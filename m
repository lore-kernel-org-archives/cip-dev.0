Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9285AC3ABA5
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:07 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.20314.1745934477233848179
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jXV8foEv;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so1047690766b.3
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934476; x=1746539276; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JAyYNmMpRy11JlEGYh3HuVmCTjPlKN+yj2sF2chmOI=;
        b=jXV8foEvGzzGTorcE7q8kah7GYmN+5qGv7FyO2/vHRWPhzIx6+kK0lNZUkOx5i1ZjN
         /RXD9xc5kQczlLuOyQJracNQW43mhGzrxrBvrbCsnGv/4BkUXdzjc4YnNr2GEshdXBMm
         pfl2DyB08mqF3N3KNU9Agrwjhs+M22wS7S98A1d8ITXLS/VX+B/1/6F3ZYfChmyWj12Q
         VXh84KVp7kpyK/tImUx/ETIEhcedyC55tzwz0DHvulFukZspc1Y9wQjh0TQEcTBkYE51
         DGw9gXLc24JwwNqOJT9EKnqaSGINFLebS/y/h5ONvxfxzmyo748iHsoHspnauuk/ZTbK
         OYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934476; x=1746539276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JAyYNmMpRy11JlEGYh3HuVmCTjPlKN+yj2sF2chmOI=;
        b=Dk0Q4FV66HOYK1fObnhBuCctejDon1cU/tkKqce0cPPoR1RCA/M5lNdFZ9E8FdIZct
         DG8Jpgj//vbizKUU4cgb/t6wGUDGddTrUHOukv6+BHxdFpLzkCFnEkr92xIq2XaBNMTx
         waEJHSaaGBd6VAQyPWp2WUL9PnBcGjk19ozruUd3RT0C1SI9G/rBOoNjWGby7vm4/dj4
         XcNE2hjDlWmPTcLpFLvvKV8+pl192Ff3nu2AFcLDlpvVRHvG8/61EDP1+DEE6v/GcMvc
         8ZubEwBmcgXfz1JQpJzEt1K/Ta3oF7/275HGMVeJ+6nkzaLHga26c8ugwJz9b+pf4Ota
         N/wA==
X-Forwarded-Encrypted: i=1; AJvYcCX7T/5eQWz+L8e1lwLhigA6FTTusKkKByRYFtvTyE6sWUwc7yhqjwUApk6F5xG097TJEQNLPnjw@lists.cip-project.org
X-Gm-Message-State: AOJu0YzxSv2sOUpgCIuEZKup4fG4jH+y7CRw8puKsRymHM1S/r0smiiI
	kXSL6jJ0QEErVgDX4XAxNigp151q/hg7KmjqAHZmEAaOi/mW2GlBy3OJu3dnxHQ=
X-Gm-Gg: ASbGncsgXoriL5EYaNKBb2zYN+Yuj+lRYvqwDu0FGc82doddeWQyRmZJlD1zBX2zz2N
	PGoJcwcjtg5RgeP45xXwd3rjcNHL27XM7eFrLcLUtvGEzDiCOK4fOgHxEToZjpXepi/fjfqmaGP
	YT+jQUG1IH1Q4SmHeORiLTfKLv0L7y7KRHQIIix58MU0BxK7Gp6LpJtrxPVA+z44r2A4lbg8jMZ
	7GRiKqoFqDDTK+1ptasBtFeFFN1qz5WbMywH4TuW4yN9/V1El4h1wJZYjutWPfEcHkT6kKcKJQn
	xVQLYQj9b5Mm/bRLHkoaxx7hc8Xaja1Acgh+2zP7vVCFCQz5Q2d0ZWAuZ5CHmom7YMMCne0=
X-Google-Smtp-Source: AGHT+IFyR2HTcHsOYSFhBQuTMIolwySH3fEbQPNyQ90lwzgblUEISLTw6iW3UX1dBkgxCiiLAwBKGg==
X-Received: by 2002:a17:907:3e26:b0:acb:85f2:f032 with SMTP id a640c23a62f3a-ace848ff1b2mr1245450166b.13.1745934475592;
        Tue, 29 Apr 2025 06:47:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:54 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 15/21] dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
Date: Tue, 29 Apr 2025 16:47:21 +0300
Message-ID: <20250429134727.2429662-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18728

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit caad8883e4202c4ba002b9b1adc62e123f739394 upstream.

Document the Renesas RZ/G3S (R9A08G045) RIIC IP. This is compatible with
the version available on Renesas RZ/V2H (R9A09G075).

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index f3f01ef2c62a..d090efeb659a 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -25,6 +25,10 @@ properties:
               - renesas,riic-r9a07g054  # RZ/V2L
           - const: renesas,riic-rz      # RZ/A or RZ/G2L
 
+      - items:
+          - const: renesas,riic-r9a08g045   # RZ/G3S
+          - const: renesas,riic-r9a09g057   # RZ/V2H(P)
+
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
 
   reg:
-- 
2.43.0


