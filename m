Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14399C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 10:38:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4754.1639737511890193434
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 02:38:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5E93B1C0B76; Fri, 17 Dec 2021 11:38:28 +0100 (CET)
Date: Fri, 17 Dec 2021 11:38:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 23/24] clk: renesas: rzg2l: Add support to
 handle coupled clocks
Message-ID: <20211217103827.GC17079@amd>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211216125446.15451-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <20211216125446.15451-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 10:38:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7172


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> commit 32897e6fff196a5de4981030466ae391dfe56c7b upstream.
>=20
> The AXI and CHI clocks use the same register bit for controlling clock
> output. Add a new clock type for coupled clocks, which sets the
> CPG_CLKON_ETH.CLK[01]_ON bit when at least one clock is enabled, and
> clears the bit only when both clocks are disabled.

So the clocks can have different properties (frequency?), but can only
be enabled/disabled together? So  we can't handle them as one clock?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmG8aKMACgkQMOfwapXb+vIXyQCcCOUv2qRIl5oolP3FmNrFkQ+/
l88AmgPQCpSdnpeUXNWgOgBwu/MshAF4
=/TkK
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--

