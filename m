Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7483C41535
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.13110.1664902102058405291
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=ZzWreBEN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-20221004164820b112cffe4df454d719-hez_yi@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20221004164820b112cffe4df454d719
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=a7Poz7PjJOZqtzT4xADTQYXerEeYKBDnfZp3qoa65S8=;
 b=ZzWreBENta+Gp7uagx6UrSEgBIeGCGkELeAhnsrKJp8IougzWwZl74MVweSba/AEhqfWcd
 ieKW4fy1XwF8x7hhwycaIDniYNDuiuz+oxiBervz0rEKDYJF1fewpphMwTRzQhgOvxY1dDMG
 Jz1RH6BW5omdKsVON3JQ9lQ5upz6Q=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 03/12] Kconfig: Hide kernel 4.4 for arm64
 targets
Date: Tue,  4 Oct 2022 18:48:09 +0200
Message-Id: 
 <a5042bd4ebe5ddae144b95762dd5f1c09a202de1.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9627

From: Jan Kiszka <jan.kiszka@siemens.com>

CIP kernel 4.4 does not officially support the arm64 architecture.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 561bd9a8..45637de8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -83,6 +83,7 @@ choice
 
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
+	depends on !ARCH_ARM64
 
 config KERNEL_4_19
 	bool "Kernel 4.19.x-cip"
-- 
2.35.3


