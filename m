Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99113C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8882885D70
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:42:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vn6Fo7__Laqe for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 07:42:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 51561845DB
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 07:42:35 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 2BD471C0141; Wed, 19 Feb 2020 08:42:33 +0100 (CET)
Date: Wed, 19 Feb 2020 08:42:32 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219074232.GA31996@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-2-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-2-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 01/23] device connection: Add fwnode member to struct device_connection
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
X-List-Received-Date: Wed, 19 Feb 2020 07:42:36 -0000
X-Groupsio-MsgNum: 4404
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline

--EVF5PPMfhYS0aIcm
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

> @@ -753,11 +753,17 @@ struct device_dma_parameters {
>   */
>  struct device_connection {
> +	struct fwnode_handle	*fwnode;
>  	const char		*endpoint[2];
>  	const char		*id;
>  	struct list_head	list;

Ok, so this really needs to be 0-initialized in all cases, or we'll be
breaking existing setups. Are we reasonably sure that's the case?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M5ugACgkQMOfwapXb+vKr3ACgjQEl3BUJjmeW+Fhb0dYHKxvO
NfsAn1oAG21szrBwYvVXV19iN4bwACOb
=dhr2
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

