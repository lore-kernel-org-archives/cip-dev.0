Return-Path: <SRS0=g6Pc=DT=lists.cip-project.org=bounce+64572+5535+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED9AC43457
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9227220838
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oUBZ6wtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9227220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5535+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PfuSYY4521723xlxwNSAhARq; Mon, 12 Oct 2020 07:20:30 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.41774.1602512378241754205
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:19:59 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351909"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:19:58 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6B84642A7637;
	Mon, 12 Oct 2020 23:19:57 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 15/50] PCI: endpoint: Remove features member in struct pci_epc
Date: Mon, 12 Oct 2020 15:18:58 +0100
Message-Id: <20201012141933.9652-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fAMOCvHVJsxOW52EOWa0Vpa5x4520388AA=
Content-Type: multipart/mixed; boundary="j4RxJpk0zGA11yGLociU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512430;
 bh=wIstCh+S8Vz6kll7qhJp+J+1VkEUxeeV9eiN2TEz4gE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oUBZ6wtG3P45+78fXU7OzXLy18U+8QLAUyAR44YcN3VAT6/d9GlFyCX3wbxLhrLFABX
 0ADloux7ukmQQTYmtIPRIN8GpUjEkhJ/u2OZKag1LgXCiO1XPOEAPNSJzx3TqghjMun+r
 e+bfLHPPiOdnTjyq+mAME8t6Do6JAdAPbx0=

--j4RxJpk0zGA11yGLociU

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 35ce0d7922d68021062a955407740d262f9ac811 upstream.

Since EPC features are now implemented using pci_epc_features and
all the EPC drivers are moved to using pci_epc_features, remove
features member in struct pci_epc and all the helper macros for
configuring the features.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/pci-epc.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index dcaecf715b1c..b3a3c0805603 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -102,7 +102,6 @@ struct pci_epc {
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
-	unsigned int			features;
 };
 
 /**
@@ -123,14 +122,6 @@ struct pci_epc_features {
 	u64	bar_fixed_size[BAR_5 + 1];
 };
 
-#define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
-#define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
-#define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
-#define EPC_FEATURE_SET_BAR(features, bar)	\
-		(features |= (EPC_FEATURE_BAR_MASK & (bar << 1)))
-#define EPC_FEATURE_GET_BAR(features)		\
-		((features & EPC_FEATURE_BAR_MASK) >> 1)
-
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
 
 #define pci_epc_create(dev, ops)    \
-- 
2.17.1


--j4RxJpk0zGA11yGLociU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5535): https://lists.cip-project.org/g/cip-dev/message=
/5535
Mute This Topic: https://lists.cip-project.org/mt/77461675/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--j4RxJpk0zGA11yGLociU--
