Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C4CCF9EF
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:01 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.26401.1761549712892507465
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=H1ja7PBF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-2025102707214981445bfdbf000207b2-x8yr3v@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025102707214981445bfdbf000207b2
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=W1YuD7CuFVo4qx+WXAaxv+DA6NWfq2qQ6QafZH888nw=;
 b=H1ja7PBFw4U9pLrH98SPi4ro51pleT3NxqBHlGarL9jOWv5S8SJJFaOAxiK95G052cVasI
 cuEhcW/OA2qqRUB17cKfbXV4QNmjsZXfhq0kUK0I7k60JufMw744jpnB5v5puxYUFDAkBxsm
 6xUaj9+yEmNElGpwmx7NYE7sHic5AsDSjGJHWqiZCUWyBlfvWduzXK481WJGBz9k/yeD2JCS
 6uQflcakXyliASnBgQUX01DrVyLN+LPX93gZW9Fzsh08MxtrbG0agAxIXDfa1K/52ld9i1o/
 3ZfV7n9izcxykloPnvyJyFL5eJEORY8740rMJkIf9iZXb07dI0f+EjjA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 01/19] linux-cip: Update cip-kernel-config revision
Date: Mon, 27 Oct 2025 08:21:30 +0100
Message-ID: <261b53e7287ff226006bf2a30d519beb95d71ea3.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20222

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings the required config options for fTPM and StMM for QEMU ARM64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 7ffeb195..8baf79b8 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "60f3454fe50a2faead9fe5f156ed1f89bd0cd99d"
+SRCREV_cip-kernel-config ?= "64bb9beeef908c4f699e84d53bb72b6124cff492"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.51.0


