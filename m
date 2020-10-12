Return-Path: <SRS0=3CSw=DT=lists.cip-project.org=bounce+64572+5542+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8A9C433E7
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F302076E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="F3qwH2KJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F302076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5542+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eYRdYY4521723x4tnqZTR8Z8; Mon, 12 Oct 2020 07:20:43 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.41790.1602512409498286210
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:09 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351922"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:08 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D30B742A764B;
	Mon, 12 Oct 2020 23:20:07 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 22/50] PCI: endpoint: Cast the page number to phys_addr_t
Date: Mon, 12 Oct 2020 15:19:05 +0100
Message-Id: <20201012141933.9652-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wuX1LiMr67jJp2G1xjM28MIlx4520388AA=
Content-Type: multipart/mixed; boundary="mKXWsvaSuMmHALcdcTUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512443;
 bh=BtnBT++jKucC7kXvkPGAS1dJUuC9ASIu+vIcIsMhJ5Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=F3qwH2KJczrmHPfZT6ZrIj3ip+eEr8BSZ/v7nGjsrXqA21WdsQ3rOyEQFVUedRENkQs
 Hz51TR4Xz7WoykyfeM/VptuKgOW3nm3j3Y7lMjudo4AWenMOLvJu3JoBbea+rx5cgiuFF
 twCZp/SnzIbKL4GzPZ7GhSRyF/MZrHa+vSE=

--mKXWsvaSuMmHALcdcTUa

From: Alan Mikhak <alan.mikhak@sifive.com>

commit daee4f4e42c792997f4fee47dcdfa65dd720ec02 upstream.

Modify pci_epc_mem_alloc_addr() to cast the variable 'pageno'
from type 'int' to 'phys_addr_t' before shifting left. This
cast is needed to avoid treating bit 31 of 'pageno' as the
sign bit which would otherwise get sign-extended to produce
a negative value. When added to the base address of PCI memory
space, the negative value would produce an invalid physical
address which falls before the start of the PCI memory space.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epc-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index 0471643cf536..abfac1109a13 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -136,7 +136,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 	if (pageno < 0)
 		goto ret;
 
-	*phys_addr = mem->phys_base + (pageno << page_shift);
+	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
 	virt_addr = ioremap(*phys_addr, size);
 	if (!virt_addr)
 		bitmap_release_region(mem->bitmap, pageno, order);
-- 
2.17.1


--mKXWsvaSuMmHALcdcTUa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5542): https://lists.cip-project.org/g/cip-dev/message=
/5542
Mute This Topic: https://lists.cip-project.org/mt/77461688/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mKXWsvaSuMmHALcdcTUa--
