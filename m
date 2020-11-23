Return-Path: <SRS0=7Lc7=E5=lists.cip-project.org=bounce+64572+5813+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EA9C56202
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 10:55:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C597B20773
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 10:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cT8ihHEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C597B20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5813+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QtsDYY4521723xKN54ZUPMWa; Mon, 23 Nov 2020 02:54:58 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.33426.1606128897696418504
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 02:54:58 -0800
X-IronPort-AV: E=Sophos;i="5.78,363,1599490800"; 
   d="scan'208";a="63585579"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Nov 2020 19:54:55 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D764F42697A9;
	Mon, 23 Nov 2020 19:54:54 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/2] Add sound support to R8A774E1 SoC
Date: Mon, 23 Nov 2020 10:54:51 +0000
Message-Id: <20201123105453.22074-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2Foi7qFmj3S4xWlE6wkku3PMx4520388AA=
Content-Type: multipart/mixed; boundary="2lWeuEnS4xUVfxPQInyC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606128898;
 bh=xHEcuQJlTUEphzFtU0A9m1WQoH5tNUcBuhM5Ppw66O8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cT8ihHEwCh3FdQSIVMK3OEbpLMwcCPYtQuHM009LumaTN1sMocLoM5ySCdbyGgWQvtS
 0snykZOTlTa5qBIjfkrNEO7Z8rrodgvbW7CO7V0vGAX8UwPeAo7wb+LdVZnLRqBIUE32k
 vYNAYw/QlpRyACsIJ9mlo62jNdKvcLjlDvc=

--2lWeuEnS4xUVfxPQInyC

Hi All,

This patch series adds sound support to Renesas R8A774E1 SoC.

All the patches have been cherry picked from Linux v5.10-rc5.

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: r8a774e1: Add missing audio_clk_b
  arm64: dts: renesas: r8a774e1: Add audio support

 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 484 +++++++++++++++++++++-
 1 file changed, 481 insertions(+), 3 deletions(-)

-- 
2.17.1


--2lWeuEnS4xUVfxPQInyC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5813): https://lists.cip-project.org/g/cip-dev/message=
/5813
Mute This Topic: https://lists.cip-project.org/mt/78450804/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2lWeuEnS4xUVfxPQInyC--
