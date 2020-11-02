Return-Path: <SRS0=MlQV=EI=lists.cip-project.org=bounce+64572+5704+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D21C55179
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160CC2223C
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GcSAjUeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160CC2223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5704+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G45OYY4521723xYveOxfy07r; Mon, 02 Nov 2020 01:24:50 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.28759.1604309087918325827
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 01:24:49 -0800
X-IronPort-AV: E=Sophos;i="5.77,444,1596466800"; 
   d="scan'208";a="61463276"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Nov 2020 18:24:49 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6CA734006CCF;
	Mon,  2 Nov 2020 18:24:48 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] dt-bindings: pci: rcar-pci-ep: Document r8a774e1
Date: Mon,  2 Nov 2020 09:24:40 +0000
Message-Id: <20201102092443.4142-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uZpeJQyQ36Qnb6g1Du1HRHGsx4520388AA=
Content-Type: multipart/mixed; boundary="8FdkoaQOkKJRktirGCEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604309090;
 bh=/8xoluJhanhTYjTFUgSB66QY01+ppB1HBqhiwZQvuXQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=GcSAjUeOEAYA0Rrk8kZCRYA/vGYlgzOJ/KAJjvJabxheZhJJX6ySBKBWqJ5zkIIJZVP
 xoyd4oR6ilR6qIO5nAzvQ6lAz/trX0OD/23TvWVLzH8X1bkiRFy30e4+zL7/xRbNYpbIp
 l/WmA7gpvAbp/yseAIXDYk95LCRk+f2dY8M=

--8FdkoaQOkKJRktirGCEy

commit 5e94083c781445b4b5c00689167558dce694da65 upstream.

Document the support for R-Car PCIe EP on R8A774E1 SoC device.

Link: https://lore.kernel.org/r/20200904103851.3946-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index 70c45f72ab20..a059c96c294b 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -18,6 +18,7 @@ properties:
           - renesas,r8a774a1-pcie-ep     # RZ/G2M
           - renesas,r8a774b1-pcie-ep     # RZ/G2N
           - renesas,r8a774c0-pcie-ep     # RZ/G2E
+          - renesas,r8a774e1-pcie-ep     # RZ/G2H
       - const: renesas,rcar-gen3-pcie-ep # R-Car Gen3 and RZ/G2
 
   reg:
-- 
2.17.1


--8FdkoaQOkKJRktirGCEy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5704): https://lists.cip-project.org/g/cip-dev/message=
/5704
Mute This Topic: https://lists.cip-project.org/mt/77977472/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8FdkoaQOkKJRktirGCEy--
