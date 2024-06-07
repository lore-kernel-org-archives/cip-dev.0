Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF9C27C6F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:40 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.42968.1717769252632328058
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=c+56102B;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so2653512a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769251; x=1718374051; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct5GcoB1LMOVfuQmdX2i+yQ8z2Z+wZiLEpC1hTKnWFg=;
        b=c+56102BPKuCFNMiR2JoD8gxeeli4v24tHYvJliewliK+RMo5R+8XZk2kucg6Uvuu6
         lH+U1Rxlo457XiWwwSB6ZMGhNdiJR42KmXmeGYSdv9M2hujZJ2dOd1nHIS5cmWnMl8/y
         BmSv3nImgzvh+dwPDNlRc95ozyyiMX0C/RxAKbeTZ2oO+LZfQZgmgf8uEdqZtbRQrviQ
         tkyVz6y0awrDLMMQMRB/Dz1/SplndVTKhsyczhKVDF6/rmACieg96USzThWgdZq8pkso
         Hijs2kwCjS9xNvXsUjnimTUjmIl0isu70bZcPU1GhCGnKlrRgC2DdHbAxPVaNXxcQODR
         +cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769251; x=1718374051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct5GcoB1LMOVfuQmdX2i+yQ8z2Z+wZiLEpC1hTKnWFg=;
        b=o6A8cuY2Empgv+/cz7bjxFYPWG1dQW8PknNo4Wv9TL8rkoFTvzFxYXN5dctdaqwVPD
         +EmBVoLD5mJITEZSILMfQya6pG+715ZAQeYAFAnk5v20W2h3UFy6xstpfaglg9KenxPq
         wGgaCro2iANF6RmCSALlzVLrFmrJOq1aCPhqMrk2LPaA/cg0XLa5ksc66ZH7Mr6DsGUb
         570DdpHSUFveL4h65b+Ml0peevj5EJOe2SG5K60Ltj9z5fkTU/NxGrOUnH9NnT8rW1+F
         rVigL/UuG+6nmyfR50X/hFepuV2/CM8yNP7Q8CLwVZLHXsN1I5UvAxcG1HpozLV/NURJ
         NrHA==
X-Gm-Message-State: AOJu0YwkfhvhL8J/y/6sF1tYn++nKvsw3h/LHGRbY1hqviFEDgQ453wQ
	UEOpNIjkOjDa/ihHT8zfeRsddMQSUQO/V2vZQ/zr9tn5C9aRNz8kfv2nwUHMrLU=
X-Google-Smtp-Source: AGHT+IFCt7WBEdieRdh8lZY33fJo1dTo2Tfrzj+9E6Um0LqPDnW830J6yxQF2bDCfFHvhgdN1EasXg==
X-Received: by 2002:a50:9518:0:b0:57a:2fc0:9ee7 with SMTP id 4fb4d7f45d1cf-57c509901c0mr1812858a12.42.1717769251138;
        Fri, 07 Jun 2024 07:07:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:30 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 12/19] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property
Date: Fri,  7 Jun 2024 17:07:04 +0300
Message-Id: <20240607140711.2497286-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16153

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit cfa1f9db6d6088118ef311c0927c66072665b47e upstream.

Update description for '#interrupt-cells' property to utilize the
RZG2L_{NMI,IRQX} for the first cell defined in the
include/dt-bindings/interrupt-controller/irqc-rzg2l.h file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 96fed779d3d4cb3c ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220722151155.21100-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/interrupt-controller/renesas,rzg2l-irqc.yaml    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 33b90e975e33..ea7db3618b23 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -31,8 +31,9 @@ properties:
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
-    description: The first cell should contain external interrupt number (IRQ0-7) and the
-                 second cell is used to specify the flag.
+    description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
+                 include/dt-bindings/interrupt-controller/irqc-rzg2l.h and the second
+                 cell is used to specify the flag.
     const: 2
 
   '#address-cells':
-- 
2.39.2


