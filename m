Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D691C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:35 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.10427.1746783331096867786
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Q9ZUxZdS;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acae7e7587dso276583066b.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783329; x=1747388129; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+GFAP2q6jaQyzIPN/6ZG4+aybkPJORZM3eoXZ+a9I0=;
        b=Q9ZUxZdSc72uquKFWEFJszlz2auIdJxGzZh4yD0KmuAY76m7Jcd6hVWBJgJ1luGTjf
         E1+lh6lIv89ZTTY7OAppSNtc1BwQCX7SyyZM7uvJbpinITVugkb60fs6MiJVboNRKztD
         znjKvy1ZYM3B6CZ69NBWfRcIDjAVt/a4o3D6e2hwZVHSr92QQpVjj1EdusQoVLI+3tAi
         rZT3RDxjEK9O5vazlnCGrtuOZp5JqTIQ9LkN5WoqmZiDw53jfAXYUJAY7Wl4syG4MqDv
         H3tus7LzBP12o7hUnitiyapasT4nxXyfztgv+8qPYX8/3+7UDYHTVI3WPOVN3ketrmNt
         AqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783329; x=1747388129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+GFAP2q6jaQyzIPN/6ZG4+aybkPJORZM3eoXZ+a9I0=;
        b=Qh4pytCFbFgmnnnTx3go73YW/GulQrPtwG3V3jQpKT7ndfCTZateHTehN5PBFiGDwH
         aOi4gmpzKaJQp1wwP95thKyPXNRiMIRJ1UZYs4v2ycSCuy56kBJarHa9wuwVkxLnqAWT
         BtJj5ynSRVEU7NTA5uSnCgPO7Ozxub95XMwNdoJrEYfneGi2qZKzECYC6tz8u6m8XHey
         BITqGu6gLoNBoyQOX7JlK0eQoHpC1wSH1FQBKT5jfBCE08FW+5x+4uqDEBJSSd8mEGYD
         /2ZYg4ULffg2dgBd3jiY8cbw2M5xWYps8YhFO2yXTOukTNQXGGFsLwYg9QyQ2IqZoUfU
         XmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVThjuo4xCf4wobjfDZD0K73MYUxGSNH9mz76J8f0v/XFGkzOuccUSyr5sAHyJtEVf2x7S9IPmF@lists.cip-project.org
X-Gm-Message-State: AOJu0YyyMAFBSdOVK2oFCR78qUteQMTBqX+ye6IdI8Fl3sYUe4A7Q5Vd
	YHTd+H3nXsrUK8nOaKpI6u19WTwceBN8AIenT7ln+q/tlLTfVAetSh17N0bGBLc=
X-Gm-Gg: ASbGncsZ3ygUaj27DVVNFskAPi5740JiQKxE7zWHSRUeaSaUA5mInzbfjazo1oeITfc
	nLLBY03LOGN8XbSETtROoND46XITilDHuOxaRcuNExFA1atsANk9U2FedH1xt64QfWjTZshoC8T
	Yn7VE7gZfXFv2+O9Nbf9iQ4WtWqwYc2by+wK89AVlZd15lC6yVvX/vDHxN5MX51557R+SzVlffv
	icRm368LhKmbOa1pWgEtsGBz2W8OKaqET4swqcQCqJzTgFOyUbcw4gvRInfUrY+u73le8FpZnHV
	FWhVtotADg1Q5dQEkOP1WxKInwdGJHcbv838QE9vBlp6ohAAA9hVclszNVCUriWBUCkvdw==
X-Google-Smtp-Source: AGHT+IEY85nuHvmNXk+ePri8RHPkPir4/mDifY74YbTYdqDY9i1U6nyhn2CH86WESL1p6TloP17Qfg==
X-Received: by 2002:a17:907:a0ca:b0:ace:9d90:c568 with SMTP id a640c23a62f3a-ad2190009d3mr272694266b.24.1746783329464;
        Fri, 09 May 2025 02:35:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 31/37] ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
Date: Fri,  9 May 2025 12:34:36 +0300
Message-ID: <20250509093442.4015145-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18883

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 699a9733a354d74482ae4d4304acdbb0c0318a23 upstream.

The SSI IP variant present on the Renesas RZ/G3S SoC is similar to the
one found on the Renesas RZ/G2{UL, L, LC} SoCs. Add documentation for
it.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20241210170953.2936724-20-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 94e2e3abdaf0..fd1ba590e8d3 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -16,6 +16,7 @@ properties:
           - renesas,r9a07g043-ssi  # RZ/G2UL
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
           - renesas,r9a07g054-ssi  # RZ/V2L
+          - renesas,r9a08g045-ssi  # RZ/G3S
       - const: renesas,rz-ssi
 
   reg:
-- 
2.43.0


