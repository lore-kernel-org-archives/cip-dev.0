Return-Path: <SRS0=E1JK=CL=lists.cip-project.org=bounce+64572+5384+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2321FC433E2
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 19:20:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718862083B
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cjDCT4YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718862083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5384+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Dw7cYY4521723xWo28UAL7XJ; Wed, 02 Sep 2020 12:20:22 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16234.1599074420283800241
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 12:20:21 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5C8011C0B78; Wed,  2 Sep 2020 21:20:15 +0200 (CEST)
Date: Wed, 2 Sep 2020 21:20:12 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add RZ/G1H WDT/Thermal/CMT/MSIOF support
Message-ID: <20200902192012.GA25230@duo.ucw.cz>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fnITSIKFGi3fYeTzOpChqSByx4520388AA=
Content-Type: multipart/mixed; boundary="StHZJh7eXD43CSAPfiHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599074422;
 bh=XRqSMVHPkkZOK9CiY8U0hef2ZR7CN8l8Ej0OvyTVEzw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cjDCT4YK186Xx7eSheGtMybbyt4eyiPo2y0IT8ympnPHl/9wvjkA1FnwGQKVCPSr3r+
 cyuteuOc9rBCeaOypnk3B2XCOvMU0QeTgXiHIHjby46OofHaS2bShxhXALAuvAKk3JPNI
 H56CjO88eSAZmc3PQVTvlRWQxepypzBmtHw=

--StHZJh7eXD43CSAPfiHr
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add WDT/Thermal/CMT/MSIOF support for iWave RZ/G1H boar=
d based on
> r8a7742 SoC to 4.4.y-cip kernel. All patches in this series except last o=
ne
> are cherry-picked from mainline. The patch "ARM: dts: r8a7742-iwg21d-q7: =
Enable cmt0"
> is ported from linux next.

The patches look good to me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0/wbAAKCRAw5/Bqldv6
8qyMAJ9SBBO0Xrq5+782rj3xuu9hnE83wwCfeuC45WbIkjTcQ+ocCR9ZuWeT1dU=
=HM8i
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--StHZJh7eXD43CSAPfiHr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5384): https://lists.cip-project.org/g/cip-dev/message=
/5384
Mute This Topic: https://lists.cip-project.org/mt/76585838/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--StHZJh7eXD43CSAPfiHr--
