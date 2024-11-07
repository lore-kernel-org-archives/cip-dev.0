Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB3AD44D56
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 10:58:14 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.69366.1730977084457909220
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 02:58:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=NXi/PeQz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20241107105802eb0e45a2ef92b204a0-tpq_oa@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241107105802eb0e45a2ef92b204a0
        for <cip-dev@lists.cip-project.org>;
        Thu, 07 Nov 2024 11:58:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n6CnCPfgnQRrnB/6l9D4yiBiORHq4ID2IdqxhmlC6LE=;
 b=NXi/PeQzE3CXaaqniJU4rjL4k1bzBOX3GxZiB8ZEzLq03DgwUkmT5lGYLAFvv3eII4PETK
 2uramHTrNPROMujfeYMvI5Y9hDlIWTg0a5R5z/55t4HB8G2X2e1pPNbx02b8Di8p1ywxaait
 bBfTCL2J/+u3IUejxiKl4iB3v7T+9/86Rwzjl9MJ1Wtvr+rkTkT4+34xfPX9p8iU7IUoQDWt
 rjDcPaSp0IMJ+++7Coi9u0xQQLFekiqIfn4ZnatPU73/VPMYp8aPzKFc26m/OxAZarrl2SqV
 TRwC3gwA47JisTnw/JE8UzkyjVnLOWXA29Knw6pc6FQroRs6SgMeuHgA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>,
	Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 4/9] u-boot: Use efisebdb with trixie for generating the UEFI key database
Date: Thu,  7 Nov 2024 11:57:52 +0100
Message-ID: <6d99a378b11f36b48bb236e45b6582d064eb1199.1730977077.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730977077.git.jan.kiszka@siemens.com>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 10:58:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17206

From: Jan Kiszka <jan.kiszka@siemens.com>

Latest peboot dropped efisiglist and points to efisebdb from the efivar
package instead. That requires us to specify a key owner GUID, and we
use a random one here for our demo purposes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/rules.tmpl          | 8 ++++++--
 recipes-bsp/u-boot/u-boot-common-2024.01.inc | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/recipes-bsp/u-boot/files/rules.tmpl b/recipes-bsp/u-boot/files/rules.tmpl
index c697cdb7..593919c3 100755
--- a/recipes-bsp/u-boot/files/rules.tmpl
+++ b/recipes-bsp/u-boot/files/rules.tmpl
@@ -1,6 +1,6 @@
 #!/usr/bin/make -f
 #
-# Copyright (c) Siemens AG, 2018-2022
+# Copyright (c) Siemens AG, 2018-2024
 #
 # SPDX-License-Identifier: MIT
 
@@ -13,7 +13,11 @@ override_dh_auto_build:
 	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
 		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out secure-boot.der -outform der; \
 		rm -f secure-boot.esl; \
-		efisiglist -a -c secure-boot.der -o secure-boot.esl; \
+		if [ -x /usr/bin/efisecdb ]; then \
+			efisecdb -g 32db313c-f7d4-42a6-9a49-e32870001c63 -a -c secure-boot.der -o secure-boot.esl; \
+		else \
+			efisiglist -a -c secure-boot.der -o secure-boot.esl; \
+		fi; \
 		rm -f ubootefi.var; \
 		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
 		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
diff --git a/recipes-bsp/u-boot/u-boot-common-2024.01.inc b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
index 69427322..5a020da2 100644
--- a/recipes-bsp/u-boot/u-boot-common-2024.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
@@ -24,7 +24,10 @@ S = "${WORKDIR}/u-boot-${PV}"
 DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}"
 
 DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
-    openssl, pesign, secure-boot-secrets, python3-openssl:native"
+    openssl, efivar, secure-boot-secrets, python3-openssl:native"
+DEBIAN_BUILD_DEPENDS:append:secureboot:buster   = ", pesign"
+DEBIAN_BUILD_DEPENDS:append:secureboot:bullseye = ", pesign"
+DEBIAN_BUILD_DEPENDS:append:secureboot:bookworm = ", pesign"
 DEPENDS:append:secureboot = " secure-boot-secrets"
 
 do_prepare_build:append:secureboot() {
-- 
2.43.0


