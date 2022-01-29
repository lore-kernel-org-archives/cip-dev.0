Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D58C433F5
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 21:05:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.11252.1643490334463948340
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 Jan 2022 13:05:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 001731C0B77; Sat, 29 Jan 2022 22:05:31 +0100 (CET)
Date: Sat, 29 Jan 2022 22:05:31 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Message-ID: <20220129210531.GB27693@duo.ucw.cz>
References: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220126221249.GB26019@duo.ucw.cz>
 <OSZPR01MB7019A1C696667D60C8F1EBF2AA209@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB7019A1C696667D60C8F1EBF2AA209@OSZPR01MB7019.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 29 Jan 2022 21:05:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7518


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Are they? I see fail label being unused in our 5.10 tree (but mainline =
uses it and I don't think we
> > need it removed).
> >=20
> It is being used [0].

Yes, sorry, I was looking at wrong tree.

Best regards,
											Pavel
										=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYfWsGwAKCRAw5/Bqldv6
8v8yAJ9AvEJwitSVFJ8C2lIFsS1b83skjgCggRhsiUVj8SwvGvo0wzsNt/meCGA=
=qbC9
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

