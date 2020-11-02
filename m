Return-Path: <SRS0=Q/lK=EI=lists.cip-project.org=bounce+64572+5706+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB4C388F9
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCD121D91
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="d42d+EZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCD121D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5706+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ER46YY4521723xPQHSaYkGJH; Mon, 02 Nov 2020 01:24:53 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.28823.1604309092548565826
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 01:24:52 -0800
X-IronPort-AV: E=Sophos;i="5.77,444,1596466800"; 
   d="scan'208";a="61246979"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Nov 2020 18:24:52 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 121564005E2A;
	Mon,  2 Nov 2020 18:24:50 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 5/6] misc: pci_endpoint_test: Add Device ID for RZ/G2H PCIe controller
Date: Mon,  2 Nov 2020 09:24:42 +0000
Message-Id: <20201102092443.4142-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kOcv0rmVeUMxggZopxNcnhyjx4520388AA=
Content-Type: multipart/mixed; boundary="yKCtMkj1Ell2gEXPAku9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604309093;
 bh=eBjXGSKY6mC2NSl/+HgTnFU/ak//YaAu+qED2fTjUZE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=d42d+EZ59Zo/Xq/4RqnZFJmGJdfbiUJfVtI4AiWXf+Gx0VPwP9uaAV/Ej7lIFFfUdj9
 0Uh3yQJrIzoHhjsFqVhdXkBHNrhN5p3J5Iw8fqSVNK4lF5aGfXHOV8/a0gNEXIiXVeCn6
 gVIY3VvtCj08/4Ngzqef6nm9Ame5T+zp7oM=

--yKCtMkj1Ell2gEXPAku9

commit a63c5f3db07dab2b205ac9a6a6ca96c4f72290de upstream.

Add Renesas R8A774E1 in pci_device_id table so that pci-epf-test
can be used for testing PCIe EP on RZ/G2H.

Link: https://lore.kernel.org/r/20200904103851.3946-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a1083f568d2c..9413a08ee351 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -83,6 +83,7 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774A1		0x0028
 #define PCI_DEVICE_ID_RENESAS_R8A774B1		0x002b
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
+#define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -821,6 +822,7 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.17.1


--yKCtMkj1Ell2gEXPAku9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5706): https://lists.cip-project.org/g/cip-dev/message=
/5706
Mute This Topic: https://lists.cip-project.org/mt/77977474/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--yKCtMkj1Ell2gEXPAku9--
