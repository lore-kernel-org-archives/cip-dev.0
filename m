Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472FE73166
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51898.1770037072080675972
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=LE3r4c5K;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-202602021257490604a7fbcb000207d3-rfjfrg@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202602021257490604a7fbcb000207d3
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=SUTmZnZwPlKpibre7m8wnVtguuu6E1L6EviarD9V9mk=;
 b=LE3r4c5Kw12Z14TsMcsoCYq1AdPCwbuLlbbHM46qX280ujKnBjb3aE2bHvlHfA3KwR7Y+v
 7uQqSaHHbvNHe2VI3Ji0+KjDUVS1TtP4vZXVPvKTBnCmvSB4wgcVULWYjc6pCwGfkUM5vBKr
 hpa02Kb4TkO/+KvYEslQxSxt8P1YfaB616RHOcObIyZnEKFfIUlK3eK84vdb+UufcXP93iTF
 0XA6r1tWSyi5vV/AvH/xgAtBVwb9rqrKxpwZv+vytNhZzLQVwVAIgwLHQyAcXPzZkfqLTLsZ
 dL0UZj2nyc8FdY4JLLz5Ougmi3pbHpQtoF8QfkeE201i3IrHzOscUPjA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/9] u-boot: Add U_BOOT_EXTRA_BUILDCMD to common rules.tmpl
Date: Mon,  2 Feb 2026 13:57:41 +0100
Message-ID: <03d818137b9923826170a993ea9e7bbab01e9153.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21801

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows custom post-processing steps without having to fork the
rules.tmpl file.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/rules.tmpl          | 1 +
 recipes-bsp/u-boot/u-boot-common-2025.07.inc | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/recipes-bsp/u-boot/files/rules.tmpl b/recipes-bsp/u-boot/files/rules.tmpl
index bbf7bb5a..560a6540 100755
--- a/recipes-bsp/u-boot/files/rules.tmpl
+++ b/recipes-bsp/u-boot/files/rules.tmpl
@@ -31,6 +31,7 @@ override_dh_auto_build:
 		./scripts/get_default_envs.sh >u-boot-initial-env; \
 	fi
 	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
+	${U_BOOT_EXTRA_BUILDCMD}
 
 override_dh_auto_install:
 	mv tools/env/lib.a tools/env/libubootenv.a
diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index ed44bad0..7d91a8d1 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -39,6 +39,10 @@ S = "${WORKDIR}/u-boot-${PV}"
 DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
     libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"
 
+U_BOOT_EXTRA_BUILDCMD ?= ""
+
+TEMPLATE_VARS += "U_BOOT_EXTRA_BUILDCMD"
+
 STATIC_KEYS_BUILD_DEPENDS = ", \
     openssl, efivar, secure-boot-secrets, python3-openssl:native"
 STATIC_KEYS_BUILD_DEPENDS:append:buster   = ", pesign"
-- 
2.51.0


