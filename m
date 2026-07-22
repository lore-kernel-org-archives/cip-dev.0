Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4037C4453C
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 15:11:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2319.1784733074162664890
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 08:11:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66MFBBuE3678392; Thu, 23 Jul 2026 00:11:12 +0900
X-Iguazu-Qid: 2rWhDvWdS0FZ3CIzKb
X-Iguazu-QSIG: v=2; s=1; t=1784733071; q=2rWhDvWdS0FZ3CIzKb; m=RjZelzKcTEN6q1UH+Gv0SaiTYaP5vbelTCeAniUzB2Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4yPq25xvz4vym; Thu, 23 Jul 2026 00:11:11 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v3 0/3] Enable swupdate support for debian sid
Date: Wed, 22 Jul 2026 20:27:52 +0530
X-TSB-HOP2: ON
Message-Id: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Jul 2026 15:11:08.0369 (UTC) FILETIME=[52D59C10:01DD19EC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 15:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23717

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This patch series enables the swupdate support for debian sid. 

Shivanand Kunijadar (3):
  swupdate-handler-roundrobin: Keep default lua version as 5.5
  swupdate-handler-roundrobin: Remove adding additional lua version
    paths
  swupdate.cfg.tmpl: Add digest-provider option for signature
    verification

 .../files/{swupdate.cfg => swupdate.cfg.tmpl}        |  3 ++-
 recipes-core/swupdate-config/swupdate-config_0.2.bb  | 12 +++++++++---
 .../swupdate-handler-roundrobin_0.1.bb               | 12 +++++-------
 3 files changed, 16 insertions(+), 11 deletions(-)
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (72%)

-- 
2.39.5



