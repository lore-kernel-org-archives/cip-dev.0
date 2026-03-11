Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA9310611FA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:51 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18709.1773227145524126829
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HfJkKnUA;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485445e80bdso15817905e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227144; x=1773831944; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NNL2XyqENI0EKBU20jSCL3P1jA5fu/vpAAMFO4h/Z0=;
        b=HfJkKnUARdvesVPFs0qe+NASoVmdYlQDVdM/Gt1w0O/0q/cd0oKOL01Ck76sITBwi1
         nhinug/IhijVhxiG6pWCVDYyjmgBb0l8RGrDR2gEnItrOLEBOvlBfph9VzUMxRlzmcqd
         Cx31aPr4uRAVJTP8Zx0flGG2oUOcaB+XvzYtXuSPxHs+nZvPfmot1Uk0S7GPHWaW8QB2
         viSWvUWi+u02Mi2zm9B3j3zmsot6M7/YM5dNqd+aLMrmt62PABLBpXWf4QMZSW2XOlZf
         ItH4Y+4wg86k5NLRe3GpJstEVaALEelp9dzj5ZqdAT40XtuLbxVoa1jxvG9HqT+z9qtJ
         KF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227144; x=1773831944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9NNL2XyqENI0EKBU20jSCL3P1jA5fu/vpAAMFO4h/Z0=;
        b=gd05C/opuSaEG1Kn96XqZdUUyQVa6BFs5R0jQjiH3KwJJew9W9lfON7VIjWL3fMZR6
         kF9/ZU5wGOOAQOKg/zcwcZd4QRMQhS3l14GwlbiICoBtqsxifQyWNw5j/xGxrIHs9Gcj
         2TMVLfoKHjl/NnYx6Ig1m5GmQLwce3ETny6gWDrlT7ux1d0+LvIXQNYyZ7h66vR4Ua4f
         f28VBOjoIpwVkjT2ckmnUJVSLvIW4pAojFdAUizN03T2znwP9kmc4RR5C6/k9AlKGm+V
         wICJgXLJPAE9KHh051u0aWmBhSVxdTfDJ+sMKp3Z1/L9F5IWvxBfSMJbMvKfeKh5Nzd1
         GFrQ==
X-Gm-Message-State: AOJu0YzQcmzS9+PgukXt5ok5KuZMJcpFYnalj1UXj5UVi8QtFz1A6eRN
	Zbizpv/twVTY+wYkxBt3CWn85O9cEKX0DpYxcgB5oaaePXzj4eIEj3mqgBf9ghXjIB4=
X-Gm-Gg: ATEYQzxFksnfg3sBxwoeZvVwQCnq5Y0B8rxzNIL80iXOugtSOMAeYOZSYXGCVygn/Wi
	vJBGNSm8hLB9N9MqgcVpY4/kinSvpZvbUwIG2V8wWugsQqVc/XJobwtia0l5yGrfnRoTprxFhqB
	4bfdZ2KHideDyVcDxKkLXnrDSdd+eMG1yajwBs1bA4f7E31CZ4424QC65RkLKldXs8BXbQom9OS
	pTueTTmQUmLbOhGCpdMJTGa0OppkPpt0LXj2KrrIiMhyU3GqWAprqwQblqTRUeHKLer51V7w5kV
	S+molbqnBhbHuvGi5HIttTsH/CBT5FCInQqOEgZqS/Ihh5qmR5kGHEviwz/bb942D+T97Cnpmi0
	Yb6F5KOqZPr45wgvA0Y5VLeU3wNuKPcMPUlr4i5qPM84yv9GxRZ1NP+CZmxFec19xGqPblj/LHO
	v/UIWUGCJAUPR6CBG4mKMpzioc8il+r/Gz39jTuJsplHK9/QrSNp6i
X-Received: by 2002:a05:600c:1f8e:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4854b0ca217mr35689605e9.11.1773227143676;
        Wed, 11 Mar 2026 04:05:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 15/17] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Wed, 11 Mar 2026 13:05:18 +0200
Message-ID: <20260311110520.1938414-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22323

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1a66160fb28abcd228f69e00bb183a4749f23805 upstream.

Versa3 clock generator available on RZ/G3S SMARC Module provides the
reference clock for SoC PCIe interface. Update the device tree to reflect
this connection.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251119143523.977085-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 7c40532fc869..b11f2e49748b 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -170,6 +170,11 @@ a0 80 30 30 9c
 	};
 };
 
+&pcie_port0 {
+	clocks = <&versa3 5>;
+	clock-names = "ref";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.43.0


