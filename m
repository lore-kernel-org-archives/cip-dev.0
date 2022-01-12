Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1764BC433EF
	for <webhook@archiver.kernel.org>; Wed, 12 Jan 2022 09:45:07 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.21053.1641980705158619336
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jan 2022 01:45:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D8BD51C0B76; Wed, 12 Jan 2022 10:45:00 +0100 (CET)
Date: Wed, 12 Jan 2022 10:45:00 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/61] Add Ethernet support to RZ/G2L
Message-ID: <20220112094459.GA3700@amd>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <16C93537A1693B9B.28404@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <16C93537A1693B9B.28404@lists.cip-project.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Jan 2022 09:45:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7450


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds Ethernet support to RZ/G2L SoC and enables ETH s=
upport
> > on RZ/G2L SMARC EVK.
> >=20
> > All the patches have been cherry picked from v5.16-rc8.
>=20
> Ok, this is really taking nice small steps. Thanks :-). You could help
> reviewers a bit more by saying "no functional changes" when there are
> none, but this was already very good job.
>=20
> I could not find anything significant; each time issue was found it
> was fixed in subsequent patches.
>=20
> If there are no other comments, I'll run the tests and apply the
> series.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHeoxsACgkQMOfwapXb+vJdIgCgsYTvjSZPqxshGcFP+0POC6mC
gJEAoLW9uYze9nojfRdL4SMGTzUie863
=9C/G
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

