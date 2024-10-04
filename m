Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A472FCFA775
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 12:45:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.21071.1728045920524749937
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 05:45:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EC66E1C0082; Fri,  4 Oct 2024 14:45:17 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:45:17 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/3] Add HDMI audio support**
Message-ID: <Zv/jXSbn3G3oEXSn@duo.ucw.cz>
References: <20241004102521.73256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZQCtclus094+rC4y"
Content-Disposition: inline
In-Reply-To: <20241004102521.73256-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 12:45:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17002


--ZQCtclus094+rC4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add HDMI audio support for RZ/{G2L,G2L,V2L} SMARC EVKs
> All the patches are cherry-picked from the mainline.

I see "**" in the subject, so I'd expect to see "**" and some kind of
note here, but no.

This adds documentation for "port" property for renesas,rz-ssi. I
assume the code is already in the .c file in 5.10, but was not
documented for some reason?

Series looks okay to me, I can apply it if it passes testing and there
are no other comments. This applies to 6.1, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZQCtclus094+rC4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZv/jXQAKCRAw5/Bqldv6
8tj3AJ0UnMDwx2hDsEhvLSGEADLrjy+sjQCcDQOnvfcrjckvZrN0lspRdraCHIc=
=XcKa
-----END PGP SIGNATURE-----

--ZQCtclus094+rC4y--

