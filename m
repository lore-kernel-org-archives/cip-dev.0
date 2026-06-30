Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC243C44503
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:56 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19427.1782820130167665933
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cXn5dZJr;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-463f1165e16so4461159f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820128; x=1783424928; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNBZbbGHHPgQdFdDoYRB7ZcuS4CZUIVCILv7FOHSi0U=;
        b=cXn5dZJrS2ssobpWeN/x+hDuIwz1EXRhyonMlutF7MV1cDdBXlcc1z1o8nz/4thoFx
         TqT3hvS7NpfNshs75TDAbyFSzBBw1qiOdn6QW0OA0p1Pmge5tZO6dHXEvJYHjq4vmisz
         LpQ1rY47Xg7/FYce6lRaK5ZEg3kWIm4nfvfb0CRi4EBPHrvfWbEnOkU7KJts9wkvL+Xu
         J2wX+3DCRSGxeNXuzArLTU7FvmLVrhpEq4BDEyNWt7XrRotzwTtB/KmxJDaCi7eQ7Y1g
         zUsm9btHhbVs0w22od8T9/3l8WGVU24Ry0zM9j6/xALXBUH8WGnpELBh4ojOeRASu/rU
         iv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820128; x=1783424928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNBZbbGHHPgQdFdDoYRB7ZcuS4CZUIVCILv7FOHSi0U=;
        b=QwcGC/gRVO2fPY2Ipk6qYY0wmibpyXSfGcBdPgA2YbwbgRqIS4rKHo/bEQk8W+QGoH
         oCtN+qT7EkWiHhByFFv3lEb+Cjr8mAS0VYUJwPD/P3RYHuzUtUyrSYEjgtl077i/ln36
         XfegjQZkk6X0CNuTA2wxuBXwAzaRp6iBy7CrP0RNcRhkdg+PxosKKVAT4Uok7Z85eI7B
         ZE5VY2RA8QqdEYYFseNw0/oNA8Qk/62AWNjloXAC07NeyIuoeI5Mtas4qN1rOZ4/n2X9
         PJVlLZbX6f9QMCAJeORQ4A9Zn4/ZZFZdva5CvhY6KZwM036hN2+HAJIqF6ot73n7guRb
         TNrA==
X-Gm-Message-State: AOJu0Yz4p1MUV5n9KaOsAevo9QRxeZ8T/TWIfnOWYESSiL+MZraU1/eo
	Atfhqilrny1DC38Y+nlVK5j3VGoFvN4nCdg8m0GvP8Wk76x8bKxlfBO30gjyqjnU
X-Gm-Gg: AfdE7cksg3dcg+JIn8KzLkFN+I2dfiU5HrbiRZKePBIzqiS+xR1vLEeWDy6MKF9LgAb
	5R5HTbRHhuSGzpyRn/0Hw0Ng/Sk5sJtQAQdU2NCmzDfDCB/W9Jc5UhvZOZ71jsYynSp6coJVPS1
	cSihHXfUnXD2iB3741dERVwD5Edj2I4bQuNv67hNVYF1fCsrFcx20ltgHpdI/zCkAnzvNGBBG/E
	zvE9SHSV011kcAB52wB0/K2JEOYX4wSrgqDNgfHkW1vhfnc12JSBVhmJws8vdJNlJr+pdOm36qe
	RZ+a0n9bVX+codz4rnrz+zXtkcPZPmN6Pqw0JDU4xfNag/fDHCrpeOHU86qSzNDOG3zr2JcCwYj
	C276ryUGKNWh4Bsn0jeejMKgAc+ksmQ6BU8MaEZsyTTrOmh4DbbuqH3nGme+nDxbG8zcMn9YMDs
	nB1zo/MkSZSY4yAZzYJlY4hC1zTemuxzthnC6mi3s62PT0BSlL
X-Received: by 2002:a05:6000:27d3:b0:46f:3046:2bf1 with SMTP id ffacd0b85a97d-47550da03cbmr3137181f8f.13.1782820128265;
        Tue, 30 Jun 2026 04:48:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:48 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/39] clk: renesas: rzg2l: Deassert reset on assert timeout
Date: Tue, 30 Jun 2026 12:47:33 +0100
Message-ID: <20260630114813.92739-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23338

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0b0201f259e1158a875c5fd01adf318ae5d32352 ]

If the assert() fails due to timeout error, set the reset register bit
back to deasserted state. This change is needed especially for handling
assert error in suspend() callback that expect the device to be in
operational state in case of failure.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260108123433.104464-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index bd562aa6f301..a7189c32849e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1760,6 +1760,7 @@ static int __rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	u32 mask = BIT(info->resets[id].bit);
 	s8 monbit = info->resets[id].monbit;
 	u32 value = mask << 16;
+	u32 mon;
 	int ret;
 
 	dev_dbg(rcdev->dev, "%s id:%ld offset:0x%x\n",
@@ -1780,10 +1781,10 @@ static int __rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 		return 0;
 	}
 
-	ret = readl_poll_timeout_atomic(priv->base + reg, value,
-					assert == !!(value & mask), 10, 200);
-	if (ret && !assert) {
-		value = mask << 16;
+	ret = readl_poll_timeout_atomic(priv->base + reg, mon,
+					assert == !!(mon & mask), 10, 200);
+	if (ret) {
+		value ^= mask;
 		writel(value, priv->base + CLK_RST_R(info->resets[id].off));
 	}
 
-- 
2.43.0


