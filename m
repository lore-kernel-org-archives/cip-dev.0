Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A641C433F5
	for <webhook@archiver.kernel.org>; Mon, 27 Sep 2021 10:17:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.29204.1632737854766208098
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 03:17:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D015B1C0B7A; Mon, 27 Sep 2021 12:17:29 +0200 (CEST)
Date: Mon, 27 Sep 2021 12:17:28 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: uli@fpond.eu
Subject: Re: [cip-dev] Coordinating stable reviews
Message-ID: <20210927101728.GB11971@amd>
References: <16A8A6032C9B7813.26412@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <16A8A6032C9B7813.26412@lists.cip-project.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Sep 2021 10:17:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6752


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We don't really need commit messages for this. Actually, we don't
> really need to keep history, either. It would be good if system could
> be controlled from command line for easy scripting.
>=20
> Any ideas what kind of service could be used for this?

I guess I should mention alternate possibilities. We could try to
somehow "hash" the commits... Perhaps I'd review all the patches where
upstream sha begins with 0-6. But patches in -stable often come in
series that depend on each other, and it would be good if single
person reviewed them.

We could also split based on first character of subject, or on
subsystem patch touches. I guess that would have other disadvantages
like uneven distribution of work when big ammount of btrfs fixes hits
the -stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFRmjgACgkQMOfwapXb+vIHYACdFtvruKiKg/Mz7PcHXhiuC/Ik
mQAAn1rdG4RtRio9uBNiW79vdbe2h4ha
=3dgf
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

