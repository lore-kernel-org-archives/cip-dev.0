Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE85C38145
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:44:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4686.1662111855303773103
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ucw.cz header.s=gen1 header.b=hwqnoR6M;
 spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98,
 mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 81E1E1C000B; Fri,  2 Sep 2022 11:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1662111851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoB/4I6irnGsLi+LwbV0oMDZNvHzkUKP0XQBkkHAjEc=;
	b=hwqnoR6M1yTkmE8eIcQwCOsSeK5N8TfQ6ZC3sMSgMNRUuHB8K3SO4KS4g8lv545bakpHIf
	IIYNrov7C9ilXRf+bGtutUnyoyn4rJWnU67hFl5cD18ABVTnfAZ1UGJhUoT55IFsPSXzQ1
	+uo2C3Lhelaew6impSUZhsHKHkQGv4A=
Date: Fri, 2 Sep 2022 11:44:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 4.19.y-cip] drm: rcar-du: Fix Alpha blending issue on Gen3
Message-ID: <20220902094408.GA16210@duo.ucw.cz>
References: <20220830145938.1326295-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94207DE8FE84D5DA082B73A0927B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: 
 <TYWPR01MB94207DE8FE84D5DA082B73A0927B9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:44:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9425


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: LUU HOAI <hoai.luu.ub@renesas.com>
> >=20
> > commit b7aaa61726cbc7b941007af14a9f991a828c67e4 upstream.
> >=20
> > As per R-Car-Gen3_Common_OPC_Customer_Notifications_V30.1.pdf,
> > unexpected image output(such as incorrect colors or planes being
> > invisible) can happen on the below conditions, as PnALPHAR register is =
not
> > initialized by reset.
=2E..
> Looks good to me this patch.
> If there are no other comments and test is ok, I can apply.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6=
28213608

Both this and 5.10 versions look ok to me.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYxHQaAAKCRAw5/Bqldv6
8qwfAKDC5Ir2YxdNzjtnVfxhQbUbhbkbmACghueVGfc4/xMoPPLzadf0eVxpf88=
=89fX
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

