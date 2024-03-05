Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A97FC54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 16:11:35 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.27678.1709655092447762967
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 08:11:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=BP7z+G69;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240305161129625b0ba62d31f10a14-ulvovx@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240305161129625b0ba62d31f10a14
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 17:11:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ltOB0YWZr1jOxXIJIJcK6JqHzwNf9a8zcL/oZfohUIQ=;
 b=BP7z+G69cWFJG1/KMozlBjKM82GSFNO87BEHUCYCwU/6L9m4SlGSaVEXpn+A4sPmT4mIxg
 z9V408eCPSjBWiwB8GTADgemK9uTOhy9NaOKaRbwfTBtegOMElCwdrlHOOayZyGVXM0K8mRi
 KIEY8vFh9emAxvKsYQAZUyK0RaRls=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 3/6] doc: Add section about SWUpdate signing to README.swupdate.md
Date: Tue,  5 Mar 2024 17:10:56 +0100
Message-ID: <20240305161128.2777211-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 16:11:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15231

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 5877882..b7e13f7 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -110,6 +110,27 @@ The sw-description will contain the following section:
           sha256 = "<sha256 of luascript.lua>";
         }):
 ```
+## SWUpdate Signing
+
+The ISAR layer isar-cip-core provides templates to sign the swu binaries with
+a CMS certificate.
+
+By default the insecure [Debian snake-oil keys](./recipes-devtools/secure-boot-secrets/files/bookworm/) are used.
+To use other key and certificate the following variables must be set:
+```
+PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
+PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
+SWU_SIGN_CERT = "<sigining certificate file name>"
+SWU_SIGN_KEY  = "<siging key file name>"
+```
+
+The files `<sigining certificate file name>` and `<siging key file name>` need to be stored
+in `recipes-devtools/swupdate-certificates/files/` or in a path defined by an bbappend file, e.g.`swupdate-certificates-key_%.bbappend`
+
+### signing script
+
+The provided [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms)
+can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
 
 ## SWUpdate Hardware compatibility
 
-- 
2.43.0


