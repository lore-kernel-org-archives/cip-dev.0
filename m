Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB0C02194
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.12051.1738229961322340300
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=c0Y+mffg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2025013009391956bfd84c826c0c5d27-33pfd9@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025013009391956bfd84c826c0c5d27
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ltHAnYwW3sA1PbZeRTSKGyuzoJMJW6CWeBEmgkSfAro=;
 b=c0Y+mffgHRK9ehThc8GoqjtI5AeI5RnsL6bmNxixEoTfeNuH7RS0bXlwYM1FKMcUaYsUYV
 R76MQslx4xA9K8ErKqneVaYBioo4Z7bRmBzrolGvn1xr6uTwbFmNQe29WdnbMKVV0p3nWEPv
 ZXg8cXQCpxG3t+iykbKU5US1pOA38xbXu/oogMn5rsICqiBDgCCs9Gq2I5uIdiEriE6/4d4g
 cQ0Iqm8oSKY8oog3xZ+h2Jvi3cceg9oYKSVfbuGak2pNuSjkY3e0kHqBvm8fyPZWkdFen3Ig
 JIicPDSNqPLLzeh5SxrIWBw3o3vldJUYK5XYVG7RzFHQUQQKxGGi5MAw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 07/10] initramfs-overlay-hook: Bump revision
Date: Thu, 30 Jan 2025 10:39:14 +0100
Message-ID: <83064498bbc4000dbbdc43a7d4e71f693c4f294d.1738229957.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17704

From: Jan Kiszka <jan.kiszka@siemens.com>

We changed the recipe in the last commits, acknowledge that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...nitramfs-overlay-hook_0.2.bb => initramfs-overlay-hook_0.3.bb} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-initramfs/initramfs-overlay-hook/{initramfs-overlay-hook_0.2.bb => initramfs-overlay-hook_0.3.bb} (100%)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
similarity index 100%
rename from recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
rename to recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
-- 
2.43.0


