Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EED2ECE579
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:23:23 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.50555.1725880993281526578
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=PC4uyjve;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202409091123105d46f53e270cc1b08c-clga_h@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202409091123105d46f53e270cc1b08c
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Sep 2024 13:23:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hk2QfxxIhDtZoSgE9n0ycDjlMN0nJmIDxkWj7Tb4zkU=;
 b=PC4uyjveCmwXYvAOBqUqngVAIYdPgVb6sE5l693UVXK5HZ1MU8E61Xri/u2p+8TGogB05z
 hwX8AU2NGhdNWSII5ESZQvy6xhszYacsfu0WzdwywoYP4d94E575z8JDT6iarJ10j8ZVYsUl
 QWym75vVx6T9dMvIeJLDbpEl8vBLeNQR9rMIJDNegUqJeyT/rHpWnxuQUORWP6IFyTxmPHYw
 mN5f1g2aFE4r/YPQSvqCS7zsJZ3gud43XcU7kJ0F1a4QVDhvKJ2o7Avx7FT/xvVEuQGgU7rB
 C5bsBJhBPhtGp3KeTI2FuQCTiDFVuXolV4S50H7tGVcSwi0WfQH28gCA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 3/3] Update README for swupdate signing
Date: Mon,  9 Sep 2024 13:21:40 +0200
Message-ID: <20240909112309.1028531-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:23:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16869

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index a5fbab9..421ca1c 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -138,6 +138,7 @@ PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
 PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
 SWU_SIGN_CERT = "<sigining certificate file name>"
 SWU_SIGN_KEY  = "<siging key file name>"
+IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 ```
 
 The files `<sigining certificate file name>` and `<siging key file name>` need to be stored
@@ -145,8 +146,19 @@ in `recipes-devtools/swupdate-certificates/files/` or in a path defined by an bb
 
 ### signing script
 
-The provided [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms)
-can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
+The package [swupdate-signer](recipes-devtools/swupdate-signer/) provides a [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms).
+This script can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
+
+
+Alternatively an own signing script can be used by adding the following lines:
+```
+IMAGER_BUILD_DEPS:remove:swu = "swupdate-signer"
+IMAGER_INSTALL:remove:swu = "swupdate-signer"
+IMAGER_BUILD_DEPS:swu += "${@'<own signing package>' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGER_INSTALL:swu += "${@'<own signing package>' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+```
+
+The package `<own signing package>` needs to install a executable to `/usr/bin/sign-swu`.
 
 ## SWUpdate Hardware compatibility
 
-- 
2.45.2


