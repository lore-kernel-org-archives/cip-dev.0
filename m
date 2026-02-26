Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4127DFD9E06
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:34:03 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78744.1772134434907501676
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MC121VoO;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4837584120eso8888505e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134433; x=1772739233; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p14neuHwZ5TIghRUWXBspnt0rHQAUdqrldLGi/4Nsc=;
        b=MC121VoONExN9YBV5TuRcZfSr+0y/mNSKWIaMJuzko3M7TxPyMwL1eheAqOouObcPr
         YQN1R+8No/hZLbTMV3a6N6/nXv5njm8d2r8DLs119MERMwmcpuxRDcQfMaFyKV8b7rwS
         GfM1yrIUcEapNxDV45szjDiC39brR1MhLDDIWNqtAePjU7rH+rffKCybJhgON581hyFV
         dbiDRas+Cd68UStuQMdBuUFed909PD5bArxMiCBgtJR0p6ZRtB4s/LSpehOwgBIxtimH
         v3TKG8Fzj1OGVzXXBkPxBPenKDXI1fJkLkmAQjsGm3kq8khku6CSjWuzEaHyGsyraehI
         0z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134433; x=1772739233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4p14neuHwZ5TIghRUWXBspnt0rHQAUdqrldLGi/4Nsc=;
        b=k6kr4rs7EunVieM4jbZSxh4+ZHh3krVMWbuaKem83QxQBQ3Bo4nOjpErKQycVgJRJ4
         r/GAimGwaE/6WjmoBzbvv9ahBY2K448178hMVbuZHs8RL1Q9OmBIu/V1+t0erAYz/DbW
         /KQGygaDTuNQsUmA3DS/0I2KzIxdbCcv0NXtkMZmqTmJNqItixtPjj1+WjHlB9ID6MS7
         UuyvGVwVg/isriSQXAFXy70jjecr5tPsUBvDJ9yZBBkXQ9NW8KRbpxg6BrfpvYKsMrMZ
         jhpapnA3Pps837HnYgHiuIOD4Idl1b/IMGp9RfOY4T3hb83+RLDpMwuzdHfPEgLofbEB
         LvZA==
X-Gm-Message-State: AOJu0YwY4zDGJR0vPeFxXSCaCfUzuMCvoDTF7OBriopm2WY6mlP0jijF
	rlzUBe9xWZcvZ3CJIzkq/3YJ9mBqVXIphFfaTf+k8mJEm+IWl8q6FGwoOehEUq19
X-Gm-Gg: ATEYQzzBwvNz7udaKzDUWbWb2CxkBAI5ujZFQ702lXPzOMCSDN55hASPpuzB7OKnXiC
	LWUIukJoW8QYdFqsYLpB73RjCtxYwr0sNcmQoREoA/VeZ//CPe0iYG/Bdy1Eb47nUlicWq8ciCf
	4qiZEj9PEG9WV7FmhQjciSgynp141jjvj3XzteEDMM8z34iGLTlW4f2PyOd5Mo863xfy544e9zg
	OWoQa7LQuXgAUPV549JPHAJVEdZ69kOw9LRvQFJUXBiisDFLCMCweMGp+ghgnL8L7i9VIJ3CEws
	oGRtaYK+wqmqKqfujsCjaKFUMZ5A3pQjAKm+CT3QHoX+7tvDiwQPcEs6GrjrPta9fURdD6WJT1Z
	tiA6Y49Q5H0f7+CwxPi3EjzwfO7CP0C6yJdCa15XjaiAqm4sm/de2a4WIAAwAm4qB5BiZXhzvJo
	OVKRUvB6HhQv+rGZm4tM5d1opF3MIqSaHbd0LCqSEVofhOK5I=
X-Received: by 2002:a05:600c:c165:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-483c2197902mr88423575e9.17.1772134433024;
        Thu, 26 Feb 2026 11:33:53 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:52 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 5/8] ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
Date: Thu, 26 Feb 2026 19:33:29 +0000
Message-ID: <20260226193348.449329-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22007

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a472f0b157832fc91c83179b1628d8f660c84c82 ]

Remove trailing comma in the terminator entry for OF table. While at it,
add a space between the braces and comment block.

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114075856.4751-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 9ca63bff466c..f57f8e85e4d2 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1262,7 +1262,7 @@ static int rz_ssi_remove(struct platform_device *pdev)
 
 static const struct of_device_id rz_ssi_of_match[] = {
 	{ .compatible = "renesas,rz-ssi", },
-	{/* Sentinel */},
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rz_ssi_of_match);
 
-- 
2.43.0


