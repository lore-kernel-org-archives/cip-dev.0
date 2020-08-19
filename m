Return-Path: <SRS0=94Wi=B5=lists.cip-project.org=bounce+64572+5150+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D40C433F2
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DB720888
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Bq7n1ee2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DB720888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5150+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yrfnYY4521723xr3A5HnAUpg; Wed, 19 Aug 2020 09:45:13 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.92110.1597854998224602430
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:38 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54984464"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:37 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A252C400B9C0;
	Thu, 20 Aug 2020 01:36:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/12] Support RZ/G2[MN] rev4 board
Date: Wed, 19 Aug 2020 17:36:22 +0100
Message-Id: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: x6430DLz5t4HkrHKNPqhjs2sx4520388AA=
Content-Type: multipart/mixed; boundary="5qKoVB9DJnmVkuQPfJr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855513;
 bh=UA0LNMsaqKfPt2mbJDKRBA6eeAKHE3OhSu1vO9HYcWo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Bq7n1ee21dah3pQ9K6ckC2kNe6oLhXUkCLp3QW7NRkQY8qsWLgLneKWAAGI5wQbtOZp
 nY2lWBrAeCU7Z0bqdj3aqfywpQjweEIJdE5W7YJEKTBXF5/ZyEaxYB5A31hII/7rodm8b
 i335kMZpoPK2ANjEPG1bKVUeHAD6XOgzQI8=

--5qKoVB9DJnmVkuQPfJr7

This patch series for supporting RZ/G2[MN] rev4 board to cip-4.19.y
kernel.

Biju Das (1):
  arm64: dts: renesas: r8a774a1: Remove audio port node

Lad Prabhakar (11):
  arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename
    HiHope RZ/G2M boards
  arm64: dts: renesas: r8a774b1-hihope-rzg2n[-ex]: Rename HiHope RZ/G2N
    boards
  arm64: dts: renesas: hihope-common: Separate out Rev.2.0 specific into
    hihope-rev2.dtsi file
  arm64: dts: renesas: Add HiHope RZ/G2M[N] Rev.3.0/4.0 specific into
    common file
  arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 main board support
  arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 sub board support
  arm64: dts: renesas: hihope-rzg2-ex: Separate out lvds specific nodes
    into common file
  arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 board with
    idk-1110wr display
  arm64: dts: renesas: Add HiHope RZ/G2N Rev.3.0/4.0 main board support
  arm64: dts: renesas: Add HiHope RZ/G2N Rev.3.0/4.0 sub board support
  arm64: dts: renesas: Add HiHope RZ/G2N Rev2.0/3.0/4.0 board with
    idk-1110wr display

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

-- 
2.17.1


--5qKoVB9DJnmVkuQPfJr7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5150): https://lists.cip-project.org/g/cip-dev/message=
/5150
Mute This Topic: https://lists.cip-project.org/mt/76290780/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5qKoVB9DJnmVkuQPfJr7--
