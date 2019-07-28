From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Sun, 28 Jul 2019 23:16:07 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Fill in commit lists for some issues
Message-ID: <5d3e2cb74d76e_6a933fbb8100a9fc865d4@sidekiq-asap-07-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
3a19e752 by Ben Hutchings at 2019-07-28T23:13:41Z
Fill in commit lists for some issues

- - - - -
37622ea9 by Ben Hutchings at 2019-07-28T23:14:39Z
Mark some issues to be ignored for CIP branches

Ignore issues on CIP branches where the affected kernel code is not
enabled by any members&#39; submitted configuration files.

- - - - -


9 changed files:

- issues/CVE-2017-18379.yml
- issues/CVE-2018-12928.yml
- issues/CVE-2018-20854.yml
- issues/CVE-2018-20855.yml
- issues/CVE-2018-20856.yml
- issues/CVE-2019-13631.yml
- issues/CVE-2019-13648.yml
- issues/CVE-2019-14283.yml
- issues/CVE-2019-14284.yml


Changes:

=====================================
issues/CVE-2017-18379.yml
=====================================
@@ -1,3 +1,5 @@
 description: 'nvmet-fc: ensure target queue id within range'
+introduced-by:
+  mainline: [c53432030d86429dc9fe5adc3d68cb9d1343b0b2]
 fixed-by:
   mainline: [0c319d3a144d4b8f1ea2047fd614d2149b68f889]


=====================================
issues/CVE-2018-12928.yml
=====================================
@@ -17,3 +17,8 @@ comments:
   Ubuntu-tyhicks: As of 2018-11-19, there is no upstream fix available
 reporters:
 - Sergej Schumilo
+ignore:
+  linux-4.19.y-cip: No member enables the hfs filesystem
+  linux-4.19.y-cip-rt: No member enables the hfs filesystem
+  linux-4.4.y-cip: No member enables the hfs filesystem
+  linux-4.4.y-cip-rt: No member enables the hfs filesystem


=====================================
issues/CVE-2018-20854.yml
=====================================
@@ -6,3 +6,7 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-20854
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6acb47d1a318e5b3b7115354ebc4ea060c59d3a1
 - https://github.com/torvalds/linux/commit/6acb47d1a318e5b3b7115354ebc4ea060c59d3a1
+introduced-by:
+  mainline: [51f6b410fc220d8a5a4fae00ebfd8243b6c11d4e]
+fixed-by:
+  mainline: [6acb47d1a318e5b3b7115354ebc4ea060c59d3a1]


=====================================
issues/CVE-2018-20855.yml
=====================================
@@ -6,3 +6,8 @@ references:
 - https://github.com/torvalds/linux/commit/0625b4ba1a5d4703c7fb01c497bd6c156908af00
 fixed-by:
   mainline: [0625b4ba1a5d4703c7fb01c497bd6c156908af00]
+ignore:
+  linux-4.19.y-cip: No member enables the mlx5_ib driver
+  linux-4.19.y-cip-rt: No member enables the mlx5_ib driver
+  linux-4.4.y-cip: No member enables the mlx5_ib driver
+  linux-4.4.y-cip-rt: No member enables the mlx5_ib driver


=====================================
issues/CVE-2018-20856.yml
=====================================
@@ -4,6 +4,8 @@ references:
 - https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.18.7
 - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=54648cf1ec2d7f4b6a71767799c45676a138ca24
 - https://github.com/torvalds/linux/commit/54648cf1ec2d7f4b6a71767799c45676a138ca24
+introduced-by:
+  mainline: [7c94e1c157a227837b04f02f5edeff8301410ba2]
 fixed-by:
   linux-4.14.y: [0affbaece6d0b7c75c5166732d0481ae9a28be60]
   mainline: [54648cf1ec2d7f4b6a71767799c45676a138ca24]


=====================================
issues/CVE-2019-13631.yml
=====================================
@@ -8,3 +8,8 @@ fixed-by:
   linux-4.19.y: [d657077eda7b5572d86f2f618391bb016b5d9a64]
   linux-5.2.y: [63fabf4287b23da069986b7a7fdc6ad0b202f00a]
   mainline: [2a017fd82c5402b3c8df5e3d6e5165d9e6147dc1]
+ignore:
+  linux-4.19.y-cip: No members enable the gtco driver
+  linux-4.19.y-cip-rt: No members enable the gtco driver
+  linux-4.4.y-cip: No members enable the gtco driver
+  linux-4.4.y-cip-rt: No members enable the gtco driver


=====================================
issues/CVE-2019-13648.yml
=====================================
@@ -12,3 +12,6 @@ introduced-by:
   mainline: [2b0a576d15e0e14751f00f9c87e46bad27f217e7]
 fixed-by:
   mainline: [f16d80b75a096c52354c6e0a574993f3b0dfbdfe]
+ignore:
+  linux-4.19.y-cip: No members are using powerpc
+  linux-4.19.y-cip-rt: No members are using powerpc


=====================================
issues/CVE-2019-14283.yml
=====================================
@@ -3,3 +3,6 @@ fixed-by:
   linux-4.19.y: [ff54c44f103825a426e46d08b5d3d76e44791a87]
   linux-5.2.y: [d39c2e97277229970fe2ae56dcbf67a535e14873]
   mainline: [da99466ac243f15fbba65bd261bfc75ffa1532b6]
+ignore:
+  linux-4.19.y-cip: No members enable the floppy driver
+  linux-4.19.y-cip-rt: No members enable the floppy driver


=====================================
issues/CVE-2019-14284.yml
=====================================
@@ -3,3 +3,6 @@ fixed-by:
   linux-4.19.y: [6e34fd07484a0622a17b40e0ca89ed451260ef45]
   linux-5.2.y: [697c0af7468a941522c1e26345aa5128fa2a4815]
   mainline: [f3554aeb991214cbfafd17d55e2bfddb50282e32]
+ignore:
+  linux-4.19.y-cip: No members enable the floppy driver
+  linux-4.19.y-cip-rt: No members enable the floppy driver



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/ceaff914a546358bc6325c65e6ae33913c26a7e2...37622ea9139eef2f7703d8a55f166590c2e5f63a

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/ceaff914a546358bc6325c65e6ae33913c26a7e2...37622ea9139eef2f7703d8a55f166590c2e5f63a
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190728/1f596fc5/attachment-0001.html>
