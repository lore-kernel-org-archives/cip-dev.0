Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088F7C433EF
	for <webhook@archiver.kernel.org>; Fri,  1 Oct 2021 06:38:33 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4373.1633070311036518241
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Sep 2021 23:38:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 99B481C0B87; Fri,  1 Oct 2021 08:38:26 +0200 (CEST)
Date: Fri, 1 Oct 2021 08:38:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	yasin.demirci@siemens.com
Subject: Commonly used bluetooth/wifi drivers
Message-ID: <20211001063826.GA28529@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Oct 2021 06:38:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6767


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On cip-members, there was question of widely used drivers that we
should include for WIFI or Bluetooth.

AFAICT there are no standartized interfaces for WIFI, and each vendor
has their own. For Bluetooth, there's standard protocol to run over
serial and USB interfaces (
https://en.wikipedia.org/wiki/List_of_Bluetooth_protocols#Host_Controller_I=
nterface_(HCI)
). Those are in drivers/bluetooth/btusb.c and drivers/bluetooth/hci_*.

If we were focused on notebooks, I'd be able to name common WIFI
chips, but embedded space is significantly different so my experience
is not useful here. I know of no dominant WIFI chip, but I'll be happy
to be corrected.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVas4gAKCRAw5/Bqldv6
8gx8AJ46HmtrclorzTfWz6OTaB+j6e5kQACfRPVZXXSEhGWnNnVaMBpLgCaHBGg=
=QjFy
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

