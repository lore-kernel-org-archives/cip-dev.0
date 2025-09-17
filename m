Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D1CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 09:57:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.18935.1758103010691501725
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 02:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hjDe4efF;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE1401038C113;
	Wed, 17 Sep 2025 11:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758103009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iZf/wes9RSdeF7qoCFDh0hu+178fXgb2qkZcMyQs578=;
	b=hjDe4efFE6tv3AqV5m0jA0eRm7hiATBO3hZpsuPKSr9y4dQnkfwLWO1K8UCBQTzHufnw2w
	AEjzqDaAxpW72mdwvF0lE9OACuRoX6jnEP3pYevtPPklsYAYsToxfK2S0uxenv/wYGX/pQ
	0JknR0r82pqrLF1CfLQWTRfvSDICNlKid/lXDgcuuhDxj/JSwiMVUXDpfakkyZgWL4whym
	QyG4/pJWgt+G9FkrNsR+zLim11DLzcRlsAxiMPysNwM/I36ymNU+7F1QGakV36slYcqfhE
	zZegGoxn7SZKKO2WJVYX3UPxmY+PdtGMjIyNi1kvJq2e/ymphAwNez9geHQGVA==
Date: Wed, 17 Sep 2025 11:56:44 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: Re: 5.10, 6.1-rt
Message-ID: <aMqF3GAHMqMD8wba@duo.ucw.cz>
References: <aME9OVprzmQL4E/A@duo.ucw.cz>
 <TY7PR01MB14818A575FEA1E5F9C91B705FCD0EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ymcHujhdihi2GfL1"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818A575FEA1E5F9C91B705FCD0EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 09:57:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20074


--ymcHujhdihi2GfL1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > There's 5.10.242-rt136 out. Could I get matching 5.10.242-cipX, or is i=
t okay if I
> > create one?
>=20
> Thanks, please go ahead.

And it looks like v6.1.151-rt54 is out, too. If it is not a problem,
I'll create 6.1.151-cip release and use that as -cip-rt base.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ymcHujhdihi2GfL1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMqF3AAKCRAw5/Bqldv6
8oJbAJ0YOUR8EbKSOHW4unp0CmZeNDURgQCfci+P48HsIpX81DlZSKJrGRwU4WA=
=n9Zb
-----END PGP SIGNATURE-----

--ymcHujhdihi2GfL1--

