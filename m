Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF40C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 14:16:52 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.13076.1682086606874522234
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 07:16:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=gqYk88cP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202304211416444743b4504596a43f6a-qpvzkq@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202304211416444743b4504596a43f6a
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Apr 2023 16:16:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=aB4Dx4HTO4d9hSKHl5hoAuj224wcKijgfnSAerrjJ30=;
 b=gqYk88cPYmVmVsTTaXixTr2xypgxjnCACX8VaxDk1uqEp7uABnW/ZlOdgn/yXc70G+UJrI
 NeyRm+2ixxsVo1/y8B+OFdYiSamA43QHa4ojgsxetoODmrO8YOeZY1HjEUk106aoF0THXRSn
 hOOGV3WPNbEbbjNatdwzxjTd17RH4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] start-qemu.sh: Add bookworm as distro
Date: Fri, 21 Apr 2023 16:16:43 +0200
Message-Id: <20230421141643.3905811-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 14:16:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11315

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to start qemu with bookworm images without additional
arguments.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 start-qemu.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 8810474..5d48e0d 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -41,6 +41,8 @@ if [ -z "${DISTRO_RELEASE}" ]; then
 		DISTRO_RELEASE="sid-ports"
 	elif grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
 		DISTRO_RELEASE="buster"
+	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then
+		DISTRO_RELEASE="bookworm"
 	else
 		DISTRO_RELEASE="bullseye"
 	fi
-- 
2.39.2


