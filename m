Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5C3E7718A
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:05 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.104176.1734524579092510496
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bU7Y/+vU;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361815b96cso42847205e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524577; x=1735129377; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8uQNymoji1ksmZrB7+5ifmXCiwpi+Yvt74CZN6UUYc=;
        b=bU7Y/+vU7erNEQCFWcLunu8oPHh1K7CcNsbrt045Kfyd1kpU4QMjXCTr61rApUVk/y
         RX9O0kYlX/d27T6PLpI5rvSkWdgEhrwsTOoF1lf7km0hLuYKkC8lH06LEoH5elQ3WNyM
         GXQsa9AM4p7hCkQIpAjBhyOLOIDMU9gp+tJc7SZ4x6lmGWL1/M+pACEgoOE1jgWFXJec
         OMLhGDktS6CPTs/YQJK0s+7jD9KiOkxbYN01xDwE+c55RhmEmpZAjXWz8VbpsBnB1dO+
         DORH2PfE17Tz7hwIB8nKBYDMd/gQoQtzLFslv1JVEOpaajV3QckM84hKAoQDhMmcnOra
         noaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524577; x=1735129377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8uQNymoji1ksmZrB7+5ifmXCiwpi+Yvt74CZN6UUYc=;
        b=sCuiQayzdoGyVW4qn74IQH1Hl8Jiy6UzJKmNnmqO7PCeqVuLPCJ9tyEoToqBXKwGAj
         EuPQ5u4VcCPbRsB/TTjFV+kIzqB9MgGMJ35nNtaxTYqwhby45xL7La9FhsCzuMaydlJu
         NIO2c+DTp+6aRf54xDdG6yNTl/oDdfvfScdy01jUfMqYOTWSHHFetkF2LW4WmPeh/vvD
         Ir5HyC2VqQGeOH7ZP7KvgrKn0FYDw3v8/Nt7/GAyKu/hjHxX7+sCvE4PruMdqohF86K/
         XOove+Eqccw51CLjQaiDfQy9vlO7JE8B1D8ci01KzaO0kU+4HrqQe/hyTKSI/+gwSaWl
         CCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCnt5PCTI2g6+e2KyC2niO+fYchWO6P/YL4ngMDtGp8k6OjhIZlEphT38fIy5QfjAn1t9rSzQr@lists.cip-project.org
X-Gm-Message-State: AOJu0YzCNWaf0GOGOE5f84KVlDzAs37g6ftXVpBDPFeU6uxitn4n+f9a
	aO9MJCHPT1l0lNIMSc/BOc65L7nVcEneKwm5iuj+DX5eLV3uhfQLOj+aydGM2Cg=
X-Gm-Gg: ASbGncvN5/JVWJfG3G2joHANbNqswnerWxlG6Yj8Du7wXRD2gtuuwgpuIeXGH+3RH/y
	7NVIb+aTf1FATQMDW1zPGFA5um92nxojp7Abff78x9cRkHOSYQ3tnA9WD4q3Re+axZzU8nV8IvE
	lV+DqSppkNq8CmKZkguphK7d9nLKqYunJwg74nKdKf5GibCUbJYzm+XAgoXdEoCQnUEUWmMWQMV
	AKF1HQ5CMdQgYTqiDpC4fxurhEnMmnv6xnJoI7o1ezjziUGb/Q78gD9aG5JAB+vvSn2na4snqug
	WwLyFkuDch0=
X-Google-Smtp-Source: AGHT+IHZn4wJKGx/ntnXzU704P4u4ZaL/WNUXOnk5t8lDUmY+arlkVHY389UYNxff1Tjj6iDjJlUJA==
X-Received: by 2002:a05:600c:548e:b0:434:a968:89a3 with SMTP id 5b1f17b1804b1-4365535fc8fmr22640925e9.9.1734524577495;
        Wed, 18 Dec 2024 04:22:57 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:56 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 8/8] arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
Date: Wed, 18 Dec 2024 14:22:46 +0200
Message-ID: <20241218122246.2365189-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17452

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


