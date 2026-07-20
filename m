Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C42C4451B
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 05:12:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2461.1784524337854578774
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Jul 2026 22:12:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 66K5CGNF3170919; Mon, 20 Jul 2026 14:12:16 +0900
X-Iguazu-Qid: 2yAbeCtgvy1oIVCds0
X-Iguazu-QSIG: v=2; s=1; t=1784524336; q=2yAbeCtgvy1oIVCds0; m=QVqkXDpD+LVEVQZuG12L/mf1JkUQ8GKaVRNFgHSf68g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h3TCg6xBYz1xnZ; Mon, 20 Jul 2026 14:12:15 +0900 (JST)
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        kumar.dinesh.h95@mail.toshiba
Subject: [isar-cip-core][PATCH v1 0/2] Enable SWUpdate support for Debian sid
Date: Mon, 20 Jul 2026 10:29:01 +0530
X-TSB-HOP2: ON
Message-Id: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Jul 2026 05:12:13.0899 (UTC) FILETIME=[536521B0:01DD1806]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 05:12:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23668

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

This patch series adds the missing settings to enable the SWUpdate
support for Debian sid.
On top of these changes, I confirmed the SWUpdate works fine.

Shivanand Kunijadar (2):
  swupdate-handler-roundrobin: Keep Lua version 5.5 for sid
  swupdate.cfg.tmpl: Add digest-provider option for signature
    verification

 .../files/{swupdate.cfg => swupdate.cfg.tmpl}             | 1 +
 recipes-core/swupdate-config/swupdate-config_0.2.bb       | 8 +++++---
 .../swupdate-handler-roundrobin_0.1.bb                    | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)
 rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (77%)

-- 
2.39.5



