Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95AAC4450B
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89130.1783073280284826297
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cIhUIIMh;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c7902f47so2339615e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073278; x=1783678078; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BrBxbmsOFG4o5Q4/6qM1T/YB/P0OYgGstFHcap7xx4=;
        b=cIhUIIMhL8jCNgfgwqIfDNTfxB8y1Xpw4BkvVmFGTKauVeeuB72YQjxlyumDgj+22E
         DZ59LiMV3KZhoXAHtSpyK7AE0iEvKqs0GxBt59bWwowNyWnhWraCQdsbbD9LTMEH2NnW
         g4Xkic+jolfvefNGGk3E5t8wDrLaz0g7mWnnkQY04Vv792l6s8ufbyoXE2auFRbmwUwv
         u73AAsFaqtvdDJiORqnWbw+YjhTB95Gu8xtx6fuhUlldWzSsZYE7gYvmZHaP2Dh4AZtr
         5U70zpEY5n+cHBmxegmHYJOjFQ/EIt+co+E9vxTECBj3XdE4VK8Ua8IkC4xKHI7hZIz0
         E+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073278; x=1783678078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BrBxbmsOFG4o5Q4/6qM1T/YB/P0OYgGstFHcap7xx4=;
        b=D+phc6F2YJU0DL0LQXt2w4XqSl2Gc0k3OZS5Qs64fC2ZgQrmtISgDpKB0mctuxTJtf
         ZMXiL9eckl1vtLZLR/Lv7hyHas27SupswM7YoYYz5XlCUD+d/qqtCUdYtwCEj156KCg1
         fYGHn6bHaaYVZROwkT3W7FVsiKNOmApJJbKgq5eevLIoGMmZfCZhyeIb8v3bKETUTrZW
         CO7hh6xgj4vaBPYj/hHGCvlX3w3J8JxP1dFEwZ2wKwff4gmF6PbdiEgGeYbU9f64fQ3O
         Aw/Vddc5/fcM2VXsLHRkiEiGYn56MjUqSSr3swvC/sopcpplTYUeeO3argqbTus3yCJC
         5NiQ==
X-Gm-Message-State: AOJu0YyCBrejuMYVXlR96rUsKMpnvICSiacD2fxA4jclqFbt0nj6ZklV
	vYETqQ+4b8Sm5fGfsuBmmCFr1Op15U41WQIJL5KuUdP0kFYQoN1IJVNIQL9Fw9BL
X-Gm-Gg: AfdE7cncNHOc+xc2cZmx2JF5ySybS2sOooBiucC27X5/1YzsznFS8AGEgtatgTLfpfJ
	a6PkNoSf/Sk0X7uMGb2t8HTdZLjJr6SkHEvH9yWePkdo+wQwUPuQcf2Pnf5xDz377vh8xhw7nio
	bpEP8nzg6WYCrTVgA/frS+pgfUeYwDQNyBRjgDHleDt7imCgVbmSg7w6vrwFxqYa7uRoPS7y+Cu
	hRXHQAr8bAglzStMcH2HjxBDxW2AoigpSZKMFDNqoxQRoKJ6H/7DY+/79h2PWcF2LY5IP5l8UQb
	VduzIQiZp8FI+VI3Xrx2k7nwnI/IbSYFKRehZXL6m5/edbWKhSaOpTpESVXQ2RY5a96GqNXfjK7
	3doZdzlijy+b++ybdhNvWflBCJx+i1j9hgTqWuheDtIzqhF2dk1ClwUyS+w2SkPaSZBTc5TZkPo
	6eK8b+eYdxmsPA9kUjKfWV
X-Received: by 2002:a05:600c:5782:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-493c2b7f3c6mr100867975e9.19.1783073278191;
        Fri, 03 Jul 2026 03:07:58 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:07:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/26] irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()
Date: Fri,  3 Jul 2026 11:07:22 +0100
Message-ID: <20260703100756.238233-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23395

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit 7de11369ef3037feb8365a3b5e8c433652f5fdeb ]

Simplify rzg2l_irqc_common_init() by using devm_pm_runtime_enable().

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250212182034.366167-4-fabrizio.castro.jz@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 7cf3d6963935..1f95039a84f4 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -568,11 +568,16 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return PTR_ERR(resetn);
 	}
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0) {
+		dev_err(dev, "devm_pm_runtime_enable failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		goto pm_disable;
+		return ret;
 	}
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
@@ -603,8 +608,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 pm_put:
 	pm_runtime_put(dev);
-pm_disable:
-	pm_runtime_disable(dev);
+
 	return ret;
 }
 
-- 
2.43.0


