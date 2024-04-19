Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C43C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:38:50 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.18412.1713526728518955901
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=brOXOE6x;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso471829e87.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526727; x=1714131527; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kriBke9WHp0TXRUwbVlQNHaHTjIcN4ZOIbr5ycntU5s=;
        b=brOXOE6x11/ex3EO5jcXh17nyV5dWtgjk7N/ud7gn6+EqUdsQn2cLo9n9o1B5hzdTZ
         s5cFo+R7Xq1SJgKRFyfxjx7b7ISmON082Pykj+VeZfIJZhr58kAyJLYZHqCo9+dGQrHl
         229x5Xt7xjnyvdPoJ93PLM5/j5Fvajx6alB/Ng1IBhTDKHnS6CRhbFG36xiVQykumTzk
         m0tU6gyhkgxL43OqpIdNh3vYUgZC1jLS/k7lJXPtEE9UR4QHn8JjP7LKw9Ckza9JfymP
         wafUz4kfHMwkWy5exfu2shZphlcDEmKzFS0YFrJhUYKllGsThpiT/b0F7mxHwHF9nx88
         V7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526727; x=1714131527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kriBke9WHp0TXRUwbVlQNHaHTjIcN4ZOIbr5ycntU5s=;
        b=u27hqUOgBVoEVrfBQ2tyEqL7wxV+QGE4hVxQ2R1R639D/+qVmf0lktjMNkZfDcxFyF
         BKUXSqYhk41QnJP2eQ5fgAfI3rpHKM3aaJVb5uEb0XOKvegdeLlX8T+tvHbzzvzVe3G9
         b9/ahlrpEGG3wp0YZM2CAoB3hBn0yMmaBloUhaP4LJY3IXKL+RFsZHLeYpDkoTFXSarV
         1VWfM4VZY5DVNMjiv41Ar3AOo6oSzqP3qsf2Iz5ooSJVB8Suxpis3WB6R24GcMw0QmLI
         lfrMHvUGJHZD/VoN/XPB9NNeVR/deWpUC9i/X0244y5FvRKjr+QbkZqyaoSSKmPXWBXd
         r2RA==
X-Gm-Message-State: AOJu0YwebYAEyevZHeGXeFWrYVB5e1YCVV3WWHwOqKfsd1qGgESILSlq
	7FtI4HuXg+3568xk1uSklXNEq5/9lCIdt622AbWI0H0mwsB8V9Iwk5VRzZEmAU0=
X-Google-Smtp-Source: AGHT+IHSOzjSY8X5dpFPvYr2ACCfEHkxds9ta1wlXd5hZO42DszmvhYj2E7sKGub2EpCaFZ2+PBA1w==
X-Received: by 2002:ac2:4f82:0:b0:519:7392:5b56 with SMTP id z2-20020ac24f82000000b0051973925b56mr1134444lfs.41.1713526726557;
        Fri, 19 Apr 2024 04:38:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 01/44] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3S SoC
Date: Fri, 19 Apr 2024 14:37:59 +0300
Message-Id: <20240419113842.3675543-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:38:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15652

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 111287aa60004e1a58320048c89391056288c455 upstream.

Document RZ/G3S (R9A08G045) SYSC bindings. The SYSC block found on the
RZ/G3S SoC is similar to the one found on the RZ/G2UL.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
index 398663d21ab1..4d32f8160db1 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
@@ -23,6 +23,7 @@ properties:
       - renesas,r9a07g043-sysc # RZ/G2UL and RZ/Five
       - renesas,r9a07g044-sysc # RZ/G2{L,LC}
       - renesas,r9a07g054-sysc # RZ/V2L
+      - renesas,r9a08g045-sysc # RZ/G3S
 
   reg:
     maxItems: 1
-- 
2.39.2


