From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 13 Jun 2019 21:13:33 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Mark CVE-2019-11487 to be ignored for 3.16 and 4.4
Message-ID: <5d02bc7dad7cb_47de3f811c17242415009e8@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
45959f97 by Ben Hutchings at 2019-06-13T21:07:43Z
Mark CVE-2019-11487 to be ignored for 3.16 and 4.4

- - - - -
f06464f8 by Ben Hutchings at 2019-06-13T21:12:52Z
Mark eBPF filter denial-of-service to be ignored for 4.4

- - - - -


2 changed files:

- issues/CVE-2018-ebpf-filter-dos.yml
- issues/CVE-2019-11487.yml


Changes:

=====================================
issues/CVE-2018-ebpf-filter-dos.yml
=====================================
@@ -1,6 +1,10 @@
 description: Ability to fill entire module space with eBPF JIT socket filters
 comments:
   Debian-bwh: This should be minor for Debian because we don't enable JIT by default.
+  bwh: |
+    It was not safe to enable BPF JIT for unprivileged users before
+    commit 4f3446bb809f "bpf: add generic constant blinding for use in
+    jits" in Linux 4.7, so this can be ignored for older versions.
 introduced-by:
   linux-4.14.y: [6fde36d5ce7ba4303865d5e11601cd3094e5909b]
   linux-4.4.y: [28c486744e6de4d882a1d853aa63d99fcba4b7a6]
@@ -10,3 +14,6 @@ introduced-by:
 fixed-by:
   linux-4.19.y: [43caa29c99db5a41b204e8ced01b00e151335ca8]
   mainline: [ede95a63b5e84ddeea6b0c473b36ab8bfd8c6ce3]
+ignore:
+  linux-4.4.y: Unprivileged BPF JIT should not be enabled
+  linux-4.4.y-cip: Unprivileged BPF JIT should not be enabled


=====================================
issues/CVE-2019-11487.yml
=====================================
@@ -36,3 +36,7 @@ fixed-by:
     ad73e3a199066ad9bf48ea1334ef312e5aa078f4, 258fc3baeb4b2da15391735fd806facf4a91b585]
   mainline: [15fab63e1e57be9fdb5eec1bbc5916e9825e9acb, 88b1a17dfc3ed7728316478fae0f5ad508f50397,
     8fde12ca79aff9b5ba951fce1a2641901b8d8e64, f958d7b528b1b40c44cfda5eabe2d82760d868c3]
+ignore:
+  linux-3.16.y: Minor issue, difficult to backport fix
+  linux-4.4.y: Minor issue, difficult to backport fix
+  linux-4.4.y-cip: Minor issue, difficult to backport fix



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/17e0403ef06488fac8ef8d014b8cc5222023e9e3...f06464f8d0ec31efa845e54c93c9e98bdda0e85e

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/17e0403ef06488fac8ef8d014b8cc5222023e9e3...f06464f8d0ec31efa845e54c93c9e98bdda0e85e
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190613/acca3a79/attachment.html>
