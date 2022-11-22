Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F31C4332F
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 10:01:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.15007.1669111259403667462
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Nov 2022 02:01:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 988251C09DB; Tue, 22 Nov 2022 11:00:53 +0100 (CET)
Date: Tue, 22 Nov 2022 11:00:53 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] 4.4-st-rc updated with patches up-to 4.9.328
Message-ID: <Y3yd1dtgnmcMKQu6@duo.ucw.cz>
References: <Y3Ea4T2hx8Sq/CdK@duo.ucw.cz>
 <1082906324.934329.1669076853699@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k/21GEn2ir6eX8tK"
Content-Disposition: inline
In-Reply-To: <1082906324.934329.1669076853699@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 10:01:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10066


--k/21GEn2ir6eX8tK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Results were pushed to -st-rc.
>=20
> I have reviewed the new commits.
>=20
> "fbdev: fb_pm2fb: Avoid potential divide by zero error" has been applied =
twice.
>=20
> Other than that, everything looks good to me.

Thanks a lot for the review. And... good catch, problem seems to be in
4.9, too. Do you want to talk to Greg to get it fixed? (I can do it,
but this way you get the credit :-) ). It is just a bit of extra code,
so I will not specifically fix it here. (Should mean faster 4.4
release).


        if (lpitch * var->yres_virtual > info->fix.smem_len) {
                DPRINTK("no memory for screen (%ux%ux%u)\n",
                        var->xres, var->yres_virtual, var->bits_per_pixel);
                return -EINVAL;
        }

	if (!var->pixclock) {
                DPRINTK("pixclock is zero\n");
	        return -EINVAL;
        }

        if (!var->pixclock) {
                DPRINTK("pixclock is zero\n");
                return -EINVAL;
	}

	if (PICOS2KHZ(var->pixclock) > PM2_MAX_PIXCLOCK) {


Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k/21GEn2ir6eX8tK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY3yd1QAKCRAw5/Bqldv6
8lamAJ41A6CFxGmhY84yRJQVu8L3sHiuWQCfbrUXJpxt4pyog4NS2VKBzo3A/HI=
=vC0E
-----END PGP SIGNATURE-----

--k/21GEn2ir6eX8tK--

