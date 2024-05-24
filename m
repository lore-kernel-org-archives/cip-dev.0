Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B310C25B7D
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 18:58:41 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.3295.1716577117354233489
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 11:58:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8F4DA1C0094; Fri, 24 May 2024 20:58:34 +0200 (CEST)
Date: Fri, 24 May 2024 20:58:34 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>, jan.kiszka@siemens.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: CVE-2017-5715 on simatic-ipc227e -- was Re: [cip-dev] gitlab
 -stable-rc: mirroring not working?
Message-ID: <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iEsM36rYuqmCuLrQ"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 18:58:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15948


--iEsM36rYuqmCuLrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'd like to test 6.1.91-rc2 and friends, but gitlab still have -rc1:
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /tree/linux-6.1.y
> >=20
> > Can someone take a look what is wrong?
> >=20
> > Plus, it would be cool to start testing 6.9-stable branch.
>=20
> Support is now added:
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
?ref=3Dlinux-6.9.y
>=20
> The initial test results look okay, apart from one thing...
>=20
> It looks like we're seeing a new failure (VULN) for one of the spectre-me=
ltdown checker tests - CVE-2017-5715.
> We're only seeing this failure on the x86 simatic-ipc227e platform.
> Failed test case log:
> https://lava.ciplatform.org/scheduler/job/1138103#L998
>=20
> I checked v6.8.11-rc1 and this test case passes:
> https://lava.ciplatform.org/scheduler/job/1137807#L976
>=20
> Perhaps this isn't a massive issue, but I thought I should report it anyw=
ay.
> For now I won't mark this as a "known issue".

Hmm. That's Spectre v2. Can you get

cat /sys/devices/system/cpu/vulnerabilities/spectre_v2

=66rom both working and failing versions? Are we using latest version of
spectre-meltdown checker?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iEsM36rYuqmCuLrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZlDjWgAKCRAw5/Bqldv6
8oVTAJ47TyZ32R4xzi8hxSykrGOeVbStRgCeI+JVYmUi0FK8iNf97tOTmMKu6z4=
=vK8n
-----END PGP SIGNATURE-----

--iEsM36rYuqmCuLrQ--

