Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F78C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:30 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.18440.1713526769172371154
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MyaoZwTF;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so2363279a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526767; x=1714131567; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdoWVPM/7DY++OMVB+jRm3KPxAtvnJQtL669qXgpLqA=;
        b=MyaoZwTF2KNLzEt6meXxlT8TXwUgOoggIuZ8Lb6ULRRhYHkEc6JyTS5lNRm3MnLT1l
         mzk8XDl4+bO6zhLICavhdVhFvT/VwETcuShjDCLEg2EXXsaewpCCIjHtmXTdcie74ynO
         IU4UXErDtuxMBMjx/xtvcg5UJfuvaubVr939p9+ohSLMXWK1APwGkP9PrpA9cvfGvAlR
         ZpylIfrfR2Shicx61NE/J8ndrlk82GTU3FrGMYo70eoy8MxmLTLgLisaYDztZMYTkeGE
         DSoumH7Nq3/KSNNpV9GlGNmr448xDddqbW68Jy4etLj55qJiNhr4gs20xDQ2Mik6I82/
         FjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526767; x=1714131567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdoWVPM/7DY++OMVB+jRm3KPxAtvnJQtL669qXgpLqA=;
        b=gtyAp0ZAKPekXperQdN0bh4VdOVCYGYsJHebRSrgnw759mx/v0hJmA2an0YbitGW2c
         KBm5N9cjEwLKy8KNpd998qNgUsikyd6rStZF8UhkZuM576fuxMdNgOTm0PI3Ar8INF/4
         Vo4eHhXCoVtuuZ44StZ32oryl+ucRDAvIoNv15whQhDyjGqlWHYAgUuxWvWsMNyDq4t0
         A701I//bgFQXe5Lrebtp7aIdWOeXhxKdnG2Avc/AF9vsTB2WQFCMmW6Y3LYjHqNeW2ni
         xPybLKoE2eGFIn4KWBmEKOPQUgocCDENKgnCfcu3whgucu0M0EEGOJ1Ca1OKAmNekLEr
         wS0Q==
X-Gm-Message-State: AOJu0YxFv9fJgs+iu+xhV0S0iwFIIxwWqdEf1lNKrjtWYQi2eHdO1OTf
	jvLhJ2Yn+8h8aBP8iq+7eLPlY3Pwig+hUSPUG0BYvtbRjDNSuPwoj/jvOuhg3NY=
X-Google-Smtp-Source: AGHT+IGRRQ8ebYvpnr+rze8kVaRAOcC51u8DwOD52FPviKS6j23rbR1A/CQHsbYO9kFGui9ZEXHNIg==
X-Received: by 2002:a50:a453:0:b0:56d:f637:4515 with SMTP id v19-20020a50a453000000b0056df6374515mr1136576edb.42.1713526767568;
        Fri, 19 Apr 2024 04:39:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:26 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 29/44] dt-bindings: pinctrl: renesas: Document RZ/G3S SoC
Date: Fri, 19 Apr 2024 14:38:27 +0300
Message-Id: <20240419113842.3675543-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15680

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
index f081acb7ba04..b8937e01be92 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
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


