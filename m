Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B31C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:19:08 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.15294.1713514739682496338
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:19:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RDp8HpaA;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5561b88bb3so187549366b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514738; x=1714119538; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R+UmzW4uO4Wz7m+wRKRRHfO4GEbAXwsuAxZn2mclRo=;
        b=RDp8HpaANXCCrPDIz7OaQpQKSxiLotXMxasmvj+/coShwcgFnVjcfmmcM8UvYZ9Jor
         RlbYR99tYaXrZaYjli+1Ge5raY2uJbZiZwkTLsEsHo3oDii4mZJleIEFbn/QYG5RslTH
         KWh5Hi1PSaqNy7qoNzqDL5NkK1IeL6RBv89pDOJnYb51M7f1NzWSMXxYl4Hab7K1FNoc
         ddwBRvOdmsiy+jshILbEGBsAzC4UBukYOOSTWMiw4hbPlOTgzKwNoaMTgDSBMxLpHweL
         yiuJTLoPc7YloQocBi5rF1NnaZ8fs5pFtKbxt76Efnu2e7BO2I5U5o4cwfv62E4QFtf2
         05Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514738; x=1714119538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R+UmzW4uO4Wz7m+wRKRRHfO4GEbAXwsuAxZn2mclRo=;
        b=dxJBPtXqONktLTLJZB0dQnt+UozKR70G0NdkcVY4Q2Vd/h/zD9Pm0pV0DKrxbrU7jN
         wKNAJ87Pj8SGMBbgba79pGQdVc56hLEgFYBxLNQw21z8C94bzo2+NG1d/baLneJVNySL
         lHUGHSTUQdv3z3dF+SxgTmtHWg13qDsZK0XaJoNa9jEeBOUf6qSGuWZrLNB9MwiNLa5j
         JxDzR0PGY7vx3YOVwDVEQ6YpOlvW7Ff6g/sRQmQrc59mVnY8IEAnQEasy7U/ImywSTsc
         dlKxBMAq2GGWAMk+JXYdNAiMdPEPO5Qi/+Ijbqfrv5ihUx3UyGzVzBAi2Z+C0PgbgDD6
         +T3g==
X-Gm-Message-State: AOJu0Yw9b1IDUg6H2p3AhIqghfHQzx6UY/f11deohl6sfofG7L92Lkd7
	WO544VvftHkaZyLwUJSyZcEkZ9yXQOB1r91WPBwNWRMO+eYxDzQmA96mFihatLw=
X-Google-Smtp-Source: AGHT+IFAgMf5HxLLeUfysYWjAa9Fpv9bpHBFK5tsVWz5RIEi2fGydJQXNrF4UzchpCXuz0By3S3b9w==
X-Received: by 2002:a17:907:7f22:b0:a52:572e:729f with SMTP id qf34-20020a1709077f2200b00a52572e729fmr1579279ejc.60.1713514738165;
        Fri, 19 Apr 2024 01:18:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 49/53] arm64: dts: renesas: r9a08g045: Add missing cache-level for L3 cache
Date: Fri, 19 Apr 2024 11:17:38 +0300
Message-Id: <20240419081742.3496709-50-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15636

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1d071ea156aaa5942564282d69866596b6de95c9 upstream.

Fix the following DTBS check warnings:

    arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: cache-controller-0: 'cache-level' is a required property
	    from schema $id: http://devicetree.org/schemas/cache.yaml#
    arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: cache-controller-0: 'cache-level' is a required property
	    from schema $id: http://devicetree.org/schemas/cache.yaml#
    arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: cache-controller-0: Unevaluated properties are not allowed ('cache-size', 'cache-unified' were unexpected)
	    from schema $id: http://devicetree.org/schemas/cache.yaml#

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231010132701.1658737-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 534b728a8e14..6c7b29b69d0e 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -29,6 +29,7 @@ cpu0: cpu@0 {
 
 		L3_CA55: cache-controller-0 {
 			compatible = "cache";
+			cache-level = <3>;
 			cache-unified;
 			cache-size = <0x40000>;
 		};
-- 
2.39.2


