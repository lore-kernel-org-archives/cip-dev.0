Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED9BC25B10
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 20:52:23 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.2065.1715028732148019430
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 13:52:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E2F111C007F; Mon,  6 May 2024 22:52:08 +0200 (CEST)
Date: Mon, 6 May 2024 22:52:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st52, 4.4-cip87
Message-ID: <ZjlC+L8DJCaUqtk+@duo.ucw.cz>
References: <1349258714.2876496.1714933279789@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YCa1ZsE6ank4amhn"
Content-Disposition: inline
In-Reply-To: <1349258714.2876496.1714933279789@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 20:52:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15846


--YCa1ZsE6ank4amhn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>

Let me take a look. Most patches, look good, but I believe vxlan needs
to do goto out, not direct return -- see !! note below.

a | c8686c014 39cdb6 o+ | vt: fix memory overlapping when deleting chars in=
 the buffer
a | 590441121 339f83 o+ | usb: cdc-wdm: close race between read and workque=
ue
a just an interface tweak | 116b0e8e4 e26d30 o  | netfilter: nf_tables: dis=
allow timeout for anonymous sets
a | b8f1a89a2 7633c4 o+ | ipv6: fix race condition between ipv6_get_ifaddr =
and ipv6_del_addr
a | 88b00d18a 0958b3 o  | Revert "tracing/trigger: Fix to return error if f=
ailed to alloc snapshot"
a just a softlockup workaround | a9a5d0706 f8bbc0 o+ | tun: limit printing =
rate when illegal packet received by tun dev
a | 894d5fe38 cf92bb o+ | drm: nv04: Fix out of bounds access
a | 4908a696d c8d2f3  + | speakup: Avoid crash on very long word
!! wrong this needs goto,  ... | 5b56e2b0f f58f45 o+ | vxlan: drop packets =
=66rom invalid src-address
a | ff7599067 54c4ec .+ | serial: mxs-auart: add spinlock around changing c=
ts state
a | 068e635e2 2f7ef5 o  | btrfs: fix information leak in btrfs_ioctl_logica=
l_to_ino()

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YCa1ZsE6ank4amhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZjlC+AAKCRAw5/Bqldv6
8jVQAJ0aiS/bXqkDkV7zU2UtwU8Y/tLjTgCdFCkJc914xY6aELdmnFPd+rw2sic=
=2g16
-----END PGP SIGNATURE-----

--YCa1ZsE6ank4amhn--

