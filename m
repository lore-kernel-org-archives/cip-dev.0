Return-Path: <SRS0=ERpV=IH=lists.cip-project.org=bounce+64572+6238+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F437C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AD664F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AD664F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6238+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8IZvYY4521723xIbOZR6Pm2k; Tue, 09 Mar 2021 08:37:29 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:29 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342249"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:28 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 97FB040A2EDA;
	Wed, 10 Mar 2021 01:37:27 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 22/40] media: dt-bindings: media: rcar_vin: Add r8a774a1 support
Date: Tue,  9 Mar 2021 16:36:38 +0000
Message-Id: <20210309163656.20944-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iaJPBrpbuY7CxTYPWQoty4zCx4520388AA=
Content-Type: multipart/mixed; boundary="1uSYjNt8zeeUrVpDdLyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307849;
 bh=IlN63SLMj7PibYWyMbl6t3+5VlMa/CTpp3cpeim17GA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=p4g+s4/fa3/iuDCvOSNLgmTSGht1eZ8uubRRFXxL/BkSaHUcw5XWO5D6eWLlGD0zYDx
 3XRnTImvdLpnJp0B6aQiWSKcH125md4gwW6JwotkxPvmaIwVcwTWlfSWtglFXYPSQMNvl
 fHV7i79719jYc5xZGrLQfBUYqQ9MwIHAw6o=

--1uSYjNt8zeeUrVpDdLyu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das@bp.renesas.com>

commit b8f92200d16e68e51c55f8ea7c2e251c423aac76 upstream.

Document RZ/G2M (R8A774A1) SoC bindings.

The RZ/G2M SoC is similar to R-Car M3-W (R8A7796).

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 2dc9e32d6b4f..5bc5d6b9d5bc 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -12,6 +12,7 @@ on Gen3 and RZ/G2 platforms to a CSI-2 receiver.
  - compatible: Must be one or more of the following
    - "renesas,vin-r8a7743" for the R8A7743 device
    - "renesas,vin-r8a7745" for the R8A7745 device
+   - "renesas,vin-r8a774a1" for the R8A774A1 device
    - "renesas,vin-r8a774c0" for the R8A774C0 device
    - "renesas,vin-r8a7778" for the R8A7778 device
    - "renesas,vin-r8a7779" for the R8A7779 device
-- 
2.17.1


--1uSYjNt8zeeUrVpDdLyu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6238): https://lists.cip-project.org/g/cip-dev/message=
/6238
Mute This Topic: https://lists.cip-project.org/mt/81205370/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1uSYjNt8zeeUrVpDdLyu--
