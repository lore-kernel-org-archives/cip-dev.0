Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC78AC54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 11:07:33 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.19793.1709636829567737105
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 03:07:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=hFHYIt7k;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2024030511031301934f2ec04b2b9f84-niwsou@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024030511031301934f2ec04b2b9f84
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 12:03:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ltOB0YWZr1jOxXIJIJcK6JqHzwNf9a8zcL/oZfohUIQ=;
 b=hFHYIt7k/tzOvbcmpStMOwTiFSWd2QyuOatE+bRfbdzN9Ox+sT4MLEXJ7LeiKlSyERC0tn
 jstgsjD6DfSZDSKxVeWfbLf5XB3HKwpqCNjIZltRz49vNRruBZhVCIadYN6BhoIzPasxMYu1
 rHJ88k6S+lMmk3rLMEMQ01Ggn+Ics=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/4] doc: Add section about SWUpdate signing to README.swupdate.md
Date: Tue,  5 Mar 2024 12:02:45 +0100
Message-ID: <20240305110311.2073425-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
References: <20240305110311.2073425-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 11:07:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15220

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


