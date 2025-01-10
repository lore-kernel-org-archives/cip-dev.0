Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F608E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 15:45:10 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.21822.1736523901367173664
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 07:45:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SIj7jB/Y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2025011015445868c5ed78cff7384f69-d0vbjd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025011015445868c5ed78cff7384f69
        for <cip-dev@lists.cip-project.org>;
        Fri, 10 Jan 2025 16:44:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=mNc8W4aNVzZmta7b5UehyE3tdh27wtF5mpPlpCZsC2s=;
 b=SIj7jB/YsVPBsYEvJrWDqBZiI/ofW1AfAspPgOa64lFcsh283bAesfV0jp9VJDy7a7EP8X
 Fr2mHWsCisVtcPwqQb8q8yTDE1Sn4QreH/fdpecC/FyX/om2DacppFu9Kn6P5XtCXvDgSvlT
 q3iJZwC/8QCGQPnsRLv3ICb/IR1lu5kWMs3YJ82sG/RFGwQznrUzS0Ji7uuY9Uf0TR00cwKM
 V26PgTG8CQJzQ1QN30BxSuL3Q7FobvsnHEEDRxic4pPxnOVffRbBkpfDZJV0ydLbfIGOtxt/
 oYf22udi1IihIuUuopqcpVKSOsMbzqBXq1jfwJG4nZnfy/XgAVlUqSvA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-overlay: fix missing scriptpreq
Date: Fri, 10 Jan 2025 16:44:38 +0100
Message-ID: <20250110154457.83539-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 15:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17524

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

During testing with LAVA it was detect that the overlays are not
mount on real hardware if the image is booted a second time.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
index 56ae8d2..4e2e292 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
@@ -45,6 +45,8 @@ DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
 HOOK_ADD_MODULES = "overlay"
 HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
 
+SCRIPT_PREREQ="crypt"
+
 do_install:append() {
     install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
         "${D}/usr/share/initramfs-tools/scripts"
-- 
2.46.1


