Return-Path: <SRS0=lfC9=D5=lists.cip-project.org=bounce+64572+5646+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AAC388F2
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F502419B
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IMNROhcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F502419B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5646+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vyABYY4521723xEUSAFe586h; Thu, 22 Oct 2020 03:16:25 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.8475.1603361778321978533
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.77,404,1596466800"; 
   d="scan'208";a="60507859"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Oct 2020 19:16:24 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 60A894002C32;
	Thu, 22 Oct 2020 19:16:23 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 06/13] PCI: endpoint: Add notification for core init completion
Date: Thu, 22 Oct 2020 11:16:07 +0100
Message-Id: <20201022101614.9298-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: b7Ercx59LzWw0Ux5ipHSK0KMx4520388AA=
Content-Type: multipart/mixed; boundary="LeM1RKqnd8YGoEkwJOx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603361785;
 bh=LXuIOqvS1+2T4/qLQw/3otxLMECgg22W3ppK+SVeHps=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IMNROhcjXBLZJM5mR1XK5/DhCsT2J96f1I/5ibcwrhVxc24lQZ8HRjjKK7hOrdIkCYp
 0B3bjCTRJmouTX4wRtJO12tl33T8TX5gYgI9iFvmntyHLXA9owhlRyTltrzfGpuKzpH3J
 SGPdtH8rHpoQ2IShAd0ALISVr7jNLXSkOlY=

--LeM1RKqnd8YGoEkwJOx8

From: Vidya Sagar <vidyas@nvidia.com>

commit 0ef22dcf0c1871888c4c0ee46a9d9c494f2fe997 upstream.

Add support to send notifications to EPF from EPC once the core
registers initialization is complete.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 19 ++++++++++++++++++-
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index dc1c673534e0..0d22a377a0cf 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -540,10 +540,27 @@ void pci_epc_linkup(struct pci_epc *epc)
 	if (!epc || IS_ERR(epc))
 		return;
 
-	atomic_notifier_call_chain(&epc->notifier, 0, NULL);
+	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkup);
 
+/**
+ * pci_epc_init_notify() - Notify the EPF device that EPC device's core
+ *			   initialization is completed.
+ * @epc: the EPC device whose core initialization is completeds
+ *
+ * Invoke to Notify the EPF device that the EPC device's initialization
+ * is completed.
+ */
+void pci_epc_init_notify(struct pci_epc *epc)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_epc_init_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 8f9bbc4b7ad1..77e04ee1fe05 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -165,6 +165,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc);
 void pci_epc_destroy(struct pci_epc *epc);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf);
 void pci_epc_linkup(struct pci_epc *epc);
+void pci_epc_init_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
 			 struct pci_epf_header *hdr);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index efbc08a153ff..6644ff3b0702 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -15,6 +15,11 @@
 
 struct pci_epf;
 
+enum pci_notify_event {
+	CORE_INIT,
+	LINK_UP,
+};
+
 enum pci_barno {
 	BAR_0,
 	BAR_1,
-- 
2.17.1


--LeM1RKqnd8YGoEkwJOx8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5646): https://lists.cip-project.org/g/cip-dev/message=
/5646
Mute This Topic: https://lists.cip-project.org/mt/77727251/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LeM1RKqnd8YGoEkwJOx8--
