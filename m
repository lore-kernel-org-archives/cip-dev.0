Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A13EC44507
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89970.1783073281151080861
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bgmGUkw6;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so3789665e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073279; x=1783678079; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqG+tA89A8fNKJ96VSw6e3i6g7gxrEhlWPNMf7w3/qg=;
        b=bgmGUkw6qIW6nWBTuaDSPqQZyElXYQ9ozJZFNBw83niv0Ov5sxhtgSvtgIjPoPDHbV
         BfxjeC0UbYeZumgabr7JXmMeB7nvJehiD0+PSZhSAnZFhYquZksJsgjZvXPmtDZqP3JH
         rPDHhli/cJAbJFSTGGdUqHntzSWh5KSOcWDyMxeGPofODiKR4bdnNueGx/qAIPe5h5tV
         QiucUmqQOUYj9KjjKAp9qgma+Yset7c8C1sW9ZfQpTWDqEhKYPDOB9MLwaQ3v66QGE2O
         h63aBGE5rfz3wX0rF6lEOyK40+VoYyQiH1JEvukpgWPGyOdJo3lAD4c0gJNmjq7xctO/
         2Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073279; x=1783678079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WqG+tA89A8fNKJ96VSw6e3i6g7gxrEhlWPNMf7w3/qg=;
        b=qv9kgSo3+t7ulzlj4px//QIRipo7vhEF+uond6kVEQpfUjU21FQzJtHYl542koqETx
         MeH7S/G8o731GWEy5gbGjrVxS7XOo+GetQ7QGCK5nrsvk/R1dBI+KOrE/H8p7/ZACRrp
         kl2BhSAP8SDx9L6O6oC5OpVjeGbsuBXO52VaAEnUvOePQYX5yFcEYJncuXkCcjFrczDr
         khaXTgggmBhEUFGEWtcIuRFsL3VrZ6RRwyHxbEZ5WOmcqv8az3HzXxK/PgrALwtidAOI
         heLkwtm1I0emXSR8M8uNuRn0UaTA3Gho8gXQ/VqicoBqgVbW1mNvhbU+im9+bwHJwlRN
         kxPA==
X-Gm-Message-State: AOJu0YzXQrpbKG09Mk7diJ+JcJWrHnXTV6zF6D/McrXI+ynJW9oGvTOO
	gKgBSUxpXGIIm0JkEgpGPvf1Ea9/lYlz8TADPCnH1H1CnNTNlIGfJDkD2kWEduFl
X-Gm-Gg: AfdE7clEIWDO+aN4mHa40F/PoaisEojmmMcTwZ+PmUzNuLQCOQZNcGebM1kiTcDfKBE
	kvOG1+pVWRvIoVDwksWB2aPo9TSEByh3uAEqw+9iYylpN3dfbL0uiRfMFwYgn43zAqflyGTGrPN
	R/9a5nmFWE1so2wWr3alOz2XtOn5sVVj58l2mq1QF3WfkCJK2KyT6Uvw9iJqeLe05vOC5fg730l
	ztTGEaN6hK7DfBgNGyLoFM9WhkQlWMAK7odw6XP22+1KS9KmFJJMni0bHDUosrgNEuPSJPHTsdY
	FgCSSlC09Kz4x9Yr0wrdgdcnTKgFbp6Hb1ZjUSjw3CDpTxQW6oL28tviQK5dB+1K306XP11kTtg
	+BjxqDHLTp6+v6k6cg1pJmN1DsCAcbd1O+rQDwKjb8qN1pPiuQrsDukuwNnsZrijwEW8pJyfWq2
	hqHMWSKmGGgOJ+JbxYieDp1re8xT6FYlA=
X-Received: by 2002:a05:600d:108:10b0:493:c337:db19 with SMTP id 5b1f17b1804b1-493c3cdf959mr101329465e9.17.1783073279205;
        Fri, 03 Jul 2026 03:07:59 -0700 (PDT)
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
Subject: [PATCH 6.12.y-cip 05/26] irqchip/renesas-rzg2l: Switch to using dev_err_probe()
Date: Fri,  3 Jul 2026 11:07:24 +0100
Message-ID: <20260703100756.238233-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23397

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit 4bd0317ce63c26c8a1b6e96c9be0badac749c6f7 ]

Make use of dev_err_probe() to simplify rzg2l_irqc_common_init().

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-6-fabrizio.castro.jz@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 31 ++++++++++-------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 9063bb98753f..1f0b83a00637 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -541,10 +541,8 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return -ENODEV;
 
 	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		dev_err(dev, "cannot find parent domain\n");
-		return -ENODEV;
-	}
+	if (!parent_domain)
+		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
 
 	rzg2l_irqc_data = devm_kzalloc(dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
 	if (!rzg2l_irqc_data)
@@ -557,28 +555,22 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return PTR_ERR(rzg2l_irqc_data->base);
 
 	ret = rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
-	if (ret) {
-		dev_err(dev, "cannot parse interrupts: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
 
 	resetn = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(resetn)) {
-		dev_err(dev, "failed to acquire deasserted reset: %d\n", ret);
-		return PTR_ERR(resetn);
+		return dev_err_probe(dev, PTR_ERR(resetn),
+				     "failed to acquire deasserted reset: %d\n", ret);
 	}
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret < 0) {
-		dev_err(dev, "devm_pm_runtime_enable failed: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed: %d\n", ret);
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed: %d\n", ret);
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
 
@@ -587,8 +579,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
-		dev_err(dev, "failed to add irq domain\n");
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
 	}
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
-- 
2.43.0


