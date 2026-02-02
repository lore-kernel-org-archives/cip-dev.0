Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C3E73173
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:47:38 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52803.1770040056671834331
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:47:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ZNp9+JO5;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1424210AE1B;
	Mon,  2 Feb 2026 14:47:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770040054;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mbsA5Ojp/AHQgscSXdI7f+G0XlIpQ4Uq054gNsKe8us=;
	b=ZNp9+JO5+s9fVr1J5GkyGd8QXbYb1LaiWWbPThX/HwWyeSH3d1wpIA6XkGOfzzmjF2rr8e
	0hzOqDJr931Y2A+00RG31e3L5fSHGNSpdOfUlMQ4oiIGoPmhyZNruvgVKkwatJi05b8e7Q
	1MR20rUwk5hNZP83MKB4b3Og0bkwDx0J3C/jd+SBRmcmbAly8VDEle+ssw4mR4k/2ma1xP
	iIviJXi4XFbUr2akacwHHFIbvgTSFkqMH2Ubhogl6xX/mnxjnZ2xX12AVL8kqBxNOqUfjj
	qkjJFCiXhyo0mQq3DpbEdyJkVcti0Th49NE/kFXUPbgVwSo2VtbSDepbW3TdoA==
Date: Mon, 2 Feb 2026 14:47:30 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	pavel@nabladev.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/12] Add RZ/V2H TSU support
Message-ID: <aYCq8svlOlLM1vG/@duo.ucw.cz>
References: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
 <188F257CFA6798FA.3408700@lists.cip-project.org>
 <TY7PR01MB1481890FD64F4010BD75C12D4CD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Og4DkQlFRusMCUgc"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481890FD64F4010BD75C12D4CD9AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21812


--Og4DkQlFRusMCUgc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I reviewed this series, looks good to me.
> > I can applyt this patch if there are no other comments and no issues on=
 CI.
> >=20
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2293422=
851
> >=20
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> >=20
>=20
> Applied and pushed, thanks.

Thank you. I had some minor comments but I was moving towards applying
this.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--Og4DkQlFRusMCUgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYCq8gAKCRAw5/Bqldv6
8k/8AKCEGL8bJwkQRfTnpQu0/sjwaxc0nQCfZP7N0knEbI8lBlXjZqEeYYyb4E0=
=7hOP
-----END PGP SIGNATURE-----

--Og4DkQlFRusMCUgc--

