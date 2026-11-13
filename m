Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9187.1794570405543616989
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 03:46:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=bMIGb0u2;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.65, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyTofyRwkHWh+vAQks/uat0u3am3jmC9H598KMqRD3yd0ssbSuyCPhtJ8zSbKZXMIGc9ZNg3hMe9xaafKf+xVRw5Ctx1aMQkbj4+0FooKFDip38aZ8tVU7IZg/0U4D4JgwIMPsSZZv6iiekdXOQy8jo48DSuxAy0e1emWz90yOWtp5sD3Xk3307Q5LI739zVkoUVhhJ2KS1dNgKFtrXJdNyySWVK6Pz5yLxweI+z6rFfgSnGabYeKucflPMmpwmCsLaiZUZ3tU9HPq6YzGbslhYgcGQAI5JtPw0Uyqu6tIVukCKzCkKZqGa+H2O0PwKRG/p6/+cUrDQVcL+EUBHhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TtYBvReyBjRQWL0z2W9KcEsHb/93Z1uEw2df9cyaDY=;
 b=DfR+azgP8inVLBeSlPLs+a6Bb2ZHOoG5z14fSmmPBMcfrEfByPidEC4ka+0sG2CPJ2swsVUYobVBFUypkUaCFk8NyZFvVhqPfWhgVrRx4iw/m+8zxIJZAYh1VSlfGI1xszr0JVG2cympWvbY4vPQoq6m0KfSLTewnQGHHh0bXECxxP7bR5pg+dUIUvE8ZYxvmAahl9JoSSAE9VMVly47/qWoJE8AUCrSk/KScRizTHeYNBVBV6qLB/kheIG1soLoDve87E+HdkdOg2CQlJ7CaI10iA5I77P+E2xmFARPAbncUa2DiUN4kNjarz2yy+SRvLu0dctim2pTweRnfuTsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TtYBvReyBjRQWL0z2W9KcEsHb/93Z1uEw2df9cyaDY=;
 b=bMIGb0u207lJyk96ZPAqEGkgwiBFWRyppc+t7rwACeJb7lpHeS6HDKiJsanJuso2ckeNeHuDhwjuA9J3pk2/AI2YPEFp1sCIY/5kdyXjJXDEBLo5PF8gSNPbmvAo6r376g3Qs9ZSBt5ZuJXdfZc1UF+2X7u+8RzJmfcsJbLDnV4=
Received: from TY4PR01MB443929.jpnprd01.prod.outlook.com
 (2603:1096:403:707::18) by OS9PR01MB17187.jpnprd01.prod.outlook.com
 (2603:1096:604:409::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 11:46:38 +0000
Received: from TY4PR01MB443929.jpnprd01.prod.outlook.com
 ([fe80::82b2:2570:827b:3e2a]) by TY4PR01MB443929.jpnprd01.prod.outlook.com
 ([fe80::82b2:2570:827b:3e2a%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 11:46:29 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
 clk_divider_bestdiv() ULONG_MAX handling
Thread-Topic: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
 clk_divider_bestdiv() ULONG_MAX handling
Thread-Index: AQHdcxuVfzvBPMww9Ea0IA7mENGC/LcrsZ1g
Date: Fri, 13 Nov 2026 11:46:29 +0000
Message-ID: <TY4PR01MB44392967D341C138EC7EAAE395AA7F2@TY4PR01MB443929.jpnprd01.prod.outlook.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261109121451.6042-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <avYagTe3duUCQ328@duo.ucw.cz>
In-Reply-To: <avYagTe3duUCQ328@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB443929:EE_|OS9PR01MB17187:EE_
x-ms-office365-filtering-correlation-id: 1b0039a8-6d4b-43fc-2909-08df417bc1af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021135927099003|56012099006|261009223027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: TGzCdp5OUZH7ebae7S5DqIEvCXnxwycHZx3Lns2n1I6/ELobVDC+wxh6dgT57DjcUnf5J0V9IaBY/8PGRROZpGTCDOoYAWFfokXen6jwSRrdp1BgCKVzgKyrPT7ETXfhcsCmpO72CrL+PRYLaLouNUoToSW2GHd9EROlZU5okHAlafsuqsl5rmtoev0cllBi3wJCbXT8pVIDzAQxC6T9de/FZC4lBf+N8idD4UvDAwjCD4JtYdFwk+jK4jegCSKeqtFA3Ts56Vf/NaYT5e0/L+YsxZ1C+9UDe3WmIIQpWfPyV3UjacU7Q6slb9VhopqH0xgxHJs/fFdjGsEdDM+ELq8QNJtXrfMW1YqbuCvXX19BnuAUZagI6fV+PKKKRc1DZJlMjtQ70ijSF27WeAXlLybTrjU05RMs3gv3eyv/f+IevezyCrMc5wuLEmsRv923PoDIw71M0O8cPM4e7Zqz4Mm67SW3tMWAjv7yGXfH6FqwRaFTXbfBkh75NECf1iqUpa4vq0l4ay16Car42zjRlqcdafm3aByYvEgYoKY6FGWjF4it9UK5S2nYS2uoA7L13YfRlZ6g6pCz5KBJl1lag/mRgIg1c2J0wp3Xf/zhUjm8P1/fr/GVR+uTLfP9innSNS+r0Wk71Vzfj7NT0Iyi73ceSXGmUT5psUCxDXJ9mxpkUVkduaspypzju7uVYrK5E1t0dWYuXBxrqGjAVDcnO/P4JSbR9P145CbGSIHjp5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB443929.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021135927099003)(56012099006)(261009223027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oP7T4zuN8MChVXtDH0QMstiTwCtCEm32mn6iRmqUiHm6u0P6ax+GULA9ULkl?=
 =?us-ascii?Q?4aNdBqU9ogmmbN7SJqhzeNMprQkGu7FQ+mL6NdS1i/QbdiNWpYhdUAcFU/5X?=
 =?us-ascii?Q?mtQPBV1OK1oeJz6GLYVZyY3C4B96oQPUoZFnsHJHDkfugnp5GhVbTz41ae3S?=
 =?us-ascii?Q?dSZ1SBdNbmSa7gOQMdgNQdRI98vcvXFbKIgNICXhxXwfME6f/xiGx81r+F15?=
 =?us-ascii?Q?5n1pX2flQJv1W4t5V22J0dleIvokFJLkezVwJZyZIBHHLXr3FUQTMGTLB/5m?=
 =?us-ascii?Q?+GgaWn7Uj3EMRj0zPKhN4NVW6lTY5cwZO0iZUkJzRTCeCDepSmXCRrpH6mob?=
 =?us-ascii?Q?z5Ji0dMw9zYyfgEMnVx3uqF04i0oDSo/9MsOWUrEzfIAzQuhltrsnrEEI5j1?=
 =?us-ascii?Q?cOcvkHRFsLyfC2cdsnPc4dmnFMZOBwa1bcWr/BoLVnA/Httft6bQzjsOLtN1?=
 =?us-ascii?Q?dKr/pNMGR8a7w4g29/K8FpbGvuuZnuBHYKE6ifIL+2doHb1E5LjT32dVcUGg?=
 =?us-ascii?Q?1dhocbXhuCphCVdmR079D/Ta7gFGiHSPbkfyIaYRAh8FjENtkmFizjVqLb8U?=
 =?us-ascii?Q?M+Yw8GtiLZw1oLof8JBqYC1q+UOiNk/ywUnZbN/a17oWIlzbNsJ67mwUQzT4?=
 =?us-ascii?Q?Nze/6hCj0IBV/h/w9hV/opxmS37gfMWb5aFMqxaTtEUbgdde1sjb9sSnRXOt?=
 =?us-ascii?Q?Om9pOV2PdbMduHdTZFNHvdpllUeelGSb80HIZc+bxUnnGdUrco5mdIWqEOpT?=
 =?us-ascii?Q?g4IY38wHNgPKxgMmgu2+4sTJlmW3fVTnRZ0q2gis5vI/BHr2ECmbnD4FQleS?=
 =?us-ascii?Q?Es3Yd6bXt+Xn9aOU2TxPcWWQodJNVmOTLaySsWGRHBM9JP/BpwjpxSGzc+B8?=
 =?us-ascii?Q?xNvrTku/t9/xAWtr0PAJEjHtP0juwk7Vno5+B9OPfOeiA9tJegaDsWoHT0ga?=
 =?us-ascii?Q?AgInz0EGvnx3ce9A3TaNxfrTZmz4uY6qdxzBeSaMKRw+UAPpZgdK/JSTyT6Z?=
 =?us-ascii?Q?/CR14XgQOx9haLTWsrDye6UFrSLtnv3eNMn9u8ZZDty4BPem6exwI82zgx8H?=
 =?us-ascii?Q?RDxES4lCOmL8r0FFqBaPGzlZqVriiLIbh1ymWANXrM6TqsZplJlmVT/n5vju?=
 =?us-ascii?Q?rHDm+l1H6HPGcdHYS3JyrpgkO5aEwNafEK4wLkChPNd4ZyFy2+QEut3r2vDZ?=
 =?us-ascii?Q?5mUUbFKRf6GNfDuwB/kjTksZ5Q9yDHExMWkhB1K/dejbrkxb1GF12wictVTd?=
 =?us-ascii?Q?fUg9JHeRtHZMlx9fSObLGlskCLXmWvC96qo/r4+MmYU7q9/WQAgcN+47E2y8?=
 =?us-ascii?Q?M7qpbst5DEhi/p7WT6MUw5pNJ1ra94SkHUuDuyuZOXLdH7SqDEnfV9y0GE1p?=
 =?us-ascii?Q?VWoiPxuCCGgtxOikcn59h4Kju1fZND8iVgjGkieo7lary4HZQE/As8JPcIIb?=
 =?us-ascii?Q?Pj3mJK4wS2nxc/9/6tuXakLg3LveOzHBlkxCxZ8nGHfLn7QyB1Hg0AfEFU/c?=
 =?us-ascii?Q?w0NfnktBsgAGxCUw6/rJ4SAkfJ1MRsiShmglw6Al58O7B4TrsHMYu5lMJK+R?=
 =?us-ascii?Q?blMrrB1xExbnMW9GQVDK97aS11XIRW5QiVOhFORJnJcc2tsYWDXCutAjZwfc?=
 =?us-ascii?Q?wxB/L8tBlngQJ24KQgysosN4gbLlxWPpSdFxcIvqBQ3ooBEPt0SHBx/0YsK7?=
 =?us-ascii?Q?3VzmEt7aj8ZY4+I6e6U0gg+W0i/sEVQCTtwzgk46VKBLVpkqMzOpPQkw5BEy?=
 =?us-ascii?Q?xrjvRoR1OQm/bY1zbKziTpyBqjIWR59qTyMCY87wR9Bh16nTYf5l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB443929.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0039a8-6d4b-43fc-2909-08df417bc1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 11:46:29.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DvAPegxS9DAqhpMkEMnW1E+wrMe2pBguHFcVqWsnPA3CE8h8T4w8Tr7mWJ+bgrunsha+fuweLfq9dj4Ip3dOMr+pUa+T9iQAMX2ClTc5zOsS5JaAYkWmvywnutBCrzM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 11:46:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24798

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 12 November 2026 19:59
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
> clk_divider_bestdiv() ULONG_MAX handling
>=20
> Hi!
>=20
> > commit 50ca555d6ae8205374e406b411ae0e8e9447568d upstream.
> >
> > Add KUnit tests to verify the behaviour of clk_divider_bestdiv() when
> > clk_round_rate() is called with ULONG_MAX, which is the canonical way
> > to probe the maximum rate a clock can produce.
>=20
> Do we strictly need the kunit tests in -cip? They should not be required
> for functionality.
>=20
Agreed, I will drop it.

Cheers,
Prabhakar

> Best regards,
> 							Pavel
>=20
> >  drivers/clk/.kunitconfig       |   1 +
> >  drivers/clk/Kconfig            |   8 ++
> >  drivers/clk/Makefile           |   1 +
> >  drivers/clk/clk-divider_test.c | 153
> > +++++++++++++++++++++++++++++++++
> >  4 files changed, 163 insertions(+)
> >  create mode 100644 drivers/clk/clk-divider_test.c
