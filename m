Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC15EF48D3
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 06:19:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65909.1770963569094807589
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 22:19:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=l/nTGS8d;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1770963566;x=1772173166;bh=M5FiZSiuftfvM1O2btBcxNlqSPdvMLsJNmi4b
	1TJOg0=;b=l/nTGS8dj8Z6EawZkxVlYOqcocQYXlBcfVTwHuAAnMHJo7PzL3su4KgrNE0vdHrWCfG
	x7Wd6x6MGOHQGwMetzmsn+6NY5bsia+KB46WXLDKK2OO7Mko17uS7AN3hsN9cKaiebtl7LJIPPT9O
	uM8WA1G8n50v2/O+DnXMkGTnid6xiUEIrkPqRphug+xPSmvZa50h2mqwog15eGtGzWNVyCh+lkkDF
	PPhcxha4vImhWsvPRb8hz+QFKGbHY50nGKCY0YASTLxl0GHPeGaVkq6eJfH+w1rNPqnblmHzEtjHe
	yXWEkcd7Re5ORQzmJY0WaNC+PqAnIWP4YjuGUG2ZUfxg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 61D6JQYi2041382; Fri, 13 Feb 2026 15:19:26 +0900
X-Iguazu-Qid: 2yAb9zgpPB58qmi41I
X-Iguazu-QSIG: v=2; s=0; t=1770963566; q=2yAb9zgpPB58qmi41I; m=5bYwbOuqqwstRxawm2Z0nEnXuGcX8ChNGFZVdPPK0UI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fC27d6JC5z1xnZ; Fri, 13 Feb 2026 15:19:25 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfBycxqq49fIFHNat7pTFrZ2GUB5PCOVfYDK0bl2eWudwIplkfz0KrpH0Qb5mW2m90ysbnXZgel1kBP4iFnSrfY82uthawMH8IbO8o0F+2T0Fex40s0pB81y3dD4E2kkYUaaZ5f84CXzeUm+chxZE0CQsLAnCsM0Q17lcceY/undT6EUQN9OSHipanwyS0cO7A7QHIKI3XUkvmCYbIfj4vj5GBcjNA01YjGN8g3yvdxh6FkpuZ2XeaI8PB6ua/rJf2194zlOkbMXYfOqc9lr5ZSJXK5WEm7MgAW2NF9ZTR6B2z/X0XSNJne/3wu5GQ+pSs85Fuwmkz9khzK6dFlPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5FiZSiuftfvM1O2btBcxNlqSPdvMLsJNmi4b1TJOg0=;
 b=MWwHXyHh5/zX6jKUaI8V671muaHz7bvYO0GL2gLai0ik18MkeTUvXKw4kaNMtvrxk/FVqgS+hSeVkrJq5gGf4wMm3paOfiQtI4cM68ZQcZE8aR6ch8Q841egGhVaGu0EUBOhIkPnmDIjpfpt5igAqGroyN2MlGGh/XNYoJRerrwnJ1oBBHrcUsNFE23+j26n6RWWmav3v+VwFfUokv1dt6OMAdkm6rbrC230kjSD5ZKrD23YP22tvYqGNqQQ4PdmoA4io5TIvLrRnawqD55/q/zVZuO42KYttPmNYXtlk42mW11ez+ywVOUF0kDDIlnsW683epf4Si4JdhbEnfu9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <s-adivi@ti.com>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 0/9] Add support for BeagleV-Fire
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 0/9] Add support for
 BeagleV-Fire
Thread-Index: AQHclEOWJ5Pc4Wjmi0GSSe/5jaNZIrV7a2AwgAA3uYCAAJmygIAD+zzw
Date: Fri, 13 Feb 2026 06:19:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185922992D6835B65DFAD6CD61A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
 <TY7PR01MB14818C90B18581467313DC36DCD62A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <4db81fef-2a03-4880-8c04-1de20c00da7b@siemens.com>
 <1e646870-4580-4fae-bced-9d7629373384@siemens.com>
In-Reply-To: <1e646870-4580-4fae-bced-9d7629373384@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB15577:EE_
x-ms-office365-filtering-correlation-id: eccbc389-a28f-41d4-6155-08de6ac7d384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YldETXZVS29xMksrTlNSdXNHTEFXS2dlY1l4OVRxSWYrYkxSUDhnYjdDVlR2?=
 =?utf-8?B?ZVpqaUNRc1dmUTQzSXNwNzBsWjA1T2pLSER1aEVGeGgxZ2tobzFrclU3a3dD?=
 =?utf-8?B?MlZrSmVreGQyT0ZwQVBOSDgzMFNUY1c5ZlA3RFRsRm8yRHI3aXM4SytuczI4?=
 =?utf-8?B?ZHJlY29MdFRRSnpOT0U1K01Rd1VNL3FqUjBXNUdjejBnT2F1NTdpbDlGNzJv?=
 =?utf-8?B?K1dQaGU3QlpTVS9Pd09xU0NnVmZzdndwRVc4QWllQjVtL2d6TEhRWXJvaTYz?=
 =?utf-8?B?dGw2Y2w5c3FwN01xTzF6dEErSUV0MDFNSUpxTTBWRVNNSXVVWi9UQjdsQVNr?=
 =?utf-8?B?OE9MVVV5dEg5dU91NHNyQ0lwQ2wxRlRFNjVlZFk4V0JpVWpzd0Raa1NvWkRu?=
 =?utf-8?B?a25GbHFhRThBOXY1OFdKMjdROGlBV0ZjN3RHeFF1ZlgrOFoveHluNFJhbmpp?=
 =?utf-8?B?b0NyRDdwRzJxaFV6UksySDY5dVhicEppWWFkK2tPeFdsbjVpUXduSytocmNT?=
 =?utf-8?B?K0NPWDdrSDExRHJlV2hvaExuT0pvS3pEeVFUVDNneW14WGdjellFU1NudjFO?=
 =?utf-8?B?Y3JEMEcvbFEza2hmcXAvdU55M2tWb1RZaTBmKzRqTk1XZmlWZ2JGY1RWTndN?=
 =?utf-8?B?UmFtblVXUVNKNWxDdjBibGhONHBRWXYzWHJodVdlRGM3cGRUSHYycS9kdm52?=
 =?utf-8?B?TjcrQVp3VUJubUN6OVhlTlNEbCtXSTNIUWpkQ1h1N0JGNlBrS29KTkV0MzQv?=
 =?utf-8?B?S0gzNmgwNnJobjROdHhUU2RKd3VWU0FrQk5oQ1ZPWnlGbjNKNGJwN3plL2hG?=
 =?utf-8?B?Ym1La05iRjNBSU5GZmFXWC8xRkVNWit1Zng3aXBxakVzSFhqQ3JlMDNxMlBq?=
 =?utf-8?B?eGVwcnhsdDVYeDFCV2RpMllLSXpROWhBMHlUMzFDQTFzTDdiakhZVUQvbldk?=
 =?utf-8?B?dG1GdFdSNm1JZ3dZUVFxekFBU1pUUFBqOGFPT3pDOWhtM3JWTmo0WEwyOVRh?=
 =?utf-8?B?bThYQml2Q0gwMlRrVjY1RURnYW9kL0hPT1JIenFXM2RTKzJLREdxVlJYSy9k?=
 =?utf-8?B?TVJsaE9EcXdEN0lTc3ZXWExmWllaQ2pFdkg5TzZXeldzNTRwOXNQUHRQSjAv?=
 =?utf-8?B?MDZ3bjVmZTJxMUxPK3JOTkJ4VVlnejVyWVBGRmM1Z0REREpURVZJdlU0VWlD?=
 =?utf-8?B?a3o5cTdiL2JVR21zSXR1a3JUUmVhdG5MTnA5S3VKakxLb3hNQ2dYMSs3VG1Y?=
 =?utf-8?B?V05QV2g0Y2g2N0xSUlpvQ0F3QXNDc3FSdU9IZFROa1JmYitVWEdGcHNJNlFj?=
 =?utf-8?B?RjZKTGtJSVJlVGdPbWVxQ3ltR2l6d1hRSFhCZ3hsbkZacEJGNFI4MkxCSHcr?=
 =?utf-8?B?MDVaUEZLYzU2N25tblRBeHZXeUE3RWxyNFplYnd2b3FIcEc5dlhhN05tYnNY?=
 =?utf-8?B?NEo4dGpWVXRkc0MzUEJUdmVmWll0N21SVEF6RGV2Y09SdVUwOExBVWsrb0pH?=
 =?utf-8?B?THdFTkVJaDlyNEc2K2RFWDVDNlFQZ2ZISmpVeE1FdlJNbnBjUmFJV2ZxeU1J?=
 =?utf-8?B?ZFlqMlI2TjhZZk9sQWo5MExOZjlKQW5Ranc1c2liS210SERJNzRwSU1udU9n?=
 =?utf-8?B?VVN1eU1BbVF6b0NOTVBVaTg3TVlpNWxkVnNuczNua1RKd0gvVExvUThSKy9X?=
 =?utf-8?B?Q3gxcUtxRkgwZWttRjRGakJaNk1XaU5nYVhwN3NMVU1sN05weWZYbUlHZkR1?=
 =?utf-8?B?M2cxaVJHMFhyajh6RlBwU3kzWEwyZUlqUXJkbEY5UjFSM1h6b1Y0T0lXMTRT?=
 =?utf-8?B?UFpLSTFyZDNGSXJwR2dPS1VJbG5CejhhQWlSUDZCT1A3SzZjMjlpOGR1Q2pk?=
 =?utf-8?B?R0gvejVsb1hYUXJuNDR6R0svazNZQ1pGVWhTTE0wL05tV3V2NmV0SGNtUkVs?=
 =?utf-8?B?bHcrM0t2cUpkYTdGZUtjMXIwckliVWl0azNsSmRBYkh4RWE4dGV6dVFsektI?=
 =?utf-8?B?SmdRektxSzdHbk4ybWZSUjR3UEg3Mk1uYjNZaXVyYkFmb1NwZ0ppdXRkVkh1?=
 =?utf-8?B?clkvZU12cTQ2eWg3bWJZYWp2cXRoRFlQTWJ3VWxVOEdCUWZQdm1HTHRwSjVH?=
 =?utf-8?B?TVkzNkVNcE9VUVo0bGl1MEVzWWEzMENDSFNMUXU2M1Fua3h1dU5DTElSb0RM?=
 =?utf-8?Q?SnZfJBDJAh185succAVPupY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WGRxVXM1RTEyZFQwcGZETDhZRjlBbWYrcEhWWmI5TzA1SU40Yit3WGdhOXFm?=
 =?utf-8?B?SWYraWhlbnpDSnBZR3FpYVhQVW1XU3U5MzE2NU1QbjgzeThCZGhnUlRnbnNI?=
 =?utf-8?B?TWVhR3hlek1remlhbWQ3dnlwWHVjMC9hbXByd2xrWW1MYkxjS0JLdDFaL01I?=
 =?utf-8?B?YmN0S2RHQUp6L3V2cStZaVhwUmFvS0QyYWpiNDUvUG1QaW9WWEV5blZFYWlO?=
 =?utf-8?B?dzJxaDA4YkpnVHlEQS96U1VBajRsRGxBNjNKVG4zaTBCUUNCc0tESXMyay9w?=
 =?utf-8?B?T0JqbHRsQk5zOEV2aFFrenJrSUlFNkVVUDhEZU5Ed203dWxvZUxONTJlNXhx?=
 =?utf-8?B?bElPZlgzd2hSc0NyWHQ2NUFGZGZYL0sxK2libG01M3lWai9lQ3RKOFh2YS9y?=
 =?utf-8?B?SkJDcFFTSG1oaCtwK0Z4M0lGNkVrSk1ha1RUSVA0L21FMDl4TUkzdHhHQ0Ir?=
 =?utf-8?B?ejlaRVdBemx6eFFvUGx4SDNsT3dES0VXdzhQRVg3ak52TDlrME1idldsRGtK?=
 =?utf-8?B?blFtNi9BWXoxYjR1OWVvYjUzdm5Pb29aeHFtYUVWSjF2SVFtUlFod0xWOGNk?=
 =?utf-8?B?NWNtV1IrZ0c4UUhqZXZlS3dTT2txWE5NZTh4UTRmeENwb25wVlYxbGRNZVNP?=
 =?utf-8?B?bkg5MEpzaTdENGdOUVE1dkpJdGJKbWc2QVNMMEkrQ0JnQXU4alU3dFc0bkRi?=
 =?utf-8?B?S2N1WllRVS83K1d6VjhiRjNXb09MckRCTHppQ0lXcEVPS08rS1hDb2ZJbmhV?=
 =?utf-8?B?c2R0a25HV2lGSHJlWllCL2pmVDdHcWVUbi9DV3B2LzhpZEQ0S2w3YjVpV0lo?=
 =?utf-8?B?Mnl2dDZNK0ROQ2NicE1YcWhhaTg3OEhJRkIrS2NVQUl0VGZmRGY2L0xEbFJk?=
 =?utf-8?B?dGJpVlJMei9xeDFXTloxa1FackZLZWpUZ3dsMlo1Z2tLVURZaVR1QnVCenJI?=
 =?utf-8?B?UUQ1Z0RXakh3bWpXenp6OUdvdDJnbnhlQmhyckdzZGZoOVJEdk9tOUdOeFB5?=
 =?utf-8?B?QzMxUWNacDBHUTRQS29HWkJLM0ZBK1RNOW9Ed2hhNExKa0tEaTJOaTcyV1pi?=
 =?utf-8?B?UGx3LzQ3MTFiN0srQ3kyYy9abUFyR1gyZGx2Vk5XVjk5SSt6Z3RkTmUwcWhw?=
 =?utf-8?B?NTlGZldCZ2p5WVJtdGl5RlB4d0hyOXV6UGMrQkg5Nmp5SWhsejhGL0UxVzM5?=
 =?utf-8?B?YW1EOUpwTHRROFhlN1RVSlJFRmd1MjFWT20rNndiUmM3Q3o1dko5K01YbnNr?=
 =?utf-8?B?bmZoeFNsTENnRHZvL0h5eGN5aG9SaHFhcWM4c2xkQnNzc3dEalBlZlhzYTcx?=
 =?utf-8?B?ckxFRmNmMHliVDZqeTJqekd1TmVBZSt6eVlCUk96UkhvZ1BVOVdqMm1DejQ1?=
 =?utf-8?B?ZVVZVWdEcGsxZFg4b1pzMXBOUTREa0xkVG1pNUlDK295YXQrdzZUVDFTZmRl?=
 =?utf-8?B?ZERjRldzejlXYkVwTmMrRFcya1lmL2kyOFM4Ymh0Mkc3VGRmZkNXb2lWSHJv?=
 =?utf-8?B?NTRHUnVyRWduejQvczlwRGlBYzNwbkdxVXZaZFFqaTdXWkdNSmtxMDIwdlZr?=
 =?utf-8?B?VHcrQkxLSmJONFMyazJxdWU5V2RVUDFiQ21PSERYUDFUY3JXdmhBOGVMVlRh?=
 =?utf-8?B?ZFNSb3c2RDdKcTB4ZmFubk9kSUEyNGI4TFNjQWNDY1owY0MyazdUSEVSRGZp?=
 =?utf-8?B?TjdyYVRYTXhKSHZOMTZ4TXdGRXRYajJtMUFUM3RINWl5L3ZQRDFteTRwd0dp?=
 =?utf-8?B?NTNrdmoyc1V5MERwNkNvNzhUa1QxTkxsNEpZajZGUFk0ZG5XckovczF2bkhO?=
 =?utf-8?B?WHNFbzRubE5GT1J0VzJ3dlM0WDBiamNrdXdtV003TU9zTVZRZG4zUVRaWlY4?=
 =?utf-8?B?N0JpdFBXZVBiWmUrcTkwbkd6RTJiNVcrVW1wc1YvWFRKZVI2dzhwcVBrRy9U?=
 =?utf-8?B?aVJBbEpvaU13bTAydXRScEZGMy96U3A0UjlVVG02bmgzKytNdWYzMHNiYWNq?=
 =?utf-8?B?QWJCbm4rbTVTMFRtdVpSSCswQTg2TVdNcTMzSlJISVd6elI2T2JpS1BUUDVO?=
 =?utf-8?B?SXJMWWlQMDRFYndFQ2VJMEpyNmZVZ3V6NlhFTGpLMForNXlNR1JBS1hGVys2?=
 =?utf-8?B?akVaRk9RWkJubUU2Z0xMckI0cDZJZUpJUmtwSFFkYUZ5THJpenV0dFVzbWg2?=
 =?utf-8?B?SldNN3BMYnVwYzhWSm10d29LUEZKTngrNmlhSDFkOWZmeVFXUkZ2L3lubEpF?=
 =?utf-8?B?MUdHaXB4Q2VGSkJFTkIrQ0U2RTdBeFhrVXN4cUNUYjN2Z1paVUJLYmdkbWVu?=
 =?utf-8?B?Nno5czFXOG5XT0ZJdDR1TDhpNFpaTG9POXVCZlhPb2YvQlZjRkg0cXpZTG9k?=
 =?utf-8?Q?7cCDThYiE+Rc8Mnw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccbc389-a28f-41d4-6155-08de6ac7d384
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 06:19:21.2784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNE/Jvo+FBwFa3/9xD/5j+cVF+7C+IUX9Bi4u4q7zJuaUjRlAjT98PnI6yhYuGW4wkTwfbkJD/0FYRMw6tK96+IGoY8QrXE7VdyUN4c6Sg5dCfyO6TFWGUS8LB/i1e20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15577
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 06:19:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21869

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkg
MTEsIDIwMjYgMjoyOCBBTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDi
lqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpIDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50
b3NoaWJhPjsNCj4gY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IHMtYWRpdmlA
dGkuY29tDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdW1BBVENIIDAv
OV0gQWRkIHN1cHBvcnQgZm9yIEJlYWdsZVYtRmlyZQ0KPiANCj4gT24gMTAuMDIuMjYgMDk6MTgs
IEphbiBLaXN6a2Egd3JvdGU6DQo+ID4gT24gMTAuMDIuMjYgMDY6MDQsIG5vYnVoaXJvLml3YW1h
dHN1Lng5MEBtYWlsLnRvc2hpYmEgd3JvdGU6DQo+ID4+IEhpLA0KPiA+Pg0KDQo8c25pcD4NCg0K
PiA+PiBbICAgIDEuNTQxNDAyXSBDUFU6IDAgVUlEOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAg
Tm90IHRhaW50ZWQgNi4xMi42My1jaXAxNSAjMQ0KPiA+DQo+ID4gT3VjaC4gSSBqdXN0IGNoZWNr
ZWQgbXkgaW1hZ2UgYWdhaW4sIGFuZCBpdCB1c2VkIC1jaXAxNC4gSG9wZSB3ZSBkbw0KPiA+IG5v
dCBoYXZlIGEgcmVncmVzc2lvbi4gSSB3aWxsIHRyeSB0byByZWJ1aWxkIGFuZCByZXRyeSBsYXRl
ci4NCj4gPg0KPiANCj4gSXQncyBub3QgYSBrZXJuZWwgcmVncmVzc2lvbiwgeW91ciBmaXJtd2Fy
ZSBpcyBsaWtlbHkgdG9vIG9sZC4gSnVzdCByZWJ1aWx0ICJuZXh0IiwgYW5kIHRoYXQgaW1hZ2Ug
YWxzbyBib290cyBmaW5lLg0KPiANCj4gSSB3YXMgdG9sZCB0byB1c2UgdGhlIGxhdGVzdCBvZmZp
Y2lhbCBGaXJlIGltYWdlIGFuZCBmbGFzaCBhIG5ld2VyIHZlcnNpb24gZnJvbSB0aGVyZS4gSGVy
ZSBpcyB3aGF0IEkgc2F2ZWQgZnJvbSB0aGUgZGlzY29yZA0KPiB0aHJlYWQ6DQo+IA0KPiAgIGNk
IC91c3Ivc2hhcmUvYmVhZ2xlYm9hcmQvZ2F0ZXdhcmUvDQo+ICAgc3VkbyAuL2NoYW5nZS1nYXRl
d2FyZS5zaCBkZWZhdWx0DQo+IA0KPiBXaXRoIHRoYXQsIEkgZ2V0IGEgbmljZSBiZWFnbGUgYW5k
DQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0gICAgICAgIEJl
YWdsZVYtRmlyZSAgICAgICAgIC0tDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiANCj4gWzEuNDQ1MzJdIEluaXRpYWxpemluZyBQTVBzDQo+IFsxLjQ4OTI0XSBQb2xhckZp
cmUoUikgU29DIEhhcnQgU29mdHdhcmUgU2VydmljZXMgKEhTUykgLSB2ZXJzaW9uIDAuOTkuNDgt
djIwMjUuMDMtMTktZzVlMmNhZjQxIE1QRlMgSEFMIHZlcnNpb24NCj4gMi4zLjEwOCAvIEREUiBE
cml2ZXIgdmVyc2lvbiAwLjQuMDMxIC8gTWktViBJSEMgdmVyc2lvbiAwLjEuMSAvIEJPQVJEPW1w
ZnMtYmVhZ2xldi1maXJlDQo+IChjKSBDb3B5cmlnaHQgMjAxNy0yMDI1IE1pY3JvY2hpcCBGUEdB
IEVtYmVkZGVkIFN5c3RlbXMgU29sdXRpb25zLg0KPiANCj4gaW5jb3Jwb3JhdGluZyBPcGVuU0JJ
IC0gdmVyc2lvbiAxLjINCj4gKGMpIENvcHlyaWdodCAyMDE5LTIwMjIgV2VzdGVybiBEaWdpdGFs
IENvcnBvcmF0aW9uLg0KPiANCj4gWzEuODUzOTddIEJ1aWxkIElEOiAxN2Y1NDRlNTZkM2NlYjQ4
MWZkZmVmZGU2NjcwMDFlNzBjZjFjZTI0DQo+IC4uLg0KPiANCj4gV2UgbWF5IGhhdmUgdG8gYWRk
IHNvbWUgZG9jdW1lbnRhdGlvbi4gTWF5YmUgeW91IGNhbiBub3RlIGRvd24gdGhlIHN0ZXBzIHlv
dSB0YWtlLCBhbmQgdGhlbiB3ZSBhZGQgdGhhdCB0byBhIGJvYXJkDQo+IFJFQURNRS4NCg0KSSB0
ZXN0ZWQgb24gdGhlIG5leHQgYnJhbmNoLiBJdCBib290ZWQgd2l0aG91dCBhbnkgaXNzdWVzLg0K
U2VlbXMgdG8gd29yayBmaW5lIGV2ZW4gd2l0aCB0aGUgb2xkIGZpcm13YXJlLg0KDQpUZXN0ZWQt
Ynk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlyby5pd2FtYXRzdS54OTBAbWFpbC50b3NoaWJh
Pg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


