Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C906ACA0EE4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 10:14:20 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.97380.1755080050989655999
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 03:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=AUaroxy+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20250813101406a6e0cf0bbe356ebdda-ooe8sy@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250813101406a6e0cf0bbe356ebdda
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Aug 2025 12:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mZTO/grZnHJpMDo+/DG4X0W0KzvRJ/ee+EVvAyDNCVs=;
 b=AUaroxy+1dvELXMoQLcOGn1bbxeYZJruzXK2GaIN044I6zR74JB8bc8IgA1dDeFZsIP8Zl
 5PSe/Be+ZOuNjrjcH9wB70gzkS81tXsL6sXSxzdWmMFfmZUEp98uicSHJfLBmR5ew4B2qjig
 1akOHGAMQOukylyPspyoWSqvOrUx8nH/renkrXpLh4n2PYw+3BWti4uXAhGY3dwPHYMW6TaO
 Mch3fMTuy8g29h6Cl/1KscFkXxHJimGedUAsCnW92pQ/NephE3bd26tSmCEiUUlMtf8LeqCc
 ZQdyZPZ5Ne/lVDQimdeHyCaSdtgKcPtGeyrPty2GvJGLppNaRG4nNspg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [PATCH 2/3] doc/README: Add section for self signed certificates
Date: Wed, 13 Aug 2025 12:13:01 +0200
Message-ID: <20250813101406.1372766-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
References: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 10:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19725

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.signing.md | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/doc/README.signing.md b/doc/README.signing.md
index 327d981..1d0de11 100644
--- a/doc/README.signing.md
+++ b/doc/README.signing.md
@@ -27,6 +27,40 @@ The default implementation of isar-cip-core is `recipes-devtools/swupdate-signer
 To validate a signed *.swu the image needs to contain the public part of the certificate which
 is stored in the recipe `recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb`
 
+### Use self signed certificates
+
+#### Generate a certificate
+It is possible to add own self signed certificates to the swu-signing process. The certificates
+can be generated with [openssl]():
+
+``` bash
+openssl req -x509 -newkey rsa:4096 -noenc -keyout mycert.key.pem \
+    -out mycert.cert.pem  \
+    -addext extendedKeyUsage=1.3.6.1.5.5.7.3.4 -addext keyUsage=digitalSignature
+```
+For use in isar-cip-core you can copy the key and cert into `./recipes-devtools/swupdate-certificates/files/`
+and used them with the recipes [swupdate-certificates-key](./recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb)
+and [recipes-swupdate-certificates]((./recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb).
+Downstream layer should use separate recipes for key and certificate.
+
+#### Use the certificates
+
+To use the self signed certificate with the provided recipes the following bitbake variables must be set:
+ - SWU_SIGNED must be 1
+ - SWU_SIGN_CERT must by set to the file name of the public certificate
+ - SWU_SIGN_KEY must by set to the file name of the private key
+ - PREFERRED_PROVIDER_swupdate-certificates-key to "swupdate-certificates-key"
+ - PREFERRED_PROVIDER_swupdate-certificates to "swupdate-certificates-snakeoil"
+
+In case of the above generate key the variables are:
+```
+SWU_SIGNED = "1"
+SWU_SIGN_CERT = "mycert.cert.pem"
+SWU_SIGN_KEY = "mycert.key.pem"
+PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
+PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
+```
+
 ## Signing an EFI binary
 
 EFI binaries are signed with the script `/usr/bin/sign_secure_image.sh`.
-- 
2.50.1


