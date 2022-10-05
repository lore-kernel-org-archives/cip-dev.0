Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795E5C433FE
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 18:21:57 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1633.1664994116233990878
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Oct 2022 11:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 654B41C0017; Wed,  5 Oct 2022 20:21:52 +0200 (CEST)
Date: Wed, 5 Oct 2022 20:21:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>, Pavel Machek <pavel@denx.de>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: Preparing isar-cip-core for RZ/Five
Message-ID: <20221005182151.GA16437@duo.ucw.cz>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 18:21:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9651


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > But due to the weird U-Boot setup, I had to add some hacks, rather than
> > a proper boot process.
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/rzfive
>=20
> Test by flashing the image to an SD-Card switching to SD booting on the=
=20
> module.
>=20
> Maybe we can find a better solution for the boot procedure before moving=
=20
> forward with this.
>=20
> Anyway, now we have a real distribution on this board. Pavel, can you=20
> re-check what you observed, if those issues persist with Debian?

I believe I was running Debian; two versions and Ubuntu, IIRC :-).

Can you check if ldconfig and gcc work for you? That were the
roadblocks I was hitting. If they do, I'll be interested in details of
your setup.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYz3LPwAKCRAw5/Bqldv6
8grcAKCHy5u+u9tS1fOUHGQzn+GNlrW5gwCfTLaS1KLzyp1v7yv0O+V/UfSdk2k=
=u7yi
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

