Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0AAC54E67
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web11.32281.1711527481980478452
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YORZoz48;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.179, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d476d7972aso102389061fa.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527480; x=1712132280; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K4zcjyXwjI2HVaogVEUmaT9a9pbF8vHfkiuYWtltuI=;
        b=YORZoz48boeMO6pWSXQnjx4HmubchkES2pSb4lEuh4YcfoMNFuGsVZiHQicZX2NQNl
         NTUxiz7lZRf2gCMqM/AU9oZxqCrNj+xW0mDf0Ffi53VsixyYPv47o9p0NyuKuNdQbg/g
         JWJpmE6Rn8VR4wEdYvs+wX1gSAHw1bHNnkYPevvLvSkulJeSgCv/XDJT8kn2pz0eYn2c
         c33nhToIt4bNqYdBi/Plu8SipP6QrZNXHcR2FgwCdckSalCShdgiXClhdsrC+4ZXDki9
         tffGiSpD6F/s47OqFu6ECWKo/lONVU2DAAatud/YgoArYjHbKiWjc7toqAPtIMckptnD
         kWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527480; x=1712132280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K4zcjyXwjI2HVaogVEUmaT9a9pbF8vHfkiuYWtltuI=;
        b=uw1tPj8Ky8S7Np7gdqlYjtgDOKubip6S0ZQUyR37h3KUpYTJFKQJDMb8/4bUrcHuRs
         eJb/Z5XgJWbyUcdGcS7pBxJhpUiO2IB7JuYU9f6SiIHte+0Z4Rjjwf+NukfMfSLHvdkr
         alS9cf4be2HjZKvn4F7npH8uKt91rci04+lGKY2YaKEiIw6q+sQz/4EcDMkSDP1fi6Lt
         5DjTy77/Rkxe36gd2b4vDfbvgtdKf41Ujwuc75j/yuUyXN3f28xCPtJxKcCUDIYxOXqZ
         bGHg82QxWNTHm6H3DDIPu7Ab0CvMBX151GKVKMTPfW8ZZYYiQnfjAXxgk14/PqOHPmTz
         65QQ==
X-Gm-Message-State: AOJu0YxP/JkWfwW1NG81oSU03tBxgR7tVERNccu4BKpRrntEAgX7H0UL
	VN7rEtxqULoRovKmJHuISlUuXuqWZ+U+ScJ/Z5mj/EKt6h4bVJf50Uz1XnCII2M=
X-Google-Smtp-Source: AGHT+IFD3kb1q31LLbnr+aXT3tpDq6LnoLPYbq37vKXEeM+D29MyN6EVCFmuouCBQUmFQ/jIVYdjDg==
X-Received: by 2002:a05:651c:1a2c:b0:2d6:e295:e81f with SMTP id by44-20020a05651c1a2c00b002d6e295e81fmr533310ljb.35.1711527480014;
        Wed, 27 Mar 2024 01:18:00 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:17:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 01/36] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties to handle GPIO IRQ
Date: Wed, 27 Mar 2024 10:17:21 +0200
Message-Id: <20240327081756.2228036-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15418

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 35c37efd12733d8ddbdc11ab9c8dbcee472a487f upstream.

Document the required properties to handle GPIO IRQ.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220707182314.66610-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 6bc9c5ebbdb1..b1cbb8a4b0c0 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -47,6 +47,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell contains the global GPIO port index, constructed using the
+      RZG2L_GPIO() helper macro in <dt-bindings/pinctrl/rzg2l-pinctrl.h> and the
+      second cell is used to specify the flag.
+      E.g. "interrupts = <RZG2L_GPIO(43, 0) IRQ_TYPE_EDGE_FALLING>;" if P43_0 is
+      being used as an interrupt.
+
   clocks:
     maxItems: 1
 
@@ -107,6 +118,8 @@ required:
   - gpio-controller
   - '#gpio-cells'
   - gpio-ranges
+  - interrupt-controller
+  - '#interrupt-cells'
   - clocks
   - power-domains
   - resets
@@ -123,6 +136,8 @@ examples:
             gpio-controller;
             #gpio-cells = <2>;
             gpio-ranges = <&pinctrl 0 0 392>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
             clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
             resets = <&cpg R9A07G044_GPIO_RSTN>,
                      <&cpg R9A07G044_GPIO_PORT_RESETN>,
-- 
2.39.2


