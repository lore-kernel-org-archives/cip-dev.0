Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A3C982CF
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 11:31:16 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37073.1789644673909371773
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 04:31:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=BVrP2cSb;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EEA3102E67;
	Thu, 17 Sep 2026 13:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789644667; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=bC+/8ioODqPGWql1x0DVPGuG792mRKWhvccuq3MWlqI=;
	b=BVrP2cSbsr83ESSLebUUC7y2p142xcGgbaGGKxnqrkjTJ/yx8Se1r9HzUsj1YAG8DQ2waq
	7+jtwiXMM8TSFxhvmWEkx4FmwhJMkZ0XdcN9uLMnSYMtDd41BmdsHBz+4n+aUeShvR1nBy
	I6aIDuIRgcwW0tqerCzAQ7Zyz8RVWsaBmGpAEzD1sxBh1GTtvEkKYazWbwj6Sf+gC1GHKV
	ppq84tFRa3t0InrXtdJYxX7Qy9+LxTdEb+XHrmpD20hd841YabPzX/EB8udYiZzS1gNHzR
	SYZIJ4VtImNRTws8oJa+D5reuYkwt/NyTr4j72Z6766pgJsvwYzXik76Ua1oog==
Date: Thu, 17 Sep 2026 13:31:05 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.268-cip77-rt34
Message-ID: <aqvPeU3Qlu-QgexT@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="alpYG3RkarNTvB/U"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 11:31:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24222


--alpYG3RkarNTvB/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel


--alpYG3RkarNTvB/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqvPeQAKCRAw5/Bqldv6
8nZtAJ91h3htzUeMCxm4407ymOO25j36tgCfWTw81igb0j2uSVzLDYH4taDBFoY=
=L1un
-----END PGP SIGNATURE-----

--alpYG3RkarNTvB/U--

