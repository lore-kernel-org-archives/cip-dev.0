Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F8C433FE
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 07:44:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16613.1667461438389951422
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 00:43:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0970A1C09DB; Thu,  3 Nov 2022 08:43:55 +0100 (CET)
Date: Thu, 3 Nov 2022 08:43:54 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ
 handling for RZ/G2L
Message-ID: <20221103074354.GA12403@duo.ucw.cz>
References: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 07:44:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9897


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit d887087c896881715c1a82f1d4f71fbfe5344ffd upstream.
>=20
> RZ/G2L has separate channel specific IRQs for transmit and error
> interrupts. But the IRQ handler processes both channels, even if there
> no interrupt occurred on one of the channels.
>=20
> This patch fixes the issue by passing a channel specific context
> parameter instead of global one for the IRQ register and the IRQ
> handler, it just handles the channel which is triggered the
> interrupt.

Can you elaborate what "the issue" is? AFAICT the code worked before,
and will work after the patch, with maybe tiny little less overhead
after the patch?

Thanks and best regards,
								Pavel

>  static irqreturn_t rcar_canfd_channel_tx_interrupt(int irq, void *dev_id)
>  {
> -	struct rcar_canfd_global *gpriv =3D dev_id;
> -	u32 ch;
> +	struct rcar_canfd_channel *priv =3D dev_id;
> =20
> -	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
> -		rcar_canfd_handle_channel_tx(gpriv, ch);
> +	rcar_canfd_handle_channel_tx(priv->gpriv, priv->channel);
> =20
>  	return IRQ_HANDLED;
>  }
> @@ -1227,11 +1225,9 @@ static void rcar_canfd_handle_channel_err(struct r=
car_canfd_global *gpriv, u32 c
> =20
>  static irqreturn_t rcar_canfd_channel_err_interrupt(int irq, void *dev_i=
d)
>  {
> -	struct rcar_canfd_global *gpriv =3D dev_id;
> -	u32 ch;
> +	struct rcar_canfd_channel *priv =3D dev_id;
> =20
> -	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
> -		rcar_canfd_handle_channel_err(gpriv, ch);
> +	rcar_canfd_handle_channel_err(priv->gpriv, priv->channel);
> =20
>  	return IRQ_HANDLED;
>  }

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY2NxOgAKCRAw5/Bqldv6
8tClAJ9FGJyKleKY9G+xDfv9dsijHhX0uACfXBpLNb7YrUSYaav+2pF4Vo2adTE=
=CBlJ
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

