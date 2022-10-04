Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE6C43219
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.13160.1664902102669354302
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=UZ5GWj7b;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-20221004164820f968677d0968cd93c5-91nnre@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20221004164820f968677d0968cd93c5
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UAa7Uydl6itarbojhhY7mU1Yu/SjOKYXal6zZeoyXco=;
 b=UZ5GWj7bYBtXqoNcqfREbHu0pUWjv+YHlRp0rRIvcgHi9LqMPwo9Y8dhuAhuiN1Nr56osx
 wYrDp2f0/QSMpfBHZTTAlrwZqULbLBYHaYPAUM/ofVV/udsmkizPa4h6PIy/wuISVhCfRQCL
 GDquC5t8qxAzn/4wm0/tinh3Ak10E=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 05/12] Bump kas header version to 12
Date: Tue,  4 Oct 2022 18:48:11 +0200
Message-Id: 
 <8bffb54134b3017f4bdd9fa86bd43d0102948e12.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9632

From: Jan Kiszka <jan.kiszka@siemens.com>

We already adopted 11 with repo-relative includes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.secureboot.md             | 2 +-
 kas-cip.yml                          | 2 +-
 kas/board/bbb.yml                    | 2 +-
 kas/board/hihope-rzg2m.yml           | 2 +-
 kas/board/iwg20m.yml                 | 2 +-
 kas/board/qemu-amd64.yml             | 2 +-
 kas/board/qemu-arm.yml               | 2 +-
 kas/board/qemu-arm64.yml             | 2 +-
 kas/board/simatic-ipc227e.yml        | 2 +-
 kas/opt/4.19.yml                     | 2 +-
 kas/opt/4.4.yml                      | 2 +-
 kas/opt/5.10.yml                     | 2 +-
 kas/opt/bullseye.yml                 | 2 +-
 kas/opt/buster.yml                   | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 kas/opt/ebg-swu.yml                  | 2 +-
 kas/opt/kernel-panic.yml             | 2 +-
 kas/opt/kernelci.yml                 | 2 +-
 kas/opt/rt.yml                       | 2 +-
 kas/opt/security.yml                 | 2 +-
 kas/opt/swupdate.yml                 | 2 +-
 kas/opt/targz-img.yml                | 2 +-
 kas/opt/test.yml                     | 2 +-
 kas/opt/wic-targz-img.yml            | 2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 319b4db0..b6ad9e06 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -145,7 +145,7 @@ kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot
 For user-generated keys, create a new option file in the repository. This option file could look like this:
 ```
 header:
-  version: 10
+  version: 12
   includes:
    - kas/opt/ebg-secure-boot-base.yml
 
diff --git a/kas-cip.yml b/kas-cip.yml
index 4956da5c..6b9d5a23 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 distro: cip-core-bullseye
 target: cip-core-image
diff --git a/kas/board/bbb.yml b/kas/board/bbb.yml
index 13f0a7f6..c99d9bd4 100644
--- a/kas/board/bbb.yml
+++ b/kas/board/bbb.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 machine: bbb
diff --git a/kas/board/hihope-rzg2m.yml b/kas/board/hihope-rzg2m.yml
index 9d11bb6b..7b80de7c 100644
--- a/kas/board/hihope-rzg2m.yml
+++ b/kas/board/hihope-rzg2m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 machine: hihope-rzg2m
diff --git a/kas/board/iwg20m.yml b/kas/board/iwg20m.yml
index 2e74ad13..c873b987 100644
--- a/kas/board/iwg20m.yml
+++ b/kas/board/iwg20m.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 machine: iwg20m
diff --git a/kas/board/qemu-amd64.yml b/kas/board/qemu-amd64.yml
index 06e9e180..f9f57be9 100644
--- a/kas/board/qemu-amd64.yml
+++ b/kas/board/qemu-amd64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 machine: qemu-amd64
diff --git a/kas/board/qemu-arm.yml b/kas/board/qemu-arm.yml
index 9bf97283..fe030286 100644
--- a/kas/board/qemu-arm.yml
+++ b/kas/board/qemu-arm.yml
@@ -11,6 +11,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 machine: qemu-arm
diff --git a/kas/board/qemu-arm64.yml b/kas/board/qemu-arm64.yml
index 823964d8..55690b3f 100644
--- a/kas/board/qemu-arm64.yml
+++ b/kas/board/qemu-arm64.yml
@@ -11,6 +11,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 machine: qemu-arm64
diff --git a/kas/board/simatic-ipc227e.yml b/kas/board/simatic-ipc227e.yml
index 70cf88e7..82b0ff79 100644
--- a/kas/board/simatic-ipc227e.yml
+++ b/kas/board/simatic-ipc227e.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 machine: simatic-ipc227e
diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
index 5ff16839..5e79223d 100644
--- a/kas/opt/4.19.yml
+++ b/kas/opt/4.19.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
index 65a47757..970351ac 100644
--- a/kas/opt/4.4.yml
+++ b/kas/opt/4.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/5.10.yml b/kas/opt/5.10.yml
index 612b7f9e..2258575c 100644
--- a/kas/opt/5.10.yml
+++ b/kas/opt/5.10.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   kernel-version: |
diff --git a/kas/opt/bullseye.yml b/kas/opt/bullseye.yml
index 24a4c848..b08e0e41 100644
--- a/kas/opt/bullseye.yml
+++ b/kas/opt/bullseye.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 distro: cip-core-bullseye
diff --git a/kas/opt/buster.yml b/kas/opt/buster.yml
index a7621633..9b0b530f 100644
--- a/kas/opt/buster.yml
+++ b/kas/opt/buster.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 distro: cip-core-buster
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index ff65e99f..f756ceea 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
   includes:
     - kas/opt/ebg-swu.yml
 
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 8b3ffec4..b534c504 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
   includes:
    - kas/opt/swupdate.yml
 
diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
index 47df7b16..9aac8b24 100644
--- a/kas/opt/kernel-panic.yml
+++ b/kas/opt/kernel-panic.yml
@@ -11,7 +11,7 @@
 # This kas file adds systemd service file to cause kernel panic during system boot.
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   kernel-panic: |
diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
index 9c67864f..b5fadcb9 100644
--- a/kas/opt/kernelci.yml
+++ b/kas/opt/kernelci.yml
@@ -11,6 +11,6 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 10
+  version: 12
 
 target: cip-core-image-kernelci
diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
index b8fe6bb6..4b2519f1 100644
--- a/kas/opt/rt.yml
+++ b/kas/opt/rt.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   preempt-rt: |
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 3cf88afa..4e74a9c4 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -9,6 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 header:
-  version: 10
+  version: 12
 
 target: cip-core-image-security
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 8ba03c9a..ea8bac3d 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -12,7 +12,7 @@
 # from the first wic partition
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   image-option-swupdate: |
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
index afe2e074..8283ef88 100644
--- a/kas/opt/targz-img.yml
+++ b/kas/opt/targz-img.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   image-type: |
diff --git a/kas/opt/test.yml b/kas/opt/test.yml
index ee481966..411582bd 100644
--- a/kas/opt/test.yml
+++ b/kas/opt/test.yml
@@ -9,7 +9,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 local_conf_header:
   testing: |
diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
index aaee76d8..3d908de6 100644
--- a/kas/opt/wic-targz-img.yml
+++ b/kas/opt/wic-targz-img.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 10
+  version: 12
 
 # lava uses nfs to deploy the image. For this we need a tarball instead of
 # full image
-- 
2.35.3


