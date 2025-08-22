Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72801CA0EFC
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 11:37:43 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.7777.1755862653371947095
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 04:37:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=L5dUKipP;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89B57103F5654;
	Fri, 22 Aug 2025 13:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755862651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BUlc5jqEUZ0qJFf+sfnRxiM/RW8/NSGjKr7UeIMw2Js=;
	b=L5dUKipPj6js/l2FVXzjAnVxMfLBhdRmutyXHlqIIPoAzejbUsseBhqbIrIDryTam9F4bh
	eGd0VyH0crrdYDIfpfFHqIV1tQE7rlHv11ezwg6Ti0n/eK9Py7yn/iMtCY1HDEur0EJ6ow
	HVKHU+v/DD1d6choAcY68OB/QHgZotzp7cAibtubYME+jHqAAF077xoNVqjLdFmHKw0rt9
	gffJ5YrOMzDcz5oZoiH8DChuwd/FoPZ3fCyTsshljFYpIQuoqXw7IZVaOOtgFUYCgWBLpa
	EZ7lAHXpl5VwZllnmQKwiqYb2nMEgYiEfbtNng8Z4mfmGmsMTaaiwyWypV7xIA==
Date: Fri, 22 Aug 2025 13:37:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/55] Add support for CRU/CSI2 on Renesas
 RZ/G3E
Message-ID: <aKhWdzCUHPWzUnNB@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BV7Ogi1lzllmg6Zt"
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 11:37:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19949


--BV7Ogi1lzllmg6Zt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Dear All,
>=20
> This series adds support for the CRU/CSI2 IPs found in the Renesas RZ/G3E=
 in
> Linux 6.1.y-cip. These IPs are similar to those found on the RZ/V2H(P).
>=20
> In addition, it includes patches required to successfully run the v4l2-co=
mpliance
> tests against the OV5645 and the entire media pipeline.
>=20
> This series has been tested on the following hardware setup:
>=20
> OV5645 image sensor (Coral Camera) =E2=86=92 RZ/G3E CSI2 =E2=86=92 RZ/G3E=
 CRU
>=20
> The series applies on top of [1].
>=20
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D993368&st=
ate=3D%2A&archive=3Dboth

I'm okay with Renesas patches, but perhaps we can skip ov5645 changes?

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--BV7Ogi1lzllmg6Zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKhWdwAKCRAw5/Bqldv6
8nJfAKC9Wx3yKTgwf+Hj5dyTmPE2uhnBVACfdlINTWbaBwObIBlWmxZIQW254P4=
=c1gF
-----END PGP SIGNATURE-----

--BV7Ogi1lzllmg6Zt--

