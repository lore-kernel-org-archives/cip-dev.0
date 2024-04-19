Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DDBC07C79
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web10.18436.1713526737774300232
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jSjxYx40;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so873870a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526736; x=1714131536; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDuQ98tfmN2EWJiGV2dZFGuLoSvlTK5HZ9tG0EzvMFw=;
        b=jSjxYx40SO7KtXQ2qFZdwbT0h/ZsKUEdeg6SEkLaJC+hNWBvK2LPyDLmy0shRd4Im+
         xt33gx23TBjAyl4+XJTudYIKM4hSVoyYvCRNy1iJUl7CfdSHNoMEL/iANpY+l5ymLBIP
         A30inUK5cYx8Y0VbO6NFlkumnvg8poArPYj9ck17H5d6PlYc7UHBJhZilL6DlIuDus3B
         KrlwtBYXhl6oGsA6JMlrh3DqJYLJTHCjIgwH/ahaC35sNcGstVZae473UmNw0Z+oFTlx
         7Q8DBWdeQ5NJ01BC37qsJ4QNkztHUAeV+A/y0WJ0SLh1jMCzqQU13hNPhZ4loKgSY8Im
         /fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526736; x=1714131536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDuQ98tfmN2EWJiGV2dZFGuLoSvlTK5HZ9tG0EzvMFw=;
        b=IZJC9ewMEgR5ho+0ZKdytStGsIoFk1fpsi9WMMYwrVXc/319c1KQv2tTHiSyx5k3aZ
         rvaWfN5WUiIDj+QJyQV51lnl86+uz9lIqaOFs1QpVG+gsIptaNTCSXsUUxCsm+tYnNMH
         k7hYdz9FDq3GTzJK4n2DE5hlSr5K8Ntl5jBEsnAIdDrklZ9aMRfPRb5A+5J7Op0MPe8S
         GX7//ZVt4vAviJeuVaTl1BXXjIklHd7jla3Px7auHpYuPT+O9nAvc+HWDzvzWF0VTeIh
         f3jlrWwvmau2Md3pCNwkyhEXn/eQ0eZQ0q2gyS6upLPkjV59igte+DOxeEBhK+ghj85T
         tcHg==
X-Gm-Message-State: AOJu0YwpCy35VUvOdY6Xf4cDvhltDxLfC0t9rQv1bz6KFf2+fNHyKYU5
	1nndPCof0cqb9XEVP3z/2av4C4OBiiTE8etTlkxe3CVKcdN1SSzIKIFbvkBll50MhUwrBstQ50G
	P
X-Google-Smtp-Source: AGHT+IFqnu0Pqglmx/7HJikwbkXZAPm0qQP0zjpy9LPqF3D5XJ7jwXmEiO/YLG2ilTKV+dBeQruCdw==
X-Received: by 2002:a50:d6c2:0:b0:570:5e97:c023 with SMTP id l2-20020a50d6c2000000b005705e97c023mr1592781edj.33.1713526736202;
        Fri, 19 Apr 2024 04:38:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 08/44] clk: renesas: rzg2l: Simplify the logic in rzg2l_mod_clock_endisable()
Date: Fri, 19 Apr 2024 14:38:06 +0300
Message-Id: <20240419113842.3675543-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15659

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit becf4a771a12b52dc5b3d2b089598d5603f3bbec upstream.

The bitmask << 16 is anyway set on both branches of if thus move it
before the if and set the lower bits of registers only in case clock is
enabled.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index cb31efab2cce..572a7e86ef44 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -910,10 +910,9 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 		enable ? "ON" : "OFF");
 	spin_lock_irqsave(&priv->rmw_lock, flags);
 
+	value = bitmask << 16;
 	if (enable)
-		value = (bitmask << 16) | bitmask;
-	else
-		value = bitmask << 16;
+		value |= bitmask;
 	writel(value, priv->base + CLK_ON_R(reg));
 
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
-- 
2.39.2


