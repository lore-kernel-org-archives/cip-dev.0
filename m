Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F06C44508
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:06 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89968.1783073279865977582
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RrQHDcaC;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c59f740cso2551535e9.3
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073278; x=1783678078; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR+uMQ+QAqSWDconemkgtA+1H62L3pSnlBz1o07J8GY=;
        b=RrQHDcaCh7NnjanFSd3B16xWtN/MVL8p7Z+/luYR8EH5jLnRa3/rquukcD6ca/nZ4a
         2l3aukht/iKRLKVrbFhe8XAycrlT24tVlpctoMP64YyFYQCS3bZZnuRYD1Y0wgroXEzz
         XRibNka8jD8TNHhPe0P4tboWAxUpUPZbajk6SqFVedBoh8Xumg7Ex0sZFUMcnzzwlIhO
         zgYUf4ges50THy3mXD1DTFPoYU1vWrA77ZfVKe9T9rcogU6uQTv6/9BgGAIpCY7OUVAb
         Om1Cg+s3yXIne2ISoiIC29X85tIzKtWMsb6OWv5v2+reAAenZpcECw8R1rERnKhRVWXo
         bCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073278; x=1783678078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QR+uMQ+QAqSWDconemkgtA+1H62L3pSnlBz1o07J8GY=;
        b=hAoyTCCPFTRrJ6csfVpm0JWxkt8lWb6iIYhvkx392jM8FQacfDlEUGMPC17eRT2i2c
         Wb7PQ+t/xtC2EtdJkvYPirjTdKeTV+lHTvufMfGEli3q2v25Exip/hNaxH73pn8VTN1/
         At+ofpLUvpVp5gZCmXbzGQB6aO9NZ+BIVfBcWeEwvMwRco24NsMHxkbrAHedglZu5S16
         uS4ybZl58fDh28GRx2AAgHxs/ujgXG58KeYjEh1rf0DY+uPtLUSk95If4B2zmw1Uz7Zn
         fRIjdMaYt25ISg31skOss+qQUkDmjjTLV75vnnpeiVh234jjYz/1ljctKulinBZwTsfd
         gzxQ==
X-Gm-Message-State: AOJu0Yws/kzaqXmXhmVGfScW7EBLPvp+7WWvirVivpgYqufdBd61Zfek
	HrLBdcNFT5bATHAXFcvUqTaTXeEQ1p+RpW570TrvCbz+42TrOzCpZHj67L8cYxJm
X-Gm-Gg: AfdE7ckAR+k8IXJfyx3VfvC8Cnk5MUpZkM23fyXnHgT+/kImRFK843b32psxt5JOVI7
	R+lQUgg4IublY5YNAFGXVKLI+q+SY3nm8g8tezRnKQHB8SHVUpLQWWpZMtNfyU+YJWSDTECRMOK
	JqnI9m5DtSqNlyjomuYn8V9x7SYygkdKUrmeCxQBVyB9EFYzqI/Ew3GN6hypAClV80uiSQWjE8L
	wuq0GoJQ4ret7M6gegI1QqaL0VP2NPlu1vb5QxY11IKdTGq4OQfR6RrS2FZAhD2zFYQgfNlXbKe
	QXfCtZEkputlcanAY369Zx+tDDqEa9/zCibv2jDgy9R4i7zDlrTbq3hID73vHaQUuzXXXmhhbaU
	sYeyAd2IvUvzN6DCW3+K9mVnYsf68loEHxDTLdOird0oPaSFLLhJXyugX3FIJfP2s/pkZQiYORQ
	EE8pMKgDPHlck2rnNoucn3VnqhQKDcy5s=
X-Received: by 2002:a05:600c:3588:b0:492:59fe:4a15 with SMTP id 5b1f17b1804b1-493c2b84695mr127239735e9.24.1783073277753;
        Fri, 03 Jul 2026 03:07:57 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:07:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/26] irqchip/renesas-rzg2l: Use devm_reset_control_get_exclusive_deasserted()
Date: Fri,  3 Jul 2026 11:07:21 +0100
Message-ID: <20260703100756.238233-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23394

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit 78f384dad082af13a9399b14ff23c5ea02b0a407 ]

Use devm_reset_control_get_exclusive_deasserted() to simplify
rzg2l_irqc_common_init().

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 53272237d9cb..7cf3d6963935 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -562,14 +562,10 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return ret;
 	}
 
-	resetn = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(resetn))
+	resetn = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(resetn)) {
+		dev_err(dev, "failed to acquire deasserted reset: %d\n", ret);
 		return PTR_ERR(resetn);
-
-	ret = reset_control_deassert(resetn);
-	if (ret) {
-		dev_err(dev, "failed to deassert resetn pin, %d\n", ret);
-		return ret;
 	}
 
 	pm_runtime_enable(dev);
@@ -609,7 +605,6 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	pm_runtime_put(dev);
 pm_disable:
 	pm_runtime_disable(dev);
-	reset_control_assert(resetn);
 	return ret;
 }
 
-- 
2.43.0


