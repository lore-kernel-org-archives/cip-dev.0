Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77836C3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 07:36:49 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.7872.1743665806444302514
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Apr 2025 00:36:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PUuLCWQw;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFDE610298354
	for <cip-dev@lists.cip-project.org>; Thu,  3 Apr 2025 09:36:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743665804; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=tVf8o+dMD31wWhOdZe9fasZCqmVWdsmmnEFpAXnHxk4=;
	b=PUuLCWQwg2Lgbdc6WsbbP3kXMxV7gHpI2mjYmnXn4S2IT6U+/eLnpoCwAPI0pJ/3CWSPPJ
	2KNVhUOxgHV7nHSA8zn/v26mMBhCnAr/MnvjWkIqIU7pt3FLJEdYqxWrY+XyHNpjec8vbm
	aFdV+f1HFa6V63lR78ApBdWHHZ4jtWmX7W/dRByrjNkTz4CmqguaoM0rkJcFYE5XSj47Gt
	2cd0uQjEQASF+RdBfZgE5mxn+46geTfYDvoq1DU7G7KnqZW6VmsNtZCrW9MmEqef9Eb2dH
	U1v6FiEvAln0qjPZA5Bb1iklpeCxKa8/pwDj9xdyT44ipcdiUGN+o3fggRqUNg==
Date: Thu, 3 Apr 2025 09:36:39 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <Z+46h0Cto81AMDrH@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xwNDbKvtQqre6BOb"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Apr 2025 07:36:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18458


--xwNDbKvtQqre6BOb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mont=
h=3D4&day=3D3&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

(Warning, there was dst change in parts of world).

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/03/cip.2025-03-27-1=
3.01.log.html

* Action items
  - share release scripts/procedures [iwamatsu-san]
  - ask for adjusting reply-to setting on CIP MLs [jan]
* Kernel maintenance updates
* Kernel release status
* Kernel testing
* AOB

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xwNDbKvtQqre6BOb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+46hwAKCRAw5/Bqldv6
8sqnAJ9pfhli8dMu5yz8MxjuHWxOLKZL6ACeI53HbMTtDUbegxXp1+sQgseaf1c=
=Qc7E
-----END PGP SIGNATURE-----

--xwNDbKvtQqre6BOb--

