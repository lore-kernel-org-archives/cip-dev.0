Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B968C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 07:50:21 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3319.1746604211665327605
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 May 2025 00:50:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=E+1CQaN6;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD6431048C2F0;
	Wed,  7 May 2025 09:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746604209; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mZQW3xsww7uUV70c7Tb+W186s80fLY8tDnEz3lJCiM8=;
	b=E+1CQaN62BGS7usH7P+6x6kd8/oCribdHFvNcionjVry+hapMNnWnXsVKx7HT5zP/kPLyo
	e/Tq43ajm0YYMgEA1DyZbpTvc3SPvscCu9OJ6vgirIjL6uc7zgdo2FVFNppru/hHolTWGt
	bY378cBsL9/M+uweynD397oO0w1qFv0NybT2RtAnSSyma+1Dja+OKoKmtK9S3HJxlMAYep
	0OBM0uIl7ZnEd6MvWo1sar1spRJBrNmQrjZZcSI4j6SSNAELMAGywC2VOtp8AFOXvYsEKF
	Piq1pKoKZvFk6Ga5EztfcxXQRlkFjeBTKFoy1rMYpWcw5QT+HW475tZaWNR6ow==
Date: Wed, 7 May 2025 09:50:04 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.19-st4, 4.19-cip120
Message-ID: <aBsQrIFPDLWwXXCd@duo.ucw.cz>
References: <781807518.215591.1746544433020@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5GfRWIQelSXH6Gjf"
Content-Disposition: inline
In-Reply-To: <781807518.215591.1746544433020@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 07:50:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18773


--5GfRWIQelSXH6Gjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the single manual backport for the upcoming 4.19 kernel release. A=
s always it can be found in https://git.kernel.org/pub/scm/linux/kernel/git=
/cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
> b6c3d672c55ea net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer=
 on destroy
>=20
> Thanks for having a look!

Thank you, patch looks ok to me.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5GfRWIQelSXH6Gjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBsQrAAKCRAw5/Bqldv6
8kXBAJ9WpxoL3vXHOoaed/Mx5qMcagAx+QCfUb9mizm96A/L72cQTR3C9NlV4B8=
=ZWsR
-----END PGP SIGNATURE-----

--5GfRWIQelSXH6Gjf--

