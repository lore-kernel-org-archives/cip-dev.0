Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FCDC04FFF
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:07 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.15257.1713514679806825419
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NRY6Kee8;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a7d4466bso184738966b.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514678; x=1714119478; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yewcQmmxC8Th8ZVMjI2OZlthzTp28WUdygEyExZdDwI=;
        b=NRY6Kee8DffklThO8UQglYS9PZZA1oNWnRmQHEr4nZvtOG5pLxYAzbazSPveXTO3gF
         m9Vu97W3gkU84P/v4g7UiNNwzNT8C7z9vjXNFy54AUOdYMS9x3WMNRd28XxqXR+m+wQZ
         q4ZRaYv3JRFMg8Y/9VsXu8HKJpdXO3fGyCkmAv8epbiCIIuHY0O7xwFhi5wekRI25sA6
         TIk7lz6fBg4es4nTtK629lHd9TdGwjYjS1v6XnshAD4T6RV9lfESLkZ6XDtyaRxYh70H
         V22Fxy3qf8J8/H95n9P1oaOiLPH2r/bgakkLgqXGZyGFwgw3TILjcQUxwBq7tYkjruvf
         n35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514678; x=1714119478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yewcQmmxC8Th8ZVMjI2OZlthzTp28WUdygEyExZdDwI=;
        b=As7/X6fysP/fsY4UCn+CQMbu9Fx1PVM82qiMf9zsZs0FCOIZAh7tgAVs3aWQDFbEq+
         NrS6oWOLoi88cX8Rrkd2gfJA9FfGOeBv4QGG6ALN+1sKzTJT4SHbKAFsOvXZACRlH7Kx
         coaB07oR6o5Ur7Tb1P/PlIjFiU0+59ZxN6EUdbAhd4ta7zLRRemXYlCBFlT9CYT/ePe7
         r/yeBWgeql2ucgHF/jhO4iRe0qENLeN1wC5sZ5gOSriHQkRX3o5I0Jgr5IYbZ21G8GTM
         WdWd6JZDmxChjZPo/1yUBHk6CrxRNKjR/ntqw5zJFSIZyzSD7jcOPl7OicWua04vU8MD
         4ghA==
X-Gm-Message-State: AOJu0YxBjCtlQzEovyAjTRawRdTelRdsYavwcLHFsKa7VvxBggVY0wu5
	iZCkqyReBB4cbLkr96QuVWT+7H3cdI5LF5TV8berHpf9c0qG6iAsUE/TMaT7ARE=
X-Google-Smtp-Source: AGHT+IEqNDHMyoNssoMWRw0GxtcHMn3yHMdrOYi/wdP6NYcgs8R1neXpxDi3NRIYVaYiBHeVPPwuGw==
X-Received: by 2002:a17:906:7949:b0:a47:20c3:7c51 with SMTP id l9-20020a170906794900b00a4720c37c51mr1177634ejo.71.1713514678281;
        Fri, 19 Apr 2024 01:17:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:17:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 09/53] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/G3S SoC
Date: Fri, 19 Apr 2024 11:16:58 +0300
Message-Id: <20240419081742.3496709-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15596

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 111287aa60004e1a58320048c89391056288c455 upstream.

Document RZ/G3S (R9A08G045) SYSC bindings. The SYSC block found on the
RZ/G3S SoC is similar to the one found on the RZ/G2UL.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
index ce2875c89329..3c2ede52d9af 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
@@ -23,6 +23,7 @@ properties:
       - renesas,r9a07g043-sysc # RZ/G2UL
       - renesas,r9a07g044-sysc # RZ/G2{L,LC}
       - renesas,r9a07g054-sysc # RZ/V2L
+      - renesas,r9a08g045-sysc # RZ/G3S
 
   reg:
     maxItems: 1
-- 
2.39.2


