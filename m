Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B276DC27C75
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 11:48:02 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6573.1718279275285418136
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 04:47:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C89181C0082; Thu, 13 Jun 2024 13:47:53 +0200 (CEST)
Date: Thu, 13 Jun 2024 13:47:53 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/7] Fix USBHS pipe configuration
Message-ID: <ZmrcaQ/nWQ6FESEO@duo.ucw.cz>
References: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nrC+l2Ow9qgFk5h8"
Content-Disposition: inline
In-Reply-To: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 11:48:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16219


--nrC+l2Ow9qgFk5h8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The USBHS IP found on RZ/G2L SoCs only has 10 pipe buffers compared to 16
> pipe buffers on RZ/A2M.
>=20
> Fix the USBHS Pipe configuration
>=20
> All the patches are cherry-picked from the mainline.

This looks ok to me. I can apply it if there are no other comments and
if it passes testing.

Best regards,
     								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nrC+l2Ow9qgFk5h8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrcaQAKCRAw5/Bqldv6
8nKwAJ94S4A8aPHcd5PWLBwR+Ei3ogV3vACgi+wbS7s+NvxDgS4PbyNYzhOrCso=
=UpoQ
-----END PGP SIGNATURE-----

--nrC+l2Ow9qgFk5h8--

