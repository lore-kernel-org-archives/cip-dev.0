Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDB5C0650F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:48 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.15284.1713514723247445528
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LYkhMYPT;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so2195722e87.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514721; x=1714119521; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW/1L2SvTv2gKkfHU0UuWuf0q7M6oFkiw6LSbMBwg5k=;
        b=LYkhMYPT2uzJJBRieE+E8OFaiNG5QCn+woyUsAKcCH1UcOp3I/znlJxl7JSU7J2Fz5
         XSZoIcbHYwvvFH2KPsIP+weGKXoOpFVRHcVCMYFCaklOJMAPWjh2apJ1D8ThsmAd3MZ3
         mi2iWj61xBuj01Fy+BUry9DxDKKGdtllUIUMGlffjsnMPbk7QeIinnRvOQjY9tu2cirJ
         zu3obXJSLP2fN8dRE1eLH3W+OksMuyTvmvLgVpkYFNQ7zwa07zxlvWlZ6iKdJXexmBp3
         mbR+ua7Ji+2cxqXqV08yPpcIskvFQWjitbo06AQiIn9BFJwLDebVY+lRyf7me3BRSocs
         ChvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514721; x=1714119521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW/1L2SvTv2gKkfHU0UuWuf0q7M6oFkiw6LSbMBwg5k=;
        b=BOnGMg6BfNpy4MdnSSXQIv9nI0KoXaVz8fHwx05+EzyPXJAi6g+wKNRxKFojk9ivdE
         tw1w08ZjK/dPQb8fpsxYz9ZJh4GvC6AmObfM+Q4q2KNpuwywj0El2qxESETreUlRpcaE
         mxB8sig141OVPug+wZ9/6e5QZymYW3x7Avm9YSmTce7UUPsL485zvDX53C7sDufzpbzp
         Tm+UWNJ/luO+HuWLIZ5lrN24mSpf4roxt7W7I1UtpNk40h2VGq/vzfVh34h6oJLJLu3L
         8Ezf5MvOO4CIueTOlKAWeobkUR5O7zczR5tcPTl9GcSaALmnRradmqBMgVk13eY/W/2I
         esZA==
X-Gm-Message-State: AOJu0YzZQDuz9tNT/ik2zrPIqDsqIyWtatCDiTW7CB8cCz2kyey2urtr
	932CtZjyHmEvatZClOzmtmQE9Vd0w4qPGzrxXSjSZSeo+IPeROQNDg6bXtKYh6w=
X-Google-Smtp-Source: AGHT+IESxMa9ph/x43ruJMOCRSawnvOSsWPQa+TiCBqpgnSHiN5894vS6ncn+kgWP2ow9cz4CHF1pw==
X-Received: by 2002:a05:6512:3b88:b0:519:6953:2ffc with SMTP id g8-20020a0565123b8800b0051969532ffcmr986973lfv.42.1713514721425;
        Fri, 19 Apr 2024 01:18:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 38/53] dt-bindings: pinctrl: renesas: Document RZ/G3S SoC
Date: Fri, 19 Apr 2024 11:17:27 +0300
Message-Id: <20240419081742.3496709-39-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15625

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 60e4dc192ce2ebabcdd7c3487387a802110dc1a5 upstream.

Add documentation for the pin controller found on the Renesas RZ/G3S
(R9A08G045) SoC.  Compared to RZ/G2{L,UL}, RZ/G3S has 82 general-purpose
IOs, no slew rate and output impedance support, and more values for
drive strength which needs to be expressed in microamp.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-21-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index b1cbb8a4b0c0..692d87356f7d 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2}
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
+              - renesas,r9a08g045-pinctrl # RZ/G3S
 
       - items:
           - enum:
@@ -77,6 +78,21 @@ additionalProperties:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
 
+        - if:
+            properties:
+              compatible:
+                contains:
+                  enum:
+                    - renesas,r9a08g045-pinctrl
+          then:
+            properties:
+              drive-strength: false
+              output-impedance-ohms: false
+              slew-rate: false
+          else:
+            properties:
+              drive-strength-microamp: false
+
       description:
         Pin controller client devices use pin configuration subnodes (children
         and grandchildren) for desired pin configuration.
@@ -92,6 +108,10 @@ additionalProperties:
         pins: true
         drive-strength:
           enum: [ 2, 4, 8, 12 ]
+        drive-strength-microamp:
+          enum: [ 1900, 2200, 4000, 4400, 4500, 4700, 5200, 5300, 5700,
+                  5800, 6000, 6050, 6100, 6550, 6800, 7000, 8000, 9000,
+                  10000 ]
         output-impedance-ohms:
           enum: [ 33, 50, 66, 100 ]
         power-source:
-- 
2.39.2


