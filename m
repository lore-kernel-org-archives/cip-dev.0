Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F8CC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 09:28:59 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9308.1791970128162978706
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 02:28:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=M/FdcpCR;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1324425-20261014092844d8e1e2357d000207bb-amwh81@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20261014092844d8e1e2357d000207bb
        for <cip-dev@lists.cip-project.org>;
        Wed, 14 Oct 2026 11:28:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=0N/lMBQUbefYGj2czMfoPoUbdM5iwy5SIQk4dJSxOho=;
 b=M/FdcpCRb7EJGiE9qdjY7CovNILtqZrJuhhF6MFClMMR6fh3MT0Dh+C2z6+yzRNEQff7ZA
 gVg9G+7g/ZdOWsEqcRWA8yr5jmwESzwx6KYp22GfvPNLASo+UnKZOZoXDrSzDKpidXXa6KVJ
 vsRRp2FJZPvXkaqgaxHykDqHVxRcA3Jp8Tq+sAHPhIiQ4yg90ktR4LRw/EuZJiHrmecToPjb
 W/DHEQiUpyWsyBAF/02cWMlo8Tf0EsJpOPUVA0VlizSiKuU44QMk7ipYb5d98TfHTkmIfjsV
 91CgO2ll2PTTSz5PkViM2vUrSNmDMiIzvjBIrItcIjS76/rWuf73M7vQ==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] Bump kas header version to 23
Date: Wed, 14 Oct 2026 14:59:43 +0530
Message-Id: <20261014092943.1108318-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 09:28:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24458

From: Srinuvasan A <srinuvasan.a@siemens.com>

This revision adds support for the isar-privileged and
isar-rootless build systems, enables repository URL
overrides, and allows the commit to be set to null to
use the HEAD of the selected branch.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 doc/README.secureboot.md             | 2 +-
 kas-cip.yml                          | 2 +-
 kas/board/bbb.yml                    | 2 +-
 kas/board/beaglev-fire.yml           | 2 +-
 kas/board/de0-nano-soc.yml           | 2 +-
 kas/board/hihope-rzg2m.yml           | 2 +-
 kas/board/iwg20m.yml                 | 2 +-
 kas/board/qemu-amd64.yml             | 2 +-
 kas/board/qemu-arm.yml               | 2 +-
 kas/board/qemu-arm64.yml             | 2 +-
 kas/board/qemu-riscv64.yml           | 2 +-
 kas/board/rzt2h-evk.yml              | 2 +-
 kas/board/ti-am62px-sk.yml           | 2 +-
 kas/board/x86-uefi.yml               | 2 +-
 kas/opt/4.19.yml                     | 2 +-
 kas/opt/4.4.yml                      | 2 +-
 kas/opt/5.10.yml                     | 2 +-
 kas/opt/6.1.yml                      | 2 +-
 kas/opt/6.12.yml                     | 2 +-
 kas/opt/bookworm.yml                 | 2 +-
 kas/opt/bullseye.yml                 | 2 +-
 kas/opt/buster.yml                   | 2 +-
 kas/opt/delta-update.yml             | 2 +-
 kas/opt/disable-watchdog.yml         | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 kas/opt/ebg-swu.yml                  | 2 +-
 kas/opt/encrypt-all.yml              | 2 +-
 kas/opt/encrypt-data.yml             | 2 +-
 kas/opt/erofs.yml                    | 2 +-
 kas/opt/expand-on-first-boot.yml     | 2 +-
 kas/opt/factory-reset.yml            | 2 +-
 kas/opt/forky.yml                    | 2 +-
 kas/opt/ftpm-stmm.yml                | 2 +-
 kas/opt/kernel-head.yml              | 2 +-
 kas/opt/kernel-panic.yml             | 2 +-
 kas/opt/no_kernel.yml                | 2 +-
 kas/opt/reproducible.yml             | 2 +-
 kas/opt/rt.yml                       | 2 +-
 kas/opt/security.yml                 | 2 +-
 kas/opt/security_test.yml            | 2 +-
 kas/opt/separate-home-partition.yml  | 2 +-
 kas/opt/sid.yml                      | 2 +-
 kas/opt/swupdate-2022.12.yaml        | 2 +-
 kas/opt/swupdate.yml                 | 2 +-
 kas/opt/targz.yml                    | 2 +-
 kas/opt/test.yml                     | 2 +-
 kas/opt/trixie.yml                   | 2 +-
 47 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 2a387f0..2b14bfb 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -151,7 +151,7 @@ For user-generated keys, create a new option file in the repository. This option
 
 ```yaml
 header:
-  version: 14
+  version: 23
   includes:
    - kas/opt/ebg-swu.yml
 
diff --git a/kas-cip.yml b/kas-cip.yml
index d618a6e..13251a7 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 distro: cip-core-trixie
 target: cip-core-image
diff --git a/kas/board/bbb.yml b/kas/board/bbb.yml
index f2e701c..f36bc22 100644
--- a/kas/board/bbb.yml
+++ b/kas/board/bbb.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: bbb
diff --git a/kas/board/beaglev-fire.yml b/kas/board/beaglev-fire.yml
index 07345f1..c82ed50 100644
--- a/kas/board/beaglev-fire.yml
+++ b/kas/board/beaglev-fire.yml
@@ -7,6 +7,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: beaglev-fire
diff --git a/kas/board/de0-nano-soc.yml b/kas/board/de0-nano-soc.yml
index 2d1d242..b1d26c0 100644
--- a/kas/board/de0-nano-soc.yml
+++ b/kas/board/de0-nano-soc.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: de0-nano-soc
diff --git a/kas/board/hihope-rzg2m.yml b/kas/board/hihope-rzg2m.yml
index 8d0136b..9b5086a 100644
--- a/kas/board/hihope-rzg2m.yml
+++ b/kas/board/hihope-rzg2m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: hihope-rzg2m
diff --git a/kas/board/iwg20m.yml b/kas/board/iwg20m.yml
index 9c9ef4b..5f83173 100644
--- a/kas/board/iwg20m.yml
+++ b/kas/board/iwg20m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: iwg20m
diff --git a/kas/board/qemu-amd64.yml b/kas/board/qemu-amd64.yml
index c27ed8e..5a679f4 100644
--- a/kas/board/qemu-amd64.yml
+++ b/kas/board/qemu-amd64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: qemu-amd64
diff --git a/kas/board/qemu-arm.yml b/kas/board/qemu-arm.yml
index 969fd5a..abd256b 100644
--- a/kas/board/qemu-arm.yml
+++ b/kas/board/qemu-arm.yml
@@ -11,6 +11,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: qemu-arm
diff --git a/kas/board/qemu-arm64.yml b/kas/board/qemu-arm64.yml
index 1a1eb0d..68151e8 100644
--- a/kas/board/qemu-arm64.yml
+++ b/kas/board/qemu-arm64.yml
@@ -11,6 +11,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: qemu-arm64
diff --git a/kas/board/qemu-riscv64.yml b/kas/board/qemu-riscv64.yml
index e8272b0..894b5e3 100644
--- a/kas/board/qemu-riscv64.yml
+++ b/kas/board/qemu-riscv64.yml
@@ -7,6 +7,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: qemu-riscv64
diff --git a/kas/board/rzt2h-evk.yml b/kas/board/rzt2h-evk.yml
index 90261dc..7c82a78 100644
--- a/kas/board/rzt2h-evk.yml
+++ b/kas/board/rzt2h-evk.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: rzt2h-evk
diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
index 5127218..cd9d07f 100644
--- a/kas/board/ti-am62px-sk.yml
+++ b/kas/board/ti-am62px-sk.yml
@@ -8,6 +8,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: ti-am62px-sk
diff --git a/kas/board/x86-uefi.yml b/kas/board/x86-uefi.yml
index 056ca32..92bd94f 100644
--- a/kas/board/x86-uefi.yml
+++ b/kas/board/x86-uefi.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 machine: x86-uefi
diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
index 708562b..944175f 100644
--- a/kas/opt/4.19.yml
+++ b/kas/opt/4.19.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
index db9bbdc..1be0441 100644
--- a/kas/opt/4.4.yml
+++ b/kas/opt/4.4.yml
@@ -11,7 +11,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
index d76d056..aff3f26 100644
--- a/kas/opt/5.10.yml
+++ b/kas/opt/5.10.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/6.1.yml b/kas/opt/6.1.yml
index caca83d..8ab9fc3 100644
--- a/kas/opt/6.1.yml
+++ b/kas/opt/6.1.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/6.12.yml b/kas/opt/6.12.yml
index 052b59c..ee1bf75 100644
--- a/kas/opt/6.12.yml
+++ b/kas/opt/6.12.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
index dc0e0a2..82d7594 100644
--- a/kas/opt/bookworm.yml
+++ b/kas/opt/bookworm.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 distro: cip-core-bookworm
diff --git a/kas/opt/bullseye.yml b/kas/opt/bullseye.yml
index 0614c92..6d10d4c 100644
--- a/kas/opt/bullseye.yml
+++ b/kas/opt/bullseye.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 distro: cip-core-bullseye
diff --git a/kas/opt/buster.yml b/kas/opt/buster.yml
index 3f19310..4913ea8 100644
--- a/kas/opt/buster.yml
+++ b/kas/opt/buster.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 distro: cip-core-buster
diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
index 7d4c28c..6d8282d 100644
--- a/kas/opt/delta-update.yml
+++ b/kas/opt/delta-update.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   delta-update: |
diff --git a/kas/opt/disable-watchdog.yml b/kas/opt/disable-watchdog.yml
index 88ece6b..64695b8 100644
--- a/kas/opt/disable-watchdog.yml
+++ b/kas/opt/disable-watchdog.yml
@@ -8,7 +8,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   no-watchdog: |
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index a581466..569d2a5 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
   includes:
     - kas/opt/ebg-swu.yml
 
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 7835559..486d30f 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
   includes:
    - kas/opt/swupdate.yml
 
diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
index faf7206..8ad40ee 100644
--- a/kas/opt/encrypt-all.yml
+++ b/kas/opt/encrypt-all.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
   includes:
     - kas/opt/encrypt-data.yml
 local_conf_header:
diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
index 3de76ab..a4332e9 100644
--- a/kas/opt/encrypt-data.yml
+++ b/kas/opt/encrypt-data.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   initramfs-option-encrypt-partitions: |
diff --git a/kas/opt/erofs.yml b/kas/opt/erofs.yml
index 7c44f5b..1eff7e5 100644
--- a/kas/opt/erofs.yml
+++ b/kas/opt/erofs.yml
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   erofs: |
diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
index f5be699..d4dddd1 100644
--- a/kas/opt/expand-on-first-boot.yml
+++ b/kas/opt/expand-on-first-boot.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   package-expand-on-first-boot: |
diff --git a/kas/opt/factory-reset.yml b/kas/opt/factory-reset.yml
index 1ea11db..d8e0b71 100644
--- a/kas/opt/factory-reset.yml
+++ b/kas/opt/factory-reset.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   factory-reset: |
diff --git a/kas/opt/forky.yml b/kas/opt/forky.yml
index 6c4fcdc..c7f1294 100644
--- a/kas/opt/forky.yml
+++ b/kas/opt/forky.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 distro: cip-core-forky
diff --git a/kas/opt/ftpm-stmm.yml b/kas/opt/ftpm-stmm.yml
index 06f645d..60797c9 100644
--- a/kas/opt/ftpm-stmm.yml
+++ b/kas/opt/ftpm-stmm.yml
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   ftpm-stmm: |
diff --git a/kas/opt/kernel-head.yml b/kas/opt/kernel-head.yml
index abb4d62..2c8ef9e 100644
--- a/kas/opt/kernel-head.yml
+++ b/kas/opt/kernel-head.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-version-head: |
diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
index f966779..3628d8e 100644
--- a/kas/opt/kernel-panic.yml
+++ b/kas/opt/kernel-panic.yml
@@ -11,7 +11,7 @@
 # This kas file adds systemd service file to cause kernel panic during system boot.
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-panic: |
diff --git a/kas/opt/no_kernel.yml b/kas/opt/no_kernel.yml
index 7bba6a5..4ee3ece 100644
--- a/kas/opt/no_kernel.yml
+++ b/kas/opt/no_kernel.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index ae611eb..79dd936 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   reproducible-builds: |
diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
index ab43a84..3abc4c1 100644
--- a/kas/opt/rt.yml
+++ b/kas/opt/rt.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   preempt-rt: |
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 2ad53ea..ed6087f 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 14
+  version: 23
   includes:
    - kas/opt/encrypt-data.yml
    - kas/opt/ebg-secure-boot-snakeoil.yml
diff --git a/kas/opt/security_test.yml b/kas/opt/security_test.yml
index 40ac576..68571b2 100644
--- a/kas/opt/security_test.yml
+++ b/kas/opt/security_test.yml
@@ -8,7 +8,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   lava-testing-add-curl: |
diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
index 9fccd20..16fe2cb 100644
--- a/kas/opt/separate-home-partition.yml
+++ b/kas/opt/separate-home-partition.yml
@@ -12,7 +12,7 @@
 # This provide backward compability to the previous isar-cip-core
 # versions.
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   separate-home-partition: |
diff --git a/kas/opt/sid.yml b/kas/opt/sid.yml
index 26515d3..cb67e8a 100644
--- a/kas/opt/sid.yml
+++ b/kas/opt/sid.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 distro: cip-core-sid
diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
index cbaa4b5..803036f 100644
--- a/kas/opt/swupdate-2022.12.yaml
+++ b/kas/opt/swupdate-2022.12.yaml
@@ -12,7 +12,7 @@
 # from the first wic partition
 
 header:
-  version: 14
+  version: 23
   includes:
    - kas/opt/swupdate.yml
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index b4c4b99..5a4c8bf 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -12,7 +12,7 @@
 # from the first wic partition
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   image-option-swupdate: |
diff --git a/kas/opt/targz.yml b/kas/opt/targz.yml
index 5c0b87b..48f3ebd 100644
--- a/kas/opt/targz.yml
+++ b/kas/opt/targz.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   image-type: |
diff --git a/kas/opt/test.yml b/kas/opt/test.yml
index 4a60ad4..ef0fc9e 100644
--- a/kas/opt/test.yml
+++ b/kas/opt/test.yml
@@ -9,7 +9,7 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 local_conf_header:
   testing: |
diff --git a/kas/opt/trixie.yml b/kas/opt/trixie.yml
index e9a76ef..9734a49 100644
--- a/kas/opt/trixie.yml
+++ b/kas/opt/trixie.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 14
+  version: 23
 
 distro: cip-core-trixie
-- 
2.34.1


