Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B6FC27C5F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:21 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.43057.1717769358907338412
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=m9NpajpM;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57aa64c6bbfso2303374a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769357; x=1718374157; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7gXeGqd10FSOY0YwStEGdQXOHlAp7J6DV+O3s14+k0=;
        b=m9NpajpMPOiejD6K+sgCIUgOF3S8T7OYNcULQIwUHwJRxmMS3bBzXIO5K8Yd3yjNi4
         1+T2V0w0JCfsq22ASMzCqqjwwuAZErQEhYWSEs3lWYDh5gb1EuOfb9eua5KcCbHnPW5D
         JF8rTeGnXBwuENM0QgwRjGxBhTmeAmaX6F1qb0Uyoi9W2kI1uh7wqM4OqDIRov+XVZjt
         Stsa0Qb632TGIpp4uqNolodKyApMSiFTPRP8j6J3wxMYSCViBK0KOfrADgEVcQUH97T/
         rhK6CVYtMJe2sXFdQSTz6LCcCl/sm3rCtKMLqvNIrq/f1hVIsLs9S3qsHy732rGM8irG
         HJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769357; x=1718374157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7gXeGqd10FSOY0YwStEGdQXOHlAp7J6DV+O3s14+k0=;
        b=iVhBqXigAjPEfjpm/oq0oqSPGFSw+eok/35HVUm2dqtDEBxn7o9aCCwI75fqQDC7Kk
         T7F7nzsj7J37bplZvq5GpyCC4zeh334gcOm51L78RbRjj8AgK2yaEyvGTyX5+mOj+Cph
         yBo7YabSYnpZmqMRASa5jwuNycrt3TSS3D3Na2vsyGszBQ+fK4jFUYy3IO/dQWWdp3qo
         dj07KOAZpoZi0MWmS2LoS/3jhWsQXFiVuZKpviRnhG0noFFI2yzrttz55byLreiRxY5z
         LUOkeaqLCl7IRFIuP6neOM0rtO5H5PZcxw+ZgGRziRH/3z9gqkqATZvAd+MM5tTGWjbg
         WyOQ==
X-Gm-Message-State: AOJu0YwSv8njbRvOf0puQBv2JpEtdzaLHxoFzc8Jm8QGiCgazD9uz8GT
	xELG8si0H7nHUIXBx0vuRiFDAddHbsPPhY1dWXr/ZVs3Un0ppnp12IFxVsgaN1tuy37oASD0lCc
	r
X-Google-Smtp-Source: AGHT+IEbA2IC0CUYV3LkN/uzyzjcu54Xax8xaHmGvDZuOVo8ubHfTS0VwtJAQoQRtrLxgy7n/a1t0Q==
X-Received: by 2002:a17:906:d193:b0:a68:b281:a35c with SMTP id a640c23a62f3a-a6cd6665c69mr168180866b.28.1717769357420;
        Fri, 07 Jun 2024 07:09:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 13/17] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S
Date: Fri,  7 Jun 2024 17:08:52 +0300
Message-Id: <20240607140856.2497508-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16174

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1cf0697a24ef60b3ce8be47090a6e8e79329d962 upstream.

Document the RZ/G3S (R9108G045) interrupt controller. This has few extra
functionalities compared with RZ/G2UL but the already existing driver
can still be used.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20231120111820.87398-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/interrupt-controller/renesas,rzg2l-irqc.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index 2ef3081eaaf3..d3b5aec0a3f7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
+          - renesas,r9a08g045-irqc    # RZ/G3S
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
@@ -167,7 +168,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a07g043u-irqc
+            enum:
+              - renesas,r9a07g043u-irqc
+              - renesas,r9a08g045-irqc
     then:
       properties:
         interrupts:
-- 
2.39.2


