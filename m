Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B6C4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 10:21:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.17289.1707301309739201549
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 02:21:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1C6271C0076; Wed,  7 Feb 2024 11:21:47 +0100 (CET)
Date: Wed, 7 Feb 2024 11:21:46 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: pavel@denx.de, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com, horms+renesas@verge.net.au,
	davem@davemloft.net
Subject: Re: [PATCH 4.19.y-cip] ravb: remove undocumented counter processing
Message-ID: <ZcNZughHMqPLI0rG@duo.ucw.cz>
References: <20240205090303.34620-1-biju.das.jz@bp.renesas.com>
 <ZcIPsg+MWKdYHsyV@duo.ucw.cz>
 <OS0PR01MB63888FB4C816903105B925E792462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jwZ4dOVs3szbadn0"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63888FB4C816903105B925E792462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 10:21:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14875


--jwZ4dOVs3szbadn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit 009a470365b37106bbd66f1e1a53bc6c3c0072bc upstream.
> > >
> > > This patch removes the use of the undocumented counter registers CDCR,
> > > LCCR, CERCR, CEECR.
> > >
> > > Offsets used for undocumented registers are considered reserved and
> > > should not be written to. After some internal investigation with
> > > Renesas it remains unclear why this driver accesses these fields but
> > > regardless of what the historical reasons are the current code is con=
sidered
> > incorrect.
> > >
> > > Based on work by Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > >
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >=20
> > This looks okay to me, I can apply it to 4.4/4.19 if it passes testing =
and if there
> > are no other comments.
>=20
> Looks good to me, too.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you. 4.4/4.19 passed testing, so I'm pushing both trees.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jwZ4dOVs3szbadn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcNZugAKCRAw5/Bqldv6
8i4nAJ40GFXHA0DYx4IB3+MhatdO7K3wNACeK4eLPeRrZgDRjCg2RIU3W9Gfcs4=
=v9w5
-----END PGP SIGNATURE-----

--jwZ4dOVs3szbadn0--

