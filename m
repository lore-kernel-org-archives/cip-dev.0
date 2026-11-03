Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7326.1793698453492676101
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2026 01:34:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=i+lcS7wu;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C107A10C4D0;
	Tue, 03 Nov 2026 10:34:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793698447; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=5Duj/paR/ZGOl5NiE/rWZw03xEj20wR67RziWKxS0B4=;
	b=i+lcS7wuh/B/t9arMVG19owWAFnL2C6SX8Ng3O8cPXMHhtZUiBgo53bBW2nzjv/BRKXtWI
	KsFKX+nDibYIKSgdvXUEAnz5DMq0uyGf5AXNZWVOK3VIHiw2esFH4K1ITP5hFL0rJISLL4
	7LIK1X+vZZeEs6fiNd2DcgZ6Jl4XaGVZ2xHnfz8BV718cTcAnZIun5lzRo0oP/Grz9G5MQ
	s9QgGwRofuFoCj9+vkUllkGl4JGnGaiH02zxM6UPCNFWrB6NwIb4EyAxHob7+ARDo5Q23j
	fD8BHBGrqZISLuEBO0bWPd+nBwuT8GPJpc4urAo36yQdoGNWI8JMdM7SE2JfIQ==
Date: Tue, 3 Nov 2026 10:34:03 +0100
From: Pavel Machek <pavel@nabladev.com>
To: .kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [ANNOUNCE] v6.1.190-cip62
Message-ID: <aumqi3umuBv2PxG2@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BuhhVr5k2FwZEVyP"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 03 Nov 2026 09:34:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24629


--BuhhVr5k2FwZEVyP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New -cip release should be available at kernel.org. It is related to
two "famous" CVEs, CVE-2026-99999, CVE-2026-98432. They may or may not
affect embedded use, but now you can just tick them off your bingo
cards as "fixed" without extensive investigation.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--BuhhVr5k2FwZEVyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaumqiwAKCRAw5/Bqldv6
8ofLAJ0Q/1WCe1XE8xtom6XLbbIVLbApZQCfe2dEK/DE+NmZuiQXdq5RdxAm0X0=
=43MY
-----END PGP SIGNATURE-----

--BuhhVr5k2FwZEVyP--
