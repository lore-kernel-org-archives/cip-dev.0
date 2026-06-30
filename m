Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD3C44506
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19428.1782820130967243345
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RrpCi+Ck;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so4139195e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820129; x=1783424929; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x4yZbZYj6DLi1YWeP+TxBwIehAGM2li/g1CPla6E6A=;
        b=RrpCi+CkjP6G6yKooHt/TKpTnzBf+sfWhJ3nwqlyVHosd3jbzSMJyy7rns5rZ5xmSy
         yiu+Eg9N7jW8+xAiO8xblk1U3jjUf3vOEn3o3hkMpz4ktVAoA3arnLpkcYGWGEwtK8Pt
         KkhxgraBHkBYE9fcPivgvzB5K00JIpMM0zjbvLXmzIxa/PW5qHHicUZuaoGTloc+k1bT
         O/hgGGAjRwFozM2srmF9+pLGtI4d2aSmCDOG0n2xQJaLqb4xMAV0H/NRGGCXIwZRccTN
         3Ivf/U+0H1BjjzgYZ1u0hTE7uqJyeArKM5H4Ry6rTaGtTCOagzyTMM3gD7vFDay1euWL
         2dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820129; x=1783424929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x4yZbZYj6DLi1YWeP+TxBwIehAGM2li/g1CPla6E6A=;
        b=aNhdsSiXbhZ7juZFkUZCcKgIxL9hcAWaSqtcnrR6HBAEo+CKnDqg39AaO45fbjUy+C
         Jyv+S/RH+2102EjxuUwWDdvNkXoF0u07I9Debvrd9mJNpq/desRBskKlLY2x03auh4G4
         U8xnnulYq6wT+VP60p4n9cyjcHsSHi+8yHD88O/5Ld3mLkyeLOs1VCUxJ850a/ZILVyn
         Opj73+sy4W0qmLxQXMVJJKdDL74jcSo8IHLHqEEBToXJvoNMPqaWnZMsCzy1HyscsdUy
         WlJ8bse7JtfAitUzLQktulwS/3mUO0+yE5THkJktpEgOTuo9XSKbzlpn7ajXHkP22uIW
         RYAA==
X-Gm-Message-State: AOJu0YwAtGYQTzvsn1rwIEM4uXOavgzV7luZ9V83SqxlPgq4Z6v3Q8Nr
	gbNu32xyPrpJEEE5PF5vzT9+uFwyZ0lEsQzCUfqACrjTeTW0r3JfSKbj8UrySURx
X-Gm-Gg: AfdE7ckTy161iYyiD2zUFMs6rvIxa3mSH6Ab3TzG+Yd9DPs0bUHQ7AL4aoLBjWf3jkR
	s4n8wOdGsaguaLPZ/s6T4gtE/e4jjLhHAUo6h+WeDCeEpiPT3KiIUutuRQVdWDvuAsX07aYVGnD
	XOzAZZiyVWfpC3WNdn6jJbpZPtsUb5DlNQlK1PRFsljzIOxtA/kk63gBcPruga4AOF2I3VQJXF/
	QTlTmmNym09+MJMCIznUY8C+l/Pu+PaxRQUuJo060+dBkgQnnLlGszNn/xJiLXqZS76halrY0N5
	0Y2UgYrfANXC1KCNFYh5KXz/bWTNQlezv9gb1DUfXvsFKA6gtjrEZGC4ov3pVenWks1c1B6wg+z
	mvXjvjvbRQCepGyN6Mqwy+GfVf1BTXR+q0SnbjfWnPbAXX6M7lQZd3JzFe+UoiMe2nqUcQWEmzF
	frb2ABlBrkRohY/TFknTlUvrk0WTxECPHfJx2LMQ==
X-Received: by 2002:a05:600c:1d0b:b0:493:b750:b565 with SMTP id 5b1f17b1804b1-493b82c0a30mr49817555e9.35.1782820129048;
        Tue, 30 Jun 2026 04:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:48 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/39] clk: renesas: rzg2l: Add support for critical resets
Date: Tue, 30 Jun 2026 12:47:34 +0100
Message-ID: <20260630114813.92739-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23339

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3d700746d76bedb9f3de505494994cd3f2afb59f ]

Some reset lines must remain deasserted at all times after boot, as
asserting them would disable critical system functionality with no
owning driver to restore them.  This mirrors the existing crit_mod_clks
mechanism which protects critical module clocks from being disabled.

On RZ/G2L family SoCs, the DMA reset must be remain deasserted for
routing some peripheral interrupts to CPU.

Add crit_resets and num_crit_resets fields to struct rzg2l_cpg_info to
allow SoC-specific data tables to declare reset IDs that must never be
asserted.

Introduce rzg2l_cpg_deassert_crit_resets() to iterate over all critical
resets and deassert them.  Call it both at probe time and during resume
to ensure critical peripherals are held out of reset after power-on and
suspend/resume cycles.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260324114329.268249-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 30 ++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index a7189c32849e..da211010d2ba 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1766,6 +1766,13 @@ static int __rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	dev_dbg(rcdev->dev, "%s id:%ld offset:0x%x\n",
 		assert ? "assert" : "deassert", id, CLK_RST_R(reg));
 
+	if (assert) {
+		for (unsigned int i = 0; i < priv->info->num_crit_resets; i++) {
+			if (id == priv->info->crit_resets[i])
+				return 0;
+		}
+	}
+
 	if (!assert)
 		value |= mask;
 	writel(value, priv->base + CLK_RST_R(reg));
@@ -1803,6 +1810,20 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 	return __rzg2l_cpg_assert(rcdev, id, false);
 }
 
+static int rzg2l_cpg_deassert_crit_resets(struct reset_controller_dev *rcdev,
+					  const struct rzg2l_cpg_info *info)
+{
+	int ret;
+
+	for (unsigned int i = 0; i < info->num_crit_resets; i++) {
+		ret = rzg2l_cpg_deassert(rcdev, info->crit_resets[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
 			   unsigned long id)
 {
@@ -2052,6 +2073,10 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	error = rzg2l_cpg_deassert_crit_resets(&priv->rcdev, info);
+	if (error)
+		return error;
+
 	debugfs_create_file("mstop", 0444, NULL, priv, &rzg2l_mod_clock_mstop_fops);
 	return 0;
 }
@@ -2059,6 +2084,11 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 static int rzg2l_cpg_resume(struct device *dev)
 {
 	struct rzg2l_cpg_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = rzg2l_cpg_deassert_crit_resets(&priv->rcdev, priv->info);
+	if (ret)
+		return ret;
 
 	rzg2l_mod_clock_init_mstop(priv);
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 55e815be16c8..af0a003d93f7 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -276,6 +276,9 @@ struct rzg2l_reset {
  * @crit_mod_clks: Array with Module Clock IDs of critical clocks that
  *                 should not be disabled without a knowledgeable driver
  * @num_crit_mod_clks: Number of entries in crit_mod_clks[]
+ * @crit_resets: Array with Reset IDs of critical resets that should not be
+ *               asserted without a knowledgeable driver
+ * @num_crit_resets: Number of entries in crit_resets[]
  * @has_clk_mon_regs: Flag indicating whether the SoC has CLK_MON registers
  */
 struct rzg2l_cpg_info {
@@ -302,6 +305,10 @@ struct rzg2l_cpg_info {
 	const unsigned int *crit_mod_clks;
 	unsigned int num_crit_mod_clks;
 
+	/* Critical Resets that should not be asserted */
+	const unsigned int *crit_resets;
+	unsigned int num_crit_resets;
+
 	bool has_clk_mon_regs;
 };
 
-- 
2.43.0


