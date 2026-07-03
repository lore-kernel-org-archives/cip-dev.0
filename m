Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C50C4450C
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:07 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89131.1783073280769453959
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gLsv5zkC;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b61b52b6so2386295e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073279; x=1783678079; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUzltByYVgZqr/wRqHp+TCCPqqgb0Qj5ZKk2dgKdoYI=;
        b=gLsv5zkCtOWqXWynv/SpYWAPx1Wgb07mA6pJJkstmLpD6icldhvRHjKSmbbQuv1jku
         javsoPQW1J69UR78LsqxRcaKXlGapMTLhjZdSa4BRtw9ny7Kueze4h2hKjUvAr1VWZN+
         2LtqDAml4+hy4u07NDQIxtOtB7aiqNqD2k7sUhG6vyfP+7SrO3/Nk8amW9fF29MtyRHr
         Tht4zbpJEwd1Py0Ot3OwPW4Jw20WXPho82d0KnoPsvthOudG1nIzT/cSJVRsooYZ8/0u
         nNCPahd4NDx7Ipdz6SHo79A9yp5eZSkDrvblgEO0o6bjL0TLlDkKTxNY9ipkY7RuQ/4F
         /DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073279; x=1783678079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rUzltByYVgZqr/wRqHp+TCCPqqgb0Qj5ZKk2dgKdoYI=;
        b=FGqHAmnFfF1BMGuQv98/zcvEquMKd+cVIN/E4MEa5yskCViZyOD9hZLdlwRbkayghd
         ohF1rToie012k8y4ePvkcvY0aO6vVC5XPTz47nq0HyKMyFbKDox8ggSiu9AfGLpehTmD
         GWrksIzhDzgiCu9J5T9Dqu8c/+cGUyKxfU1Yx0tX91ETHsr7pikbG12JIuplEK2DpD+9
         +f+vpp2CjlXTd+NT0Rg5eTZSut9F/47k7i3Z4n0lGfo97RKTNeqLHFDzxMQt62XrrvGb
         0RHorbCfmyVgmw9p5/8TXpq+NKTT5OKx7zVT0B82zObpOJVluJ211vrk4w5ifLwaUw/j
         JUaQ==
X-Gm-Message-State: AOJu0YxhcCr09Tc8gF9tyR92cxl4TXmSCrKShjkh056oYNOOkYKKi5rC
	PAvCxWQ030PmWcpwbvYeUTaIARrvtYXPVdqQqPVWc1fROx0psrS7hCvHRSSdy5V4
X-Gm-Gg: AfdE7cmwKusUr6+I77Dfj9czd9QbsjhPl9v0aTzsh632zyRQeZqILZcnTQDVjEkA1Uh
	blcXqZLDGURIpC52ONLKy6zxZ4gD1Gbqiplja/C7jL6oVyU/c8WXVG3PeRVfYVSO9yB+nW1Jggk
	1nIVRqNrg+Sm46FCI/fnQhO2Il2YSAarF1g02bSNVEmKeme0IiVcEa+NNPldtWEQutQTyzVWDHK
	fCMdsN9bRHUdkiQgbWxHC7/BNKAz5urtsgE1vBGzYNTS98yjsJASoovF47UWdQ4jdW1vn9fcL5s
	21/7QkC4VFqPRtD7/8GOavLMhNT796E3cnW7KpXHBpM6tMq6InS6Rv8Sqc7cFEZ0dsiHu8OCmCr
	10NflMoty9ZPbc1StfuVDpq2zVXdWD6omgd2bKGjRyEzn4a+4T6+w/OUkulRi9iiglp0OCN1bp6
	BE+kr+cm6zYoQpF7bbygRR
X-Received: by 2002:a05:600c:8286:b0:493:c42c:7e88 with SMTP id 5b1f17b1804b1-493c42c8307mr114389845e9.34.1783073278655;
        Fri, 03 Jul 2026 03:07:58 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:07:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/26] irqchip/renesas-rzg2l: Remove pm_put label
Date: Fri,  3 Jul 2026 11:07:23 +0100
Message-ID: <20260703100756.238233-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23396

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit bec8a3712943282fcac10647905c021335e27c2b ]

No need to keep label `pm_put`, as it's only used once.
Call pm_runtime_put() directly from the error path.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-5-fabrizio.castro.jz@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 1f95039a84f4..9063bb98753f 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -586,9 +586,9 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      node, &rzg2l_irqc_domain_ops,
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
+		pm_runtime_put(dev);
 		dev_err(dev, "failed to add irq domain\n");
-		ret = -ENOMEM;
-		goto pm_put;
+		return -ENOMEM;
 	}
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
@@ -605,11 +605,6 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	dev = NULL;
 
 	return 0;
-
-pm_put:
-	pm_runtime_put(dev);
-
-	return ret;
 }
 
 static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
-- 
2.43.0


