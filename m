Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D4F3C275
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:25:57 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15521.1773066354519683948
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S+pphEw0;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so19671845e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066353; x=1773671153; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTreNAs3ON+xtKgLZuRmRUsIUIft59+OGiTbNZlAjrU=;
        b=S+pphEw0VIlkiLKyUJGYimcM122gGSlgHpvTuSG4jFXKmrS0NDRv1eApytFU0ShsTi
         SSPw79S0FzBLOJa+DeG4BmcvP+FTf7utkrkYIblE48vYGkYRcL/mAKmABP2ZY0gBhLku
         Ig/ZZRMFCYqFrcBvhOkleFOjXa6bhmnnJdvrtUYXA1byvKK8+VCxNF9eW1UMZkyqCPKq
         AOP2tY7h/UcrLrJYWdVS9HIdPPaGtzn9fgTqvkR4i4BsVx0KvBoa3PHQcCzjoTQGWjXW
         MiDFy8dIDrEavv6bg3iqTSFEhQdF3m3j5EkFcvgBNn6qkqVbqhReTpqlopdXfFYxZLi2
         0k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066353; x=1773671153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTreNAs3ON+xtKgLZuRmRUsIUIft59+OGiTbNZlAjrU=;
        b=vmWZlaFhIaKITBAspxqA3PD6nwCfzhda4007OQX6JZCth+/DByyo5e9oN3Lu9EqnWH
         M5XzwgGhO6/Cn/JrcCbT1Ja8koCZLor/SAddSNJOJCiCwztB+4s85ST6nnYTWQ8EUdnZ
         1knSmDqeTexvEq8NEiwA3M2QBB8nHsnFy3gIi8HudIUlxaDtIg/RcK6GV7m7OwkaMr9M
         OyPy6e/tPe2VOOjizZx97YxerPCBmYEDy/8Xm4vW4V+VM0ARrORMqvsvaU+9Q+7Q9tgb
         zjC1+SINwyLkgg8kp3/CLXFDiocPgHQ8ZBPXPPc1wedDpzBop2tqsEoGwtnxHuuF7FDa
         ZwiA==
X-Gm-Message-State: AOJu0YyLTB199xfatAw5TBznVoBLY4ey7TZNReW+p7EZRawgv0LOY4h2
	zHWg2R+eNmMv7YrnyGi1lOGCdAqWTFaTdtICBl3vGpahTLpPlSWOJ9fkBPS52Q==
X-Gm-Gg: ATEYQzweH+FJbqKPLTP0Nk0SjSl2StWq1cvvWjL1oTHhLaqIKyjcFSb25+o+9YuAl2Z
	kX9Gt6cKSLGgE2KPfDefK5AqAWj58PbwsAbn3uOwmacJXyjVFVPPh6dcJT1xRmLb/F/F1nGwqax
	1jl+Qf6l5FjmHVE0RKlbCdZsTNGkt9XPys2jiknb+pcGRWznQv0r3vtxf/sNu9aI3j5GhEvi09A
	T8GTFci5Uxjwu+ahmhGmbAoEE9xn/5wELGbgZePB8/GKp9oTYPma5ERYFw+yZF/szu4jLTp7nzM
	3QC3Wp6u8Ck1x2XPqWGNnPcwm8qYgbfLzVIMsl0Hb74Hgwsctw2NVydAvO9zzmtNb9psFwy+ARk
	KpFLXoJxWA+L503bU9h/qAdgYAgNdvd7iKSPvCBPDl1I5gmv73EmYMa1cNXDL9NO0UK2Sk8uDNQ
	iHc0xain0cAasFjV6mVI6fjF7dHPcpq18=
X-Received: by 2002:a05:6000:200d:b0:436:1b1:6cbd with SMTP id ffacd0b85a97d-439da64fc06mr21062639f8f.6.1773066352541;
        Mon, 09 Mar 2026 07:25:52 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:52 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/29] serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon,  9 Mar 2026 14:25:04 +0000
Message-ID: <20260309142549.987737-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:25:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22172

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 65acd0d86f2fa104fc0a0c9d86aa1ee6b1a4763e ]

Convert the Renesas SuperH SCI(F) serial port driver from
SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().
This lets us drop the __maybe_unused annotations from its suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/a5628fe028362ae3f8729021a7864dd39f7869bf.1752086885.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 03d248b2d8da..4e094d8ee882 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3752,7 +3752,7 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
-static __maybe_unused int sci_suspend(struct device *dev)
+static int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -3770,7 +3770,7 @@ static __maybe_unused int sci_suspend(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int sci_resume(struct device *dev)
+static int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -3791,14 +3791,14 @@ static __maybe_unused int sci_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
 
 static struct platform_driver sci_driver = {
 	.probe		= sci_probe,
 	.remove_new	= sci_remove,
 	.driver		= {
 		.name	= "sh-sci",
-		.pm	= &sci_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&sci_dev_pm_ops),
 		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
-- 
2.43.0


