Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7D2F4644B
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 10:25:10 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47290.1773656704949990397
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 03:25:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GiTkUnKg;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E80C910BD9C;
	Mon, 16 Mar 2026 11:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773656702; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=qA2EQfogRdDwrKoS2x0dIOJEgw3W9jAHhPOFnA7nY6w=;
	b=GiTkUnKgbUUxKiwHtAfnCji0GHEZuF/n+MH/Yf/SWYU2NwY42Eo1cZncp1TAIVNTsQ1Eui
	S7O0lChh6sqMzHDlo12q9tyYjNiTeTSQLobim4p0lcfb2vpK6I82R4HHfEza27cGyTqPP2
	cyj3it/DTVh5rIBOGxtHspsloleDOsUhYJRg2kG3nQYSpQujm8bUvNxX5EqULwdmuM1Uli
	2dubW9DfVkVDwWhTGKptVlptpPDD512x+LTsoryw920HGF+ZGSlq1wNmVTNjtmzZA7GdPt
	a+5w95oZVHdHzeeuiuVzoNnm5ywAS3TJK1STEW9pcEf/aEbmbOFrSdimuANR9g==
Date: Mon, 16 Mar 2026 11:24:59 +0100
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip109-rt60
Message-ID: <abfae+K29RRt9AeO@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="46fCxxuEKRYMg3TU"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 10:25:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22379


--46fCxxuEKRYMg3TU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--46fCxxuEKRYMg3TU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabfaewAKCRAw5/Bqldv6
8kGhAJ4ma396j84fIGIwh12iMg4Mr8OQ1QCgjrZ1Gncp/SNBwlO8pKLb/YwE3fs=
=0Ua0
-----END PGP SIGNATURE-----

--46fCxxuEKRYMg3TU--

