Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF3D167FC
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:22:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7376.1767954169152823389
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 02:22:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=RkQRLjwe;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4533110D8A0;
	Fri,  9 Jan 2026 11:22:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767954166;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ea1uvDvi/qPkRIs559/UpgrGtfXsx/T2peEkLqe58Nw=;
	b=RkQRLjweg6l1VH9VblpcxGIBax9w1osdxAFXkASWv2d4NMf5yJyBxkEygbh9wsXuK28C9S
	D1+i6oxcRoKULeLh/6u5HzLPWJ51DlzOS6rBo8oGfC/gNc8Hh3GgMkUPB/u6etuTLh1vys
	zsGdoOt5/YFvocUvlDqagARJypyvVUWFkNNm94gj9G5FVyxPNUrK80d3IWgHjqt07ORjtT
	kGl+eMgeMFnm6xScXOx0Xf0vw3A/jNF91Bi13tHt9jro6bCdRqb5clB7bf5QwMr0bHH9Mk
	bFvjIUcBjdTbpOBeSN/34GfEvacCch7/eyeYuT6PAFLAtS7A/AMOKwQeuyG/7w==
Date: Fri, 9 Jan 2026 11:22:42 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 04/22] i3c: master: Add basic driver
 for the Renesas I3C controller
Message-ID: <aWDW8tT9BNp3Cz+L@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <20260108092823.489287-5-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dzSwizQnf5FmpFZN"
Content-Disposition: inline
In-Reply-To: <20260108092823.489287-5-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 10:22:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21494


--dzSwizQnf5FmpFZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Some comments and questions are below.

> Add a basic driver for the I3C controller found in Renesas RZ/G3S and
> G3E SoCs. Support I3C pure busses (tested with two targets) and mixed
> busses (two I3C devices plus various I2C targets). DAA and communication
> with temperature sensors worked reliably at various speeds.
>=20
> Missing features such as IBI, HotJoin, and target mode will be added
> incrementally.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Link: https://lore.kernel.org/r/20250724094146.6443-5-wsa+renesas@sang-en=
gineering.com
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> [tommaso.merciai:
>  - Removed  __counted_by(ncmds) from struct renesas_i3c_cmd cmds[]
>  - Added struct reset_control *tresetn, *presetn into struct
>    renesas_i3c
>  - Use devm_reset_control_get_optional_exclusive() into probe function +
>    reset_control_deassert() and devm_add_action_or_reset() for tresetn,
>    presetn error path.
>  - Fixed renesas_i3c_remove() from static void to static int]
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
> new file mode 100644
> index 000000000000..432be328a4e4
> --- /dev/null
> +++ b/drivers/i3c/master/renesas-i3c.c
=2E..
> +	/* Initialize Queue/Buffer threshold */
> +	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
> +					     NQTHCTL_CMDQTH(1));
> +
> +	/* The only supported configuration is two entries*/

Add a space before */.

=2E..
> +	/* Hot-Join Acknowlege setting. */
> +	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);

I would not mind consistency in the dots at the end of comment. Normal
convention is not to have them unless comment is a sentence.


> +static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_p=
riv_xfer *i3c_xfers,
> +					 int i3c_nxfers)
> +{
> +	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
> +	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
> +	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
> +	struct renesas_i3c_xfer *xfer;
> +	int i;
> +
> +	/* Enable I3C bus. */
> +	renesas_i3c_bus_enable(m, true);
> +
> +	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
> +	if (!xfer)
> +		return -ENOMEM;

=2E..where is xfer freed?

> +		xfer =3D i3c->xferqueue.cur;
> +		cmd =3D xfer->cmds;
> +
> +		/* Clear the Respone Queue Full status flag*/
> +		renesas_clear_bit(i3c->regs, NTST, NTST_RSPQFF);

Space before */, please.

> +	ret =3D reset_control_deassert(i3c->tresetn);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D reset_control_deassert(i3c->presetn);
> +	if (ret)
## BUG:		return ret;

> +	ret =3D devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_control_=
assert,
> +				       i3c->tresetn);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, renesas_i3c_reset_control_=
assert,
> +				       i3c->presetn);
> +	if (ret)
> +		return ret;

This is wrong, AFAICT. If return happens at marked line, we'll leave
tresetn asserted.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--dzSwizQnf5FmpFZN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWDW8gAKCRAw5/Bqldv6
8u6MAKDC4z89hXJouDzlnT4L2tVO/Gk9uwCdHpzSnrGwy7LEWOC7rUgfJz+x0gI=
=qz5Y
-----END PGP SIGNATURE-----

--dzSwizQnf5FmpFZN--

