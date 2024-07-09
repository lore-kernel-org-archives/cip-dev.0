Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C22C2BD09
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 10:26:59 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9741.1720520817752245210
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jul 2024 03:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4E2C21C009C; Tue,  9 Jul 2024 12:26:55 +0200 (CEST)
Date: Tue, 9 Jul 2024 12:26:54 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: paul.barker.ct@bp.renesas.com, pavel@denx.de,
	prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX
 checksum handling
Message-ID: <Zo0QbuzfgIl4U2pn@duo.ucw.cz>
References: <20240708183832.33446-1-paul.barker.ct@bp.renesas.com>
 <20240708183832.33446-2-paul.barker.ct@bp.renesas.com>
 <OS0PR01MB63885D918692983EA4B890AD92DB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uj26nQmEjzGyTehJ"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB63885D918692983EA4B890AD92DB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jul 2024 10:26:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16439


--uj26nQmEjzGyTehJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
> > wrong skb for a packet which spans multiple descriptors. To fix this, u=
se the
> > correct skb.
> >=20
> > Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >=20
> > [backported to 6.1.y-cip]
> > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > ---
> >  drivers/net/ethernet/renesas/ravb_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> Thanks for this patch. Looks good to me.
> I can apppy this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Looks good to me, too.

Reviewed-by: Pavel Machek <pavel@denx.de>

As an aside, 6.1.96-cip release would be useful to me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uj26nQmEjzGyTehJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZo0QbgAKCRAw5/Bqldv6
8v6rAJoD6wgKdEadXvwc6kJNmEis+o45PwCdEfq5hT5eRwnzJeuciPpH6hWPEXE=
=AlaR
-----END PGP SIGNATURE-----

--uj26nQmEjzGyTehJ--

