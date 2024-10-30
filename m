Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E2D5CCA8
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 11:52:02 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.12872.1730289112353330534
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 04:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=QCXHi1/q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-20241030115149cedfeefedf6d9b0284-_e3mso@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241030115149cedfeefedf6d9b0284
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Oct 2024 12:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=K9nOK9xzQEq6avm0mlePSoGEWN4tgBKY5SOvbHXGsu4=;
 b=QCXHi1/q/VyWtiEJYbaJfRcVJ+dq5EyjFS1pJDnG/7gt+HtNDcxGphqBbN19DJBf3ODap9
 DnnHLqKdMbjtn5h1fuPPjJ/IuAUegesdqK7scHm68aie5s4at59IR95ZUAoNKP23WS/QICib
 rl3VPoQxBlCJYnyft+EV7OI6A0GJKwmkc1dgXvA/HCTnuZ16KZ3i55oUGOWIZOUJ+VhKRLp9
 xrH2171TSab/ZkKJnEThmbV+dL5lYcY5AMQTyMZmGipWQXqFGC/IU+Bx5SWlPdKkkQgjhSKp
 wZG/cWHaLs0OMAb/6QDfciVGdVIV0TcOr1UpL6M2RlG5Yg3wpGDDpO2Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 5/6] linux-cip: Update cip-kernel-config revision
Date: Wed, 30 Oct 2024 12:51:46 +0100
Message-ID: <90a003078be88c2b963a7ace4ad7841639c8effd.1730289107.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730289107.git.jan.kiszka@siemens.com>
References: <cover.1730289107.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 11:52:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17115

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings support for EROFS and PID namespaces for 6.1 and also fixes
Ethernet configuration on BeagleBone Black.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 9c1ab946..4e1cacc2 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,6 +14,6 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "f6b7018cb6845f34f8a03c126bf4f823ce10d637"
+SRCREV_cip-kernel-config ?= "c3c5f08d24dc05f7dd20d29d6337e00aad190093"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
-- 
2.43.0


