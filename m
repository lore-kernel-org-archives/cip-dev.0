Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40DDC2BD09
	for <webhook@archiver.kernel.org>; Wed,  3 Jul 2024 12:18:05 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.49604.1720009080512115595
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jul 2024 05:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=O68k2ckS;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from localhost (dslb-002-207-026-217.002.207.pools.vodafone-ip.de [2.207.26.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5834C88224;
	Wed,  3 Jul 2024 14:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720009078;
	bh=anEDFKkZ939xwJJXjvZi233tgrGt3uF8nGLYHbdq5Vc=;
	h=From:To:Cc:Subject:Date:From;
	b=O68k2ckSfk5aTGvmHk9v5SVSMDong6cV15WT8MnuWUTp9WCFyIhXCDfHNIUZQwu/d
	 BbhTlaEf0Wk/R4ilkNKZKHXYYwjXgh03dpuiKZcYhRT4ij1X3pbjc2dVGtM9T7XrNq
	 6Xzgp3IO3IFEYwVOhdz/8JAGcqkdAsRsNFRtf+huoYL/tC7lR947mOuOv3zH8A4Ngm
	 V25v2hRbewYstc6vJUyCbL5VgLDI3v2PoF2hssrxrWnNoNXBLTvTkqVJYYknARz2+4
	 KrA5KLbvBOBdRAHw1+gCGBOQWxk7qkOzAFRjg/SXBG1wtVmuspqb4pgurADCFDGW3D
	 1nJgytBCuYzNQ==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [PATCH] swupdate.bbclass: add SWU_BOOTLOADER='none' support
Date: Wed,  3 Jul 2024 14:17:56 +0200
Message-ID: <20240703121756.2164672-1-ch@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jul 2024 12:18:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16368

On some systems the update process and bootloader integration is more
complex and custom, thus integrated into handler and wrapper scripts.

Bootloader support on swupdate and the default cip-core update structure
will not function correctly and need to be deactivated.

This change implements a `none` setting for SWU_BOOTLOADER which allows
to deactive any `SWU_DESCRIPITION_FILE_BOOTLOADER` handling.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 classes/swupdate.bbclass | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index e91238d..aa0af00 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -52,9 +52,11 @@ IMAGE_INSTALL +=3D "${@'swupdate-certificates' if bb.u=
tils.to_boolean(d.getVar('SW
=20
=20
 IMAGE_SRC_URI:swu =3D "file://${SWU_DESCRIPTION_FILE}.tmpl"
-IMAGE_SRC_URI:swu +=3D "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
+IMAGE_SRC_URI:swu +=3D "${'file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tm=
pl' \
+    if d.getVar('SWU_BOOTLOADER') not in ['', 'none'] else ''}"
 IMAGE_TEMPLATE_FILES:swu =3D "${SWU_DESCRIPTION_FILE}.tmpl"
-IMAGE_TEMPLATE_FILES:swu +=3D "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
+IMAGE_TEMPLATE_FILES:swu +=3D "${'${SWU_DESCRIPITION_FILE_BOOTLOADER}.tm=
pl' \
+    if d.getVar('SWU_BOOTLOADER') not in ['', 'none'] else ''}"
 IMAGE_TEMPLATE_VARS:swu =3D " \
     SWU_ROOTFS_ARTIFACT_NAME \
     TARGET_IMAGE_UUID \
@@ -192,7 +194,9 @@ FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-core}/rec=
ipes-core/images/swu"
=20
 do_image_swu[depends] +=3D "${PN}:do_transform_template"
 do_image_swu[stamp-extra-info] =3D "${DISTRO}-${MACHINE}"
-do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-${SWU_BOOTLO=
ADER}"
+do_image_swu[cleandirs] +=3D "${WORKDIR}/swu"
+do_image_swu[cleandirs] +=3D "${@'${WORKDIR}/swu-${SWU_BOOTLOADER}' \
+    if d.getVar('SWU_BOOTLOADER') not in ['', 'none'] else ''}"
 do_image_swu[prefuncs] =3D "do_extend_sw_description"
 IMAGE_CMD:swu() {
     rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FILE}'*.swu
--=20
2.45.2


