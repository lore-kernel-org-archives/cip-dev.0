Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB28CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:24 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10069.1762416677059169873
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=i8RCGud+;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so470581f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416675; x=1763021475; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBTl479lBmsUDd9KkF7yQKUTbB4vtDxXNPYW++KhVdU=;
        b=i8RCGud+nZpF7j60aLeEiuh8H+2NfjlcWnWiwng+puO+axWiI/2I6NdK8+FgDWSDOn
         AiHXLFzPMbbmhB/l3gnY4r7pkBL4ndxaR7X+PW3ToDk3heOQoiaR0Prg0Mqx00FPGc9F
         8xcr8kZN1NSl03tcCxy9T24/SlfeVlDm7y6tANurOY7QOp+XQYtFb481CzbPA+A2gQEW
         6XCM/TJa9YZgvTtgF6BjZmgSTlmleWiOketEq8+MMQHZ1R58YXeMceaA274LHPfP2nPm
         6Ye1UE7Lup1xP9p59hkfcBsMgfympEl7iCsbB3zCRnTma36APKBhhilmEqSiLwawVV/N
         CxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416675; x=1763021475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBTl479lBmsUDd9KkF7yQKUTbB4vtDxXNPYW++KhVdU=;
        b=kyN07f74JYiAgtpoxoCpBv41w2wKkmgZL2EbBw0QfqQJ15smA8yBNhCUDSkuYQxVkE
         YA5lmQakT0olFZ4jPOHwFLWjYv7J35InTn0Nkq2KmGtwIZd2keRpzt0A/xmi6h4cbl0d
         n4tibn+ek+aAH/l8v4lfcYNj9DpcvZabERsJv8ckLrqfFysDP4eug+cRSuEHaTDoFuTF
         ZiwUIms4to1RF89AUxQhGRR+fhuSiYdVAzM3bEsqYghNbiHM47IMR7FXOPavNfCHOk5k
         b9Rz2YQNoWgPp8NHxMq98xmIiNBFAjsCYRqFP5j87/vQn6JkM6vKrics0/vqqiWal/Pd
         q4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUYz1elpKzV1hYAQmDLrZdHql8jSJH/kJCDHqEMIzbQNHQHl1kvbswrEac0WAKSfwcxMs0+LZ9P@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy6E0Ydhj6rAmvYE78rksHLLbHH1jXEWgfja6cvJV694tnDC/tT
	GsT0L7ZqLplpFeRWHsi9Np/U9RezWXb4LnRMqjAKuvfI4xL5kGaIF3wjyVM8yMExiOY=
X-Gm-Gg: ASbGnct76VInkr2gAcGOwvM5/BGZBnyJDCTleohE99wM9QtFY6Y94FPDY8M9vO5pPfw
	ElwKsioF8ZTqqpfCJtehw/vAUJX0n+DBh/n5nJnQekMEjdlWjFVGxIfm+OZBymP9FQrz9wDXiyw
	mCp8E/4IXV8wBNMfI/AFotXvKR8X6R1THDdI++0a2j+2h8zzW9iFUZq1MyLzT74vA3JuqzmIVKM
	8+QlOE7HRswShoxORKn0SvlNcEYMUJYA/aBPMz0NXGcdrgw227BZfoqdItTXeePIyxXFniXON39
	bak+Fzeguh+v0h8bVdOCgen9FkPMe4BbIPH7kvKfI9f2FYvtHh4RWtPBBDnvLq3GhK0I1JdOGcs
	YW2q4ZCxCsMR3NEbsaFdvEQrljYrK2ZvlXER33akhByroAQau2smm0uyAqF5ETVEnpVLWlzOOxi
	TdcW1hfIG5DS6QXc7BGhtTZXemY97gjQFUkBObiWg3
X-Google-Smtp-Source: AGHT+IEOiSMKGyEmN2NTwX8Jf/7itCuLuozqqlHBrHuQHvFo4J/lErKuPqqc7ZgdqgMXEjqfOjkbZA==
X-Received: by 2002:a5d:584b:0:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-429e331283emr5987144f8f.56.1762416675432;
        Thu, 06 Nov 2025 00:11:15 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:14 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 18/23] Revert "dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S"
Date: Thu,  6 Nov 2025 10:10:43 +0200
Message-ID: <20251106081048.2574345-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20387

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


