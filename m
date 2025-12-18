Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F79D6E2D1
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1410.1766076969321093519
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dAfvZ6ta;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso10444345e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076967; x=1766681767; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrav2i/Rv2KNSk8jYVPSiF5II/GF8muU61rLGmbKdUQ=;
        b=dAfvZ6taUJPD7NE6xfGWLuF6oMdJuW8ET19/uwlaTLi20bIbc2/4eNO/ijrcr0DHA7
         I2aiRXAX2xHFknGrdd6lz+030STEL/z/1Osb7buhDp83zQDQmuSPfuVn49eHDXVQ4T+P
         GkVpoYQkC3Y7LGNDmA4QZFwR6+H95CLGak6TvKxk0moYmIvUsAvfltZXq7Fo/wwhgo9Q
         su5vO/ipINkU6adEPLe1cNdgL/2IEVQaRWs43HHGWHf1BsyIry3V55HpbNWc6erD/0tP
         EJnzcrjsuYhNzMyQAFIunsziQ84vYtRDcWNovuHfQRrFA1/kpI3B/Zy+HU/ZZt3hbLJL
         1D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076967; x=1766681767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vrav2i/Rv2KNSk8jYVPSiF5II/GF8muU61rLGmbKdUQ=;
        b=t1CKV1ObI/lyM2z/IKUdWuGSZdwpBXhzslJ8dvLzCYZOnbcjILrT4CnyDDLV+Ba0Sj
         Qqw8UbpBWGPnLqWrABq6b4gaFYVM0BtOmY/ZSbEo7pz7QhtXQi9y2db2CSL6wANYIrcN
         8DDyiUQCXJ2I3Xs6E28qHrR/R6aHzKYHV0pxcv2t5jlOLA+K+oYlBkwlE6MaWHyGaZxk
         I3hrow1gtemRGNBPMOYapKEEJwQ0O5YpUgeeNJYUU+vLptMldQx4KoARi207a+/SG25S
         at/bsH9T09Hxq8YOhIIqcdqUPkHUD4CiWjt4gG0YoP8Y48W0v6+ou5jA2qBK7uFpmfXV
         dUXw==
X-Gm-Message-State: AOJu0YyOrPxalLFGRm2DrUciB3Q5ihqwRTvjhcndz/5Xix3PxNpEX21B
	NcB6HeAqf1K49dxQgmSdmobdJIJhfq7A05H0AKpZw8H/Tz675eILj351bhpgpw==
X-Gm-Gg: AY/fxX75cr5nlLFQ2Gx6Nui7J6thnCEo5upwyfRqVvShmirEaMLYt13mFWouElqMy7j
	4cR4oLR68eAX7GPfRvUqR6W40BUsMP3A8iWi/dnJ9KLhPNjE65rZeJsNIgCXMAAQjL7vGucXBTc
	KPACeeWikCVaEUszJWjcFZo6GLoQAhhTQyrwTlK6CTYqNEQ5yvqr+3Ua2Grb9a5CjL2+jMkb9Py
	DMGroA+f5/9W1oyFABBa78fdSF9nA3SJ9mnGRvb6Oz47dZmREXxwJ/6eYVMb+ZcrqfMd5qHp0O1
	r4aSV5cbpeL1W62fYJobxxrCp98VlEF4t/zL4/6n3JNq9Z3xRUXO3UopgtvkEazHM+LUP2L9ppZ
	uDB9ck48cR0nQfeuULjb9ZRTJxweP/e/P0CuGDk/HxRBrtVpkUc0SmGHKqv2T2IE1NbNUIbJksP
	rB+9mfta+uhhYto0Hnb6PE0RFYX3p8
X-Google-Smtp-Source: AGHT+IH1eInt3p5Fy+yw8ePN3cnVAnBhelA9ekAMhlQ3tzJzmmDhh1R8oXozz7AdcFYMGGql/TTEFA==
X-Received: by 2002:a5d:5f96:0:b0:430:fca5:7353 with SMTP id ffacd0b85a97d-432447a3dc1mr3682917f8f.8.1766076967340;
        Thu, 18 Dec 2025 08:56:07 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:07 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 14/24] can: rcar_canfd: Update RCANFD_CFG_* macros
Date: Thu, 18 Dec 2025 16:55:13 +0000
Message-ID: <20251218165600.258194-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21152

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 726213c8e79a615497816b76c9d236aaf8a47053 ]

Update RCANFD_CFG_* macros to give a meaning to the magic number using
GENMASK macro and extract the values using FIELD_PREP macro.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250908120940.147196-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a9b72e95464b..848fdd820438 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -104,10 +104,10 @@
 /* Channel register bits */
 
 /* RSCFDnCmCFG - Classical CAN only */
-#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
-#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
-#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
-#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_CFG_SJW		GENMASK(25, 24)
+#define RCANFD_CFG_TSEG2	GENMASK(22, 20)
+#define RCANFD_CFG_TSEG1	GENMASK(19, 16)
+#define RCANFD_CFG_BRP		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
@@ -1413,8 +1413,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 	} else {
-		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
-		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+		cfg = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1) | FIELD_PREP(RCANFD_CFG_BRP, brp) |
+		      FIELD_PREP(RCANFD_CFG_SJW, sjw) | FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
 	}
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-- 
2.43.0


