Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF3C44502
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89133.1783073282521778030
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UEwf7k4j;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so3080925e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073281; x=1783678081; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw43WNC6tZkLMXxuWzqLrdRcsm7YTrTeCV0D8TQLHfQ=;
        b=UEwf7k4jTrABMVpfxRioa4Y7DBBXCPxdk1Lfcv1LZRJRGTGqqcmqUO5+MvCOy+suM9
         TiKl9NIJ8mEggFCXLNct92hdXgRi+CoSXjmcv8QKE7y8E5clEbAM2KQzgOUHVH9EndDD
         easR04wbjdUKGj2j8OgWAIcbhhFgweTUzmjhtXQqbUS1aY5f6Mh9bl39l2YNDuQGQHxU
         lZM9LKxIuFfKvkCUzCui9gClAiu+qVzE0xvnPrNS3GTGq6eaG9V8Ca6cN1dbuHrVb/wO
         3iKIZz6p8abobWVQaJZYk4Vx7QQEFyEacpCUuFHZdkVp+ubgu01GkY6lvUam1RyJlD5J
         ooAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073281; x=1783678081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lw43WNC6tZkLMXxuWzqLrdRcsm7YTrTeCV0D8TQLHfQ=;
        b=r1YMu4oSiS8AWKdxLlEzqRgmbg6ULhMUFewNZ3CVkoqd0rn900B88XfBpN/Si9FSOF
         NLcEqvKeZ5Di2JMxrTs42aYDEbmyJs1d3iiJnMHh1MXEgAenob3KcZttdRQIDYKNhtgW
         WpoJ1zG33MEPXGQTVoBG2gasHpGn9Y3NCgw0oGX6ov9oMHu2GNFFy03mI12bLTFMugvb
         LkThpk6pl4ur+pVTAUG6/I8rQb22NswypjB3UofywZbV7tcHT4AePaTDBIKIotYpzMbw
         mf1WCtfBsYyJXBKl328VNTl5g5RqzTmOWnWLweksERhr8YVi1DfqeNXLAkXebTVpVkpk
         mzjQ==
X-Gm-Message-State: AOJu0Yx1hshB+ZvM5mfbzw8OUtfA1imCB/7WgXpAow7ku+9tUg41ycd+
	Rndq5mRQhld9Acwl2iP1hhWTjUaJo8YK8m3dGVO8+F9bfKfk+Cc9wkezA9wcxOy3
X-Gm-Gg: AfdE7cmx63Tpma/O/QHn0L1vSy98Zl8X3/RhpsfQi0pSshSYCjGr1jLR0nTQCdbv4rQ
	sFWZNdYmV+FGFT434Hq4bzYydnkBSD9rXqsCOzDM9HK8fz6q0V5kruBNNxm3PfrVEvVGWehq2oa
	A8jZjMw40nWkvBQx1UquPGYbdkuodoCrAM3wJHPPdDljo7hh7vtG/sTZ/wNzPLt2a4WuYdSiJvC
	MRdMq+YSWnx2uV0pfR6Rc7nr3tUMTKjh74UGMhjml2wov7N9YWavJ9LTGYBXbYS8GJJHNpeDCW+
	PkYejVq7Z7ZDrm58XDgG0hFBWDZ5wFB8boqM6ITGgnpCH9V+8UyjWWOzTJEm+FTLoKPimGWHXQA
	1SOsuMgb39mwgGl28YWaF7J13DeO3jaOPhH3nqCJNMvHQodxO693TocrOVhEmj352IUAW2TrYB2
	MD6Fa5GCKtQ8fob3pmznun
X-Received: by 2002:a05:600c:8b05:b0:490:e974:e006 with SMTP id 5b1f17b1804b1-493c3cfc531mr124401155e9.29.1783073280600;
        Fri, 03 Jul 2026 03:08:00 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/26] irqchip/renesas-rzg2l: Remove dev_err_probe() if error is -ENOMEM
Date: Fri,  3 Jul 2026 11:07:26 +0100
Message-ID: <20260703100756.238233-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23399

From: Xichao Zhao <zhao.xichao@vivo.com>

[ Upstream commit d36bf356068cdb5499b9bc458db9149c0fd938a2 ]

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.

Therefore, remove the useless call to dev_err_probe(), and just return the
value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250821093845.564496-1-zhao.xichao@vivo.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 71635c6d9232..82ce5cd71b03 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -579,7 +579,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
-		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
+		return -ENOMEM;
 	}
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
-- 
2.43.0


