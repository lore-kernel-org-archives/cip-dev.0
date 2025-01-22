Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC44C0218D
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:30 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.41680.1737546684543972736
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RxopO1Xv;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso5028345e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546683; x=1738151483; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qg77ngq7pluM4P1oll1tovlL68Jn8lQ52Kr83gG9/ww=;
        b=RxopO1XvoeoC1/By0kY/ySyw0zxrOrwcfs8iHWo0z3ROJuZ42LJdfA9NCzJdSbwwcg
         FB++X+3KSqE/Pi2PLuea5Y5SGmAZB9jNyXHdVXemOEwDAaAn+HgwGvUA/wWsZH6xymLl
         QJJjBBn7piQZrc0qZqSY3T6Htc6LqQfYFlIHAthQtdf7TMUlxS1QCwuvm19WqXpIjRik
         glBZNXCXUlO5Aze+HEfoSIT23nub//grjIgQVUhrDxX7wpcKnjsrEINfqZFyABo3Fdz+
         VnDjtbb917uu13RzQTs7xbr31kof8Eikxr08fsAPL0ax2CExwjliN5i5yXd4Zj73wsMD
         mqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546683; x=1738151483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg77ngq7pluM4P1oll1tovlL68Jn8lQ52Kr83gG9/ww=;
        b=tWviPS9wjJLHZ4oACu/A1MsvxRHQqacdhMhjDM/ZzlAw5zVOppHvluUe0/n+FO/VSS
         PCRyj+F5/ua+k/xKtErBiIrps1YoFZz7BxXINz2s/AzMk0z7iwHIbDjD6tQ6Brgl526i
         Fv+QNT0LCwfN0xAAeX2RRrNpVGGmaWTAkj1sAcgYf6JIDSJLLG/4JBfCYX69iw+o++b0
         TkL2tj3WeJLJ06iPqEH+ABPNjnDwLk4fhz0FmGNaAbYpi7WT2i72EXifTPJ+0kDtDLx5
         0Ukj6b8mBqjI88Fw5+U4MTaIiWJIiEHOR2nNdYcX/3lulvjueo1WIaHtJkU/b94yShnj
         d0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCYgDUU20icWde0VnetL/S9QYXz+KFBkzquP9MFBC2QqGgdWYqqwHPfSujo37o/Vvmtge2FCNb@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw+YhOvnVfMgJtJFukdZl7tvinUqXrecyx3jeqm5Wh2DwNBGAqE
	cPNhAFIcbCLBqQGP6w7ApMgsKGgaa6TFRa3VUb+Kfm0pfV3vQl28iG9EL3Iz5uQ=
X-Gm-Gg: ASbGnctBO7lX0emvBdoCavBmVbnMRvcN+stWzS7ikWleuzVt6b9Gob9eOJk3p0mn55F
	JcRmmGACPMAwNSPTyyum/xOTRfI4No1IEGUYX5NG3M/csHPkK3xoKZHUdmgUpeaLrthDVG5ZP8Z
	/N5ONPJ71/5FEsAXZ3415oxWCyZj33hAX2TSmKTfTn6mjJQhtfwybXMrwH1ssQMsbigd8kjY8SM
	hQfMPj2qib5HaO/CAg4V2eEdKl1Qk5kS83qvgXxCS0MqaqF7muBqBsrF4BZhBza3FTT+Cr5lFIL
	H6q5nd8EnugrUa9Cmmnt8oc=
X-Google-Smtp-Source: AGHT+IG64ZDjyfGCd6OsmqwqX5zc8sxoQ+GbPFrOqbT890kqazGcKfAQzALhE+OUOElVSM8/CIXFZw==
X-Received: by 2002:a05:600c:4c06:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-437c6a86b58mr246635785e9.0.1737546682699;
        Wed, 22 Jan 2025 03:51:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 00/14] renesas: rzg3s: backport the RTC support
Date: Wed, 22 Jan 2025 13:51:05 +0200
Message-ID: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17563

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the RTC support for the Renesas RZ/G3S SoC.
Along with a clock driver for the clock provided the VBATTB
is included as this is critical for the RTC to work, as it feeds
the RTC counter.

For the VBATTB clock driver the following patches were also
backported:
- clk: Add Sunplus SP7021 clock driver
- clk: fixed-factor: add fwname-based constructor functions

and adjusted accordingly, if needed.

Thank you,
Claudiu Beznea

Claudiu Beznea (12):
  clk: Add devm_clk_hw_register_gate_parent_hw()
  clk: renesas: r9a08g045: Add clock, reset and power domain support for
    the VBATTB IP
  dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
  clk: renesas: vbattb: Add VBATTB clock driver
  dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
  rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S
    SoC
  rtc: renesas-rtca3: Fix compilation error on RISC-V
  arm64: dts: renesas: r9a08g045: Add VBATTB node
  arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
  arm64: dts: renesas: r9a08g045: Add RTC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
  arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3

Qin Jian (1):
  clk: Add Sunplus SP7021 clock driver

Théo Lebrun (1):
  clk: fixed-factor: add fwname-based constructor functions

 .../clock/renesas,r9a08g045-vbattb.yaml       |  84 ++
 .../bindings/rtc/renesas,rz-rtca3.yaml        |  84 ++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  34 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  16 +
 arch/arm64/configs/defconfig                  |   2 +
 drivers/clk/clk-fixed-factor.c                |  59 +-
 drivers/clk/renesas/Kconfig                   |   5 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/clk-vbattb.c              | 205 ++++
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-renesas-rtca3.c               | 902 ++++++++++++++++++
 .../clock/renesas,r9a08g045-vbattb.h          |  13 +
 include/linux/clk-provider.h                  |  43 +
 16 files changed, 1456 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
 create mode 100644 drivers/clk/renesas/clk-vbattb.c
 create mode 100644 drivers/rtc/rtc-renesas-rtca3.c
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g045-vbattb.h

-- 
2.43.0


