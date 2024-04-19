Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2110BC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.18430.1713526729869694818
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Eqqwixrq;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so1921646a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526728; x=1714131528; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT8WyvYr49MKkJbI34ROZ8a3WBJ9Rz0CaUxRSYdvHsQ=;
        b=EqqwixrqOQxaRBFeD3q9cvhKOcOXplnyWZayUvxiD/OY6nWOE9k1z4q8Sun9ey+xoJ
         P96M/tKUl8Km4QmL5QIJJOKpZlkvRmq2vyUUUObSdfAL6nIT5tzR5jBhcKVStG5E5b4Q
         5qhekyrRpweEURpyBjUh00vpf6Pva/6r58IajhPs1wPUcs4IdWh1/qAsPaK0K1FgLzpn
         tF8HpCEzWtKk9SPAmADDWEtjWnRpvpHnFBBzBFTrD9U/SCmcrF05kPKl3W/YZuvZH9GO
         yRZnk+tJnwrHcaSle73XnITDupfypvdEQpvIwv77o0im/oGAwxdCdwNwW3eHfdCLPyah
         hBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526728; x=1714131528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fT8WyvYr49MKkJbI34ROZ8a3WBJ9Rz0CaUxRSYdvHsQ=;
        b=Z1kxQGvKWcR0XnztlEjRFJVqpIulKBk2udHRXTItmQboQzFuMR/49sJ5wxF/q+X1zt
         rcdIx9fCO+7uD5jrAlvqZjUZjTsFSNvvKxdkSpulOM7xHKO5liYYZfHtRfGifJ3aY570
         e6KoUGoyeBacrsjG4VDeH/BNZ+08E4jrgoeQc1iVr9VDywf76xU5eJJvXOCmfxHp23an
         fFRUzSq2Cx2wCFxH7jfGVpAihMSzVlT3tWbJiBILiNbZtu5iIAsaU7UrjIxRS5srIbQf
         lZONwSsFkNp8+V9KqiaSA2Lx2vKi4VWvXGbeGeo/qcSGlyGPPrS247RZgP8cksm2hiqj
         OZiw==
X-Gm-Message-State: AOJu0YxoqlXsriD59Ka/xVxte7Iodf7nMrXIYk4UnVY4Pg0iPYno/6CZ
	e3dsApU2ALvSaW4FH2/x4iQpKNN6Y2BGCdbczIacINZ51p1Wbz42aAmsK8KU/IQ=
X-Google-Smtp-Source: AGHT+IGqRvA1PpFERckVCrblWfrePrqJoXl9W6dJbAp5Z2GnhDji4OTH1wwTMLEhnrLUKmEMZ4plhA==
X-Received: by 2002:a50:9e61:0:b0:570:1de6:8a2d with SMTP id z88-20020a509e61000000b005701de68a2dmr1273751ede.10.1713526727868;
        Fri, 19 Apr 2024 04:38:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 02/44] dt-bindings: soc: renesas: Document Renesas RZ/G3S SoC variants
Date: Fri, 19 Apr 2024 14:38:00 +0300
Message-Id: <20240419113842.3675543-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15653

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9c57c4a9a45c04c19f38986c73847b756ceae237 upstream.

Document RZ/G3S (R9A08G045) SoC variants.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index f51464a08aff..7d75117b401e 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -466,6 +466,12 @@ properties:
               - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
           - const: renesas,r9a09g011
 
+      - description: RZ/G3S (R9A08G045)
+        items:
+          - enum:
+              - renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2


