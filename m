Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4675.1794512944165374726
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 11:49:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=EqKAxowW;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 988AB10BDA3;
	Thu, 12 Nov 2026 20:48:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794512937;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PYEvZvDfTGwOz0j+Iv5FY6xzDlItAtD8rI1CXTOrdXI=;
	b=EqKAxowWsi28eJ+kD/RZXBtly/GnSwAs+coSkeT335M4RaHYI5TleRGdgpkdwDFQInC0Xc
	U7ARqjiV0lyJaAX6/XrLHG0Q2LzjAIxbLGMMPQAGa5QAd2ZzfulnxiuN6qNEhlrCoOqQKS
	XQmpTPYev7UqgNFO+YVS07Bwrs5YnpplHcyciOmk3hXP7LvnSs7F4Y9bRtCNyDj0Gwzb6u
	WF4K6wy1Yd6XJjUiqzSj+snOQxXgUhDQqcq+XIjGzFL09LMP6lEwU2FUidEJgR2e67foBk
	FarK3gEGuUCPs2gcRYnjX+PFd7CzOHgdwHaBs1930yCzX74JLuVRAnXpDEyp4A==
Date: Thu, 12 Nov 2026 20:48:51 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>
Subject: Re: [PATCH 6.12.y-cip v2 0/6] Backport PREEMPT-RT support for ARM
 32-bit
Message-ID: <avYYI7sPwZ4W87y5@duo.ucw.cz>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7pI+ST//dvil+K"
Content-Disposition: inline
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 19:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24790


--Kj7pI+ST//dvil+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As a full backport via stable was rejected, this is targeting CIP 6.12
> with the required changes from upstream to enable PREEMPT-RT on ARM
> 32-bit.
>=20
> The series was derived from the ARM-specific backlog in v6.12-rt-rebase,
> only reconstructing it from the corresponding upstream commits - maybe
> worth to consider for stable-rt as well.

Series looks good to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--Kj7pI+ST//dvil+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavYYIwAKCRAw5/Bqldv6
8m5aAJ9U1OkRXe4HzYDOphG4egjbH1uWdwCdGNrT3TlPbopJhSdBivskHCownxI=
=10Yo
-----END PGP SIGNATURE-----

--Kj7pI+ST//dvil+K--
