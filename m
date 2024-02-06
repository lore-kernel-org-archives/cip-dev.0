Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F812C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 10:53:45 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.18798.1707216820912126835
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 02:53:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 552511C0081; Tue,  6 Feb 2024 11:53:39 +0100 (CET)
Date: Tue, 6 Feb 2024 11:53:38 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19.y-cip] ravb: remove undocumented counter processing
Message-ID: <ZcIPsg+MWKdYHsyV@duo.ucw.cz>
References: <20240205090303.34620-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u16AAgP+aJRLWcrp"
Content-Disposition: inline
In-Reply-To: <20240205090303.34620-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 10:53:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14782


--u16AAgP+aJRLWcrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Simon Horman <horms+renesas@verge.net.au>
>=20
> commit 009a470365b37106bbd66f1e1a53bc6c3c0072bc upstream.
>=20
> This patch removes the use of the undocumented counter registers
> CDCR, LCCR, CERCR, CEECR.
>=20
> Offsets used for undocumented registers are considered reserved and
> should not be written to. After some internal investigation with Renesas
> it remains unclear why this driver accesses these fields but regardless of
> what the historical reasons are the current code is considered incorrect.
>=20
> Based on work by Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

This looks okay to me, I can apply it to 4.4/4.19 if it passes testing and =
if
there are no other comments.

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--u16AAgP+aJRLWcrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcIPsgAKCRAw5/Bqldv6
8tk0AJ9CKExfvd+6yYFPO8CFJxrjW3LJ4ACfS/4a7SeJzDsnpasy5os0Q8GPgfU=
=zRxx
-----END PGP SIGNATURE-----

--u16AAgP+aJRLWcrp--

