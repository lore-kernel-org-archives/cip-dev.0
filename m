Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32245C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:15 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.10353.1746783305136353486
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EMfqPKQD;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so221016166b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783303; x=1747388103; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iun09y0IT/d9FNVVRKVLZsVKN/IxkDzK0zGvl755C6M=;
        b=EMfqPKQDgGbxP/hgocaIA+gCwVqWnlYWzFnWvCA33aazDPH4F46f0MEJTYADEEavEP
         WmFh+BX52lPSwLzfgzYM7Eti6Md03/D03McsqzJ9mZ+jIHh95TG9DzNZtPZlQRTZWsAC
         FR8J58oZndmSY1sEnaZQ9ngVK2oU73n8++AXnaNdpxLD0CsA1oT+XKqa2nGoVP4RJ6Cq
         ig1qmwqqaMdxWxpj30twMWzpUL8M7nz05/FFhIX/pYLfhIohiWZg/VE9vBUJMS2yVzUs
         e06ADr6PpuxnVxU96yOsQYi09G+PVBo5pyq/5CygHSoIL626W41aLT2/X51r4AM9mubg
         y+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783303; x=1747388103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iun09y0IT/d9FNVVRKVLZsVKN/IxkDzK0zGvl755C6M=;
        b=I0t//YK7F2mTY1UJIxU6qrdffP077Ispyx35Lv4sjpVbw5BRQSwHjr8vFigLT1GI6J
         xppZ7zj6ybEtu6L6Nv0vmZRSQXcRsMPTwMG/XWxE4C8oJaPtd9CBzul3Z5auNIZZt6LA
         SL4DdHcioEDRdCTb8w3mgBI2qAkBYws4d80gKTKGmd8NH7/AjBAcUvruWA2+E0dciZO3
         0bS8pYdylDAL5oiNZguu2+IIZihrLkO6hWI4cMyPA/FyRo/FZ1Kt/2oKtzYw0NFxzE6w
         2ZC1AU6OkZ1C40pvuHo8R0zwLLP4UHdVVZYpvCSFHbznb1aJTBFMpNjUl+/zBVE5qRrM
         CfRg==
X-Forwarded-Encrypted: i=1; AJvYcCXkHAVWVwtOs5zDUdmMbkoVki564merr9Scb5FJGg2lbo+lxIRkS0kYauvyzGRGxZAvNh5pEvSX@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx61LXzn0NUcJL8H15bpInrUDDEmA4o+Ds222htsOJKGs+8wza/
	JQaIzVMp0rnHD6ebn2ZCXmWvTYeFLI/2YJI9Q/CP3DLW08ChJgboEbZSMdP02vI=
X-Gm-Gg: ASbGncvYqmlDwPciCGsAHgf9mLm9Uz7LaAKrdFnYzzduWcRnGKDh8yudit92MQK/Gx1
	SoA95nR2nAJhLU96iKct99IfP10bKSYQtjLc7uDpIoYSqceQf9DrBLtZpJnwcwbZLcjhREO7p9G
	hyIKTU8dROvZ9MzxI6uyuEoQTB+CUO1Ja+eMLtNHEpceyy+/NpVlJGWAGkSzbDMTgB3XlqbiQX8
	nnh9RwL8AiKXsyAVgcc8856JZQVlRItEa35iCZ1IKmUBPPq9XCeUBFTBDkDsNNczKA2RaW+08Rl
	iaZaNS+JtMpdDROXwjjQSYV1JfESYbbqbRE73NPZ2y/YAEYNPXnwH2Vr6bmyA0bgHmSYew==
X-Google-Smtp-Source: AGHT+IHdiEV2dMu5sjCC7Rvu4lWz+jn0ICT3q9QUbBHQtUrXNO3rXEUlbby7QdeFLaO41O0u4X9ZZg==
X-Received: by 2002:a17:907:7d88:b0:ad1:a87d:3de6 with SMTP id a640c23a62f3a-ad218f2c720mr277557066b.4.1746783303440;
        Fri, 09 May 2025 02:35:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 14/37] dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock generator
Date: Fri,  9 May 2025 12:34:19 +0300
Message-ID: <20250509093442.4015145-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18866

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 626b77735a3712b02dabb25be3a0abdde6696bf3 upstream.

There are some differences b/w 5L35023 and 5P35023 Versa3 clock
generator variants but the same driver could be used with minimal
adjustments. The identified differences are PLL2 Fvco, the clock sel
bit for SE2 clock and different default values for some registers.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20241210170953.2936724-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,5p35023.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml b/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
index 42b6f80613f3..162d38035188 100644
--- a/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
@@ -31,6 +31,7 @@ description: |
 properties:
   compatible:
     enum:
+      - renesas,5l35023
       - renesas,5p35023
 
   reg:
-- 
2.43.0


