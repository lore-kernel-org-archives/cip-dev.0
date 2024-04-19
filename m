Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0247CC07C79
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:41 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.18467.1713526776714910431
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mVvmHeeQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso3195618a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526775; x=1714131575; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY1wlIz55MJmJng8ohake8+4usMSV9yT0FIpuQ7CV88=;
        b=mVvmHeeQ9Ld5kuZTzKrzS/Zrr8K724KBmYppz36rj1LxfElf1Xw0/RLu3FeQHqNdcM
         zKAOnqN0QP4buCOJuIM+6H6PDQAW1yWDh+9ykJrCCExgPjV3Yqd4uVOBEk9s9/BzXiJj
         6/zMD8avlqY/Eb6lwwZElGySfa53et99J3jZj0Dq7Gh5S/L5+BXmHT7QqDrHb1uo1Gjm
         huFD9fhj+uPB+1KpbnCUSMsSCxh93oBROsUd+bzseB0PJ95ntLqRWHXmu6Ne2sBij35c
         V0Uwgsg9wmocCFVn6rmkrXk8+O7Ze54bC03sXQiAcn8Rch+CeS9S/EygckFDT2CVO5Ru
         SWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526775; x=1714131575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY1wlIz55MJmJng8ohake8+4usMSV9yT0FIpuQ7CV88=;
        b=L3DtLi2egrY6A1Ct2FjYzluYihyogMBfBFGomaKoQk6/gnCgftZECyx4qGj6i8PLNV
         liltd2R06Gv/7jhoKCeKhZEhdGAiTn0BrAm3FL3HfN8nUpwqpqSDCCeMZWetZHry65og
         JF46t1IxzansfGRTud8H/VAdIKahjzwsJoj/iSQw7j922YqlQZr6IlyovOKRcJ4VYF/R
         cYJkL9alKTKYWn0BNz0Efda5/3Y4Sjba1G2l2aoLzLsmvwLoXV9d8TrbrmdVCKUzBY2C
         GU7r6aoqf/c6W7F5ZIy79m7kuUQjEGU20kfF31FTlMKGFuU8BArcxYzQkdrUtedvyPPo
         hq2A==
X-Gm-Message-State: AOJu0YwO753YAuXVNK1PoABNzpSSQY9HtM1XCHL9ie6UHk1WhYK7lY5x
	sTqrKSGreCO26SYUvY4FfG2u+zmQSiU/YbWCPPMQp6sVUgj4Bh2hJKjgiUJApApd2ROtR0QCs5+
	n
X-Google-Smtp-Source: AGHT+IFKHob19zq7oSccq7hgI/+DAlKZaVl2P1bs8VmbncuKnd6AlZ9+6jGu/GzB/dNSoRKMu8W3Cg==
X-Received: by 2002:a50:ab09:0:b0:56e:6e0:9f39 with SMTP id s9-20020a50ab09000000b0056e06e09f39mr1276344edc.17.1713526775144;
        Fri, 19 Apr 2024 04:39:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 34/44] dt-bindings: soc: renesas: Document SMARC Carrier-II EVK
Date: Fri, 19 Apr 2024 14:38:32 +0300
Message-Id: <20240419113842.3675543-35-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15685

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6042f5365bee167ac27d02454f5cba403747277a upstream.

Document the Renesas SMARC Carrier-II EVK board which is based on the
Renesas RZ/G3S SMARC SoM.  The SMARC Carrier-II EVK consists of an
RZ/G3S SoM module and a SMARC Carrier-II carrier board; the SoM module
sits on top of the carrier board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-27-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 42753f4f7442..4eee12b5d67c 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -478,6 +478,13 @@ properties:
           - const: renesas,r9a08g045s33 # PCIe support
           - const: renesas,r9a08g045
 
+      - description: RZ SMARC Carrier-II Evaluation Kit
+        items:
+          - const: renesas,smarc2-evk # RZ SMARC Carrier-II EVK
+          - const: renesas,rzg3s-smarcm # RZ/G3S SMARC SoM
+          - const: renesas,r9a08g045s33 # PCIe support
+          - const: renesas,r9a08g045
+
 additionalProperties: true
 
 ...
-- 
2.39.2


