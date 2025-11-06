Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B80CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:24 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10071.1762416678836513143
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BELKlrCz;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47109187c32so2697005e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416677; x=1763021477; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBXNsfD4B2DO3Bx7Ss2SQ+1DELG6ogi6mtqqqH8JvT4=;
        b=BELKlrCzwAcoNMB47kXuelkZhm1BC6H+R7BTlprbpO7Aa5Tod8qphjSD1Y3fJv/APC
         3NMuVdLU3EBE5g+LDjB2LKlvyTfd8bYmrz2RPmaejtgMvAKoT0/AAA+M5OTwouAQ2/eS
         ZK5oRXenp6Qg3b7tpSEn+Sqxs8Yq0V7pgIvq6fSCk0Alhok5Kfits+9PTp1TO3Yjcixl
         vB802sJfzsAcZ6TIlbJXJp+ETQqzXkPQVOUVKzKBqbeBRTDuMvU8TAb/af3gg8bJ6TsN
         E2mlAgDuTiRB6Uh1M7LsHYZhpLay4n++dZtXxZmWO+1kYyqqdPUffJY4Vz/rK/kpQ/0v
         U/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416677; x=1763021477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBXNsfD4B2DO3Bx7Ss2SQ+1DELG6ogi6mtqqqH8JvT4=;
        b=AsXzcUWiklcSG6G3k7USBfMHKgM7KWezhmJJD6Y6K3qBfup+j3WUpwVkJERu8ubwo6
         bIsc/YTlmfSlgN7xtZ0UfSu4FFyi0SyIaRp3R28OlMD15/LAUWr3mtsEDigx9wJNmVDd
         /hkHeL+EUGVx2eJ+qbmp1EedLwCl0HgC2gexDzmwJ7ZsM4RRLSjNa5osniAn2a5diCgg
         MJ7dFh/Ns2y2toRpYWhcKtZkGK0LTqLoQ5lVoXF3tevVoVOTeZDEmeb9ZVafYyBYaLSs
         dEYVgBHQBOz9tnDW/ozmhZYxC2fbuuxC1mQcRD5TWKrv1J29PeLe1QsneynLhbaiSB+E
         T1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW/RUBJ+Pt0y2pvfGQvQ/KFvOp3Kv1XCiQOsw/wibBSTuFDLIbCqq2GjV9mXmMSFlvMEa4HnYik@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywyz+5tabT4+4qzL/QUUjuUTL0ZbFhxb/jLRsZPVFm1w/76qI09
	bqof1Ar9oxCWb3uvpyzpwqtRvDc8nFLctukYZ4gkpDnystMA2Zh1qt+svfBzJ8Opn/0=
X-Gm-Gg: ASbGncvOMVfANzIfTSIgo9yqPhnQVPSekOpB8Ewhy5/Mu+nxQjNNAB1f0plStWuGSIT
	4qHER9AoD5rNaluxmC3xoY7KPUQxXpdkk5X6ieTPzIbOuXZhWZEsGrSFAvkHLpaBh+wvoepiT9w
	IYccp4OPt6Jp0taelQS3Ukg+7q49scnjS4c5wWnwU1F8aQRspKdnxTJ0dF+KjjDlfuDy+J+KIOM
	DKnxzKybbxR9kZgIGwB4XN3SxA2ELQQCt/CdrzEP1BFxblWahMLes7rLJZ3Q68TwBZJqf8aTwRd
	3kDYPQVopg20aL2ejnQ8TZN0HnQrukIB3k+38Sg6+mBNZ2QVrySwOhBBGgn4qryNimHkYmCiAsC
	e7JxT08L3veJ3+nRWb0DerndgNz3fAvhc+AM6GIe7YtEwAWziYM6dy+rKRIsT6F8NM2JLGFdzgz
	kqpGfp2SFQGbxJKcRJLdfpByhqdUwqCSLpvPeeGxBB
X-Google-Smtp-Source: AGHT+IHBhXktQPeqMzNcF0Z3H+Odw9fe7sugrC1h/WsD3QyZzpso0XXPMYzzTrxKaHDbRG0FOTYhYg==
X-Received: by 2002:a05:6000:178a:b0:426:d82f:889e with SMTP id ffacd0b85a97d-429e32e3fb0mr5349689f8f.14.1762416677203;
        Thu, 06 Nov 2025 00:11:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 19/23] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu,  6 Nov 2025 10:10:44 +0200
Message-ID: <20251106081048.2574345-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20388

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0ab2d84f94dae48c3e7605cdc99dbb4e7c7b206a upstream.

If MSTOP is not added for both clocks in a coupled pair, and the clocks
are not disabled in the reverse order of their enable sequence, the MSTOP
may remain enabled when disabling the clocks.

This happens because rzg2l_mod_clock_endisable() executes for coupled
clocks only when a single clock from the pair is enabled. If one clock has
no MSTOP defined, it can result in the MSTOP configuration being left
active when the clocks are disabled out of order (i.e., not in the reverse
order of enabling).

Fixes: c49695952746 ("clk: renesas: r9a08g045: Drop power domain instantiation")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250704134328.3614317-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 6f0bdf9b6e4b..c1365385d61a 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -255,11 +255,13 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_PERI_COM, BIT(4))),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 0,
 					MSTOP(BUS_PERI_COM, BIT(2))),
-	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0, 0),
+	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 0,
+					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_MOD("eth0_refclk",		R9A08G045_ETH0_REFCLK, R9A08G045_CLK_HP, 0x57c, 8, 0),
 	DEF_COUPLED("eth1_axi",		R9A08G045_ETH1_CLK_AXI, R9A08G045_CLK_M0, 0x57c, 1,
 					MSTOP(BUS_PERI_COM, BIT(3))),
-	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1, 0),
+	DEF_COUPLED("eth1_chi",		R9A08G045_ETH1_CLK_CHI, R9A08G045_CLK_ZT, 0x57c, 1,
+					MSTOP(BUS_PERI_COM, BIT(3))),
 	DEF_MOD("eth1_refclk",		R9A08G045_ETH1_REFCLK, R9A08G045_CLK_HP, 0x57c, 9, 0),
 	DEF_MOD("i2c0_pclk",		R9A08G045_I2C0_PCLK, R9A08G045_CLK_P0, 0x580, 0,
 					MSTOP(BUS_MCPU2, BIT(10))),
-- 
2.43.0


