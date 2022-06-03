Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7873DC433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 06:54:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4552.1654239242772884814
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jun 2022 23:54:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98,
 mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5885E1C0B9B; Fri,  3 Jun 2022 08:53:57 +0200 (CEST)
Date: Fri, 3 Jun 2022 08:53:56 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, theflamefire89@gmail.com
Subject: Re: [cip-dev] Followup to "nfc: st21nfca: Fix potential buffer
 overflows in EVT_TRANSACTION" #cip
Message-ID: <20220603065356.GA13963@duo.ucw.cz>
References: <Tbun.1653035720797762715.tMvS@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <Tbun.1653035720797762715.tMvS@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 06:54:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8481


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First, thanks for reaching us over email.

> I noticed that the mentioned patch (https://git.kernel.org/pub/scm/linux/=
kernel/git/cip/linux-cip.git/commit/?h=3Dlinux-4.4.y-st&id=3Db2df16de20b3f2=
ee6dbaf86b474e1bd87ddd8d51) made it into various CIP branches, e.g. linux-4=
=2E4.y-st.
> It fixes potential OOB writes.
> However it also introduces memory leaks due to the new return statements =
leaking the allocated `transaction`, i.e. it misses a ` devm_kfree (dev, tr=
ansaction);` in those cases.
> Furthermore there is also a logic error and potential OOB read issues whi=
ch are fixed in various Android kernel forks. See e.g. https://android-revi=
ew.linaro.org/plugins/gitiles/kernel/hikey-linaro/+/bf7ef8f2d57cd1f5f1846dd=
58ff9309efad58252
>=20
> I haven't found patches for that in the upstream kernels and I do not kno=
w the policy regarding such issues / not-yet-upstream patches.
> Anyway, those issues exist and at least for some there are patches and ad=
ding the missing devm_kfree is trivial, so I wanted to make you aware of th=
at.
>

Yup, those issues seem to be real. We'd preffer not to take fixes that
are not upstream, and this is not too severe bug. (Should the skb be
freed in the error paths, too?)

I have sent an email, and it seems fixes are pending.

Best regards,
								Pavel
PS: I'm cc-ing you, in case you are not subscribed to the list.
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYpmwBAAKCRAw5/Bqldv6
8qTpAJ4/WSQj9jPEprdXlE3CZjlxhWpNKwCgtDpLWEFkLNHzk5fvUvcwW2YoDVk=
=Ba1v
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

