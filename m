Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0DDC36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:39:17 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.25])
 by mx.groups.io with SMTP id smtpd.web10.42686.1745825903221109229
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:38:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=CrUU5rHu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.25, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJPo2AS9MgrSsQL41WiDQi1pJmjhWwQEe+SgANoGeiN7RImoLqxQQ//Mgl3dpNUoXnNpC1Gbt+Pxy1F7463vVbMq76vDy7hvWX2GvVRm7vDuwefrw56YE7iSXN5dGEPkFWnpFQ0kx1l32gyleP93Nr2u8IVquqTivwwWzSgKapfk+JNhWfiO1jnWwgcptQs38TSDUVSHoJ/MfWNOya7v5LRB8iJFvNICNBLowBW4T+SatF12jUnL0XUlTfnJKgyhkXHgV/zrra2ws18ifR+b4Ugn+1M8LF9DzfavamsCAtTAfddpaucX6sP8sWU/a/FgYFISC7xrVNpOixUxdq80mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/OISvsjWBfShwJcZzV6M7muxjZpvjqYizHu7TcNBMs=;
 b=CF4joolXAApgg7gSlD/U0S2uLJxMWnd3S8cTL/HnkgH/8E5BnKDcsZEyOtw9BVibVJ/+46jqfxuQKXhWqGF+QVRCgTAiAMUiqhXhGBC5VYfXPMfNCBDw3Q5rMcrnjz2rWzBQDKNNW6DEmtG7AZTGDR0O+8Geg1ZJrLuxX7JpdSpkao6Sda2H4CcqLzpqybAgi1/XmJuL0dlQp6X+YNXEUT+c/kRjrKTnU9xTEDvcHJx9C8X3dROIqKZ97LbjWUced/Q+WPV+oCqYZA0ctGkzHiQhuVfXX+jeuypSfqZL0vIq4Fz/TM1kZAegWe3E2s+4zL0gGm8VEQ5WctaRGYk1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/OISvsjWBfShwJcZzV6M7muxjZpvjqYizHu7TcNBMs=;
 b=CrUU5rHum6XBt9T791vKEtJ0hKkCodxr91TUFuv+323p8jFljU6fN8yR8DnF+1abgWVyYDXOw7ho1TpS/7Ct00hcm+Cpp00+3+QO+3sJLNhvF7uum1ox5VqygpJSFfCXVsa/dKXZGqQhuGSMUOjwYvLg7hFTHmsv4eYKJzDbPFc=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB9828.jpnprd01.prod.outlook.com (2603:1096:400:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 07:38:13 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:38:08 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for Renesas
 RZ/V2H(SoC) and EVK
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for
 Renesas RZ/V2H(SoC) and EVK
Thread-Index: AQHbuAuAGFMahQZhyUW9cHBQ9xk/2bO4sI2g
Date: Mon, 28 Apr 2025 07:38:08 +0000
Message-ID: 
 <OSZPR01MB701937601DDD05B499799EEDAA812@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <183A672739828D38.938@lists.cip-project.org> <aA8oA0Qe9hybNv/A@duo.ucw.cz>
In-Reply-To: <aA8oA0Qe9hybNv/A@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB9828:EE_
x-ms-office365-filtering-correlation-id: aca45ec0-2dff-4df0-a91b-08dd86279f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Dofwiug7jUMLlK79JywaZid27bjSn9y8N9RNdn/YJRgcwuWav9dxilHcHtWF?=
 =?us-ascii?Q?2oMHlZOFMdvmfiwnnx+A3Eew7uZNu4gMBfzgz0PXzMguXxcG1BhgX0rpOpym?=
 =?us-ascii?Q?arGESHYUQJsyvG+osvKthgG3ePKb6xyKQgGxHbcEXiWn5cnQkSrxSMqlp/J6?=
 =?us-ascii?Q?PjMpqrv6x1LSCbowugGHY+8lzmeeSHoneDXMajXcgK2cG3mXZg77D8902S6n?=
 =?us-ascii?Q?sAkytAVn5ogS/5ktVz3/K9sLu0ya4CITGDQ8gptVdRnarRqZW9hy1+EG25tr?=
 =?us-ascii?Q?pBEG9Ya07YSPQBEjkLSQZWQBFB0VXhs9idDudhLjx6iWlAWbjBV8CZRHZOgw?=
 =?us-ascii?Q?yq+HS4ISSHKPBVhZK4HPLAX2InQAgRAKTZWyYV5WmYx3BqmP+qqytEzpaBq4?=
 =?us-ascii?Q?VBkBQ/cDQnurs/IvHDgmW0glpLZ8ilPaoYCQRPdVWCtq98dr1QGSMSDDM4vi?=
 =?us-ascii?Q?3rPRbVMUTAh6C7s5oBDiC1eWM7SJR46q2vZocLFsfiiRqKitliu+drh4bSnX?=
 =?us-ascii?Q?+5sgntcZYWNChlIkiwqnoDsbOXdh1YwDMQy53MY+0xSUVQxo47hs3mSYpRAL?=
 =?us-ascii?Q?fpx91J8vAEeTWKoC12xTFnQ+tgNo/MM9i7Qt5z5WenpiPUxV8HFas/cYKb09?=
 =?us-ascii?Q?+00WO9L6gnqsrhFTeBZ55HYpV83sNeqrWuDdQato40MFWqH+94lRJlEwcQru?=
 =?us-ascii?Q?85akBhfR+xqKjuksASBJmiqngvvjO44poHin6euE6ctgCob1+n34Uurkm7ve?=
 =?us-ascii?Q?3CvbnePdqBjGfWD8BcBxNA+b/DrViKV/LyaWsroZIRuBU7KEXx3oqERuIm5H?=
 =?us-ascii?Q?kMllwSOIvm8fRTlh1hyqxPUFN7jvb2aKVIMBoz00QzniMgrYRnUnhWyxpENY?=
 =?us-ascii?Q?6hypdQ4zZ1VRZt3bWlsJ+PhMcvMrptg7Lqua8Ir6Eq/nAxxvuA1g1ekhsLpf?=
 =?us-ascii?Q?1XP1wYFIam/cdZq8alWFfivPhwJQy/w5La6WC4Cx/dOSQjNrpLOjN3qDMl//?=
 =?us-ascii?Q?tacgEe/6wZpyNr5BopQ4OwyFPU78g7/IaDCRFhSrEiiSkTVCNMulrvnRgBYx?=
 =?us-ascii?Q?3P7A6TLLot1AasUrMHkZcs/fm02R1bOwKbHOFS2yeDIDzeU2pV1j+qEEhIFl?=
 =?us-ascii?Q?ouRTQq1Kvh0SZeZQgPB9gRUKHc2753Fq0AiXNaWqKalinzTYDQ8rlSQTGVEz?=
 =?us-ascii?Q?ZV28y/+hmkXtwcb1iwZ/kAAQzI1jEriY/C2THgPgoGawptc0HY1/tG3IjvNq?=
 =?us-ascii?Q?TlYIfl0+FekCo2YLSaS9VzTW1/nVffRgNs7cWrmM5K5fQ5ReJeojgkZQIvP8?=
 =?us-ascii?Q?Hf4T3qMLvNjOPI34e+i6ixlLM3tCiHssIX+1MuFQwovtW+Clyu+Z1k3/7WlE?=
 =?us-ascii?Q?ujZeS0WRiVdKqdR+y5AygnsnvQaOaC1rxAMCijGpW82ReMlsxLVHXgtF4sGb?=
 =?us-ascii?Q?px8g3MH8D8NNdXdJfT/sKyNZBjxWM3eRF4Udp678fHCVlhRVL3BLvw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?J8S3WJ2QovqlAZMPtu/TjZDHRqnHo/0FcmbmnSEskxQYEVuJezBI3YmmXFWZ?=
 =?us-ascii?Q?+AWDW5PmFb7iSASuVtjlyfumhy/4mRTtgUMA5TBe+TrsoguBvh7SWrJpNd0Q?=
 =?us-ascii?Q?tRHTpbuBzxxHAe/uNHGf10W0Q3PqAkkOsGLAnGbAmWj0HuITUFBOYfxK7mBd?=
 =?us-ascii?Q?npu/9p2Yc9bgD/K8zW6kJOdkOi8rAtBX21IVNw9WxeoIRmfIcuFFo+ymx+Mm?=
 =?us-ascii?Q?LxaJguEHLczr5tDKPlBDiyOhg1mXDU4qRVjCzqlAFwTkAHDJj7QU8bSAzMfV?=
 =?us-ascii?Q?oGmGAniLPWg+AqlR7XcgrxCkQqVrxgRI7h2Vu0tB9/7qLsdT/nICRANK/Wn1?=
 =?us-ascii?Q?2tpHdHGxnY6Uyl+GcUkMju2sQE8xRXX9Zg/2eoJnb1khQi302nQXZiOpDeEz?=
 =?us-ascii?Q?XUkkobZVmHd1zKw+SfK30UWuSCwWfFjFah6611G2kO6GIcuJ6RvU5hDxUEm5?=
 =?us-ascii?Q?RCkeLMpg63JIp3GeuxuTkTpEOD0+s8rtlM4XqyTW3Vgs5MwwdqkufyPhpaaA?=
 =?us-ascii?Q?GEKIaOZLks4PFyUFdgVhnffcHNHX8Pmk6zjox3OAg6Iyhgvi7RE71cBb/nZy?=
 =?us-ascii?Q?/VVP77CZT0kP8xi75iCzfjhrhhq9XWENJC6oxFpp3T+Ki5tr7aIKP6EtAOnx?=
 =?us-ascii?Q?FZj0JtfkuWjNmscVcLtVjQV3eh9lSKM8TmCr63eaJPIbgfzBsSvq7h+Kd5B0?=
 =?us-ascii?Q?AoQxZ6MXGFZ37pYYsMWcwUQ60pBo8pEwgkhkq918wy1/cuLA9BGzPvBj0AgQ?=
 =?us-ascii?Q?6fKUWLjN6BufAMQCcWM3Vpd5epxct+nNy9keUpqjSezQdGXvQ4GSWVudrdxm?=
 =?us-ascii?Q?54PT4boUfYaBfe6nB9bapb0qDZamhJt8jdXf4mMGlBoJgtBc7ubsR+4XswU2?=
 =?us-ascii?Q?vkKCVpxMRYFPfltqnZXeMW+P0WsqCFxREDoRKj9y5LGlurJp9fBiRdCoWl1p?=
 =?us-ascii?Q?sfWRFnKt8U0gLyjURSInnZ+shjcAKEnSSLeyxV1Fws0gkoCCNP91HWCuxFBi?=
 =?us-ascii?Q?Owws05a9R2YkwD6yhZDRTjwpdvxbBx41/KiUdQ2Z6phcUMd1hnNN3SShvU2A?=
 =?us-ascii?Q?Th4dBng98N5a/WIWwH6D+I0DrExPQoCrkBQMS8j7jVwQrKvXM8bW3bChD+Fu?=
 =?us-ascii?Q?ejrTLcVEnj2wLPkyH0xl5PcmVcMSdNXsyus+q+uM7P2qj7ZBz+4IsyKVeDQi?=
 =?us-ascii?Q?whEepNFn/XshOQlQVuKjqIuL70u/cfPkgay5SZ/pTWkNWyIyjoGTdMg7RD0q?=
 =?us-ascii?Q?oiFH7FgiB5S1F1nyoAiR1JYCvk1FxSpoKzjRAhvAhrWJy/8GYU9lGV9G14Ci?=
 =?us-ascii?Q?aMP0PLTIN5ZlEnX9s1DzmUW1oB12otCNsfmSOVeUU04sHzeCRO97YOGZN9T1?=
 =?us-ascii?Q?g3fKOvWLwIZALjU6AyRNXKLVpDR05VBxLiSdRrqJAIeaorfUO64YQM8BiRIt?=
 =?us-ascii?Q?1zIiRn71XRbAtLdPIcz/xIrrBCrjNeVtMypRD3FjVyG3tQSFGElDWLd0GOLZ?=
 =?us-ascii?Q?PknWZ15fX3BmAeoNLUd5mpxrspEb3xfDtrLZdXiiRzJGIaDrzAbR8izcrik1?=
 =?us-ascii?Q?lx9COffSVuoZSdLzHW7c8uZSoFWszskBj4adVSY99J6fdX1xqmD5pqvMJgRL?=
 =?us-ascii?Q?SuHFDrsX3apS7yyF7+Nft2M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca45ec0-2dff-4df0-a91b-08dd86279f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 07:38:08.7634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRDF0hnNlH3eqUueZ3EzcC9L/9VOQ6aK+oHSWSvPpyHe3YRbXq7PfKzsIeGv1JZZbMRneWVU4grZ4mXlHwtbyvVh0bXwPN5Lg95E8+zq+V2pIbkO6jmXQma90HuxiGYE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:39:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18688

Hi Pavel,

Thank you for the review.

> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for
> Renesas RZ/V2H(SoC) and EVK
>=20
> On Mon 2025-04-28 08:20:17, Pavel Machek via lists.cip-project.org wrote:
> > Hi!
> >
> > > This patch series aims to add initial support for Renesas
> > > RZ/V2H(P) SoC. With the initial patches in, the EVK platform can
> > > boot up with the below features enabled.
> >
> > Thank you. Series looks okay to me, and I can apply it if there are no
> > other comments and it passes testing.
> >
> > > Note,
> > > - All the patches have been cherry picked from v6.15-rc3
> > > - There are some RZ/G2L SoC family patches which update
> >
> > If you wanted to help me, adding note "All the patches are already in
> > v6.1-cip" would be nice. (I checked few, and assume they are).
>=20
> This should be "in v6.12-cip". Sorry for confusion.
>
Sorry I missed to add this information.

Cheers,
Prabhakar

