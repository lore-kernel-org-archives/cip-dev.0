Return-Path: <SRS0=ZR6f=DT=lists.cip-project.org=bounce+64572+5550+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF76DC433E7
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C0320838
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wvjs0CMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C0320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5550+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fX73YY4521723xEBMb5ChkOy; Mon, 12 Oct 2020 07:21:04 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.42182.1602512420027305830
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:21 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59351951"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:20 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CF51E41D31C7;
	Mon, 12 Oct 2020 23:20:19 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 30/50] PCI: endpoint: Fix clearing start entry in configfs
Date: Mon, 12 Oct 2020 15:19:13 +0100
Message-Id: <20201012141933.9652-31-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ahgDybw29R3Mk3d7L9ZtgvRfx4520388AA=
Content-Type: multipart/mixed; boundary="OySbjabSMZnnxiDsHaDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512464;
 bh=4N27HYgJtuxOtbl5OSBdekXw89kabvG0h+pYCfm+Dr0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wvjs0CMDcbREmSvPVGyMvWCWrO6MbMD9xsIezUdMq0tnWEDlMdFSYkYQTrqIYWo34QR
 vg0okTKDw11vP19FTK3LjDn3Q6c1osZ26/4eH1MKoQ42xL2JNFYSweIJ1eZc5ixigjhVe
 T4gjaPYHwivoDzW1SkD0v6JK6t0HhRfvdDY=

--OySbjabSMZnnxiDsHaDE

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

commit f58d5f53c89479c12ad719c1960176442add5aaa upstream.

After an endpoint is started through configfs, if 0 is written to the
configfs entry 'start', the controller stops but the epc_group->start
value remains 1.

A subsequent unlinking of the function from the controller would trigger
a spurious WARN_ON_ONCE() in pci_epc_epf_unlink() despite right
behavior.

Fix it by setting epc_group->start = 0 when a controller is stopped
using configfs.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index e7e8367eead1..55edce50be96 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -57,6 +57,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 
 	if (!start) {
 		pci_epc_stop(epc);
+		epc_group->start = 0;
 		return len;
 	}
 
-- 
2.17.1


--OySbjabSMZnnxiDsHaDE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5550): https://lists.cip-project.org/g/cip-dev/message=
/5550
Mute This Topic: https://lists.cip-project.org/mt/77461707/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OySbjabSMZnnxiDsHaDE--
