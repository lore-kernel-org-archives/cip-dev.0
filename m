Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8074ACA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 12:01:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.15724.1757505688066424016
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Sep 2025 05:01:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=VTfdTKkG;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1757505678;x=1758715278;bh=y8+02BNXJe0od9TIwLZVnBZ2pjnHBTPwGDSw8
	TSnVpY=;b=VTfdTKkGdgHxQAclQyYwSjfGAArNAZz4bYDCUYSz0JxVgNZfdq8CVyW2/YhYfz7cy7g
	Dhc/TWSAQ/P0idZRaWYq3inomoQicEvOIHWpU301kT5ukFNMjjVq9P7gYFCa7p1+f4ec0XXboVgJ8
	u9AoJfrIJFKXm8iG8OUOZk4NI07nAnTYVOb3NM2XH9BcgJ71RApILLwLWqPLxMu2TbweVbUFkikF2
	LWT6dDNbjYGOJWVHx3YJ2c0clpLCC8PIJO9LjlimUL0wg7suhmQfHCutNfZqlDc4zOawcrZ7cspoS
	DmGduQrKAJCtdORVFn2bHRY8gdGG6Syji8G4SSN+/4Ow==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 58AC1If9998481; Wed, 10 Sep 2025 21:01:18 +0900
X-Iguazu-Qid: 2rWgn3EcXWLNMgHIPM
X-Iguazu-QSIG: v=2; s=0; t=1757505677; q=2rWgn3EcXWLNMgHIPM; m=ILlESQt+s1ipn98X2bLY4FGDHo7YAuaU2PpTvHonQI4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cMK651Qzdz1xnf; Wed, 10 Sep 2025 21:01:17 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHCJiSpCn5DhN54JrOyA39xF+MGR9xBelw9bTBPEny+gdAYVUUeL7fQmYu1D8X3eePoY+yy0Sr5bFhyQRCwxZBqxfBOEIErg5CO7PabNJfMYOoKJUkvNRurypYcSrfNdF76B7Ejv0yQP1kpIrlm/fHzGlfj8be8FpRo9j09okWipvTEHKYd27uUoIASOCJvp8KoO/mnTRTGVNWzBFbrXygrIdafOoODNfKr8gziDQTwQjYCDSC1URpssRiFr0x8MlV20RpwHyLKwt/712FdqLRerQCQej3LZPpgWcRkFEblMfp9ooIeXkDvPFdkintM5Om10bplEZxg5FKWwYHUvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azhRfK8RFr+9ONjR1W7FKkrnWmxrG7Yr8T0obLqXLwU=;
 b=kf7SwRN13E3VI20orgkr9r2CjXNaKAcGI7vaSQ3Fkuf6Urqvh+m+GDXRZh+D5FMvNNod1sSpC+ldobjjTAgin4PLDZBXGb4hz1YOfsUNMGalOhjecjDjyTGqBbNVK8BGmg2+a3lfIBFPDa78p0so8PNtmJvJFqNcxcbQ03KlvhwfPBjzGdoYChBZVaX7md+rFloRgqdGIYicPNtzspdguBwDgrtwPWaSLdVVT32uZBuEJkxmHLSvzMqU0mkp2p7dmOaayNB6y7TXoQQ5J8ysX3r+NTvJBXa4S2OMd+pXtWNYGwbW0AWLzXTKd46kMkpiHegZTUheK0XArvj/9YQQqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 5.10, 6.1-rt
Thread-Topic: 5.10, 6.1-rt
Thread-Index: AQHcIjDbySaL1Q57l0Cja2xrKqVl+7SMUD+A
Date: Wed, 10 Sep 2025 12:01:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A575FEA1E5F9C91B705FCD0EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <aME9OVprzmQL4E/A@duo.ucw.cz>
In-Reply-To: <aME9OVprzmQL4E/A@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB7049:EE_
x-ms-office365-filtering-correlation-id: a0476a72-3d16-41dc-16fc-08ddf061be7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?L1B2SEVwb2MyenB0dlp0N3FpWmJlblFJQXFnWW9QYkZDbGlsWHdIZW1R?=
 =?iso-2022-jp?B?S25yL0V4RXNjNGZ5L09JL1prU3RuSXdCSzRkczFhQzkrU2llZmNudXJC?=
 =?iso-2022-jp?B?MU85d1JaenQ0cDFVVWVuL3dYQ2Q4d3ovZFVmM2ZqbXpXUnhqSzcrdllO?=
 =?iso-2022-jp?B?b2dyOVk3ODk4S2VJZE4yMHNaN2dRdEFqaDB1NTNPMStLU0xTMkpUaUJI?=
 =?iso-2022-jp?B?elIyam52NS90TlN0WG9IampGeUtqcmUxdlQ5WXZ3ZDFOWXdxWklzSUkw?=
 =?iso-2022-jp?B?SWhJbHdEMFNWNGRFL1ZqVFRLR0M4RjhITzk4OGhydzRBY1hrUmpGc1hC?=
 =?iso-2022-jp?B?cXdsVzhxTk9TaGN3aytHMXQ1b2tRSTZpa2x0blVFT2lsVnRaUTlNVTVl?=
 =?iso-2022-jp?B?MnZZNUFzY3plc3M1d0lteXNyTUM5RHgwcWZscDUrVHI2NXJuQytraVBy?=
 =?iso-2022-jp?B?SVd2MWg2WEl0VmpBSklFMW84VExSaXRWSU5DRVptNTJ1T0VNcVoweHJq?=
 =?iso-2022-jp?B?R2swdW1Vc0dZQ1VNaGs1U1pKUGtqY3I4aWtGNXVOd002cFhEeFlCbkdD?=
 =?iso-2022-jp?B?M0ZJMG05Tm53Mk9McGdITWxOYkx4WDFGWjREV3orSnpGbHdIQk00SGIw?=
 =?iso-2022-jp?B?UVN4V0RBT2oxNnlSbW5aMW5ld3VOaDROdDlLSkI1MkljenRPK3BId2V4?=
 =?iso-2022-jp?B?RWo0UWtEZTdXSm0wei9mTU5QYXA2ZHE1dkhucm94dFFPdDU4QUdiOTdy?=
 =?iso-2022-jp?B?Z01TS2VzdjdXaXExM1NDbjlmTFhoblBneitaMVdVZC9kRkg2TDViZFJK?=
 =?iso-2022-jp?B?SHE3elJEWHZYRWpaYlhyLzByTWR4YTFQY1VRMzVPQ3FPbGNUZFRYSE1E?=
 =?iso-2022-jp?B?YncyU29YWFJzK29ZT3VsbkNJRHZVTmUrcmN5SVE2ZmZtNHF0dWdXellL?=
 =?iso-2022-jp?B?R3BRbEJDdDBsVGhyTXVHMm9FcW9EazlzRHVaa1pxanNmbU5ka3MwSnVp?=
 =?iso-2022-jp?B?dExKNVJ1Uzl3N1BkNDBHSHltNzJPL0lvZ29qWEtyY1g2VFNpbjJiUlh2?=
 =?iso-2022-jp?B?SVU1amhBSk5XeHJ6TDh6dFIzVzdiVFBENVBjbmFBZGdDdkhLNWZ5RFNr?=
 =?iso-2022-jp?B?N3RwUllqSVVkZVg4RDNoZ1J4ZFNxbG5ScHNvYzRvNFh4eEZ6QUpQd3h0?=
 =?iso-2022-jp?B?UCtSMUR6R2s0NjVmcTJ2NlY0YmM5eXQwYmgrR3Viek9DM0NORFVDZGoz?=
 =?iso-2022-jp?B?RitaQ3p5ZSswcngvSkdyWjB1SkNlTW1HeFdrd0xCTDV2Q2xLa1RxZk55?=
 =?iso-2022-jp?B?QW40UER5TlFWTGpjVnJ1dlZHdnp2V2hISHJHdFVuc1lod3c3RlZmWkVQ?=
 =?iso-2022-jp?B?QmFaZ0Z6UWUyc1JaMFNhcnNUTzJKd0NBbUE5VXgrWU0zRUZ6VEd1VXdq?=
 =?iso-2022-jp?B?MS9vVy9OL0kzTVg1OEdVRmwydExwYW8zVDJiSDNJMXJud0F0dzRVWjFY?=
 =?iso-2022-jp?B?S29zbzE3Nmt2YnNOckdTbkJDbFp0ZURXZ2NWZlk3d04wVkRtNGllUjQx?=
 =?iso-2022-jp?B?Z0xkbDNwYUFnT0VxMTNPUXB4am1EVDgvblduVjdqSndQQmtiQ3FLaEhs?=
 =?iso-2022-jp?B?ZEFKNndqVzl3blJNS0NZVWx2RkErb0Fkd2lXNEZXR0F3VS9ueE83OGV4?=
 =?iso-2022-jp?B?cGR0MG5SdCs3TFNyN29WaWY5UmMyMXBrYTY4T282eFVON2dZdVc0b1NY?=
 =?iso-2022-jp?B?amIrRS9ycU0wSkJmSHMvbFRjd1JNemtSV2krbDVTeGpBdGJOYU1mSHg2?=
 =?iso-2022-jp?B?ZE1ZSHkxQlFMajJuNHFtQldFY2RubW9zQytUSkJjSXVPR2ZvVEVKa1ZV?=
 =?iso-2022-jp?B?NmI0Vldad1cwc2swNy9Zd0F2WWxXY0h0SWxYZHo0ckNqdFlERERLMzlo?=
 =?iso-2022-jp?B?U1JtdCtjaU1PRUlVZkFlUzVkamIvYTZLQTlKcyt6YWdqMnpPZ0IwamRq?=
 =?iso-2022-jp?B?TG9XZG5CMFFGeHNlZFA2b2lGQVk4M1dHK01UL3oya1pLcXVselVOTnFk?=
 =?iso-2022-jp?B?ZndBeWVxV2dGRkZJZWMrNmsxUnlScTJKM0wzRzg5V1RWbzZEenZRNGww?=
 =?iso-2022-jp?B?N09Xc1FxSyt1aytoMG93aTV3Ny9hQjl3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZmJZV1pvMXIwMFFnWmxFNmZFT0ZDa29ra3FZa096ZXk3dmxaODd4a0o1?=
 =?iso-2022-jp?B?Z0dlUW03STQybTBxZlowcDlDT0x5OTRzanludGlpSVVheDV6QWhPKzJR?=
 =?iso-2022-jp?B?NFp1Sm1mYlFIRUpVS1BTeG8wNzlEME1sdU94RzZZYzY2NWJnRU0vcjR0?=
 =?iso-2022-jp?B?azdNdlJJb2s3MnhUMyt6cmRpWVVFaFh3eUdBZGgxNVFXRlBodlZGWjcz?=
 =?iso-2022-jp?B?eGZVTm5TaHhoMnZGYkVxbFU4WGFMTGt2RldkMWdDblRSMHg2MEp5ZmEv?=
 =?iso-2022-jp?B?U2FUWFVoK1JoUnZyc2ZwdFdIR1NwUWhDMkg1RjVHYmE3QlBGZXY4K2FW?=
 =?iso-2022-jp?B?emJMSmRGc2hmQ3pVRVNEY2QyVy9LY3pONS83K3NIOVpyTFBzNHdaQk5o?=
 =?iso-2022-jp?B?RzJ0aWUrODVac1VOR0NDY24xMFBJNU1hczhabTRzTDlyZHZMWTNSZTN3?=
 =?iso-2022-jp?B?emRxR05QLzVxYVg4K3ROZTlhenpOVUVhZHNYQWVLRHY1QmxZZ24waEZZ?=
 =?iso-2022-jp?B?MmRTOU5odlJRdUNCS0t6VmdHaS9FeVc5UHdTUEg1U2ZQWFBxUzhhblJj?=
 =?iso-2022-jp?B?bzFSUkt3SHBCbi9IZE1wU1RISElNbjQvbkxTNHBRYVhrWmJoSlFRK2JT?=
 =?iso-2022-jp?B?L253a0dLcXZUQjRMamJKa2hxQUdlQ0RMNU56Z3c2UGRoKzNzVXhNRnZj?=
 =?iso-2022-jp?B?ajAwbXhhTCtLTjMra1NZMExrU1BNa0JTaXZocjBRTCtEWUduTEtIR0M3?=
 =?iso-2022-jp?B?WTlHRVFUWHhSOWlhTFV6V21EOUdmazA2dFhCVVgzV2ZTc3h6cEx1ZTVi?=
 =?iso-2022-jp?B?L0lzekg2R0pEaCt0aHBVT1N1N0NYOUdCQ2JrazVORGFNaGplZkhha0RE?=
 =?iso-2022-jp?B?eGNadkpjcXRnMC93ZmR6eXdVdHA1M2UyZGpvYnJBUWxWL0gwb0JCRURz?=
 =?iso-2022-jp?B?TzFCblJNaVpGNUtsUzExN2J4QS82aXh5UWh0ZlkrbVVyM0xmWHhlQXdj?=
 =?iso-2022-jp?B?RnBqZDJvOForNldiS09tOWFtRFYyaWpDUnFyS3VXeFU3U29SYjU0enFS?=
 =?iso-2022-jp?B?Q21DekpKL0tDb2NwdWIxUE5JWStST1YrVC9aK291Z1RWVFNuR2Z5S3Q4?=
 =?iso-2022-jp?B?ZlpmNnZmcGNyaHJMVDVRZEVZd0hBMUZOWUY3SWZNdlNtR2lsWUdud25z?=
 =?iso-2022-jp?B?OGgrVFd3Y2VDNE1YZlE1aWxyamkyYzdnRVNnc0xsd05nSnVhb1JaTEV3?=
 =?iso-2022-jp?B?Y0l5emovVjJwSTV3ejl6L200TzhTRktLNjdNR0QwQWNFWkJtaHZoMlZJ?=
 =?iso-2022-jp?B?TXo0ekdxNkEzNi9iREsvV01rTnlYTmpPKzI1MFpxK1BWOUVUYm9TVlo0?=
 =?iso-2022-jp?B?VHdBTktVcS9waGMzK3dJM3l0Y3czUWlJL1U5bXg1NFlhdjFuZ2Jjays2?=
 =?iso-2022-jp?B?SHVhQ1FKKzVSaEJ0NklaUFhWckRKQTk2ZWRsK0U0aFhBaXdvMlN3aHFV?=
 =?iso-2022-jp?B?bXZiV0xXY29reUlSdmdsMEV0cnFEQ2dBeVg3R05GQ3k2Z0VFVnEyTDVM?=
 =?iso-2022-jp?B?TC95OUZCYTJYVWZoUUZZWjRGTnExd3lzUTk2VXVRclJPQ1NZbGcvcm9B?=
 =?iso-2022-jp?B?WUpTdk5mb3NNQWp2Zml5c1NTTGJYNTJ6ZkxHSXFyVVJmMGd3R0x1UWdn?=
 =?iso-2022-jp?B?bmNweWlwZ29PalVNSWFVN2k0SkltNnV0U0NHZ3djZkxwcHBqVTl4SlNK?=
 =?iso-2022-jp?B?U3A4ekNVRzBjcjJwL2lmSENtM0RzOGk3VlpoT0draDM3bU9XR3BYajZO?=
 =?iso-2022-jp?B?RkpnQlhBNSsrVnZtZTI2djdNY0RoQTZzazR5SHdGMHZ0Q0ZxZ2xBUzY4?=
 =?iso-2022-jp?B?bGhPU1JZdmo5SVY0RXBHbGJ1RGFWR1NLNmdQR2NiWmk2eUdvMWVETE1Q?=
 =?iso-2022-jp?B?aEMyQlRmZ2laUmdjczN3L0x2c2pHelY5L0o3bW1WUXdSaGFORTRWSVhi?=
 =?iso-2022-jp?B?RDBEeUwrcUpaWkszbW9ka25VeWN4S0VmeG9XdXA3ZDh5K05ZZ2RSdExi?=
 =?iso-2022-jp?B?dzVIUzZWUTJyRk9GWlJoR0hwcEsxQTJVMjBHRWVaKzBOcXRKcERWeVFJ?=
 =?iso-2022-jp?B?WWtXNWhkWFRCYkdzM0VuaWtpbjlXOHdkV2F4WGxPUmRWbmNwK3ZTcWlo?=
 =?iso-2022-jp?B?YWJhVWMyUVVQWHFjSVZvNDdxS1o1TU5kTEw0di9MVitZSkk3ZEpWM2FL?=
 =?iso-2022-jp?B?enk5TUc1UHNJdVQ5bTFoM2QranZPWmNnMG5ZMUJJMDl2cFpxd25YdHRy?=
 =?iso-2022-jp?B?cEhRYjAvQk5YemNoRE96ckRVYmJDdXE1SHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0476a72-3d16-41dc-16fc-08ddf061be7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 12:01:15.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNZa5NRF3mWDOUBG3XjUNTysJhDxq6bdbzVsR4ZhZteJJ3026mACYrJ9EhrrQ9N7s4xoXRDwVLVKwaxCdwKF9synbGOEyTzphIoTJezPT5KlQ5KAFCoReI4lzPp0x7Mo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7049
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Sep 2025 12:01:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20033

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, September 10, 2025 5:56 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; cip-dev@lists.cip-project.org
> Subject: 5.10, 6.1-rt
>=20
> Hi!
>=20
> There's 5.10.242-rt136 out. Could I get matching 5.10.242-cipX, or is it =
okay if I
> create one?

Thanks, please go ahead.

>=20
> There's no recent 6.1-rt release. It would be good to get matching -cip w=
hen
> one is released.
>=20
> Thanks and best regards,
> 								Pavel

Best regards,
  Nobuhiro


