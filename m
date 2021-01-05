Return-Path: <SRS0=qmhy=GI=lists.cip-project.org=bounce+64572+6000+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62301C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6B32073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6B32073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6000+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id St5wYY4521723x36PfOBlBq4; Tue, 05 Jan 2021 05:58:03 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.5372.1609855081956264875
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:02 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67868536"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2021 22:57:59 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D63CD4254F69;
	Tue,  5 Jan 2021 22:57:58 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 00/17] Add Renesas RPC-IF driver
Date: Tue,  5 Jan 2021 13:57:40 +0000
Message-Id: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ckpRUpy2b8KMuNbNhWWdme4Ox4520388AA=
Content-Type: multipart/mixed; boundary="fUTqwavat66PgPK2yyog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855083;
 bh=DgykxBGyvRPCn0yaPE3vU5XRcaarsJSOxU/uwTh0RUc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=l6eC3YZwXWKP+3KJIC9rxKyALj7w8ffqrSyS2ICsFERhf7g4VlZzCN1xfWAcSuutkOp
 0jEYtXt8hY88784/CnyS/sUsoQOEHxa7hz20E0jTp5gRGOi1N7dkDS46eu91XsbaNERGU
 nqG9uCHhlsSNckUDvk1Pd3sXghtPF8TX+KY=

--fUTqwavat66PgPK2yyog

Hi Nobuhiro, Pavel,

This patch series adds SPI driver for the Renesas RPC-IF.
Alongside relevant changes for spi-mem have been also backported.
This enables accessing SPI flash chip connected to RPC-IF.

The series includes just the driver changes as the DTS/i changes are
currently being upstreamed [1]. The driver has been tested on RZ/G2{EM}
with all the required dts/i changes [2].

All the patches have been cherry picked from Linux 5.11-rc2.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=408139
[2] https://github.com/prabhakarlad/cip/commits/master

Cheers,
Prabhakar

Boris Brezillon (5):
  spi: spi-mem: Add SPI_MEM_NO_DATA to the spi_mem_data_dir enum
  spi: spi-mem: Split spi_mem_exec_op() code
  spi: spi-mem: Add a new API to support direct mapping
  spi: spi-mem: Fix spi_mem_dirmap_destroy() kerneldoc
  spi: spi-mem: Fix a memory leak in spi_mem_dirmap_destroy()

Lad Prabhakar (4):
  memory: renesas-rpc-if: Return correct value to the caller of
    rpcif_manual_xfer()
  memory: renesas-rpc-if: Fix unbalanced pm_runtime_enable in
    rpcif_{enable,disable}_rpm
  memory: renesas-rpc-if: Fix a node reference leak in rpcif_probe()
  memory: renesas-rpc-if: Make rpcif_enable/disable_rpm() as static
    inline

Lukas Wunner (1):
  spi: rpc-if: Fix use-after-free on unbind

Naga Sureshkumar Relli (1):
  spi: spi-mem: export spi_mem_default_supports_op()

Sergei Shtylyov (3):
  dt-bindings: memory: document Renesas RPC-IF bindings
  memory: add Renesas RPC-IF driver
  spi: add Renesas RPC-IF driver

Tudor Ambarus (1):
  spi: spi-mem: Compute length only when needed

YueHaibing (1):
  spi: spi-mem: Fix passing zero to 'PTR_ERR' warning

Zhang Qilong (1):
  spi: spi-mem: fix reference leak in spi_mem_access_start

 .../memory-controllers/renesas,rpc-if.yaml    |  88 +++
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/renesas-rpc-if.c               | 593 ++++++++++++++++++
 drivers/spi/Kconfig                           |   6 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mem.c                         | 282 ++++++++-
 drivers/spi/spi-rpc-if.c                      | 211 +++++++
 include/linux/spi/spi-mem.h                   |  93 +++
 include/memory/renesas-rpc-if.h               |  96 +++
 10 files changed, 1353 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
 create mode 100644 drivers/memory/renesas-rpc-if.c
 create mode 100644 drivers/spi/spi-rpc-if.c
 create mode 100644 include/memory/renesas-rpc-if.h

-- 
2.17.1


--fUTqwavat66PgPK2yyog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6000): https://lists.cip-project.org/g/cip-dev/message=
/6000
Mute This Topic: https://lists.cip-project.org/mt/79450058/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fUTqwavat66PgPK2yyog--
