Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2093.1793034308927216345
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 10:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YJQwx8TO;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70427106E76;
	Mon, 26 Oct 2026 18:05:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793034303;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WqPTNCDqHmdLe5Zeu1G1u6OzLQNSQKQzKdr9+ye8VgQ=;
	b=YJQwx8TOQIvTo4DkaprNYXZUNvxOWUWseGWDUXrfP+bR39BnMHY49g2Dhnp7UdB2GegIkm
	RQSm7nbECahpQAZckpQWl8YU0qvmgk1ka6UniU5vYiFxZ9q12Lm769Q8E+v9D3hGPa/U9y
	I4494uZMAhNbJ5RfWwXIaoo91+bXcYMI1DFQvl1u3b7txetOx4+u9aXdttNBlixDD8F+c3
	yLhK9/2iDP6/GdkfWh13dbiYEThAl4hkB9v8Ec7H7zYvkxso4toGpW0515UKArnNneukfF
	nw9zmsmwrhqVBaQHnuvVTQz6y8Vrb6PgTaTqGLpfBcBIfgqfDctqogfxAyqasA==
Date: Mon, 26 Oct 2026 18:05:00 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	tommaso.merciai.xr@bp.renesas.com, fabrizio.castro.jz@renesas.com,
	claudiu.beznea.uj@bp.renesas.com,
	cosmin-gabriel.tanislav.xa@renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches
 backported to the CIP kernel
Message-ID: <at-IPN-MRUUGbw3y@duo.ucw.cz>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pfo3SgWam2Feex+y"
Content-Disposition: inline
In-Reply-To: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 17:05:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24548


--pfo3SgWam2Feex+y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is a patch series that fixes CVEs related to patches backported to
> CIP kernel.
> The following CVEs and commits are addressed in this:

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments (but it may be easier for you to apply it...?).

Best regards,
                                                                Pavel

--pfo3SgWam2Feex+y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCat+IPAAKCRAw5/Bqldv6
8h+gAJ9yAw7lOh9gUWOLSJ/D0PGtAHr6NwCcC8yw8Q1i51Ab6Et+w2LUv8Clr7E=
=7Zml
-----END PGP SIGNATURE-----

--pfo3SgWam2Feex+y--
