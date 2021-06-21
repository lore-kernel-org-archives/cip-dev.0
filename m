Return-Path: <SRS0=AeUi=LP=lists.cip-project.org=bounce+64572+6559+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB1C48BE5
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A086054E
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A086054E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6559+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fOlbYY4521723xV4ZxRUwXsC; Mon, 21 Jun 2021 10:09:52 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.50359.1624295389824735430
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:50 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="84957104"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:46 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 928B34003EA5;
	Tue, 22 Jun 2021 02:09:45 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 14/16] dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings
Date: Mon, 21 Jun 2021 18:09:23 +0100
Message-Id: <20210621170925.11328-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UlAFBUGKrObqgglRVsT6Yiazx4520388AA=
Content-Type: multipart/mixed; boundary="zFyYhK2iTcYzBvuhquWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295392;
 bh=bx5utdFXEKzLvdVhbAJogg2IIVRvtAzu77y26K7+yy8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Hb5b4IXqfnWrSk+Ld3RFBjexFCw2UYxnkGaGLSBScn+eX602OLKO/RrudZP3WrEFbak
 y9YqBpFP/N1WqGyglp2kAXCVzxfLTt13wo2aYKETKXvyqegbyAk6E1rCQtmTidLdcajBg
 yxNgyOQIdmEcQhSIhBlUTkMJ2s3J2tj4hDw=

--zFyYhK2iTcYzBvuhquWc

commit 64fc0a030987eec45c5362618bacdef7227783d5 upstream.

Document the RZ/G2H (a.k.a. R8A774E1) SoC in the R-Car PCIe bingings.

[shimoda: minor change the subject and description]

Link: https://lore.kernel.org/r/1604455096-13923-4-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
[PL: Patched text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 14d307deff06..8e495d6811a0 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -7,6 +7,7 @@ compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
 	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
 	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
 	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
+	    "renesas,pcie-r8a774e1" for the R8A774E1 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
-- 
2.17.1


--zFyYhK2iTcYzBvuhquWc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6559): https://lists.cip-project.org/g/cip-dev/message=
/6559
Mute This Topic: https://lists.cip-project.org/mt/83693890/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zFyYhK2iTcYzBvuhquWc--
