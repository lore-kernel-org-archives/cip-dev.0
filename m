Return-Path: <SRS0=OmWk=DT=lists.cip-project.org=bounce+64572+5547+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EBC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C16F2076E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WULOvRZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C16F2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5547+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WsriYY4521723xofYmL1GpP1; Mon, 12 Oct 2020 07:21:02 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.41794.1602512415549265316
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:16 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59566850"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:16 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5EC6D40BA087;
	Mon, 12 Oct 2020 23:20:15 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 27/50] PCI: endpoint: Add core init notifying feature
Date: Mon, 12 Oct 2020 15:19:10 +0100
Message-Id: <20201012141933.9652-28-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VOKKBxniyirq4iVkUTnFkUpWx4520388AA=
Content-Type: multipart/mixed; boundary="bjHmrWCajksXc8l28Va2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512462;
 bh=9ego83tfrm3Jo5r/G8XX2Trfd7zxUPYl0eBq9qPYvks=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WULOvRZl67fYr6NP6pueMjNdU5OY0XQAxQfYYCoWirfIIxF+PXy0Lc7f1eV0yvXE86M
 w4IwOUEErx0kSeYGLUXliee5cr0pilSlIAtoL+Lf5VAP+JwVws/u3t9ebmuT91eVjkala
 kmvVdcD5nWOG+NsmcVfzflz5vyEjm6HlPHE=

--bjHmrWCajksXc8l28Va2

From: Vidya Sagar <vidyas@nvidia.com>

commit 3d5f7d9f6a38ddcc105ebfb23b640630bbabba65 upstream.

Add a new feature core_init_notifier for cores that can notify about
their availability for initialization.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/pci-epc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 44bfbeb480bb..8f9bbc4b7ad1 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -120,6 +120,7 @@ struct pci_epc {
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
+	unsigned int	core_init_notifier : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;
-- 
2.17.1


--bjHmrWCajksXc8l28Va2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5547): https://lists.cip-project.org/g/cip-dev/message=
/5547
Mute This Topic: https://lists.cip-project.org/mt/77461702/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bjHmrWCajksXc8l28Va2--
