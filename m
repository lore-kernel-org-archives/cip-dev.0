Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856F8D64082
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 07:01:14 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9089.1765954868452267968
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 23:01:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MzDMle/I;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7a02592efaso804998766b.1
        for <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 23:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765954867; x=1766559667; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXWOREMztq6f0WxEo8ex6wrABYsQhAN9wL30i5vZli4=;
        b=MzDMle/IF0ToJO/xz+lJCUb55X8Kn32LIJBr9wffg8XM/ZzLU6xUc3cHEqVyq+2pZ1
         KaAfJTMx9mQeF54MwInD7SLT7iDZq+zD5M92tu0iJKktwBYwfffU6H1UyBhu9SBiFglp
         iD0+RoEeGUihiGnTM1IJuNhjOjwgSJwvmlW5PVHdpQKrqrOpkHKBw/FPlTzcY5rJDfjI
         +PyRcpj+gKM0YUCSGdOjp8Dt70y6anyAWJsnvj1WGjuVOD/qfPSQguGzy2wUFWx085Oj
         tfC60tIBtPmOceWcxGk5Z9WKjkbXgmF/omxdRpKxRH3q8DeD1kBpl1jXmh9EYp5EPWlO
         3Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765954867; x=1766559667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXWOREMztq6f0WxEo8ex6wrABYsQhAN9wL30i5vZli4=;
        b=sFGBR3etMH2Bnyg7vpYs2qf7sNnyizXZOwZIFj6T+84IQs6XMFYhWbXd+WIrFxTYfX
         HCe3Wbnj7b+U5ZjEn5NtEkfbEnhYUxybmaLIYMeqfIUx3FmwuXkVjNADVWUsCHUPUYVv
         BuXzBRR2e4n/fxzUWvr9BMuGp0IruDZ7tm7MzihwL6Xza4FLn9BZ8pMQ23niVII5WH8o
         rnYtjWu48StWI/k8+JPH28n89+577l4xZ4TNS56HVBCP052gmkM/i5DaJ3DhVR7IOFPe
         FsqGe9EjSocgL554PbVFxnC7EVSKTSem8W2VLlHIgxsnUXBk5enL9HaE6eUV0FKRfRF6
         rCmg==
X-Forwarded-Encrypted: i=1; AJvYcCXHiwJy+jugSOzsFGFzRt2NrBHIwRUp/WyOUh1ELkazU3IIFd/1cImziRbAXME4a5fumhbNZrpb@lists.cip-project.org
X-Gm-Message-State: AOJu0YyQF/X3ZumSY11IFCE+gYIySS68f8sT8xZu6EvrLE3gf5G1GVul
	GC5E1xEfRpuuSFwteEF0lGXEnpKFWcAsu/smprHM45iRjfpyH+iZM0J9
X-Gm-Gg: AY/fxX7aEC0TlxF6EoLvCysmSfQF9RHKyFN76euAfrOkz2px/A2dUb3/UHU4EXIBF2L
	24OnKxS6j3wBSmKHAgY4/pFtQ/Xxg2e3rHQZbQ3zlPibp+3XX947QCsCtiEL5WVxbGrUSOq3lcj
	0M1VVFJ5z+B5rCm9xSLV//j3K18KutprpWVdAACzpl3PQBX2Ed7rpTvPqxoxFlXqn06/x8XOW3R
	tW5bSTzb73xVyCv/HWc2v9TjGS9auyTjxZg4Z3RgoSBQII9vXEmyfzaQhX2x+Vn7ge/A3+/Pjog
	kWyDO43h1UYlVjIxdj6xldaOVuZLoRBsxTIDEHPEFU/gX0XJQwaNuJMBmuB0S1xHmVfZwljBWEu
	foSIuoqEJaGmikz2hEaC3KYWQa8T63DOlQGWCWhouMvXUJFvphIE3CTxA3wHCsV5V89YtDjeXVK
	89tPPiLQNdua24eebExzxF6YPfO2CkS/8tENw=
X-Google-Smtp-Source: AGHT+IHQTqs/A0uOLc/ODZTd1rLZx+reLi89wjDXiastl1Z9BXx9S6S6RYC2ayg39OPK4XFvVNthCQ==
X-Received: by 2002:a17:907:940d:b0:b6d:5a24:f124 with SMTP id a640c23a62f3a-b7d23665676mr1810189266b.22.1765954865574;
        Tue, 16 Dec 2025 23:01:05 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:66f4:ac02:4208:e435])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7ff7e5e79esm363629266b.46.2025.12.16.23.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 23:01:05 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth: Add .init() callback
Date: Wed, 17 Dec 2025 07:00:58 +0000
Message-ID: <20251217070100.3680-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 07:01:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21094

From: Biju Das <biju.das.jz@bp.renesas.com>

Currently clock usage counter imbalance occurs as .exit() is called during
suspend() and there is no corresponding .init() during resume().

Add .init() callback to support balanced calls across suspend/resume
cycle. While at it, avoid code duplication by reusing renesas_gbeth_init()
in renesas_gbeth_probe().

Fixes: 709bdc1cafe2 ("net: stmmac: Add DWMAC glue layer for Renesas GBETH")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
index 42cba9dd967c..5c591c7215bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
@@ -31,6 +31,28 @@ static const char *const renesas_gbeth_clks[] = {
 	"tx", "tx-180", "rx", "rx-180",
 };
 
+static int renesas_gbeth_init(struct platform_device *pdev, void *priv)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct renesas_gbeth *gbeth = priv;
+	int ret;
+
+	plat_dat = gbeth->plat_dat;
+
+	ret = reset_control_deassert(gbeth->rstc);
+	if (ret) {
+		dev_err(gbeth->dev, "Reset deassert failed\n");
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(plat_dat->num_clks,
+				      plat_dat->clks);
+	if (ret)
+		reset_control_assert(gbeth->rstc);
+
+	return ret;
+}
+
 static void renesas_gbeth_exit(struct platform_device *pdev, void *priv)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -91,22 +113,17 @@ static int renesas_gbeth_probe(struct platform_device *pdev)
 	if (IS_ERR(gbeth->rstc))
 		return PTR_ERR(gbeth->rstc);
 
-	err = reset_control_deassert(gbeth->rstc);
-	if (err)
-		return dev_err_probe(dev, err, "Reset deassert failed\n");
-
-	err = clk_bulk_prepare_enable(plat_dat->num_clks, plat_dat->clks);
-	if (err) {
-		reset_control_assert(gbeth->rstc);
-		return dev_err_probe(dev, err, "Failed to enable clocks\n");
-	}
-
 	gbeth->dev = dev;
 	gbeth->plat_dat = plat_dat;
 	plat_dat->bsp_priv = gbeth;
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
+	plat_dat->init = renesas_gbeth_init;
 	plat_dat->exit = renesas_gbeth_exit;
 
+	err = renesas_gbeth_init(pdev, gbeth);
+	if (err)
+		return err;
+
 	err = stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 	if (err)
 		renesas_gbeth_exit(pdev, gbeth);
-- 
2.43.0


