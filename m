Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC07CA0FED
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 10:45:31 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.12081.1756291525737683449
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Aug 2025 03:45:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qN8judKL;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afe9358fe77so454763766b.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756291524; x=1756896324; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8edHdPscngRl+C0b8pVKTzF5bxiXP/JT9Xlxj4/QSQY=;
        b=qN8judKLqnPbYDSP4c8a3rJfRvudif4ttFtKb53XS+08BIvck1vQHd0ZDo3hupJUn0
         lPzkE5hj3heUDhVLYfrYALgxiztYeXgvxtPW37mPA30Wp5NyGkwVUuwY0SduNVAZ+kE8
         kaXEliCeAhw4l1elWo3b2LJDWI5Acae2iVh3CpVfcU2XcjRpLyM3B6cElaMzRhfoq/wL
         GRLgk987AVEBbAkkK4wEIl17vUx2TDwLOqCJM2Ka8nhpbSS8daL1ksLibfNA5DFK7sFb
         wT84SMEefGwpcMz1GENAVJraGS9lM6FHt7awTEUKQzHr6L2ivGVp9YC6VuL+SfLgnuLW
         QEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291524; x=1756896324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8edHdPscngRl+C0b8pVKTzF5bxiXP/JT9Xlxj4/QSQY=;
        b=i502nEJCX1qEIdm74uV7zgUXWTDlJsv14+LNGh4sylS1oioYdFY1yfZA/50d5NxgzE
         HdVNvV17nm8DzafkjOaWATptN129374LmxXWenqCAIBVbAVr/WTtI4FAaOPr+roJxl8y
         N1QQoG63nVoxHJSLWLDOjGkHbYCxdN7bI/yqFRXesxoKq+7hu1JD0Q3nd2hicOgUt9cb
         7jAUe+PsDgoQ0Sbj0KhlDGBfjRtMC7vtL+s9D0u5ll5+YvVunXsrvetSJlfVtXpN1EKU
         S7Fn8V51eNRKRzdKD2cOQ5DLcx9XAtPpBslLg4GfBdrKB9shPzqJJuE1a9By0hoPpi5c
         ubRA==
X-Forwarded-Encrypted: i=1; AJvYcCXHlS5vGAFY12sD7OhirCQ6ELVLjTfGo6gaMPXmZajsFb7tQDzPLa/mzzd/HGzl9sXFQlzKgEqg@lists.cip-project.org
X-Gm-Message-State: AOJu0YzVusPLvQY6u+GHEbBWeVxS9/0bQOOqNY0hcmNkR4ZpSFYdq32+
	ANBcCdF1DKJISyUierqemW581vMFyfBcn77swl3FLZVzHZ2pV5cXBW877vZHw8EoGSw=
X-Gm-Gg: ASbGncu7K0lmdypQ5Uyl5QjpBSfUUpve5gWoUFsyWsTdV7lUvHBkQOvr+yj3jhr1Xtw
	Q42ev6x4ofj0qt8+TyNcz7Y0LQMCoQDazlDeTbtgMtewtNmexveVfhZ5DdXHOBfbTY17LUbAk8D
	Ov6uKq3gGXg5iAzKTXSzfEzD1eC1LjUFd2IvkglJUGdoMaGN1R1hO7HA1er5oBbIbKaJFfhIHCk
	3XuGJiuiy5sTDh2q/pnpH/GGvR0xosSN1gFG3bFZlxMr03Ar8bCSB69F+QI87HYiPRW4wVaiga6
	AYgUP3+rsrvuhZPo7rurE6IgAKzrghYfgbkPlhgzR6MqBWJ6sML2RNW4JwutEBdPjLqVufieO5i
	yM0IdGvefQdLYksgr4fBnZNDw+2fPJKd/IBJiu8Xlw6+E5LSen6U+5JvFEHtHUm+dYPND/GdIOr
	J9AiGz7Jkf2P5sCQJT
X-Google-Smtp-Source: AGHT+IFgwrAOFdUdq3eVq2zlNzjKpzUvMXoGg7BPNSNqmTcZwUSfenMYXlBeApSaj/qXkwLXVtAdKg==
X-Received: by 2002:a17:907:3cc1:b0:af9:8cbf:6053 with SMTP id a640c23a62f3a-afe28fe85e1mr1553162966b.6.1756291523950;
        Wed, 27 Aug 2025 03:45:23 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afeb7fa311bsm220226266b.69.2025.08.27.03.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:45:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 27 Aug 2025 13:45:21 +0300
Message-ID: <20250827104521.931674-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 10:45:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19977

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


