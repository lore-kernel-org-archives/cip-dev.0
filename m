Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C09D637AE
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 20:50:00 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4268.1765918199045506752
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 12:49:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fkTRX1ol;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC9531009213E;
	Tue, 16 Dec 2025 21:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765918193; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EjV4MUiUUtdp3nS/WHPFNpStClh0LDS1b+DK3bLunTU=;
	b=fkTRX1olHMVkR+2/YM7JGmuMVI+4FS5g7R9NolqPf9eK7xefINx8FJC2wspEvGEGdOVjr+
	5Kj8uglSy0YkuaILFa1Uv9S8MTZCzO58xI8RSJUB1Chy1j5Dy5TDBxNxiPpuJkWNmfUWfw
	CpdPlAM/G+8apO4W2pHTxLwoqiGdvBO61APHXDrjRqceWVEJb/gixrqncznHjJlxwcWVI5
	0BFwxg6aL2lbAbi9beSn8dRZUSSneXZCy6qikxKUV5eVW9O9OmbtPPhEiGvNUAWmR7zMGn
	7MMKtsy/G9+8alffCfNhyOo6cjJ/SsGGh+TnxyatY8jgeA9HGa+lq3r+5BJVzg==
Date: Tue, 16 Dec 2025 21:49:50 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/3] Add suspend/resume support for RZ/G3E
 ethernet
Message-ID: <aUHF7tDLEEf5v1oJ@duo.ucw.cz>
References: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7V4q62bmrxCwCFoJ"
Content-Disposition: inline
In-Reply-To: <20251214120122.3784-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 20:50:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21091


--7V4q62bmrxCwCFoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> This patch series adds support for suspend/resume support for RZ/G3E
> ethernet

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7V4q62bmrxCwCFoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaUHF7gAKCRAw5/Bqldv6
8mJuAJ0X7GIG/VaGKzXtacsNzIHjPoYuPACgmCYrfOtS6xj1GQO/oTIFsKEY2Wk=
=bGyD
-----END PGP SIGNATURE-----

--7V4q62bmrxCwCFoJ--

