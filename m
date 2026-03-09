Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51094EF370F
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 08:16:43 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9327.1773044197108053628
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 01:16:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QSFih/pQ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 368F2110D11;
	Mon,  9 Mar 2026 09:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773044194;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rGQLbpmocJEsMotWXeVk+yUfkxC+wB29ilv6H6+upe8=;
	b=QSFih/pQxfCoGLi3qomfIp80e6ZxMEg4pgjyHx8bQABANZrVNkNDNi6mAYoODCFHZcvKEn
	u6Tr3V7NF3W0qPeMbt/cxWIdekpMyRzeBdGqvxhj++E8yUeaMNRONRl5Y1jj178Jez7Jzj
	F4sPEnddEOFqBmOxrj4owMKcQW9z88Y0DgUaCZF+bhs6m8tAIZ3SQ1647XZriCj9jic0bA
	50d4Mwpiw2wGqj7EixKmnZkrKzRUda3dSBpSTpIOhy92RAusDELzNpr8GCZX21ZWRacEjG
	MBz79h1GGSf1SeNdO1bUEOApkXAVeCH7Faqz7OMQ10Jxdlbh+5kySGsEeUmViQ==
Date: Mon, 9 Mar 2026 09:16:30 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 6/6] can: rcar_canfd: Add support for FD-Only
 mode
Message-ID: <aa6B3tuP6oufeYb6@duo.ucw.cz>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
 <20260309075112.35445-7-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EFw4jhWyOSUNkLBq"
Content-Disposition: inline
In-Reply-To: <20260309075112.35445-7-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 08:16:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22162


--EFw4jhWyOSUNkLBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 9a2b56a48c219d189366dd9bf4c2b42afde2f361 ]
>=20
> The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode called
> FD-only mode. In this mode, communication in Classical CAN frame format is
> disabled.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://patch.msgid.link/20251126155911.320563-3-biju.das.jz@bp.ren=
esas.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 68e6c7ac6649..4bfc7b5ac0ae 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -829,12 +830,20 @@ static int rcar_canfd_reset_controller(struct rcar_=
canfd_global *gpriv)
>  							 RCANFD_GEN4_FDCFG_FDOE);
>  				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
>  						       RCANFD_GEN4_FDCFG_CLOE);
> +			} else if (gpriv->fd_only_mode) {
> +				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> +							 RCANFD_GEN4_FDCFG_CLOE);
> +				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> +						       RCANFD_GEN4_FDCFG_FDOE);
>  			} else {
>  				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
>  							 RCANFD_GEN4_FDCFG_FDOE);
>  				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
>  							 RCANFD_GEN4_FDCFG_CLOE);
>  			}
> +		} else if (gpriv->fd_only_mode) {
> +			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> +					       RCANFD_GEN4_FDCFG_FDOE);
>  		}
>  	}
>

For the record, this part is way too confusing. Long term, it really
needs to go to separate functions... and be refactored.

Best regards,
								Pavel

--EFw4jhWyOSUNkLBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaa6B3gAKCRAw5/Bqldv6
8mRVAKCb0KWtdnehkwZjQmM+AknSq6Da9ACgs1FulnEcU00Ks+XpB/D2sscB8aA=
=gDqo
-----END PGP SIGNATURE-----

--EFw4jhWyOSUNkLBq--

