Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6E4C71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.7068.1749809740235027303
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=W1t+WHrP;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso1568699a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809739; x=1750414539; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWJDW+eUKn3+suapcxO+glNYeg+mj+rSGVqbj3rcoqs=;
        b=W1t+WHrPd4nKnhN/EEcBk3rkR6zjqeEe8JGMusewXRfvFgtlJ0Ho9Hpcj1nVd5jQcU
         zifWzJ9xHBYNsg7jAQ0UEMWQ8VFBNkrn3CoW7PT34b9WGag4Yta1ZRxAEdZsUKsVPbHY
         eI5K0YfKORyFCrn/ZETNegI/dCJEv6hyiqfvDd7aCZCVvwMcKAxQzJdyuXH9a1nJXsrv
         g5IK8HE6APZAMVqaxJmbk44VOXbRzQbvBEGRzkYRPnLk+8beQjKAvFBxytrmplmViCM2
         iTXl9ASWoi6nUT2kGWvQFk3CkDkkEVyNF0RhfafxRG/cSBHKFl8XmaA9n9rT9boMiZVh
         Q62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809739; x=1750414539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWJDW+eUKn3+suapcxO+glNYeg+mj+rSGVqbj3rcoqs=;
        b=WFrxLXoPIey0F0mWT5k5lhPmkuCtR+0mO00jWW556e0d4T/B3uJHXiNtXbHVYXUBDw
         ea+BUY++neXwhj89RQAeipy0QnlH8sZuIfkjGe0hGxWYMD1hRDbdxyUY7wPxpMzByXop
         huOuFP+PRScquPLmRcxnl5CSgbKLzkYoLYm3TZ0raN8Dp6FeLqKvmZ1ZB5vNjokikK2D
         feXDgUwMfLPXiKoYASyd/VytWL9XnZxr8SeZQGWEiANom9vJEBZHyVzrogENzwbjx4Ho
         qHymD2wQacERIIVArgcPp+XnwQwNQmq7Xt1r0gtQxFJpR17/8RsP/Q/nXThwgztfAbxO
         uyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYhZ4T3oXBPKtSpFCRUvMvB1K3lUmuN3+HBGY61Yyxkc9gXnV2K34Cm8c21P23TsB2iTsV0GuO@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw6FX8vCx3Zn5jwYPUK6pNgMCSwp7dxz+D2wpYkgJj/uuIAYjqW
	IriE0X9itrtn3w3vSO8oc0jS6Z+En8wh7ERO5T1m08gmZh++TSXzu18wNfOpEV3Wmq2HMeRCP5a
	rqT/l
X-Gm-Gg: ASbGnctuoDMk18MwLSIm92eAPdzgvoPjAuv1Jmgc5fd8PLckR/Y4GDv66PVXB4oW8eS
	jamxZPS1NTlkhd0OipyGSJn+j+8jeAUCUBiAAmeYDdzqEgaJ3Q2TkAZTn55WDC08a2vJDBfR1rU
	Mx0C+BdB3jyROLX3jCOuq0gPzyLAtHQSwTFTZ2SE7XpbQ//ADZXwGano5E9dgfnojXP1yFmOCLo
	pgom3LE71o++rfhZVqsEytbmQNDgV+jiGuG/OUkwxcq5BBAZVvSIezMIYZnfKMpyrRsJMKzaqIA
	HSxQx4uEQ2m36LPHC1IIe1ss/djIaiJXfQEV6zH+m8iFd/Cc+Mgu4LlPPG+odpg8UreValWGakL
	yS7CfQcSmcIqhpNWo
X-Google-Smtp-Source: AGHT+IHTSMgoKaj815oNNtTl71mTZ6LFrsZ1flb/Ku3sT+kv11YYoLDZWOlNnZad9QyJGLab/eLDyw==
X-Received: by 2002:a05:6402:27cf:b0:606:c388:636d with SMTP id 4fb4d7f45d1cf-608b4a093f3mr2212901a12.27.1749809738645;
        Fri, 13 Jun 2025 03:15:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 00/14] RZ/G3S: Backport ADC support
Date: Fri, 13 Jun 2025 13:15:22 +0300
Message-ID: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19054

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S ADC support to v6.1.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (14):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the ADC IP
  iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
  iio: adc: rzg2l_adc: Simplify the runtime PM code
  iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
  iio: adc: rzg2l_adc: Use read_poll_timeout()
  iio: adc: rzg2l_adc: Simplify the locking scheme in
    rzg2l_adc_read_raw()
  iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
  iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
  iio: adc: rzg2l_adc: Add support for channel 8
  iio: adc: rzg2l_adc: Add suspend/resume support
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
  iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add ADC node
  arm64: dts: renesas: rzg3s-smarc-som: Enable ADC

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  39 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  53 +++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   5 +
 drivers/iio/adc/rzg2l_adc.c                   | 426 ++++++++++--------
 5 files changed, 331 insertions(+), 196 deletions(-)

-- 
2.43.0


