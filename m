Return-Path: <cedric.hombourger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB27C0219E
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 07:47:08 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.7004.1739260024135456046
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Feb 2025 23:47:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=cedric.hombourger@siemens.com header.s=fm2 header.b=Pf2BLA7A;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1212295-20250211074700c5edf9d4c59253599e-uql7ct@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250211074700c5edf9d4c59253599e
        for <cip-dev@lists.cip-project.org>;
        Tue, 11 Feb 2025 08:47:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=P+bpFj1IzAKq3FPMt2+hPmSYMQXUyErBTtHI6ni3JK0=;
 b=Pf2BLA7AnRi7gWlxCWMQ3RZmfXAHPoNXHYqEyhQBibuSOxlj+mGOqDMA41IDtcsHpQXyiG
 sn52HfcO4Q53QmVfgtktEV/bLgJ2y/t9GKsk+rdAFhAHEr2r/O50ZojMuab3YBR5AI8KnA81
 0aBwd/CmlOP9jy1IiDwwa0eZJBVLoDOPTGMJuZGdKEgyKdRVdB8i8mXa3DIS+ur7izmuLTPr
 dHpvYhhzYJwfA7OoBBMwAQcUcuJFmq+vuHG5OFNjZT5EZqQQ4eKbegXdPVfhXWJbWLa+3Xau
 lukNuFCGEnJl1ON37jqWyM6S94nFj08aZDhRqcpZiSmTPWbiSWB5IL9w==;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [isar-cip-core][PATCH] swupdate-config: suffix package with -${MACHINE}
Date: Tue, 11 Feb 2025 08:46:36 +0100
Message-Id: <20250211074636.348469-1-cedric.hombourger@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 07:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17803

swupdate-config generates ${MACHINE}-dependent code since it uses
templates where ${MACHINE} is expanded for the configuration files
it ships. This causes problems in multiconfig builds. Dynamically
suffix the name of the recipe and package with -${MACHINE} to get
a separate build for each ${MACHINE} selected in the multiconfig.

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
 .../{swupdate-config_0.1.bb => swupdate-config_0.2.bb}       | 5 +++++
 1 file changed, 5 insertions(+)
 rename recipes-core/swupdate-config/{swupdate-config_0.1.bb => swupdate-config_0.2.bb} (89%)

diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
similarity index 89%
rename from recipes-core/swupdate-config/swupdate-config_0.1.bb
rename to recipes-core/swupdate-config/swupdate-config_0.2.bb
index 3495285..63fa320 100644
--- a/recipes-core/swupdate-config/swupdate-config_0.1.bb
+++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
@@ -11,6 +11,11 @@
 
 inherit dpkg-raw
 
+PROVIDES := "${PN}"
+DEBIAN_PROVIDES := "${PN}"
+
+PN .= "-${MACHINE}"
+
 SRC_URI = "file://swupdate.cfg \
            file://hwrevision.tmpl"
 
-- 
2.39.5


