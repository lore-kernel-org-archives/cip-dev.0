Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFBE6748D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:20 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78284.1766402240417816862
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=npMHCZpB;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-649e28dccadso6162699a12.3
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402239; x=1767007039; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc7E6sxrfjqs3jjFkvOFyy+xurKUEkmC7b8+AOxcz5Q=;
        b=npMHCZpBIshaV/M6spOdMZ2JBST8UWJ0v9zoKhDTyxzzUclvwgn0Oxf2waHQMYJn+I
         Cj2gYbusLagr+eaKiirUBRqMVMXVClSQR5ab1zEDGDKJfd/VwexPuPRKlhGPCvoFGgSu
         m5TGXAgG/Ar7RkqFRIxmDbPNa1dPQoDGTnBaDKZsM93Qk5Nw8Nsk6l7SMsKs5D9agDZ2
         f67bvf7M4ZZ/m7W47K/VX5uNdFrJ9W+xPWGoGEKhQ/HUK19hbW9TN0MBEET3joYhMzhC
         VMkwp54BVpHwvJJspd9XuUDHCnKeg5dTSDoxPHnfFjMZC0AYJAc6Q2D2TJK2D5Hl93nD
         nzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402239; x=1767007039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wc7E6sxrfjqs3jjFkvOFyy+xurKUEkmC7b8+AOxcz5Q=;
        b=JwfVPsPauig0OWxyElUHnDstbrnWM6uz4kwFEs95GLX3yjjVM5fzBLIBcKNkz8TzeP
         p8JnlbfyYHeg/GNsSfNhqrzL4lm0CIyH6O42ogfgLdBF6w46AVDofA5wiBnCc1oQ65B+
         q1NobyS1TS6hHr5Sv9Rq15IqEP1SIRXUx81kFZ2oeVsJ76ELoCkHSD4escyc0sNbYJhq
         n7824iX+i7B62/gqCFaAZVPzjxHcX0PW0mNlP3/xHqBPCssVuIs2YYLzQJIa1AlmE4Zy
         RvRNwxcopTiJhN5tSLCQ35PAyyiwr2cQbNjJ0ss1ZB3xweGgX9e2bJzDER7jx0YbZ+uI
         iJlw==
X-Gm-Message-State: AOJu0YwWNMGDkx3iGN/EZsI1UDJla8Wm5ILIv7IOqVilIrQGhFqm2E9w
	G4g71r5cuWaBMyI4H/sydpnBoEMXAG2osZ7/8i533VR9a/zBAEI4aVo5AdvESg==
X-Gm-Gg: AY/fxX6WJx/A+oNJMxcIRaLVb2ddX+2oyh3VFplJp1A4Op9x2wmfGppvnnYANF3kjwN
	+LOM6a6sj/W4roubGP2+cuf9xvF79emUgI9fEFtC598kTvKw89v7xvnedkdF3cVpXWXXAXgEwjf
	X2Q9V6L0+C6D/GCJLs2p6PtqTMmLA6V+5+cAI2qiS5OUpVcGNQeX9QEWuJj3ijnTNBrKnIaAZc4
	LAmvI2XzatAW0Ye+Ikx8193TEX7wypyJrAGzkJD+7P1238sE/xvcROeT4js34SrwZb7mf+wkwA+
	Y+cZIIsDg7B6stCjjfPHG5w8eqAobm+OooLfB6nc3Plj/HhgDJ4GGNSldU9MTTraOHu983I63um
	HHQndgTMH9i2o4tOLLMBWmR4N9lQweFzH1Od77vLSfQ8mGFHBtXJCpuXVpRca0irUHaGE5+3sf2
	+BYomY8IF4G2amjDVa9t4VxB4Q7Z9r5AEmXZ4=
X-Google-Smtp-Source: AGHT+IHN5oPSNMlPUrs7pQ3Rrr8W9dW0fg8pDaaqCWdmZlhyl9hXr8EddEv8evAuA5WnyVhi6OfU1Q==
X-Received: by 2002:a17:907:2d92:b0:b73:5acd:465e with SMTP id a640c23a62f3a-b8036f0a56fmr1222785066b.11.1766402238409;
        Mon, 22 Dec 2025 03:17:18 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:18 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 24/24] can: rcar_canfd: Fix CAN-FD mode as default
Date: Mon, 22 Dec 2025 11:16:56 +0000
Message-ID: <20251222111705.27028-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21210

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6d849ff573722afcf5508d2800017bdd40f27eb9 ]

The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
has aligned with the flow mentioned in the hardware manual for all SoCs
except R-Car Gen3 and RZ/G2L SoCs. On R-Car Gen4 and RZ/G3E SoCs, due to
the wrong logic in the commit[1] sets the default mode to FD-Only mode
instead of CAN-FD mode.

This patch sets the CAN-FD mode as the default for all SoCs by dropping
the rcar_canfd_set_mode() as some SoC requires mode setting in global
reset mode, and the rest of the SoCs in channel reset mode and update the
rcar_canfd_reset_controller() to take care of these constraints. Moreover,
the RZ/G3E and R-Car Gen4 SoCs support 3 modes compared to 2 modes on the
R-Car Gen3. Use inverted logic in rcar_canfd_reset_controller() to
simplify the code later to support FD-only mode.

[1]
commit 45721c406dcf ("can: rcar_canfd: Add support for r8a779a0 SoC")

Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251118123926.193445-1-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 53 ++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fc38c87f0574..68e6c7ac6649 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -710,6 +710,11 @@ static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
 	rcar_canfd_update(val, val, addr);
 }
 
+static void rcar_canfd_clear_bit_reg(void __iomem *addr, u32 val)
+{
+	rcar_canfd_update(val, 0, addr);
+}
+
 static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
 {
 	rcar_canfd_update(mask, val, addr);
@@ -756,25 +761,6 @@ static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
 
-static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
-{
-	if (gpriv->info->ch_interface_mode) {
-		u32 ch, val = gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
-					    : RCANFD_GEN4_FDCFG_CLOE;
-
-		for_each_set_bit(ch, &gpriv->channels_mask,
-				 gpriv->info->max_channels)
-			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg, val);
-	} else {
-		if (gpriv->fdmode)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
-					   RCANFD_GRMCFG_RCMC);
-		else
-			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
-					     RCANFD_GRMCFG_RCMC);
-	}
-}
-
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
 	struct device *dev = &gpriv->pdev->dev;
@@ -807,6 +793,16 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
+	/* Set the controller into appropriate mode */
+	if (!gpriv->info->ch_interface_mode) {
+		if (gpriv->fdmode)
+			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
+					   RCANFD_GRMCFG_RCMC);
+		else
+			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
+					     RCANFD_GRMCFG_RCMC);
+	}
+
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -824,10 +820,23 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 			dev_dbg(dev, "channel %u reset failed\n", ch);
 			return err;
 		}
-	}
 
-	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
+		/* Set the controller into appropriate mode */
+		if (gpriv->info->ch_interface_mode) {
+			/* Do not set CLOE and FDOE simultaneously */
+			if (!gpriv->fdmode) {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_CLOE);
+			} else {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
+			}
+		}
+	}
 
 	return 0;
 }
-- 
2.43.0


