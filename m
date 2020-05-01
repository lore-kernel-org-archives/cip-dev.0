Return-Path: <SRS0=x+TL=6S=lists.cip-project.org=bounce+64572+4611+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E881C3A5A9
	for <cip-dev@archiver.kernel.org>; Mon,  4 May 2020 22:41:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779B620663
	for <cip-dev@archiver.kernel.org>; Mon,  4 May 2020 22:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="icKXelo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779B620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4611+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kicRYY4521723x5qXKJ0f0an; Mon, 04 May 2020 15:41:55 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.6771.1588324804409304991
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 May 2020 02:20:05 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CFEA71C020C; Fri,  1 May 2020 11:20:00 +0200 (CEST)
Date: Fri, 1 May 2020 11:20:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= <JohnsonCH.Chen@moxa.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 1/3] PM / OPP: Add "opp-supported-hw" binding
Message-ID: <20200501092000.GA11782@amd>
References: <HK2PR01MB32812E5997579D3A664F3F45FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
In-Reply-To: <HK2PR01MB32812E5997579D3A664F3F45FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: STTkgW7CLvHSv2688PmWHbHzx4520388AA=
Content-Type: multipart/mixed; boundary="YDvNTgIbB3mQsiaAaG2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1588632115;
 bh=Kjtq1GwfRUDNPRAjcrCjFfRPOPYbHOEib9Jq0rKsIuk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=icKXelo6N20/DtijoCecHat6E33+QfTMxtBv3uO9NPh3UZYKk0zQ/LNgK3KaDr/g+Aq
 BadFXbZMHV43N5HyK29EQkCzrji4Fz9xRMMvgKrAvlkT5maC7G3RHur1NACTZCdlhzNPn
 T7St3rqkVNYuwn+fEa0J+JyZHVlsJ6tphDo=

--YDvNTgIbB3mQsiaAaG2c
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> commit 1c4d12de2719dfdf27c6dab31e7a5641ee293c94 upstream
>=20
> We may want to enable only a subset of OPPs, from the bigger list of
> OPPs, based on what version of the hardware we are running on. This
> would enable us to not duplicate OPP tables for every version of the
> hardware we support.
>=20
> To enable that, this patch defines a new property 'opp-supported-hw'. It
> can support any number of hierarchy levels of the versions the hardware
> follows. And based on the selected hardware versions, we can pick only
> the relevant OPPs at runtime.

Few typos mentioned below, but this should not block merge.

> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentatio=
n/devicetree/bindings/opp/opp.txt
> index 0cb44dc21f97..d072fa0ffbd4 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -123,6 +123,26 @@ Optional properties:
>  - opp-suspend: Marks the OPP to be used during device suspend. Only one =
OPP in
>    the table should have this.
> =20
> +- opp-supported-hw: This enables us to select only a subset of OPPs from=
 the
> +  larger OPP table, based on what version of the hardware we are running=
 on. We
> +  still can't have multiple nodes with the same opp-hz value in OPP tabl=
e.
> +
> +  It's an user defined array containing a hierarchy of hardware version =
numbers,
> +  supported by the OPP. For example: a platform with hierarchy of three =
levels
> +  of versions (A, B and C), this field should be like <X Y Z>, where X
> +  corresponds to Version hierarchy A, Y corresponds to version hierarchy=
 B and Z

"Version->version".

> +  corresponds to version hierarchy C.
> +
> +  Each level of hierarchy is represented by a 32 bit value, and so there=
 can be
> +  only 32 different supported version per hierarchy. i.e. 1 bit per vers=
ion. A

"supported versions".

> +  value of 0xFFFFFFFF will enable the OPP for all versions for that hier=
archy
> +  level. And a value of 0x00000000 will disable the OPP completely, and =
so we
> +  never want that to happen.

> +  If 32 values aren't sufficient for a version hierarchy, than that vers=
ion
> +  hierarchy can be contained in multiple 32 bit values. i.e. <X Y Z1 Z2>=
 in the
> +  above example, Z1 & Z2 refer to the version hierarchy Z.

Above it claims that there can be only 32 versions, then it explains
how to do more than 32 versions. Overall, I find this text rather
confusing (concept is quite simple, but I'd not understand it without
the example).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6r6cAACgkQMOfwapXb+vIOYQCfaXfacNzKlxGd44hwphR8KA0R
UsoAnil9oPTSl9VPMdSMlRG8myJXg63N
=xQWy
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--YDvNTgIbB3mQsiaAaG2c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4611): https://lists.cip-project.org/g/cip-dev/message=
/4611
Mute This Topic: https://lists.cip-project.org/mt/73369239/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--YDvNTgIbB3mQsiaAaG2c--
