Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC38D6D237
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:25 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44876.1766071943056625932
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DutA2sZv;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so7155575e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071941; x=1766676741; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEf8BhaEqIkoXFhuH4yOrS21hTk8juRb5eJGyncmfew=;
        b=DutA2sZvbyD1C+mhHTu8knzDw1HwXe6gPzMY1S0dBofuVOG503bE4oWDLtp4G6xFpU
         NNJXyZvISZgVikVBXb+yMgieinkl3EECXWCnDn1tI5bL0ZzpHDGNAaLquBvpJOH+W6gC
         eOCK2LfMCBocmDOzWvSQXtwDl1NWwHl3boG+grloKR0IuuvA/OQrbj6ex364/SQ1S7D2
         kesMNeuSEsVeMKlTzN0t7KcSQkuytCKElfcTG0q7ZAzNiD1BCqULKN0v5q0ser1Zhy9M
         IliSnsE6P9HS68vH9fFpoMR4CMXWbQT2o/VdoUTno6KGE4h5zh4EsNAj4vuw2M39UAQD
         wi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071941; x=1766676741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEf8BhaEqIkoXFhuH4yOrS21hTk8juRb5eJGyncmfew=;
        b=ZMb+0AgU1317kyUn3EJ6y/IQcLvp8ZlKgFghmtHejI2+7m5nY5HbUfRjBC8nEjCkCr
         AFMkfzskCzHRg9GWsjwMHUHF0kXwkPeuZzGGW2tYRN+Lg6Knr01oopioAe6FA1/UnVmt
         yMdxHMFhH9NnPvJfIArtB86XD0SNtnKQGu/s4kcJwuMkU0LYbyKVIkGGJv8k4Yk1AApV
         HRiI5SkRV3g4bg/pdDbB/FNZuuMKbJlNkCSAGDf9hPmvNrF6DGaU1jAa1y7wSN1/DrYB
         dNZZ5RAYBDDse4vlAUgwT/qsHMjedspVBw5g7xe7fs614yTTzoX/UIAg25XnQMDdnDll
         PqVQ==
X-Gm-Message-State: AOJu0YwlK8rfyDzcxYfo35KxLHNOmiLPladrL+0gUBETKdjcEAc08CAm
	Lle2SkkELCGbJrvpSO1Qi9jnpp8nH/erCwDzi+Xk/tslcE0jNX68J4ksAuugIg==
X-Gm-Gg: AY/fxX4Uspy5Cgn7DWJZHN6zlJXSyYCXB+ooRfSM0xDzwbnVCpc+WrWf7rY2u+y1gQE
	6juAXk5NMIPeZKPmjLGfxArpCt+utF8hPZs5zYThVq002j0PMYhvVDfqfPhJxKsp97MYEnYd6YP
	OlQylSrKASWGUTdsBya2xfbmxDN9WBMYCEFHAaZpyqyZS5bVgwWm11rfNc9mkoRwWcWy5Wt2Ml3
	DKQlqOza+HvLCvFAmRhKFyiUR/7zXk+vJcvqy0kP2afvVYbQODvhl+dQ9xZE7d8ghV/VAeQVyaw
	KGZPfUQAGr9dvmr83NaMGvrOk05XKUM9LuBSTiTgrvjX34GQAE17Q6CwuQACM/BlKAyj+Ity11/
	EK/trnKCWuzjkQXbPDxz4ZYSOFYWVq7dNazmFkqxo6WPH588kk5/efMrhcjs7g30jw9qpw5HvYR
	KOTyjAhaghcGHAFaK3WA==
X-Google-Smtp-Source: AGHT+IHqwtceIlfMLKuH2kp3kNbJ5mmtr7rrhcTO+/Jxtw55/5+eBJnEb9T0AbvzuLDzAmlTN2pCrg==
X-Received: by 2002:a05:600c:8115:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-47a8f8a9c26mr222381175e9.3.1766071941098;
        Thu, 18 Dec 2025 07:32:21 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:20 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 02/12] pinctrl: renesas: Mark local variable with const in ->set_mux()
Date: Thu, 18 Dec 2025 15:31:51 +0000
Message-ID: <20251218153219.228506-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21127

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 731b30f6aab7c45bb89372c3c05b711cee362b69 ]

We are not going to change pins in the ->set_mux() callback. Mark
the local variable with a const qualifier. While at it, make it
also unsigned.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231204160033.1872569-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index b196105ab293..062e109126a4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -559,7 +559,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const unsigned int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index 593b03bacad2..2e58495b26f3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -165,7 +165,7 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	struct function_desc *func;
 	unsigned int i, *psel_val;
 	struct group_desc *group;
-	int *pins;
+	const unsigned int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
-- 
2.43.0


