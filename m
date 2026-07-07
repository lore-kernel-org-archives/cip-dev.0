Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE2BC43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 08:19:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.168784.1783412350492534099
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jul 2026 01:19:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=t6e1n298;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783412347;x=1784621947;bh=IGxdpOUuLVtCvPzgFIC/gkUeLPaukP+q+sZvt
	ri89yo=;b=t6e1n298qRly3N39KHoNKDLZnXUTWIHf+F7BVSaEs0avT2jwJn2Qlj89RNspiOcMCNQ
	beR0rXkaWG/iuGIcrjLKfyjjUH27w+27Q9Vb1c7Su+t12jr24C3m3GdCT9uFX1Nf6GnC48b9S0o++
	wPdd0SQaqGelotZVEsievYo/N/6hhRTlU8V1t9RP0AjzQBatPMz4aaIxs4yDil9Nk0An4APLiVxq2
	Py+Z5Xj6bR9My9CTuk7N4sdw6MykIdPL9hg6BR5iv5RGc84gh8EPw62MwpcUx4IMwIvcdpy3fR3Jb
	AqzAw2OTU8PpHopdBu7bZ7mUc+mu4PNziqtotcHa4tCw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6678J6FK3100234; Tue, 7 Jul 2026 17:19:06 +0900
X-Iguazu-Qid: 2rWgjGMztW1Hh6wZMx
X-Iguazu-QSIG: v=2; s=1; t=1783412346; q=2rWgjGMztW1Hh6wZMx; m=21r7qsL+1d+c4sZykkandVqtey86s+VBGAIuS48ktgE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gvYzG035Zz1xnf; Tue,  7 Jul 2026 17:19:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sv5Y2Yn/Ltz+ccES6rlW0fNU/fqtEoOl3XKDe8dsb8AoGrljDcfFC/BfhZW/i+LrkKDnAGkjX8nhyiP8ne2oePMYpm37qGbSSSA0b3OHOMLcvMjMYfKm62eZphEln5cFlqs3wbsKibNyrfvC+WbZu6Gd3Wt9oJwQ0JTs9IluXXVVDUl40IcJGGiVlmJt/9RUd0aCQFF3hest9J1mv43L/89Ikam5jvSLu0/db9NJIwEWF9l/C1zcGxOPk9fjWw3yWJVRm412xxOiSJeLytcqgkQXAwk3D/v/1Tfgn83ikAea++D15KumbDCQ4PEaWnBjO6upvIWkhiR4I+jfmjurnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZoap1tvs16aO/WBBQbs8sDqQmqR2HKnR7NaVdxqk9k=;
 b=vLxygniN6WyaUWPUO+vMHfpHPH2yO0u3CezW1AIEGBxcJhNqsaCb5k/m9CgtoCOgAvmxl+dRjo4ckN/4LZsfoc9vBIjMLPnDvVjyZ8+R/pHhP8LJ/i2veoEGiTyNVQthWQSWexkmnuwLRcL/uSeLhg3fagdjSo2j8JKq9BCTn3SFvx4/c6tYIMTu3DwpJUc6R5eWOXp3U3nx2xCxsL6YbYtLonHHGJkBb+xN5walA7wV8I42IzISklNDMCIB+g4FDQPcwl48mjly7Vjec+ns3rg2CrWg+1iOO/22pGoMDrjoZ+1a0viVeP6bwRdaVtbMzac8/MCS1vFehcA+ESMSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip v2 00/10] Add pin configuration and GPIO IRQ
 support to Renesas RZ/T2H SoC
Thread-Topic: [PATCH 6.12.y-cip v2 00/10] Add pin configuration and GPIO IRQ
 support to Renesas RZ/T2H SoC
Thread-Index: AQHdCgzpA7yJ/wDBOEutQWIiWdmaj7ZhvZ2Q
Date: Tue, 7 Jul 2026 08:19:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481845D862F3FDD700499334CDF02@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB12509:EE_
x-ms-office365-filtering-correlation-id: 4729874a-7e00-44aa-e7cb-08dedc0067e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|22082099003|56012099006|18002099003|6133799003|11063799006;
x-microsoft-antispam-message-info: 
 cfb+DvNjiayEnxye2GJkl+ttpNpgA6XJuTkSknCo0eTaxTmXVN7ptKjdTbIEfh4nOhrPJ9YHuPD8AtoP4YSeZfBWFmu1M3TWe7DpdVY0KJlNKLLoDblo+m/T+1HR3tWNhoh98O1SGhEyJpGMyT8RZRd2/t0OuBvLVmWw+m10Ko/Tbo0aUIgT1nweeRjxli93bsovGqYMo1gUgbHvu4oiX8vgxU8xh1NLSpbjYsxQ3BqRWDR5rrOK41y3BvtPLA8kwsaXbUlfigtJhAmRDNVfqTTk+M4VGV3KRp8G69WKRJ1mAm9UD0W3K1DQPKpa/ugj5Pv1ua9unnrdVRtRwqwdJ5sTRDT2rmZ1a+nkZ4tv3aLXmKwedQDaLkwL9u+QM0j0H7vNy9GqaSHIt1Ox2SIlvIae7PVbLrJooUog0/Xrk1A7rdYmwjvRH0/lx8suosHtSIid1Lvpx5s+PCk9FcPsVocR+LG0tyZLt6GNXOB7mr1W0H35l7etpxKwLmhZj9eruZ+t7vGuOOrKgffrbnROVTyJtQOb34qc8uEj+6SQkvLFYyJUDngt1X6m+TMVHo5iqgYobPtdKs9xD2N+ubwC7gxiIm4E/Aby2SpBA5M6/wXhcj/Mzk75R//VHrfS0tQUUGvXpQ7wwxWB1FWXhyolWqLJGx0lDVYB0c0eQFJ6f/mnF0fb/6+xM4diDLiAlHf6b4p5dclmjbMRnHZNZrSjQQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(22082099003)(56012099006)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YWlYVWhaUjF2VDhmdDdIRnZFYnJ1VmZHRWcvR0F2VUR1NS95UFR4NmVl?=
 =?iso-2022-jp?B?SVpaMkRheXo5TTJKV3orR01jdy9YRGZURlUxVVVwVjZhQUIwcHZQdzNC?=
 =?iso-2022-jp?B?TXVTTXlUY21id1dZYmhMdUFDeWxiOEQ1RVU3djJMTkxTSVB1VXdjaEM3?=
 =?iso-2022-jp?B?M25kWE52Q3YwQXBDL203amRRMVlnZk1xUEpxNUQ2Nk83Z2FvU0RFMkNr?=
 =?iso-2022-jp?B?N0hLZXNvZzhteUxwMTllUC8vODVpSzFCTGc0M0FwYThBblU1RmdVeVRl?=
 =?iso-2022-jp?B?cjVNSnRxU1BKZmZxVmp6dUJjeUlHYmxUYk1BRWZIUHZvUWdoeVZjS01s?=
 =?iso-2022-jp?B?K2dVS00vWG5yOEVNc3VpN2c5a0p0WVcxTDBtdFJUaU9YcVN6ZDhPMHhL?=
 =?iso-2022-jp?B?cnlaTHp6R2RycjE0aDFUaVJtM0g2N3F6UXhJZDU3V2srVFlidGxETHRM?=
 =?iso-2022-jp?B?ZjZTRnZqSUJXVWNBSlFyamRBdjIwdThacEJzVU5SUUhpUjd6MGJjSHl0?=
 =?iso-2022-jp?B?STNXMzdJdVJkY2I2NFBuUG95WEF4Y2U1dWdBbWhqQXNFd3JHT1hSVmYx?=
 =?iso-2022-jp?B?azBkaGd4My9xb3QvMG9JSk1EVFp3QkcyTVFuWEM3UUgzbkxWT1ppNlpR?=
 =?iso-2022-jp?B?QWJZWnp0RnVpeXdwUnptWm1MckFHWHJ5dHVtQTdvd1h2MXBtOHhPNGVz?=
 =?iso-2022-jp?B?UUdkSUNkMjJwNmc1M0Evd0w1dk1Mc0ZiWmhXd3BxWEIzYkR5RTNtR3E3?=
 =?iso-2022-jp?B?OUpjUWxOKzZSdEZsNUJKMzFzbDFmeWVqemhTR0FZK2J2TlBxVjdZbmN5?=
 =?iso-2022-jp?B?YkdpUTNNdXpWV3RYdTR3S2FwQmhqTkNiU2x4bzhoNEpVUE0yNHhrZHhO?=
 =?iso-2022-jp?B?TnZZTmIrTmpqeUxJaUJPRUI1Q1pORWQzdHRhdWQxaEMyanRpMFRpUUpQ?=
 =?iso-2022-jp?B?Mk4xY0ZCZnlSTHdzSUVNSVl6UmQ3bStZL0ZiNDlpRU9EV0orMXpmOFYw?=
 =?iso-2022-jp?B?TElreTR3YjV4VVVQYitkRklQNmZhSWJRRkZmVmtCUlE3a1Q4cC9nM0Ey?=
 =?iso-2022-jp?B?UWh4bWMxMG1Sd05sZHRqTGh4T2RDUTMycS8wME1ueDVReThLLzhBQWty?=
 =?iso-2022-jp?B?RTNVenkySCswdUNLYkx1S1F2bWcrMG9BSFh6N0hCMGNYeFJRc21iMWxD?=
 =?iso-2022-jp?B?OGFQamE4TEJ0THc4UFZGTndSNG5lekczcGtGMU0zU01tLytEdUtmbEE3?=
 =?iso-2022-jp?B?aGVEMVBOcUlyK0xHQ2hjSVNjSkowemFKdmVzM01ERGpZbklkcUZ0akln?=
 =?iso-2022-jp?B?djRrQmU2YWNRT25pOThtOTlQUFRpdUgzV2JrYXBCUTNrSFhUK0ZpcDcy?=
 =?iso-2022-jp?B?U1NheHJZMXdmcmF2Rmw5NHM3MDFDRFdrQUxCVlQ3dW8wUng5WnNXS0Zt?=
 =?iso-2022-jp?B?VktKRk9UUVR3Y2xidkFHK1l0bEZVVmZsTUJUeDRWRmlwYjYzR0hXNktQ?=
 =?iso-2022-jp?B?VXF6SUg4Z3BwZEJPWlhJSkFZZVBiMzFXNi82VjZvWmtHT0xURnlzREoz?=
 =?iso-2022-jp?B?MDBxcWU4Mm9jdU5PcUN4RzdiV1hNUTl6MDVrZ2xiVUNKMzRzcHR5TXEr?=
 =?iso-2022-jp?B?OWRreE5PYzlwZ05Rb0NvcnhSQUNmbFZiSTZlcEsvdGk5TlZGUTJLTjFS?=
 =?iso-2022-jp?B?WVorU2NGdmJXci84c05Lc3I4K1BFdmpER0I0WUNCbTBZclU1QllOWjhV?=
 =?iso-2022-jp?B?Tzl1dEFpSEhHN2xJdkNNWldYNkwvc1lNcENlZ0lsWWpVSUlPZzJYb0tU?=
 =?iso-2022-jp?B?UkVoMlNnK1VFc1NUQko3TlpmbXBjdHA3REFGcmE2WDQvTTVyUXZUejRx?=
 =?iso-2022-jp?B?Y2pWWHBBT1dkeXpBU3ZZNGYrdFV0dmRBWVI0YlhueWdhd3ZMaUZGZFZw?=
 =?iso-2022-jp?B?Rng1ZWtkVTlKYWlwTmtDZDR6UGxwMHhBMUFsQ0tsdm1mdXVxb0Z3cHcw?=
 =?iso-2022-jp?B?d0dJc2htSXlyRjFrVGtsell4eDdkczAxdG5GQ0J1YnB4QzBOR1AvdDdK?=
 =?iso-2022-jp?B?T2VsQ0EvTnV6Y2xYblV5dXhqQkFuckdheEVJNmdRanRxd29VNXlqY01Z?=
 =?iso-2022-jp?B?cFRmUHdqNUsvVXB3Nmp1RXV3R2RiRGRCNEJWSUN2REdSWHJWV0V1TStv?=
 =?iso-2022-jp?B?eGVvTU02aUlKaXdzRWt2T2lJTVJlbzdlSFExZEpTc3hVTGsvblZrbjE5?=
 =?iso-2022-jp?B?SmdaQXRROWtRcFFyYStvQU5WSTZoN1U0djRVUXowblhNM2VwNnI5K3RD?=
 =?iso-2022-jp?B?Y09kN01oaVU1TzJmUmI0LzRvYXdNL1RQRFFZK0I1bjg4ZWc2aGN3Tmcw?=
 =?iso-2022-jp?B?LzQ1MDZtTWJFT0g5OWZTenZOekZpcmNZWTBJdVJCQ0VPdC9UN2dHTEVx?=
 =?iso-2022-jp?B?cS9VUzNqZzJlRkRJN01uUHREZTcxbThYczMyR0p3dE9oSUhLUWFxQVR5?=
 =?iso-2022-jp?B?aXpuNWl3WGw4VHgzYTJEV2hZMWtFb0pvbzUrS2Zud2N2Z3BTaFdJNTlF?=
 =?iso-2022-jp?B?dGxGL2lDWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Mvf+dI/CzKc8iAjJ6pwO5kmK9eAVob+2k/1y8x1WaZ8nS70orQQNpNKeTAv4OMQkzNu5oDFnR/+Wy5hAs7F68FdqDe3pOiHolDc3mjpf0nxubNIszHbargRbZ5dKzyGZrDKc22xC1/H5vKEgEl4j1KiX5gdfH4h2ueHmOM1ynp4Zt1Zc7IBSUfrbnppfyhG7zOgCtv5VfqoF7iRK5P9oyuiVM4f1OY+EL77+22+EzKRAhT24V0/f/aXcanMaUL0J4kY5h8xseo30EIpAewse0vP1iKMTmcumgb2jINkAlq5Un4HYqDkOLzfzW9fL4aW/aIK5bkOYHAxyHpAveLPi/A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4729874a-7e00-44aa-e7cb-08dedc0067e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 08:19:03.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aY4/kLjWzdqHqt9j01KTYbFRel4nBRGfgCT55fUnNBQxr3/qHtVygcaO+0sIhGXO9bIwlXQqR1UGzWYAH5+tzEXWXE/cmZ4jmkOFISp5iWQiAmntsY8BLpfFWUq1OCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12509
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jul 2026 08:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23472

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, July 2, 2026 7:24 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip v2 00/10] Add pin configuration and GPIO IRQ
> support to Renesas RZ/T2H SoC
>=20
> Hi All,
>=20
> This patch series aims to backport pin configuration and GPIO IRQ support=
 to
> Renesas RZ/T2H and RZ/N2H SoCs. Enabling of GPIO IRQ support to
> SoC/board DTS/I will be done as a follow-up series along with xSPI suppor=
t.
>=20
> All the patches have been cherry-picked from upstream kernel 7.2-rc1.
> Patches apply on top v6.12.94-cip26 (commit-id e00178e6fe853).
>=20
> v1->v2:
> - Dropped patches to add field_prep/field_get macros
> - Added DT binding patch
>=20
> Cheers,
> Prabhakar
>=20
> Cosmin Tanislav (4):
>   pinctrl: renesas: rzt2h: Move GPIO enable/disable into separate
>     function
>   pinctrl: renesas: rzt2h: Allow .get_direction() for IRQ function GPIOs
>   pinctrl: renesas: rzt2h: Add GPIO IRQ chip to handle interrupts
>   pinctrl: renesas: rzt2h: Fix invalid wait context
>=20
> Felix Gu (1):
>   pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register()
>=20
> Geert Uytterhoeven (1):
>   pinctrl: renesas: Remove unneeded semicolons
>=20
> Lad Prabhakar (4):
>   dt-bindings: pinctrl: renesas,r9a09g077: Document pin configuration
>     properties
>   pinctrl: renesas: rzt2h: Add pin configuration support
>   pinctrl: renesas: rzt2h: Remove unused variable in
>     rzt2h_pinctrl_register()
>   pinctrl: renesas: rzt2h: Skip PFC mode configuration if already set
>=20
>  .../pinctrl/renesas,r9a09g077-pinctrl.yaml    |  17 +
>  drivers/pinctrl/renesas/Kconfig               |   2 +
>  drivers/pinctrl/renesas/pinctrl-rzt2h.c       | 554
> +++++++++++++++++-
>  drivers/pinctrl/renesas/pinctrl-rzv2m.c       |  10 +-
>  4 files changed, 556 insertions(+), 27 deletions(-)
>=20
> --
> 2.43.0

I reviewed this series, looks good to me.
I apply this, thanks.

Best regards,
  Nobuhiro


