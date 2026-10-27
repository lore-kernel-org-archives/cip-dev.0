Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25515.1793124584231041505
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2026 11:09:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YJ/zfiIV;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99022108C92;
	Tue, 27 Oct 2026 19:09:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793124577;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cfBBsDYW1wa+7EnQFXmfe9YkC1379mdGeoGNivPT/Rs=;
	b=YJ/zfiIV3yNlu2TQ5IfjZIllptQr8ky/nfM5iC1fT1C6YxN7SlW/mlLQgLf88cvQKMp/si
	Jo9kBXn1O4iVlJo4qWXSKWU7+RKleay5f82/wWOdSzCj2hT52NSCogVtyIWp3A+NirFIZa
	a8tAMHONZOtHuFJfzx+TslnMIFKp/40P9v+0S+Zhu6P2WdSphStRq4pWMz3ElFfw5aZf/j
	es7zQTCwzYtDFGf3XLqaFU7P7tGKInfXDnXjLiAaSS5knJxZgFD+XxLSE+9L4S6fL0NCeN
	9QTCw6MM0sstA4m2gqgWthnInGl7M5j6FjUiFSnx+QMW0/ykQtaGswySl5OCXw==
Date: Tue, 27 Oct 2026 19:09:34 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Garpur Hnefill Emiliuson <garpurhnefill.emiliuson.d47@mail.toshiba>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com, uli@fpond.eu,
	claudiu.beznea.uj@bp.renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip] PM: domains: Mark
 dev_pm_domain_allow_detach_on_unbind_cleanup() as inline
Message-ID: <auDo3gtcBmkzjoG5@duo.ucw.cz>
References: <1793085576-6789-1-git-send-email-garpurhnefill.emiliuson.d47@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vrj/zD92En0oTHos"
Content-Disposition: inline
In-Reply-To: <1793085576-6789-1-git-send-email-garpurhnefill.emiliuson.d47@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 27 Oct 2026 18:09:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24552


--vrj/zD92En0oTHos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Building with CONFIG_PM=3Dn and CONFIG_PREEMPT_RT=3Dy triggers a
> -Wunused-function warning for the stub implementation of
> dev_pm_domain_allow_detach_on_unbind_cleanup() in pm_domain.h.
>=20
> This issue only affects the -cip tree. Unlike the surrounding stub
> helpers, this function was not declared inline. Mark the stub
> implementation as inline so unused configurations do not trigger
> compiler warnings.
>    =20
> Fixes: f7c0934b4cc9 ("PM: domains: Add helper to check for PM domain deta=
ch on unbind cleanup")
> Signed-off-by: Garpur Hnefill Emiliuson <garpurhnefill.emiliuson.d47@mail=
=2Etoshiba>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

This looks okay to me. It is also fairly obvious.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply it if it passes testing and there are no other comments.

Best regards,
                                                                Pavel

--vrj/zD92En0oTHos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauDo3gAKCRAw5/Bqldv6
8kUHAKC8atzaCPhMQDmVWHsB2/ao2bgX7wCdH+WwHpSpia2ZRPoC3BHjWlGuVQE=
=phZD
-----END PGP SIGNATURE-----

--vrj/zD92En0oTHos--
