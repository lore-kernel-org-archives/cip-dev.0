Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A582FCD0B0
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 05:31:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7517.1773811876497058521
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 22:31:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=BR/ZFetr;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773811873;x=1775021473;bh=QXcTPQHDIGluRYfJ5wowXq9mMPh6sr4paOhCg
	2GDPq4=;b=BR/ZFetraFu9V6Jzjt3WTHEBYP3Zcobq2u9T3sXI3ve8jTDsNaZtZ8RHg+J5enAYWkj
	jR4ujPIn93Fv+JSh8uTTdcEUBV6XO0I6VgvevJnY/VsFjiZMrjy7cZkHmnouZ22fCEk98pi/rgJxE
	+uhWWMB0Nv+mjyZ6pBM5AqLGYrHgNrQ4DaTRVCcSPr9Dyrui8fC/VBsWhDAH0EbWYaLwIeOafynVO
	Zj+UsGUjXw0xYoLtLxX43b4wNkWbeSlRmzsNFeCdBeFygOZqnxbqqaWnmJuSRMvssBuESbx9gGswC
	P7zg2hMt0xoXBN/VWU+bR4RrkVIau+iznwuovtKOcHgg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 62I5VCZZ2326006; Wed, 18 Mar 2026 14:31:13 +0900
X-Iguazu-Qid: 2rWhZwovGE6hc7lGzE
X-Iguazu-QSIG: v=2; s=0; t=1773811872; q=2rWhZwovGE6hc7lGzE; m=wpuQLXZTcBqzX3WW/tbKQGfUl6FCsJP3CSzbKVwDD30=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fbHVm2rWFz1xnZ; Wed, 18 Mar 2026 14:31:11 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMEO4tzBuRCeACq8E6+nnSHt1pTORHJnnnXMwHLgEEKQ2KfDzHwX0BJ9cDGLD5gKTFunSFC6EAkWrDIJTQNpLjW305cxeGsVR0vlLPreq6pL5dPhZeknAbTBIsiAsgAYQr23VZodIXCH9Ppu2Tp0d5sDrISjV7j97YvztMFz8myjCYoD8aUqfsOYikfXveDYl6Uw9652s084U81dkbZKL9PPovc1yfbGrN0rBdp+H0QrC5ahOyvppoImsUUSrgx6X3SfBW7eEc1nj48b7PU+Oyi6DV3WuuFINe+Otqk0szGP5zIDDyqEF6IkVBtc1Q0hEm1xGdEzMVGRT5XhTEN2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNfTgRgAdrwD85hv7GxkJ16oWK1A7wu/ZMl5Lm46w1o=;
 b=sCUaamKm7GeqXaqyAYLA9m8AxuFbDl1IVKuzUlZ4ajbPf3DpwWejCFByPrwiaJzNOHJkwFulZJK+jCnFLPS+pbHZimCkx1AKYluT7mnVBvu45JQbp6uYmj3cPNxYxWLQQvyPebnwIHWpy+jrw05hR8UOn52NSTxshTpdsUOlVXSrBimIdEldmPMVsYDvFrSFqWFgOMbWOF/uH/Pb9I5AZszHJPY7lZAeIYfCIozHAnABeb4Swk/lTBJ/UmnuGE6LImUjuA+/I0lwZ1bCHq+FXYsncFhdouOrZqgymQA2bTsbHdI3xYNFarNKhwX6SlW5LStHMawmzXfRthc89ehIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <cosmin-gabriel.tanislav.xa@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip v3 00/17] Add RSPI support for RZ/T2H
 and RZ/N2H
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip v3 00/17] Add RSPI support for
 RZ/T2H and RZ/N2H
Thread-Index: AQHcr9Zt8oT5m3eB9k60E04iS9TVQLWsSWmAgAeHbhA=
Date: Wed, 18 Mar 2026 05:31:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818659E4E349A48CA7213A3CD4EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <abPnfRqyoKUL8xxz@duo.ucw.cz>
In-Reply-To: <abPnfRqyoKUL8xxz@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB12450:EE_
x-ms-office365-filtering-correlation-id: 8027bed4-84c1-41f1-cba7-08de84af8e3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 m3Pc/YjzVDcqOMVH2JW9ZqKeXn0QKznr2jEBDhIJ4THheOg9jVmeBjcM2aN66rP3s7xiAoPYxiB7kYdaY+NRBYonl7Y49Rhw6kSzy6yS+WvVCmmc9+z7pTTOYlhkH6fuGpYTZzMYo7meM1M7o+WrTRbJ15GW9gRz4QlGqYFFl2+ZGbE8hNV2VMAt0542G31SfbqrQTq9YzCVk/y3Ze/4CTsvIzTstHfvLUre5zKzX32YPAx66g3ZltAmx/UhVHkywBAa93uAdvAYd4wy7IUvpwjT0nGf1w5emIcMC1id52Qn1+Mcpj6UXHjiemKwVft4T/ofeO+EI1L0DazEaIJ7S7ZrvfcB8jH9JiFY6EfF6nekQxkoX1Kykha2dpOH5UJ1u9aFsSCuRwJXNpZMkVz5xqbz5BBwKy/JYpQbK3g4wHyzgiPkRUEkzGio+5wiDvG0sSV9Ih5qko15K1pmJPYO0voQGIyVtLCfRozfYovlisKuuqsuNh3GfdktteqMeHy3tt5C5nkfgwReB3wN8+g5TyAT0Jqqy88TRTOH52Q6V/e3s0/tvSSBASdnF89AokSPQhBZisE/Qus/nXEm6DZneODZl8UKPHCK/52yCKYEvpwmvEjQGvaOfsbz5eMLeMXbWQjYT2QDCUuYSy71mcg20jx+xYGElqFpzXQ1sAukth99CDTXTkI+DY6wJ+8vw3PTYT8LIuCqdLwBE/hsvI58m2PJNpAu67wWovopv8QiGsJEegNyrHDx0hmjKQuXodh9afYbqiDTpvLKbBQ6BT2f+e+24ILUC8EilWK3GE+qYb8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YWNvTDNVQURLQ0ROclNnSm4xdlVPT2RDc0x1dXkwQnJFQnNtM0tDM0ov?=
 =?iso-2022-jp?B?ektzb3FIcXdsa1NSU0VQNUJHU1VuZUpJTFVIVE1NWDZ1OVF2QTNzMlF6?=
 =?iso-2022-jp?B?V1I1NFFhTi9zc3R2Q1VodnNaWEhuZU9PVDUzSUdIaHNDcFhXRHBUaU52?=
 =?iso-2022-jp?B?dzZXbXZPaENTR2lwVWVoV1J0a2dIVkNvV0tVRmhJMkxDWWUxT3d3bk5K?=
 =?iso-2022-jp?B?TVFMbFVURG95dDk0emI2RC83aDZiZXlCQjlDY1IxM2VwWmY3aW9SNGlV?=
 =?iso-2022-jp?B?VytEWTV3aVV0ZUpxVHZoOXlmaCt1VUFFRms0Q2NxT1RlVkdNeDhyUUxI?=
 =?iso-2022-jp?B?eDVhYkE5Rm10RkRpNTlXYkdpeUtRdW5Db3RSTkR1RUZPcGNvSmEyR21a?=
 =?iso-2022-jp?B?TUpGejQwUjF0RGJJMEpqWm9RU0ZNM0s0ZnJsWWRiRklrREpHbk1CeUlW?=
 =?iso-2022-jp?B?emVOUm05QkdXWmFKUDZucEpqV09CVm9aQ0FvUTdGM0lGYS9SYjRPZkpn?=
 =?iso-2022-jp?B?Y2laS1A0VURGVitQVjBQZG5JU0gwcmhraFZzYmFsejI3dU9WMElWVFVh?=
 =?iso-2022-jp?B?R0g4YW1iR3FybS9pRDBEMjJPbjkwTGlFNXVzSHJrSnp2OFVOVlRKY2dj?=
 =?iso-2022-jp?B?b2wzcmQyamkwb0lVcUJ5K1ZORmVleG9WUm9aNDNua242QXdkdEszZlV1?=
 =?iso-2022-jp?B?YzI2dnpvRFFURC9iWlJiQjBabHpxTm1jbXRtYyt0UlRDc3BXSHBxS3J3?=
 =?iso-2022-jp?B?dERYaFZDaHBDazVFWVh4ZXppNnJ6MTdYcEk1ekw4NGs0QUVLaE5wUGFj?=
 =?iso-2022-jp?B?Q1d3cWtxaEZ1NFFReXMrY1JpSzcyck1GUUtQc3lNazArU25LWUpFUkxl?=
 =?iso-2022-jp?B?bWJXWHZNVm1BMlZHblNqR2UrendNcjU3Ull4Lys3RjRieGhsWFdRSnNV?=
 =?iso-2022-jp?B?WmhBbSswUUZ2bjB0RUZjcWhoenZsbXk4dFhPU3Y4TXFIM29QbDNvd2gz?=
 =?iso-2022-jp?B?am5oRXdRT2NPWURKU0JDZDd2QWFpWXBsTUVhNnpLT2xhME1SamRmN1dl?=
 =?iso-2022-jp?B?QnZjRW9xL1V2MXBWc0FGN3R5MEdUWUdOYVhPOHpMTjk4R3BtM1hZeE9J?=
 =?iso-2022-jp?B?N2s4QktHYjJOTldYUmFBRi9pQjVqYmRDaDNBVTNjbGVXRTZOdUc1MnEv?=
 =?iso-2022-jp?B?aGNhZ0VOVkJCeGlEcmZmMGxYZGZ3WjlxTUUrSE5QREJlZnFITzhGcUQ2?=
 =?iso-2022-jp?B?M3dUSm1CRkNoOVBUWHBmL3lZTlZNSDdQV2FybHcyUlp4bDVEZGMxbFIy?=
 =?iso-2022-jp?B?OS9mckpsWXM1dXRkMStWN1pWSUN1em44K1NGOHJ6emRoOEJDbFd0WERC?=
 =?iso-2022-jp?B?TEF2UzZwLzQvQ2hmVXVUcGZmK1lodGkzS1J5cjV4aGkwK1RUdXlvSVVs?=
 =?iso-2022-jp?B?WGQ3QWkxUHdvUUF3VzJwaHk3YXhhMjVOc0JmeWs3N21ySmZ1OTh1c0RU?=
 =?iso-2022-jp?B?MEIyS2p2azVrd002akE5T1p3dTViUzRyWjl3d05UL0tGOFFUOE9OSXJ2?=
 =?iso-2022-jp?B?b0pwZzNLMGJsTFlNNVp0OWxzY3diZGVxdFltRHRCQkRqcjB4OG91NFRZ?=
 =?iso-2022-jp?B?eE5LVGZCSWwzTUM0UjBIdE9naUwwY3NwaDYvbFdzN2pJWmtXUVJvU0p2?=
 =?iso-2022-jp?B?dFRVQ3UwOER6cGhtTFB3cXlFTEF4eStVbjV4TWtucUJhcnJCV1ppTll5?=
 =?iso-2022-jp?B?TllIN0hTWk1lWlZYUlhubWF2Z0srdWtZTjNubS9Wa2Fhd0RXL3BUNnVL?=
 =?iso-2022-jp?B?b3RlVWEzSzNTYXZONGtOQzFXU2t0ekN0UER0MU42dUdhYkRxRU5YcXZw?=
 =?iso-2022-jp?B?c2JFUDVrdUhKYWhHRkRlTGF4UUd3TUdrclE0VDY0c3ZXMTJRQ3ZHSmVG?=
 =?iso-2022-jp?B?THZhT0VTeHQrbEdPb1dYZ0Z5c2lJTWFGYmR3TTUrNHJFZ3ZqVUVZNWRC?=
 =?iso-2022-jp?B?b1JRN0xFSko5WU9YYkg5R1RLaGVSVXJMTHAzWGVJMk9ENlluT1JOVjJD?=
 =?iso-2022-jp?B?cnlLdC9Tc3lsSlU0dDhOVDFPWXpjdkwzUFBwMWg3bE9PRCt2dUF0aVZZ?=
 =?iso-2022-jp?B?VzZXS2pSL1dOeWNRS1VmK3kvZHRDaEErU0JTQmVGSDExdEZ5czRFZ2hP?=
 =?iso-2022-jp?B?dnV0RFlHaXFuRVlabEJxZ1psRXZmQ0NwMVdIUVdETGIvN28yTTdaSytW?=
 =?iso-2022-jp?B?MGVPTDhwNHE4YzRKOWJXWnpwNktGTWVxOEY1OSs2VWpPMTl2Qmk1Ty93?=
 =?iso-2022-jp?B?cnd6azBHVTdLTW8yL2VnbXJ6ZjRzZDVzRzVlKzhpbHZsOWlvay9Jd0hs?=
 =?iso-2022-jp?B?ejJ3MnJWcHNNT3ovUGx0TTJJY2dhL2pDQXhzY3hVYmZ5MTY3UzJmTlFz?=
 =?iso-2022-jp?B?cjFzSkhRZ3RiSnVPemhkQllyUXM0VHVKMC9ERHlNelV3K3drQ3FkNlZx?=
 =?iso-2022-jp?B?bE5nSThlZzhWaVhPbThnT21EYkx4UGFCMEtGVGVwbWM2M20yRWpVQy8y?=
 =?iso-2022-jp?B?SFZTaGdkWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	cv4MR3p305/jvJrruykMAt4sF30Vj6kEtjbCplIw31fGGARII/DXdYPPlMnPQVWCQPl7gFKqesNSacLEAxNd8ZEjCUfBtIjqVpEy7pArRL9g9XWRVxOS1dbT3vOKH15MU3HSv4MqcYb4kv18gDALxhFqZ27GhcX5jK9nV5GzS0FWR5OFz+AhCKnJpQPzhabkZH/RFU1qaYP1M2ButRHn+Ba9I65jnjQ5hFXy0n03siO21noMFnbKmna6JxQkkhoVnQDNO9QD8wPcPnywmrmRAM3gIOB3Rqa6CB4UXGIUjUXPOxq2I7qFP3NkNtB1v11qTxuL1YRAKnp2nFNly8zuIw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8027bed4-84c1-41f1-cba7-08de84af8e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 05:31:07.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6F3l2G9FqxmNpPEbxYeJ0HsebgBJ4OuEWEw6Pcm3QgeT/un016eWiPqBuroUGFKHO5ruZuKlnJOI0Yxtox7lI+9a3GjggbEGoEE5d2dzSfek0cxYnpJTYIQYGMCo06tR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12450
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 05:31:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22495

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, March 13, 2026 7:31 PM
> To: cosmin-gabriel.tanislav.xa@renesas.com
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip v3 00/17] Add RSPI support for R=
Z/T2H and RZ/N2H
>=20
> Hi!
>=20
> > This series adds RSPI support for the Renesas RZ/T2H (R9A09G077) and
> > RZ/N2H (R9A09G087) SoCs.
> >
> > RZ/T2H and RZ/N2H support is implemented as part of the RZ/V2H RSPI
> > driver, and, as such, the RZ/V2H RSPI driver had to be backported.
> >
> > Patches were cherry-picked from upstream kernel.
>=20
> I had some minor comments here, but those should be fixed in mainline, fi=
rst, so they should not block the merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I applied and pushed this series, thanks.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


