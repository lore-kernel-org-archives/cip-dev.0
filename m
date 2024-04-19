Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2F3C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.15321.1713514730265626140
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CpS83Fhj;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518f8a69f82so2114092e87.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514728; x=1714119528; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k0JqLCTm5YJ9uCkGHJ+BOxGiI9vPdO/4XaCNz5/Z0g=;
        b=CpS83FhjLC5Ab/cceF9U92liFzqn7WOIQ8jAysK3qEa5IJIuAn7t3PJtNQhOk4w5K9
         ZW5EG3G9DMdMCt89fCocwJ9kOarSm2tnqD+3t66+HyoDH/mKZdrLOtsHaibjAL2s8cgs
         01hLfPOETxpc5j4tufsQT1cecgaIpd6IGtBgdWJPXow5WRXfxx7fQ5gFagA5RUsv2BPs
         2NaBtNL4WDniYFD7qegMOEqWZ8qEhAiR53AfRTVXme/3spxQDRSlFeYrVMQavapt7VX7
         wZJaJtIWfmtLrIpTf8hvaj2peRsxgxcVeDaL/QvDfXXN1CmOuiGf2VcFzWsOPHROiBZd
         X7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514728; x=1714119528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k0JqLCTm5YJ9uCkGHJ+BOxGiI9vPdO/4XaCNz5/Z0g=;
        b=tmHnAIo3U95845cRM3wG5BrIPmyGBTLum93CluWe5TUlfVL1LgOEv/sGzNBCygkW3q
         9VlOntvmuZbWz1aVVIfCsu3OvBJi++CDq5ZKDSo1xvCbg/FWdr+0PxFHiZStlDjR1Q0L
         2mGzKdty5YZZQeFf6iSj53S9l3AevaikNE2u33xODPCgnGiOSBbS7Yrv4DwMxZWjEJdE
         k5Q06ecHPbJMBLE+eTM9BcsSR2Qu4OS2xT0M5lSX1C+W7Yc7vNPJaF8AjeB3SAybZ+tQ
         qFgxVgS/vvEkomiin9sp3m5pahaSF7IyODeszVyP2rDGZ4eBFJGOOouLJi0ga1FHI5t8
         ZUXw==
X-Gm-Message-State: AOJu0YzZNl3JePaiTw6aOi5jQVj2+7X4+mDUED/F6Xf20PaP8kKHYztI
	KuKj9RqJhGGy2Q5IKKhikYKJU8a6A7PZCQlcR567MZNDtiokTrUnooRKBP3AU6o=
X-Google-Smtp-Source: AGHT+IHyyGS6+Q76rhHZgauCxZfPPOaBpgiw1kFwEgHPFPxdP83QIkhZ/Q413UMmuWVtZSKs4nGBsg==
X-Received: by 2002:a05:6512:608:b0:519:7698:e9d9 with SMTP id b8-20020a056512060800b005197698e9d9mr1059403lfe.35.1713514728345;
        Fri, 19 Apr 2024 01:18:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 42/53] dt-bindings: soc: renesas: Document RZ/G3S SMARC SoM
Date: Fri, 19 Apr 2024 11:17:31 +0300
Message-Id: <20240419081742.3496709-43-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15629

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1c3be6ca72293723e009a29fbe90385fa047e5ee upstream.

Document the Renesas RZ/G3S SMARC SoM board which is based on the
Renesas RZ/G3S (R9A08G045S33) SoC.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-24-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 830121d7dd25..ea995b9c77e8 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -340,6 +340,12 @@ properties:
               - renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
 
+      - description: RZ/G3S SMARC Module (SoM)
+        items:
+          - const: renesas,rzg3s-smarcm # RZ/G3S SMARC Module (SoM)
+          - const: renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2


