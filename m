Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F229CCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 21:08:21 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.20674.1761685694089083476
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 14:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=H5cmYOjK;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69F701038C10B;
	Tue, 28 Oct 2025 22:08:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761685692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=eDszC7N9Xo1CYpJjMKxyzK1MHV05dwVwWPZ1QvDe6OQ=;
	b=H5cmYOjKPCeQ7nHdOS0+Xvdy5STlugSuIEEJDaHiWYggjPnXOOB2l8E+anw9xArJ5viPpf
	y/H4MXJMz+kniKFEBS2jxYpO6SNnIY200d7rxGMKCqPajir2kGnk6niWLqcjKYYGaH32H4
	nohaS8dtuWl65Z7qQyApi0OmGjSZ26s/v3aGdzGfTskhb+VOD+QedcZIekC03+4lWIJrZG
	4oCnzppZBThczl7zWLtM8FEXlTGEsvpjBl9J3BYz5Lsd61TUQy7IjUsZDTH+B6ucdCm0lf
	EvpXvo08S7TxTNSxFRGN2gTTT7FMqgw42K+/T9e0b+RnQgJ2+VITFrbFYFtfEw==
Date: Tue, 28 Oct 2025 22:08:07 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.4-st69, 4.4-cip104
Message-ID: <aQEwt1csuBOZNtpd@duo.ucw.cz>
References: <1483065062.11009.1761645498941@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9WzW7CuNkJ3wEP29"
Content-Disposition: inline
In-Reply-To: <1483065062.11009.1761645498941@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 21:08:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20267


--9WzW7CuNkJ3wEP29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.4 kernel release. As alw=
ays they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/ci=
p/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
a > d019e4ada7f80 mmc: mvsdio: Fix dma_unmap_sg() nents value
a just a robustness > 86d6a790a96af i40e: fix IRQ freeing in i40e_vsi_reque=
st_irq_msix error path
a just an interface tweak > 67a69099af991 igb: fix link test skipping when =
interface is admin down
a just a LOCKDEP fix, not a minimum one > caeb615c0f733 net: Fix null-ptr-d=
eref by sock_lock_init_class_and_name() and rmmod.
a > c7cf401d1bffb fbcon: fix integer overflow in fbcon_do_set_font
a > 1bdd492e312c1 ocfs2: fix recursive semaphore deadlock in fiemap call
a > 9ba58127984b1 e1000e: fix heap overflow in e1000_set_eeprom
>=20
> Thanks for having a look.

Thank you, patches look good to me.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9WzW7CuNkJ3wEP29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQEwtwAKCRAw5/Bqldv6
8kclAKCWlcddPxL6Ws+SPN+h8pkBJTrQBQCeJ9Oc4Q6k2xRtq+Dpjhf3q6uk5QQ=
=gZSc
-----END PGP SIGNATURE-----

--9WzW7CuNkJ3wEP29--

