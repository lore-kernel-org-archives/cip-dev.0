Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C161CC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 14:29:03 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.9115.1659536940210010240
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 07:29:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0D5E01C0004; Wed,  3 Aug 2022 16:28:57 +0200 (CEST)
Date: Wed, 3 Aug 2022 16:28:56 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 4.4-cip] Revert "ASoC: rt5645: Fix errorenous cleanup
 order"
Message-ID: <20220803142856.GA7175@duo.ucw.cz>
References: <ed1abfd6-0bd2-c266-53bb-bfb17f51eaf4@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <ed1abfd6-0bd2-c266-53bb-bfb17f51eaf4@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 14:29:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9049


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This reverts commit 32ab6f27ac8264da14ff3b8dc17da1013fb5560f.
>=20
> Misplaced in 4.4 because there is no btn_check_timer in this kernel.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Thank you. Let me apply this to -st-rc, it should get merged to -st
after testing and should appear in next 4.4-cip.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuqGKAAKCRAw5/Bqldv6
8hVoAJ9WfDu1ryPE3tjQcgmLO325+yxh+QCfcymdU8jx5ZC8iEsa7OOa+kA3a+o=
=w/s3
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

