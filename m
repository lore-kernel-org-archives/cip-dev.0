Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11DCDC166
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88181.1767699912864151855
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cxs869Au;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso3548975e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699911; x=1768304711; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAuwvn2s4k3x0cDhEvct/WWq2KxI4oJRAMeVWyhaAUk=;
        b=cxs869AuzLv+qVoQlRZBk/cYGTzckwdbkcFFeRiHZ4/zFSvw2xSn1f7gX7V8biZSn8
         U2bW5vWferoKkkvBlQEDF1YEZmv5E/W3IaEurFFNkTuNDI1nWYzdbqQWXaa4j6L8EBqt
         szGxxhpJxPYiasuoIsK3itCXqbDPwGg4A1c1kpo28ItLsqTqQWHzrntiX7W78hQ5wjde
         5BXNaGeExbDwf0fmGNrDLRDx0OjNny1SS8kjF6oIdVwWG2oC8aYkpxT3t3pVAKGD+FYC
         tt/nYXfLK/IK8y1UGILyYhJQF1CgR3svk0240EsNHw8mGp2bGPA+DplGPpZH1O3fJnJ4
         hoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699911; x=1768304711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zAuwvn2s4k3x0cDhEvct/WWq2KxI4oJRAMeVWyhaAUk=;
        b=ltLDwX3fhCkaj3eE/XlzeWxcv13A0qbczEZ35EMOFuEdoz6vhEptvgdl65uoV5dBBQ
         NX1TJ7FF5nl93kK4HoyWZbdYDOBVtr0nS8oqXKcj+1Rm31LG34hXiLEoB0naJrTStAQ9
         YArab/VLQXQdfLPY4VXM3JGk8K1/AeWDwe7YypinfkRYmDUK7kPuZF01Pvv1p1FLNXWD
         hmb3+TwN9UyMoOBZro5k7yORSOSuLyKLdDfv7UglpEQ7xU3IfR4uFWuZMPpYNfztk4Rf
         fYIpohE/2IyYoF+qBC8XRIHDTXEFYcCK9h2z0mVvX17pI8IKqNYeREeUZ5qBKZWb8x6l
         kEBg==
X-Gm-Message-State: AOJu0Yyjuk31yE85GKMflbu843iPrOyCOdFrYo0fu/Kqyw/Gm68ifbcS
	iMNmheaM1HT2RRxz0Jm978465Oogz136R/3t1Fq4Yv5iw+/vaV/J8DwE9Fx+gg==
X-Gm-Gg: AY/fxX6nSWzezeLjyI5lzIpSjB3dS2xbT2aAnLFtM/V61H+YBzl7Dd3KqGE9ATjdGYQ
	8A0huA0YCwoaXDJtZ94nlRzWfNLZBjq/m3GrhVLkef77RAcmeJWYPqSNU48I3p9JapKdBh8fh0T
	MNxojMwdO1kU2rE0d39v0NexMzrpKOrqCOWkAf3EHNZ7pSA8ZFGU3205K4bnvZzX3DEKgpaUeD2
	Fn6YRWLh9VeMAiAuPCSEk7ZSiI8P755GHUjpqB2lQCLCOLnja7xF29nIVR6LkyGmx90DgYkQtqP
	88eP8jqGH9g5WZkWD4uatdAbwoqKXV6ggwQRUgK+HQQEkrAcGKhboXpPbFJSrojdQTwoYefTPu7
	oJmegI47PyAccAObbFBN/R+qldq07E/vsWhZklhmp8VyycCntVi2IKmN0ZBk6Aj0w5UkP2OKN7N
	b+83sdr3VQ2mzEwB4JKw==
X-Google-Smtp-Source: AGHT+IHHMXNQlW2e1dhFk1j8JR4XyogS53hDTx4rOgb33Kasfob8Hiu7hZvuIVhFq3m51ryBqfRpkg==
X-Received: by 2002:a05:600c:8b33:b0:47a:94fc:d057 with SMTP id 5b1f17b1804b1-47d7f063049mr27715575e9.2.1767699910982;
        Tue, 06 Jan 2026 03:45:10 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:10 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 24/24] can: rcar_canfd: Fix CAN-FD mode as default
Date: Tue,  6 Jan 2026 11:44:47 +0000
Message-ID: <20260106114458.122333-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21356

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
[Biju: Synced with mainline ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 1cd4835a4742..68e6c7ac6649 100644
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
@@ -789,7 +794,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
 	/* Set the controller into appropriate mode */
-	if (!gpriv->info->shared_can_regs) {
+	if (!gpriv->info->ch_interface_mode) {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
 					   RCANFD_GRMCFG_RCMC);
@@ -817,22 +822,18 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 		}
 
 		/* Set the controller into appropriate mode */
-		if (gpriv->info->shared_can_regs) {
+		if (gpriv->info->ch_interface_mode) {
 			/* Do not set CLOE and FDOE simultaneously */
 			if (!gpriv->fdmode) {
-				rcar_canfd_clear_bit(gpriv->base,
-						     RCANFD_GEN4_FDCFG(ch),
-						     RCANFD_GEN4_FDCFG_FDOE);
-				rcar_canfd_set_bit(gpriv->base,
-						   RCANFD_GEN4_FDCFG(ch),
-						   RCANFD_GEN4_FDCFG_CLOE);
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_CLOE);
 			} else {
-				rcar_canfd_clear_bit(gpriv->base,
-						     RCANFD_GEN4_FDCFG(ch),
-						     RCANFD_GEN4_FDCFG_FDOE);
-				rcar_canfd_clear_bit(gpriv->base,
-						     RCANFD_GEN4_FDCFG(ch),
-						     RCANFD_GEN4_FDCFG_CLOE);
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_FDOE);
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
 			}
 		}
 	}
-- 
2.43.0


