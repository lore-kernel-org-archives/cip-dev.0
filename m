Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EE0C43334
	for <webhook@archiver.kernel.org>; Wed, 29 Jun 2022 18:27:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.15386.1656527271157124252
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jun 2022 11:27:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2F47C1C0BCB; Wed, 29 Jun 2022 20:27:48 +0200 (CEST)
Date: Wed, 29 Jun 2022 20:27:47 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y] cred_getsecid hook
Message-ID: <20220629182747.GA8730@duo.ucw.cz>
References: <20220622120633.GB7458@duo.ucw.cz>
 <7356.1656517471464294518@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <7356.1656517471464294518@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jun 2022 18:27:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8627


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > If CVE-2021-39686 is important to you, right way forward would be to
> > backport neccessary changes to 4.9, first. We would rather not have
> > changes in 4.4-st that are not present in 4.9.X.
>=20
> Hi Pavel, thanks for the reply.
>=20
> I'm happy to contribute what I have back to 4.9. Can you give me some gui=
dance on how I'd do that?
> I've never contributed to the upstream kernel before but am confident in =
C/C++ and git and am maintaining an Android kernel fork.
> In this case it should be pretty straight forward. All commits are from G=
oogles android-mainline branch, backported where required, but mostly uncha=
nged and I have the upstream discussions from the kernel ML for reference. =
If you are curious the 38 commits I want to backport to reduce the divergen=
ce and then fix that CVE can be found at https://github.com/Flamefire/andro=
id_kernel_sony_msm8998/pull/24.
>=20
> It will likely be easy enough to port them to the 4.9 branch but I'd need=
 to know how to have them applied and/or who to contact.
>

It should be enough to send them to stable@ mailing list, as described
in Documentation/process/stable-kernel-rules.rst . Greg KH (see
maintainers) is the person to talk to, but mailing list should be enough.

> PS: Greetings from Dresden, Germany

Nice to meet you, Alex!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYryZowAKCRAw5/Bqldv6
8sBVAJ4+Mu2wHU2/xr5OIcyeDpRiYsmM0gCeM3JtTs2g9O72q93wo258Q9snxDc=
=TDoo
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

