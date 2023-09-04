Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20FCC71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 10:42:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.44950.1693824130522667827
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Sep 2023 03:42:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D28A41C000B; Mon,  4 Sep 2023 12:42:07 +0200 (CEST)
Date: Mon, 4 Sep 2023 12:42:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st44 4.4-cip79
Message-ID: <ZPW0f+krBDyMzAQB@duo.ucw.cz>
References: <1583308606.3395319.1693820637255@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Aw4vrO1mdVh5SpeC"
Content-Disposition: inline
In-Reply-To: <1583308606.3395319.1693820637255@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Sep 2023 10:42:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12940


--Aw4vrO1mdVh5SpeC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st44 and 4.4-cip79 rel=
eases that should be reviewed, and that can currently be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc
>=20
> My apologies, this is a big one. Thankfully, most backports are of the tr=
ivial sort:

Ok, let me take a look.

> There is also "x86/msr-index: remove duplicate definition of
>MSR_AMD64_DE_CFG", a minor fixup for a warning introduced in the
>previous release.

I'd do this one the other way around -- keep the definition in the
header, as we have in mainline, and remove the one in the .c file.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Aw4vrO1mdVh5SpeC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPW0fwAKCRAw5/Bqldv6
8qT6AJ44AWr2oeriuOLFBpz8rxLCb/ZO+ACeOtZqfwKzpSPjfDJJuqb7DulTuF4=
=ToCB
-----END PGP SIGNATURE-----

--Aw4vrO1mdVh5SpeC--

