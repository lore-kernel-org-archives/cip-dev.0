Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A5E77187
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 02:03:33 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.7151.1733910996882337138
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 01:56:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=VVX7f8cq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1321639-20241211095634eef9b7ca69b17960bb-4_fcdh@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241211095634eef9b7ca69b17960bb
        for <cip-dev@lists.cip-project.org>;
        Wed, 11 Dec 2024 10:56:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=fp0mMlnzcN3U8d4c8p+FDb1Qd0C2gRsyWjnVu4Cp7Jo=;
 b=VVX7f8cqFBS9e5kXk1KEyZQlTAoR38ZiY9a+YRpnnRB/UtHSyYFvwUMOAvAoHkVg0jvtxr
 m9lxN4tK9g9JEd5yQmLRvRpiH3pvdS9L7MrwFAat03usGDBVbLRu0wanDDdwWgvxhI4p2Vyd
 KFfpEojRua/4zOcsAvLBy+zXtnmqJcXgLARV/H8IFnQ/kld4HprkfyhOCu5hRsyWyeljmEjB
 UtLShhNMoqx8/xeZkBcWuXDVxrQFaJJe4GMCjMR8CtcP6eOgM1+EmlgkXL/iYaBpzq+2dfXv
 T5fGI6JDp9/3Dszu8WqKlhWZitOzv/uIN9iz9ntGx3PakSls57SyAq7Q==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] define RO_ROOTFS_TYPE before using
Date: Wed, 11 Dec 2024 10:56:28 +0100
Message-Id: <20241211095628.2735849-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Dec 2024 02:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17435

When including isar-cip-core in another layer and not using the cip-core
distribution, the RO_ROOTFS_TYPE is undefined. This results in parsing
errors.

We now provide a weak default in the verity and squashfs recipes to not
break the parsing in downstream layers. As we no longer need the
definition in the distro file, we remove it there.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v1:

- remove RO_ROOTFS_TYPE from distro file

 classes/swupdate.bbclass        | 1 +
 classes/verity.bbclass          | 1 +
 conf/distro/cip-core-common.inc | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
2.39.5


