Return-Path: <SRS0=mRvB=GI=lists.cip-project.org=bounce+64572+6022+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA689C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BE122B45
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 15:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BE122B45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6022+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5hVLYY4521723xXB6TtDCA4H; Tue, 05 Jan 2021 07:11:02 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.6688.1609859461253190014
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 07:11:01 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68089562"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jan 2021 00:10:59 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F20C4400A0E0;
	Wed,  6 Jan 2021 00:10:58 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/8] Optimize pinctrl and add QSPI[01] pins for RZ/G2{H,M,N,E}
Date: Tue,  5 Jan 2021 15:10:49 +0000
Message-Id: <20210105151057.12752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FlWck65kSKSf3yyHfbCzJxxPx4520388AA=
Content-Type: multipart/mixed; boundary="WRWtEanZUGhqCFoxqzwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609859462;
 bh=l1TcfqSXCOoIg8xyi4jryrhoMZNPkxS+OqVZuRS+p4g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=f7XuF1S2S/JEa09OBo0OUccQzFr9+27CHVoll0jYHRqRqFvv17ti6EPsq/Nx72D6AXs
 vmuRjRXKMBrY0WsvufVL5UI4ljcd00wkyHU0wqeeZ/BWjNdr+T2XugpNhGUdc6hn9O3cN
 qG6+kQZA1iLaw02Iy51MRdWtNSFCCNMbIqM=

--WRWtEanZUGhqCFoxqzwe

Hi All,

This patch series optimizes pinctrl driver for size and adds QSPI[01]
pins for RZ/G2{H,M,N,E} SoC.

All the patches have been cherry picked from v5.11-rc2

Currently the SoC DTSI changes are being upstreamed [1] once this hits -rc
this will be backported to the CIP. This is for users who currently plan to
enable RPC-IF on CIP kernel (using patches from [1] to enable RPC-IF).

[1] https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=408139

Cheers,
Prabhakar

Biju Das (4):
  pinctrl: renesas: r8a7796: Optimize pinctrl image size for R8A774A1
  pinctrl: renesas: r8a77951: Optimize pinctrl image size for R8A774E1
  pinctrl: renesas: r8a77965: Optimize pinctrl image size for R8A774B1
  pinctrl: renesas: r8a77990: Optimize pinctrl image size for R8A774C0

Lad Prabhakar (4):
  pinctrl: renesas: r8a77990: Add QSPI[01] pins, groups and functions
  pinctrl: renesas: r8a77951: Add QSPI[01] pins, groups and functions
  pinctrl: renesas: r8a7796: Add QSPI[01] pins, groups and functions
  pinctrl: renesas: r8a77965: Add QSPI[01] pins, groups and functions

 drivers/pinctrl/sh-pfc/pfc-r8a77951.c | 89 +++++++++++++++++++++++++--
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c  | 87 +++++++++++++++++++++++++-
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 87 +++++++++++++++++++++++++-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 87 +++++++++++++++++++++++++-
 4 files changed, 340 insertions(+), 10 deletions(-)

-- 
2.17.1


--WRWtEanZUGhqCFoxqzwe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6022): https://lists.cip-project.org/g/cip-dev/message=
/6022
Mute This Topic: https://lists.cip-project.org/mt/79451745/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WRWtEanZUGhqCFoxqzwe--
