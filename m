Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE255C88E75
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 06:01:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5070.1789711263255217571
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 23:01:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=a9MtiXy0;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789711261;x=1790920861;bh=bECaSpCSTHlDD19DAuybuEeVUXYgqVp70aWb4
	mrE36E=;b=a9MtiXy0JgqkP0Rh98S54a6txOVZeHqWXVeIbotCSNJa6RGRlKXV1HpIifsAWSgv8no
	KM69q7kE09FZlgkx9CFGHyKFedvYFbUss825h0O4MGeY9RMz/tQ8CWs330xAynYb37XiEwYQpCK5C
	TlxYcaPJQgv2TjvUwGmXxRY+OalECD/aRhOXF/eqtVDjoMleRYzny/GAT2j5lZy9bZybaowVXSM4c
	xkQZsZfmZF7cNV63PX2RWMrogSBd3LQhWE9R6mo2ibxkOX031smfhouLTqu4ru4DFMU1g/4yN5iaW
	kJENGwLJfl6jtkX18KhA46gWZygWlNj2bwFO+QcDVdaQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 68I611ce1537280; Fri, 18 Sep 2026 15:01:01 +0900
X-Iguazu-Qid: 2yAaMsnyJHIM2GvAYd
X-Iguazu-QSIG: v=2; s=1; t=1789711261; q=2yAaMsnyJHIM2GvAYd; m=rQf7QGX55HUZoHoMh7VEVyvcWZhhqZ5taQ+jCWGYafE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMSF1ksvzyPj; Fri, 18 Sep 2026 15:01:01 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP0nLDLZl6xbelQzbmuL2v9tHckXtpMG6O5Q/NaXKBmGhhhA00JTws3YzofTQ3OZNhZk3i1AjtqmzkKKW0iLNagOgpoNVes+VrFgfgHuRyxkimgTT+ACH5iUxyQOss2lDQaE8BUWasHF9wkFb6AycTx1UY0/QbV8TFCJ+XBG99Yl6F7V0e3X7czmlrz9nchG8Clv2R55jFXsZqY1/Io5BynAuPvOEYMzRZjUBpfz5SsPQwXVZHiPI0MiDQw2HC115k46CGun6dOxnDGxZd/nd2HThbYMkDvs2xNaIIWOavAwht7pWWHj54z9RPNORuhy1eBeqjWUcAPAiVTJQRu/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhj9QNSZD/w0hRNvtf0+HWIev2jECqeHpugbyfblRSI=;
 b=g5oJUzlKjMBeypLcN6ABD4Z9j1EwCKnFv+Pbgzhy4cqnVdpw0L8dVmufJ+DgEAq8mN4Qd8g+PhjIu2EM78vmRwsOZfnVkgv4efhqf3+XRfMlSYPvoDRm9EXmqoHt69io6GGKNpaUQPORkhxtsNYcjUcV13HFPErnvQRumc7IbIMUkBZozUyVrLr3FwF1gWzghFEPXP8Tr+YPq7uj0tukzeL2BYr/Cbhf+XIFxII/ZGR8KpvVMyZIT9A2uulH80mAkcrDREiBO6GzXcTxEbkDcfuzy68iKV6yUE+ty7+AcfOQVxHxnumbNFYkkNZt0KcyKDXvqsep3GeaBeclJ7ZlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for RZ/V2H
 and RZ/V2N
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for RZ/V2H
 and RZ/V2N
Thread-Index: AQHdQ54dYkJtuHLN5U6sjva/iIpBybbNllcggABnOYCABeFKYA==
Date: Fri, 18 Sep 2026 06:00:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818FADC93A5E97926DD80DFCD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818DE7C584C2C09A6AE14B6CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aqfk0-jrU-TFz7rL@duo.ucw.cz>
In-Reply-To: <aqfk0-jrU-TFz7rL@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY5PR01MB18383:EE_
x-ms-office365-filtering-correlation-id: d1aad9d4-dcee-4730-6635-08df154a3556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 
 pFaL/4jCoXObewiBZ23PZniGBWpwT25CTeE2vl+J/J2F44o+EkXEwJSaCiXka4FKuVkMPdwNEs9SIANabqnMhma3+e2TCm5Jnr9riy1CKJ8EdTcEcHxCFsbfZfvhDP93L9/VfOc+2qNvaGvLo8w2XJdA9Xds3cWRsb3+g5NQXtrqgT/uE30d3Lxgs4adsIkQ/X81Hp50FHb2WLTLNOnFXZ0txXAr92F3QxudOXYXeUvqB2Pi3MPSf69jk5joR+i8Q1epCVGMZx3+78o9vX7q0kUFbFMO+0Q/6ozemABXKduSU7bMRtRhLOdozkIWIPe/7puT7zkUynZPhKcpBuQuaivwa7WLycvPOGOnxd9yBGfT+CdDkbzbU0lNijed3EqbA8ncf9m+4o+4DGPdetNho/HuPd9JUjQqzefgwHRJN+3lZzYjXL8GEwAZfxi0zSn+ERmJX2WnAIr8aGsdbyyqprNllIen5quNYmNizxCpbOV7l1VQ1oqncX4GWfWPYkaukgByXN6pV0ZNDnhUa5LtDPuAbG8//u0yQDbbikKcsgZMuUylSeHeQZivlNvR6XgAO03aOXv2Co98izVwRzoANO47SA7LDwr0PMAtvgkmgr1nJNwSLpPRkOAEy4FrdpFLWcep3mgBKiheJyLNXSKzGta78A2Y2+5mDWjVoNlW+npVFprX86LXPkBMb96gRsTXSaK+founJmZY342QgUxMoKCX0JANJMk4rrS2/8zKgMc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WmVqQTg4NHZmNWxCOUNMU3VKZTlTZVZITzVMQVN6N2JBS3d5WW9XUzBK?=
 =?iso-2022-jp?B?cC9VRlBwTndSKytMV3MyRFVuT0prNGYzZEMrZ3F0WXFYenhlQmlucmlG?=
 =?iso-2022-jp?B?dkhyMlZ3WCs4M2Q4WUtjYTFlZU9VaHBKNWQ3bEI2UGJURk1hQ3RoQzZa?=
 =?iso-2022-jp?B?b2VoN0RaQ0RGZUl5Ym5UYnBLaFpPV0RrN1JPOEgwdEhuaVNaYVRaZjRh?=
 =?iso-2022-jp?B?ZEhnQWpNUG5QOUFWbTFiSDNwekRnbVVvekFOS1VZdHVTcXl5U01xZ0FN?=
 =?iso-2022-jp?B?YmZKK0F1ZXorejVHemk0STJEdmlyRWgxSW02b1dLVW4yWGgxd0RBWGlT?=
 =?iso-2022-jp?B?T0JmQzNselFYOGdnQldnMjZQS3BLTVFDams5T2hiSWtZak9MQk9ZbUVE?=
 =?iso-2022-jp?B?UHpxV3AveEtNeHhDOTAvVU9qYmJxcGF1UGxuMks5cFFpNHZKRkhSWlBC?=
 =?iso-2022-jp?B?NnVGaytWREtwMmRFZXVPQ3l1ZnQ5bStsL1cwZFk5Y0dDRGxTZnN6MUNU?=
 =?iso-2022-jp?B?bUZxMUZKWE8wSzRkbjRVaHoxUGdKbk4wQlEvMGtNdnZia242ajVEeXpw?=
 =?iso-2022-jp?B?TCsvcUYzcm1DWVBPNUk3b1E5Z1lFL2llQ2htNDJBQ0RwclZMVC84YXVR?=
 =?iso-2022-jp?B?YzhCWWpCa0F4YVZrWWI3OWZORHVsaXE1bUFveU8xdHVTUXpFU0Q0dzYw?=
 =?iso-2022-jp?B?S3c1N2JKT3hTai9hTmtJekNuUjd3aTgveElrWG84QUR5NjNtS1RIUEQx?=
 =?iso-2022-jp?B?RldldTNSc0Q0ZEJWTGxmWEVaNUVhSDZ0Vy9TSTVjamFVaWlDZlpMSEUz?=
 =?iso-2022-jp?B?VXhDMTBvc2NUbW94b3lIdWpXS2Y5STJZL0NCR2UwbFA3ZmJUNVFHWW5a?=
 =?iso-2022-jp?B?OVNXbnRZc2krWEN0NWhQVlF0SzlEWFA4OTVidERjMko1MnFzMXY2UVA1?=
 =?iso-2022-jp?B?NlcwaFJjYmJCSHlUQW00OXRMYVQ1UWk3aWJzWXZFMHpGTWVSY3c4Z2tL?=
 =?iso-2022-jp?B?eG9ZMDQ0OTVlU29uNW9CNlc0aUwybnNsZDlkWm55M2RWUDJkeko4U21Z?=
 =?iso-2022-jp?B?UENsVk5MazluVnJkQU1IUndPVUhQNE5FM0E0NjMzait1Qnp4dlBZWW5x?=
 =?iso-2022-jp?B?NDBLQWdSZHYxT29aUnhNWXBzSkl5OFR0U2tXV2pkZHhOSko5YWNPMHJx?=
 =?iso-2022-jp?B?NTNqUVpXUFhYNkU1eWxxdTFVTllDUDh4aEcvbS80L0xkaEQ0S1RkclBj?=
 =?iso-2022-jp?B?ZVJSUFpSNTFMam9qTzBoK2QzSFB4T2txcG9BOVNBWVBPdU5XUDB0WnRp?=
 =?iso-2022-jp?B?aFhNNjczN0M0SXp4eldNcnhVMktNekVCMDgzNTVTemdjVFhSb1hSQVAv?=
 =?iso-2022-jp?B?Sm9jUkQ0amdaOXQydkZNN3dlNnF6dzdpWEN3clVGMHRic1hLL0R4MEtZ?=
 =?iso-2022-jp?B?MW5rT09GY1ViSnl6cG4yWUswREpsKzVQU1hlRDlZM005dk92dGMxdTky?=
 =?iso-2022-jp?B?S3lTdDdqZG00RmkvVlphT1dGbGVkSkN2QnJyVUlueGt3S3BqVTVVamUy?=
 =?iso-2022-jp?B?VG1NZ2RuOS9HdTB2VVZPd3lLMElEZzRNY09WbS9KWkVDem00Y2FjZjJl?=
 =?iso-2022-jp?B?ZzRmZHA2d3d2R083RVVZUXAwV2RybDBCYVgrdC8xN0hhMlYzN0dGV1hR?=
 =?iso-2022-jp?B?UmM0OG9yclR4eXhnQlZrcmNuNGd6bkFaR0EwVVNFb2hrblVMSUFWVEM1?=
 =?iso-2022-jp?B?V1hiOTNNWXhzK1lkeExaanYrU1h3Ri9IdzhsWUp3bzYrbDAreDFDdXhm?=
 =?iso-2022-jp?B?RDU3eER5U0RyTzZkR2IzcHJXS0xaWW9YUE1heXd2MDJDdXQ4dTVHRVhX?=
 =?iso-2022-jp?B?bU82ckxCbGtiLzUvQTRRc2xyODUxN0RFK2xRRG1zODlXYVp0Ulg2eXQ3?=
 =?iso-2022-jp?B?U1YxVGpLODZBZUtxWlFpc3FFbXk0d2FscFZzNG9QRlNVVkMvVURQWGs5?=
 =?iso-2022-jp?B?dDFpNjZvdkpBWTNPRmdVY2ZuNDJ0LzZRSkhvcVVJeDdscjRvYW9rc2p0?=
 =?iso-2022-jp?B?UGZHZXdSbUovUWh1QTV6dlk5REN6ZmMveWpKUEFGWXpyeUsvNUR3U2Vp?=
 =?iso-2022-jp?B?enUxNkFtRGtrdG9QZzQ2eDVKYkxyaUZrT1ZlOHh5L0hjQU1EVkNqZWk1?=
 =?iso-2022-jp?B?czFjbVZYL2p4T3hyZjE2UlFSQWl3ZlBSWlJ0OU9tM1ZadmUyc1lUS3kz?=
 =?iso-2022-jp?B?TGh2emliclNTM2pJVjR6VW5sTVdweWMwb1FrVUpyS3NWZHdEazBwSWgr?=
 =?iso-2022-jp?B?My9EdGxVazN3RUxXOGo5d3RCVC9wMVI2YkpmTEIxZUh2Y2hmWjA4Vksw?=
 =?iso-2022-jp?B?cVdwcFJiS3QxaStiM0ZqZndEY2tTMmpnNlQyV1B2aUpDaVQxSDBVc1l6?=
 =?iso-2022-jp?B?RG9NM2pkKzN5ZHFUTmhLdEVjSDFCV3JyWHIxYjZFQThCckRXa0VyTUJv?=
 =?iso-2022-jp?B?UFA2OWU5ZEFURmNqamd3aHc2WXVTeG9pNTF5aFVBVDM4YUl3TnVqQ2hW?=
 =?iso-2022-jp?B?UWdMdG9XVT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	snyTTfG7/ebAAcFDdf0td0ykSgjFr4pu0OJuTABvduQO+xDLA0Dr7v9lTq10ELlpR1fb8Vc/Wio26XvKyp2x1Vz/GmTCi+apa/Upz8yPdT6IPFR+Ze6hms5hQ+HD5cctrmFNQvVmMSzjQheH9vHu4N6NOyNx0M5wtFVCLZ7uqAogcoHkVcJo2GLUpuzF5Hqy0CJYh34DlJfyDttKyqrdVWUH5OnCcFCEez9sqFbX+GnAy6M73vzayR3zmN3nTh17rz9s72KF5UCtjqBjt6IQUv+hiMcgjXMYiPZjzfeylOmsafNn/GrX8ZteJXIskiTuDGnspiz95ihCfacYVuJH+Q==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aad9d4-dcee-4730-6635-08df154a3556
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:00:57.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmLXS8UnNEhqDobPuFFtyOeUs4NWhpAn6WGl586+RRYYMi9TZ5oVVb/yww+S9EXSrWnIyaULRN4sayi4p6uQTxRm2yNemjcmYRCMTkYaVUnCkgNfLzR+6RqgsdZ5y+ON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18383
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 06:01:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24232

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, September 14, 2026 9:13 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: ovidiu.panait.rb@renesas.com; cip-dev@lists.cip-project.org;
> pavel@nabladev.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for
> RZ/V2H and RZ/V2N
>=20
> Hi!
>=20
> > >
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
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284575090=
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


