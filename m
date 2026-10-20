Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6950.1792501599155269635
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2026 06:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Sgmfz5HH;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B63E9108DDA;
	Tue, 20 Oct 2026 15:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792501592;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kq+ALJ68cOLH+vQyt+LPirmcSz0u+iSRANzZ09bYjRM=;
	b=Sgmfz5HHdoijm9/6htiWCiB12fwjzuTjcPuiBONPYxsLBvOIv0M1lvQflmDhlnksrB4iCv
	OLwdWmJTrSrV2kD4mI7WWzxnH08nkgZUHv2p279wpCl6tnCHD5TC6wJ29nlFJHR4YquXwu
	a2DywGnBDv/6zJu6/TVpiJ2A89Qo6pYI4GV7OUKgeld/DudeRAKSTn2AusOVI4ceBPlBMj
	gqeL+nQA6FDVEpfVe3hr/4B8/GtchS77fJuWyxFUov2AbEdCLxA/yNk+JqQFMxfp1z6oBA
	0zZ9mI9kf0gV/Y55RbokYGPIViK1pMxz70IufFEDk5FQ2Oq7H04+POHbGcxpsw==
Date: Tue, 20 Oct 2026 15:06:30 +0200
From: Pavel Machek <pavel@nabladev.com>
To: muhammad_usama.sardar@tu-dresden.de
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] =?iso-8859-1?Q?Contribution?=
 =?iso-8859-1?Q?=3A_EarlyAttestationTsch=FCss_=28EAT=29=3A_8+_Critical-Sev?=
 =?iso-8859-1?Q?erity_Vulnerabilities_of_CVSS_9=2E1_i?= =?iso-8859-1?Q?n?=
 Early Attestation Exposed by Formal Analysis in ProVerif
Message-ID: <atdnVlo5i7MERcar@duo.ucw.cz>
References: <49bffea3-63e0-4151-ad98-1710231f6b27@tu-dresden.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ZYetsFwyhRuImde"
Content-Disposition: inline
In-Reply-To: <49bffea3-63e0-4151-ad98-1710231f6b27@tu-dresden.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2026 13:06:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24503


--9ZYetsFwyhRuImde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Following up on our previous contribution, GitHub has completed its review
> of the 7 GitHub Security Advisories (GHSAs) on relay and diversion attacks
> we reported against early attestation implementations of Privasys
> and

Can you briefly explain link between your work and CIP project?

Best regards,
								Pavel

--9ZYetsFwyhRuImde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatdnVgAKCRAw5/Bqldv6
8jDDAJ9D/z1/GxrWvBJ0jyFBfFbQH/WKrACdHnjLDnzU5ZBPXAQVt21iTueaulU=
=x0OG
-----END PGP SIGNATURE-----

--9ZYetsFwyhRuImde--
