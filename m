Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15597.1795519247502789330
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 03:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=hsXS+im6;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92A8D10F3A4;
	Tue, 24 Nov 2026 12:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795519241;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+gXlb00PISyt2frmqzIGRjRnay1R4RO3SXpkfBJ/M7E=;
	b=hsXS+im6sVQzb1ykpcSKpMTHIbUSvP0JvVaBZDn7ru3yjx5CTnZM1KXwSgSvLn30K0niwL
	grih6XZNL9fhFkkvdGA8CiiSPbY2a/Rs91tF+Ntz4tGSih1WGxx4zeK8ELLBbanrYn2gIR
	XwTv49o6qQ/aVC9rhLYaE6sG2jCWyAUS8Vmu6xpyJ3DpjfO/5Upn4tStd4uvxPecHPqCTw
	ntvFIKMdTyDWu2CwOgT0nQhp8CAsfLQpknuy28aTveRKHc1tmGDy5f37HZLuBNseFxxApB
	Z0fznNGSBObL7DbBiUB7XsN8FvUqsPtbZG2o+TWyIGzh2t0hOJHKGF0AYYfmvA==
Date: Tue, 24 Nov 2026 12:20:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: christoph.steiger@siemens.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Kernel Vulnerability Triaging and SBOMs
Message-ID: <awVzBxSqWVci3OZx@duo.ucw.cz>
References: <b62df3a5-fc1a-4fbd-a81b-0ffe38d8d854@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mnj1ewi8h6fnE2xt"
Content-Disposition: inline
In-Reply-To: <b62df3a5-fc1a-4fbd-a81b-0ffe38d8d854@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 11:20:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25059


--Mnj1ewi8h6fnE2xt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I think it would be a good idea for CIP to also follow this approach. This
> would give us kernel SBOMs, easy triaging and access to all tools develop=
ed
> for yocto and the mainline kernel.
>=20
> For this, the following things need to be done:
> 1. Backport the SBOM series into our SLTS kernels
>    This should be pretty easy except for the v4.19 version, as some
> prerequisites are missing there. The series consists of around 15 patches,
> but is solely confined to the scripts/sbom directory.

=46rom my point of you... I believe we could apply such series to -cip
kernels, even through it is not "hardware enablement".

But I guess even better way would be to submit them to -stable team;
-cip will automatically inherit them from -stable for 5.10+. These are
not "bugfixes", but I suspect -stable team may take them. You can cc me.

Could you do that?

Thanks and best regards,
								Pavel

--Mnj1ewi8h6fnE2xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawVzBwAKCRAw5/Bqldv6
8vFlAJ9JvRLvkc4LdO01Td3CPBt0eg7gAwCeNFDxfN02uJR+6LrL+r7NIC5BCnc=
=chCo
-----END PGP SIGNATURE-----

--Mnj1ewi8h6fnE2xt--
