Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F5EE7316A
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 13:19:28 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52294.1770038367201854069
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 05:19:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=I2oGKUPu;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 243AA10E69F;
	Mon,  2 Feb 2026 14:19:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770038365;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ctAWG3QgSm0Q4rMZ9M29ajBVI+6gohBcQHSC4BlL3MY=;
	b=I2oGKUPuQV1CyL2ZUV1OekUhgyuLNGk0BmNW5LftoU1o8tI8CZMnaCiwgVK/VibBFyV/r1
	z5I4SNUgWg/cL8JhZtZ3TZrNQEzCeBjNrV+Cw5M2aULe99+8l64KYVaxOCsxcblag9ayxw
	w/Cp8JBos5wL/CJ9GbP/do6IKUONTTDlVk9K+hmcemYdJtVjUbBnd96Or0fErcD5QSSN8N
	XavDKe0GaF7tTMSW0HVYJk42qf9icYDFhGBQIpkwauD8nmbarlgXpsSEzBY/+n+F044O5m
	M9Qal8wwHoWsGpgKNlydSNmzhiANs/NTM++PVxgb8LHnblKYtqwYOjeMBDdCDA==
Date: Mon, 2 Feb 2026 14:19:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 03/11] soc: renesas: rz-sysc: Populate
 readable_reg/writeable_reg in regmap config
Message-ID: <aYCkWsWv+5CoAFFH@duo.ucw.cz>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
 <20260128132522.6902-4-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QScUaAUMr1xA12N9"
Content-Disposition: inline
In-Reply-To: <20260128132522.6902-4-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 13:19:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21807


--QScUaAUMr1xA12N9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit c432180a7d95081353a96fd6d5bd75b0fc8a27c3 upstream.
>=20
> Not all system controller registers are accessible from Linux. Accessing
> such registers generates synchronous external abort. Populate the
> readable_reg and writeable_reg members of the regmap config to inform the
> regmap core which registers can be accessed. The list will need to be
> updated whenever new system controller functionality is exported through
> regmap.

Ok.

> @@ -18,7 +37,57 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sys=
c_soc_id_init_data __initc
>  	.specific_id_mask =3D GENMASK(27, 0),
>  };
> =20
> +static bool rzg3s_regmap_readable_reg(struct device *dev, unsigned int r=
eg)
> +{
> +	switch (reg) {
> +	case SYS_XSPI_MAP_STAADD_CS0:
> +	case SYS_XSPI_MAP_ENDADD_CS0:
> +	case SYS_XSPI_MAP_STAADD_CS1:
> +	case SYS_XSPI_MAP_ENDADD_CS1:
> +	case SYS_GETH0_CFG:
> +	case SYS_GETH1_CFG:
> +	case SYS_PCIE_CFG:
> +	case SYS_PCIE_MON:
> +	case SYS_PCIE_ERR_MON:
> +	case SYS_PCIE_PHY:
> +	case SYS_I2C0_CFG:
> +	case SYS_I2C1_CFG:
> +	case SYS_I2C2_CFG:
> +	case SYS_I2C3_CFG:
> +	case SYS_I3C_CFG:
> +	case SYS_USB_PWRRDY:
> +	case SYS_PCIE_RST_RSM_B:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool rzg3s_regmap_writeable_reg(struct device *dev, unsigned int =
reg)
> +{
> +	switch (reg) {
> +	case SYS_XSPI_MAP_STAADD_CS0:
> +	case SYS_XSPI_MAP_ENDADD_CS0:
> +	case SYS_XSPI_MAP_STAADD_CS1:
> +	case SYS_XSPI_MAP_ENDADD_CS1:
> +	case SYS_PCIE_CFG:
> +	case SYS_PCIE_PHY:
> +	case SYS_I2C0_CFG:
> +	case SYS_I2C1_CFG:
> +	case SYS_I2C2_CFG:
> +	case SYS_I2C3_CFG:
> +	case SYS_I3C_CFG:
> +	case SYS_USB_PWRRDY:
> +	case SYS_PCIE_RST_RSM_B:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

But when register is writable, it will also always be readable, right?
So Imo readable should just do if (writable) return true, to reduce
code duplication.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--QScUaAUMr1xA12N9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYCkWgAKCRAw5/Bqldv6
8lBiAJ9fp4EqOGORc1feyLkwXgDP2V2IwACgh+j9xNIkPzlpEm1JS9EvpWcPnRw=
=bSS5
-----END PGP SIGNATURE-----

--QScUaAUMr1xA12N9--

