Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7243.1794560775636968686
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 01:06:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=J3t8CrU4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95EAC10CC6B;
	Fri, 13 Nov 2026 10:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794560769;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Sdy9FxQzkjuNZ32izKSrximFXUMWFiaKac4iy9Sl/xA=;
	b=J3t8CrU4oW+ZzdUKjuvHEYhQlQxUrc3grLxf1gzoKvdnSiPHtXZOUsEMkB/1i6luW8CCm9
	KI3geLU+J3xTUk3M4et7p57Yat5pKOI1gBzQNsAup6g96mcSpDFbulj9GXO9qcl2z1d2QU
	WpCuc6N41NkMFanXdXjssnA9lS/LR5MR77YIlZkY2OVoQlzphSDMPwnXerS71oCG+gqHlX
	bBszJp+D5qJkLXEoWpkRTokRN7cuD5RA3ZNnVB7BFqBqE/bsJSoXn1pWhPN8vcZNagsCk7
	EWiNUJbL/L3+kYbg4Dju7FvdOJmi71lNurnCAeOz2RH8ylNnDB2otdgw/RN7Og==
Date: Fri, 13 Nov 2026 10:06:05 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Chris.Paterson2@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, Daniel Wagner <wagi@monom.org>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Pasquale Nieddu <pasquale.nieddu@siemens.com>
Subject: Re: [PATCH 6.12.y-cip v2 0/6] Backport PREEMPT-RT support for ARM
 32-bit
Message-ID: <avbS_UO1IHpgbZgA@duo.ucw.cz>
References: <cover.1794223241.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEDdoo26H1DrEKfD"
Content-Disposition: inline
In-Reply-To: <cover.1794223241.git.jan.kiszka@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 09:06:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24797


--lEDdoo26H1DrEKfD
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

Thank you, applied. It might be good to merge relevant configs so that
we start testing rt on arm32.

Best regards,
								Pavel

--lEDdoo26H1DrEKfD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavbS/QAKCRAw5/Bqldv6
8ik8AJ0fs2o5FRRFPuKYNOdv0z8X+59CqACfc1WY68H3HrOkm08e/L/ulFzjPY4=
=2oIe
-----END PGP SIGNATURE-----

--lEDdoo26H1DrEKfD--
