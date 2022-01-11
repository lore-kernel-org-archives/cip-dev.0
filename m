Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B118C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Jan 2022 11:54:12 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6098.1641902050921850875
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jan 2022 03:54:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3DEF31C0B81; Tue, 11 Jan 2022 12:54:06 +0100 (CET)
Date: Tue, 11 Jan 2022 12:54:05 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/61] Add Ethernet support to RZ/G2L
Message-ID: <20220111115405.GE11620@duo.ucw.cz>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jan 2022 11:54:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7444


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds Ethernet support to RZ/G2L SoC and enables ETH sup=
port
> on RZ/G2L SMARC EVK.
>=20
> All the patches have been cherry picked from v5.16-rc8.

Ok, this is really taking nice small steps. Thanks :-). You could help
reviewers a bit more by saying "no functional changes" when there are
none, but this was already very good job.

I could not find anything significant; each time issue was found it
was fixed in subsequent patches.

If there are no other comments, I'll run the tests and apply the
series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYd1v3QAKCRAw5/Bqldv6
8uk/AJ0ZYcFdwrbVKbhXLfqcXt9Lm4hTgQCfarbNQMEgpNbuKJeMHi2DcF66Zoc=
=PTGy
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--

