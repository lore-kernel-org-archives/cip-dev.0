Return-Path: <SRS0=04A2=OY=lists.cip-project.org=bounce+64572+6776+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5FC43217
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 13:40:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCBA611F2
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 13:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DCBA611F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nAPFYY4521723x0KVpcZxIDo; Mon, 04 Oct 2021 06:40:05 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.9437.1633354803557079464
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 06:40:04 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2B4A21C0B76; Mon,  4 Oct 2021 15:39:49 +0200 (CEST)
Date: Mon, 4 Oct 2021 15:39:46 +0200
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.4.285-cip63-rt36 (-rt226)
Message-ID: <20211004133946.GA2724@duo.ucw.cz>
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
X-Gm-Message-State: KVO7xtgYdZf8trUxcF0HrfTbx4520388AA=
Content-Type: multipart/mixed; boundary="NnhhwlyG8DZHVBfIGslE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633354805;
 bh=MBegrbnHi+uAaNCOrFKlsGgt9xgFMyM+2+n+S0Jspb8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=AQB25ndXDgXUcton77VI7fgGcYSzW1gAdaSFqkU5VGx92C0nDdr9ATRcQfQ/iC6sCCq
 6S6VHF5P0N1uD8L7r/TMO3LZu9WeCep4xkzThnt9yvdJ8etJ0UDs3c8LGkwUFcEXE0d6X
 614lsxyCKNzynlTLSeudCcf5uyHE181V/1s=
Message-ID: <20211004133946.yICdyviL801hkVleL8EhG_escN38bLcQ84b4tGb1FXE@z>

--NnhhwlyG8DZHVBfIGslE
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVsEIgAKCRAw5/Bqldv6
8rPSAJ9WnRzUbXQdqqZgIvAYvDdJw0FIAACfeT6/SszAdcN7JdgpmetCdmMFzyo=
=KY5x
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

--NnhhwlyG8DZHVBfIGslE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6776): https://lists.cip-project.org/g/cip-dev/message/=
6776
Mute This Topic: https://lists.cip-project.org/mt/86066546/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NnhhwlyG8DZHVBfIGslE--
