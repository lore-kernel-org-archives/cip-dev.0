Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD10F8D77F
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 20:57:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26330.1776373062522918564
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 13:57:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=imakgMKN;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7129B11411C;
	Thu, 16 Apr 2026 22:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776373060;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=m0qqMzui6TOwHlsv5hRY/QpbCNjbXHTGpHjpqQAX5ZE=;
	b=imakgMKNqYA7Hd/CAiJu1a9vIzQCd1Qn8JkEzG8OHn82dAQ/Mya4k8H2qmiD5Mb8qzXJV0
	twzJ0T9jCXJB5mvMTvrANJyYWWDb40LsDZtftuSbgNYNRksHcVqNky5RFnk4H86wPxnU5g
	32Gm+F5ldtYJQrx4IM+J2JaeSSnfrxLfOJp0e59cpiCR+r3CLM9AXiXBlzroX1bDo4k7XG
	wPq1ZGfV1qDFgMVMG9wjiLz6vsJb/G/HMHXmMDL8tveB2pqQ3KdvJ8k8xpMT4TL2pvGKBZ
	rhpEmOaJT0jDct/y+fj9RC+2inSfu3cOkhdB2MZvHF1o9koOu0mpw0j9cMYOJw==
Date: Thu, 16 Apr 2026 22:57:39 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: Re: [PATCH 6.1.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_enable
Message-ID: <aeFNQ-qnm-GNv7jW@duo.ucw.cz>
References: <20260413171831.3091144-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V9nn7fHxM8RWfFAm"
Content-Disposition: inline
In-Reply-To: <20260413171831.3091144-1-chris.brandt@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 20:57:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22754


--V9nn7fHxM8RWfFAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 5ce16c169a4cb8ffceabfd48853d0bf605ce785a upstream.
>=20
> When drm_panel.prepare_prev_first is set to true in a panel driver, the
> panel expects the MIPI DSI hardware to be already configured before the
> panel's prepare function is called because it might need to send DCS
> commands.

For whole series: I had some minor comments here, but those should be
fixed in mainline, first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--V9nn7fHxM8RWfFAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFNQwAKCRAw5/Bqldv6
8plyAJ9fA/0A9P7FIv8xCeX84Fy2IagkGwCgugokjCQ4cqPRES5kDIjpPi60H9g=
=IFMI
-----END PGP SIGNATURE-----

--V9nn7fHxM8RWfFAm--

