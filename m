Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F79F33836
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73444.1773746264382785313
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Qb3yeNPa;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485445e80bdso49182725e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746262; x=1774351062; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W668EUt43gTFzD7QVqI5yLcqiKM/h5AvBQAEOv44b/Q=;
        b=Qb3yeNPaTm1NszN9FcWzSGflubEPyjZvyBjPs5I1KDPNd7FVmyGIz025IrbkudVk9t
         67j8ewugzsqpEohmF6Q0Kqxk3+XW4KduDldPJW9pHjzgljkbwmZCX++oKjDPEuNSK64Q
         YgozpmOG4SbVThQA7hkfcQFbGdAON49GbueefXy90efLU401iPJ1pveNnCbMnNxfGNXy
         rUI3CWVS56PbWb1Yb8DVm7UdfwnVrmuMw2uUp7FNcs6vdRkemf1UmUtN2Y/Y+K6QdNbN
         x2bSSXMrpCVrjmlgDcYxkY/4WN3bCFoGxKjO7w4WAkmXTSer7AO+2r1SDDDlt8JjRUJp
         c7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746262; x=1774351062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W668EUt43gTFzD7QVqI5yLcqiKM/h5AvBQAEOv44b/Q=;
        b=HWRAd8LFwTkd5gKO6RdRily25jNgMs5PYS6P5XPSEJPxycZ2XCgz5OFZS5oTEKRprV
         JW/KQ5bhAxV81Ey5Jla2iphhiY/zrHuTbGHGJ3DUqivQ9hmhf2wzSfi4Eyw4AMOa4kET
         JSA9A+kBKutWHb9X1HHqCKWIDo+HBGmS8S1zMDtkY1DKKGj3zTdZ1uWymHo6KnVBowhw
         f8C+BeUEFmaHFG6N0J4QsOIWbET7ZbNTTs7xXdFTCy4PbvwDmSfze2mIYyTNvaBkb8WT
         6FzBJQE6WM9Xhq5p+TbaQh4xUyrqLAtZYX1t5wBAXO13hraDWnx/sE34cahQpmioV+gQ
         Gtpw==
X-Gm-Message-State: AOJu0Yzd6sbZJ7qd7gKAh0Wy5ZsCPhio9QsgUzQt/ZPHma+OQwYYRKK0
	HxwGo2NJ1R9RYspUd+4moj9nV7s4YpRAzxgDYPGE/Q1mvya1FEPdxNpqrLI0bA==
X-Gm-Gg: ATEYQzxwQoDjNvDhOWwoLaKBDVoIIsXPN55yuj83YzfnGPS9LJLgaFTwgEYDlUzTgTU
	n334XYRhh47dRsqITF2zri9oRWBq6PH0ZqEvEfFCNtH1OG0zCpSFtp03fa5GEggSGxhGLdwFDBD
	qAYd6bu18IglSiZHp4l0DPoA/OWbJzaSrujuY3xQo1KGrdGeTdrLT+3x7N9oVF01eQqYZKyL5EF
	YNg+YY44iIa0Vu0pR02LcQ5VaQd2rQcIvodMv/W9gENN6ZGymoSCWVCzevhk94nqlBFCM1HU0lM
	gz/VjPgBL1KqsjKHldgPtM4OXoOGw0cfLsZw8Zueu/DalW5mVcaUzbO20nG8Z/65ymPrFpVe32c
	+9SA/fpE1suWcvzLlBamXF7SF5x+eJY+UvuWPPUgpqKGssXwakE9xQA1BwKiGowlPjY2Hlu+NwX
	wzrgNDcUOQ8N2KqT9Fe2PAwEKvi1vdsM3kQIl+gc6tQBjwZjjK
X-Received: by 2002:a05:600c:3b90:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48556720ea0mr254981045e9.26.1773746262262;
        Tue, 17 Mar 2026 04:17:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:41 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 28/39] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Tue, 17 Mar 2026 11:16:53 +0000
Message-ID: <20260317111718.281633-29-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22460

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 850ec928922fb819c28eb175bf85b01e28afdea7 ]

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-10-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b135914e53c3..ec7b487ec44e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3703,7 +3703,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0


