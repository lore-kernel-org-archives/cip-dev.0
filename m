Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA8CF45C4
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 18:28:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39839.1768242524814613835
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jan 2026 10:28:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=gWfhvcPD;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8B421038C120;
	Mon, 12 Jan 2026 19:28:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1768242522; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sz2GRKnpHHVdX7k2KYdGygQL9KBvmpBos6MCcGHrVQA=;
	b=gWfhvcPDnevhFef6NZFOLDWmwajpjLNbubd2rJNHNW4DsJDIWh2dfJes4u+VnbLV8zcYaE
	2hTg3I+SLaXIB15AZe6lKDMlAoNb8rDrq0XLt5jyyFCm4siZvjDOGXhISw1ijQKhiPQLge
	u6ftmRoBM/e2H/w0yPJmTX7xgQwMAR/Pkw0cwpnf6yxiTLLXrhmIql1+hm/q/kKJZDbU7w
	HuX8Kb6kQ7YtLrIBsHvxEiCj+djlN2DOMxaSHNqJIt3Vz1wzI4E3gFJnaL4gYXVCxnh9IT
	bsg/M4nV/AT1X5IUTCMf7fF6YS+067tBbfCWsuV4JvuXGqX5NHM4NBrc1JrSiA==
Date: Mon, 12 Jan 2026 19:28:38 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com
Cc: Pavel Machek <pavel@nabladev.com>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] v5.10.247-cip68-rt30
Message-ID: <aWU9VmyupbXT0JcG@duo.ucw.cz>
References: <aWLVHnFYQWsNWmjj@duo.ucw.cz>
 <b211ca2c-033f-427f-ac3c-9e9d2a16acf1@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AxvTjwgK+49ha5V2"
Content-Disposition: inline
In-Reply-To: <b211ca2c-033f-427f-ac3c-9e9d2a16acf1@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jan 2026 18:28:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21534


--AxvTjwgK+49ha5V2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-5.10.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-5.10.y-cip-rt-rebase
> >=20
> > And their content should be identical. There are also tar archives, at:
> >=20
> > https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> >=20
>=20
> Could it be that you forgot to upload the tarball?

I don't see a tarball, but I'm pretty sure I asked vger to generate it
(but maybe on wrong branch, by mistake). I asked again on the right
branch, and will watch for incoming email confirmation this time.

Sorry about that and best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AxvTjwgK+49ha5V2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWU9VgAKCRAw5/Bqldv6
8nhAAKCMDkabDrBJaRUwsr52Zecyx9KvrACeKTi61RVHKNn/9ON0pfF9aqxZHCE=
=EzWi
-----END PGP SIGNATURE-----

--AxvTjwgK+49ha5V2--

