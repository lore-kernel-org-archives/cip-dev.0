Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6619D10611E8
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:40 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18283.1773227071849552892
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YjTvlaOI;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485345e1013so6678265e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227070; x=1773831870; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft7TdkZ7BUAmt99j6YdoQU7xWgIgCOp7kdlcjt2Csuo=;
        b=YjTvlaOI+kX8Qufez67u3eIKZwp9yQW3Lz1TP39PAPF9mnEjPE1iKrVbAV8e5gO5qB
         QbKOu3fLh2phbwqHNNMQJ7L8+laqmLHdxP/BRcLIoAloCkf0AaacU/Ss68nN6T5YKeEe
         GQRLaH1FcmJqpy1xEcqjZiLMjI4gRm70slZY//gEI36sBYjxQ4lO7yqlzph5luKRKUyg
         7AXm0Atl5bpoGHjzDYJb0GZVxqlzfvNcGilv6heGBb/zWzujk8A4Ly/SD1TZeP+yIGsc
         bsImNVStP9WgSp1ouA3YCMVuj/bmmqDMtN3Q0xPHS8KlUKqnBianTaEq7G99Oc6ph6V9
         Diww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227070; x=1773831870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft7TdkZ7BUAmt99j6YdoQU7xWgIgCOp7kdlcjt2Csuo=;
        b=Mc5BC9JZa9d+IEYKGvxLbPx2AYcIpe5u6LVVbs5FcYUNDmcUHwGuC5SjkCPgOt325w
         FDIqumCc+ivflNkXgICaWmjSxoD/iXrN5oTLdxjYHk9mCc3JgnRkV2vbTozWw8t4Tqan
         wtHhd73G0NjU7R357WvUzlUjnkBHm01Vih622e9kxDP3i3kL24XD0PLRno8ZpLNcSrsY
         TASwGyDw58IFTStNKFFq5DMLQ5OCmYTKLAExMkPnlAljyNlgR3IiPYSPmA+dw7xCEdTr
         fI/Na37eQk041u34Uz3cKd6Bdv8LugdQ0ypomOCioC8elVIGHo23z5Ket0hJFb5qjdEE
         ztvg==
X-Gm-Message-State: AOJu0Ywo+wE7mU2u6ikd3JVo6+TJZnFwQe3Rv8HPmu6WmGKPDOQ2TG34
	rCaCmvOeuVwbjEg/eL5n3QA4jdNrcCSe55Q8uxDR8QT5w8Joa1tpP8y0dar7lj5pIQZGFNc5KRb
	c+Iz5
X-Gm-Gg: ATEYQzywdUnFEkrPePHcmXF9CcuKE8hgAc9H0tmfY8cT3gsqUpyxX3MvY0TpUmIuzqc
	w+q1tnnQhI0440auefEm//LigilIq3V1IA/VlEyGXRnzBNQsnht/2IB/vmCJlH0Nan4NxkMvqX/
	lW0KsmPAwbwWpvCmnWR9z93oqz99lzHkuFfFURzhDZwma9RdK42pj/vXn52ScOY2XGkg7d4mffL
	Jb7pnAIaLn4EARQI8VQXmyeLbdAEfjjrhrvWQx86XBtZsGR/K+Olzj59WI+TxQ9+9QSvuvnLeOa
	laihRmCe714NsXQCZAMq2IVeP5963JvAXuVESNacEIu0Bl0rEifOEbXCCIkD3lNnwM5rPk8dvIQ
	9LUqmp03owG4X3xc0WLKQiGM9xpjYHSq0G7NOnflptJRf8z7eZlLBDXQ1lUFr3TBrgb2O+eD4tI
	TKl1jJxSiupTPCvGD27qGEAPEI5SXV3uHfL7EmIzpsH1t/9uoj0HELsJ/NtROK3qo=
X-Received: by 2002:a05:600c:1e8f:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-4854b239d48mr29855575e9.2.1773227070125;
        Wed, 11 Mar 2026 04:04:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 24/28] arm64: dts: renesas: r9a08g045: Use syscon compatible for the system controller
Date: Wed, 11 Mar 2026 13:03:53 +0200
Message-ID: <20260311110357.1938200-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22303

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S PCIe driver needs the system controller syscon to be able to set
its registers. For this, it uses syscon_node_to_regmap(). But, in v6.1
CIP, the syscon_node_to_regmap() returns ERR_PTR(-EINVAL) if the node
for which it is called don't have the syscon compatible.

Add syscon compatible for the system controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index ddb2477675ec..8d90ea8a82c9 100644
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


