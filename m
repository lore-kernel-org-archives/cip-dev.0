Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D926C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 07:31:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7386.1784187062521293516
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 00:31:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=RD5TeFAg;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1784187059;x=1785396659;bh=SR5bjr2natMUPJ4v2A5GDN9+H0HgGUxUHWtCk
	uDg42Y=;b=RD5TeFAgJBXIdj866PGEcyglGdW7BmSfNNHvbe9os1ryS8MqnXeMUj9d0BuRkXbaBUv
	/zxaWbw8GgMx82fkqwpfqc5m4NoePv+hynICGe7KF73Bk+GMm1WDMd/gOoH9MxeZq3Hwiuq2Kbi7x
	wNu74hDZmlpJCZQk1IGrNh97bLVaGk74bOozss9lPoRYUNbjEsTh+qbZ0a6BoHZ1zbG0Kwkd/3eOS
	H3Pzo0vguPxzksp2xznBtCkyNOxhzBmqavqJxGFiaZCf0QPOZr9a9MVhbh0iY4Bb4XSLRpdOfShUF
	RYw2ivHdk2PckpHKaIBr4na3QWy0lgqXHmlISQbyrJMw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 66G7UxcZ524774; Thu, 16 Jul 2026 16:30:59 +0900
X-Iguazu-Qid: 2yAbkFS0Lr46eMvUtW
X-Iguazu-QSIG: v=2; s=1; t=1784187059; q=2yAbkFS0Lr46eMvUtW; m=h1bGsfMoRUOdSmkT0HiV/8Dkb6n0i4jZOXw608bnh4M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h14TZ3pWzzyPQ; Thu, 16 Jul 2026 16:30:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2I7VAbck1c1bPGO4DQWKtMmaFFkYnjExyt8/aCBD8nh2YHMe0UCK+WH0lGmyo560AaJFES4BMfcFNMsZcYW4LSlfIbSmGaAnhAREPhZfJe7wXGzuW512p2FDEW0utNo13Irh7BlL4WxHyiZtDjsKPA/0BMsXP9Kgxsan7Gpx94okjQEBRINAcu68jIOgq97hs+XGZKIQSyowks0ZCvXCDzYskriQxF7a5vU0xc5xMB1vTcYqgreFRr7QipAOyw2uUHzIzX0hkVjINNZNOz1gVV1om/3k3HNpZT3KTT+iK1aqN79JEybZJ4w9cVaL7UbwdGA/gcTzZedLaq9s11vRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsiczqItIS9GRwT90vATQhjiyEVHufFTOX2du34+6/c=;
 b=OOA2T7n2wUfXUkNCATwxMDUmzhONAhHtIMsH7ev4IUYe+XQWCottAj6OMc86pxiuJDOPa3EBUYF4BKh8gQyu1vKpCW6UOr3zH86bKiy3waNAHxO+r7Jag9ru9UQyCmqQwkhK5TaU3Dhg8ImRIx417ejz3qrwjRxcJYp4hN5z2FfJeBO9dgMYq98zjGgXj6VdA1qQR6UMtA00byXLZeg0MMACclyJcvsnLyuzCjIO5VxN8/E8oENccEF+iYJpMyY4bdXAap/2zzbFXDkiFZK9ESwr8YUJkf3qPHZLYYfzIwQ1A5MRimadCfN2OBuIj54MpQUrnASCcn8WZpVy1Wq4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H and RZ/N2H SoCs
Thread-Topic: [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H and RZ/N2H
 SoCs
Thread-Index: AQHdDXSU3U96EU15T06lJtQ4i0GQ6LZvzqaA
Date: Thu, 16 Jul 2026 07:30:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D949B2AB9210CF312A6ECDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB10208:EE_
x-ms-office365-filtering-correlation-id: 061484d2-c76c-4250-f962-08dee30c2c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 fmALvItz/QRKrF/yft+DKGKa7ynkMOQuvCWVD1fd7V55NmMPxqr+lxGhgr/b5GDAtDEhhLAG3+ldVtBUvOIKjZdks0dt+9wQ7/LBG19iJNAZ1ciYn2CJYLu9UJ1ajkn8qF9hjPOWcMe0Dz5j8ohigXrOdNdYVGP4GJo+ZqLLiPlCYhJUp+bvoaNIdmWxnz9UzALSbNcO3GA8NT61sC0jnpExtjJttPikyGB/6JVGc2LdfgsjKCjC2R+TlJ1I8gJlfiG0EKrDmnagb2AC9pFpDPa0vXkffgM1KyJgPlBmVL3vfemyVQMMP2ke5zUoBv6v4AcBl/cn3f6iNRQHJOkct/Pp9yT1n8GaNEyIcj6yaq5u0E4sA/OnNC7zN3dh+pCu2Ze/9epNMnQHet+6XmCpg+db4/dEOU7S1t34+RIinhHsad9pkAfZwxIAR/TCtJOiQ34DG6ShYc9eei65PVh5t8Jhuqot1pwJk163R14GkDfo41BU2GkH+Ub9f14RbPSqCdidazoXaHjCkf6KgF9iOOu7s3SfJq+wFzHUymLaORA38MQKERS6YVWwBhZbAgVLIlBQxtgUTTSyr6w0ThguEyAlt8kea8VE5fGMVg/V1GbmW9ZxGPrL8OU4ZqDTvl2MhCEmnf5vTK7uevbQuWFJ7/DxntUUXK4Bg/Pgmhl0tHoHnG3H69wGAzHF9UyVtPd2/t6FD+4vIhk7T+DKVvQJGkXaoQBP9eyR/ayDFjjrmCE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dVNvQzdRbEZsQ3VnV3NMQkdUSW5xSDR1Y0hVd1lxbzRvQmZKK0w5VHh0?=
 =?iso-2022-jp?B?Qmp3VU9ScUlhMVVFUzVuZS9SdzR6UUpwOEluRlhqNzRvVzFVV2JNaWtq?=
 =?iso-2022-jp?B?UVpISFpoSmpGRS9GSVE4SWpqdHFUemNhNmJHUmw5NXphM0JFeGVSd3la?=
 =?iso-2022-jp?B?VjYwcmRzbXBabkVTT3NPSFdaYzVDL2NpUTQ4WGxwVzhqWnRtNDlvT1NG?=
 =?iso-2022-jp?B?WndtWXpkeExMRS9uLy9TZXJLQThsVzRWNGZwZjdXMjYxWm5UYy9OM2ZW?=
 =?iso-2022-jp?B?T0ZhRXdYSzkwaHNINGJrbmFtdjhKcVZJdjlMYXJYU0xZMVB1dStxclVq?=
 =?iso-2022-jp?B?UTBsU0s0WWgvV2MxU3ExQUZUd05MK3BUMGJOa05jS1ZmOVlZMmtyS2hP?=
 =?iso-2022-jp?B?eTNhb3I5QTdiRHo5YXBweWZ3eFRLSE9kRW1vSm1LdEhaelJXSHdHU3hC?=
 =?iso-2022-jp?B?S3JFMDZldDZEMThaS2lsTGl5bTE5U204WlhzbnEwNDhScGpCNGZ0Q29q?=
 =?iso-2022-jp?B?SE85cGFDc1lobDZza0VGK1Yxb3pvUzNJRW84dU10RnNiWWswcjBPSFBs?=
 =?iso-2022-jp?B?TERxSDRvd1ljVkdrTUw3SDlGUW03UEdlWWlJRXNjUCs2SURRR00weW1z?=
 =?iso-2022-jp?B?VG5uaTJZdExvRm92YUtRTStDaFI3a1lTM2wrRm4xK25MNzVoZnA2c2xE?=
 =?iso-2022-jp?B?eG50MGI3M2QwaklmUWtUMUlldmt5NzdZS1RrYkhKM21BZmVUQVU3bm5T?=
 =?iso-2022-jp?B?VTYwR1VVODByQXFWbjFtRjBuTkF4YzhCVFVYVmwzZTNSOTAvK21BNGdy?=
 =?iso-2022-jp?B?cSt4YjRyM3VtdjhhVFZZZklPQWRIN3RZdEJJaU9hRUJhZlNUVnh0ajc5?=
 =?iso-2022-jp?B?YXBxa0pVd1laWWd0RVg5bWlYKzB3VDJtWjl3MzZsb3NGZkpDVktWeWpQ?=
 =?iso-2022-jp?B?YkpFWnhuMUJjeG9CN2sybDFjU3l4OFZOVFA3cDEzTEJNdUNXcG9hSkV6?=
 =?iso-2022-jp?B?eUd3cEx6SU9FWVdXZzRsM1htVFhGRE9TL3V5VUNxTHFYa3djenVrY3JZ?=
 =?iso-2022-jp?B?VkhqL0ZpY05vdHYxTFlndDF0WG4yNGlrRUVtRDBDRTdFWExoVDNFenBD?=
 =?iso-2022-jp?B?SlNYbzJCWHdjd2dtQlN1L2pwdi9uRVJQQXBOcWtyOTlZcHM3OW5FaW1U?=
 =?iso-2022-jp?B?dERIYW5GblJxM3FUbDhjVldTOExNVm1tN2haY3lZVUpKSFJ2OXRkTU5V?=
 =?iso-2022-jp?B?YUtaSzhOTGZLTk1MSFRTaWxMdy96UitTb0RUMklSTi9hT2M4RFEzZlN4?=
 =?iso-2022-jp?B?K09VNzJsRzkyakQzSTVrMlAvaW1wS0c2d2xjbU0xN2RRejFmaWwyWWU1?=
 =?iso-2022-jp?B?UEVraUJMemd4SXplU0tpeTJkKzF6VmF6QW04TjFySXh6UG54Yk9SQmFp?=
 =?iso-2022-jp?B?d0ticDYyY3hDdHJkanFjMS9laEZUYUpqSWpjLyttY2JyWFZ0dzg4aHFZ?=
 =?iso-2022-jp?B?NVM0Q0hCcUU4bFNGbHRXU3Zad1NBYUV5cWZJSXJwSUkzSzBrRnAxV3Vl?=
 =?iso-2022-jp?B?eE5hRXRiaXpMMVB2YXZCV1YwaUg4Y0dZdnNobXNSUCs5WG5ZVnBpSWMz?=
 =?iso-2022-jp?B?VWx3Q2VHeFpPWGl3R2pqYXJnWWJJeVhuMzF0YmM3T1lBaTRzc0lTNndu?=
 =?iso-2022-jp?B?THkvY2hiUmVNMkUybXUxdnlDamEycmxTbWxhbVRyZ3V4OVRBWmlra2Y3?=
 =?iso-2022-jp?B?RFhlN0tTQ1NRSUVvZHUrUHdOOVRTNGR3cTRVcXRCNWZ4T0lRQTBJblZm?=
 =?iso-2022-jp?B?Vnhib2pGYnlORWtjUTNDekZleGI1N3JYdGluSWhrS0NzUzcrbUpzUUJL?=
 =?iso-2022-jp?B?dHdXRnAzU2NSSHR5T05RZXlCZnM2VXA1czVibTJmWE40RzVMQVFoZ0h6?=
 =?iso-2022-jp?B?WHNJNFhvQzZLTngwSGhsK21QK3hiVEFna1FmZGlsTHovZFk1enVnVVhm?=
 =?iso-2022-jp?B?TXQ1NzhFdlpHcitJWXFOUlpLYmpaQkVoNHpwR1l5Ui9KdEhCajhSaFF3?=
 =?iso-2022-jp?B?TkpzeUFIUGNUT2U4SEV3czQxSS9aa0x4QkFnUi9hWjVSUDhYK2gxbTdl?=
 =?iso-2022-jp?B?NDVObFVVaUVRTkxseGRrSDEzQXpCamNlQmVCK28zRFQ1V28zejhWK1Bw?=
 =?iso-2022-jp?B?VkJ1WTd5Tjc4UHF6YVRzQzd4RDlKcWlHVlJWQjFSWW5uUDVBaFBHbnVq?=
 =?iso-2022-jp?B?LzBlT0ppWG5RWXNVQkRhRmY1a3JPN25ieDNEcEpCTUVEN2tZSVJqSksr?=
 =?iso-2022-jp?B?c1pFZjZDbG4wbUtPN3FwZHU2bWVhV2ovY0dMdWdTZTQ3Z21GVXEvc1M2?=
 =?iso-2022-jp?B?YnNIYnlzVVpHdHZGLzRZYk81ekZOZW9tNGo4cGVJeEJpem9zNks5U0pN?=
 =?iso-2022-jp?B?RmhRbzYwVUc1QTh3R0xFd1U1V1hReTBXQ2NBc1RuZUhtYTJYdTRyODhq?=
 =?iso-2022-jp?B?emRkaEpwTEpVa1UwcmtWSEhuSXVXTFJDWEMzOThqakM2R0pvSFdnVWpK?=
 =?iso-2022-jp?B?MTAzdndPYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	KFDJ5SCy/6/8Q5f/sV1PyEw2CDyqbG6hiQOBhjuY/C+xh3L6xLg5ls38l3xtAX0j7ql2FbMz81WCEu/P+TosiCwfefL5TouXW96Qv7F6cv/UA7TtpxbPeH0Dz3O6L+6Ra0v4CUUxhUwRIXTETlDIB2r5g2mTpwTp1J78riNKvZcp/asl7vMPoT4a/y8/ljZ/yBNq6IUEszCBmpwAZ6WfxTbtYFgaxWTl0iYrp6GGzP2x6HrgXVbWRlxjfYI+zZYQtg+4+XNl8c3yU5ds6GGz032DnKKCPywPnKlCi+2Mnub7v00PSWaAOs9cYlomQrU1UEc/RbmycOxIbNaluFcTwQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061484d2-c76c-4250-f962-08dee30c2c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 07:30:55.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gjhrzs1L8rK7iG7c76summz4aF9ffhyulo9ZMUXgf4PSR8y/1atcgwAUmYOYev9nsFw1Cqqc68oyJximO1nAuVilsFBYlw5VIUsefKOE2PgyoQ/gp5KsyU48Ek8wElfZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10208
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 07:31:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23608

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Tuesday, July 7, 2026 3:23 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H and RZ/N2H
> SoCs
>=20
> Hi all,
>=20
> Add xSPI support to Renesas RZ/T2H and RZ/N2H SoCs. Patch series
> backports clock, driver and enabling the IP on SoC and EVKs.
>=20
> All the patches have been backported from upstream kernel.
>=20
> Cheers,
> Prabhakar
>=20
> AlvinZhou (1):
>   mtd: spi-nor: add support for Macronix Octal flash
>=20
> Biju Das (1):
>   memory: renesas-rpc-if: Add suspend/resume support
>=20
> Lad Prabhakar (6):
>   clk: renesas: r9a09g077: Add xSPI core and module clocks
>   dt-bindings: memory: renesas,rzg3e-xspi: Add RZ/T2H and RZ/N2H support
>   memory: renesas-rpc-if: Fix duplicate device name on multi-instance
>     platforms
>   arm64: dts: renesas: r9a09g077: Add xSPI nodes
>   arm64: dts: renesas: r9a09g087: Add xSPI nodes
>   arm64: dts: renesas: rzt2h-n2h-evk: Enable xSPI nodes

I reviewed this series, looks good to me.
I can apply this if tests are OK and there are no other comments.
  Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro




