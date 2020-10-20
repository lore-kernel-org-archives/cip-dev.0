Return-Path: <SRS0=/hHo=D3=lists.cip-project.org=bounce+64572+5604+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7054BC54FB2
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89F821D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JhA3pUS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89F821D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5604+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IeLZYY4521723xMxf4q2NCBb; Tue, 20 Oct 2020 07:57:51 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8061.1603205857454945281
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:46 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088184"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:45 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7C3E2433DEA1;
	Tue, 20 Oct 2020 23:57:44 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/26] PCI: endpoint: Add helper to get first unreserved BAR
Date: Tue, 20 Oct 2020 15:57:13 +0100
Message-Id: <20201020145732.30343-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mSqld1EpswHMU44DyQKzxg4Ax4520388AA=
Content-Type: multipart/mixed; boundary="diKZ8SE9RO2MLMvoyEud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205871;
 bh=2dZZBM+iskvkMVFbi+mEYG0cnao48ezfjJbmWnR5spg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JhA3pUS1AxeS6S+QQzBxTKoldtuclJmkISoyGuzWcqYG9JHkpiL3YinvYdl5PiYwEuG
 pOEq2SVi+cakHiEJXhlA9QgRF4ysFOKQP6pJh0+XMeNCAN6a5K7qFBAQHX7wvaRqBkTAK
 xR4nw5sA/ht56oHMUa0hNKEOHhh8kJsgsu8=

--diKZ8SE9RO2MLMvoyEud

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 1e9efe6c9976552e88c6e6feaca3a78b8cf5aaf6 upstream.

Add a helper function pci_epc_get_first_free_bar() to get the first
unreserved BAR that can be used for endpoint function.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a099479d9ab..e4712a0f249c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,29 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
+ * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
+ *
+ * Invoke to get the first unreserved BAR that can be used for endpoint
+ * function. For any incorrect value in reserved_bar return '0'.
+ */
+unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
+					*epc_features)
+{
+	int free_bar;
+
+	if (!epc_features)
+		return 0;
+
+	free_bar = ffz(epc_features->reserved_bar);
+	if (free_bar > 5)
+		return 0;
+
+	return free_bar;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
+
 /**
  * pci_epc_get_features() - get the features supported by EPC
  * @epc: the features supported by *this* EPC device will be returned
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index fcd5e5047546..dcaecf715b1c 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -183,6 +183,8 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no);
+unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
+					*epc_features);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1


--diKZ8SE9RO2MLMvoyEud
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5604): https://lists.cip-project.org/g/cip-dev/message=
/5604
Mute This Topic: https://lists.cip-project.org/mt/77683519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--diKZ8SE9RO2MLMvoyEud--
