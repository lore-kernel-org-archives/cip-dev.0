Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9CD31A0B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:42 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31337.1768466196332446673
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RaNrB4S/;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65378ba2ff7so1088705a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466195; x=1769070995; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTjX2F1Cut7sIT0b5Fo5qeHqRvdJjrBCxTSDSzhGuuQ=;
        b=RaNrB4S/UxyawRJ7kr9K9elpgj5+i5HbUSI6K3ujRxs+G/6+yl8sKDOrdq77CuO56I
         FhqD7Cgh5xs/CCdOV5btEaP74yJjdCNwMOHVX8MlIBUxWyJaMskxWsAYR2GwEbbAi4nz
         sFm2kxP9IGSel5ZKz9aULulvNVuc9P1SeXh1hH/6Fpc4DZpSYchheHkFW0ZyjLjO07CC
         VA0NT+P8ikEiEmeYsSezLf0zx4/PYR1VwCzmqG4jjbr9W6Xx0YNOXDcsNFISaHyonveu
         y12Boi7LYcJLOQ4KDY9mwSg/5p5Xub4g3MW+SZsVdZ7FsLFbs5i9lwXS4+2FDI/IdTu9
         Hd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466195; x=1769070995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTjX2F1Cut7sIT0b5Fo5qeHqRvdJjrBCxTSDSzhGuuQ=;
        b=gpZeZEugGslcdWggMgW/m8SP8fCMTFbdUHqF3tGoOh9uvTsBLyN36ahxAEygK1Qm1f
         cBuyIxb9u0zEVRWz+GLp5C68FbFTsPAaLL7TGQxya+8CVj3MOTGTPeZuSuu+xXNTcfVa
         7xYxRm0MrWKJbzxtoKqRtiag0ZxkgoQfgISVWrwpNtZ7TM8vhiaaukVXkjQZ2j5kecCl
         dvO6+MeyIzyYYeTMUQgGnuL9LLOAUSGlpzlhUyMeQeAz1pJ1Td7l8sZXm7npjs3hs8DX
         +bjLQOXv7zyOShG/wnEe2MDKdnP/mQSAFq9gvvo5jP/e4OSSpKibuOfrs0ZMmljaeUsB
         UyFw==
X-Gm-Message-State: AOJu0YyqyACmhSUzyY+unOLvFGUJYybl8FihFCpKuXyzWGuHF7PMt7Zq
	sTBZ1Eg7bdyfjooHq+4yfy59H3JxBVyn9e+uSXepMWLp5P3T6ZyxYZOOGyygTm7CsJ4=
X-Gm-Gg: AY/fxX5fNlz2+zp3PwOIrtPuvii9MmRrvBnIR35mpGMMe/0BPYjs4D4p+b7Qm6IBNXK
	vGara3jIJh+g2lRHPNMJ73XViBJCKuSD0wnrjd1ZaLIfg9sEwL7s8k+UNuu2cy9AH2dGcpyG+E/
	buYcPlvlLuWQn/kFnSVboeq52GBRItcMnKS9Nz8Ull1NSLksrCboUIX8zAZNMrWi0OHNF9MQaMl
	1G2ywcbxYG5eDuuV9ra1N1n1Qa13qG/h8+jRVsOUTCqfVdVwq/DcK8J8OqBKD4h5yAZxvW5QvWY
	lNngrVS3d8qjcRWhtaMDjAENMIO9Xg1vgvRMpbqhfsr8Qs3lOcOHBJV17XcltdPnpgdFtGxaBI0
	/RwC6FZYkBGmbyMJULsJh+2l8vg9a4RqRaN9n88KD+cKdfDwQ6J/HvC76l2RIVehKg4iAvxzEVz
	n/y4VRaQxGraliA/EZ4ntJSmoOQ/7Wq1kkH1Se0yGuLMYytKT40R28p227HAvL2jLhlQ==
X-Received: by 2002:a05:6402:440e:b0:64d:2889:cf42 with SMTP id 4fb4d7f45d1cf-653ec1017f9mr4321101a12.2.1768466194710;
        Thu, 15 Jan 2026 00:36:34 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 16/19] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu, 15 Jan 2026 10:36:00 +0200
Message-ID: <20260115083604.1064260-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21616

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
index c3bdc7b0b67b..812adb223fdd 100644
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


