Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E7ECCFA00
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 08:30:36 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.10717.1761899429068362682
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Oct 2025 01:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=T8iOmgnV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73E061020BDF9;
	Fri, 31 Oct 2025 09:30:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761899426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/SmEGWRdLWrrAcPvUjqmDYufEeCmIZeK++5plsRtpLE=;
	b=T8iOmgnVg1ajzzeU2Jylot66IhlQK+oLg35b+G6B26rG+XTtT8nuJjsbkPkk/XHllvilpS
	4EfOr3+iDnPdivX7s5/akQahc+zFR0VO7iTZWok9FgS2HqXV4DTRJzVF+WXIEMJt9R6B/1
	VhPmmS5lSzWSaK6TnwvsdXVfzQXiEv+PGqykZbbVR9YdMGkw3nvfIRT3Rg93Etb3MY/sLy
	MGYqwswjnC6VNlK3lR6lvUrj7cL0FRCC/ud+kwyeGVwAhhP1UIw+M7qK6McDfAsVlfXB3w
	IdBQLIpE2I5vyFUKXm9bsZIrOKpXRPZ+fTtGY4Za30VDjPNpF0t5gjzkUUef8A==
Date: Fri, 31 Oct 2025 09:30:21 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Message-ID: <aQRznZw+YUU6h42P@duo.ucw.cz>
References: <20251030084927.47505-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148188796779012A1BC1EDA69CDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4aGzMpeH1jSo+3h"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148188796779012A1BC1EDA69CDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Oct 2025 08:30:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20291


--G4aGzMpeH1jSo+3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series adds the ICU dts node for the Renesas RZ/V2H SoC, to the
> > linux-6.12.y-cip kernel.
> >=20
> > The ICU driver and its dependencies are already present in the 6.12.y-c=
ip
> > branch, having been included earlier as part of the RZ/G3E backporting =
work.

> > The patch was cherry-picked from mainline kernel.
>=20
> Thanks for your patch.
> Looks good to me. I can apply this patch if there are no other comments.

Both 6.1 and 6.12 versions look good to me, too.

Reviewed-by: Pavel Machek <pavel@denx.de>

									Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--G4aGzMpeH1jSo+3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQRznQAKCRAw5/Bqldv6
8veVAJ0QoMXBCm2Svrhhr83zzbQnnLD/pwCfY5ju5lnQyJ8mcid2JDxhoi6Llfc=
=Kqwt
-----END PGP SIGNATURE-----

--G4aGzMpeH1jSo+3h--

