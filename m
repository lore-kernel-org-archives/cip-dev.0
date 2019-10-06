From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Sun, 06 Oct 2019 18:57:11 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Add fix for CVE-2019-14821 in 4.4
Message-ID: <5d9a39074e9f7_16703f84ed980d6c1296c0@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
6ffdead6 by SZ Lin (???) at 2019-10-02T10:20:39Z
Add fix for CVE-2019-14821 in 4.4

Signed-off-by: SZ Lin (???) &lt;sz.lin at moxa.com&gt;

- - - - -
4dd56965 by Ben Hutchings at 2019-10-06T18:57:09Z
Merge branch &#39;master&#39; into &#39;master&#39;

Add fix for CVE-2019-14821 in 4.4

See merge request cip-project/cip-kernel/cip-kernel-sec!14
- - - - -


1 changed file:

- issues/CVE-2019-14821.yml


Changes:

=====================================
issues/CVE-2019-14821.yml
=====================================
@@ -19,5 +19,6 @@ introduced-by:
 fixed-by:
   linux-3.16.y: [0bd118896b6a82a42845a6148d2f0f4a3694d178]
   linux-4.19.y: [232a6462f43fceeac82bd99ef092b38e3a7ee296]
+  linux-4.4.y: [ae41539657ce0a4e9f4588e89e5e19a8b8f11928]
   linux-4.9.y: [52cb3fd60ec0a1c9b61cd28bae4e8c1d377e7b60]
   mainline: [b60fe990c6b07ef6d4df67bc0530c7c90a62623a]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/91550c5b7ca15e06bbf72b79f8f7dec4a572b10f...4dd569652193063a0fb0c30701f9962b8dc721f0

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/91550c5b7ca15e06bbf72b79f8f7dec4a572b10f...4dd569652193063a0fb0c30701f9962b8dc721f0
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191006/a7cbb442/attachment.html>
