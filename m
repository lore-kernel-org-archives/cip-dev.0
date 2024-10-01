Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C4CEACCE
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 14:37:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.83478.1727793464576026563
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Oct 2024 07:37:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1EAFC1C00AB; Tue,  1 Oct 2024 16:37:41 +0200 (CEST)
Date: Tue, 1 Oct 2024 16:37:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] Backporting query
Message-ID: <ZvwJNIjpEi+fjjCQ@duo.ucw.cz>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-9-biju.das.jz@bp.renesas.com>
 <ZtWJqOdRxkBkUb9y@duo.ucw.cz>
 <TY3PR01MB1134657025BC48D12CE94672186922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346B7F9FA61A31E428C25EA86772@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDy9rGaVpQpjRoE6"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346B7F9FA61A31E428C25EA86772@TY3PR01MB11346.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Oct 2024 14:37:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16945


--oDy9rGaVpQpjRoE6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> RZ/G2UL display support patches are now in linux-rc1 [1].
>=20
> Previously as CIP policy, we are not allowed to backport anything from li=
nux next, but
> ok to backport from rc series.
>=20
> Is any CIP policy is changed for back porting recently? If yes, for new f=
eature/device support
> patches like [1], without any fixes tag or dependencies, how many rc cycl=
es we need to wait?
>

I don't believe we have strict/firm policies here. It really depends
on many factors. If you have 3-line patch that enables driver on newer
hardware, we can likely take it directly. If you have 3000-line beast
that includes changes to mm/slab.c, well, that's different :-).

If the patches are very simple, very safe and well tested, feel free
to send them directly.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oDy9rGaVpQpjRoE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvwJNAAKCRAw5/Bqldv6
8pqdAJ4sTczWTGFuNU5eU1BR8zRCDaGc9wCgpm+kUEjv2Fb4yZ98LrNJ9IaAvl4=
=IOc4
-----END PGP SIGNATURE-----

--oDy9rGaVpQpjRoE6--

