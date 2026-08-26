Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4DAC61DCD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 05:42:07 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6256.1787722925285401550
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 22:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=S3pdI0ru;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-20260826054203af1629aa8a00020716-ipj5sv@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260826054203af1629aa8a00020716
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 07:42:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5ZjtnmNWC/2RXXCg2/P8LLKYwm4wuB3xFLVKuJLwhhc=;
 b=S3pdI0ru5MZz3pkSKZSVMA898ocKE3a5/URfoifxH0u6imNpCP6j+s7VFRJHr81Nyw9yS+
 uAX7uM9cz6DQdXIUBi7IsUdDpQVKAJeCCVLgoUeQa3PQPDgDI79fIGOgHxvSF8zGxXJrgUia
 L9MohpTsPg2vU4M2e5c09AFo4UbQ1PvnjjCith1h+ArXsjy/tMk/MQlx1pIrveQ56VkLn5pj
 KLaZrEfuANhCI8s0HnDnPa/TGwj/N8a6GgjIhzbR+LS/80D6OYC6vgJ2hI4kR+C89UamOv0F
 mGfIvSaFxV3IU7p+DE1nBPgnIwk1n0+l6R3WcCysS37tTRw8hIRNjzqw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 7/7] initramfs-crypt-hook: Prevent encryption without secure boot
Date: Wed, 26 Aug 2026 07:41:45 +0200
Message-ID: <eee0dd79f2b78a061ee9a097d68a9e27cc805731.1787722904.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787722904.git.jan.kiszka@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 05:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24007

From: Jan Kiszka <jan.kiszka@siemens.com>

We so far allowed to run first-boot encryption in any secure boot state.
This remained unnoticed because the QEMU x86 machine is started with
keys provisioned, and the QEMU arm64 machine does not support measured
boot yet. The latter is fixed, and we also deploy keys during first boot
now if they aren't pre-deployed. Time to raise the bar and reject
generally insecure states.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete             | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 7bc08e55..3312e632 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -297,6 +297,10 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 
+	if ! secure_boot_enabled; then
+		panic "Secure boot disabled! Must be enabled to ensure correct key sealing."
+	fi
+
 	# check if we are trying to mount root, set ROOT to decrypted partition:
 	if [ "$partition_mountpoint" = "/" ]; then
 		echo "ROOT=$decrypted_part" >/conf/param.conf
-- 
2.47.3


