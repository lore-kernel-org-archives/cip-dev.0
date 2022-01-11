Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF5C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Jan 2022 09:02:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4629.1641891743336708989
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jan 2022 01:02:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7BBF21C0B80; Tue, 11 Jan 2022 10:02:19 +0100 (CET)
Date: Tue, 11 Jan 2022 10:02:18 +0100
From: Pavel Machek <pavel@denx.de>
To: Amy Fong <Amy_Fong@mentor.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <20220111090218.GA22781@amd>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat>
 <20220110175519.GA3396@duo.ucw.cz>
 <20220110180635.GB3396@duo.ucw.cz>
 <YdyTRgrErYXoQzti@cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <YdyTRgrErYXoQzti@cat>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jan 2022 09:02:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7442


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > > Ok, let me take a look at the series. But... could you provide some
> > > kind of explanation of what these are and why you want them in -cip?
> > >=20
> > > These are not usual "hardware enablement" patches...
> >=20
> > 0/6 email was not part of the thread, so I missed it in the first
> > look.
> >=20
> > I see it fixes sysbot report.
> >=20
> > Do you have special loads where you are hitting these netfilter
> > problems? Are similar fixes needed in 4.4 / 5.10?
> > Would it make sense to get it fixed in -stable kernels?
>=20
> We haven't been able to reproduce the issue but apparently it's being rep=
roduced=20
> periodically.
>=20
> The offending patch doesn't appear in linux-4.4.y-cip
> linux-5.10.y-cip has the fix already.
>=20
> Both patches were introduced in 5.5.0-rc5

Thank you for answers.

Is there reason not to submit it to stable? You are describing it is
as a bugfix, and Greg takes those. [Advantages are a) community
review, b) less patches to maintain for us, c) bug fixed for everyone,
not just us].

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHdR5oACgkQMOfwapXb+vJ14gCeNXvoGCUyW/m9XGTfXCXf9fob
gNoAn0cJ2xdqVz0cR2PBpelfGrW3+4mU
=fC/T
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

