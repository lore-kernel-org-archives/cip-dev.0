Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619CEC2A062
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 23:54:36 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46712.1767547702127079349
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jan 2026 09:28:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=REwcOl8f;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7BC210D262;
	Sun,  4 Jan 2026 18:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767547699;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=U2xLK6N4oc45E8nH4NVjYcCp+xaH30lCZRY68dlL+pM=;
	b=REwcOl8fCw+nj6RNxupBdBsegsC9x39adBw1zZDKrQPKVpA9Oxp4jWVr/OHLmB1wvfeiiJ
	VFWeUaiYC8HHPre8dbxpYvsre0pkt/XeQN1BP7V09FHITda6c6x9jZqvSLNGAIW+IYSRVb
	hjWQ0h4dzLxhq3vveYLqj5sGg1fsvr9GKZBMmP89qutoIYp+AzYyGgAQXbSBamnQ5LDNZL
	L8lDjmYQttvO6+Kuunq9WDzRx7eNU+BeLIXPsFvkXg3RgqWJ6GqGLbI6Q4ckloQxZE8dB0
	A5UC07N8+pRKEuJi/tb3BtI+69KSJCLhdWypmCGhy6nVI90hT+6gtgsOfNMFpA==
Date: Sun, 4 Jan 2026 18:28:17 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 1/3] net: phy: add configuration of rx clock stop mode
Message-ID: <aVqjMXT5hDhU2yhr@duo.ucw.cz>
References: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
 <20251229083954.3598-2-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
In-Reply-To: <20251229083954.3598-2-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pg3cMzrWtGQxkCOV"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jan 2026 23:54:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21300

--Pg3cMzrWtGQxkCOV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
>=20
> commit cf337105ad38564d7855151889a7315da73119d0 upstream.
>=20
> Add a function to allow configuration of the PCS's clock stop enable
> bit, used to configure whether the xMII receive clock can be stopped
> during LPI mode.
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Link: https://patch.msgid.link/E1tVZDR-0002Jl-Ry@rmk-PC.armlinux.org.uk
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [OP: Added error handling and called phy_eee_rx_clock_stop()
>      unconditionally to clear clock stop bits when disabled.]
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

> +++ b/drivers/net/phy/phy.c
> @@ -1354,12 +1377,9 @@ int phy_init_eee(struct phy_device *phydev, bool c=
lk_stop_enable)
>  		if (!phy_check_valid(phydev->speed, phydev->duplex, common))
>  			goto eee_exit_err;
> =20
> -		if (clk_stop_enable)
> -			/* Configure the PHY to stop receiving xMII
> -			 * clock while it is signaling LPI.
> -			 */
> -			phy_set_bits_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1,
> -					 MDIO_PCS_CTRL1_CLKSTOP_EN);
> +		ret =3D phy_eee_rx_clock_stop(phydev, clk_stop_enable);
> +		if (ret < 0)
> +			return ret;
> =20
>  		return 0; /* EEE supported */
>  	}

Does clock_stop ever return values > 0? If no, this can be simply
return phy_eee_rx_clock_stop(phydev, clk_stop_enable);

Best regards,
							Pavel
--=20
In cooperation with Nabla.

--Pg3cMzrWtGQxkCOV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVqjMQAKCRAw5/Bqldv6
8l7DAJ9De9KAko54T6GwBlwUUQllUmW64wCggUQxr34D6RToHi3qikw0yT396HA=
=LH5j
-----END PGP SIGNATURE-----

--Pg3cMzrWtGQxkCOV--

