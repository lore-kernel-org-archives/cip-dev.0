Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE4104BEBC
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:06 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17640.1773223501203572531
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mCmnHD74;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b790af67so656558f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223499; x=1773828299; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdV4s+5Bcf5NVDvzyiZKzzoiNQCHzvUQ9+XMhkD4mXQ=;
        b=mCmnHD743ZB5MiCaNb+bwGU32YL06+tP7mc+CG2axWCKTeACQKr4ZxNGXl0hWkywTo
         tBAyUIK8j8oTsw8fO7jXJtIxZTxRAsDi9n0b9Uhbb10IC/PvQuPC+V339nYbzFwoImlZ
         RGIl7ZVgW3J8bnOcsp6QNQbbbUhsfJ40PwYJ/oPIKYzMRu782dDqjRiVyuT4Kd1nw8cO
         1JeEovoiUhx5perzSzRPMF8XwBYfCostX2icWlCi2ROmZ1yXnV7CJpC6a61Xf6p+tAPS
         PBCIM6dmH4HinBiixVyq1epW/ONVJZx7+QWjYFoUzZ0czvmhWwUDol1oooFzi22mq7YY
         6DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223499; x=1773828299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdV4s+5Bcf5NVDvzyiZKzzoiNQCHzvUQ9+XMhkD4mXQ=;
        b=oU7bTK+2zWL5FM2g2Gjf1hpcVhK/ZHt6rm5inpUJ8RVUiOmwIYFBEGGxmkg9xWcFbE
         VGoo4eoBCEt3N/Jg70NuV1DCRX2uj/tZDTdlFW7nZ+hJWh8t/Q1Ty1LY3mLlJzULVdqL
         vu/a2LuButdjI9Vn3Dh7DGE9/cnGNoSLn0bWVACytNE/3yqzIytmflMMg6FokLCkUray
         nOzO+47DtYIJuDFQrnnBPmfUkXtRqytxr9tuLXclEmHpSmMOpvXbj/HmgWhREJMtZqab
         Bso8IHA6M1FaS6teAi9ZXpDTtT2VnGvU580aT/GrsUBwp9rgqOKtzmsTbswnQZbg4xay
         v+jw==
X-Gm-Message-State: AOJu0Yw31/JxnHQC9Dx/n0OI5V2TbVv8ABB3vlbqqUE4NtK1Z5h1iTzV
	9t2uvXRbnvDU6QMdqoKI/LcPgs2jiQRxkzF2r03pJOslpmjXlEmWB1CrgdS2pw==
X-Gm-Gg: ATEYQzzxy3+5XcPQ5UgL7bbsdJ4nv0uadepHlnHd4MC8Q7hYBeRSpQ2bcEsCLZox07B
	Y4o2G0zAv/eWomhfaLJ+MYjoaWThghkLT/3TUiLsJJ1MzwB+wqkmpTaqr/EMn1eweEpPhB0K0BS
	fpOpdp1xPIJc21fqKYwQQX80BtxVDZ0O7IL95pBz+pPrFLglaUlSK5N+b+oUWrahfUS6lHzneMl
	CFsudJ/0R6BLiRlSqWUfHA8dmwkAK+DeBfZpSztYdwLiDzY8/LR9MoulhX8DzPAEgmHJfo8yae9
	b461k4y8Fpi0zD72h0nHstAoBQ3v13YP4HQR8nkBfxXr6gXTV4MpO7e8GEbfCerV2aHDQKk6Mzz
	j1jjhXSABWRIXgENSg5b0fyDLhKG/PHvxEYb02vJQ9iU2ldczJzqFVULaDzIGgoBlRCLrsmkfF8
	CQVj4aoNlRFfKnQQjaQcHXgwGtKnCheXI=
X-Received: by 2002:a05:6000:26d0:b0:439:c018:60e1 with SMTP id ffacd0b85a97d-439eff5ee41mr11858082f8f.21.1773223499091;
        Wed, 11 Mar 2026 03:04:59 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:04:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 00/27] Add RZ/G3E RSCI support
Date: Wed, 11 Mar 2026 10:04:19 +0000
Message-ID: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22246

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E has
6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
(2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the
hardware flow control.

v1->v2:
 * Dropped patch#28 "bitfield: Add FIELD_MODIFY() helper" as it is
   already present in 6.12.cip 
 * The set_rtrg() uses field_prep() and later it was replaced by patch#29
   that uses PREP_MODIFY. So squashed the commit, as field_prep() is not
   present in 6.12.cip
 * Fixed the typo arround->around in patch#21 commit description

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

Geert Uytterhoeven (1):
  serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Lad Prabhakar (2):
  serial: sh-sci: Sort include files alphabetically
  serial: sh-sci: Merge sh-sci.h into sh-sci.c

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
 11 files changed, 1040 insertions(+), 280 deletions(-)
 delete mode 100644 drivers/tty/serial/sh-sci.h

-- 
2.43.0


