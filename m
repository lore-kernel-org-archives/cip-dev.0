Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE51BC3ABA3
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 08:23:40 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6855.1746087810852888099
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 May 2025 01:23:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UDoV3EUa;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AB9E102A8CBB;
	Thu,  1 May 2025 10:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746087809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=m/hsmoOOm4kcPIFa/84ymmDgQWCte35WGFeVPvqMX1I=;
	b=UDoV3EUaPWfPjDv+QglvgAgfdixycsPyRp2B+xfyMW2VAPojgWD70HNpdDj+Qw1j6yAb8E
	886t+fqBRNSpPnoLf/TDogb+1MtU6rRXHi80G6HbCpSJ9jSoepNDGJk3KibT1AgIv39A8o
	vO8RRBppnR2xn0cnZOrHexqhdVO6Az4VR8kPU3Kb0P+/5o59HO2k9W13YMHeCs3w8c1iPK
	FUoabKviKyIf5MB7OksHAU88Ts5IYVo6HiMs9sCAnQUjNhtmHE7AdZtv0hlCYDXhdMFEmC
	kZroBvLQ9Se1FILZxBU9ykOPFjIwa+s7+CGH7Gn9jXs3WNMT9ZysckAbB3uDCA==
Date: Thu, 1 May 2025 10:23:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH v6.1.y-cip 0/4] Backport I2C
Message-ID: <aBMve/sYp1bhvWsg@duo.ucw.cz>
References: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="44oOap9uWUdVhgnb"
Content-Disposition: inline
In-Reply-To: <20250429134826.2429916-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 May 2025 08:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18745


--44oOap9uWUdVhgnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S I2C support to v6.1.y CIP.
>=20
> For v6.12 CIP none of these patches need to be backported. Everything is
> already integrated.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--44oOap9uWUdVhgnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBMvewAKCRAw5/Bqldv6
8iYFAKCUdncNnmExtx0dS9R+5fCSZ6apbACeOxfB1OvfqqQmnt5k6fnSuFY7HEE=
=8zh2
-----END PGP SIGNATURE-----

--44oOap9uWUdVhgnb--

