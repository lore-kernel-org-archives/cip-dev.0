Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CECBC83F07
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.55698.1751879784288500919
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=XDCVaDHc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-294854-202507070916216372be9d7f7ffdf270-lnhhda@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202507070916216372be9d7f7ffdf270
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ITHzYcNTUZrtyPMijkUNUYygZpWAN8qbbSMb3h/t028=;
 b=XDCVaDHc40N5J2RIM07U9iuf2m9gsGKfKBpps8wrAM4uNwHalF2UsPtws1fgA1FB5h1LRV
 ycmHdH+SS3dkW/QWxSHCvX0CTyi9DQHVYQiuZ024XrC6BNqeMaEFTr2LMZuSZ5t9b96iq5L+
 jVKwFBqRpAZpKGTN0CydOMRyjOmXuIbTsS2lVs/vDUXcfHEIAfnzu89rNUZpZFvis4Un0MGK
 BsGvOCOpKjl9Q+nyiSwvedUhS7/eyaHadN2Ib1xbV3M3j0FjGJ67SWC2Co6gsJM8Fl3V3uw9
 teX2Wq7+4aryKeGJotVUB/oq+tVPUnX6SxVWXjllc0g620d1sqHUb56w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 3/8] initramfs-crypt-hook: Only use resource-managed TPM instances
Date: Mon,  7 Jul 2025 11:16:15 +0200
Message-ID: <038a70a9da5c9326b71658c521f0a5d9bd8995ae.1751879779.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1751879779.git.jan.kiszka@siemens.com>
References: <cover.1751879779.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 09:16:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19370

From: Jan Kiszka <jan.kiszka@siemens.com>

The resource manages is a precondition for our TPM usage. If we ever
picked an unmanaged instance, we would have failed. This didn't happen
so far as we currently select the last candidate from the list, and that
was a tpmrm device node.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 087da96e..c5d5b85a 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -188,7 +188,7 @@ expand_partition() {
 	log_end_msg
 }
 
-for candidate in /dev/tpm*; do
+for candidate in /dev/tpmrm*; do
 	if [ -x /usr/bin/tpm2_pcrread ]; then
 		if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet ; then
 			continue
-- 
2.43.0


