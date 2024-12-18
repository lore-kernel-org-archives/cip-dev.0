Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D233E7718C
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:35 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.104198.1734524612500942209
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=IGRmeUx5;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso4555015e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524611; x=1735129411; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8uQNymoji1ksmZrB7+5ifmXCiwpi+Yvt74CZN6UUYc=;
        b=IGRmeUx5xucaPwbflwXzdk0VxtUhzzXRiIx0LJaHJocw312S+vtPD+bUkXjKD2LpYV
         wlw6T0tY5z3RmwiWVoXJuTP6IcqJb8sRMqiIvEQkwf7EYtPjtkrX0zQeCFgpCZ3w0+A/
         zJmQwKKx2MkotPMYMgt/nmawL93fCuk/C2qJON0GVZPU5wzTzQgbl/Xd3BLmZqQ6UPM7
         mHHGrjlnJa5oo0GZt8NyvQv9y3mGrXhHSYZPGBraW25xUyEhy1qLT4JyMnoN58I0BR2h
         fEzgXyxpIhNamdviEIXOgKSjJX6Jv9oLSeSgN6YvvjWk8D+d5880ssIOjUHD4QqwaBSY
         8u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524611; x=1735129411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8uQNymoji1ksmZrB7+5ifmXCiwpi+Yvt74CZN6UUYc=;
        b=LY3Vt53e5iaX/p93BpsBkTTFbpF2euyT9SscNHa8lv/GvmjJOSwCLMbIAmWSacqVdS
         kZE76B9oOn1lLSfGaQmxNwpUkDYq4A0EJRFYjL1skK3cuXqfLs4sql4R9Ov/5dtBDS3l
         Fuqky8EMg1pQx/GWeyY5SV6IF0fz0hVd4kmgyGbNSXZtjva8po5nDm5SlHiA1Bg8Jslp
         s37a1B5TvVo28CpDuOB1kj9U+ikuwLL9N5tiWDq4wgpk2BkmkxSSyXh0KkkpiIo6Fan3
         qqUSTGmPZCM980K7pSzzNYDCFm2p6aEZTNNfPOlZI/vN3NTrewNV/+vLHAxULi4jzVfC
         WoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDH/ig+oczF0iI7oqihN9u+krAquQLrlknu5Pldqy2cMEEkWnq1neJKufUKWdsElhzTC/9Pcgz@lists.cip-project.org
X-Gm-Message-State: AOJu0YxahISiEwQkbSOxFhgvT7Qktx9HVLIzX/Vh46aTm3VYqNDiCXZa
	0gGmuOYLFkSFdywvyJxsTHc/zundIQQ/ul5ndQMlAPfAtguCWEvqjn4Ea0dnipg=
X-Gm-Gg: ASbGncu3+tESIY3zO+hWlYQCE1QubaJomlKK7v6GN6Tl2Y5t1Dua9W3icRmUptylnYv
	Si4/Nd7gR2pZcm8gEMdmzi43EMIKJAFfUc5yTpXGuSONyS/tJTPYcNBveYXkXVfC7JDbPAqg9HE
	9XCOJEB2yxkVd7zo3ymYNinW8pu6MXisDWgq2QdHaAE9m+lVN3KPwf0yCAnw6sWlZdVtgPOGccK
	lHonrqTPFf8IpnDp/y/e8IQxVHZWfCiZaCrYIPZn+BfAc5BVncJQk1YG4oflJeGUKiZc4H5MUcg
	J30Iu6P+J14=
X-Google-Smtp-Source: AGHT+IEHwbtQydv2i94PfmNceJ0YmnY9Ar3AFscdsfUNGXyRdaSwYGapJXGVoaJqbXuDzpYcsMkiCQ==
X-Received: by 2002:a05:600c:5854:b0:436:2155:be54 with SMTP id 5b1f17b1804b1-4364812a126mr64961195e9.1.1734524610892;
        Wed, 18 Dec 2024 04:23:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 10/10] arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
Date: Wed, 18 Dec 2024 14:23:17 +0200
Message-ID: <20241218122317.2365272-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17463

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2c0f4dfad96a6809506265f53f251b83ab2c848a upstream.

Enable the watchdog interface (accessible by Cortex-A of RZ/G3S SoC) on
RZ/G3S SMARC SoM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240122111115.2861835-11-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index d33ab4c88787..acac4666ae59 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -340,3 +340,8 @@ mux {
 		};
 	};
 };
+
+&wdt0 {
+	timeout-sec = <60>;
+	status = "okay";
+};
-- 
2.43.0


