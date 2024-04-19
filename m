Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2220AC071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:51 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.18472.1713526786544757054
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kgLpesoY;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51acb95b892so398680e87.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526785; x=1714131585; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R+UmzW4uO4Wz7m+wRKRRHfO4GEbAXwsuAxZn2mclRo=;
        b=kgLpesoYxC22rZh1y+vwn1O4sThZHsFwlIqdQYwntklIbgwXUhrKr4X2efg61uicNV
         xLTlaqCxXF4QCdFlzXDm54Nkh9VG9wOM8q2KzKH88G3mSNbHlg62ZwdEjndG5QwZRj3n
         A58yKheFbPJuEEvg52bKyvXcIz0ppSD1SEqw88NCi7GK/rL8aLVKGbDQu6WiZJNate99
         y+KkFS9QJ60BkVf1TMx/zIzQclYVo7+lsyn0huCP4bfy694XKWu9KLI3LYLCf/ixfM1r
         P04tvxp5HVeKfLPxSqxh6vLE9pzUbfey6twBIl9C9b1JffmaHcmdTYOmXpdu2tcd5310
         7zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526785; x=1714131585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R+UmzW4uO4Wz7m+wRKRRHfO4GEbAXwsuAxZn2mclRo=;
        b=lHHbtRIJnASw0PNZP9ADbMEVzjYUe2YBnOSdSfOo66tkLTKkf7Q05mPhhHQD7JAO3I
         IpivgXaegXpsSfDZvYR1zUWxnt7MvSXedlG+w32NusS9eAr8YIcyNAET5bKaEOYWHfxS
         J0WEfNmMwXCtFYA5WYh3YV6ZmGrFfwHmb4KKjvrjU/4qDxrr9+XCJu25SYidb6PoVQ2p
         tJ5d0tJkKx68HDGBoTNUzi1Qv5OzdNrQJ97Zjt133CwEOAo3UMY++6BfV82EkbFCx4IA
         utbq1O3szKyygj3yvV4hWCoIbS6TH9a+WGhxqrr9hYMPN365KkojDa/LVEr2FK2Ehz38
         ZcsA==
X-Gm-Message-State: AOJu0YywOEWCWpNDGDnQ/GwGbb4pPwPNsnhH2ptWa7qXNiVao/sVc1dR
	W3mi1RT6PG2WjKb6OfxEs7gYy0cz7gsH27hM9C8JfIBgYY62FgjOJRu/i2RDrRKIk2pIVqHTPAP
	5
X-Google-Smtp-Source: AGHT+IFGjD5k+TWUEM62WBNFQHIO6Kce70uq1gAoZAQZzUywfL8C3dVhNlOvIRGIRTj0Pvth/xKvow==
X-Received: by 2002:ac2:51ad:0:b0:518:b5af:5f64 with SMTP id f13-20020ac251ad000000b00518b5af5f64mr1526783lfk.46.1713526784745;
        Fri, 19 Apr 2024 04:39:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 40/44] arm64: dts: renesas: r9a08g045: Add missing cache-level for L3 cache
Date: Fri, 19 Apr 2024 14:38:38 +0300
Message-Id: <20240419113842.3675543-41-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15691

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


