Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5C3D6AAEA
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 16:09:17 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32.1775146155916380482
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Apr 2026 09:09:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lieD3gvQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso951630f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2026 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775146154; x=1775750954; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4L937lJiYX0ahsMrZzRqCDsHuS7oJAX3oCQ8XZ/KsM=;
        b=lieD3gvQNyZbHl+cCtbI+6Qn/onCrF6nHlpejD7fAPDifXZ66Xw+9mT+bDMg8LRhBO
         M4IhkSrShblo84vyMu2u5Osai8nOuDssnmBN20b8HoPyYgoblmY4cvsdmrI6UTS3P405
         TD24/1HJaqJlabP2Guc6iV67QumkEGAWBsxERW+CvbEmZru4anNMGbDZtTLuZqoWO84A
         tFep364MEEkFb/UO0UITnrjUAYOqlUshjETlXfOAB7CdtBLgMVsRekUL/uy5qKekuizD
         1AdwtJO14aQtyJHQKKhn56xk2do81OKadV0GoiE5J6F9+SnIFAQOuyIZ7vfll/xPL98h
         6Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146154; x=1775750954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4L937lJiYX0ahsMrZzRqCDsHuS7oJAX3oCQ8XZ/KsM=;
        b=dDDAwVBZ+siDHeWYXTb9uYnTR752gs+ujO7joie2vwetthzjfZ3YZVr/yuEiXstUAo
         yr6ojsu4Xb5PUBijys3VWtZGwK2TYrkoTttXJs24YoHFkI2MPJ3mSGM8fwS6XE0k0daa
         vbMpTRNb4SBOoMV7QLnBlMxBCETQJksFkRkAL/gK8LopwJLHrvEXxNEzoSE2jaZ07BaT
         hW1gYrXVR8qqgpA3Xp+99u1lKUfvMG6sJAw3zVvOnRRD9mfv7KX8nxoWXNKLMSuoCg/M
         hV6l3Y1MVQ4qsWvehDY24zOquRQAIUPifAJ1AkpCPJ3MIFQPXegv9jJxpD0Ou+Y7UfZP
         Bmgw==
X-Gm-Message-State: AOJu0YygcDpp8JdLiSijHfg+xIxKtz0FDCifbiY3xV1euxUwjb7klUCm
	Z9+/Vrdd1vLx0/Yl/lV9PtxxeVqkLPyIFXxKhvFyXQJ+4w1piSx/Bs6xA1CNlQy6omg=
X-Gm-Gg: AeBDiev7JRvqM1WYxKuN5jxYs6yK1uS1Bn8hkcj4QS8BNdRnaAJG9TLyVprn9n4smv/
	oWQbzUrxnoSqvWXBlQbSFGiI73T84fchnVuR6A05S1+iju44tOk0MgJ2/TNAGgGYImwC3XFI/Vm
	4sE2PVKLIAQjDTR6uD1H23JEadHctDg+ZY7YAJRagrSsiwJiGSaUkUsPjJaJ1Ke8G1DX12b5X4K
	I7hW2dDC9Oa5HkgIYrxlL7A8/P6I5XYfstxqLFBUfj7JI8PTGzdM4fY44aH60YnnG/GdNjoHTAG
	XAUUbOSSB1iVpNn31Da4cHxJZfsV6Q5p9vDMC59tT7HFKV3HdF4Cz1IkBl7HfPQRUgoAd3ckYNM
	koHiiVpGKab8yCDv89SP0VZgkHJl5O9mEhtv0cyqJcXAHmlxvIsyFvat/olH5faIJDXaCT3buo3
	QX+XRgRPR1MruC/ntOlsWRVcq1ZAd+i07VTx7bgkIebd0wSxdnFyp6
X-Received: by 2002:adf:ec0e:0:b0:43d:259f:d3b9 with SMTP id ffacd0b85a97d-43d259fd403mr2011250f8f.5.1775146153962;
        Thu, 02 Apr 2026 09:09:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm8535881f8f.37.2026.04.02.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:09:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 1/1] arm64: dts: renesas: rzg3s-smarc-som: Set bypass for Versa3 PLL2
Date: Thu,  2 Apr 2026 19:09:12 +0300
Message-ID: <20260402160912.2002334-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2026 16:09:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22616

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6dcbb6f070cccabc6a13d640a5a84de581fdd761 upstream.

The default settings for the Versa3 device on the Renesas RZ/G3S SMARC
SoM board have PLL2 disabled. PLL2 was later enabled together with audio
support, as it is required to support both 44.1 kHz and 48 kHz audio.

With PLL2 enabled, it was observed that Linux occasionally either hangs
during boot (the last log message being related to the I2C probe) or
randomly crashes. This was mainly reproducible on cold boots. During
debugging, it was also noticed that the Unicode replacement character (�)
sometimes appears on the serial console. Further investigation traced this
to the configuration applied through the Versa3 register at offset 0x1c,
which controls PLL enablement.

The appearance of the Unicode replacement character suggested an issue
with the SoC reference clock. The RZ/G3S reference clock is provided by
the Versa3 clock generator (REF output).

After checking with the Renesas Versa3 hardware team, it was found that
this is related to the PLL2 lock bit being set through the
renesas,settings DT property.

The PLL lock bit must be set to avoid unstable clock output from the PLL.
However, due to the Versa3 hardware design, when a PLL lock bit is set,
all outputs (including the REF clock) are temporarily disabled until the
configured PLLs become stable.

As an alternative, the bypass bit can be used. This does not interrupt the
PLL2 output or any other Versa3 outputs, but it may result in temporary
instability on PLL2 output while the configuration is applied. Since PLL2
feeds only the audio path and audio is not used during early boot, this is
acceptable and does not affect system boot.

Drop the PLL2 lock bit and set the bypass bit instead.

This has been tested with more than 1000 cold boots.

Fixes: a94253232b04 ("arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260302135703.162601-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index b11f2e49748b..990adea09799 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -164,7 +164,7 @@ versa3: clock-generator@68 {
 				       <100000000>;
 		renesas,settings = [
 		  80 00 11 19 4c 42 dc 2f 06 7d 20 1a 5f 1e f2 27
-		  00 40 00 00 00 00 00 00 06 0c 19 02 3f f0 90 86
+		  00 40 00 00 00 00 00 00 06 0c 19 02 3b f0 90 86
 		  a0 80 30 30 9c
 		];
 	};
-- 
2.43.0


