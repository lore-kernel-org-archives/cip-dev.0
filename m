Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127DBC54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 11:03:24 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.19722.1709636595644170336
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 03:03:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qF4Bmsje;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20240305110312b230621281171d66d1-3dfqbb@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240305110312b230621281171d66d1
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 12:03:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=IpKQdYiT4JWOQuVEpHZfqCJaRO2XpZXV4eGeeGhrp1c=;
 b=qF4Bmsjezic2IUbKYJ7MfZR/35fOGZ6ZOl8DL1zJ1obcvYamPDTC3nB6H5BkNDvkit054I
 goKebytrgwfdhBWbUylVs0mnZvv4EoH7aDWFeDubFt4ztx7LNc/R8zvVvT+f9kGw+kDMz3jG
 dUOOeNELfWAFj+KkMUvybyP+P9F+w=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/4] sign-swu-cms: check if key and cert are valid
Date: Tue,  5 Mar 2024 12:02:44 +0100
Message-ID: <20240305110311.2073425-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 11:03:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15218

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids a broken update binary.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-certificates/files/sign-swu-cms  | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-cms b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
index 7bd04ef..d844e01 100644
--- a/recipes-devtools/swupdate-certificates/files/sign-swu-cms
+++ b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
@@ -1,9 +1,34 @@
 #!/bin/sh
 in_file=$1
 out_file=$2
+inkey="/usr/share/swupdate-signing/swupdate-sign.key"
+cert="/usr/share/swupdate-signing/swupdate-sign.crt"
+
+error_msg() {
+	echo "$1" 1>&2
+	exit 1
+}
+
+if ! openssl rsa -check -noout -in "$inkey"; then
+	error_msg "key '$inkey' is not a rsa key "
+fi
+
+# if openssl > 3.0 we have the x509 check option
+if openssl version | grep -q "3.[0-9].[0-9]"; then
+	if ! openssl x509 -check -noout -in "$cert"; then
+		error_msg  "certificate '$cert' is not a certificate"
+	fi
+fi
+
+key_md5=$(openssl rsa -modulus -noout -in "$inkey" | openssl md5)
+cert_md5=$(openssl x509 -modulus -noout -in "$cert" | openssl md5)
+if [ "$key_md5" != "$cert_md5" ]; then
+	error_msg "key '$inkey' does not match certificate '$cert' "
+fi
+
 openssl cms \
 	-sign -in "$in_file" \
 	-out "$out_file" \
-	-signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
-	-inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
+	-signer "$cert" \
+	-inkey "$inkey" \
 	-outform DER -noattr -binary
-- 
2.43.0


