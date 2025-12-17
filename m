Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FBED6553A
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:15 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11758.1765967533772060055
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dB0YY8id;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so11056791a12.1
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967532; x=1766572332; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1dAODUGrp1Y7Af33s6dlSwTGWT8za1+Qb/woLYXaPI=;
        b=dB0YY8idSNChuPLW+E7QXpAnog+x5g/v8vZ3lDgZ+l/HIykdD4fe1NEBNtfcCP4mlh
         LWjxuI/wMnQ87LKl2nJN0YfVWNT7wyS7HQxYR/BMlWoEb7sv6HB8nt8v4qDO7mO2/vOb
         Rk7euvowUi3QtLtd2/GaRa65T/b5nIpKpuWVxdOcu+1YfHYDYQAXjjY8pyOxsUbyLBfH
         99G56PgIDbJKgs5Dd+wDTcGD7U4Ktu5okGETMMw97saXyGIqxCF6WU6rhuySFWcgjJGG
         0Lh69y+U4dKGLBW2y0DHCvdfoN8S3ThQs636GT96xcbsWfXO6ucebYQtEpcy/le5W0DY
         NfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967532; x=1766572332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1dAODUGrp1Y7Af33s6dlSwTGWT8za1+Qb/woLYXaPI=;
        b=awzTKGQ/j4kaligbWQE3cNxjBxi87h+PknTSYMy7oCdkUKc9ZVysR9SvFVn8fbzD5c
         LWw5FdVKg5qyesJ2EWyAZltvTmDhLv9cSBRkfAlKcUHFze2CLcU+3/fnKkRflPnxW04I
         AuBTfc4Ajg/o7q+kWn5l43VM6CIvwaMbwStF6LW5JHJha4vfrea1V8ngckNPKtqLzPIm
         HC6JA7NDPXzBMzC+WWj2EUyktV/qFQAhqXUSXetw1BhLhcCF/foqLm9Sf+OpmGqdjLfv
         qzgCbURQMCR3yAIiTfKEmgOSycUmasxE2Xqw+SvZPy78YmnwAg6adkk+paqNvjtTawdw
         My7A==
X-Forwarded-Encrypted: i=1; AJvYcCWd0HgcJbHTZ7/ecfeL0rfnb/cXNUM1lMdZOmPKsSlwJbxQDRxXV+iG6oUpaElsznSHRi5H319+@lists.cip-project.org
X-Gm-Message-State: AOJu0YzEr9d1+sQinTlTm0yZ6GO9f6qzBj0szKXc2wYPAFlTNwdScD6Z
	iot3kCQUNs+ObGeFPOiVQu4fCubWeTqhVqyem0L/UiNZzUvV9JWIatSIYxc3TzFNUu8=
X-Gm-Gg: AY/fxX4U2OkZdmXeLk1ZX98DCLqoaSniZNee98G+NircV4CrgbCoi12TxN1omQ8X/+X
	mQBqV14C+AcLJXblKY9//7I4wFuwoJiETkRKfpYBPV5kJlCgNgk4V5vgCusb5BeYx6YZjNozTnD
	QqNya5as6A03bmlyphu3oCgcN16YNrHpOrzf5s7Caz8OkXSdkEA05kTgI5UwqKWbsul+tnH/SgX
	feO7LW/xGYtEOxTny2wv4D3R2t8JMyEcgbJO2OjpPAT9bW3hoq9iYWm1RNPHXvcjFqiFbheO0I7
	EgjMzo/iNJtTXwMoxniEnye8ueQC/uGGLpyJLMHFPsp24ThOcZqmNZbm91e88k3sgciAjrNjq+J
	GgT3QgoDMdh4af/S83JypMRH2F5wXWn1ZwYgDzbkdsFMgh6IvpDYtLMhrBAEoSQ33YA7A7vJECU
	fezQpuVOrY/pPRTXfFstCk26UBi+zLFPUQyjkZXXm3
X-Google-Smtp-Source: AGHT+IGULTws7/JkGSnjunk55qhd6AJheIqLeg0pN5rtjLuRxdCUyF3yxRAALKEuAVK3qjokTJMwQA==
X-Received: by 2002:a17:907:d8d:b0:b76:74b6:da75 with SMTP id a640c23a62f3a-b7d23c1aa40mr1707184666b.38.1765967532179;
        Wed, 17 Dec 2025 02:32:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 0/7] RZ/G3S: Backport TSU support
Date: Wed, 17 Dec 2025 12:32:03 +0200
Message-ID: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21105

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the TSU (Thermal Sensor Unit) support for RZ/G3S.

Thank you,
Claudiu

Claudiu Beznea (7):
  clk: renesas: r8a08g045: Check the source of the CPU PLL settings
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the TSU IP
  dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
  thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas
    RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add OPP table
  arm64: dts: renesas: r9a08g045: Add TSU node
  arm64: defconfig: Enable Renesas RZ/G3S thermal driver

 .../thermal/renesas,r9a08g045-tsu.yaml        |  93 ++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  77 ++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   7 +-
 drivers/clk/renesas/rzg2l-cpg.c               |  13 +-
 drivers/clk/renesas/rzg2l-cpg.h               |  10 +-
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/rzg3s_thermal.c               | 292 ++++++++++++++++++
 11 files changed, 502 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 create mode 100644 drivers/thermal/rzg3s_thermal.c

-- 
2.43.0


