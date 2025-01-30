Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6D9C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:29 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.12047.1738229961127205024
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=AOhLrm9E;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-202501300939182d8535175867336765-ycecnq@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202501300939182d8535175867336765
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7o/5aGfYbaMv+qJwnX2dKgSAgy9RXCG+q0RliYThbfQ=;
 b=AOhLrm9EaH1UTqXMoTm8xRfasf4n7dHl0b6ziCLvNosjt8lziwX5WlSDF+6o/CFmeZx6U8
 tVXXleUncDExG0h8WYJLwToUK5DpOv+behfYjzYG9fD1kQqtisYul9czQ4nGXmj7R/gffiO6
 kVuKIQPGPFv3nLKb1XId/nY06LMEWxAZSc3n5jHhEMm/uD7Dv+RJk45nh8hKn4GF3sQnlYN3
 QCPqFgI286HMLmg5Qw8V1/lNIjtlPFFswr6MYc1c3XnGc/RpyEH6B2Swui/ET1g3bSiv4cvR
 RqlC76AH0Vn5DHJzOYy5yzcFIdJYZL5UhQLXLfC8yiA8Qfi7wRfyR7Ig==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 02/10] initramfs-crypt-hook: Bump revision
Date: Thu, 30 Jan 2025 10:39:09 +0100
Message-ID: <e2f1d865a54b94a78415183102c8e77413c5381d.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17700

From: Jan Kiszka <jan.kiszka@siemens.com>

Recent commits modified the recipe in a way that justifies a bump.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{initramfs-crypt-hook_0.5.bb => initramfs-crypt-hook_0.6.bb}  | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.5.bb => initramfs-crypt-hook_0.6.bb} (100%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
similarity index 100%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
-- 
2.43.0


