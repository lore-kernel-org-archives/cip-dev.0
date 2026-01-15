Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F25D33A33
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:31 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31304.1768466123860406393
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P/xHDLdC;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso1107447a12.1
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466122; x=1769070922; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQRi0w7/F0eBzGT0Id8epD7eZdOUXbrU1HlqPRSFV8I=;
        b=P/xHDLdC/57eAqW4KKswL8Xx70QHTjnzqDQtYF/yUiLZt7a1WPgBFTDzcdXZ7u8jDy
         huKzprKwq45PuGYXteGkBHDUzsMiTzFJ9spWQGziICHOES362EVdFi1lrHxZS69RTg1H
         thIyHRqj+ZjzxyKQ/f4UKF95qg3353I+98EOiY6hwD057fi/CcAP15e+OMG42XOOvxO9
         RzWvrFIEQ60QPqOSyo/mot9H2fSZaTmU2aSH/aT8rKQBL/JwqqrCPR7p8fSqG5gDRv/1
         WhgBZG+CenVaGWZ3fcHzS/b3neQyigRCZEF+Zv+AjofaO72MLNCQd4otbSd8j5xN4RAI
         zizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466122; x=1769070922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQRi0w7/F0eBzGT0Id8epD7eZdOUXbrU1HlqPRSFV8I=;
        b=GJjvVryoVc42UIgCUp+uC++wvjk2W1H2XGVicDww4Q7m8zH9uIsNTQNWGOFYKVsXAJ
         QpVE8KUEzRJ13DvpAfXyJXjDT/e8aXJLJebfaqvCrOg8Ht9ZLP+ZYmjGutmIcbjKHHMj
         Vxvtwopr/Nq9rTL2QNCTG5i1dqVofJ/05eOq0s2CrVi9aq6jK7Oe2EcI7MHRJGhNnSJY
         V+LlBw+1rOjGjChkgBlhDw0KF+jng0H1zUJ8AeaKSK9y8BZ5Zq8wSHSdYXn1psdOanwC
         PQyYHZJySsG4nRjLwbycJEB4KAU4xZ9MD8ixgaM6M9JFyYCUhRoaoBhi3zkMf3qcFZ+W
         tPLg==
X-Gm-Message-State: AOJu0Yy3klcWdRjqIiGgPZz0KYKSSWxdQk5RbeAzvBJG3t6toxyt2uWs
	3+j/qXfAr3lM2dFYNztuUwDxjZBkAR7A9PYC+CWQDz0wZM4GLNgv5DJp/k/SMS1AhZU65jWJzRD
	S4HXd
X-Gm-Gg: AY/fxX7NjBCGuiNTm2IcluMnj689B2t/p6xv0sKeMhaMQJBfOn/78w+tjVMp83qRDID
	JS/j/3NOWEKm4jItZITQloOIimOk8meLYw3BsB/OAEbKtCztO/vLKv9SvxfC1OUQLCONSIYM4Rk
	R9K7bYUbQz7CjpR0p132KFBx9GpxC1sl7jpnH2eWThKJXXX6bWJKTTQt99HCW7Lm/IsqDaYgIbK
	L8XWUJmB+wLUtSydR/B5/SHNcoa2Ivcz4RllaZwqxlGXVzcm/Lk3aWwzP0pgWRqSdKln50UzO6H
	uJKG4/hmat3dhHoZVEZNPS3SOSkaWkDkmkgto4lEQppKTedjAUeNc89av3QH9npUQp4s6Al7s1x
	1mE9yYZ/KJC1ogNMf/k3DT1gdSRZCndsVDVM97oRwsol/LNFYZ8SJYHBbQ/AC3ZyBUdXoP3ZEE4
	pk3goGshwhLTe37bnQHtWbWNmEZuVejl31Ns8e4fuRqkzKW0NHkYmQOPJX9ikvfXGZKA==
X-Received: by 2002:aa7:c918:0:b0:64b:5625:c519 with SMTP id 4fb4d7f45d1cf-65413173f63mr1492061a12.10.1768466122119;
        Thu, 15 Jan 2026 00:35:22 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 16/19] clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
Date: Thu, 15 Jan 2026 10:34:48 +0200
Message-ID: <20260115083451.1064048-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21596

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
index 4351bae7b8bd..87c79df6406b 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -247,11 +247,13 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU1, BIT(13))),
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


