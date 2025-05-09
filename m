Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B654C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:44 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.10294.1746783217407709592
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BPefzj8T;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso2965627a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783216; x=1747388016; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iun09y0IT/d9FNVVRKVLZsVKN/IxkDzK0zGvl755C6M=;
        b=BPefzj8TwEjSBS6RrIjaZGKpWwZIXl57CP4NRN68kuaaQQqqbIH9y7wcVg0Ggm8NaB
         mGN5Xr/GnIG6IXF1tOPZ+VN69Iw5CZt50iRa4MZDNA1pNimi3L+x2mj4PjM4d/6AYObA
         7uoaqFEY6e4/D37/qiZKOBgvfLUh4oqlcEp0j0aqPuRpBO+BxidmLMJO25q61ulRkSmS
         x5V1lPRbdpfedAawriEsybBWLd0wulgDNNJtuWbHwpjDzPJk4fbR7GbBfDrH7Dgcyya1
         8ftxIpc6c5yxyJj8Zu6l6I8n33blAqBQDjVcHszKbX+0x9C5ZVY0iB/oeYSwNYc/SsiK
         /7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783216; x=1747388016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iun09y0IT/d9FNVVRKVLZsVKN/IxkDzK0zGvl755C6M=;
        b=JJsKSb7nnQJ8HasIJOdwLFzttyePgNYIk5NSh4eK/Qx0WABuPtpA4TX/DNCXCIBB5D
         OiNX/x9ic3ZLyKecDnmfLk4dKqQ9S7qwtMOvktLLwGh5DPCgUSBIkCpfjDfGG9nLN6S1
         CsI4lCXlN3A0rHmGHCv/u57hInl+j9fqXzisRnWRU59EE18LWCvAYKP/X4ykmu7hXMzW
         pezGfMUjMMDGls65w+3txvi4UqjNoBUMhMhVbfrHfGnTytAew7x5qZFA/FnOAafGX8dN
         9L1ervrPlNAbVCIfU6II2GVsmanBFzSq6AgR+IIx2s11Scd+PGJtsIeTZ140076jyOhR
         DA4A==
X-Forwarded-Encrypted: i=1; AJvYcCXNtJ3OduBsZSxRWX8YddlhmSx883di1vNMlVbKKuATI7HYJeo2DgT9NJYGKTXMnVBKzDyBxm9k@lists.cip-project.org
X-Gm-Message-State: AOJu0YxEwMhb80fS3UIgbuBy1PDsDWNXAqYoFVv8s2bjfpeFoFH8Y8Sm
	BHGL8lFtS+DfKRXMFsgqSJIZVEjEUqcTDripQ+bL/+bRh4ZLzCYl9fiVdZFnNXoN9a24SXZBnun
	H
X-Gm-Gg: ASbGncsedMI2TcoawcFM8xs4z8JnNta/KcOvD1oDMxavbvO7TKT8G6RjdFE82kzjQdq
	l9k06mHDq4xFJTxHoHdMAr0J5gR7uRAsxM23K5AMesxS98Oik+Q5/uX81dWwdJUiNdoA5+znzRP
	HbV6rEYQ9M2w5y1saADbsCuFz3aqLlwd/AnieXC3CrmsME90FFfpAcfHrCjIb+wKMKeYmhoGLfP
	WZE4LvLAHlbHiQPYjjPEPjBjZDBi3ot4qLOgozqY2sm51dEWgfKjdJJugbfae5lHkAYr4t3R2Bw
	W2QqJvEOrPe/U/ooDCaSOJg4V18L/qVDGO12YyTI4Lt1DS97IvhFcJfKfilygMMfWPY/8Q==
X-Google-Smtp-Source: AGHT+IFGSlNSuGv8u5ZdjMD5WO28yRdzMfZKHsdAtajPs7Z9g2GDXtcFXahJ8LdtLD8cEZIj/ZBC+Q==
X-Received: by 2002:a05:6402:2355:b0:5fc:8d3f:1e5 with SMTP id 4fb4d7f45d1cf-5fca07eb591mr1762718a12.21.1746783215771;
        Fri, 09 May 2025 02:33:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 12/34] dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock generator
Date: Fri,  9 May 2025 12:32:56 +0300
Message-ID: <20250509093318.4014916-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18829

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


