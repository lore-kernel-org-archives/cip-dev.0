Return-Path: <SRS0=Sz3n=IH=lists.cip-project.org=bounce+64572+6248+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AFEC433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331A464FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331A464FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6248+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tqidYY4521723xPgmEFcmxNS; Tue, 09 Mar 2021 08:37:44 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:43 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591046"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:42 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0878B40A3D20;
	Wed, 10 Mar 2021 01:37:40 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 32/40] media: dt-bindings: media: renesas,vin: Add R8A774E1 support
Date: Tue,  9 Mar 2021 16:36:48 +0000
Message-Id: <20210309163656.20944-33-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TPH7tZobvguiPFvpf0ru985wx4520388AA=
Content-Type: multipart/mixed; boundary="uESvTjTpniJTjazNFIkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307864;
 bh=cs+cg43JXUnBmQ1jYJrkpSXUSej+wkZtMFz5voVWqK8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KNjrrdMLGf9WEGhTVtJNTw1XMEbTAVP7wmW1dfwYfUEZvO9PZYVDy141FlMdg5QIGhs
 s3K49zDgPbloMmYuiiWxSIWud6WLJoZaQH3/r3m+aOec+EQAEJBmQa/NJtUas3+IvUXlZ
 SyUe8W1wf05zOABYR1jBJKAJ/m/sLfXorSo=

--uESvTjTpniJTjazNFIkf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 200b0d9a754e5436c2952c934c813a3b26da78b2 upstream.

Document support for the VIN module in the Renesas RZ/G2H (R8A774E1) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
[PL: Patched text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 4d4841bce32a..0f20db3ef9a3 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -15,6 +15,7 @@ on Gen3 and RZ/G2 platforms to a CSI-2 receiver.
    - "renesas,vin-r8a774a1" for the R8A774A1 device
    - "renesas,vin-r8a774b1" for the R8A774B1 device
    - "renesas,vin-r8a774c0" for the R8A774C0 device
+   - "renesas,vin-r8a774e1" for the R8A774E1 device
    - "renesas,vin-r8a7778" for the R8A7778 device
    - "renesas,vin-r8a7779" for the R8A7779 device
    - "renesas,vin-r8a7790" for the R8A7790 device
-- 
2.17.1


--uESvTjTpniJTjazNFIkf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6248): https://lists.cip-project.org/g/cip-dev/message=
/6248
Mute This Topic: https://lists.cip-project.org/mt/81205387/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uESvTjTpniJTjazNFIkf--
