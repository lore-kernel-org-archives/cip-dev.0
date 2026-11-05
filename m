Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38239.1793895234283181233
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 08:13:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=iA7veWJf;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2B9310CD8E;
	Thu, 05 Nov 2026 17:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793895228;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xeEcVP1CVtO6bOXT7oZcCIy3F5Neb3wY+96oiEakUWw=;
	b=iA7veWJfxSiL+2uET/8LLMsljQvozTgOCFSkseftftQw/5DA0R2D2nNYphPkkQMeZoPF+0
	HN5koYjW1ZZO3jh/MNTn8NT89gdKUTwvXjja7MW1qopRFMdbXHccOexAmKO4pk7mgEtJWs
	vPFcKE7sthCv1PZAI8/tzy1Oa9k25gC4+/5Hxrk+OxQeGmwgX7Vw1PFXrJvzfc/u8M0M+X
	fQPpZ/NOZiHbY/jYf9jBOsGldwlnv1WBpNuh1EF2dxo9knh9CFQJeTVcSCQK6odOlLm/AE
	sfnwtBBI0XCdjzIzZOvoi0FmERw3QmMyfzXuXww2E9MscRJYpYomf+lOtG4ITA==
Date: Thu, 5 Nov 2026 17:13:46 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 4/7] PCI: rzg3s-host: Add support for RZ/V2H(P)
 SoC
Message-ID: <auyrOmptVJH_CEUm@duo.ucw.cz>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261102125309.7743-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U9sJGpm05x3GqQf2"
Content-Disposition: inline
In-Reply-To: <20261102125309.7743-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 16:14:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24648


--U9sJGpm05x3GqQf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 007c7304d80f1462b98a36284f45adcc1eb8adec upstream.
>=20
> Add support for the RZ/V2H(P) SoC PCIe controllers to the rzg3s-host
> driver.
>=20
> The RZ/V2H(P) SoC features two independent PCIe controllers that share
> four physical lanes. The hardware supports two configuration modes:
> single x4 mode where the first controller uses all four lanes, or dual
> x2 mode where both controllers use two lanes each.
>=20
> Introduce a setup_lanes() function pointer to configure the PCIe lanes
> based on the hardware instance. Implement rzv2h_pcie_setup_lanes() to
> detect the configuration at boot time and program the lane mode via the
> system controller.

=2E..

> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

> @@ -1762,6 +1873,16 @@ static int rzg3s_pcie_probe(struct platform_device=
 *pdev)
>  	if (ret)
>  		goto port_refclk_put;
> =20
> +	if (host->data->setup_lanes) {
> +		ret =3D host->data->setup_lanes(host);
> +		if (ret)
> +			goto sysc_signal_restore;
> +
> +		ret =3D devm_add_action_or_reset(dev, rzv2h_pcie_release_lanes, host);
> +		if (ret)
> +			goto sysc_signal_restore;
> +	}
> +
>  	ret =3D rzg3s_pcie_resets_prepare_and_get(host);
>  	if (ret)
>  		goto sysc_signal_restore;

This existed in original code, but I don't quite understand what
action sysc_signal_restore undoes, and comments do not really help. I
would not mind someone double-checking this.

Best regards,
								Pavel

--U9sJGpm05x3GqQf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauyrOgAKCRAw5/Bqldv6
8g1AAJ92TBk1wx4E83JGC5rXq551IjfO2wCgg9G+v3KBGJ7t6634ix8Ic5S07mA=
=Gpds
-----END PGP SIGNATURE-----

--U9sJGpm05x3GqQf2--
