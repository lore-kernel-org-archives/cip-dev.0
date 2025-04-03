Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F48C3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 08:30:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.8377.1743669035908553872
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Apr 2025 01:30:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DbA0qK1e;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D07910298354;
	Thu,  3 Apr 2025 10:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743669034; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=wz03om617WOTw+euUDfObBRyamA09zaTL8qVRlltijs=;
	b=DbA0qK1eRQ0uEAKzywX/KfhW2b1jRxml65Owo8lqUhYsSq2kqbpsYG14i8kGlKbz43bOkj
	XzthcqLmGB9G0wy9VphGtvrx0uAkHu+PXi/P0AP6OW2BtiSmg1IYUoZXUepU9KP4DnP/Ww
	woMrpic6MfVC9DzpZPHiAIwowie50xN9ivE0BOkyOvQO4FmcoXYXu+BeRZb06QncRp4YmE
	zaO/Wx3g/e1zuLnp/eHg1M9sXFyNrHFMw/OdaQSrqIGHQggmwmrz9gdAnHiA1bAKJ+WUKW
	W67pS9ppMfYcWebD7Q5sK8ijdOqGDIKgPz1vhzqmIPNbt+R64ZGiqopShA2BbA==
Date: Thu, 3 Apr 2025 10:30:28 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: v6.1.132-based -cip release
Message-ID: <Z+5HJCi+E6ynObsN@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u0stnQvq+dvbvgXh"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Apr 2025 08:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18459


--u0stnQvq+dvbvgXh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

6.1.132-based -rt is out, and I really should do -cip-rt
release. If there are no comments, I'll do 6.1.132-cip release soon.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--u0stnQvq+dvbvgXh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+5HJAAKCRAw5/Bqldv6
8veQAJ9BZPlG4dnsDpA5nLcLV2NFnaeedACgr6aA+BBd1Dk6hVRRrmbJ6qfNoHc=
=3S7A
-----END PGP SIGNATURE-----

--u0stnQvq+dvbvgXh--

