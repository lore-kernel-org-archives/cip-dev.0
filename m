Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62791C43334
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 09:59:46 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.5498.1654250375808642930
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jun 2022 02:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E82051C0B9B; Fri,  3 Jun 2022 11:59:30 +0200 (CEST)
Date: Fri, 3 Jun 2022 11:59:30 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, theflamefire89@gmail.com
Subject: Re: [cip-dev] Reported 4.4.y-st issue from Flamefire #cip
Message-ID: <20220603095930.GA1095@duo.ucw.cz>
References: 
 <OSZPR01MB8124B28C7339EF7B39CA6F87B7CA9@OSZPR01MB8124.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: 
 <OSZPR01MB8124B28C7339EF7B39CA6F87B7CA9@OSZPR01MB8124.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 09:59:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8482


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> <quote>
> Hi guys. I can't make it to the meeting(s) but wanted to let you know tha=
t a recent commit to the 4.4.y-st branch (and potentially others) introduce=
d an annoying bug. Commit link: https://git.kernel.org/pub/scm/linux/kernel=
/git/cip/linux-cip.git/commit/sound/soc/soc-ops.c?h=3Dlinux-4.4.y-st&id=3D7=
a78bde1faa42e0057350378baf518a04b3bae58
>=20
> The issue is that "val > mc->platform_max" check which would need to be a=
djusted by "min" as done for a similar function in https://git.kernel.org/p=
ub/scm/linux/kernel/git/cip/linux-cip.git/commit/sound/soc/soc-ops.c?h=3Dli=
nux-4.4.y-st&id=3De41846dbe6f49d305c1a8fc229c5deabd66e3e24
>=20
> Others already did that (e.g. https://github.com/baunilla/android_kernel_=
xiaomi_rosy/commit/969b9d366c1e9564e173aea325ec544dcd7804ff) but I've only =
found a mention in the kernel ML but seemingly it wasn't resolved
>=20
> This bug (in short) e.g. leads to wired headsets being unusable on phones=
 using this kernel. Due to the to-eager check the mic volume isn't changed =
leading to a feedback loop.
> Hope that helps.

Thanks for the report.

Unfortunately, mainline seems to be different here. Looking at the
code, is min < 0 in your case?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYpnbggAKCRAw5/Bqldv6
8hpIAKCc6AgScOeMeunYhO7RctTBKyHvFACgqmh+Mbg4WV7hakbZNRo9IPQtlus=
=qfIK
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

