Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FDF532FF
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:10:50 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15483.1774343439978646642
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=ZUPYSuNe;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD11E10CE9B;
	Tue, 24 Mar 2026 10:10:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774343437;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cPbEluO1WiGND4q8wVQe072HTPvDkv7j6Emd95CcB64=;
	b=ZUPYSuNeB4Lqjkc+On7PyKjQ8005/sDeX4VRzXziSn0jK+YVXMJh1mHoNa2iQJ2VX0T3Pl
	zCqnNX/zVGdmaz6ETki6d650k90UkZ2GR7Zm45lK9t4/iVN+dY/uSKxMo6MiirypCKj8LM
	ZdmBOVSeZpqpyn1Oc3KWHfnmwv+uLxmQ7Y298FhEeb66XDSAHGHHrV+k+dry/ca/aqEKTt
	X7bu91szBD4Zi/b5j5JiH+hY5cQPqK4KHPnbV6NbPCMI2S5/V9/LT4gSPwwGlKN4lbaKaH
	XOdp4D7/ARLtZO6YcJT1MX9Bs9be9T01zcKiUp3jmj8jextFNMtpmXYjqQqSRA==
Date: Tue, 24 Mar 2026 10:10:32 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 11/35] phy: renesas: rcar-gen3-usb2: Fix ID
 check logic with VBUS valid
Message-ID: <acJVCOdlchLiSe5n@duo.ucw.cz>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nGx2VVxBOL+hWTe"
Content-Disposition: inline
In-Reply-To: <20260316145915.8580-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:10:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22535


--+nGx2VVxBOL+hWTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 356590cd61cf89e2420d5628e35b6e73c6b6a770 upstream.
>=20
> The existing ID detection logic returned false when both IDDIG and
> VBUSVALID were set, which caused incorrect role determination in some
> cases. The condition:
>=20
>     !(device && !vbus_valid)
>=20
> did not properly reflect the intended relationship between IDDIG and
> VBUSVALID signals.

Yes, well, original code was so obfuscated I was going to comment.

> Update the logic to:
>=20
>     return vbus_valid ? device : !device;
>=20
> This ensures that when VBUS is valid, the role follows the IDDIG value,
> and when VBUS is not valid, the role is inverted, matching the expected
> OTG behavior.

> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c

> @@ -301,7 +301,7 @@ static bool rcar_gen3_check_id(struct rcar_gen3_chan =
*ch)
>  		device =3D !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_IDDIG);
>  		vbus_valid =3D !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_VBUSVA=
LID);
> =20
> -		return !(device && !vbus_valid);
> +		return vbus_valid ? device : !device;
>  	}

Could this simply be "return device =3D=3D vbus_valid"? That's both
simpler and easier to read: we are device only iff we the other side
is providing power.

Thanks and best regards,
								Pavel

--+nGx2VVxBOL+hWTe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJVCAAKCRAw5/Bqldv6
8giNAKCeAAd0tFwT19fxVe+6ZhViGEzpuQCgqaIfGfrw54thoSKPvMHSMvFVLEY=
=/G6k
-----END PGP SIGNATURE-----

--+nGx2VVxBOL+hWTe--

