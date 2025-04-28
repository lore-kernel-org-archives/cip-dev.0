Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1351C369D9
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 05:01:54 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.40931.1745816459929047297
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 22:01:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=I+Yayi/n;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso6586073a12.0
        for <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 22:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745816458; x=1746421258; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLK4FWi3z5/ERGW29Q5WBQ7D/yL2ySlqFQlNza1zPm0=;
        b=I+Yayi/nL/Vx7xBDLlDs1TLYbsW2tzCWYcUW498Cj3s86bCuRxlQ/N/k7MFlraewvL
         I2NwhPw/NPsU142NPy+DY9rBqijDieiupc42miMqd5ULvobR5b8c8UQvOuSTFly7Crq+
         BXuQcCfzDjXuTpML9IfDlaojrSH5X3x2gaG+vDJhq1dJHT3/rFoqrNxWdoIQflJMPLFn
         ssJGGCSRG+1vAIJzU75RLbOWsM3VW5lkBmFUy/G1pOY2CbUSbDJZ24m4HQH7pUuWjyAi
         R+krobgXFPNPIR4tmo6bwSPeS3b+4Sei1gkrZfYTvn8v9GB27qY94Uf3ows/pVIeZhpe
         UNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745816458; x=1746421258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLK4FWi3z5/ERGW29Q5WBQ7D/yL2ySlqFQlNza1zPm0=;
        b=ZDDOATVtwNZUslvh9CkAdJ0RNgu2MOH5hzWVcRc+ZReV5Wmfsi6VSemaJJKNUNOSYn
         hOxeMuCTq3JePxnvpLPcZvrzweMldLDS3cUpZAS8wkf5PoTvClLi/YruqqqXLXi39p1T
         vikRMqg5Jv/Jz0OQPIoKQ6/Ih8I+w2Fsll2laioiLuI2ndffpaFEit16PQGIfHd+ROQs
         KPjBNexFs4gpQzkDNfz0NCGGRxsY5BctGkVoc8h46k/PsfSea4jCYlO8sCmbAdFQGQpi
         KmFabCzaiUhkuDlCvmQnT4EwQHexcDDrusO0MeZmLklCDAlhUDTgvtOHajQqIxFRQQkA
         MPGg==
X-Forwarded-Encrypted: i=1; AJvYcCXZxQyzNKCGQXaXD9XHMhAVvUSL1S/3GMrpduHGcS+D/n07FyCQhHy6mRXygXjLHY/GWRNml8Rr@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz/5jOosxQ8ZwRGdqZ/E2e+RPuHbpfODKzU9zMYUYU6Su1gkutM
	3VyEFqNPM7QM8Yk3A+luWvymLa95OrROLOMwyWQTugHx9I3AoyQSi7CzPXTnaGoc9wm15owYKGz
	c
X-Gm-Gg: ASbGncuTsBLU6Hq6b9t3UeI5Foy2BjlOUnhHzMgA0v0am4po8xmAsJJllWYQzS77wSX
	33+0OPhxHv0q6KgIjt6t+8bbZWnXVm9glp7ZLytGpJT27Uld1t7EJ6HSLRYPGGFZddYvP4tbmkE
	0Y8ilCN/fFslcGh+TpUZo6tKOHh4yz8U1lTNxAkbk8A2bhlXVwl7ljShVwVwTQq/sLvMHPGOMBR
	vxqmkn2DqFgYo3wYP2sDw5YXvP+0H6cd+3r/CnsqDZA6PkNUusJBV4lHuACDfUH9mabdZiW0nd7
	w0VDo0kBApF/yMMXxTx2zkYVmeGeTZ8ZuegaS97uPhEjc2JHfGONp8edvNJdjxyK0HgkLVA=
X-Google-Smtp-Source: AGHT+IFIbZPr+kDi07B3KSnXP6Om3M5DshVshbxEKJoa+1Pfe7B0G+yXxyVKbEp+NW68oMBzm478pA==
X-Received: by 2002:a17:907:2dab:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ace71098cb6mr1092891366b.19.1745816458292;
        Sun, 27 Apr 2025 22:00:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7011fc361sm5176645a12.16.2025.04.27.22.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 22:00:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
Date: Mon, 28 Apr 2025 08:00:50 +0300
Message-ID: <20250428050051.3081705-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 05:01:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18671

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7492b2f89cf6d83e2a68400c43be25bd8d4cff4b upstream.

Document the Renesas RZ/G3S DMAC block. This is identical to the one found
on the RZ/G2L SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240711123405.2966302-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 7e472f3d6087..6e7b4b6af0b0 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -19,6 +19,7 @@ properties:
           - renesas,r9a07g043-dmac # RZ/G2UL
           - renesas,r9a07g044-dmac # RZ/G2{L,LC}
           - renesas,r9a07g054-dmac # RZ/V2L
+          - renesas,r9a08g045-dmac # RZ/G3S
       - const: renesas,rz-dmac
 
   reg:
-- 
2.43.0


