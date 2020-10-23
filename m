Return-Path: <SRS0=HymH=D6=lists.cip-project.org=bounce+64572+5664+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F20C56201
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BAA206BE
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ATzekCWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BAA206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5664+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qQtbYY4521723xSSiK2PL2AV; Fri, 23 Oct 2020 09:58:17 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.12263.1603472290450737560
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 09:58:17 -0700
X-IronPort-AV: E=Sophos;i="5.77,409,1596466800"; 
   d="scan'208";a="60418349"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Oct 2020 01:58:16 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8FC9F400C9EE;
	Sat, 24 Oct 2020 01:58:15 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 6/6] misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
Date: Fri, 23 Oct 2020 17:58:05 +0100
Message-Id: <20201023165805.1910-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: B4PP47giJGiWW6yIx6uRLBZCx4520388AA=
Content-Type: multipart/mixed; boundary="Fk9luUzAmMa1MlD3Qcus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603472297;
 bh=wkeHJMWIv4eGW+nqIrUvbRbAY+vtzpwzt8Yg3MniMHY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ATzekCWXrdr6e2EaDrXiElPiXCp65pF0SNcuPF/80oSHxeWnd8wal1P4k3qNtey7gOJ
 Ywn9O8dFe+q3oIrGHKo0EiGhEKFr0GkjZpUE3MX2JZmRvVAe4DVWOAT489pPsX6ecEu0B
 3iDC8aNpYgkiz9to/U08DxkcsAyuYQSlsi0=

--Fk9luUzAmMa1MlD3Qcus

commit b03025c57396b23fe2423384c25aa580000e9883 upstream.

Add Renesas R8A774C0 in pci_device_id table so that pci-epf-test can be
used for testing PCIe EP on RZ/G2E.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1589493809-2602-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 7d166f57f624..aff8cbca5d18 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -80,6 +80,8 @@
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
 
+#define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -814,6 +816,8 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.17.1


--Fk9luUzAmMa1MlD3Qcus
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5664): https://lists.cip-project.org/g/cip-dev/message=
/5664
Mute This Topic: https://lists.cip-project.org/mt/77756299/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Fk9luUzAmMa1MlD3Qcus--
