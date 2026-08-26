Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7372C61DCD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:11 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15102.1787757660641957838
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 08:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=G05o24q+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-202608261520586ff59a079d000207a5-nz9alk@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202608261520586ff59a079d000207a5
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 17:20:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NiB+baLu32pxr+4xDsUUFOc/SAqKL2A8W8bu4UHLF1o=;
 b=G05o24q+YHvBb6H0GKxyKiNoz/nB16isMevy1JdJw+w7nbm2CISS8B2RvlXuC5KKcvHVDz
 MsY29ioeCSGrjC6F3epM+8I5Efp7ne5RoKtT5/RcYxik2ORBS2QZZOM1egqRhujfkz+u069/
 pObNmWLmt63DR//SF7puwz/zcDD6ENXre/FcgjhFsC9p2oW3gi95VIGSDuEQdOYyjM7nj00y
 AMLEZEddcF/U/B3goDq3qFpVJbUk692wIHABZD9qPqcQz6UXVE+BnYhVL9NQ6vhyiEAWPWdH
 mW4nIAf2m8J6/d1+CZ5czoDs0PUBFh3r8y8Pv83sZGtlouvcwo9zHdLQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 5/7] u-boot: Refactor ftpm-stmm.cfg to enable measured boot for all
Date: Wed, 26 Aug 2026 17:20:53 +0200
Message-ID: <c3c5cc14cad35b24f59707758622ce8e77d91b89.1787757655.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787757655.git.jan.kiszka@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:21:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24024

From: Jan Kiszka <jan.kiszka@siemens.com>

Move the common bits out the ti-extra.cfg into the shared ftpm-stmm.cfg
which is consumed by the am62px unconditionally. Any commands, though,
should be selected at board level because they are not needed for the
fTPM and StMM functionalities.

While at it, fix the header of the ti-extra.cfg so that its bits get
removed before being re-applied.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/ftpm-stmm.cfg  | 7 ++++++-
 recipes-bsp/u-boot/files/qemu-extra.cfg | 2 ++
 recipes-bsp/u-boot/files/ti-extra.cfg   | 8 +-------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/recipes-bsp/u-boot/files/ftpm-stmm.cfg b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
index a6fe2a38..21032d12 100644
--- a/recipes-bsp/u-boot/files/ftpm-stmm.cfg
+++ b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
@@ -4,5 +4,10 @@
 ### Enable OPTEE, fTPM and StMM
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_OPTEE_SERVICE_DISCOVERY=y
 CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_TPM=y
+CONFIG_TPM_V2=y
+CONFIG_TPM2_FTPM_TEE=y
+CONFIG_MEASURED_BOOT=y
+CONFIG_EFI_TCG2_PROTOCOL=y
diff --git a/recipes-bsp/u-boot/files/qemu-extra.cfg b/recipes-bsp/u-boot/files/qemu-extra.cfg
index 5380ad83..867cafac 100644
--- a/recipes-bsp/u-boot/files/qemu-extra.cfg
+++ b/recipes-bsp/u-boot/files/qemu-extra.cfg
@@ -10,3 +10,5 @@ CONFIG_MMC_SDHCI=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MMC_REG=y
 CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_CMD_TPM=y
diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
index 9500055f..38d12dd0 100644
--- a/recipes-bsp/u-boot/files/ti-extra.cfg
+++ b/recipes-bsp/u-boot/files/ti-extra.cfg
@@ -1,17 +1,11 @@
 #
 # SPDX-License-Identifier: MIT
 #
-### FTPM + RPMB + StandaloneMM setup
-CONFIG_OPTEE_SERVICE_DISCOVERY=y
-CONFIG_TPM=y
-CONFIG_TPM_V2=y
+### TI extra config
 CONFIG_CMD_TPM=y
-CONFIG_TPM2_FTPM_TEE=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MEASURED_BOOT=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MMC_RPMB=y
-CONFIG_EFI_TCG2_PROTOCOL=n
 
 # workaround for v2025.07
 CONFIG_USB_STORAGE=y
-- 
2.47.3


