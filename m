Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67907E674A8
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78273.1766402232155994559
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H9c2JOPJ;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7a6e56193cso641060766b.3
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402230; x=1767007030; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB4bW07X3+19RYPF9ntUttO7luLRKFeH/jYS3H8a0+I=;
        b=H9c2JOPJ/KysaHz6WnLxrURJ5Go217eop/JtJfBoPK7v+NVbD9/XeBOneddczim21v
         Ck6DluVt8HOXs+WHeHPm8H2WqRin3DgkMPtiLmEOvRqZYtlPLB8V48Q6KtC2U3K6TbpF
         jNAlvqMKdkkoxPWB2AdvnssPgQpWd9ZT7FF8Cuh0zLZzFo5WFVFbRsB0GCSdwc00dYhG
         V18KE+mRM/Cg9o9Ja1Ab0CXDikc4ZKiXgB+Gzp/QbNMN5TAToGQlykTiQg/bfwXBavS+
         DzhlhA688ghCLF4fs73dOlHVAo75VEeIXB0EbsTpTXkzcXN7czSemCTRJ7Sq5psyWiNJ
         DcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402230; x=1767007030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZB4bW07X3+19RYPF9ntUttO7luLRKFeH/jYS3H8a0+I=;
        b=qmFwNReVgwOISpCMsAcDuPBAt1bx7C2RvR7DcuOvFUED1r8uGQ+9BCFoJKN25SpcMS
         nQRJIcUYjW6khjqU3YBOaQYR89pIIjAirLulXH34/JM7k1EfjbJLwX/3ypd86MJYRY3t
         m67glbuoY0wUONPGru6jbnjJVEh7Kq7zhsXjOG6tw7P44ExEidBPNuMlxoHvsmAfev7V
         NIV4edyUdPVZ8RjCp5LhYMdGU7Ll71RCli9MTFXB3eLXyAI4zEKLad+L8bGt+QVUlmKz
         KNgpCG2w4QXYb+6taqoHin0ATndPrSYndZbHFa02ldU+yKHVIt4Q5qN3IVHuYi8a5Yhk
         dL1A==
X-Gm-Message-State: AOJu0Yzd38o3umBZ/jnfMrbtH3vOMTf/0bUbji7zG2O+8hzsnC8SaxUt
	x+J6mbmQ+cx4DGF5kWcr/60PKSlGdXKdevvcZiEjQqmUYXcflscP99ZrVpSpOg==
X-Gm-Gg: AY/fxX4JU8e004k+axsZHLj2WW2zbDh4hn/b47SwcDuu3ON1QaTUczYZzzkEF3mulFh
	ori3afoCqio/nxupTd+1RdacHlIGalN7KTG4wLrscgcdHA0clMrXDxwJYSuY7BwGVtQm5N6I8bF
	uDGJZBgf4VQJdc3hze1b097anmRxShaSAOqMJQlSspBdjWSOEOid04h/fHRHePyAxG8y4ha49Jm
	VjpfTAsJRivZ/A78tqhtCqHrY0C6Ycv+XxcV8+/VR+AXVmloadJtUl+ElHEn/r1XE/DknPr4aen
	DLsyESce7l8/LMnZbCr1PM7iBb/davVLEvqxcLlaroOcaUjs97N/NIYuNiTS1JWP+udVzbp0khg
	DK7xoaESPWAKAdsTPZMRyoIygyoBvMEPw0GrbOjHgysLxrhOtff1ikIoZ9ekfBt3almP+Yd1mQh
	+VOWomJnUzDeFm3ulmYdS3Ng5952bzxKO2WKYzRLdZj0UY+g==
X-Google-Smtp-Source: AGHT+IG3dYFR1xik3hMsSKud448wKAR7zc9CR0EnQNOnCRHRNMPXcz7ybdPK+4F4J/f9XvlakIv6Xw==
X-Received: by 2002:a17:907:7fa5:b0:b76:d548:f85b with SMTP id a640c23a62f3a-b8036f2d2demr922441966b.11.1766402230154;
        Mon, 22 Dec 2025 03:17:10 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/24] can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
Date: Mon, 22 Dec 2025 11:16:40 +0000
Message-ID: <20251222111705.27028-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21194

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0a0c94c682fd2606b65a512ba24478a3b5e73d7d ]

The configuration register format for nominal bit timings in CAN-FD mode
and the format for bit timings in CAN mode on CAN-FD controllers with
shared Classical CAN registers are the same.

Restructure the code to make this clear, also reducing kernel size by 80
bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/b7643a3c49777989d02145a85b85cf773ec2123f.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index d125b416a8bc..b270fe5658fd 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1475,13 +1475,17 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* CAN FD only mode */
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
+	} else {
+		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
+		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+	}
 
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
 		sjw = dbt->sjw - 1;
@@ -1492,21 +1496,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	} else {
-		/* Classical CAN only mode */
-		if (gpriv->info->shared_can_regs) {
-			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
-			       RCANFD_NCFG_NBRP(brp) |
-			       RCANFD_NCFG_NSJW(gpriv, sjw) |
-			       RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-		} else {
-			cfg = (RCANFD_CFG_TSEG1(tseg1) |
-			       RCANFD_CFG_BRP(brp) |
-			       RCANFD_CFG_SJW(sjw) |
-			       RCANFD_CFG_TSEG2(tseg2));
-		}
-
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 	}
 }
 
-- 
2.43.0


