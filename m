Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0815AC43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89132.1783073281970989484
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=etIHXI8F;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b691cb44so2619485e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073280; x=1783678080; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUZ9LWE8PhO7aEhHDdvHpC2pxCRcs9LTMwlsYYtuGgA=;
        b=etIHXI8FsO+jNt2uTuV1VpU8aF0jLgxismaFgyyFdL3+wxdciUpVKjx1NuBtmj4w9L
         28xBjcVwFa/MdYqnVt3+JGEHBY5bMXlo8EARHa0BMfnZkO9fcZcmdwYiFFBekxwZGifN
         Rf+4Fw4SfeH+e2ztyCcqoG+5CaO5cAS3FWydBRxYiGXrqTKXj0FY2n/tkcakSzIOzhOu
         iutop+YLnidE+QtwFV0jiBxtCvXn8fvbe+OLObsrwY5Hg5q9DoDtd1tieMkhAnXCGFcE
         ZW4nZErBA0IAa88EuSlYvg/71A+WTqXs6E6ADsiY+qrP/cTl5RRnHsJbKwRYmZe2rkUb
         HOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073280; x=1783678080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUZ9LWE8PhO7aEhHDdvHpC2pxCRcs9LTMwlsYYtuGgA=;
        b=YKNeF+vh78KGYWXo0dqo+es0CtMdmKIqy3KFVmvXRBRGFm2pMKgbU2Rl3Z2FEdsyT+
         7ypP0UToYfl2VWvxHK9kbRwCrx08j0jFFo3quUVmToWXVTY4DsBmjUtjJy/B8Dn+ayxO
         4V+KMIiLK3QRM7FZzeqJIcVgItP5vKj9N7jybN0Dli93hU/WRh0E6pkByqEiEdFk1eOe
         9/2Ex84eW5M6KqyZjK1HQT5+03aQmRwymUAn6C7pXNHqIL1j0EyzZ3D601yAoN3+quGu
         7+wnV2d6ocOuRl3mo35q8bUNispDp3k1D52lwLKoJFMHpD3jax1eJAegCbSOk4W5Cf+x
         iXIA==
X-Gm-Message-State: AOJu0YyMiQ4aasvpz1VmpWZUPGf1Z4gCC0qoDy8hCaFiHIqRkatgD27E
	GpadBmqeCkR8H5rZqrDiWfrr2EaPNdDozJxeyzVtyff+FLqxZqOWZ8IR9tbMMbjo
X-Gm-Gg: AfdE7clfL4LV/xRR9E3GevWfcDk9k4R9drizSMIFMP0WS68U/u+gon84fNdpkXd+iRq
	bWDCyeeRvMHxs2cS6zNfd4aj8qqwTk3e3GMFQ/dfkm7SHsUz7lEd1M6sp8iNpJU0BnDa9KjSv+5
	V+sjPWsU1QPDQ6RUCIsl67JaZxoKULftnw5ClcEZZyzJLQwvOZE3knBeKU6TRWckify7NrUe0ZC
	2apAR+BW0HHoB8WHCv3Dc/r7l8PDpfg27Z8GCN/Zfv5x2XP4F4AJv4xIGZ+yuaznLc8F4nRHA4a
	M/DnsJSh+YJeIFDuPK6BzbKQ2NMQ1NUX5bAn5m8iOT0sladweRUCEVpo+H9cexsSkcmRCEHpi+5
	F/X9igUiXJvYbU9h6fsQU7my18ICff5vnElReuKDOQsWzzOK3zZ+v5DfgyjOjv53e5ole4ANwNA
	gvd7GLAzWlnqloQBBRq4UGkKfsTPrUhZ0=
X-Received: by 2002:a05:600c:34d4:b0:493:a5d4:3798 with SMTP id 5b1f17b1804b1-493c2b3a6camr134285365e9.1.1783073279969;
        Fri, 03 Jul 2026 03:07:59 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:07:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/26] irqchip/renesas-rzg2l: Simplify checks in rzg2l_irqc_common_init()
Date: Fri,  3 Jul 2026 11:07:25 +0100
Message-ID: <20260703100756.238233-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23398

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit 0699e578e27910224ee09a55b824e5d494ce280f ]

Both devm_pm_runtime_enable() and pm_runtime_resume_and_get()
return 0 or a negative error code.

Simplify the checks done with their respective return values
accordingly.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250212182034.366167-7-fabrizio.castro.jz@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 1f0b83a00637..71635c6d9232 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -565,11 +565,11 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	}
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed: %d\n", ret);
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	if (ret)
 		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed: %d\n", ret);
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
-- 
2.43.0


