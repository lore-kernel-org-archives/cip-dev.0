Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D0DC4332F
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 09:38:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9318.1671183503829238118
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Dec 2022 01:38:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2E5101C09F4; Fri, 16 Dec 2022 10:38:21 +0100 (CET)
Date: Fri, 16 Dec 2022 10:38:20 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [QUERY]: Avoiding tree wide changes
Message-ID: <Y5w8jFcx0DAISYoV@duo.ucw.cz>
References: <OSZPR01MB70195709C33AE5168BFDEFE1AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+3KdRhiQqhloZOcB"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB70195709C33AE5168BFDEFE1AAE19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 09:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10236


--+3KdRhiQqhloZOcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We intend to backport IRQC driver [0] to 5.10-cip but for doing this
>we need the patch [1] ("of/platform: Drop static setup of IRQ
>resource from DT core"). The problem with applying patch [1] means we
>will have to do tree wide changes to replace platform_get_resource()
>-> platform_get_irq().

We would not want to do that.

But... your platforms are already coverted to platform_get_irq() in
5.10, no?

> What are your thoughts on how we can get the IRQC driver to 5.10-cip?
>=20
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dnext-20221215&id=3D3fed09559cd8be79568d368ce02bf7f2d56259b6
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dnext-20221215&id=3Da1a2b7125e1079cfcc13a116aa3af3df2f9e002b
>

Is the change in [0] really neccessary for your driver to work, no? I
wonder what happens if you revert it on new kernel. Is there chance it
will not do harm on platforms with "platform_get_resource() ->
platform_get_irq()" conversion done?

Do you have an example of "platform_get_resource() -> platform_get_irq()" c=
hanges?

One way forward could be introducing of_device_alloc_new and using it
on your platform, but finding other solutions would be better.

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+3KdRhiQqhloZOcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY5w8jAAKCRAw5/Bqldv6
8h4kAKCYTkbum8u+rxlolnfXmVY/azJfUgCfUJ/IxNmI7VDFkvDMdfrZHLvWsHI=
=idqh
-----END PGP SIGNATURE-----

--+3KdRhiQqhloZOcB--

