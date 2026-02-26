Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFEFD9E10
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:53 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78944.1772134964194627615
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JkufBnSJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43990aa7dbaso989123f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134962; x=1772739762; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gO+WOQ/7sVQfL3L4eVBO+aCF48sKezCS7E0V7MDn0U=;
        b=JkufBnSJOoRs1hdD1Z+xOeHrCwD2bA50jCuKhkyGdTdPtizEQsvUlnvuymY2TQA8ch
         B6M0xj/5OBoQZ+JR3bgniZBos7GdzM3kTlr8gteiUE4C2khT7k1Jbm7ulp/MtApaaC+j
         1F04j1Xm/99iYF5vbb370pH9qlwxUJ6SACAGOPhWc1AKV3VbAX3roFECZ/G1vgV1TSKe
         wSoh0hLBmhir2w+hoo67Lb0cD/AQj25BGFUnyT24ERX9O8DYH2nCReh1AKGHhR+MCE3o
         EMbGh/m8KQMW2wUwGN4aNa6LbizdRrscKzGlAxIaVLf7bONuFWkykJg/W+wuONqkGrIM
         T7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134962; x=1772739762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7gO+WOQ/7sVQfL3L4eVBO+aCF48sKezCS7E0V7MDn0U=;
        b=V21TIkH/MHT/rKBgjBQB1wcgFs5p1ZMkds7Hx+oGoo2mwtAqLxPxjJTocvdelO/OOp
         rX5WqekGNyOVcUvpPF+uv/IMiRbbSof3hUYtQxAU817mPEu6JaVf1plbFOpIklSOpXgO
         O68I+K5oR+3INPjlLNNgSb3oXl6hyyBEZ82f/IGulVXuyAJY4ocGtaI5efw4O7YUSGSu
         ayGO5CqF/+JuaQqHonP0yd9sv7d0lWuup0TaHL57rLI8yaCzi5dyhfkNnPOom2gxeiD5
         dyuADhKkNonoD5o7pxTtwj0eBGu4ys+Eq5F0gh/zA5sMGL1LdlD4lFifXo5pGJ8D26g+
         tYCg==
X-Gm-Message-State: AOJu0YynO+LB1vNSLffZIdParf11m3WL1U27dj2YlrKXUEv0X0bOCaja
	H3ADhobX6pU3PuWcY98RaJUj9Qx2O2raexuJbt/UMRDOFGRuZLacSKZgFg8AgE64
X-Gm-Gg: ATEYQzylLzznEjQIKrbiUPPHZQzOZfTtMw9rBa9a2lmz7nwlDllVi9VSIohAyT4fzUS
	+V+1yeP54Su2HraqtJEWf5vXnMZg/EgzW0/uDUO6M2NDEMKOJDSvuVEBU6FzKxXQDGNZjpVTJa/
	9VK9W6Y6bUSjD8ldTch6v/k4GOnGcBiwoqUCjkA7laBcn8R4/7ULF179qdCSG66aX/FTssCtesy
	LN6vzdglC44TZ8C+cyG2PVsZtxbEFXe0jhVCK6qEvftMXxFH4DBgOjqFPs0hsU+EWEtktCsFz0t
	h4Sxxo8H0hpMimFWzV5J3euSZG37BmJf1JBdgreA2qjmhvP9UFoA+KDor14mkoFpLJFwqopocRV
	EiWvkZN+xS3kYVyBCTVYUkAjNBTqcZntFJU8FkpPQeajQCZW/PMocu67gbmyIbxKvrwv94drOfG
	788Osz1vjUkPSkan74kZcRsuD/lNmBA2beYrOb3/gYL7ykXIQ=
X-Received: by 2002:a05:6000:2482:b0:430:ff0c:3612 with SMTP id ffacd0b85a97d-4399de28a69mr29851f8f.41.1772134962209;
        Thu, 26 Feb 2026 11:42:42 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:41 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 5/9] ASoC: renesas: rz-ssi: Use dev variable in probe()
Date: Thu, 26 Feb 2026 19:42:26 +0000
Message-ID: <20260226194237.449383-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22016

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
index d10ca9ee99fe..5d3a318f5d09 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1132,19 +1132,16 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
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


