Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F87EC43327
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:46 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19070.1782820121218561975
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ImKMx453;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4745492ed3aso1246339f8f.1
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820119; x=1783424919; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQQbTGDeX1lTPVFNKyHdKooXreVBv+jC0fK7QYvy4KU=;
        b=ImKMx453upfJ2D6LKJmdMFyWvdSMhPM5HDSJjPhMbcjw1w4Io50zsyjxXf1dKW+Cnd
         qJdeQRSc5QtJDgVPa7Z5RnT8Cs7yd3xeHXC+XHLjWA1+gKvj0jul2SHJItoQBXo2oH8k
         5FMUHa5XgQ7nXhBwQeBxX/VXip7FF2PwfSSlxMZydqi4CGLjgr5NuGHzTiFuPTDDz/lc
         xN4KzWhz536Lhj92jAIZ5RKkSrS5sKiut+4RAvFho3icOWAU3XmIDvc/56t6jJIB+M9O
         hqFDdJ6FUSxHWRBW5zLP/m0R8XUgUlDcvqRebcGXzlsu1HqA5OR3UDul02/WHn60J0tD
         Hvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820119; x=1783424919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQQbTGDeX1lTPVFNKyHdKooXreVBv+jC0fK7QYvy4KU=;
        b=VvI277kDxZStWrZqob6ymIhoSjQg2UOhEDC1EjkAmAbEcEL3L+kg+Vv0s0sHqcHT3P
         5FdGfKrhROUInj6rFPsYzSvrrL8BpqzR9WUxU4KPnfpICaE+nByMngYUSpx31btaEvSt
         F9xOnXm4yhnGrOFsvgkUhVhgYGeon3KP72eQtkeDyy10FLL1aQ1kbMS4RDm2sv6dYCVc
         /zry+AgOhNASb+Sszw+X8YVC8I9GN+q5p3cJLzXQoZQZVUXnJy2kmgjrnt52n6zxYHCW
         uAnjzLtsaEwuu7WCHB7LQ26/vfRis01ty8XK/9+0SwZb4RoDY1mjl7QfdBxcy8ki5pi+
         q+ow==
X-Gm-Message-State: AOJu0Yw1iIiDhpR4jd3On4lOMz4mxyWz8k60FRBv0b438f/f5hGo7KCm
	FDiIMGR4dxvS/QzTak+uYc18T0PDo4Ixb3upPJ6Ut0ier7gXsHGfS4d4E5/e6eIP
X-Gm-Gg: AfdE7cls2Sz3g0K0QoDJ1CcnBjZZPlbvHlb0BwBnxQBXc4uLuGCaYJuh8aqmFX9DACY
	sV7lzoPUpL6GikICHz4cQGZL7mqaC5X+aU66plPFMHAvV2AmROAG3+n9bwJP6j6KBkDjYPfLUM0
	U46x5WyZBls/DQ7NIW2FbTwQ0sdcAsFXiqaGHCia4fJocjjmqyGzYcM3fAIG37x9uJSb3mnl4u6
	+0dEshwZvISZQg+n7riO7qgSAgZyXaqlXe+zwB0qLzQfQXWwiEc0nIQmCamSGa1Rk+rsJI+pK+P
	wnmevJ0aOvOP7Ruh2RL1kouXGFDrTHXERTxSIsVbBsANENABUDPK9KzTRDWCDJfkYqx5CgX/LQq
	QPhwCUgMrUzqQVjM9gxnF9B3jSwCgitaZRG5iLt7Mx1xSIBc3pyv0vQfpxFtvhu/fCtZdyPIObB
	XUVfr1vlUFBo5kdg8y2zl4IiR54RdVcHw/QznpxQ==
X-Received: by 2002:adf:e384:0:b0:46f:7d90:8125 with SMTP id ffacd0b85a97d-47659c03707mr196285f8f.15.1782820119436;
        Tue, 30 Jun 2026 04:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/39] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Tue, 30 Jun 2026 12:47:24 +0100
Message-ID: <20260630114813.92739-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23329

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit 9ef17cafc36bbf47aa840727bc1dc3e65812776f ]

Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20250307011623.440792-4-inochiama@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index e685e715556d..a147243a7db6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -412,6 +412,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-4.20a",
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
+	"snps,dwmac-5.30a",
 	NULL
 };
 
-- 
2.43.0


