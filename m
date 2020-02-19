Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D50E2C08A0
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CBE682001A
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoVLq-YEncSC for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 08:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 0266F20017
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 08:16:28 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 97F371C0141; Wed, 19 Feb 2020 09:16:27 +0100 (CET)
Date: Wed, 19 Feb 2020 09:16:27 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200219081627.GE31996@amd>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-18-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582034720-5249-18-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [PATCH 4.19.y-cip 17/23] usb: typec: add dependency for TYPEC_HD3SS3220
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
X-List-Received-Date: Wed, 19 Feb 2020 08:16:29 -0000
X-Groupsio-MsgNum: 4408
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline

--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-02-18 14:05:14, Marian-Cristian Rotariu wrote:
> From: Mao Wenan <maowenan@huawei.com>
>=20
> commit da4b5d18dd949abdda7c8ea76c9483b5edd49616 upstream.
>=20
> If CONFIG_TYPEC_HD3SS3220=3Dy, CONFIG_USB_ROLE_SWITCH=3Dm, below errors
> can be found:
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
> hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
> hd3ss3220.c:(.text+0x154): undefined reference to `usb_role_switch_set_ro=
le'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
> hd3ss3220.c:(.text+0x294): undefined reference to `usb_role_switch_set_ro=
le'
> hd3ss3220.c:(.text+0x2f4): undefined reference to `usb_role_switch_set_ro=
le'
> hd3ss3220.c:(.text+0x348): undefined reference to `usb_role_switch_set_ro=
le'
> hd3ss3220.c:(.text+0x390): undefined reference to `usb_role_switch_set_ro=
le'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
> hd3ss3220.c:(.text+0x5e8): undefined reference to `fwnode_usb_role_switch=
_get'
> hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
> make: *** [vmlinux] Error 1

I guess it is okay here, but for more serious bugs it would be nice to
merge the buggy patch with a fix -- not to break bisect.

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5M7tsACgkQMOfwapXb+vKAXACeMsFnlKzuxHwMwYQFsdRjBOso
8mQAn1TXAIpuScTdU5ay6K2n0npm1YmY
=ft9z
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--

