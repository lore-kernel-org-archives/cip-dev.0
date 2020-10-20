Return-Path: <SRS0=5i40=D3=lists.cip-project.org=bounce+64572+5620+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338EC4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31E521D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wckg2iuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31E521D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5620+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HB8AYY4521723xTUmsl1oTml; Tue, 20 Oct 2020 07:58:11 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8069.1603205878331425469
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:58:10 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088235"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:58:09 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A8DC3433DEA0;
	Tue, 20 Oct 2020 23:58:08 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 23/26] PCI: endpoint: Fix clearing start entry in configfs
Date: Tue, 20 Oct 2020 15:57:29 +0100
Message-Id: <20201020145732.30343-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mcW2kYKZLJeEE2lRRykFhGA3x4520388AA=
Content-Type: multipart/mixed; boundary="QCju3xxP063oWIo17iqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205891;
 bh=GhBJOSCglczkRQlOe6SkbGR1cbV9YmLAsYblEWpn340=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wckg2iuwilk33gShIbSublXy5ruD5PM4s0zPwG2yyBOTbNnCTRK2BvgJ5r8hxq9r7aF
 sK8glIk2YT3ApZmyxW4X6Q2H671bKdUd/mfis9q0PNzGOMf6yPqiTQ0kdJf6adXRxhtLd
 BAFWvbLvAEYnW4tYyzb48t0o4QLO5dTJGBg=

--QCju3xxP063oWIo17iqp

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
index d1288a0bd530..4fead88257bb 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -58,6 +58,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 
 	if (!start) {
 		pci_epc_stop(epc);
+		epc_group->start = 0;
 		return len;
 	}
 
-- 
2.17.1


--QCju3xxP063oWIo17iqp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5620): https://lists.cip-project.org/g/cip-dev/message=
/5620
Mute This Topic: https://lists.cip-project.org/mt/77683542/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QCju3xxP063oWIo17iqp--
