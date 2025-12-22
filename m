Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD6E674A1
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78277.1766402235357764404
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f3wjqYXB;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b72b495aa81so630953866b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402233; x=1767007033; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYd0n0TtfUVlK9H1kCmdS4OxLblnz8yPHJLhtl2fwB0=;
        b=f3wjqYXBOdcrC6ZsU60TSXMSDJqPl/CSVdDtiiId3k8h7KhupphcfLeBebq70+LzSH
         ulvQVDr5BvccBZeOWi7F2CT9U8x2Ho8sh1Ohv57UBv/xi6a5VqV8zRZejK0j5Uu3fiiQ
         8KCl6/p0iSHd7pOtM82d4QN9dH2QuXS7Az2+l/ju+Nh4zyHImNDzJwBQyWoReZyP1CCt
         QMZ2+3KdDsQqLP2zctT8k/KGWOAFoCZRQfkBTD9jqO3QDI3FVu2wzt3mmbHR2mjxhQJH
         HY0NfShU9sp+E2aVfihhos5SMRog4J2ZQsaVsrEwDR5Lu3oQ5KK0ZM/5tC/B8UK0i+tY
         uIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402233; x=1767007033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYd0n0TtfUVlK9H1kCmdS4OxLblnz8yPHJLhtl2fwB0=;
        b=OXOPtKu43mIKxsqOxxaE02SOKfz6ManeyAPh3NrOLuhSQdrQ7/UFkdlnMQzRXlK/7w
         Xzqs/SidJs1eB+mumrGUh2XqA8jyoHKixEsUXRvnXUSvhVh0weXhPNNxg007jUsuz6JF
         Y03u7jK3H/E2TdRnWTY1s5hmh02Oc/Je13rNr28IbsTTD8/NJ6VGlUcEQ2e1rGUk/eY7
         Q9hGzUzttSpj6pwkBKAUMclZH9I2BbTDxBF34bXokK+/l+p5EHkwE+Vcd0v4qUewkG/Z
         SbnV7PSXCwDY+GkUDw4vWt9HicEXQ9CeiJUUD6N0fjZGFbm6okkD0T0uQ4P0zh7HFSg+
         a2/g==
X-Gm-Message-State: AOJu0YxIkNL3unxyEVoqYlfNfXzi4WAwciiJMAvHgMKPPjMJIeM5BO/V
	p0LcstsDTa2NJpvNAy1xw/0Xs2g+Kz9rc2cl1gNG47CSrgO+9EcjAgjrmat1LQ==
X-Gm-Gg: AY/fxX4UZHxfQ2GYmHOL3P4Xwpdw/meXWnxfZ8cSPne8crkGDjWF+IMJD9XdrjWlIL1
	Td45yvkw9uTQWWSzkoo75toa0CSgsQaC/uDBesWWZhAAwZDVxPxGNp/SzhzJOfF/5E6+NW+hUOK
	wOL4R7pBqsfxi4YqRAYeHt6twXyyui5FoAKir0scz6OwzL1GB9ihnDOYll6JkEgkaO4BJl29jXB
	i8c+04PrKRef5Ja7yeGvuT6NBt6I84q4r7byM+bUUtIqdGvpK6lkLTYfoQedWtQ32qYTVUFI1Xm
	OzXcs/yRZISxKSTe7AHKicGMCa9vxAqXuSMf35R7y/hxSBWxpdfi7RzQmq4Y4hc/CYMFoDpgozN
	8iN3V1jrcgnD7dWjMDCoH1u6beWG6+xdCCxUHfz0CTyQi7nqxugiyuCxoUbDTdylQVxfjb6tH8O
	Rjmt26y6/pY6/OeBMSAe+9X4EN0AF/FgLSfbw=
X-Google-Smtp-Source: AGHT+IG3RFmwghbxkMA/zSAaGl91ZJmnmIwRyayPqMP1XaNcKHJt7f3HrV2RIohMkpEbhZNy+O4pew==
X-Received: by 2002:a17:907:2d9f:b0:b80:751:ee5b with SMTP id a640c23a62f3a-b8037257594mr1072749966b.49.1766402233390;
        Mon, 22 Dec 2025 03:17:13 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:13 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/24] can: rcar_canfd: Update RCANFD_CFG_* macros
Date: Mon, 22 Dec 2025 11:16:46 +0000
Message-ID: <20251222111705.27028-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21200

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
index fb089a9d42ed..3b93d1e40087 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -103,10 +103,10 @@
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
@@ -1412,8 +1412,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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


