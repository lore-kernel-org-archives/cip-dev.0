Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F3C4332F
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 07:00:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.8404.1667545232324575138
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Nov 2022 00:00:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3CE3E1C09D8; Fri,  4 Nov 2022 08:00:29 +0100 (CET)
Date: Fri, 4 Nov 2022 08:00:28 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Message-ID: <20221104070028.GA20014@duo.ucw.cz>
References: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 07:00:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9923


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit d887087c896881715c1a82f1d4f71fbfe5344ffd upstream.
>=20
> RZ/G2L has separate channel specific IRQs for transmit and error
> interrupts. But the IRQ handler processes both channels, even if there
> no interrupt occurred on one of the channels.
>=20
> This patch fixes the issue by passing a channel specific context
> parameter instead of global one for the IRQ register and the IRQ
> handler, it just handles the channel which is triggered the
> interrupt.

Thank you, applied.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2S4jAAKCRAw5/Bqldv6
8uEIAJ4yiVokiI3yDGd4zgDf+kPZs8K11wCgim+00+lUz+V41bjMrW7gYrVQrcc=
=mu0D
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

