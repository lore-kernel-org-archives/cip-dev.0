Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C80C27C77
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:41 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.42970.1717769254809842689
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P+RvU8q/;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57aa64c6bbfso2301256a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769253; x=1718374053; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7gXeGqd10FSOY0YwStEGdQXOHlAp7J6DV+O3s14+k0=;
        b=P+RvU8q/tO2e0J51JWRqqcD63QoWvIXN6tMcJfjN2OMaHgNa127sg7Hoz+j7BJsAE3
         lJy70voWTNl5jTcnymRNPfFzt8iLCcYE9FNfEe1Mu/dRpPRysCjMgmb/7McrCMnToEZh
         uNMu4+KJ8jL+obE5k1mU0AOjDmD6lXmK1ErzUBtkBGpAjqcxlAjEIYjE0+hKN2Ik5ss7
         lfPf2Q5ML9MnSj9t5wqDUS67j8y3BqP0QYt+vKREnIcMbBNf3+bhJap2y2cs/OuVs11+
         basywJafInOYmfJmbu62JkJzcHsphamg8VT5u1tNAEybeW7L5ecTIRDNaFtoqYTFhHo4
         N1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769253; x=1718374053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7gXeGqd10FSOY0YwStEGdQXOHlAp7J6DV+O3s14+k0=;
        b=byBLpB7HiE1z9y2lmafiJycK9jocvIocvnJ4crbRD6yNT0ixMZIPKdqMYdK3ldvwhl
         Qga4j4GHnRlMVTnTcV6AvRSzLDFDJmtNwYFXRCHpWdti20zPkPBXF9AjMlCqpfzy+Zzs
         2usRi42HctFTcA4Jvkh1qwfBws7iG3/TKWuVGiz/9vcHSxghmuOcglPDM4m26rfjYtQK
         v1Ef5FytjPLxLWcH3hQnzig67kTpcXM3pvblDHfqkcoq4dEK5aVNLvBGpOuXFBCPL66f
         cny5I4c6b+H5nioWKrTNJnYb4j6H6416fPu9UgSfJdW8fwq8C5xijt6LSEQ/gA4BzE5s
         WgDA==
X-Gm-Message-State: AOJu0Yz9OIbhsLM3E/acDC63ych3ppQEVRrvcQZlW/uUWZnbV9YM4+kN
	FoDUnkIskzXjrUhVKlOqx4f9TV18NY7yMA8t9Xmogs/OD3ZTOEQz1ugVT+5n75M6+uhaOabvJHe
	R
X-Google-Smtp-Source: AGHT+IE4c3qKx0yLYujZ9ETtNACb5pGl1Ba2j8nh9l2cqdh/m8bGlGyNzdAs9k5xFSQLcWbrPbAvIA==
X-Received: by 2002:a50:ab43:0:b0:578:6378:bc4 with SMTP id 4fb4d7f45d1cf-57c508d39a1mr1740127a12.10.1717769253215;
        Fri, 07 Jun 2024 07:07:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 14/19] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S
Date: Fri,  7 Jun 2024 17:07:06 +0300
Message-Id: <20240607140711.2497286-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16155

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


