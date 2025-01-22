Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EF1C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:30 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.41684.1737546688139812310
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hvIDW+qK;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso70040865e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546686; x=1738151486; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyh/eCeUAKyxfgbv4E+U4BbnwMoXJ6eA0t8m+1CZZmQ=;
        b=hvIDW+qK3trx09Xa+DeU+RoWDr2KqBUAbflT0rwq9aMhCP98tMC4t7L/o36OfrpH2t
         F/Dda3juXij9L7BQaRhdAXAmZIG3q4g/UHOjE1O5dsdgaYCj5wZhTC2xZnRT89uLyZ7i
         +H3R9k0+m16H67q8gAuzFsWlhE3DGsOzWAvPAJZoa7ycpFinREBEAMEyZ1utpIpFDhyJ
         c+73q7DOwUpAWZQ8cbANPZMS0lxKg9bX/yar7lu08DvastUxxqfkkUmFppsqF2NVEVCX
         bWmnI5T92ONeDrnhn90vrBEeWQnNuOB0HjtcVr3FcyzfK0cJLiMOAJCb5JJPjDOnjDdf
         5aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546686; x=1738151486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pyh/eCeUAKyxfgbv4E+U4BbnwMoXJ6eA0t8m+1CZZmQ=;
        b=pEl+rEceQ309fTQ+LEQAugTks0OQaaMUoaNYKLTh6fdYpPd4W4gyOM68goL+6v9cMk
         fpaAQ4XUuHfpqaY6naALcf+/ouUx6JUlKdOnq+2UY6996zl9A8R+5FgrtM3xndOeOc03
         7gtEV66ZQ9cZqRutPFDYVyYqRiBQbJql+przAM4ulLdCGKkO+yBiqWUrAUL9KKk6iEy5
         0xVRmqNr02OJ3rupoV0sdECUvkjzShRcN4YO087eSOHaj+dNEtzogUyBwJRW4SpKOSvc
         VovrGsdKpN1r50gP/YpslXgZQPZmMUe4R2ZboPlbtwV9uJJBgv7YjbvLwF4RrlmlzCLB
         2TLA==
X-Forwarded-Encrypted: i=1; AJvYcCWIowU3p35jAsM6EAnQr5CAqeJuKbAiaxYjoBpwjd0a05sLlaNGvYYZGsHqBUuPpxTPgIvoGE3V@lists.cip-project.org
X-Gm-Message-State: AOJu0YxwBzEdF+lTN9GC5Xts6EsMOZQSKiKVuCkTt2zrrn/2yg3GZKyV
	5awLwr9ft4tMsSFsy9ZFDtYxvcMFvuqYuUoeBD0qepQ31ROFMTspKX6RlLIUSHM=
X-Gm-Gg: ASbGncvT1oddu6L1RRdQjUT977xMApLNqZ4jtErkoDSmarwNnmBjaLA/0dU5nmPTPiv
	u85MMKxoo2r5+u8WmhAr8LJ3/6TZiTg0upd4k4ejOXDTiBFdjakrUct8eu3ZWR2EHIclNkuplWc
	h9AKJjyPNCjsvBcb3pN2Qkiglhi2XQB3q9quFd17kmWMEcvRR+Br1e+x6cRS1d9oBbPigYJGeuN
	UFmo+vCGh00w42m2zu9YDY/13VG6YWUlzPrxUB0+TVfK77q9++oKx4pULCsxPyc8rwFSuZaUjZU
	VYfWJrcHWFoXSqDd5LhTIsw=
X-Google-Smtp-Source: AGHT+IFNvgw/j0KjLeEBx/dlBaviRPBh8R5ch+16pXNaRP5Opi8zmrbb9D/SfNLn7St6IwOjz0v1CA==
X-Received: by 2002:a05:600c:1f8e:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-4389141c352mr163812375e9.19.1737546686609;
        Wed, 22 Jan 2025 03:51:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 03/14] clk: Add devm_clk_hw_register_gate_parent_hw()
Date: Wed, 22 Jan 2025 13:51:08 +0200
Message-ID: <20250122115120.2885015-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17566

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e1ef630c56d36770e180f0d0bf7b61b5289f5c48 upstream.

Add devm_clk_hw_register_gate_parent_hw() macro to allow registering
devres managed gate clocks providing struct clk_hw object as parent.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/clk-provider.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 19bd0ad70b08..a0c7ff8d8928 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -606,6 +606,24 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	__devm_clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL, \
 			       NULL, (flags), (reg), (bit_idx),		      \
 			       (clk_gate_flags), (lock))
+/**
+ * devm_clk_hw_register_gate_parent_hw - register a gate clock with the clock
+ * framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags for this clock
+ * @reg: register address to control gating of this clock
+ * @bit_idx: which bit in the register controls gating of this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_gate_parent_hw(dev, name, parent_hw, flags,      \
+					    reg, bit_idx, clk_gate_flags,     \
+					    lock)			      \
+	__devm_clk_hw_register_gate((dev), NULL, (name), NULL, (parent_hw),   \
+				    NULL, (flags), (reg), (bit_idx),	      \
+				    (clk_gate_flags), (lock))
 /**
  * devm_clk_hw_register_gate_parent_data - register a gate clock with the
  * clock framework
-- 
2.43.0


