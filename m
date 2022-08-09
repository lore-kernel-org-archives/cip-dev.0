Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099CDC19F2D
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 16:55:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.14426.1660064135606131831
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Aug 2022 09:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 279GtWjY022359;
 Wed, 10 Aug 2022 01:55:33 +0900
X-Iguazu-Qid: 34trEV9ARS0mv3v6NE
X-Iguazu-QSIG: v=2; s=0; t=1660064132; q=34trEV9ARS0mv3v6NE;
 m=anl6IQf/t3hC4WkZnEMkA8f/wfAx5GlBZ62GkyHLIH4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 279GtV5G028355
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Aug 2022 01:55:32 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] security-customizations: Inherit common
 customizations to security image
Date: Tue,  9 Aug 2022 22:25:28 +0530
X-TSB-HOP2: ON
Message-Id: <20220809165528.21438-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Aug 2022 16:55:29.0296 (UTC)
 FILETIME=[D48E0100:01D8AC10]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Aug 2022 16:55:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9149

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Current security image doesn't enable ethernet device by default in
QEMU target, which is required to verify some of the security requirements
like multi-factor authentication.

This will reuse the customization in common.inc recipe that will enable
necessary settings in security image.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .../security-customizations/security-customizations.bb   | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index 4a41d2d..240a577 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -9,11 +9,12 @@
 # SPDX-License-Identifier: MIT
 #
 
-inherit dpkg-raw
+require recipes-core/customizations/common.inc
 
 DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
 
-SRC_URI = " file://postinst"
+SRC_URI += "file://postinst"
+
+DEPENDS += "sshd-regen-keys"
+DEBIAN_DEPENDS += ", sshd-regen-keys, libpam-google-authenticator"
 
-DEPENDS = "sshd-regen-keys"
-DEBIAN_DEPENDS = "sshd-regen-keys, libpam-google-authenticator"
-- 
2.20.1



