Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20253C3DA7F
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 15:17:18 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.10495.1722871031525274673
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 08:17:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=hkHSFag5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240805151707733cbb7622aad53158-naoolw@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240805151707733cbb7622aad53158
        for <cip-dev@lists.cip-project.org>;
        Mon, 05 Aug 2024 17:17:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=U8VzPyod95k8K7EveRQHv4WfqNDIdV20hZUf7N/rgGk=;
 b=hkHSFag5YKbxkJJNFFgPe5CltvwMN9C0SiC/tPRCNOeE7JQnkUe/XxvJmKKtFDItBsbHzj
 2gh/rru1flQZ+vKRy+GDVFrBwJhYRuCpKm0Haz2DV6x+oTL7eF/Wlg+E4Xf54Y0tLkr0byd8
 6ZACPJ4mrj2PvmooSSuZ5pStAagAbMnzsrE6z6pEN9R8TRszEFzOS83gZrQ50/ZIuK7GIR4n
 96zoqLGylipgtuQc8LVoHEPBVECJJ7JXlO1nNXF9lez4GdtKtgT25rwl/+KdsAH9OFhzYqs/
 WOPc7xb9wOQNJS+TNH7i8eoe1xJE68goGrcsTjKzieaaA1tVdsxPVGYA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] fix: initramfs-abrootfs-hook correct install dependencies
Date: Mon,  5 Aug 2024 17:17:01 +0200
Message-ID: <20240805151706.778686-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 15:17:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16720

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes a regression introduced with
b16c77c77761896e42fa4d2f9738f20c24e80d03 (classes, recipes-initramfs: remove do prefix for adding task)

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
index 17c60da..fb27f94 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
@@ -26,7 +26,7 @@ IMAGE_FULLNAME ??= "${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
 
 IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
 
-do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:do_generate_image_uuid"
+do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:generate_image_uuid"
 do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/hooks \
     ${D}/usr/share/abrootfs \
-- 
2.43.0


