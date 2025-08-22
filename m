Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63368CA0EED
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 11:29:23 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.7631.1755862162316535029
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 04:29:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LoTfzLAk;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FA8D1038C11E;
	Fri, 22 Aug 2025 13:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755862159; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=A+n6ciAFAskMkEEgGUYZIZ7SXdFimsX8x+jtqheR4fk=;
	b=LoTfzLAkPSjyPgH9jcgbMz06QBMket3bjFCMqxvRGUdB4VAxq3fKd1y8UGDh0C70F5+md5
	4tqc9G4VlDO0oivisfvHy95JdNF8DQVg0wqLEGRrgZrn58Bqsr1LlFgWB74noK7wKsTIi9
	QZsTTYAUZ8ntbFBB35FQNQcLQRE7jT5DZK6WcNTlq8eKjWFIxZkIumqAhnddEmaCXkoksc
	NFw687W9tS+x04nRB1Xdhz3hCz7PM2ewIiJyh4mMUxHfgcTM9D8PNIOo6NXS6SKNvI87V4
	+CmVg1pDL1K6jhZYE1MzV7yPkqsBx61bBbXBE/45W46FQpq3CEC1t5xWCqXPRQ==
Date: Fri, 22 Aug 2025 13:29:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 18/55] media: rzg2l-cru: Simplify handling of
 supported formats
Message-ID: <aKhUia5N1sMbH8lz@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-19-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W7q8JTHdeMGOfxqi"
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-19-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 11:29:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19944


--W7q8JTHdeMGOfxqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 8853467c41e8edd77a1dceb22c085d1d483946c3 upstream.
>=20
> Refactor the handling of supported formats in the RZ/G2L CRU driver by
> adding `pixelformat` and `bpp` members to the `rzg2l_cru_ip_format`
> structure.
>=20
> New helper functions, `rzg2l_cru_ip_format_to_fmt()` and
> `rzg2l_cru_ip_index_to_fmt()`, are added to retrieve format information
> based on 4CC format and index, respectively. These helpers allow the
> removal of the now redundant `rzg2l_cru_format_from_pixel()` function.
>=20
> The new helpers are used in `rzg2l_cru_format_bytesperline()`,
> `rzg2l_cru_format_align()`, and `rzg2l_cru_enum_fmt_vid_cap()`,
> streamlining the handling of supported formats and improving code
> maintainability.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Link: https://lore.kernel.org/r/20241018133446.223516-14-prabhakar.mahade=
v-lad.rj@bp.renesas.com
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>


> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
> @@ -66,10 +66,14 @@ struct rzg2l_cru_ip {
>   * struct rzg2l_cru_ip_format - CRU IP format
>   * @code: Media bus code
>   * @datatype: MIPI CSI2 data type
> + * @format: 4CC format identifier (V4L2_PIX_FMT_*)
> + * @bpp: bytes per pixel
>   */
>  struct rzg2l_cru_ip_format {
>  	u32 code;
>  	u32 datatype;
> +	u32 format;
> +	u8 bpp;
>  };

bpp normally means _bits_ per pixel, that meaning is also present
elsewhere in this series, which is a bit confusing. Changing it to
bytesperpixel would be welcome.

(But it should not prevent merge).

Best regards,
									Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--W7q8JTHdeMGOfxqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKhUiQAKCRAw5/Bqldv6
8lMEAJwOhUY0TcjCWhBqUcF9oAt11NEvhwCgtSMzr2EhVEyUkcBO3RVd8QyUMgE=
=Of3W
-----END PGP SIGNATURE-----

--W7q8JTHdeMGOfxqi--

