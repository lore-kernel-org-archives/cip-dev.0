Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB90C433EF
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 09:58:15 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.3545.1639994293354820306
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 01:58:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 663A81C0B9B; Mon, 20 Dec 2021 10:58:07 +0100 (CET)
Date: Mon, 20 Dec 2021 10:58:06 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33] 5.10.86-rc1
 review
Message-ID: <20211220095806.GA21780@amd>
References: <20211215172024.787958154@linuxfoundation.org>
 <20211215183223.GB10909@duo.ucw.cz>
 <Ybo2lbHVaASDyAcC@kroah.com>
 <OSZPR01MB6877AA8378F08F7071E53A58B77B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB6877AA8378F08F7071E53A58B77B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 09:58:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7196


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I believe we should not change build requirements in the middle of
> > > stable series.
> > >
> > > To our testing team: 5.10.85 introduced new requirements for the
> > > build. gmp.h is now required in our configs, and maybe something else.
>=20
> Hi Pavel, sorry for missing this email before now.
> I can look into supporting this, depending on the answers to the comments=
 below...

Thank you.

> > > Easiest fix might be to add
> > >
> > > # CONFIG_GCC_PLUGINS is not set
> > >
> > > to our configs. Alternatively I know which patch to revert.
> > >
> > > But I believe -stable should be the one doing the revert, as the patch
> > > does not fix serious bug and introduces problem. Faster compile is
> > > nice but let mainline have those kind of changes.
> >=20
> > But that commit is needed to get gcc11 plugins to work with the 5.10.y
> > kernel tree.  So either we "break" it for old and obsolete gcc versions
> > (i.e. gcc7), or newer supported versions break.
>=20
> Well this leads us to an interesting point.
> At the moment we use GCC v8.1.0 for building all of our kernel trees (cip=
 & stable).
> What does CIP want to do mid/long term? Keep upgrading the version we use=
? Or try and support a specific version of GCC for 10 years?
> If the former, when do we want to upgrade?
> If the latter, which version?
>=20

We should do what our users are likely to do... they want stable
kernel, and will not update toolchain in middle of product
maintainance. [Updating toolchain when starting new product with given
-cip kernel is more likely].

I believe that means we should stick to specific version, but I'm not
sure what version it is. We support Debian distro, likely gcc version
=66rom that distro would be a good option? Perhaps we should ask on TSC
meeting tommorow?

5.10 kernel was released in Dec 2020. At that time, gcc 8 and 9 were
maintained, and gcc 10 was new (https://gcc.gnu.org/releases.html).

To get some results for -stable testing, easiest options might be to
disable gcc plugin support in Kconfig.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHAU64ACgkQMOfwapXb+vJSCACfd8WyI1hJHg2APop27LkZwCaR
RU0AnjfD1RLvhArTGW1gAC4K+9Jik48g
=s9Ta
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

