Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EBCCA0EFC
	for <webhook@archiver.kernel.org>; Sun, 24 Aug 2025 18:33:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.22428.1756060404126337227
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Aug 2025 11:33:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ucw.cz header.s=gen1 header.b=sphFYsHX;
 spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 52E0A1C008E; Sun, 24 Aug 2025 20:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1756060401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0d1OvDpeqmJqZshSbjkQa9Rb03kYeDEalfRAgbZdt4=;
	b=sphFYsHXvip18rmTk5x8NQoVEHJnsDHCTUf4XkFH5zrrnYG3AYE/L5D/97wIQjEdYqCHAS
	qVyY6OSfM2HRuifAKT7rvHCwRrohiFamqRLujOIXCcIs+pBnQ1ul4sGSdaHh18jErigH3o
	Vx15cItBSiC6xTze03dFnCZ/VDNS6X8=
Date: Sun, 24 Aug 2025 20:33:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.4-st67, 4.4-cip102
Message-ID: <aKta6ClE4uLoNw7J@duo.ucw.cz>
References: <1277181115.2080.1755954343886@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n7uCStKLW2B3D/pA"
Content-Disposition: inline
In-Reply-To: <1277181115.2080.1755954343886@webmail.strato.de>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Aug 2025 18:33:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19958


--n7uCStKLW2B3D/pA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
a not sure -ENOSPC is right error code for that, but... > 229eae116b5c0 mtk=
-sd: Prevent memory corruption from DMA map failure
a > 06c0a5014dae5 btrfs: don't abort filesystem when attempting to snapshot=
 deleted subvolume
a > f9842f07b9a20 net: ipv6: Discard next-hop MTU less than minimum link MTU
a > fc8b9ad41b46e atm: clip: Fix potential null-ptr-deref in to_atmarpd().
a > a527c7ac6068a mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepare=
d data
a > deaec106a3477 ceph: fix possible integer overflow in ceph_zero_objects()
a > d3fac163823b7 HID: wacom: fix kobject reference count leak
>=20
> Thanks for having a look!

They look good to me. That -ENOSPC should probably be something else,
but I don't think we need to worry.

Thanks and best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--n7uCStKLW2B3D/pA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKta6AAKCRAw5/Bqldv6
8maTAJ4z14z6HuZ2Ji2iAcVyZ7jrCGMTOwCfUZAV5naK9B0FcAnM/UUGQy4TolI=
=1qZt
-----END PGP SIGNATURE-----

--n7uCStKLW2B3D/pA--

