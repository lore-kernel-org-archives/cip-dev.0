Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608DAC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:26 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.8645.1716970276041530704
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WWtR0IkT;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421087b6f3fso15309315e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970274; x=1717575074; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuC1pmed93/VuJSLGFO56pT00C9lVNQIsULD3rUi6GE=;
        b=WWtR0IkTT8naMwNmhcVe4j52xjL20Ppr40wUeJn7bDl/66AK99JQrxRuTq7VsVeIXx
         v32RWz8C9Wq6M91tuM5CmN8F/nKCPulgNBvosAms+BoLvqyOHv2alfAnXBHB2fTTGfKv
         akoa1yR60stcZzWfS8RFDQajnubPLA1CdWXfR0spI78dWzBrMdXI3R41uak3pG8EdVuH
         YQWsOW7hcHViaA+fvhGlwMbD4RQrO771NXg4unHmlUHfXiRBafkIxd0Qoff86X28vm/U
         Xts1HI9V5Yzc35Rvf9eSljxQZDEi8bTh5ReRF3qfY3f/XgY2TXRuSogk5oKeaQO1OM+j
         OyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970274; x=1717575074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuC1pmed93/VuJSLGFO56pT00C9lVNQIsULD3rUi6GE=;
        b=DRkOHeRJ04MgOEFjDi/295hu5u+TCYtKiPB6myBsRmalv9tJzcIXWoD6FqRweMkrH/
         E/np3TXozyQsJd7daCkMMFUOz7v7xjXEyW09B/bBIBDlojgIACZL32S01attzigqioWf
         1e39vc/2AcBOhjlNy5qGxOaVV+O3dO80BDeJ5Qx6qAYmy90MjJXEoT83XzPtS5L7cffN
         ZNZ8DSB/yrMAnwrZ8WhX+FNTckZt5Kva4ley994Kp3KOlvie+DiPxNk/Pfa+imZm+ZUv
         CshOuzoxj5mVJMNr9CcRpRrzv3iNKrZ0DousCakyiufkgz6MWRm56cai05Zd+s9LR1oC
         c2yA==
X-Gm-Message-State: AOJu0YwwSNZp2VKKlSsDanMBYBok1+0PF3vJMR8hqkYxIKO7cYBjoWWf
	dYkRA+w9zkCfvsC0C84rSHbeOl3927w7tghFexbIWUJUTj2cBZHSTuT/OOpIqeA=
X-Google-Smtp-Source: AGHT+IHWpQlwgZokPgaKKtKVfljkI2E8OSy6cZp0yTPDwRUEB34wysNWxD705T/80/pl+V9elmVamQ==
X-Received: by 2002:a05:600c:21d5:b0:41f:ed4b:93f9 with SMTP id 5b1f17b1804b1-421089de9f0mr114843025e9.19.1716970274553;
        Wed, 29 May 2024 01:11:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 19/47] dt-bindings: net: renesas,etheravb: Document RZ/G3S support
Date: Wed, 29 May 2024 11:10:11 +0300
Message-Id: <20240529081039.639010-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15999

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 060baa9b90d4e14eac7123abc563070dd30b21a2 upstream.

Document Ethernet RZ/G3S support. Ethernet IP is similar to the one
available on RZ/G2L devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,etheravb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index 846ad0352c71..d302cb12babf 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -52,6 +52,7 @@ properties:
               - renesas,r9a07g043-gbeth # RZ/G2UL
               - renesas,r9a07g044-gbeth # RZ/G2{L,LC}
               - renesas,r9a07g054-gbeth # RZ/V2L
+              - renesas,r9a08g045-gbeth # RZ/G3S
           - const: renesas,rzg2l-gbeth  # RZ/{G2L,G2UL,V2L} family
 
   reg: true
-- 
2.39.2


