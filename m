Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3978.1793905640372943981
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 11:07:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jq1XmF8r;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1780F10BDD0;
	Thu, 05 Nov 2026 20:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793905633;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XAw2ke9U+rveSCpoc+i5aXOlpOB/PyqLiMd1LGa/t6A=;
	b=jq1XmF8rldCSaxXSufZDW2oINsYXnFvkdOzPHzb2eae0I+m31Lz2KDLYGFNSOeLMMZhUSi
	45P/YWT+ogHSKS1PdpmqC2cA5ylXoJt5ZTz74NGmMUK0vP9Xw5RY8CCQpW0DGrvPPpekD8
	J7pUMs8DGlE2A4fVxpVj3YI3DK1LJrsojxma1iSCY0dJwm6flFRciH9iHssc5QQA5ocgIX
	mG7lrCyb7TEURR2XWeCaG9mM5fcUAdDf5DmTkrQ2VZUfW6WUfQoqXUTIbPjx9gO0H/c8aq
	6tkCOaSTEX9uPXjUuqwZggK70jNmmeFYno9nWe1H3QyEkDyIsJP3o4+H8o8pHg==
Date: Thu, 5 Nov 2026 20:07:09 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st21, 4.19-cip137
Message-ID: <auzT3ZLOLZ01GlXL@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
 <auh1sRkdmg3AWRbt@duo.ucw.cz>
 <1099989158.146013.1793697722731@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQpt1K31Uz/fGdaF"
Content-Disposition: inline
In-Reply-To: <1099989158.146013.1793697722731@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 19:07:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24651


--xQpt1K31Uz/fGdaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > These look ok to me:
> >=20
> > Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> Thanks. Here's a last-minute addition:

> 09c9317a392321 ipv4: free inet_opt and ireq_opt after an RCU grace
>  period

Thanks, that's CVE-2026-98432 afaict. That's good to have.

Best regards,
							Pavel

--xQpt1K31Uz/fGdaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauzT3QAKCRAw5/Bqldv6
8uwJAJ95F+BZdXLvlyOFZi2LTObRhFeQVQCgrdxRgzeSEoe57SpM1aTeBeR86xg=
=dAiE
-----END PGP SIGNATURE-----

--xQpt1K31Uz/fGdaF--
