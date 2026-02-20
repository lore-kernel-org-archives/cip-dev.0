Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D579C5CFF1
	for <webhook@archiver.kernel.org>; Fri, 20 Feb 2026 22:40:01 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9541.1771627193541956429
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Feb 2026 14:39:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cOSWYbaL;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 498D2110BF7;
	Fri, 20 Feb 2026 23:39:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771627191;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=o8xdmHkI6kAGr1OFWavzBVFCJobVbPqD0Bfqzc0EJU8=;
	b=cOSWYbaLFq0hcCATlSs4n85kzxRLG4KHRNpRi/srMgWKAywZZPnSV9kcSyySUV1tzNZwF+
	cxMZGGCzb7s63z4GKQoP0l+FrcYvjUGyfriuC/A8C6T8arkqP27DO7ayQGynZaI3BsHr/p
	d2rN+kydO25L9gGnn/HuWOAyjUJVVzkP0b1TrONvPQsyYGABGP5zNu5M2f582SVm16ylqi
	d0rh0kRfcpRPevkI4jN4gohSO7i1J/gYRb9DqkvxMKpX6+O269Vaz4Xfa2op/zHg46FoMI
	BrIUi7zrxieosPQ22qzNB5PgoG2wfK21D4XmvUw1hVqK6sQ+ODfvZGUJzQeo9Q==
Date: Fri, 20 Feb 2026 23:39:46 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st13, 4.19-cip129
Message-ID: <aZjisoxIDzMr2vpk@duo.ucw.cz>
References: <1504945381.404757.1771569526446@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+lJUnhtLLKiKpbO0"
Content-Disposition: inline
In-Reply-To: <1504945381.404757.1771569526446@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Feb 2026 22:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21903


--+lJUnhtLLKiKpbO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
a > 797ce10e2a2f1 macvlan: fix possible UAF in macvlan_forward_source()
a > 85f1f9ce40bf7 HID: uclogic: Correct devm device reference for hidinput =
input_dev name
a > 0c110bc67bd3d xfs: set max_agbno to allow sparse alloc of last full ino=
de chunk
a > 6a8957a06bc31 l2tp: avoid one data-race in l2tp_tunnel_del_work()
>=20

Thank you, this series looks okay to me.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--+lJUnhtLLKiKpbO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZjisgAKCRAw5/Bqldv6
8uXuAJ0SRkK6+lNhgeBDAwQcrCyNjWxJqACcCXXYKiWn0VMB5T/ulP4NrK/WzK8=
=ncZW
-----END PGP SIGNATURE-----

--+lJUnhtLLKiKpbO0--

