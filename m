Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92889C3ABAB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:07 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.20351.1745934485592373652
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mQVyHVhl;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb39c45b4eso960542566b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934484; x=1746539284; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo/vcjF64X7ZsuAoe3I68C3VPgc2cEmgB6i8lowYWjM=;
        b=mQVyHVhl/yX7nvX1axtPJ5WtTcJSZ7BI3oQ4AMOPLFwajJqdUtDsWR9Fu5ZYNOcSBA
         6lK/K1mA9Ht+5zX6sqGGrmHLgtoul1ePaDYmoTBKOT8duZGJeyCJuoCELwgO83Tiuxcm
         Sq1pHzk3c1qozHoQbtFMygajhDM6aWzeW6lYFzS/D8X0yj1DhEAVjvL/J7R24FIZdN/z
         A4z6nvVI3kpeSROeWENZ2j5lHGXb8JVeqmqkN3C7ri1rUiJaKAfNwlMg1CgyCPqf2W3E
         sVgj+t0ljCqhkGRM7gz6PdnyJT/jV9eVXe67Rc6opzNphp4WmLgmI4a7JcPIqoRz9gPz
         zBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934484; x=1746539284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo/vcjF64X7ZsuAoe3I68C3VPgc2cEmgB6i8lowYWjM=;
        b=YSfLqLyK1sboxxOd1HE9XbMMdwL4NwqB/GSqyo/ZXOiiQ+r+rwClZC8bNKkrup7wHZ
         kWmTC/b8kqskr0IYZtRqWR4fTmKyb0SMDmZExNNEwvM4q4YYoaLPswBoUtwzL/wB30v1
         H+90guH680hC8amIUn9IDPjKqErWt0ph0S+QgzJFdP62Ckr5FczbsGIiLLZlv3+ibWzH
         c5hApHdrUAKBSYyHJ7+pgccA3ed6vErK/B9vzqIDlz3VAUf/8N0d/3POAPE7nn0Ba0c8
         Q2obcB1nSl+JbsKvvn8/agK/WBT0qM+ch1Lkqr4DjI4AxGWgsBXRz7VJ4nMrblo3gaMu
         LhVg==
X-Forwarded-Encrypted: i=1; AJvYcCXAF8jIwCvqCsh4vkV/3iHe9xf0imp7mv5Uh4DE9buCrsJcl1m9muhipqXX+t0/HFmVMUFkW6Jr@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz4r+vsHzwOri6D/O+UlzQLx1QxB9QzXCPw00JqdBhYSPk94m8D
	roHPzM5dJbdpego2nL1mtVtj3AqCmnWKJtcWpUg5D7Rt3N+1YSXhlvHHnt03l+g=
X-Gm-Gg: ASbGncueNgv5kqaQxJ9YZQLstPfxCYNtgf2/FWw5xeET/aKd6V5yAhwf4n4jIKdPOC8
	i+agxNiGEx5SI1XkFH/xgGrBWZjvERH+lBeZpBsnyI0vQ3Sgzx8iq6CAaSazYgytmiBhSQ0LsAP
	NeFaS47Pbp5qkDsI7Fn779Ffi3ItdfzggYZbuF+pXxeSdOIJZGRdbmfpcXZ2I1Wkhsm+Old73/p
	dIrYy6DGxj4GFIwqp4ylhZL3EwJyN4JwEDPMpod3uQEYKJ8OAck0uizIuWti7szq5TjLO4lQx/u
	3HaPGv5qfYoev5xqkCZBMxVJV/Ht/HhQ2hfwZGbiPZcFVpbLxHS2HbW2L5Brg9OryaqFsJ4=
X-Google-Smtp-Source: AGHT+IGkZvOpXus1nGLKuztNdy4t+STr3oWnNXl1VICpgnk7l9deOWKNcdztRWJqS6+ByGrF1mh0IQ==
X-Received: by 2002:a17:907:9722:b0:abf:73ba:fd60 with SMTP id a640c23a62f3a-acec69ae910mr287822066b.29.1745934483937;
        Tue, 29 Apr 2025 06:48:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 20/21] arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
Date: Tue, 29 Apr 2025 16:47:26 +0300
Message-ID: <20250429134727.2429662-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18733

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 268a99583372a0a2ae93d0969db0bf3f95d74049 upstream.

Enable I2C0 node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240820101918.2384635-11-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index deb2ad37bb2e..7945d44e6ee1 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -11,6 +11,7 @@
 
 / {
 	aliases {
+		i2c0 = &i2c0;
 		serial0 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -66,6 +67,12 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+
+	clock-frequency = <1000000>;
+};
+
 &pinctrl {
 	key-1-gpio-hog {
 		gpio-hog;
-- 
2.43.0


