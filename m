Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67618C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:51 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.7445.1737709244826649736
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Jb3Vc/Aa;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab2e308a99bso352091566b.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709243; x=1738314043; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQdrkiIjHnLsOJw+Z5zMeptb58ITACFhO/vADqq0RNg=;
        b=Jb3Vc/AakvSllJSX+PKR8Upmbjvkg6/VCjY+GEcsLDgilMOBhwVs/iLxXUPezJb2Ms
         /rvWGk7AYyTS0ypSBvOtOFAcZ3/TmMFIFNhdFRm+EwWZMBT4lZPhA8h0JGoEroort+vj
         9f0d3uAp8y1arvSGEqE7kIv4eAGuTmXTPzdnFM+av+SYFMdScUEQSjE3YAVnM3sdqS/w
         vT01h6hRm+AuB7N5ZieovqerFrijyr6NdC3NEcZejLcAI63PhtGd20eljvWrH8uiRZbI
         FHdn2igF5z6ZTWf7jHKBPm8tknR99yIUZ/lgfCYMjKAd+tjs4jh1D044b64cSUn3mEb6
         kIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709243; x=1738314043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQdrkiIjHnLsOJw+Z5zMeptb58ITACFhO/vADqq0RNg=;
        b=i9cQpR7TvfieNf0luWhl3eQy5PfyP5HHMQ6zZLXRnlcOasZZA2gnnzXfIYcwa5oYM0
         cZu9nfoSifK+yUuOaFKlEQjk5dlcEULZJvN3wSWGWOi1RSDq3R+JAlfAIGS56fKGjDKt
         oQ8mUbgVHDknC8oVInc0DDYCPe1eIfhKqFgpVRXa1RpR3YgMRNN6ecJoxqSE/BWZsQrE
         dAF/xwMur8GA8HDz9Qpw+0cTXh26ff3Zi1zVTIZHlV5Z1tlrd8iFV1rTQZOBd0oVDMCW
         fKay/KLG9sg1bs5aKkTsLPNsTxDB2ggNllnYfQJNnFMgztxySZAsa/EWgDPRqeFx7Hb/
         ShLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj7lVBWV+wQOexRaBKIiSAizv0xRdPU1X3euln0iu3gV8Zxso0brVz85yYV4Y0rUhmZSOKlT6r@lists.cip-project.org
X-Gm-Message-State: AOJu0YxgNU0tkqNJQ6d38xokKcWISOecCJeIUz4lEQjxZgPa7jjIBuLe
	2O7bUKtiPaerj2VffAYcsfn9blIwSrBa+qOY9wLZEpxYkp/SpVhW4EU22L75RL0=
X-Gm-Gg: ASbGncslC1UzTFVa1ZFWIYkZ43QFpLMwpcKfyAs5tU6V+s9lmhC2mWN5ah7Jteb++Hp
	iokB+ea6pPXqrCkFYGrTfgDyVuOJQkA+yn8CQu11u574sSfluLkIc7xk5MnOOjILS/PbhjEs8qm
	7Z7S+C15f4ajV3vt6GJm1NRuAqhdt0qSjkypa1y1x/mZ9ALGtKauVQEZfFSgQLk4V8KGjDUc/Yt
	uS4GMp/OSkPoqzW3/vzeVrb2RheW+YvwT+aqH5CTskadX0A0Tpw2mfmyY+QcbjIS3KvsHlGl83p
	Ev+vRHrfYTUs0lKZP7Hjkfn2y7PNm19kjA==
X-Google-Smtp-Source: AGHT+IGPPBo/3VXYnDIU6uYaQFBPKaGArKVeWHVihD/KGII/G+7Ph/qgFwRJ0ZZrvRRpFn74T+pVzA==
X-Received: by 2002:a17:907:970e:b0:ab3:47cb:5327 with SMTP id a640c23a62f3a-ab67457c7f4mr246681966b.5.1737709243207;
        Fri, 24 Jan 2025 01:00:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 00/16] renesas: rzg3s: backport the RTC support
Date: Fri, 24 Jan 2025 11:00:25 +0200
Message-ID: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17637

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
- collected tags

Claudiu Beznea (13):
  clk: Add devm_clk_hw_register_gate_parent_data()
  clk: Add devm_clk_hw_register_gate_parent_hw()
  dt-bindings: clock: renesas,r9a08g045-vbattb: Document VBATTB
  clk: renesas: vbattb: Add VBATTB clock driver
  clk: renesas: r9a08g045: Add clock, reset and power domain support for
    the VBATTB IP
  dt-bindings: rtc: renesas,rzg3s-rtc: Document the Renesas RTCA-3 IP
  rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S
    SoC
  rtc: renesas-rtca3: Fix compilation error on RISC-V
  arm64: dts: renesas: r9a08g045: Add VBATTB node
  arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
  arm64: dts: renesas: r9a08g045: Add RTC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable RTC
  arm64: defconfig: Enable VBATTB clock and Renesas RTCA-3

Horatiu Vultur (1):
  clk: gate: Add devm_clk_hw_register_gate()

Marijn Suijten (1):
  clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()

Théo Lebrun (1):
  clk: fixed-factor: add fwname-based constructor functions

 .../clock/renesas,r9a08g045-vbattb.yaml       |  84 ++
 .../bindings/rtc/renesas,rz-rtca3.yaml        |  84 ++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  34 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  16 +
 arch/arm64/configs/defconfig                  |   2 +
 drivers/clk/clk-fixed-factor.c                |  59 +-
 drivers/clk/clk-gate.c                        |  35 +
 drivers/clk/renesas/Kconfig                   |   5 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/clk-vbattb.c              | 204 ++++
 drivers/clk/renesas/r9a08g045-cpg.c           |   3 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-renesas-rtca3.c               | 923 ++++++++++++++++++
 .../clock/renesas,r9a08g045-vbattb.h          |  13 +
 include/linux/clk-provider.h                  |  73 ++
 17 files changed, 1541 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a08g045-vbattb.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
 create mode 100644 drivers/clk/renesas/clk-vbattb.c
 create mode 100644 drivers/rtc/rtc-renesas-rtca3.c
 create mode 100644 include/dt-bindings/clock/renesas,r9a08g045-vbattb.h

-- 
2.43.0


