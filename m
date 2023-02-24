Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D64BC7EE23
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:28:41 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.22282.1677256116517469882
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 08:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SiDy8K2x;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-20230224162834352c86ddd391037ece-heltbz@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230224162834352c86ddd391037ece
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Feb 2023 17:28:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=eltllsOFwPoUHY2nn/Y6HC4Vt+r7Q0cWSnoUmgVqJ80=;
 b=SiDy8K2xj8nCLQ36hrG0xzhtFE8VkxhC9SXhlcxug9+2Zfxojc43BHXBR69VbfqohriQ5O
 7+uT6+VzY7f1ePngxgRlT5tKIh76HlbswnG3ZGPUoeQZmtgWI3DnByG/M5LLTymU+ZnfM3in
 j2vUdnnPfan2xalBjNt3KNm6QpH/0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 3/8] KConfig: add tpm option
Date: Fri, 24 Feb 2023 17:28:27 +0100
Message-Id: <20230224162832.327030-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 16:28:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10817

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Kconfig b/Kconfig
index cd24ce2..b8fa16a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -189,4 +189,12 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
 	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
 	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
 
+config IMAGE_TPM2_ENCRYPTION
+	bool "Encrypt partitions on first boot with TPM2"
+	depends on TARGET_QEMU_AMD64
+
+config KAS_INCLUDE_TPM2_ENCRYPTION
+	string
+	default "kas/opt/tpm.yml" if IMAGE_TPM2_ENCRYPTION
+
 endif
-- 
2.39.1


