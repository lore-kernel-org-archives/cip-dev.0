Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8892.1793270182498508869
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 03:36:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=A+cROL+1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 059D91066CF;
	Thu, 29 Oct 2026 11:36:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793270176;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iG05/AY9AVdiyHGQCJOnas4rUHlhiYaP+DRYW4XZwjA=;
	b=A+cROL+1hdeqIrcM6kIpP5G+fE6IeLgLnId1zp+FMymeexfphTR9o1cMFKvAzyaPdsGME1
	8JT1CcU5y0eKSoBlediSaCiechHatrQXokHCsJoxLUjYqu0cAdCR6j6XMjZzAOW10gCT+4
	CF6ApC77CqsVM3TpnDU56Lt9iIZ4JbGMGm9KGmzze8nS3ML2QhcLbahnRELBlJwQHsHLZd
	9nQitH6LQjMaqH1pr5DBJ0xAsHzCyNsi0qloJZmum9eIud2J6sqVEcEPCq4oi251GTrCCa
	lJb+G310BromvsmAzf5Z2X1S8nhVOJC4vCv45FEKTgWZuNBeBqqzG4O8R+PMgQ==
Date: Thu, 29 Oct 2026 11:36:12 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <auMhnCWA5XBg9vln@duo.ucw.cz>
References: <TY7PR01MB14818B13FA2A81593C33A4DFCCD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tSXIMYKY6kuKbCo+"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818B13FA2A81593C33A4DFCCD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 10:36:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24565


--tSXIMYKY6kuKbCo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please note changes for Europe.

> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6697/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>=20
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mo=
nth=3D7&day=3D30&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>=20
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00

Note this is no longer correct. Daylight savings changed, and 12 UTC
is 13 MET.

Best regards,
									Pavel

--tSXIMYKY6kuKbCo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauMhnAAKCRAw5/Bqldv6
8tpEAKCGfckSjNKlR0Pv7g6VPCoTIlNx8gCeLIZk9+M1Bclf3p2WXG4hi/9HLL4=
=sPXd
-----END PGP SIGNATURE-----

--tSXIMYKY6kuKbCo+--
