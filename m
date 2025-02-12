Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF83C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 22:26:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.1290.1739399208786197039
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 14:26:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=JYmSz69r;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1739399197;x=1740608797;bh=a3Qn+5XAmzGoOLqQfDAQKdzZsrOQJgV7F+uZDZf
	LisY=;b=JYmSz69rjlbjGgKEyGLhgdjbeLowDLDhaq8nAfMs7wlYVi7h9NzWcWzzGoducN8pfQpBF
	qvQT81QsEZopggogA0+4KALrfxLhIxZgU2R+e5J+Do23i+HUV4o+6ac1+ikiTNNBAfEY1UvZk7o9/
	dhoI490uLz5Zpvput802puH+saQ8e1DuBYa/n+yUam62w3G92AuAWw48qMNB8sFvbrP1JjwfOfuU9
	zHezz7CGQRqhDfrUD2eTme10K9IMUW15egLwQBUyqRuZnQpAfPU13eUSUVeHrMVRQgSoRRFh/enE7
	pJwiBPaYwCjdzXYHfsGvT83WZprmsdHHzcP21IUA8A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51CMQbtg1640291; Thu, 13 Feb 2025 07:26:37 +0900
X-Iguazu-Qid: 2rWhBFYKIjD1NsxCtR
X-Iguazu-QSIG: v=2; s=0; t=1739399196; q=2rWhBFYKIjD1NsxCtR; m=9VyGRAkduZUEJRGO9QevzddVCGVX4m1G6Lu1UjvPG4o=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 51CMQaI03857871
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 07:26:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuktXAujwvLm/n60xfEUUgXm73WR7vewEJJZygr2eowh74up/pBeWBhNScYd5UgBslm92wd1GGq9Ig4pq3bghVWSVonLzN70rOwtnPTwdrwjYs17SR3F0qpF0EHzLzFjykF7WNXLBrWbmBuFDK0MKmjZv6LD4IK+wQeMkWPPyX6tbNI8b8Z/qlGzYqrL1bj/nYKfojdrdQ2bpnq0fGZFYEo3j8xYFWh1raQOnVtP8ExpctBInCYeHwbvHpeox+CTxxiJtGXraIWzGOfNnjRYr8hizTp0Ji7iL7fKQ565Ji1S2Xq0tiSfEX2kWbI7AtiEpJeriYmkTa69NHSJ88ffqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvCc764WixqsjUJfK4/8u2z2yXm+FECU+2czLmMnRhs=;
 b=MJ3sCPqThglP0ZYzLvSrA5Vje+bruQ8yWO4SHagMQYuJfr4B0FGl1Q81ykaS+5kUBE9S/fgrebwRhk4Xhn/gjW367Qmb0IwRk8aRzhaeEPl9I7bp0TA6hh2ojRsaiU6rBL+St0kv9Ob08cokZ09M2VusCH10P/PCOEVJWebUpGpb5KtT6GuBmV4kz82szDIDDFfMCWfswUVaW/b4p3npFB4y6VmIo2pBlYIBMJHKxnrQGaP+4V46OxkCZv013fyF9Ry3FfSq03Lx9U21Y6jilOoIZhBFeIzdL6s4GOhQdbweEl5QIKZGxdD6kIPFE4iK1hemksrtM9HtSA8avldsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: v6.1-cip-rt based on 6.1.128
Thread-Topic: v6.1-cip-rt based on 6.1.128
Thread-Index: AQHbfW2Nkw4/X5YxUUKbpVSt0JrxHLNEPibg
Date: Wed, 12 Feb 2025 22:26:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638855DE9BCE6BF647DB3D4992FC2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <Z6zQG669vWGTBgKI@duo.ucw.cz>
In-Reply-To: <Z6zQG669vWGTBgKI@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYRPR01MB14208:EE_
x-ms-office365-filtering-correlation-id: 4afb58bb-77c3-41f1-7e46-08dd4bb44eeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Vkttc3dLaytnemZsZVhCR3JYUmFXSVdBZWdLNmFrSE9pNVBLWTZjZU5r?=
 =?iso-2022-jp?B?YW94aUNCRGxYWmo0M29wUkpqeWtaOGtiQ0NwK1ZPbStobkRjY1lpZHRa?=
 =?iso-2022-jp?B?OUwybE9RU3I5VWE0U0s1b29pZXQrdzBEWmV4NEhINmsrYlZKRWFKT2Vz?=
 =?iso-2022-jp?B?MHAxUGlWS21hblVtNmcrNnpYTnRrMVNqM084N3NBRVo2WjJTNEdNdlNu?=
 =?iso-2022-jp?B?LzRwUTZGclhtSXA4K1VZWjFlT0lXZmdUL3lMN0dpU3pxUmE0VXdOK0dp?=
 =?iso-2022-jp?B?TFloTS9rZElCMUdjamlnTU9lUlZpcm1yM0xjV3U1MjNLVTRtdXRWWEZT?=
 =?iso-2022-jp?B?Y3h1K1hITG10VVNUUHFGNVdBUlBZbUZBc2tGZ3FNNDJOMnBGSTlKMXNR?=
 =?iso-2022-jp?B?cHo5MnEwRVJQNGdHYkd6S2lTOW1qMHlpcWR0LzArVWVYMFY0YjdlMTN3?=
 =?iso-2022-jp?B?SlZDQWVVSFZOWm56UkhtaWVtT1Y5UWFvQ09HOGxqbWJES3B0bmIvSWtU?=
 =?iso-2022-jp?B?ZGJ4dnY4QW1yWFlMa1ZGM0VzUkFpeW15NWRmanpCWFFhczdRK3Zrc2wr?=
 =?iso-2022-jp?B?MmVFamxtN0tSbFloc29hanZhQzZQZEtNcldoSVk1Vk9iNGowT3g2Rmh1?=
 =?iso-2022-jp?B?QnV0SEQzSFM1SzJueEpJazVrdFR5ZDg5Q2Rad0ltY21obitma3pkSmJP?=
 =?iso-2022-jp?B?STY1R2J1T3d4R3ZUYVZHU3U3VDhRTGJ2dVV3S1JCalR6TXEwYkh1dVBr?=
 =?iso-2022-jp?B?cVMxbzBFZXhuSjBsblJiTVJCM1A5NFhZN1RtRjYzTk9UN3lSd3VPSE8r?=
 =?iso-2022-jp?B?eDlaY0xvSWRzTEF4eXd1Y1BCSmpkZFhFZEwxbjBRc29zaCtWMk83ZHlp?=
 =?iso-2022-jp?B?VEJQSlk4aDVrM09QaTRJbC9PWFdYRlp1M2pNS2IvWmJyRmJQeXlwZ1Jm?=
 =?iso-2022-jp?B?TUR4SVBINEhGTXVISVBaZXljTlRGTENJdS9MaVJjd3Q4WFlvb2ZMbjlE?=
 =?iso-2022-jp?B?QWd6emxQelFDYWZkbWNjL0lkYWptRFE4YlR2VjIwZ3pWZ1hnaEJiNE1P?=
 =?iso-2022-jp?B?S25kbUxndmJFNVY3a2VieUo0N3cyTzBvRWN3VDM3WHdWTVBrMkd1bnVC?=
 =?iso-2022-jp?B?eStLTlMrUDNXVHlDZmxVclQrVkdtVWRXd0dPYkVLQTFxZENTbHZ1MG5v?=
 =?iso-2022-jp?B?VnRZS1praVh6Y1E0U3cvcmZON1h5eGo4WFJ0MkIyWC9jeDZIVTdsd0pp?=
 =?iso-2022-jp?B?V2FVZlp2Y21ha3VQcEhCYVdoK0c1U2V0eS83Zy9RaytSVktvQXkzTk9o?=
 =?iso-2022-jp?B?UVZmb2hQcTZVclVVVkR2aUhlbnFiQVRmcDNZdHBSa1RraDZ0SkNUeHM3?=
 =?iso-2022-jp?B?NHI1T091eDg5cW01NlpwZkpNVW5PNDdaTDYzOERlMlo0S2Y3ZHJRV1N3?=
 =?iso-2022-jp?B?Z2lQN091bGk3Wlo2a09PSEhQNGtMejhLRnJ1VitmMzdBRnhkSEZEc0Vu?=
 =?iso-2022-jp?B?QmJnMjNvaFV1aTI0Nysyc0tiaE1JSHhCTVJtOUdJUUhmUmZlMURpMmZi?=
 =?iso-2022-jp?B?bmZyMWRON0ZSVEtHTlp2VjJsTHBFaG14K2dseWFTVWFWenJncTBzQkM1?=
 =?iso-2022-jp?B?SkI0OFVGZHgxRUxLd2pKNDJQYzZhNmp2R3oyam0rOFk2TW5hN3VzVW5F?=
 =?iso-2022-jp?B?N0VsTGZ0ZnFtdFFvczJOTGRBVHlLVGU0NUJnZFNTYUpqNGpLdnp3QWk3?=
 =?iso-2022-jp?B?UUtUQUoxendGQm94VGMwUUVySkZUN1NZeVgwNitSSmx3bFNCdUtMRlhD?=
 =?iso-2022-jp?B?dm5ScTdHalFDVWxqSzIrWFBramxDdy9nY3gwT3JMdkxDSVhaMXI0YTVF?=
 =?iso-2022-jp?B?cnVxVjRtNy85SDFFU3JpSDBGTHFXQmpRVjVZTnBjMEFkc01lb1dTeExl?=
 =?iso-2022-jp?B?VWorRDdFY2NQdE1EdUs1VWYzSnJFdTBhbVcrcnhaemI2Z3hxd24wT0dX?=
 =?iso-2022-jp?B?QmczWVRXZS9ob1lYdmljMFczT2l3MDVuTnZjdEFtdXRCRTlnL2Y3Z0x0?=
 =?iso-2022-jp?B?Yk1wekMyWll2aGE0WkxVMStHb0I0ZkE2cE1aNVR0Sy9ualZPWUNNUG0w?=
 =?iso-2022-jp?B?STRsa3E0YnVhcm1rLzQ5cFNNWDZLNXhRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Rkg4SXRodGhKR0NmbjVJWEx3SUE0Tk03MmtKTm9vNGVteTFrdUpUbmd6?=
 =?iso-2022-jp?B?cy9QV3BhKzUzWHhvZ3BiRWFEWFovT0pPNFE3L2NoeVZZMW94K2ZsL1Y0?=
 =?iso-2022-jp?B?MHRHVGRlWHRCRmVKaFU1WDFjMDcvL25lRWh6TVpwY3VzME43L3NCT3JR?=
 =?iso-2022-jp?B?T1lEZjRkdEcyL2lJL3dUUld5Tko3eEFJTDd3ZXJtWDQ3bGVpc3F3YTlT?=
 =?iso-2022-jp?B?V2NXREMrQmFPZFdibVhva3pwZHVkazBqWXJxWHpxNkRXSkZMMGZWT1U3?=
 =?iso-2022-jp?B?Y3JoMk5kZkg5SGRUK1lCMDZGUlRLTzJabFNxSDlLR3hLYXFhQ0lESmxx?=
 =?iso-2022-jp?B?ZzY5RVJKbGF0cDYvWnBzVnlndElVTjY2d0h0NTYwT05DeTZTL3JPaU1h?=
 =?iso-2022-jp?B?a3lNbTBKRm1taisxV3dZU0pzYzYrdXVzRXovSDZOaDNncmVSVnRGK3lw?=
 =?iso-2022-jp?B?azJqeGxxTElRYlBXUW5GVWNjWWNqMGtaNGZuVUlicHpZZTZWN0xEMkM0?=
 =?iso-2022-jp?B?K1ROdC9PNUhkOGdBakRGR3lYTko4VHR2bmlWVVBSZVB5enVucmhsWnh3?=
 =?iso-2022-jp?B?ZGkrL1lEY05GdUs0TVk0bHNEK1hsL0xGaW5FVHJsZDVUc1VVNFBMeDc3?=
 =?iso-2022-jp?B?OHBmTmhjQ1NOeXNQVXpSV0Z5TThZVlFXbm5McWJscUl6bE5tNmFKOVBV?=
 =?iso-2022-jp?B?R3JyWm1ocE05eXU5cE1hN0k2WTlPSUdnVElxWkVFQmJINEczZFlZM05G?=
 =?iso-2022-jp?B?N1V0NUpzTmxSbjNCSzBzOTg2bDJhR0lOZlMrc3hGZktjRTdna2RCQnhC?=
 =?iso-2022-jp?B?SUswQlljWm5OSE9DWGRQYk1MVkdDNkxZY3V0RWNabDA4ekFobHh3c3Iv?=
 =?iso-2022-jp?B?azA0UnMvd3VtaE81ZDNtQi9BemhXK3FDdnFqRnFFWGczekt0cWtOTHJG?=
 =?iso-2022-jp?B?UHdnSjlnR2E3WkhzVm5hMUUyc1N5WVljSEhlc1JYSWpuWllFbXFuVk10?=
 =?iso-2022-jp?B?M0xweXhiVkZuaER0RDFUZnVhbGNhaHgwU2p2dG8xSjVXbi9XWWgyWkFQ?=
 =?iso-2022-jp?B?Z28ycFozdFN4ZnlrUVMyL29OYlEyQWhGSmNLSVlHd2ZqeXQyWE5xRmNN?=
 =?iso-2022-jp?B?Y1BYQWI4bzRQRUNydWtiZE1xL1crb1hzTXI2Z3lQVEEwNjhzT0ZKWmg5?=
 =?iso-2022-jp?B?SlgxTnh0aTQvZWlOUE9hUktJZFd4UmlYZ2hWVWdnY1pnZ0VMNXVhYWs0?=
 =?iso-2022-jp?B?WmRDSWJyY214VC80emRlejFpSXZJU3NRU1BDaFNDaFpmREUxSUovU2V3?=
 =?iso-2022-jp?B?NjR3U2U0cVBaT2VITEVlUGR6TVExQnE3WEhsQVpERTRDTFpXYWJMV1g1?=
 =?iso-2022-jp?B?NjhGZWxhVmhCTXREZXVRdXJqeEdxUFFCSC9xem5iMDBxbmJyaktFVnBM?=
 =?iso-2022-jp?B?RUtiSFhsMkM2ZnNENitjRS9vaThHRUtCTy9HRDVKY0MxMzhxMEVaWTNt?=
 =?iso-2022-jp?B?cjhTaGVkMVRZUWtoZEEzZm0yUmJ3RXVqOUJpTWNKQnBOejlKZFUrdFJK?=
 =?iso-2022-jp?B?M1RONHk0c3Z1bEZlWlhzRkJIWTVXK1UwMG9zMEFkcHR1bUZVTCsySmVX?=
 =?iso-2022-jp?B?eWhxeEtqcUw1eE5aR2lCbWtnMmUwMjNpUGQrelk0a2lHQnFrVmFLajRP?=
 =?iso-2022-jp?B?azNwamxGZnNyVjRtSFRMN0duUGV1Q3VrNllvV1J3TnAxRUQyTW9kck9C?=
 =?iso-2022-jp?B?cDFzT05ENFkzVDJwUGR6UnhwS1RDVUZMbmtzcGNzbkRWeE9SSk1tS0h6?=
 =?iso-2022-jp?B?Y2F0RDIwY0NRNktOWmxDMnc4UmFNaTZnNWFCT0FZSFFya3VqUE53dTVq?=
 =?iso-2022-jp?B?dUxNSnhYQnl3N3liVVJVN00xQVV4Wi9vQVc5bFh5RVU2em5uUmcxdy95?=
 =?iso-2022-jp?B?bkFFMlMxVGRWQndUTlR5eHRLbzFNRmxVdEYyLzBPUUx5dEsxQ2JZVTEv?=
 =?iso-2022-jp?B?dEZmMTJNTldvT3VHNTBGcDMzV3g4U201dkVNZjdMdDIwdmhkK0JaWTJY?=
 =?iso-2022-jp?B?aUtHMmRETnhhSGw1aDZ3SUpOa0ttMTNMT3R3bHN5c2dYbk54aExBYnh2?=
 =?iso-2022-jp?B?b3hhUVdMcXdwVjM3c24xSmFhYmVCdU5mMzNiS2ZZdlBCR2YyMi91SjVv?=
 =?iso-2022-jp?B?aFhCVEFTUS90UHRpUnllb3ZCRCtBS3pwc2I4RnRUZTFTOHlyeGlOeDAw?=
 =?iso-2022-jp?B?dmhqcm00SVZxVktLSFdXME12U29FYnVEdFNRYXRPSkNuYWg3QkVpNVlu?=
 =?iso-2022-jp?B?MGVMQUJZaDFNSE51LzBEVUdiT1NWaTcwN1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afb58bb-77c3-41f1-7e46-08dd4bb44eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 22:26:34.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlC6horlJ2uPpdeHAOk2bfYxqO53YF/O9kmXmhir59xOYXNvqeUjC9c9sd6PQnOu8Ec36UhnSX5jYnypOFWe+NnMeX74j6XuB++2FL4T2IKa0+R4ZeDg/Y3t4ZK/uueC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14208
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Feb 2025 22:26:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17820

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, February 13, 2025 1:45 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: v6.1-cip-rt based on 6.1.128
>=20
> Hi!
>=20
> 6.1.128-rt49 is out and it may be good time to do -cip-rt release.=20

I think it is a good choice for us.

> Could I ask for 6.1.128-cip release? (Alternatively, I can do it myself).

Yes, could you release it?
If you do not have a time for work, I can do it.

Best regards,
  Nobuhiro


