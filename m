Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E463CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 11:09:02 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.20045.1758107337570184245
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 04:08:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FzQHFaYP;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so23897765e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1758107336; x=1758712136; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q44NpvnUsN6W+/RRBDaeF3Gmk9zwZVVCiAr4riKzlxk=;
        b=FzQHFaYPjxecgnVP3nOzo6yuGyyb0nrxwV1TiZxfT/FfADru4RvC98RhyYp48814+l
         7Zo2FCmcDmH55Qz/8g7BjE6RW5ywDZY4TWEOA/dKaihJM7z13eZwqIrB71Cdu4WTzxeU
         1/nk0DyWQ9PZmRKKcL0EYSH3FfMcrvlepifHxNHSKj+hOt2kHS751NP65SAVTzYISsRF
         n6omXi5KwCiL6LnYz4sNo+72hW6nrpCg4T7L47PpHCUq0g//zmU6iwC+tmgUHiaqTlAw
         wOw3nYgTETP1F1ZZY//Jwki3WkHJWUVR39NsjvwCo6PQSjmvYfZkXNbTSBV2gqCyH6Dd
         UMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107336; x=1758712136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q44NpvnUsN6W+/RRBDaeF3Gmk9zwZVVCiAr4riKzlxk=;
        b=rrtvK3B0Ac/zIZUlX4wesIwasB5oZcW6qzS2sXhZqxikroPk3an56OI4NqHZYsorNm
         B7SpyoBKwENyktp4n41KKSUumVjNzrqv3olXdBtJrUTS8rBjRmJn3oTeMDFC1G2LJ3Tq
         m6fVkVVrN6Yevbk6nBUSd7yXf1ZUurtWn895E2cqQMhnvNnPBiNCZmJjAcG94npnkSih
         doT+dnhdxin5c373kmjA1Y0yE++eem1HvADj+v4SJ38WefMPgslwJlyxKmhO3VIez6HY
         UVGCpf8FJX9Drd35i0X+HTwdyOc5iKEgFj+0RB47dKJgmF5NmtZxMTsfGIZk7wQWRnn4
         sUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8k91ovWTfw65rBzXAVM2hu3ElVJPB/0HiBd9gJiumK2JYJNg8omm0mRDf8C15oiTnV8rb/q8L@lists.cip-project.org
X-Gm-Message-State: AOJu0YzhPjRz3o+tOgjj9gFrXu11jRxcderNJnFpm7MWGsdVQNbLATJG
	Eii6NR/NZy9Cl3arLH+ijIrAQK5FVotPPgsJfrykpBw86AdE7xpVQAw18ZBYFtGhli8=
X-Gm-Gg: ASbGncuhScnm+54yeYA1TfXlpEajZ2zL2ciJElQTLaoq2MiYhmER1i7pNGTKM9nOuw/
	WaeDZXYt3GPbviTACzYKj29FoxVHq6oJxTDvLP5OW207ggpGO4kVdhS933dSLszpVt0FwkTa4wR
	oJYy0AkMa0j7jhEkwsOKoQiEm++AxBEkAbRMIeyHLKikIa++NI4U8yxgY5G/tUT4M42YjjVa13c
	qQf1919JfrsqWrd+M8hhrYkmoxe9tljQ4N5HxEdryozh1jsKVa1IIvaanYXx7ZGHT5tmhHm5k2N
	NRXo2nWI1n00WwlC0lzPRF1/yc+DYcX0YAjEyPU7u0VNUNX2nmgIY1FZfLdUQVgmKNn6lfiwtqP
	k3pwuwoQ1UyZOhtyb2u6mmZhCy175OFvIXEA80cQ1iVR/1X5nmc7A
X-Google-Smtp-Source: AGHT+IGOsWX6H4IKeITngMmfSytKSu6KptNNTFZaeFA9NIdbZ2cQEHDtiWRbCRBfr5VgZ5/nMh3R1w==
X-Received: by 2002:a05:600c:4f83:b0:45d:f7e4:bf61 with SMTP id 5b1f17b1804b1-46201f8ab4cmr17942265e9.4.1758107335817;
        Wed, 17 Sep 2025 04:08:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138b5be25sm36549745e9.15.2025.09.17.04.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:08:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [RESEND PATCH 5.10.y-cip] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 17 Sep 2025 14:08:52 +0300
Message-ID: <20250917110854.326336-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 11:09:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20075

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


