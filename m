Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F2C44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:28 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89964.1783076366481491115
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CIFYWJtu;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so2328795e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076364; x=1783681164; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3lHpPVAlRD0K9M8Jdy2ruGoXZmcWhpK1wnMTXIYgUw=;
        b=CIFYWJtuk1DoSezDBeIqJEnFGao0OFIqrAUKY5sq5yFR0WwkSkLDcfMzWBm5C0J5q0
         e9+s3UZ8dvCUiWrAA1+sBGnR96InZRn8nLj2514zGLgRUUrr30amnaklFUrb5rVcMXN1
         rJuN5nRr1eboDJdnA2+8zppOB0lJEtCxXnNCcEV9hnnrUIVgR9eZgFCV8qckZHOBOp9Q
         lEsRavA7hku+1SMfXkBuU6bmEHSSVZJxgWpmtkPXE/R2Y74ciFNw7cgDtWWIzmODp+bT
         ONqFQrU7tKp9BjLnsM5a0TP0VOnRFVvLQjBlAfdJqROYGvNPxgMaegEymu3dfV08e2Du
         wqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076364; x=1783681164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3lHpPVAlRD0K9M8Jdy2ruGoXZmcWhpK1wnMTXIYgUw=;
        b=YCje3q2BTZvcBDpeb4aup6XK8r9eFprytGTN24MwhutiQKFhPwUXgNhEj9Q8A8mLCE
         mR+qQAZjWZScfpIAhEyaxtEG6SsBijzFI/W+US92/+/tJezsk4Ugl5kQ44dVBET7Z6N1
         drDV5h+HpFHMBb6t1vCxwqc81oeaiUk4HWnVgLv44n08HlhMtq2xiwGhafeKSg0OLWKu
         B9dGA5Ve6HlbfNmtXSpgVt3f0AyUL76MXXxcBjOQUbuhQ9YoMea7E5bEG5hi88zg30iA
         3W32WP9TTdJqFL42mBe1HbKJCt0HsIkJl6V9QwdUkWWH22LLk/Mp2dFPJ6vlfZ56OsQs
         C/UA==
X-Gm-Message-State: AOJu0YzI5t7Ubc0PblisWWIYCmmcpqzt422gPuQCe7InHAGSh5SAeK7U
	VJOrufksaE6/RBfO8GMZBsiQO75lSHkZQlkzK6eRC4utQJMa0r8SmFJWQiJ5pZfa
X-Gm-Gg: AfdE7clDFZIkpqJ+o6bQzaX1FjL8HT2cPU4gzjFijzxyuaNuP8tj3XgweBkUytlHqbV
	8JwY5M+84lt9kehphtOR/hREkq/pEEsm1IqT/drhBzZ8D9dOKTYyxSumWCbit1qY8zebNJ0Ao6+
	ILYvflM81KWPMRDYror1O30qdldYCdLtbimp9cMrwEkoU4bfh/5z3xPDr2MMJ4nc62maiy1bayA
	ewufr9lKUcBxoPokTCra1KAGzLnxLTwMrBBmQZGI9Sp51N/24r4opw4LKymazI/oAQy7nWXXmUF
	6L/2oSznZL+4ACqEHazKtEV8UDHNujiPwROk1Sdm8DCP9ko3iKmpD8N3Hys6KmYZDnM/WqDj24X
	+z5qJAS3WMMaaxELiyXlSccO2Jxh9YnHMhgzCN+Km+C4hoYLlfy8I1pNg5almE0oOnjCprXsazz
	m6hEMNxexNy0BZm+VxG88P
X-Received: by 2002:a05:600c:34d4:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-493c2b3a709mr138537135e9.2.1783076364403;
        Fri, 03 Jul 2026 03:59:24 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:24 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/23] Add support for RZ/G3L pincontrol
Date: Fri,  3 Jul 2026 11:58:51 +0100
Message-ID: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23419

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series aims to add pinctrl driver support for RZ/G3L SoC.

All the patches from this series are cherry-picked from mainline except
the patch for dropping "syscon" fallback compatible from sysc/sys
nodes from RZ/G3S, RZ/G3E, RZ/V2H and RZ/V2N to match with the
documentation after backporting the commit ba5095ebbc7a ("mfd: syscon:
Allow syscon nodes without a "syscon" compatible") to 6.12.y-cip.

This patch series has runtime dependency upon [1]
[1] https://lore.kernel.org/cip-dev/20260703100756.238233-1-biju.das.jz@bp.renesas.com/T/#t

Biju Das (16):
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document reset-names
  dt-bindings: pinctrl: renesas: Document RZ/G3L SoC
  pinctrl: renesas: rzg2l: Make QSPI register handling conditional
  pinctrl: renesas: rzg2l: Add support for selecting power source for
    {WDT,AWO,ISO}
  pinctrl: renesas: rzg2l: Update OEN pin validation to use exact match
  pinctrl: renesas: rzg2l: Add support for RZ/G3L SoC
  pinctrl: renesas: rzg2l: Simplify rzg2l_pinctrl_set_mux()
  pinctrl: renesas: rzg2l: Add support for clone channel control
  arm64: dts: renesas: Add pinctrl reset-names for RZ/G2L and RZ/V2H
    family SoCs
  arm64: dts: renesas: Drop "syscon" fallback compatible from sysc/sys
    nodes
  arm64: dts: renesas: r9a08g046: Add ICU node
  arm64: dts: renesas: r9a08g046: Add pincontrol node
  arm64: dts: renesas: r9a08g046l48-smarc: Add SCIF0 pincontrol
  arm64: dts: renesas: rzg3l-smarc-som: Add pinctrl configuration for
    ETH0
  arm64: dts: renesas: rzg3l-smarc-som: Enable eth1 (GBETH1) interface
  arm64: dts: renesas: r9a08g046l48-smarc: Add gpio keys

John Madieu (1):
  pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling

Lad Prabhakar (5):
  pinctrl: renesas: rzg2l: Fix SMT register cache handling
  pinctrl: renesas: rzg2l: Add SR register cache for PM suspend/resume
  pinctrl: renesas: rzg2l: Handle RZ/V2H(P) IOLH configuration in PM
    cache
  pinctrl: renesas: rzg2l: Add NOD register cache for PM suspend/resume
  pinctrl: renesas: rzg2l: Handle PUPD for RZ/V2H(P) dedicated pins in
    PM

Rob Herring (Arm) (1):
  mfd: syscon: Allow syscon nodes without a "syscon" compatible

 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  37 +-
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   1 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |   1 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   3 +-
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 103 ++-
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  39 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |   3 +-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    |   3 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |   3 +-
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 110 +++
 drivers/mfd/syscon.c                          |  12 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 650 ++++++++++++++++--
 .../pinctrl/renesas,r9a08g046-pinctrl.h       |  38 +
 14 files changed, 932 insertions(+), 72 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h

-- 
2.43.0


