Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C38C433EF
	for <webhook@archiver.kernel.org>; Thu, 28 Apr 2022 17:35:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.605.1651167330611303301
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Apr 2022 10:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 76AE71C0B8E; Thu, 28 Apr 2022 19:35:26 +0200 (CEST)
Date: Thu, 28 Apr 2022 19:35:25 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
	alice.ferrazzi@miraclelinux.com
Cc: nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] 4.19 oopses on socfpga
Message-ID: <20220428173525.GA32556@duo.ucw.cz>
References: <16EA1EC5D11818E9.15794@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <16EA1EC5D11818E9.15794@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Apr 2022 17:35:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8228


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> There's oops during boot on socfpga:
>=20
> 4.19.240-cip72-00010-g0ffbb4b1066 -- https://lava.ciplatform.org/schedule=
r/job/669893
> 4.19.240-rc1-g5e5c9d690926 -- https://lava.ciplatform.org/scheduler/job/6=
69259
>=20
> This commit may be relevant:
>=20
> commit e2423aa174e6c3e9805e96db778245ba73cdd88c
>     net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-l=
ink
>     [ Upstream commit a6aaa00324240967272b451bfa772547bd576ee6 ]
>=20
> Let me investigate a bit more.

I tried to do some testing, but it fails on two targets:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/522211501

And failed test says:

https://lava.ciplatform.org/scheduler/job/670508

ob error: Invalid job data: ["Resource unavailable at
'https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-testin=
g/linux-cip/zImage_siemens_de0-nano-soc_defconfig_4.19.239_e5e741fbf/arm/si=
emens_de0-nano-soc_defconfig/dtb/socfpga_cyclone5_de0_nano_soc.dtb'
(404)"]

which sounds like a test problem, not kernel problem.

Any ideas?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYmrQXQAKCRAw5/Bqldv6
8paFAJ9ifYb/ZF9x65R1I0gwA4C3b4ZoRQCgquxMgfeeXly9HFKLLTcAvhitGyA=
=1nCZ
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

