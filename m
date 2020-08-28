Return-Path: <SRS0=blCp=CG=lists.cip-project.org=bounce+64572+5326+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5175AC433E2
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:59:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F3B20838
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pUU5QGOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F3B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5326+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0secYY4521723xn4lc5z4MnL; Fri, 28 Aug 2020 11:59:44 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1667.1598641182708713285
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 11:59:43 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7D45D1C0B76; Fri, 28 Aug 2020 20:59:40 +0200 (CEST)
Date: Fri, 28 Aug 2020 20:59:25 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Message-ID: <20200828185925.GD10270@duo.ucw.cz>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZYnAoAC6Lq73jxrMmKHeolZDx4520388AA=
Content-Type: multipart/mixed; boundary="1EC5IiCIXCNLpMdilu02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598641184;
 bh=zhGcZMnb+HJbcXphnNtRmtNj3tNLEoy2t/ZUFwDZOtc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pUU5QGOEGQMw+wPwiCUiqR9hXwCDM2v8cJuSlXUOxN5cpiVKSxmKnr7PphFYH9RFBne
 eH/ax1QHtFkoZ622mGz4+4R/3HHfYwDvDtrulDzd8cr4ZOarixbUT64aLDuIOm5vJWcwV
 QWlk2fgiu6uV60G08ZltJfy6qVXe0j+w5vU=

--1EC5IiCIXCNLpMdilu02
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline

--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add RZ/G2H SoC support for [H]SCIF/SDHI/I2C/RWDT/MSIOF on 4.19.y-cip kern=
el.
>=20
> All the patches in this series are cherry-piced from ML, except [1] which=
 is=20
> a new patch similar to the workdone for other similar SoC's

Thanks, applied and pushed out.

Best regards,
									Pavel
								=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0lUDQAKCRAw5/Bqldv6
8i80AKC0aMBqU0XPSHbdiM4LVD4NpSsSOwCcD+/7aTZeEf5ERl5rrjX1wqRTSLc=
=mveb
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--

--1EC5IiCIXCNLpMdilu02
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5326): https://lists.cip-project.org/g/cip-dev/message=
/5326
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--1EC5IiCIXCNLpMdilu02--
