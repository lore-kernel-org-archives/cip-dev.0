Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1081EFCE076
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:29:03 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78616.1772134133657666303
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:28:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HL9DRCBk;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48370174e18so7108955e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134132; x=1772738932; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37NccFdW8lPD7B8yA8KYMW1z6EKIJqgphcMHZlaCVfI=;
        b=HL9DRCBkg+e6E00bbJrSRD6If2CkSK9Nh6ZotLSXx8cRUxtaVwgLePrfUTb90tfRuk
         6hnJwhzn7rtyMEWRwC/q7JBRDlCZwtxd5qc3u3z8uK/2F1cm5nAtkl1kdC70o8HVNIzb
         7QrSjioX29G/OaWn1t6fVTaIh4TU+6jgWPYY4DuY1+EdrJiGJcPPXHWX3LOXgpYm7NAR
         AErGBetAjFC5sV66jaOq/W24nZqHfL0KOyb+IAmOO1W/MPBKhWkMBdsUcPUm1eFVkVok
         EuU1UB2NDQgzhS28makWsfVX5OSd4DG2BrOpkMi/S3pos/fvxZFvZc8OKKrC4Lrcn5Gf
         5jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134132; x=1772738932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37NccFdW8lPD7B8yA8KYMW1z6EKIJqgphcMHZlaCVfI=;
        b=UIm3F9oM1FNcY5HpYrJHB2546gzbAkSF+zDzaUdYyz4g7Xkk0cDjvi2rQZMAzXBPcq
         ypjl4lu/ru3yaeIz2FziFyHk6I54ma6ykOj66x+pYFFiKCOXXqdUY20MdRDPA+jtih1Z
         UN7bc3kXwTKZVAjMrc53Lv2i3Q+DZpSim+h5uk0xUK57Bx+LLbsxcWmIjzKSwKkNk5jj
         YmDrUtPky/hO7RXJ16xrf7Z/tr3AD3Ba9zocc0saW3oqMEWq5lWoxfYMEWjoEd0Y8FfA
         yfF80MMFWLG5f3Jjjyhk3MD28ZjJ3jDoolXC21InTZIVyOr1VN54pBB0aPMR7MFwB/mz
         qtlg==
X-Gm-Message-State: AOJu0YwtVzYCZ6VjAWrbmUgFpPD9F+UUX9le8fQptmUn6Kmwrqa2m2F/
	eov4SqtSHkO/CQkt8gGCjM8ntBnVOBCFm2RKmEPatuCD+zoVNxAYn1/48DGyi8sq
X-Gm-Gg: ATEYQzyxtkx+oGK8dd6K2NSXtLqXOBDL1/Rbg87m+tzdEnmHD7mREPh/t5B2brep6EM
	Ppv1ocHQThUGh8OtS3hjR3RL4Bq0x4N6aao0c3HuRJs3IJ+JdhsZtH1g6is2ODo98tOdhw1dEEP
	BZjx9o2p6r2KrOE+Qz7+/u3fAB2fQe9iOEdHYOLY2/o/zzhn+fZu6wEsHdv3GXeoel/VP+VolHq
	zevIQYbW7JIh88eYLKZH/nDrAGrVXE2JM/Hv7cax+Rvj/7L2N4YAoznkMzS+yVprHyM4iT5fRgM
	zF+fD7s/CTfHMIOXy+0ZfEI3nmH9IiLarTcLalBxb5Ak06ZrStUmrxy3pMXM5T/7i48cG5GKC+V
	XXqOXtVd5yfJu7Qvu8t2XyREyUTDJnmxVrTZtOV09nAmOjFGsyC+Y/Nftl7g+HyFgPW6AiV6xaN
	cYpLCLh5YGa1iHDw4hclqwzqyPy1g8Fq5E5YsxDD4j78rAJls=
X-Received: by 2002:a05:600c:6385:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-483c9b53c9cmr343515e9.0.1772134131599;
        Thu, 26 Feb 2026 11:28:51 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm76701365e9.1.2026.02.26.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:28:51 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/5] ASoC: renesas: rz-ssi: Add support for 32 bits sample width
Date: Thu, 26 Feb 2026 19:28:42 +0000
Message-ID: <20260226192846.449277-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
References: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:29:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22001

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
index 53a5d0b9d58c..808dd6dcbe12 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -75,7 +75,8 @@
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
 #define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
-#define SSI_FMTS		(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define SSI_FMTS		(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+				 SNDRV_PCM_FMTBIT_S32_LE)
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
 #define SSI_FIFO_DEPTH		32
@@ -301,7 +302,7 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	}
 
 	/*
-	 * DWL: Data Word Length = {16, 24} bits
+	 * DWL: Data Word Length = {16, 24, 32} bits
 	 * SWL: System Word Length = 32 bits
 	 */
 	ssicr |= SSICR_CKDV(clk_ckdv);
@@ -312,6 +313,9 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	case 24:
 		ssicr |= SSICR_DWL(5) | SSICR_PDTA;
 		break;
+	case 32:
+		ssicr |= SSICR_DWL(6);
+		break;
 	default:
 		dev_err(ssi->dev, "Not support %u data width",
 			ssi->hw_params_cache.sample_width);
@@ -1024,7 +1028,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rate = params_rate(params);
 	int ret;
 
-	if (!(sample_bits == 16 || sample_bits == 24)) {
+	if (!(sample_bits == 16 || sample_bits == 24 || sample_bits == 32)) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
 			sample_bits);
 		return -EINVAL;
-- 
2.43.0


