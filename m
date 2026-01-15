Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90CD39010
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:42 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31324.1768466195220336928
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VkpIcSCS;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so928511a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466194; x=1769070994; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBTl479lBmsUDd9KkF7yQKUTbB4vtDxXNPYW++KhVdU=;
        b=VkpIcSCS9UfeHH4DBxGcy2aboX7Z6ihhmmE6tow1GgWGpt1yTTqWBzQu49s+6d4CbF
         U3oJSLzSAJ9ADdB69G+/5jlI77aAkCwCv/EWVGQOP9wEOpMjc/KIstUOB+Puc0yz7b+Q
         2ZEwbj5ouUCl850H7bixBI9a5bQKCEejF2juwqHZcuJjzqbFF9Lpsc5SnrYkbtW8t8g2
         DAjzS12GvRm202YUSE4ICwkARsB/fLhw3xUor8eHvvbT+Io6tYFabfcxkngZECfGAoVc
         O+UE7uzpQzz/Cyqsl/L2iRWdjXLCpoZZu4Ska3PQqzSQ97FsQhAf4gd5JNfA64VboqCd
         FDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466194; x=1769070994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBTl479lBmsUDd9KkF7yQKUTbB4vtDxXNPYW++KhVdU=;
        b=YOwRXJ/GGSqA+GSZ9sNgr5AFgGgNzroZMKv2jHqwz5UR4mKCnnjS+amYtcYOgIsF1F
         ZeAXl7wj91lDNW7Y7mq+NTquB1WFJwSwXARgJmM3yeUwisPiZNMGaAdJdPne2cugz4tC
         vo5wd35jbSO5ThvmzIz60X6JAFeqTrpKNdkOWik7By1yovTZvKMU0I0gpPCJMPjGT4s+
         EjAL2io3QtR4ppUmH6fI6KcoF1C3yKP9uh2KofGlRhi2FW3fJPyBV55EvOU9Ql8c6ANT
         HtvnsLKu9YIjwBb4CwpE6sO6T8NGyDvm9cPEIXjp61tPjxZmtcRgL4mv5Z32S59Rzxtr
         IMAQ==
X-Gm-Message-State: AOJu0Yzlra7FsCbCFEWYsBeuQiWMlqOlBKWHroNw//bx+JJhBK5zd+i/
	1L0o1/ifmJJw1WGCw4BQmScCcu71x4pvMfT8j6eK23wsMVYcs03MiCJ9LaNIkdll6kY=
X-Gm-Gg: AY/fxX4KPh9JXvU2gijPaOSZrSpWEbA1OnKAkcvMhxx9F7I3ZADrk0QxIaZeWW2jQd8
	CoGpelsoX6zjBunfn8C1BeSNLBTN+ElzvD29W7AU03kuin69QB54snZsQr98wcEJaSJX59PjGjc
	gX74hW3AgIsk2ghgeQccWP65SKh8E/1skufJxMM8R3QurtqQ/kTK7eEBTdy1S+LUREP9vMIMcVI
	CeM3MQdK9JD0XHOpekW/ujbhYu8AsHTPy8HINOEkEkPHbpHhh12rXRHQERCU2o8a6+3eEqyEwmv
	w7FFdR1IdNgrcluYDk/B205W5K2j+/7J4fI3K6tTT6CPSZqKGeBQC9Ft07GPURewjpawI0v0xPF
	fH9dsGtvwF2o0+zZNOLC/K38sW0wODAak7ZyBH2FS+gCcKRP3ruhQpebRYJDoux/J6k8pdsoPZe
	dL0lVOd5abZMUMaW8/IGIIwNc3xx8271U4NMWceThqVlWwQ0ZxuzJVEU+3LhwxqYQvv+JKYFIg7
	8Ok
X-Received: by 2002:a05:6402:538b:b0:651:1107:d3cb with SMTP id 4fb4d7f45d1cf-653ec46287amr3724080a12.24.1768466193043;
        Thu, 15 Jan 2026 00:36:33 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 15/19] Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S"
Date: Thu, 15 Jan 2026 10:35:59 +0200
Message-ID: <20260115083604.1064260-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21615

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 705d9f8f180851c60e6a344881661c3d44b92313 upstream.

This reverts commit f33dca9ed6f41c8acf2c17c402738deddb7d7c28.

Since the configuration order between the individual MSTOP and CLKON
bits cannot be preserved with the power domain abstraction, drop the
power domain IDs.
Currently, there are no device tree users for #power-domain-cell = <1>.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: "Rob Herring (Arm)" <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20250527112403.1254122-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/clock/renesas,rzg2l-cpg.yaml      | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index 0440f23da059..8c18616e5c4d 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -57,8 +57,7 @@ properties:
       can be power-managed through Module Standby should refer to the CPG device
       node in their "power-domains" property, as documented by the generic PM
       Domain bindings in Documentation/devicetree/bindings/power/power-domain.yaml.
-      The power domain specifiers defined in <dt-bindings/clock/r9a0*-cpg.h> could
-      be used to reference individual CPG power domains.
+    const: 0
 
   '#reset-cells':
     description:
@@ -77,21 +76,6 @@ required:
 
 additionalProperties: false
 
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: renesas,r9a08g045-cpg
-    then:
-      properties:
-        '#power-domain-cells':
-          const: 1
-    else:
-      properties:
-        '#power-domain-cells':
-          const: 0
-
 examples:
   - |
     cpg: clock-controller@11010000 {
-- 
2.43.0


