From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 19 Aug 2019 18:05:16 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-kernel/cip-kernel-sec][bwh/update-issues] Note
 additional commit needed to fix CVE-2019-11487 on linux-4.9.y
Message-ID: <5d5ae4dcdc288_67883f84bd572d4016940239@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch bwh/update-issues at cip-project / cip-kernel / cip-kernel-sec


Commits:
efbae131 by Ben Hutchings at 2019-08-19T18:05:05Z
Note additional commit needed to fix CVE-2019-11487 on linux-4.9.y

- - - - -


1 changed file:

- issues/CVE-2019-11487.yml


Changes:

=====================================
issues/CVE-2019-11487.yml
=====================================
@@ -23,6 +23,9 @@ comments:
     604d7b594c6d ("mm: add 'try_get_page()' helper function") was
     already added in 4.9.175, possibly for preparation.
   Ubuntu-tyhicks: Requires >= 140 GiB of RAM which is rare
+  bwh: |
+    For kernel versions before 4.13, arch/x86/mm/gup.c also needs to be
+    updated.  This is done by the last commit listed for linux-4.9.y.
 reporters:
 - Jann Horn
 introduced-by:
@@ -37,7 +40,8 @@ fixed-by:
   linux-4.19.y-cip-rt: [0311ff82b70fa12e80d188635bff24029ec06ae1, 0612cae7ec6b79d2ff1b34562bab79d5bf96327a,
     d972ebbf42ba6712460308ae57c222a0706f2af3, 9f6da5fd05577ef4a05c1744cc7098d0173823af]
   linux-4.9.y: [9557090582a33801349f0a0920a55d134a27e740, 604d7b594c6d18582650dd06b201643b15202232,
-    2ed768cfd8956df77f60dd073251699ad3e56cd4, 96019c69145840a498e4e988f56a7524dc0c59b7]
+    2ed768cfd8956df77f60dd073251699ad3e56cd4, 96019c69145840a498e4e988f56a7524dc0c59b7,
+    d73af79742e708a171c1a224759fb0661ed6fcac]
   linux-5.0.y: [27f651142eec95373c7ed6e10a3929fab1733c1a, bdc8dfd6587378458e248e36ab79a129f24ba8e9,
     ad73e3a199066ad9bf48ea1334ef312e5aa078f4, 258fc3baeb4b2da15391735fd806facf4a91b585]
   mainline: [15fab63e1e57be9fdb5eec1bbc5916e9825e9acb, 88b1a17dfc3ed7728316478fae0f5ad508f50397,



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/efbae131393ebc9f8819885263323835f880b7b7

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/efbae131393ebc9f8819885263323835f880b7b7
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190819/c7fed627/attachment-0001.html>
