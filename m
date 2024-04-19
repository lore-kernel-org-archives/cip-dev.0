Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AEFC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:19:08 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.15295.1713514741380234874
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:19:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YwHQ/qm7;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571d6d1943fso211824a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514740; x=1714119540; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA8u4MVHkNzXVIrqfjKWy0CIgT/wq4HGtLUGMza3xqw=;
        b=YwHQ/qm72OI2hNZsWjXvduNBFdDBtdnl4ID5b9meVBt8JMaQSn1+yyyI4BWY2zC1DP
         L61headgVlzmp0b5tu96ZUAfc+DfxrObWsigPqSjkJOmSDsoS+RyLyeILAt/EN7SpmUJ
         FQ9s0XP+xtnAxCDxi+Qx+XX3gfPUuXBDhw82rnG1RJ8za0xunQqeApV9xZjTfJ2wx3oQ
         MNgWdfwHB42+lk6CiRiAVwb6ICEn1AW3a2FXc60dk0mmPiuRAUQyt+tM2cf0Q6w7NisT
         BH9QgORedy4CP+fh1fW00Z1szl87p2vSmWWSQ24uTP3I3H3bRUKeJ2MgKCs6kB48x4x+
         ZqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514740; x=1714119540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA8u4MVHkNzXVIrqfjKWy0CIgT/wq4HGtLUGMza3xqw=;
        b=ASzNlwOH1UKL6IvlCbN9bFbudwDjxZp/kuEyiAWYjVoFYAiSEd+j/7L5kxt8tNCw4x
         alVpGPLz+sAwyMOJo3Dh3T/wPIrknHPCYm3KvbPVet+MwBHEAVyK5cqZZ2sITH8HZEbK
         OsfnK0K6kdsZJHpwNhRMRCvXmyg8AZCr4j/6cd0ccWDrvGTB87YP5BltXHmYQXAOH7ZE
         bjfRZGoYIi/ic2H7DLl11QZQDS9RoW/2xfdjzwfUvYi8H5E0o7Mpn0IZfBaKIjxyHjQu
         D/Gnq5vhvaYUCe4hjn9p18CIh0WboZumem0AWQsghVNr9Rqy7jiCbhDFPL2v/UhIAqUP
         r+5w==
X-Gm-Message-State: AOJu0YwI2AgcamxHpf87hkttp0HERFda/S/kvQa8aBbyBoLlBjUWbBR4
	szOCEKprVFp3iApZO4hGICW1Do7bSK5v+X2VtVGzOHHai1uTU4qjOj6TRgmw+sQ=
X-Google-Smtp-Source: AGHT+IGrAihfRWtEHwPwXMsWEMni6VCO7GglM79lQjK5ZFLSLREzCmkUV8AzGKxADHq3Xh2n9cD+2A==
X-Received: by 2002:a17:906:1c5a:b0:a52:3d07:de62 with SMTP id l26-20020a1709061c5a00b00a523d07de62mr974491ejg.58.1713514739826;
        Fri, 19 Apr 2024 01:18:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 50/53] arm64: dts: renesas: rzg3s-smarc-som: Spelling s/device-type/device_type/
Date: Fri, 19 Apr 2024 11:17:39 +0300
Message-Id: <20240419081742.3496709-51-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15637

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit aca0f89bad145c4f1c4d4d60a957de1e4f4522a4 upstream.

Fix the following DTBS check warnings:

    arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dt: /: memory@48000000: 'device-type' does not match any of the regexes: 'pinctrl-[0-9]+'
	    from schema $id: http://devicetree.org/schemas/memory.yaml#
    arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: /: memory@48000000: 'device_type' is a required property
	    from schema $id: http://devicetree.org/schemas/memory.yaml#

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231010132701.1658737-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 185ca8289a35..a199de8f8b02 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -29,7 +29,7 @@ chosen {
 	};
 
 	memory@48000000 {
-		device-type = "memory";
+		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
-- 
2.39.2


