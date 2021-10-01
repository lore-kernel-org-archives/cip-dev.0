Return-Path: <SRS0=F2/0=OV=lists.cip-project.org=bounce+64572+6767+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A7EC433F5
	for <cip-dev@archiver.kernel.org>; Fri,  1 Oct 2021 06:38:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DFE61425
	for <cip-dev@archiver.kernel.org>; Fri,  1 Oct 2021 06:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80DFE61425
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Lac2YY4521723xPZRVERKhnz; Thu, 30 Sep 2021 23:38:32 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4373.1633070311036518241
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Sep 2021 23:38:32 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 99B481C0B87; Fri,  1 Oct 2021 08:38:26 +0200 (CEST)
Date: Fri, 1 Oct 2021 08:38:26 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	yasin.demirci@siemens.com
Subject: [cip-dev] Commonly used bluetooth/wifi drivers
Message-ID: <20211001063826.GA28529@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LR4FFhwhqfbzWO18WZ7ByeQkx4520388AA=
Content-Type: multipart/mixed; boundary="ZPXNzR0sOX24ZDIO8P1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633070312;
 bh=DVKqtci5Zfg4iPcihG/3Wp4KggX2idWO8suwhfAAKQs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SP1pTdBvDzA8oh36tN/rSljY7xwq46mR5sphrE5ZB8Akvb2iRrHnpPAHm7kxzgmzFVg
 hnckAq6At1RHdueU0WxiA/WqbyV8AlS5OqStVuyfSjyMJpYeT8DKA1kn04RP5HR2GEda/
 PgTscHOh76xsICdiDxP5HwtFcnfOJVKgLs4=
Message-ID: <20211001063826.9zMmDSAZ8Zl5ZWXfrTj5wSaYZb7UwC8OnufrQRT6Y-s@z>

--ZPXNzR0sOX24ZDIO8P1A
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline

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

--ZPXNzR0sOX24ZDIO8P1A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6767): https://lists.cip-project.org/g/cip-dev/message/=
6767
Mute This Topic: https://lists.cip-project.org/mt/85992852/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZPXNzR0sOX24ZDIO8P1A--
