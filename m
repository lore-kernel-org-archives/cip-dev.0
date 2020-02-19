Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D331C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6913D204E8
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mBdHRgVNV46 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 07:56:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 09AC5203BB
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:56:32 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id E26081C0141; Wed, 19 Feb 2020 08:56:30 +0100 (CET)
Date: Wed, 19 Feb 2020 08:56:30 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219075630.GC31996@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-6-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-6-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 05/23] usb: typec: Find the ports by also matching against the device node
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
X-List-Received-Date: Wed, 19 Feb 2020 07:56:34 -0000
X-Groupsio-MsgNum: 4406
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline

--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
> commit 6a0bbcf96b2273f110a14d11a5952527c5921191 upstream.
>=20
> When the connections are defined in firmware, struct
> device_connection will have the fwnode member pointing to
> the device node (struct fwnode_handle) of the requested
> device, and the endpoint will not be used at all in that
> case.

>  static void *typec_port_match(struct device_connection *con, int ep, voi=
d *data)
>  {
> -	return class_find_device(typec_class, NULL, con->endpoint[ep],
> -				 __typec_port_match);
=2E..
> +	dev =3D class_find_device(typec_class, NULL, con->endpoint[ep],
> +				typec_port_name_match);
> +
> +	return dev ? dev : ERR_PTR(-EPROBE_DEFER);
>  }

So... this adds handling in fwnode !=3D NULL (expected, okay with me),
but it also changes behaviour in fwnode =3D=3D NULL case: return value
changed from NULL to ERR_PTR(-EPROBE_DEFER). Are all callers ready to
handle the changed situation in -cip? Could we get some explanation
why it is neccessary/good idea?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M6i4ACgkQMOfwapXb+vLMVgCfd68NvGRsJ5SKhBHVj0OrogWN
QA4An30ac23wIN/IxpFB+0U+fBcOEC7I
=9XNS
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--

