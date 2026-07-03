Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D5C44503
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89134.1783073283157237936
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PE28hujF;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b7612475so3543895e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073281; x=1783678081; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HUnCWaDpnG0BiJcRxPcDM3gmCOtXiHLTodo6QKA3Yo=;
        b=PE28hujFslNwR4d5EeEhW6k64RHTFsFDSNi3/6dpHHuI5rHhHK9UJ2B350h2TPS3zr
         tGuJbTWFafOzFCaaee5/VjDXOBlNH9qT8dt5Mzl7BaDkJ9ZieST1ITX3qMiAf5aTm5RM
         ZZJm8QC97HgAIlF9kkOBwB1SkTk6ln9+C9YyKpScvFMJhWlmVCgKNRyAMV3XB/k4Nt/c
         fPBghBARc4iJ0AqZ3gCS5kq0+HJeUVFVoekpjn5LdN6edc0nd6pzuuKFGedeXCfnv1Sw
         FhElZ021jW0UgXK67LSIZBduIwWAOM4k/aq8OC3uOB0i9RYadLtq0cZqN2bKPQZ6m5KV
         IuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073281; x=1783678081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HUnCWaDpnG0BiJcRxPcDM3gmCOtXiHLTodo6QKA3Yo=;
        b=AvM7SFhXyu1jZFN7xSmyw1ra7Kkx/RoBay3Z5N31RkV9q8oCU4i9M3qYpmdcp+p6//
         E1uz2feq+K5VicpbTw0qo4ywCmRZzt8SrEPCx3FYi1pJgx7WYZ94VB9Ngs0UWZ0iYeVT
         prraOdZ7A7ViUjAw5+ZLaBLCPnyy/8qWo73BMzjpAHmmElO0Jq+gX4+WGwv51grp8GFZ
         YT6aVwUhzNISkesDQcye0/32fmW5DWd16xB7oY4JZtkVuoSrlu4U2hyAh5A6Jxbw8A5b
         bYkb8rtES+WK9B3mnt/Pgj11Z7Xjj9n12C0TQ1omp42Iw28F3M0UY//74yvqewnKSTyl
         vwxQ==
X-Gm-Message-State: AOJu0Yxqt0d/Cjs0aU5QV+SzKXJIQ9ubVy9+ufgw92RawJKp+4olR8PC
	l9em3rJF3BhzAqUbewcC+pFlMuT/Xd64sFDwYwvSpXVxwZG1cL5JAXupREOsRG+g
X-Gm-Gg: AfdE7ck5GgY8YTa1D4swefknaWauiuLf4MSdXjJIlHGoCPd2RSOn+CTA8MumACMQQ0W
	wQb2i3RLnGQ7x90iArkVPNoHC5uVSji2GKHfvmkGxHTbYOjYP+A9Es4Zsxz9h8JgpezfnOszzzu
	6DNRikEjUd7IR4crY2BNj+P7YJK8tEXzTAWUwwAWpx7X6Ri5OY7PX/CoJYASU+xdnA+b7QW4HbV
	1rJJzObIt1jE24uiFt6al2m9H4qes/jebLoJsB0WlUR2hZr5nVSG8FJLSaqD+qgncRBCa+j1OC0
	kY3Ai2Kkv8qFH+nQDsrIHbnPCxXTYJzzUjnci47d2ghN3SPbKMtpntgWmx7uDadBRUguvccRWcg
	BCcExQns5VLG51yrFnv9Y3iXSW2MM8EmWdST9y5hEqEn7EP56tyrTHpSSeJYNzNx+YW3Dqx6hWA
	+SBwenMElp0bX+OHOODctV
X-Received: by 2002:a05:600c:574b:b0:493:bc4a:9547 with SMTP id 5b1f17b1804b1-493c2ba70e2mr90579005e9.39.1783073281155;
        Fri, 03 Jul 2026 03:08:01 -0700 (PDT)
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
Subject: [PATCH 6.12.y-cip 08/26] irqchip/renesas-rzg2l: Fix error path in rzg2l_irqc_common_probe()
Date: Fri,  3 Jul 2026 11:07:27 +0100
Message-ID: <20260703100756.238233-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23400

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit fb74e35f78105efd8635c89b39f4389f567edbdc ]

Replace pm_runtime_put() with pm_runtime_put_sync() when
irq_domain_create_hierarchy() fails to ensure the device suspends
synchronously before devres cleanup disables runtime PM via
pm_runtime_disable().

[ tglx: Fix up subject and change log to be precise ]

Fixes: 7de11369ef30 ("irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-4-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 82ce5cd71b03..5f67013227c4 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -578,7 +578,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      node, &rzg2l_irqc_domain_ops,
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
-		pm_runtime_put(dev);
+		pm_runtime_put_sync(dev);
 		return -ENOMEM;
 	}
 
-- 
2.43.0


