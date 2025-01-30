Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1254C02195
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.12048.1738229961207974230
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=Bl8cGMG4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-2025013009391963dc9ffb9dfc62fcf0-mcvu7b@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025013009391963dc9ffb9dfc62fcf0
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y37RzRoqZk9vGn0adegaXIWrpep5ywtxMOkoowVlkS0=;
 b=Bl8cGMG4row6WmCan3w+TAZr9uShjzCeqqDZmHFNXmhHPuF6D82lRIpTE5HWhpLYwEypNA
 sZ57VpqzvT21jN5BTigvzJXQQPOuFgDewMxxLQ3B0cgFDH2qTdYMdv6jaGLzn1OeL34nqsVt
 F5XXUYKrr7dNTwwbVcK+uG4n25NqKUg7knPRvuqB/VOm/lUJRex1bMNPpagX9kyNSe2x2pWc
 z3ENKNq5T3TA7sKvz4WKx1WEhRhX6lTBia2GCZ89aJMJ7gBYb/zecKTyujMOtiHpf0UqaArl
 JBIJ35JhhikEs9Tz1oFThS4X6Uva7E1r5sd+TRBwzNO2dg4huvmPFcWg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 06/10] initramfs-overlay-hook: Add awareness for abvar hook
Date: Thu, 30 Jan 2025 10:39:13 +0100
Message-ID: <5dfbfd21727f454c63f2d144d75142815790742e.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17706

From: Jan Kiszka <jan.kiszka@siemens.com>

If the abvar hook is used to mount and manage snapshots for it, overlay
mounting has to wait for it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
index ec7f85b6..073fe070 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
@@ -47,7 +47,7 @@ DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
 HOOK_ADD_MODULES = "overlay"
 HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
 
-SCRIPT_PREREQ="crypt"
+SCRIPT_PREREQ = "crypt abvar"
 
 do_install:append() {
     install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
-- 
2.43.0


