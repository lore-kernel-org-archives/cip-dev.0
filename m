Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0C3FCE08C
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:28:53 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78613.1772134131082026923
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:28:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V7g5JYDX;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so11270815e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134129; x=1772738929; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl9OtxKERrPtmJMK6LEmPKPJ53L0LJNFOCVINRklyiY=;
        b=V7g5JYDX97BXdxeSBG8GpSVuh+DdrulgnGviDU9//eAs+NF9h5A6KaO+XO5kTaMlsy
         XRThFXc6j0P7gczzc0VBmIJjDldDzufMxg1V1a73DT94iz368BJUF3MxZnSAwEGaQpPs
         bro5UrFWiX0hOZEYX+ZG/l3TrQTot2l1qHiK4TbRNTASNC2/hToLw5mNaarLdGqv+Hf/
         qhG9tYV8nfi1OUAF0BIzjyN22cqy4X1dW+eoWm20uPGBrfG0kSc5MZgiwCvV+MNxv8qS
         9tcoyqWEWEldwV997WmuhQKFtv6LnZP7pnPcZDGy7DgQNPV+QVN3/I07X3gMHj1KmHrL
         sGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134129; x=1772738929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gl9OtxKERrPtmJMK6LEmPKPJ53L0LJNFOCVINRklyiY=;
        b=In/5WYWMOMSeo6OdfbOvmaJCf05JfwRGzxIPBWXzouZMaJV6TrrjPuHR5BhU/r/ufU
         2FkQSq/4GHH9OBCPsWjnHbm08w91iZIGZLb9/Lxs70ZFd4gMiLlMc9nyYdsB9Uejj07Z
         U1FB9qa6+ZGQlfdahjFyBiHzKiIpApDLd+VDkdZfO0yfSbr9UkfVV5f4aCQDcs7hDfOB
         AC1VoMqvf2EfEg4SaostocM3yW8R5zTt7IG1kCbTwBikL5tdyzUB4dI0kfx9e/R00gT+
         k9/u+MuzUO5L2PgqNzqqbXK3vP1cC/rWMAsWDAqQqlbuGgNHovdI0bE+Ltv7pCYFviOg
         AnJQ==
X-Gm-Message-State: AOJu0YxNYEnAvslmm+oCjI08t5jyWrxjVL/eQEh2RlDn7PWgqZx2/WxK
	ymnYAGR2OFYsk/MKe5MHvwNdaSs1OmlqCi1fC4guz3uFwNNdvYhVeE9R/d+hfri3
X-Gm-Gg: ATEYQzxAE3+sVxba8akCpo/JIPYDACTbXsKTXnKrQZykPKtJmWAeiY4ZExLGSYGU7nG
	zxEUL77fG5tCma7scRRlLm2mFY8ciAW/hd+QMXELgAAvbKERrLKjoogn9dpF13CTg5c07B+QHf9
	owpLy+zmZET6R0Zqmv5Yjzj2KJ/PmK1kKo+KiNz56pvFlKPn/hzBhORqO4Ykr6hl9XF42G0e/GH
	FECnTkkenvTYdwoGMdZxUWyPN45zttSiJfoSwOpw+RstwoAS0f8qOK6jqzVoSAwb1DPyDacc0cC
	y2wR+788/u8t2toIp+A6eVCUA8eKCSxlTG1g7wyuFk7eiJcpCvOCkjG4AuqasI10k5Tum+6WRj2
	KRK8ymJWV8ZZhbclcI6xCM123Cvd0/tzGxXtKNSO/Yalgz14IJ3bAIvvnHYG/hUl8NEDaqlxhIg
	Xd9DASYDQhzNsz8ohSIGjqqFcvr027ZH5c2RHnevqTEML7nGo=
X-Received: by 2002:a05:600c:3b17:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-483a95b15b6mr362366135e9.7.1772134129183;
        Thu, 26 Feb 2026 11:28:49 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm76701365e9.1.2026.02.26.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:28:48 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/5] ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
Date: Thu, 26 Feb 2026 19:28:39 +0000
Message-ID: <20260226192846.449277-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
References: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:28:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21998

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a472f0b157832fc91c83179b1628d8f660c84c82 ]

Remove trailing comma in the terminator entry for OF table. While at it,
add a space between the braces and comment block.

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114075856.4751-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index c5658fe0aaea..7ffe26c17433 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1252,7 +1252,7 @@ static void rz_ssi_remove(struct platform_device *pdev)
 
 static const struct of_device_id rz_ssi_of_match[] = {
 	{ .compatible = "renesas,rz-ssi", },
-	{/* Sentinel */},
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rz_ssi_of_match);
 
-- 
2.43.0


