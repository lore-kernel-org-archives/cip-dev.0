Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB03FD25931
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 11:21:18 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8881.1769512876305626251
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 03:21:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QfRsZKw1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36C3810DDF9;
	Tue, 27 Jan 2026 12:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769512874;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Y0fJsjWIrnFD9A6NuMnub0BcLQnOqXxfgmOYTYB49zs=;
	b=QfRsZKw1TL5bzc5FFuBOtV9cU/Jhhm9VNazh6KKJS/xx2cwfNjt2xFwfrnD4/NEDp2UpzU
	MOmIOPVwcg8M70RRGosTDCRdvIro+1HOh+zkXznLKIkqP727K2Jop+MGlRkEow3aeC5ez+
	fKFSJsfukUU1FK+OxMeK3pwLzV1X0iRbutNTP18suTpMBpiyRW8Qi8eyYa+j9W1pXduAgx
	DnAtfQfXRkrK+ElqtxFO+3CsHD8TV4PJVgkqZ73E7L+RguD65HD7NWsPid7hTgUO0ZFS9z
	HWcmesdWrPi4WzgA0bK4o2jwDArtnjpQjHsAqlVlmW0a9HQ8MEuwLQXhiJ/f+A==
Date: Tue, 27 Jan 2026 12:21:12 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 0/3] mmc: renesas_sdhi: Backport reset control
Message-ID: <aXifqIbi111kBo2w@duo.ucw.cz>
References: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mqRRU54V032aIGr5"
Content-Disposition: inline
In-Reply-To: <20260126094333.2528974-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 11:21:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21724


--mqRRU54V032aIGr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports patches to control the reset signal of the Renesas
> SDHI IP during probe and suspend/resume.

Same as 6.12: looks good.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--mqRRU54V032aIGr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXifqAAKCRAw5/Bqldv6
8jQoAKCj76jHhKw6L5fTa8lKYELvEnGmXACgjZURqm5/b+U+uj1bBp9BqYlM9rk=
=mMuJ
-----END PGP SIGNATURE-----

--mqRRU54V032aIGr5--

