Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83250FD9E0E
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:53 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78945.1772134967116385254
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dniLRI5l;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4398913af88so1122062f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134965; x=1772739765; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mmBT+8dh05covI91GC/zpFBjLiVhsra19415+6uAp0=;
        b=dniLRI5li8BxhLOiDV2o3VYYMzMywopJO16J96BBTRqMF59RGsxAW1cN5novAGZEVg
         ws0mKczZW2gz9Fpk51NomEgTdbK9qcsSkp80wMYfNuBxnn86oxEJGYrRFf/w4Jya9lMD
         jyK/fJzt/bjHZPkNssKG8ZhTX729us3I7ILMD4dyFWrQQbJg+4jhFy9GXlv1Pg0p7+LK
         VfBPBjLPdxiRz7TmVqIjn7jRkWJVLG123iM2TMiNkaEevuw3b2BgeLqzaHq0FOZaK3S0
         psQ0tUdmCNYdgvsed1nGjj+LxIXpvwtdSWJqZQizfVI5GW7wCeoTg/mtAeaYXWIarb7I
         lLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134965; x=1772739765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5mmBT+8dh05covI91GC/zpFBjLiVhsra19415+6uAp0=;
        b=Ch5TG9+a6KNgUFAPUAM73+ddMeGOjjiLX/uecJuYc+vxydHUURMU+8Mplvzs52OXxp
         Qs0Oiy3uA1thiQ3eh6UcwqjD9UrZwdkEIcVcM8B269w7sKTBtNX6ME0mrwpzksHgEqlx
         oLlQphxDYGN61qRvn5Xc5vda+9rLpXgRkEpOCa7BvvI6LkzYa627deuuSv44wf0GTors
         j9CwgHVb7dNwdmpG/UisYgvisa83EBlzAW8uDQYl3oyRi437Wrz8QBSe/svHc9uuiFnr
         sYHBQ/gaa6mfcapdEOHsIG66ACfzZGSWperjUtAKer80k0dDtVcqoJlNBdBHsx4O7iXf
         PGlQ==
X-Gm-Message-State: AOJu0YyBOLWMNE5id6C/QTVajEfR9RxiUXO6+th9ExMi/eWQQdmiw80F
	f7WxlpVVlwjQQ3AqsQ9GqI8X+w4cIWBmAm3B2YKRd4lM4pjadiU77PnxjITJzxUW
X-Gm-Gg: ATEYQzwh3H3hWJN5lsLJTcF6jminZwNHpY9Bs1loZBDZFwbclZXihKE63Jvu5X4224a
	69ytc2mWQRC3FjCideNg3CcNzQYD/mKSRYfMjOuL+6PQEt3U2QjRbc9Ba45ADXQJNPkjE2Jl6xd
	RFrvBkEhu6jf11Y/s11oiuPg08ygCBKgu9OThCcpDMkwCvCIvXz7kASDSiJKsuN1c7qeSrUHQq3
	NTQHe6YdTURGiOAXUuc+vY0POeffvgLumX/lDksG9h8J+5L8EOfejcGS9g9j19yVc2vjCiSKWpN
	LJhVCApCDFkbpJhnVkakYJdnO/0GoFwSBP1EgoprFl6eS7Ut8uL3tQRVHrcFq0Ao3P1bYF8fAD4
	uTqhMghgclSFo79CyuuktDd3mv7MfEIJOKDMn4UKilKVSZlbZLhAHb1Pt3t+J6v4V6jP8Cvrv+L
	6hc3TnsBhAC0jbuFcYdePt4CEGoRrg3oXt9Ix5Vujymh99MUo=
X-Received: by 2002:a05:6000:26c1:b0:436:1989:46b7 with SMTP id ffacd0b85a97d-4399ddecce3mr61870f8f.15.1772134965232;
        Thu, 26 Feb 2026 11:42:45 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:44 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 9/9] ASoC: renesas: rz-ssi: Add support for 32 bits sample width
Date: Thu, 26 Feb 2026 19:42:30 +0000
Message-ID: <20260226194237.449383-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22020

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
index ccc33ca34b48..0c2dbc7528f2 100644
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
@@ -1031,7 +1035,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rate = params_rate(params);
 	int ret;
 
-	if (!(sample_bits == 16 || sample_bits == 24)) {
+	if (!(sample_bits == 16 || sample_bits == 24 || sample_bits == 32)) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
 			sample_bits);
 		return -EINVAL;
-- 
2.43.0


