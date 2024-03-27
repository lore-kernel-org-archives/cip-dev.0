Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818BACD12A8
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.32450.1711527516332914887
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GKJVgTXe;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4141156f245so43040815e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527515; x=1712132315; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmKGK3vdK5uJgoMZKJ3vL7L0C4g0A3QkHWLueTVsAgs=;
        b=GKJVgTXebS0+zwX5cdBl2pt0jaAKX+f45TarqiTxNKEsorM+0YLX1oJ+ErxhnwvcBq
         i4V80QH7qYaPaXstEzKVjEyUONZpLhJOnmT0c6vXFDoUVt4MSDuBHBwcMfDePG6/rqju
         7vq9HQyt0FIcofezBPktCiNP+NZMUUglO/Qb6K8gZX9YiRM3hkE4ca/CDVdzdiayFwgV
         Zb/PFCWlFlgRI4IoUz4t7zrRYfIaEwNMeXZX8lVLOKhiNW3x4sEFIvjpMUmYwoomi7N5
         bWt/yUUGFoFtTXFzQzVSqmswmRFPz2UxWr067nz2T4pawR9UYZx8zDFMM9qiMZ906fB3
         uIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527515; x=1712132315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmKGK3vdK5uJgoMZKJ3vL7L0C4g0A3QkHWLueTVsAgs=;
        b=i8BzNNml8YS4EXzNnccUc+2TzRO/FDJUkN+RON/PBbl5Gfdy92OBTyS2YmYJmCAneH
         cCq9k+8Q+GutV9YjL80n2cupVZ3zhWh9kezdRAtNxm7zlNinwKj+iZX3uIczYxCWERsS
         yRbJrS9FJQAS0to6qjei5gu8SQVNymVZP/9/+VOp1HbTWt+8a4rLU3vtxGQ1mnLyfyhu
         8PmLkXH2Bk5hQuhzVqrgy6eAfjuVVzL6eVqrlqVu9JN153+250HsMIeHHphPBFGJf/sZ
         e/ENfmVzsyV2Wct9KUdLf3slaxD0RgXVQgB/DYU2cax9n78bEkU1G6PYZaEJOue6QPRB
         4GwQ==
X-Gm-Message-State: AOJu0Yz/oteEMS4u0PRif/jxthlhgpN2GlXffOkyylGYuilyfcJetwZa
	Jyu564em6LNG2rb7WU1rXlabS2QRcFrn22e3lxS1cBeR11jJ5v3CLPq4u9PClq9W4/KPukWSatv
	7
X-Google-Smtp-Source: AGHT+IH12RGaW59LSoDaSdoT8OLdKgbfz2L3qfcekv4COgTnXD/oiE8bUx7jMqJLE0L0mRtelGXWHw==
X-Received: by 2002:a05:600c:4f06:b0:414:95de:6c7a with SMTP id l6-20020a05600c4f0600b0041495de6c7amr198619wmq.40.1711527514852;
        Wed, 27 Mar 2024 01:18:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 31/36] arm64: dts: renesas: r9a07g044: Update pinctrl node to handle GPIO interrupts
Date: Wed, 27 Mar 2024 10:17:51 +0200
Message-Id: <20240327081756.2228036-32-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15448

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 989fd5a7fb7927da37a004cce5336e3940a842e1 upstream.

Add required properties in pinctrl node to handle GPIO interrupts.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220718195651.7711-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 881fecc8d0bc..390914c8db49 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -767,6 +767,10 @@ pinctrl: pinctrl@11030000 {
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
+			#address-cells = <2>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&irqc>;
+			interrupt-controller;
 			gpio-ranges = <&pinctrl 0 0 392>;
 			clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
 			power-domains = <&cpg>;
-- 
2.39.2


