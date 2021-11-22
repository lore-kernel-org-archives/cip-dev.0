Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22480C433EF
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 11:19:47 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.5232.1637579985536456226
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Nov 2021 03:19:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.87,254,1631545200";
   d="scan'208";a="101417899"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Nov 2021 20:19:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 05772425F878;
	Mon, 22 Nov 2021 20:19:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][RFC PATCH] customizations: Add FW and tools
 required for wifi testing
Date: Mon, 22 Nov 2021 11:19:40 +0000
Message-Id: <20211122111940.12250-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Nov 2021 11:19:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6962

Add firmware and tools required for testing wifin on hihope-rzg2m.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

Sending an RFC as I am not sure if this is the right place to add
this. I wanted to add the debian package depends in machine.conf
file but didnt find any variables.

Is this the right place for adding this, if not could you please point
me to the right direction.

** Do not merge this patch **

Cheers,
Prabhakar
---
 recipes-core/customizations/customizations.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 932b11c..c508fd4 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -23,6 +23,9 @@ DEPENDS += "sshd-regen-keys"
 DEBIAN_DEPENDS = " \
     ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
 
+DEBIAN_DEPENDS_hihope-rzg2m += " \
+       ,firmware-ti-connectivity, iw, wireless-regdb, wireless-tools"
+
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
 	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
-- 
2.17.1


