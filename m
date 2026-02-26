Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B038FD9E04
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:34:03 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78746.1772134434127566629
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Tmsyx2g+;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837907f535so11616885e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134432; x=1772739232; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PInRt/WHY3y4+8jDmt7oTUWAA4ePzPOx1GhjFEG3Zqc=;
        b=Tmsyx2g+7hDjmqHHoRPd6r2jbxxTYasc84NfXOqhP2GLJKbsr9Fi1owHizquvTs3uR
         hhclQTpxIefBXFuqt5bdEoS7QwMrV0FiZgrQTh6v9ZR/8JVtcziLyWkGhBCN6eCZIush
         wvW6p7lzT9lsQp48F66DodYf+Tybj6kTJ+Pifd9SffN8Uu0TTx60Bh36d2TJTzxg6WWu
         tE2Gt/ERhJ4Gorgh8sqNTboIsa221Du3ESlIXH0Hch3SGtpI9W6prYlATsR/VFD5YlAn
         JZ46BGeSTJgaCIPpG1g2XGOIbLJxUowpAxHmkpQG2bsnyEa4oGco4qphUk/tvNtMJnxv
         H7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134432; x=1772739232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PInRt/WHY3y4+8jDmt7oTUWAA4ePzPOx1GhjFEG3Zqc=;
        b=itutZmIVxDW+m9AdMv5nCFwYXYP3VaoQdrhA4aaWXwDA2P0/oNpWRlsOWT7/RBRaeI
         lidt6knLGO4PQvJvQxzbI6iz7nCJoGLd0b5B4nVC8oyUV2YrS6R4uh2Cls7GTAHSegp6
         OyMlnh6Bg+34VW06QHtTNdtOqPE7EA7KuYkLPhiFI3Tnl+7CZtfM/KP36JqTRrCyJ+XB
         ygJBJAPOPbFvAeUKBXnND8WP09O5X3O5jnUyiAPa923VILM/63WCYyqPhqriRPwC4Lb3
         4aKr+02AvEws9VEezB2SL3wTHbDTN3fVsQKDHGUrQHLVa3PoT4AMMUYo1c2LK0PcfBJp
         t7Sg==
X-Gm-Message-State: AOJu0YwTdCKhfOhEHPFS6M1LII9HZ1ijRVBcKUxYlUN0BTCT3InHWv3D
	VZflpaKAijdyvZ0aAcruWQn/lmXKpyW+AiBoZp+tvidQ8qMwDEmR2FmxdsvDn4Ji
X-Gm-Gg: ATEYQzz4ZXtCYtUM81IY6ykIE5T1PkSHMnR4P7SyTdMEiEZTCxKktNzZE53D8GwUg6D
	Cmjo51jMiuGVC6cqP6aTqlbl34rdg/Idi9oEIBN0DYzA1U05p2bTcsj5+AskxdF1DjyJvVcIhKk
	o3qmcWC8fNXpW/dWLqLCUdIVW4N3JlvLSfYRQR6uMgHlhtKvhpaOHQumTbc/f8pCK4Ce6DxCsTi
	WGMb1ZhXFFnmm2c4rdQlQ6WeyeYrAW1plyDm3p6VQqnaA6UDkFiHZTDPcXG6F0USCzd7wiblkFY
	+2Z8feixqrfiel5eNelNqECHvmIvru0HA2V0yZ6nqbYyAXMHjz3ZCje0Cg8vwfDMq1iEEBbZ4tM
	ZMys09M8Fb6XONEGb2/9s3BSGkMECsIABRiYFBgiUjaNPmwe8/w8vERJEYsk3o3Ozn6rGqnAj9A
	FFcVYjXm7buSmK3FnZiZUvPWAnYsinc/qHePoZvKFa2EN+KS8=
X-Received: by 2002:a05:600c:4503:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-483c216fa42mr102524305e9.13.1772134432268;
        Thu, 26 Feb 2026 11:33:52 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:51 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/8] ASoC: renesas: rz-ssi: Use dev variable in probe()
Date: Thu, 26 Feb 2026 19:33:28 +0000
Message-ID: <20260226193348.449329-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22006

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit d6c160d5e86f4e7354dd6c3154b7cb562abc6c7d ]

Replace '&pdev->dev' by 'dev' in probe(), this makes few error paths
shorter.

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114075856.4751-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index ee50ea30de72..9ca63bff466c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1135,19 +1135,16 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	audio_clk = devm_clk_get(dev, "audio_clk1");
 	if (IS_ERR(audio_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
-				     "no audio clk1");
+		return dev_err_probe(dev, PTR_ERR(audio_clk), "no audio clk1");
 
 	ssi->audio_clk_1 = clk_get_rate(audio_clk);
 	audio_clk = devm_clk_get(dev, "audio_clk2");
 	if (IS_ERR(audio_clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
-				     "no audio clk2");
+		return dev_err_probe(dev, PTR_ERR(audio_clk), "no audio clk2");
 
 	ssi->audio_clk_2 = clk_get_rate(audio_clk);
 	if (!(ssi->audio_clk_1 || ssi->audio_clk_2))
-		return dev_err_probe(&pdev->dev, -EINVAL,
-				     "no audio clk1 or audio clk2");
+		return dev_err_probe(dev, -EINVAL, "no audio clk1 or audio clk2");
 
 	ssi->audio_mck = ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2;
 
-- 
2.43.0


