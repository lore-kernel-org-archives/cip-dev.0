Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13DC4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 14:16:11 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.2534.1702390561285984705
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 06:16:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VIETN7hQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202312121415570ecc1badde64d8c3fe-s_2pun@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202312121415570ecc1badde64d8c3fe
        for <cip-dev@lists.cip-project.org>;
        Tue, 12 Dec 2023 15:15:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=AJQJw/QgFdN0sx1EF21xrz99fVYm41t80QUQj7louTA=;
 b=VIETN7hQj5w71NQq96MZL4TC4VThR1NUb+0qXUZGuEodqiKrwc7BArLyEM9HpHSvdCSivH
 R5mOcq6MuB6ha+kLOEUglU182QBRJVpD3RQlkIUze2P8SVcv5dBSqA0yTw9YCtInIl1vLxpW
 cLpIFGoTIkSy6S5SMOK+G4bCa/Py0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] swupdate-certificates*.inc: Add missing FILESEXTRAPATHS
Date: Tue, 12 Dec 2023 15:12:35 +0100
Message-ID: <20231212141556.1616031-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 14:16:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14059

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to include the files in downstream layers.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-certificates/swupdate-certificates-key.inc         | 2 ++
 .../swupdate-certificates/swupdate-certificates.inc             | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index d3d2e16..2c67e89 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
+
 PROVIDES += "swupdate-certificates-key"
 
 SWU_SIGN_KEY ??= ""
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index 6673383..564dda4 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -11,6 +11,8 @@
 
 inherit dpkg-raw
 
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
+
 PROVIDES += "swupdate-certificates"
 
 SWU_SIGN_CERT ??= ""
-- 
2.42.0


