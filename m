Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10169.1793617348474700152
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 03:02:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JxzxXAzf;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 160761099A0
	for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793617342; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=NSlGlGQltcDXDyL+WDJ0s6KKE25RAgjWes31tKk2P3Q=;
	b=JxzxXAzfX6yWhe5avbLBj9ysy5j7+oiblSuVQ2DxwbcN/uHjMmZAPZYyhVfFcUxir4FfaE
	fu6/dWQFTKSrdt9N+T3VbUDQbWG3WPjWvlJO2wTwgFeEP6QxztpENme4So9uTWMO3LcXnC
	CgIzuc5OZ73jg60tbyvpDhhFul/wDGdvpBNy4p8TQ6/KTHvt/10wN+JUmd/kgZQ866dEY8
	uO/yoL4EybA5I07GyIV3KXWai58UOjsjgPkJKg4qcyxFrNRgkKFIEzqK4fvOidliytqmsY
	R7pMLboUnzgYhzLw9tUvUfIVcZrDZBvazF2OtBkQ470igvPKH8JcGdlX9SPZTA==
Date: Mon, 2 Nov 2026 12:02:19 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org
Subject: CVE-2026-99999, CVE-2026-98432: status in cip branches
Message-ID: <auhtu6LQDZuPFP_N@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/uTj3i0aCfgR3GV+"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 11:02:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24600


--/uTj3i0aCfgR3GV+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

CVE-2026-98432 is fixed by e3f33b0a1d89d738e2b913dab519226eaf76e15b
"ipv4: free inet_opt and ireq_opt after an RCU grace period"

Exploit for CVE-2026-99999 is stopped by
6785011f8b16abf40b1e9d8b2e332232b3e68822 "ipv4: validate
checksum_start before completing checksum"

6.12-cip: we have v6.12.114-cip34 with both patches.

6.1-cip: last commit is Oct 26, last release is Oct 14,
v6.1.189-cip61. Does not have e3f3 or 6785. 6.1.190 has e3f3 and 6785.

5.10-cip: last commit os Oct 26, last release is Oct 15,
v5.10.271-cip78. Does not have e3f3 or 6785. 5.10.272 has e3f3 and
6785.

I guess we could do early releases of -cip at this point. I don't
think embedded users should be affected by either of them (one is KVM,
one is MPTCP, basically), but both are getting some publicity and we
were already thinking about early releases when CVE-2026-99999
appeared.

Best regards,
								Pavel



--/uTj3i0aCfgR3GV+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauhtuwAKCRAw5/Bqldv6
8n20AJ0cMt7tYDuRVGAss75kapjUJ9dB/wCgmQvUN0WYVY25yd00mJXvvs4lRJ4=
=FqQw
-----END PGP SIGNATURE-----

--/uTj3i0aCfgR3GV+--
