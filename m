Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8BCC369AB
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 01:44:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.30405.1745286244439372974
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 18:44:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=ZAvYOYqo;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1745286231;x=1746495831;bh=dTHU7HFA8Xq5qdPlXgVep/NF6Br6k6ZA5UYUvWr
	LsJo=;b=ZAvYOYqoA1qYvkwwZhGU/GEeBcHp48mqrCV8y8LCvALg5OarR8bwLDKvzg2gYgn5OJpVK
	We+elTB/KT8R3G0QGU5hVNq7s0boZZF/kTLqfW9odeOpUPJhNT0YIyy02PesrIsdjsynvOEEAhGnD
	4X9UdQiyHaBpKNvAH/MghydwoF52YZK7HdVcyVoL+0kX7+fC0c7cVbIc8LAHO5DaAHWRtomywzPb/
	3scQT8IZsETq0KoPLSUCBOr5m1Y5Qcrj3N0odcyvxCItcEwLpQZj3P3IanPpQN46ZYgOjAdKhK7R4
	xWuTAevaqvgtnZJz9Dww4/XBcdp6HPK9wYbcRVwbOA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 53M1hoeQ2914174; Tue, 22 Apr 2025 10:43:50 +0900
X-Iguazu-Qid: 2yAbRDIdvRE4JqFzF2
X-Iguazu-QSIG: v=2; s=0; t=1745286230; q=2yAbRDIdvRE4JqFzF2; m=JUgp/T8GMQMXJnZT1sGAEx+SGq1CpZdTD88Ce4ZjRjc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 53M1hmuG1890045
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:43:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLEsp5dC2aINuQ39hgnWRpZnLkh2hOYGVjr3Q8ZFCuMPsk91PbOT47nLJUjf8/FeoiW/dA/5rJdykchucSyMhDr+gzOLJppApNW0q9mfzVUNy6jyhUZL8paVLIM6dJ6llu2uG8aD6DHwgKukyiHh5c1GdBzyDPv9ZfRBZI7tRv9T8Z9zKTTATRpgPVqkDe9Cd+tHLEG77MJWzvuT7iVpGMXCc/CalucNdVZ9geaQzclEIDyKlHb4xubmONquk1oru2ah+DXjGpOPHBVKNL3X43n2n3siZgpRSl3iNcPSuaa8ewUdORXbMamcjiuPX305dgNATCB7vQp+bnKBwtveyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71jraxoaI3Nd2Ir0bzw1wh2znUN7QX72UxQrjAvLRn0=;
 b=wWQxi16BtRvRX+rvcYHCwokqYzWk6pSWys1mND0mdWiNB3RBbDRmQcJ8OTGYqYLzBfWvKLX0QITQskqns6huPxKZIWcRXb+hycaudIfFteGN3rxZcLooegjrwQ4PzEW7uK0ne2yh3fUE59LpvfuacRjjCDYqvXm4ei8bHDvDhXYCYWVP+0iFK1CELf+21eqW3fj6Tq2LQHhnrtoIdh0/AW9IvzHpsJDnTWN1F4ZXV4vaAky0jWTjZgyQC0HeDRE49Wy8WjfngHVCo1a+WVoSHM2+3tXGBdb/8ZWeIiBpP5hneYRqtNKsKMGEvLAUREQZOANtmdtVHItt9sWJ57C3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock source
Thread-Topic: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock source
Thread-Index: AQHbsut7sTKLCk/5rUKvAwbNCsAwHrOu59EA
Date: Tue, 22 Apr 2025 01:43:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C38AB25D1CBF8231D8B192BB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250421183025.632955-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB11916:EE_
x-ms-office365-filtering-correlation-id: 1ac43643-af9e-4156-c678-08dd813f1c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cTVKaHM4aTVxK3QrZERrWXdiSytVMWJkS2hpZVNRZXNKUXAzbUJIamdl?=
 =?iso-2022-jp?B?YVNRaVVVaDBBQ05JcUhYT2Z3cGZMM24rWkFRaEpvd2dGRkNPUjM4TjM0?=
 =?iso-2022-jp?B?L1FhTVh2NzFqaEZzcnVjZG1Md01ydTZRaUpsU3Y4Vi9SY0ZmdTh2Mmh3?=
 =?iso-2022-jp?B?TGttTHV2eUFWS09vNEdIMHFCN051YnduNktwU0JEZk5NeldsbXpkNnBz?=
 =?iso-2022-jp?B?akdIUkJSdDEzZG1oOUp6cUNHV2JTb2J2d3NSNXhmam1LY2tVNHZNeTBq?=
 =?iso-2022-jp?B?eVFqelhkb2ZxVDVWMmlCQ3VMOEFXMWJLOEFqTEY2RDBWR3lJb3FXc2VE?=
 =?iso-2022-jp?B?U1lmOXBDc2VMM3NQT0lJdzNqM2U1eURkSHRWeU1vVTNpaXRjWDVkdnNx?=
 =?iso-2022-jp?B?eEh1WndSdDNWcmRCMXQyd2d3TU9iakVJTjVrOW9hYTRNSmdkVUxUWHpG?=
 =?iso-2022-jp?B?SWpjZnhGZDdzekdES29Od1hxZnpOMERHZjFRa3Y2bXN6UzlJb3hKbHd1?=
 =?iso-2022-jp?B?ZEozOUowV0I1KzJTWjZ1Vno2Q3Fob2k0Q2MweDNyL2Ewd3JUd2dsYnQy?=
 =?iso-2022-jp?B?N01qbXUrNi9PNHdZN3habHB4c0hlK05ZOFZmaHVzUmdER3ZBTEJzZlN0?=
 =?iso-2022-jp?B?R25NdHpGT05INnMwb2RrdENFNXRJcEM5NUdCYXpGOHN5MGFCVUhoZFdn?=
 =?iso-2022-jp?B?Zk5iWmxBMlZHdHhGZkVQZWdjTVFEdEFOMXJHWFZNdE4yekR4OTFROEhO?=
 =?iso-2022-jp?B?ZGg1Z1dpTTkzbmRwYmxRa3VpM2NqUE1XZlpxSUtOaUFlVk5jaExSZXoy?=
 =?iso-2022-jp?B?V1dMejVsYStRUVR1eFdIQnlPRFpyUWhwc1Y2ZXUvL1NsOXhqTk01OHlv?=
 =?iso-2022-jp?B?a2s1WHltWmlBZUt1L2U5WDhYSW5pMUV5V3pRVjZadlBxSUdYN2tnKzMr?=
 =?iso-2022-jp?B?RzdkMkZzUEdwQ2xvc2lLb214WVNwUTR6UmZFOXNMNkoxL0I0UXFKc0Yy?=
 =?iso-2022-jp?B?T0l0eVQxeDBJSmpnblcwZXJsTkhxRkNJaW1IWVBjbGltSUljaTRCOU1Z?=
 =?iso-2022-jp?B?VzFCMXdwNWcvb3ZBcit6ZkEvV1ZlMG41U2c1VENZZVozc1pCUzNKK2Nm?=
 =?iso-2022-jp?B?Vm5yMFczWkx4WUNxUms4SXU4TE5td3FnclFZcHducVByOExZcnVXZGRv?=
 =?iso-2022-jp?B?QjgrdTZPbmxWRmpqenNjS2lRamVkUFN2YmIrcFVOb080Ni9zdWMrSDhK?=
 =?iso-2022-jp?B?bGMzcFAxWmJOR3hBL0g1TWhqQk83SWVzVk93MHdpbmJLV1RkcUZqQ3JQ?=
 =?iso-2022-jp?B?Ym92bEZqSkxZM3VpNGhXTy9qMURLR3pRVFU0TlFlUmZFMmpIdUdSS0xH?=
 =?iso-2022-jp?B?NzZJRENLalNFNVVXdHRtVGtWelRha2FQbWlZajNieUlKM2k4aGtaRm42?=
 =?iso-2022-jp?B?WDE0VkJsbWtVeW5ocGtjZzM2YjZuZWIyUlg3ZnJvcDdibHZwdEF3UE5o?=
 =?iso-2022-jp?B?cHVVbDcxVEZSZGk2R1dzOUdlTXNCVjB4M01VUmRyMGpaNER4b1BweWY4?=
 =?iso-2022-jp?B?M0RVN3o2N290WTVPbXNjWVFNWS9NTXFOVVBsSmJTN0xId1dLVys1TktX?=
 =?iso-2022-jp?B?VnBZZWc3OTE3alQ5S3JOSFJHMzVYdFU5RlExTkdWelM5cTlISWl0QW8z?=
 =?iso-2022-jp?B?d09TWURWa1VZcWtVWWRiREM3WGc0NG9Fd0FCNnRvM2VPMVZ3RjllbGg0?=
 =?iso-2022-jp?B?SlVFaG9lbGNGM1FUQ1EwZmxPamN1SkhubUd2R25PQmVlWTJySG1kTHV5?=
 =?iso-2022-jp?B?OUhPc0RHcEFMYzBadTJvNmw3b2RqRkd3SmxLdFpuRlpxYnB3NTBZOHNw?=
 =?iso-2022-jp?B?d2NINTJndVEzakpBNU8ySEF4eFplcXhZZFk5NmR0UTc1cVUzUjRVczZ2?=
 =?iso-2022-jp?B?WjRGT3NETWZRR0dCaEYxV2RxaStJQUkwWUt3aU5pcnkreCtJaVprdnl0?=
 =?iso-2022-jp?B?RjdpSVBnOExEUm01YUlTYVNMaWxrRzJlbGFvM1FQZnZ0UUtEQWhndVlG?=
 =?iso-2022-jp?B?YUFvUWNWMThydTJEcmNieHZzOFJPdE09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QmZMcExNaWc1Q0lDYzZyV3dOTWxwTjNDTXVCbjRENmNnS3JuWk1PcmJD?=
 =?iso-2022-jp?B?aHM2TlBQWnl1bXZRd0c2T2x6UEZqZ2pud05rTkFiTWMwckRDUzBYY1M0?=
 =?iso-2022-jp?B?U0VMRUlNZnQzRDVFZ01kZGxDOVZQdEZXd0pGOHA4SnJDN0FYSzFTT3Jl?=
 =?iso-2022-jp?B?VUlMWVo1RWEyblNidUkvUEMzOE52eVBtWGk2Qnl5RnVHMEh5SXJSb3ZT?=
 =?iso-2022-jp?B?S2NFeWlteWlTOGFMWXV0T3JoU1hZYlA0WlhPSU5QT1ZuVlFVdWZYOTlJ?=
 =?iso-2022-jp?B?bGFFTG5OL3dyY0tocXFyMElhU0xVbXd2M2NZYmd0MWg1Tllkc05sVGlN?=
 =?iso-2022-jp?B?V0Y4RDVERitkU0ZwbWJheFE1QlJOYVNLVUlYejJyWHdTRWExUVJQT3Jz?=
 =?iso-2022-jp?B?UDZqT2VxK1A3czhFVXRuRE9ROVZCazBYNFdDMW1NcEZDV0xCSGoyL1li?=
 =?iso-2022-jp?B?R0g2Mm9ka3BjckNScTEyQnl0R2RlUjF5Q29iSnBkNmZ1SE1XSlZzZyt6?=
 =?iso-2022-jp?B?NlJXZW14NFk0WVFaR0FkR0F3Zm04OElJVk9TcVV2ZE14RjFqNlJUUDhW?=
 =?iso-2022-jp?B?RmtTSjdqQ2E0dnBGZDgvL1BNVTFpcnBLYkxxWjl5MEZBWmdsY3RtMHg1?=
 =?iso-2022-jp?B?bC9GM2dDeDJvSEZmKzBZaGZRbnk5Znk3NC9vbndnbDJURGtDdmp2Z0Fn?=
 =?iso-2022-jp?B?OGJVT2lTeVByS1RwU1NBZHJkalZEN21NZm4yRXRnbUJvZmU1bkpDTlZH?=
 =?iso-2022-jp?B?V0tBZXpyVk4vcyttSmpNbWJxbDVHcm9CV05HOVpMdWZSU3dkeThGVGRx?=
 =?iso-2022-jp?B?WlF2Wm5OYlNBOG9lbGZubmZwcmNaT2t0RVU2MzhqZ3c2WDFKOGR6TDRT?=
 =?iso-2022-jp?B?NUYyem8wYXdPbzNlaFR4dy84Y3BRQmtTczZTRDBIVU11ck8vYWJRSzdG?=
 =?iso-2022-jp?B?c2V4dy85NDRibWdzSFV5aE51UXZFeVFodXl1b1JzcEJCam5ORk1jNWt5?=
 =?iso-2022-jp?B?U0FtNUxicndxV0xzdE9oR3gwVUlKQmVqVCt3Z3JFN2ttcWhOS1JuVlR2?=
 =?iso-2022-jp?B?VjN3MlVYd1NUWVdrTTVUdU5PdVpvZWNweGR1c3g4QVZwMTF2c290QWZo?=
 =?iso-2022-jp?B?YWEydS9BTUt4eU9pUEN6cU85YWNoRGhDN2JwQll0NG53RDVqR1Q2TjZB?=
 =?iso-2022-jp?B?djl4WTBiQ3l6MFJqRjhDVDV1Tm5pTGhFaXdxVkVBV1c1alJIdVVLOHZU?=
 =?iso-2022-jp?B?QW9nVm11aTBPUjVidFp4aUg1dzVPS0JVZGttaUxZL1lsK0JnRVcvbWx4?=
 =?iso-2022-jp?B?cWtjb25KZW5ZbXQxZnh2dHZCbXRqVzlERnhlRW55Y3c2Z2xnN1JQckVs?=
 =?iso-2022-jp?B?TDNWTE5ZU1Q5THRqSGM1WEx0ZHFraEdqa3JnYTczakdVWmRtSE8yT0hn?=
 =?iso-2022-jp?B?bERmT1pnK21UNU9XYmNFVWdNWnkxZVIxWDBMbmVmZ04yQXBPZkFYWWJk?=
 =?iso-2022-jp?B?OUs2Umw1bkU5YUFHRHdlamNyM1N0cUYzZ3ZhdVZ2VnRTdkRENGtXMXNx?=
 =?iso-2022-jp?B?eEdsSk5VTGpQL0xGa1dlNkFJdEFFc1F2aFNyaVpHRldyM2s0eENGWi9h?=
 =?iso-2022-jp?B?R0tKeEhpMkM5ZnVNZ1NRZmhQa2MwOGxlMk43VmFGR1FFWTR4WVRWU1Vr?=
 =?iso-2022-jp?B?ZStDM1Fab1FxN0tReng4U2I5UFJjSHFicldTUmlpNENja0FyNTBTenda?=
 =?iso-2022-jp?B?UTgvSktib0hGTlB1R0JuMzhNcUNSTHJqam1FK09UTkJJdHIrUC8reXp0?=
 =?iso-2022-jp?B?Y3JWNTl2dzl0ODQ4QzY2R28rTEZhM3NGREdXRDFLK01GMWhzOTRPQ1p2?=
 =?iso-2022-jp?B?RUUwOTFMdmxmVU5TQmZ5Q0MwQWI5YjBlMVBPVlVIOW1uWlN0czBYNmxG?=
 =?iso-2022-jp?B?cWd1V0VoNnBxNTQ2QjRKbEV4cU95Z2NsK3FEenFEVm9CWjhlUmdIa3NE?=
 =?iso-2022-jp?B?ZkI0Si9Gb3VUT0JrRWYwZllsWitEVWhuVDNNYzI0SE5MVTZpT2t5L3Y5?=
 =?iso-2022-jp?B?aUJmUDVPY3RscGRyY0tBM3M3TnRKTkRRcUhmSDFKdUJ3Sk5tQ2paaFFN?=
 =?iso-2022-jp?B?ZnlsaHA3OFVoN3FPSEJLN2pjSnBKWkswa0hILzNGZ0hNbFdQSkdIbEp2?=
 =?iso-2022-jp?B?STBmVVl6bVZpWlNDL3AzTlpSenIrNXZyS2JDK3A5T0h3YzZxMEt1QUto?=
 =?iso-2022-jp?B?azBYVGxPdlNNUEVYTGhUNFFCN3lxTmY0akcrVGJUbUs5ajk4elVPMnl0?=
 =?iso-2022-jp?B?QXpxaHFwR0hlMXFzajc3bGFVREh2c25VZVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac43643-af9e-4156-c678-08dd813f1c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 01:43:41.4572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +grDj36s/GM2HexnuEDS0mjjz9Sno4P0vMwGsEO74KWlKbIMwSA5youKRUTH1tu7llNG5mb40I+3UfePF1CMvgjktXbBbMD1rLrPee6Cz8q65tWIpq2jJ0U5puJHxGA4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11916
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 01:44:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18539

Hi,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Tuesday, April 22, 2025 3:30 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/3] clk: renesas: r9a07g043: Fix clock source
>=20
> Hi All,
>=20
> Fix HP clock source for RZ/Five SoC, also included miscellaneous fixes wh=
ile at
> it.
>=20
> Note, all the patches have been cherry-picked from upstream kernel.
>=20
> Cheers,
> Prabhakar
>=20
>=20
> Claudiu Beznea (1):
>   clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable
>=20
> Lad Prabhakar (1):
>   clk: renesas: r9a07g043: Fix HP clock source for RZ/Five
>=20
> Paul Barker (1):
>   clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
>=20
>  drivers/clk/renesas/r9a07g043-cpg.c | 17 ++++++++++++-----
> drivers/clk/renesas/r9a07g044-cpg.c |  6 +++---
>  2 files changed, 15 insertions(+), 8 deletions(-)
>=20
>=20
> base-commit: 38336ea2d1beb9af557adcc91b04e82478f539bc

I reviewed this series and 5.10.y, looks good to me.
I can apply this, if there are no other comments.

Test:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/177888521=
8
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/177888585=
3

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


