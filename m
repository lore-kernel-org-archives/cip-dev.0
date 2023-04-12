Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413EFC77B6E
	for <webhook@archiver.kernel.org>; Wed, 12 Apr 2023 12:03:58 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.36696.1681281690710391650
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Apr 2023 23:41:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=HD0qJsgT;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-20230412064127fedaa8ca79080a0307-u_vftg@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230412064127fedaa8ca79080a0307
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Apr 2023 08:41:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6TVrAReynt5Zv/DFDXKuGd7Gkh2RcaVO/QzWDidJvrY=;
 b=HD0qJsgTviFodoLregX7hSYpg2NcqJgujDII3D4LXPpyoKmCyOzvuKoqTUu4DQiSSmpArm
 l6gAISYqGIJ3raAz3+whWea8hEGHNc3+OShAwa5sXMN9uHfr/+9oP2r0g37ASNOVxwiwVwsl
 I2w449l7f2do0giFwhHBMgjeA76OM=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: gokhan.cetin@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] add missing dependency to template subst in swu
Date: Wed, 12 Apr 2023 14:41:18 +0800
Message-Id: <20230412064118.431415-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Apr 2023 12:03:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11193

Before creating swu files, the sw-description temlate needs to be
expanded. This logic is also independent of the imagetype.
Previously, only some image types had this task in the dependency chain
before invoking the swu creation. By that, it was working for e.g. wic,
but not for ext4 rootfs images (referring to the type of the abrootfs).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/swupdate.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 064d0ad..e12a4d2 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -9,6 +9,9 @@
 #  Felix Moessbauer <felix.moessbauer@siemens.com>
 #
 # SPDX-License-Identifier: MIT
+
+inherit template
+
 SWU_ROOTFS_TYPE ?= "squashfs"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
 # compression type as defined by swupdate (zlib or zstd)
@@ -50,6 +53,7 @@ def get_swu_compression_type(d):
 # We append to the path, so locally provided config files are preferred
 FILESEXTRAPATHS:append = ":${LAYERDIR_cip-core}/recipes-core/images/swu"
 
+do_image_swu[depends] += "${PN}:do_transform_template"
 do_image_swu[stamp-extra-info] = "${DISTRO}-${MACHINE}"
 do_image_swu[cleandirs] += "${WORKDIR}/swu"
 IMAGE_CMD:swu() {
-- 
2.39.2


