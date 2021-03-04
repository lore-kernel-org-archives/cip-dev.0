Return-Path: <SRS0=4Bxj=IC=lists.cip-project.org=bounce+64572+6210+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA22DC433E6
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 17:09:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5933064F5F
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 17:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5933064F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6210+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AE41YY4521723xIJw32Jz9xp; Thu, 04 Mar 2021 09:09:38 -0800
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.1840.1614877777794279246
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Mar 2021 09:09:38 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 124H9Z7q011100
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 4 Mar 2021 18:09:36 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.94.54])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 124H9Y6k031858;
	Thu, 4 Mar 2021 18:09:35 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/2] conf/machine: Add KERNEL_DEFCONFIG_VERSION to select defconfig path
Date: Thu,  4 Mar 2021 18:09:33 +0100
Message-Id: <20210304170934.7424-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210304170934.7424-1-Quirin.Gylstorff@siemens.com>
References: <20210304170934.7424-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k5O8trQ8hn5p3B1qLRffW0VTx4520388AA=
Content-Type: multipart/mixed; boundary="EVMVHGftk3YWr4yP0OGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614877778;
 bh=ok/Hj87IVwX5BdnxmSsT7tjVp/6JEzhg495+YhWo+Bg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZB4699pZEEETdYd6xfq5JrSo8Pevotmpu6GLnizgQdqIjzAEOZ8fWqUhwoOIf6xQ5iK
 jQmA7EmWwkh0igPHHjA4fu4gN/hiLzLTGMfanTekUQtZvwWrq98+OjgCwrwcryzgTqaD1
 fxcuy1PMWL8iro8qb5EGG6XGrCs9P/ubclo=

--EVMVHGftk3YWr4yP0OGv
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The repository cip-kernel-config[1] contains for each supported kernel
version its own directory. Add the variable KERNEL_DEFCONFIG_VERSION
to select the defconfig matching the kernel version.

Also add a version to select the rt configuration of [1].

[1]:https://gitlab.com/cip-project/cip-kernel/cip-kernel-config

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/bbb.conf             | 5 +++++
 conf/machine/hihope-rzg2m.conf    | 5 ++++-
 conf/machine/iwg20m.conf          | 5 ++++-
 conf/machine/qemu-amd64.conf      | 5 ++++-
 conf/machine/simatic-ipc227e.conf | 5 ++++-
 kas/opt/4.4.yml                   | 1 +
 kas/opt/rt.yml                    | 1 +
 7 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index a9b460e..2878ed1 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -11,6 +11,11 @@ DISTRO_ARCH = "armhf"
 IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "u-boot-omap"
 
+# kernel defconfig
+USE_CIP_KERNEL_CONFIG = "1"
+KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_defconfig"
+
 # On stretch, select U-Boot from buster which comes with distro-boot support
 DISTRO_APT_SOURCES_append_cip-core-stretch = " conf/distro/debian-buster.list"
 DISTRO_APT_PREFERENCES_cip-core-stretch += "conf/machine/preferences.bbb.conf"
diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index a2ae03d..2a46b74 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -13,7 +13,10 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_TYPE ?= "wic-img"
 
-KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
+# kernel defconfig
+KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
+
 DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
 IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index 91bfd94..b5f9490 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -17,8 +17,11 @@ BAUDRATE_TTY = "115200"
 # kernel version
 PREFERRED_VERSION_linux-cip ?= "4.4.%"
 PREFERRED_VERSION_linux-cip-rt ?= "4.4.%"
+
+# kernel defconfig
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/4.4.y-cip/arm/renesas_shmobile_defconfig"
+KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_shmobile_defconfig"
 
 # Boot partition files
 DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index c90d957..d99d8b1 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -9,5 +9,8 @@
 DISTRO_ARCH = "amd64"
 
 IMAGE_TYPE ?= "ext4-img"
+
+# kernel defconfig
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/cip_qemu_defconfig"
+KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 3c9638f..aacfc9d 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -10,5 +10,8 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_TYPE ?= "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
+
+# kernel defconfig
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/x86/siemens_ipc227e_defconfig"
+KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
diff --git a/kas/opt/4.4.yml b/kas/opt/4.4.yml
index 65a4775..a601be3 100644
--- a/kas/opt/4.4.yml
+++ b/kas/opt/4.4.yml
@@ -16,3 +16,4 @@ local_conf_header:
   kernel-version: |
     PREFERRED_VERSION_linux-cip = "4.4.%"
     PREFERRED_VERSION_linux-cip-rt = "4.4.%"
+    KERNEL_DEFCONFIG_VERSION = "4.4.y-cip"
diff --git a/kas/opt/rt.yml b/kas/opt/rt.yml
index b8fe6bb..d6fcf78 100644
--- a/kas/opt/rt.yml
+++ b/kas/opt/rt.yml
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   preempt-rt: |
     KERNEL_NAME = "cip-rt"
+    KERNEL_DEFCONFIG_VERSION_append = "-rt"
-- 
2.20.1


--EVMVHGftk3YWr4yP0OGv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6210): https://lists.cip-project.org/g/cip-dev/message=
/6210
Mute This Topic: https://lists.cip-project.org/mt/81081992/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--EVMVHGftk3YWr4yP0OGv--
