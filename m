Return-Path: <SRS0=94K7=E6=lists.cip-project.org=bounce+64572+5853+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82575C63777
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6942206D5
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="R89hCTXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6942206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5853+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VwWmYY4521723xT2RntuHzQS; Tue, 24 Nov 2020 09:59:24 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.807.1606240761140942962
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:59:21 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63741939"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:59:20 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5FB8440BD416;
	Wed, 25 Nov 2020 02:59:19 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 0/7] Add RPC-IF driver for RZ/G2x SoC's
Date: Tue, 24 Nov 2020 17:59:11 +0000
Message-Id: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fSlP4EJuRrJ6yoJlrHNgRKePx4520388AA=
Content-Type: multipart/mixed; boundary="27lE0nr8svFnzuqwaV5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606240764;
 bh=z5tu7bwH6QakD9SGRg4VlNoqRQKLMpckEsslJwTdIEs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=R89hCTXw/G6xjEYxVovKQdSrE18BRdPsjyWzIAtZkYmR7ZeypeiwPp1bY6U/FFMf6yn
 mWAq3mKrZgWxL/9TYbLzHv4cFI3bfGF2al+Dxri87cQY5gix68AK+2WuOBwYm+VEuGtqw
 N1Wr5XAF1b1e0iq9lgjz5z977yOrkI0L7WA=

--27lE0nr8svFnzuqwaV5a

Hi Nobuhiro, Pavel,

This patch series adds SPI driver for the Renesas RPC-IF.
Alongside relevant changes for spi-mem have been also
backported. This enables accessing SPI flash chip connected
to RPC-IF on RZ/G2x boards.

We currently only aim to backport just the driver hence there
are no changes to dts/i files. The driver has been tested on
RZ/G2{EM} with all the required dts/i changes [1].

Currently we are upstreaming clock [2] and pinctrl [3] changes
required for RPC-IF interface on RZ/G2x SoC's once that hits
v5.11 we shall backport it.

All the patches have been cherry picked from Linux 5.10-rc5.

[1] https://github.com/prabhakarlad/cip/commits/master
[2] https://patchwork.kernel.org/project/linux-renesas-soc/
    list/?series=365697&archive=both&state=*
[3] https://patchwork.kernel.org/project/linux-renesas-soc/
    list/?series=387535&archive=both&state=*

Changes for v2:
* Patches {1, 3, 4}/7 unchanged
* Patch 2/7
   * Fixed reference leak for OF node in rpcif_probe()
   * Fixed overwriting return value in error path of rpcif_manual_xfer()
   * Replaced C++ style comment with C style
   * Replaced tab with a space between struct and struct name
   * Fixed a typo in commit message (s/absract/abstract)
* Patch 5/7
   * Fixed reference leak in spi_mem_access_start for PM
* Patch 6/7
   * Return early in spi_mem_dirmap_dirmap_{read/write}
* Patch 7/7
   * Replaced C++ style comment with C style
   * Used __maybe_unused for rpcif_spi_{suspend,resume} and dropped
     CONFIG_PM_SLEEP ifdef checks
   * Elaborated the description for SPI_RPCIF config
   * Dropped the label err_put_ctlr from rpc_spi_probe()

Cheers,
Prabhakar

Boris Brezillon (3):
  spi: spi-mem: Add SPI_MEM_NO_DATA to the spi_mem_data_dir enum
  spi: spi-mem: Split spi_mem_exec_op() code
  spi: spi-mem: Add a new API to support direct mapping

Naga Sureshkumar Relli (1):
  spi: spi-mem: export spi_mem_default_supports_op()

Sergei Shtylyov (3):
  dt-bindings: memory: document Renesas RPC-IF bindings
  memory: add Renesas RPC-IF driver
  spi: add Renesas RPC-IF driver

 .../memory-controllers/renesas,rpc-if.yaml    |  88 +++
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/renesas-rpc-if.c               | 606 ++++++++++++++++++
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mem.c                         | 274 +++++++-
 drivers/spi/spi-rpc-if.c                      | 208 ++++++
 include/linux/spi/spi-mem.h                   |  93 +++
 include/memory/renesas-rpc-if.h               |  87 +++
 10 files changed, 1351 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
 create mode 100644 drivers/memory/renesas-rpc-if.c
 create mode 100644 drivers/spi/spi-rpc-if.c
 create mode 100644 include/memory/renesas-rpc-if.h

-- 
2.25.1


--27lE0nr8svFnzuqwaV5a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5853): https://lists.cip-project.org/g/cip-dev/message=
/5853
Mute This Topic: https://lists.cip-project.org/mt/78482875/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--27lE0nr8svFnzuqwaV5a--
