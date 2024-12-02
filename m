Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D7D7832E
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.174652.1733151094403796516
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=JDZD/Udc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-202412021451365c761ba1e9195c24ea-__8mqk@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202412021451365c761ba1e9195c24ea
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LraoXwwIuW3cEqjJ1FB6LxRBMGSBmp3xI1dspSBNw0M=;
 b=JDZD/UdcjeeihUVAffR+yrazOOEJNeeZPGQ4fC1ymyTJGXkMMLVzBfxocqXjcXb0eHOtF1
 n67Tl3eg4TF3tEdcEcr75Lmscyaz0WgGv1lMhKibQ9FSoN9vfGQfhuT8fXnGolrBC49UIzlo
 o4Y1x+O0CQkA7zbB12kPfgdlHgJnGxmTwYR2E8u+C6cI6VQNKEFNbd4UT7qXZzjohWB98zQi
 qAPaw9DK+saIzK6FdAJ8U8RLWDj50SZQ6GYmVdXPzeIuFRaAHWWKrp7VXIfv+BeR/zLnBWY3
 iydsSb3TGl9g0TfYNh3Km2Pq+Hq9EXPuDioDpxHeMb3GOXMZ+33q+hpg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 07/10] initramfs-verity-hook: Drop dead verity.conf-hook artifact
Date: Mon,  2 Dec 2024 15:51:10 +0100
Message-ID: <0b2d9912cdf106fb8655c9a8f3c30a9a3c2daf26.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17314

From: Jan Kiszka <jan.kiszka@siemens.com>

This was never used in fact.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-verity-hook/files/verity.conf-hook              | 1 -
 ...tramfs-verity-hook_0.1.bb => initramfs-verity-hook_0.2.bb} | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
 rename recipes-initramfs/initramfs-verity-hook/{initramfs-verity-hook_0.1.bb => initramfs-verity-hook_0.2.bb} (92%)

diff --git a/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook b/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
deleted file mode 100644
index 9b61fb85..00000000
--- a/recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
+++ /dev/null
@@ -1 +0,0 @@
-BUSYBOX=y
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
similarity index 92%
rename from recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
rename to recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
index a86e47df..6db4efcc 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
@@ -12,7 +12,6 @@
 inherit dpkg-raw
 
 SRC_URI += " \
-    file://verity.conf-hook \
     file://verity.hook \
     file://verity.script.tmpl \
     "
@@ -37,8 +36,7 @@ do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_image_verity"
 do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/hooks \
     ${D}/usr/share/verity-env \
-    ${D}/usr/share/initramfs-tools/scripts/local-top \
-    ${D}/usr/share/initramfs-tools/conf-hooks.d"
+    ${D}/usr/share/initramfs-tools/scripts/local-top"
 
 do_install() {
     # Insert the veritysetup commandline into the script
-- 
2.43.0


