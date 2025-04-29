Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD9AC3ABA5
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:37 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.20332.1745934451581092136
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qhDIUKR1;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac345bd8e13so869955566b.0
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934450; x=1746539250; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZzAOm5Fkl8qCIT3j66YGe08i6RZkMxf0ta1Ae6dYhE=;
        b=qhDIUKR1ppa+Kc5jHwZzvrRyMKLsXqfm6zifwE67BUHUSLg3xqUUpo+0YlKgEUjksQ
         yZhC/QYEwuDL5rlRlmsIeduX8gbQIEIcDqRkNuVGUrZ1zNpAJmfKgX1Ep1E4KVCtjGKX
         bIn6fkeAwcFIXFtNBzgvTmuUHRe2mSu9+TmLFpyGF1wl4AQwibRBTbu/eg11XgATk/x9
         fyKYFuBtSj9E2AdojfbiSLXXpL28Vli2lp4alntWmzftRd62CTsUlXdQYCVtiMwHHWlM
         ynDMMwdpoJlgiNvfcBSK8YjePjoPYcMQGN9KOAb9vlMEPnoGeFXcybjEZrXWOUEwFH+l
         X71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934450; x=1746539250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZzAOm5Fkl8qCIT3j66YGe08i6RZkMxf0ta1Ae6dYhE=;
        b=nATdDxmYTVgS/M1nEas/ul/vsoS/VGMcHGoJCtGVaiQZGaeKUKbD4GmyadJNQLQkjh
         +H9+1sENg0HASb8jVpralIROjtJ0Myoy2+lstzILGvAuP2YqMrhBYeXMrV/bzxBJxIes
         NeB2a0s+WC0bTyapfY0hNW8mRPRzmhoiIf1vKyaZu0lfbZERVkkCebhfokO84U24iLPt
         +8qCE22boGlQ3qM4ju1c7rnpJkh2iVK63Re3bT5/8KVl6wx6k7DJVOWPBV0jCvlunt0F
         ZoeekWYil6ksuuRfTXGx0Uv26CXlG5bMY65P6nc17Jc/M2w1Wo/ONhuIo3WVQRpyVxgZ
         ZXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAZwVWnact8oOzlSE1IZMRNjjLbgGSsKCEzm8GsJX60qUonTGr1+FPX/gZEnAqXCPq8+g9PibE@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw0x8RFUDZJfK6LkTIzvBur72S7Ti7kSHleRP0MnZ7CQzzSGqNA
	KK4RRPEoDEadE8CxI9HLT4L28CKe0yzXqv0F9WT9vuZ/fgJgX2coUSrmI20Fygc=
X-Gm-Gg: ASbGncvDlC2UcoZZEXIySessaZpPcZiD/Hd2tPXHX4brQ1Frrle+sRF5NSHSAh1ycma
	ZNt4oSN7tFGURVeMcebyJ1rA+PD5sNXfHlMxeAJPiqKQCkUojYh+mr7Gl0cYaIcNxSbyDS2qaGO
	ArZ08ii7A/2hukxeCIHOanWtxaUbxn2Qzin1oJ51zfb71EGl6nymE1US+gDZaS6Li2W2aUF/OXT
	ezd9YdV1+ml1q0E1e0KBTQUPj1ahtIexDxceHGUW1J4hoY+cmlxbtsypP3AXQ/TNA4jjWP7tE8Z
	0EIPs0/37f9LYw/YS+tlsxJMZg5kb+vo1DdE4QamoQPlvbt2SNJ81yygqSCdYoMO0C+5VF4=
X-Google-Smtp-Source: AGHT+IG6mxLaLkfygtApOBBDV+5I7kjkgYbWSY1CEGrd/ByqrE6MItlN+JUhhEEvW2LyQu6TNoU0TQ==
X-Received: by 2002:a17:907:7f92:b0:ac6:fcdd:5a97 with SMTP id a640c23a62f3a-acec874bc8emr293224166b.48.1745934449643;
        Tue, 29 Apr 2025 06:47:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 00/21] RZ/G3S: Backport I2C
Date: Tue, 29 Apr 2025 16:47:06 +0300
Message-ID: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18713

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S I2C support to v5.10.y CIP.

For v6.1 CIP only the following patches need to be backported (everything
else is already integrated):

  clk: renesas: r9a08g045: Add clock, reset and power domain support for
    I2C
  arm64: dts: renesas: r9a08g045: Add I2C nodes
  arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
  arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node

For v6.12 CIP none of these patches need to be backported. Everything is
already integrated.

Thank you,
Claudiu Beznea

Claudiu Beznea (12):
  i2c: riic: Use temporary variable for struct device
  i2c: riic: Call pm_runtime_get_sync() when need to access registers
  i2c: riic: Use pm_runtime_resume_and_get()
  i2c: riic: Enable runtime PM autosuspend support
  i2c: riic: Add suspend/resume support
  i2c: riic: Define individual arrays to describe the register offsets
  dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
  i2c: riic: Add support for fast mode plus
  clk: renesas: r9a08g045: Add clock, reset and power domain support for
    I2C
  arm64: dts: renesas: r9a08g045: Add I2C nodes
  arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
  arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node

Geert Uytterhoeven (1):
  i2c: riic: Simplify unsupported bus speed handling

Lad Prabhakar (7):
  i2c: riic: Use platform_get_irq() to get the interrupt
  i2c: riic: Use devm_platform_ioremap_resource()
  i2c: riic: Introduce helper functions for I2C read/write operations
  i2c: riic: Pass register offsets and chip details as OF data
  i2c: riic: Add support for R9A09G057 SoC
  dt-bindings: i2c: renesas,riic: Fix 'unevaluatedProperties' warnings
  dt-bindings: i2c: renesas,riic: Document R9A09G057 support

Wolfram Sang (1):
  i2c: move drivers from strlcpy to strscpy

 .../devicetree/bindings/i2c/renesas,riic.yaml |  26 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  88 +++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   7 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   8 +
 drivers/i2c/busses/i2c-riic.c                 | 309 +++++++++++++-----
 6 files changed, 349 insertions(+), 94 deletions(-)

-- 
2.43.0


