Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56FC3ABD2
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.10313.1746783242981975595
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Z4rh+VcN;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso3666997a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783241; x=1747388041; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+GFAP2q6jaQyzIPN/6ZG4+aybkPJORZM3eoXZ+a9I0=;
        b=Z4rh+VcN8CxA/VLw+RhtsGPYzhD3X/Ho41Nts8yRxiofogvnpK3gYBfgmeSdob6yfk
         y7Ngx7ncsiYLWga+Vxew0izmUnlh03V3Vj8pNJKMnx8QXuQWXh79SamaISedXF0RaeJL
         2xOYMfEqEPbMb7t8weCiXxwixYvM5fDdlh8hDXWCEncH8NbAZ8d1v/jR+4HXp3HCQnKp
         7BE1Ycnxw4T3C4QNz0Rea4ML+veaF9FRSHPGBjgpZIkdXUBXNbA3jUxVzXcVvNPQuSaB
         k+91odAnVWG6+bkJRkOI9RR8IQhv0L9fvkkPC3YviUM0mdovX2w3A4Lj4YJnqdDlq6ZP
         OWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783241; x=1747388041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+GFAP2q6jaQyzIPN/6ZG4+aybkPJORZM3eoXZ+a9I0=;
        b=nyjCJS9oDd5QpW5P4oIx5PdP/YPvVMTSvszaurHfczPNZxz/rOma0BlVM8nYhhedfe
         Tsv5yMtc/Z6Z9h9C9WF78+IpF7ILIDeEA9X4BC+U4eJ9Ev/OpfTYG/BT9S7ESlTWDche
         X5+a+mqdrDSG/c8FaCWqzwwXk8+cGjv6+E6LNxAshsce9rkus1P9SleljNDCETrx+mTr
         /U7+t1Ib+rmi2D+vTqsfo+v9BcYtrxzNwHlDQeBDYttHwf5I7jm43I5hT2/xMyQ07WEo
         C0UVByNm1q+oTlTHFeP+nLFzu4mBjiPJaMYxwYpAKDf27H+ML92TqIqi+Ew95CKsvX/u
         Jbkg==
X-Forwarded-Encrypted: i=1; AJvYcCX919MMR9NXNLmmSwol9EHUujtf+w2oxT08O6H26Ih3YLbPI2sVkiXTCh0jUqkvTMcislitcHVU@lists.cip-project.org
X-Gm-Message-State: AOJu0YwF39XutQ4FpbzXzIPxBVQzCi2LpYHGCsq3UH8EDZ033cO0i2/V
	IuXzlth3/aXhtpgv3RlrvM3OAj3jC1Oez+wRcOMvG1d3PdZXvsXreyjpPORUscM=
X-Gm-Gg: ASbGncu5tTz86jsHML/vbS+pvUII1Fysz+gdnt/iwy0sbnMLEqNZciBDD7Wc7h9LrGM
	ium+yPMJDm0H7tKFGa55pN/0v8kYUcCs+mp3h9LloUJWWM4LykD7HwkH2hh3iwfh7io/XEPkk8k
	H30Kaagayob/86uRYJVyBWdTRO98se0HGBNLKiZ5nM7q8kctkoF6l0TVk8ID5DukDbIJnhBl9jn
	ZDG+f2fDCy00U65r2o0KFlzDk/QY/Ar/SC6cPw0aLuviLRqiwgWPf5Z2TgoxK720aFuaDBr/F2v
	OaAfnqpNM4ZSdkaGvZki5O8kSoylGFqWmvywt5rT5qPxtGjQ6Aztj+RP+YvDYPpmSzQCMA==
X-Google-Smtp-Source: AGHT+IFSzp/kK+PoqUxiG1KNwMI5aBoAtP3Y8IA7P7PMAmrABzym+SM6e01E+o69s2PybaqxkcENgA==
X-Received: by 2002:a05:6402:1e88:b0:5fc:4121:e8c3 with SMTP id 4fb4d7f45d1cf-5fca073137amr2112813a12.4.1746783241331;
        Fri, 09 May 2025 02:34:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 28/34] ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
Date: Fri,  9 May 2025 12:33:12 +0300
Message-ID: <20250509093318.4014916-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18845

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


