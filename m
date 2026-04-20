Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E9F5A8C7
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 21:31:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5151.1776720670319961330
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2026 14:31:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=WGaIIRDU;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776720666;x=1777930266;bh=rgVJ3vClIEso7hio44kxtWADcXNHcgyjN7LQ8
	nJ0Gnw=;b=WGaIIRDUUzekmoXR6zyAIj3Ca3sRdRj/9maFiUySrDgK85xvWL4CGyDtqqYChMUfwgv
	sNnZL0AgVKA3VrMxCbSFWH0xyWqqReiBvxadG6Q6ucUgkOMRjckyCoWlTBazbYe9OdVqHissIFJr1
	B9dN2x0z+7AbB2Pwqg9+YrcJ14GmEQktUpMPT7pcybzGGPxrBMEJ7VZLpKHiWGbfQaVenKmjZb/K/
	wYKGjiMwIAK0XZW/3OOhev9u/9ORmtwGxNzfa30Jyq+07+8KozX7bBNMGKloPYwiTcRbKTLpimBp8
	b0TH4Q9KwJRvXZJRS7yXku9+Nn9PMB5Z3m6OtfHw786A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 63KLV67G147351; Tue, 21 Apr 2026 06:31:06 +0900
X-Iguazu-Qid: 2yAbslxpJVNS7mZCsr
X-Iguazu-QSIG: v=2; s=0; t=1776720665; q=2yAbslxpJVNS7mZCsr; m=6GXkd7j/GGt4MDVYt4D8Aykbuv3siH8GSxMDuv6DFxY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fzzF54jmszyPQ; Tue, 21 Apr 2026 06:31:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4J13MkGhqDRZqNZtsvMYwTGtzkfY8A9cwbgI3IMqLkvQmXlaRxN+rREDSMg59Pvdgmsr+WnJ+4kDLdzwh/PTshxXWl4Pr9VuN3lEF2cLZ8SD3Yd7by5lkF9Sja8Qkp1P22ZtML+Q9eXtiLrx4206LeAXIJf8wpa4eS9GPLvlOrO5fv5tpEE6DodNQQ0KmHIGK0lLV1rxDcRtP2WJk+1OctsGB6yyyuq9Kys9Jf+kSAnG+5rcMkgPdtJ3ZoGKdiDPHH2WDia+G3cOYLSOOtadoon71c4ZtERq+apHDyl7/BfOLGpn2R3yLMP9L4SjzVPDmJ2LVGmi0z9rUkaP4vQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAJ5av9tLbjGcMp6JONu+k2lt38pBNyjp5d7lm27mCY=;
 b=Nqo5BXttKM484uVJIHwZkdSAw4PPjJqgWEYEs4rZmYqrlQBh62s5Ke+FI1uIbiRSRd5QStvgE2rYoIgC1ITiZmDgWlQIBXu8DCD7GqvgxFthTC/IPkQPDA04YK87PUJiw0FpgxqawN0lZDP/sGz2GbSPBCmKPCH9yVu1KMRVwsDVqZkfaKn1uFGmyZkDgyMexgUDuDgy3nAWmTTVaeQ7K54+jI1fFDc0bJ5YPFWqiLD54nhoju4V8GkbNKzkgUAsVuZgrSj1/uuOb2ke8PJV7lg3it0HWua7YxovASNrN9aUUbSt65Y0mSipbmuYoRO/cbTpJFwEDUEF6Fc7OrBqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <chris.brandt@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 1/7] drm: renesas: rz-du: Add
 atomic_pre_enable
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 1/7] drm: renesas: rz-du: Add
 atomic_pre_enable
Thread-Index: AQHcy2ly6MS9BwarPUSHe34CvuSuVLXiMGgAgAZSQ+A=
Date: Mon, 20 Apr 2026 21:31:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186B87FA6613FC1902B505CD2F2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260413171733.3088070-1-chris.brandt@renesas.com>
 <aeFNMOPdsv5EJ6rf@duo.ucw.cz>
In-Reply-To: <aeFNMOPdsv5EJ6rf@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB9313:EE_
x-ms-office365-filtering-correlation-id: 1775ba48-958f-4f45-fe98-08de9f241eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 tERXdpAd7fYRzVpz9BfDU7vSFXSqkYYcPpBzZ7G+kHQDLO97DGJnGmLrG1h581QLm2fEfQRLR7BWqvfEYhoWWXTrqZ2QIgMLdLQLyVQPFd7HqKDJ0cRAPbzUEYI1okF7Nm+1Ix9yilYC+5f4xUPSVfx0f0P1w2+n6h+DaZWXLFljujUaA2mlE6BNGU3Kjr0XKBKplYS11j6q54t6WwhRVAip5jVMxXpJPblCKHz9yQadmEP9ltSF26aBntoe3CHg4EQdve31WHWAD71CQxm2dO19TtG88dBi5WNlbmjn7NvEIxuVICoHq/VGRDBNntknMXTSw8LT2PHEHw2kw/gYGSqty7YdRcl3TUcqWrgS9O8SNGhR4oyD7GGXVtlhZOOTO0bmuGrN6aO9lsGoQyb11+WSz4u4K3yww611f4IQjmb1q2oku9V2VZFTzcje5gPK903q1agIEhF9hVvfXp1fdgmYy+o0Hsy8FVC9efty1BtwOWwQekORO1CMoubr000SOybj9ehDMoqOruo90ndKXsTx5udME2zvl3qU47wQ57ebK6l19MBtaLjwkuYU5OF+GfJL5G6osdZekhny3xkws7qjGG/EdOjasFtHIf4cKTrHfOuo20w8bsWMR6HgD/hE1QTsuEndjcGVua1tx7u95Sv2vWa2cPG8ifNe2asD2WKKX9QOiGzgl9gTKX4HIpTPQ6yZkMYE2tEJlabNb9/VDyMnn2HLcnPJYOQaifv1EO8Yu1e09rcmq2wX/EFOS71SwSZ1+AwRcBViOsMm76+EJOw+76dmtIspR+t+FiAyZqw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Uk03TCtRak9tTlBZcEQvb3AySzVSTWpzNW0zY2JuUEZDWTRCZTlodE8v?=
 =?iso-2022-jp?B?aDVLemFWdzluY0dNTHR4akNxdlB6Szhoa0J6NWRpUkFhNWZKdDFJQjVh?=
 =?iso-2022-jp?B?cnh5S1JhMENPSHJpZ3U0T2Q1Mk0yTUNqakdCWXBMWG53VHY5QWVVREh0?=
 =?iso-2022-jp?B?RUxJVmdBc2JLdVlucDQ1aFR6UUJObFBlbFZ3UnU1dXAybDhadGRkck9N?=
 =?iso-2022-jp?B?Zm84dEg0SmhRTWxzajJCZmF1TDgrcXBiUUk3VlpOZFF5MnZVc3o0a0Jq?=
 =?iso-2022-jp?B?OGN1dDVaYTBrSE4xV0NLQTZ1cm9ESVI1d2hnK2pheWFYQWczazBLdmVZ?=
 =?iso-2022-jp?B?QU1FZjRHWW9LS2YvUEY4c2hmV0dVWmhGOG5nNEdLQ2hNNms3dGFBc1BD?=
 =?iso-2022-jp?B?QXp4aVdPMGVyK0FwbWE1Q3Z6VW85b3hwOGpxZExSM0FTaGJUMGVwellO?=
 =?iso-2022-jp?B?YnkrSWo0M3F5b0NnWUNWMTNSQVIwUlZpdVpIUUx3TFpEVHRPNzB5d216?=
 =?iso-2022-jp?B?YTFpc2RVQTBHZWlESjJva1NrUkJTZkluRFFWV2srTUJKWlJKMC9uQlRt?=
 =?iso-2022-jp?B?ZkVjN3dvYW5rZ3lwRGVoR2VYOUxmYjA1VFNGdWltaXZnbW40SUlyUjFB?=
 =?iso-2022-jp?B?OUc4TGRDT2dYZEJyWWF0dldST2JnMVpodHZlNXdselhLRnFpWFo0QzRn?=
 =?iso-2022-jp?B?TFBNVFl2bm1MUmtTQXp0bWhWMG5YMDV3aWoraUN5ODlrMGVMaWRRME91?=
 =?iso-2022-jp?B?Z3dvSFpWWDRrWEVnSVZ3Si9oeFpVOURBR2JGUFFmRjc5dUp6VmpLK2lO?=
 =?iso-2022-jp?B?ZzdhdTE3U1hTclBJVm9sbWUweSs4MVV4WlI2NnRaZVNhRU4xajk0ZFBy?=
 =?iso-2022-jp?B?TTEzSktuTXRhTFpDUGIyRjd4QjkvN2RpeWVqbCsrZ1RKanFXRkRGQVA4?=
 =?iso-2022-jp?B?aGsrQlNtSzdadzJuWW81UjJUUzlkanRoekZPT2RCdGpTQWN1NXpDRjN3?=
 =?iso-2022-jp?B?VU1vT2pvVkIvZUtOTkwzNmJlam9DN3dWQlpMWmNOL0x6Qkh4MGhHdmpV?=
 =?iso-2022-jp?B?Q1FMZ3BSQ01jTldERTR0MkZUdUtxdGVxcXErZFhBdnFrc25pTnVlZ2hG?=
 =?iso-2022-jp?B?OWgzWk1vd2w4RFJjVFpYeU5ZMjRPaEFxNUgwUkF0NWxES0NKQkdwU2FU?=
 =?iso-2022-jp?B?S1QwREtENlZYM0ZOOFFTNkZBTmlQNEl3c1JwUFp3TnU0NVJyYVZUYWJ2?=
 =?iso-2022-jp?B?cHcrNVJzU1h0bFBCcXNtZEJnVFowY3A4ZG1NbWdSRGdKRW9QNXR0MDBZ?=
 =?iso-2022-jp?B?V0owVG1abUtNNnFHb0VtaFM1NloyTkdyKzExanBZRk9mWVlzSlpESVRJ?=
 =?iso-2022-jp?B?MXRXeDdpeXo5czVoVnZTWnpoRG9zYktxeURPelY1VXF3RU1UR1p1cVJh?=
 =?iso-2022-jp?B?WW82M3NwVXF3cEZNTkVqbWorbHdEeFJ6NFNqOWVXc3gvZGs0cFNpREZi?=
 =?iso-2022-jp?B?bVpTN1RKTlZiTDdhTU9NR1dubUVUYnQ0cU43dEFZdmMrVU5uYXBFYmNo?=
 =?iso-2022-jp?B?UFJ5RWhIdXVCS2w3VGxIclZabVBsaTY4YUh0dUtOSllLQmtZSC9TWEti?=
 =?iso-2022-jp?B?eVpReDV3NDQ1dWswVitPMmRUTU93L2MzOUx3T296RVNaWmJjSjBnM3Nv?=
 =?iso-2022-jp?B?NjFBdmZlYlhYbTRRTVAzbEcyRU5HTXB0S0RHUjNOK1o2VkIrQ2l6OTlM?=
 =?iso-2022-jp?B?M1FLSEFFREdHM3MvTkxBcDVhSE0zZ2FtM2hNVjIzOTg2UUx3bWNTbmQ0?=
 =?iso-2022-jp?B?Q2VjL1lDUTU0SklrUStYQ0d5eUFvRytjN3NDeEJjaStMM1cwQThDRGJU?=
 =?iso-2022-jp?B?ZWhqakM1T25hUkh6Szl1MVlZaDgzT2FoZ1E1cDZ4ZnRkNUpkcENPSWNH?=
 =?iso-2022-jp?B?TXMwVUlhK3crdzFVSGV5M2htekRzbXVrTTNSSjBsYTEwRTdiKy9oV1FU?=
 =?iso-2022-jp?B?aTNpdG90eHEwRGpSeDJYTEJEZFY3blkybnIzZEdXYVljbkxFbTVVVHZI?=
 =?iso-2022-jp?B?c1BxU1pDQS9JUzBLNmhTY3JRZkwvTnR3Unh6azZQNjJCR05qR0MweVNE?=
 =?iso-2022-jp?B?OEdsZW9GdVRrVTVvSDU3b0xCZEZHQ000YmwzVW0yK0RSR0xMckF0Zit6?=
 =?iso-2022-jp?B?dXpha1BINk8wUC8yWHB4cjNRNVcxaWFudXRlQ0V3VEF5Q3ZMQm5QdllU?=
 =?iso-2022-jp?B?dkFNZTdma1JwcGZmZmRuMXRZOUJzakFvSDZQb0FsVVFFTERSaEN1T0Mw?=
 =?iso-2022-jp?B?RS9rdWZKV0luMC96aU5FNC9zcERFSzk3QmtRMHkzZ25HOGtJQVRBdTBq?=
 =?iso-2022-jp?B?TGFnMWVIUEdHR1NEc2s0OUxYaDV6YTNJRWl3V1lrVHcvWEt1N2kzVndP?=
 =?iso-2022-jp?B?T0NXMHdia2d2a3ZFWWxjTGlQeFdLNVdaaVZJaFQ2SmhiZE1CRjlDR0NE?=
 =?iso-2022-jp?B?ZjYrMTVlTHhtcGFzZXc0dVprV0d0a01uVmxLeVdHQ0ZLRVlOQUNlejI5?=
 =?iso-2022-jp?B?eWtkTVhjWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ue8LwdGy2Rpckux8A2DBujB5IfBfxZhqyoEn4nv8E9aoalC1//10T44YZlrsWyU/kCeaJW23NPIeBJ6k7Exmo54niw99Qii8V0vfDb5DIOhwEmFUY3XsUTD8yHswgEyxy0fIiVTAwmumhMOfntyfTl6GojzvwAGjxjCtDKrRiJwZ5n//+EYGxStjj8F8SI+tRoCzvm702NLrEA7MSjlIPmGu9wQNvE0BLSO+NGi6WuTOg3WEo1cJqDTbGQjPjM4cQaecqhXU8m2x9CMDnrXMFGCSd3HU1miGW0YYCLfpv28kf7uc/nRWiDzFNwxXzWnAhMploYmHVHFO1pVWluLVew==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1775ba48-958f-4f45-fe98-08de9f241eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 21:31:01.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwJldwlUQDk6zEN961mMnskEQu0GkER3RKU6gphPzKJq34zs+GJbT+hGENPjSeb7u6Wb6V01JsuyLzzpsnhZ/y5/DPBqLx6XIOVrJkwW+svoa0e4MIdxU1d8nR35cjVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 21:31:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22772

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Friday, April 17, 2026 5:57 AM
> To: Chris Brandt <chris.brandt@renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 1/7] drm: renesas: rz-du: Add at=
omic_pre_enable
>=20
> Hi!
>=20
> > When drm_panel.prepare_prev_first is set to true in a panel driver,
> > the panel expects the MIPI DSI hardware to be already configured
> > before the panel's prepare function is called because it might need to
> > send DCS commands.
>=20
> For whole series: I had some minor comments here, but those should be fix=
ed in mainline, first, so they should not block
> the merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, It seems to be fine.
I will apply and push with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


