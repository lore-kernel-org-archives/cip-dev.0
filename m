Return-Path: <SRS0=a3fy=DO=lists.cip-project.org=bounce+64572+5503+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1204C4363C
	for <cip-dev@archiver.kernel.org>; Wed,  7 Oct 2020 20:11:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0368F207EA
	for <cip-dev@archiver.kernel.org>; Wed,  7 Oct 2020 20:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YyNofMny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0368F207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5503+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i113YY4521723xQmXsuVHR4V; Wed, 07 Oct 2020 13:11:09 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.49.1602101467743398381
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Oct 2020 13:11:08 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6034C1C0B95; Wed,  7 Oct 2020 22:11:03 +0200 (CEST)
Date: Wed, 7 Oct 2020 22:11:02 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de, jan.kiszka@siemens.com,
	SZ.Lin@moxa.com, ben.hutchings@codethink.co.uk,
	Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Message-ID: <20201007201102.GB32003@duo.ucw.cz>
References: <20201004090653.GA18130@amd>
 <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
 <20201004213905.GA8065@duo.ucw.cz>
 <163B547D5FFC3079.30511@lists.cip-project.org>
 <OSBPR01MB2983148027370F1B4D02B0B6920D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983148027370F1B4D02B0B6920D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3OkMkJaswWRDCQK7UvxHUP37x4520388AA=
Content-Type: multipart/mixed; boundary="sbVCUQUpcLqKqzF4FLrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602101469;
 bh=qGNnom3hlW/3dueRYIpzu3wZYJhuIVveQAsEN+uzC5A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=YyNofMny0y0Br7GK+wUic77paU2GpWt4cF6OiW/RApHDU8L7U2BZUr0x6LmYoVF53Mn
 psfOf5ddvNCujj/tIexEIhgyv/dMxoCojvIVNeKKb3MXlbEvS2JoB4tTgxsx7Wqw5odVs
 pVIQjdFSizX2arx2FXqogmtYT7iX0n0saJ8=

--sbVCUQUpcLqKqzF4FLrw
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> FYI:
>  https://patchwork.ozlabs.org/project/netdev/patch/20200922072931.2148-1-=
geert+renesas@glider.be/
>

Yes, and the revert is now queued to 4.19-stable, too.

So.. what do we want to do here?

We can merge 4.19.151 to -cip when it is released, and I can then
release new -cip-rt that works on renesas boards...

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX34g1gAKCRAw5/Bqldv6
8n3aAJ41C6W+dZvnBilZeb4bu+kIYdMCGACeIQxDrTxw/TvCG49cgv2+yUK4/Io=
=eMLa
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

--sbVCUQUpcLqKqzF4FLrw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5503): https://lists.cip-project.org/g/cip-dev/message=
/5503
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sbVCUQUpcLqKqzF4FLrw--
