Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB09EC27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:40 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.42694.1717769251317467971
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=g19WjkYe;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so6147812a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769250; x=1718374050; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uPFFQruZPnp2jQJxy3Th1pcvd3a5i3jOHVQ3IbF2dU=;
        b=g19WjkYeS23QISLhopJg4N+rahiVtekldOHdmq4CV+Gajn5Rq/EJ5oV8WUab7INjDa
         /k76e30CKf41voc1cB0PR9dO6HRUZ+sOssvCyzWtp4zFz96BTf8Ihi+17qUYjvBDS/M9
         ot6zDvxUU37armB0hXY4IsEu6EEZptqRuguNqSGV/X2MqcqeRYR/HFniVISi45tZNilm
         BwxoJM+3SBhRJm+sXHBcUXdEBd7fYFpf/CE6E9SKN+Qo1+KnJB5gHvjtlcxJS4dkY8o9
         adNbpgMzcYiUH/xkfXkz6SX7I2Dq3Auai5NRdLlymu617obXkrTLpSvneMRu1tdGVXCq
         PC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769250; x=1718374050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uPFFQruZPnp2jQJxy3Th1pcvd3a5i3jOHVQ3IbF2dU=;
        b=mDM7LpUPyKtz89NHk54qwHlgxZI+Fs+3qVv401WJURaBa1RmOheJ/kVkqdJVp8AvRm
         po3LpMSPZ+5LeqTkfR6tttw/q3eLPkxh73En5wOkEl9vecIKAg4zN0pT22JH3/6MOMpA
         Pk/YySuBntV7idk92ak5eNif8FepXNwrYh11NwlamRAPjLSZwTENcxyykRsrx6LjVAMw
         dMDRHqodQXEwqeqp4ST272eLzQD6erU7VWrFlbG4DvQiPa9AoQ11ErF/fsLy/8NSaOcG
         MC13HcGrl3sus2xmzIOVBv+oNB21nQbMb8g5VDdAHrzvgt/h2gi7fITEbjAn1ikbP4ou
         wNqA==
X-Gm-Message-State: AOJu0Yy3LLUSJq29y0TGTBeGG3yLosfgjNhWClo3SQrlvvE1mWaJKwni
	i5ALHBNcfFRDlQotf5Ge/GDZTQJmAvRQeNneXS/t+wwnLrQgql6rBBaE+F2LQmE=
X-Google-Smtp-Source: AGHT+IEjSq+H5uJ8qau0o9d0icDKE/p+YHe2JEbDq39Z/AMPhhzdDLlHQhIp9Eghsj4NpFPnP6uqCA==
X-Received: by 2002:a50:c2d1:0:b0:579:db1a:558f with SMTP id 4fb4d7f45d1cf-57c4dec9a80mr2264618a12.7.1717769249517;
        Fri, 07 Jun 2024 07:07:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 11/19] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/V2L SoC
Date: Fri,  7 Jun 2024 17:07:03 +0300
Message-Id: <20240607140711.2497286-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16152

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8cfc90ecd33e73f4a30207b316bc6886e3c3a166 upstream.

Document RZ/V2L (R9A07G054) IRQC bindings. The RZ/V2L IRQC block is
identical to one found on the RZ/G2L SoC. No driver changes are
required as generic compatible string "renesas,rzg2l-irqc" will be
used as a fallback.

While at it, update the comment "# RZ/G2L" to "# RZ/G2{L,LC}" for
"renesas,r9a07g044-irqc" compatible string as both RZ/G2L and
RZ/G2LC SoC's use the common SoC DTSI and have the same IRQC block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../bindings/interrupt-controller/renesas,rzg2l-irqc.yaml      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index ffbb4ab4d9a7..33b90e975e33 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -26,7 +26,8 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g044-irqc    # RZ/G2L
+          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
+          - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
-- 
2.39.2


