Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED97C54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 07:45:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6623.1785224708603861500
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 00:45:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=AwxKpPCg;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1785224704;x=1786434304;bh=JEPpBzGeOpMSls5Gw4ZdSp5H0F3PiDZfCsqeR
	S/IXvc=;b=AwxKpPCgNS6qRhPpf6X0jTK2yUGK0zA4oZbe52845TWWx5X4T50ukCJk/vqp3vnDo6G
	rizYTBhBJScpgaoSQNgsOcEoLzZLtLwR0i+lV9FlpsqXTHLpMed5RIqyfE8vfu2QkCgKRkJpdYG6w
	k0oz5Xv7LDj2yjZe4SqSqaY2/18Bqen4aMaRsp68mWO+D7pIvWuzC/M3QxaDt06P7Zt6Pvpf25tf7
	8PLOCJwrO2E8bm9itEyI/12bLKazRQLKsK93nH2tmV60a+Q8kImVewfzbayu0F0LsBq7AywJgxeWS
	yU9amTcSH/04CSXNPTaYuBH/6PV7O6r2OVXdjLn3E+2g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 66S7j3Ih1064117; Tue, 28 Jul 2026 16:45:03 +0900
X-Iguazu-Qid: 2rWhi97bT1OaoLogei
X-Iguazu-QSIG: v=2; s=1; t=1785224703; q=2rWhi97bT1OaoLogei; m=ro1D8H5U4E7z1PUuslNYWNORlpmL1Mmv0l1pbfe98rg=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h8SDG4FYVz4vym; Tue, 28 Jul 2026 16:45:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUF09I1ogXoNNYL/7gbJgSeHNbE3PkR56DZMZ7DfUMw8iJASqu3EO7F4LwinP+iEoeEJ91JE47l7AtklVyqZCb48v6prkZSI8Czpa3s1a4YcoKqnrvnzgyct7BktVuL4xd6U58+PXHy2ixEpOXSbYWGZgfT4Kl+5zat+aLwQuwYvMxRq1Qz1hbZRx8o5YwqxHz4sgqXX3iCxQzURer9ykwaRI1xfQm3ZTZ/f0Tf/+y1zGHX5oilwH/UL2bo1UjRebMAn4lfbBQQhNB9V8lAMFA7PSddL66JkXaMPcpB+/uRbMBhZWI4debIQ+zjd9IKLFnhw0FhAV99FxSNRcffwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlwmsw3O1ZM4YqU6kSOgV9j8FxTv+uWRPrk9n2TzEf0=;
 b=TU4FTzm9Pj850buZfruCaQ00m9+wAsAAuV4fSjpnGKXxXKsS8mbJ3Z7LgEm6DTt2rE/SlM/QyGLQWxlmULXJCmO8aIzA83o9s/Hp/NBocxJAJfETjMQTaN1DK3xSVwQCBR1zkNX3UPnBUAXQv7l+8lTwZ1VkCdhd4aExT3+88Uv9iyy6CJaivtShdDIGiKDmozEr6HVYf6u/nxsjVtE2TlAXZKQHHFORSw+CniZV+e1sjBfZ+4jDHaSaktqqjIRmXmdia5TCnz/1LUD7NDHjQyRV4hVyJBtDxA7zK5+imKUbnlEKRUW0DFgQWAcpPg1JM1khtoBdoGa1iWk322z0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H and
 RZ/N2H SoCs
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H and
 RZ/N2H SoCs
Thread-Index: AQHdDXSU3U96EU15T06lJtQ4i0GQ6LZvzqaAgAA4nwCAEqetsA==
Date: Tue, 28 Jul 2026 07:44:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185984781EE99AB66F2FF6CDCB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818D949B2AB9210CF312A6ECDC72@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <ali3wExG4j1r02cS@duo.ucw.cz>
In-Reply-To: <ali3wExG4j1r02cS@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB15501:EE_
x-ms-office365-filtering-correlation-id: bb41f3b7-8699-4d2f-d959-08deec7c1fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 oPZ8dr7KSrDYwjyZwGLoobaNrUW+hoH+v2ujxWlyBSwjVdp4VGn+63byFcQRljos1t9Wu+jRMQidk3LG/x6hm4c4VcNFD5VsMsirHqM1HudF8FPb3tQ1b3IWH5vgAa6o7Ld/0xpL7/Ii7Ay/NpPJApL4QA3vOKeXQQBKxO/9TBsdYyaB/FPnJcK31GOdXk7TlJBajDAiyvKRTGLljyN0GFI8ozuWQHI6PwBkozaTEGyuqNrwjnYga777X91p9uB9ULg4qow6qIk1D9IDGfielM96YSlSx2OD/TxkkV2OiV3yDjtbXJxitzrJKxBAzScSsCijdXYxOWOsnHSQXNZ6HUUsCE8qdP1Q2q5S087Kc16nRuzEw4NvxO08VdgRbmp0eb4VK95Ejuf4KD25MVn+WjF4QelRkj/2eDMCPnnPWg2+UUGKmPN52dyXE72FYSPlGUrYtw+LkxmArW897lFZ3lo8nja0GDB59bU2V6EZZxbvSL0AFa8dNE4WvSu/HzJuWtfQsgkxZ8CuHX01IsxmwS+BleagCyf/U+AxkgnO7MrLdJv6P4aWtkZJUGxuJS9OnsfsrLsHvsP6RoiE2+eqIkDV9k2S8cHsgqVD6ZdIIJNnYEng7vZm/6rOeRccdSZQTny8mW2Xyn1YLYN/aM6jnIH5TjVXTj8LozAk3rpbFEKqKcigiD248jMO22+hcyRqi3qnYy+8pCvK/bItDUP5fF9G4p5JXjBH6VmEQKyGGqw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cmVpNmtBajMvdU9uZTNwVDhrZ25sck1hdU40OGtHVU52TXlWNUhYK05N?=
 =?iso-2022-jp?B?WjljZVhSQ29nb2RrRGdxc2pmTjFtMkxTbHR2M1RWZHlWbXhLU1NVblpP?=
 =?iso-2022-jp?B?cVNkUnp1R1NSWUxYb0lyRis2Y09YMGhSS0hrU1VNZmRETGc0YU13QUpK?=
 =?iso-2022-jp?B?OUUvbHYxS3k4NmRZbnhtZHhZcGVDbmpoVjlWTVE1MHNvZ1dwUkN3bDla?=
 =?iso-2022-jp?B?TCtXL01VSDhaZytUVVVDNjRpVEF2VllScU92b1hyL0tmOGxWbFRPWStQ?=
 =?iso-2022-jp?B?Q2lOR3ZmNmZpZWJuNVNCTlJ6ZTdRU3RrUUNiY3lVNW9yTk5GU252czhp?=
 =?iso-2022-jp?B?Ty9lNmtFeXRETlVKM20xNDlwNUorVnlNdUswYTFoZldiSWVWYmxRQzEw?=
 =?iso-2022-jp?B?bFRDeWFYaHFrd3FlWHp5bTRQV25SRzEzc0UyVEM2NlluVDkwdk05YUdp?=
 =?iso-2022-jp?B?aHJSd2ZVVHY0QURlbWdmVno4bGtzZFV5aWNBUW9SV0h4VXk2TEpEbG9M?=
 =?iso-2022-jp?B?K01Ub3Rrd2M5M1JnZnBWTXBtV1Q5V3d2dUxTODNBcnVRQjYyNzlXK0sv?=
 =?iso-2022-jp?B?MGtULzJZM2cwbFMxLzhUOTJNdW1xVU9hTWp1M2JDa0phcm9lUjBML1dr?=
 =?iso-2022-jp?B?aGk5WEI5RklLOEdONWpNbktYL1pURDk5eTAvV3lIUkgyT0dLN0VEV0kr?=
 =?iso-2022-jp?B?MlQ4WmJXRmpYbnI5czlkTTNrZ3d1YTJhTWNLMEZ4aG9ubit4NkU1L2VU?=
 =?iso-2022-jp?B?bjlNYWJzclV1NS82Y20zYmtVWFFXZUR6bDlLVDI1eitaMitYSjRYZUJD?=
 =?iso-2022-jp?B?aEtNTlFMMUFlUzVYd1V3Zld4akJWVFE2RmhiRWUzdVN2OERGK2pkUEVl?=
 =?iso-2022-jp?B?TTlBRTRrMEk0NTJoQ21yVU9KVWZwdGIxeXhEZVd4eUFHN0pOUEE1bmRC?=
 =?iso-2022-jp?B?TFVGNW5ieGcxcjhiUmp1U1duT2NqSGpDcGdFSXZueHluT3cvRzNoY0Jv?=
 =?iso-2022-jp?B?NE56Mzk5dS9WS2dhSmVCbVprWVoxWmE0dEFIVC9XK1N1bEIzTmlhU0lq?=
 =?iso-2022-jp?B?ZVVHUHlsMkV3OC9nTVJ1dFZqMjc1Y1ptcno4blNUMTUwVTRnaEF6RktB?=
 =?iso-2022-jp?B?RTcyMWRWd0g2ckRxVnJtOEhyZ2dEODJBWFZPOEFMSGN4RlY4cDlKcDVX?=
 =?iso-2022-jp?B?YVJjZnpuTjA0NmJOeUhnUXRwUWk0Z1NuTEN1TGtHd0ljUEN4YzFKcFd0?=
 =?iso-2022-jp?B?ajF5MXlid0VtRFczcXpsT0VLbDE0b3RSeHdsaEVwcGM1aWVwekFsY1lF?=
 =?iso-2022-jp?B?TEI2cHZuWE8xeHIzR3A4ejNiV1psU24zcjZsdEZYVHhoK2MzeElGcm9F?=
 =?iso-2022-jp?B?ajJMUTY5a2VsWHRpeEtic0txYkpDYWZnVWpwNDAxQ2FpMXJpSzh6Nlhv?=
 =?iso-2022-jp?B?VkRGSUxEdUhRcGdPRlR0SkcwNGNyM2NackFNbXdtRzFGN2xxZG5EZ1N2?=
 =?iso-2022-jp?B?SDIrYWxudmlsSmFsUkE1S2o0cWVueVEvREVRQkZQUDFVSk5nemVDRXJx?=
 =?iso-2022-jp?B?VDRPQnlhSEZIQVNXTGk2eDlyaG9NeWxhR1NJUXU4YjBuTVVRbVU5OWtP?=
 =?iso-2022-jp?B?SGVjWm1KTENwTS9leHZVNS9zRWtrdWlWU2I0bXN2TnVOKzFKWUVCV0lm?=
 =?iso-2022-jp?B?MmNPUSsrY3EvSmFnVTlvb21WNW1Zb0cvRVlqdUFGNndMSHI4N0QxeFR2?=
 =?iso-2022-jp?B?QUJRNnNLcE5CM0dod1VOckI3bkprbWtlU29pa3Z0UEY0UW1qbWs1azVx?=
 =?iso-2022-jp?B?d1JQc2ZKdVo5K29XdmxyL1VCZzlkQkZSYm52VGJ1WHFUMmgxWVhaQkpq?=
 =?iso-2022-jp?B?RUNWVmE1WVBvNkFBb3FUTDFCN0ZrRHNoQ1gxQWZlckNORE9JQjlDaTF2?=
 =?iso-2022-jp?B?VmhvcHUzRitNTnZLNllXdVVVTWtKYVNMdk5nQUUvRTd5TkhmVHdrVllK?=
 =?iso-2022-jp?B?TkVFYTJUN1N0WCtXNS9FMDAxeE5ySUg1L25OSFpqWWdmWFVmaHlTZDZR?=
 =?iso-2022-jp?B?dmloUlNtaURDUkxTdUxHZUp3b1NUaFJNNWljeUUwdjlzTEE0eGxkOFNq?=
 =?iso-2022-jp?B?SnpxRnNsbjFjcjlWVmFSTmRRbmg5ZmpsN0czTEJLQUxCL2lVWE9sKzdY?=
 =?iso-2022-jp?B?WnJldDFwN21MMGVBMitPS1RCNklHSTI2RS9xS1lXbEhqSHNqdUo2U3B3?=
 =?iso-2022-jp?B?UFR6WFhMRTUxNWY4ZGxrSlpyRHI1bFpMWDczUGdCSGZ6K1BYdnhaS2FB?=
 =?iso-2022-jp?B?aGd6K2dvY1I5Y1JGV01NTXR5TVBJRGRtemxzWVJ3d3YxMmVYQ1NuNkIy?=
 =?iso-2022-jp?B?N3k5YUZsMXNzUHlBUWliODgzQ0JXdEE4OUQ5TVE2eWh2MGtrWHJxOTNP?=
 =?iso-2022-jp?B?YWF3YlplNnlPcHdveWpEbk1VdlJITDlkZGZTa1pRcE84Zk44MDk4Z0Uy?=
 =?iso-2022-jp?B?d3RIZzg0ell4bDhOcFNPV3d4K2lHSDQzRjdPZ3BrditDbkoxcHJqLzFa?=
 =?iso-2022-jp?B?M01BMkdtND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	OciA2MGi9JlT6BFDljCa2Tf0Gk2FS9WQgPqvnbBPFsw0mnyk7ZnMzks/kmq8Kio6vUy/iuwiIBEJgqqLA7ynWLctNo+lcb4jNdsmqRvmiuJvbng+cMywF1eeJgoy6Z0Zbx4L7wsrOAoP8hF883JkvxaD3l6biEkRPswrDhMkBe4Lxj+B0ONrXkOIztb/tm7TFHvC5w8XxTs2QlDjuvGSVX52u+jaIdVgB1w1SqZO7gImRhXLadcewL9kAsIKLxm7hw+ciaGLSdBjcyb6j3Yj+InsVHJvxcBOouLvq5nIHQ9Q+g5SxPrd52M6LD3/bAJ5Mpx0E8SetqM2jlAk60A+cQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb41f3b7-8699-4d2f-d959-08deec7c1fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 07:44:58.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyeVl4C1zwqftj9ef4fETcoPe9xTWeSZOcMF0Eb/4nwescQVlYp5JEkuSKvui/geWNIfX1k5VhGPqgkGZr6GPGUuLl1T5CRR/AOhNGdDmOnjf8V3cko1LNyWWqM4pjVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15501
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 07:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23791

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Thursday, July 16, 2026 7:52 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: prabhakar.mahadev-lad.rj@bp.renesas.com; cip-dev@lists.cip-project.or=
g;
> pavel@nabladev.com; biju.das.jz@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] Add xSPI support to RZ/T2H =
and
> RZ/N2H SoCs
>=20
> Hi!
>=20
> > >   arm64: dts: renesas: r9a09g077: Add xSPI nodes
> > >   arm64: dts: renesas: r9a09g087: Add xSPI nodes
> > >   arm64: dts: renesas: rzt2h-n2h-evk: Enable xSPI nodes
> >
> > I reviewed this series, looks good to me.
> > I can apply this if tests are OK and there are no other comments.
> >   Reviewed-by: Nobuhiro Iwamatsu
> > >   <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> I had some minor comments here, but those should be fixed in mainline, fi=
rst,
> so they should not block the merge.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> Best regards,
>                                                                 Pavel

I applied and pushed, thanks!

Best regards,
  Nobuhiro


