Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF9C982D2
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 06:00:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5117.1789711246772183239
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 23:00:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=gXn79Sic;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789711244;x=1790920844;bh=R4yEQMrIAkmNcLFy8aDjVrCrJcPQ3gskGuF1v
	0qYgjs=;b=gXn79Sic4FSWTPndTPhoHJhWWA2KPlAWRVpS5l383oPmUoQUXoCRbbfelbAr6jU2nmL
	xFAwZl4mwUYmCdrX+zWyJk7ea5TX5MB1/2aNv6JX84Xmyw9Iir3nTMa6T6Eh5ZHRLH2ddbRwU+UVC
	g+fQ40xeVZk643jZ8LIbV3HeJzN087RtlJ+NgFfiM4M1lKNaETi1MJeKbwJWypcv17QGnGLvhgqOl
	LkDt6gvaVJ7kc6I7umrdVmQRaAS0wTClX2Rd6qKxMEgU6eNA0043Ld2IVhX5ujIfgCW+6firOpLzg
	Qf70SiHQPYJ/QZFuiUsCmdbHngmsYu3wog2OmU4uPnRw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 68I60htX406991; Fri, 18 Sep 2026 15:00:44 +0900
X-Iguazu-Qid: 2rWgJYzA5lKGw4UWQc
X-Iguazu-QSIG: v=2; s=1; t=1789711243; q=2rWgJYzA5lKGw4UWQc; m=oNgamfKVaMV6otEE1WCssTMsOWByOrD3T+5IBOcKzpU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMRv02hPz4vyw; Fri, 18 Sep 2026 15:00:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWCJyyHza0RfzW90S4MGNhfU1S5XcIMvaYqClHqQzVFy3W1bdaaMJFIXVirfBu8IpsUB51psct1ktthTEeVKwWxDBwnB3quCPepNdUWTPom9MOdh91lfxU+YqwXrVPS460PZ5iRkQTuLuLVGWTvbbtVAjfj4oxUlgiOjv6Tf7ikN+kOg9H8hEXT6eQRGC+xwECmGOIJYDdWtzoHEso5M2UeEcrEXz4NnbrGeM7R1RgvZRdDE46YnezcpcrjPRlUBVZZ3H9l+pPmx1Y9ErzmAmFd34SpRkDwtil08MQfLDCWGWTy5Jz8A79xkXYbHU+dDXjlkTAi5CMLCJG9akGa4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EELuUTg+i7CIPPmZ21Pq5pfZVN3hBmroNQfH6WoPzgs=;
 b=nihZX2s8QdFAZwxOTcivZp24d15ObTJCI2sgP7gUKO85lEsxj5nO2UZX7t4h2yO2EfIj/elvQ+wZKpLgsWc2GW7YCtOsNC214rLM4YXnldvRZ8bIDhS7YqxOpkA3Zk8hdubNycORlCX9y2cOqWUxPTvk+/B+zb2woJWsY00COEHT32eRY5JAUy1N1dOrLRpgIdRet631HIcxbBA1u/ZHSOYdJaWQ9KokLFPFCzoWEvpRUS8kWmXZmGW0wupvnQgNB5Ja9hGwnyxLQmg/+17INw3fp7X2fi8YVuxXshTJcL9c4OBn8mhcyan18TzPCklDJl/H3sNnQ2n6WZazvKbhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for RZ/V2H
 and RZ/V2N
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for RZ/V2H
 and RZ/V2N
Thread-Index: AQHdQ548sjgCQWGqqk+/5yDTRUHwzbbNltJAgABmnACABeFbAA==
Date: Fri, 18 Sep 2026 06:00:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CFE0753FDD239E2B16B0CD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818789173C2C8D8F9C75388CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aqfkthTXCdQOceY7@duo.ucw.cz>
In-Reply-To: <aqfkthTXCdQOceY7@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY5PR01MB18383:EE_
x-ms-office365-filtering-correlation-id: 9a2f150e-1569-42f9-efa8-08df154a2b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 
 mFcJWVG1AB+RzCQ7RT0WAkl40iCjsfJwKscvdkKHY5x2GXX7o1nVIcHauOx6zrAJcY5Nc0f2mdFiJ1fOPrtcXMdhdp83RTIzae4nyc2IGB/Vi8AemC02ZfiIzH6FP3SjQBI3eXScVxrIUj3WioJLUddLMqHk2hXoyXuKurFPjI2FrHm8qVWgeNRgKxW+OJAR7ehsODwMuTVwPvpK6MLHom+PN30iUtKMyN5dOmD9aOcfDBYHHkswLhohL5yyMslw9T3QSGqrwYtSzuVpH+8BAfJQD5xl7hzJnRKJ3xgprTKw3sz16p5rdfVD4DzW5vPFn5pauPaGhQ4x+1f68wh3zVIVO2MhTjlku4wyrFaN+qC6dGz4nqvrfkdO/9IM9T4TEEktwR1dmZJCQXFEo9M3SknMRoDQ31o92hc5jN84LoHjzlI2mUn5NK0/QbfsZgCmP0opno/7hTlmcuHvaPIpTxwSMGKZnoO9/hCubiSP/ARCrSeW5E5lJsczQgzGG75Ey14wdo1bZZAaiXr1jT5282tV7mjPmM8ZhFGmowcFGrxw2hw5zCmuD/19syG/TWB7bouW5VeEnK49FzWUX0An/TikuH4CyNgc0uUJ8bTgpboFtjtT+t7/473EIOWeb9Gpdj9LtjipLfQbcsE/zB7Zc02bLQeYhxsrBMVIbsBdBuqRR+8dwqh9dp9NCbxUrXY8XVChITEJvv1UgjPTl3K8gapYTd16Z9yIkoyDyig83Ro=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NnFRUzgyRVVzM2VsY2dYL2lUc0hLMi9pOUhzc29JYnp0Y3RRVzY5eklP?=
 =?iso-2022-jp?B?ckI5bzRnaVRJSy9iTDRsc1lMRG8zQkdpV3NqOUJZcG1uSFFXMnU2QVhH?=
 =?iso-2022-jp?B?YWRHc1BuNCtOT2g0OVAyYndRcVZJTzJkWjVCaDdLckZ6aFlxREtXeHZU?=
 =?iso-2022-jp?B?MDNrMnc0citOM0FPcUovcE9LU0JRQkY1TGwrdXhKWjMwdkptNlZkTitQ?=
 =?iso-2022-jp?B?RmppcWVZbkpRSjMxZy9yNGhRNDF2MStCa0FMNm8rYXhhUzV2TTRtQkoz?=
 =?iso-2022-jp?B?RXE2ZGRCaVU4aUMzMVhRNm1PaVVyNHJ1VGJraHVnRXRZMm5Qcm5uN3Bj?=
 =?iso-2022-jp?B?ZjBjck5rVUszTXBNYzNhZGN6MnpnbVJ5Smd0NEhDYkdTZFRzdzlWSDlk?=
 =?iso-2022-jp?B?c1NPTEhzRXFWOERZclBNN3lXTXNIa2c4N2RaOGhaMnZ6ZUJpb0luSzBB?=
 =?iso-2022-jp?B?d0JCdjlUZWxwOWpqZFhLTDhWMmRjSlNGQlltUm9XL1R5ZnBTRHQrQUZX?=
 =?iso-2022-jp?B?QjJOanoweXFEa1VZTlJNVlhya2tpYmduWktZa0dZM29UZEVBelY5Ui9C?=
 =?iso-2022-jp?B?UHpDZThBK1MxZGFnSUx0ZU4vMklya1JmaFBzWStxUTN3cmp4cDBtdm1i?=
 =?iso-2022-jp?B?TlRtVlNJQ0JtWUVma000SXhsVTZRRVdkbFZNcEk4aG5BZldUclJTeHVQ?=
 =?iso-2022-jp?B?cmgvOE1Mc1VjcEFuNDV4UGpac2hPUjBmL2pLWWg1N21sQjhOdG1ic0pa?=
 =?iso-2022-jp?B?M2RWMCtUQUhlcDJKVU1lWFRnb2lRa244QkZ3cUN1WnZpdyt3TEZ3YjBl?=
 =?iso-2022-jp?B?M3RlNHJDUmJRMjQ1T0FkeU5ia1JBcXV6QjR3SzNDdFp2UStnZ242M2N0?=
 =?iso-2022-jp?B?MkUxVUJSQUNHbjR5YVlaVE04RFhTc3kweVJUMkY2V1FBR29hZTJvVUNF?=
 =?iso-2022-jp?B?NFFkSklnakU4aVJZemJldmdGWlRNTEl5c3NBMzM1a2FWZGRXWU5aRFhr?=
 =?iso-2022-jp?B?TDhOei9pbWhWQlIwRHI0QUxlMEJwU3p1NUMySVkwbkdpWHVNNDVaOTNM?=
 =?iso-2022-jp?B?aGZFZlFkc2VKRkFzSysrYlc3cWd5L3ZYcWNZR2tqY205Rm1rbjlaUGtI?=
 =?iso-2022-jp?B?ajNtTzN3d2M0L2NkZXdJUDZZRktCOWwyNVBOWUN0Q0kyR1IvMUU2c0RW?=
 =?iso-2022-jp?B?VFBTam1Va21pWDg5dmw3YXp0dERwY3VRSytBa0t3V3YwTHp0QkVCMmVh?=
 =?iso-2022-jp?B?U3NSOFVsNlFEa0hZRERXcXlrR2VWbHV5K0Z5bUNsTTlKbGNPOUcya0pH?=
 =?iso-2022-jp?B?cXZzaHlRZWVIc3AzTGE0a2U4STVWcGVwQ05rRW8rTnF5N0lUVjVjcVZk?=
 =?iso-2022-jp?B?WG5FQ2F0ZlFHRnY2cUhnU2pHSDdRa2p4QzlJYk1VQVlBSG5lWWJ4MVNy?=
 =?iso-2022-jp?B?RitlenpzVDRLM2xWVDUzT21wcTdZVkhBYk9KbjFxbzlFak8zTVVjRnI1?=
 =?iso-2022-jp?B?U0c2Tk1RU1VTZEVxQnVpZlVVbVhUbXFIYlMzOXNyTldZVWc4YkJiaWtQ?=
 =?iso-2022-jp?B?SlJzRlByYXZ1SXFMVGNmV3NmZWFOcjFOTkF6VEMyN1FrWVVDaUMzS0wy?=
 =?iso-2022-jp?B?OUQ1Ui8rWmR1bTNKMTF5YWZGNk1QVHpiak02dGdkT1d5VzR2ZnpaNjhN?=
 =?iso-2022-jp?B?alVmcTZVR0pDc29ZalV0dWQ4MFBRMjRzUnhRY2hHSURqQTE1dXBNUmFK?=
 =?iso-2022-jp?B?a1I2L3NQOERtRy9jUWFSSmx5eVIyUU56UUtrT3hSL2lZOE5GWG9NRUVp?=
 =?iso-2022-jp?B?R05INFJMNFpRWHdkR250VGxZWHNwdHNIOFlRb1FQUzRWYmxvcVZhR05T?=
 =?iso-2022-jp?B?T3IwYkdZQzNDcHVIRU9VbHh4SWt5QWJJVnNZWUpzemkvRXIybHg3RUJo?=
 =?iso-2022-jp?B?cmpFdFYybzJ5VVc3RUJJWTJ2MDZaQm9paEJ0dFpKYWtSZFZoeFUrR2JQ?=
 =?iso-2022-jp?B?VkdiWGpiRmpZMjlaV2VtVkJLdjFtN1RYR28zVHJaU2cra2dLc0JyZXBl?=
 =?iso-2022-jp?B?QllSU1NzZzR1V1RUMWd3eFVUTEJkYnIzWU5hS2RDQkcyem1mcXVEcmZU?=
 =?iso-2022-jp?B?YWplcmdaQ3gwWHZ6dFN2bEk3VWNUZzdINm1LSldnQ1lCNkRGQmhXTm1j?=
 =?iso-2022-jp?B?SWVtSEVHUFMrMkZyMlZlMXZ5L3k4S0VXZ2ZNTk1XNEFpMVRGbUtySVR1?=
 =?iso-2022-jp?B?OFRTMTNYN1hCeDNsaWRDcG40d2VJUGliTTl3cGJzWmY0ZUpLdmZ0Mndt?=
 =?iso-2022-jp?B?eTV4UCtaVk1DUmZOeCtJckRyVHl6WVphY013NHhhcTVrTXh6WHFJblBM?=
 =?iso-2022-jp?B?UitrbTM2ODk2Z1NXSWwvamdyYTErc2dLSk5WWVZoZnkxU242Q01yWlFh?=
 =?iso-2022-jp?B?UlE4cHRKY201UDRlK056M2t5YVkzNXVIdzIvckovdE90Y09DdjB2c2R3?=
 =?iso-2022-jp?B?eHN1Qm9CMm1lbUUvVnJNZEgxK3NlN2ptRm1SaVd0YStkMUQ4dnYzaHI5?=
 =?iso-2022-jp?B?VXNjeWVZbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	FhZwEeZaS32KeMOhmFQS81NwenUhF/jDb7RRb3MkTOARcPcCAt1ZwxCy+a8yWuD0pLBOkcWKIqu17+3rYJF7fmjT10huB7CuX21NetMrg3syvZ+7Wk8ANoY/prKVFWaBf60Xq0Miz8ISoJFP2qYH0El6KpWQb361uX4/ytsf05CuBzHChjVUiI6y+3vCDFMw5OvVACOBuwb9azHyEzhN1YWCkkOYtMQghtGmPhPywNH2PwaPfeRsu6GV5UNv1BI4MilbpQXWwgDwStrT1TDTJpsWaakC+Rhv2/jPZ3/t1b4TDn0zJEvHwnxFJQq37M3Ve/ZAA+Yq2kwLFEa5eZ4TWg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2f150e-1569-42f9-efa8-08df154a2b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:00:40.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lp9RtIqx8tVjIX2UaqgHuQloU/l348rlSPNOfsdIYrylvSmw9xY/NXfVpnqHr+LsrzD3MYI5efZ2d+zYiBsNMLXXFuv/APOSfNb9P4UYbejaEi4pZLlTzRFkPoHbgt+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18383
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 06:00:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24231

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, September 14, 2026 9:13 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: ovidiu.panait.rb@renesas.com; cip-dev@lists.cip-project.org;
> pavel@nabladev.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for
> RZ/V2H and RZ/V2N
>=20
> Hi!
>=20
> > >  arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 21
> > > +++++++++++++++++++++
> > > arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21
> > > +++++++++++++++++++++
> > >  2 files changed, 42 insertions(+)
> > >
> >
> > I reviewed this series, looks good to me.
> > I can apply this if tests are OK and there are no other comments.
> >   Test:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284574937=
1
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
Applied, thanks.

Best regards,
  Nobuhiro


