Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271BF8FA6B
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 12:14:04 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26013.1776773634356334720
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 05:13:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=sari.sercan@siemens.com header.s=fm2 header.b=MD3kPR+m;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1334722-202604211213514f69bdff59000207ed-_rqg12@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202604211213514f69bdff59000207ed
        for <cip-dev@lists.cip-project.org>;
        Tue, 21 Apr 2026 14:13:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=sari.sercan@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=z6YeocRK7lYUcVcY0uYULbap0oWC4rvYDdbuoGh9DYI=;
 b=MD3kPR+mjcTJwKe3pNF2cIGK1YgWe968ngSOcq2tVdF47YjKYWRNvoq6JdoJ0aDY0dWC8y
 kyknr3AXbwZZ+KdpXzwfncUJhmvYi9K1TleOyXlKOi6pN1OlqpC7c/hQef+AgS72Uho8GV9p
 20lkwne9X4Xh0aE4ebZ6RV5+p/slE53shknk3bmfkgFRwR0O1Ayh/18RR2t0pFoUi0G3BvEO
 1TMrf/YIXAzIEv5y3MrinbKJpR/yGbRBGf1XXT2sYT3M0mL145tfsezWytShMWU6ZDj6SM58
 hQsBLfdxDhjAC+Mfm8C18bCp9g9W7OJa78kNG1lDVBcSdMLNDR5Z93zw==;
From: Sercan Sari <sari.sercan@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sercan Sari <sari.sercan@siemens.com>
Subject: [isar-cip-core][PATCH] tpm2_functions: verify PCR bank output instead of relying on quiet mode
Date: Tue, 21 Apr 2026 14:13:44 +0200
Message-Id: <20260421121344.3747040-1-sari.sercan@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334722:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Apr 2026 12:14:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22774

tpm2_pcrread --quiet can return 0 when the configured PCR bank
is not usable on the device. This causes tpm2_check_device() 
to incorrectly select the TPM device, encryption failures 
when encryption is optional.

remove --quiet and verify actual PCR data is present in the output
via grep. If the bank is not available, the device is correctly
skipped and optional encryption exits gracefully.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
index 54d43f3..1c6bbff 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
+++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
@@ -11,7 +11,8 @@
 # SPDX-License-Identifier: MIT
 
 tpm2_check_device() {
-	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet 2>/dev/null &&
+	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 2>/dev/null \
+		| grep -qv "$pcr_bank_hash_type" &&
 		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/dev/null
 }
 
-- 
2.39.5


