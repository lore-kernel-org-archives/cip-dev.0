Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD458FD007D
	for <webhook@archiver.kernel.org>; Sun,  1 Mar 2026 23:35:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.149159.1772408105666330961
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Mar 2026 15:35:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=O8mIeYMp;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1772408101;x=1773617701;bh=uKRJ4hWro7yDStjttTM4SqRbY2zqX4DrvHfGe
	SeaF7c=;b=O8mIeYMp3OqvZQTz+ok2G+c9fmjW+7zTEo/hsH63NPweaAwWf3jg+DdHyKHbalpGgvo
	LvSb5FsqsIeYRgCXH93JaFAt6QSOjU3Olcm40KVLY0xaNR4z90GGaBa/PM8uBykR24DxtxKVuKavr
	3FH7nWD2IbAqYCPxY2qJ3J/2XvrhRHh4wTAMsTbKn5iBlqIkumecuo6V/Wewnzt+7ZI8j7lJQuhqh
	QF1pg8/v0Bcjc704i8P/H04DABU7sXSMKSp8192cd8Fil8dkIbeUhNfgb3uD2wwwnPrGrsjj+aJLh
	HAYf6C08+euegNGYlo/xDnXlkQPxt40pkBzvs66ulGLQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 621NZ0es3361275; Mon, 2 Mar 2026 08:35:01 +0900
X-Iguazu-Qid: 2rWhHaaNBOfwn2WXlT
X-Iguazu-QSIG: v=2; s=0; t=1772408100; q=2rWhHaaNBOfwn2WXlT; m=hrvlqxcWcAfbD/tsn4mo2LvkiYjV6JmKHbCzfMN7EnA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fPJM81W8pz4vyw; Mon,  2 Mar 2026 08:35:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS1R+wJL32W5WtpEtSSx2KES8wSYDKKCzrnY/0m1HUEw09FjS1JrWCjY1TAlfDYqKzycDTv4RY1YaCwLQPFtVReoO7J+c9cE9A22hBYpZSaQz1VDGb3+3vZoT5pEcwI4+rrXMKqM3ALL9u4/NV4fP3/Ntl+6frgN3F4MuwjANqW+GX5Li2XcXE4reRhWVWNbAkN6o/jldnLHJ0NhwXLDTCmTEai6f5kzu22mBRTLIkSKpgwOS9MlqGo2Cbo5m/CKgln2118cA78HLcp3dBDQd5EVxIY+KZcUc4vyZ+cMaWDLy9wIuAalJEQ9EcYbylGaFeT3mlMM8uJj70wgKFv7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4e7/akh2WcfIX1by2xCwjq4ZdiLVhAGUYeRt8U1fEY=;
 b=peoo4D/2HcAcxKGJb7sFTadyhbp9YME/hLi4q4gQFKupv6J3UmUiWpStBuE0igOcrNxQtdFT+4C49l40Yc+kZNhOFMDOq/BPS48mBsIX7Y+XR2GWorO9FaDBr1OK9WgYhiT0+VnIgDP1A91G+l/+znQSDAHEa7sat1/D1K0DBpVElJCrgG82YOW17ZzYER5WpsAwgWpJluHJzShPOKA8KkfLvx11C0FMa37QPVWBqSh0VoDamN43m3y29h6RrcUOzBcUCIiFc9xv++K2BKV4G/bfI1neHCYntFHlT5mPlSt3UEfMPUqDsKwGGQo0qo/jBSA6/R2tbsM4kiW38doiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/8] RZ/G2L SSI Improvements
Thread-Topic: [PATCH 6.1.y-cip 0/8] RZ/G2L SSI Improvements
Thread-Index: AQHcp1baXlQ5NC/ihU2txINteSnuB7WWTv8AgAQKIZA=
Date: Sun, 1 Mar 2026 23:34:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481884B3F0397918E972D502CD71A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
 <aaFpdGfNb62Dddwb@duo.ucw.cz>
In-Reply-To: <aaFpdGfNb62Dddwb@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10879:EE_
x-ms-office365-filtering-correlation-id: 8d6bd983-6960-415e-818e-08de77eb2477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 enpLpJU85KYxlt8URQIHF2bvuunK8N9c8uiV5XrKPV0GA/whBYxfF8qjK4kRWnRyc3broX411k7ZDP/WIT5eRMvDYl242UBkw5HM5jGtMVlU7H5vnToTItHJnvxsOwqOOp5n2TLdWeWZpIDCudahXsYYjogEbGGNv7Nrn3Nn5doYUGQODIdgtL4s2CpaC0v6sEKRNU81NOMDfp8JHtC7RUBAlUvb5MvaM/JKtI+8GN4pEjDdP5WNwTAfxxUtExJEXfyXGOLdux49af0CAmAmaAKJef3EzXpyuSCgE9ixNCsIXJC41XB62fWqc50wQ496Ys6GgUH4vWAkl5Xc89bLbaFxuyf+tvt+yH/+u5l1QfgsV+FO0L6pRdvPb+d9eYzjn2cV5DzggmtwvJBa/rwVsteJwN9Nj2j74aQhlZCwR5zAMKtP+ZO1IRS80TUciMZo41n5y6W2aJGD6FHf5gccBcV6j+IuuyVa4e/mpn72BdpJLvGmZslldInwAJDmfeFntrSXYYgb3IM+tFfbcjvwo0CQ7CxrLjInKpkNSyWVN4VyUF/+OAd7qYZeslVyH9o9xqLHErYDJdFDbF9kruI3gYJ6M3OHCiEfo8HfzRKQLD68aF9qw71Xe1HfPRGZ4+pcDdpcojfgptGXXrOkjX/gAiZbZE+xODx5lh+zPYkB/0ofbjrV5zP5Puw+23XDRcNkrvpaGHXTan9uDOImJ3LGzakrrXXpt3kDWKXjFEE0Q/MvuZn3sVnxvLlmsoob33tb12kqMmLxrP4/k9xunYjemRuH7JoEfbFkbqrTbwUIMEU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YVJielZwaUtXUzF0aXpSVVFhWDRMSkdUMG5GRUM2OW9PZnFvTDJLWXhn?=
 =?iso-2022-jp?B?MFFGUGg2Y3MyaFNwN2F2SktrWEsyT2Q2Q0MwczdoR1QzZS85UE1DVVhw?=
 =?iso-2022-jp?B?dW5zVE1EeTJEaWFkMmRaSVJvVWQyZEtSbE94UC9SNGFQNXNneEFXYS83?=
 =?iso-2022-jp?B?VGpGMUtsYTQ1SUxYUGtwbVVQTStzdUpKdkdOVkR5WkFRdGZiNFV3cnlh?=
 =?iso-2022-jp?B?WWFxQjhiSGh1VDYvSng4aU81S0ExbEhtOHNmUTk4ZmsranZ0Zy9weGxS?=
 =?iso-2022-jp?B?Tk5uZktmQVpyanZDQ1hvaHlZYmlYc2lRZjdlRWI4cjdKaVlXZWU0MWt2?=
 =?iso-2022-jp?B?Wk1sTUZDdW5CYkdjOVJxcHc5RytyUWFzUlRkZ1RZZVdQa0xNQUdZQ2hi?=
 =?iso-2022-jp?B?N1RTWWMrdXlRd3V4UHRVdjNxSUZPemNiWEtELzlIWGRJbUZodW1xTWNs?=
 =?iso-2022-jp?B?aC9kUXkzYU9temtHNitNM1kxSE5iSytuaDJDMmFQMGszOWlIRzFMekZZ?=
 =?iso-2022-jp?B?UER4RnNSZitXRU5zK1BFdkJYV3JEa01BclRGS040QXdzUkxOUGVvdHE3?=
 =?iso-2022-jp?B?UlFZYzErdXpnOElrUXo1UDJYbG5renpQSzhwbVFrc2x3ZGl3QVRHNmFQ?=
 =?iso-2022-jp?B?Y0l0UFBDektzOFYweHhLWEh4VmVEYUc1OTUvblF6Nm1QUjhwOUhCWmpI?=
 =?iso-2022-jp?B?YmRJbUdVT3RjamR1VXp5M1hjNVVCMWZsTWZEWWU0Vm92WldjMFRqVGp3?=
 =?iso-2022-jp?B?ZGg2MUlJZ0NDVXhlQmdUUlJnVkd5eE9Pb3ZvWEhkdVJ3QVNzcHJUaERx?=
 =?iso-2022-jp?B?Y0FXUEFucDhoRC9DbVJVYUpEakJPWlN6aER4T1ZYWUdSVHVYU2xmb1p3?=
 =?iso-2022-jp?B?THFLMWY2TG1QVDQ5V0tadW9wVjlDMEpqVW4xNnRyR0FJRFh5UVd1YUhu?=
 =?iso-2022-jp?B?c2FacnlJZStMNmVQYU5IY3pTS1ZmSjNLdFgrV3EvM2tCSXkvZVZPTk5K?=
 =?iso-2022-jp?B?Wm1lKzZhRUsvRFdZTHcvTEdiQWZiZnVkUmw0bTFuUVBuMmtTVlRJR1FR?=
 =?iso-2022-jp?B?NlJiNENGWXRQZ2daQnU2b05VcytESlpHNW1qZ0d3NzNVNlovMHhDdVJK?=
 =?iso-2022-jp?B?dDBlZFNWZnZPbXQvQmhEaHN6Vk5TQjJaVlBmdW9yK0Z4a0Q1SFpNRGJr?=
 =?iso-2022-jp?B?cENBUXFBbXpSdDJCYzlhYkJyU0FqNXQyWjBWbEszT3l3RVZLb05zcWoy?=
 =?iso-2022-jp?B?QmVmTHZrbXFibUNnZGU3NEtpV2RwbEZPUDAvaWdBNEZUc2dZK2xlaEpT?=
 =?iso-2022-jp?B?ditBeFp3cHJBNFRjUG9jN1haNUhKSk5ZYm1SVzV2OFRTTlFVVnNobW5C?=
 =?iso-2022-jp?B?MWRiMVVQbnVGVmxCNDZFN09yRCtIdFpUL2pvU3NYcm53bFk1bjRDR3dV?=
 =?iso-2022-jp?B?U0xiYzRjTStIRmVBSVp4TWtrUUhHd24walF1R2laMU1nVWRRVExtSzB3?=
 =?iso-2022-jp?B?TTJBenBOOHAzZmJKbG8wK3JRMFV6ZU5wdGk3bGY4VlJUMDA0Tmw0enIw?=
 =?iso-2022-jp?B?SytWQkVJNWk3ZTdTaGFxRlExWHNHdENqdTNxUXpYKzlMRkppcGRJYTRK?=
 =?iso-2022-jp?B?NWRGKzE2elpvZ3IvZ1ZacytidjlPUFA5UkM3cmoxNVFoQlFVNGJPeHJ0?=
 =?iso-2022-jp?B?bm82ODBISjN6SWUxWWRXQVNQWmljZktBUGRsMDFXRVg4b3hjenF0ZE9O?=
 =?iso-2022-jp?B?VHpnNTh1LzdSQ3V4SFhtZldNUWFmUUlqSFlaYkRqZzRrTmhuZVBIdlYy?=
 =?iso-2022-jp?B?MUxsRnZrOGdwS0UvcTJhY0xmKzFxaHRtdGFBYWtrbXhyWUFvcU1xaFIr?=
 =?iso-2022-jp?B?RGVFWms3c01aOStrWThaZEJzS2M1RUtYYUNrRDBPUDZQalFqWnJtak45?=
 =?iso-2022-jp?B?YTBCazdzalJJbnZHck8rdFEyY0ljN1IwaGt0a2xrMGlOc3BDNys2aW4z?=
 =?iso-2022-jp?B?bEVoZWtVOWlUMnh4RGcwSTFOOW9BVTZHdDg1ZFlVd2NCYmk3ZFZ4SjRx?=
 =?iso-2022-jp?B?ZHZQWXIxcUpBZU13Rk9mVnZES2dndHZVdXJyemdqSXVTcXRZeENidzFq?=
 =?iso-2022-jp?B?bFA5ZTFjaHRRdG9XZDdmZ3FaMXNHdm9Iclo3L2pkSjVGb1QyclhRcFRz?=
 =?iso-2022-jp?B?ZDF2NXh1WmlvUHFUVzNXaUtXOW84S3lzMHIxMmJSMG5aQW1pWEEvVFU0?=
 =?iso-2022-jp?B?dXZwMG05RENVaStwZ0FpV3owMlNYUFI1Z3d3dXhiSHpWWVFWbmVBUTN5?=
 =?iso-2022-jp?B?ajlTOFhGa1ZoVkJZcXBvQ3IxM1Z4a1RkeFNodDRaU200T0lOS2Q2bjMy?=
 =?iso-2022-jp?B?SGgwMjc3K0p4c0N6S1RwMWpiSnJsMEJLVUFUVFl3aG1BdHpjQy9iRDYv?=
 =?iso-2022-jp?B?K2xNMmU5cDh4NW5lbzdDU3JKS3FHdDUvUGViZ0tQNVRjbXh2SjBlK3Vm?=
 =?iso-2022-jp?B?QmZiRTFtR1BBQ1FEOFgxaHFybDRmVVhzclJEQVpsaVE0c0hTdkJiVGJO?=
 =?iso-2022-jp?B?cDZrMlpVTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6bd983-6960-415e-818e-08de77eb2477
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2026 23:34:54.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTCLdxE23T4ZUkpHPb/ymnAPcBy9p/rCZDslD7PIIQLLiLRW7zWetAFbQUkbz3weCr8jGh9IYzQtmdEyLK+Mpf/sI6x1v4qGEmw3a5Tek2291B9ahp2rLay8qrZkrM/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 01 Mar 2026 23:35:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22031

HI all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, February 27, 2026 6:53 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.=
renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 0/8] RZ/G2L SSI Improvements
>=20
> Hi!
>=20
> > Add support for 24, 32 bit sample format width. Also fix channel swap
> > issue.
>=20
> Similar to 5.10, this looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks good too me too.
I will apply and push with Pavel's reviewed-by tag.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


