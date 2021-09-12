Return-Path: <SRS0=Mc9O=OC=lists.cip-project.org=bounce+64572+6725+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA1C433EF
	for <cip-dev@archiver.kernel.org>; Sun, 12 Sep 2021 11:10:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C846E60F8F
	for <cip-dev@archiver.kernel.org>; Sun, 12 Sep 2021 11:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C846E60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id g45cYY4521723xiinHC6QlGd; Sun, 12 Sep 2021 04:10:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.14701.1631445022695450729
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Sep 2021 04:10:23 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EBAD51C0B7A; Sun, 12 Sep 2021 13:10:17 +0200 (CEST)
Date: Sun, 12 Sep 2021 13:10:16 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de,
	masami.ichikawa@cybertrust.co.jp, Chris.Paterson2@renesas.com,
	uli@fpond.eu, jan.kiszka@siemens.com
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.206-cip57 and v4.4.283-cip62
Message-ID: <20210912111015.GA26423@amd>
References: <TYAPR01MB6252E924DEBEBBABA184CDE492D89@TYAPR01MB6252.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB6252E924DEBEBBABA184CDE492D89@TYAPR01MB6252.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0mTdFIjfOLyGyPXU0nNEAr2wx4520388AA=
Content-Type: multipart/mixed; boundary="2U49yToj6aKpbQfu7W8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631445024;
 bh=pEJXz5+g5uIr2g3HocILowFso249WtLfNXP5FaMCuJM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=h8pM52JnauoMR3YWImycQ68uKLraBe8XK0/ukA7ePhUjC02FfbGbn46QcFY726IaxOe
 jnjwCaH3sx2woqAd4nvZjJ5y9byP88O0HBgjp0hjhW/3wYJ1zcCkVSRgV6XnV7MaEqnaO
 q9bdavbOkBiXCSDdar9sFxmQHKoaNc3/jPM=

--2U49yToj6aKpbQfu7W8t
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CIP kernel team has released Linux kernel v4.19.206-cip57 and v4.4.283-ci=
p62.
> The linux-4.19.y-cip tree has been updated base version from v4.19.205
> to v4.19.206, and the linux-4.4.y-cip tree has been updated base version
> from v4.4.281 to v4.4.283.
>=20
> You can get this release via the git tree at:
>=20
>   v4.19.206-cip57:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git

I started updating -rt to new versions, but it looks like
v4.19.206-cip57 is not available at
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
=2E Can you recheck you did the git push?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmE94BcACgkQMOfwapXb+vJobACeOjCFG5koEnDn01Qa9ao9m/t9
JXsAoKzizQy2suflYLu2X/foybLZdxSW
=iBWg
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

--2U49yToj6aKpbQfu7W8t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6725): https://lists.cip-project.org/g/cip-dev/message/=
6725
Mute This Topic: https://lists.cip-project.org/mt/85547773/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2U49yToj6aKpbQfu7W8t--
