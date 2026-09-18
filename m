Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FEFC88E75
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 05:57:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5062.1789711019263400776
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 22:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=JtAWUF7b;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789711017;x=1790920617;bh=u0uGx59IdLhasEo0pZG0scJiD70wOgp05JHAW
	SY69jc=;b=JtAWUF7bOsPgIokoYzFPjW+Kmcpg8uYl04NI795T9W14/odovJqTjt0yeJq1q72A7ft
	+zteMbn7lFC2T4SlFqJClcnnGd+BF2ujBCkbJSidy8Fpusk2dwsqqBWxUIflxASJ5iByILREkRDXw
	33xUaMAuz3hPkhexjvoVBGpbVlUADhi9mO/KBS2cJIqZ45CGEzEMqPBR7aRwbydX1KekXsTp4ktQ/
	Juj8/CTav7mAE3BBw6WORhcpdNuPYzjVfZphxKqz+ZvDh63+Ms4KztejSFj3iwGTq/yYssCiHIOKU
	Mf0l96GshlfwGkEDPQXGc3ccIDUzXCvj6KDGMBdcQyqA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 68I5uut21522511; Fri, 18 Sep 2026 14:56:57 +0900
X-Iguazu-Qid: 2yAaMsnyJHI3Vfw7t2
X-Iguazu-QSIG: v=2; s=1; t=1789711016; q=2yAaMsnyJHI3Vfw7t2; m=UzmsPlnbTFz8loWu5gAYaMsqe925ITBPmtU7wn9pUYY=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMMX1zqtzyPZ; Fri, 18 Sep 2026 14:56:56 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngBtKf3iyQdnY3W6Qxv2xOHiVdpQ+vOb5gLrbKRzzARZOPXQzc6tUN5ntBVdf20Lqz42+Zaxnv8ecP2P93Q7llni250nwvIdUxNTUA8ygEBBREDEgIzM/hJFI0m4EQeYkQbGnTrh+JqmZEuO1ki334SZQkXn/ZuxyV7YF5th/TLnnD1xQqjFjx4hc++8Kfls/z8VCCnlK1vUrxCrN/sriHDTTgEquuxD1alht210BotqDBtOWZxB1rLvbP0Pb47LWvrcpmHwtUNEa0UFCIbdpEON7Li38nc5sOBivfpEVGxtLohR3u/+q7SfzuoN21AxhXSNyYrQN1h/ml53PThLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qARPm7j/Bbivzfkxp9mUdIt+EL4duKqtv3qB60u0H+A=;
 b=ffvcg0xwMLPb7JNUryuOH5Ht7Eqgi20U5+GoSeIaL9thSmDOFa8AUhT4bvtSdNlM9i1wrWDggIH0fdjp8Fgj5T9jUpYrylI+romXc4FQZEZFoEedf4/ayJIw6PzR7zScXpQAj/q0jy1W66BxjIMqiA6Hw7xkFstAd+fkkKox+QRW16tYfmOrxoCOT6qidJAult0S1YAIbc+W1a4pFJH1SILnkx43+p8E5JFfQIL6sG3tlo06ROuXtgM4aNI9hSJiLzPkpG0v2WyR94GQmYhAU+szFzY+Tz0fM2X6XwKpkfMUNMwmYFJlTF8vlmxZ4b/EM9p3wU8Dd17y2daF9tuLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <claudiu.beznea@tuxon.dev>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi: Backport
 support for RZ/G2{E,N}
Thread-Topic: [cip-dev] [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi:
 Backport support for RZ/G2{E,N}
Thread-Index: AQHdQfZDJob54k08uUeeN1lHrp5PpbbNmetwgABlwACABeFHgA==
Date: Fri, 18 Sep 2026 05:56:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E0E11201189396DB2AA3CD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260911140251.2119701-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB14818F25644168ABE36216676CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aqfj0P_vp5Nx4qYM@duo.ucw.cz>
In-Reply-To: <aqfj0P_vp5Nx4qYM@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB15189:EE_
x-ms-office365-filtering-correlation-id: cdca9b4a-7349-4e64-6a2b-08df1549a365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: 
 a+Zr26siV98vjsndfK5xhS3CqsKf0Zk723kve2uULIOE0aGHcQB5veLSnZxddSSGl8nhU7HdzswHYr9e5e8RmO5ZbOZD8SxfTH56zCzlVPrUi0FINE9KS1WofiBYF66k/es25R8oDfyjCCP/I1rlPBBeaNZ8YtUKEbRkXVIi3xyviaf2WQsL+oq3JheO0FpUC0c1Fj9TFZUEiHKIIO/8xP8GP3gfg4XnwLAwb2IF85Azm5qCd1D1B2TekM5BZcL1RJYDmoqB4BLwTRsCuRnyXBwcvERfNQbTJZGIzqzwLiSUyCOyjBxH7sIWgWsMB7V0/pusbxbuTyqhuHFyS/K4osMsvG7bHadS+LoY4UMrURNWSrQbn7p3BCaniz5cIC1hwC4l40VC2JO47FewXCPONRTHcVj9rm8u8i1jIRABX4SvfECFTnYMDqwCK3CXwV6OCAkT1ziOdJV59X7Os2k97W6f5SIeS8pEutsN9yY6Py9sZorigxLne3zwC4sGqHofM8wrWeEYsOHnlaErVbRGLjL6sTV7OrLjq1sOcC28T8bbi+eHS3MZAveoXmWhQCEPRv1lqbBIThTPWfptbieg1bjg97zI5uYxu35eZg6KodPjwXR9DhCPVY+K9pYPTDCq/QYDNqZxPApZ52yJjufCVfEDPMaE0YrJSoLJJx9ZJ6yicenVzXaWKb3HJ/j2DCfD6yzgH6eZJGG/XnzD7poz8mV1W5W/u71o2c2f7MjBzA0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZnpCdDJkS2RrWTd4TVlsamN1bmdqcjh3Lzh6dEF1M0YvZlYrNzY5MG1u?=
 =?iso-2022-jp?B?VUpGNGZqbEd2dnNsd2tmWm1LVlRjNjBsSDAvUG1JaHViN1RxSWZTTzdM?=
 =?iso-2022-jp?B?NFNSWEZKRkxkemlZTXV5UEhZWmt1YWxpSGNnOGhmR3B5QVV3L3ZaN2xx?=
 =?iso-2022-jp?B?c3hETG1lcHNIcHVmSXVGc245M081UklxT2EwSHF2L2R1ZEQ0RmlMdnY5?=
 =?iso-2022-jp?B?ZDRib25ldmg3NmJkU2w4MmthWEJ3eW1IOS9zY3VKckZud1gyTG83bjc3?=
 =?iso-2022-jp?B?WmlpQTFxZ2JndWxtT2VwWEpxb3ZULzR6OTB0VHRKQi9UaHI2dlB0RTJh?=
 =?iso-2022-jp?B?K2pCQXc2cGFDUGwyenJKaExnZlduRXIyVjU2Rm9jNGJCZzl4TVYyRDVL?=
 =?iso-2022-jp?B?RXdUZ3dmNWM3NGx0c3pSZ2JoZG9DclNxM0Q1TTRCNkwwUTA0cEtRTHdi?=
 =?iso-2022-jp?B?MkFBUHZPSkM1WVFiSWE4UE1ZM3Z6WC9WSFZCbFBuSitIb3VYTFllMW4r?=
 =?iso-2022-jp?B?MEs5S05UZHcyRlVrd3BOZ2Q0Ykh3VzFEQ3BJTUZMbGRRYlFiRlBDTWlB?=
 =?iso-2022-jp?B?QXMwL3BBS29nYUVwOTNDMUVxQmgxMktRb3J4NkNZM2FVTjNOTGNjTnNE?=
 =?iso-2022-jp?B?c1BFVXNZUnFmbmdvWFdXSmdwemNaTzRjQlRBWGQxVVZLNDRlcktVL0F2?=
 =?iso-2022-jp?B?UTBlYjhOL2JDbFJaWUZNTC9qMUY2WUFuK0VDSW9NRnZaK3ViRUoxeHZa?=
 =?iso-2022-jp?B?bUgzVDFyRm9DWGFsa3RaZjNERG50Wm5BbFZZVXM1czZ6cnByQjRlUnRR?=
 =?iso-2022-jp?B?Q0FmSFRjak9rZ05FaEFxUGVSSWVIZngzMGVwWHJNS3IxRzU1QmVMdHcy?=
 =?iso-2022-jp?B?emhLRDdxa2FIT0hzaEV6N1NyMHZuS3hJUW5xV2NyeUNIeENZQXdiSmE2?=
 =?iso-2022-jp?B?Z1JGVmYzUzRBaXVEMjQwVE1JdDkraklBdDJCSW9ySG04N3owSFdUWTBP?=
 =?iso-2022-jp?B?OUJReVRLWXBQNGZhVkMxWko2YzNGSWN6T0JiNnpZQ1JraXo0UzJqY1lY?=
 =?iso-2022-jp?B?R0VwaVRxbHRnYUhFOGdMenBMbDQ0TXlpbFBQUTdTM1RxNmRsNlpRQWM5?=
 =?iso-2022-jp?B?c041SHdVby9uMUZhZ0NzMFdFSnJHVm1DOE9HWjM0M1p6RU44RTVjM1lG?=
 =?iso-2022-jp?B?clBBSjFwOHVENHRYZ1hXaStzSHdHR3JRbjg3MDh0Z0s1QXZkcDIwV0hX?=
 =?iso-2022-jp?B?SXFyZkJSb0NWQzFLZmVLMHFFZFIrVjV3K1NNaXY5Q3l6NXBZYndBWWZH?=
 =?iso-2022-jp?B?aXo1ODIxeDd2MG1vOUViSHJUb25hZVRPaVlBZmprVktWVlg3YUNoU3FT?=
 =?iso-2022-jp?B?S2d0cGwvN2pWdk9QOXNiZlNxRVRTNyt3KzVaMHFmYlF2VVFrOUwvUklO?=
 =?iso-2022-jp?B?QWRJMStvU0lINmh0M0FNV2xKOGFBcSszT2Z2V2JVdHdrOUJBTEVyM0Yr?=
 =?iso-2022-jp?B?Q0RPc29oTGYvWWU1UmNKc2pMd3JGUCtaU2FEelVoY0E2SzhjM2dIaGY3?=
 =?iso-2022-jp?B?UlJXRXpianJWaGhPTlVRZHNjWXdDT2swZ2J6YUhDZkVFM05EMk9nbDdR?=
 =?iso-2022-jp?B?VHRiRVg1dnR6enBRemhhaTJBUzdJSUw3WDRpMmx4YTN5VU81Q1ZJdVFW?=
 =?iso-2022-jp?B?b010U0thVU5KSHk1VGJ6VG1LSUVReU9ETHQ5NHNPRC9yK1JWYSt2Tk1I?=
 =?iso-2022-jp?B?YytUTDRqdXJYS2tEQUZ6SmZvL1BVc3ZOTWZFRFlhMHhRcUFtMGFLMHlB?=
 =?iso-2022-jp?B?OVZXdVhzMDFHSWhvOVFQYkdXajMrVEU5K0w1RGU4UFdmTlBIdXFMNU1Y?=
 =?iso-2022-jp?B?eEJtU1AwL0FrRmlOWGhSSWtuYVhia0NBM09tT3ViWW9iNmxHYmh5Z3BI?=
 =?iso-2022-jp?B?b3h2RnZZM1hteFNZM3ZpRm5wNExYd2l1OGtNQ3dlTGFQUWNCYkxIQ1JJ?=
 =?iso-2022-jp?B?L3pZNkk5eGNZdEhOMURJanYyL2ErdTZuVmVuOVgvVGpKRDRtSWphTTFG?=
 =?iso-2022-jp?B?UDdxVU1kN2tjZ3ZQTXNYRjYyZlRES05RRVBLd0xNOHA1dTFZRWkzQ08v?=
 =?iso-2022-jp?B?NFdkQ1dXbWtKK2R5Tkd6ak5NNjByZEI3Mi9iY2NqQTNYRGt5RE5WNzFE?=
 =?iso-2022-jp?B?ODladTk3U2loakpnVjBrN2MxV0lTaTExYjlvR3NXcTFXM0h1ZkFnK2Z3?=
 =?iso-2022-jp?B?VlZKYzY4MjY1UWp4YXp2RnhxTDZlNlZOZDBVT1RidjdEZzBlWkFXaGJD?=
 =?iso-2022-jp?B?ZWZIbmVoeVZGUU9vc0VoOTA0a2ozRElqMkdhak1wUWVuL0c2d3poS295?=
 =?iso-2022-jp?B?dGNjRmVMcG1jdEgvNGRVNEFPc3NJZE42czhmTGFjZnpRc29ya0ZiSnRp?=
 =?iso-2022-jp?B?cGxOZ1RDd2k1dFlKZ2c5N2J2dHpVUUtXZ0xhL24wOTFCMTlZK2txbG9s?=
 =?iso-2022-jp?B?bnRxT0h0ZlpmWTZocllhU2I1ckFRaU5lODFTcTdKMHJCOWhJQmREZXJE?=
 =?iso-2022-jp?B?MTV5L1BMaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	reMUEzsq01Z3GNdbZ43zsd7J4OcN5sDSVbGOZqfpY3vfRc41UaQGWttnY5+iFEFjGKF+lyidvUmixQy9Q3u1OPmDWUPyigspqVN70dxV61Y7HKz2CwKvj31Aj0PsczX1zmfOe2GWq1jKfpNRsviVrPiZgASBldgeixzHv2wyZjF7I4pbRDQLcnj+FZMMKXm/G8eY+J8CjvFuOceey4dk8cHvImPZrx9g0vd/P4xyuZsMrQ+MtXHOjdHuX4jBY+RWrLzw1d3dDTv3aulTZViP9ox8Ji7CyksSAqwJqjH773GsRASJSuSS5qLhQ8Z5Vyc/y0P8pt7SR5MNwwrTo1P/0A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdca9b4a-7349-4e64-6a2b-08df1549a365
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 05:56:52.7614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgaHFzCsslHzVur1K4oOoN6gRODi4gSayRBEjK66NYNEGByO+HlVNWlijcDM5NPh/hEN9gR+8YLBlkaPI582wsN/DHHqQPVG3pdXeV9DmUb7PmBF6195VZ+Z1vSijNKH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15189
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 05:57:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24229

H all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, September 14, 2026 9:09 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: claudiu.beznea@tuxon.dev; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi:
> Backport support for RZ/G2{E,N}
>=20
> Hi!
>=20
> > > Series backport patches to enable SDHI for RZ/G2{E,N} though their
> > > own compatibles.
> > >
> > > Thank you,
> > > Claudiu
> > >
> > > Lad Prabhakar (2):
> > >   mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
> > >   mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
> > >
> > >  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > I reviewed this series, looks good to me.
> > I can apply this if tests are OK and there are no other comments.
> >   Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284574
> > 9371
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> This looks okay to me.
>=20
Applied, thanks.

Best regards,
  Nobuhiro


