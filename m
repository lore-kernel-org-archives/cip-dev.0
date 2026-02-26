Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E063FCE076
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:28:53 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78616.1772134130614024710
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ROS2URU5;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483a233819aso12750475e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134129; x=1772738929; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnAjzwbXaaGFvxciyaSoGqmF5UCJ5FXZ99HiJ5LycNI=;
        b=ROS2URU57KFsC1NuDMT/hQzGXaO/+NctcC878j7+c+9zhld8bmVFEK6M9jOvMM/DCg
         GWDu2yoPv6b5qrdOpei/iy2ExxlwGfd7EOzQ0Rh49c+DNIxUCMppmjAsLLh7d91+v2+6
         +OuvjYe/h3cSQy/4O63Le36CiXV/9JwUHEJa0UkYDbQpeojFC0uopKNS1XSyuwg0hZvO
         hTsBRg62Xv8I5yApJLhQV9JIlhIHYFnwju6J/PIh3du3RlBTMjnbPpZTmzSRSZdHbIZY
         zZrBbD8QFOscM//RUSfC+cVd5SvSithlHO6FwNFRKa9ABgQxT10z2jZVXQFo76GUOOym
         /3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134129; x=1772738929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnAjzwbXaaGFvxciyaSoGqmF5UCJ5FXZ99HiJ5LycNI=;
        b=EOHRlnDbl78/wKp95U3Gsc07SpdJ16pLRYQwSiISS0Fe+s4L3sN6DngqEvQkWaY5J6
         /0+lAhYTSC6e1wWrFjVrhIJhm1FLXefSA0LRC0e/AOw6zAyOR6lrgNrOy4cJ8Wu7lEGI
         nXjXyy5qU2MHDYsbxijxOaBe9t55mzwSbL0zHIi8TPMPlVHnOoHuecm/Ml3KhjDnpzAE
         MZZJz8hU/XBzf9YPT2KMJ4x7ORYQFzGRAPeDVqh/JHiGMI+KVBx2f3Y4y+iv7qk9XC/C
         Ld9ujgZd/5LsMcQ8UMFo9c9pvDazeH6PURBhCc1ctMdC3TcfurW+7MXYq90xFr7Olpp1
         0kUw==
X-Gm-Message-State: AOJu0YzM2oTAvFMy90EKH7vd4v68kGOkVWeONTdXUgVX7eYkLMGv9C89
	QzKRxckTM2Z1X0XJHW0lzSsM3MGz4qrfdskTjaLsmTw9X6841A+0eVmRHTnfsJjX
X-Gm-Gg: ATEYQzyhSRoccWIGCQRlkU7NbTdIAy1VC3kT4yg0lndFpGI7uFw/4ppWu06TUy/WQvn
	W0PsEnn0MCaVmFdnCMm3sTXJy2qtAE53h0u78Hg/kPgqiZtb1PKfq5RqtxPTQmdfjVWcbsYU9tW
	MQvQgQYx8PSVawmB+XC5NK0VIvYZJ9wn+AYxI/Y89hQSpCXdqC9x5Xl87ZZK4z1xHx0n6cv1SS6
	ZPnECemlFExxqO0/0EH8MpZ/XUBt6gm775Yl+j7JxLz37kLE/HFfyWlmya3v3Q/M+bm2HuteiwG
	w83WWNM1GK+/9G2sMfSklPn0aR5rkuUlMJVDS6Q0lowCtSqEN6LIy25jWqo6K//nNhCsYFLlAAy
	Bg8prhHAoCXuWetPB6O3cA7s2VXocBiQpV3fW3FfTus5757JfV68UN9IMUbEGDy0SMId/UiURDC
	S0l21GjKJhcpm0ElIPNz5WNiE3ooxL8quuld3ZzRYGnJnkkTo=
X-Received: by 2002:a05:600c:4e0f:b0:483:badb:6191 with SMTP id 5b1f17b1804b1-483c3db0103mr57270005e9.8.1772134128512;
        Thu, 26 Feb 2026 11:28:48 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm76701365e9.1.2026.02.26.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:28:48 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/5] ASoC: renesas: rz-ssi: Use dev variable in probe()
Date: Thu, 26 Feb 2026 19:28:38 +0000
Message-ID: <20260226192846.449277-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
References: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:28:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21997

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
index 8c32e3bdd777..c5658fe0aaea 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1127,19 +1127,16 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
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


