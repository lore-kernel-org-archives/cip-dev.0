Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6437DC7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 20:52:21 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1532.1685998331293413763
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 13:52:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 904901C0AB3; Mon,  5 Jun 2023 22:52:07 +0200 (CEST)
Date: Mon, 5 Jun 2023 22:52:07 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] v6.1-cip: state of forward porting
Message-ID: <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="12HW1z6WSibN/VdQ"
Content-Disposition: inline
In-Reply-To: <1765D9D28CD911EB.3349@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 20:52:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11824


--12HW1z6WSibN/VdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I moved 6.1-cip branch a bit forward. Below is a summary of patches
> that needed forward-porting according to my scripts. Let me know if I
> missed some.

To be clear, by "forward-porting", I mean "making sure all patches
specific to 5.10-cip are in 6.1-cip, too".

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--12HW1z6WSibN/VdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZH5K9wAKCRAw5/Bqldv6
8jnrAJsHWpZ4vuV8L53OjeHrID7Y/vyGYQCfVh+A0thwNVMC0yGaizmYgLLXftg=
=hc4R
-----END PGP SIGNATURE-----

--12HW1z6WSibN/VdQ--

