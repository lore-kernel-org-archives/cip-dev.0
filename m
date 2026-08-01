Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21804C55181
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:13 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2454.1785575704230943580
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NyjcRdc1;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so5263165e9.2
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575702; x=1786180502; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JVz8QfeGJLS5vudk8RGaMjEHJwgG9hzgNsUtp87R64=;
        b=NyjcRdc14EvhUU2WcSgMmVDifZG7iMrDFqcoM3kaaHFAh52VPAwVM/MCtTKrKS29tN
         ooPwk0mHhKVecNSGMpE1TR3osd9jDoYcfneLAi+seTTrE5u22PiKKIkkxbEwsOYmfEuo
         470f93ZzI2HK2qn0132A4herl3wEphLrdZnZdb05hwHNgjzyvfd0JkeoO0WkUrfCtbL1
         DGs3jkr+QdYkWl809Wie0bURrbMYCbOunhnt8j16WNsOfsEQMT1PkUnVRHVre6BxzMaq
         n5gs7biKFK7UcYVF1/9LD47Ts4FxTg0bEROR1JMWvOR8lnf+o3k2WnDHWUfwTFWD7SBe
         p7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575702; x=1786180502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0JVz8QfeGJLS5vudk8RGaMjEHJwgG9hzgNsUtp87R64=;
        b=LyQcQ6LCBL7ccB0Bk2c3uOf92VJDR/IEijRKb/JJyokWrl7Ts2IHRHTg5cUmxdF3vY
         bAqq8qqlTIsmBeJeihp7FbsnGvJPTc0IrxmKDPE+nuqXMytW8eKIbvokY272UCub2gGN
         LJ37mmeFQJD9XRKT3PFrsRaEIiRZ1GQpgP3gvuf2qtXVf+PMcvg16X22B6bsPaqoZwBP
         8QPefWDIzGY1QYQOi0FL1AGaUVU5iCXe4QD2f7picAaK0ra9Ogyovu8/uefMjr4CtTeR
         gN5DW0iBa4dkDt3HKKq33qv6vrdB3xtXujtiDwaXl9SWQe+57+HzJgPat1m7UX3PZOXK
         K4/g==
X-Gm-Message-State: AOJu0YzpktKGIEpfenabzqxcaZ7UMLaFzlakzRUA2P7GYhRwbaqUirfb
	SK+0XerCkLi3Nge01rxHETKx1c6kjFFB3q1mlX/YvZ+aOIVsJY+sz0IbQrpahQ==
X-Gm-Gg: AR+sD10UuB1HVN9CFvvpic62jp0FAD8EXE5xyK0bf72cFhHSTFBP0FlNUdo+r1VTDSj
	kg/r/e+MttM4DwIn6uyvYwHV3kacHjCxSMIoFUlsl7Qvo3hRLNuv4MK3sI8nwPwF6DM6AQFW/UJ
	w5H59HjpLLR0BfFTaNq1uvjgqF8mOJkiRT04K6MNaQ6Su4F/Gtydnm9kt3V5tPucOzeD+JZgN5C
	vx/Tx8diNCCJExnUSRq3SZuD7PxQpct+lHecXQ2NwzompX3M+c1/ureG93oB60IRUHkuKnwdBQ5
	/7UCvRGkzA3tS+WLQTeotbHFyDx4ztCtsZREUNrNNNoJ2CfNCkontXks1tIXTQw3ETe/topPqQI
	gTXdP3eQ6A4w7rrm5GoBqokhK9fS14McbpuijJVFc1kTUWDYxI0KH16wV8a/wu7eZVzXokmZltV
	exn0w3vbHUl4FrAVxsRra9lQUScPP1Js6Qver4jSyj3vM8FrqM60GzyjrYtJ3AVkUQtFLi+qtIn
	E9625Bb7hQLRg==
X-Received: by 2002:a05:600c:3b03:b0:493:f262:b8 with SMTP id 5b1f17b1804b1-4980c66d884mr34363485e9.1.1785575702193;
        Sat, 01 Aug 2026 02:15:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/19] clk: renesas: r9a08g046: Add SSIF-2 clocks and resets
Date: Sat,  1 Aug 2026 10:14:34 +0100
Message-ID: <20260801091458.14026-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23830

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 29c46057d55648d88805e0412deb8729d806bf97 ]

Add SSIF-2 clock and reset entries on the RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505071544.8965-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index 0cb681358642..fe3cb9a4f0ec 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -269,6 +269,22 @@ static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
 					MSTOP(BUS_REG0, BIT(0))),
 	DEF_MOD("wdt0_clk",		R9A08G046_WDT0_CLK, R9A08G046_OSCCLK, 0x548, 1,
 					MSTOP(BUS_REG0, BIT(0))),
+	DEF_MOD("ssi0_pclk2",		R9A08G046_SSI0_PCLK2, R9A08G046_CLK_P0,	0x570, 0,
+					MSTOP(BUS_MCPU1, BIT(10))),
+	DEF_MOD("ssi0_pclk_sfr",	R9A08G046_SSI0_PCLK_SFR, R9A08G046_CLK_P0, 0x570, 1,
+					MSTOP(BUS_MCPU1, BIT(10))),
+	DEF_MOD("ssi1_pclk2",		R9A08G046_SSI1_PCLK2, R9A08G046_CLK_P0, 0x570, 2,
+					MSTOP(BUS_MCPU1, BIT(11))),
+	DEF_MOD("ssi1_pclk_sfr",	R9A08G046_SSI1_PCLK_SFR, R9A08G046_CLK_P0, 0x570, 3,
+					MSTOP(BUS_MCPU1, BIT(11))),
+	DEF_MOD("ssi2_pclk2",		R9A08G046_SSI2_PCLK2, R9A08G046_CLK_P0,	0x570, 4,
+					MSTOP(BUS_MCPU1, BIT(12))),
+	DEF_MOD("ssi2_pclk_sfr",	R9A08G046_SSI2_PCLK_SFR, R9A08G046_CLK_P0, 0x570, 5,
+					MSTOP(BUS_MCPU1, BIT(12))),
+	DEF_MOD("ssi3_pclk2",		R9A08G046_SSI3_PCLK2, R9A08G046_CLK_P0,	0x570, 6,
+					MSTOP(BUS_MCPU1, BIT(13))),
+	DEF_MOD("ssi3_pclk_sfr",	R9A08G046_SSI3_PCLK_SFR, R9A08G046_CLK_P0, 0x570, 7,
+					MSTOP(BUS_MCPU1, BIT(13))),
 	DEF_MOD("eth0_clk_axi",		R9A08G046_ETH0_CLK_AXI, R9A08G046_CLK_P1, 0x57c, 0,
 					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_MOD("eth1_clk_axi",		R9A08G046_ETH1_CLK_AXI, R9A08G046_CLK_P1, 0x57c, 1,
@@ -356,6 +372,10 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 	DEF_RST(R9A08G046_DMAC_ARESETN, 0x82c, 0),
 	DEF_RST(R9A08G046_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A08G046_WDT0_PRESETN, 0x848, 0),
+	DEF_RST(R9A08G046_SSI0_RST_M2_REG, 0x870, 0),
+	DEF_RST(R9A08G046_SSI1_RST_M2_REG, 0x870, 1),
+	DEF_RST(R9A08G046_SSI2_RST_M2_REG, 0x870, 2),
+	DEF_RST(R9A08G046_SSI3_RST_M2_REG, 0x870, 3),
 	DEF_RST(R9A08G046_ETH0_ARESET_N, 0x87c, 0),
 	DEF_RST(R9A08G046_ETH1_ARESET_N, 0x87c, 1),
 	DEF_RST(R9A08G046_I2C0_MRST, 0x880, 0),
-- 
2.43.0


