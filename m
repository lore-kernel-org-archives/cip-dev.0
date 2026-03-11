Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9FFD88FA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 05:02:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13703.1773205334676183859
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Mar 2026 22:02:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=WkUEyplX;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773205319;x=1774414919;bh=bUfA3wqt/RXOwdBiBfSfTpgUSz0+XkRsHlaFC
	8k7kbs=;b=WkUEyplXQtytR9c+oenMmKSGbHLt8VZ0t/GdLIpQgvxi9/wKq6pQ23alfvh55hsbeeL
	jrJTkrubYT/EyWM1VBBW3K+GmpEXVoI5Pq+yaLRWmlz3cFqSMMEM3DZqIaJLVKKlh/sTZIBf3DUrn
	mXRyAyvDtNyDo1VeG2l01sgYrovkbuAJ9LjwX9nmbByACVDxXxiudrbvHsJNNZyxxt/plB2KD4XML
	ysyDmZk1aX8bSt6ROHRhcvy/DOamjGGnrMtdQqpcrBaRBwgnRB6It1fcDhk6V1uSFBtuCjzhpfB6S
	+OL/Qw2qzklKNDxsMHCy+s6GFcs5Uk2u8Nae0jK+YsMg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 62B51w2Q1170381; Wed, 11 Mar 2026 14:01:58 +0900
X-Iguazu-Qid: 2rWgOuWFNCmKZOJnVo
X-Iguazu-QSIG: v=2; s=0; t=1773205318; q=2rWgOuWFNCmKZOJnVo; m=WAvW7sK8tb6WIQlo98CXENsGfXeCX8F1qkJCqp+hi88=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fVzBD75Kvz4vym; Wed, 11 Mar 2026 14:01:56 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWEF7HEfmBagyO2mYUmFKTpjZVd6MOF8TYG3wgxcedDGE/bOj/51LFVM49lg3aFYq5FdPYDNIQf1lqyYpPSrgoXzE5rLFA5BdE0GeBUDABG8fgkp1/Fd3zRNzvQ+V96CcrU7yUxlZeCSKMPqPtK4IGHORxOnEtcSEMaSJqe9AGgIxceRRm7hkal/R277tcgSlabsCn5wQdds30w8HI0FValTFIMQ3pejVID3ErI8GuBb+9ygsyWYS/54aOGD2L4UTB228F7+B1X1l0vE2p/9WyBfw/I5cA6FpWEn4TGU4DQjd4wkSRFZEsX9b8cevDAlaS7e5ofMSdGNNVejf0kKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUfA3wqt/RXOwdBiBfSfTpgUSz0+XkRsHlaFC8k7kbs=;
 b=xNVmZEyxC11HewJ0ke9Fkqnz42vEB370N1/2Jjk1ctOG5pLvmFcONtJ84SbIEHKguq/mhw+n24LkFoGZzFqT5ndzCOkrVVd1xjDqFoWGD2mvjVc9KRd3KBXr/cGhd7kiKHwQLMUE0B4DvEXH1H2xBsjExjGmFY5UnLFGZ+W7uIegGy7ldYK8fbhVLuzqLqE/0G1+K01tF/p2wfTM4n6vpodvPVvRpDZIh8e5cwX9Wvn2udSoWIxXFYar7YSI3Y+WX9NtRoR+zissFPpHiHX7hDmimTR3W/0GdHPE3PIZpzLI50ZdC+LpA4/Bq8YsctvQqSdSXFbb7oKm9L96V1pwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <chris.paterson2@renesas.com>
Subject: RE: [ANNOUNCE] Release v6.12.76-cip18
Thread-Topic: [ANNOUNCE] Release v6.12.76-cip18
Thread-Index: Adyvo7ioq5fm8MhtSt+h7L/y0HwvkgA7b1OAACCM+JA=
Date: Wed, 11 Mar 2026 05:01:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DD62ED8DD7D484BD232CCD47A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <TY7PR01MB148180663612C1BAD4584B06ECD79A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <f54ffe73-aafc-46ec-8f0a-a2c14f41b471@siemens.com>
In-Reply-To: <f54ffe73-aafc-46ec-8f0a-a2c14f41b471@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB13526:EE_
x-ms-office365-filtering-correlation-id: 42e30ce3-ea87-499e-ed04-08de7f2b4f8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 7bJdIG0sp/14IiTfgkus3xGE0IlpgPXj3VWYgKEOoabTvirgTd30OkbCYLGkYE9SZETnjS/ulQhZhP8sv0p3M49eMgqrkWpzHHw4hAF5L84buAZP4hbk2q34xM1KkMNIRhwnd3I1Po+jshtYG/Xfjua0EYO6aTIThJLvoZP0kStfyBDKvv10VL1OrAKtYs66UFZq558wyXbuYdo7r80XwiSeZ9j1XDQhQ5xVzzJoHeam2YX1iVl/GC6kU64grSYAQa68PrpsvrF4l5GyjTkNuGl6rX7wWKQuNZRuT6MOszdZdNaZ/xVQyUGnxVv/p1Xch3RSEbZlyvwNxxaEjAwjlFfL2izrlfH+bZVDBSsSBJ3oCU99Haq9fLfYVMdJwpsLRY1QHTaRwJUP85chUSU+RxQhN14BPJYFimntVOxv0iJK54oW2681f3Dj/OevydwkHO10C97YBQAYuTkdFDPSkkI/1yK2jvX5fes8JME0iIgXc9HbQGs3O199YHTMUBo73lpPk49NFSjEr7mDamH4AqfwYKUfZQ1pqks64K4xSRhSmCuY9eyEgdXXNtYpGqCxBL+bhui0jQmMyqiGUAIZeBI1jBIzrWvd/SPQGNfdtWST0afPP4sbNBgrsVKQHioX5h42nzRM6y5c4C7oT2D9MVpZHXqJfTtZdpj2lMU3b2YQv2Z/uFaH4exvPLJBJVQsiubFZklt9y7xhhtrOlD7KJ13tQvWs+5t48/L9bmamqg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NjVFdUk5aS9nSDNIQVVib2hlbVc4K3NRa0xlUXJrM1RHd05YM3piaHFOS0FL?=
 =?utf-8?B?MTBlNzRwWE44dC8vajRjSkJoL1ROSHM2ZmxJWGRDMy9LRmNTV2dDTHJRdm5B?=
 =?utf-8?B?RDVMeU1lZTRWTXlaakNPY20vV0pSYlFlc1dMclMvbzJDTW9XTzBGMVNwbzhG?=
 =?utf-8?B?T015NGx0dVgzb0xId2FKY3lFSk9rU1dVVE1YSCtPcDg5eVFWSzVoeU1jYUJi?=
 =?utf-8?B?OHRRVjJUSW1ETG5iUVAzZ3BTRmlHVlFPeEZFdVg5NG9XZ0V1c3o5YVlPLzlT?=
 =?utf-8?B?bzQ4MDhPajF6bFdXLzd5THF2L0VEcGwvdi9IQ2ViNGpaQnNZaGdvYmc4MW1K?=
 =?utf-8?B?L0ZzanRGN0U1U3RnTkc0NWtWR2pIYktzRldPVzVOVmlBUmVxRWFxQnBzektP?=
 =?utf-8?B?UlVZV0RQbGNVRHFNRlI1R2NhZC9kdU9FeldQUnZ5d1VsMWZUeXdyVjVBTDVt?=
 =?utf-8?B?UVZXZjNhMFNXdE44Q1RPYmpNcy9YS3VVRmU1dXNSMzZiU2xjdzdnWUxXUFlR?=
 =?utf-8?B?ckZpVVpLQktkUHhoU2xIM25yQ1RvdG9RbFo5UW5lMGZpWTg0SHFPRFB0V0NM?=
 =?utf-8?B?T1hpdzRqVzlSbXBZYmVwQVRpNHcveDBBVnZ1VGo2WVJ5V0E5UHk1SG90cjhv?=
 =?utf-8?B?OTFHSEZUSHZzNW1OSG9XVEhlTHpKSlpzd2g2Mnd6ZzdSam1IcW5BTVlwcWxy?=
 =?utf-8?B?NjVWVnVFYXpldkpxZDZiaENzMWxXUGZVeDh0NUxsdldwS2ZEdWhlODlZeHZi?=
 =?utf-8?B?STBCVTNVSWJCTW85RlhVSEZiT2NoanVFQTN4T2JnbFE1aWpmYU1wQ3J2MFBI?=
 =?utf-8?B?cW10VGE5TXdpQ056VmNwVnZ4ZTZNeTNFRHdNaWhmeWIxZ05BeXdTeW5rV2hh?=
 =?utf-8?B?K2F6czRQQ2R0MXIxWjJmVlAvNGhKeEpBSkQvd2lEcGg4MGdDcER2NlhKV2hT?=
 =?utf-8?B?bmF3MHIwM3lQV2QvZnhycVhFVXFyT3VJSlR4SHYxQVEyMEtnSlY3S2U0R1U4?=
 =?utf-8?B?M1MxczU3YVJWby9CbzZoSGxLWEdQTm5Fd0ZWb0Z6NDNJdkdWS1M4aUtaRi9V?=
 =?utf-8?B?ZjczcStORk1CL3hacFlVVWZlK0VmbVZzcEFMdjRXdXUzWGpUbjRxTCsyWE81?=
 =?utf-8?B?MGM4L1JGYUtoRnpIS3JSdXc0Rm9SdFhyUlV0UHgyenBJTzJuMDlLazVQaWs0?=
 =?utf-8?B?Z1M3SmZJc3ZhdVUyaXdzR3ZLa3daZnV3OU9BSUNCQWlkS1VCRm94NUd5a3lH?=
 =?utf-8?B?THg2empLaE1EZnNSYVBPZzI3NkVRZ2cyekR4cmJyS1VaTXlIc2Vzb1oxVzdz?=
 =?utf-8?B?UGVaM3FQYW9xNzZzVkpMTWpKRThKSU1xTFBzbDAzTVphOG04YzYxVkNia1Rq?=
 =?utf-8?B?Qk4rdUlka0NFSTZ5c0hJd0RZRythR3R4ZlQvc2dNTXNsTktNSy9zV3J0U2ds?=
 =?utf-8?B?ZDdPSEhCd3c2QlAvaFB4WmhtN0xydTEweVBVem9IQ3hiT2ZVc3M5WHVpMURq?=
 =?utf-8?B?MFpPdzhSckpFVUp2V1MzRzBjWUNXNFFFc2pKZ25qTysrdUZDZG0vMm1vYzZJ?=
 =?utf-8?B?cEVyT2gzYmU1cTBNWDJhUXRsTnJ2R1JCSW1ReWxvZHJYUGVabzlnZEZCT1pp?=
 =?utf-8?B?ZkFTS2kxNE9KQ1pxT05oNzZQM0d2aHNqclZZNUd3MFBFanlPTmg1NjdxWFJh?=
 =?utf-8?B?dmdLak44c0tRK0E0NDZFRklaUlM0VUZrc3JZOFJNS25XMUR4ano1MG1BSG80?=
 =?utf-8?B?ZkVySTVpQ2dFM2Y3bkVFeTVSMWhHdHJJNFFWQWRjeWFJV2ZyWmgyL0hDcHBa?=
 =?utf-8?B?aTRVemkzZ0F6Vm9OZ3NnUzNZQm5iZ2s5bnRDRmtHaUxtM2puekhhaGNXUFZL?=
 =?utf-8?B?SlVYWTNiVnM2MC9abkNKbkRPUU8rL2l6WUViWnU0TnhFSWtmN0pmbFdNVkdB?=
 =?utf-8?B?bTJsZGs3dEFXL3VKeWJuRjNrV2JnUXBVZzZGUVFCdHlzSkFvK0ZwUWdVN1BL?=
 =?utf-8?B?N1d6L1JqNjIxbHQ1VmRUQjVSQjFjTnhXayswVitMYlBQcEdKSGE1cFhJQ0Vj?=
 =?utf-8?B?a3BZNDgwSGYxZEFZWXNsb3ZmSUozZk9oZTk0TU5OY0NVcU9aeE44dm9WN2Fm?=
 =?utf-8?B?YThPN3RnMWtoVTdSNVdONUhpYXBDTWF0a3lXNVpUTXV5bG9OV0JjanZmRUQ1?=
 =?utf-8?B?SDc5a0FteVUwVHJBZ3FhOENRY2JjTVJxNWw3L1VpSVIyWGhjeng0TjluRUF3?=
 =?utf-8?B?cDY3akFYQXB4cjZSLzhDTmo4bWx5cnQyVjJROFhXdGhDRk95VXVrVUt0WVlz?=
 =?utf-8?B?ZTY3TE0vVHMyeVRqczU3OElzVjN5RGJtUVRJcjl3c01nbzY5VjU0emZtNmRD?=
 =?utf-8?Q?v8CcNSMfYUEqDJdg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	sho9mjOOshqY36bR/Be+4eMTiOUsoyiNF4JVBh0/MmGTP0LHCJNHZa22pWx4f0ZcC8jwbyfqRyAGtutuPpoIXXs52y8cQ468ot/h9tUGqRZewvEiSFRLGx7M7QyULblgKq2EZ3mssTtbpBdjcZ+VGkhUK+bDjUhZyEF6WGbDtsAcEig1mu3TS/IQmClKwR8F3fxH8KcpAcz+j7pVryqv+gvoPrLk/P07meulctg2RZQCva9WfCkuWlb4+2K+ocbH9i4ifXPx5hzSj6L/Db4e5kBlsmoYZIixQi9pdNRaCJeaeFrjjCmC/m8dq5d/pmbyCYpnTpU+nsk5FsorETX3lw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e30ce3-ea87-499e-ed04-08de7f2b4f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 05:01:52.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avTQQWdZRmtFuQXKTKwhJYUvtONlixZpZZ+wxunOAFlWInDtCe60ptfsZUIO2SYKMa87xvHUbtsPi9+THXKGP0zHds5cbpgJwqMcIJfd71OrGEdz3SmdRgysWTIT7Kma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13526
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 05:02:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22243

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAy
MDI2IDEwOjI2IFBNDQo+IFRvOiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8
pO+8qe+8tO+8o+KXi++8o++8sO+8tCkgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hp
YmE+Ow0KPiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogcGF2ZWxAbmFibGFk
ZXYuY29tOyB1bGlAZnBvbmQuZXU7IG1hc2FtaS5pY2hpa2F3YUBjeWJlcnRydXN0LmNvLmpwOyBj
aHJpcy5wYXRlcnNvbjJAcmVuZXNhcy5jb20NCj4gU3ViamVjdDogUmU6IFtBTk5PVU5DRV0gUmVs
ZWFzZSB2Ni4xMi43Ni1jaXAxOA0KPiANCj4gT24gMDkuMDMuMjYgMTA6MDUsIG5vYnVoaXJvLml3
YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmEgd3JvdGU6DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gQ0lQ
IGtlcm5lbCB0ZWFtIGhhcyByZWxlYXNlZCBMaW51eCBrZXJuZWwgdjYuMTIuNzYtY2lwMTguDQo+
ID4gVGhlIGxpbnV4LTYuMTIueS1jaXAgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lv
biBmcm9tIHY2LjEyLjY5IHRvIHY2LjEyLjc2Lg0KPiA+IFRoaXMgcmVsZWFzZSBpbmNsdWRlcyB1
cGRhdGVzIGZvciB0aGUgUmVuZXNhcyBBUk02NCBTb0MgUlogVjJILg0KPiA+DQo+ID4gSW5mb3Jt
YXRpb24gYWJvdXQgdGhpcyByZWxlYXNlIGlzIGFzIGZvbGxvd3M6DQo+ID4NCj4gPiAgIHY2LjEy
Ljc2LWNpcDE4Og0KPiA+ICAgICByZXBvc2l0b3J5Og0KPiA+DQo+ID4gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCj4gDQo+
IFdlIHNlZW0gdG8gZmFjZSBhbm90aGVyIGRlbGF5IGluIGNkbiB1cGRhdGVzOg0KPiANCj4gaHR0
cHM6Ly9jZG4ua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Byb2plY3RzL2NpcC82LjEyLyAt
IG5vIGNpcDE4IHlldC4gVGhpcyBpcyB1bmZvcnR1bmF0ZSBmb3Igb3VyIGNpcC1jb3JlIHJlY2lw
ZXMNCj4gdGhhdCBwcmVmZXIgdG8gY29uc3VtZSBmYXN0ZXItdG8tZG93bmxvYWQgdGFyYmFsbHMg
b3ZlciBnaXQuDQo+IA0KPiBDYW4gd2UgY2xhcmlmeSB3aGVyZSB0aGVzZSBkZWxheXMgY29tZSBm
cm9tPw0KDQpTb3JyeSwgdGhpcyB3YXMgYSBwcm9ibGVtIHdpdGggbXkgZW52aXJvbm1lbnQuDQpH
UEcgc2lnbmluZyBoYWQgbm90IGJlZW4gY29tcGxldGVkLg0KSSByYW4gdGhlIHJlbGVhc2UgcHJv
Y2VzcyBhZ2Fpbiwgc28gdGhlIHJlbGVhc2UgYXJjaGl2ZSBoYXMgYmVlbiBjcmVhdGVkLg0KICBo
dHRwczovL3d3dy5rZXJuZWwub3JnL3B1Yi9saW51eC9rZXJuZWwvcHJvamVjdHMvY2lwLzYuMTIv
bGludXgtY2lwLTYuMTIuNzYtY2lwMTgudGFyLmd6DQoNCj4gDQo+IEphbg0KPiANCkJlc3QgcmVn
YXJkcywNCiAgTm9idWhpcm8gDQo=


