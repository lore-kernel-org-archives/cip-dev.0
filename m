Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DBD6AAEC
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 16:09:57 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45.1775146196959125611
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Apr 2026 09:09:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=f0SU8nFy;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-482f454be5bso23571015e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2026 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775146195; x=1775750995; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NYEd37GNn2Njoe5c0oDOgdSagGmNusafbodQ8JDjUU=;
        b=f0SU8nFytS2rvp77CbTxVPdmeMczpbiZ+RuYdBf7EVRVwnWv4Z39FlOROkIiZ49uFW
         5y+AnSUqpi4UkgddWjcz1oDFrQkM5MrA1mVypIAik3bL3tHmiXKwIbtB/zY0wIeYKufg
         qwoJi3Wwjku0zRnS7anqt+5ot1Xyir0b2ukW4VCKQF+X+shGcSf8cTucB6B7BegUbjCy
         /yd7iw1Karg9VbnCCcSM/cuYgKTVA87SU2q36v5LYEiPnm+xA9XlXdx+09c0GFGj4lSE
         vXmavfcqgH6wgkaSz5xF0cVldUJz0qu/KwX6MuJHFr5ZldWAVj+86IW3rtZIdic/0zRl
         bjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146195; x=1775750995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NYEd37GNn2Njoe5c0oDOgdSagGmNusafbodQ8JDjUU=;
        b=Nf5vaJlIMPjoLxl+raGE/fJWWEA5yYqR2oYVVVLGPgA1rMRDkOQH75DlmPNYFxR6Zw
         KED0BFTYUR3mcfJg12ocw+z9W/hVDX0VaUdW5W7/SDE2dlOseZvZXwnPZa8afW214aDe
         tqWEqhWRgPjZ+uVaNbr7wl/v6zYUpFZU5z0/+JtFoTO7d31KriUpp7OGhj2N5ffgBWWt
         LVYQOjTh45b5hna3V0Nhstr8rnj6I0J01zNYnyWBgP6VHsUQj0jwlLiYF1hD5BM3/zVJ
         51pbPKCj8A9cVMGY5fdWaxWfPm/XmvLVb/NXzKLa5c4S9yGAewF2kiveL6pYZAYLHg/e
         W1RQ==
X-Gm-Message-State: AOJu0YxtFrjCSfrj81v1HU4if0wEF+2WRb7NqzuHm1Na/7sMdXm5rtMa
	RcHDBnLwkBhNanrW/ykfTuQqTQsn4s6I6B6ojpatZhEDUViq2sBaCGqcmM5w0AuLl4c=
X-Gm-Gg: ATEYQzz2Ra0BQl7ECuTD6FQ8EYGH59xTy4Iv0P6mXUOabkQh3Y8YJrfWyHTm8PsbQnd
	zxkzAOUUG9izkzwV0YcenR2JqsCGFCDcnYnbsiCOhGF9md7DLgnrMR4u2I+gn8vDfOfJBNlVR91
	mDU2y6uLT5TQJn3uer7DN/arLhDTYAWDGPCh5/H+MTHq+ZFejWe/JJHD4vScK7FR7khmTF4Yo6h
	pN6B9y0IUJ+JGczJJTrSpZiLpbaxASXkmwQO3ixIADbQsbMPhwFk3nExbw10OtAtg71VvVbE1O6
	caAEGNYvJSD3Tr9wH/1SJkWQH0FtUJ29562N56AdtDnekr4dVr4da6Ak62CKnuboAWPs22jKn09
	8hoKDEIn0CeKAc9c9a8sHkPzdojeO6+5XKva/ZiwgywoaHw0PgzKNdH1vJwzQ+575ovFfsYtbKd
	rpD9E/SnCwVcQEEXoC/A3gDBsaDqtkjgopDYjZwJ7wClY1LfoV6TNC
X-Received: by 2002:a05:600c:8483:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-4888e0cf3a0mr50336055e9.14.1775146195170;
        Thu, 02 Apr 2026 09:09:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm248400755e9.0.2026.04.02.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:09:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 1/1] arm64: dts: renesas: rzg3s-smarc-som: Set bypass for Versa3 PLL2
Date: Thu,  2 Apr 2026 19:09:53 +0300
Message-ID: <20260402160953.2002671-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Apr 2026 16:09:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22618

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
index 982f17aafbc5..b45acfe6288a 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -162,7 +162,7 @@ versa3: clock-generator@68 {
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


