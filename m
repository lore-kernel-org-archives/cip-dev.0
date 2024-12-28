Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB485E77188
	for <webhook@archiver.kernel.org>; Sat, 28 Dec 2024 20:08:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.34713.1735416517058472964
 for <cip-dev@lists.cip-project.org>;
 Sat, 28 Dec 2024 12:08:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Fb7R/6WB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 147D210408FAF;
	Sat, 28 Dec 2024 21:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1735416514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyupP+HrUOCayGvpMDRdHHAWOyfLhHpvSEdjxr/4w3w=;
	b=Fb7R/6WBFHUyPxEIw29DNB/0MNqaxz9NoJlDhqTggQ+VBB5VhU0pz/jEGtP4m7xqjfD9N3
	WbeOMvL6x1hqrz8rsMzOdAKkY14O5lj1D2XLg4ibElNuxMlbT7c9BlVdLprLw6xjqKq1ll
	UOSGqhrRkt/I/FEV7WFLJ646WDlQ786mGU+xuPFsy6ZTcZH3eM4R8Mor7z1rOHyumeGPde
	xTEV1+9EUmR7RjT8g6Fk27rY2PIHw6w6Jy8P5iRZ3rb10H1DG365VhMCx+Q9+LXTZfTEv1
	WPfyPDr8pPVVsY558AsdnbwcROmDwNEqG7RaU16jrQEvbamYSrnhCMCcZOpYqQ==
Date: Sat, 28 Dec 2024 21:08:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st60, 4.4-cip95
Message-ID: <Z3BavbcAezwkMWZ1@duo.ucw.cz>
References: <295685651.3780611.1735275418169@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z7FQsBV519nGzudh"
Content-Disposition: inline
In-Reply-To: <295685651.3780611.1735275418169@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 28 Dec 2024 20:08:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17498


--Z7FQsBV519nGzudh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the last release based on 4.19. As always=
, they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/=
linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
a just a "performance" fix > 8d8dec49e86e5 ubi: wl: Put source PEB into cor=
rect list if trying locking LEB failed
a not a minimum fix > 0705b897c226f usb: using mutex lock and supporting O_=
NONBLOCK flag in iowarrior_read()
a > f8fe313711e34 vfio/pci: Properly hide first-in-list PCIe extended capab=
ility
a > bab603ffcb9ca Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigge=
r than 4K"
>=20
> Plus the revert for the broken nilfs2 patch:
>=20
a > 67baec71e0577 Revert "nilfs2: propagate directory read errors from nilf=
s_find_entry()"
>=20

Backports look good to me, thank you.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Z7FQsBV519nGzudh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ3BavQAKCRAw5/Bqldv6
8okNAKCaSlN054Y2ra9wRUyTMSuFM6Zm5wCfRaZ82NJ8YlDMZ+8MM/whQKlLaKY=
=5vkg
-----END PGP SIGNATURE-----

--Z7FQsBV519nGzudh--

