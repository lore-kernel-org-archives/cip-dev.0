Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17692F531CE
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 03:21:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10919.1776223290576229182
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Apr 2026 20:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=KrUfwDFU;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776223286;x=1777432886;bh=eQxkXQYikn+XUcIx5KKAsj9T/TFAmK0uaM4Ea
	7auI+w=;b=KrUfwDFUFhjdvm+ix7K9RQeROuxEndVR6AtthGh0Oj3J7Zf39Ns1HIgZlx+6dP2KpI0
	QXsjFK3IxCxFgw7ciT9R9TUqBkVpXOzOoLZ6a8jviRJ0w9yAp8pEluWbDK+Gx29d1hDJuh1iw8chT
	RNsSZV5CkiPld73INz2VLtUda3+f5VgBu4Hq6vziSf5AmcN0UEGjKFOQtOYMN2f5nJWI0zAkv6jmF
	xJ+co+iWsSA0gKGTZHrBPSUVN7PjqOOrv90bIPz3FRtyA48phdxEwxDKDzLkJmc+AOhmyA+kDm9ON
	PtDQzU+HolG/tJUhGRcYMTegeJMRPkFPDM8ebG8b516A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 63F3LQQg3981125; Wed, 15 Apr 2026 12:21:26 +0900
X-Iguazu-Qid: 2yAbljrMjhMU6aEDoX
X-Iguazu-QSIG: v=2; s=0; t=1776223286; q=2yAbljrMjhMU6aEDoX; m=qMcS2ZhDpNtA2oxnCgUmGCAilvblYGpIdWRLRsEOGzE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fwRJ56X3vz1xnZ; Wed, 15 Apr 2026 12:21:25 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIoMCmWzJ5KOKoGXUzRe+Md//SLlE9YEEb4xH3jkCGgyA2he+lnRypnx2KX0aLSuRMB7aI2t9SveabWyz2wQI5TbvG8KHZUJzdfPg0NB3LB401BKK7XarlqQBbldDoUCwWlf5SRenEFYw9yenJ+ds8sxymizvJDW+fT3x5uSR9UrpsuljAyo3+B1sBkruz/9n1CIFMeVwY0QtzOUjUooFpIny/YYkRVtez2CO+yfgjNM8IMf5uNnTYodp5/3jg6I1CH5SM2qvrsWgGUNK6lRnHiddlgZnwk+9DBIuBx8pLAYA2409VJxMP5Z5gua4n4AJboLgmT61EBlRZZoPVGU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVGSRL2mosrcVSGviWbmaqRJog6OeY/cHyR6Rbg2pDk=;
 b=uvRTFd8wqosSoRvYGOPUDmcVXHnviq1xrmhTl1Ij+Qu8kk2JUN5HWjxZzjeYTcjvZKftxoyBRcov0Vqzlm9Zfko6hxhBGZ8UjutNIMqxUPe/zxqcD9kf1I9KHEvMsbiMVstbph5+RFLqfHHQ3sXHXq2BwAGixfDC5iJJnWTNwvBUiNxzWKbhrnL486K8mPJaMwIfLtgHbSTqp6Juru4Rxuoj3t/i1oULgh5lHM7A47qt9cF1iAHEMAZHGfiL51AnTIcK8tS8oHtUZ5skSES6ZDWks/FsrrxKYFiKk+qRU4dDh65NrOy7CurgTiiqOksOWDd8gsdgSosLRqKDRXf8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cosmin-gabriel.tanislav.xa@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2H and RZ/N2H
Thread-Topic: [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2H and RZ/N2H
Thread-Index: AQHcyQvqXNHIv8jd0E2M2H2Ro/oRfLXfek0Q
Date: Wed, 15 Apr 2026 03:21:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184B2C1FBF41C6718DBD1CCD222@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14717:EE_
x-ms-office365-filtering-correlation-id: dea6ed63-f3f2-4010-0a49-08de9a9e11dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 jQNLeSWgGHpZiiQEswsnPxbYzurp7KZklS+e+LC30fThOI7wbzRG2CTm5K/RUpW0OC3wSXwgLnKvCqv5J5goMRdfKozVmj7yTo52mukHHbiBM4B6Q9OKpp2ZHNLOuT7eT90uDBS28LWtD3fCyPhN2q4tzBV5HV1hcWp39U3g8652JC4VBX2p07qe6R9YVMjpUbtLzS/jcuxfvqMhXVQK764T+J5+NQftcK+opcZmbnjK/jVlheWARKZa8y2ICNIT2GCUvpXuF0qjTPRG1G3Vku6YdUgABqCodzHIIFurkvLv5cZDmBxG1tqDh2JOO7IKRSPdFcv0FGiUD9c+O8FWMuH1BpxgskdL7V7Jp1RBpoeZ2vRlS6w0c5d4qjA8oqyEMhBE4BJ4s+2BEhJo8ic3VfLLTUNQCgWC8iY+GjIm+5dR0KRInycqtx+77TYcNHQXTtt/KnaIr3Nh54i2w2WBY+LwR5HPX2XYKwRGeoHlJ1xG4I9jf/E3IV+JHLiHcyeB4DBRBzP5pPDqGDmg18IpoYFIHH9nq4wR7mLu+71SmW+whCzsKwO+jms2vMONh+5BKqmvOUEgMKoR5FhNGYMj29xLYt7ozVmrwjBpg76nJL8/5j0zFaSSC2WXBBuQ+tE83bHfF7pvgoaHgPJfpSiIRuPZNuJvRDAypkhtLSpboVDh9BxkThwMvqzEHCTXzRpbZQHjpw6X8wOsqVJkcJ+NlZk9/6JE6I08rmYgsfeUPTauUF/LvtCwRUm92HSPlzH9
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TEZoK1hkYzgzaDAxUDJpTnI2d0tOUzU1cnFxMi9VZ2JHWWk0MkJBd2hQ?=
 =?iso-2022-jp?B?YUNFZ2VqQTdGRnU3Y2FuWVJXMnlVZGNqVVVZb2FkMXg1NmZrcXZuK21u?=
 =?iso-2022-jp?B?TG02Zk5uUG45cTk3RnQwQmpGY1hxcUgvYjhRNWhlRWZOWFUzdzgvN0RX?=
 =?iso-2022-jp?B?TXhFYzNYQlpobzRQeGV0aTV4dGRKTWNMTklDYnZRYWlZNUVuUHhhNlZx?=
 =?iso-2022-jp?B?dlhuaGFzOE0xdUQxTXVOSEhtbXNJd0EzbWpjbktqZ2c0S09sMThpNzh5?=
 =?iso-2022-jp?B?Y2E2cXRBS1BQbGpzL2t3cGdrK0Vza0RPVjVpV0JTTFU1bklPSTdhWmdI?=
 =?iso-2022-jp?B?cWtIMEtOVm9TK3krSHNzbnVZeXZLZjBNeDVaNHpsUURrTk45aGhBTmo0?=
 =?iso-2022-jp?B?V2lXK3lzK0h6enpUeGFRSDRtWEpHN3BPVFJRQUdVRFVBS2ZzZkVHNXNu?=
 =?iso-2022-jp?B?cTlpR1g4Yk5rMStWL0gxSHRGM3RrUGthbFBSNm9tUDNuOFJwWGczNEVZ?=
 =?iso-2022-jp?B?RlZuWFlNMXI0dTJkQ0c5NGNwQW9ibE1EUWl1RGMwb28rSldyR0E3ZTJW?=
 =?iso-2022-jp?B?YlhyRWFQNEdreTFXRzRqNDBXZlkrUzE2Y0VPUGJiRUJlNDlDazFiVWJ3?=
 =?iso-2022-jp?B?N1k0dUNDYzZOWmlNQzA2VFhrU29CNTY2M2pyQ2hZeFVYaFliL1hucTVk?=
 =?iso-2022-jp?B?OExkVjNCVHNoRlpNMzJPNjZOYVBGbXBxTENJb2h4YThVdHpSaGVJZ29v?=
 =?iso-2022-jp?B?TjMxZnlndDhnVCtFeGpxSWY3N3dSYno5ZE15YU5ZR0owOGZWdFl6LzhB?=
 =?iso-2022-jp?B?TEU3SnlZelRBR2plUDhIazBETVpJWldpNFdDTTJIMFBXOS9QU21SeEpZ?=
 =?iso-2022-jp?B?OUxBYWFOZ0swa2tDNXFnNlZsODVUT3ptcFIxWHQwZUUxam1BSktmR002?=
 =?iso-2022-jp?B?aXZhblZYVnQ3UjluQmcycnloTTJMK2E1aGtOUGZLSmpVVmtMYkswbmtE?=
 =?iso-2022-jp?B?eWJqSDFZSm44T0FGZGtzNU1qQ0lyTWVJalFocFMrV1NtM0tpc25XaTdo?=
 =?iso-2022-jp?B?Yi8xZFp4cnhXRHFlVGxpSWNaQ05aN08rZnc1d2RiSlhnUEttcEJ2aS9k?=
 =?iso-2022-jp?B?VUorZnduT3dweWd1My90NXhGb3lhTGpCYnZJVmpYM3dTcFFZVm04cTVD?=
 =?iso-2022-jp?B?ck9ZU25ucHErd0hzS1p4MnlUR2wwbU1hTTBGWXljdFF2K2pBRXk3Nmo2?=
 =?iso-2022-jp?B?TklidVV0ZHBpVnhOZUlmc3doNUx6cnozcFZoeWd5MDUzZTZERW5XUll0?=
 =?iso-2022-jp?B?RjY2R2NUVDVxS1V1TjNOd3hCQ2Vmc1dCalVJQit2cWcyaFN5WDZWRjA0?=
 =?iso-2022-jp?B?VC9SOUwxbVd2TGtLcmttUmlKRFRjVUVZN1FFa0pEVXpheWhvblFpWXd1?=
 =?iso-2022-jp?B?Y0RMNmVIWFRhcXdYbzZQUlRGbVRRRWtkR3pwT1ZldW5pL29RN2owTTBT?=
 =?iso-2022-jp?B?ekV4N2hmS1RYcDNkVmszMXJySzltWFVxcFBhcDJBcG9vN0ZMdFMranBo?=
 =?iso-2022-jp?B?N2dpbTNNTXhDbWU2KzRQYVZFWE9YU3hHZnA3MXFtVVdHZ0Y1RDljNGRS?=
 =?iso-2022-jp?B?b0YrUHI1UEJXS2U5UnlHdjg5ajBXUENtclVwWHRyeG5XNGJYK3lWN3l6?=
 =?iso-2022-jp?B?NmY1S3l0Qjg0Qk1yT1Q5NitiTC9DUk5XWTZzSWlsN2VONGxGQmp4NVBp?=
 =?iso-2022-jp?B?OHlyYmxCL2NFUzJqcWViZW9UdkZocitzOFdUOEJKT0wzL1AvKzdjTnAy?=
 =?iso-2022-jp?B?SHkwSHg5Qmx6cXVYd2ZrOWJmSzYxUnkwODZPdWFFK3EyOEo0dXR2aE1s?=
 =?iso-2022-jp?B?cVFVZWxYV1J2bHBoUitPVml5RFNxRG1YMEMyN2F1ekhTU1VESDdlK1Ar?=
 =?iso-2022-jp?B?MlZiamt4OUtqMUNJVlF3aTlzekFTazFpM005UlZoN0xiOXhqZmtFMzU0?=
 =?iso-2022-jp?B?ZWxLN2NzK3ZWbnR6YWlxSmdhM1BKUkdGWWVZZ292Q0JjckpyajduOHBn?=
 =?iso-2022-jp?B?bWhMT3ZvUzEzVUNORlV0Ymo1c3Y4dmtMamxlYmFPYklZYyt3ZlRSd2gv?=
 =?iso-2022-jp?B?aG1vd0RLSStwS3d5bHJzM1RuNmNaeFQ5SWt1MVBqeWZXbm1XR1dFc1c0?=
 =?iso-2022-jp?B?MllWYk9VV2ZzRVFVdG1TanBQYmp5bXc4S21EWU5ncW5wVVhHdVdac3Js?=
 =?iso-2022-jp?B?bjNQaDZtOE9wSEIweHdzM2dwYnd3U0pZNTlmZ2Q2VnoyY0Y0ZjZvTXdh?=
 =?iso-2022-jp?B?M2NqZGhIZDE1dGU5c013WUQ1NjFxeFgyd1BxbjFCS0EyNW0yRVh4V1lp?=
 =?iso-2022-jp?B?MGVpSDFHS3NzNVpXNXpPZ2wxdkcreldqbSt2OGcrTHhIemwvUGxRTW9h?=
 =?iso-2022-jp?B?WWFaQitDVGZ4TEp2MFNYR1J3bDVOc0lrQUs2RWxzd1c5ZUlscW5LcE1m?=
 =?iso-2022-jp?B?c1lJRUo3cEE5enJXclNyMjBVNDJpaC9jZGRVbmtXWmV0dk5LUHBiZXg4?=
 =?iso-2022-jp?B?MjgxZi9HUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	aLlgKlVnz+YKRoQdNMWziiE401BgOwRJMnYSAh4f5g260iUhdZVTa3hJaVUTgkkT0jRi0bMG4GhJo+77A4pvYCK3Yd83olsl6crdjQ1cX0fLLOEGhwwwF6fTgoJjrZFfBnW2TNMxxgPmp5pTDfv/P6syECS8itSVZA14KKc4XghGvOkZYhfbNmXFBtUQJ/1GTv41eB1oK1c7l+JdIouql9wRohey+k/7Qo90BeEY+Y+4wppGu+HtJPJC6WotUGu0B/R7dPNsyajZ2AIAYu140CKoN4Tq9unVRa54E9HLKNsFd0dY7rJgMinSIswqAH2i7JgHMfcrO4QwoDhppg2aYw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea6ed63-f3f2-4010-0a49-08de9a9e11dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 03:21:22.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIczvpy1Ch8ZzmOf4LO0Gho/y9lX2bgOuxjXVGnf9ZW/YwfmgR/QEa1Nk64mUFlkfKzH2jxfCQpt1GhupGnXg2F+gYdjJf0Dkt0RWgYAZ7SxSbftZRsbacdiRyVJWFpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14717
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 03:21:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22702

Hi,

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Saturday, April 11, 2026 2:02 AM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2H and RZ/N2H
>=20
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the tempera=
ture calibration via SMC SIP and do
> not have a reset for the TSU peripheral, and use different minimum and ma=
ximum temperature values compared to
> RZ/G3E.
>=20
> Patches were cherry-picked from upstream kernel, except for patch
> 7/11 which is needed to fix asynchronous aborts during unbind.
>=20
> See the MSTOP series for more details:
> https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.beznea.u=
j@bp.renesas.com/

I reviewed this series, looks good to me.
I can apply, if tests are OK and there is no comment,
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/245384418=
2

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro




