Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE74105D28C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:19 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18260.1773227048744999683
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=C6I6jKTG;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so43306775e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227047; x=1773831847; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvKG9W5EJzOGVWUHViOwYaUbAHINI6d9WZJfW7/MD+4=;
        b=C6I6jKTGEle4ki5Q8l8goa6Ymr2s/7LMHdlgDJx8f3XUYFeeNha2C0LXN1FPad25I/
         cLVE0+GjThT1CEf43gBI27L3zYbvqXWHFx4hma3NgCllaOj1Ac6T2Y8AbxYyqDjKB7qG
         FMFIoa3b1rPFn0eHkfzqeRvq2WioAfaY+MeAlnS3VQHRKhhDepXjPjgAuS3hqOyJamGH
         VJiKzTjdq1z6U0Ts/9pxEfu6sG9+w4bNDybfeKeylk9EHw36OFtJhzlKojA8yxrVmIJO
         3u8Szuq7pLi1G3qidBQSuhsEFe/IvN7v7osceFOPv3GINMYee3fCrAiMr1Dxg+bsdl/4
         +OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227047; x=1773831847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BvKG9W5EJzOGVWUHViOwYaUbAHINI6d9WZJfW7/MD+4=;
        b=tT4ttjEJt/TIT2f6rptzG7tYscfxIza/5pSzIMj59ddjrR0lFd50f4+ph1P3TE+n0d
         xrh/lxz6kDXWY9c0lRRhE9+3z69I8M+5DKk8hM1ANGCcSZNyM7dnChICYr69e3KalRQ3
         XvWiDOMkqv8Gspb7mWqFC9z6gzMwirDmopgsKZzosRYIDamPfIg5BNvmHAXnGiuLYHer
         evOdHCSfW1EhR7QUSU2Rd1mS9to7JNjwcfkiT9zlL53KnDoq5jtyez1yGXhEkSkwwpZO
         t9wzukD6I/QMyDjJGs1dGBC6s3L4GedhAhPyIIGeUibFe7QVE2YAzEbEQHPPpw1YAe68
         cXfw==
X-Gm-Message-State: AOJu0Yyv+qojoamj99vzwpheqo2tbxjD6MvdGEjTf5b0+sJ/uoYJDfv+
	XguEk6elYUswjoq5WnS9ZFCH0LGaKKL5Dcy1EOxVZJlKbJvmQVHXx2nof6Fc/lavuurkghufbSw
	j1WON
X-Gm-Gg: ATEYQzwRRITvma3saq07nyHKN812YRnEc9jvSfci4wW5z7RBuQ1IvfpZ2wu2/OQHAiD
	HXAOpHCAvNRN4eiHp2Y7n7MuStw0VQzUuMbj3MDPXthe5kIsqEaj+L3iKmhnqS7Kv89y3eFvKk7
	KoG4Fw1HPaPQC17faSSbbmo5OdDhd/X+qeq3B/0xw98G9oc7pVaSfw5MvF2uJTagCmjGwovmuZb
	cd23sVfZl9RMB1/1Q7XfCtdA31vH1lY10SgyHFsysWJNwIN+Qs71PDBYdU7juGycPCU/tQPVW1V
	NwAOORZzHhexPVjv5s0V+Z2YEaZVbgoOT7ukUGH0q66S8embEvvcrV0UjNTkszo6TNxROUvU8Zy
	q39cx8HY044Bb9Ocg68y9DD7R8j97h11d7tpNerC/skjrrLqtuB2ggA5iq7faWQSOJ5lqHuxJcg
	RShPbk24rkXb9LaS5kPiOGs69ireR8MpGBdTnFE6RJ+fG/tsYRr6sD
X-Received: by 2002:a05:600c:a44:b0:485:40c6:f526 with SMTP id 5b1f17b1804b1-4854b109d5dmr28863945e9.26.1773227046985;
        Wed, 11 Mar 2026 04:04:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 06/28] clk: renesas: r9a08g045: Add PCIe clocks and resets
Date: Wed, 11 Mar 2026 13:03:35 +0200
Message-ID: <20260311110357.1938200-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22285

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6b234eda88d781d244094836afc37c90b57832f3 upstream.

Add clocks and resets for the PCIe IP available on the Renesas RZ/G3S
SoC.  The clkl1pm clock is required for PCIe link power management (PM)
control and should be enabled based on the state of the CLKREQ# pin.
Therefore, mark it as a no_pm clock to allow the PCIe driver to manage
it during link PM transitions.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250704161410.3931884-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping I3C clocks and resets as
 these are not yet present in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c3b64f94e188..3e8eae79af09 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -283,6 +283,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 					MSTOP(BUS_MCPU2, BIT(14))),
 	DEF_MOD("tsu_pclk",		R9A08G045_TSU_PCLK, R9A08G045_CLK_TSU, 0x5ac, 0,
 					MSTOP(BUS_MCPU2, BIT(15))),
+	DEF_MOD("pci_aclk",		R9A08G045_PCI_ACLK, R9A08G045_CLK_M0, 0x608, 0,
+					MSTOP(BUS_PERI_COM, BIT(10))),
+	DEF_MOD("pci_clkl1pm",		R9A08G045_PCI_CLKL1PM, R9A08G045_CLK_ZT, 0x608, 1,
+					MSTOP(BUS_PERI_COM, BIT(10))),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0,
 					MSTOP(BUS_MCPU3, GENMASK(8, 7))),
 };
@@ -319,6 +323,13 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_TSU_PRESETN, 0x8ac, 0),
+	DEF_RST(R9A08G045_PCI_ARESETN, 0x908, 0),
+	DEF_RST(R9A08G045_PCI_RST_B, 0x908, 1),
+	DEF_RST(R9A08G045_PCI_RST_GP_B, 0x908, 2),
+	DEF_RST(R9A08G045_PCI_RST_PS_B, 0x908, 3),
+	DEF_RST(R9A08G045_PCI_RST_RSM_B, 0x908, 4),
+	DEF_RST(R9A08G045_PCI_RST_CFG_B, 0x908, 5),
+	DEF_RST(R9A08G045_PCI_RST_LOAD_B, 0x908, 6),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
@@ -330,6 +341,10 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_VBAT_BCLK,
 };
 
+static const unsigned int r9a08g045_no_pm_mod_clks[] = {
+	MOD_CLK_BASE + R9A08G045_PCI_CLKL1PM,
+};
+
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a08g045_core_clks,
@@ -346,6 +361,10 @@ const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	.num_mod_clks = ARRAY_SIZE(r9a08g045_mod_clks),
 	.num_hw_mod_clks = R9A08G045_VBAT_BCLK + 1,
 
+	/* No PM modules Clocks */
+	.no_pm_mod_clks = r9a08g045_no_pm_mod_clks,
+	.num_no_pm_mod_clks = ARRAY_SIZE(r9a08g045_no_pm_mod_clks),
+
 	/* Resets */
 	.resets = r9a08g045_resets,
 	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
-- 
2.43.0


