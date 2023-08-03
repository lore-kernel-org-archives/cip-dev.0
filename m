Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F1AC04A6A
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 11:38:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12424.1691062727074402572
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Aug 2023 04:38:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0F9341C0A9A; Thu,  3 Aug 2023 13:38:43 +0200 (CEST)
Date: Thu, 3 Aug 2023 13:38:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st43, 4.4-cip78
Message-ID: <ZMuRwsAhrpbgThbv@duo.ucw.cz>
References: <536431671.1986977.1690984726917@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7FT5xII0LRvLrGhu"
Content-Disposition: inline
In-Reply-To: <536431671.1986977.1690984726917@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 11:38:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12546


--7FT5xII0LRvLrGhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4-st43 and 4.4-cip78 rel=
eases that should be reviewed, and that can currently be found in https://g=
it.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3Dlinux-4.4=
=2Ey-st-rc
>=20
> Standard backports:

a | 9d7178c75 62fab3  + | IB/uverbs: Fix to consider event queue closing al=
so upon non-blocking mode
a | fb7bc3baa 8d8406 .+ | mmc: mvsdio: fix deferred probing
a | bd9621108 2174a0 o+ | sch_netem: acquire qdisc lock in netem_change()
>=20
> Then there's the Zenbleed workaround:

a | 17a67740c a32b0f o  | x86/microcode/AMD: Load late on both threads too
a | 5bb1e29bf None o  | x86/cpu/amd: Move the errata checking functionality=
 up

| cfef7bbf0 None o  | x86/cpu/amd: Add a Zenbleed fix

Return before break, non-english message. Nothing for you to fix, but
this is not my favourite patch.

> This stuff also has some dependencies that had to be picked up/backported:

 | 3f1f576a1 | x86/microcode: Propagate return value from updating functions

Misses upstream marking. Apparently
3f1f576a195aa266813cbd4ca70291deb61e0129 is the upstream
commit. Otherwise looks ok.

 | 1008c52c0 | x86/CPU: Add a microcode loader callback

Misses upstream marking, upstream is
1008c52c09dcb23d93f8e0ea83a6246265d2cce0. Otherwise ok.

a | 42ca8082e | x86/CPU: Check CPU feature bits after microcode upgrade

Misses upstream marking. Otherwise ok.

> It all looks relatively harmless to me, with the exception of "x86/microc=
ode: Propagate return value from updating functions", in which something co=
uld easily be missed.
>

Yep, looks good, with some missing upstream markings, as noted above.

Then there is

commit 679130ec67b34c822902926135425ce7f97f9960
    x86/microcode/amd: fix/remove incorrect function declarations
-extern int apply_microcode_amd(int cpu);

In ideal world, this should be part of "x86/microcode: Propagate
return value from updating functions" backport. Not sure if that's
worth fixing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7FT5xII0LRvLrGhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZMuRwgAKCRAw5/Bqldv6
8ivoAKDEed61lu/9r1LDJ3jAPqTF68uv2wCfREQYHyldDXgT80a4a9CrtFXfgOE=
=gUKQ
-----END PGP SIGNATURE-----

--7FT5xII0LRvLrGhu--

