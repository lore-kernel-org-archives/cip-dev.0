Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80886C6FD19
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 10:09:38 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15789.1678442968328514380
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Mar 2023 02:09:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 878AC1C0DED; Fri, 10 Mar 2023 11:09:25 +0100 (CET)
Date: Fri, 10 Mar 2023 11:09:24 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Ulrich Hecht <uli@fpond.eu>, "pavel@denx.de" <pavel@denx.de>
Subject: Re: [cip-dev] Request for reviews for 4.4-st38/4.4-cip73
Message-ID: <ZAsB1OKyZLdyWMrE@duo.ucw.cz>
References: <1010789948.2703824.1677492030810@webmail.strato.com>
 <174ADDD3EF16CBFE.27660@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eTcRZdwxkcS9zQqF"
Content-Disposition: inline
In-Reply-To: <174ADDD3EF16CBFE.27660@lists.cip-project.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Mar 2023 10:09:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10972


--eTcRZdwxkcS9zQqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'd cite commit # being backported on the first one, and I'll need to
> take second look at these:

I'd do "[uli: backport from df02234e6b87d2a9a82acd3198e44bdeff8488c6
to 4.4", but this one looks ok.=20

> ! cite commit # of the patch being backported? > 7672af7c726f ALSA: pcm: =
Move rwsem lock inside snd_ctl_elem_read to prevent UAF

NL_SET_ERR_MSG is there in 4.4, but nowhere in the sch_api.c, so I
believe this one is ok, too.

> ! NL_SET_ERR_MSG? > e6f2bae11168 net: sched: disallow noqueue for qdisc c=
lasses

Best regards,
    		      		   	       			Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--eTcRZdwxkcS9zQqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZAsB1AAKCRAw5/Bqldv6
8uRSAJ4/GnmDwTQvRPR/Z60Ydft0t2cc3gCfTB/k/ux++WsepGCyjw7wp19HS5E=
=drb0
-----END PGP SIGNATURE-----

--eTcRZdwxkcS9zQqF--

