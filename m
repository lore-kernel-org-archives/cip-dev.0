Return-Path: <SRS0=fHF0=E6=lists.cip-project.org=bounce+64572+5846+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C68C2D0E4
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7FB20857
	for <cip-dev@archiver.kernel.org>; Tue, 24 Nov 2020 17:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qULPqOjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7FB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5846+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id b2mIYY4521723xQZmmENry9g; Tue, 24 Nov 2020 09:11:35 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.15.1606237784446827976
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:09:46 -0800
X-IronPort-AV: E=Sophos;i="5.78,366,1599490800"; 
   d="scan'208";a="63522780"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Nov 2020 02:09:45 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.254])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4B74540ABFEE;
	Wed, 25 Nov 2020 02:09:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 6/9] usb: host: xhci-plat: Add r8a7742 support
Date: Tue, 24 Nov 2020 17:09:29 +0000
Message-Id: <20201124170932.13588-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
References: <20201124170932.13588-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KkfCdTO1jqz5pf2hhjw4jLvox4520388AA=
Content-Type: multipart/mixed; boundary="pttcwVwBOujOjonFlXAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606237895;
 bh=R8nR1+YhXy5q5oWM40BTXVKZ8tgHDeTFjlf5sp39Ymc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qULPqOjmPrq/kGwZPfmvhV1qcC4meewl9asDQKYq18L8BECeX3ml02IJbcPaeCAdpiz
 2elHPgbr9hs7DpVNiFu2rjtcHoQ8wY7mXN2wuA1PHzRkX124JOKW/HwIT/6YK0jcAzdOb
 IVeKDy3wYY8Ch86/GLrxT5PbX+qvctvPD0w=

--pttcwVwBOujOjonFlXAO

This patch adds xhci r8a7742 driver support.

There are lot of changes between upstream and 4.4 kernel and
we cannot cleanly backport the changes from upstream.

This patch is similar to commit d09ccbb73386 ("usb: host:
xhci-plat: Add r8a7743 support") present in cip kernel.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 26e0cd535deb..46e69e2db1fa 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -54,6 +54,7 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 
 	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7742") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7744")) {
 		ret = xhci_rcar_init_quirk(hcd);
@@ -70,6 +71,7 @@ static int xhci_plat_start(struct usb_hcd *hcd)
 
 	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7742") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7743") ||
 	    of_device_is_compatible(of_node, "renesas,xhci-r8a7744"))
 		xhci_rcar_start(hcd);
@@ -271,6 +273,7 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	{ .compatible = "xhci-platform" },
 	{ .compatible = "marvell,armada-375-xhci"},
 	{ .compatible = "marvell,armada-380-xhci"},
+	{ .compatible = "renesas,xhci-r8a7742"},
 	{ .compatible = "renesas,xhci-r8a7743"},
 	{ .compatible = "renesas,xhci-r8a7744"},
 	{ .compatible = "renesas,xhci-r8a7790"},
-- 
2.17.1


--pttcwVwBOujOjonFlXAO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5846): https://lists.cip-project.org/g/cip-dev/message=
/5846
Mute This Topic: https://lists.cip-project.org/mt/78481728/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pttcwVwBOujOjonFlXAO--
