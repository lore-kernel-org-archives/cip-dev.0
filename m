Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CBEC54E41
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:58 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.95416.1709549696688986779
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 02:54:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=McZR+kQC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240304105454652640bb9a6816c5f6-lbiqdr@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240304105454652640bb9a6816c5f6
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 Mar 2024 11:54:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=JdCUikBekwZxgZ8Q0PqG8e6lj6eiUnEs/L1GaN5x6mY=;
 b=McZR+kQCW0HUkrzuZHN9C23v4XC8kgM3jn2JMglCGFFXSfIR0maPG8oK+YXMvWBNp/jo/p
 vpt3jDSShuhin/WPnRHhzubO8Z3crQfuQli8M+R9shMOMhulJ+zSoLE8fjBXUY3RfhZ+eO8T
 v02H7sG9JpvqnNiKKlN+cWHrX3tsM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 4/4] doc/README.swupdate.md: Add documentation for hardware compatibility
Date: Mon,  4 Mar 2024 11:54:52 +0100
Message-ID: <20240304105453.984881-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
References: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 10:54:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15194

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index cf1bcfb..5877882 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -111,6 +111,20 @@ The sw-description will contain the following section:
         }):
 ```
 
+## SWUpdate Hardware compatibility
+
+The variable `SWU_HW_COMPAT` contains a space separate list of
+compatible hardware revisions.
+SWUpdate checks the compatibility against `/etc/hwrevision`, see
+[hardware-compatibility in the SWUpdate documentation.](https://sbabic.github.io/swupdate/sw-description.html#hardware-compatibility)
+
+For testing purpose the content of `/etc/hwrevision` can be set with
+the variable `MACHINE_HW_VERSION`.
+
+In production scenarios it is recommended to acquire a HW specific
+identifier (e.g., Board identifer with dmidecode) during boot up and
+write it to `/etc/hwrevision`.
+
 # Building and testing the CIP Core image
 
 Set up `kas-container` as described in the [top-level README](../README.md).
-- 
2.43.0


