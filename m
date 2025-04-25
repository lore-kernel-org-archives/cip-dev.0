Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B79BC369D1
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:24:58 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3666.1745576693373125411
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 03:24:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hDUtFqdr;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECF98102A4BFC;
	Fri, 25 Apr 2025 12:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745576691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ux/W9rXBoby+sZO0469rDgdXZuWU8/o6yLgC+L4NEBc=;
	b=hDUtFqdr1BcYdgfc16jotRFAO3nEyutzZ6zpbZ+Jsz5+PZlzfINaJ7SLaK4yxthX3GZKoC
	V3z1aIM3p+4GInFdrL64xNd/6vnhe/qJ5l+jrwnsu8yQ3ECIKMavnpEUnMkg//uuUCEtKN
	Cy8W20lrRUY8xl7lfDlncANS0KRXNyjn8s1woAwPow7HuzD1qNs45RTrGoSgMvlEYrA+dt
	0XUUTbFJOfYORcGluULl3UCf1qulERH75XcRQV2we71mgPVq5HkNueLe8JP3LUDobTI17w
	xz9tluNbK3iDTdKumIvXu9wOj8p36EYIB0Ty0XWObSkzXCNVSx8hFAA5aAYqLw==
Date: Fri, 25 Apr 2025 12:24:44 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/15] i2c: riic: miscellaneous code
 cleanup and improvements
Message-ID: <aAti7FKVCHFN4Tdu@duo.ucw.cz>
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0A8gXXhTZT5XWzv"
Content-Disposition: inline
In-Reply-To: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 10:24:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18620


--f0A8gXXhTZT5XWzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series includes miscellaneous code cleanup and improvements
> to RIIC driver used by Renesas RZ SoCs. Below are the features which
> are backported:
> - Runtime PM support
> - Suspend/Resume support
> - Fast Mode Plus
>=20
> Note,
> - Patches 9-15 have been recently posted to 6.12-cip
> - All the patches have been cherry-picked from v6.15-rc3.

Thank you, these look good. I can apply them if they pass testing and
there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--f0A8gXXhTZT5XWzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAti7AAKCRAw5/Bqldv6
8vlkAJ9sAVqUQEXW0NYYSJVBBS36+7IvUQCeL7Djyg9zNFbNzpgUsSq8xlcJPdg=
=AFF2
-----END PGP SIGNATURE-----

--f0A8gXXhTZT5XWzv--

