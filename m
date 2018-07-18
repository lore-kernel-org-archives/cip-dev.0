From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Wed, 18 Jul 2018 07:25:46 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Use a local test for the BBB health check
Message-ID: <5b4eeb7a98f0d_ac5f3fcfb201b3c0106010@sidekiq-asap-02.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
f9d2bb54 by Robert Marshall at 2018-07-18T07:25:45Z
Use a local test for the BBB health check

- - - - -
01551476 by Robert Marshall at 2018-07-18T07:25:45Z
Merge branch &#39;localTest&#39; into &#39;master&#39;

Use a local test for the BBB health check

See merge request cip-project/cip-testing/board-at-desk-single-dev!62
- - - - -


1 changed file:

- tests/bbb_debian_local.yaml


Changes:

=====================================
tests/bbb_debian_local.yaml
=====================================
@@ -1,4 +1,4 @@
-# Copyright (C) 2017, Codethink, Ltd., Robert Marshall <robert.marshall@codethink.co.uk>
+# Copyright (C) 2018, Codethink, Ltd., Robert Marshall <robert.marshall@codethink.co.uk>
 # SPDX-License-Identifier:	AGPL-3.0
 # This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
 
@@ -10,7 +10,7 @@ device_type: beaglebone-black
 
 # NFS fails on panda and arndale.
 
-job_name: local test of ramdisk test on bbb using /TREE/BRANCH/TAG/arm/omap2plus_defconfig/zImage
+job_name: test of bbb using /TREE/BRANCH/TAG/arm/omap2plus_defconfig/zImage
 timeouts:
   job:
     minutes: 10
@@ -62,11 +62,22 @@ actions:
 
 # TEST_BLOCK
 - test:
-    # defines the tests to be run once the health check passes
     timeout:
-      minutes: 5
+      minutes: 2
     definitions:
-    - repository: git://git.linaro.org/qa/test-definitions.git
-      from: git
-      path: common/dt-selftests.yaml
-      name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: kernel-version-basic
+          version: "1.0"
+          description: "check kernel version"
+          os:
+            - oe
+          scope:
+            - functional
+        run:
+          steps:
+            - lava-test-case uname --shell uname -a
+      from: inline
+      name: kernel-version-inline
+      path: inline/kernel-version-basic.yaml



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/42e332d726083b8ccca95d783f9c0fd1c7af9bcf...01551476f285f2cb5caa5f0e99bf483f24735123

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/42e332d726083b8ccca95d783f9c0fd1c7af9bcf...01551476f285f2cb5caa5f0e99bf483f24735123
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180718/1841d680/attachment-0001.html>
