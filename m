Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98C1CD1288
	for <webhook@archiver.kernel.org>; Wed,  3 Apr 2024 07:42:35 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5786.1712130147534762426
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Apr 2024 00:42:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7502A1C007F; Wed,  3 Apr 2024 09:42:23 +0200 (CEST)
Date: Wed, 3 Apr 2024 09:42:23 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: pavel@denx.de
Subject: Re: [cip-dev] 6.1.83, 5.10.214 would be useful -cip releases
Message-ID: <Zg0IX1mq8NAwgsdF@duo.ucw.cz>
References: <ZghRfAeHw2i7rdjF@duo.ucw.cz>
 <OS0PR01MB6388AD7CE5977F6F9494AD05923F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <OS0PR01MB638805BF298A7488E54CFB32923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MST2gW5h33m85zPS"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB638805BF298A7488E54CFB32923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Apr 2024 07:42:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15484


--MST2gW5h33m85zPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > 6.1 and 5.10 -rts should be released soon... There is 6.1.83-rt and
> > > 5.10.214-rt is in the pipeline, if we could get matching -cip
> > > releases, that would be useful for me.
>=20
> 5.10.213-rt is correct?
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/co=
mmit/?h=3Dv5.10-rt

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

v5.10.214-rt106-rc1	linux-stable-rt-5.10.214-rt106-rc1.tar.gz  	Luis Claudi=
o R. Goncalves	7 days
v5.10.213-rt105-rebase	linux-stable-rt-5.10.213-rt105-rebase.tar.gz  	Luis =
Claudio R. Goncalves	9 days
v5.10.213-rt105	linux-stable-rt-5.10.213-rt105.tar.gz  	Luis Claudio R. Gon=
calves	9 days

5.10.213 will do the trick, yes. I expected v5.10.214-rt106-rc1 to be
released by now, I still expect it to be released "soon" so that would
work, too.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MST2gW5h33m85zPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg0IXgAKCRAw5/Bqldv6
8l15AKCG9VfFU+OdWw+y+SmNt360VdUheQCeNtSjuQH8vOmt4qmCH7h0Sf7jvxM=
=+h81
-----END PGP SIGNATURE-----

--MST2gW5h33m85zPS--

