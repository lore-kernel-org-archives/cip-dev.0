Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC5DC5AE59
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 10:57:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4636.1749121054335496584
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jun 2025 03:57:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TNQp9mYU;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7121C10397298;
	Thu,  5 Jun 2025 12:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749121052; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aYie6XmBtvRYsXNCdzUCeIuNddRgigzvHrXn4I/w408=;
	b=TNQp9mYU9yl0jmkBOjDLyvZV3rA6z12i5GplMgvEvoQLshzntDQ4KD/c/CnKGUt/0MChgw
	ns9hVMqk+qUkMD9AlpE6c79UOqkpQtA5tAjlDPHLE5kMQCuY8UY/o+59MlMvNm9is6nG0A
	Ue6eE/95e1e3LTtYYz1jwM6gy/FbtD3eagprmwkN7NX+bBwN4NWZbUadQ3fCpy6U7dpKDW
	mZEqfEV854R+6gOE1nRS9RNM4xEU06/oYjeTN9EMKC3lNgfdYlw1sQ3RWdQm29ukRKKPR3
	za7svBB/ruBa8BXZy3nqdgTweHxTOGrimlpgWn5ikQgTSyDqeLA7dkQONXbBUw==
Date: Thu, 5 Jun 2025 12:57:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.19-st5, 4.19-cip121
Message-ID: <aEF4GNNiA2JOWcxQ@duo.ucw.cz>
References: <1295692742.168185.1749115407487@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oQTAGU2D51804cMH"
Content-Disposition: inline
In-Reply-To: <1295692742.168185.1749115407487@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jun 2025 10:57:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19022


--oQTAGU2D51804cMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>=20
> 4e1c5d6453080 x86/bugs: Don't fill RSB on VMEXIT with
> eIBRS+retpoline

This one is wrong, AFAICT. Mainline does not have

-       case SPECTRE_V2_EIBRS_LFENCE:

line, and neither should we AFAICT.

> 97dc5628cba1a clk: check for disabled clock-provider in of_clk_get_hw_fro=
m_clkspec()
> 43222f234ff0b PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX

These look good to me.

Thank you and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oQTAGU2D51804cMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEF4GAAKCRAw5/Bqldv6
8pihAJ9xA2FT5EJCY7y/We0iyPvc15NmvQCdH24Mivh8zo0BAAexEv+qBRE56lw=
=LzxT
-----END PGP SIGNATURE-----

--oQTAGU2D51804cMH--

