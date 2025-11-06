Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227EACCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10060.1762416661382786316
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iQOZW8hY;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711810948aso4193735e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416660; x=1763021460; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CbSCUiVXd3UmEiyuTweiB55o9W4Xbnloi3Ne0sXyu0=;
        b=iQOZW8hY9LpUCKlqyfuN/4ySyKMDL1rl1A2WJrX6fIPYUyh3/hrB3By/m/DxJeISuJ
         SXxXHClCJVr2voA1QTug83U2F8c4np45pI/oVpUneaY+CqZ2zFSJKiU7rxY7vNMDonuz
         xM6H2c0h+olxbkJdOBrQZL8mNAjPyVFMc3syHR1stPLP3sLTRS6RSkD2vlkokR0uTj2K
         HX/+5BoG9FaBz/EOuLQ+Sn6mHRlSDm9kSKt/1cucA19WX3FnzqNQaGP2EMFtcXb7TDMc
         qS+ajnMtJMV3t8YU6beKJS8ZViLhQptE9zzxKRf0E5as0bFsBK42TUYsPBei6XcGy+gT
         1wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416660; x=1763021460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CbSCUiVXd3UmEiyuTweiB55o9W4Xbnloi3Ne0sXyu0=;
        b=cxiTV3u9rS6yTlrgaOwLEN/EBTKPdjn1GyeJIWy9uX6Ifc8fdBTMg6il+KnZX9T2Zh
         C+OMA3LE7b8TVknTNZl1IwAxNABN3SWilrfLHvK8oLki8Q6IijZqrntYp4LyQ9o+HgNt
         vBZ52MuPhiQQlXk6enNKE8EbsHVUv+01Zw2Fxza0aakKLIbn09Hof4kIS4h3SfHhZdsr
         dhMAjgAbcvlWiaY+iAQ8vgpuPP1I0l1XVMWr6nHe8V+CyExY1+oOD46NV7gO9ZjLHWCe
         sYDDFSukgeWoQqRbilH+r4jIWiosrWgpNdO9Pg/qlcpBNUJgB0N25CSe1I9bMst3omnx
         Dzxg==
X-Forwarded-Encrypted: i=1; AJvYcCWPwP1aFy7PtKu0UKeXVLZfdamHMi89GOKZJeS9/yLUaQOAe38harvOLVlQHDeMafYrFGUqaMJS@lists.cip-project.org
X-Gm-Message-State: AOJu0YyZswp2Xqt4D6zABaCSQz3h1ywGagw9dwin3idpOMe7h2sgjNJc
	oDIm3YAoNRyMloXuvO1aQ6hrMu6KvK19uh5np0+2c6c03lWLkv9Zq16JDbns1gGR5Ec=
X-Gm-Gg: ASbGncvPG8n5h9fsOs4T3pnDR+rraQue6qe3azkXZdRK+XzSjLMCqUMOtwIQBji3ALd
	6L6WV8aFdfwdLKpynX01gQj9tIbEKQlRb84gjSmnoMsUeHibgOulweF9MlbO6+DPcZCVWCeT72r
	FRt/oP/X8V6lP3DcQpG4YM/skPjHj41qAbM0k77FZGsk7IyokB9LsTAmUTJwb7SaXrRuNopMZ4f
	D4OxMMbWnS+ypUO7pMOmL56Em8PnfVnVMEiDuPsiKiAdA0FdQI4Ms09/AA9n1dDXOMbRLRQkbTm
	kVc6eZ0T1jdKe+1I1VqIomZGuBVn+z2Dx4hqdfwCkYFCqpd4Xht9/MufRBbgCkJx1KJK6+6tLcU
	cnBlCNUkjRROxp591O0/xauAKuyU6uwpSJ0JOSXEGH/qeg3PaUicnuysmmELtRgTq9/1XCwv3S4
	NKocKD8lqks/EZlDt0WfwQQKr6xT7R3jVDvdfNYOEb
X-Google-Smtp-Source: AGHT+IEcz7CEiT/+gKcHRP2cXH5dONSeIy/j8XX2rA4R3iURYvykjwS3ymV8J1KWjeUQZAEl3yFDxg==
X-Received: by 2002:a05:600c:450b:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-4775cdad63cmr51974445e9.4.1762416659770;
        Thu, 06 Nov 2025 00:10:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:59 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 08/23] soundwire: bus: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:33 +0200
Message-ID: <20251106081048.2574345-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20377

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 969bf687c12cd9f64ed9368f0c7429445de7c10b upstream.

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20250827101506.927787-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soundwire/bus_type.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 9900cf0e6f8d..24041aceadbc 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -175,7 +175,8 @@ static int sdw_drv_remove(struct device *dev)
 	if (drv->remove)
 		ret = drv->remove(slave);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 
 	return ret;
 }
-- 
2.43.0


