Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B3EF370A
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:11:42 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9241.1773043898288396194
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:11:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ggUtZ9KE;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483703e4b08so110354125e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773043896; x=1773648696; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6l+K+oWXnh9lMlEWxT/l38HmKWH3TQ+bye9iUtr/AA=;
        b=ggUtZ9KEYzRY+TLxTeEWjRMj+0RJEULeGc0l0nyy6HrMkb3kch46zhHu1+YB5zuZ7U
         Gkf+9s9rOs+kdQvK4MQ3IAzHEvlcoJbnbEfwDRB00bktCovM5KoGiyBD52KqLgWpu7KM
         N4NPA2buk3aRFf0DZYwjyDjwREEJEJaE0zuWlRzAkiXLpKO2p37lxvJhrE7w0D8RIZEj
         OMbp8yg046iKeMtIOmfNrqpKu3lFV6HdN437C3reIlenkiXfE+/xXBsLCr5SR6PEJxKd
         YLYOlvWhA2MasJaEduey0NDiKPU+wdY2KG+4iXcexJiEsiQKi+vI5PE3zuKMd068YnP4
         ZnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773043896; x=1773648696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6l+K+oWXnh9lMlEWxT/l38HmKWH3TQ+bye9iUtr/AA=;
        b=FG6BuB4xEkFxfwQ1KJIT0ptZE4asVJoXDbRQ3L7y7NIZCc+k6is+ZRJIjUhoKm3XpM
         5hVk6MtMPq7C8P6Kpl/24lba2BnU8vVbHFFkqenmCcQjRb85gwX9y0GhO/l9868HOWUe
         o4lbktIzymA+onpT9FfAN90XfLprZwYRLY54xfjuNG0sm/TJA/XmiZTZR7AH7LoDfylq
         OQJcndV8+o5tZ1XISNsLPVejNxbztm0PWMDVPA/tixdUtodApPvfJecul//5wj1Zyln9
         5AtsMD++7xddJGE5JX0qlPPFgSAN8Zt+2vM+vcXuM0oPp7I3HpHUx/H1J0P1PukOObic
         amvQ==
X-Gm-Message-State: AOJu0Yz4CEZOaQQj0gxn9dXLL1hhJ6b2MAHBvsI2+3hxf+Z2fgTDSoi0
	PAeZU5LtTJOeVmWKShYpwHdwpP/ly3Eu7mNUw75poptzhmqWXN6KIlZoHCIGIw==
X-Gm-Gg: ATEYQzyyKxA/hAMJK7aQCJfzFNAUpcJXWrgxIxCEqVFs2sKJFFMSTVHjw65V1jB8cco
	us6laxrPwOrDAqX4BHq+w016GKdEt/xjBtw7lryNIPvUneNECOSSE0wm9zv+XD++L00onoULMCT
	MQXW1Cw6rJpCXi/0C11UIrRaDch+27Ry9/8OnmHMB/S1GKx5EhDvYFgEeYSAbMu3V7QeTQrQNJf
	V23AyV/1Mdld1tGpiP372hCgQTQ3iV2XQ+e8LcweIxiU37mJFM7URCagVzrY3YYyybL9/N7iABf
	5JU1Xgxv63EiM3GqZnfBwaxvBNLAz2sxiv16jhyNnqiFqQq9SyzZu54624pFN839YMJmicZypnU
	Gq1nvjkdBfs1S3jE9r8SKcW/Jy+Rvqr0Q1F5ULAnQporg2hxVaeeKOVe84cTz5by3E9eetB33aL
	gRTqKzGvcjcn1T/vM0wHIqiFBWlOc8WqtWv/nKDb2u+qIJnVT7
X-Received: by 2002:a05:600c:8b2b:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48526715213mr148331655e9.3.1773043896274;
        Mon, 09 Mar 2026 01:11:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm4252135e9.23.2026.03.09.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:11:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 6/6] can: rcar_canfd: Add support for FD-Only mode
Date: Mon,  9 Mar 2026 08:11:26 +0000
Message-ID: <20260309081129.154109-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
References: <20260309081129.154109-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:11:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22161

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 9a2b56a48c219d189366dd9bf4c2b42afde2f361 ]

The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode called
FD-only mode. In this mode, communication in Classical CAN frame format is
disabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251126155911.320563-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 725c86e1b6a5..0d5d96672309 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -473,6 +473,7 @@ struct rcar_canfd_global {
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
+	bool fd_only_mode;		/* FD-Only mode for CAN-FD */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
 	const struct rcar_canfd_hw_info *info;
@@ -830,12 +831,20 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 						       RCANFD_GEN4_FDCFG_CLOE);
+			} else if (gpriv->fd_only_mode) {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_FDOE);
 			} else {
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_CLOE);
 			}
+		} else if (gpriv->fd_only_mode) {
+			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+					       RCANFD_GEN4_FDCFG_FDOE);
 		}
 	}
 
@@ -2142,6 +2151,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->fdmode = fdmode;
 	gpriv->info = info;
 
+	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
+		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */
+
 	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
 	if (IS_ERR(gpriv->rstc1))
 		return dev_err_probe(dev, PTR_ERR(gpriv->rstc1),
@@ -2241,7 +2253,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
 		 gpriv->extclk ? "ext" : "canfd",
-		 gpriv->fdmode ? "fd" : "classical");
+		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
 	return 0;
 
 fail_channel:
-- 
2.43.0


