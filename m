Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B2C3ABA5
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:37 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.20364.1745934516068163056
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ldouCF+x;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ace98258d4dso508201966b.2
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934514; x=1746539314; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8n0o2kOkz/U+WEmTD0xJqREBgo6kThL1G/8nceLwVw=;
        b=ldouCF+xS52Hgb4pYqSISpqTLFg1KufBQYlT7tKo9MmRaCrZ8pXZh6c1nkrrLdGejn
         20M0YADl+pt/39cq8zwbzLM8eWaXOWByZjFQZqDDByw1mxjx363Je5puGGVFNNYAtTgb
         v2mKYOKKgJt/p3aBljqN1Ta5sNXS9mGTBMnoT1iVrPCXNqz7LneqD/FLZT2rx/1uTp2+
         obk4rJNTQs669/IOMZ4IJnB3deX2ZC5/oPjda03HQFzzxNG8l6sS95+sutJt5Re7x4Y/
         aDHnPLeOvYDzZ4EpwlJFMTaPaFwbkVRGbT2r1BEdNsdb96jetdEwSQFjZtOfkgXA7Dm/
         y6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934514; x=1746539314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8n0o2kOkz/U+WEmTD0xJqREBgo6kThL1G/8nceLwVw=;
        b=uwYn3X1RNbfMtRkYxmhSYatCTtJCA4/22kX+Yba/tUZ/AhGCwHxUTM26RsJpPJaAMH
         aRlZkf3jV3KFdHHFttI7oWArVe+EWEDavNo5P95k6TBDtFvdhMSbu5pbqZ7EGlNH2HIc
         KNxY0STFhAi19MhEUTsAJfuEpvhxeFqMGKFEN81gM94pv5t4oYX1QTvP91DK0/VLOKZ+
         gWWSj8SNeFA94OxaqJ49Cq+50Sh+Anvl/Iuj94jd2eU5Zq4jriuDlYqFekZPUxCDZyas
         dDeIk7w96OhCK7BhYQ6vSMVRBEgGx4SdJvm4hXi19mL4N2RKpNK1KvewcJ5f/UBw3YGC
         BOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzbsB178I7RRxKaBZRpXvv0QEz+6OU+uAFGNZ2SSqwXQNiOFSfkXeNJvTg+0LfyyVbDfSjWzgS@lists.cip-project.org
X-Gm-Message-State: AOJu0YzwIaoCyBWYlqmzuKM7JNMs4TShZowV1aCAtduhrR4puVbc6lOe
	8z50BXih6W5aHUkEediUx1AUoXVp/veWJWbZzjPT8v6Zmo0ThquZgXrI+vR5eyA=
X-Gm-Gg: ASbGncvMXYMY4GiQLXx9Kem7bZv/vu9hsE0ZlTuXEfewnWQABwiKh3sCQugUadU7sVQ
	CkOYs+B06rVe5W0DhknWHr3Lfc7rd0K2jy3tcHN7LSldpUCG9jqVZJmTYTAiSO2Oals/3a0BrjH
	zRs/xyfYKlOe5dB6uVw3dPGhhWt0kb7rMxS+mCy6xFTye8cuBergFjACHGNvw+SWEpNC4GltH/n
	X/RuTWY6vxrgA3RFja/G0klX90itUaDaPOJPcbYBtD93nEBqvnbH/4uXyJ7vu7yohUNX4IwmT7m
	ziB6mh9VDZaYLXSzCHeP/3mzmMsP4ESibqNXEbN8S8qGEkj0S0YIZWGogl257c7l7OtsA5k=
X-Google-Smtp-Source: AGHT+IF/sP1SOz79jRYFnEDNTZDGX6h6ZBBQsXQ7+89mSok+ehZ68Rc2P55Rrv6VvzzszpcK4jGC7w==
X-Received: by 2002:a17:906:57c3:b0:ace:52f6:8500 with SMTP id a640c23a62f3a-acec8758f1fmr226066566b.45.1745934514503;
        Tue, 29 Apr 2025 06:48:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c898sm780033466b.7.2025.04.29.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:48:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 4/4] arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node
Date: Tue, 29 Apr 2025 16:48:26 +0300
Message-ID: <20250429134826.2429916-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:48:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18739

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


