Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4537D6E2D5
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1420.1766076974482781710
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lNXy+3Nn;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso10444865e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076973; x=1766681773; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP0hZbznJsr8tYeOi+VZ3XSZ76in2Fr/widAR+PDnPY=;
        b=lNXy+3NnIkMSLAyszc/EhaDiwjFwhI8xajdCsetJeCbSHXbkcjd5OK4Bb6KVBUKxwz
         NTrpPAdSdKhrxjWKQvrGsUMXXcpQ5QBtDReYWuIYTswBdQdifyyfisc+45wY++BGAbdq
         suxq2bQrO31mxSZ8nh2Wd3ifru0IHCOXaME4dDuvO3xoA47/CC/unYB/kmk0xfsDYfLi
         huY4f58Gs6V/u/tj8bKPqWvc3H7D9tlN0+1CjwJfBQXsb/Ghs5y818g5m+bFarLbTU2N
         n70bifx149RmFU9LZlrQKqdE4IxdreiP0seBKtTm3kCMJ4Ec7Rcq2nqNApI/mMT3TKOM
         5MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076973; x=1766681773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JP0hZbznJsr8tYeOi+VZ3XSZ76in2Fr/widAR+PDnPY=;
        b=Nr4HCDUC4HRwG5SDZ1Ui1DooYVNdYebBdqMIfmaKiwURQ2RHz5IcB6c57I+EhKh1Kn
         XCVcZHW/ke9Q43aGMlKeEk/aS0bZPkal4heAfVz8QcKgov8+/cL32r8h2Pg8vDzMa8bT
         NwKF/jZeJgXS8DoN3eBuKXUuYdT79mKZ6MsSjdrECtYY4N2iXrgvfoepZmVfXbNqSVe0
         Vybjh2jdeDzka8MWtzic1gQ98dqKeO7cB42mWKPT1wFbes5gA5fqsjPsLh77n//r/1hX
         +5CEXpwl174r7/tPoLBUfmD44z3lE+v7E6XP2p74y//jDj8Lboea2gxqtIjlwAKgYTEJ
         wrLw==
X-Gm-Message-State: AOJu0YyC5BBr3mW3Y/OOCe8iC2SLZXJEntYy9oj4jFaaXb+cek0EFIMP
	hdE0oURTXfnTsTqN1cdj4WwG9R4o9xRi7HR6GT36KRfrvR+kwAHM5EofGA0xqg==
X-Gm-Gg: AY/fxX5gcwR7yerY4IN8tnP8HnKgDFlxLS71MDOxuFLR48dVCAjn/gccEE+8Kp0ymzf
	6dh1eZkFKik0Ma6Uwj+wFRJ0FKtVth6ds+rQnzFgeqiW6XS9Ju3G46lexFaqFReBvbRrcriYvOW
	AN7kLCkWVJMYqmmoIR5RTCJ74pPXCr//4AtjZc62s4tGNG2UXwJuN3QqxXgE5zZHdY2Ou2i3bVk
	0QnuoG7SIuHmm9HNh3NXyyDrWxGzPWHuoIknDBvgT8jic7CXQc1PJORTEATT9ADRuQu1ozSy57O
	aHVzj2cUDWw/yLlk5RPQyuDuepgd5Rxzu11IqU1M5xwm3fkEk/GUR4/Uzq4E3dkwWyb742eLthL
	qmtov3Z9g/NwVz2GknWIpp870Pphy3OHHBp6rIi2Ca2bZaUVupwkq9p9CUPbsbj7ZTf/Y3+z/3f
	u0NYm5RpAOzT4RSbqOhA==
X-Google-Smtp-Source: AGHT+IEIR5n+896Uxe8ay8B0lDxhsOaxJUUbKSrnKUWHt62B9USFi+HzTmND2706Pd9doe5qqw7VeA==
X-Received: by 2002:a05:6000:2dc2:b0:429:b21e:49c3 with SMTP id ffacd0b85a97d-4324e437870mr279488f8f.26.1766076972528;
        Thu, 18 Dec 2025 08:56:12 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:12 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 24/24] can: rcar_canfd: Fix CAN-FD mode as default
Date: Thu, 18 Dec 2025 16:55:23 +0000
Message-ID: <20251218165600.258194-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21162

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
index 5503c2c14bef..725c86e1b6a5 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -711,6 +711,11 @@ static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
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
@@ -757,25 +762,6 @@ static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
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
@@ -808,6 +794,16 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
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
@@ -825,10 +821,23 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
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


