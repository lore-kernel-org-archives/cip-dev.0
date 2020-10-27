Return-Path: <SRS0=fcjf=EC=lists.cip-project.org=bounce+64572+5681+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845ADC5517A
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F8F20727
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AtmNrrpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F8F20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5681+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NevJYY4521723xB6AJy693Ls; Tue, 27 Oct 2020 09:56:32 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.70.1603817791660695107
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2020 09:56:31 -0700
X-IronPort-AV: E=Sophos;i="5.77,424,1596466800"; 
   d="scan'208";a="60958863"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2020 01:56:30 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF1DB40A85CA;
	Wed, 28 Oct 2020 01:56:29 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 5/5] misc: pci_endpoint_test: Add Device ID for RZ/G2M and RZ/G2N PCIe controllers
Date: Tue, 27 Oct 2020 16:56:22 +0000
Message-Id: <20201027165622.28777-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ECf018ju8OVPKrpHhh6qjomSx4520388AA=
Content-Type: multipart/mixed; boundary="pW6A6TeE927FXKQmGhaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603817792;
 bh=HNtmk40sLyfj/pcVtPYIv+Kpk6oEHAwuxkEZRbn9jH4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=AtmNrrpNZZxF90FJGHZLuFsC0sjjaYh5vH1r2bNaemLM0viefR/KGcPiWk5IWrREdi4
 /oM5KkrmpktcQbab2Sme0hRPrmrvYzJkzKlM8cPuVed81PQO/oZd0GJ8hTuAlvWphL2Qq
 Eg3g8LeWRyxn1xmxCBNMx6ESMEKJJCp/Uts=

--pW6A6TeE927FXKQmGhaq

commit cfb824ddd1c040a7ac65eea3f900f14268e8f383 upstream.

Add Renesas R8A774A1 and R8A774B1 in pci_device_id table so that
pci-epf-test can be used for testing PCIe EP on RZ/G2M and RZ/G2N.

Link: https://lore.kernel.org/r/20200814173037.17822-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index aff8cbca5d18..a1083f568d2c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -80,6 +80,8 @@
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
 
+#define PCI_DEVICE_ID_RENESAS_R8A774A1		0x0028
+#define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
 
 static DEFINE_IDA(pci_endpoint_test_ida);
@@ -816,8 +818,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),
-	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.17.1


--pW6A6TeE927FXKQmGhaq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5681): https://lists.cip-project.org/g/cip-dev/message=
/5681
Mute This Topic: https://lists.cip-project.org/mt/77842966/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pW6A6TeE927FXKQmGhaq--
