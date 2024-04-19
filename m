Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7EBC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:58 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.15319.1713514728356662913
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KX0FlGjy;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso2715260e87.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514726; x=1714119526; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yjeEQQU5UbcsKcDF/bM7rzYtDeLoSfFhMg8PpgTF60=;
        b=KX0FlGjytRzZaefriOd/+sqBVgEQIUh2d+Vyq34u8EA2EWt86Zi0DNJY27u3yssjYF
         /ePHxuWGrwizvezGBme+OF7zgt2n/PXQ93drubrYLnoI2OTmJgeWDlZI9Q3j059qXQrz
         kAcL4+yhTGLlZd35D6YJOxsMyD2nmaAauXAlGuo3yMleklRJ4nHMG1sfPh0NDq39fokO
         txoJyPolewm0YJGVv0xFx7MBrJ/1pPdJpAU8MfL+oHtpV2bSpu/eABwYuEup0HzNYI2Y
         mp46spmzJJBO2vMVW5AwPyA6/oN7KqMlr4J3rGI3hSqy7EI7N8R47FuFmJrnoMxoR1Z/
         kKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514726; x=1714119526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yjeEQQU5UbcsKcDF/bM7rzYtDeLoSfFhMg8PpgTF60=;
        b=Rthm1GYChBxTc2X183StM4PK5iztzaYrXAnkBERQsKXfuBmQteL5VBSemszBn3+iVl
         6nJ9Jw35u6EC7DPjNeigXsyypR1wrCwiipf6bceCFS97gPph0kzMZGa80/u3eFc8h2z6
         giH48FMxfsZazUZu42ZG+1b92y6XEqnLoEqDv5uzzJW8hq8F6xCThxhjokHdIG7vFTXX
         MwsOUqo2ywlnDlL9f3VXWqIi3hnb0IBwBUO5I6z5ja6gDnswVy4iYF9Q6SSnSybxxGwR
         sOTrtV15Uav83dWHbcCZprJ51JZBFwpVhwVZUcyMl2cjSP3/DwjZzkVlrJdU1AqZULqR
         RuLQ==
X-Gm-Message-State: AOJu0YxdRnWerWAmdTcvoaSy9pWMa3719HtI/6Dn02exz5YW4S5vqRmP
	VoQL+wHCfDnzMb4Y4WT360IEKfXD3ov/ZmNC8NWihR55qUh53aYLkjD6djmOFtA=
X-Google-Smtp-Source: AGHT+IEvoSLMxLtsMoVmcgLtYvFEg0lp4pAym1SoTKoYIUD1VxY9ezGjohy/NXcME9mvJ/XnGQYc4A==
X-Received: by 2002:a05:6512:32a7:b0:516:cbca:5c9a with SMTP id q7-20020a05651232a700b00516cbca5c9amr1067485lfe.9.1713514726519;
        Fri, 19 Apr 2024 01:18:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 41/53] dt-bindings: serial: renesas,scif: document r9a08g045 support
Date: Fri, 19 Apr 2024 11:17:30 +0300
Message-Id: <20240419081742.3496709-42-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15628

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 8e3c825288c6a091e3e80edcebe746b927dd1f73 upstream.

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/G3S (R9A08G045) SoC. SCIF interface in
Renesas RZ/G3S is similar to the one available in RZ/G2L.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231006103959.197485-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index cd2ea22b0d07..1b1a9e586361 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -72,6 +72,7 @@ properties:
           - enum:
               - renesas,scif-r9a07g043      # RZ/G2UL
               - renesas,scif-r9a07g054      # RZ/V2L
+              - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
-- 
2.39.2


