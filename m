Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08062C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 10:39:43 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4764.1639737581571064969
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 02:39:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2B0C11C0B76; Fri, 17 Dec 2021 11:39:38 +0100 (CET)
Date: Fri, 17 Dec 2021 11:39:37 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de,
	biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for
 Renesas RZ/G2L SoC + SMARC EVK
Message-ID: <20211217103937.GD17079@amd>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB6252CF2DE6303073564AA03292789@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: 
 <TYAPR01MB6252CF2DE6303073564AA03292789@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 10:39:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7173


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds the following:
> > * Serial support
> > * Clock support
> > * Initial RZ/G2L SoC DTSI
> >   - CPU
> >   - CPG
> >   - GIC
> > * Initial device tree for RZ/G2L SMARC EVK
> >   - memory
> >   - External input clock
> >   - SCIF
> >
> > All the patches have been cherry picked from 5.16-rc5. For testing purp=
ose
> > MR [0] can be used.
>=20
> I will check this series, and I am also checking the build.
>
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/4316631=
40

Thank you. I checked the series and only found some details (some of
them were fixed later in the series). I believe we can apply it.

Reviewed-by: Pavel Machek <pavel@denx.de>
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmG8aOkACgkQMOfwapXb+vJ+iQCfRhJJcdxsu1Q94QbH3VWR84uK
5c4AnisS4iQ9Mw4IfpHdUYRC+X9ux1XG
=nXig
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--

