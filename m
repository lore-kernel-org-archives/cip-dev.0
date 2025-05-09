Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956EC3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:35 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.10370.1746783332357646241
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=G28vzI8k;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so221063966b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783331; x=1747388131; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Yn7J1P8pwoviXk58a92JoNdDWKOu1lLI8d9GERQQf8=;
        b=G28vzI8khb0cpZURLkQHaLDURgz+zO8HrV98r4tbSujHe6pnenpokFRymoy0sg7sR6
         YUwV6iKMCp/9HlsyP1klzgyay7Uk4YaytwvOqWact0qDQmTaqFQ4la/zj4yRtRCUoM10
         i1mIhUMOkEwd8RVPuMXsiIfms4nP45jhO9gCFV6N6WCZE605fYVp4WRUm1I5EBEjF0Qt
         Pj4WQohxxVlmbjJIqAJiTSlgNqQUfTzuEB65m4F+M9nP58gmleusrRrJNxojLHNezLS4
         N4aDBKnwebY0iO42qjxjEgcjHESNSCc6lIq1d/B1xPjRvWbcrigERbBHABGz+utt53Fv
         NkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783331; x=1747388131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Yn7J1P8pwoviXk58a92JoNdDWKOu1lLI8d9GERQQf8=;
        b=ESMb8n5d9ZK1GCHgDl6K3QxZBv+29eFk/irAstxDKwr9QQmYmxYGU198bdqFiTfCfn
         yQbDooLgO/xdOVzvmnzxECwA9fHEl/X2514F3AN+wS4hv8ssEcIZhj9seCjKO6cw3I8F
         IlVPcc53i/jbbplsGAZZj5YrWa2Nd5UVc99Jnv4eMU1BHn8e7sqjnZ0f3MqUlTxARr8a
         ZmsU239ouzOvfMIP+Q3OTtzL+W9pk2NB6kVRiM1hKKqLPagVZugX1gvuTD0jKlw02W7T
         9Yg8F+mA7bsDjii3thOMos3cMIQJadRZVmdEEWZn7yoRvXiLKC33pHiYBwWd/yh0EWAs
         PiCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYfm415wMtff1Nzt4qwrgn19LklbcxnyUbZBryEEUHctDdUXOidWAQt5kKVk20XeS9MaudzF18@lists.cip-project.org
X-Gm-Message-State: AOJu0YyHNb72VvzvTnyr0cTiCfZRhgLBg536hp70lnuN3M9gVnsGp0Q6
	rPnsRiMblqju9ybL2JJdFWrHu2T/N5Oh92NfWV9DCXH5varpVpJjLnG3nOu6P3E=
X-Gm-Gg: ASbGncuC/HmZCbSs0bXUjB42kichfs1tQDqy1r/N20prRoJoYKAGD6MNVRLXSg2gy4D
	zq2Qn5qQhn2guiQkJIwXdJfKJTt4G3pnoQpxJ15s3w6JKg2+BwNp49ISvf48uMm1N6EqyyG96fc
	dNtEi1tWN/+yPPhJwrM2qg3NgzMh7tLgWyeDXxmWgD+Ych5KmTDxjpmok3AA97wLDiZR2XWcIrp
	yyPtDLhUGtnQ0ekrQL0x5GCy9IxmxQ3lun0I9MBN/+s1SAf8ULKG6NqnlyteordyK24ZpbnBAAE
	X6Wxlt1KrQvGPCQqaRwBkx7tYWMMzH++ynV9WwtpJfrFeo8aNc/+zxKEz927z/xWiZdJuw==
X-Google-Smtp-Source: AGHT+IGip9TnRQ0E1NSOptcmNAvVGLKZ0azMhgik0Tyn0N9d8XxofOLOcbzciSHvCk2RDobc4DcXCw==
X-Received: by 2002:a17:907:da0:b0:ace:c2ab:a720 with SMTP id a640c23a62f3a-ad218f2d373mr249430866b.6.1746783330691;
        Fri, 09 May 2025 02:35:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 32/37] pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
Date: Fri,  9 May 2025 12:34:37 +0300
Message-ID: <20250509093442.4015145-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18884

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 03fc60cd8e7b7e6f330d0a48c54545740addd9d8 upstream.

Add audio clock pins on the RZ/G3S SoC.  These are used by audio IPs as
input pins to feed them with audio clocks.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241113133540.2005850-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4e95cf53d0cd..7e6ff6617c93 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1803,6 +1803,8 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
 	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IEN |
 						      PIN_CFG_SOFT_PS)) },
 	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)) },
+	{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x2, 0, PIN_CFG_IEN) },
+	{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x2, 1, PIN_CFG_IEN) },
 	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS) },
 	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
 	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
-- 
2.43.0


