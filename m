Return-Path: <SRS0=5+RK=E6=lists.cip-project.org=bounce+64572+5856+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B781AC64E75
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6B8206D5
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CqGinTva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6B8206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5856+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id c7nFYY4521723xXFSCLG1uas; Tue, 24 Nov 2020 09:59:26 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.807.1606240761140942962
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:59:26 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63741948"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:59:25 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB1A240BD27D;
	Wed, 25 Nov 2020 02:59:24 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 4/7] spi: spi-mem: export spi_mem_default_supports_op()
Date: Tue, 24 Nov 2020 17:59:15 +0000
Message-Id: <20201124175918.12029-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uRjLUlZuMjAQmCvD4nvsvyrQx4520388AA=
Content-Type: multipart/mixed; boundary="GSoX9yKDsJKvaud3r8IF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606240766;
 bh=QLdeO4e8MxHveONZ//b2tGclebXvPFsS/whYuswYJbs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CqGinTvaZWi8Kwse3d2oUdvRFDFKJTEZQ13qOLs0YCXzxgJYDeiJePs51Nisqe7VC+j
 5FMm37ChfNwh2YepSj4yE0kp5Eu2E6y90mvaRTvsWOsWNzhGYnk2+7oO3fFaYG342LuNu
 7xV9BrGikPhEvdGBB3o9hfpd7GGlnwsZARQ=

--GSoX9yKDsJKvaud3r8IF

From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

commit 46109648052fe778c75f199d72255c899578d6f7 upstream.

Export spi_mem_default_supports_op(), so that controller drivers
can use this.
spi-mem driver already exports this using EXPORT_SYMBOL,
but not declared it in spi-mem.h.
This patch declares spi_mem_default_supports_op() in spi-mem.h and
also removes the static from the function prototype.

This patch also squashes upstream commit 72e6841608b9 ("spi: spi-mem: Fix
build error without CONFIG_SPI_MEM")' in the current patch as commit
46109648052f ("spi: spi-mem: export spi_mem_default_supports_op()")'
introduced below build error when built without CONFIG_SPI_MEM:

drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: manually applied the changes, squashed commit 72e6841608b9
("spi: spi-mem: Fix build error without CONFIG_SPI_MEM")' in current patch]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c       |  4 ++--
 include/linux/spi/spi-mem.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 967f581bca4f..b319a9f0138c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -128,8 +128,8 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 	return -ENOTSUPP;
 }
 
-static bool spi_mem_default_supports_op(struct spi_mem *mem,
-					const struct spi_mem_op *op)
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
 {
 	if (spi_check_buswidth_req(mem, op->cmd.buswidth, true))
 		return false;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 80db2de83402..253a8d451d4c 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -224,6 +224,10 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
+
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
@@ -239,6 +243,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
+
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
-- 
2.25.1


--GSoX9yKDsJKvaud3r8IF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5856): https://lists.cip-project.org/g/cip-dev/message=
/5856
Mute This Topic: https://lists.cip-project.org/mt/78482880/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GSoX9yKDsJKvaud3r8IF--
