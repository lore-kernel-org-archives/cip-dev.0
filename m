Return-Path: <SRS0=KDNU=6F=lists.cip-project.org=bounce+64572+4592+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB33C54FC9
	for <cip-dev@archiver.kernel.org>; Tue, 21 Apr 2020 08:31:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB1F20B1F
	for <cip-dev@archiver.kernel.org>; Tue, 21 Apr 2020 08:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UPQA5dx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB1F20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4592+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dnapYY4521723xF23k3cybtE; Tue, 21 Apr 2020 01:31:30 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.130.1587414288523754938
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 13:24:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6C2A41C01E0; Mon, 20 Apr 2020 22:24:46 +0200 (CEST)
Date: Mon, 20 Apr 2020 22:24:45 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH 0/2] Add HiHope RZ/G2M board with idk-1110wr display
Message-ID: <20200420202445.GA22198@duo.ucw.cz>
References: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qsq8C1xKFzH8MlE3MdcJw8j9x4520388AA=
Content-Type: multipart/mixed; boundary="5bUyDY1jZ4c2AYIO8VeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587457890;
 bh=xnVQwXVv333GR3uctNzSHE/6yX7ebkK8XWFFkiOwYkc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UPQA5dx4eZFm42s4gihQgYYrNb/rVMY5HnjK0lpIE+Jpkp6WBUppf6rSv5v6JvXcdUF
 nesHJ+9QrV1o9BbLZ34FRBmbvc8HpdjgIxaq/e91s14o3S12V0CwuJN5H3Qc1DiGFMRYZ
 ShWGNoNh8PyvIZ8XfsX7EWNO+DltnBNCJ54=

--5bUyDY1jZ4c2AYIO8VeV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support idk-1110wr display on RZ/G2M board.

I assume it is for 4.19; subject does not say. Otherwise it looks good,
so I'll test it and apply unless someone sees problem with it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXp4FDQAKCRAw5/Bqldv6
8uaWAKCGLSc3D2Rv4zuLk8+VouvJGTUm+ACfb05XOumxNIydG2uYT8VYfmTSBHo=
=vkH9
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--5bUyDY1jZ4c2AYIO8VeV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4592): https://lists.cip-project.org/g/cip-dev/message=
/4592
Mute This Topic: https://lists.cip-project.org/mt/73158050/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5bUyDY1jZ4c2AYIO8VeV--
