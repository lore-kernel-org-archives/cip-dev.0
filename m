Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FD7D0E6C9
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 08:17:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.41045.1729498646700813650
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 01:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=WNrJA6Dy;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1729498644;x=1730708244;bh=Dm9bFKsVSA5+jVp/8/G7qVFHkQXkRvo2uAYIn6LdpE0=;b=WNr
	JA6DyumedyX8+C4fHuVFZpck5GtJgOmPUSa6N5TMx9ecrRx6XacV0RKM7/SQceseobDRcBPrs0gvy
	A1MckVvB6WsdRaca9Luu5w47glLtwzcZYK1YxACR6poc3jo1RLnIGaEj3Kf3+I7dMaS+1458Jk+wf
	8rYy2NYJXsQDGlP7QzHKVKJhhuypQTklkTJtXS0B2hA+S/Sg+2UPQbu3RBFG+ZC7q7Ys1o1e/fqRD
	mgo308JvHFqMtxKfs2nCwxN7eDN6bORrWSs+RGr8fMIiaa7g9SK7wkFJ6zkZsgqNrVaqBC81elGNZ
	MYhgj14qSWcJER7MXCMYTsbb85fqZug==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 49L8HNSN1415228; Mon, 21 Oct 2024 17:17:23 +0900
X-Iguazu-Qid: 2rWg67yet6X17qPBhK
X-Iguazu-QSIG: v=2; s=0; t=1729498643; q=2rWg67yet6X17qPBhK; m=b2S2pfw+PWcsnJxqiPvbCJHMPUO8oo34sUfnGce/yrk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 49L8HMqQ039410
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 17:17:22 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.112-cip30
Date: Mon, 21 Oct 2024 17:17:14 +0900
X-TSB-HOP2: ON
Message-Id: <1729498634-13298-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 08:17:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17056

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../{linux-cip_6.1.111-cip29.bb => linux-cip_6.1.112-cip30.bb}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_6.1.111-cip29.bb => linux-cip_6.1.112-cip30.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip_6.1.111-cip29.bb b/recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.111-cip29.bb
rename to recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
index b4db33a..870e060 100644
--- a/recipes-kernel/linux/linux-cip_6.1.111-cip29.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "1aa412d9eaa31c566568537cfd9149cb1b12449d937f93b693c97a425b47b89d"
+SRC_URI[sha256sum] = "70681787bee6c1057d002b440e3682656306aacc723ebffeebda1bf41da47882"
-- 
2.45.2



