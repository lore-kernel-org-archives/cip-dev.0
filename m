Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97334E77186
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 02:03:33 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.8733.1733916743529574112
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 03:32:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=Phz5KDhR;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1321639-20241211113219e4360ac089d9514aee-ad5_ty@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241211113219e4360ac089d9514aee
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Dec 2024 12:32:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lb5MIBBrWrbGRWGhtLgOQtQynn8mDet2qR/PR0NCn2E=;
 b=Phz5KDhRvLayYVWdMbhOhlN+hJ3mwoIfvDWPNqh7n8y656OwmE+caphRlXTVxftjWIVo0I
 Ko66qIiIWlTiFQL2qAMdOaA8aTKbO2h5oQNywyKN5g2AKGDUOZZ/u4QiLJ7aRdk/i/12mJBH
 vJhuFhqdB9PUJ1bULRAUv6QKsCwm4d8duGu9KKbfYDZS8FTUaVr+E3dwKigNzu+Oql0ZowlP
 +h4+NyfXVR98KEvFcIpjCVr934X0ozquA25Xz6XHkBQse8myHSW3UTEcp2YDF7oeZpbKBe3P
 B34JVQAImFgr55NFZnDeaep4yjPGfKC3NLXwAjmBLZVDotBi2p/K+I3w==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v3 1/1] define RO_ROOTFS_TYPE before using
Date: Wed, 11 Dec 2024 12:32:13 +0100
Message-Id: <20241211113213.2743931-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 02:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17438

When including isar-cip-core in another layer and not using the cip-core
distribution, the RO_ROOTFS_TYPE is undefined. This results in parsing
errors.

We now provide a weak default in the verity and squashfs recipes to not
break the parsing in downstream layers. As we no longer need the
definition in the distro file, we remove it there.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2:
- add missing definition in swupdate.yml (used to control which
  initrd is build).

Changes since v1:
- remove RO_ROOTFS_TYPE from distro file

 classes/swupdate.bbclass        | 1 +
 classes/verity.bbclass          | 1 +
 conf/distro/cip-core-common.inc | 2 --
 kas/opt/swupdate.yml            | 1 +
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 5bf021a..3243f67 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -12,6 +12,7 @@
 
 inherit template
 
+RO_ROOTFS_TYPE ??= "squashfs"
 SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index 231d172..c3b89ec 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -12,6 +12,7 @@
 IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
 IMAGER_INSTALL:verity += "cryptsetup"
 
+RO_ROOTFS_TYPE ??= "squashfs"
 VERITY_IMAGE_TYPE ?= "${RO_ROOTFS_TYPE}"
 VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
 VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
index 3323dd0..d06eef0 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -15,8 +15,6 @@ WKS_FILE ?= "${MACHINE}.wks"
 
 CIP_IMAGE_OPTIONS ?= ""
 
-RO_ROOTFS_TYPE ?= "squashfs"
-
 IMAGER_BUILD_DEPS:append = " dosfstools-native"
 IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 837efa7..38dc390 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -20,6 +20,7 @@ local_conf_header:
     OVERRIDES .= ":swupdate"
 
   wic-swu: |
+    RO_ROOTFS_TYPE ??= "squashfs"
     IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
     IMAGE_FSTYPES:append = " swu"
     # input is already compressed
-- 
2.39.5


