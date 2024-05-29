Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95086C41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:07 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.8725.1716970500543229350
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gucVK0W0;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so2731675e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970499; x=1717575299; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1shavOW4v75BUBdVT1Z/xxS98OQNziJYxadz6ndFFAQ=;
        b=gucVK0W0TWx76vLGCmIXYNd2NzzEZASbD428xRfrFHXWJ1TBrmfx/C2tiFReQdyX1R
         kd+c+ubsEvZKiNz2/HEYEC0+lpmNwBtDb7Ybcw3dLe4CCQcwulgTkFFJrVxsA3K4d9ax
         MU4QIH6lD+7XDCyC5Tf2zXVIrZBAdNUAYqGbHbZfTpmFLwYQkp2PHgH2lx4EPG+pFPZK
         9D9fUnE6ADtrO2wVYKc4zu+xFR2LuL0RCxZODpSP1ggJ73/gjvSAHfshGEzmn3zK3KKi
         yK7iwWRrWl3hZeVU+ZOs1L7uX+YGY2HM1zMsqJ9lQlaEtBY2CeszhC1g+r08AX3wk2vb
         CHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970499; x=1717575299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1shavOW4v75BUBdVT1Z/xxS98OQNziJYxadz6ndFFAQ=;
        b=Yact2wnzpV7EO8VzlbMVDuEmTdvXDfClJWn5/GAZBfspbBv/yTmGb4yJ8p9Vke+DYB
         VGtI6hVnJAXBtIg6QkqM1guQGANoepTxW3p7GWBeHNDsOPVLzbc/ez9WFgP9Ef8obTIL
         gdhxZmH02MPjVzurloleani2z9p8+inFbiX6UxGnwX1NjfUSK1/s/5oy54wPL0xyXbrN
         LuYknKoC6c9lrd6cZzDgKUq9B423fi1Lts8GHD9YdI0iF2bfs6GhLyLepELEOdCMwmJY
         DglnlSo2HQSGEThIJL42HsZKhcIMvlvL8WpWBK+HESxm9ybwkuMcrDbNSyr5bYSnNSfp
         Sm2A==
X-Gm-Message-State: AOJu0Yw3g37VU7vEqfwjoRY47Lc0aJzOGPngUDXDCDlvkamJKdO5L7Ff
	DtlxjYG0UtZahJmEIQ7Jb6WERmv3V7ehnIqT8BKoJbjT8QG00cRxU+Sqh/vnM0o=
X-Google-Smtp-Source: AGHT+IEYFp7jIqtqWBcsKYf2nu33hWNkSoOEoSocPH5nAietf1vlzNO4+hIqVDGC+zejtaEnuFQrPQ==
X-Received: by 2002:a05:600c:468a:b0:41b:4caa:554c with SMTP id 5b1f17b1804b1-42122adb0eamr11762385e9.2.1716970499019;
        Wed, 29 May 2024 01:14:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:14:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 14/33] net: ravb: Split GTI computation and set operations
Date: Wed, 29 May 2024 11:14:15 +0300
Message-Id: <20240529081434.639519-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16042

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f384ab481cab6ad71afdf9c80a8b407a70a8624c upstream.

ravb_set_gti() was computing the value of GTI based on the reference clock
rate and then applied it to register. This was done on the driver's probe
function. In order to implement runtime PM for all IP variants (as some IP
variants switches to reset mode (and thus the registers content is lost)
when module standby is configured through clock APIs) the GTI setup was
split in 2 parts: one computing the value of the GTI register (done in the
driver's probe function) and one applying the computed value to register
(done in the driver's ndo_open API).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +
 drivers/net/ethernet/renesas/ravb_main.c | 96 ++++++++++++------------
 2 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e3506888cca6..268ccfafe7aa 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1102,6 +1102,8 @@ struct ravb_private {
 
 	const struct ravb_hw_info *info;
 	struct reset_control *rstc;
+
+	u32 gti_tiv;
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index bbc025017c44..90a61e2e1a77 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1776,6 +1776,50 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 	.set_wol		= ravb_set_wol,
 };
 
+static void ravb_set_gti(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+
+	if (!(info->gptp || info->ccc_gac))
+		return;
+
+	ravb_write(ndev, priv->gti_tiv, GTI);
+
+	/* Request GTI loading */
+	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+}
+
+static int ravb_compute_gti(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	struct device *dev = ndev->dev.parent;
+	unsigned long rate;
+	u64 inc;
+
+	if (!(info->gptp || info->ccc_gac))
+		return 0;
+
+	if (info->gptp_ref_clk)
+		rate = clk_get_rate(priv->gptp_clk);
+	else
+		rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -EINVAL;
+
+	inc = div64_ul(1000000000ULL << 20, rate);
+
+	if (inc < GTI_TIV_MIN || inc > GTI_TIV_MAX) {
+		dev_err(dev, "gti.tiv increment 0x%llx is outside the range 0x%x - 0x%x\n",
+			inc, GTI_TIV_MIN, GTI_TIV_MAX);
+		return -EINVAL;
+	}
+	priv->gti_tiv = inc;
+
+	return 0;
+}
+
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
@@ -1793,6 +1837,8 @@ static int ravb_open(struct net_device *ndev)
 		goto out_napi_off;
 	ravb_emac_init(ndev);
 
+	ravb_set_gti(ndev);
+
 	/* Initialise PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_init(ndev, priv->pdev);
@@ -2484,34 +2530,6 @@ static const struct of_device_id ravb_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
 
-static int ravb_set_gti(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-	struct device *dev = ndev->dev.parent;
-	unsigned long rate;
-	uint64_t inc;
-
-	if (info->gptp_ref_clk)
-		rate = clk_get_rate(priv->gptp_clk);
-	else
-		rate = clk_get_rate(priv->clk);
-	if (!rate)
-		return -EINVAL;
-
-	inc = div64_ul(1000000000ULL << 20, rate);
-
-	if (inc < GTI_TIV_MIN || inc > GTI_TIV_MAX) {
-		dev_err(dev, "gti.tiv increment 0x%llx is outside the range 0x%x - 0x%x\n",
-			inc, GTI_TIV_MIN, GTI_TIV_MAX);
-		return -EINVAL;
-	}
-
-	ravb_write(ndev, inc, GTI);
-
-	return 0;
-}
-
 static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2783,15 +2801,9 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_rpm_put;
 
-	if (info->gptp || info->ccc_gac) {
-		/* Set GTI value */
-		error = ravb_set_gti(ndev);
-		if (error)
-			goto out_rpm_put;
-
-		/* Request GTI loading */
-		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-	}
+	error = ravb_compute_gti(ndev);
+	if (error)
+		goto out_rpm_put;
 
 	if (info->internal_delay) {
 		ravb_parse_delay_mode(np, ndev);
@@ -3006,15 +3018,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (info->gptp || info->ccc_gac) {
-		/* Set GTI value */
-		ret = ravb_set_gti(ndev);
-		if (ret)
-			return ret;
-
-		/* Request GTI loading */
-		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-	}
+	ravb_set_gti(ndev);
 
 	if (info->internal_delay)
 		ravb_set_delay_mode(ndev);
-- 
2.39.2


