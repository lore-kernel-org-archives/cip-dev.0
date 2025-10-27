Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAAACCF9FC
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:02 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.26393.1761549712335410639
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=NkX3JjJU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-2025102707215097c56def930002075e-azvpuo@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025102707215097c56def930002075e
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=AlprCFsGjXuvLG0tD1zKSv9u4YHqZCH6PGv8f1GR0ss=;
 b=NkX3JjJU5sKdvEWZIix+1mSsNO6Qvz4FYagtmBFBBxHtyKyMZxsLJSBMJdA+IvrdB47EZh
 jKzpw/W5yQDdQi/YpymSJJxm7jCOFHm4LZhhxUC3LmEQ+0uwZsUu9E8jKGAj/XFi04pumTTc
 4W1x0/H+Ipv/i2e5fxU8Q33D7m5f26dv9Lyd9hIBPQRPmdfgLNHVJ/JEPmFzAG+g7eLTxFJq
 jMybFL1INi5asivSQh71Abu26Kuj7KA280+dvvye3blCzDBUi7bbPTMMY6RuxAO33d3pChHv
 4MeGVKlKA1XascyubDQahlpCi7IneDf+/O4r7WesMn6FLHZUYbb026oA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 09/19] u-boot: Prepare for different build dependency without built-in UEFI keys
Date: Mon, 27 Oct 2025 08:21:38 +0100
Message-ID: <97152226e787e66499f74aed97cd7f9e33a25f89.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20224

From: Jan Kiszka <jan.kiszka@siemens.com>

We will soon add StMM/RPMB-based UEFI key storage as an alternative to
static, built-in keys in U-Boot. Prepare for having different build
dependencies then.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/u-boot-common-2025.07.inc | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
index 5f8f9de9..f9dde598 100644
--- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -29,12 +29,18 @@ S = "${WORKDIR}/u-boot-${PV}"
 DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
     libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"
 
-DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
+STATIC_KEYS_BUILD_DEPENDS = ", \
     openssl, efivar, secure-boot-secrets, python3-openssl:native"
-DEBIAN_BUILD_DEPENDS:append:secureboot:buster   = ", pesign"
-DEBIAN_BUILD_DEPENDS:append:secureboot:bullseye = ", pesign"
-DEBIAN_BUILD_DEPENDS:append:secureboot:bookworm = ", pesign"
-DEPENDS:append:secureboot = " secure-boot-secrets"
+STATIC_KEYS_BUILD_DEPENDS:append:buster   = ", pesign"
+STATIC_KEYS_BUILD_DEPENDS:append:bullseye = ", pesign"
+STATIC_KEYS_BUILD_DEPENDS:append:bookworm = ", pesign"
+STATIC_KEYS_DEPENDS = "secure-boot-secrets"
+
+SECURE_BOOT_BUILD_DEPENDS = "${STATIC_KEYS_BUILD_DEPENDS}"
+SECURE_BOOT_DEPENDS = "${STATIC_KEYS_DEPENDS}"
+
+DEBIAN_BUILD_DEPENDS:append:secureboot = "${SECURE_BOOT_BUILD_DEPENDS}"
+DEPENDS:append:secureboot = "${SECURE_BOOT_DEPENDS}"
 
 do_prepare_build:append:secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
-- 
2.51.0


