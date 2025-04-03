Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2611EC3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 19:42:35 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4538.1743709353854559264
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Apr 2025 12:42:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FdI07JkE;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 498741026A6D3;
	Thu,  3 Apr 2025 21:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743709351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fKa3BoixPJJC6YTNM2G4/HbUcLQIg4Zd5qJlRRlJwm0=;
	b=FdI07JkESOeq0tUsh9t7CNgraoKoFKjYVRqBXAfbzvkS+YCLuukKrXPduHE1WyhRnPIjCM
	y39Ecvi1d7dPNwaZ0WAqrCqq7IFx+1btbpqCrfkehc0tuN2EXby+gTzX1ICAF8usBkR40r
	HggLn0hWgG4sbo4i8qNlS5Rt1dlA3hO+1IVVxe43chDXayWVfpomP1QFkMQ2zGuUUISQW0
	JfuD8srS3Z3pNJ5t5RUd0Uslpv1xAzBbWu3lP+nf7tZUS72yqT0Pkgy64rsBNGyCYGab0f
	wHktbl7S/YHXM+VAWLkAxsT7y+Qt2IBJL/qvkbp8Z+td3M9y/PyZ0s2dPuYmQQ==
Date: Thu, 3 Apr 2025 21:42:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.19-st3, 4.19-cip119
Message-ID: <Z+7koix0J70LOPhF@duo.ucw.cz>
References: <717776371.819202.1743673424632@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8m3uXYDBkRbJmuK"
Content-Disposition: inline
In-Reply-To: <717776371.819202.1743673424632@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Apr 2025 19:42:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18463


--d8m3uXYDBkRbJmuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the upcoming 4.19 kernel release. As alwa=
ys they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

Thank you. Most patches look ok. But lets drop "wifi: rtlwifi: remove
unused check_buddy_priv" -- it does not really fix a bug -- it is just
a cleanup -- and it will break drivers/staging/rtlwifi/pci.c AFAICT.

Best regards,
								Pavel

a > 1b1e6b6e3290 net: gso: fix ownership in __udp_gso_segment
a > 6ba7acd180fd gpio: rcar: Fix missing of_node_put() call
a > d643f3984b9a batman-adv: Drop unmanaged ELP metric worker
a > b53c91a6173a tee: optee: Fix supplicant wait loop
a not a minimum fix, quite long > e1705bb093cc pps: Fix a use-after-free
a > f3b89c9ef6c1 net: rose: lock the socket in rose_bind()
a > 7b102256a506 btrfs: fix use-after-free when attempting to join an abort=
ed transaction
a > c283df6d5cce media: lmedm04: Handle errors for lme2510_int_read
!! lets not do this. drivers/staging/rtlwifi/pci.c > d4ddd1298e3b wifi: rtl=
wifi: remove unused check_buddy_priv
a > f71199fc4170 wifi: rtlwifi: rtl8192se: rise completion of firmware load=
ing as last step
a just a interface tweak > a63a48e6da4e x86/cpu: Properly parse CPUID leaf =
0x2 TLB descriptor 0x63
a > 4b60501002d7 usb: dwc3: Fix timeout issue during controller enter/exit =
=66rom halt state


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--d8m3uXYDBkRbJmuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+7kogAKCRAw5/Bqldv6
8hTWAKCPIw+NZCRtPzSBhNOmLtLcFc1wGwCgtEp1o85rHXcVBJTAASMYEmiS010=
=5eNx
-----END PGP SIGNATURE-----

--d8m3uXYDBkRbJmuK--

