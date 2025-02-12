Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B7C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 16:45:28 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.20788.1739378722467117559
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 08:45:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WKb+a7tc;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8B47103718C4;
	Wed, 12 Feb 2025 17:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739378720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CBc94GSzKkMXgf1XHIw1VNzRozlW0wyBMQ2rPpxEUu0=;
	b=WKb+a7tcrky23rc0w246XOJCdkKaRWebnA7btZbUm4Y2t9ge1ZPxgGreDSnvg9k+cbuYxu
	WspCL4yd7NOTXJnDwvEE/JyZpCNPYreuHd4aazWxJQrfyfJURCtY3BcWdTDtIQu15xIsW9
	QFDvaK6QDJWIgMwHSVgPXQd873/fjds+6UQEXz4LXg+/07yKL2tcudgNas7akoe1xW7o/p
	WiYX8f/c4SI9zgkiqzxR0OA80mjhuIg/2bndNfA6HMXIPBlyhd+ob+1tbv+BqlI5NkLDC0
	cz3KBaD6ZOrE35Ta3xPmSpfxRLNr/gBeuZdZPEip+2Dwr0tPRjORnsW2R19gcw==
Date: Wed, 12 Feb 2025 17:45:15 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: v6.1-cip-rt based on 6.1.128
Message-ID: <Z6zQG669vWGTBgKI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5maiLlkRF43YpKCZ"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Feb 2025 16:45:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17817


--5maiLlkRF43YpKCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1.128-rt49 is out and it may be good time to do -cip-rt
release. Could I ask for 6.1.128-cip release? (Alternatively, I can do
it myself).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5maiLlkRF43YpKCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ6zQGwAKCRAw5/Bqldv6
8lmnAJ4maeKy74ppujtSyussb/wi40KkvQCgit3UT5YIZcnZNMNMI4LbXo+U+RM=
=DZq1
-----END PGP SIGNATURE-----

--5maiLlkRF43YpKCZ--

