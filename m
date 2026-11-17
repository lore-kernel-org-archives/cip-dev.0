Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1454.1794938026128302913
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 09:53:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=AzsS8KFS;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C75410F83B;
	Tue, 17 Nov 2026 18:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794938019;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KkF4T4CMRoruFYCE7UVlWKe5E5op8ChNX8+OQScnj4s=;
	b=AzsS8KFSc8dKeVqQUMDAlYqy4TFsjYhZTQT07q04PpJ6vuWs07tiNS8EViqw3cz05309pg
	7ZWwkINKylZCMiaNm2UUchrVfbmUzDD/bsL0J7NV7pTBjA7oE1eCDz7xBpG8nEJxjlZVZI
	9yfwiwudKLYu/yN56J+/74+ek3Qh/2TnD60ed2jyB/tdHukuge9ENwcY8MvjsNJNjFYTO1
	VnnIcW42JeIkblgGJ2VqUyipOlFZnMD2vFqjIKG1QFXhtlN51QIyJOW77oBUzJPpGSVMaA
	lPxOgWJeQgIH+YgCogZOQLiUKlQXnF6ESDpMppedgeK1yvhZb8jdb6imj7vJDg==
Date: Tue, 17 Nov 2026 18:53:37 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	cip-dev <cip-dev@lists.cip-project.org>,
	Dinesh Kumar <kumar.dinesh.h95@mail.toshiba>
Subject: Re: [6.12.y-cip][PATCH v4] Add SECURITY.md for the CIP kernel
Message-ID: <avyUodZ4_b0QpWyI@duo.ucw.cz>
References: <fd7c1d48-bb3a-448f-abc3-108b5c573783@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xwNkMGi7PBQBuRpt"
Content-Disposition: inline
In-Reply-To: <fd7c1d48-bb3a-448f-abc3-108b5c573783@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 17:53:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24947


--xwNkMGi7PBQBuRpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This describes at which time which areas of the CIP kernel are handled
> by the CIP security team and how to report vulnerabilities to it. It
> furthermore states that this project falls under the LF stewardship
> framework.
>=20
> As the original kernel documentation already contains a reporting guide,
> leave a note there which one applies to CIP kernels.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply this if there are no other comments.

Best regards,
								Pavel

--xwNkMGi7PBQBuRpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavyUoQAKCRAw5/Bqldv6
8kyOAJ9T2NIQc+RjOnjlU20SIYaPsN8mVACeNZr0oeCkqTt2OwdYhpq930K+cMY=
=GAii
-----END PGP SIGNATURE-----

--xwNkMGi7PBQBuRpt--
