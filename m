Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E6AD5B172
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 06:26:42 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42270.1765779992287626968
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 22:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=jS3mclG1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-202512150626290bd7a7351800020753-1ed_5i@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202512150626290bd7a7351800020753
        for <cip-dev@lists.cip-project.org>;
        Mon, 15 Dec 2025 07:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+QhQdffvhAKxxCoYBOCq9X0VlFCfZWF3kLFUPwTVMuo=;
 b=jS3mclG1SPmV69cw6wYPyhVXGYrDZN3mU5EZWaMpgVa0bpSp9gYwlxy0cyutbfnBLvcBF+
 8lvWW1Q2N3Hu6AAJAB8V/rc0WYZDI0oNXPEWnX2WSS/VtYgA8OK30NM+A7sh4BDc4UDvPTVI
 qdiM+UdWpHxeN0HewME6KTleYOSjjPHBJG+Klzx14i9ALmNHTmuemZEHSSu9TaIdYGkDBXGp
 +r61aHoJIppjKVmqIe0Inligst4gXmr8mS6F9p+znbndiKtreUl58fWDIQs3srqHnlArMcZz
 Im1WSaJYGjKhqVURP5OSfu/zWoHQwHLByXCLdOuQRnL7QVNqp0w95WsA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/4] swupdate: Drop redundant template class inheritance
Date: Mon, 15 Dec 2025 07:26:25 +0100
Message-ID: <36c4b2e9ec0fbc660c55d421eddad6df4b19899f.1765779987.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765779987.git.jan.kiszka@siemens.com>
References: <cover.1765779987.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 06:26:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21029

From: Jan Kiszka <jan.kiszka@siemens.com>

This is pulled by the INHERIT'ed base class already. Upstream isar
migrated it to classes-global, and bitbake will no longer find it when
trying to inherit it directly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/swupdate.bbclass | 2 --
 1 file changed, 2 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 64ae58ae..21d881d6 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -10,8 +10,6 @@
 #
 # SPDX-License-Identifier: MIT
 
-inherit template
-
 RO_ROOTFS_TYPE ??= "squashfs"
 SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
 SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
-- 
2.51.0


