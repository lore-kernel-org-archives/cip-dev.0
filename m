Return-Path: <SRS0=tHzx=4L=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0713C35666
	for <cip-dev@archiver.kernel.org>; Sun, 23 Feb 2020 20:11:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1F120656
	for <cip-dev@archiver.kernel.org>; Sun, 23 Feb 2020 20:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1F120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E5AE220384;
	Sun, 23 Feb 2020 20:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WAaNFalnDoJ; Sun, 23 Feb 2020 20:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F1F52000D;
	Sun, 23 Feb 2020 20:11:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BB96C0177;
	Sun, 23 Feb 2020 20:11:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF76BC0177
 for <cip-dev@lists.cip-project.org>; Sun, 23 Feb 2020 20:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE46486F5C
 for <cip-dev@lists.cip-project.org>; Sun, 23 Feb 2020 20:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28GhGHYbamnN for <cip-dev@lists.cip-project.org>;
 Sun, 23 Feb 2020 20:11:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0AF6486F3F
 for <cip-dev@lists.cip-project.org>; Sun, 23 Feb 2020 20:11:33 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 5CB0B1C0370; Sun, 23 Feb 2020 21:11:30 +0100 (CET)
Date: Sun, 23 Feb 2020 21:11:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200223201129.GA24510@duo.ucw.cz>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582303929-5773-2-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582303929-5773-2-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 01/22] device connection: Add
 fwnode member to struct device_connection
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5175114898982265572=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============5175114898982265572==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
> commit 09aa11cfda9d8186046bcd1adcd6498b688114f4 upstream.
>=20
> This will prepare the device connection API for connections
> described in firmware.

Ok, I made you do this. Sorry. I assumed it you'd just audit
initializers. I suggest to take this, anyway, but:

> +++ b/drivers/extcon/extcon-axp288.c
> @@ -446,6 +446,7 @@ static struct platform_driver axp288_extcon_driver =
=3D {
>  };
> =20
>  static struct device_connection axp288_extcon_role_sw_conn =3D {
> +	.fwnode =3D NULL,
>  	.endpoint[0] =3D "axp288_extcon",
>  	.endpoint[1] =3D "intel_xhci_usb_sw-role-switch",
>  	.id =3D "usb-role-switch",

This one is not neccessary as struct initializers are "filled" with 0s
when no other value is present.

> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/=
x86/intel_cht_int33fe.c
> index f40b1c19..1fa77e4 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -175,15 +175,19 @@ static int cht_int33fe_probe(struct platform_device=
 *pdev)
>  			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>  	}
> =20
> +	data->connections[0].fwnode =3D NULL;

And these should be already zero-initialized by

	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);

Anyway, extra initializations will not hurt.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlLccQAKCRAw5/Bqldv6
8tXrAJwO9O/IdAEXBH+PnikkCSI9YbWFBgCePTcDJJpaqozQ8uI3bVbg9cRIkQg=
=8fgd
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--===============5175114898982265572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============5175114898982265572==--
