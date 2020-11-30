Return-Path: <SRS0=fxXu=FE=lists.cip-project.org=bounce+64572+5907+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB190C63777
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDD92067C
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IVEKMTrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDD92067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5907+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id brq4YY4521723xgBR75zbBVJ; Mon, 30 Nov 2020 11:32:26 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web08.2094.1606764739676014708
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 11:32:21 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 0AUJWIZg032487
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:18 +0100
X-Received: from md1f2u6c.ad001.siemens.net ([167.87.39.132])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AUJWGdj001649
	for <cip-dev@lists.cip-project.org>; Mon, 30 Nov 2020 20:32:17 +0100
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core][PATCH 3/3] Update to kas 2.3.3
Date: Mon, 30 Nov 2020 20:32:16 +0100
Message-Id: <b3717fe32f6ba1c1f6a5475d0def199a0806cdea.1606764736.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1606764736.git.jan.kiszka@siemens.com>
References: <cover.1606764736.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RGUYUxndYyCDdNmp9ewi5BE3x4520388AA=
Content-Type: multipart/mixed; boundary="LVatsszz6lWlTEdI0Ywb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606764746;
 bh=VANvfbvgDsZNZEtFQtnczLe8Yc0NJesffhChD753pJM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IVEKMTrWVRyiWBoMfOb9KaCu1pVZPIzYj6jMhMpCzD6QA0A1/nLZqf0+QTiAavTLWRA
 +dwWDLDN3tiJVZnBI+9rQfFyQBAXMuDB44QsBG5lzBRmOZzXsiLibCPMPdFYrNznLwbEJ
 L2/XqoUI5vu71mgfulFlb27UIx6AT4sAxqI=

--LVatsszz6lWlTEdI0Ywb
Content-Transfer-Encoding: 8bit

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitignore                           |  3 ++-
 .gitlab-ci.yml                       |  2 +-
 README.md                            | 12 ++++++------
 doc/README.secureboot.md             |  4 ++--
 doc/README_iwg20m.md                 | 11 +++++------
 kas-cip.yml                          |  4 +++-
 kas/board/bbb.yml                    |  2 +-
 kas/board/hihope-rzg2m.yml           |  2 +-
 kas/board/iwg20m.yml                 |  2 +-
 kas/board/qemu-amd64.yml             |  2 +-
 kas/board/simatic-ipc227e.yml        |  2 +-
 kas/opt/4.4.yml                      |  2 +-
 kas/opt/ebg-secure-boot-base.yml     |  2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml |  2 +-
 kas/opt/ebg-swu.yml                  |  2 +-
 kas/opt/qemu-swupdate.yml            |  2 +-
 kas/opt/rt.yml                       |  2 +-
 kas/opt/security.yml                 |  2 +-
 kas/opt/stretch.yml                  |  2 +-
 kas/opt/targz-img.yml                |  2 +-
 kas/opt/test.yml                     |  2 +-
 21 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/.gitignore b/.gitignore
index bfedb76..5142933 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
 build/
 isar/
-kas-docker
\ No newline at end of file
+kas-docker
+kas-container
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0b0a771..77d361c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,4 +1,4 @@
-image: kasproject/kas-isar:2.2
+image: ghcr.io/siemens/kas/kas-isar:2.3.3
 
 variables:
   GIT_STRATEGY: clone
diff --git a/README.md b/README.md
index 0d2374f..f038db3 100644
--- a/README.md
+++ b/README.md
@@ -10,18 +10,18 @@ from scratch.
 
 ## Building Target Images
 
-Install `kas-docker` from the [kas project](https://github.com/siemens/kas):
+Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.2/kas-docker
-    chmod a+x kas-docker
+    wget https://raw.githubusercontent.com/siemens/kas/2.3.3/kas-container
+    chmod a+x kas-container
 
 Furthermore, install docker and make sure you have required permissions to
 start containers.
 
-To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-docker like
+To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-container like
 this:
 
-    ./kas-docker --isar build kas-cip.yml:kas/board/qemu-amd64.yml
+    ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml
 
 This image can be run using `start-qemu.sh x86`.
 
@@ -39,7 +39,7 @@ card, run
 ## Building Security target images
 Building images for QEMU x86-64bit machine
 
-    ./kas-docker --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
+    ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
 
 Run the generated securiy images on QEMU (x86-64bit)
 
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index f365ab6..84131bb 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -139,13 +139,13 @@ scripts/start-efishell.sh secureboot-tools
 Build the image with a signed efibootguard and unified kernel image
 with the snakeoil keys by executing:
 ```
-kas-docker --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-secure-boot-snakeoil.yml
+kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-secure-boot-snakeoil.yml
 ```
 
 For user-generated keys, create a new option file. This option file could look like this:
 ```
 header:
-  version: 8
+  version: 10
   includes:
    - opt/ebg-swu.yml
    - opt/ebg-secure-boot-initramfs.yml
diff --git a/doc/README_iwg20m.md b/doc/README_iwg20m.md
index 20e4bf6..317d240 100644
--- a/doc/README_iwg20m.md
+++ b/doc/README_iwg20m.md
@@ -5,16 +5,15 @@ Copyright: Toshiba corp.
 
 ## Build the CIP Core image
 
-Use [kas-docker](https://github.com/siemens/kas/blob/master/kas-docker) to build the image. Currently this board is only supported by the CIP kernel version `4.4.y`.
+Set up `kas-container` as described in the [top-level README](../README.md).
+Then build the image:
 
 ```
-$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
-$ cd isar-cip-core
-$ wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker
-$ chmod a+x kas-docker
-$ ./kas-docker --isar build kas-cip.yml:kas/board/iwg20m.yml
+$ ./kas-container build kas-cip.yml:kas/board/iwg20m.yml
 ```
 
+Note: Currently this board is only supported by the CIP kernel version `4.4.y`.
+
 After the build is finished, insert a micro SDCard and flash the image with `bmaptool` (a better `dd`). Make sure you substitute `/dev/sdX` by the device file corresponding to your SDCard.
 
 ```
diff --git a/kas-cip.yml b/kas-cip.yml
index 922ee7e..f50cd6c 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -10,11 +10,13 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 distro: cip-core-buster
 target: cip-core-image
 
+build_system: isar
+
 repos:
   cip-core:
 
diff --git a/kas/board/bbb.yml b/kas/board/bbb.yml
index fc8dbbe..13f0a7f 100644
--- a/kas/board/bbb.yml
+++ b/kas/board/bbb.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: bbb
diff --git a/kas/board/hihope-rzg2m.yml b/kas/board/hihope-rzg2m.yml
index bbef122..9d11bb6 100644
--- a/kas/board/hihope-rzg2m.yml
+++ b/kas/board/hihope-rzg2m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: hihope-rzg2m
diff --git a/kas/board/iwg20m.yml b/kas/board/iwg20m.yml
index 3def3af..2e74ad1 100644
--- a/kas/board/iwg20m.yml
+++ b/kas/board/iwg20m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: iwg20m
diff --git a/kas/board/qemu-amd64.yml b/kas/board/qemu-amd64.yml
index 02e99ba..06e9e18 100644
--- a/kas/board/qemu-amd64.yml
+++ b/kas/board/qemu-amd64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: qemu-amd64
diff --git a/kas/board/simatic-ipc227e.yml b/kas/board/simatic-ipc227e.yml
index a2c6965..70cf88e 100644
--- a/kas/board/simatic-ipc227e.yml
+++ b/kas/board/simatic-ipc227e.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: simatic-ipc227e
diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
index 87be777..65a4775 100644
--- a/kas/opt/4.4.yml
+++ b/kas/opt/4.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index c1d98b1..30ca35a 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   initramfs: |
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index cda8177..8a72084 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
   includes:
    - ebg-secure-boot-base.yml
 
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 304fa4d..aa3aed1 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   swupdate: |
diff --git a/kas/opt/qemu-swupdate.yml b/kas/opt/qemu-swupdate.yml
index 99b4547..3f5fedf 100644
--- a/kas/opt/qemu-swupdate.yml
+++ b/kas/opt/qemu-swupdate.yml
@@ -11,7 +11,7 @@
 
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   qemu-wic: |
diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
index b52774a..b8fe6bb 100644
--- a/kas/opt/rt.yml
+++ b/kas/opt/rt.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   preempt-rt: |
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 237cbeb..3cf88af 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 8
+  version: 10
 
 target: cip-core-image-security
diff --git a/kas/opt/stretch.yml b/kas/opt/stretch.yml
index 29a497a..8e854c2 100644
--- a/kas/opt/stretch.yml
+++ b/kas/opt/stretch.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 distro: cip-core-stretch
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
index 1a73024..7e9081f 100644
--- a/kas/opt/targz-img.yml
+++ b/kas/opt/targz-img.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 # lava uses nfs to deploy the image. For this we need a tarball instead of
 # full image
diff --git a/kas/opt/test.yml b/kas/opt/test.yml
index 4238f0b..ee48196 100644
--- a/kas/opt/test.yml
+++ b/kas/opt/test.yml
@@ -9,7 +9,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   testing: |
-- 
2.26.2


--LVatsszz6lWlTEdI0Ywb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5907): https://lists.cip-project.org/g/cip-dev/message=
/5907
Mute This Topic: https://lists.cip-project.org/mt/78616511/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LVatsszz6lWlTEdI0Ywb--
