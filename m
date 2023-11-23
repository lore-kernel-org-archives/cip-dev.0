Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E197C61DF7
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:42:57 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.89700.1700743368874883921
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 04:42:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 253AF1C0073; Thu, 23 Nov 2023 13:42:47 +0100 (CET)
Date: Thu, 23 Nov 2023 13:42:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Message-ID: <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
 <ZV5uUFDxiawBZf30@duo.ucw.cz>
 <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MR2i35wdmgLx6zGW"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 12:42:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13667


--MR2i35wdmgLx6zGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series aims to add versa3 clk generator support on
> > > RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> > >
> > > All the patches are cherry-picked from the mainline.
> >=20
> > > Maxime Ripard (1):
> > >   clk: Add trace events for rate requests
> > >
> > > Stephen Boyd (2):
> > >   clk: Move no reparent case into a separate function
> > >   clk: Introduce clk_hw_determine_rate_no_reparent()
> >=20
> > I believe we don't need these in 5.10. I'm okay with this version as-is,
> > but if someone says these are intrusive and we should use 5.10 versions
> > that don't need these, I'll understand that.
>=20
> I have n't added this to 5.10 as it needs lot of code restructuring.
> Please let me know if I need to port this.

I was trying to say the opposite thing: maybe version without the perf
stuff (similar to your 5.10 code) would be better for 6.1, too?

I got build failures in testing:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1082601870

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MR2i35wdmgLx6zGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZV9IxgAKCRAw5/Bqldv6
8t+PAKCPjyNAADMC1hcLzZZKOfZID82zcgCdEZJktJCpoQm8KmLqn9ydk1V7Quo=
=YxH5
-----END PGP SIGNATURE-----

--MR2i35wdmgLx6zGW--

