Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED7C41513
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:31 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.43060.1717769362741526892
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=joY+lB7T;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so299662e87.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769361; x=1718374161; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bflcX6nbdHaX857+csHfWNKFzZ2w80yYoNBs+5YjahU=;
        b=joY+lB7TcyBSiKsaqT0Or0nU2e+WsIr960MvW4FaM1YOXA36B0hrUGtY6k8IdVZeeH
         DvA2ig2mLWR/wUj163AxmadIt0FExNTIRTiXRRo2hehe+93Xb07v+Rd+OxgB6wOfOE+Q
         QrgyecWOfXpBvImYC5W5sS5/0WKJX26/YWIfp3zgtYQ22Gb/R3KG1Zn0ieuN6Od9bTml
         vXjJZII916dqeoS/zrDbvNraogbRFyro2yeDsIBs3XwGGJ3qPmCx3/RMNX64jjTKa1g2
         0MP500kky0As6s8nozU5lAMjtld/NjqI+UMhUhPa88SXHI011B/cC8BkXYf71qpWbsG+
         HiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769361; x=1718374161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bflcX6nbdHaX857+csHfWNKFzZ2w80yYoNBs+5YjahU=;
        b=pd3g7K0HjmOOHtvlFbQRGOiGG3y6XP9ju+IjMTtLEK47MMxGPmK+RktG9CO/asnRL9
         jUlu/n93ofHsM9qj7MVw2EzDBUpN5kG3SCyOMijroFgot7FbUqQcEs1x7+AVHtQ+QUeg
         FCeJICSMYEI3MJPxwyMNV5WIhEBEvwJR4EbNufnYB9GUejNj+p50tfgcK93ZDE8VSRoB
         CPyqqz36RVm+TZerSfE+qJ8Wyv0pf+RT0tIxd6X4S/q7G2+BXHxUpOWPiF1SyNIAj1S2
         MdIHxWlU5SKRPoI6VyvO9/+ZAXZDBuCGlA5bl8lEaxBVB5sRkwuSHjdwlt3jLdjHVUBx
         6Q3A==
X-Gm-Message-State: AOJu0YzYmsGCpTi85/Lb4ulAnXH6ehD8p+0PMMr+uZ5oz30KUFD6WX7c
	SBT21+LLsteBT8HD7BAG2n1ZiqBAS9Zhcrij/UhHj5Vjg7sQPNbbEg/ZjS+GUZMllLvv4xh3ozM
	R
X-Google-Smtp-Source: AGHT+IGGJwDkMQThQ52iCL4BWP5nikO1MaLubvQJUJNjQNrhw7FPqHqZHz7QljUh/aAFjLiSK1Ngeg==
X-Received: by 2002:a05:6512:704:b0:52b:be6c:9bcd with SMTP id 2adb3069b0e04-52bbe6c9ffamr944532e87.6.1717769360924;
        Fri, 07 Jun 2024 07:09:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 15/17] arm64: dts: renesas: r9a08g045: Add PSCI support
Date: Fri,  7 Jun 2024 17:08:54 +0300
Message-Id: <20240607140856.2497508-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16176

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 145f33d1f1db869da15beff664f2c787fc94541f upstream.

Add PSCI support to enable suspend/resume with the help of TF-A.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240208135629.2840932-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 5facfad96158..02fd68b06eea 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -42,6 +42,11 @@ extal_clk: extal-clk {
 		clock-frequency = <0>;
 	};
 
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.39.2


