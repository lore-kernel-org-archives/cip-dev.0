Return-Path: <SRS0=QpnE=6E=lists.cip-project.org=bounce+64572+4587+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,
	SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C01AC3815B
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08F02074F
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Dutznhve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08F02074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4587+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Dw6EYY4521723xVJ2dBvOsaj; Mon, 20 Apr 2020 12:50:55 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.1970.1587412253742864971
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 12:50:54 -0700
X-IronPort-AV: E=Sophos;i="5.72,407,1580742000"; 
   d="scan'208";a="45013028"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2020 04:50:52 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4E57440CC657;
	Tue, 21 Apr 2020 04:50:51 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Subject: [cip-dev] [PATCH 0/2] Add HiHope RZ/G2M board with idk-1110wr display
Date: Mon, 20 Apr 2020 20:50:48 +0100
Message-Id: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uVdpvJzB5JPDqPNHZ65OQP4kx4520388AA=
Content-Type: multipart/mixed; boundary="klAolBBXKkRHS6qhixJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587412255;
 bh=i7sEfXqn68VN8lSlHgD5LDyNAAQKfQRDhuU1ZG5yzyo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DutznhvedXKORMi6W06oUGJ6puhBD/1tel0KlhXOFukTVtm507+mz3jRzXPL1cSHseU
 wMGPRYJzlFe4BWoQuqJjT1+sJPcts8MlzSxD1j7z/5tZ8Eu6qw4qgTZ+zDmXpKIVQAuF8
 M1wmWgbIUK2AXyXh0Zes38PEOj74SIG+2fg=

--klAolBBXKkRHS6qhixJa

Hi All,

This patch series adds support idk-1110wr display on RZ/G2M board.

Cheers,
--Prabhakar

Fabrizio Castro (1):
  arm64: dts: renesas: Add HiHope RZ/G2M board with idk-1110wr display

Lad Prabhakar (1):
  dt-bindings: display: Add idk-1110wr binding

 .../display/panel/advantech,idk-1110wr.txt         | 45 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 .../r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts        | 52 ++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.txt
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts

-- 
2.7.4


--klAolBBXKkRHS6qhixJa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4587): https://lists.cip-project.org/g/cip-dev/message=
/4587
Mute This Topic: https://lists.cip-project.org/mt/73158050/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--klAolBBXKkRHS6qhixJa--
