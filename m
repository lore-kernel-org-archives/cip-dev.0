Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B48CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 20:33:04 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.515.1760646782067961560
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 13:33:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=JbmptqXe;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CA3410398814;
	Thu, 16 Oct 2025 22:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1760646780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eU9d3BZP616476H60wF4UNoxA16A1xlXP6LZAtsZZS4=;
	b=JbmptqXevpDAV9MXuIW4MIrHQ3PR11ecvH9SDVH6zUNe3HnjtCjDXQT4Lh0AG2M1BeQW2O
	t+p+ozVDi0aP6TQtEP5y32uVkKZWveWiMw123IS8bhNZ96OVrdi/AT5LvfmHGSyZF59Cvi
	XaC8Q9pjtMA5FR0NlmByFgd3S/eOAq/I2BoCrTa0W/ET/TLDKonCLpJlhadpN6W9eKAAm+
	mlhPGBl7lcAlugj4avRup/NwJZpJnWgD1ma20RzAo1C+nwUnxPhPtzo0wTN7yoQZQo7cXc
	WtVTiu6Y4dhKet1Jx8LD9k1yFm3GjsPxTq2HUETW/cw0oEdEV8ytTZgYq3s6EQ==
Date: Thu, 16 Oct 2025 22:32:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.19-st9, 4.19-cip125
Message-ID: <aPFWd8k23alj1kpo@duo.ucw.cz>
References: <1987113732.203443.1760622835166@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="79Qe3+f8bXvXdo8U"
Content-Disposition: inline
In-Reply-To: <1987113732.203443.1760622835166@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 20:33:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20192


--79Qe3+f8bXvXdo8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
a > c7b36525554e4 mm/khugepaged: fix ->anon_vma race
a > b91c123855d13 i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error =
path

Patches look ok to me, thank you!

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--79Qe3+f8bXvXdo8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPFWdwAKCRAw5/Bqldv6
8rpOAJ99ktsAFPW+xSNDva8lLxIDSLUwdACcCnGei3n3QsJ86+AAGjjt5YA7zqw=
=icnw
-----END PGP SIGNATURE-----

--79Qe3+f8bXvXdo8U--

