Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D829E105D29D
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:29 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18652.1773227059206588550
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=N/cVgoGu;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48539d21b76so26470035e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227058; x=1773831858; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mQ6YmFWX5oKn9DwqKtC5Glr74QJ8EKG7nz630UR4oY=;
        b=N/cVgoGuWmyByKBoarVH9JPyEt7bwxNs8RxwUUTEzkjNsGjiPFMIcv6qsazGfbx5QX
         115/o3m/WLtsDI2Y4AoXPq9QxqxmaK1VAU8Gba6HQyVmaF4n3dbKiarqDjETHwmcCQCS
         l4Nd+HlgqCL7wCoVS7z6LUPciMqK8Qfv8FcPrWRX6ALj6QRqRYlrrbzgSK9cR/p2iY7M
         Oey92u2JZ81+YZdLFjs9zzUAzGPytQPYO/g/hOIDZM2K2nuat00RAUpnkfjfY2p+aAIN
         mTBHuW9UbqPHfqC0MdqJGtIkC80O6/MkiEITPocKPScQVpLzME6jasF+Gqo1JTjYcO0K
         7WyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227058; x=1773831858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mQ6YmFWX5oKn9DwqKtC5Glr74QJ8EKG7nz630UR4oY=;
        b=hg3gtRIGrp3bCgFhWixrDgNn+c0TFtVfYRfefuCMWFbcqRu2KOgPxqIBbVIrqhCXOp
         LDoCDIc20xjyE098bXt8OkjWSd1VXmBXhmpHE3/VMyzCmdjUejAWw76utHW8SkVJmiw/
         QM13LJQdQzwXSjg7y2kVLk3y7nSpOI4EiJRS6CJ0mYDhwT3HeVoAeBc786f7LjiZPldJ
         csSwjg/97dJ1i6bZJoL9O3C6GHaYssqjGWleQx28rmKjmbeKAmhz7sbXsmLHyqxgk362
         v2bFcr/jq133a3gJISS+C2b6tQ9W8GSwVrhU7nt5GuoeGIkONOhVJ5YtO1F9wPafOAlj
         ILwA==
X-Gm-Message-State: AOJu0YzQRTCUzT1hmMU5yx+Pc66dmrNiOyOE2vKrdvmZWpUXkcQ5uoRE
	Sm1H+jDfWfIozSR+3Q20ASEsQFiQIckmVjwLRS6+Cf/wGZi/PHzwzZrp585SJNgcv28=
X-Gm-Gg: ATEYQzyOKdBZKjmU0F32h3/7MmQv2vuXrUhXCJgyPVZ7cGmZT04dl1joIj6AVhnPgLH
	VEkGgJFAHgvqc3an4+fpZBQE2IXCbLd8Nxhp1Vp1VejOUwqlZ6LKFhcYIo6xiyOfYio6gnt1+aJ
	VpypnL0NceE/1YJ0IPnRu4Mbkr4J9hC5NNmYTKHR5S4CxT8Z2j/TrYtiLBb/I5/irnbWQ/CW+Up
	UtxaUhwv3ALDhigC51lKj77VzF//vXV8bIEax9vzhegnM9hTnsBBO2xPAtkEO8fedysqr/xrSCn
	D3A8TbtNWtkYDzLeQnI7YSAkiL6w3yWOqsuZqm4FVjBVaD/++sN80+C+Ga6NwNryjpKAFH/GTGg
	AUM91KO0jHrZZzIyvsotFAAxSL+ral0vUGKSHsajsWwCRyBE3jHtfM+rVlaSmMcOZbkZsisLv15
	45XL5g3KpOElsIrBvwA+O5F12tG/r/KxfrNIUpoNEwbv0BI2wgcny0
X-Received: by 2002:a05:600c:8b0a:b0:485:3ae8:2236 with SMTP id 5b1f17b1804b1-4854b123cd6mr34473955e9.32.1773227057614;
        Wed, 11 Mar 2026 04:04:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 14/28] of: Add cleanup.h based auto release via __free(device_node) markings
Date: Wed, 11 Mar 2026 13:03:43 +0200
Message-ID: <20260311110357.1938200-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22293

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit 9448e55d032d99af8e23487f51a542d51b2f1a48 upstream.

The recent addition of scope based cleanup support to the kernel
provides a convenient tool to reduce the chances of leaking reference
counts where of_node_put() should have been called in an error path.

This enables
	struct device_node *child __free(device_node) = NULL;

	for_each_child_of_node(np, child) {
		if (test)
			return test;
	}

with no need for a manual call of of_node_put().
A following patch will reduce the scope of the child variable to the
for loop, to avoid an issues with ordering of autocleanup, and make it
obvious when this assigned a non NULL value.

In this simple example the gains are small but there are some very
complex error handling cases buried in these loops that will be
greatly simplified by enabling early returns with out the need
for this manual of_node_put() call.

Note that there are coccinelle checks in
scripts/coccinelle/iterators/for_each_child.cocci to detect a failure
to call of_node_put(). This new approach does not cause false positives.
Longer term we may want to add scripting to check this new approach is
done correctly with no double of_node_put() calls being introduced due
to the auto cleanup. It may also be useful to script finding places
this new approach is useful.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20240225142714.286440-2-jic23@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/of.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 65c0e3105809..5f4dd8db7a67 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -13,6 +13,7 @@
  */
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
@@ -128,6 +129,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
+DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
 
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_root;
-- 
2.43.0


