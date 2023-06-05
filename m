Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0458AC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 08:57:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2903.1685955444657540782
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 01:57:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D92E41C0ABB; Mon,  5 Jun 2023 10:57:21 +0200 (CEST)
Date: Mon, 5 Jun 2023 10:57:21 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	fabrizio.castro.jz@renesas.com
Subject: Re: [PATCH 5.10.y-cip 00/19] Add RZ/V2M USB3.1 support
Message-ID: <ZH2jcbHORI312PPo@duo.ucw.cz>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420A65185CE82FEC2EEC4B9924DA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8CDXHWLabjib7MWo"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB9420A65185CE82FEC2EEC4B9924DA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 08:57:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11778


--8CDXHWLabjib7MWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, looks good to me.
> I can apply them, if there are no other comments and issues.
>   Test CI: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipeline=
s/889078814
>=20
> Reviewed-by Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review and testing. I applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8CDXHWLabjib7MWo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH2jcQAKCRAw5/Bqldv6
8nFTAJ9EBptzV3dbvGQbYW7qHIxIzqC4MwCgiDKn2o82EEtYWFwEfbFXdhOgLlk=
=j1KI
-----END PGP SIGNATURE-----

--8CDXHWLabjib7MWo--

