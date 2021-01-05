Return-Path: <SRS0=Dxdr=GI=lists.cip-project.org=bounce+64572+6012+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E9C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12E02073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12E02073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6012+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JxS8YY4521723xJ2kSHXBP1m; Tue, 05 Jan 2021 05:58:16 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.5380.1609855093624078507
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:16 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67868563"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:15 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A9E264254F72;
	Tue,  5 Jan 2021 22:58:14 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 12/17] spi: spi-mem: Compute length only when needed
Date: Tue,  5 Jan 2021 13:57:52 +0000
Message-Id: <20210105135757.11069-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7Rt2LB2VBbrfRYSoTFfhAtfWx4520388AA=
Content-Type: multipart/mixed; boundary="75BJC5vYDaLawdpnhGpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855096;
 bh=V9zwEgNsOYd9QYpeohM3gyM8BTlHOR2GdHNXGSCm5dQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lkAX7rC7odAp15Jv2QI5x6byvVsH5gcR3VTyDxW3YKQjm9RSi08uqJZXcOShqxvMbkH
 lFrrFndrm7eMIjPh6kFFN+WVMzBVKXkp9zqRuPg3B/1YxKSVfzB+ijn0acHVJ7tGJpU3i
 nuYxPEOHn9dpl+YtTN8iV6ni1pgb2h1ALPQ=

--75BJC5vYDaLawdpnhGpr

From: Tudor Ambarus <tudor.ambarus@microchip.com>

commit c0e035ac56680e74b27fc218c07e70f4b9b8b7a5 upstream.

When adjust_op_size is defined, len is never used. Move the len
computation where it's actually used.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20200228160735.1565047-1-tudor.ambarus@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 59f7aa117a10..02cf8c3f7350 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -412,12 +412,13 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	struct spi_controller *ctlr = mem->spi->controller;
 	size_t len;
 
-	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
-
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
 	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		len = sizeof(op->cmd.opcode) + op->addr.nbytes +
+		      op->dummy.nbytes;
+
 		if (len > spi_max_transfer_size(mem->spi))
 			return -EINVAL;
 
-- 
2.17.1


--75BJC5vYDaLawdpnhGpr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6012): https://lists.cip-project.org/g/cip-dev/message=
/6012
Mute This Topic: https://lists.cip-project.org/mt/79450076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--75BJC5vYDaLawdpnhGpr--
