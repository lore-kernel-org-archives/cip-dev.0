Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CDC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:23 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.10281.1746783201879005763
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=R4mx0Ksl;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbcd9088a7so3563994a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783200; x=1747388000; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdLMOUXAEWPzS6sGDj4fnxGcwzBi5zodj18BPKeS8eE=;
        b=R4mx0Ksl4m2vqkQnLCaJ+6C2WsE0qk7SNfgaCUpgo2ngtcNPg8DX4e1fip+3qgTlVc
         FhT0CHJRGAy73fFGWmDYSeB4QmN6AOJTgNxvL8SAmjiPgOreAeuaULxLIdZiVZlh+QV1
         gICMNw3Tt+LtfWgYaV20lWbu9bcrv/c9igIUEofKEn8kk/3WRQOoqlIkJLWrxjzRVSmt
         Ok/4JigZS1WJSR8iU0OY63vR7NgYmBAMZnWPcWFYjkRNtOAbMPB8nrW7Sf0nw16ECihg
         uPE38sZ/oNXs1lpAqQdDDlyG9Uekguhs4vQceoFquyZf4Qi7ECy8HYrXn8LmOSlSP9GX
         8bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783200; x=1747388000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdLMOUXAEWPzS6sGDj4fnxGcwzBi5zodj18BPKeS8eE=;
        b=MFl3pTkcI/DIN9jTwKpFNF/39xsxxQ2OU3Tpm4jgtSyIiG3tyebo7li33IalwbAwB6
         IQ1DfA2swKF3UMyPd3QwXbHsqNA92sSkIyghvg00Nhps3EYyChgw1VcAtB+QuqnwNdmy
         FKICdm6CsfxXeRDw25R1BKK/AOiuSg9Lhf5f7rLitY2DXIfnePTRVc2FSgNgwlpIIJ7K
         Ajtd+klWQhFQ89m+aqf7Mw1AVL1706nMMoBfJKRmSFxeK6Z3m9GxzdcHhSbfzs1scLE1
         u1GfnPtnH4o5ohmx9po2MV3wviRs3ffhSaIqSnye4j/HWMu7xa3dZmvQ+QGhb9x31eoi
         coXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXTmu2TDDZ/g56yPkd0WzRFzwA6m9raAK/+AiY8HXB+G73DkXN4VP9CbiVq32IGLWZe2pYCnCv@lists.cip-project.org
X-Gm-Message-State: AOJu0YyWFKbsIYiIPHx7Pd1+cu1rXhk3CeT6zmzFm0h8TgUXpASf4dZN
	TH3O9lPkNWmXKN9hwBOKGYyGSzqjkrOPzGYzeTwLemPyPCdfmf8SUTsvSTGxUKU=
X-Gm-Gg: ASbGncvWq1KL8vUrq1/XcuO7Tmft4FJ3TNlLVQeioNPACB4KSH1POA/VDWfFFSSexwp
	S6DSkMOxmd3NosBjrYz/F1ix9pvdYL6A6K73fNLl9ETvLnN8Vksld+x+5YVXmAzJtiXdEvOIWmO
	JVawAhNtW0PzlrTpZVTiPB4KCQI7FFFN9c6PfOfGcxF3M1YVi8r0sJuwvdPLhtzG5NEPtpXB+Z7
	4WvVp3b88D4Sgjwtb7zwKjzV9r+4a7xKT7bjf/4FQ+2FjvVJtT5s9xr30c6diJWE37Fw1OqvoO3
	iflFmOm+2Bi6bEo75/PAC73rlJHqVGQxUQ4rF79ltGf6u+crikeusJHu1vUXe2i3inXLdnJVLkM
	K46+3
X-Google-Smtp-Source: AGHT+IHw143ZqDZ7IUHB5Cs1wN2RGBnape2I6sAjH7iGnoCS10PvEGi8Y7qQAJTzO2NgjalGm/khDw==
X-Received: by 2002:a05:6402:34cc:b0:5fb:5be8:3e2c with SMTP id 4fb4d7f45d1cf-5fc34e3d613mr5794998a12.9.1746783200262;
        Fri, 09 May 2025 02:33:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 00/34] RZ/G3S: Backport audio support
Date: Fri,  9 May 2025 12:32:44 +0300
Message-ID: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18817

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S audio support to v6.1.y CIP.

Thank you,
Claudiu Beznea

Claudiu Beznea (29):
  ASoC: da7213: Initialize the mutex
  ASoC: da7213: Populate max_register to regmap_config
  ASoC: da7213: Return directly the value of regcache_sync()
  ASoC: da7213: Add suspend to RAM support
  clk: renesas: r9a08g045: Add clocks, resets and power domains support
    for SSI
  clk: versaclock3: Prepare for the addition of 5L35023 device
  dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock
    generator
  clk: versaclock3: Add support for the 5L35023 variant
  ASoC: renesas: rz-ssi: Terminate all the DMA transactions
  ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
  ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
  ASoC: renesas: rz-ssi: Remove the first argument of
    rz_ssi_stream_is_play()
  ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
  ASoC: renesas: rz-ssi: Use temporary variable for struct device
  ASoC: renesas: rz-ssi: Use goto label names that specify their actions
  ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime
    resume/suspend the SSI
  ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
  ASoC: renesas: rz-ssi: Add runtime PM support
  ASoC: renesas: rz-ssi: Issue software reset in hw_params API
  ASoC: renesas: rz-ssi: Add suspend to RAM support
  ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
  ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
  ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
  pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
  arm64: dts: renesas: r9a08g045: Add SSI nodes
  arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
  arm64: dts: renesas: Add da7212 audio codec node
  arm64: dts: renesas: rzg3s-smarc: Enable SSI3
  arm64: dts: renesas: rzg3s-smarc: Add sound card

David Rau (2):
  ASoC: da7213: Add support for mono, set frame width to 32 when
    possible
  ASoC: da7213: Add new kcontrol for tonegen

Hao Bui (2):
  ASoC: da7213: Avoid setting PLL when closing audio stream
  ASoC: da7213: Extend support for the MCK in range [2, 50] MHz

Kuninori Morimoto (1):
  arm64: defconfig: Enable DA7213 Codec

 .../bindings/clock/renesas,5p35023.yaml       |   1 +
 .../bindings/sound/renesas,rz-ssi.yaml        |  19 +-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  94 +++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  47 +++-
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  63 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/clk-versaclock3.c                 |  67 +++--
 drivers/clk/renesas/r9a08g045-cpg.c           |  12 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |   2 +
 sound/soc/codecs/da7213.c                     | 230 +++++++++++++++++-
 sound/soc/codecs/da7213.h                     |  68 +++++-
 sound/soc/sh/rz-ssi.c                         | 208 ++++++++++------
 12 files changed, 685 insertions(+), 127 deletions(-)

-- 
2.43.0


