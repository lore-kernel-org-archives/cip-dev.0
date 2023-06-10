Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CDC7EE2E
	for <webhook@archiver.kernel.org>; Sat, 10 Jun 2023 09:07:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.14419.1686388051319707615
 for <cip-dev@lists.cip-project.org>;
 Sat, 10 Jun 2023 02:07:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 427B01C0CA9; Sat, 10 Jun 2023 11:07:28 +0200 (CEST)
Date: Sat, 10 Jun 2023 11:07:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] v6.1-cip: state of forward porting
Message-ID: <ZIQ9Txvw5Nh9ffEg@duo.ucw.cz>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
 <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
 <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3qT+FkoMDLO/7y9l"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Jun 2023 09:07:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11960


--3qT+FkoMDLO/7y9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I moved 6.1-cip branch a bit forward. Below is a summary of patches
> > > that needed forward-porting according to my scripts. Let me know if I
> > > missed some.
> >=20
> > To be clear, by "forward-porting", I mean "making sure all patches
> > specific to 5.10-cip are in 6.1-cip, too".
>=20
> I confirm, It looks good to me. Maybe this patch as well[1], which I miss=
ed in 5.10.y-cip.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dnext-20230606&id=3Dbf58a687db232e738105244e34a85d21f5e2598d
>

That's just documentation, I'll let you submitt it to 5.10 and 6.1 if
really needed.

> For CAN I guess we need to backport below patches for 6.1 aswell.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3D34f9e9852b90d7be6eef9=
5874500d1fb1b768e7f
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3D841645cfc773cdd0a21c6=
7357c53845f2e972f91
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3Da1dcfbdfd1d0f7843f381=
f7c58cc87a0f8c11f6c
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3Dea6ff7792203ad6786bda=
75d1dabf33311c8bef4
>=20

Thanks for hints, I think I got it right. I would not mind someone
double-checking the tree.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3qT+FkoMDLO/7y9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIQ9TwAKCRAw5/Bqldv6
8hn7AJdAmDORJIko1YG5snooS1u1xrgWAKCnIQ9cQJH9a57zwK4B5LQfz6DN0Q==
=AFwL
-----END PGP SIGNATURE-----

--3qT+FkoMDLO/7y9l--

