Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FC4C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:15 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.10417.1746783312456630147
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=lnBjgRIn;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ace3b03c043so304514666b.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783311; x=1747388111; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMf0BaE5i+Dc15bXCLHFOZ2RCoP15HqWYVUdKrNF7a8=;
        b=lnBjgRInEyd7+8rM7/meQ5Mjzn6Pp2NWhW9EA8ZpXsFIVcDhr9GENNuklFWT5HBRRA
         ksVtkvgl9HF4YN19+2arA/4QusxKU5khEztU9XPJSzmTCvowLiRgBXOC7I3nW1RieUkm
         D+Tdg5B18RpphU0mEyJvonsywpQr0aR4ZGM59HXfDRfRvI/Undu/R+L8sSInjCFjgJ3U
         w/q36JOY3sLgjXw9r7Yml9kiCeWYyXKZoLiAUh5S7GKP4Z2ASDcjeXOGoRbAmLuyZrhP
         w9LJMPEkHvpLHFBrWzdqNrQEu5/Hks/F47cTakPwYMace+zLrwFKf0NRlKixB+uMzAhs
         BD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783311; x=1747388111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMf0BaE5i+Dc15bXCLHFOZ2RCoP15HqWYVUdKrNF7a8=;
        b=I/MUnsY/iXZQrXChgnuVREb2Z0zfejNT0Oe11U+9vtFpyCGkyR7uVPGybSXGWB/eLl
         DGhEXktK92DX4ZUyzP54aM4jLV3nYwQrNtOWIucmPOva28sYgyYPwcjyOA6+g06sKm1/
         zntrrZiMUgzLwjBEhBkKLzVxXHmwxYwbN7aay35q8re1oLFHJH+rQZiJkB9/gJsCtcUR
         0RFPuXmXSAl4u6FPVjSu3Rtl+fIu7M4tP5KZQPxz3Rj4KVVs7k8wNcRfCIHICENNqRPG
         6WSgYtFyiOA6iBgXvTCFCftNrHrtTKjj6O8IKtH76v5ozHX5EzCMcp7th3IZ04vdFoGX
         IN0A==
X-Forwarded-Encrypted: i=1; AJvYcCXLm8TQvYnRWrC8yn6REL5QOOA4qJEsUsOm74BAsWHtYg7yz5OWzzXmM4zRFhYs/8B4SYWtHl0o@lists.cip-project.org
X-Gm-Message-State: AOJu0YyIEO6wkLze3XD3bUJrO51g06Wj1bBJh7Ls8WQjEKVaRz9MQM3W
	GVPYNw/Kenm7yeQPxtTpOlqBp7OTFo6DyqILQW3sk5JzD79ZiSEIaVwDvJZbREE=
X-Gm-Gg: ASbGncuRa0lE2j9BUxaQHbDvBrgdNmJe18lsL4BVvFk1gyV801gyNBjYpXDjp7nhImu
	2Q3tYgYewQIX2sVlnVX/yVoFfhAUoxV4gCwuOqC0UXhKp0XLCemaqxaPc5F9Qqw2zQ8oMP/fn/E
	FwXMAUh58L9Jra7RP+w5SIQDYbIPmXY/M/mUc60tltvNK7i7QfaO9z3nKl6V4t3Wn1BqDJDmreW
	jgp+V2VbUGkMfKXKasi0evCovrgVIWpIf8Uiq4hLgCcnj6RKuaDCIjpYFTz9RtRTJChtXm5Bnin
	4J1yNprwPR1mEVgO5vMviJ598vp0nbhapogHraLehKCyHB5nvYCnQmbtrXc1ftzqFSga2g==
X-Google-Smtp-Source: AGHT+IFzyhdf28DvU4JR0pfXApUX+fTa/bIcLY0bxJDaUErbQCkbg+XVuoWyBfkVGNCTAFxMX4Zy7g==
X-Received: by 2002:a17:907:6a13:b0:ace:be1a:b033 with SMTP id a640c23a62f3a-ad218f386a7mr278827466b.24.1746783310815;
        Fri, 09 May 2025 02:35:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 19/37] ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
Date: Fri,  9 May 2025 12:34:24 +0300
Message-ID: <20250509093442.4015145-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18871

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a73710a25808a585a2bf0a8325eb16fd6a2f370c upstream.

Remove the pdev member of struct rz_ssi_priv as it is not used.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 5828d059262f..c1b729822747 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -100,7 +100,6 @@ struct rz_ssi_stream {
 
 struct rz_ssi_priv {
 	void __iomem *base;
-	struct platform_device *pdev;
 	struct reset_control *rstc;
 	struct device *dev;
 	struct clk *sfr_clk;
@@ -1045,7 +1044,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	if (!ssi)
 		return -ENOMEM;
 
-	ssi->pdev = pdev;
 	ssi->dev = &pdev->dev;
 	ssi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssi->base))
-- 
2.43.0


