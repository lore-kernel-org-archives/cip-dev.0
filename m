Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D4FCF34C5
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 13:50:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.60])
 by mx.groups.io with SMTP id smtpd.web11.22692.1728049799440936489
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 06:49:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Jg/mfds4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.60, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLyXLCyepe19UtPSiAP2LPgDhDLC+V61xIg6t0dZaB/q3ZrtComvp9o8sd4kuMfXRG3fpPNgQXKHZK1tIEJ25J8CrjEK+/1i28tLmsEhoIji7XgVrHVVjtjXkN0dqWt91d8bUQTtZjOAo2cCfT1OepSxpuU5WPVrcoXVtSjh3CnxVgCxeefSXN2BdcYX/ZJJhB7K993iM90aqMB7OaJ9xf9U0Ir3H/jZPlmmg6IY5XD7BRtFnxkV8X+LmlLZCj+2MzomVScTYnLgNSKeB6jlM5zyYuxXDxAaAzif14ZZT3GSrUFqt4e3tQZX+6IqpbOA53Rt03gY6G6bRfBGM28TEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvhez3dTWfAj7a1s3ivxmk6CsMh5q7/7TCxuXpqf3cQ=;
 b=P3/z9kKTGPMBoiYBZPihnqS+8zZwKPQq0J78Ng3W2t7+X36D5LnoidLUiStdHnN5ZpZMUU1KUTcBfGYnSGijg6tsMjgvrJK0zWwGs4wTHjoMkv74cI4xg/r1uUoLTdgpPpfcRWqI66FdFo19wStgcHOfUah97gDEy0baUOrlbA0x0H9YtKPrxN0Xkipt+k+LvNJf0As9YhLQ7bW7MfuyJsUtSBf9fJqdjHZDwdbGEUSW0GqxqUc1GhpCQ5dALjdQhmZ0Wmd+n8zHitrEDNBhO40o2IXJYAHoLQKCWQGsp/IcxKJ8vyWjwU2JxmFxhuE2jfS9m7p56w1egR6jS42Ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvhez3dTWfAj7a1s3ivxmk6CsMh5q7/7TCxuXpqf3cQ=;
 b=Jg/mfds4WaVCiq7pIitSIGQ4AgXo7YjL9r8abm/CDBLWlhUuqAsWZSZ/5MVunzHea2e8Nq00sqBZ+D/tTWcVX9DW8/PPBHIZYKtDMfHvxlZmMgeGTvOaKpiMSeV/IFEWj+sUamfZspP9MbDtoTQMqp8YOx6PxEc5D8KOTnsNiEE=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSCPR01MB13009.jpnprd01.prod.outlook.com (2603:1096:604:332::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 13:49:55 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 13:49:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Topic: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
 support
Thread-Index: AQHbFO2Zo5RDsBGV90qClx8ximlPu7J0jF4wgAAJw4CAAfctgIAAAPTA
Date: Fri, 4 Oct 2024 13:49:55 +0000
Message-ID: 
 <TYCPR01MB113326D06D3BBA796FBE15CA986722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
 <20241002170712.655449-4-biju.das.jz@bp.renesas.com>
 <OS0PR01MB6388556A5A29232D4FB90B7292712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346D77ACA74093D61B9AD4A86712@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <Zv/j5Q5v9S8DvIBE@duo.ucw.cz>
In-Reply-To: <Zv/j5Q5v9S8DvIBE@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSCPR01MB13009:EE_
x-ms-office365-filtering-correlation-id: 60d7f942-90eb-455c-9de8-08dce47b6dfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?cfoIsQBSdYuf8nnTt/Fj4Xkd4EZSLT9RJsPFZMULEiJkgMKxLibUF077yLj8?=
 =?us-ascii?Q?hohk3jIX3VmnH2Z/r4nI0YQyh6/DXOTHSOHEICH+yNkKVRF3kYQdKKaP1lO3?=
 =?us-ascii?Q?KTe1gjITpE37/y6ELR6QfaCr6m8NQllDJmFzrReZqmaleQJhtnS+MDM/5sjW?=
 =?us-ascii?Q?2n8+xh8hWp0VFwWP3mWLgk6LVkhWjY97mV2LvwMxWEk391JndO7Lx0ZxeJHl?=
 =?us-ascii?Q?kNbYkOpvRS6Ue9H76wfXBrsCRbBSv0caVoBYe7RhfUDYDYeuvcJyHABE3n/z?=
 =?us-ascii?Q?zFqatAGXSiFrkaHApDrHPVjriIpT9CNLjuuGuv0P0uaBP7o08/4WxxNLQxwE?=
 =?us-ascii?Q?AaA9Oa9KHL2dNuPYHTF3InJbG9z4SLUAZh16VBGp0vCT7aCvb/WwSlYFx1Y4?=
 =?us-ascii?Q?FgEydTM8L0oTuzvNucXnJ+35IHhDz9IE6rCbPUSmEXMVVi7RlM3pYy6eRLp2?=
 =?us-ascii?Q?YnrkiuxuX2I7HhujrqXrb8BuaipBVaBFyQEoadkOruT+PpoDN+jQssOCCDpR?=
 =?us-ascii?Q?xQNWRz1oUSRs3Zf1J16Zr9XUSvnacUXTEoI6eBzFMx531bZNN90g+sKpcm8C?=
 =?us-ascii?Q?3qIaxpyeute5Lgt4xtLsvhuemmpbnC6ENfCIokdHYrKPf/Oyyak8Hu6XzH9X?=
 =?us-ascii?Q?dXHHmmWupz+f6jPhwLTTd40y6HV9mY7oGUunNbsDfbygpWCyJUSvlPXkCfDE?=
 =?us-ascii?Q?PFgIBCUbTabMND5lO3FwhgBSo6/LOqmNXyyOp+dMyUj6uzfD/+ErPI4EA0DQ?=
 =?us-ascii?Q?QlEmPbW3XXMmlWk12cmB2YHVtA+9oPh6Zy8Dh804icsaAh9qQYiD312HWa0t?=
 =?us-ascii?Q?PrSV3FBz3bcl3AcopXHJwbsHt1MGC/w0YQ5U2CQXlsL4pKO/wdaJTLTLZe2e?=
 =?us-ascii?Q?bDzocmUgsTc+jyc1Eln2/wgFq8gyuo8j87+GLAT9GOslITXgqUY5MX9p38we?=
 =?us-ascii?Q?FSP3VOIsg33sIR55ilIyIXNPrGpMCyobvDAJPQXpmpT5rLPbDKkU9DFQvOHM?=
 =?us-ascii?Q?nbbHdyDLmANif6hX2mzN58mxdc158wgLqP1Q9fsPCNBxTwHXydmT2keN/xMY?=
 =?us-ascii?Q?yLsk/srMrjcgfSc3j0iDn7XCyO21hlBlwH3ihGS/hAYyNG4rT3+aKfa4V8Oj?=
 =?us-ascii?Q?BzWBIePoB/U9M2YSNubYGwUln34guu+TMGeRKq4n9KCcJ/FjK+F1/nAXQ1pM?=
 =?us-ascii?Q?5HaciLfxAQWfvCO5o74dNIA+qCXR7VPn6EdriPweQn4t8wpsu7J4EF+AvlVM?=
 =?us-ascii?Q?7cn+ODsEWXh9qg7mRpguuJYau50KaabjtwByFzIWM4v7tsaW/ihxFeqV4pic?=
 =?us-ascii?Q?aFED88Nu1nZunGh9qA6ZVb2uvGU6CYq9Z/1Fd5QFDZrYVA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mBpuqQkSNg8bH60S6rvB9wOv1dQqeBZhBi6RUQj8/ea71xBU2+fAjFqXFdNP?=
 =?us-ascii?Q?bd50pX3WVOucMClpqOoninUnOygBw9HzlZzeaOxFI29kcTxeuCn1rkue/+a9?=
 =?us-ascii?Q?pNBxKlmkq20B0Ul+2KeCHZHkaPUJ0c9x/j19Q3d6u58G+KPobbfkI6sIbuuy?=
 =?us-ascii?Q?WpwofQiNwiW/BZES9PVPICpDLhQn0mWwumB0EykOQa78yF+I8Y2etfVJAxfB?=
 =?us-ascii?Q?kclNroXBzIJr78l+8HJMGpQfPDGmDpSUl6b9kK+IX4hg0aBkdOm4tusTVzax?=
 =?us-ascii?Q?1Ix/B61n4ndoUM8KzAw/CGFLYTLisWNnl90Uhz4EIbpIzB1UGhBSaxTBViVL?=
 =?us-ascii?Q?bAORyu8zEJH5ks3zENmDsz1p5sZH/deKHFR2y+eOvqFLMrAWrnUeXHOeA2ZQ?=
 =?us-ascii?Q?Nwmlnh1NbID//0FW3oQ9e/AHKgSsYPpfF6i0L2Mxb1TBp1uZNfgaftrbTXwT?=
 =?us-ascii?Q?i7vYYdhUU91uZaLoYEdPxPPC4+5dVzvSQ0Un+uRgeVI4W5ruXNMLXFwG1WJq?=
 =?us-ascii?Q?u4DzVySpNz2fsGxQA8ge/YrFyckC5ZR8dIwM0kTn7H+uF5IS4d69vag0ANgn?=
 =?us-ascii?Q?NhxbGGABVMNoMIxIAMogZ9lNmVzUO7VBfNme7iXPSfBMAYAVebdBX9qfKz2S?=
 =?us-ascii?Q?s3JaR3CY/e9iwhV1Ck0Fubi7psGz8TBTEnWRBkfKqPxHyoj1csM3iHcz2hHZ?=
 =?us-ascii?Q?UQCvFW1JHo4rzllXqXnGMpZjpO/c0YZGpFF2nSLZULd+V22u75CslJa0VFIg?=
 =?us-ascii?Q?dggdZ5zMotpJCA6n1u+AwVeULRqPPLCPD8N3rzNCOZoh50I77UWufIElszRz?=
 =?us-ascii?Q?gcHJSM4v4gdtfU14dGLgQ+6s27nHy0tTEaFdse0gjAKM9E+v7CsxC/T9whT6?=
 =?us-ascii?Q?aAZNdtxG4I5lHuZsIyEpYgn4/QSuYosXXh/d+crgYu1IBnM/xwckVQ8uTLIA?=
 =?us-ascii?Q?JFZqIlrlNTkyY8c8RUCyYsEW4WMYko2N/hexKrTU9oqJyWDA4DR6I61K1FDn?=
 =?us-ascii?Q?8gQ+vvkody7J/MVCgESn56OwA3aMjtTSpYvzFOjp5Ra7WQErcawg5O1KqHCg?=
 =?us-ascii?Q?3h2XDjfr1DONjH1CBrmemAFAZXOFUGZOHJKgT8mGGKLk/lJF+C9A7+Yj9U+R?=
 =?us-ascii?Q?xutbrpxHJj5XV7JaTCwoF+iiB/12Nfe9RKVajW584f2QxTpcQSyBxUMIPhzy?=
 =?us-ascii?Q?QmGz6G70rZv2H1Jz6fwn/GgtxIeyRbf/OEJYC+NFqNpDOyOS7UYgwH2ot1Mj?=
 =?us-ascii?Q?7zjl1991xTwb6slAK3IcKhBlZAZeOHV3gOaaiAGGQkd5Ki/iGkPypx7j5HiE?=
 =?us-ascii?Q?UKnPGaYkHqDxwfZviWOIj4v9jlBS5fcWJdbhxOoekPR7rizJ2VO5Y7dvH1Ne?=
 =?us-ascii?Q?CryJkKNrOyJZdDtJoh6OP8P0gIoINIwH996yI5QMGiUwHoZ+dud2Mo9vELlE?=
 =?us-ascii?Q?kt/jKX9rWLIDi6ukhcUB5MNro8S5QTCMZ9YBC5lvKTxQrRC5iMJKY35oEaDF?=
 =?us-ascii?Q?mVPAxC+za9VLJCiLtuHy0fTcCHZcKFU+WfmYCJ2yx2Ox4g8+IR8qZFzmnFJf?=
 =?us-ascii?Q?77rSX4kig+x4symLZvGgr+vobC1mYIak0pMmvSf7lRki+vrH7xmVdkeAFH8X?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d7f942-90eb-455c-9de8-08dce47b6dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 13:49:55.6720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 922PMjaYHsb6URX90Ki+lU2E+IoUJesnx+A+VzKOYY3uaY/nbJe1jUEGBJHD/nmnTMJ4IN20qKfuwtz5+io3rSbjRd5pFeg5X/s0MgvHh2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13009
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 13:50:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17005

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, October 4, 2024 1:48 PM
> Subject: Re: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex s=
upport
>=20
> Hi!
>=20
> > > > +	/* Wait for idle */
> > > > +	timeout =3D 100;
> > > > +	while (--timeout) {
> > > > +		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> > > > +			break;
> > > > +		udelay(1);
> > > > +	}
> > > > +
> > > > +	if (!timeout)
> > > > +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> > > > +
> > >
> > > We do not need to process to timeout?
> >
> > HW manual flowchart(Figure 27.57) mentions to wait for ever. So, I
> > have added a safe time out.
>=20
> If the documentation says timeout should never h
appen, should we have
> dev_err() or even WARN() instead of dev_info()?

I will try adding dev_err() as dev_warn() is not acceptable now a days.

Cheers,
Biju

