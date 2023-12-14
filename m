Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D25CC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 10:05:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.18780.1702548332016372364
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 02:05:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A16001C006F; Thu, 14 Dec 2023 11:05:29 +0100 (CET)
Date: Thu, 14 Dec 2023 11:05:29 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip] ASoC: dt-bindings: renesas,rz-ssi: Update
 interrupts and interrupt-names properties
Message-ID: <ZXrTaYOu97OV5DAt@duo.ucw.cz>
References: <20231213165248.975443-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYVPR01MB112457DC7499A4A5A8FBA5567928CA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zSYW8kFv/sPsOX0R"
Content-Disposition: inline
In-Reply-To: <TYVPR01MB112457DC7499A4A5A8FBA5567928CA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 10:05:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14094


--zSYW8kFv/sPsOX0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > commit 56a3840486ae22c42176828e25d4073712837bfd upstream.
> >=20
> > From R01UH0914EJ0120 Rev.1.20 HW manual, for full duplex channels
> > (SSI0/1/3) dma_rt interrupt has now being marked as reserved and simila=
rly for
> > half duplex channel (SSI2) dma_rx and dma_tx interrupts have now being
> > marked as reserved (this applies to RZ/G2L and alike SoC's). This patch
> > updates the binding doc to match the same.
> >=20
> > While at it also updated the example node.
=2E..
> Looks good to me.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Looks good to me, too. It only touches documentation, so I added your
Reviewed-by and applied the patch.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zSYW8kFv/sPsOX0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXrTaQAKCRAw5/Bqldv6
8iouAJ4ivQ7fWJHDLpdOT0Zl8E8ZfVv4nwCgrEytkUXl0qAaTUDHl52hzghocVQ=
=ZxxE
-----END PGP SIGNATURE-----

--zSYW8kFv/sPsOX0R--

