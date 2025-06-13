Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C9C71157
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:20 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.7079.1749809718930174538
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=E2gJB9Z0;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade48b24c97so285330166b.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809717; x=1750414517; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S1afLlbpj1B3s7nm9tpjr3mXb470X/7Nt5bLSv6zTU=;
        b=E2gJB9Z0LZgJNNqZNWkk/0qoEZlsQ3AIaJkodRxZYyTy62F+EZpUm6J2YPkNpdqwQ7
         F/l2bbeyFamdn8gkYcIBiffgcXluNTgCI+1PAFEwCRnQ9epXHh/4zyf82gcU+3bcAvcr
         8xUi/ImPFWViGLF9uaYrt55KeNUm3O04doyAkOlO6ffHuxUx4sreKMMgWYsbLdB0zhOi
         Ix/rRMUH7KnvOCybr6REkNwiHxuPqKI2j0OlP5KFS5J/yXiHhD80G2SxMQSIsV+ueoUY
         Kacghh8rHZLmJbizzK6xrrw/uGpSX1h0oCLtC9QzqaR2XUvavSmxhBv2kYnoYZLj88iU
         Z5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809717; x=1750414517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S1afLlbpj1B3s7nm9tpjr3mXb470X/7Nt5bLSv6zTU=;
        b=NRebW4ylEXf4cQ4bAEtRmG0hT0VLuvr+9Tq7dhxLiAMtSJl/wDKCgiKP6f8dUBhUFA
         YCaQ2YXv2RdbXgnEY/UJSQ51tFUvZ1An/kiLid0Sn8q2KrLn9LUFRD9kmYhbi06bk/u1
         Z/Fgtg9TtSmFhWBP8z2uRNnuJMzJm+7uw3O4SSigxLJymlkOvQttr20PzClOWoJ6/1uA
         /FJGp/IxXxC1g7gth7CfrktvQeEK4p5OAT8IT5abpv2YqnJT4Wey2uOgCG351RMtG/WO
         op1bya9/IeRedmDKpEVuE6jownFRRMFOB+5kdFGhi6WoiR79/x5nHXA6VqRH6jgG5ksP
         EQOw==
X-Forwarded-Encrypted: i=1; AJvYcCWPEY6bJilLF9XO9XPMDVn30tizjzYlGubKwPAihPfseoi4yxyyRKyiM+E5qNzSfK/hYFl4hU/P@lists.cip-project.org
X-Gm-Message-State: AOJu0YyEvoVy/EBD+75tTXad5r3ecb5bhDybMrLxq/MKdDM6aX8+8b8E
	WddbN4pTw5dOpAGF0XnIGNvQVnpmn38jhtPKGfR2rzhSHA6QD/6LeblFftUSjunJpKU=
X-Gm-Gg: ASbGnctD6yE2JRNIsBR7+IgOTJTy41Kp6fGYNW8lOxDldnwtPyiPMq/LrT1JE4/NLMd
	KkwUIiZXcWRdFhXMKQs1UfwsbYifub7AIoa1vJHQwhyn61bHWk3QXg+PoZ2lBd22stOmrymtxBT
	5KjiAFWijJv0qIYI1qVYzESYwMPoL1tFhx5n8FMAPW+ll6SSgf8O5Er+t9aKVP1bVW24zCJVzli
	hBIAGjbh5sFVndFfQ5eUUbkfREjyTXjmLp2UoKFdf2rGoDwh0UBCyk3+YqQLfwcqU8Lm5Lt1v47
	kGqh1pLio35T1IPXesFKvObKrojgA8+s9y0PIbqgXrCuBbm1tORRNO2eCQTppb8o235gPyXEp3W
	VxighlmVQcz8+qFXdHPT2lOv5d1o=
X-Google-Smtp-Source: AGHT+IFf/Z4DMcC1VzV1nz4qdsMtO4cF1CAuIP44G+G3YIqQNCj+dRqAeNl/WZIrunpyVtG3KSciow==
X-Received: by 2002:a17:907:7241:b0:ad8:9428:6a27 with SMTP id a640c23a62f3a-adec5c7721dmr255127966b.50.1749809717331;
        Fri, 13 Jun 2025 03:15:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 12/12] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
Date: Fri, 13 Jun 2025 13:15:01 +0300
Message-ID: <20250613101501.262091-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19053

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 8cbf69bc74e1f365b0ef8caf5dd2ac994ce965e0 upstream.

Enable ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241206111337.726244-16-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 942f9a5fc543..3f050a28f2a7 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -84,6 +84,10 @@ x3_clk: x3-clock {
 	};
 };
 
+&adc {
+	status = "okay";
+};
+
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.43.0


