Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB9C1067049
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:32 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24570.1773329725961441685
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XrSakpAG;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so13337605e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329724; x=1773934524; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tYRJPMccBPTqSNLDzccMmbdzLB5g3pRKouTKTC3g9UA=;
        b=XrSakpAGkwE+njCLAo7VFb0cBxWzEr9c9rws76iQDcEACm9l89nEQp1MY2xSK+2ZBp
         RRjYs9rVlsj1savW7PZ4p4UHx7uuaBVhus6YSSvORDuLq67qRd/z0EFGeqKRBH/0CwJm
         3SIYUXASH90sNvETVHj46MQSr9ErKCF0AfA6zHfuB+AH2QTPza5dNNJ88Azq/Ui5ZP4p
         fKZKo8TsfLTA1VQlVlj8cXcJ53XI//GEmT+rTNqyn+eYthlBiGnMYpGWnvm11yt+7SrP
         4HRKngYFyKLTkqGvB5M4C7tBPiyikFM3QXRBBUB08QX9IqOSsmuQG84khXUTsPMMCOV6
         zKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329724; x=1773934524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYRJPMccBPTqSNLDzccMmbdzLB5g3pRKouTKTC3g9UA=;
        b=F5WYrOALZ7EhsvA1iw6nki2V+89pyavinPCNTRlY1nC3dty+nE9JElbTdYg6X1RS7A
         8/zKP9W8h2OBD2A8H93oUia7ZBPOMpas6vcDwmk1dctLPUK3IQfyza8P8HTJBPla7AeA
         F7j1s4Gyriiw4vjBos80Po5YrjQw1GnTogcRUVLwUOQuI1SbobfCVG2AgQvZnwfJLNsw
         8BBd/gaNVPysJgqYB8LOJ63c2COOzStQ0VXW2Um/r8fhGsxKlvN/VA+tU+K5USG9cknn
         /dimwOzECY2+7GOrxSzwcOtgCHtruGjrLpe9R9k7o0n/cFJfO8SkTMj1AHKy8hWml6tv
         3Rug==
X-Gm-Message-State: AOJu0YyHx286g1XWQHCYmHhXUXPG/9hzbuZCzAaPh37B5zs7VYFh/rgF
	dErS/JvhsH04vmUbZ21Tk/cZPsgNqsNr5h2K/g8J6snxobPZwlytgNNQ8VDUbQ==
X-Gm-Gg: ATEYQzyB2ZdV02cw8tnCStotJwrmGRemXVlfu+0Nj3wedfmiSZA4J14460KYwijns3+
	pdVFmgqZgGvLSU3wqzI5/FZn/9l/zs7TgMyppuMlcLa9BVZI3hc9uP9LeutnbjhDC4rzgSeX3Hn
	lwJjwqmn6z5EFqTCOF1V3ruXv6jTJQytJ+KlLLdov9GP8DOhcg+Al0SyHqBgq0LNVVzC1pGYq+/
	ePt35z/ogZ2zCaRi/r5smXmjy9dYlgcGy/d2ZyTfQcTqA11HVb8OKywQCNEyuo0Ly7MpoqrTmON
	0yb8MbYbC3hlHfG6sb6bIyYTZKEwaDz3s0EYQLMNw8AfSpmQkSsZHSupSuVJdnqysvCL+KNBndY
	hn3GiGCePn8P9v9t8d3URLZ/EHeq33hF+MC91mf8haCuwcSVYdWdKrlq5fvcPfQinIa9mr5Sawz
	/QSzfW6xJsCZrYceBh6/x0QVDSI+5K4Py8jx0vLNPxY/obGrA=
X-Received: by 2002:a05:600c:c4a2:b0:485:353f:c651 with SMTP id 5b1f17b1804b1-4854b12cfb6mr118410465e9.22.1773329723778;
        Thu, 12 Mar 2026 08:35:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:23 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/11] Add RZ/G3E USB3.2 Gen1 Host Controller support
Date: Thu, 12 Mar 2026 15:35:05 +0000
Message-ID: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22356

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E USB3.2 Gen1 Host Controller and PHY support. The USB3HOST
is compliant with the Universal Serial Bus 3.2 Specification Revision 1.0.
 - Supports 1 downstream USB receptacles
     - Number of SSP Gen2 or SS ports: 1
     - Number of HS or FS or LS ports: 1
 - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
   High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).
 - Supports all transfer-types: Control, Bulk, Interrupt, Isochronous, and
   these split-transactions.
 - Supports Power Control and Over Current Detection.

Biju Das (11):
  dt-bindings: clock: renesas,r9a09g047-cpg: Add USB3.0 core clocks
  clk: renesas: r9a09g047: Add USB3.0 clocks/resets
  dt-bindings: usb: Document Renesas RZ/G3E USB3HOST
  usb: host: xhci-rcar: Move R-Car reg definitions
  usb: host: xhci-plat: Add .post_resume_quirk for struct xhci_plat_priv
  usb: host: xhci-rcar: Add Renesas RZ/G3E USB3 Host driver support
  dt-bindings: phy: renesas: Document Renesas RZ/G3E USB3.0 PHY
  phy: renesas: Add Renesas RZ/G3E USB3.0 PHY driver
  arm64: dts: renesas: r9a09g047: Add USB3 PHY/Host nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Enable USB3HOST
  arm64: defconfig: Enable RZ/G3E USB3 PHY driver

 .../bindings/phy/renesas,rzg3e-usb3-phy.yaml  |  63 +++++
 .../bindings/usb/renesas,rzg3e-xhci.yaml      |  87 ++++++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  30 ++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  10 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c           |   9 +-
 drivers/phy/renesas/Kconfig                   |   7 +
 drivers/phy/renesas/Makefile                  |   1 +
 drivers/phy/renesas/phy-rzg3e-usb3.c          | 259 ++++++++++++++++++
 drivers/usb/host/Kconfig                      |   2 +-
 drivers/usb/host/xhci-plat.c                  |  14 +
 drivers/usb/host/xhci-plat.h                  |   1 +
 drivers/usb/host/xhci-rcar-regs.h             |  49 ++++
 drivers/usb/host/xhci-rcar.c                  | 100 ++++---
 drivers/usb/host/xhci-rzg3e-regs.h            |  12 +
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   2 +
 17 files changed, 609 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
 create mode 100644 drivers/phy/renesas/phy-rzg3e-usb3.c
 create mode 100644 drivers/usb/host/xhci-rcar-regs.h
 create mode 100644 drivers/usb/host/xhci-rzg3e-regs.h

-- 
2.43.0


