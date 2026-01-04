Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60285C2A070
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 23:54:46 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46737.1767547771091344121
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jan 2026 09:29:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=hKLyW+dN;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 935E2FFF10;
	Sun,  4 Jan 2026 18:29:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767547769;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RFjIhXCArRHw19qiMZdrcZWytcdqvmebysq6VmTGqNw=;
	b=hKLyW+dNdP2wZcFstGstqxibVD+wEO7d1NNMKjgEcD9kTgJGp8CgOv6PWcHYDVF4qkoOXE
	0/dLu2f59RbzA4cdia6EhSytQ7RvM+eDk8qhctrOKC5ivsj5pcY0SalAre9f1nUIAXa/R3
	3qiDq66bZ0D4lpCRTiHPzB1lG15ZbU+cncQP0MLHyFZZ6VexuyMI2TtwfaK6nSLkFJxlhs
	JBSgbhyzdoxe+v4fGzklX5Nt2rHxBjAGYoMiWNxgC1ena8VJiCH4/+dsd2Fyo4kmIxTLv2
	Gf/uTJC5b+wLb3lmT9lhl+iB7fhNXmY698CFEaZ1yIWqDBykxjlJCbJb/pWNuQ==
Date: Sun, 4 Jan 2026 18:29:27 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] net: stmmac: Fix EEE-related issues
Message-ID: <aVqjd7TiG82mDTC5@duo.ucw.cz>
References: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
In-Reply-To: <20251229083954.3598-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YXMoPxElRIPxzSVN"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jan 2026 23:54:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21301

--YXMoPxElRIPxzSVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> When testing Ethernet on the Renesas RZ/V2H and RZ/V2N platforms with
> 6.1-cip, LPI interrupt storms and VLAN register access timeouts were
> observed.
>=20
> Both issues are caused by the RX clock stop feature being enabled by
> default. When EEE is active and the link is idle, the PHY stops the
> RX clock to save power. However, the stmmac hardware requires the RX
> clock to be running when accessing certain registers.
>=20
> More specifically, VLAN operations fail with:
>=20
>     # ip link add link end1 name end1.5 type vlan id 5
>     15c40000.ethernet end1: Timeout accessing MAC_VLAN_Tag_Filter
>     RTNETLINK answers: Device or resource busy
>=20
> Also, LPI interrupt storms occur because the RX clock may be stopped when
> the driver attempts to clear the pending interrupt. The interrupt is
> not cleared and keeps re-triggering until the RX clock resumes.
>=20
> A comprehensive overview of RX clock related issues in stmmac can be
> found in these threads:
> https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideas=
onboard.com/
> https://lore.kernel.org/all/Z9ySeo61VYTClIJJ@shell.armlinux.org.uk/
>=20
> These issues are already fixed in mainline. This series backports the
> relevant stmmac EEE fixes to 6.1-cip.

I had a minor comment here, but that should be fixed in mainline,
first, so should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--YXMoPxElRIPxzSVN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVqjdwAKCRAw5/Bqldv6
8ujlAJ9DXp6e1azWIQPH1v8nze39OGz1MwCfQXuuhpuUwzrvLWToIBqnL9ChqzU=
=4NDg
-----END PGP SIGNATURE-----

--YXMoPxElRIPxzSVN--

