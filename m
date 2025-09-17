Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7A9CAC599
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 11:09:02 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.20046.1758107339547059954
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 04:08:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iO10858r;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d44d734cabso3991973f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758107338; x=1758712138; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwHCDpGoc+fCx72V0hFR1cr1D7weqAc+1KXGskA9Fy4=;
        b=iO10858r+1fdYhhgVOqOM7u/YE7Ws8Zwzs1O4g8hRwjTzuJCNjPAV19XPxmIU6OF20
         qfhH8cAp+VqYzfLgPYpqF7c+hwqA9z86M3dLL/IswBGqaNzoQhXxDEN/Xl71Rzah+uOq
         la90ELTUCcfadpzmVj0PgIneitZEQp45MyzZ5h2givp11j3gEzQWdpSDRNM2P1QMW878
         jZT+63W9vnBNTTSRQN/2yn9Ld8yZOL86eo8+ejObAX0bieBEIQQZne6otqLlslA6uF7O
         9OLp37HKOPq8UuWXYLKFVhnV8hJ7LcK14CY5HlpiHUMHOfLCc5QBmNwIjnEUNkv8EZFF
         fIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107338; x=1758712138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwHCDpGoc+fCx72V0hFR1cr1D7weqAc+1KXGskA9Fy4=;
        b=Kodnofbae5Nwk5wLecv9n96gzoN4cO9OHuk9xGbfJhGUvRxDlJngZBd/cV6rAcD0ET
         hYHm/ipLNz+omq7vojrPsr1WrfnpDl9ZEd7IYRHmxP5N2OQy9CPbt7xLhLPZRaKV3NWH
         MuOfjaKjf44hvKzxPdxKvH9vNJfeLgeYZSoPd1t4hCwzPyhLoKtoJsHL40ZK+Hp7XeHZ
         qHo+MHHWfC5q4v2baOg07GodMjFVDUPTXRNRi3AWdqTFjW5Z3aza394KPraW0HIp2KV8
         h2GICg0cD+9/IRs8/o3vbPxQiRLOCcTth6gg6d54GYtDT/1yfKGPx5EVaCVJmAmyRiw3
         k6dg==
X-Forwarded-Encrypted: i=1; AJvYcCVOGlkUWCsatchU40iv4WXAATnmESuDxqG1qP0RAyuetz7oPyYbGH44M5m3Bq+RYdK9RKl27d8n@lists.cip-project.org
X-Gm-Message-State: AOJu0YxYG3f2ND/rWGCuAENbrFX3bZTN0rqSY6frELBKVJ/JtLd1kArC
	X15scJFVlh28eMGkhN+9V1uV4vk1BUHx/9BykjRjgb6jb/GKoNdkccAnkiZ5Hv2mXHs=
X-Gm-Gg: ASbGncuWrnAqPnWoeiTbibimD9HNODHJcsb1EYcsX8NxzSjRXdS+1zVaWYMXEvBi3bm
	tQGfYCyn+ikA0E7ieCMOUd1r39xFqwYGtRqa1I2soNjAW6Lv6FagXj/ih56fjKwckx+DWcwDgKC
	2PEBvTcw5uTVcxrM64aa/4Bps2Ret+sjwzOmKMm+mGI3EyAcX5JYtKqaguC1xKMhC1H8+N/WZwF
	cjVUkLP5aDwfPgZrH8E9pvCfjCxf5VG4gQ1R7c83KeCiTb24Pnnxu19UOrnndjKjd1ZoGl4P/BU
	sEzgwNKcyrh6X5PR38Vn9WvsHoTg0S3D0+9KYYYm/b3iJo15JBYh0ANVsHAkleDMxe//bgs16vi
	ynsewUR5wztDlmHUqk24QaflZDR3FJsFJ6fXtWUQK1TRu8LDtcSod
X-Google-Smtp-Source: AGHT+IEhwXCU7ZFyTOVDavXAzKDXdi1tMyohOH0h77UbhsEsMPuD9xFTbZ55A0v6SCqBaIgUj64VZA==
X-Received: by 2002:a05:6000:4304:b0:3eb:5e99:cbb9 with SMTP id ffacd0b85a97d-3ecdf9afec7mr1855696f8f.10.1758107337890;
        Wed, 17 Sep 2025 04:08:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138b5be25sm36549745e9.15.2025.09.17.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:08:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 17 Sep 2025 14:08:53 +0300
Message-ID: <20250917110854.326336-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917110854.326336-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250917110854.326336-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 11:09:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20076

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 68dbe38ed7ba9141b9329eb203fe9762a93b60e8 upstream.

For development purpose, renesas_sdhi_probe() could be called w/
dma_ops = NULL to force the usage of PIO mode. In this case the
renesas_sdhi_enable_dma() will not be called before transferring data.

If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
call from renesas_sdhi_probe() will configure SDBUF by calling the
renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.

To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
removed from renesas_sdhi_clk_enable() as the host->reset() is optional.

Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Hi,

This fix is already integrated in v6.12.y CIP.

Thank you,
Claudiu

 drivers/mmc/host/renesas_sdhi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 725bd37b8c21..30ceda915f1a 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -603,6 +603,9 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 
 			priv->needs_adjust_hs400 = false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
+
+			/* Ensure default value for this driver. */
+			renesas_sdhi_sdbuf_width(host, 16);
 		} else if (priv->scc_ctl) {
 			renesas_sdhi_scc_reset(host, priv);
 		}
-- 
2.43.0


