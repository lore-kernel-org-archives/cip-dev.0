Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37ABD0D171
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 20:21:28 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15940.1767817287543959628
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 12:21:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YIZP52st;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C373D10D56C;
	Wed,  7 Jan 2026 21:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767817285;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dRhU6QpiVQXfAWGAX+7Pq+H+CKRZrARpj0BekkM7bAk=;
	b=YIZP52stw5NuiLJUKD3gWJjuv5tFE1PN8DmhREKboe5w+Gylwoxol95Zq/23bkjDqHnGxg
	StcRUc7bl/FnEuCJ825/f4HQNBMv76YTtGjhy1X+Je4bTmosuzcP/Hdqg+U7WmZULRLLnZ
	WWEvZWONWFTWpKgZHzUYisV2kXeykfXk4zHX4J6knyHiwTvtwNBgVyYcyUT9v+lpiQtIpy
	msMFOC+fK9YpNYqwm9PP23k4jDEc3zX0XUcnEJ3a1iEnnyrgOYku+JLTyN1Abmm+eZwWPi
	gzrua56QknTHxwaa4+q7wnz5rg14x23Kc4/sAZiVhMGGRzi6qE5ulHw7EtX+2Q==
Date: Wed, 7 Jan 2026 21:21:20 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/8] net: stmmac: Fix EEE-related issues
Message-ID: <aV7AQHWo1Un9oZsN@duo.ucw.cz>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818BF6479C1E24FEC289040CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0TO3miN30U8d24kW"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818BF6479C1E24FEC289040CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 20:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21419


--0TO3miN30U8d24kW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The following EEE-related issues were observed on the Renesas RZ/V2H and
> > RZ/V2N platforms with 6.12-cip:
>=20
> Looks OK to me.
> I can apply this if testing is no issue and there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Looks ok to me too, and it passed testing, so I applied it added your
reviewed-by tag and pushed out. I plan to do the same with 6.1 version
next.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--0TO3miN30U8d24kW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV7AQAAKCRAw5/Bqldv6
8onOAJ4sltHfAdNN+wgG72DjqB3oW0eoowCgrDOIgqPSa1jSbPv5KWgp9gJaFFc=
=g+Xb
-----END PGP SIGNATURE-----

--0TO3miN30U8d24kW--

