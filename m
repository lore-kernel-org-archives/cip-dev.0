Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7EF506F6
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52447.1773673175962015446
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: kP2SwKGVQ4SGaJKavZdelA==
X-CSE-MsgGUID: TfuaP/rzST6VLXptps9LhA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:37 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D14AA41B7814;
	Mon, 16 Mar 2026 23:59:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/35] phy: renesas: rcar-gen3-usb2: Fix ID check logic with VBUS valid
Date: Mon, 16 Mar 2026 14:58:48 +0000
Message-ID: <20260316145915.8580-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22403

commit 356590cd61cf89e2420d5628e35b6e73c6b6a770 upstream.

The existing ID detection logic returned false when both IDDIG and
VBUSVALID were set, which caused incorrect role determination in some
cases. The condition:

    !(device && !vbus_valid)

did not properly reflect the intended relationship between IDDIG and
VBUSVALID signals.

Update the logic to:

    return vbus_valid ? device : !device;

This ensures that when VBUS is valid, the role follows the IDDIG value,
and when VBUS is not valid, the role is inverted, matching the expected
OTG behavior.

Fixes: b725741f1c21 ("phy: renesas: rcar-gen3-usb2: Add support for RZ/T2H SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250821155957.1088337-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 5659ac22511d..4e8cf7527439 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -301,7 +301,7 @@ static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
 		device = !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_IDDIG);
 		vbus_valid = !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_VBUSVALID);
 
-		return !(device && !vbus_valid);
+		return vbus_valid ? device : !device;
 	}
 
 	if (!ch->uses_otg_pins)
-- 
2.43.0


