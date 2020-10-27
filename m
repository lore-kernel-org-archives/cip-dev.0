Return-Path: <SRS0=2i1F=EC=lists.cip-project.org=bounce+64572+5676+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C0C56202
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AFE20728
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 16:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nhZn0y1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AFE20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5676+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pI5yYY4521723xFW0UxCSfZw; Tue, 27 Oct 2020 09:56:27 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.57.1603817786680344361
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2020 09:56:27 -0700
X-IronPort-AV: E=Sophos;i="5.77,424,1596466800"; 
   d="scan'208";a="60743166"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2020 01:56:24 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 71B7940A87A0;
	Wed, 28 Oct 2020 01:56:23 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/5] Add PCIe EP nodes to RZ/G2{EMN}
Date: Tue, 27 Oct 2020 16:56:17 +0000
Message-Id: <20201027165622.28777-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EEF97SBvixdF72O6szZuakbex4520388AA=
Content-Type: multipart/mixed; boundary="VuMbgcZJT034mqU28Rmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603817787;
 bh=udPSCyINmoMvALoeCV5XVMInAWhzZ5ciwN/myJoxxdI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nhZn0y1eUQ4LsM43riyAjK3wXTw/mWfEVDZb3vCXpuXFrI/ieiE9l6SMaWI6HoI8OlX
 7BkcPkOEpVMRjx1dynvr1ihzaQ2AlhFGh9Lzb/zke6aeko2QZIVlogq/pkrTJQqqLP3C1
 6Y72iIdGb1p/F4jC6elAZ5wEiCgke3WI2l0=

--VuMbgcZJT034mqU28Rmv

Hi All,

These patches are part of RFC series [1] ({43-46,48}/50),
these were dropped earlier as they weren't part of -rc release
at the time of posting now that patches have landed in v5.10-rc1
I am resending them with non-RFC tag.

[1] https://patchwork.kernel.org/project/cip-dev/
    list/?series=363279&state=%2A&archive=both

Cheers,
Prabhakar

Lad Prabhakar (5):
  dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
  arm64: dts: renesas: r8a774c0: Add PCIe EP node
  arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
  arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
  misc: pci_endpoint_test: Add Device ID for RZ/G2M and RZ/G2N PCIe
    controllers

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  7 +++-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi     | 38 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi     | 38 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi     | 19 ++++++++++
 drivers/misc/pci_endpoint_test.c              |  7 +++-
 5 files changed, 105 insertions(+), 4 deletions(-)

-- 
2.17.1


--VuMbgcZJT034mqU28Rmv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5676): https://lists.cip-project.org/g/cip-dev/message=
/5676
Mute This Topic: https://lists.cip-project.org/mt/77842959/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VuMbgcZJT034mqU28Rmv--
