Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F0C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 07:46:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.74738.1720424770735786803
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 00:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 788361C009C; Mon,  8 Jul 2024 09:46:07 +0200 (CEST)
Date: Mon, 8 Jul 2024 09:46:07 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 6.1.y-cip 0/9] Add IRQC support for RZ/Five SoC
Message-ID: <ZouZPxvfkh7R5Edl@duo.ucw.cz>
References: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS3PR01MB6391ADDA9FCEE7A5B46567E592DA2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0p5tPBy+JsZBSTV8"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6391ADDA9FCEE7A5B46567E592DA2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 07:46:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16427


--0p5tPBy+JsZBSTV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, I don' t have any comment.
> I can apppy this series, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thanks for review, I applied the series with your reviewed-by tag.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0p5tPBy+JsZBSTV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZouZPwAKCRAw5/Bqldv6
8vfFAKCuYKtJWTbJTqkHqMFC+xFMDrc4ygCgihPmpdylSM8kQ/E5RDHacqP5D1o=
=Ytu0
-----END PGP SIGNATURE-----

--0p5tPBy+JsZBSTV8--

