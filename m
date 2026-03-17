Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38896FD707E
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73573.1773746242170418693
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gGCdPNAv;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so53401965e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746240; x=1774351040; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qAmRNi0U8Wdd7qoieBssw8+W/blZvJlBW8t/NtlMZUk=;
        b=gGCdPNAvdXGEjrF5fFiCfenTpMArVA1eQSCZxsV6NU6GMVzk1mEp08sTU0ReVxLuQE
         Kev4w06RpvNDm9x2d6UIEjmy8pJZ4eVxigYGnUEAi+9LIsHCbhdiJO0KijiLIBxjMsgV
         o4Z1rgaT7nSQUqxZgrfHpIwwGW+8K7Ftz6HeDHv3IH46H8Dx9YEf1dtVSubqh9u1A745
         z+IwMDmc9viH5Bf5Olrb372XioWTQYnsjciDpiRcOpGu0/fmBFyOqlYg+aohY+vuKViR
         rundwEjYPs9aaUfhcAQQY97IykEzFTpybjrq+HVEodoh+0HcuS5zMIII0rGL1TkUKIqJ
         0mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746240; x=1774351040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAmRNi0U8Wdd7qoieBssw8+W/blZvJlBW8t/NtlMZUk=;
        b=kbKkyyQKtr8fLyECx3AYtsCTD2KBpTJQ/gKJEOCX47af+FkyKW3Gw50QR5Qyf8iInA
         h46ctpxqDe8yFYuPSsZSqzKhDDd+3a8LrgfrPe92l6Rs/QKx3o82hA4lPD6A9JuPFsuv
         VPQXBo8hX2ApyXzYL0a2/ZOt3vvokjapaeMAZIELvw3pyf2pnWxrXf3ekGD9onPdNbug
         LW7zEkACU9SyzqdErtxgLg2M+mX9q2HSAFiqM2qrjCJM4XS4+BUXF4lYJz+/KsddBMWF
         80wiEavO+RRMx+724nxi78FdMhPHKqFHlTNzAkzoQ0IX9hxrAyIAFDBq24O5rEKfGPas
         Y1Og==
X-Gm-Message-State: AOJu0YyQS5yQ7VuHMTWoS94CWm1N0+U+Ae91sGLMxdwndVd4sxEQI1k9
	N/gwTcDgz2RibyBoEBshB1Rw0kM0AqJ004JzC6OryEwEO9c+CjQeZp717W+3bg==
X-Gm-Gg: ATEYQzx53D3T9yPHF3Ym5A1RIISed0xBh2vxFuI+vyAcLETkkTMmPS1zxGuHUx68w/9
	8isaKWB9Sg6Tz5SMiNgpfIQLhgfPxhZBFVUxnIRSnlcSwdyuLXPDFcTN2EOfdAm+m9i/pOlPn3l
	fjuU5/cOuRigwwaSHZI9hh0XU3CT93D0rlHokcnFmJYKrVyIhv1qME3ZfYEufZ7w/dgp6nwM8QR
	voEFfccFW+XeIyg/QCjBAVBik/VvCLXusps6uMAhzqBOiZnmu4WwsCAXG0ECgnOi5ywy9kXl36j
	CP7ff1x3XY/lGh/uC/tlQMiYh9ohUpUNpndj9Fg5mY1BJkxncgzB/7oDTdpPwvBQ0GjUySdXDXv
	s2i4oYV/JN6WywSbFnwEHkGp32lNEWSxoQgR9cm/LZ8eXDNK1JvTYjAwwJQ0BnnKlD/4sY9K5lx
	uLjS1HLRLvYbD9toMBSKHDlRLSb7lX8Zg2UQSoXq9Z+Z+3lCOr
X-Received: by 2002:a05:600c:8b46:b0:485:3171:7845 with SMTP id 5b1f17b1804b1-485566ca8femr290256275e9.4.1773746240057;
        Tue, 17 Mar 2026 04:17:20 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:19 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
Date: Tue, 17 Mar 2026 11:16:25 +0000
Message-ID: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22433

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the hardware
flow control.

The device RZ/T2H is not present in 6.1, so squashed all the binding
patches into single commit that document RZ/G3E RSCI.

The set_rtrg() uses field_prep() and later replaced by PREP_MODIFY
But field_prep() not present in 6.1. So squashed the commit.

Replaced kfifo_*()->uart_circ_*() in rsci_transmit_chars() to make
similar implementation with sci_transmit_chars() for fixing tx issue
with 6.1 kernel.


Biju Das (21):
  clk: renesas: r9a09g047: Add RSCI clocks/resets
  serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
  serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI
  serial: rsci: Add set_rtrg() callback
  serial: sh-sci: Drop checking port type for device file{create,
    remove}
  serial: rsci: Drop rsci_clear_SCxSR()
  serial: sh-sci: Drop extra lines
  serial: rsci: Drop unused macro DCR
  serial: rsci: Drop unused TDR register
  serial: sh-sci: Use devm_reset_control_array_get_exclusive()
  serial: sh-sci: Add sci_is_rsci_type()
  serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
  serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
  serial: sh-sci: Add support for RZ/G3E RSCI clks
  serial: sh-sci: Make sci_scbrr_calc() public
  serial: sh-sci: Add finish_console_write() callback
  serial: rsci: Rename early_console data, port_params and callback()
    names
  serial: sh-sci: Add support for RZ/G3E RSCI
  arm64: dts: renesas: r9a09g047: Add RSCI nodes
  arm64: dts: renesas: renesas-smarc2: Move aliases to board DTS
  arm64: dts: renesas: r9a09g047e57-smarc: Enable rsci{2,4,9} nodes

Cosmin Tanislav (1):
  tty: serial: sh-sci: fix RSCI FIFO overrun handling

Geert Uytterhoeven (2):
  serial: sh-sci: Call sci_serial_{in,out}() directly
  serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Krzysztof Kozlowski (1):
  serial: sh-sci: mark OF related data as maybe unused

Lad Prabhakar (3):
  serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in
    sci_shutdown()
  serial: sh-sci: Sort include files alphabetically
  serial: sh-sci: Merge sh-sci.h into sh-sci.c

Luo Jie (1):
  bitfield: Add FIELD_MODIFY() helper

Max Filippov (1):
  serial: add PORT_GENERIC definition

Thierry Bultel (7):
  dt-bindings: serial: renesas,rsci: Document RZ/G3E support
  serial: sh-sci: Fix a comment about SCIFA
  serial: sh-sci: Introduced function pointers
  serial: sh-sci: Introduced sci_of_data
  serial: sh-sci: Use private port ID
  serial: sh-sci: Add support for RZ/T2H SCI
  arm64: defconfig: Enable Renesas RZ/T2H serial SCI

Wolfram Sang (2):
  serial: sh-sci: let timeout timer only run when DMA is scheduled
  serial: sh-sci: simplify locking when re-issuing RXDMA fails

 .../bindings/serial/renesas,rsci.yaml         |  160 ++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  220 +++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   64 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   13 +-
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |    4 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/r9a09g047-cpg.c           |  126 ++
 drivers/tty/serial/Kconfig                    |    7 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/rsci.c                     |  728 +++++++++
 drivers/tty/serial/rsci.h                     |   11 +
 drivers/tty/serial/sh-sci-common.h            |  183 +++
 drivers/tty/serial/sh-sci.c                   | 1296 +++++++++++------
 drivers/tty/serial/sh-sci.h                   |  180 ---
 include/linux/bitfield.h                      |   21 +-
 include/uapi/linux/serial_core.h              |    3 +
 16 files changed, 2348 insertions(+), 670 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,rsci.yaml
 create mode 100644 drivers/tty/serial/rsci.c
 create mode 100644 drivers/tty/serial/rsci.h
 create mode 100644 drivers/tty/serial/sh-sci-common.h
 delete mode 100644 drivers/tty/serial/sh-sci.h

-- 
2.43.0


