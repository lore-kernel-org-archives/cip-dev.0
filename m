Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C23CFD9E01
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:34:03 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78746.1772134437679998980
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f3nwU/Bd;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48372efa020so10462265e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134436; x=1772739236; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtzsuX2FnpPHhWmIOuIov7UDLyVntEACu2GVIo8tzow=;
        b=f3nwU/BdGDRMR1z3Z+ILaPkGZuMHqots48gZSVgtZmxwh8EBFDA/X+pX9UnupgxMME
         DkWAlOPLBPR3noHa83JU1GaAeFBMG7Te14qZO0v6emlYhIN4uadR9u/oeoL8o4l1k/3D
         OwqhpkVmI5lIHP9Je5sp+NAz92fqnX7FaAH3jUrTbc2DB4CzN/Uf7FTxFY9fLt00iVUp
         4+ykXTdh9xkTo6fDn2VKr6TGdRsVWp2QkqAXKYHJ4gvCqbUZBZuyXeGVd+jzBSI3PYPi
         vE0gTo/p0+DAX1Ysnb3RdrCorWpfuJMWpO1ElWyPqmro1qn0PD4FNnpmZ+1lYEDwiTFo
         7wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134436; x=1772739236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtzsuX2FnpPHhWmIOuIov7UDLyVntEACu2GVIo8tzow=;
        b=TicL2F9jPi5L3E2QecFq7ocyHULUuRV0zKoxmU/GC5Bc+ltPO3127Fe2AacASKEt7R
         b9PNKy8lVQv7QB2rTWNKak38xbtnD6LppOFSpEBLBIi+IYA7kiEZh1bjWoZghV3mf/mU
         t7fxKg98f/ftIAACPLNaRTLQ1VVWZzYJaXKvt4ConwbE+H2ylombVR6Y/xJCOlfiSOli
         GXdB8eigvbzIMKuTVGjQL8Yhlo8bObn93BRxJzfM5+MVtUQgvgf/pYfsHZim1jALtJab
         xLAkaP7d+I/VnkkA71bleHoMvbrsRycDLq0zW/hNGhhqT9Z7k68qqH9tZWS3pu2LK9e8
         0VEw==
X-Gm-Message-State: AOJu0YxE8L4DAsBHg/fZZRTOAr9m3AOTFesdc+P9seZ8KjNyjazGmfjU
	0PV1tY2NX5O1uvONeh70FINF6D4SqlhhaU/RcyYoEFCc9wgY/4wJTCecKq1ULb66
X-Gm-Gg: ATEYQzwRT6VY+p9xOPt+s0s3k/PLX4/wBH4OqyIc9XSUPdoWbPPrhb82f1yO8wV56XU
	Lgj8NlY0hn6PKhW3xql6+hm/rKvmkK3EY45R9NvB1Enc1cpaX1gA5LBCCdjS64wwTOEI0bYfKpZ
	wK/8end80jCMIHtmCI0ZwfZET0OSsTNVZABbgYkCFR4US1R8UwuWuj2e/pY+GjXNr2ewLxw12Sm
	k7Z8+ksdvonHkTFy8agPevqCO9WgQ5yFx2wPgEQWyVGPpj5o7QMvaSoqg+OfDPgaranqU2O1qtQ
	owhc3ESCXkvW2ZdufDZAx+5p8EYbnT8nMDnJSMNSIv8HqqLVlTq36Qpz/ZteYmwd0P4tAJKzk0l
	Dy91l0TJU0VSLtHhZ+G6NU/Zer+mJK5h7+cy/D/eZg/r6I8Q3cx3dDMYs5VPvPCrt2qAr4oQIrU
	UWVkfLY/MX7j+QITP1rwgUGZAYvCUWrUZAwz8GAaRkF+vzF8c=
X-Received: by 2002:a05:600c:4fd3:b0:483:7907:ea02 with SMTP id 5b1f17b1804b1-483c219ebc2mr99149895e9.16.1772134435602;
        Thu, 26 Feb 2026 11:33:55 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:55 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 8/8] ASoC: renesas: rz-ssi: Add support for 32 bits sample width
Date: Thu, 26 Feb 2026 19:33:32 +0000
Message-ID: <20260226193348.449329-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22010

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 124f6155f3d97b0e33f178c10a5138a42c8fd207 ]

Add support for 32 bits sample format width for RZ/G2L SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114075856.4751-6-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index b6692921eedb..b50868a9d2db 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -76,7 +76,8 @@
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
 #define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
-#define SSI_FMTS		(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define SSI_FMTS		(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+				 SNDRV_PCM_FMTBIT_S32_LE)
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
 #define SSI_FIFO_DEPTH		32
@@ -310,7 +311,7 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	}
 
 	/*
-	 * DWL: Data Word Length = {16, 24} bits
+	 * DWL: Data Word Length = {16, 24, 32} bits
 	 * SWL: System Word Length = 32 bits
 	 */
 	ssicr |= SSICR_CKDV(clk_ckdv);
@@ -321,6 +322,9 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	case 24:
 		ssicr |= SSICR_DWL(5) | SSICR_PDTA;
 		break;
+	case 32:
+		ssicr |= SSICR_DWL(6);
+		break;
 	default:
 		dev_err(ssi->dev, "Not support %u data width",
 			ssi->hw_params_cache.sample_width);
@@ -1033,7 +1037,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rate = params_rate(params);
 	int ret;
 
-	if (!(sample_bits == 16 || sample_bits == 24)) {
+	if (!(sample_bits == 16 || sample_bits == 24 || sample_bits == 32)) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
 			sample_bits);
 		return -EINVAL;
-- 
2.43.0


