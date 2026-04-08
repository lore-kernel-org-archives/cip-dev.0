Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AB61073C92
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 10:46:13 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.103606.1775645170038367399
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 03:46:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=XIsOpgLt;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2B9C1128C4;
	Wed,  8 Apr 2026 12:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775645167;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kF82burpJlOWMvo2x/iEd8HD5rn8D4OX3S1S9lVfYTw=;
	b=XIsOpgLtjupXgoVinBIwtNtgGIOTxoocHq1ykjRwuqO0RCQE7U8TrNrbalP4prv7VJo+Dq
	ah2eHOQxis2XCnifAOwMvUQ5h8pqPAXy8KHMuQE7zxzwiQQVpNhB4BBuZ7RA3aoyEqnYOH
	KbQmPoC6cimGXFEbAcufaVotAxkrBO8vrT3D9JJy1vPm8v4dLF7wCPJGArt/KJG10W+K5u
	LsGof9KtLavS7MZYOAeSxrn/D0Q2fNuFXcb/7ogBDuOAc8boK6dWTqjlhK911hZuNGa5Ha
	C2tPWqfwYfnGGyrImNWaxDKl/9iSubkFtorVWF4QqTex18ezC8os0JIxKKM0Wg==
Date: Wed, 8 Apr 2026 12:46:03 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 4/7] PM: domains: Add RZ/V2N compatible to PM
 domain detach list
Message-ID: <adYx64wtN4zxBnGr@duo.ucw.cz>
References: <20260408093951.66884-1-ovidiu.panait.rb@renesas.com>
 <20260408093951.66884-5-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gt0G1/SLjgpvwZid"
Content-Disposition: inline
In-Reply-To: <20260408093951.66884-5-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 10:46:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22652


--gt0G1/SLjgpvwZid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2026-04-08 09:39:47, Ovidiu Panait wrote:
> Add Renesas RZ/V2N compatible to the PM domain detach list in
> dev_pm_domain_allow_detach_on_unbind_cleanup(). This fixes asynchronous
> aborts when unbinding the TSU devices.
>=20
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Aha, so this one is not upstream because these power management
changes are -cip, only. This confused me for a while, would be worth
noting here.

Thanks and best regards,
								Pavel

> ---
>  drivers/base/power/common.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 44c485f0c96b..e83ba3a5611f 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -246,6 +246,7 @@ bool dev_pm_domain_allow_detach_on_unbind_cleanup(voi=
d)
>  		"renesas,r9a07g054", /* Renesas RZ/V2L */
>  		"renesas,r9a08g045", /* Renesas RZ/G3S */
>  		"renesas,r9a09g047", /* Renesas RZ/G3E */
> +		"renesas,r9a09g056", /* Renesas RZ/V2N */
>  		"renesas,r9a09g057", /* Renesas RZ/V2H */
>  		NULL
>  	};

--gt0G1/SLjgpvwZid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadYx6wAKCRAw5/Bqldv6
8iGVAJ0bGLzV/v3q4nf0rQaK64Q8pOi/CgCfQoMCTMc0iwxLtmx46lLj5INeJQw=
=ivne
-----END PGP SIGNATURE-----

--gt0G1/SLjgpvwZid--

