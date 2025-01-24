Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B43C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:21 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.7422.1737709212047346213
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Su0FVR3e;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361815b96cso12214325e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709210; x=1738314010; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSwNf19Qou7nM7wSKGPHcusBPehB83fjBKTzzY4qbz4=;
        b=Su0FVR3eR9DGW/LdN3mrIfPGlqfO1120I54E3up9yPb9Qvn2ZAyzKQHbd03gK09JCJ
         r2dZ0LbYv7hn9tw+Fq9mU64KxZbRGwOvosFaFvJewP3muM9BQT/BEjWc1FrhXoWNexi7
         s4F/JuQb4fQXrYckeHAkxI9uetFX9tHIshR7qbeuQpnBFb0vW1FmjKvGnmX5MJ/IW7P0
         mcq79XhUWrYAjPqnRhuBS9McgLKBelfkoE8m1BU0LW+8imGl86GnDuuuQW/BE+gKeyDn
         SpKb6veYM03Ej950FHHg/JkWH5GboiKEH/roRH0/Zr8xMvFMTwu0W3S2/I4cYyO2IK0M
         Cqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709210; x=1738314010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSwNf19Qou7nM7wSKGPHcusBPehB83fjBKTzzY4qbz4=;
        b=PcXr2aHj+X8vOHaSs1/ETy0XLE4QQJcMaQXsa/28pMsL4KgnPLYyspOf/kfYGZHB0O
         OWH59ol+afHrGwEFKIA/+syWEa78+NrMjKJbIS1rnZKuVqrqcZK6dS4iTdL+qkuOd8n/
         8OTmv5noB2NSIMfhZ28UtSlnZ51+cZW/+2ArfnjpzOZw4VsW3OyQSjqglVNdkSTO5+r1
         LcBMvY+9s2CV72+PFUZ48y1ZXkdsqumbdsg+BnY9PAN/SOsRRu3p3g6E9vhNdhBGRFLD
         a1K4oNp87YeNzBIn0iTJrBUdUROhuH+dw+9+To/8UcSWjGOun58JNM1qkCdZX9OYiId2
         Ei/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZqJWwvWi/sFPzAZDVFXOHlZZogm6IHSEzw7D8HldDsXbsokQ8Eje1b2XgZuSkhjDCO5K3aNKW@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzwh3fOmvpsrfvCFxGNgWwxI1rJNGxXMiLFFXg7eX8mEMJhrXoH
	CgnH5ITD+xuYRJsLGkwnlvIUkaBSBtmsuFwid6yMCfJe2bj1TOHZwIN7XkNCEhY=
X-Gm-Gg: ASbGncumndIXhwEPUdMuoBp2TScB0Wo7XL5PsJOlJRqbZWZ1IAJqx5eq40mzoHMBjNg
	ISAEVcbjyvbNH3qBLHdp8enxAhqmaLf9DE3wZpha2hL+SjigdMWhbXwcsws1j+bTLn8pvUebGqF
	9NHkrAPiIktrsRwdsuBQ4BLmYZk6OTWPSrfB/vTFxFVtnvibCOkjfw5fKlPJJfjg7VEZx6ZvQqr
	KP1rYsJ2R3kRiB83eGJiZILQVtMiLcQVPbuL1jrs/MKcV8SMwiFGqL1KfQ+H0/Ltq26KkIX9xCL
	2ceJ4GKV6zCHO2EAWioTeeV2BZAjQ1hMAQ==
X-Google-Smtp-Source: AGHT+IEQcXfdLzlnpDmpbrWdBiIxcDADZ0nYlVeynGrYCoAqSsYB+Da/eYljCWszjX65tVm0KuZdkQ==
X-Received: by 2002:a05:600c:4f93:b0:436:6160:5b81 with SMTP id 5b1f17b1804b1-438913dbf79mr294850385e9.14.1737709210380;
        Fri, 24 Jan 2025 01:00:10 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 00/14] renesas: rzg3s: backport the RTC support
Date: Fri, 24 Jan 2025 10:59:51 +0200
Message-ID: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17622

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the RTC support for the Renesas RZ/G3S SoC.
Along with a clock driver for the clock provided the VBATTB
is included as this is critical for the RTC to work, as it feeds
the RTC counter.

For the VBATTB clock driver the following patches were also
backported:
- clk: gate: Add devm_clk_hw_register_gate()
- clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
- clk: fixed-factor: add fwname-based constructor functions

and adjusted accordingly, if needed.

For the same VBATTB clock driver the
devm_clk_hw_register_gate_parent_data() was backported from the upstream
commit d54c1fd4a51e ("Add clock driver for Sunplus SP7021 SoC") in
the patch "clk: Add devm_clk_hw_register_gate_parent_data()".

Thank you,
Claudiu Beznea

Changes in v2:
- adjusted the patch title and description for patch 1/1

Claudiu Beznea (13):
  clk: Add devm_clk_hw_register_gate_parent_data()
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


