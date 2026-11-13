Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7024.1794559293153244765
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 00:41:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JlnHdeAi;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3857310E659;
	Fri, 13 Nov 2026 09:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794559286;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4+48FtOZFukM7CAV7Y8ZqCndmKZNTgUw1PDAXPJF3y0=;
	b=JlnHdeAiVlJ8Uq2+qj3xrJ3RgBXP86LLSelLu6WGB0OlPc7E3O+Ff2KWehb9XsePfFTHZS
	p6UF/4Fg1IPKv894i6j8DkCz6t1mQvlifS/h1DWU+UaZKwzp45vLGbs1RUaJx6S0BVec0g
	vyLmtwB7WRTQN4cfvNiVaxkBSFYxK3G/LxhT8Yybk/uiJNtD/7Gy+41VG3ayLhosWxkI0X
	r71cOr66N4ysjfC2pF2CTu+ES+u9TWlHtzTJGPgLdbvxhUsLLy6+Fw0KXwQZOhF9joCMvN
	So0HOnkb8egXYmW45uW1RbEer/Z5p0v6e6lqcsB93morHh4p59To8UQ4KmeqeQ==
Date: Fri, 13 Nov 2026 09:41:24 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 09/21] rtc: Kconfig: Broaden RTC_DRV_RZN1
 dependency to ARCH_RENESAS
Message-ID: <avbNNKysS5fSE6WO@duo.ucw.cz>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261111091901.41995-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kACfW43jdTZXfgvm"
Content-Disposition: inline
In-Reply-To: <20261111091901.41995-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 08:41:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24795


--kACfW43jdTZXfgvm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 960987abe58d175b94869fb7aca72d7b931b584f upstream.
>=20
> Replace the ARCH_RZN1 dependency with ARCH_RENESAS for the RTC_DRV_RZN1
> config option to make the driver available across both ARM32 and ARM64
> Renesas architectures.
>=20
> The newer RZ/T2H and RZ/N2H ARM64 SoCs integrate a closely related variant
> of the RTC IP block found on the RZ/N1 SoCs. Update the build dependency
> and expand the Kconfig help text to allow this driver to be selected for
> these additional platforms.

> +++ b/drivers/rtc/Kconfig
> @@ -1570,10 +1570,11 @@ config RTC_DRV_RS5C313
> =20
>  config RTC_DRV_RZN1
>  	tristate "Renesas RZ/N1 RTC"

I guess we should list supported hardware here.

> -	depends on ARCH_RZN1 || COMPILE_TEST
> +	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on OF && HAS_IOMEM
>  	help
> -	  If you say yes here you get support for the Renesas RZ/N1 RTC.
> +	  If you say yes here you get support for the RTC initially found on
> +	  Renesas RZ/N1 SoCs.

It definitely should be here.

Best regards,
									Pavel

--kACfW43jdTZXfgvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavbNNAAKCRAw5/Bqldv6
8pqSAJ0fQQTU51sZyjPfDeUW0mb4ACJ9qACgwL9MvFLQozUqBbiAf1GzyhQgezc=
=jTvL
-----END PGP SIGNATURE-----

--kACfW43jdTZXfgvm--
