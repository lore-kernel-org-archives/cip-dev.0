Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F55C3ABAD
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:57 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.20311.1745934472011731437
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=J4cSrFs2;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac7bd86f637so1345475266b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934470; x=1746539270; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SK7pwyeZc1WmwoNomzal0yxKmrsSlIHgO2qSukFbaM=;
        b=J4cSrFs2/3mxoiYQncqaAvvbBzazQm0o8CdjJI0kGpjreujLmO5iva0JtLz2OEluyy
         VKqV55JfO6ZCyjzwAUkKtBULOwrtN7A49htMrjp+zxWVfS9mSm4ZkCH5kKb1zpIv4bpA
         hKM9tG7Q/VrhBa+5qNj0FSSXXxq09CRq1NDsIkq9YEvNj0U9VsW7KP/jNfeMQZvYvc1n
         P/IBGLhgyWpeO3qZdC8LvUV4fFFZbbVUv9+HESZhwhW+QmHX/uBO/4XCW6pwWCua2+eX
         5VvFq8hlhleUU5iaxtP1Jve0aUak4OqbHo3WTQgho4/LYMf5mGeFs7ERP+W2ZHi21Z3k
         uW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934470; x=1746539270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SK7pwyeZc1WmwoNomzal0yxKmrsSlIHgO2qSukFbaM=;
        b=DEfjN1kGdqkQ1I1D3vYjlsAv5slIqAsArlcckyVqXCtLaNt6HWEl5keEhLVR/90KS5
         U1449MfbfDGJOoFT88oOfnd9JlbELE3L/7kXbIawlaK8hCREVmtpht1CusM2X//JCEPr
         HfYyYvk9cYGjedWQSydK9p8lDv9RZ2ePwTvKViUzvUx4FllcUZFNsCq2bV7Q3Ez0mh4s
         wd7r10Vw/eIchCRJW/v/S6a/7Aamkk8VtcJmDEghcuzqkzUjdXPs4od3z3WFMLgBdsTQ
         cuP3Bor9LE4pxnraCet7zj0MuDAdg8pW9tezFkxwz+1zDjCfqP8GOZ8MRewOYuSY1PGb
         i8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXIjOhOly0c9JtNaSy8qZbmmdiKkxfq/K9qFNsusGS5XUNcTK0ds7OAn7dXry9A6fqNyLGEM87F@lists.cip-project.org
X-Gm-Message-State: AOJu0YxUftujn/cLJgxAeNEdnBaIRW2bhiL2/Tpcil1jFY7Dvven65N6
	aH3/CDgzybKxzPU4bchQL1nKP/eAmF3fOHUbmiUTf+q4dHPjZ6C3vRKPx18CGeE=
X-Gm-Gg: ASbGnctNOKrNflXwiadxw+53ZvOCHh9Ve451vaKTd2XkMd7P05U6V40jle1t+KdjOpT
	jbc743fRB2djCDw++aPUS519+T7aqa9YWjXNyze9nEk9cseXBET/sPzPqkvP1rFiCLIO6Tat1nI
	Eiesf7i7DzRG9aI1SVAJD+BF2k5tLCC/nBbzDu4Ed0myYq/I4Ady9Y/h/LqZgbl2tXiRrVGwalc
	VJyIRrW/3fDS7mXhOIYKk9BTbVutZrSSDUrSj5AZAWA02F0PseAjtMeol2F6BHFPX90DIIl5Ll6
	A3AWi/TZ4W5jWIQnm2JcwDTGmaYHgvSdmLgA05wkJSXNf5KQaSSqb6DoCtA0y5DS63JHrGM=
X-Google-Smtp-Source: AGHT+IGUpz46SVSB60UCvoAzobTDY3Q0q1crTtN18vToNjAkfkU8NmwWQU+ZbpL2JJbyBXz5Fmm78A==
X-Received: by 2002:a17:907:6d17:b0:ac4:3d0:8bca with SMTP id a640c23a62f3a-acec6c12ae4mr300801866b.29.1745934470282;
        Tue, 29 Apr 2025 06:47:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 12/21] i2c: riic: Define individual arrays to describe the register offsets
Date: Tue, 29 Apr 2025 16:47:18 +0300
Message-ID: <20250429134727.2429662-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18725

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 88c5cf45927bb43328b869b0bda7276e47896c44 upstream.

Define individual arrays to describe the register offsets. In this way
we can describe different IP variants that share the same register offsets
but have differences in other characteristics. Commit prepares for the
addition of fast mode plus.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 58 +++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index eaa11b3edd2d..bb1339ccfb49 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -92,7 +92,7 @@ enum riic_reg_list {
 };
 
 struct riic_of_data {
-	u8 regs[RIIC_REG_END];
+	const u8 *regs;
 };
 
 struct riic_dev {
@@ -525,36 +525,40 @@ static int riic_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const u8 riic_rz_a_regs[RIIC_REG_END] = {
+	[RIIC_ICCR1] = 0x00,
+	[RIIC_ICCR2] = 0x04,
+	[RIIC_ICMR1] = 0x08,
+	[RIIC_ICMR3] = 0x10,
+	[RIIC_ICSER] = 0x18,
+	[RIIC_ICIER] = 0x1c,
+	[RIIC_ICSR2] = 0x24,
+	[RIIC_ICBRL] = 0x34,
+	[RIIC_ICBRH] = 0x38,
+	[RIIC_ICDRT] = 0x3c,
+	[RIIC_ICDRR] = 0x40,
+};
+
 static const struct riic_of_data riic_rz_a_info = {
-	.regs = {
-		[RIIC_ICCR1] = 0x00,
-		[RIIC_ICCR2] = 0x04,
-		[RIIC_ICMR1] = 0x08,
-		[RIIC_ICMR3] = 0x10,
-		[RIIC_ICSER] = 0x18,
-		[RIIC_ICIER] = 0x1c,
-		[RIIC_ICSR2] = 0x24,
-		[RIIC_ICBRL] = 0x34,
-		[RIIC_ICBRH] = 0x38,
-		[RIIC_ICDRT] = 0x3c,
-		[RIIC_ICDRR] = 0x40,
-	},
+	.regs = riic_rz_a_regs,
+};
+
+static const u8 riic_rz_v2h_regs[RIIC_REG_END] = {
+	[RIIC_ICCR1] = 0x00,
+	[RIIC_ICCR2] = 0x01,
+	[RIIC_ICMR1] = 0x02,
+	[RIIC_ICMR3] = 0x04,
+	[RIIC_ICSER] = 0x06,
+	[RIIC_ICIER] = 0x07,
+	[RIIC_ICSR2] = 0x09,
+	[RIIC_ICBRL] = 0x10,
+	[RIIC_ICBRH] = 0x11,
+	[RIIC_ICDRT] = 0x12,
+	[RIIC_ICDRR] = 0x13,
 };
 
 static const struct riic_of_data riic_rz_v2h_info = {
-	.regs = {
-		[RIIC_ICCR1] = 0x00,
-		[RIIC_ICCR2] = 0x01,
-		[RIIC_ICMR1] = 0x02,
-		[RIIC_ICMR3] = 0x04,
-		[RIIC_ICSER] = 0x06,
-		[RIIC_ICIER] = 0x07,
-		[RIIC_ICSR2] = 0x09,
-		[RIIC_ICBRL] = 0x10,
-		[RIIC_ICBRH] = 0x11,
-		[RIIC_ICDRT] = 0x12,
-		[RIIC_ICDRR] = 0x13,
-	},
+	.regs = riic_rz_v2h_regs,
 };
 
 static int riic_i2c_suspend(struct device *dev)
-- 
2.43.0


