Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A77AF3C269
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:25:57 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15517.1773066352684564144
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MzQplumz;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439cb5af25bso2078273f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066351; x=1773671151; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTwtGPs+42RA4MfLsJQKHmPf0dwWTFEburUokQsUGD0=;
        b=MzQplumzYRGelT8vteCBkeayX5ARuXTQ3HTcgloHiNKGc2t80JPctvJum8hw2koqrQ
         Xy9x3/auYmghbTwUYjuG+0Um8TPO0W4Tcqa0tULGr5pau/KtmLr1fORqEe1N79pSGGGK
         a0Or58wKTsT0KMJfUtnImW04NEd+dXX7LxtjYFumxCvccrN9xHNUCXFcjrWVWsaq10Tr
         kBzDoI/JM6r+MD+FtObrqWggeRH8RvmV5DqqozyJpFmhRkBeMreBKwCi3d0OAV0EwAq+
         qK2xbmi0xgQpA7GnTzqfc8wNmXRjjGKm5w2g9qH9uTdUsdL8877Mrm09PgqnO+d+9nzb
         wrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066351; x=1773671151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTwtGPs+42RA4MfLsJQKHmPf0dwWTFEburUokQsUGD0=;
        b=xQHik3rtht/YQ29uRxXAwLBikawEmDr0gzJcBjsfHWG+LXdXOWwEdCdhbUPOsn4pX2
         9fuIknhzlkPtcn7s4oe4AaB9EWn2W62xgTufEold/TYZOU5jyJl1ZGfrpgqSaHUq1rYB
         +/7ZvFvydVAZ007uvJre97iAcJQMkpRggvU3zve5NP9qfHSBXGGZ7MkIaIOMvC83cIqU
         TrVfV9EwYIwH9gY3nJFyNKRO5wvSHdRERmn7hiLiL838Zss4kIkY0UzxXbHldo3aKBax
         mn7m80vmNNntXFWYcj6Urc1HrvKdTuwxhaAnmNU+w7VPug61USTXLSWVWHB2pGLeK6rv
         XIDQ==
X-Gm-Message-State: AOJu0YwUVorl5+jK7lYAM3BriQ3iQJDWxLkvr8MuqTAmW1QJFy8YJ3uX
	FWURlT45fMrpyv3rapRPos8HMwBWOKFIHZ7yQ7x2IUjzgBfwWdHxA+ZzN88uSA==
X-Gm-Gg: ATEYQzzuDjfiaPE42W6NRGsO9O8cOxICldYhDx3R5lA7J4SHcaF0+f2qK7zyWIpabOV
	DCyWGIZuDyqbl0vtQRoBEdxeMJERp9mhX6CDW321VRV9F3uPm1a/BmRGdac4VisLMKo90eV2I2z
	zfCbvlenwzX3o5KeQmAL0RcC2qu9GySE3Rl486iogI8Q0klWw+O2hllsGLd1Jnj2qzBqfjEzz4h
	4wKF8rP+Qh7WShC17EZufxH2/jU9/olGaBeotvaT9NI9hHYNoMBRB9CAfX859kyCcLyGQtOAvZT
	0lFg48Kar/bRbqr35SaAQZOvX3Q7Cjl64BMyVWM4ARUB1uuxLbB1AK6+nKSDfw/z5pBZqTHtGme
	HyksGwFipwh1YAFmt46lP/gYcSdeAY3e+ZGVqyZvVe08zra1h1BD0mtwW8Xv6ZIKAfJVgV8Y+8A
	QgdQm+UiMIh0reOXFAxzpAr5Qs1NGfUMEbhYDVsahXjw==
X-Received: by 2002:a05:6000:208a:b0:439:c550:d92a with SMTP id ffacd0b85a97d-439da87bde7mr20333647f8f.53.1773066350457;
        Mon, 09 Mar 2026 07:25:50 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:50 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/29] Add RZ/G3E RSCI support
Date: Mon,  9 Mar 2026 14:25:00 +0000
Message-ID: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:25:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22168

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the hardware
flow control.

Biju Das (23):
  dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
  dt-bindings: serial: renesas,rsci: Document RZ/G3E support
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
  serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  serial: rsci: Convert to FIELD_MODIFY()

Lad Prabhakar (2):
  serial: sh-sci: Sort include files alphabetically
  serial: sh-sci: Merge sh-sci.h into sh-sci.c

Luo Jie (1):
  bitfield: Add FIELD_MODIFY() helper

 .../bindings/serial/renesas,rsci.yaml         | 101 +++++-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 220 +++++++++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  64 ++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  13 +-
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |   4 +
 drivers/clk/renesas/r9a09g047-cpg.c           | 126 +++++++
 drivers/tty/serial/rsci.c                     | 309 ++++++++++++++++--
 drivers/tty/serial/rsci.h                     |   3 +-
 drivers/tty/serial/sh-sci-common.h            |  10 +-
 drivers/tty/serial/sh-sci.c                   | 292 ++++++++++++++---
 drivers/tty/serial/sh-sci.h                   | 178 ----------
 include/linux/bitfield.h                      |  21 +-
 12 files changed, 1059 insertions(+), 282 deletions(-)
 delete mode 100644 drivers/tty/serial/sh-sci.h

-- 
2.43.0


