Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E3D65534
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:05 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11297.1765967512361995377
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:31:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=R1p5zrVK;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so11120117a12.1
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967511; x=1766572311; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N30TwpZhjn+2klR7SVFcU1iOQpSEMKtig6X8bECb85U=;
        b=R1p5zrVK8ERxl14N3grc1swnPZ9DzXajgY+VD1ADYYFqSHi3zKRg6DcuFA0fooxoqH
         dy6PIlmZCQZ6pw+s52Dd6C+Oy7fvDIMXwmKqk2WaPY8FxAlLE0MmhsacTEK/DeJMp1Aw
         B0WaGPH5UJJMT6b/PZszqp8pkVBr2bz4qDZoOXmXXrKlbxs3KDbMHhRYF05O0SfYEeIx
         3aALumVeuqHlfNHldn775shYJr3d/FtaEFzVERa8xVxMbHJ2mvw+i71EjxyT4V9bBCUK
         DfjwtAoPkHCXBNrxPlyor5n1NfhO1toQD5Jtxii9cC2OFuzzZeQtsffmYEFoQvi7hGJ4
         KY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967511; x=1766572311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N30TwpZhjn+2klR7SVFcU1iOQpSEMKtig6X8bECb85U=;
        b=i7tObrPiluH4KUcLIg/t9BPxqDEATCJo2hbY1LsSfHvmeOVbIhXOoGFONgFSiRpvKh
         layc//RIDlAnLYykX5dhhZDSQXd0vmBAx/Z1EUj6CuQhapJ9H+OlvBBDgLgiVh1kOcX1
         z3ri0aTs3aDSnDLlaoTsGd3raa56QowL6VHdcmYuEt6MuZtTVYFzO/ItjQ2Nd/8HUsdn
         d+ke63X1UzNHTaM51L3+pVcBuIy3CyMBaU0T7nkmh4QvYfnN8dJ/kD2ro+I+elpLr/um
         ceOrp2uPes1c4iTGrnMBlnhyHQBfaXNp73/Kja6T6CY7oGZryle2+6vbytxz+kE6swaI
         vUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYkHlFyNTpkZ7jNn8Mdnf0w/uY2lsacLmZYhyU36KgEQdg9REvAnCuucSPe+ck2kFv9z4nVRQg@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz9K5BZM3sgQlN06fHfAAXxuVbsdu98M418Juiz1alt2LABOSqe
	jserquUby5oAjUjTPyCgjGXq7ngVsNKaSh/LkEUNK7EUAHzZZTf/8mWUB40+7+YVpuU=
X-Gm-Gg: AY/fxX785aYuxD7isDCnQbXQm1i6g1GuX/Bwhi+rje4ADIkNFo4wEvH2BpKBa6tFm5x
	ixPAJ+e16y1ioVbvWlLKjBaojpJcE3kIdUw//dFdqlJi2VCLYyjp0eCWTcmyUqFqCVG80op3oI/
	JTqmNTSGFW/wDqz3zTF0YQ2BL+iB0KLs0zOJo1tajMlAfV2Vqu6Bk/wCO677OqmDhx6U3VcTl25
	wBAcK35+4V4PnKGOVNgrytXdieAHDy1VlHP6FZkhgdVHKTfxjyp0loqSQ3bg7lEvEhi8QQzLtDw
	ZXHouGeraJ8r5dp/AA5pgXlGvKKVa+umgHvFoJH0jyALvBiodPUNNpfd8Jwq5R+S1uHffsvGdkd
	ZWu5bT797o4Wa7SOtgPRwERw3Lfy2lFkKxVceTVijSGHOZKYxVV+shM0VT6X/YH9ZX6Y2BfPat1
	7Z1w9q2ENGwQ8z8Xhq1j1AKwsPTvEoGGGoUoSVOZvQ
X-Google-Smtp-Source: AGHT+IFlocmOZziIL/lG/8u5uE7t7HQg2/a1snQqK9male2y6bv+kqiVC/OSUlhGwI5rqqdkreQMRA==
X-Received: by 2002:a05:6402:210e:b0:646:6de:a09f with SMTP id 4fb4d7f45d1cf-6499b16e8eamr15368566a12.2.1765967510593;
        Wed, 17 Dec 2025 02:31:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:31:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 0/7] RZ/G3S: Backport TSU support
Date: Wed, 17 Dec 2025 12:31:41 +0200
Message-ID: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21097

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

 .../thermal/renesas,r9a08g045-tsu.yaml        |  93 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  77 ++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   7 +-
 drivers/clk/renesas/rzg2l-cpg.c               |  13 +-
 drivers/clk/renesas/rzg2l-cpg.h               |  10 +-
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/rzg3s_thermal.c               | 318 ++++++++++++++++++
 11 files changed, 528 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 create mode 100644 drivers/thermal/rzg3s_thermal.c

-- 
2.43.0


