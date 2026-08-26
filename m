Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E54C61DC6
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 05:42:07 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6178.1787722924430564758
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 22:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=lUZ1S4J8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202608260542018de93167c400020793-9r_hv6@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202608260542018de93167c400020793
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 07:42:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FX7rg4T80lsz0qEKmkuu4vTM2fvrgFxqs/6u/gPqWKU=;
 b=lUZ1S4J8xrnIjsSOOQYdX1bIA4pmJS8BGw58mI4Ukz3166fPfOCS4hDCT7N4Vx3fertkKR
 eka7qPcT1Wa51cIOJ9sbs54IeTiN5Cn+Fj15bRm3famecHTyFwhcmV4tBuajDRK9Dnb6UnOv
 H/+oIVFTE7LXdhP1P0dNJ65hFmau8SbsdOnhKpWyejbiT6nrRmwqEpjv3Mz+U8PDp7pOcJt4
 vm02bYZu7i2bSTUlxvGeh+AiUTw/Guvcrxxsx2vL2OxDMHPTgChNq3O+yv22RUMcbA4BvnaX
 l7jFjlD99n5wyhlO2DhOqOl2d3ZOSt2DLFeE+9Rw3+IE/OlCxJIYFLdg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 1/7] secure-boot-efi-keys: Add recipe to create EFI keys
Date: Wed, 26 Aug 2026 07:41:39 +0200
Message-ID: <97dc63827a8f33a225a39b3884afd6e6933c048b.1787722904.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24012

From: Jan Kiszka <jan.kiszka@siemens.com>

This recipe allows to derive the PK, KEK and db values from a single
signing key as we are using for demonstration/testing purposes and
simple scenarios. The recipe provides abstract "secure-boot-efi-keys"
which could also be offered by an alternative recipe/package that picks
up differently generated keys and/or a proper key hierarchy.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../single-key-to-efi-keys_0.1.bb             | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb

diff --git a/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb
new file mode 100644
index 00000000..cfa48b7f
--- /dev/null
+++ b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.bb
@@ -0,0 +1,41 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
+DESCRIPTION = "Generate EFI keys from single secure boot key"
+
+PROVIDES += "secure-boot-efi-keys"
+DEBIAN_PROVIDES = "secure-boot-efi-keys"
+
+DEPENDS = "secure-boot-secrets"
+DEBIAN_BUILD_DEPENDS .= ", secure-boot-secrets, efitools"
+
+do_prepare_build() {
+    deb_debianize
+
+    cat <<EOF > ${S}/debian/${BPN}.install
+db.auth usr/share/secure-boot-efi-keys
+KEK.auth usr/share/secure-boot-efi-keys
+PK.auth usr/share/secure-boot-efi-keys
+EOF
+
+    cat <<EOF >> ${S}/debian/rules
+
+override_dh_auto_build:
+	cert-to-efi-sig-list /usr/share/secure-boot-secrets/secure-boot.pem PK.esl
+	sign-efi-sig-list -k /usr/share/secure-boot-secrets/secure-boot.key \
+	    -c /usr/share/secure-boot-secrets/secure-boot.pem PK PK.esl PK.auth
+	cp PK.auth KEK.auth
+	cp PK.auth db.auth
+EOF
+}
-- 
2.47.3


