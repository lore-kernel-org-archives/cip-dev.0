Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC7C47BF4
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 13:55:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90264.1767707729290279549
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 05:55:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=T5+Q5yad;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A36DD108851;
	Tue,  6 Jan 2026 14:55:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767707726;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wxXV1RXgvRspNQ+Yw2xvm/D7K8skx3oBUo/YvD7SG2Y=;
	b=T5+Q5yadfgCBNTYj81MS3c6kj8DCA50yhYNrqdldrIx4+GHTfPgrBsfShhdkKdRCocOikp
	V1jhDpmvOwzXjI+ib97ZcbJA17RVfiIQ7HLfGCQ7ohRzrPYSwBdEGnQdzSijf7oizKTvK0
	zz12Bk0KlW47WWouAD8HKNpEp/yWJkg0kTCV8cxawLo0CEQG1lyepfQL1vQkYqKsaJ3zzD
	3gTqQFieDTvb4VrOEbaXeB2G/Bh0d5nRJuhFDDiGW+kV9Rl7cb0DTKJaX3ix9fvbBqy1UK
	mJNC5/IX2c3tQezca8S8+LbBnmIVC5PxvHoT0iI1kg7ff/QvmddWWiohv2t3cA==
Date: Tue, 6 Jan 2026 14:55:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12-y.cip 0/5] Add RZ/V2N GBETH support
Message-ID: <aV0USkliTHiOGWx7@duo.ucw.cz>
References: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N0XIqatjr/rtj1R4"
Content-Disposition: inline
In-Reply-To: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 13:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21382


--N0XIqatjr/rtj1R4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds GBETH support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--N0XIqatjr/rtj1R4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV0USgAKCRAw5/Bqldv6
8nUCAJ95mMOAFfmHflP+O6Tw6h67pO4TrACdHeSqc7F4PuMe/796XaMzrNsEO30=
=W6aC
-----END PGP SIGNATURE-----

--N0XIqatjr/rtj1R4--

