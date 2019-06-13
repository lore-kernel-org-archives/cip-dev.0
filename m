From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 13 Jun 2019 21:20:01 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] Add
 fix for CVE-2019-5489 in 4.4
Message-ID: <5d02be01b8242_4323f95d2d165bc17198a4@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
ffa1ed40 by Ben Hutchings at 2019-06-13T21:18:59Z
Add fix for CVE-2019-5489 in 4.4

- - - - -


1 changed file:

- issues/CVE-2019-5489.yml


Changes:

=====================================
issues/CVE-2019-5489.yml
=====================================
@@ -53,5 +53,6 @@ introduced-by:
 fixed-by:
   linux-4.14.y: [212c5685825c1ed45ac3a191dd7ada6e5889bfa2]
   linux-4.19.y: [f580a54bbd522f2518fd642f7d4d73ad728e5d58]
+  linux-4.4.y: [b614485b6b93dbb2f6202341c60594fcdc110d5c]
   linux-4.9.y: [fef85fb00224cb22f9efec262e9ffe8970e555ee]
   mainline: [574823bfab82d9d8fa47f422778043fbb4b4f50e]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/ffa1ed4041689c3324120a118ee2c46814750c22

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/ffa1ed4041689c3324120a118ee2c46814750c22
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190613/b8ae1ded/attachment-0001.html>
