Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF1EC19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 07:54:07 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.16887.1740604703397079588
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 13:18:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gokhan.cetin@siemens.com header.s=fm1 header.b=dtKg5Mda;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1328731-20250226211820c20fac2f847ea525b7-mdqysd@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250226211820c20fac2f847ea525b7
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Feb 2025 22:18:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gokhan.cetin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=e+6OmNuF8rDQu5ueGgRlrjIvXcdiznIlLPDcwZSB4L8=;
 b=dtKg5MdaYacl4ngqj3/iBfuNotAGmxXdedvbr3ugCao8jyst/KO+AZRFoc3x8RskDRVxtC
 u+on26QGzDm6dH1+G5cGLE+Fpq5unZdXrdmbpBoIbi9/Bp8or6cCF4vjd1AzNS+16VLqGrQ2
 yMgJ5pzc+MH+1qZXF28E4mq4x7O9KPiNvIat3SGIfhRIC9MUa3IMkld0yeXWCBGJBn4iW5I0
 rGzf3LghKWTI/n1uZM5/HS1JiVj434I4X9S8kOzpq7cUOytUfjiwlrIz4emtc3wuMO/zjh+y
 RTUWxCOOfFTeRADW9YlOHCf7KUqom2YCiq0yZB45oc5E+BCbkyOqWatw==;
From: Gokhan Cetin <gokhan.cetin@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: gokhan.cetin@siemens.com
Subject: [isar-cip-core][PATCH] initramfs-squashfs-hook: drop unused hook file
Date: Wed, 26 Feb 2025 22:18:03 +0100
Message-Id: <20250226211803.2915172-1-gokhan.cetin@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328731:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 07:54:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17982

Probably overlooked during the hook.inc conversion, 5ab2ad84.

Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
---
 .../files/squashfs.hook                       | 25 -------------------
 1 file changed, 25 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook

diff --git a/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook b/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
deleted file mode 100644
index 0b9b208..0000000
--- a/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Felix Moessbauer <felix.moessbauer@siemens.com>
-#
-
-PREREQ=""
-prereqs()
-{
-    echo "$PREREQ"
-}
-case $1 in
-prereqs)
-    prereqs
-    exit 0
-    ;;
-esac
-
-. /usr/share/initramfs-tools/hook-functions
-
-manual_add_modules squashfs
-- 
2.39.2


