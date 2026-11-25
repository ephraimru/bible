// Security-rule tests for firestore.rules, run against the Firestore emulator:
//   firebase emulators:exec --only firestore --project demo-faith-mission \
//     "npm --prefix test/firestore_rules test"
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { after, before, beforeEach, describe, test } from 'node:test';
import { assertFails, assertSucceeds, initializeTestEnvironment } from '@firebase/rules-unit-testing';
import {
  addDoc, arrayRemove, arrayUnion, collection, deleteDoc, doc, getDoc, increment,
  serverTimestamp, setDoc, updateDoc, writeBatch,
} from 'firebase/firestore';

let env;
const db = (uid) => (uid ? env.authenticatedContext(uid) : env.unauthenticatedContext()).firestore();

const profile = (role = 'believer') => ({
  displayName: 'Ruth', bio: null, chosenTitle: null, role,
  hasPaidToSkipLadder: false, canPostOnBlog: false, createdAt: serverTimestamp(),
});

const newPost = (authorId) => ({
  title: 'Grace', content: 'By grace are ye saved.', excerpt: null, category: 'devotionals',
  tags: [], authorId, authorName: 'Bishop Paul', status: 'published', likedBy: [],
  likes: 0, comments: 0, views: 0, readingTime: 1,
  createdAt: serverTimestamp(), publishedAt: serverTimestamp(), updatedAt: serverTimestamp(),
});

const message = (uid, roomId = 'general', content = 'Amen!') => ({
  roomId, senderId: uid, senderName: 'Ruth', type: 'text', content, status: 'sent',
  moderationStatus: 'approved', requiresReview: false, createdAt: serverTimestamp(),
});

// Seeds data as the admin (rules bypassed), e.g. a Bishop granted in the console.
async function seed(path, data) {
  await env.withSecurityRulesDisabled((ctx) => setDoc(doc(ctx.firestore(), path), data));
}

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-faith-mission',
    firestore: { rules: readFileSync(new URL('../../firestore.rules', import.meta.url), 'utf8') },
  });
});
after(() => env.cleanup());
beforeEach(() => env.clearFirestore());

describe('user profiles', () => {
  test('signed-out visitors can read nothing', async () => {
    await seed('users/ruth', { displayName: 'Ruth', role: 'believer' });
    await assertFails(getDoc(doc(db(null), 'users/ruth')));
  });

  test('a user creates their own profile as a Believer', async () => {
    await assertSucceeds(setDoc(doc(db('ruth'), 'users/ruth'), profile()));
  });

  test('nobody can create a profile for someone else', async () => {
    await assertFails(setDoc(doc(db('ruth'), 'users/naomi'), profile()));
  });

  test('nobody can sign up as a Bishop or with paid flags', async () => {
    await assertFails(setDoc(doc(db('ruth'), 'users/ruth'), profile('bishop')));
    await assertFails(setDoc(doc(db('ruth'), 'users/ruth'), { ...profile(), canPostOnBlog: true }));
    await assertFails(setDoc(doc(db('ruth'), 'users/ruth'), { ...profile(), email: 'r@x.com' }));
  });

  test('a user can edit their name and reading role, but not make themselves Bishop', async () => {
    await seed('users/ruth', { ...profile(), createdAt: new Date() });
    const me = doc(db('ruth'), 'users/ruth');
    await assertSucceeds(updateDoc(me, { displayName: 'Ruth M', role: 'preacher' }));
    await assertFails(updateDoc(me, { role: 'bishop' }));
    await assertFails(updateDoc(me, { hasPaidToSkipLadder: true }));
    await assertFails(updateDoc(me, { canPostOnBlog: true }));
  });

  test('a Bishop granted by the admin cannot be downgraded or changed by the client', async () => {
    await seed('users/paul', { ...profile('bishop'), createdAt: new Date() });
    await assertFails(updateDoc(doc(db('paul'), 'users/paul'), { role: 'believer' }));
  });
});

describe('following', () => {
  beforeEach(async () => {
    await seed('users/ruth', { ...profile(), createdAt: new Date() });
    await seed('users/paul', { ...profile(), createdAt: new Date() });
  });

  const follow = (me, target) => {
    const d = db(me);
    const b = writeBatch(d);
    b.set(doc(d, `users/${target}/followers/${me}`), { followerId: me, createdAt: serverTimestamp() });
    b.update(doc(d, `users/${target}`), { followersCount: increment(1) });
    b.set(doc(d, `users/${me}/following/${target}`), { targetId: target, createdAt: serverTimestamp() });
    return b.commit();
  };
  const unfollow = (me, target) => {
    const d = db(me);
    const b = writeBatch(d);
    b.delete(doc(d, `users/${target}/followers/${me}`));
    b.update(doc(d, `users/${target}`), { followersCount: increment(-1) });
    b.delete(doc(d, `users/${me}/following/${target}`));
    return b.commit();
  };
  const count = async (uid) => {
    let n;
    await env.withSecurityRulesDisabled(async (ctx) => {
      n = (await getDoc(doc(ctx.firestore(), `users/${uid}`))).data().followersCount ?? 0;
    });
    return n;
  };

  test('follow and unfollow move the count by exactly one', async () => {
    await assertSucceeds(follow('ruth', 'paul'));
    assert.equal(await count('paul'), 1);
    await assertSucceeds(unfollow('ruth', 'paul'));
    assert.equal(await count('paul'), 0);
  });

  test('cannot inflate followers', async () => {
    // Bumping the count without a follower document
    await assertFails(updateDoc(doc(db('ruth'), 'users/paul'), { followersCount: increment(1) }));
    // Adding more than one
    const d = db('ruth');
    const b = writeBatch(d);
    b.set(doc(d, 'users/paul/followers/ruth'), { followerId: 'ruth', createdAt: serverTimestamp() });
    b.update(doc(d, 'users/paul'), { followersCount: increment(5) });
    await assertFails(b.commit());
    // Following twice
    await assertSucceeds(follow('ruth', 'paul'));
    await assertFails(follow('ruth', 'paul'));
    // Following on someone else's behalf, or yourself
    await assertFails(follow('naomi', 'naomi'));
    const d2 = db('ruth');
    const b2 = writeBatch(d2);
    b2.set(doc(d2, 'users/paul/followers/naomi'), { followerId: 'naomi', createdAt: serverTimestamp() });
    b2.update(doc(d2, 'users/paul'), { followersCount: increment(1) });
    await assertFails(b2.commit());
  });

  test('owners cannot set their own follower count', async () => {
    await assertFails(updateDoc(doc(db('paul'), 'users/paul'), { followersCount: 5000 }));
  });

  test('Bishop is automatic only with 1,000+ followers', async () => {
    await assertFails(updateDoc(doc(db('paul'), 'users/paul'), { role: 'bishop' }));
    await seed('users/paul', { ...profile(), followersCount: 999, createdAt: new Date() });
    await assertFails(updateDoc(doc(db('paul'), 'users/paul'), { role: 'bishop' }));
    await seed('users/paul', { ...profile(), followersCount: 1000, createdAt: new Date() });
    await assertSucceeds(updateDoc(doc(db('paul'), 'users/paul'), { role: 'bishop' }));
  });

  test('a Bishop can still edit their own name and bio', async () => {
    await seed('users/paul', { ...profile('bishop'), createdAt: new Date() });
    await assertSucceeds(updateDoc(doc(db('paul'), 'users/paul'), { displayName: 'Paul the Apostle', bio: 'Tentmaker' }));
  });
});

describe('private progress', () => {
  test('only the owner can read or write their progress', async () => {
    await assertSucceeds(setDoc(doc(db('ruth'), 'users/ruth/private/progress'), { journey: { consecutiveDays: 3 } }));
    await assertSucceeds(getDoc(doc(db('ruth'), 'users/ruth/private/progress')));
    await assertFails(getDoc(doc(db('naomi'), 'users/ruth/private/progress')));
    await assertFails(setDoc(doc(db('naomi'), 'users/ruth/private/progress'), { journey: {} }));
  });
});

describe('blog', () => {
  beforeEach(async () => {
    await seed('users/ruth', { ...profile('believer'), createdAt: new Date() });
    await seed('users/paul', { ...profile('bishop'), createdAt: new Date() });
  });

  test('a Bishop can publish; a Believer cannot', async () => {
    await assertSucceeds(addDoc(collection(db('paul'), 'posts'), newPost('paul')));
    await assertFails(addDoc(collection(db('ruth'), 'posts'), newPost('ruth')));
  });

  test('nobody can publish under someone else\'s name or with fake likes', async () => {
    await assertFails(addDoc(collection(db('paul'), 'posts'), newPost('ruth')));
    await assertFails(addDoc(collection(db('paul'), 'posts'), { ...newPost('paul'), likes: 500 }));
  });

  test('likes: only your own, once, with a matching count', async () => {
    await seed('posts/p1', { ...newPost('paul'), createdAt: new Date(), publishedAt: new Date(), updatedAt: new Date() });
    const post = doc(db('ruth'), 'posts/p1');
    await assertSucceeds(updateDoc(post, { likedBy: arrayUnion('ruth'), likes: increment(1) }));
    await assertFails(updateDoc(post, { likedBy: arrayUnion('naomi'), likes: increment(1) }));
    await assertFails(updateDoc(post, { likes: increment(10) }));
    await assertSucceeds(updateDoc(post, { likedBy: arrayRemove('ruth'), likes: increment(-1) }));
  });

  test('only the author can edit or delete a post', async () => {
    await seed('posts/p1', { ...newPost('paul'), createdAt: new Date(), publishedAt: new Date(), updatedAt: new Date() });
    await assertFails(updateDoc(doc(db('ruth'), 'posts/p1'), { title: 'Hacked' }));
    await assertFails(deleteDoc(doc(db('ruth'), 'posts/p1')));
    await assertSucceeds(updateDoc(doc(db('paul'), 'posts/p1'), { title: 'Grace and peace' }));
    await assertSucceeds(deleteDoc(doc(db('paul'), 'posts/p1')));
  });

  test('anyone signed in can comment (with the count), only as themselves', async () => {
    await seed('posts/p1', { ...newPost('paul'), createdAt: new Date(), publishedAt: new Date(), updatedAt: new Date() });
    const ruth = db('ruth');
    const batch = writeBatch(ruth);
    batch.set(doc(ruth, 'posts/p1/comments/c1'), {
      postId: 'p1', authorId: 'ruth', authorName: 'Ruth', content: 'Amen', likes: [], createdAt: serverTimestamp(),
    });
    batch.update(doc(ruth, 'posts/p1'), { comments: increment(1) });
    await assertSucceeds(batch.commit());
    await assertFails(setDoc(doc(ruth, 'posts/p1/comments/c2'), {
      postId: 'p1', authorId: 'paul', authorName: 'Paul', content: 'Fake', likes: [], createdAt: serverTimestamp(),
    }));
    await assertFails(deleteDoc(doc(db('naomi'), 'posts/p1/comments/c1')));
    await assertSucceeds(deleteDoc(doc(db('paul'), 'posts/p1/comments/c1'))); // post author moderates
  });
});

describe('chat', () => {
  test('signed-in users can read and send in the fixed rooms', async () => {
    const ruth = db('ruth');
    await assertSucceeds(addDoc(collection(ruth, 'rooms/general/messages'), message('ruth')));
    await assertSucceeds(getDoc(doc(ruth, 'rooms/general/messages/x')));
    await assertFails(getDoc(doc(db(null), 'rooms/general/messages/x')));
  });

  test('no impersonation, no unknown rooms, no oversized messages', async () => {
    const ruth = db('ruth');
    await assertFails(addDoc(collection(ruth, 'rooms/general/messages'), message('naomi')));
    await assertFails(addDoc(collection(ruth, 'rooms/secret/messages'), message('ruth', 'secret')));
    await assertFails(addDoc(collection(ruth, 'rooms/general/messages'), message('ruth', 'general', 'x'.repeat(1001))));
    await assertFails(addDoc(collection(ruth, 'rooms/general/messages'), message('ruth', 'general', '')));
  });

  test('only the sender can delete a message', async () => {
    await seed('rooms/general/messages/m1', { ...message('ruth'), createdAt: new Date() });
    await assertFails(deleteDoc(doc(db('naomi'), 'rooms/general/messages/m1')));
    await assertSucceeds(deleteDoc(doc(db('ruth'), 'rooms/general/messages/m1')));
  });
});

describe('reports', () => {
  test('users can file reports but nobody can read them', async () => {
    const ruth = db('ruth');
    await assertSucceeds(addDoc(collection(ruth, 'reports'), {
      reporterId: 'ruth', contentPath: 'rooms/general/messages/m1', authorId: 'naomi',
      reason: 'Offensive', excerpt: 'x', status: 'open', createdAt: serverTimestamp(),
    }));
    await assertFails(getDoc(doc(ruth, 'reports/anything')));
    await assertFails(addDoc(collection(ruth, 'reports'), {
      reporterId: 'naomi', contentPath: 'x', reason: 'r', createdAt: serverTimestamp(),
    }));
  });
});
