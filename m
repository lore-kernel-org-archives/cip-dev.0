Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88FBFD7088
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:33 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73432.1773746246840302447
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y7mTSm4Q;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48534237460so60947775e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746245; x=1774351045; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1fQhX5heRM2WDI61V2FPn/ZHzFe6nYrULN1RkxlSNM=;
        b=Y7mTSm4Qb9+E1/mP7FqFQHtAr2CRLi2hDDyHlfa/W3SXJYaeBbPStt9vr2mac6eFs2
         bO8SHwTuI59JdnHHNTi4Q+1HB5gHG3RulznF1tX0FPBlqe6yTPh2P0SkDI+VoF4IvPgg
         B6MMrBmzQ2D6JxQ/LHNo9YC3lDXUYf+qU2+tqWobDIGhbgKpZITNmef3s6Ug6W3AVyq7
         kwaTs+0dgs4OkFvedJ0/e96ZhEw2jmPIIaHSVRe7vquDxvDTMrQbCCNVWKNe60PbLSuC
         YQFePk5StMPPCCgVi8MAj3ZIwNT6uDbRhe5XdjOk3b+1fqu0KAkCMN+NxFXHCiVsZ6Ir
         +cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746245; x=1774351045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1fQhX5heRM2WDI61V2FPn/ZHzFe6nYrULN1RkxlSNM=;
        b=kJpoxH6C+0Vk1JkcnEKV7gK4kLmGi/7RQZGVfS2Zpqz2GkGSl0qg3Jz/TlKiuXVLC0
         Vrz2I9vGZLea1S+GSie7sz0KPuDHU0HzA5bITKkkUUzeNDSHeWB+FvyF0778UkzwKlgE
         H5gy2WGRbdzW/oOIFQkmmZKzprI67xnsGL03ARta+q1qwlrgMw1gJ3j+QZ1h6cjuTttL
         XxbPqCUdVOR9pj6MInGwVmOm5Fq/37s6y2oTBbjkvdD4aMnIjxj2CA6aOQkNPriUAF49
         SlKBDHUcfb0g8aaKn4v8rWSf6X3b8kLkA2R7yosfr6SUqiQ+EfhGyzEFADKETkVe/LCJ
         NjQQ==
X-Gm-Message-State: AOJu0YxoZjt7NP9LDgGe9mxY/ZlQUo9/SzTD298fp3t+h2p8axghcU8t
	XFQnTv+FwEE72AcVppVJmq5bgP4ded8t163o4Uoahg/2KK7OR47CiBUdnu90sA==
X-Gm-Gg: ATEYQzxSSO//OQoyUz/yO1frk3lcTYhMDYhmU9PWcz/PzN17mkAfJLND3hc/eN0KTvf
	G/UlJLJY0y2njKB53cIxVMucdyqTWJ3011kTve67DNsvLOv2EfgY1rf3I6QepywoFGv5kjHqswx
	g0TE4Q/fWMwz2gzYMcGrMQmy9/IQy5FQlVrRPBNvkcrhVzmDYPv7WMsyRJQCRS7Uc/9C+XHHDCF
	91e7i8A1JPs2ksP0RaKhEGAUdgfXjTSz8NY6RYoY4cwoX81Y/PADJiXmtr5eG+e+Zs8Lu/EJokm
	MeQxi0B7dh9l08GVg20nvB4d4O8zuhXIKKsSawLxT8AwuwIjDAJRpradd8I4fjJCYdElopaSbUH
	YWgJ8Y0Cq6CoDZTzN9Dgzk+FYMpZmZPZWNEixv2P4wIT4JDzCrNXjG/drqmDm5ctCmkuDVqr0u0
	qbkQ/W5iMkYbG38+F/zpoPvzUA+TcVbYrt8rpmpXhRsOvot2Xt
X-Received: by 2002:a05:600c:4fc6:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-485566cfccfmr267521145e9.10.1773746244836;
        Tue, 17 Mar 2026 04:17:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:24 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 07/39] serial: sh-sci: Fix a comment about SCIFA
Date: Tue, 17 Mar 2026 11:16:32 +0000
Message-ID: <20260317111718.281633-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22440

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

[ Upstream commit d004e3595718b8b55009c08ff59cf13be5490f59 ]

The comment was correct when it was added, at that time RZ/T1 was
the only SoC in the RZ/T line. Since then, further SoCs have been
added with RZ/T names which do not use the same SCIFA register
layout and so the comment is now misleading.

So we update the comment to explicitly reference only RZ/T1 SoCs.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Link: https://lore.kernel.org/r/20250403212919.1137670-8-thierry.bultel.yh@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 06f6e1c7cf5c..61d7081043e8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -311,7 +311,7 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	},
 
 	/*
-	 * The "SCIFA" that is in RZ/A2, RZ/G2L and RZ/T.
+	 * The "SCIFA" that is in RZ/A2, RZ/G2L and RZ/T1.
 	 * It looks like a normal SCIF with FIFO data, but with a
 	 * compressed address space. Also, the break out of interrupts
 	 * are different: ERI/BRI, RXI, TXI, TEI, DRI.
-- 
2.43.0


