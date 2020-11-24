Return-Path: <SRS0=qa7L=E6=lists.cip-project.org=bounce+64572+5858+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B288CC2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47055206D5
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pY7CqNV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47055206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5858+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0APVYY4521723xlhnBzW5os5; Tue, 24 Nov 2020 09:59:27 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.809.1606240766013300857
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:59:27 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63525899"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Nov 2020 02:59:27 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 11FA140BD413;
	Wed, 25 Nov 2020 02:59:25 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 5/7] spi: spi-mem: Split spi_mem_exec_op() code
Date: Tue, 24 Nov 2020 17:59:16 +0000
Message-Id: <20201124175918.12029-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WVf9xOKauTwBsqdQPyH1eQBhx4520388AA=
Content-Type: multipart/mixed; boundary="HGfo8zaQIuzBm1eMadbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606240767;
 bh=WHmwc+gC5J2/SuCTowGjjbKHjhE9AXyjnAYdtH+vBBc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pY7CqNV36plmhshAba79KzhOARY+vM0RVjLSvyhLoduxi56FeDOWVSi4XfUOxf4PmNP
 A186nTN5vlOt6pzIsFXmdaPGcoMvnTAtPKEkWLIbcJjB1d+E80BK07Ki2Ilm6PLJCENmP
 lFqgiFrYGmWubjqhV19BL7ZvbYRuX0//oSU=

--HGfo8zaQIuzBm1eMadbf

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit f86c24f4795303e4024bc113196de32782f6ccb5 upstream.

The logic surrounding the ->exec_op() call applies to direct mapping
accessors. Move this code to separate functions to avoid duplicating
code.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: Fixed reference leak in spi_mem_access_start for PM]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c | 64 +++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b319a9f0138c..2607981d973d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -213,6 +213,45 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
+static int spi_mem_access_start(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	/*
+	 * Flush the message queue before executing our SPI memory
+	 * operation to prevent preemption of regular SPI transfers.
+	 */
+	spi_flush_queue(ctlr);
+
+	if (ctlr->auto_runtime_pm) {
+		int ret;
+
+		ret = pm_runtime_get_sync(ctlr->dev.parent);
+		if (ret < 0) {
+			pm_runtime_put_noidle(ctlr->dev.parent);
+			dev_err(&ctlr->dev, "Failed to power device: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	mutex_lock(&ctlr->bus_lock_mutex);
+	mutex_lock(&ctlr->io_mutex);
+
+	return 0;
+}
+
+static void spi_mem_access_end(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	mutex_unlock(&ctlr->io_mutex);
+	mutex_unlock(&ctlr->bus_lock_mutex);
+
+	if (ctlr->auto_runtime_pm)
+		pm_runtime_put(ctlr->dev.parent);
+}
+
 /**
  * spi_mem_exec_op() - Execute a memory operation
  * @mem: the SPI memory
@@ -242,30 +281,13 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -ENOTSUPP;
 
 	if (ctlr->mem_ops) {
-		/*
-		 * Flush the message queue before executing our SPI memory
-		 * operation to prevent preemption of regular SPI transfers.
-		 */
-		spi_flush_queue(ctlr);
-
-		if (ctlr->auto_runtime_pm) {
-			ret = pm_runtime_get_sync(ctlr->dev.parent);
-			if (ret < 0) {
-				dev_err(&ctlr->dev,
-					"Failed to power device: %d\n",
-					ret);
-				return ret;
-			}
-		}
+		ret = spi_mem_access_start(mem);
+		if (ret)
+			return ret;
 
-		mutex_lock(&ctlr->bus_lock_mutex);
-		mutex_lock(&ctlr->io_mutex);
 		ret = ctlr->mem_ops->exec_op(mem, op);
-		mutex_unlock(&ctlr->io_mutex);
-		mutex_unlock(&ctlr->bus_lock_mutex);
 
-		if (ctlr->auto_runtime_pm)
-			pm_runtime_put(ctlr->dev.parent);
+		spi_mem_access_end(mem);
 
 		/*
 		 * Some controllers only optimize specific paths (typically the
-- 
2.25.1


--HGfo8zaQIuzBm1eMadbf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5858): https://lists.cip-project.org/g/cip-dev/message=
/5858
Mute This Topic: https://lists.cip-project.org/mt/78482882/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HGfo8zaQIuzBm1eMadbf--
