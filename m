Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA0E77184
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 11:19:13 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.127290.1734607142744890638
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 03:19:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=gTw2EsdD;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCCD3108A6AF0;
	Thu, 19 Dec 2024 12:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734607140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uNX9it2SbnoMT/4KeBpXIxpZKFrJGzrl+iJLhYW4Es=;
	b=gTw2EsdDPx7oYV4/nvngXB0TQSHCzkuDyhnhdXZLMn3E8wYWaYbQJdNXtg+Ks7gUZgmbj6
	/jm1MSb94v5RaaqrGFgI1NsV1UPu/oGYhwVlpTvj41PJQGXySLA72emuJL7MdCp0KTtG3V
	8+Sii8jief0zPml6T2BGnFbFLM4bbftJrQI54FR7gf4TUFhjwYqaDPCtYnJeBYn+7DUDZK
	Rtw5o7rP6mmkr1bu/iusE1QZzW8f+EA39kZeaCImp09QZzmN/Q/y4Ow0ryuZb8bBT5dK9b
	6/3VLfiywABY7XHFmvKxG2Fau2IqOv8BXv53oMNgspy6CsZ9NpkH6zfu+As+VA==
Date: Thu, 19 Dec 2024 12:18:57 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix
 FOUTPOSTDIV clk
Message-ID: <Z2QBIbbdr68ZWlX/@duo.ucw.cz>
References: <181032168C715C4E.8579@lists.cip-project.org>
 <OSZPR01MB701902FE30A554F6C65B52F7AA052@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <Z2Lvx+d6NOE0VHRx@duo.ucw.cz>
 <OSZPR01MB701960E1742A56ED759CFB9DAA062@OSZPR01MB7019.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OM4w+KQE558Dh/Xx"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB701960E1742A56ED759CFB9DAA062@OSZPR01MB7019.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 11:19:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17480


--OM4w+KQE558Dh/Xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Again, sorry for the delay. Should we have similar patch for 6.1? I can=
't
> > seem to find that in my mailbox...
> >=20
> Thank you for the review. For 6.1 this patch should automatically land in=
to CIP
> via stable due to fixes tag.

Ok, thanks for the info. Unless it is urgent, I believe it will be
better to wait for patch to land to 6.1 before merging 5.10 versions,
in future.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OM4w+KQE558Dh/Xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2QBIQAKCRAw5/Bqldv6
8tpsAJ9eDBlMKjfkud9xN8ZZiVoTcE1GNwCgsjleTiWasu/G1UJFYzWNfMZTrsg=
=H2FY
-----END PGP SIGNATURE-----

--OM4w+KQE558Dh/Xx--

