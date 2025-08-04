Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED06C87FDA
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 05:04:02 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.9480.1754275126665276534
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 Aug 2025 19:38:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=huaqian.li@siemens.com header.s=fm2 header.b=SYskjuio;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-959203-2025080402283625326bdb125c5100bc-dj93p1@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025080402283625326bdb125c5100bc
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 Aug 2025 04:28:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=zcyNHItROUPy5UZT6VfsXPprSw87fb5CZyrVaAMwSiw=;
 b=SYskjuio+aj/sDGxSkYM4w7ubeAh4Uu+RZYOXgZduuHvmBdlcOwc1knO3mMR1mPqSxKvxK
 W/Z+45Hl9XoDqI+qb+yjC3pu6iCrXFp+f6kGxYJh1A34DZMYuZQn9DUzkUYWN0UXYNMwv8Lq
 gClzMNXxV35iWrwtOmaMPtguF4tNO7n9UG5ijze9h4UDIfPxDXE8btySx0PhdavWdCNctXng
 08jA528O2m5/t2bhvuigXlLDPwXr2xqw+kqWeIcxF+x8BxMiiecU1DrNmAvyqFtnTGNYw3YC
 z9l4OR35GInI3OjM7xdjTAfXyEzZhcHpha6zG293OuWUYaVq6srykimA==;
From: huaqian.li@siemens.com
To: cip-dev@lists.cip-project.org
Cc: baocheng.su@siemens.com,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com
Subject: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Bump to 202505 and refresh crypto dependencies
Date: Mon,  4 Aug 2025 10:28:19 +0800
Message-Id: <20250804022819.136786-1-huaqian.li@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Aug 2025 05:04:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19656

From: Li Hua Qian <huaqian.li@siemens.com>

Sync with latest upstream, requiring OpenSSL 3.4.1, MbedTLS 3.3.0, and
libspdm 3.6.0 per EDK2/edk2-platforms dependencies. Also pick the latest
brotli release with edk2 submodules.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 ...05.bb => edk2-standalonemm-rpmb_202505.bb} | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)
 rename recipes-bsp/edk2/{edk2-standalonemm-rpmb_202305.bb => edk2-standalonemm-rpmb_202505.bb} (62%)

diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
similarity index 62%
rename from recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
rename to recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
index 01dcbf9..4f80cc7 100644
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202305.bb
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202505.bb
@@ -1,11 +1,12 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2023
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Sven Schultschik <sven.schultschik@siemens.com>
 #  Jan Kiszka <jan.kiszka@siemens.com>
+#  Li Hua Qian <huaqian.li@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -21,22 +22,29 @@ SRC_URI = " \
     https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;subdir=${S} \
     https://github.com/MIPI-Alliance/public-mipi-sys-t/archive/${SRCREV-mipisyst}.tar.gz;name=mipisyst;subdir=${S} \
     https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S} \
+    https://github.com/Mbed-TLS/mbedtls/archive/${PV-mbedtls}.tar.gz;name=mbedtls;subdir=${S} \
+    https://github.com/DMTF/libspdm/archive/refs/tags/${PV-libspdm}.tar.gz;name=libspdm;subdir=${S} \
     file://rules \
     "
-SRC_URI[sha256sum] = "5f6c18cf1068089d669fbe81dab2325f8bf7b1298b192c276490b65e2edbbd94"
-SRC_URI[edk2-platforms.sha256sum] = "31257160ac51a4a5f63db92d26482d6a005286ed040dafe89d01f0ee906b111e"
-SRC_URI[brotli.sha256sum] = "6d6cacce05086b7debe75127415ff9c3661849f564fe2f5f3b0383d48aa4ed77"
+SRC_URI[sha256sum] = "5f2b5e3a267230f82e4566592fd0bfac5e205ad90520b2c9bf80f575293b7015"
+SRC_URI[edk2-platforms.sha256sum] = "0a266a61732d8dbb95bd2a4c0bf64a91965728b9fcd567af6af0894f23da0f97"
+SRC_URI[brotli.sha256sum] = "aaa739962a45b508b2e783b915e6b2b57ed3b12bd4b0feac73acfb144dffa54f"
 SRC_URI[mipisyst.sha256sum] = "9fda3b9a78343ab2be6f06ce6396536e7e065abac29b47c8eb2e42cbb4c4f00b"
-SRC_URI[openssl.sha256sum] = "b1270f044e36452e15d1f2e18b702691a240b0445080282f2c7daaea8704ec5e"
+SRC_URI[openssl.sha256sum] = "d4b22527a645acf76b53e44487a8db687c6eed621d7246891d025e38ba8c9651"
+SRC_URI[mbedtls.sha256sum] = "a22ff38512697b9cd8472faa2ea2d35e320657f6d268def3a64765548b81c3ec"
+SRC_URI[libspdm.sha256sum] = "dfadf501d23c26041c921974971953a1d4a250ed6cd2679facb781471a5f944c"
 
 # according to edk2 submodules
-SRCREV-brotli = "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
+SRCREV-brotli = "ed738e842d2fbdf2d6459e39267a633c4a9b2f5d"
 SRCREV-mipisyst = "370b5944c046bab043dd8b133727b2135af7747a"
 
 # revision closest to edk2 release
-SRCREV-edk2-platforms = "b71f2bda9e4fc183068eef5d1d90a631181a2506"
+SRCREV-edk2-platforms = "cf63a7257a0a12044b4530904835427813855f4f"
+
+PV-openssl = "openssl-3.4.1"
+PV-mbedtls = "mbedtls-3.3.0"
+PV-libspdm = "3.6.0"
 
-PV-openssl = "OpenSSL_1_1_1t"
 
 DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-dev:native"
 
@@ -61,6 +69,12 @@ do_prepare_build() {
     rm -rf ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
     ln -s ../../../../openssl-${PV-openssl} ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
 
+    rm -rf ${S}/edk2/CryptoPkg/Library/MbedTlsLib/mbedtls
+    ln -s ../../../../mbedtls-${PV-mbedtls} ${S}/edk2/CryptoPkg/Library/MbedTlsLib/mbedtls
+
+    rm -rf ${S}/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm
+    ln -s ../../../../libspdm-${PV-libspdm} ${S}/edk2/SecurityPkg/DeviceSecurity/SpdmLib/libspdm
+
     echo "Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd /usr/lib/edk2/" > \
         ${S}/debian/edk2-standalonemm-rpmb.install
 }
-- 
2.34.1


