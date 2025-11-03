Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA4CCFA06
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:36:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18623.1762169774650115223
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:36:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: mkKftW6iT/WTEs2MQ9Z6Mg==
X-CSE-MsgGUID: Gz0usHUOTpmyOUyJgQ9FmA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:36:19 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0FDE4400942A;
	Mon,  3 Nov 2025 20:36:17 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.1.y-cip 05/25] pinctrl: renesas: rzg2l: Fix invalid unsigned return in rzg3s_oen_read()
Date: Mon,  3 Nov 2025 12:35:38 +0100
Message-ID: <20251103113608.36240-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:36:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20297

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 8912b2862b9b74a0dc4e3ea1aacdec2f8abd7e1d ]

rzg3s_oen_read() returns a u32 value, but previously propagated a negative
error code from rzg3s_pin_to_oen_bit(), resulting in an unintended large
positive value due to unsigned conversion. This caused incorrect
output-enable reporting for certain pins.

Without this patch, pins P1_0-P1_4 and P7_0-P7_4 are incorrectly reported
as "output enabled" in the pinconf-pins debugfs file. With this fix, only
P1_0-P1_1 and P7_0-P7_1 are shown as "output enabled", which matches the
hardware manual.

Fix this by returning 0 when the OEN bit lookup fails, treating the pin
as output-disabled by default.

Fixes: a9024a323af2 ("pinctrl: renesas: rzg2l: Clean up and refactor OEN read/write functions")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250709160819.306875-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 3c60663c9454..9b157eab986b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1117,7 +1117,7 @@ static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 
 	bit = rzg3s_pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
-		return bit;
+		return 0;
 
 	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
 }
-- 
2.25.1


