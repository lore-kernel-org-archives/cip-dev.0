Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB92DCD54AC
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 10:08:00 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web10.4856.1695118076242067318
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 03:07:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: srinuvasan_a@mentor.com)
X-CSE-ConnectionGUID: FgE4ujU7QtSjAQGfCLsVSg==
X-CSE-MsgGUID: XxcetHUITHmdzEiKkN3vBA==
X-IronPort-AV: E=Sophos;i="6.02,159,1688457600"; 
   d="scan'208";a="19517010"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 19 Sep 2023 02:07:54 -0800
IronPort-SDR: gX1Vzgku3uW3AcNhvpAZDsrmqa1C9D1BjKJmpQJgi/0NWN6L3PsYHJ51EtqQhqxPP+tNtYpIAq
 KMf+aeW/63wZRurVl5wrCslKrMsndo1Tde+mDaS2klb5hf7447cAXn/sI6YTl37c8uNJavaIXs
 cSUB7p2q88A3j2ECf72Tp4UBgDlDw7Oe+9h8PDS8NxtdED3VHDeqjARbuYoOWF6WkGMU470xgN
 rTmRuL2PC1RbcXDWZMMqS9/GnuQCy3CWyJgX/FjjkjLPFDmD1YDvLzWcFKRiT5SpKLNYgpN1RF
 kZM=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] Update kas config file version
Date: Tue, 19 Sep 2023 15:37:32 +0530
Message-ID: <20230919100732.67656-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 10:08:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13141

From: Srinuvasan A <srinuvasan.a@siemens.com>

We need 14 since we switched to 'commit'.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 doc/README.secureboot.md             | 2 +-
 kas/board/bbb.yml                    | 2 +-
 kas/board/hihope-rzg2m.yml           | 2 +-
 kas/board/iwg20m.yml                 | 2 +-
 kas/board/qemu-amd64.yml             | 2 +-
 kas/board/qemu-arm.yml               | 2 +-
 kas/board/qemu-arm64.yml             | 2 +-
 kas/board/qemu-riscv64.yml           | 2 +-
 kas/board/simatic-ipc227e.yml        | 2 +-
 kas/opt/4.19.yml                     | 2 +-
 kas/opt/4.4.yml                      | 2 +-
 kas/opt/5.10.yml                     | 2 +-
 kas/opt/6.1.yml                      | 2 +-
 kas/opt/bookworm.yml                 | 2 +-
 kas/opt/bullseye.yml                 | 2 +-
 kas/opt/buster.yml                   | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 kas/opt/ebg-swu.yml                  | 2 +-
 kas/opt/encrypt-partitions.yml       | 2 +-
 kas/opt/kernel-panic.yml             | 2 +-
 kas/opt/kernelci.yml                 | 2 +-
 kas/opt/reproducible.yml             | 2 +-
 kas/opt/rt.yml                       | 2 +-
 kas/opt/security.yml                 | 2 +-
 kas/opt/sid-ports.yml                | 2 +-
 kas/opt/swupdate.yml                 | 2 +-
 kas/opt/targz-img.yml                | 2 +-
 kas/opt/test.yml                     | 2 +-
 kas/opt/wic-targz-img.yml            | 2 +-
 29 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 6546095..2b73d10 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -151,7 +151,7 @@ For user-generated keys, create a new option file in the repository. This option
 
 ```yaml
 header:
-  version: 12
+  version: 14
   includes:
    - kas/opt/ebg-swu.yml
 
diff --git a/kas/board/bbb.yml b/kas/board/bbb.yml
index c99d9bd..f2e701c 100644
--- a/kas/board/bbb.yml
+++ b/kas/board/bbb.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: bbb
diff --git a/kas/board/hihope-rzg2m.yml b/kas/board/hihope-rzg2m.yml
index 7b80de7..8d0136b 100644
--- a/kas/board/hihope-rzg2m.yml
+++ b/kas/board/hihope-rzg2m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: hihope-rzg2m
diff --git a/kas/board/iwg20m.yml b/kas/board/iwg20m.yml
index c873b98..9c9ef4b 100644
--- a/kas/board/iwg20m.yml
+++ b/kas/board/iwg20m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: iwg20m
diff --git a/kas/board/qemu-amd64.yml b/kas/board/qemu-amd64.yml
index f9f57be..c27ed8e 100644
--- a/kas/board/qemu-amd64.yml
+++ b/kas/board/qemu-amd64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: qemu-amd64
diff --git a/kas/board/qemu-arm.yml b/kas/board/qemu-arm.yml
index fe03028..969fd5a 100644
--- a/kas/board/qemu-arm.yml
+++ b/kas/board/qemu-arm.yml
@@ -11,6 +11,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: qemu-arm
diff --git a/kas/board/qemu-arm64.yml b/kas/board/qemu-arm64.yml
index 55690b3..1a1eb0d 100644
--- a/kas/board/qemu-arm64.yml
+++ b/kas/board/qemu-arm64.yml
@@ -11,6 +11,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: qemu-arm64
diff --git a/kas/board/qemu-riscv64.yml b/kas/board/qemu-riscv64.yml
index 0de158a..e8272b0 100644
--- a/kas/board/qemu-riscv64.yml
+++ b/kas/board/qemu-riscv64.yml
@@ -7,6 +7,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: qemu-riscv64
diff --git a/kas/board/simatic-ipc227e.yml b/kas/board/simatic-ipc227e.yml
index 82b0ff7..cf27058 100644
--- a/kas/board/simatic-ipc227e.yml
+++ b/kas/board/simatic-ipc227e.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 machine: simatic-ipc227e
diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
index 5e79223..bad4293 100644
--- a/kas/opt/4.19.yml
+++ b/kas/opt/4.19.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
index 970351a..c0c5c05 100644
--- a/kas/opt/4.4.yml
+++ b/kas/opt/4.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
index 2258575..f3a6d86 100644
--- a/kas/opt/5.10.yml
+++ b/kas/opt/5.10.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/6.1.yml b/kas/opt/6.1.yml
index ac12adf..7ac2735 100644
--- a/kas/opt/6.1.yml
+++ b/kas/opt/6.1.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
index 8b4431b..dc0e0a2 100644
--- a/kas/opt/bookworm.yml
+++ b/kas/opt/bookworm.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 distro: cip-core-bookworm
diff --git a/kas/opt/bullseye.yml b/kas/opt/bullseye.yml
index b08e0e4..0614c92 100644
--- a/kas/opt/bullseye.yml
+++ b/kas/opt/bullseye.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 distro: cip-core-bullseye
diff --git a/kas/opt/buster.yml b/kas/opt/buster.yml
index 9b0b530..3f19310 100644
--- a/kas/opt/buster.yml
+++ b/kas/opt/buster.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 distro: cip-core-buster
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index f787c82..e083304 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
   includes:
     - kas/opt/ebg-swu.yml
 
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index c90142b..61a8eee 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
   includes:
    - kas/opt/swupdate.yml
 
diff --git a/kas/opt/encrypt-partitions.yml b/kas/opt/encrypt-partitions.yml
index 2fe38f8..3de76ab 100644
--- a/kas/opt/encrypt-partitions.yml
+++ b/kas/opt/encrypt-partitions.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   initramfs-option-encrypt-partitions: |
diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
index fe17982..f966779 100644
--- a/kas/opt/kernel-panic.yml
+++ b/kas/opt/kernel-panic.yml
@@ -11,7 +11,7 @@
 # This kas file adds systemd service file to cause kernel panic during system boot.
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   kernel-panic: |
diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
index b5fadcb..ec90792 100644
--- a/kas/opt/kernelci.yml
+++ b/kas/opt/kernelci.yml
@@ -11,6 +11,6 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 12
+  version: 14
 
 target: cip-core-image-kernelci
diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index 9b56b28..5d6a896 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   reproducible-builds: |
diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
index 4b2519f..ab43a84 100644
--- a/kas/opt/rt.yml
+++ b/kas/opt/rt.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   preempt-rt: |
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 67bf4ff..d87235a 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 12
+  version: 14
   includes:
    - kas/opt/encrypt-partitions.yml
    - kas/opt/ebg-secure-boot-snakeoil.yml
diff --git a/kas/opt/sid-ports.yml b/kas/opt/sid-ports.yml
index 2e89f2b..b11a1c2 100644
--- a/kas/opt/sid-ports.yml
+++ b/kas/opt/sid-ports.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 distro: cip-core-sid-ports
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 0e30e89..ef61e4e 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -12,7 +12,7 @@
 # from the first wic partition
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   image-option-swupdate: |
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
index 8283ef8..fd8303e 100644
--- a/kas/opt/targz-img.yml
+++ b/kas/opt/targz-img.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   image-type: |
diff --git a/kas/opt/test.yml b/kas/opt/test.yml
index 7dd5536..4a60ad4 100644
--- a/kas/opt/test.yml
+++ b/kas/opt/test.yml
@@ -9,7 +9,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 local_conf_header:
   testing: |
diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
index 3d908de..74053f5 100644
--- a/kas/opt/wic-targz-img.yml
+++ b/kas/opt/wic-targz-img.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 # lava uses nfs to deploy the image. For this we need a tarball instead of
 # full image
-- 
2.34.1


