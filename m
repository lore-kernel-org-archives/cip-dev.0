Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA28DC071FD
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:20 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.18456.1713526759957591674
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hEd0rggf;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.175, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso18418851fa.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526758; x=1714131558; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM57XABqcaGBvMQDlpnMqamhEeQOnzT40167cggAPio=;
        b=hEd0rggf8qZijWRd0RO5B+l9QhTCaADbOKuw+8d/8NkAmQPSyzOaOXyaXiOKVSlhKn
         42FcT1rVARSOEg69ImasdN+S6VCisSdFyQTeb+tjsle7RuN3kMlj8roEgCuYFaQAh++s
         n+4kewjquakCeVZ/j0SeLWuFVRnGFp04kfbd+fSFrjBruf1WzKv/6BwdHpm20nBEt4AN
         OJ5CavkmkrNFEv/k0rwiX6cI7mHfPhpvmRXXi3017xN3Fljo27KWnGU7WQp4P52zBwhU
         NgTogZrgCl8EMu5///rMSSFbpvS9XPAgu7Npz8g2LKs/P2wVdB57ED9yk4i03q2O9kzF
         Ou5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526758; x=1714131558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM57XABqcaGBvMQDlpnMqamhEeQOnzT40167cggAPio=;
        b=s+denw6RUuMQ/w6X6BPUEnWUd/Hb/BOXX6+F0+YTzXElxA3ppAah1/5/zOertDtIqz
         fOM7xhR544cp/e/9qaqeKHysX4P+Hmr0I4vL99E3LdfJex5vN0R2Xspi1xLS00W+Kl4i
         rwnN8tDF3KphEMon6pEgTAbE/RwZKjk1v5iRtHFjoHq8zV65PXlLZxAF8+UsOKphjsCT
         1zxDiTRwjRCzUT/eXj4577X08mzfgW1pwW8Evc6rAxL1b/eZx3fYaIrKUBnHhym/MEd7
         dAT7hV1QKC0JnNEQaQCKZ08xhy8JUBcYck4sGvLHoyn1OKKUksk9RDao7u54JPrNJzrR
         UgqQ==
X-Gm-Message-State: AOJu0Ywmq7ZrIcEDGiHloKd8p2KGbGsM1J75/mXgQ3yW0m+qbmg8UBoK
	KSPaqNb3sy6J1aXdA4AVKNTIsHW89dGndKomYjEmL11By6JPZjV5uvgvxUJg3YU=
X-Google-Smtp-Source: AGHT+IG6bSVQ8pUQKwQAp3ur4Uqs4z5BPw3nMqWxpIxU1548UQUVGJVpWc/SMixFlk2rBNi7gzRzAQ==
X-Received: by 2002:a2e:8692:0:b0:2d8:785c:cdb0 with SMTP id l18-20020a2e8692000000b002d8785ccdb0mr1148911lji.8.1713526758171;
        Fri, 19 Apr 2024 04:39:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 23/44] pinctrl: renesas: rzg2l: Add validation of GPIO pin in rzg2l_gpio_request()
Date: Fri, 19 Apr 2024 14:38:21 +0300
Message-Id: <20240419113842.3675543-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15674

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c944d9dea75e453d18bc8c100022e990c2eac3cb upstream.

Validate the GPIO pin request in the rzg2l_gpio_request() callback using
the rzg2l_validate_gpio_pin() function.  This stops any accidental usage
of GPIO pins which are not supported by the SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20230925154548.27048-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index cf11b8e08842..45a39e04ec49 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -794,12 +794,18 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
 static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
+	u32 *pin_data = pin_desc->drv_data;
 	unsigned long flags;
 	u8 reg8;
 	int ret;
 
+	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
+	if (ret)
+		return ret;
+
 	ret = pinctrl_gpio_request(chip->base + offset);
 	if (ret)
 		return ret;
-- 
2.39.2


