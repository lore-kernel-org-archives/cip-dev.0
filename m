Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45646C54E67
	for <webhook@archiver.kernel.org>; Fri, 15 Mar 2024 12:07:30 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.17791.1710496389521684357
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Mar 2024 02:53:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=JJYSsLd5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1324425-202403150953068982f82b96d9cbf615-q_4kjp@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202403150953068982f82b96d9cbf615
        for <cip-dev@lists.cip-project.org>;
        Fri, 15 Mar 2024 10:53:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vvFj8oxcxxFGg8vhBP9fPGbPu+6ldXx7z1f7dIw+DWU=;
 b=JJYSsLd5BsGzp7tVbjJBIVkCYOqmoBRgkFdxOspDC9nxrDjUL7DBVFFx2NLAyRp8BBnARb
 45CzlXa1ZH9OtA8J36dJVKIhaR9mFkoHC6hFKJi04iT8RWRuCXnV4A+7Bru7fBykh+hx1jUq
 u9b6/yYzh4MJt9uPTw+xD6xqQSxDE=;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [PATCH][isar-cip-core] recipes-initramfs/initramfs-crypt-hook: remove unwanted directory
Date: Fri, 15 Mar 2024 15:22:46 +0530
Message-Id: <20240315095246.275065-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Mar 2024 12:07:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15325

From: Srinuvasan A <srinuvasan.a@siemens.com>

We are not installing any file under "${D}/usr/lib/encrypt_partition",
hence removed from the do_install[cleandirs] part.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
index 3b2e6fa..b275c0f 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
@@ -48,8 +48,8 @@ TEMPLATE_FILES = "encrypt_partition.env.tmpl"
 do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/hooks \
     ${D}/usr/share/encrypt_partition \
-    ${D}/usr/share/initramfs-tools/scripts/local-bottom \
-    ${D}/usr/lib/encrypt_partition"
+    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
+
 do_install() {
     install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
     install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \
-- 
2.34.1


