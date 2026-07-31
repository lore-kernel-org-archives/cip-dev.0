Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDEBC5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 14:28:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7677.1785508108589629139
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2026 07:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=LAdNxAzn;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA44DFF098;
	Fri, 31 Jul 2026 16:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785508102;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TLQOg5/wL58RPd22IoSVT+ptrDu4BQwiYoPU7jHFTZg=;
	b=LAdNxAznq3+qdWSVgfCjahulAV3WyVPpE1H+rQgCLKXcrcPDeha/A9SNEN6YaIR7TyU9YC
	416y8NrJiMz8d//g7aD/gtq4D1y9QYOigSeOYVNZcfbGhNMWduUAP0VOSm5kll1YT25sFb
	xZPGS+89Nwpr+9wrZqjkjCUyj4LFDp/6hnI8UChlJVcvJ9NBMmrq4E2qr8en9MPCXvYhxg
	d1pHk5OgZ/6uGzaewtVtIkEWy1dS3xYEKEV8FgydLMgmaF5KhD7neXqKF7nIPxqV6Ln5an
	4hIvIKAcUrg5K5oYdoWkakT2ux2Ru34iRBUT5jBTah0tubRdJyvOglgax1xgSw==
Date: Fri, 31 Jul 2026 16:28:17 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st19, 4.19-cip135
Message-ID: <amyxAb4e3E7u7EzE@duo.ucw.cz>
References: <527172097.345263.1785165473174@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SeRwUEa92MIJPx7K"
Content-Disposition: inline
In-Reply-To: <527172097.345263.1785165473174@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jul 2026 14:28:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23825


--SeRwUEa92MIJPx7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc

a > 9f05da0b8dcfb Bluetooth: serialize accept_q access

I can see nothing wrong here, but ... this is quite complex and redoes
locking. I see quite a lot of bluetooth changes in stable, and we are
not really testing Bluetooth.

a > b106698c9084b netfilter: nf_queue: hold bridge skb->dev while queued
a > 50387c55b9106 mtd: spi-nor: sst: Fix write enable before AAI sequence
a > afa6edb63cc55 sched: Use u64 for bandwidth ratio calculations
> 43c19f228085a batman-adv: stop tp_meter sessions during mesh teardown
a > 1a36cfc71bae3 Bluetooth: L2CAP: reject BR/EDR signaling packets over MT=
Usig
a > 8bc3105c22af8 net/sched: act_api: use RCU with deferred freeing for act=
ion lifecycle
a > 68d166edfbe56 thunderbolt: property: Reject u32 wrap in tb_property_ent=
ry_valid()
a > 44b20b4fce209 xfrm: esp: restore combined single-frag length gate
> 9118dc9ac0a49 batman-adv: tt: avoid empty VLAN responses
> e0f823e33114c batman-adv: tt: fix TOCTOU race for reported vlans
>=20

Best regards,
								Pavel

--SeRwUEa92MIJPx7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamyxAQAKCRAw5/Bqldv6
8qpmAKCy/F2Au2xZVfrjUdt/jVujumBk/QCgl8y6FGNk1fp+YzaKv56GtNqPvxA=
=UHWM
-----END PGP SIGNATURE-----

--SeRwUEa92MIJPx7K--

