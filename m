Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA72BCFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 11:41:47 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14816.1763984501635681378
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 03:41:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=AvAf6n0l;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE3FF10078562;
	Mon, 24 Nov 2025 12:41:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763984499; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=N2MrcaduCUs6bbYoMT/SnDAG7yT4Ogx5+cNcgM8gmBE=;
	b=AvAf6n0lDMKhqTVIlB6q8GxXcjHqlX1u9hy0Df8rA6NrL6Hu7UJ8EYAOmFXz1jNJhVGgr7
	BTb56okA0nqdFaXwJMDsh8iXkd7poDqScXGlU2pCfOptRwIisk15fHTb5KXjpQY2iTpBR7
	usH1Xqo0yVrPjIxtblQ41vZk+7MqrNGTeJo+CII+CsFs3ApB8qtlqryFgPnv2g5RSbIzpd
	Pzdxnc5hP9hwlmxfhs6J3gN7WQTVque3htPPa7TGlJtRFyOPv6poKRTZphPG3glkSOnedF
	iZWZKysyNLR+CodMdm8S/x00+VzvUVPPi0gCkdipfb9C2f5eiMb5kg4A7z0EWQ==
Date: Mon, 24 Nov 2025 12:41:31 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.4-st70, 4.4-cip105
Message-ID: <aSREa6uOnLbH0y1l@duo.ucw.cz>
References: <88055065.32862.1763642846447@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HrP5fjouVL0BXcGj"
Content-Disposition: inline
In-Reply-To: <88055065.32862.1763642846447@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 11:41:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20713


--HrP5fjouVL0BXcGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
a > 54c5af41f0647 net: ravb: Ensure memory write completes before ringing T=
X doorbell
a > 697d8a82e0984 tracing: Fix race condition in kprobe initialization caus=
ing NULL pointer dereference
a > 21116d340963b KEYS: trusted_tpm1: Compare HMAC values in constant time
a just a robustness> b804b894ade38 mfd: vexpress-sysreg: Check the return v=
alue of devm_gpiochip_add_data()
a > 319a1a1ce7366 KVM: x86: Don't (re)check L1 intercepts when completing u=
serspace I/O
a just a API tweak > 5e4cb116f19af rtc: interface: Fix long-standing race w=
hen setting alarm
a > 8c9a884e8adf5 pwm: tiehrpwm: Fix corner case in clock divisor calculati=
on
a > 0894b95293ccd media: tuner: xc5000: Fix use-after-free in xc5000_release
a > 9d5dd367ddc15 ext4: increase i_disksize to offset + len in ext4_update_=
disksize_before_punch()
>=20
> Thanks for having a look!

Thanks for doing this. Patches look ok to me.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HrP5fjouVL0BXcGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSREawAKCRAw5/Bqldv6
8vw5AKCn1KLpn6+VC3Mmuc8C7VExTtqk3wCeIclrenURqnIEabbIIwDWS++DsgE=
=dY55
-----END PGP SIGNATURE-----

--HrP5fjouVL0BXcGj--

