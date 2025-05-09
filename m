Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C01C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web10.10318.1746783135667799131
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OU/IizDB;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso3716899a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783134; x=1747387934; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iun09y0IT/d9FNVVRKVLZsVKN/IxkDzK0zGvl755C6M=;
        b=OU/IizDBBsw5fjJ0zMfqs3RP13pXFPGMbD8Trwlp8NKc+LFkuwoIwXYHOa15+TlZxX
         k96Wfjea98NhKmblzpuPzFNPWg8kt3pJ0/5nMTrK8xWK/f71JhBTz29TqDrWabhW2jQP
         bTQ3L5rA0xNoVGg6DObKq+u4eCXS22v6oSzuolDOe08sz3FgijI4v14A9VjWxqK/A62a
         Y9+2xn9JSCgQCaB7ZGZGuboD2vUDLsl1vQbkUdSZ0qLl057zMrz6huJoOI2NzKIHU7Li
         Mh6IZA1msBh6p4SYOKEt3RKGXIQX++8N/4VIuhafH3meNRx5DSIsoassZ2MOloyxax43
         X2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783134; x=1747387934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iun09y0IT/d9FNVVRKVLZsVKN/IxkDzK0zGvl755C6M=;
        b=Qc04AmpgoN813AKXo5Q+ASv32smDVsX+CGZGe9+GwRrPijtDCOYj6doGnT0J28G85i
         NJDDAaa5HjKqSYgtrX/TvI+HYGkI1X4cYElmyGMj9u4BdYJurgNQi850HxmEyTjPLYdK
         F0QNtA6CDSxkZyqxs20nOzSndNEYuLl5BhoUZ6NmNWjeItbcpdgWmJtCqeLGYEA9KNNp
         ohKkWiQnsx2ajjt5CsUebeMhdBCudb2cJECFMpEoqNSXCzeHzzbNXUxbyhrZzwJRPiWw
         ovbyK+4MPSVqri/aa9RaCJo5WxZtraJHvu7bzC76M99WgjZKY4w8rlY+I9kbyu6F6CpR
         0wVw==
X-Forwarded-Encrypted: i=1; AJvYcCUPy4XLo9AApYw0w+azYDCkuTzZ301ok6zFvOLCEGlJQBuabG4HV6cs6mOf/Bvdv+fqbmsWqFdG@lists.cip-project.org
X-Gm-Message-State: AOJu0YxLJYnV2KPNqd7u5UvWM2eoCK3rbmDislsaiXXP1Vr8oYHDmg3A
	2IC7Fzyi9m8eDnRIWYv+KZHKJXCAyi+bl9L4Y2tZ0vnF5bTDbrXIF4bfGN7SvT3GfspRdDtUY4I
	K
X-Gm-Gg: ASbGncv+LFl8NCBv0+EFlnHyvoSzaR4oQaba8P0rYMwUcPG2KTVyYVZujw/evf4Q5EQ
	qA6fHa4veaJXiLuT39V035AurVx3T6dqiZ4BzHFyvVVDNuvyOjFIzlY3GKHewr6teS96Ev7Z4wx
	SgUjfk0LbpmAo06M2lxQ12nYc14/C2AFrf0AV5Wl9ls/JP4oe/WWRsZ97je23HPN70GR+V+8IWm
	rh1QBHCSQVdWaTusN4KgoQjULSrc4dj948WVIUJiO3yPDaaES/pLWFoNcZip/ymvqYnshGQ30WZ
	fiBoDYNmwCuxaV2BKHqxlrn+dj6gDi64p+3EZXJ2IpboP/sRzTi822zdDBRF43mPFGP4RQ==
X-Google-Smtp-Source: AGHT+IE/86J5q6ui3L2EfTg6ewyokiwczWCOdnVwHY5D73u4Jr4FrUjwaWSHIv0Z6E9PPnuu3NwIHw==
X-Received: by 2002:a05:6402:3509:b0:5e5:bdfe:6bfb with SMTP id 4fb4d7f45d1cf-5fca078eec5mr2126420a12.16.1746783133988;
        Fri, 09 May 2025 02:32:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 07/29] dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock generator
Date: Fri,  9 May 2025 12:31:41 +0300
Message-ID: <20250509093203.4014750-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18794

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


