Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C630D74EEC
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 15:30:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.738.1769182228646736632
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jan 2026 07:30:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 60NFUPV5256736; Sat, 24 Jan 2026 00:30:26 +0900
X-Iguazu-Qid: 2rWh8deQOrgo9xyIpm
X-Iguazu-QSIG: v=2; s=0; t=1769182225; q=2rWh8deQOrgo9xyIpm; m=ULTpJ6Gk4TMhQ1tzM+hxzqR1tuwVrHuSmysMilm0D4c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dyMM54YFfz4vyh; Sat, 24 Jan 2026 00:30:24 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v6 3/4] swupdate.inc: Enable wfx based updates if WFX_URL is set
Date: Fri, 23 Jan 2026 10:44:56 -0500
X-TSB-HOP2: ON
Message-Id: <20260123154458.2479542-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jan 2026 15:30:18.0768 (UTC) FILETIME=[2E2B9100:01DC8C7D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jan 2026 15:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21707

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

WFX_URL can be set via the Kconfig menu. Enable wfx backend based updates
if WFX_URL is set at build time.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 recipes-core/images/swupdate.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 7cd816a..00e972e 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -57,5 +57,9 @@ python() {
 IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
 IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
+WFX_URL ??= ""
+# check for wfx url to enable support for wfx backend based updates
+IMAGE_INSTALL:append = "${@' swupdate-config-wfx' if d.getVar("WFX_URL") else ''}"
+
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
 IMAGE_INSTALL += " swupdate-config"
-- 
2.39.5



