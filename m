Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF267D6AAEB
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 16:09:47 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31.1775146180636943352
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Apr 2026 09:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lOjznt5S;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d02a71526so691756f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2026 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775146179; x=1775750979; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4L937lJiYX0ahsMrZzRqCDsHuS7oJAX3oCQ8XZ/KsM=;
        b=lOjznt5S0ILl4FLKRhJQ6NU7zZ6ZcjLSikPjbvJnZ2eDM76BTZDp2oIC70GI6ThOU4
         HQhydfeIQIQloUEISuHs30/ttCQEcmwq8HdtUmgOSPUN2D5/eoLLOgot/dZNgG/MHPNa
         V87Wo/v7oA87LtL2UCo6qPH2jlEBw3L82G8QAkNJvhYIaP2BBWT//ovGNUgz1rPI0PO6
         +aNBfv4WSdWXu1dyxTGWX0vKyH/EoJzW+/mXQU8GrU1wxyUFrdPcEyIbQj4RowMbF4bE
         L6iigsMRb+PqP9ob6TF44frJd1sMHfz1PAdpwSYaK6PxkSVAlCcCofNIYXnMUQFHRYCb
         JMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146179; x=1775750979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4L937lJiYX0ahsMrZzRqCDsHuS7oJAX3oCQ8XZ/KsM=;
        b=HEPbjdpTNJjB5PA081+I+EJPXWa6Mm063TtEKKc9qgATxM9wkIElJHJNstlLCCqeRP
         +fZdi+CGMKvL6HZUpZqPLsZqVXnQnBL25tF8hYKtfgAVhSvjb9zHdu30JTgTlshzWpKG
         9MMWzNHkMlHqKNW43OTQfEFAnb0o37up+dlHQbFSTB2VjbYLFhYKJuc8VN3wZAay4hGg
         0spue23kLizbGEl2kRCGTQyw/FMPfgiVuJz6s5iEUgLiFJuCSJE7JOuvYbPCuvt2MjQM
         eJMGbTjkUohjyaklZrSnLqirzgslmEMptOGHholiJf4SG5mK0ZovWNgFRKd+N82E6UTi
         uftg==
X-Gm-Message-State: AOJu0YxK3r1cXguxtuOYlc7KeXyTM+WLntGa7tApBH0rVguxrA+V2vED
	YYhYoQ6ZFVZH+LK9WT/wEv8O/zo5Q3uPKI0cNvXunVQRab5ywAbPnsUG6RdjpL7ip0E=
X-Gm-Gg: AeBDies8cH4V9/Ja3a4Iyx5W5U9haVu+rK+Dkkl4TS1HIUu5zc8lwGS0RZ2KrUsh6CR
	uTRVI0xM8xTkEJU7gsdR1AO+G7jrZr+Oj4AlautmfaM5hIYJkJZvlJbG6Ky2stG2GjAklu5kutu
	279rIiKt12PEI/xOEnMBT8jBMf/kQecJbdyCc8WLBDCpSCfQbwF8k3U2yXgJKDCad1mnJohrmd6
	vGE4pVYm4QOKrs3sG4SjNxOfQjynlKX9AenkRQZDsg4rQkzrTDn+lozcxvpRiGiKNepQEX+RvSZ
	slw+3QrcPoaIhFULkju25m1VhOJfi/EBDpcYIn2J2Kdaxjmqbsa6+u8q387NxbGmvupnHveFqGV
	zNjM4emVduko6ql9eX7Z2aVb+OpHaCBxM7X6RL/hDFlARN3nG4fur2bFD2HlqlEz+dKpY6Ym7+Z
	TnU30fXvzfYzj6srDyiHecw8bwLSOp+hyGKvAvsIXfL5DdoydhWulE
X-Received: by 2002:a05:6000:1ac6:b0:43c:f719:a7f0 with SMTP id ffacd0b85a97d-43d15066951mr15110658f8f.12.1775146178741;
        Thu, 02 Apr 2026 09:09:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f52easm9438965f8f.36.2026.04.02.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:09:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 1/1] arm64: dts: renesas: rzg3s-smarc-som: Set bypass for Versa3 PLL2
Date: Thu,  2 Apr 2026 19:09:37 +0300
Message-ID: <20260402160937.2002534-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2026 16:09:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22617

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


