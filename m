Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDBAFD7099
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:35 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73436.1773746253306736729
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YdhDIKxc;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486b9675d36so3201185e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746251; x=1774351051; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3ceTibV7KDKqfSFfV0tcKZi+v8TwM0pnDwER7sRNTY=;
        b=YdhDIKxcnozIbb6JSyP/Vp2OET1kPS4vHXtA014qd34GWnHDa5BYMMTzuY4et9UHT6
         76AsY+3yiD6zZ8p6yX6TC+cBMQJBJEwlordQsub3X8O3r8IMKUkJ0POLumZ4BDKoyeHG
         Lmt6Cbfe7560CUwHwsCI8qhfQhCt4Pi7PafpeJjMiNglRwMeSh9m6PVhmhPHuJGHGFAd
         WIWN8FnQp8Yi4NKvGHjjTfwG7hEKWL0szokseJzZNGbj9r7IQl6RSJC848gEcnQtdtk9
         sFh3ep3Zlhb/JXKUdWFhw5/ZUVLFnbzwIgDDBOfmlkOcVG0bVRSsrPh+kFsCyBDokbxU
         tMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746251; x=1774351051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3ceTibV7KDKqfSFfV0tcKZi+v8TwM0pnDwER7sRNTY=;
        b=f+rkiwqyLcuR4lVBwZfwllXNGD1PI+TYsmX4j4XxMWllmA5C6Ipw8difqxnkeSJMtw
         57930LwmqX8cOwsc2uCcArjjI5ILULq4wO1oS9dOpEY++2Rd9RJZc80//5uU+73jxb3c
         pXJbu84MJYtcsG+ElVKz50LTqxlRKu7vsX0PQff6ZZmhwUhjC+QAps9qLl+d4LKpmy0x
         azuEOfQbg7lvRkK9TsfQtLydb48taUZfuCIjW7+bBKDWlf2LBFM+rDYPU54XRDNzKQ2V
         tX27DK+1705QEvAgyWT6VrjKs1pm09xQLRN4xEANsyPP4IecepvJnkjSMLUAekDtGk02
         PnnA==
X-Gm-Message-State: AOJu0YyZTHWqPtIcQuXNhohXOevv49P5lDm/y4gNm+uJjsRZW+rsu+j2
	4Nv7AcHqjVN8vACaNmkTsRaZbpwQN7ac9gnnn01RKy7q4wGOXwxGSRnCRgNd1w==
X-Gm-Gg: ATEYQzyu3A3eiW2EMAGsVQ5dZuy+ZdPzeObCkjPmMnKZnaZwT/YlM34+lieRdxZmENz
	uRLB0p/XJ0OwNFQ1HFNBL0DSktpP9gbT3Avg4uaj/x1YKzVfQGjAvFkfVrAbR8fqnmnLruuiLsi
	wZOz2VnBdk3DomefIcjJckvhoO4SX2683dScC0sj5NGqj7e6AwFDzSKquy9cKuUW021DHNTBDaE
	vZFyFF8QDmoc/58PhnI2OnbOBjutlLEi8eh4dCxDms84PD7gpCPvhgWwdhx2KRyUVRLHBKany2X
	qx4z/9O+QQECY9F0U5AIxqVwsKNzFJ7Hvp/qqS0oyJlCXR2Ielf//cadE+ay1Uf4swvqbrFQUsx
	QzA5xlEJ4qWsWcRuvFRKlln3SGt7jolWDiCDxpJxdpg5LCn7ZucHyM4Pbm3mth4Yo6GRzsfKqSt
	1PY28k+0sO1F8SM9E39RBkH/pjXL1YgRwVbzpEm1I4lj8R+Tzy
X-Received: by 2002:a05:600c:1395:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-48556709d85mr267536735e9.26.1773746251176;
        Tue, 17 Mar 2026 04:17:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 15/39] serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue, 17 Mar 2026 11:16:40 +0000
Message-ID: <20260317111718.281633-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22448

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
index d941d4757842..db1950a7a750 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3749,7 +3749,7 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
-static __maybe_unused int sci_suspend(struct device *dev)
+static int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -3767,7 +3767,7 @@ static __maybe_unused int sci_suspend(struct device *dev)
 	return 0;
 }
 
-static __maybe_unused int sci_resume(struct device *dev)
+static int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
@@ -3788,14 +3788,14 @@ static __maybe_unused int sci_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
 
 static struct platform_driver sci_driver = {
 	.probe		= sci_probe,
 	.remove		= sci_remove,
 	.driver		= {
 		.name	= "sh-sci",
-		.pm	= &sci_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&sci_dev_pm_ops),
 		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
-- 
2.43.0


