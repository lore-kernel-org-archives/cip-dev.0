Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D2C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 05:23:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5184.1785216178651026451
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 22:23:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=L6ZS5TCv;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1785216175;x=1786425775;bh=Mlk6uDWnp7EBnaKO1InlXWFQYswzyrzz/RQSI
	/GlCQw=;b=L6ZS5TCvL5Kujj9XXC2TRlVYmg7Sirfw1kn6P4DmkcYiwlg3E0JYyivYc/ORCS/VBuQ
	qNz2JXQPrHd702j/s/bVrBSkDkOG9cHXWjEhhpGifMfo6RipTxdRW0gN+H77ANH3OZAzZwUblZkRY
	qm5lu5PV8ZUYwwNCe8mg7LnI188fi62pAzDuDQHK7zjlyv3CIslfZ+tPFYP/xFaOfC4i/UVybqQrw
	2Uxq39V74e33EV2uzud7kNW5ksmB5NE/qj6r4rRGaToErj7f1e4IW7R7KcD3jNXeupSlWM9lH31GY
	eAjwMf0tf+k2lm+JtL+4QewutJ9mUF/eyFuglpX1Lqyw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66S5Mt3g406653; Tue, 28 Jul 2026 14:22:55 +0900
X-Iguazu-Qid: 2rWhc6Lor6mTYcj0bJ
X-Iguazu-QSIG: v=2; s=1; t=1785216174; q=2rWhc6Lor6mTYcj0bJ; m=Yx2d8cx0WpJk8h+6zzR3UG9w71m0oDdbmqMgABIn4zI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h8P4G2Wjvz4vyn; Tue, 28 Jul 2026 14:22:54 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW3yCVyHH+lBNnYHATMaNcgrErB4AqkZJQYuIgIF7RzD5GjuaHTgMVuRBJtRH1M/vnuHSA3yP5pro3dZ27vqm1zD/YhNTCXlWaCwU/CmCmrNej3zZkiKqKlFmZUfSNbmj99zS+vBPgpuB3fYwMTPBrw4UDD4Z+zZX+6Gzcy4At1pgK1vXsf9A56+LfaPmaY6SxML3VOHn0Dgl1k7KtyheQNYry/SJafvX5tTNiXgSVjNti9QLhN69M0Srmf+ahL8wH983kYYVamjNGbJnrLAUfRJ9izQnRbfRF1rX8l4inNkTLvHCoMHJ52Y4NzxitNWlpoaGD19Ge6w5yV504z++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvqZOg6Pv1CTzIIi8IPy8oQIyUQ4qi8s6HozvE7TaHU=;
 b=CqRX63K5Ktb5MY/Egw0rmkB9C1slB/m4Cs4P3QOERMfWZyDT/5wDmCmDL8PsytxmAeR7v5HskG54zWT8GnDTNybQHT2Kl1MD3mK0YlXz1rrAqLboffG7NDjUUqmzYUdjIfrZXb/gvCgMuGP4pg2R5OF6B0TYrhtfBZIo7t6nMSdmnfSApyhAtFtgdboAfBcpLFyHYcqzt1SRN7kP+6M0E/rs5WHygT0OQ4z2/5QX4pvMajtSjqAln2PR/7+dPrAEBMgAaAcl2Fc75YmJTg7sk3J1oYECZxE/GJ4EfS3z8Qh+JJ4XCTuXi59gcPr2rn4/K89amd83SdbH9Gei0Ibu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip v2 00/22] Backport RZ/G3S USB support
Thread-Topic: [PATCH 6.1.y-cip v2 00/22] Backport RZ/G3S USB support
Thread-Index: AQHdDrF8cvOCwNefEE+eBDZeGCCRb7aBbMKAgAETJHA=
Date: Tue, 28 Jul 2026 05:22:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C57D19F20E8B600E225DCDCB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260708081159.3882514-1-claudiu.beznea@tuxon.dev>
 <amdRr8AyS5v6aAob@duo.ucw.cz>
In-Reply-To: <amdRr8AyS5v6aAob@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13503:EE_
x-ms-office365-filtering-correlation-id: e08887de-dce4-4e06-e5be-08deec684549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 lqAU7gm5K+cHAe2eDM+UkbyKzRa/Jo0nEZ5xF6UcYJXUBSqKWEgBzEgd+lSaHZPvFMFIHg+8O/MnkchFtTLVBJYM3RU07FnzJed77y9Yn/kTrkZpSiUGHgxMNYLcO23UDNqUhFhj7YrWOnZ5Fa5QOX2iZROZA6Iv5KgZtMlTX9mGOnLH29TaZM759YauOb0Q0vjGt1LPaTcYzVx9AyfE4Y2Z6Drl1JCuPbLb6UaicKEQJa0ZTiP87auKOv+TCgYv9/IkKKzf99Xb0ZIEyeQ1Ou5Tr3xpmAkI+AyaHhzzgCg3XvaD4IEpAoI9rvgAfRP5N9hdYNAYRW17s6Q/0XVHvwIYTm+HHourhiMUwkbAo2zwL2EWVum6fyGg+RTm+Ut/Gz/mPx5qHfbXqDS/zPnsoxSQvVU+jTqjqy1CcmV/8AowiQASPOaqZweGEpIzDecCwb+cV7QYnhzRHpqXI2qw5KQ8h4b0wT1ESa65ecxp5eyP/YFYOvJ4isUS/GsNAYoSgjiyzlGtoVbSGu/ajbcoL9yK007y8vS4XuUMcISnE7sLiZxzL+YOgzfagApapRwRvWJg+Ko2prP3xBP4IMMAe5L1cvGVOyGfyyZ5LYiaDTuOWYNS4Nh2FtW7yXhNfj5zwwASTy7RAc4QdZQFguoD01gL3u6s0WrLwcdn7Yzlr33FX2zCHd3YeKrJbNoNYhqF5an1MywI81yi0pt7MOjTmA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TDFTWHlPcXBhWTFSNXU4RTlYTEFPMzF1bGNHRmRvS3p1OFdZNUthanZR?=
 =?iso-2022-jp?B?S054NmN1SWxDMUxiaVRQMDdpQ3Y1Zlp2dHFvR3NzSktWUGtjVmFVSzV5?=
 =?iso-2022-jp?B?UUVnUDNURmJmb0htRHNoR3J4Z0xYODk1MEhYdzM4eGt5aktxQVI1S2hy?=
 =?iso-2022-jp?B?UWFDSEZON0FabEl3Y1d1dUxhbFB0ZGRPRUJ3TDhDUzBMOEhBemwrQUxC?=
 =?iso-2022-jp?B?VDZ3QU5xdkpEa25VbWhNR05ia2xOMXJobVJOMHU4U2Z4bjJtUnhGTjIv?=
 =?iso-2022-jp?B?YmxmSEd0bnFtY21ESk12MVk1eDdGVFB0NEFTd1RaQTUyd1I5RGFqdWdz?=
 =?iso-2022-jp?B?blg2eEw3Q3IrK0VCSzh4KzYxOUpzSjlkY0wwd240MG5EZ2tMQnBnc21z?=
 =?iso-2022-jp?B?QTJNNGs2TUVjQWRXdm4yelpLY1dxSnVKOVR2UHJhNjcxZHpKWjJLaklP?=
 =?iso-2022-jp?B?QmdZalhRRFIwaFBUMEtoV1dkaEdLdS9GWGlzV0pQZkNqUWU3dEZiUUdB?=
 =?iso-2022-jp?B?YnVBTkkxNW9EdkJ5bGNWQk5ySWlhS25lWDlNSHM1b1pzM3V6Zm5mTU4v?=
 =?iso-2022-jp?B?Ykx1N0VsdVEyOG1VU1d5ZHo4b1ptS3lDalpibU1YVW44aDcrQlNVSktr?=
 =?iso-2022-jp?B?YXpJYlpOUU1iQStYNVJnbk1UZnZ0NHZvVE4ycSthZGR1QjY5VS9Ha1Zw?=
 =?iso-2022-jp?B?L2hVOWhBYWRjdXZoRTNnaGgxUHZXQmcrakhRSzEyNndYTHp3NDU2c3hn?=
 =?iso-2022-jp?B?bUNNU21vclhZYXlrMXBYdXJKaTYvZzBhNkZQNTFOTlBLcldLdjl4ejhJ?=
 =?iso-2022-jp?B?d0xoZkcycjVwdE9hbFBHbXNYSndDNTZET1lFRUJTTmx6UWNPcDNJQlBM?=
 =?iso-2022-jp?B?YjUyeDNnUWhlSTkvVzdNaEg3OHk3UitZTHN4SDA3b1lWZXc4d2haVk9O?=
 =?iso-2022-jp?B?S3ZSL2djQTRDcWFpYUJuOExQSVcrZDh0R2tMcDdQY0xVMkFXRktMQW05?=
 =?iso-2022-jp?B?cGR5cnRkWG5pMDdMUm0vMVd4RmtWeVVGQmtsL3M4MklINTQvbmEyS2tu?=
 =?iso-2022-jp?B?UCtQc2E4SmlkNlpYRVdWVWdNNUhlbk1xY3FtMUp4KzVMejM3UVBMS1V4?=
 =?iso-2022-jp?B?bXY3dUljV21Yb1FKU2xQUnlPOE1qZGkxWHNqd0daSFdTTmx2MktZSXAv?=
 =?iso-2022-jp?B?UzVYamNQcHUwOW5lbVhyUTZzcTUvUkYyc3M2cGhDSnluaEEwblNlaEM0?=
 =?iso-2022-jp?B?bGllNFFtaUhJYU5wSFJJMngvTWN3STFJZGF6NkN5Q3pKZHo2a2o2Zm1p?=
 =?iso-2022-jp?B?cUpnSmtJYStZSnhkckFrUUFHd1c5cU9KY2Y0bWl6eHRncmMzSlpNeW9h?=
 =?iso-2022-jp?B?UGhaM09TUi9DM1VLY1FkTW1wdndMaStML2dORlBrNVB5RzRLczFGNVJO?=
 =?iso-2022-jp?B?Tk5VMVVlcWNPQnZQNkhlekZGMUZxNUM4UFJEU3BpVmpBa0UxdjMzSWRo?=
 =?iso-2022-jp?B?WXI0VTk1MGlEYWNIa1YrN1ZNaFNMOTk5NjRJR3F2MVp3ZzJwbVBqWVUw?=
 =?iso-2022-jp?B?bTNqSXdxY0RPMjkvNnBmTlRva0Z5Kzd3VnR4UlFNWWJ2T0hzOE1XaEpO?=
 =?iso-2022-jp?B?YnR3UW9JNEY3NDY5bDhFT1k2amNuZWR2WkNONEJvRUdCTVFSUXVhMVdx?=
 =?iso-2022-jp?B?R3lZcXZpbjd3WllFVkgxM0F1Y0J1TUZubFNCK21Ra1NSU3JJWXpBVnVT?=
 =?iso-2022-jp?B?NEFUZW5WNDdXTHVlYStBOEVtM3BKblJVd1hVdW1DVlJKZ1lIUU1LQXEw?=
 =?iso-2022-jp?B?ZW9RSkNJZ1FCREJDcXFCNnlnY2ZGVWtmSkZEZHJJaG0yczZxU0Z5YUhH?=
 =?iso-2022-jp?B?Q1c1elN1MDN4NW1TdDZseUxiT0xXbkFYdEhZZ0hyZmJwMlhDcVk3ZHl4?=
 =?iso-2022-jp?B?WWVyaVI5SmNQNW1pR2xMdHllRDRoVXY5Z2RodjJLdVFoWk0wU2ZwWE9O?=
 =?iso-2022-jp?B?SktxdjdtQ0lSaVdMNEVnUTQzRUlZTUtZdnhkcFRTVGwwZHlkYitXTU0r?=
 =?iso-2022-jp?B?NlA2ZlVNL2ovOHN6Q01HM2ZNUGdsUlRaZlJFczFNcllyWXIrSUNVTzFp?=
 =?iso-2022-jp?B?S2FDbGRuWUhwMVgxTkZ2Rklud0ZqKzU3V3duSExuaTFXc3kyUGVYMVQ4?=
 =?iso-2022-jp?B?djMrc1k2amlRMWVidDZtV3R0azFIcXliZklvVVBhZjVEcTIxN1hnbDBa?=
 =?iso-2022-jp?B?bjhpTTNnOXkxcmRTSG1tejg3VU5zVjBhR3lkNkN3YTJhUWNZTlNDSnNi?=
 =?iso-2022-jp?B?a0VubFhVQ0dKanhXcEM3UCtqT2xmejlmMFdMd0ZFcE1waldpY1RPRitr?=
 =?iso-2022-jp?B?d1Jqb2tNSkovOUJTbGNaWVJhR21iRHhweG0yRDRHcDBoemZZMHpxazR1?=
 =?iso-2022-jp?B?VGZmdWlVYVd2LzNKUmFrUWJQUmxUSDRoZXAwRGY5Rkxhb3AyOTBDTmwr?=
 =?iso-2022-jp?B?T2x4MUdiMSs4ZkxtVEVtK2wvckNYRERiUUpQWlNabytqTW5MSzlQeHFt?=
 =?iso-2022-jp?B?QXc0THNvQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	FPWdRj3x2gUDfYtEId0PjpWRXf9b2/Ppr5NCnVCk5voA0hXs6yRDqy89fJKqCGest9+BCdu+84BQt0DpUzeNZ6ri0lHAxxy2YKdPCaO4TIlmjQl1+rl3uI0j5KFqzHO34LI2AfVCmkuO3lQYPB95vtL/UIMX16PCZ7yXZfn7wIlfZBjdbdrIJr0x4pY1vr7ujbPwkU5IGTBjSrj0HufwL7AnXH23KUS9BU2xBjEnZg1Vm5I+alNxKqNM66PMO/1if3cNuNBaabJHnscOw3f86fgZIqmGeCcu7MLEj+LGJw8QNEQdk0Iqjcn4WHlRKQY1NhY7jpKdHUfTKSzjZbHm3Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08887de-dce4-4e06-e5be-08deec684549
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 05:22:51.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Km2cGBlFcQYJFc4I7HftDlfwddR99S4GKtyybZhS0Uupn7Zcx5/UuYFBn5ZX2dUjQX6hzu+bHUbbQVUKZ5GUvTfB99VzDK23gWwwsmgyqX/dO0q/f/fDO57uNI+OITf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13503
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 05:23:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23788

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, July 27, 2026 9:40 PM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 6.1.y-cip v2 00/22] Backport RZ/G3S USB support
>=20
> Hi!
>=20
> > Patches backport the Renesas RZ/G3S USB support.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks good to me too.
I applied with Pavel's Reviewed-by tag and pushed.=20

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


