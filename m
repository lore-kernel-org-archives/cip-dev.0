Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4317BC43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19071.1782820126349305316
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=keMSn3M3;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso396904f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820125; x=1783424925; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMHBGLjnAIwAZotOeHm2vXRlgmaVnunRTPLtoOE0zY0=;
        b=keMSn3M37C/OOaI5v55tWLIgSkYsuV9M/m7s6tUHLDfHrnLPAqYGaxFwxqRDIIHQe5
         0eQ+Euoh5mTZA1drlF+bnjAyb8ezC1sJ/ssJuWnkRaoS3Yv9geaG3erUtycToHbYzqh6
         XypddRDG7cBc5jkA5LStWt1MG1g8OCM1fgOeghRjaGjierhYaWxgyLY+2blubPTtqcaw
         2GTi4UXT2MgfGQ1Tn/n56RWPx02RIH/S59tgCLpaGPu2L0lEtYNGQuklfBrx6awXBn+C
         pqI4YWJ3Xtz7o/ymWIkabJSxCZcFgYZEYTppsrThxO8Mky/1WHQxxMpfauOR72wR1lIJ
         tscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820125; x=1783424925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMHBGLjnAIwAZotOeHm2vXRlgmaVnunRTPLtoOE0zY0=;
        b=MMT7k1/4dJ+nGf+S6KXQ5X9Z0+p8EgvIM2Gx+3/FMbLnwQkCxoqUlR9vcoYr98RLQv
         Ctm+31UWAGTwqJQ1txBT0cVBjZQDp0NYXscKdsLIzP92TT4wm5088+AbzG2qdsxfZjKL
         4TpDwVqE9mA9kFaX0mzU8Hql4ffS/Dd5ChI95ITSNOLUMj1Tmn7dncqWk9pVz+jiivAo
         vk9YYM39o4rkcupSbrOinwtn32XqbBq7ABVQWFMiSYn0sHHdUcOTkhVdds7BnqVNrgn3
         O4HRT7qtqEsulcYOd8VSCwKslMCrEslBdvf1JuhWXgN7ydritiXFzM02TOgE1Pbup89S
         y7VA==
X-Gm-Message-State: AOJu0Yw0xO5C9AD/ZNTvBx7s+je+wmV48tE2Qb0kWmLW7wsN1Xf3WjRQ
	tY8aAyo8ONjzKnw3lLOuv0j56WDyg7SqcTzVo0dPnHES6iPlL4TF78Pu9YVxwL1k
X-Gm-Gg: AfdE7cmiIovjnz0q17gkNlb2xHiNPZsNpa6NMeG3FtIXSLQwpQdM7YERGZgbZ7OR/p/
	Cd/jswdug8zW/DKtnp2H/0ld+42W//1xtwGnYW/bKfOrR9ziG0XhFo3TzTpzKqF9hdlTqM7n6FI
	5yKIPHvIlAXUXJcinKZp788qeunzeb1ZatyJFr+G1igq5aQe2NqJgvtIql5EBHrVsfZRPtHNrzx
	89bS6hlUTB9rpdvJpqEPit8VWT+QqsfMdcX/YoJa8J5LdWTHivMmeKmfM9tEIrA+02R6iQgRmY8
	Et13PQ2WB+82+A1x7S+t/mNrHZOCLHB6Jy4VlSlnKN+FksAWLOQWR0Ump2/vF15kd4Vac4PPZIW
	B2E9H1sXj+/++ihevNnBsctHKROHf+JV/JQ5Cg+y6GyGn+LuwiMbYr7Q9s6f3usLZIWdu6UMDNv
	KnVG85qZTL+52yYWloe2NeNDgeR2+wY7fizmANsQ==
X-Received: by 2002:a05:600c:4fc4:b0:492:4363:e7d6 with SMTP id 5b1f17b1804b1-493b82c14dbmr49030515e9.37.1782820124573;
        Tue, 30 Jun 2026 04:48:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:44 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/39] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3L SoC
Date: Tue, 30 Jun 2026 12:47:27 +0100
Message-ID: <20260630114813.92739-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23332

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 3ac4e6b92fc200e047d13aae06224b2a72539b9e ]

Document RZ/G3L (R9A08G046) SYSC bindings.  The SYSC block found on the
RZ/G3L SoC is similar to the one found on RZ/G3S.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260203103031.247435-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
index 4386b2c3fa4d..94ae72eb8fb6 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
@@ -24,6 +24,7 @@ properties:
       - renesas,r9a07g044-sysc # RZ/G2{L,LC}
       - renesas,r9a07g054-sysc # RZ/V2L
       - renesas,r9a08g045-sysc # RZ/G3S
+      - renesas,r9a08g046-sysc # RZ/G3L
 
   reg:
     maxItems: 1
-- 
2.43.0


