Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB98DC433EF
	for <webhook@archiver.kernel.org>; Tue, 23 Nov 2021 18:16:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15159.1637691415453473377
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Nov 2021 10:16:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.87,258,1631545200";
   d="scan'208";a="101529516"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Nov 2021 03:16:52 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4A3F0400C44A;
	Wed, 24 Nov 2021 03:16:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] customizations: Add support to include tools and Firmware
 required for WiFi testing
Date: Tue, 23 Nov 2021 18:16:49 +0000
Message-Id: <20211123181650.8887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Nov 2021 18:16:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6979

Include iw tools, wireless-regdb (to include regulatory database) and any
additional firmware pointed by WIRELESS_FIRMWARE_PACKAGE variable only if
INSTALL_WIRELESS_TOOLS is set to "1".

Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 recipes-core/customizations/customizations.bb | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 932b11c..d302b4a 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -18,10 +18,15 @@ SRC_URI = " \
     file://ethernet \
     file://99-silent-printk.conf"
 
+WIRELESS_FIRMWARE_PACKAGE ?= ""
+INSTALL_WIRELESS_TOOLS ??= "0"
+
 DEPENDS += "sshd-regen-keys"
 
 DEBIAN_DEPENDS = " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys \
+    ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
+	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
 
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
-- 
2.17.1


