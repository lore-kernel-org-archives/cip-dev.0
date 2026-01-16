Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF9D4898C
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:49:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4358.1768564148482657622
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:49:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 60GBn5Gc2052946; Fri, 16 Jan 2026 20:49:06 +0900
X-Iguazu-Qid: 2rWh7Ml5iWvJAa0fCr
X-Iguazu-QSIG: v=2; s=0; t=1768564145; q=2rWh7Ml5iWvJAa0fCr; m=0n5Q4t6cUAzp2/BJ+gS+kD5RiReh9yduOonX4LbHEbg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dsymx507Nz4vyk; Fri, 16 Jan 2026 20:49:05 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com
Subject: [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx based updates if WFX_URL is set
Date: Fri, 16 Jan 2026 07:03:46 -0500
X-TSB-HOP2: ON
Message-Id: <20260116120347.1733494-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2026 11:49:00.0824 (UTC) FILETIME=[1B01D980:01DC86DE]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21635

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

WFX_URL can be set via the Kconfig menu. Enable wfx backend based updates
if WFX_URL is set at build time.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 recipes-core/images/swupdate.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 7cd816a..7041058 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -57,5 +57,9 @@ python() {
 IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
 IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
 
+# check for wfx url to enable support for wfx backend based updates
+OVERRIDES .= "${@':wfx' if d.getVar("WFX_URL") else ''}"
+IMAGE_INSTALL:append:wfx = " swupdate-config-wfx"
+
 IMAGE_INSTALL += " swupdate-handler-roundrobin"
 IMAGE_INSTALL += " swupdate-config"
-- 
2.39.5



