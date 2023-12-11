Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D5C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 09:53:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4997.1702288384780688576
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 01:53:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A077C1C0050; Mon, 11 Dec 2023 10:53:02 +0100 (CET)
Date: Mon, 11 Dec 2023 10:53:02 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Potential ext4 corruption in 6.1.64-cip10
Message-ID: <ZXbb/i1HuG0yPHXi@duo.ucw.cz>
References: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
 <ZXbYD5WHuRCKNGO3@duo.ucw.cz>
 <d3b38c88-34db-42cc-8f56-7fc8b4696fd0@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R7fZO+4q6Y5i+lHc"
Content-Disposition: inline
In-Reply-To: <d3b38c88-34db-42cc-8f56-7fc8b4696fd0@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 09:53:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14002


--R7fZO+4q6Y5i+lHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> seems also our 6.1 CIP kernel is affected by [1]. Please do not use in
> >> production if you have an ext4 filesystem!
> >=20
> > This seems to affect O_SYNC / O_DIRECT users, so I'm not sure how
> > common problem that is.
>=20
> Well, Debian considered it grave:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1057843

Aha, thanks for a hint, there are good pointers in that.

> > 6.1.66 is out, and there's matching 6.1.66-rt. I can release one or
> > both, but I don't see any confirmation that it is fixed in .66 or how.
> >=20
>=20
> I would expect some reference to this commit in 6.1.y as well, but there
> is nothing yet, no commit after dc4542861ec8dde92c3c8a5139bc412860aebe60
> touching that file.

So this should be fixed in

commit ea574927fc0bc343016ea3337fcfc0b3fb26fe08
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 1 16:58:54 2023 +0200

    iomap: update ki_pos a little later in iomap_dio_complete
   =20
    commit 936e114a245b6e38e0dbf706a67e7611fc993da1 upstream.
   =20
    Move the ki_pos update down a bit to prepare for a better common helper
    that invalidates pages based of an iocb.
   =20
    Link: https://lkml.kernel.org/r/20230601145904.1385409-3-hch@lst.de

=2E..and that's indeed in 6.1.66, and looks like it fixes relevant area.

I'll just do 6.1.66 based -cip and -cip-rt releases, unless someone
stops me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--R7fZO+4q6Y5i+lHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXbb/gAKCRAw5/Bqldv6
8sgUAKCq/7u1g11++T6N/toVn/e3C4TDKACcD3ANIZ1SZAv5wSWa+0QoeH8mRPg=
=Fswy
-----END PGP SIGNATURE-----

--R7fZO+4q6Y5i+lHc--

