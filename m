Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF31DC369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:17 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.20317.1745934487795584406
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eQwPTEW5;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1306717066b.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934486; x=1746539286; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8n0o2kOkz/U+WEmTD0xJqREBgo6kThL1G/8nceLwVw=;
        b=eQwPTEW5f3cKAjIyH0rU3EYjmpDYWaYcrvYwlRu1k06db1Ici0Vnp3PUI9YoanRVX5
         fXcG9Sd22bhkd80agG0wbG2wEH2o1vLNLqZ6v32bLP4FFJ7gAYE9QojhlvEfu8lulo83
         +LIgCqRM+gOm7LfDZg4ltxxgbEPh9KrECT4WEMWEWoE5WyxMsO2QqSiKYQ/2wTnIcay8
         i+lRyoBOWbCf2S/9LdhVFDn99U/FH5WuXStXyejvbb0gYzJ7i4/fdds3Xm/HsagNfh+V
         882ZcVjKlvtU/C/Fmxo8k1NQOkRIiBtmP0aPYf+zoMzFQHBfUsslEMj1cxaDnoghhGyV
         jvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934486; x=1746539286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8n0o2kOkz/U+WEmTD0xJqREBgo6kThL1G/8nceLwVw=;
        b=FKmUUUaR3lJhT2ln5dM8NHMNcj/n2vN1tUqQBgWeHRsRJ3DA7EdeUJ2JpLX26DO3sg
         qEdS13yhGvQ54AMbf+HJvhuWwBV4M17IGkTYIIe7tFmFqha0+m0pqzdrE9JKXK0daZAB
         eXYPhlx5TEQVIE1ZGoi7IPCvxGNTJGgzeG5W8voAFRb2F44mLCp13VCuR+TJDDKBKJKR
         Xq9vlg5hJp+BLFFow8wZTHs86SpYsL9zdAKiioZjDiIuGNosqikktusJPjVf6QYe3VkT
         NyoVeVdHiJ1nRmUHNwX7qLIopDgDRBotMeZj9t73nJDwkUtzfW5/1wG8zAtEetMwu/e0
         geMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdCRO4nhawVKEW743H/g2/kcdl3C3LqtEFjRnOgXU9lrWb0myNlW9O4c0zkzC4g1xavynmSgvR@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw+jLml8iKs2DDqL+KmChZmBYP/B+8vNV4UArUa17cfVOEZomRT
	e878UEfPIvsnbpywqlyLHc6b8fH5STcJg2RLIBpSViBlGrpmGfV4BPurFpGJg8o=
X-Gm-Gg: ASbGnct7JYYntUEXD0Dlb74HKVQeuHu7Sob1EwrnQ0IuTsv0t3K0AJAsAgtLHFy+XET
	IUZRAfeMngb30tlNC9UoMNyPj5yPrjbK3XF+BkfTdIG5dR9f0WEPGgYTHjDX4ZVvZHzHsR6ZGvS
	LGDOfy1duVpSZyF5XniaB/exDWv+/8K7rUF0Bo2EwGbfkhfPAZ+4Std6uCvZtUGsg0q1kXdE1i2
	PzcvKSVphVvHB6nMRqnA8PWE/eGpTlqVnp5xIjQUsOEycQFs8YccChpvJDUCZRmTAwH2z/GI29X
	wFxfTPpB0OTxtvf9n1e137dyuLsC8zRya9I5LlPx2hYZhuqGU25lz6ytbKx3kMPBuCBGmaE=
X-Google-Smtp-Source: AGHT+IHQZrxzO61DcQ073eN9+8uCJmAieHu6tqBgVZWCPENNoimYSvajscJHJJQrKft5XmUhCgIbWA==
X-Received: by 2002:a17:906:9fc6:b0:ace:8004:2a87 with SMTP id a640c23a62f3a-acec4e05464mr362298366b.16.1745934486168;
        Tue, 29 Apr 2025 06:48:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 21/21] arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node
Date: Tue, 29 Apr 2025 16:47:27 +0300
Message-ID: <20250429134727.2429662-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18734

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1670b7cc71dafd8736f47925a93dbae71093059b upstream.

Enable I2C1 node.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240820101918.2384635-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index b07d9251d182..0f8efaeb163b 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -33,6 +33,7 @@ / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
 
 	aliases {
+		i2c1 = &i2c1;
 		mmc0 = &sdhi0;
 #if SW_CONFIG3 == SW_OFF
 		mmc2 = &sdhi2;
@@ -151,6 +152,10 @@ &extal_clk {
 	clock-frequency = <24000000>;
 };
 
+&i2c1 {
+	status = "okay";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.43.0


