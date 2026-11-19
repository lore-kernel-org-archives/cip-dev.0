Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12457.1795088696003158034
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 03:44:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NBr16VT9;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67A9210E1E4
	for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 12:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795088689; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=tbL5Zxlih/UyfwaPNQen9YsAiwkd3ZVQEp51jHk4sYA=;
	b=NBr16VT93CvbTOxPAjlZP4aHAw3jFFjXItXjFlAa5rs3AUHgAW9RoYDqcyNd3JO7Y+LF2F
	hkxvWtBvqs0OegXKm2o7MigJbKU7oKlwFehgjwxAyNmnzE8I0dVK3xg2pRB6YuNyf0kBFr
	zPULeO7l6UMSi2CxF8JAM3s/UKB6rfzuelit0JeOQCPMXIj81AQ70PLn/ZmPyi2SjaOHM1
	7sah5Ex7j4UX3mJpqf4BOuLQXn4CDUDR1Xt/RFA5DCDJWyUBmHqie4prIDWybNp/P4DozN
	T2+j2vH8jRLvlxiBxJiwa6/+vkenBoza5mo7rathmKAnefGr1IENCuShPITY4Q==
Date: Thu, 19 Nov 2026 12:44:47 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org
Subject: Patch review improvements
Message-ID: <av7hL4LCGQKBZa52@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/4fJBCcjwQpUfAgp"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 11:44:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25014


--/4fJBCcjwQpUfAgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Stable kernels work like this:

There's upstream commit, and there are -stable commits. They reference
the upstream commit in the first line of changelog. If upstream commit
is reviewed in context of 5.10-stable (for example), and diff is same
as in newer -stable kernels, it can be assumed commit is okay for
those kernels, too.

There are "bugfix" and "dependency" commits. Dependencies are often
marked with "Stable-dep-of", and don't seem to follow
stable-kernel-rules.

Commits in -stable have order, and it is useful to review them in
approximately that order, because similar commits are often grouped
together (fixing same bug in 10 drives), and dependencies are often
just before the commit (useful when stable-dep-of is missing).

In past, we could snapshot 5.10-stable, 6.1-stable and 6.12-stable
staging trees in time of 6.12-stable release and get patches to
review. In 2026, we see a patch hitting 6.12-stable, but hitting
5.10-stable after a delay, so that we review 6.12-stable version of a
patch, and only after that corresponding patch hits 5.10-stable tree,
leading to repeated review.

Current scripts I'm using produce output like this:

 |e4ee79fcb 1bc953 .: 6.12| comedi: quatech_daqp_cs: Fix sanity check in interrupt handler
 |65d5bd36a 1bc953 .:  6.1| comedi: quatech_daqp_cs: Fix sanity check in interrupt handler
 |6944f2bfc 1bc953  : 5.10| comedi: quatech_daqp_cs: Fix sanity check in interrupt handler
 |d814c51d3 e90d05 .: 6.12| comedi: das6402: Add sanity check to interrupt handler
 |0ee3cd2f4 e90d05 .:  6.1| comedi: das6402: Add sanity check to interrupt handler
 |a866a62fb e90d05  : 5.10| comedi: das6402: Add sanity check to interrupt handler
 |93e91cbf7 8dda63 .: 6.12| comedi: dt2811: Fix sanity check in interrupt handler
 |8d212cb9b 8dda63 .:  6.1| comedi: dt2811: Fix sanity check in interrupt handler
 |84d53d6f5 8dda63  : 5.10| comedi: dt2811: Fix sanity check in interrupt handler
 |bdbd9d5c9 f876cb .: 6.12| comedi: pcm711: Fix sanity check in interrupt handler
 |d7383c292 f876cb .:  6.1| comedi: pcm711: Fix sanity check in interrupt handler
 |2b1485b47 f876cb  : 5.10| comedi: pcm711: Fix sanity check in interrupt handler

... that shows 4 upstream patches hitting 6.12, 6.1 and
5.10. Unfortunately, it is not easy to cooperate on review with system
like that.

Detecting differences in diffs in 5.10 / 6.1 / 6.12 patch is currently
only done manually.

What I'd like to see would be something like this:

f876cb | comedi: pcm711: Fix sanity check in interrupt handler
...patch is queued for 5.10, 6.1, 6.12 stable
...diff is same between 6.12 and mainline, and 5.10 and 6.1
...it does / does not affect -cip kernel configs
...Pavel reviewed 5.10 version
...Ulrich backported patch to 4.19 with/without changes

It is somehow important to be able to view patches in logical order
(current scripts do that only partly).  It is important that people
can cooperate on reviews, perhaps by marking "I'll likely be working
on these". I would prefer git-based workflow to something requiring
online web access.

Best regards,
								Pavel

--/4fJBCcjwQpUfAgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCav7hLwAKCRAw5/Bqldv6
8nG8AJ9rtyBz34A8WQl4nBtn4lMLqmiUcQCcCBMonqgxplqEYNLKnn5Xd+eqi+E=
=3odo
-----END PGP SIGNATURE-----

--/4fJBCcjwQpUfAgp--
