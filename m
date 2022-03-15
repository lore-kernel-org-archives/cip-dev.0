Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC88C433F5
	for <webhook@archiver.kernel.org>; Tue, 15 Mar 2022 18:36:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.15085.1647369391830699064
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Mar 2022 11:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1E4B41C0BA6; Tue, 15 Mar 2022 19:36:27 +0100 (CET)
Date: Tue, 15 Mar 2022 19:36:26 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] 4.19.233-cip69-rt24 (-rt105)
Message-ID: <20220315183626.GA30901@duo.ucw.cz>
References: <20220314232121.GA23936@duo.ucw.cz>
 <2cd7693d-dc31-f378-e309-26b019404f2b@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <2cd7693d-dc31-f378-e309-26b019404f2b@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Mar 2022 18:36:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7741


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-03-15 07:13:31, Jan Kiszka wrote:
> On 15.03.22 00:21, Pavel Machek wrote:
> > Hi!
> >=20
> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.19.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.19.y-cip-rt-rebase
> >=20
> > And their content should be identical.
> >=20
> > Note that there are speculation-related bug fixes in the pipeline. If
> > you are using complex out-of-order CPUs for dealing with secret data
> > a) please stop, b) let us know and c) be sure to install next update.
> >=20
>=20
> You tagging script seem to have run amok with "v": ;)
>=20
>  * [new tag]                   vv4.19.233-cip69-rt24        -> vv4.19.233=
-cip69-rt24
>  * [new tag]                   vv4.19.233-cip69-rt24-rebase -> vv4.19.233=
-cip69-rt24-rebase

Thanks for report, and sorry about that. It should be fixed now.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYjDcqgAKCRAw5/Bqldv6
8v4EAJ0T8U20ZTyAItJ8nhrg6/EbwKL81wCeLf7hYi36lXdzvdmGzr35CeVJJr4=
=LtAq
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

