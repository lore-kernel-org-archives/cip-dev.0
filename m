Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C71061202
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:51 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18323.1773227148927224127
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DQZjWOzx;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso9738905e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227147; x=1773831947; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiqgzD3x+gd4OTGMaKlmq2xRdgG727ojYIbUVSpFnqs=;
        b=DQZjWOzxiKtKasMY8ar0r9JOzge/W9PjyaLg23t9798X+YeAu6xvZQGww5FPfo8XA+
         Bbbuh5aGtMnwxnq6sUrWgK8cnCAgSc3XKbaP5xQysnZYrcHIKfXRGaL3F2BDkkBWVQbU
         +yvKcFSrnhkfLFYFKsjc9jcv5ThWN7Y49rZV/GN9/z1bRTUrnUP0DR0HslUXNdLCNWQx
         8zqMPLXKXfFBHt/jAyInv/3JPuhio6oD/JTerX9acHLqauS0BLqOtbDbVPqATtOrilGg
         pZgD8IuRhbe/QY2V7D5lDfduMcwCYhwA9Jw2bOXfwhEG16G3YFmlHRkHU60pnzYu/8SG
         yZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227147; x=1773831947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MiqgzD3x+gd4OTGMaKlmq2xRdgG727ojYIbUVSpFnqs=;
        b=ncXGOCmMF8HoMk0unMAumrkKHUD52x8Xgk3bJll5ULQ2cbWRU2vTE6WHfFHyrbGe0K
         j4V8eFdNWCKcWCxrMjax7a1yq1qNfajko38T6N+oeDpaSQEF+A4gHUvTZ6eT+5RylxXM
         4wFfNXaQaebbWlRozBa+Kt3ZM76gWiNYY4IGflEKNYcsakEGr2Zuyue5SEWP0civjCy0
         NlbvyYZpL/sPjvlMvfSnJ3u8xQrKMNhhepQG1RPGNaTLZWoGRKBeimev/OC96v+dbRkO
         t++3NJf+ar8nXVWyPehsjRK1o30Z3+iBvRGxja36HlYNoEbsElaC6AVSomG42DS3VBBG
         zOvA==
X-Gm-Message-State: AOJu0Yz3RjKzHFUZM8bGwm8CLEW01UfRsSUsTY5NDgljhU0md7FE5vhs
	w+cU1TCedtjfyjgAUMrv+RpNl6ffyojqsDaeFQB8z6brXBlzpBkCC54wBnrvo7hsbWM=
X-Gm-Gg: ATEYQzyDABX59ygjNdflah2W3vvhcBu/btKw/p3CBux356rQNeXc0iaXcnvLyXyweja
	MTDXXnYkxZhaVVgXJAXA/f6Cf57yf3gPVoIIBA1dqeRMf2PCrrb1HudyhwffCOYgpKAwUZEpX47
	nMmpIoAyfXMVLsfReEZNKnb+gxQ9otMGAcMnurSrHzlEILHyoY2w+mqkrH2PPAIWuCO1KvnhV8s
	Vpd9vkRzK2/wECCZg9VM/1LisV2GZ+TIW0gm6i3OGFKks+uCtcPw5vi7lw6FILilblDWscf2A/c
	e+E+6hV8VRZaQkzr5j02FAGzPIBdpvJck78lP9E/EHxyuno3d+3LGQI27GF6JgrP7D3OtuVxXOS
	x3trboGI5aqxIDNE7hp/76j9fxIzleVvYtJxe+Q5y+p8GfpBIaoD2lT5IBN1YG/o7mf88dWfMJ/
	Ed2LOX0Z75BSfSHPnaOZpzNWK767SbFE/AgefRpWZans0RrkIuzG1o7ZEanvL7xto=
X-Received: by 2002:a05:600c:1c16:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-4854b288424mr30364225e9.12.1773227147251;
        Wed, 11 Mar 2026 04:05:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 16/17] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
Date: Wed, 11 Mar 2026 13:05:19 +0200
Message-ID: <20260311110520.1938414-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22324

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 73b73af99a49fd7bf0515741734660973fa2002a upstream.

The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
support.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by dropping I2C1 and USB nodes as these
 are not present in v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index c8800c41b4e7..203656961bdf 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -123,6 +123,12 @@ da7212: codec@1a {
 	};
 };
 
+&pcie {
+	pinctrl-0 = <&pcie_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pinctrl {
 	audio_clock_pins: audio-clock {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
@@ -150,6 +156,11 @@ key-3-gpio-hog {
 		line-name = "key-3-gpio-irq";
 	};
 
+	pcie_pins: pcie {
+		pinmux = <RZG2L_PORT_PINMUX(13, 2, 2)>, /* PCIE_RST_OUT_B */
+			 <RZG2L_PORT_PINMUX(13, 3, 2)>; /* PCIE_CLKREQ_B */
+	};
+
 	scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
-- 
2.43.0


