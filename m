Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A57EEB585
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 10:07:21 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.44700.1726135633978988625
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 03:07:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=H72cN8ab;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20240912100711b206e80023b82dec3b-8qyfif@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240912100711b206e80023b82dec3b
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Sep 2024 12:07:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=DMGleDdvhHF2nzTXw6zBfR7UwAo9tBlcIR+wHOEC5cg=;
 b=H72cN8abYXoL6H2V4UVogeRHxhmJLzbmSPp1BzaWbi423NJC0KHnGFrGtiCFr+cVpycMLT
 HQ+bTNzG1LF1hOWifZYSFYGr3Z9NW2qfUEjYZaUIeOdgmfEiqPr5SzJ9KI8U8Mz2pyyRCn0v
 Ma1ewY72VE5XMjRtsdTs7fkTxWJdHgvk3d+9BghtNrhdyWsXuc2eapw5eWOkUS6sI3WGlghI
 S+HTJUzFCTLrfPoPSnZDykV1nJXmj2d+RHYX73cg4++nmj4TOlUgVt8xuAcZtg9W/Ci0HB5G
 n8X+/2VlQTNIDewCNy0EKafUEiqNl+gfdkVJR8JGIkIK29K9o8Fe0vAw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] Update README for swupdate signing
Date: Thu, 12 Sep 2024 12:06:42 +0200
Message-ID: <20240912100710.3183806-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
References: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 10:07:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16892

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index a5fbab9..d4d0851 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -136,8 +136,8 @@ To use other key and certificate the following variables must be set:
 ```
 PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
 PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
-SWU_SIGN_CERT = "<sigining certificate file name>"
 SWU_SIGN_KEY  = "<siging key file name>"
+IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 ```
 
 The files `<sigining certificate file name>` and `<siging key file name>` need to be stored
@@ -145,8 +145,15 @@ in `recipes-devtools/swupdate-certificates/files/` or in a path defined by an bb
 
 ### signing script
 
-The provided [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms)
-can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
+The package [swupdate-signer-snakeoil](recipes-devtools/swupdate-signer/) provides a [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms).
+When signing requires a project specific signing script,
+e.g. for using a hardware security module(HSM), an own package can be added.
+The package can replace the default package by adding the following line:
+```
+PREFERRED_PROVIDER_swupdate-signer = "<own signing package>"
+```
+
+The package `<own signing package>` needs to install a executable to `/usr/bin/sign-swu`.
 
 ## SWUpdate Hardware compatibility
 
-- 
2.45.2


