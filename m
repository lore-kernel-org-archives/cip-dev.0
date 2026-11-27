Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5643.1795817272998255982
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2026 14:07:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=V1bPZUzS;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED49710B6AB;
	Fri, 27 Nov 2026 23:07:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795817266;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kkpDH0s5GDKtHFMPeXowNNX+kHEJh5dyxIDm9Qkv7GA=;
	b=V1bPZUzStaX60panF+uxXYDoy8ZZKDR5tgtR58hrkS9r7V2tqWeQx0cOg/3vnZObpGts8J
	4pC91RPpetjdzAkngW/Xl9XGI1g4/uS2SCsKOSRrSpmY10Te4jF7/XbjYInSftnMHK42+K
	q4HYabMzTJa60NZ7XQu6zwBaVli8oS+52Mmzvkyf8B8BWwqaDWhCjK1QojsemN12GU/x9J
	7+00/hYy6SHiPGq1O22oaF9tVu1R1vx8yudatp+x3R3TXCDFGsvjBzBh1ft6wUj6Ao6rSl
	DuE1qZQXBs32SrfSWK0a4KqqkoYXSnnVtYoiDBOinuxkQ0hbTD3eznFfa7brRQ==
Date: Fri, 27 Nov 2026 23:07:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Greg KH <greg@kroah.com>
Cc: dickson.wu@certik.com, cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@nabladev.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Ulrich Hecht <uli@fpond.eu>,
	Yongchao Wu <yongchao.wu@autochips.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 5.10.y-cip] usb: cdns3: gadget: fix state inconsistency
 on gadget init failure
Message-ID: <awn_K39uYLTg9DWv@duo.ucw.cz>
References: <20261127-cip-cdns3-510c-v1-1-56e5faa149b9@certik.com>
 <2026112729-zips-gargle-7886@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TWFzJmxq5xwSAjKx"
Content-Disposition: inline
In-Reply-To: <2026112729-zips-gargle-7886@gregkh>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 27 Nov 2026 22:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25232


--TWFzJmxq5xwSAjKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Yongchao Wu <yongchao.wu@autochips.com>
> >=20
> > commit c32f8748d70c8fc77676ad92ed76cede17bf2c48 upstream.
>=20
> There's no need to send cip-only patches to the usb public mailing lists
> (or any other lore.kernel.org list).

Could you share some kind of motivation / background why are you doing
this? Do you have product using -cip? Or is it just AI advertising?

There will still be 5.10-stable releases, no? This is not -cip
specific, so I'd preffer this to go there.

Best regards,
								Pavel

--TWFzJmxq5xwSAjKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawn/KwAKCRAw5/Bqldv6
8iJAAKC2O3bD19gBdFxZui2LzsEatqT9lACgp6WXxjp4dAEzNl+e865WW3JByWk=
=caUz
-----END PGP SIGNATURE-----

--TWFzJmxq5xwSAjKx--
