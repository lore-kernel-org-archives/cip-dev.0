Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDC1061206
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:51 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18743.1773227207536727013
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Y5LraVD5;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c944bb62so5333973f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227206; x=1773832006; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDZ5B+ig4P/YhLR8VZcqpLHZa7GAF1vReP06a1DtYdo=;
        b=Y5LraVD5xjvKYkxrNL24taN9QniTvUVwnkgx5wQknCG4hmKlKppfHp4tpr7ZxnkZgS
         /vBEGlhfkqjLwqgClGVETZ8AePQb5HGqSdNv3OCzsEsjBFj9sk5Pi8lcEvnROFUNIdHx
         07Cm43DGBJyanDi0Y8+0twll5RWvjLyiyVulYGV5C9aqi8P6S3WsbRJinefPxa3Y5JIs
         edh/h8PjU1PYrhi+1b5zJZCfGkA4RzsN5L1vfd6Wt+cck5cPA1zbuKHHHN71b1/NjTET
         YfC7+6PYUtnslDrJm6dxUTc/+iJAstgHJ76d9xyh7ONgskjvj/0lHl2U6wkKip5IGe4q
         ZAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227206; x=1773832006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDZ5B+ig4P/YhLR8VZcqpLHZa7GAF1vReP06a1DtYdo=;
        b=K20MZlML7gvCs2ewXGnac0vVLjzIRVXaZu/XJoNUONBFvfLiOKpDyVDQFLvkZLJB96
         O9aEt2t0iY3J4SX5V4mEy01/UdMPESDBNKvnhf6JcpNeIMP/tcSzOfxQ8sxDBOoR8Pmj
         JZPJAWu2Oe1afZv0hHycvq7u1IIMIPB90b3zHUUi2vIPfq9wzada+jZ1eld4eJyxE9/d
         RtGp/oYnFXgkLEosHIKaw5OhwKsVV+XXkvf9hk2kyfEMs5ZLDHn1qPXifCUQ0edx1wwC
         TqrLi0ti2sG2kmS93k4AN5ubI2H8h0H9wd1DoWSkXw/o6IQ8JNxJ5+UdIWi97pPgts86
         uANQ==
X-Gm-Message-State: AOJu0YyPES5wE16w4Gbc01QYSlPJ1cGEHXEN7V8gLMlQvQzbZdhRTU3R
	wttBPwXwjNXCLV8O9EXnMN8eE2c2P0szNh/NiDjA6SAZ+4JEP6M5zua1eINkLlyc6Is=
X-Gm-Gg: ATEYQzzaBcCesIIiUd7l4WHASWaJ/xn3EOeBM7CuiB1nVl1cUxWjileVb+1hFAib2ED
	/rOnXWT58Ta7WCZjfZNVusenEH3jw+MLzUPCFg6Y5Ws9AgvWHl3eEds//Awaq7sJId/jKjYA6ee
	z3mLTfkfI2aJ0DGAaMXqKUh3vtqbNjgueYC36iaPYkaFwo1a/WJ4XIMbVgQpEYJstS6udKCpbjD
	FlIkZTvJHqYO3Mc8Gj6XyCp4Nct2nH+eD8dlHbZTyJn/hdAozOE2o1rLWQSn+SuU/DDC6bsUtvw
	TdiQHa86VGQ3iZNad5usTKfX4BbDZnwtw+K4b/ZOYpAo2PQxgVQBmKrgBEgnsSWfja8qgS/xKG2
	cs1JtaPgc04Whf80Y/7+zheSbkEA705oX1dY9SVfnV2FbJICOZGCnIWNB/8pybDSK6v7iuuwgLb
	xM+V+/2ZtQZw+LlktNkPu/oOz0aCCNzKo9ORmXnduHcY+sz/5H9jiv
X-Received: by 2002:a05:6000:1845:b0:439:bddb:cc77 with SMTP id ffacd0b85a97d-439f8206d14mr4106086f8f.37.1773227205800;
        Wed, 11 Mar 2026 04:06:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 09/13] arm64: dts: renesas: r9a08g045: Use syscon compatible for the system controller
Date: Wed, 11 Mar 2026 13:06:29 +0200
Message-ID: <20260311110633.1938579-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22335

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S PCIe driver needs the system controller syscon to be able to set
its registers. For this, it uses syscon_node_to_regmap(). But, in v6.12
CIP, the syscon_node_to_regmap() returns ERR_PTR(-EINVAL) if the node
for which it is called don't have the syscon compatible.

Add syscon compatible for the system controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 3f56fff7d9b0..1a2e6f20e113 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -473,7 +473,7 @@ cpg: clock-controller@11010000 {
 		};
 
 		sysc: system-controller@11020000 {
-			compatible = "renesas,r9a08g045-sysc";
+			compatible = "renesas,r9a08g045-sysc", "syscon";
 			reg = <0 0x11020000 0 0x10000>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


