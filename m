Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15CBC47DAF
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 22:08:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.6630.1705615691490391437
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 14:08:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 271A71C0071; Thu, 18 Jan 2024 23:08:08 +0100 (CET)
Date: Thu, 18 Jan 2024 23:08:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/30] Add support for Renesas
 RZ/Five RISC-V SoC
Message-ID: <ZamhR4rfpyS7kg5W@duo.ucw.cz>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZZ2jpzco/6c5h/UP@duo.ucw.cz>
 <17A967822D2F9532.647@lists.cip-project.org>
 <OSZPR01MB6816679E5D1F28D931D8C412B7712@OSZPR01MB6816.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c5+usuDPwAqFCWPV"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB6816679E5D1F28D931D8C412B7712@OSZPR01MB6816.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 22:08:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14410


--c5+usuDPwAqFCWPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Currently we're building using CIP's risc-v qemu config.
> > We'll get test support sorted soon once we have a suitable rootfs.
> >=20
> > I've done the initial work to build for RZ/Five, see pipeline [0], job =
[1].
> > This is using a Renesas specific defconfig [2] that I've created a MR [=
3] for.
> >=20
> > [0]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
la
> > b.com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> > %2Fpipelines%2F1135494600&data=3D05%7C02%7Cchris.paterson2%40ren
> > esas.com%7C02bb7316971e4deb9f8f08dc12ea7a30%7C53d82571da1947
> > e49cb4625a166a4a2a%7C0%7C0%7C638406045475126479%7CUnknown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DJ%2B4VRFeq8aHpn
> > Vk%2FEjuoxohV3i0iCJfM3g%2FeAfBAyb0%3D&reserved=3D0

Okay, not sure who damaged the link, but I'm not clicking these.

> > I've also done the preparation for boot testing RZ/Five, however before=
 we
> > can use it I need to put an RZ/Five board
> > into the CIP LAVA infrastructure. I've got a board on order for this, so
> > hopefully we can get this sorted next week.
> > I'll keep you updated.
>=20
> I've now added an RZ/Five platform to lab-cip-renesas so we can test.
> Tested with a simple boot test based on CIP 6.1 + this patch series:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1142975670

Ok, green tick, that's good I think.

> Please let me know if there is anything else you need.
>=20
> I'll integrate test support into our "official" pipeline once the kernel =
config MR is merged.
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1142975670

Thanks for testing. It looks like I'll simply push the RFC I had in my
tree.

Geronimo!
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--c5+usuDPwAqFCWPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZamhRwAKCRAw5/Bqldv6
8kWgAKC35D8Rr5ntVsocsD0uMzAWcGKFFgCguFoyd9hKIVBfTaS49070yhzmEm8=
=8aHg
-----END PGP SIGNATURE-----

--c5+usuDPwAqFCWPV--

