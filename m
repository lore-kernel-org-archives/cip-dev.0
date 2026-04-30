Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E31CD13D3
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 07:33:28 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14906.1777534402260634433
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 00:33:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=d0t6eU4B;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D35610BB3B;
	Thu, 30 Apr 2026 09:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777534399;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OBIGded310jwXGtDbXAMtuxLYdn5nmGon56mg/McSS0=;
	b=d0t6eU4BvtCs2HRtg68kHnWpFU+vmj4r7z517BO4YDtriphmLc6j+H6wXq0uyq/cy/I2y5
	njJEBqoEsw/phA5f3No4QH3aVdjklbcn7tgbZmOU7vS2T++8dyVPwDXNkCjUzeDVchniDL
	MyGmjVt2dFxCMjCkCiTffHr+Tkfnvx0RgrPntEC53v2PiXXTPa/BgKQi1wMwYuiyiIPjxi
	hOGuW4CRr47m5Yvfw7GcpqIHdKCZGeALtwrxZiBl2hke/GhOhCBRRXEf6TlUdBg/szCRFA
	vuJtw/hR0JuB7cmOLjoVcdMMeqpbwfp26Y9ZhYTMZVcC8gv3GzQdVaOYsYz1Gw==
Date: Thu, 30 Apr 2026 09:33:16 +0200
From: Pavel Machek <pavel@nabladev.com>
To: masami.ichikawa@miraclelinux.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Fun CVE -- CVE-2026-31431 was Re: [cip-dev] [kernel-cve-report] New
 CVE entries this week
Message-ID: <afMFvJzVtg4GvKVW@duo.ucw.cz>
References: <CAODzB9pBqBOhOpu=H4RyON1VaLGJSP4jsFrLmGVdACU73DXyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FLzQqeVd1g0AoEpQ"
Content-Disposition: inline
In-Reply-To: <CAODzB9pBqBOhOpu=H4RyON1VaLGJSP4jsFrLmGVdACU73DXyxw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 07:33:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22825


--FLzQqeVd1g0AoEpQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Apparently there's new CVE with a name, and when a CVE has a name,
that's not good news.

https://nvd.nist.gov/vuln/detail/CVE-2026-31431
https://xint.io/blog/copy-fail-linux-distributions

Good news is fix is known/available.

https://github.com/torvalds/linux/commit/a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5

I have not verified information here; this is just a heads-up, we may
get asked about this one a bit.

Best regards,
									Pavel
--FLzQqeVd1g0AoEpQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafMFvAAKCRAw5/Bqldv6
8gZsAJ0VQ9HxNl0Wz6JYGPVOkIfxecRqOwCfZXbc+XBCVeQMRrWeB722zpR+Fs4=
=8qEg
-----END PGP SIGNATURE-----

--FLzQqeVd1g0AoEpQ--

