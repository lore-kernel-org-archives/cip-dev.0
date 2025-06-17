Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D4C71157
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 10:20:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15298.1750155648561286148
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 03:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=JdSjMTFg;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBC5E103972B9;
	Tue, 17 Jun 2025 12:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750155646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ig23AJFLaZIkaaKR3PwcFwGHgTcNiSfgDaKptM2toaQ=;
	b=JdSjMTFgbfzflxvmUWBQIPuvzSxLcaI8hiYmp+5K+Fi3Sfcm7Lr/fCl3tQKQrfN6GOVopQ
	yF0EY1QiH455dXkvzcGjBq/gQN6JKa+VG+crKQFYi/UJL2p2YsqzTkqHXZsP3sXTYsR/b5
	keCf6EugJDCsknoRTeAN0tKQJLNsJlXg1cmFzO5oqYZJKQU/dVqfMAFkQogS9fH7eK26Yz
	4yXCrtYf9CW82YGV+yz1gs1OcGVdIIfH1d2ZTUtUtO9oRtGAdftDPRZE7YoT7GLmiUTxXI
	GEuNTOMV7Xg0d9jypBJgBoCJ4ebfDd3h6JATCXle4F9TCjzMYf4zPIPzAXL8yg==
Date: Tue, 17 Jun 2025 12:20:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Indirect Target Selection (CVE-2024-28956) Re: Request for review
 for 4.4-st65, 4.4-cip100
Message-ID: <aFFBeZA4Tnlf3d35@duo.ucw.cz>
References: <1652754680.135113.1750092922654@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKev+WxPvKBBKlkw"
Content-Disposition: inline
In-Reply-To: <1652754680.135113.1750092922654@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 10:20:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19121


--tKev+WxPvKBBKlkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the upcoming 4.4 kernel release. As alway=
s they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/=
linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20
> 8dab9bb642b2e net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
> 6f43c571bf094 of/irq: Fix device node refcount leakages in of_irq_init()
> 7f406a4c1fd70 mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unl=
ock
> d24045205aaa7 media: streamzap: prevent processing IR data on URB failure
>=20
> Thanks for having a look!

Should we add something like this?

Does anyone care deeply about ITS bugs? If so, talk to me, and we can
cooperate on deeper investigation.

Best regards,
								Pavel

---

Document that ITS workarounds are not present in 4.4-cip.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/KNOWN-BUGS b/KNOWN-BUGS
index ec2de4aab685e..b268e54bc96e4 100644
--- a/KNOWN-BUGS
+++ b/KNOWN-BUGS
@@ -19,6 +19,10 @@ architectures.
 Random rewrite from 4.9.320 was not backported. We have seen no good
 explanation why it is needed, and it is rather intrusive.
=20
+Workarounds for Intel Indirect Target Selection (CVE-2024-28956) bugs
+were not backported to 5.10-stable and older, and so are not present
+in here, either.
+
 These commits were not backported and may need more investigation:
=20
 be8173bc1 | mm: fix race between MADV_FREE reclaim and blkdev direct IO re=
ad


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tKev+WxPvKBBKlkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFFBeQAKCRAw5/Bqldv6
8pdhAJ9jZ2XGL+xw0PwQSDspkBTTFB2DnQCgl7CDGRPLgzyQkwa07OPLwAewAew=
=exOd
-----END PGP SIGNATURE-----

--tKev+WxPvKBBKlkw--

