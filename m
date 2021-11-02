Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A415C433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 20:18:41 +0000 (UTC)
Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.838.1635884320405146473
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Nov 2021 13:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1A2KIcDj020947
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Tue, 2 Nov 2021 21:18:38 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.22.43.93])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1A2KIXYE007052
	for <cip-dev@lists.cip-project.org>; Tue, 2 Nov 2021 21:18:38 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v2 3/3] Update Isar revision
Date: Tue,  2 Nov 2021 21:18:33 +0100
Message-Id: 
 <bdd3d220696e6843dfc63a62e371a4c2cd422d46.1635884313.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635884313.git.jan.kiszka@siemens.com>
References: <cover.1635884313.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Nov 2021 20:18:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6855

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings a few smaller fixes and package log cleaning.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 4eadaa7..dc56729 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 9b31dae3284127d4aed4b9331af1b1c3c31152f5
+    refspec: ceb7e21154fc4862f704bb5c7739e87a26db6eb3
     layers:
       meta:
 
-- 
2.31.1


