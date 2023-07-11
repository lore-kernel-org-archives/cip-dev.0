Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C6C001DD
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 13:39:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.507.1689082739914761949
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 06:39:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 36BDcv441695525; Tue, 11 Jul 2023 22:38:57 +0900
X-Iguazu-Qid: 2yAbS7mhd0yD59C44e
X-Iguazu-QSIG: v=2; s=0; t=1689082737; q=2yAbS7mhd0yD59C44e; m=qtRxzv0R/0FCRBzz2NSfkkHdgaqfJc5BVbDzi/hAkoo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 36BDcuK63035431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Jul 2023 22:38:56 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] Kconfig: Add additional features to security image
Date: Tue, 11 Jul 2023 19:08:38 +0530
X-TSB-HOP2: ON
Message-Id: <20230711133838.437045-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Jul 2023 13:38:38.0360 (UTC) FILETIME=[FF7C3180:01D9B3FC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 13:39:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12304

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

From IEC certification perspective, a security image is needed which has the
below features along with security customizations.
1. Data encryption (CR4.1)
2. Secure boot (EDR 3.14)
3. SWupdate (NDR 3.10)

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Kconfig b/Kconfig
index 94e807a..a9c3425 100644
--- a/Kconfig
+++ b/Kconfig
@@ -171,6 +171,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
 
 config IMAGE_SECURITY
 	bool "Security extensions"
+	select IMAGE_DATA_ENCRYPTION
+	help
+	  This enables security customizations, data encryption, Secureboot and SWupdate, all in need for IEC certification perspective.
 
 config KAS_INCLUDE_SECURITY
 	string
-- 
2.30.2



