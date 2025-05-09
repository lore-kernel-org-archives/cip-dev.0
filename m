Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6290C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:14 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.10394.1746783250669634157
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jWWtqPEk;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fbdf6973e7so2411859a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783249; x=1747388049; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCQ25g4vQ6Z6BOwfBM4ssj1hE4tla9RWIcCKCcyPFeE=;
        b=jWWtqPEk0tjmNm7xH+egLTbQbMCPxNkXKoO+KLhTP3YO/aYCV8lvKv/lUufnmmiVM5
         QRCMaQYOPm17hx2f/EwoEezNc+oDuJFXEBfX437XCjhI/BN3kQgOTkfJXZQHv1oDPea7
         yNsOzL09TI4KIhtrBwy0/HZcRzS7Y4+cB0Stnu9b47E5gkLY8QZK5aaGCcbdtihw3fiZ
         z01SSOhPBXj82fgWs27PiFJGrh3NfHg31FPidrxq4FAXOAKBC36KSqD6I/rK45ox/mgf
         mNnWxCgzLrn4AVImd55ZkQ4XJyPOgM04ZQ1Mu2KNYgUklsT3WjF04rxulgz2LfCRp+rv
         UGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783249; x=1747388049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCQ25g4vQ6Z6BOwfBM4ssj1hE4tla9RWIcCKCcyPFeE=;
        b=nCe0qwcpyj3qJzJQxiSiI8aRkPbtIvfg6P1Eu4rUBGoeJHp4p8s7xJJLlxNN1rgHVG
         xFPe+yuTUyY1DXBlLDzI3d2YCqZcPsRtJ7jGFSofVOSKAgpehLdmkrWMu6pD7X9aMKGz
         gw3ovSnfdu4bbACAqqg36ee39DgKHFJ2piB17MJO3Tw1JsoA2FIkH5r1nAkhhHZnNEiN
         DWUsU5o2O6X7iY7brPlfJN7Ig3IMyVrdjlQwwvx7a/VB63nXMrp0PLAKz0TsCeUxpZU+
         3TyHJkJrFZWDbRNJIWz99JRnqyDRZYL2AWFNYjSZ837ibQh9SsMpey5OxHQMqtEl8Bij
         sivA==
X-Forwarded-Encrypted: i=1; AJvYcCUXWq964R4R7eCZqPW4Y3r3J7mUp1QWj4uwCjLWKPwWfczWEyPCO/9bNVAFHGDMSgBAqQabz+P7@lists.cip-project.org
X-Gm-Message-State: AOJu0YxYpn6U5Txsi943F+sfkhh4v65IzXeCC0+aqPV6JP1g8COKrrcX
	/At1Qd2eo8uMWZk9Ta86yKttn3KVf7aZCeBzb/6rsPLeDeGqXz6Rt4gRV4aKURBUUmutTYap1ok
	r
X-Gm-Gg: ASbGncutiueU2iMfLTkz0AwqXe4BJ/J+Xm22npaFSrH+DmC+hc/T1Ch6sdBHAyUiMzd
	ExUZ3cZisOr6Gtz3XIUktLKD7UNPWpcLeeNRUFXjRWrmwdg86bfDlWPi5zPaQkZc0oPeVIrxrOp
	IdKKkB1+5hsMd4LnucJ8a6ubJ3iSdhVuRPa4CIAoN53qHcgTorZCF9vEXGasoBzsZ0XMXT4secu
	XrzAce/ElKnwshYGhPYbxYGCiKstz5CRiK5q51m3quU0oQvXutz8biOvMo7u9HA0eDUPvaSV2ur
	v5ym4vWm7lkun3v3sYDg0eUbEWWA+Ya6C+Zw2l3Whzl7vSZ9jPVgunWuSKkCEQI7cEgRbw==
X-Google-Smtp-Source: AGHT+IGbbu8qR+ARAWsdH6GsE3AVf/scm0Fjm7+yCirKI0DAntp1w1M1F4IFFcupj+j3O+2Z3gOxog==
X-Received: by 2002:a05:6402:35ca:b0:5fb:455f:ac25 with SMTP id 4fb4d7f45d1cf-5fca0730764mr2241149a12.7.1746783249037;
        Fri, 09 May 2025 02:34:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 34/34] arm64: dts: renesas: rzg3s-smarc: Add sound card
Date: Fri,  9 May 2025 12:33:18 +0300
Message-ID: <20250509093318.4014916-35-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18851

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 24bfc042ba3dc3692e206ff060eb22733b6d3ac0 upstream.

Add sound card with SSI3 as CPU DAI and DA7212 as codec DAI.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-25-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 12cd3772148b..244f77925239 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -47,6 +47,23 @@ key-3 {
 		};
 	};
 
+	snd_rzg3s: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&cpu_dai>;
+		simple-audio-card,frame-master = <&cpu_dai>;
+		simple-audio-card,mclk-fs = <256>;
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&ssi3>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&da7212>;
+			clocks = <&versa3 1>;
+		};
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI1 Vcc";
-- 
2.43.0


