Return-Path: <SRS0=q804=IH=lists.cip-project.org=bounce+64572+6243+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63B7C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0F564FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0F564FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6243+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Bx3lYY4521723xQ5wOiLYG6K; Tue, 09 Mar 2021 08:37:36 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:35 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591037"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:35 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 49E9740A3D20;
	Wed, 10 Mar 2021 01:37:34 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 27/40] media: dt-bindings: rcar-vin: Add R8A774B1 support
Date: Tue,  9 Mar 2021 16:36:43 +0000
Message-Id: <20210309163656.20944-28-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sSw7qZvBvS2qvbL1I7knO8jVx4520388AA=
Content-Type: multipart/mixed; boundary="RPwSGhrgxP0kSasfZhyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307856;
 bh=kqB5OjCZUtDqabZvYfc9ncsW7T/AClapMLtsED2+NL0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=d8xovJLWa3qRrr/tMzX3NNzchGQXuJscDlljwkrKwuO7+nJmeABwqGphdbMgeciE8PX
 UXaSml/YQREshJyuaH+vtbRanungjGFWxDK4J9XH11ZNvJnFOm8qvcsgZScxrYM8wMrYG
 iY0eB+zt/csMz31/F0fjRDL/ceYrwU88HlM=

--RPwSGhrgxP0kSasfZhyn

From: Biju Das <biju.das@bp.renesas.com>

commit 8681cc38dfa84f5952bca024191eb4ff1646525d upstream.

Document support for the VIN module in the Renesas RZ/G2N (R8A774B1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
[PL:manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 5bc5d6b9d5bc..4d4841bce32a 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -13,6 +13,7 @@ on Gen3 and RZ/G2 platforms to a CSI-2 receiver.
    - "renesas,vin-r8a7743" for the R8A7743 device
    - "renesas,vin-r8a7745" for the R8A7745 device
    - "renesas,vin-r8a774a1" for the R8A774A1 device
+   - "renesas,vin-r8a774b1" for the R8A774B1 device
    - "renesas,vin-r8a774c0" for the R8A774C0 device
    - "renesas,vin-r8a7778" for the R8A7778 device
    - "renesas,vin-r8a7779" for the R8A7779 device
-- 
2.17.1


--RPwSGhrgxP0kSasfZhyn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6243): https://lists.cip-project.org/g/cip-dev/message=
/6243
Mute This Topic: https://lists.cip-project.org/mt/81205376/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RPwSGhrgxP0kSasfZhyn--
