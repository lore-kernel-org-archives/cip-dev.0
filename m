Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD58FD8746
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:56 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73767.1773747406530447858
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=neJYQXO9;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48534237460so61163915e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747405; x=1774352205; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=us8OGSJYZsKIFiuWcz0Sckr4CzN9Mwwe34sm5EGWlfg=;
        b=neJYQXO9kwS0Vu3tUw1d8RE9JyHe7kfvLff/YKBNhlA5D+DcJN4eJR2K92orWwbWx1
         VLc2vNC22WQW3wFnNiFO73Ub1/Md7ytieaRRlv7VUYOJqH6nb52NNi+U/kfvf09/7FhR
         idZiCb6Fp3NkZfdlKik0qXdSjOZaEBZesTXkZdVT8FPng7nhk4d+o5n5/Q1qbaJk+Plh
         sYn5JK1aLWhdBTepvQdzr2fiQ+JgwhtlMNxRHlvALRl3Y6OA7r3fIEZ+bdy0GPSDpEsR
         hEkxdgvV3Yr0zIk+JxK/aiw0hJizCWD9+xG+pcvMG7ZRbEMSKveSZ+7WKJwhk+p/IDOG
         sGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747405; x=1774352205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us8OGSJYZsKIFiuWcz0Sckr4CzN9Mwwe34sm5EGWlfg=;
        b=Y9MyN4cJNhpTsZsG0U5o9Uull3knN6kluJhsdLqWi4F9k3C4SSX8jGGEw5isFbuBnT
         RpUncNqxpyaqFE2VUmwSiyHCyaruVONrwzuqhoDR7nZnWdHWlB2g+SoruWqP5BUyAQMs
         ZSfbioLu/A391SZhpBmthX1Fy4QtFCdPV5SLn65YqDF17AD+eZNwPQPVF0nUd/TvzBFN
         47e9YMcMwEIGyqbqTAsLNok1ccgx8XFQBkk5l/GzFQgYcISts1BT+JdgEXWtzRuRnxJ2
         EH+N25QwaVMrZiEOX7p5drIawv3DGVCmyXs8wyXLoFF8MYpEAhKUok8rVglgCgb+o8dB
         dYZg==
X-Gm-Message-State: AOJu0YyqtVQBdO5iW4totAWijLK8VjWQL7eYz294J7UoEEOjredJ3zjn
	IgSfDU0edFyn28rx6MjBbPDoVgd2tavWoqpoCkxkYRjL0c623Ik37kNSOB8biw==
X-Gm-Gg: ATEYQzyBXi7U7RX9V6Ab3VsCH/sf1JC6IEfsmqCxFGQLNqC3mYuCpeQwnnlpKLji4/Q
	aCxVlY3lL2lUU2bfHVZx6DVSCpDxylfzwBXyAq/ALFeWTdDsCHkh3watuCWfwd08HAoUkYWcyXs
	Bly+JM35HQumVQ4eKBCyC9MDMhlmHfv2s7T9DrT6t+z1pZq7mwyzycIT1wooR9c/0vxNd/MQtZe
	ygClR9GoGT0NhcJBdXP/NzSKqdih2AnOt30JFMVL8XJmWP40i8A4jILrdw5w9sp+NSoceyjqqsY
	KBCTuFqU1yAnimrqs3CzLeCd1p2q0wA37BVWti22D03PFj6o/pgkljbYLrX/mvTM5mTiElHwKnH
	3WXPwnLc/J9T5vbwiNl7m4uuFQoNTM8ksWEJvfg1FC1DOnwQ/olz7xv6qSyJ8r9tVan6Tmw0TZq
	7iUM4bjAxshZeonRusHJSqWt+DhAY5sKQ/IJ4MdzncyDu90eW0
X-Received: by 2002:a05:600c:348e:b0:485:ae14:8182 with SMTP id 5b1f17b1804b1-485ae1486d1mr28090915e9.11.1773747404414;
        Tue, 17 Mar 2026 04:36:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:44 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/11] Add Renesas RZ/G3E USB3.2 Gen1 Host Controller support
Date: Tue, 17 Mar 2026 11:36:27 +0000
Message-ID: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22474

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

Add Renesas RZ/G3E USB3.2 Gen1 Host Controller and PHY support. The
USB3 HOST is compliant with the Universal Serial Bus 3.2 Specification
Revision 1.0.
 - Supports 1 downstream USB receptacles
     - Number of SSP Gen2 or SS ports: 1
     - Number of HS or FS or LS ports: 1
 - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
   High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).
 - Supports all transfer-types: Control, Bulk, Interrupt, Isochronous, and
   these split-transactions.
 - Supports Power Control and Over Current Detection.

Replaced devm_reset_control_get_shared_deasserted() with
devm_reset_control_get_shared() + reset_control_deassert() +
devm_add_action_or_reset()

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

 .../bindings/phy/renesas,rzg3e-usb3-phy.yaml  |  63 ++++
 .../bindings/usb/renesas,rzg3e-xhci.yaml      |  87 ++++++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  30 ++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  10 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   8 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c           |   9 +-
 drivers/phy/renesas/Kconfig                   |   7 +
 drivers/phy/renesas/Makefile                  |   1 +
 drivers/phy/renesas/phy-rzg3e-usb3.c          | 273 ++++++++++++++++++
 drivers/usb/host/Kconfig                      |   2 +-
 drivers/usb/host/xhci-plat.c                  |  14 +
 drivers/usb/host/xhci-plat.h                  |   1 +
 drivers/usb/host/xhci-rcar-regs.h             |  49 ++++
 drivers/usb/host/xhci-rcar.c                  | 100 ++++---
 drivers/usb/host/xhci-rzg3e-regs.h            |  12 +
 .../dt-bindings/clock/renesas,r9a09g047-cpg.h |   2 +
 17 files changed, 623 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,rzg3e-usb3-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
 create mode 100644 drivers/phy/renesas/phy-rzg3e-usb3.c
 create mode 100644 drivers/usb/host/xhci-rcar-regs.h
 create mode 100644 drivers/usb/host/xhci-rzg3e-regs.h

-- 
2.43.0


