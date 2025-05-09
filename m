Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F28C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10316.1746783133241502715
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=S02coRlS;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fcab0243b5so595551a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783132; x=1747387932; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz2+NBOEMzykqSdQUiqT27vAGcdakk/48AzZDTVj6YY=;
        b=S02coRlS63nOUt/hXHW9yYlWemK0z7m7HHZ2Pr5kL0ZmYnrh+yLr8MbfYj5wU9ka8N
         W4cZAUJEB5M7VEh+d658GdpDNeIg5QokMyDbq9z8/FXSUGQquT71VJRLiiVDcFWjW4VN
         9cXfUaudl98TY0F1u7TCYJ3m3WOArVC1/ew3Q9humKicQ2dM5quR+tOmjXo5jjPByYq9
         ZhQrK6IFdmTJm/aceaN8JniwI2pzkUhAU6wN1JaKb+tj/S+b6HA3Brto+AU14COrIyL9
         p7Qtmt24daM2C2nH/0IWKen3WM5XZ1PN4har3QJ/01zTwyAgGtki1Mp5sqPLaHuz9DJ7
         kypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783132; x=1747387932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz2+NBOEMzykqSdQUiqT27vAGcdakk/48AzZDTVj6YY=;
        b=eD3Zd9vHdHqgkPd9nrtNRNaSUvLmu22LZJ1II1hmsCT3Z9q+ssC+cR+ACN7A0IXtQx
         3zezTo7L9DTfOT8WGa3didgOJlbGhsH07NkN/zUMWQKi9QrdNLU8rsq2DUdpAhfBqgzg
         M9FO9R4r+eUPkh3yGamijhsiv96BvFq/pq5dSka/+6lEP/u+YDdiX8yigopA2+UNdIiX
         LwJaG9+KCTSCmZkgl41rHp2G07ANxufKn01jmSns91zxmoyl/GBlzmlOfYktrp+r9xs5
         BpyhfLYusLVoDk2LSjbL9V6QhqPQM6RRr05XFtrOhOx6jZSBWCQJL7BxUsphYXCJ5tLw
         vWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3HRNp7809KJ7qjTA03WxDPaCgWhfy3RXLTjMzSBL1ywtyabIMM0x57hPPGE50N3fARQxnpjP7@lists.cip-project.org
X-Gm-Message-State: AOJu0YzZM3okhA+KA25MMxv1LWZuDdofcdX9RNHL8lA6i8Jj83Uf/b2k
	OdtloVoEANRgwpp9ubjkYfZ/HwgfMJPPlfAsv/7Dw2pntrkuU0oCf7hkV88l8xU=
X-Gm-Gg: ASbGnctSI54pJSDTlNkJrWrqlQ2bW0aj/pCn6ykUPiRgd+E4ohw/sb/enqtk3PBRWWy
	5AXU9ARK+5OtuwnQMnm2X5aERy4tKU4ssbpZGYbn1INkDOlvGT/PLFOuw5SQiSQKWe0PUELUqZ2
	Fze9QP0R8hgxRQsPmSiYVUED2mUC9Mh9EZTmd/7CJGSj+EUbUQrXFp8M66Rb024tuN5P9MMdz6/
	zvmp7JPtbuod49DMRGCmDO5pp1EKEC1sYoOU9kNHYBvzxjnZAoetYSlbaKQviXcox/QeWc2p7ad
	Y2JSrMFSGYgejN8Or2GYw7h3RlVgyNZvk5FQtSMvvAEmSvNzVZAwDUxuMlNgkDT88OQ3LA==
X-Google-Smtp-Source: AGHT+IFibN+pOfBes/mNSnGISAdRJLXgtycnQ4RWn31bEkXa0jEQa0w11yQLJqBLuusdFrA5LH8EcQ==
X-Received: by 2002:a05:6402:4306:b0:5fc:8d7e:51 with SMTP id 4fb4d7f45d1cf-5fca07edd19mr1883200a12.21.1746783131564;
        Fri, 09 May 2025 02:32:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 05/29] clk: renesas: r9a08g045: Add clocks, resets and power domains support for SSI
Date: Fri,  9 May 2025 12:31:39 +0300
Message-ID: <20250509093203.4014750-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18792

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 97088b3a8e71ed87fbb25a34b222d869033d73df upstream.

Add SSI clocks, resets and power domains support for the SSI blocks
available on the Renesas RZ/G3S SoC.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241113133540.2005850-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: use RZG2L_PD_F_NONE as the last argument for DEF_PD()
 instead of 0 as it was in the original commit]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 1ce40fb51f13..74413452221d 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -208,6 +208,14 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
 	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
 	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
+	DEF_MOD("ssi0_pclk2",		R9A08G045_SSI0_PCLK2, R9A08G045_CLK_P0, 0x570, 0),
+	DEF_MOD("ssi0_sfr",		R9A08G045_SSI0_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 1),
+	DEF_MOD("ssi1_pclk2",		R9A08G045_SSI1_PCLK2, R9A08G045_CLK_P0, 0x570, 2),
+	DEF_MOD("ssi1_sfr",		R9A08G045_SSI1_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 3),
+	DEF_MOD("ssi2_pclk2",		R9A08G045_SSI2_PCLK2, R9A08G045_CLK_P0, 0x570, 4),
+	DEF_MOD("ssi2_sfr",		R9A08G045_SSI2_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 5),
+	DEF_MOD("ssi3_pclk2",		R9A08G045_SSI3_PCLK2, R9A08G045_CLK_P0, 0x570, 6),
+	DEF_MOD("ssi3_sfr",		R9A08G045_SSI3_PCLK_SFR, R9A08G045_CLK_P0, 0x570, 7),
 	DEF_MOD("usb0_host",		R9A08G045_USB_U2H0_HCLK, R9A08G045_CLK_P1, 0x578, 0),
 	DEF_MOD("usb1_host",		R9A08G045_USB_U2H1_HCLK, R9A08G045_CLK_P1, 0x578, 1),
 	DEF_MOD("usb0_func",		R9A08G045_USB_U2P_EXR_CPUCLK, R9A08G045_CLK_P1, 0x578, 2),
@@ -237,6 +245,10 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A08G045_SDHI2_IXRST, 0x854, 2),
+	DEF_RST(R9A08G045_SSI0_RST_M2_REG, 0x870, 0),
+	DEF_RST(R9A08G045_SSI1_RST_M2_REG, 0x870, 1),
+	DEF_RST(R9A08G045_SSI2_RST_M2_REG, 0x870, 2),
+	DEF_RST(R9A08G045_SSI3_RST_M2_REG, 0x870, 3),
 	DEF_RST(R9A08G045_USB_U2H0_HRESETN, 0x878, 0),
 	DEF_RST(R9A08G045_USB_U2H1_HRESETN, 0x878, 1),
 	DEF_RST(R9A08G045_USB_U2P_EXL_SYSRST, 0x878, 2),
@@ -288,6 +300,18 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 	DEF_PD("sdhi2",		R9A08G045_PD_SDHI2,
 				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(11)),
 				RZG2L_PD_F_NONE),
+	DEF_PD("ssi0",		R9A08G045_PD_SSI0,
+				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(10)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("ssi1",		R9A08G045_PD_SSI1,
+				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(11)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("ssi2",		R9A08G045_PD_SSI2,
+				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(12)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("ssi3",		R9A08G045_PD_SSI3,
+				DEF_REG_CONF(CPG_BUS_MCPU1_MSTOP, BIT(13)),
+				RZG2L_PD_F_NONE),
 	DEF_PD("usb0",		R9A08G045_PD_USB0,
 				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, GENMASK(6, 5)),
 				RZG2L_PD_F_NONE),
-- 
2.43.0


