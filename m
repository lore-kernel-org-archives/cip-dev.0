Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8392A10611FA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:41 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18733.1773227197087711304
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=InMyQbhI;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b611274bso6928714f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227195; x=1773831995; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zXwm9h5gC2jVyAv5719nqYMwFjVy1J1n5NJPS/aELEU=;
        b=InMyQbhIqfTuIRqHgpnNJGLQXc49uX2gTrnROZgErpylW0iDHPd/ePFfrLz6mpW6I/
         bojoLaZQLJm/K4qnvPc31DH25RHpHtHSRHRG+8T/O2IOeU2AbyYMnE9B9ywITcaGDR+e
         y00pZ2svQWiRjS/bQWZYhGhOu/hijhxstys40dGgqltlVy+GNEiEX2gD3p3NkaJfdpH+
         tVzLvTE5aSJRkffaLiXLUFclrBiY3VYONiuEzaQbGBMo0+FPiMwS1ugFBZoDjpzUPn/Y
         LCPqQhBDoikI+qBV2UhA3t5CDZ0ABJOg/+9PiIUkd0mffnwa/9ymcd0EkfHJ1AlB+f21
         ZK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227195; x=1773831995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXwm9h5gC2jVyAv5719nqYMwFjVy1J1n5NJPS/aELEU=;
        b=WHiww2MioIiEmc9WeJZpnZ3lYr+45Bm0FsVCexLyG2YUPKp5YNCWcpaR2uE2P0z7+t
         ewijEIR4yiBzz7aPQypIi0U8iJ6BGm788KjmuhacSoEwfuO3KexAVEutaEehXaUgiElr
         ZhNkcAdHv6Bmbvn0hDO7pcW2FsIHXDkDev7IH+EWwEKQh4LtY0harV0i3nLAUSjXuXNV
         HU83/4LSHl/QRsQ1RlcDf0ZBp6rID8gn2c+QxzQ17C1dtp8k5/YqjrSErTQhYgGjq5Os
         mzKh3QbU/mJ+8xwxJ0X+mpB9QmAhuzPJT5t5NuzWtm64dxOqlfMaxAL3ikUSZDFhfE7a
         sSgQ==
X-Gm-Message-State: AOJu0YzqoZDhs8tl6cEFpxLmDahpqJaRQP+zOWBD01CtuFCzwdxyFi7O
	9s70nfkgRLnDR7JYUOHLAJrw8XE+g2lA2UHB795V7jOI0w3dw3Qf2AI1hsDklsLGzrc=
X-Gm-Gg: ATEYQzwQcYUXsfa6YzwNjC7+Pfechev7fKe76w+bcLPxamY4XSTJYR2EGwtIeRXoe7P
	nZQq4HGGmoEMFfsLO5nxEv76k5WgUdjbjksh+PRswAQX6S/cYrmovV1EUtHo/Sr9v7b9Nw4N62J
	SQKpX8qGUCdltWDT+h76HsfrLt76p/PZayEsgli6rMjfzUc5rVhfkTYlCmFWtEsHRiFmX7iq0sY
	gf2xqxVhsQ3BVWDR3W0c1hOVGKKVVqwI8hM1eSbsEc8c1wiADRSLLOM2h7Q/higP9J5OqYQJEXB
	b9UFUiS81hUlnx/kQhBw+yhtoJVuBZ9Y7RW/RRunzvVICw+PUp7uNgx/5tVebktCMXabh0nezb3
	IwDZrpTsP5MahWAPulrzONqCddqQCTgewPtuBG6IzEuB3gJSQJrvwvDk2kA1/m2C4RXBccRjCgg
	Y2Tu2GCEJqbplqRxQPQc/NJUunneznmcPjrBURV0e7s2GBqF3K1+Pn30Fc7Wn5bfQ=
X-Received: by 2002:a05:6000:310c:b0:439:b744:c601 with SMTP id ffacd0b85a97d-439f822bc29mr4402558f8f.40.1773227195461;
        Wed, 11 Mar 2026 04:06:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 00/13] Add RZ/G3S PCIe support
Date: Wed, 11 Mar 2026 13:06:20 +0200
Message-ID: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22326

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds PCIe support for the Renesas RZ/G3S SoC.
Please have a look.

Thank you,
Claudiu

Claudiu Beznea (11):
  clk: renesas: r9a08g045: Add PCIe clocks and resets
  dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding
  PCI: Add Renesas RZ/G3S host controller driver
  PCI: rzg3s-host: Initialize MSI status bitmap before use
  PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
  PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and
    RZG3S_PCI_PINTRCVIS
  arm64: dts: renesas: r9a08g045: Use syscon compatible for the system
    controller
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

Felix Gu (1):
  PCI: rzg3s-host: Fix device node reference leak in
    rzg3s_pcie_host_parse_port()

Niklas Cassel (1):
  PCI: Move link up wait time and max retries macros to pci.h

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  249 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   67 +-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   19 +
 drivers/pci/controller/Kconfig                |    9 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/dwc/pcie-designware.c  |    6 +-
 drivers/pci/controller/dwc/pcie-designware.h  |    4 -
 drivers/pci/controller/pcie-rzg3s-host.c      | 1764 +++++++++++++++++
 drivers/pci/pci.h                             |    4 +
 13 files changed, 2140 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


