Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB28E9A74C
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:29:45 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15675.1774344583862626832
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:29:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QuaVt4KL;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FF0F10BCC6;
	Tue, 24 Mar 2026 10:29:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774344581;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3cgU3ZbqsD/rdVzRvkKODJhpOeXg+LfXeMXTK3yB7Tk=;
	b=QuaVt4KLtYFSENa7hgpinYjEvoJY52vZZm6XAP7RSePPgQ9vZz1TG89R25gZ76NARv0dWS
	DhrJ8uyU1yOkDpvCuw1863O48nhScS9p38D3EO99b7dHpPeuz3H8kDkg6cpVDxapXROxh2
	bun9EXNsKFInJa+nLgV7McPY+QEoQi2ImrC0a4AKWKIkEYicB0JM9GW4hqdBwgmHKFE2CP
	eEFGanV925IGMQ7/zVMuxTFP9CP0DIN3FzDnrAyGWRul45NGuBtqq47Qvy7B6Lm4uNrF5R
	vsYp8AsZeabzQqOKUBYUC+qC5qrFpu818JVVICvPID+Txry7GNbJmIJ6tkG7pA==
Date: Tue, 24 Mar 2026 10:29:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 07/28] lib/bitmap: add bitmap_{read,write}()
Message-ID: <acJZg1O-1aB15Oyl@duo.ucw.cz>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
 <20260311110357.1938200-8-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gxDJfi9PqO74uCOa"
Content-Disposition: inline
In-Reply-To: <20260311110357.1938200-8-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:29:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22543


--gxDJfi9PqO74uCOa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Syed Nayyar Waris <syednwaris@gmail.com>
>=20
> commit 63c15822b8dd02a2423cfd92232245ace3f7a11b upstream.
>=20
> The two new functions allow reading/writing values of length up to
> BITS_PER_LONG bits at arbitrary position in the bitmap.
>=20
> The code was taken from "bitops: Introduce the for_each_set_clump macro"
> by Syed Nayyar Waris with a number of changes and simplifications:
>  - instead of using roundup(), which adds an unnecessary dependency
>    on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
>  - indentation is reduced by not using else-clauses (suggested by
>    checkpatch for bitmap_get_value());
>  - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
>    and bitmap_write();
>  - some redundant computations are omitted.
>=20
> +++ b/include/linux/bitmap.h
> @@ -601,6 +605,79 @@ static inline void bitmap_set_value8(unsigned long *=
map, unsigned long value,
>  	map[index] |=3D value << offset;
>  }
> =20
> +/**
> + * bitmap_read - read a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
> + *
> + * Returns: value of @nbits bits located at the @start bit offset within=
 the
> + * @map memory region. For @nbits =3D 0 and @nbits > BITS_PER_LONG the r=
eturn
> + * value is undefined.
> + */
> +static inline unsigned long bitmap_read(const unsigned long *map,
> +					unsigned long start,
> +					unsigned long nbits)
> +{
> +	size_t index =3D BIT_WORD(start);
> +	unsigned long offset =3D start % BITS_PER_LONG;
> +	unsigned long space =3D BITS_PER_LONG - offset;
> +	unsigned long value_low, value_high;
> +
> +	if (unlikely(!nbits || nbits > BITS_PER_LONG))
> +		return 0;

If someone attempts to read more than bits_per_long, we silently give
him 0. That sounds like recipe for hard-to-debug problem when the code
designed for 64-bit system is ran on 32-bit.

I'd expect WARN_ON here.

> +static inline void bitmap_write(unsigned long *map, unsigned long value,
> +				unsigned long start, unsigned long nbits)
> +{
> +	size_t index;
> +	unsigned long offset;
> +	unsigned long space;
> +	unsigned long mask;
> +	bool fit;
> +
> +	if (unlikely(!nbits || nbits > BITS_PER_LONG))
> +		return;

And similary here.

Thanks and best regards,
								Pavel

--gxDJfi9PqO74uCOa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacJZgwAKCRAw5/Bqldv6
8itIAJ0TEvMGfgi0UblR8JrIDIXVI+oarwCeLgFtCd0greKjs2A9F7TXaZeignU=
=CNdi
-----END PGP SIGNATURE-----

--gxDJfi9PqO74uCOa--

