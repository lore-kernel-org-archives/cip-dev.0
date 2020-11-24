Return-Path: <SRS0=rZdf=E6=lists.cip-project.org=bounce+64572+5859+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9EFC63777
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77A6206D5
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vI/XDHQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77A6206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5859+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TTMlYY4521723x4ozbKHJBwl; Tue, 24 Nov 2020 09:59:29 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.807.1606240761140942962
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:59:29 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63741951"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Nov 2020 02:59:28 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5D07640BD27D;
	Wed, 25 Nov 2020 02:59:27 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 6/7] spi: spi-mem: Add a new API to support direct mapping
Date: Tue, 24 Nov 2020 17:59:17 +0000
Message-Id: <20201124175918.12029-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201124175918.12029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NmwLFZqXWrthIdXdLF5PjVOPx4520388AA=
Content-Type: multipart/mixed; boundary="gcKjw0hC2blRm9r3ivXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606240769;
 bh=ZhVl0pbrhKxcSOeDDe4gS7AJyGx6wvcmOpu4PqcQTmc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vI/XDHQqSs02MEUGRdYLTWGMojMvWXZOJeVgpPdf3ZlM3z/WXeh17cROHY4W28SpZxN
 53b/SBMN+YclyQukdJ7SZo9NnkQG9nCn2y7Zhrrmaa0VfR2aCMOxwpKyEs9xmj5fEiqKC
 /1TTPR4LkeblOZTN9j5QF6oEj4yFWBnWfUs=

--gcKjw0hC2blRm9r3ivXS

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit aa167f3fed0c37e0e4c707d4331d827661f46644 upstream.

Most modern SPI controllers can directly map a SPI memory (or a portion
of the SPI memory) in the CPU address space. Most of the time this
brings significant performance improvements as it automates the whole
process of sending SPI memory operations every time a new region is
accessed.

This new API allows SPI memory drivers to create direct mappings and
then use them to access the memory instead of using spi_mem_exec_op().

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[PL: Return early in spi_mem_dirmap_dirmap_{read/write}]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c       | 204 ++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  80 ++++++++++++++
 2 files changed, 284 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2607981d973d..930a83c964c1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -433,6 +433,210 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				      u64 offs, size_t len, void *buf)
+{
+	struct spi_mem_op op = desc->info.op_tmpl;
+	int ret;
+
+	op.addr.val = desc->info.offset + offs;
+	op.data.buf.in = buf;
+	op.data.nbytes = len;
+	ret = spi_mem_adjust_op_size(desc->mem, &op);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(desc->mem, &op);
+	if (ret)
+		return ret;
+
+	return op.data.nbytes;
+}
+
+static ssize_t spi_mem_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
+				       u64 offs, size_t len, const void *buf)
+{
+	struct spi_mem_op op = desc->info.op_tmpl;
+	int ret;
+
+	op.addr.val = desc->info.offset + offs;
+	op.data.buf.out = buf;
+	op.data.nbytes = len;
+	ret = spi_mem_adjust_op_size(desc->mem, &op);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(desc->mem, &op);
+	if (ret)
+		return ret;
+
+	return op.data.nbytes;
+}
+
+/**
+ * spi_mem_dirmap_create() - Create a direct mapping descriptor
+ * @mem: SPI mem device this direct mapping should be created for
+ * @info: direct mapping information
+ *
+ * This function is creating a direct mapping descriptor which can then be used
+ * to access the memory using spi_mem_dirmap_read() or spi_mem_dirmap_write().
+ * If the SPI controller driver does not support direct mapping, this function
+ * fallback to an implementation using spi_mem_exec_op(), so that the caller
+ * doesn't have to bother implementing a fallback on his own.
+ *
+ * Return: a valid pointer in case of success, and ERR_PTR() otherwise.
+ */
+struct spi_mem_dirmap_desc *
+spi_mem_dirmap_create(struct spi_mem *mem,
+		      const struct spi_mem_dirmap_info *info)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct spi_mem_dirmap_desc *desc;
+	int ret = -ENOTSUPP;
+
+	/* Make sure the number of address cycles is between 1 and 8 bytes. */
+	if (!info->op_tmpl.addr.nbytes || info->op_tmpl.addr.nbytes > 8)
+		return ERR_PTR(-EINVAL);
+
+	/* data.dir should either be SPI_MEM_DATA_IN or SPI_MEM_DATA_OUT. */
+	if (info->op_tmpl.data.dir == SPI_MEM_NO_DATA)
+		return ERR_PTR(-EINVAL);
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	desc->mem = mem;
+	desc->info = *info;
+	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create)
+		ret = ctlr->mem_ops->dirmap_create(desc);
+
+	if (ret) {
+		desc->nodirmap = true;
+		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+			ret = -ENOTSUPP;
+		else
+			ret = 0;
+	}
+
+	if (ret) {
+		kfree(desc);
+		return ERR_PTR(ret);
+	}
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_create);
+
+/**
+ * spi_mem_dirmap_destroy() - Destroy a direct mapping descriptor
+ * @desc: the direct mapping descriptor to destroy
+ * @info: direct mapping information
+ *
+ * This function destroys a direct mapping descriptor previously created by
+ * spi_mem_dirmap_create().
+ */
+void spi_mem_dirmap_destroy(struct spi_mem_dirmap_desc *desc)
+{
+	struct spi_controller *ctlr = desc->mem->spi->controller;
+
+	if (!desc->nodirmap && ctlr->mem_ops && ctlr->mem_ops->dirmap_destroy)
+		ctlr->mem_ops->dirmap_destroy(desc);
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_destroy);
+
+/**
+ * spi_mem_dirmap_dirmap_read() - Read data through a direct mapping
+ * @desc: direct mapping descriptor
+ * @offs: offset to start reading from. Note that this is not an absolute
+ *	  offset, but the offset within the direct mapping which already has
+ *	  its own offset
+ * @len: length in bytes
+ * @buf: destination buffer. This buffer must be DMA-able
+ *
+ * This function reads data from a memory device using a direct mapping
+ * previously instantiated with spi_mem_dirmap_create().
+ *
+ * Return: the amount of data read from the memory device or a negative error
+ * code. Note that the returned size might be smaller than @len, and the caller
+ * is responsible for calling spi_mem_dirmap_read() again when that happens.
+ */
+ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+			    u64 offs, size_t len, void *buf)
+{
+	struct spi_controller *ctlr = desc->mem->spi->controller;
+	ssize_t ret;
+
+	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+		return -EINVAL;
+
+	if (!len)
+		return 0;
+
+	if (desc->nodirmap)
+		return spi_mem_no_dirmap_read(desc, offs, len, buf);
+
+	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_read) {
+		ret = spi_mem_access_start(desc->mem);
+		if (ret)
+			return ret;
+
+		ret = ctlr->mem_ops->dirmap_read(desc, offs, len, buf);
+
+		spi_mem_access_end(desc->mem);
+		return ret;
+	}
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_read);
+
+/**
+ * spi_mem_dirmap_dirmap_write() - Write data through a direct mapping
+ * @desc: direct mapping descriptor
+ * @offs: offset to start writing from. Note that this is not an absolute
+ *	  offset, but the offset within the direct mapping which already has
+ *	  its own offset
+ * @len: length in bytes
+ * @buf: source buffer. This buffer must be DMA-able
+ *
+ * This function writes data to a memory device using a direct mapping
+ * previously instantiated with spi_mem_dirmap_create().
+ *
+ * Return: the amount of data written to the memory device or a negative error
+ * code. Note that the returned size might be smaller than @len, and the caller
+ * is responsible for calling spi_mem_dirmap_write() again when that happens.
+ */
+ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
+			     u64 offs, size_t len, const void *buf)
+{
+	struct spi_controller *ctlr = desc->mem->spi->controller;
+	ssize_t ret;
+
+	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_OUT)
+		return -EINVAL;
+
+	if (!len)
+		return 0;
+
+	if (desc->nodirmap)
+		return spi_mem_no_dirmap_write(desc, offs, len, buf);
+
+	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_write) {
+		ret = spi_mem_access_start(desc->mem);
+		if (ret)
+			return ret;
+
+		ret = ctlr->mem_ops->dirmap_write(desc, offs, len, buf);
+
+		spi_mem_access_end(desc->mem);
+		return ret;
+	}
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_write);
+
 static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
 {
 	return container_of(drv, struct spi_mem_driver, spidrv.driver);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 253a8d451d4c..762b3974cf9c 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -124,6 +124,49 @@ struct spi_mem_op {
 		.data = __data,					\
 	}
 
+/**
+ * struct spi_mem_dirmap_info - Direct mapping information
+ * @op_tmpl: operation template that should be used by the direct mapping when
+ *	     the memory device is accessed
+ * @offset: absolute offset this direct mapping is pointing to
+ * @length: length in byte of this direct mapping
+ *
+ * These information are used by the controller specific implementation to know
+ * the portion of memory that is directly mapped and the spi_mem_op that should
+ * be used to access the device.
+ * A direct mapping is only valid for one direction (read or write) and this
+ * direction is directly encoded in the ->op_tmpl.data.dir field.
+ */
+struct spi_mem_dirmap_info {
+	struct spi_mem_op op_tmpl;
+	u64 offset;
+	u64 length;
+};
+
+/**
+ * struct spi_mem_dirmap_desc - Direct mapping descriptor
+ * @mem: the SPI memory device this direct mapping is attached to
+ * @info: information passed at direct mapping creation time
+ * @nodirmap: set to 1 if the SPI controller does not implement
+ *	      ->mem_ops->dirmap_create() or when this function returned an
+ *	      error. If @nodirmap is true, all spi_mem_dirmap_{read,write}()
+ *	      calls will use spi_mem_exec_op() to access the memory. This is a
+ *	      degraded mode that allows spi_mem drivers to use the same code
+ *	      no matter whether the controller supports direct mapping or not
+ * @priv: field pointing to controller specific data
+ *
+ * Common part of a direct mapping descriptor. This object is created by
+ * spi_mem_dirmap_create() and controller implementation of ->create_dirmap()
+ * can create/attach direct mapping resources to the descriptor in the ->priv
+ * field.
+ */
+struct spi_mem_dirmap_desc {
+	struct spi_mem *mem;
+	struct spi_mem_dirmap_info info;
+	unsigned int nodirmap;
+	void *priv;
+};
+
 /**
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
@@ -179,10 +222,32 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *	      Note that if the implementation of this function allocates memory
  *	      dynamically, then it should do so with devm_xxx(), as we don't
  *	      have a ->free_name() function.
+ * @dirmap_create: create a direct mapping descriptor that can later be used to
+ *		   access the memory device. This method is optional
+ * @dirmap_destroy: destroy a memory descriptor previous created by
+ *		    ->dirmap_create()
+ * @dirmap_read: read data from the memory device using the direct mapping
+ *		 created by ->dirmap_create(). The function can return less
+ *		 data than requested (for example when the request is crossing
+ *		 the currently mapped area), and the caller of
+ *		 spi_mem_dirmap_read() is responsible for calling it again in
+ *		 this case.
+ * @dirmap_write: write data to the memory device using the direct mapping
+ *		  created by ->dirmap_create(). The function can return less
+ *		  data than requested (for example when the request is crossing
+ *		  the currently mapped area), and the caller of
+ *		  spi_mem_dirmap_write() is responsible for calling it again in
+ *		  this case.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
  * case for QSPI controllers.
+ *
+ * Note on ->dirmap_{read,write}(): drivers should avoid accessing the direct
+ * mapping from the CPU because doing that can stall the CPU waiting for the
+ * SPI mem transaction to finish, and this will make real-time maintainers
+ * unhappy and might make your system less reactive. Instead, drivers should
+ * use DMA to access this direct mapping.
  */
 struct spi_controller_mem_ops {
 	int (*adjust_op_size)(struct spi_mem *mem, struct spi_mem_op *op);
@@ -191,6 +256,12 @@ struct spi_controller_mem_ops {
 	int (*exec_op)(struct spi_mem *mem,
 		       const struct spi_mem_op *op);
 	const char *(*get_name)(struct spi_mem *mem);
+	int (*dirmap_create)(struct spi_mem_dirmap_desc *desc);
+	void (*dirmap_destroy)(struct spi_mem_dirmap_desc *desc);
+	ssize_t (*dirmap_read)(struct spi_mem_dirmap_desc *desc,
+			       u64 offs, size_t len, void *buf);
+	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
+				u64 offs, size_t len, const void *buf);
 };
 
 /**
@@ -262,6 +333,15 @@ int spi_mem_exec_op(struct spi_mem *mem,
 
 const char *spi_mem_get_name(struct spi_mem *mem);
 
+struct spi_mem_dirmap_desc *
+spi_mem_dirmap_create(struct spi_mem *mem,
+		      const struct spi_mem_dirmap_info *info);
+void spi_mem_dirmap_destroy(struct spi_mem_dirmap_desc *desc);
+ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+			    u64 offs, size_t len, void *buf);
+ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
+			     u64 offs, size_t len, const void *buf);
+
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
 
-- 
2.25.1


--gcKjw0hC2blRm9r3ivXS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5859): https://lists.cip-project.org/g/cip-dev/message=
/5859
Mute This Topic: https://lists.cip-project.org/mt/78482883/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gcKjw0hC2blRm9r3ivXS--
