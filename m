From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Thu, 22 Mar 2018 13:41:35 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Add the markers for the kernel version to the description
Message-ID: <5ab3b28f32a49_4673fdb0654bed0581914@sidekiq-asap-05.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
950ad4a3 by Robert Marshall at 2018-03-22T12:40:28Z
Add the markers for the kernel version to the description

The description ends up in the result email, so this adds useful information
to emails reporting on tests to e.g. cip-testing-results

- - - - -
1002fb7a by Robert Marshall at 2018-03-22T13:41:30Z
Merge branch &#39;augmentDescription&#39; into &#39;master&#39;

Add the markers for the kernel version to the description #118

See merge request cip-project/cip-testing/board-at-desk-single-dev!56
- - - - -


1 changed file:

- tests/bbb_debian_local.yaml


Changes:

=====================================
tests/bbb_debian_local.yaml
=====================================
--- a/tests/bbb_debian_local.yaml
+++ b/tests/bbb_debian_local.yaml
@@ -10,7 +10,7 @@ device_type: beaglebone-black
 
 # NFS fails on panda and arndale.
 
-job_name: local test of ramdisk test on bbb
+job_name: local test of ramdisk test on bbb using /TREE/BRANCH/TAG/arm/omap2plus_defconfig/zImage
 timeouts:
   job:
     minutes: 10



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/482e656e4c4488c2ea936df5ec11080c76956656...1002fb7a6e3b63983f3e315030809fa54fc6c019

---
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/482e656e4c4488c2ea936df5ec11080c76956656...1002fb7a6e3b63983f3e315030809fa54fc6c019
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180322/345f15dd/attachment-0001.html>
