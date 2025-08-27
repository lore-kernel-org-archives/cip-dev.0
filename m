Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91786CA0FED
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 10:43:31 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.11679.1756291404951070525
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Aug 2025 03:43:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qa1/COzU;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c325a4d18so7355644a12.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756291403; x=1756896203; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLNmIsW5Q3GINiArPxonzyeIFuJOwZj7rn8N13+KnSs=;
        b=qa1/COzUi03yAC+8/kONPtpfQzqrugir7SgYSOxtvYtkamDV7EAlhu/ZKrjxQIyJbW
         LqWlZXGlO5JcpEUxzrPCLdYWXctwrVvevUnIejzHAy6m3Wrq586qR9Ju4JXpVV3U1eX4
         st4Bo6ibcrVbVELTmsz7HHjUIOkcsgXPjROp1G3aDfJSdHHSoVw1DaMdTgEiOXzRMzKm
         50P2gUtYD7vkcKetE9RXtD/wxT8tvS1mtYoiC/AI7/6mhbxdDBOdb9G/wsjzDpsi8Gjw
         9ORFGOUOQvk8yQjJX+GzkQwwioVBx2Rhb45BZA6Jslpak3cyY2LYeaDSbaZZnRHFEbss
         zlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291403; x=1756896203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLNmIsW5Q3GINiArPxonzyeIFuJOwZj7rn8N13+KnSs=;
        b=F+oKRYGIR9QkoKrx2G1wxTG9SE+LuWDyo4CdYr9wx8CmEkF1/wDU2IYQ/VjQir3Qas
         1p/Y2sSuhwtyhTOREmYv4IX2P0goAG4Q0xi4ttj7Jv/3udQ037ygP3rhHxXrUxYSkVBp
         p147K+vo4c+NELU+r4wz/yxM1jxEwBPnPugPGT4k3gsGAchPXf65pWF4ngIe4ffhX2gH
         MfLW4sPZGUKg0wwJf4h51YH8W1GzElCzFExDevgNJsdhmDzg5eMsMbpC31V7/nd4u/Kb
         x3YHOtHeeK5i8JbuU8PSXurlJoxkWsTyjuYS8LFbMgDo/ljkOP1j+5DW28UJVVKkCLWY
         zKtA==
X-Forwarded-Encrypted: i=1; AJvYcCW5rEaomuevllo5/JqxVfS10LzzP3ap9TSZdgi70I4fiE2/bcNtxRW/TjtE4HEKy6I2pdGGK55o@lists.cip-project.org
X-Gm-Message-State: AOJu0YxHiWL2PyvDjVF9LGj4iK+boJWZVpHC0WrVzfBlPvBGPPSF1KVa
	TZjCqNJRIP9F9fR0MF6i34Vin/fsb6s085xJ5wyP+u4/2xU9Bc6vWGgRf6Ds2cUuWg4=
X-Gm-Gg: ASbGncsoIai8l8h6m0Xa2rSqNhSpks9SebTExaf8FDELhON3YE/GbtCWhG83+1tX3PS
	dUyM/tx+HVxVZUEprmY89GQdVHsBD1ktZ1f4y4Wf567KON9FyCAgAItPuJ29o4ZXsNJox8wiRgI
	BFvpqOZm/oJlFH5lbiAIZGV6ARYGXR2KnwNhx9/PShCV4va0MTdjYYCGXLA1S8uClO7jiJRhj+/
	E8nc9G+OcS2ttCNWe+L9jU/hqodX15Sz2kIAOU69Vc/N0OwfEcFRb6uZhCEgbbNE4ftj2maVi1C
	cVa3O4S7r47fGxqv0NNXYO3k35ChsAb/AR8uSt2uUh7gOKBb0toIZWIjg5Dxo5RGkbjGt/rh6Bo
	O8sULrvA2Ds1pzAs2yAhYvrsubAQJgyyhCbSyenKR6lcFAzGYbkfAod7VTdzyrYkvGET/dpF71y
	45AeXTrA==
X-Google-Smtp-Source: AGHT+IEWEQvNu0H8mqHFeoV9NGCmBLa81BbLfNA/z5rASW6mT7zoEtmzeckissjJFwsSU/riV3hIvQ==
X-Received: by 2002:a17:907:60ca:b0:adb:45eb:7d0b with SMTP id a640c23a62f3a-afe28f156f6mr1726016166b.15.1756291403211;
        Wed, 27 Aug 2025 03:43:23 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe90c8f85fsm497239066b.8.2025.08.27.03.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:43:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 27 Aug 2025 13:43:21 +0300
Message-ID: <20250827104321.931369-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 10:43:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19976

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 621670c6a227..a087eb41e9e7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -599,6 +599,9 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
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


