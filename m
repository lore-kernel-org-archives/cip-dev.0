Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E3C071FD
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:51 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.18456.1713526787487397908
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Em1oC1mm;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571d6d1943fso479311a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526786; x=1714131586; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA8u4MVHkNzXVIrqfjKWy0CIgT/wq4HGtLUGMza3xqw=;
        b=Em1oC1mmt8BwqI+uh1O/ahFr14XBGjeZBX42H9bvDDAviGkCP/ADHfHtIZupMSG3Xq
         uKgWmxxg6io7Dc6Y1zE0z9qeW3hO/Q7MIm5x8Pvp1+uleQWW2fIMk6VGfNzNiGFjY02y
         bTXkku48Jfg3MBmXUOGjse1gUx8p6/qs6lxQXnunuZglIsfrVkXeCW7inwjYGHhIDIb9
         tCT+yLJSQmMUj6m8kMT8kwmFAmNKFN+iyMdwb/QQ6cdMgSc7yViTUm8aOMgG0Ims3L2S
         MZFbwoWjXH/0SsIzZ0PcFnsIxUS4u9gra4r2gqUN/sdUJxtukKp3NL/B24kqv9r9KDFQ
         3WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526786; x=1714131586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA8u4MVHkNzXVIrqfjKWy0CIgT/wq4HGtLUGMza3xqw=;
        b=DQwQL/W1NAsFvY3JT5W2BysRmAMCiWBqZszYAuDM5UsBJ0P3Vdj5vg84xnIyZgxdtV
         02LZM2I+E54KhLXV//arL2lo2DZP38+STaWLSGSwhXBUf3hpJeWNMvNIL/cuQU0GcyKM
         9jygY6rEFhwC+Tg0/BFIb43CY2hv+eVubqvD1J+CCy6D8DKAS+t8+DEGMNtY/3pCUcM/
         9qaMPwueEg5GQgmPUWh3xa5HKGWVa9SZ8I62lwuR0Ok02X825nKW3YpcsH+yC5otNSP3
         aa4Kw382GUa7s8FxA84bZUgZ1TgyuFNyvMbwdCBzYjTQuzZ1cCnWeCbMVJoEh0O6ZvQG
         ciSw==
X-Gm-Message-State: AOJu0YxkXuwOsq4QeW/0PTq+zTZe3lm6lEiWvVQiVxeWV5fkJ9MhoG5z
	EwYysFhzH0byqWOle20VYnxt+XnPdPts32mbzvY6zDAAtxrcVlya+YfNEMX5REM=
X-Google-Smtp-Source: AGHT+IHM0YicAPlzqWgmp8YLG22ke9AdtgMDFdJa+E3LvhfMDbsoqPmVWifkQIwpKxQlvaJap1WlCg==
X-Received: by 2002:a50:d658:0:b0:56e:34db:f5ef with SMTP id c24-20020a50d658000000b0056e34dbf5efmr1241690edj.28.1713526785877;
        Fri, 19 Apr 2024 04:39:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 41/44] arm64: dts: renesas: rzg3s-smarc-som: Spelling s/device-type/device_type/
Date: Fri, 19 Apr 2024 14:38:39 +0300
Message-Id: <20240419113842.3675543-42-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15692

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


