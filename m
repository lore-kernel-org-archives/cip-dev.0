Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8FC3DA4A
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:05 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.10342.1746783296084344471
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=E4s8b9rZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ace94273f0dso388714666b.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783294; x=1747388094; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOiKfKkceY2wrX0dMuchwwbXzadmqON7kImNaFMzfeI=;
        b=E4s8b9rZ9FjwmAN/GHnXJHxvwSAh4q6FLja+Uj2+ensd1qJTf/5w0OwhfNicf6nFwf
         S436DuLy3bogniZw1YbzhjPZ+VYQEKu0QafS/uCT6HB92vXt/IOet27REGFFThs2u0gi
         g73B+mhRVIt6FkQcaL/MNnCDkle0dp6WcxFM6a2JibtNdap7q1mL213NCUvNbCgz978B
         f8SUsq3YxCjosjSByO2C7jHXHCkgDPM0XOA64V5b/l+f7KvUs9fm3D7o7BoLPGQweSyE
         Gr41o3cHv9MNb2KxHYAvGulgk0LoQv5SgktEwCAvoE8/4QWwJyel2H4+YG5nHqZlCtqp
         07gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783294; x=1747388094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOiKfKkceY2wrX0dMuchwwbXzadmqON7kImNaFMzfeI=;
        b=Tw84Ul+tYrKTQ/ns9rCe5HceyUBy1jg+iyUGPcCDkduhZ+MAJdqmvAV4O4BV2c8PFd
         05SSgat51rUrOlO7EX9N1J/vdM8rQhraB0coZe3GerCLJEr3M7cWyZClGvHn8NVZ6rfC
         aR9PjHbgJG7+h14DKLCEF3PyJhw+cvdqWBDqcv0MoNR4PPAraIJGqSUTfP1KTriqmGli
         2j5q8GzkwepZ+NTxWRoM/hDulnbkPfFcG8TfXVTErNLqOULOekqQ0Ifq7MLrfBkd52Le
         fnKg02EBl8bEuPtjPof0TKzGGzXwU9DRLu1Vx/hJyWSxPX6t5Yusv/vtKxyL/UkeUdQm
         rvig==
X-Forwarded-Encrypted: i=1; AJvYcCWaNJsJiSTr0JvuFfetOhU3hiDJUfbXWSBqKdbPVsJyFPcaPLNO5k/Yc4ZSwpm8H/9DTHxwAvis@lists.cip-project.org
X-Gm-Message-State: AOJu0YyzcqF32t41vGJXGTE0QnqCNzqj5wGJ6lEWrtTVgGm+I8wyGefm
	tQndJ++7o+Oxd2onu6qr99odUK0ly1j6J9+r6Hrv0P0V0S+tmgp4wGrWYywwFN7SWip5L9QftD7
	E
X-Gm-Gg: ASbGnctxLqCLO0CJID6X7frwfM6E0ObuIEHEjbyAb2w5xGLRqMAspYzEiPEL6E5tYUm
	e+1ycems62f2zUSc6qXAJvZ7XJjv8wQ9mCXEOGNNWsD+Wo57YnXcKKUZRTjZGAchDMaRvQTY1rl
	4lQ92iS2l+hHJ26rBJJLcvHtNrO4WAkwv+KItdcTjtp5+ACXVkad0SXJr+uxFf54PiH/9GP+TvP
	agL24BKVz6cCCBXfmJ9GxaF0/eAnDHQdrNL8M0krLH0ofaEs0se+l+jyxeVrzxvbqgdkDSLt2ET
	oShvLrwOdUriBcD9RChXCTssLLb/JrzGKuXlckWjfMXDy8TXanF4Rye6ji3cUF+xgKu3aA==
X-Google-Smtp-Source: AGHT+IF5Fvv20Z7s5bAtvZq9OK52ls4IoK2gcsjggsMvL/VTGaj2qb3jElV4A0Oe4aitA0tqb13ZCw==
X-Received: by 2002:a17:907:940f:b0:acb:107c:7aed with SMTP id a640c23a62f3a-ad219291ef8mr285234466b.55.1746783294459;
        Fri, 09 May 2025 02:34:54 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:53 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 08/37] ASoC: da7213: Avoid setting PLL when closing audio stream
Date: Fri,  9 May 2025 12:34:13 +0300
Message-ID: <20250509093442.4015145-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18860

From: Hao Bui <hao.bui.yg@renesas.com>

commit 1e1a2ef95b571825ca9c0113f6bef51e9cec98b0 upstream.

When audio stream is closing, audio frequency is set to 0 by ALSA but
codec driver DA7213 does not handle properly in this case. This patch
adds checking of 0Hz frequency to da7213_set_component_sysclk() and avoid
unnecessary PLL settings.

Signed-off-by: Hao Bui <hao.bui.yg@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-26-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 61edcf70e717..32d03f764e00 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1555,6 +1555,10 @@ static int da7213_set_component_sysclk(struct snd_soc_component *component,
 	if ((da7213->clk_src == clk_id) && (da7213->mclk_rate == freq))
 		return 0;
 
+	/* Maybe audio stream is closing. */
+	if (freq == 0)
+		return 0;
+
 	if (((freq < 5000000) && (freq != 32768)) || (freq > 54000000)) {
 		dev_err(component->dev, "Unsupported MCLK value %d\n",
 			freq);
-- 
2.43.0


