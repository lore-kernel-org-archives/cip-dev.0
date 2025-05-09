Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57FC3ABD2
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:43 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.10337.1746783161356027523
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eaRc7JDU;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fc9c49c8adso1061392a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783160; x=1747387960; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYWh+wdMQtg/N96Y2q07Qtyhq4I5IFGdekuBlsr3yF8=;
        b=eaRc7JDUI2A0CRfD3YE3WOSs7kqeAJf/lZmDP0dX8KMQRx0CYp73uFaQYaqDuW7lkO
         ldj4GNhPMPDVj6UEwDofcr5XfE01Ko77HPBtwM5KXhfI4i/wmLYz9LsOdPFJmHDdDAuT
         p+acBiITT8NXnY0qojkunWZXHvraoXFg8FGpJbVoxcmF4/2rCXCosKJdA+TwngFEASGd
         KUw2idprtCmgTpQAl26Tzu3Z3cfFCNEiZG9V9i2PF9H1ZqJhoLu7xWP0B6MZTMV+klx3
         qMVzDOHDfN8Sd6pY070leSNVy+HUGK4fUid3EgylVRg48UfQYeg1pinv6Ed3yyuKQfyK
         6Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783160; x=1747387960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYWh+wdMQtg/N96Y2q07Qtyhq4I5IFGdekuBlsr3yF8=;
        b=O99rSYLR9+NjQBDtS4+p0R9KmvjsyY6RxOC4zXKgEuGODNcaEzy0K3+kFRF6CNXiiU
         xNjILs1ePvoZTkKqtsu2ajQjD9cVmPVHh9TxNJ0t5b9GeZ8TFvz6mhKO3Giw66duZF4T
         7TTwiI8Shy1f3v34k1mQrVRGnfRNKDzxFAwmf3BPDs4A+hsT2csY0arrl5NviadNLfmA
         xvWp0mDRgD/n3DP8ikR3D1vqLpcVREXKQLcpryEaCmsrvBbaN7NY/GJAw0R7fI11q5ys
         6RBqkVkmYUtm0N9ElOujWFUhu1QI1yHCZuI+lT5dGjHlmVCNerUKsbiyBMYea5jEzvLk
         4P4w==
X-Forwarded-Encrypted: i=1; AJvYcCUbmZQH8uVl/8eHaEVnxmgPQr1ljO8b9Bm6h1tbF6RHpMpPYPMfMbNv/E/KsrA2rRXTOOwi7/83@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz0CYvDAHKGmnPUTXgI4SaOsJKuCKWaebTfHgDHO2jp2b6SfRx3
	HH/6EAME73YSoQo3acFWJsM/TDMl4XFlWHWjViIR3re4LWtWJRo43PhCr23FMQI=
X-Gm-Gg: ASbGncvLXZbP3ho8Z7kwfJZU2InnpGh9zgoqNs4cKhXQWoPYjnCgSd1IMleRmoi5QX0
	A8o7tT9j1F0dgNctyCCEh6+O78Xli390ZT/69QRbA1/PQRA6zpy8sv4Lu+CWCbQy358XUTbOe5P
	dzZ0I76PNBY7vQwGsbr6Fvnsj6d+1p9wZmjeDAUnmUlIze4Btu8Dp3PdIiNaWDFhKuLSdfNivhM
	05fHCRxw+Kg1vnwGVeSHxxK0hh1uylJD2TyEJB594QI6AaNOcFjoXzmdaESQLYt8MCLVCsXqGE+
	W5+CsoXxbrIevyLpkmnmV+qapsnS+JLXBXGAUtzJVLPSBbLrEozd1mdnX3DK+nHRoE91Pw==
X-Google-Smtp-Source: AGHT+IEQovi0tmWCJFyUmMDe41etmX+6tYgYTUg6UIYTP3VxQSGOB+wVqKp1u5kzU4Eg+5o7V3mZlw==
X-Received: by 2002:a17:906:bf46:b0:ad1:8e78:3d79 with SMTP id a640c23a62f3a-ad218e74716mr264270666b.1.1746783159703;
        Fri, 09 May 2025 02:32:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 23/29] ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
Date: Fri,  9 May 2025 12:31:57 +0300
Message-ID: <20250509093203.4014750-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18810

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
index 5b42eec864f8..e4cdbf2202b9 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -19,6 +19,7 @@ properties:
           - renesas,r9a07g043-ssi  # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
           - renesas,r9a07g054-ssi  # RZ/V2L
+          - renesas,r9a08g045-ssi  # RZ/G3S
       - const: renesas,rz-ssi
 
   reg:
-- 
2.43.0


