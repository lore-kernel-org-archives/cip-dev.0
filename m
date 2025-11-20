Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F942CF9C72
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 17:04:17 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1527.1763658244305288022
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 09:04:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: j9NqPKtVTo+t6ErM6hnWPw==
X-CSE-MsgGUID: 5nhRDJ59RDOzgwlkUvB6kA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 02:04:10 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4309E40614F0;
	Fri, 21 Nov 2025 02:04:08 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 06/10] phy: renesas: phy-rcar-gen3-usb2: Sort compatible entries by SoC part number
Date: Thu, 20 Nov 2025 17:03:53 +0000
Message-ID: <20251120170357.18342-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
References: <20251120170357.18342-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 17:04:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20653

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9414ceb38a74470249dee69784d6079daa452c3a upstream.

Reorder the compatible entries in `rcar_gen3_phy_usb2_match_table` to
maintain sorting based on SoC part numbers. Keep the entries ordered
numerically while ensuring the existing generic compatible strings
remain at the bottom.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250414145729.343133-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index b45aee8f5964..bfc49236a28e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -609,14 +609,14 @@ static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
 		.compatible = "renesas,usb2-phy-r8a77965",
 		.data = &rcar_gen3_phy_usb2_data,
 	},
-	{
-		.compatible = "renesas,rzg2l-usb2-phy",
-		.data = &rz_g2l_phy_usb2_data,
-	},
 	{
 		.compatible = "renesas,usb2-phy-r9a08g045",
 		.data = &rz_g3s_phy_usb2_data,
 	},
+	{
+		.compatible = "renesas,rzg2l-usb2-phy",
+		.data = &rz_g2l_phy_usb2_data,
+	},
 	{
 		.compatible = "renesas,rcar-gen3-usb2-phy",
 		.data = &rcar_gen3_phy_usb2_data,
-- 
2.51.0


