Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDDFC43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 21:59:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19524.1783547985691811552
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 14:59:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=JLQpysdz;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783547981;x=1784757581;bh=hPySZzBFCHqiJvUm9k7mbq+wqD6+6R47AIDuZ
	QpZWAc=;b=JLQpysdzk9tmy7TfYJm01mexihOfdpc7uDlv1Lr3E77GBfkjrlBFBPTxqU1HdcdQNRD
	rj7o9uBi32PlsnlBKMybo6yy7TwvQdWWL7pBSHDC7buY+vlCF1BWuxOOz0EajyqqtFTBySe0/GtYt
	MCPBD/2oCOVzF1XWHKXKl7OIC19caPS798V1Y337TgsOpQRZdVBko0Sr8v1Sti+nIbDLf0JEvaxyb
	JLg6UNZOnp5SnZ0Ahd/k4pq3ZgYT8co2b7kijG0sMEsxfWNRKntTTaHxLQnVisaGo3KTorJfboxBx
	StuM0Qdv/pMfy5/3SY6DY+8DRx61FqxT7iSVPOU9aa6Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 668Lxe0f2871312; Thu, 9 Jul 2026 06:59:40 +0900
X-Iguazu-Qid: 2rWgvr1NS6RyqdQCTg
X-Iguazu-QSIG: v=2; s=1; t=1783547980; q=2rWgvr1NS6RyqdQCTg; m=jJrSjf3EWmL9pWp61V2JgI1cclJ+b8JR7ajOJZ6eF2U=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gwX7b6QVGz4vym; Thu,  9 Jul 2026 06:59:39 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpeqdADCb2FNDMTFH2KFlvSm1GFeDCnKta1F/m0uu46uAKIUFJVi2PRi/lGz9bz6S9d/o6ZG30ph0cIY2lNTKMFq1GCD/QKYo6DNOgJI7+0Pl40gl3scZEcOvIg0VF1e0WFOYx+Hu/siQAUPJT1WfhFfF262PTKx1mYihNIynccKM/3zGhxt9hUo8fgkWE11351kMUAEo/+G1hmAYq5NV01u3xaMLlTACN3wLFpZkpxP2SxnwzfzqF9M+dEG0/DUJVqarre22Qp91KLWah+NNqJi5Mhz7Rqm+/Pd+qUE9RX86YxyF57KQkvJwi8GB0nlge35eUn3GHs8W4ihaIJivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rtBD5fdCouTvoAYScApXvU65V6a9fuZInu/8iAqAng=;
 b=nw2iVnfg9vsN+mQPhSTcxASD3oCnezs9ON/5svX8eWhEzTVZZNOrMfaGLaUXpMlBaN6VwEKef5/fp5jecAmm/9h1AQ3vNSEDb9ZptPJS1esouPMKru6Xd/EjaLJh7uy9A+l1IZxran9zSv0DJ/ZD5a3YLGEsGUcX/Bn4wniyAYrAZqJDkwE1D7ymW7W5nFrToBm4UlSVveLx8ouJAUZ6qU+6+wOgoBtewqQIjabDx4zZoO5HZaxnxWyx9C758u2c+uWd4EsdowazAaCNtxIZ9xbMzkjapC63COCCH7jzK5FOStQ7vq2pzlGHyz7300lK3wn3g7COf6SMbimOVaW97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Thread-Index: AQHdCwCUkhnq9h50lkCvnEQkxepej7ZcS2WAgAfn5SA=
Date: Wed, 8 Jul 2026 21:59:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186D0455B7A34740B0B01DCDFF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260703152803.29302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <akgl0XRpDkjmOgIi@duo.ucw.cz>
In-Reply-To: <akgl0XRpDkjmOgIi@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB13132:EE_
x-ms-office365-filtering-correlation-id: 031e3e48-05b7-4083-7a0b-08dedd3c33b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 W2J8DRY+aJdpYxvL0z0zmFYmSua4niyPCsygiUOwPHItIhe+P3vU7xkPSX1fM5sHfJglolpi7/qqO/WNGYXec7tHb/58ejc4dH35J9gKp+Y3HNDAu4WrsgL1cIoAVT0hKhRLZc2vJHhfD7z7YHJlKwdDso1AKg37aDO5QjtJI59Izk/tFdrWmnU+1WT/Ssz6sKRVw4DIwqfQ7KHDUU8L9nx8qdcCbZZ/82DwhDJMSsProUJ1iRIeuO+rzTU6HZi3gNR23PJeLn5/hCL+ZW6BmCd4KbXinL8IhO2PyBgXtKvQVM9qFI8RZ6cJqDUVS5e7L7fMFPmXziL5EJjA6mzaN978DNolxQFKUi1uK2cOR9Kkqa9VSMEI3Z+ZDkVv51jNrbyN3gMD+gAao1w6JHr5kkK4t+T5oezBcB/Z5WcPAgeEArr++zrtTdQzaJTs82CjaLjxIOiy5SaYpkOw73vzYGNwaWtoDsW3i8B2ZoyOqQdpOIBr5v6CDXDPFrUy2QmnCV+1tABD8ha36B/HWnhpJ8QV3hgd9F8JeJNXxrw0AeOgAftJmix7EC81CC9eVbYV5wJRkH98Qve5rF53VJW0AUka8ObgkmuByKvg4K8p1SjSakFOGgdRIbLl14kfW2R+lLlXwO8wRqeS+lb+7GEs//18tajupSsu6v47HaJzfP85axP5NgmGAYdeX13WUJV4g9h5UzouUqCmuB4TP/gMeZH+nofuI4+u+01/hDjOY8A=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SDZDK3VwT2JHL1M5MDMvMnlDVWNGT3dmMmxReHFTTjNUNzlrdmdjN2dq?=
 =?iso-2022-jp?B?dk5sdFR6WnFjYmJoTWxWMDhPQlAzSU9TejhJSTk5YnZKV3VSSUpYMFFJ?=
 =?iso-2022-jp?B?SHRqdXRHWVE1UVBHVE9nTkJqMGhCZEU0bUJ3Y3R2MGl3dGRYNmh5TGJC?=
 =?iso-2022-jp?B?RTd0N1N4MGJOVlkvUWgyblo4WmF1Q0FtemgvekIwc3pPM2ZpNzhkWXpI?=
 =?iso-2022-jp?B?bjZEVmNTc3ZSUCt0MmFUSzMzTUNNMmo5Wm9SdlJYcVc0R0ZZRkJzMlVv?=
 =?iso-2022-jp?B?aXBoQWw1STkvWElQMUpCd3d6WkNTNzhxZmF2Y1FmSDZicjFQMktCR0tM?=
 =?iso-2022-jp?B?WW96bzlXL0pOenphK3NPUjlKVnVLUERxWGJGRkdwc2dpSUpBKzhMZ0Rs?=
 =?iso-2022-jp?B?YmsyWHQ3VFk0ZjZHM1JTQ2dKQnl1azYveTNGSUw2aDNsVE44RE5vRzBw?=
 =?iso-2022-jp?B?Y2xYS0ZUS0hCcmI5RFlaNnlJcGRKOVRQOG9yMG1ld3BiQzg2VEdTeVdt?=
 =?iso-2022-jp?B?bVhDK3BMNmc3M3lLYkxqWnhPZklQdXZPY3U3dDFMUU5pUTR0MVN4ak01?=
 =?iso-2022-jp?B?aU5ZSC85Szg1K29aK0N0ZCsrbEdmV1VGL0Jrd05zUGExeHZrWFJoelda?=
 =?iso-2022-jp?B?YzhXcHI0QjR4MFpHa3BkYVFIaDJQS2RDemdFdVlPNWJUWmtNdGFPSGIv?=
 =?iso-2022-jp?B?MnZ6SzJWMFRRcXp0MEk2SERkTzV2YjBMbC9yb0x5S0pmeEI2Vjh6OEJN?=
 =?iso-2022-jp?B?WE42MEg4Ty9xM2FrTE5HdkM5V0lmb2lVekhhZVc3RzNhdWlveHE4QkNj?=
 =?iso-2022-jp?B?UGhxdU9MU1RNZXUvZlNoeTlKaG1qaFU2Sm92bmRacTVhL0pGSU1EV2Fr?=
 =?iso-2022-jp?B?VWQyd2lXK1RpOFNxc2d4UjZWM3lNNTVlZHUwcjd1aHJkcWx2T1pua2RM?=
 =?iso-2022-jp?B?NzBDUVM0dFQ3RzBaYWdDN1UyZkNFckJYckZxc29hdDFVdlRCcFlLRVRo?=
 =?iso-2022-jp?B?L2V0c1dDNExHcVFCamRlQndYcGNlekErUHY0bHRMT1FoK0x0bURRdzdB?=
 =?iso-2022-jp?B?SXJnQ0RxZllsOGxtTkNyUGUyZ3JNUEJ6WXZ3ZzRnb0dDd0ZvNWE1VEQy?=
 =?iso-2022-jp?B?ZFJHa09jNmpNWERyRHJWa1NZTnJCUGE1UlR0NCtoSVJtR3lvc0NLZWFL?=
 =?iso-2022-jp?B?WmVGOC9iblFVV3BQRnpWTklZVUN3UHVZQjhXOVErQk5aTFB6bFJGaVRy?=
 =?iso-2022-jp?B?NXJ6S2pXQy9Md2gzemNUOUpwUjdjU1NBZkJNRWRwdTNpWVBKaTQxUnk4?=
 =?iso-2022-jp?B?T2lHS2ZqVGprOG9TMFZNQnpydUdIa09neHlZblh2YUZudHc4Wk9Xamx3?=
 =?iso-2022-jp?B?a0hwMTg5b05mWE5MSFZXbkJmdldjNnBmZTR2RW1GWjY1YlVlQ0RPV1dl?=
 =?iso-2022-jp?B?L0VqcWcwT0RhMVVNM2VIczM1OTJCbDhYS1F0d3loMjl5TkF0angxdXYy?=
 =?iso-2022-jp?B?RlJMQ1dtdnhjZkFOS3BWK0ZxL2lEekVOcnRZRWJ2bU5qZ2NBYjZoMWlN?=
 =?iso-2022-jp?B?ZlF3a2JBYTFNTjI3THFUV2ZLNE1KT01qaERWakxHeGJLR2hiazZ0VXB6?=
 =?iso-2022-jp?B?RDVtSkU0cnJkMnRNL3gyMDEySjRmeHhrRzZ3RThDNWJRbTEzUnBRWDZl?=
 =?iso-2022-jp?B?YzB0ZVh1bHlEbTlXWE4vMHZtY3lWNjR2ejJqb01IaUNQZFREOE5pUWpE?=
 =?iso-2022-jp?B?cGl4aGxKQ3ArdFFMU09SbGVzQm5TWlZna2JFVjBrdVFxWEQvU2xiazdT?=
 =?iso-2022-jp?B?L3A4VXMvdGF0WXhWZzhPL1ExK2dMRVA2eTdqejFwUTRqdjJqYUlCZnhy?=
 =?iso-2022-jp?B?M2FYOUVESUJZUFo3V0FOaHZEODJNOTgvYytkbjNHd29hbWtWR08xWEVs?=
 =?iso-2022-jp?B?ckRwSEVHaHpPNCsxU0ROdDBDV1dWcXB4TlYwalQxZTRUWXVLM1JUcVdz?=
 =?iso-2022-jp?B?NnJQVzJNRGNFSmp5eGtzeFREUHN3d1V1blo4L0xsdG5Tam9aMittQnJa?=
 =?iso-2022-jp?B?VkU5ZHZmMncxblVpay9ic3A1R2Y4L0xMbGk0RE5yQUY3emNHZDZ4Tm5V?=
 =?iso-2022-jp?B?RHpEajhnVEhFOEF0QU9NUmo5UjFpVjBJd2h6OHRCQzRmdHExeE9aMVJw?=
 =?iso-2022-jp?B?Y1YycHVNV3RJWkl6ZHgvZEpJVllPNHd2ZElIRndqWmFWNUR6bjNhOWJQ?=
 =?iso-2022-jp?B?WGI0aTFXajFWRzFOc2pjQ1hRNSt6OFNqdXNFaEhWT0hPVWN1YjJlNXNL?=
 =?iso-2022-jp?B?VWNHRTZqVmNmazFZRWwrUmZkK1BvWXhETy81ODNzR2VOZ3ExUmpIMHJR?=
 =?iso-2022-jp?B?MldNdll4b3RkckJsa1I4S3NoRitEUEpLaUdBaU9UdzA3TVhJYVBadXNa?=
 =?iso-2022-jp?B?QTI5ZFNqR3pIdVpFcFBJZHNKV3ljTHNMbzRIVlRVd3dPckt6ZnBpL2V5?=
 =?iso-2022-jp?B?QTB1dWY2OVZRQ0ZGTjVseHhvMGR2aXJIRkxWY3d5bkM5NmVza0txdXpo?=
 =?iso-2022-jp?B?ZG1YWnZSMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Iurey8eX3I/odLd9Mtx3BaTsq2QMG5K821Ll12WKBn75MEXbtIzDHo4bPleJg/VChv6hL8KsUSQZ+nAKUMv7s1RIixzcTLvv3d0llvNuDdmzXCQFFp8dNa0dxz4/S6TyevmOaUbLHJKuwG1lWXZ/7T2vkKXFAE3HU+Kr/ZvQNMDwEPUHSJ/EZkzIRtU18+B/VX0lbnQ8j4qxNsSXQsltPV2AnKI5DSuHUXMRb+dLrCuNc7ww5KHKlasaPGuV2q4sl06iZ8GYFCP7bKwGJCeaw2w5ctbFxZYyUzuNWSZYG5FH3dzIiqwC/3gcLqjoW/Un6wD3BeQmi+hOYmW8X0cCSQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031e3e48-05b7-4083-7a0b-08dedd3c33b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 21:59:36.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hsXPx+NZUljN1BvoGn4IZQeaGFl60dP7f/xhDCfMeeJi9Ol8iqngF/bLkOKu9Vezn8E+em7grvQBITvUfB+To4rKxQdUmBYEMC4asM1UoqOU80jbHEIgu42VaAKextB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 21:59:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23549

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Pavel Machek via lists.cip-project.org
> Sent: Saturday, July 4, 2026 6:13 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/4] Add PCIe support to RZ/V2N =
SoC
>=20
> Hi!
>=20
> > This patch series aims to add PCIe support to RZ/V2N SoC.
> > The driver patches have been already backported. All the patches have
> > been cherry-picked from upstream kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

I reviewed this series, looks good to me too.
I apply with Pavel's Reviewed-by tag, thanks!

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


