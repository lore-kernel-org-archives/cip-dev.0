Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F71D1D89A
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 18:29:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4285.1729016961770930652
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Oct 2024 11:29:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A4DB71C0095; Tue, 15 Oct 2024 20:29:18 +0200 (CEST)
Date: Tue, 15 Oct 2024 20:29:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: de0-nano-soc and gitlab mirroring Re: [cip-dev] lab-cip-renesas
 offline
Message-ID: <Zw60fumWWCKkct2t@duo.ucw.cz>
References: <17FCBD68B18E5703.22523@lists.cip-project.org>
 <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <Zw4uFWi6kWekKeCd@duo.ucw.cz>
 <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NbEION6yhQLnY90p"
Content-Disposition: inline
In-Reply-To: <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Oct 2024 18:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17041


--NbEION6yhQLnY90p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > All back online now :)
> >=20
> > I still see failures like this:
> >=20
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /jobs/8086067433
>=20
> lab-cip-renesas doesn't have any de0-nano-soc boards.
> We were seeing some issues with other labs, but now we have 2x de0-nano-s=
oc available from lab-cip-denx.
>

Sorry for hijacking the thread.

> > Other branches show test:arm_multi_v7_defconfig_de0nanosoc failures,
> > too.
>=20
> Interesting.
> The de0-nano-soc device seems to be working from a LAVA point of view, it=
's just the kernel that isn't loading.
>=20
> If you look at the job history [0] for one of the de0-nano-soc devices yo=
u can see that it's booting okay for various kernels, but not all of them.
> multi_v7_defconfig seemed to boot okay with 6.12.0-rc2_d3d155669 [1], but=
 not since 6.12.0-rc3_6485cf5ea [2].
>

Ok, let me take a look.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NbEION6yhQLnY90p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZw60fgAKCRAw5/Bqldv6
8vNHAJ9QfexKiwnO63CzVcPHNNXILiiCVgCeICB+z6Pe5hxQCa45TLRQ4bedxa4=
=x/kg
-----END PGP SIGNATURE-----

--NbEION6yhQLnY90p--

