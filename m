Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E417C8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 09:16:28 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.55699.1751879784440952016
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Jul 2025 02:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=NL6mfAIg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20250707091621eed4b458c167699c1f-wa7hjz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250707091621eed4b458c167699c1f
        for <cip-dev@lists.cip-project.org>;
        Mon, 07 Jul 2025 11:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xFsXk8q7ET2SJ+mCrMGUcdDjs5ubbAfbUe8bfABbu9I=;
 b=NL6mfAIghNEsE8ZXYVVOpoyDOFsRXchlN9sVUhHiMBe12XI+S2N8ykL7Wc1bIyFPXcozg7
 icoPkYq4QQjlxeeXWmrHghMo0CsdxaHo90QvFrz6jfVBp25Jt/YtaL52NCYOOfXDeke0iJge
 wijZTSKDqg1bKTjgCE1hGRmHSKsJsztFxwx274/q/n32lZSFP3LKd7sllNzefsN+7RI9yewu
 JnAbi/rXMYkJO92NwPEcIB1+/wmtA86nx9XcE1LkhkLo1zwDMGKxWYRGEuJS4AoNQEPZmSyH
 rybVXm/ALbP5E9oqm1z81GHIxEyfq1qBQE16isao7fSxSDBEieAyBBTw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Heinisch Alexander <alexander.heinisch@siemens.com>,
	Cetin Gokhan <gokhan.cetin@siemens.com>
Subject: [isar-cip-core][PATCH v9 2/8] initramfs-crypt-hook: Drop redundant copy-execs for systemd-cryptenroll
Date: Mon,  7 Jul 2025 11:16:14 +0200
Message-ID: <f82ea8750b83f2d92c1cbcd1041e8825f83a4b6b.1751879779.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19378

From: Jan Kiszka <jan.kiszka@siemens.com>

Both are already unconditionally copied, except for buster, but that
release didn't support systemd-cryptenroll.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb           | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
index 6815476a..5073af47 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
@@ -52,8 +52,7 @@ HOOK_COPY_EXECS:append:clevis = " \
     tpm2_createprimary tpm2_unseal tpm2_create tpm2_load tpm2_createpolicy \
     bash luksmeta jose sed tail sort rm mktemp pwmake file"
 HOOK_COPY_EXECS:append:systemd = " \
-    systemd-cryptenroll tpm2_pcrread tpm2_testparms \
-    /usr/lib/systemd/systemd-cryptsetup \
+    systemd-cryptenroll /usr/lib/systemd/systemd-cryptsetup \
     /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so"
 
 HOOK_COPY_EXECS:append:buster = " cryptsetup-reencrypt tpm2_pcrlist"
-- 
2.43.0


