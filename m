Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773BCC44509
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19434.1782820138324582867
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=L5+AZBbC;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1900768f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820136; x=1783424936; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/syzYoLnvC4gfqw1hDYXQnEjRFWTTPoE3lzZqmlnFdY=;
        b=L5+AZBbC6vuozY+8cIXSO1Uy1i2/e9Zw90dTLMrZ4i7GYhg0uWLouKtElsNOPSMQDH
         7lyzi5il/HgSxhSAKOpO7Wypb1eZ2W9/O4Ya/YO5GFfM8HJFMsBss5Ks5szmapX4D+vY
         GyQrpIq9kllyEjgG37OVRTc2xzW4wZM+n7mh5XWyXxMhVhBLXQpsud5pLBbRdmiW+XEp
         F3SbVw9aSx/OWksCRdw6oh6UKv364dhq50Fn2HGnX9nqqqrkkRZnaDAU3seKVkslyvvi
         EatsyIoY1YCyfNF3Jhop1NUWldmkNPWKm3StRKoY5vzHl57/eieFSwSsb51b1bU6/2A8
         xrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820136; x=1783424936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/syzYoLnvC4gfqw1hDYXQnEjRFWTTPoE3lzZqmlnFdY=;
        b=tUkER/m/LdcDXqSILatgriWU8gHNVZ9KB194jGcDT7CVVtVYZp8kLEZNmwDXopJOsF
         lcmIozMMSYZIOt3wu7EZntGe9DdtcvlcZ2ricl2EiVHSpdt46EwpACERNG8KD8gV2IMT
         Xf8u2ch50wqxqwFfAfz7h4SAvizFHIRgwLef3dRxKQRVzl0C2bkxvKXmfE9HuPr16b45
         vtF+Hz/9fi1H4HeuwBXxAgzskoJyDpfqSVQqjLnVDW/8/rVuZXIvLHHQ9i+eytXh1qyb
         VQtMqPSzNrnqjZBxaLyrtdQrcjqDqsx5/RtkcvduQjPb+ptcUlnGLVGFRAw5AZJC3FVD
         mOvw==
X-Gm-Message-State: AOJu0YwDs7ouUuBsIcviPXa7kaBoX8oxyJaOs0ahNt9i+H4frTSkzApu
	eHyCrskEgCO/uYG9hoRaecjV7MNSM8R29NEBD7hJaqZg8ldZrFyoVrolaPhOcqxi
X-Gm-Gg: AfdE7clRB0b7wp5jILMzAjgf/W/4UsDx/b97fTMGaMouPBWCuXwgai2ULw6rkKnDGXo
	0UXOVVOTmQKHb1H6t7BPmafyrf4p5ihh6NOsw04u1JoR9alBl8XkZ2l1ArDe/OBelE7BbMeKOyN
	vOFB5dKiPR+0U1D6aHOXbeUfBzJRAMyKF46pV3c5jaSBdOju5EHH9zoP44r1knnQXSCC/zXEUiB
	XiEBwvq4gEucw1Tce8kl3xMld4D8WhpVy3+btdk9EvWaa5xKdTdmQK8ASuWCyWYlc7edRB0N08x
	8NjcKEifpUGJ0wLLL308oRS42VcuqU2Z7CCcg1XZJNbqzj+opZ1gDMGY2Lej8vo4OPt6ZwxKMjr
	eP30M0fEZN49GRigVSU4dBRiDZrWyX62cXLtbiMVmwsleaXaR/PlqIaTs64TlAsXqO9yLOZGY1b
	KeZEbMUGrW/VDbl/y68f2SZcMwhzzLmV+zPDN8r/7YcoKxp3Yy
X-Received: by 2002:a05:6000:2dc3:b0:461:a161:8102 with SMTP id ffacd0b85a97d-4765a4ac3a5mr229366f8f.28.1782820136504;
        Tue, 30 Jun 2026 04:48:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:56 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 27/39] clk: renesas: r9a08g046: Add WDT clocks and reset
Date: Tue, 30 Jun 2026 12:47:46 +0100
Message-ID: <20260630114813.92739-28-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23351

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit c03f83f2a36291acca0b6638e91ab384fc319945 ]

Add WDT clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260330132349.149391-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g046-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g046-cpg.c b/drivers/clk/renesas/r9a08g046-cpg.c
index d47aeaea2d6e..a311e17958d1 100644
--- a/drivers/clk/renesas/r9a08g046-cpg.c
+++ b/drivers/clk/renesas/r9a08g046-cpg.c
@@ -218,6 +218,10 @@ static const struct rzg2l_mod_clk r9a08g046_mod_clks[] = {
 					MSTOP(BUS_REG1, BIT(2))),
 	DEF_MOD("dmac_pclk",		R9A08G046_DMAC_PCLK, R9A08G046_CLK_P3, 0x52c, 1,
 					MSTOP(BUS_REG1, BIT(3))),
+	DEF_MOD("wdt0_pclk",		R9A08G046_WDT0_PCLK, R9A08G046_CLK_P0, 0x548, 0,
+					MSTOP(BUS_REG0, BIT(0))),
+	DEF_MOD("wdt0_clk",		R9A08G046_WDT0_CLK, R9A08G046_OSCCLK, 0x548, 1,
+					MSTOP(BUS_REG0, BIT(0))),
 	DEF_MOD("eth0_clk_axi",		R9A08G046_ETH0_CLK_AXI, R9A08G046_CLK_P1, 0x57c, 0,
 					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_MOD("eth1_clk_axi",		R9A08G046_ETH1_CLK_AXI, R9A08G046_CLK_P1, 0x57c, 1,
@@ -270,6 +274,7 @@ static const struct rzg2l_reset r9a08g046_resets[] = {
 	DEF_RST(R9A08G046_IA55_RESETN, 0x818, 0),
 	DEF_RST(R9A08G046_DMAC_ARESETN, 0x82c, 0),
 	DEF_RST(R9A08G046_DMAC_RST_ASYNC, 0x82c, 1),
+	DEF_RST(R9A08G046_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G046_ETH0_ARESET_N, 0x87c, 0),
 	DEF_RST(R9A08G046_ETH1_ARESET_N, 0x87c, 1),
 	DEF_RST(R9A08G046_SCIF0_RST_SYSTEM_N, 0x884, 0),
-- 
2.43.0


