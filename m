Return-Path: <SRS0=LnjN=DT=lists.cip-project.org=bounce+64572+5538+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CDEC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127EC2087E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VH8oWaN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127EC2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5538+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OgqIYY4521723xy0LNxgxWIV; Mon, 12 Oct 2020 07:20:31 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.41774.1602512378241754205
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:03 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351915"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:03 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DDFFB42A7643;
	Mon, 12 Oct 2020 23:20:01 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 18/50] PCI: endpoint: Set endpoint controller pointer to NULL
Date: Mon, 12 Oct 2020 15:19:01 +0100
Message-Id: <20201012141933.9652-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ltNDGo2PnU12ixZvnivBsdLUx4520388AA=
Content-Type: multipart/mixed; boundary="aZwNQOQpHamF8ep45yPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512431;
 bh=+9hTXzxBK56Ug5Dxl3009u3+jqTdkbZ0Vz6JrZ0kApU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VH8oWaN4zuU4pPzFm9uTPLmKNnwNoTOlmOq3mYtErnsdUZN1zQ+7oFWJgcdW/58QhIA
 auZ8K6zva2DFz9T3v/Nv1lzDG7e0h/9VahhcMrFUciRYIW3qW4iFSKi2xlq6lYgqCGZgS
 kJfRWYgw+D9D1rHo7/DeGSSfpUQzchAmego=

--aZwNQOQpHamF8ep45yPc

From: Alan Mikhak <alan.mikhak@sifive.com>

commit db7a62482d2f6a63f36f30f62c4cbf1e53035719 upstream.

Set endpoint controller pointer to NULL in pci_epc_remove_epf()
to avoid -EBUSY on subsequent call to pci_epc_add_epf().

Add a check for NULL endpoint function pointer.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e4712a0f249c..2091508c1620 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -519,11 +519,12 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
 	unsigned long flags;
 
-	if (!epc || IS_ERR(epc))
+	if (!epc || IS_ERR(epc) || !epf)
 		return;
 
 	spin_lock_irqsave(&epc->lock, flags);
 	list_del(&epf->list);
+	epf->epc = NULL;
 	spin_unlock_irqrestore(&epc->lock, flags);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
-- 
2.17.1


--aZwNQOQpHamF8ep45yPc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5538): https://lists.cip-project.org/g/cip-dev/message=
/5538
Mute This Topic: https://lists.cip-project.org/mt/77461680/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--aZwNQOQpHamF8ep45yPc--
