Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030EF417F1
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15647.1773066360848121225
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jFs6vsVI;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c56e822eso6198613f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066359; x=1773671159; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fXFwJT90M+/FKqcQ3BPND5W/Dd7hh75uMvotRHSq8Y=;
        b=jFs6vsVISlHqeW7w7uKBDUXt7OlrsyTW+SGm5Xv94+7OxLbGGiUgzi8IZtwj9+2vws
         z+kLjMdfTnfDxV2pncUg7AHHxO7njddZHlUk33glhKgW+yQzMh6wIChK9DzIqNe9J/hU
         DyRp2lkGjanMivNXHjdCjcvH6prwqecrVs1KsGr6Gdpm/ErljHUW/p35wTYMXOcTP8Jg
         YbvuLRon0YUleSm6zC54skzbQg5mm99dPjkkVO4MNyKymphDLHaCPWqgrBUK7+Ab61oG
         PSrh1msBumGipcihOvD54VVyDcoFxI5Wc1+wVeHB6pVNqSRKusIMj2DdbtdIWE7gDKcQ
         9pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066359; x=1773671159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fXFwJT90M+/FKqcQ3BPND5W/Dd7hh75uMvotRHSq8Y=;
        b=sSV4yaLzrFPp2X7sbXDMqhHmPm1e+osaGWdjPyGAAY0cXI1CK5meIeDnp3ncLWR2xO
         MlWfflQy/hKnK0PELtvUsD/MPkn0YSVLeNdit48VAX9qRxtoDGuOdqP73XN0FMb9cDNx
         Zs0A9so/Diy5OqBc/beBbc7cKlC4QHXZ5+Bf6JFTqsbnRWkv13vqH0f681rPGY2ffEhY
         vNQSPXDADLHSj2N1XLfIYAYIBNNuBhajX2RYtI6mJyIcMEqHi43GTZIkQzjPWyjQ457+
         Cp1Dg6NxT7YMuAfnkO+PaRGFlsKF3mWuUwlmIPeGxQ++Uw4gvZIRllZefDpT8kSfAG8y
         8GTA==
X-Gm-Message-State: AOJu0Yx7gAAkYmCQxc696c+r1bGyVUrVcCPvWZVmvofuIJ6t9QX3vqlP
	ybusberIOQR6LiIXOE0hQi050Y1o8vT17Lkgk3Jf+UgiUKpKTIyRso3QYKKDWg==
X-Gm-Gg: ATEYQzy9vKuuvPiyWXKDhRpuNlG7CG1RynmSYCL7JI+vbJAaMWH20l6l265n1lvIDFD
	pEm0mqLlKsEGSvoNT98GuA05aS8tYB2JcVdrTGcM+OIGxsO8lMiU0Yg0G2iF8/CSQ3dXVP5v4yP
	PLIytHGwhkbnq6F/FCBvUq79O51yHOKVUcvy7neGFNyfJLsipnYWLa+EjNUtXEvEOOCeILznOjU
	p9f43MoKGk1yvxMbO1cYDo2ppPIF7QfBA3hFd/XyyTsGgXYFZNRPDOIci0FGbSk1MB699WKLna2
	8Z0BTfOw5wW396RQ51ew+R52+wIqaMj6EO4kORfV0+sHKul721ZQH3DkDPUFD2Tbw7OUfcYY6v7
	HWCXiFbp64oxFC01qUZI6KcEi9mTMM8daqgVChpy3wweEZ+oZo1GS/BT7S5KGrLdCHAzQiuW5jP
	vjGiftqyXtKZp1x2Xi5+DW/BovlUGMvsM=
X-Received: by 2002:a05:6000:178b:b0:439:b7c9:2edc with SMTP id ffacd0b85a97d-439da8902f6mr20657220f8f.48.1773066358563;
        Mon, 09 Mar 2026 07:25:58 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/29] serial: sh-sci: Drop extra lines
Date: Mon,  9 Mar 2026 14:25:13 +0000
Message-ID: <20260309142549.987737-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22181

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit c17db4d06cabc7746d48d99c6245d19bd55077d4 ]

Shorten the number lines in sci_init_clocks() by fitting the error
messages within an 100-character length limit.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-7-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7f23b63eca13..97f6dc8692f5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3187,11 +3187,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			return PTR_ERR(clk);
 
 		if (!clk && sci_port->type == SCI_PORT_RSCI &&
-		    (i == SCI_FCK || i == SCI_BRG_INT)) {
-			return dev_err_probe(dev, -ENODEV,
-					     "failed to get %s\n",
-					     name);
-		}
+		    (i == SCI_FCK || i == SCI_BRG_INT))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
 		if (!clk && i == SCI_FCK) {
 			/*
@@ -3201,16 +3198,13 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			 */
 			clk = devm_clk_get(dev, "peripheral_clk");
 			if (IS_ERR(clk))
-				return dev_err_probe(dev, PTR_ERR(clk),
-						     "failed to get %s\n",
-						     name);
+				return dev_err_probe(dev, PTR_ERR(clk), "failed to get %s\n", name);
 		}
 
 		if (!clk)
 			dev_dbg(dev, "failed to get %s\n", name);
 		else
-			dev_dbg(dev, "clk %s is %pC rate %lu\n", name,
-				clk, clk_get_rate(clk));
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", name, clk, clk_get_rate(clk));
 		sci_port->clks[i] = clk;
 	}
 	return 0;
-- 
2.43.0


