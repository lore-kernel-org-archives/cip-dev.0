Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B959CCF9EE
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 09:11:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web01.2822.1761729082159430500
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 02:11:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 59T9BJt01592753; Wed, 29 Oct 2025 18:11:20 +0900
X-Iguazu-Qid: 2yAbL6ern2Fn4T3uoI
X-Iguazu-QSIG: v=2; s=0; t=1761729079; q=2yAbL6ern2Fn4T3uoI; m=PD1Z6mSAQuCqA7TDoBm99HAyuwXd/ysbi3fQcPrQYso=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxM1M4gyRzyPc; Wed, 29 Oct 2025 18:11:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn+QFmR8R7DkL3/DmOmmqAH7HLOWSzOyZKbTHY/49CeFKMh5HOujlXdZpKGkREM9GqGnm00eNVWXFYu/b+8aVqk6DypuqtCWlstFzWFkAYqI62LMxuduqWXYCYDOrGWfhw5yu9JzTS06RsqQgc/SFcl0PpyLy7VUs1gJGYcwe6EglhUgsWG2wjZMEovq8JoMqQnvWcQSrdOitksbnNRGzb+kk3F7YYgwGCUWCJz5Cbx5is0DnODHnB9MSNy+W4JkCCz97DxsWbbn+kfjCDJbygv0cqk/bwZ3yx+XHIMFPJlHdBoz/3cWd7jiKqnAYHpwpTO/ZwR5CnGfTzdlHkpC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl9Y5CM3gRNDRc7vEKcsiWDteHgZHoYfo6EP9VmZNiU=;
 b=j5xi2+aInbc/MigCwLDvoU8IWyXn9XyQy6MVe7oNLOdR983xGQHZLcKcB7U01UqdtQBpI19H1G2uhUVWcDnLRs1tLMmPFn7lGu728KkHvSDvfCst/2f+t5YHfOMel7Xw3F5NxUx00vYE4w/G1YOiOlPOtY4thZDG3zS9OCa3jx7b0WkeNgRi23TJh5J5RqdYHJm0CVdUB8sybIyNkBrRjyO/thJvieAMPU8/ira7j0/r3u4AA5QXh0N/z/f0o+h3fVvUl8dnJQ7bSvVXxfEs+GnTRT5k/vOPJ75Ztxdtu+0nQcnAb54Tbendf+MTgQ2Jxi8R35j1xn/dITILeJKVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <hirotaka.motai@miraclelinux.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>, <pasquale.nieddu@siemens.com>
Subject: RE: [cip-dev] isar-cip-core: Shifting defaults to trixie?
Thread-Topic: [cip-dev] isar-cip-core: Shifting defaults to trixie?
Thread-Index: AQHcSCSlRPbY/m07hkmeACGdhPyNKbTY1f0g
Date: Wed, 29 Oct 2025 09:11:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB8515ECCFEF6C63E9F77F7998BFFAA@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: <87286d13-6e1e-4cbb-ab14-a8af38037b8a@siemens.com>
In-Reply-To: <87286d13-6e1e-4cbb-ab14-a8af38037b8a@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|TYCPR01MB11525:EE_
x-ms-office365-filtering-correlation-id: d97f986f-754a-495f-ae64-08de16cb1dde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U0R1ZVlwVlBkOHZIcHVSaEZobS9qT25EY3BxcEMrZ0NMT1IvUEtQVmFTMXp4?=
 =?utf-8?B?dWhWUFpRNFFNZFZOU2dYTmN5MWNvRVVJeEx3UkFQRGxrWkc4dTZPbmIrZnNk?=
 =?utf-8?B?RzVwMHd4UWFJT0J5N21hSGE0T2p2WHYzajJoSmJnVVpxQnZFbC9icDdxdVM3?=
 =?utf-8?B?V01JVTFPWFJ2Mmo4RUpuT0xsMHlUNDBXSnJoSUFvM3NvS0lTMjlDdXZnckVo?=
 =?utf-8?B?cktPRlRsd1p6V0tqUktoWjlwT1JGWGYwRTJEdnJad2JmdWVKT0dpL0ZQUWVI?=
 =?utf-8?B?OXhPQndPSzYxeWVuOFhwamdNSlB6aVJXd3MzVWhNWUFpSnhjMU94eXZOcFY1?=
 =?utf-8?B?L3JnV1VFMGM5cDBXWkYvTDZ4cTBzZ2kydGc2SWFkeTVyTm14aXVFSm1uYk9P?=
 =?utf-8?B?c0RmK3Jta0puWUo4ODY4RkkwM3dMSVhtSzg2VDNZeDJKaW5pNTRIekVITklF?=
 =?utf-8?B?WHhmdVBXQXozTVgyeExueW5oR1BlbmZRMUdTNWwyUnRwQXhENlo0N1NLV21z?=
 =?utf-8?B?SW1DdytEU215SU8ydURkWjkvOXRROENob0ROR3JsdE42c1FudnVPeHk1MGVj?=
 =?utf-8?B?YWV3bHlUaFBaSUdNc1JjZjBpMGhjRFg3VWV5NGlBRkdVT01IZFZIWXIwengx?=
 =?utf-8?B?QmNDSXZua2lrZE9ScHh6M1NDYXlhUGJZeERVT2hob3NVdWhFWU04WEJISEFQ?=
 =?utf-8?B?Rjc3bW5ucnpnbDRQTjhUT05vaEs0NW5YY2o3aThMdFhRaVNCK3k5d0dOS0wr?=
 =?utf-8?B?ZlNUZUhKSzd5ODlpbThuOWlNQ21acFhsUnNpOFJ6R2tZeTU0cGsyUlFtdURY?=
 =?utf-8?B?WlFTWmkvbkRJZ0NRMG5yN1hCNTdxaUJPUUhDTXRvR2hwdndnRjdxNXBDMGp6?=
 =?utf-8?B?a0pNV2VRVVl3bGxnd3pId3F3QlI0UHF3N0dGaVhublpuTTAxVkwxOTQyWTc3?=
 =?utf-8?B?TUtReUp1M3ExRCtOSGlySmpPS3Z0SXhJUGREcTFPamZoNjcwenlOV2NlR2w0?=
 =?utf-8?B?clJkdXM0ZW1DeHVhT3FUOTdvMnl4QlI2VjFqM25ycWY4M01xUWVPRnd2V2hv?=
 =?utf-8?B?WnRNN3ZUM2dkeUQ3M1hrRk5KbTdOZ1F5alNMM3NaeXdHaXpDUld6MExYUG5P?=
 =?utf-8?B?TjRNakJYSTlXbkIyOVhTMHdGRjRVdFVmTXN6YytvdUxOQUR4MXcwbE5oYmQw?=
 =?utf-8?B?TDJlRnpzS1gvd2FRQTFidlZzcDZnNFpZMTg1RVlpbDFFQnIvU085SjMydzcv?=
 =?utf-8?B?SlZ5OWJ4YUY3TmNPUWlqdVNmYmlReVZMTDdMbXJBUU54VElSTFlnNnZzY0pD?=
 =?utf-8?B?MXBQaWNpOThBUVhNUHp6dTU5ZnhGYU5Xd1ZOZDNXZk9EaUtMT3IxUmxmNThU?=
 =?utf-8?B?OENneEF4U0UyckZQTUlmOGQrZEJHcElLSkVGQ3h4bHRtMXVNUnIrWnE5bmNs?=
 =?utf-8?B?NjlZdk1XVHc0Qy9YZXFvQlZOeUhYQ25hTjRHUkdaNk9ZcFhrQUFuNzdZaHVx?=
 =?utf-8?B?Z1BEeWtOMi9iMXJJZWlwNjhXSVJDY01rL0p5QTBONVZVQ1Jsc2YxTnlzSVlP?=
 =?utf-8?B?b3Y0Rm9KKzFndHN6MENhdGlhRGtVd1lzQ3pUMGVNT2VHSm0yclRmWXcyV3hn?=
 =?utf-8?B?SlBpSnZjZ0JuVFk3N2NQNkYvTnhrRmRvYldaNDBqRFRoK3JiS3g2aTVqV0NR?=
 =?utf-8?B?V1kvbjhmOFd0clRjUVEyZ3dzVTdXMkJ4dkFLVlFYemJDNXQ3WG5MQXVodXZV?=
 =?utf-8?B?cnpZR09LUDJMUVAxNWYvR2JHanVDeU5PYUlTTFVDK0RyOGpOOHlEM256dHNC?=
 =?utf-8?B?L3M0UmxhL2RxRjhsazQwTURuZmtJWTQ1ZWxQOVN1aUVzd3ZBZlFHeHl6YjNR?=
 =?utf-8?B?ZVRMeUppVWxpSDhDUXc3NmNSckpTZ2dKTHA2YkdheCtoSnFMMGlrTnV3RkNw?=
 =?utf-8?B?OXExMW1KaUhCWHFuak5XVXVBTmF3MEJSclFibUx2T2hYQkkzOWJobjg4Ym53?=
 =?utf-8?B?L24vT3krR28yaDhHYXNwNTRzUGxOTS9ad3VWODVKbUc0YmFMTmt5dUdHdzN5?=
 =?utf-8?Q?3SvsaM?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MWl2YTNUZWlsc0ZzVnNpWmlmbmE4SG11TlhsM2J6Y2RuZUN4S3ZSU3lTZ0Uy?=
 =?utf-8?B?NjhsSVhKNEg4QStHRVExZCtXMTlyQTlaK2Q1TlBZRjk4eEd6OVF5Q29kQmpL?=
 =?utf-8?B?cUx1M1ZyTVpVK3pZc0tVdnZHZlpBbDlsZ1ZsRyswc0ZZOWlCOXE2dU16OGtS?=
 =?utf-8?B?U1kxRHdpa0p0Zm5WNk9uSTkxdnNqMXhZSlAza0Q4MElTOUN1cFFpTEdmQVV1?=
 =?utf-8?B?VTczMHJOWWVZOE9Yd1Rvb0RmZWUzcXAvcXNkUDJKN3JVUUlCV05sSHo3aXo1?=
 =?utf-8?B?ZW15d3BCYlRac1J4S2dmek5mRVJkTlJFUHUrV1M3UGM1WWh0TVE2a2x0Vm45?=
 =?utf-8?B?NWlBSWpRYytYRDdiL01NYUViMFBuUmZreDRsMFVEVm45dVVhc0lnbFYzNnAx?=
 =?utf-8?B?MzB3VHVGUnltVHFGMUpVWVFTZ2lESVFGZVViNnZNVWpyWm83RkpweEgwM2xB?=
 =?utf-8?B?SUNHdnVwUnR4ZnJpQ1JKSDRBTUtJSVkzNVhPeGZVOExQT1ovdTJHa0N5RU4z?=
 =?utf-8?B?M1U5WEhseHVzam1XMGlleFkxd0VaM2hVTDRsaWoyN2hkMlhHY1Q5cUUzejAv?=
 =?utf-8?B?VHlKb1VhcWJKUzdJVHhEcmZSSG15aFloVFNSSGw0WWJXZWdWQm5xbFpwTG1w?=
 =?utf-8?B?M0lZYUJZVE9mdzhScjZEYnV2VGlFbHhaY3EvczAraHA2aGxJUkRwTE9qTU01?=
 =?utf-8?B?aUFib2xzeWMvT01OaVUzSlhjeSs1UG5xQlg0WWFxWFVqc29jWEkyOU40dnJN?=
 =?utf-8?B?T1FoOW8wcnB6cFVQNm1VakxFamFtakM3L2FJazM1TjNFZ2tEQktnK2tsb0xL?=
 =?utf-8?B?MGoxM3NwMUp0N1c4U2Z3QW9aUTl0L1d1eGRPSm9uTktnaGVqTkoxZGNEVzMy?=
 =?utf-8?B?NUpGSHJPalZjdEUzQ3hsL2R3emFwdVZicktGSUpDcUc2T1F3MXBlckJYZjBH?=
 =?utf-8?B?VWhuNGdwbXJUNXY3emd4ck5TRUVCMWFXeHBJWVFSQ3VzNVFYVzhiSUs5eGNH?=
 =?utf-8?B?dThzcldaQ096QmZEbmo1NnQ1dnFacWZRV2p2ellDOFQ2bjZCNFp0SUpCbXNa?=
 =?utf-8?B?MFFUM3Z5VmVTbEN1S0pBOUlqMTNnY2hSdjhzRmp1V2NIUW8rcm9BaDc3MjFB?=
 =?utf-8?B?cHpGYkF2NVdWWEtWdFo0MC9aYjRxdVMzRC9SQVBNaFZjNUtFb2gwQ3JwaXVh?=
 =?utf-8?B?ZzRCK1hHOEZFL3AzMm8rcExrTGRnNWJ1YU9QYWZSczVZeUtlOEU5eXFvTzYw?=
 =?utf-8?B?NXQ1K3d2ZkkvY0VGbVlHc3FFTEk5ejNwemVpek9tWTNBZk42a3N1c2FFb25I?=
 =?utf-8?B?QkVTTTdwNjBuckF2T0xFSlFPZVNhOGE3REZPWkRScUlEcGc5MU9wRjVtTlR4?=
 =?utf-8?B?REV6T3JHYk0xNzBoVEY1SXNCd293bENLWWdPVUVHQmVvZUVFT0dzYy9Yb0c0?=
 =?utf-8?B?M1RXS2NaenR0Mzl1MHhRWWV4bC9sQnptUEJkUStrZ004ZFVrWEZ1V1IreW9R?=
 =?utf-8?B?SWpJdWxadEtsdEZvNEhJaTZldjNDVU9RNXl5ZjhUeTZ0RDNIb3NkeFFPNk1B?=
 =?utf-8?B?OGQ4ZFRRdDhQTUcwMFk3bk5NRDVmMFF4QnBTL2IzdnRPOHE4UlZxbnZsR1Vk?=
 =?utf-8?B?VExnNWozamJaaEw3R2RWVHRQSVljemJsZ1ZFdWJuaWw1UlVNUHRIQ1NBNG1F?=
 =?utf-8?B?WTRZaVYxU2hua1gzYmt6ZVQrYTU4Z3B0QmV5bXV2U09lMzZnUHg4a3RyN01o?=
 =?utf-8?B?YTRCVXFDcm5VZ2x0YkVRcHFhSU9qNHhxb0F6c2xjanVrSFlhL1Q2YU90NTg1?=
 =?utf-8?B?dk1XMG16NE5zYUprNmhhb2plSzZNWFVqOWhBRXNySEcvekc0WFg3eUtva1ht?=
 =?utf-8?B?UUZud29EcXJVeFBsSERuK3ZVejRJM0xBN0FIQmtyVXJON25xKzIyRkNGS2Yv?=
 =?utf-8?B?YzNzQ1NwcG5CTlgrOXAvM0JXbU5uUlZUUnFRN096Y0FlR3NkMWRJa2NuZEZl?=
 =?utf-8?B?WkdrTy9EeUg5di9PeUpIYzNtOG9ISFdkcHRIU1dFMmpkVGM4b0VoazVGN21l?=
 =?utf-8?B?ZmdPTFd1YVpNUlVzeStVMTZGUXBmMVQ4ZkJ1ZzhINkxQRDBmM3dweTJxWW1z?=
 =?utf-8?B?dXllSXJrdW9rZWxMbVVQQzJrVEVVWCtCVVJQbjFqUDFTZlhUNjRnNThXMHg2?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97f986f-754a-495f-ae64-08de16cb1dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:11:16.8033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxNDeoZOlTuyWAp1lNOBJcJwCJiJETN/UOuq3ns0hlEsgdqkWZqyghot0AgxIJny7giEDRfUH7/vU8w0g/t3CDyGuzXbXKwaSQ9RKyDqw2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11525
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 09:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20269

SGkgSmFuLA0KDQpUaGF0J3MgcmlnaHQgQ0lQIElFQyBjZXJ0aWZpY2F0aW9uIHVzZWQgYm9va3dv
cm0gYmFzZWQgaW1hZ2VzLg0KSG93ZXZlciwgaWYgaXNhci1jaXAtY29yZSBtb3ZlcyB0byBUcml4
aWUgaXQgZG9lcyBub3QgYWZmZWN0IGFueXRoaW5nIGZvciBJRUMgY2VydGlmaWNhdGlvbiBhcyBC
ViBkb2VzIG5vdCB1c2UgQ0lQIENJIHRlc3QgcmVzdWx0cyBhcyBldmlkZW5jZS4NCg0KSWYgQlYg
cmVxdWlyZXMgYW55IG90aGVyIGFydGlmYWN0cyBmb3IgU1ZWLTIsIFNWVi0zIGFuZCBTVlYtNCB0
ZXN0aW5nLCBTV0cgd2lsbCBzaGFyZSBmcm9tIGJvb2t3b3JtIGJhc2VkIHJlbGVhc2VzLg0KDQpU
aGFua3MgJiBSZWdhcmRzLA0KRGluZXNoIEt1bWFyDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJv
amVjdC5vcmcNClNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjgsIDIwMjUgOTozNSBQTQ0KVG86IGNp
cC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPjsgZGluZXNoIGt1bWFyKO+8tO+8
s++8qe+8sCBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IEhp
cm90YWthIE1vdGFpIDxoaXJvdGFrYS5tb3RhaUBtaXJhY2xlbGludXguY29tPjsgaGF5YXNoaSBr
YXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8pO+8qe+8tO+8o+KXi++8o++8sO+8tCkgPGthenVoaXJv
LmhheWFzaGkuZjc0QG1haWwudG9zaGliYT4NClN1YmplY3Q6IFtjaXAtZGV2XSBpc2FyLWNpcC1j
b3JlOiBTaGlmdGluZyBkZWZhdWx0cyB0byB0cml4aWU/DQoNCkhpIGFsbCwNCg0Kd2UgYXJlIGN1
cnJlbnRseSBzdGlsbCBwcmVmZXJyaW5nIGJvb2t3b3JtIG92ZXIgdHJpeGllIGluIGEgbnVtYmVy
IG9mIHBsYWNlcyBpbiBpc2FyLWNpcC1jb3JlLiBMaWtlbHkgbW9zdCBub3RhYmx5IGlzIHRoYXQg
bW9zdCBvZiBvdXIgQ0kgYnVpbGQgYW5kIHJ1bnRpbWUgdGVzdHMgYXJlIGJvb2t3b3JtIGJhc2Vk
LiBJIHN1c3BlY3QgdGhhdCBhdCBsZWFzdCBwYXJ0cyBvZiB0aGF0IGlzIGR1ZSB0byB0aGUgb25n
b2luZyBjZXJ0aWZpY2F0aW9uIHdvcmsgd2hpY2ggd2FzIHN0YXJ0ZWQgb24gYm9va3dvcm0sIHJp
Z2h0Pw0KDQpXaGF0IGNhbiB3ZSBjaGFuZ2Ugb3IgYWRkIHRvIG1vdmUgdHJpeGllIG1vcmUgaW50
byBmb2N1cz8NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9n
aWVzDQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg==


