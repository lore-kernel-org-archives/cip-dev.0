Return-Path: <SRS0=P66g=AZ=lists.cip-project.org=bounce+64572+4922+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E1C433E2
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:33:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573E522450
	for <cip-dev@archiver.kernel.org>; Tue, 14 Jul 2020 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="j7mfaVu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573E522450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4922+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XMASYY4521723xnaa2JnfiKy; Tue, 14 Jul 2020 10:33:50 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1632.1594748027983404225
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2020 10:33:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9CE571C0BD7; Tue, 14 Jul 2020 19:33:42 +0200 (CEST)
Date: Tue, 14 Jul 2020 19:33:42 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	JohnsonCH.Chen@moxa.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/23] PM / OPP v2 & cpufreq backports part 2
Message-ID: <20200714173342.GA18210@amd>
References: <20200708154554.26450-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20200708154554.26450-1-wens@csie.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2bA0U4G7Bfj7Oy1gYaZZLC7lx4520388AA=
Content-Type: multipart/mixed; boundary="FRAq0MTybu24s86zCkZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594748030;
 bh=8znL70j1GMM5Dek2ViXsjBeSkyAPCN3/30lD7dx19uo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=j7mfaVu/QxSqPkSmTWbkRaZ+ykVoof7C3JuZf+YtEtij2TURW7GUeyqa5PZ+BJ1nGTA
 8pXVjzV3KURKTJvTYqpzzPoejFS0fNPywpfIuMAXoolO24HuWoGoa5Eskw4GPPqfrYAVS
 q5l0fb7kqZBKHRPRi8rTmG/L7ZhDpcqJQME=

--FRAq0MTybu24s86zCkZY
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is part 2 of MOXA's PM / OPP / cpufreq backport series. The whole
> series aims to backport patches related to PM / OPPv2 and cpufreq
> which were included in the v4.4 kernel from TI's SDK. The end goal is
> to include cpufreq-ti and convert am33xx to using it and OPPv2.

Ok, I went through them, and most of them are ok.

OTOH lots of them are changing common code, and I don't believe all of
them are neccessary for am33xx support.

Could you identify changes that are not neccesary for am33xx support,
and drop those?

Could the fixes be moved closer to patch they fix (ideally merged
together)?

Best regards,
								Pavel


> Part 2 here includes patches from the v4.6 cycle, as well as additional
> fixed found through Fixes tags:
>=20
>     9f8ea969d5cf PM / OPP: get/put regulators from OPP core
>     7d34d56ef334 PM / OPP: Disable OPPs that aren't supported by the regu=
lator
>     655c9df96175 PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
>     2174344765f4 PM / OPP: Introduce dev_pm_opp_get_max_transition_latenc=
y()
>     50f8cfbd5897 PM / OPP: Parse clock-latency and voltage-tolerance for =
v1 bindings
>     d54974c2513f PM / OPP: Manage device clk
>     6a0712f6f199 PM / OPP: Add dev_pm_opp_set_rate()
>     896d6a4c0f41 cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg=
/err()
>     457e99e60a8f cpufreq: dt: Rename 'need_update' to 'opp_v1'
>     391d9aef8145 cpufreq: dt: OPP layers handles clock-latency for V1 bin=
dings as well
>     050794aaebbb cpufreq: dt: Pass regulator name to the OPP core
>     6def6ea75e6d cpufreq: dt: Unsupported OPPs are already disabled
>     755b888ff098 cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency=
()
>     78c3ba5df96c cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequen=
cy
>     df2c8ec28e73 cpufreq: dt: No need to fetch voltage-tolerance
>     dd02a3d92008 cpufreq: dt: No need to allocate resources anymore
>     78ecc56247f0 PM / OPP: Fix NULL pointer dereference crash when disabl=
ing OPPs
>     0c717d0f9cb4 PM / OPP: Initialize regulator pointer to an error value
>     a5da64477ee7 PM / OPP: Fix incorrect comments
>     2c2709dc6921 PM / OPP: Rename structures for clarity
>     b318556479cc cpufreq: dt: Drop stale comment
>     21f8a99ce61b PM / OPP: Remove useless check
>     c5c2a97b3ac7 PM / OPP: Update voltage in case freq =3D=3D old_freq
>=20
> Of these,
>=20
>     b318556479cc cpufreq: dt: Drop stale comment
>=20
> was found while looking through git logs.
>=20
>     21f8a99ce61b PM / OPP: Remove useless check
>     c5c2a97b3ac7 PM / OPP: Update voltage in case freq =3D=3D old_freq
>=20
> were found by looking for commit hashes in Fixes tags.
> All other patches were included from TI's SDK.
>=20
> The patches apply cleanly on top of linux-4.4.y-cip. The last patch
> involved some backporting due to path and code changes between v4.6
> and v4.18.
>=20
> Please have a look.
>=20
>=20
> Regards
> ChenYu
>=20
>=20
> Jon Hunter (1):
>   PM / OPP: Fix NULL pointer dereference crash when disabling OPPs
>=20
> Viresh Kumar (21):
>   PM / OPP: get/put regulators from OPP core
>   PM / OPP: Disable OPPs that aren't supported by the regulator
>   PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
>   PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
>   PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
>   PM / OPP: Manage device clk
>   PM / OPP: Add dev_pm_opp_set_rate()
>   cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
>   cpufreq: dt: Rename 'need_update' to 'opp_v1'
>   cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
>   cpufreq: dt: Pass regulator name to the OPP core
>   cpufreq: dt: Unsupported OPPs are already disabled
>   cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
>   cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
>   cpufreq: dt: No need to fetch voltage-tolerance
>   cpufreq: dt: No need to allocate resources anymore
>   PM / OPP: Initialize regulator pointer to an error value
>   PM / OPP: Fix incorrect comments
>   PM / OPP: Rename structures for clarity
>   cpufreq: dt: Drop stale comment
>   PM / OPP: Remove useless check
>=20
> Waldemar Rymarkiewicz (1):
>   PM / OPP: Update voltage in case freq =3D=3D old_freq
>=20
>  drivers/base/power/opp/core.c    | 1066 +++++++++++++++++++++---------
>  drivers/base/power/opp/cpu.c     |   22 +-
>  drivers/base/power/opp/debugfs.c |   85 ++-
>  drivers/base/power/opp/opp.h     |   74 ++-
>  drivers/cpufreq/cpufreq-dt.c     |  303 +++------
>  include/linux/pm_opp.h           |   27 +
>  6 files changed, 973 insertions(+), 604 deletions(-)
>=20


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8N7HYACgkQMOfwapXb+vKyggCgtWQjBUn4iLULmzrCk3nCYlXB
8swAoI182rqe5i1AApZjgvVNc2CNBbWQ
=DeIU
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--FRAq0MTybu24s86zCkZY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4922): https://lists.cip-project.org/g/cip-dev/message=
/4922
Mute This Topic: https://lists.cip-project.org/mt/75379082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--FRAq0MTybu24s86zCkZY--
