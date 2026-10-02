Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB9CA5FCE
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 00:16:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1173.1790900151110432251
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 17:15:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=i8hccGXO;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790900148;x=1792109748;bh=2D672Pmn/7u3QrqxSRF0IFcOErNUZhp5UyshU
	Brgx0c=;b=i8hccGXOESKirexxVIH9UwmYrMCZjpBLpNWNtpkpPTzBtqMi3S8OvNbsu4FrvDOR9b9
	XFXPRVDneO4y93u9pfMKO+a36iIDG46swXGzErWYMXzIQt5fVRKg/kwnTzaJK93imrWw9VfDPgFb3
	tahzIl3c8thhfNVxZC3eXZAs7H2OrO5x90N6K0HCp9nfk7RCXRKD3g7KHC6jyw8Pvode8rLC1Wjb3
	rypeZme63o85d9GZ7ZVmRSWoylJiKislNxXzeXX/gbIsx4tgO2Evdh0q1HFQzHiWJoCKtjB8Zahn3
	3+ZWJSWNR6SgIIp1HL5HVpIIZahTErGaT7XeBHa++mJw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6920FlGE1836025; Fri, 2 Oct 2026 09:15:48 +0900
X-Iguazu-Qid: 2rWg3sYdYrwyLWp5kA
X-Iguazu-QSIG: v=2; s=1; t=1790900147; q=2rWg3sYdYrwyLWp5kA; m=2fqKhm9VhDxmOo9m7F6hm1+HJgAAKmVdxNMX071rYEI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hwq7R2Fqhz1xng; Fri,  2 Oct 2026 09:15:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDvQpkvyQrgzrlIDFA9lohHClhsUxD4QQXJdXwEEpWFh91pKAHUjk3hMwYQzVJNwfLsYDgVWmWxzg90wrXoUaGsnhX2Wp7d3A3+IoktOacTwGUspkl3vlbkJuv/lFjWRSlwunnZpuzxWWzhdMdLKGv2KqwWtiAvFC/7YW7NK4dkBmvFgnSB/zzfyDOsVh6B6kaiWmP1WVRLnoPWrkXa4k7IljLjTev9T87iOxCw9O40Qd7Mn0kwln5LtZiWycJ97pilRBqp8QQ/8E890/eAPEgqt2aSOBsgHWhO+3M3vtm5gli40mmsYtRZXxuvztN4ZUiT91Af8/dSLkiGE3cz6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp60GBV+nHi/OoXcispE+jqBu2BYUdy2YRBrSq6XIuw=;
 b=sKgITuo1cxGHgK48uvoOimNgmmPdQB5jqN3ChIZfylO8/93kFdPfWda+mlVnw/0LV3gyZhYkZBZGv4ywa1mrHr+CKtaYjPgYW4LkmjIA4qtlCG5TZ4wU8dZ1Auv0qu1gsasO0Br8YRwjv0eeBtg3reQZ3Kk0KRA9Zb5rg1cop/LISyFESFeht4pz4OVZwl8sbTFoipHd6zS+EGyvBejtHaNmlLZjSwbBUIGpsKT4p6mEAD3vp7OD3OQ3CDvt8E1CXuanRRKI12UStehPk3Jy5rR0/J1c0qdRtqkg0kLllJ3QEBClIiN22d0XRNAZ6Xta6lk/MPeMQtpeScgxTfnzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
Thread-Index: AQHdTAehex3U4PayT0iyxysdE3WCZbbokUwwgADXYuA=
Date: Fri, 2 Oct 2026 00:15:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C1FE803BC90BE5F9C32ECD892@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <18D837EDDA8014EF.2416057@lists.cip-project.org>
 <TY3PR01MB113465D5BE3E3F4DA59396432868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB113465D5BE3E3F4DA59396432868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB17053:EE_
x-ms-office365-filtering-correlation-id: 1dc421d0-7e41-41f7-340d-08df201a4ced
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|260925022911599003|56012099006|260925021911599003|260925021311599003|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 Rfhe4NZDO3ykZWjibyhU/au9+ukJHHc+JzWKrqA0HA9JcNP6gJD71iKO2/vpNBp2YiT+Ind19FQ/pO3WD+tr1hpazo8dvxW/j9IGHIPj7hH3lDuzpNZaQkWufH0FfupX1CrsYS1ExoxyYEpHht37pW8oSwtxAwAyuk0nfP09VM+ZAH9o7Kb6ZYvIUtDZQlMeBWD9huQTkf96iJWq+qrfQ+99AwqjiF57FyWe0PXFcsItwj7TzkSj2Pg5YIlDsyEMVapQ8KmOIP2jfjsrvieI8gUKvtlB3Vl+9iAewm1W7yPUitJRvkegjzoWqLKCF4Po3rE4LLQjbfY6N1NOJXjO2kbf1KSAUSZB+dM93tRUnejvoBc4qe/iLDulcag5slKMqlq1W9bXwzplAuLUGqF2jtM2iP6do0ZyawFf3EeqKbf68ucJ7XP+v9Y2fv9MPWPyRrNRrXlvlAeVpVh8C10tHHzxA8qO7h2MWeF5PZOvXa6wWEH/JoY140oHUEJoHkw7U12Xvv2xCP5oTZUWRuQfnoM95knLhdsOw+fynI+wrG/TNlReccM4SXDX9Rp4uWyKqqP2HoYLAzTyGEx3ejkLKXGXhklBELyTa5DhC6QiaJpJNO3ZbW/uLfzq9DWkwByZKRFHjPfdrt/g/yxmYpCOY23VltahHz69lIT/1rtwLWI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(260925022911599003)(56012099006)(260925021911599003)(260925021311599003)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WUh0dW4zeWR0eFZqYjZYSFhoaCtPQ3dKbExqOEtLSFVTL3JaalMzYUw3?=
 =?iso-2022-jp?B?UlJabEtrRWhrL0Y2eEhwYVcwaUl6eUdodkJFS3lIZDlrUSs1SEIraDZI?=
 =?iso-2022-jp?B?T2dBeTJ5VEI1RXdqN1dDalAwYm0rWkNGbzZoT2ZLUDdCMUJOMjZhVnlo?=
 =?iso-2022-jp?B?OUhEZUlEc3Y4YjZjK0V2elpBZjEwQWZJbnA4NDVVNnpuSXVDaGhSYzZl?=
 =?iso-2022-jp?B?ck9oVzY4MmRGT0xqTlZ0azQya0t4WlY3VWJFOTZuc0EweVczWHBsWlFo?=
 =?iso-2022-jp?B?RlFsZXhWRjViVTh2QUR1RHBhc3gwRXpIYnVnSGN2ZXBtVEZiUG9zSUg0?=
 =?iso-2022-jp?B?aVdYUGlGWVM5cjVlNkM3aFFxUGZ4VFMwWWRDZEIxUlA5YUljVk1jU05w?=
 =?iso-2022-jp?B?NmdrUUtZbGZscEcyR3dQZjNEOHMrdG5FeTVwU3hDZDNOVzZLSEFzUGhW?=
 =?iso-2022-jp?B?czVkdjNsM2FmckplNlAxczAwWmVRdUViN0x4WUVzbFZGS3l4MTZPcWN1?=
 =?iso-2022-jp?B?clBmNGxxbzRWZS91ek5NdW5CUnBUbmg4OXJxVDRIWVVlOUozNklXZDJB?=
 =?iso-2022-jp?B?eFBsVUY5N2lhVGVIVXk4SnhXbi96bGZ4ai9uY2U0VDFiajFha0F6T1pW?=
 =?iso-2022-jp?B?M25uSk5jRk43dCsrb0pJYk9yakdMbGhSQndXeGpzS0FuZ2FzdS95ZmxM?=
 =?iso-2022-jp?B?TThIVHNMdTEzcFBRaHNDUWZvMHdkUVo4bEZrbGNnUkZCS2I4d09GRGJP?=
 =?iso-2022-jp?B?WVZoakJucUJyRlZvWFllMlY4R1RYUXl4UXgvRmJPMkQ0OFEwZHdMUnZw?=
 =?iso-2022-jp?B?NkNjT1o1MWJhbW52aUh2Q21xWUJmanhhQ1gvUmc3WXplNnpHWEhxaUxS?=
 =?iso-2022-jp?B?NldIdHo2SzN6NG94c0xXVEI2Z0tJcHl0d3pFcDc5SVR1d1JNbWR1UUNZ?=
 =?iso-2022-jp?B?NGVPY3JCNXArU3l3WHFDYWdpSFIwS2MrY2dta3c1SUxZaDEvTENsY0hH?=
 =?iso-2022-jp?B?SkN6ZkExbTZRZ3praDFzZ0EzQmlXZGZQeTlVa1p1ZmcrZFp0ZWhybzkz?=
 =?iso-2022-jp?B?VUlvNGpLditjbE10MTBmL2d5TjkvRlJ2cVU5T1d5NzQxeW53OE04QkNL?=
 =?iso-2022-jp?B?cjNCaVovU1R6U252aWh0UDZWbUZORDh4OXJ3YXFzQzB4QWE0ZC9sZ2F1?=
 =?iso-2022-jp?B?Z1BzWUFOTjdwQUxZUndCaHFtN2NNSjYrYmVJRVhJUGpCcFlBbWxMSnZs?=
 =?iso-2022-jp?B?dklVUGlqdkNPaFJReGQrblA1dGgwRDJhaGF5cmFvOVdEcHlsZlVhZjZL?=
 =?iso-2022-jp?B?WWNDSmdvRFRFUWpPS0Ivay9OSTZ5YU9QNkRNazZQdXp5THViWHZlRVZU?=
 =?iso-2022-jp?B?OUlxek96a0M0cG1XSXRSSHBoZldjbHFpUW5xZlR6am04TU9FdlNmS0N3?=
 =?iso-2022-jp?B?Nnl2QXJMT3JWNSswZW55dkc4a3FxeHVldnBaV1U4aVNmWGFxNlRQUFh6?=
 =?iso-2022-jp?B?R1krRC90dkVFNGljd3VZdnM0STlnb1dnZ0tGTHdPamlreFRuZ3J1eW5p?=
 =?iso-2022-jp?B?V0JXT0tUM0NsNXgycWE0c3QrNk5UWjBOREVtSVRjdTh3UWM5NHlUVUFa?=
 =?iso-2022-jp?B?M3UyMnNLbWRXQzczL1hMZ0tTcTdCM01WanhRdzd2ZHA5NXNhZmZJQ3Qx?=
 =?iso-2022-jp?B?aHZKaGxDUVovMzlnYkt5WHo0T3RhMFF3Syt1dGdhOXhZamRIcW9JZTd1?=
 =?iso-2022-jp?B?bEh3QTlXSTVOTkN3ZE8wSHY5dWNkNlNUVmVqYUpQZHA1Y1RndFlIb1Jl?=
 =?iso-2022-jp?B?cnU2azluZUZpYVlDMERTamNiNVVqNEo4R3pwL1R1M29IUWdTS0dZNitq?=
 =?iso-2022-jp?B?SlJQMG9BT2VaWW0vVk1xWWdtdUxySkZ4NC9oSFZGK2drdUhtWXRwSGNN?=
 =?iso-2022-jp?B?SWNSNW9Eb0RkNnd0MXQ5NndzdE90eTBROVIvbkRZRHBVdE9DcGtmUFFO?=
 =?iso-2022-jp?B?TExkSEs3UHNpdnZpZ0lJZmJsTzZYbkMrOG9NZzJCOXk2UmlEOE1wbVFU?=
 =?iso-2022-jp?B?Lzlnc2dyVFhPaUNNTlBMT01QTVNmSGlzWE00MlZaQnRQOXMwdlJRdnR0?=
 =?iso-2022-jp?B?eGd2ZGNNUEsrT0Y1ZlJ2SW9acjlZdzhnalgrbUFYRHQ4dlRiVXF2L1JH?=
 =?iso-2022-jp?B?M1RmN25KVHNEcUxvRnAySDhwaEh6cUVWS1NaUFVGN1NXY1kwYmt6VEFG?=
 =?iso-2022-jp?B?WnV6a2lFN1lhSzU0YktqWlgxNzVmUXVxWW5mWkFOQUJ4S2RsbEdwemdC?=
 =?iso-2022-jp?B?YUJaR2VlYWo0MVNFdnI0d3dCdllRU0JSb2JPOEIvQ3c5NmlvYzFPQ3JI?=
 =?iso-2022-jp?B?VjR2T1psRlY5ZFRDc2d4eWJGSm0rODM1OXhXaThNUWphN0ZRZTZLQld3?=
 =?iso-2022-jp?B?MEs4NEFLYWlnS3UxUmVUY3ZpRWpwU0hLek5SN0cwWThtR1pmdXNhWEd0?=
 =?iso-2022-jp?B?YkFoeEVST3V2cTBSR2ZLbTJ6Q0RmODhPN2F3R09pWDhUalc5N09DWVpB?=
 =?iso-2022-jp?B?QXRLMWl4OD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	pCT3DzyAn5pRpU7wznlhXJl9P9XTR+Hj35eax6U9+T+eVsWNPsZBuxCNA5kYd3CFqJ3ucmElk4AUJx8yE1TL8bA2mMTPVE7ciSjM8q3b3PTBvjRqErBtDZbzxAL7huu9ADvXUYajT8Xie255Ot2xWyt+X+LE++DusdIoDXt9LqsAIsnWQ0KUH6934Bn1TCS/Q67zg1kuvCNG2bmt/xxCzSedK87cevVMdv5sEMUTKPL29tgMTtfQIPC/6Wl31tkza6VxhvsDr6S2xQzx5pnUPtltQNV+laKRH6CmGb1jMNKsuHpk2vTr2V9Z86qZjDa7L1uK5Xl3sasbsGidgNvNIw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc421d0-7e41-41f7-340d-08df201a4ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 00:15:44.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rI2KJXPCy+NtikR2NRPJUNndYpczTwx6reSfKT87enDN/ySDhtJRQI2CQ4lBpPI1svaJDys0IbAFpGWOtk+Pmsf9Hgn4huqhCyLBk4u3kZBkLi7yUiozV2rDK4yKdkPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17053
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 00:16:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24402

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, October 1, 2026 8:06 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org;
> iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=
=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI
> support
>=20
> Hi All,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Biju Das via lists.cip- project.org
> > Sent: 24 September 2026 10:32
> > Subject: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI
> > support
> >
> > Add Renesas RZ/G3L RSPI support. All the patches in this series are
> cherry-picked from mainline.
> >
> > Biju Das (3):
> >   spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3L SoC
> >   arm64: dts: renesas: r9a08g046: Add RSPI{0..2} nodes
> >   arm64: dts: renesas: r9a08g046l48-smarc: Enable RSPI2
> >
> >  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 29 ++++++++
> >  arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 69
> +++++++++++++++++++
> >  .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 19 +++++
> >  3 files changed, 117 insertions(+)
> >
> > --
> > 2.43.0
>=20
> Gentle ping.
>=20

Sorry for the late review.
I reviewed this series, looks good to me. I can apply this if tests are OK =
and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/290=
4860853

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


