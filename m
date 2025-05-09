Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9737C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:54 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.10331.1746783286610751162
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kWhQoWsK;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so268969866b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783285; x=1747388085; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWPIHhH8KYRl9RG3iMEU9APYru22ZWUBajQzTnZAhXE=;
        b=kWhQoWsKx7CBNwiHPipLG/BeYrzF0Q3CyvXZg6F2DzHCyikx4TsE7i4fph+bC6HPTb
         o+aaIGE+VYbpeWEuolSXeKZND+VFek3D8m+rqo0VMfm0Vj0fYJ8DSMNHCS1U4LsbVeg3
         rFWkxCdoTw1PTzg37D6090hrl8DUVnZRSmMjGAjOYvkjxR4Z0NyaCI9sbTcrF4YjtKpD
         GTF5McL4+mAmO59Grmg3iFKKMBl5dRiEeIGHDQ5/3Ab93uyevcqhX4CkXaNtA/96bpuc
         Eaivbu0MFDc7BinWY1HnkFdltb5NfW0C0RDDdEXXmOTjIqASswnAD1Q5WUA1GuYCw6lD
         mXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783285; x=1747388085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWPIHhH8KYRl9RG3iMEU9APYru22ZWUBajQzTnZAhXE=;
        b=Vv+abg8DcrUjJm/ntkM0q6TmDR9pmU/mVQI2EbmcTXVXDNDCsJ+OP/4bedEaY9d3jg
         keKq4Jvo/M7t6A8Z6qkxyHxISwi0Z6zFB/btz0XH6+zevNI/gshdbDzGrJkdFsFA+Tw2
         BhdgJ6XUSf6U9HuzWkEp3MQVvZUE0aXwZ5vu69YKOKxyTIPI+NiAX7P0IN1BrcvTBke6
         HmY8OYI9648OHRWQ9lYqBSQFAzNQq8/nmJkeOBBBcV2n8IqjSJsU/egngavYxB89KFtN
         L5PpoU1ydYFVaoNprepDZ+UEFfN/f91x39wQOhvyHGNPxlvaduFti2owyLdzT6mEjZnv
         Zy0w==
X-Forwarded-Encrypted: i=1; AJvYcCUpM0wbSzBiKMxfkhxOanD1NXaEtxuaoJamzrh//SV06UUKA0MIEFbWGx8VC+yEj2BNJaASkf+7@lists.cip-project.org
X-Gm-Message-State: AOJu0YzfqPmd4oDOTn1M/gjTO4lJdbU4ErrAQpvhC+RslJQ2Jstv+vFK
	pTZ4UnP8tAniSf6PVyplBiobpoMSdac1UlXvOsJi5c1CTlCENSmWejbSpD6gMiw=
X-Gm-Gg: ASbGncsrbcRTOjbaoSBJsXendsG+PNu/bvBs135k4q/d/Pl8vkjmZIa6oogotHqhm5F
	562xpdiFqf66THxNqDG+9+npvLNMUQi/DXJWS7+SPbGku41M9fptW+eY9JUWGMuggmbS2yqHnSl
	9ElfrScfUbLcH+CCOVh6bhmHqKILWhlTH0XJ2xA/rhFugqEEGt5J9sVXeaGtCo98GylYsAtINoG
	J6pRglvLb2gFQOwJMShqCE0KkluJ3rWUqPSVanBOqEgLWEAfluJkviqLAQeE1FjbM6gaitPZ/QR
	MmkHUaXm37i6jhVUR1mdf3QGJxQmDTuAVSDr8j13GAmvWEJ2qClfoef8hCFxpu1aIslI++mWgH8
	8wKRB
X-Google-Smtp-Source: AGHT+IGtmrdzipV/rLcFXiEt6pw/T3aFV3617FL2VuuVB5KjXV3/7eYWqApZzW7o+M+zQZ52M8jiLQ==
X-Received: by 2002:a17:907:e918:b0:ace:9d35:6987 with SMTP id a640c23a62f3a-ad218ea5b7dmr269603166b.3.1746783284775;
        Fri, 09 May 2025 02:34:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/37] RZ/G3S: Backport audio support
Date: Fri,  9 May 2025 12:34:05 +0300
Message-ID: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18852

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the Renesas RZ/G3S audio support to v5.10.y CIP.

Thank you,
Claudiu Beznea

Cezary Rojewski (1):
  ASoC: codecs: da7213: Simplify mclk initialization

Claudiu Beznea (30):
  ASoC: da7213: Populate max_register to regmap_config
  ASoC: da7213: Return directly the value of regcache_sync()
  ASoC: da7213: Add suspend to RAM support
  ASoC: da7213: Initialize the mutex
  clk: renesas: r9a08g045: Add clocks, resets and power domains support
    for SSI
  clk: versaclock3: Prepare for the addition of 5L35023 device
  dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock
    generator
  clk: versaclock3: Add support for the 5L35023 variant
  ASoC: renesas: rz-ssi: Terminate all the DMA transactions
  ASoC: renesas: rz-ssi: Use only the proper amount of dividers
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

Duy Nguyen (1):
  ASoC: da7213.c: add missing pm_runtime_disable()

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
 sound/soc/codecs/da7213.c                     | 250 ++++++++++++++++--
 sound/soc/codecs/da7213.h                     |  68 ++++-
 sound/soc/sh/rz-ssi.c                         | 211 +++++++++------
 12 files changed, 698 insertions(+), 137 deletions(-)

-- 
2.43.0


