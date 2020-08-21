Return-Path: <SRS0=3H0c=B7=lists.cip-project.org=bounce+64572+5220+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3025FC433EA
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:18:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A3D204FD
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aASnuX9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A3D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5220+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NsrjYY4521723x2i5R9WjHpr; Fri, 21 Aug 2020 07:17:59 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.135294.1598019426613685109
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 07:17:07 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54969223"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 23:17:04 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 975F140065C6;
	Fri, 21 Aug 2020 23:17:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/7] Add IPMMU/SYS-DMAC/GPIO/EAVB Support on R8A774E1
Date: Fri, 21 Aug 2020 15:16:55 +0100
Message-Id: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: B0ZEHRuzjgv45yJKbqPyx4xDx4520388AA=
Content-Type: multipart/mixed; boundary="9nDeeiiPABEOc4CGe86i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598019479;
 bh=CGIe3M+DIM1+mtoC5rAbzS7XXDVm3E/3u1oLHffC1kY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aASnuX9lNP5aVKo8e2y+bq0v+VUMK+ZimZvho5hkz6wFPVvWck8IV2BOoV/Z5EW9Fln
 PLnAyR5EG7JMjXTMubyt/3RPrIbNfwQmiAxzkD1Cekeu5vFkNrgxBHQVA+WCGNjLj2AnN
 /CtYV3FGXPDR++ASBYQHCIdUSwSRq+fZogw=

--9nDeeiiPABEOc4CGe86i

This patch series add support for IPMMU/SYS-DMAC/GPIO/EAVB on
HiHope RZ/G2H board based on R8A774E1 SoC.

This patches in this series are cherry-picked from mainline.

This patch series depend upon [1]
[1]: https://patchwork.kernel.org/project/cip-dev/list/?series=336489

Lad Prabhakar (2):
  dt-bindings: iommu: renesas,ipmmu-vmsa: Add r8a774e1 support
  dt-bindings: dma: renesas,rcar-dmac: Document R8A774E1 bindings

Marian-Cristian Rotariu (5):
  iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
  arm64: dts: renesas: r8a774e1: Add IPMMU device nodes
  arm64: dts: renesas: r8a774e1: Add SYS-DMAC device nodes
  arm64: dts: renesas: r8a774e1: Add GPIO device nodes
  arm64: dts: renesas: r8a774e1: Add Ethernet AVB node

 .../bindings/dma/renesas,rcar-dmac.txt        |   1 +
 .../bindings/iommu/renesas,ipmmu-vmsa.txt     |   1 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 361 +++++++++++++++++-
 drivers/iommu/ipmmu-vmsa.c                    |   5 +
 4 files changed, 349 insertions(+), 19 deletions(-)

-- 
2.17.1


--9nDeeiiPABEOc4CGe86i
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5220): https://lists.cip-project.org/g/cip-dev/message=
/5220
Mute This Topic: https://lists.cip-project.org/mt/76329804/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9nDeeiiPABEOc4CGe86i--
