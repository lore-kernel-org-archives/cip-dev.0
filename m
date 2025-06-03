Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC29C5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:17 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web11.7115.1748942409290907259
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rbAcesrM;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso8642374a12.1
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942408; x=1749547208; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IGsngIJ4I6XDV/nj8ZkDBPfrx78PIKAmcQJrX5G4PU=;
        b=rbAcesrM5uwxTl/3sRkqntVEncjKXeYcgwVCBQM08aCyi6Bzd3+ELvC2ngOSV3K2S6
         0Jei3LyD4Tou3BCEW9GernoVa3sBX84VNbJkIzegJi+hqRMMRNxbfg8gp5BO5Mw0CD82
         UrqEa50MHkTeKW69Lidthw1rvfT1X1+wT/BERLyeUUmSf5OhnWXrMRRAr41F7RS9UDsa
         ghuJyghXkKlQE8F9IRVUOA+dyJQbIjutQHw+fMaxkCUS5sNj+YvnlyKDULd7ZCTot1XB
         LKL2X0H1GVAi8/tGbAhIKxCvQpYw+1JS8qdbXF16kv2pUZzw5CiV3Up7YiCeqjdFf0pN
         d9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942408; x=1749547208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IGsngIJ4I6XDV/nj8ZkDBPfrx78PIKAmcQJrX5G4PU=;
        b=One0zgaZ4mz3oJUl0q1AUGxi5J+hWbG8WL9r3pXi3hmrTaHkgcAWECvHL56Yw85iGR
         ZRaq0iOmy7ivRbw1xTZK5AnULlo0V0hS9+LXGXu2Tn8oGXsWH67FrTzqAFuHXzqAtCvw
         L3QPSY4pfyEYGS6/uoZwO6obECNLJmDOqVt84SmnLZJOkRsoenI6I36cQXBh0g7a/cy9
         UttH4Uz4HxpWtXSCAGgG3PltFAyiGtSZUx/rryaRrOmSAOfHsfN+eWxJulBGRVq/EkK3
         IxGoI3A9vUKaUUXAEaAvrpTAHf3F5Rq55Fp0JW7RS/Pl1CYBfYy5xVM4hV9HHnOy1inx
         /fSA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+5kiVvQ/paUggrDQPckaENtQEN1K1sTSPVCSSG2q16xZUERh+TWHHFyBdoUFVGGKRSaaG1cs@lists.cip-project.org
X-Gm-Message-State: AOJu0YwbsSO03NUgdu9Gnv+cGhPD5sl63b5YlsKIWs1MXFNbqUb4GOIu
	XdePJ9tAPlZyK6lNh9Gk7BmSVs50+6ji/YdPBa+dFZD7N1JQRD/TItf/UT9ry4lsXCU=
X-Gm-Gg: ASbGncsP+68aO/ZpyngZYvg/OyhpG4tZOaeRqeGQWg+pjBZsYjt9ajqwxH4099510KW
	gNVFYZODX2a2e9IJdW8kl3xV1rsZkxa2C7p1CimtHnOmG99FJvkXQf+XPpyUFOdi5m7MiMOb7nG
	rxFijp5YVLXtx3R1MFMoUepjR+u6kD57Tc8/Qu9qM3aHnAqSkb12LOaGQAmIr8Ce/1TNpQY28oy
	C5hFl4HDbXDAsQrloKmgqT0AjHAQCendSz+XGE7aJN5GYTCbOtJ/VhuSuiTgVVkVrTAPTZEASoH
	1g4DvdyZRLEFH5ggMq7HefFX6We4oFGWujhwj38IETYaFKF0vccwg8gRBMKyJOZrJOg//fh0e/i
	4PYXjUQ==
X-Google-Smtp-Source: AGHT+IH1CTw7gLi4T9/LCnDshUCW1rinCJQ2YlaFKVSSoGznc9bRTUAx9K8r+v/MuOg4SZ+6KgL9Zw==
X-Received: by 2002:a17:906:3956:b0:add:ee2c:7313 with SMTP id a640c23a62f3a-addee2c870fmr7206866b.22.1748942407603;
        Tue, 03 Jun 2025 02:20:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 0/7] RZ/G3S: Backport SCIF support
Date: Tue,  3 Jun 2025 12:19:58 +0300
Message-ID: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18983

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S SCIF support to v6.12.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (6):
  clk: renesas: r9a08g045: Add clock, reset and power domain for the
    remaining SCIFs
  serial: sh-sci: Update the suspend/resume support
  arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
  arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
    different switches
  arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
  arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1

Geert Uytterhoeven (1):
  serial: sh-sci: Save and restore more registers

 arch/arm64/boot/dts/renesas/Makefile          |  3 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90 +++++++++++++++++
 .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 ++++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +---
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 13 +++
 drivers/clk/renesas/r9a08g045-cpg.c           | 25 +++++
 drivers/tty/serial/sh-sci.c                   | 96 ++++++++++++++++++-
 8 files changed, 314 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.43.0


