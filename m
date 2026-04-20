Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A1BF36C39
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 07:20:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14239.1776669604941853903
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2026 00:20:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=aNKmA6ZV;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776669601;x=1777879201;bh=8zxS7unGsuQtY/dVaOX0881N11pHaX08MzmYh
	FCpt4I=;b=aNKmA6ZVRqa9DEhzhK7tC6VcRDML5m9ALmJ0/bafklZk26WHz4nMGpbmtvXfyaPXd+M
	+oayqNY4FyyWZch+LtdgUkaV1Q6csy4A7AFu4jzxQd/wIxIOqNyOk9XLpSK7M1tJabEqzE2UiWzae
	7wepi0Q65ClKrMaxPnCqC6LQ+mzzKv+NoHKIk09D+8LcJEaLeLMR44Zjf0Zhe6cEavyCxn2oTwXaM
	zftY9o2YBt0M/AOwskFcX6oBSzFxnAJVfUFf2N851mtqgGRn3SSJe+x6FfNcr25J+iiG6bJ6m1Czf
	BBboQEAU0qUoTvhqAGEaslsZY2MYaVpE136DObYRRKfQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 63K7K05P1175601; Mon, 20 Apr 2026 16:20:01 +0900
X-Iguazu-Qid: 2rWhZwovH8Jzb1g9Kl
X-Iguazu-QSIG: v=2; s=0; t=1776669600; q=2rWhZwovH8Jzb1g9Kl; m=th55f91bFEuIqU0DmQIvV6K62trJHIdBHBiRpwP/TXg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fzcM42k6dz4vym; Mon, 20 Apr 2026 16:20:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aju9205in5+aKRe/TEEdEhwL+Beh0HoO7epo/9f6bIAyAzlGZDqet05T7yuKIGP0CX93unY2Z9INUxO9JsZLgBRk6VqFJP9FTjlT2TP9oO9RpwcGqituVbQIZVDMR4/gRCGO94sAwbkmOmngyXS6t9WG/Ifz4H5yzvzRSz9R9eBrO2aNLdQxsX52iXCxY7ZGb1rpUhB9W4yh97NdtMGI8Cdmql59AnOEByvk6pRPtpPOhM0Sew+IyUP6+4UaUqpRangHfTjHIsImEDLuSaG0xX1C+T4aA7lXEzHxMwHOzqBk7GEW20Wjf6oZRuSuQjxKZoNwq53EHd2wLnI8owBaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP9b34IiSwr1msdIBPhYxiXLRW7ygZa73rLOkk/v5UA=;
 b=bdEbsZwGYhGd98x0Y3Ai0uAoHRMc2E+wqJYRc07gGXbQU6QRkbD+ypY1a8zC9qpxAfnAACSc8pLzjvO8OCM27TYqsxKnlqeURbRXKgR2CAI3ZfS7Rv5d45E3OwmkXFa6YKXK4mV+3iIgLZugWERyPCnweOvDgn8wJ1gzRYa0v+J/lLnvXA78M5RCCuIYrVwRoHQfqyFSRJ0v3ME/i4CQyoBSCtUTYZcObdOc/2k04A46KGmfAz1IVxobzydrlT1g6V6mfYwETg+I0pyMSZX9cTDnlB6Rz6ajW4beihZp6hryFwcM2cNGLynvImE3mIVhii7E1Cda4e3PgScOY9KR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RSPI support for RZ/V2H and
 RZ/V2N
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RSPI support for RZ/V2H and
 RZ/V2N
Thread-Index: AQHczNq5Nzs8gJXJBkClvMKKMvLqKLXiLIEAgAVlyzA=
Date: Mon, 20 Apr 2026 07:19:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D87CE88D677ECBC9AE15CD2F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260415132056.95570-1-ovidiu.panait.rb@renesas.com>
 <aeFMVuHp-BUoO6DH@duo.ucw.cz>
In-Reply-To: <aeFMVuHp-BUoO6DH@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB7129:EE_
x-ms-office365-filtering-correlation-id: 8c35e2ac-34e4-44bf-308c-08de9ead39e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 vOl9N3NKEQkHpv0NtyQVV5mb3dZqsWIvZTa+swTjRpnjEHClulYCM+1Sv5EL1GKAh0GqkT9mWx5tm08TmAkrQbwSBeAr5sc2oHN40Ugw2rW1CesfkhRHcsAJ226rhRXpVccnI3h8XVxgPY7VLQbg6Y9Az2VFS6NBpJxo9JsCxTVwRR+sxzlBUZgciZvgGDRQDdmDH7zNr0eudpsj+a8yghYv+qdr64JMleY6qgjp8kuGPiRDpTTXMwREimEwCitpRDoOFaveG041hetit3vBqGMZwOU/s2B69bygK6j3KhvcBjDvlwnKcSAFESzy0jweFztVG7EqPGMJMN54BCogG8BzxlcwM09H8xn0PpU7yyZ5AJcJsip7RAoPcXDq1D8Nh7huyTFZVYc4FBZuzq7Y67OzKm8ojbkclBFB7n/cN0Y0uDs9/e8Dzt9zE5SO0TFiuSBw9FI23hDzSKYXeebKoIRuHOx3+e6Meij5qdxrBDbEdQtNBbXCgoEmN3zDj1qrhIr8+P2mBf7YqnN89pQBEaaMivZqi8xlGVhp627x6tUFTQbMOginvA6/ijhc7nCm2cjH93rlJNz2M73GyVk/Mm6E2RHalF6PYS0dxAaqCaFuMHxQdAWs87Sh0ZiKFgvjhc39m2HrzQBZcd9u5zFS5xXzk283Pc1n1Ks4DD3UY/p1KtWfFqAmyeKb1EnrbTZxLAXlqeoQIW9zOQt2P2lPKN7nTN69V5c+40ZoPQ0Cpip7Ob3El8QkG4zWlgbiredZOP3zsbb8oxdoL+uY9m0QJpBcapT+zID1ZXPFdYawIeY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a2NXL1NKRnlxTmliMmNycHpRQzNXdkl5aXM5TEtBaEZVTFhJV3RUZDdF?=
 =?iso-2022-jp?B?b1hjRFM3NnZjeHZGaFVnTFJHMGFxYStjaHIzNTkvMEp6QkxFb0FKS25z?=
 =?iso-2022-jp?B?QXM3cllFR2xpbnA4TjV4V1J5RG5NWFN5NkJ6cHU0dTRvV2xMbWF2TzRC?=
 =?iso-2022-jp?B?U2tXTmZ1VWtIaG5KSTY2ZUtGRFlzbFJsc1p3TmhOUWR3RVFRZUNITGp4?=
 =?iso-2022-jp?B?VzY3VjVoKzFkRWNld1NLaEdOVFRXRmw2eFNJWUdTQk1yNjI3L05RZnpa?=
 =?iso-2022-jp?B?QnkwOUQvMEFwTTE4SjZ4OWJyRHRvSmZsUGg5RGdKVEdlWDBwSW5sODk0?=
 =?iso-2022-jp?B?WlREYXJ5czJtVHk0dW16UTRxdE95WThTT2s0NXlESS9RSXhBWnQyQnNJ?=
 =?iso-2022-jp?B?cmRycnk0NUdCUGpMNUwvK2E5MXdNVGhlWVBrWXRCNHphaEJHRnZQSFoy?=
 =?iso-2022-jp?B?N3FrTmhHUnh0ejJFbVFVdTFSazVIdXBOYUpzblpMMXV1ejJMOXVPT2Yy?=
 =?iso-2022-jp?B?WVVjUkxGWjgwQURuaS9DRitZWlRoak8wNlk0VzZBaTlqby8rbzlITmtz?=
 =?iso-2022-jp?B?enE2REJtSXRXQkIwY2Rub01MZ2t4OVBNcklOZTlHV08zZ2NUR0FlVFd5?=
 =?iso-2022-jp?B?dTNMSC9BQzdVaDJmcDdVUlNrZWtVNVdlSzBVaXZsTjZJUklZUmJHSXVE?=
 =?iso-2022-jp?B?Q203anpwSHhIWkl4L3BRNmJkUlhxQ1ZXT0o5WFdpZWZOajdGbFdqbXFi?=
 =?iso-2022-jp?B?S21BK3hIcFQ5dlNudkE2YkZuVE95VUo4WGRoRmlHV0hOazFFbmtVYVUr?=
 =?iso-2022-jp?B?UVhhU1BuOWthTks0R0FUUkFIS3VWQm43NHgxZk1aNGdYRGpPY0ZldzBW?=
 =?iso-2022-jp?B?eS8vU1ltL1J1VFhrdkVLV1dlYmVETEdXelYwSkg1YTQxUndJTDFJQVVp?=
 =?iso-2022-jp?B?R1daSlFObS95enVRVUV4OGNHZkdZVzRrOXBpM3h0UXRZbU04aDh2bG5t?=
 =?iso-2022-jp?B?aGxmUnB4MWJtbzVOUmdGQ1drRkViRDU0SFVpL21BNlJRODJldTFxUmFC?=
 =?iso-2022-jp?B?Z1prSVdIWFBjeW1oNFBLYUpXZ1lzaUVhZHF5VXluZzBDWk1vUTVQYi91?=
 =?iso-2022-jp?B?U0tRcXUrUWRvQXZ0UzdHaE1zZTFMKzNuNUFTQVdGMlhmZGExblVpWlBI?=
 =?iso-2022-jp?B?RjB4NXdNUzgwS3l6aGpxd0dKL1V2WHd1anhYWk1kOGF3elFrbEFuRTRE?=
 =?iso-2022-jp?B?Yk5wRm94WXYzcGZsVU80NDJIYzdmS1hEbXAxemRPNjRGY2NWcFF2Tzlm?=
 =?iso-2022-jp?B?Z2xHT2ZvRU85ekpZQmtSSmNOeW42em85TWl1bmVvcjkvZWo5SU1jTFNv?=
 =?iso-2022-jp?B?eEtVOFRRblVGMld3eldEZXlhVzVtbHhMQmgyVVVMTDluVnpuS3J5VTJs?=
 =?iso-2022-jp?B?SEFBQUZxZktvc0hKdHlEZmFTSGhDK3I1c1JZTG1WT0JIZHVKZEdxZ2F1?=
 =?iso-2022-jp?B?YUw3MlZxaWRINTR0V2JGYkVxMzVBdG56SVU3ektxYXdoZDhNZEx0ZVJm?=
 =?iso-2022-jp?B?UmFPU1B2bVBZbEhYcENKYU1xNmZzQVNtanB6WUtSK0hNSnM0YUpBOUNH?=
 =?iso-2022-jp?B?VlZaT3BoYlR6QTRxc29jSmswSnBQTlZpS1lvTlZhSkxjaHBlK3ZWejRP?=
 =?iso-2022-jp?B?SWkyZ3ZkV2pVRCtSOVBabHhVL2d3dXd4Qm1HbXJGZEp1cXpMSnJydWhZ?=
 =?iso-2022-jp?B?NTA1RXBhRWQ3ZTBzZEVQU09NdE02RHp4N2g1V0UrdEl3cU5xWE14c24y?=
 =?iso-2022-jp?B?WlVnYnBzWWxoeDJqazIxOEQ4alp6Qi9pQVJsanJMRnE4bHA4ZEJYcis1?=
 =?iso-2022-jp?B?OFY5dlRnSzNZeExUUndMb2U0RFBQK2xEY0MvQlN3TjNtZWQvSUZqdFZQ?=
 =?iso-2022-jp?B?bUxsQWppb3psVytJOXZDTVdDcTY3bzVRbEpUTmJzMzUxRjdMdXE4Mzll?=
 =?iso-2022-jp?B?YzJnR3RzYU95YlRxeEkydHIzS2t3RTcwVnR6ZWVtRGZvOTJXZ1I0MGpI?=
 =?iso-2022-jp?B?Q3V4c3MxZ0UwSytWZGcwcml4b3ZNV012MGtuSEo4Y2VrUFNQNDIzVkdR?=
 =?iso-2022-jp?B?NERMWXgyL2dabCtWcEFFMm4xSmNhRzBoNnBBbUZwUWFjdlRNb0Q4VzRY?=
 =?iso-2022-jp?B?Y1FTT3pjZFZ5REdvZS95Ny9mWGxoOGk3T1BFMU1VV1JXN1lWNWRZaFdi?=
 =?iso-2022-jp?B?ZkNhYWxKRm9HQXVkcU9TUXV2NStyenUxUkdpTElIc1puaTBQOHcxS0Na?=
 =?iso-2022-jp?B?V3pxVnFueXdxZWdpTjNua2dZTnBhV2k2WnZFdG1neDhBZlJFMVRYc2dy?=
 =?iso-2022-jp?B?bkhsS0lEL3gzMUs0ejl5bFV0SWtDUVJpc3k1ZFMvazVPdit6ZFp0c1cz?=
 =?iso-2022-jp?B?Q1YwWEFMYmV3SlZsZDcwTWVVaURKbVdJaVY1QUFIOFZRN200TWFiUzJW?=
 =?iso-2022-jp?B?SG1raFptOXA1eStGMmthWCtTdlhYZzhCcTdIN2pQM3F2QWh5YmhwTU5H?=
 =?iso-2022-jp?B?b1dIYkswQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	I0YmMCFPNwEroWNaolH9N1wX/K6nd4TOVncHRdPzq9rYP4hBZ8Bhyl5Ne6ZL1U74f9raB1EKyRaJ8BvJY6e1+dVILVqIg+GffnnQu4CzbTR8J/wHD+ujA8c30kgD1tiq4gL8/YJj5l+x8JCqyzytsYXSCSqJNIzWCJUWrYoLU0xBF2VuN6VJK+mp+BGTvm54mCum87bhpNppGSZUFedzxbv1CWCnxIIxyjLouKztB/NDQu8LKVy4kyfrJ/YzmeF0XlHgT+wXO+gGPRtyGAHMmWV0UMgwuEjnLP2CtlHmiYcZlkmHnf96xO0LM8ga7Nsx7jMfvh7kwb/6yuFzbTD+Yg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c35e2ac-34e4-44bf-308c-08de9ead39e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 07:19:57.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/iJ4rQEe3xMmgiV0aitMxu/HV45TvrPhDI2Df+SyIS0Gv03AUKpHA4LNKCFZe6r2WFxDcb15JaYUB6nyMI9VLs31QEc+ynW2pLWHueiISjKZprnPBkg7NZNdkvpWuf+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 07:20:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22766

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Friday, April 17, 2026 5:54 AM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RSPI support for RZ/V2H=
 and RZ/V2N
>=20
> Hi!
>=20
> > This series adds RSPI support for the Renesas RZ/V2H and RZ/V2N SoCs.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> I had some minor comments on 6.1 version, but those should be fixed in ma=
inline, first, so they should not block the
> merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series. It seems to be fine.
I will apply and push with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


