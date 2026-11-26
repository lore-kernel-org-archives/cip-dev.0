Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11179.1795687847475907437
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:10:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=O9WVD8ys;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D4C41076CC;
	Thu, 26 Nov 2026 11:10:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795687841;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NBgXSOL5f8XxO43DxcymgRx2xxootirvSehEn0rh9e8=;
	b=O9WVD8ysSU0mN8HfmsQK3taSprmcDRnuv+P5AKMxjiNR7T1FpOaEXkXpUmhfrak7eWKyxr
	+XEdVVpqQUBe2yqSz3XP3gzFbLH5XlyNo4SmF11J+WUkDenMjxQMPNY3tvKJZUKBL0QThE
	TeUP2wFgRw/mYHuZZxM7D2iYJk79AIwmWEEkJxGZlu8vF/Q5jloIT+NF9rggm1RihxJlCj
	NqWZzVf38Kp/J3GazF1v2+PSehVVw8qSV/XHfjoDpLebIfUlmhjYOV5nM2sQfnn1p5iulz
	YvEtzW+/Su2Yd5tWRUmk28h0SbpamSa9d+ek7X//c3Hw9a6ExHnBQKQCCgj6Tg==
Date: Thu, 26 Nov 2026 11:10:38 +0100
From: Pavel Machek <pavel@nabladev.com>
To: christoph.steiger@siemens.com
Cc: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
	"Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
	Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	"Masoudifar, Negar (FT RPD CED OES-DE)" <negar.masoudifar@siemens.com>
Subject: Re: [cip-dev] Kernel Vulnerability Triaging and SBOMs for CIP
Message-ID: <awgFnhmjayrgXWRq@duo.ucw.cz>
References: <eefa6825-b571-4671-a870-5845f8700af5@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YKcALjMJWP0/t7bN"
Content-Disposition: inline
In-Reply-To: <eefa6825-b571-4671-a870-5845f8700af5@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:10:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25081


--YKcALjMJWP0/t7bN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> For this, the following things need to be done:
> 1. Backport the SBOM series into our SLTS kernels
>    This should be pretty easy except for the v4.19 version, as some
> prerequisites are missing there. The series consists of around 15 patches,
> but is solely confined to the scripts/sbom directory.

I'm not too familiar with SBOMs. Could you provide example output?

We have kernel development history in git. Some of that is copy pasted
into CVE reports. That's not very useful.

Taking copy of that and presenting it as a SBOM will not be too
useful, either, and I believe will make many people unhappy and ask
wrong questions.

Best regards,
								Pavel

--YKcALjMJWP0/t7bN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawgFngAKCRAw5/Bqldv6
8gs/AJ9qFN63FAB1r2VmIY9u5U62K3nFaACgiqvtqhqQhtN627SKZyepAq4MKgs=
=YiOM
-----END PGP SIGNATURE-----

--YKcALjMJWP0/t7bN--
