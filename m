Return-Path: <SRS0=SOC+=E5=lists.cip-project.org=bounce+64572+5819+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DF5C63798
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 12:04:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F285520888
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 12:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UYCdJ6UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F285520888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5819+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id s2P4YY4521723xpXsDXqXHov; Mon, 23 Nov 2020 04:04:01 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.34009.1606133039933459828
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 04:04:01 -0800
X-IronPort-AV: E=Sophos;i="5.78,363,1599490800"; 
   d="scan'208";a="63589393"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Nov 2020 21:04:00 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BC7C940061B0;
	Mon, 23 Nov 2020 21:03:59 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 3/7] spi: spi-mem: Add SPI_MEM_NO_DATA to the spi_mem_data_dir enum
Date: Mon, 23 Nov 2020 12:03:50 +0000
Message-Id: <20201123120354.26413-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KLWukkbz4XQnMYJe8dTYx4bmx4520388AA=
Content-Type: multipart/mixed; boundary="zGvbw5j8G45hGeTp5T1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606133041;
 bh=ONPADo9qFCeKW+B4qynxN0RDGyjfEtFYKvzOWzmQcOc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UYCdJ6UVD1XbKr4KaLSQUqm74akWEzS/GCLqxiFDopXKkUGnHKUdKtL5UyQrRYWTvUU
 7V13yaf/MCVcEY9ZHUN0s/RCj6MIbKgJQCdmsUQ8ctuT0MV/AjX9TXXqt2+i/GnJHgg1K
 g9LfU0KX0mcaHeCYGDWvE9yDJO4mZa4j31c=

--zGvbw5j8G45hGeTp5T1v

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 0ebb261a0b2d090de618a383d2378d4a00834958 upstream.

When defining spi_mem_op templates we don't necessarily know the size
that will be passed when the template is actually used, and basing the
supports_op() check on op->data.nbytes to know whether there will be
data transferred for a specific operation is this not possible.

Add SPI_MEM_NO_DATA to the spi_mem_data_dir enum so that we can base
our checks on op->data.dir instead of op->data.nbytes.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c       | 2 +-
 include/linux/spi/spi-mem.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 62a7b80801d2..967f581bca4f 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -142,7 +142,7 @@ static bool spi_mem_default_supports_op(struct spi_mem *mem,
 	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
 		return false;
 
-	if (op->data.nbytes &&
+	if (op->data.dir != SPI_MEM_NO_DATA &&
 	    spi_check_buswidth_req(mem, op->data.buswidth,
 				   op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 69ee30456864..80db2de83402 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -57,10 +57,12 @@
 /**
  * enum spi_mem_data_dir - describes the direction of a SPI memory data
  *			   transfer from the controller perspective
+ * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
  * @SPI_MEM_DATA_OUT: data sent the SPI memory
  */
 enum spi_mem_data_dir {
+	SPI_MEM_NO_DATA,
 	SPI_MEM_DATA_IN,
 	SPI_MEM_DATA_OUT,
 };
-- 
2.17.1


--zGvbw5j8G45hGeTp5T1v
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5819): https://lists.cip-project.org/g/cip-dev/message=
/5819
Mute This Topic: https://lists.cip-project.org/mt/78451542/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zGvbw5j8G45hGeTp5T1v--
