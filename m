Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A91CC013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 77D4881E80
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-ElczYBXEhq for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 07:51:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F005181B8E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:51:15 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 872D41C0357; Wed, 19 Feb 2020 08:51:14 +0100 (CET)
Date: Wed, 19 Feb 2020 08:51:14 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219075114.GB31996@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-5-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-5-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 04/23] usb: roles: Find the muxes by also matching against the device node
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
X-List-Received-Date: Wed, 19 Feb 2020 07:51:16 -0000
X-Groupsio-MsgNum: 4405
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline

--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct usb_role=
_switch *sw)
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
> =20
> -static int __switch_match(struct device *dev, const void *name)
> +static int switch_fwnode_match(struct device *dev, const void *fwnode)
> +{
> +	return dev_fwnode(dev) =3D=3D fwnode;
> +}
> +
> +static int switch_name_match(struct device *dev, const void *name)
>  {
>  	return !strcmp((const char *)name, dev_name(dev));
>  }

This renames  __switch_match -> switch_name_match. That is welcome
cleanup for mainline, but not quite neccessary change here. As the
function is static and local to the file, we can live with that,
but I hope you have not had to do extra effort to backport it :-).

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M6PIACgkQMOfwapXb+vKKuQCeLzmtDJeL6VQs2ngFvphF4cBr
iwMAn1t+Hl+Q5G9WKEiPTrUu/m2i+kIf
=Mydp
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

