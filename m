Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BBCC433EF
	for <webhook@archiver.kernel.org>; Tue, 18 Jan 2022 12:36:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.11942.1642509394860774442
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jan 2022 04:36:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 20ICaV7Y021848;
 Tue, 18 Jan 2022 21:36:32 +0900
X-Iguazu-Qid: 2wHHOe8oPr9jo1r5nc
X-Iguazu-QSIG: v=2; s=0; t=1642509391; q=2wHHOe8oPr9jo1r5nc;
 m=wfxFoZBX8WbNgJ9x/odiifbo39rEzODYLPifhgXeb4U=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 20ICaT0a021147
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 18 Jan 2022 21:36:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoLJD+0/97fh1NEyWyRWdZa2xsgIJ078eiwyhcM+glEm+RqQSRzzlpA6lpxQ8qMEA6wC43pTgKlM6KW1uPpE/BRBfXoML6qnjouE4yNSn8JFcJvjDe+8POslgZO8oDKmnJyvxE5WuQq6NOcbrSqGp43wyLU6RnFhB9LbaAxZ9KGGgTZ163oVY37uVKZKKlY+XpsBiRG/F1KSMcgb/TxU2EebvkCy+4kqix1l6DKsMohiKNuZL4EvrOHJpaHDkjhJ6Ww6Xz8EobHam+AU6xcILyNxB5bU4z3I6JdhyIlcje5e0HmeriHPNF4AEoVI2DmrmhGPjAzePaPfmheYfWm1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uicub63UUP6teltjggAMS5USKhP+PXdA5vCLhvdp4o=;
 b=OcPI+g70r2a+r5oHYClFsA57p/yrI6ymvq8ePaIoKuZsQPs0uBdxH0+I0kcXjme3lxzWtXyoNi9HTs82WVAg6j7x9GlIXK7prqYjWqNy9e+3RApoEp6uRrncGUbbsZ8FQvXxlWnt5YK+2w5APLzG9FnKLVJi/VbG6jJHkVZ8J4ZouDdFgwnXARZ7zApUjCETvdJg0vZQNZXoG/f4mHTc4CbvwX3Ib284Y0yoZvDD+tUacNMlT4nkD00szSNQUu3K6WZD/c3ef3kOF+31SSSwSVSTuw++UMRdY6Ah0/Dq3Wsd26q+C1iYKODZyM0y2N76qHn4nuiMHKgVjpC4X/9NEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Preparing a container for kernel compilation using the Debian
 compiler
Thread-Topic: Preparing a container for kernel compilation using the Debian
 compiler
Thread-Index: AdgMY9eyAPGayKlPRVGrKjqb5zpAXg==
Date: Tue, 18 Jan 2022 12:35:57 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB6252AFDF07076F430E2CD1DC92589@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce8d2128-bdf9-4796-1028-08d9da7f13e9
x-ms-traffictypediagnostic: TY2PR01MB4233:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB4233F2A7F94D84113A11F80392589@TY2PR01MB4233.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cc4d+k3K86l+FlWXVAUXxHvyVcHl2/bqjDv8WS6nJldRF3IiR+rsw9jQ9xo1CslAm/bg7EHyTFz+JU3MCJY2wps+33JOAwdWtAn0tPxw8nqWOtkziJwzI/GhGGkTAXjhljiAsTpJ/vxeF73/JM2Gd+09z/McUR7NC0UtMfaft2HcFuodOcdznjyd1zLgrYOQrxLL4dBndaEwQui//juRHJ79IAi+nsvI3vu7OqSXSQNhGTSbSOZvmKEmv4fxgM0ERxKa4xAewHPTrhxGAkgIkRcKmajU3D7YfASyiGuYxuKtsw1PpCVGMCvgNDnlyNmTCYrXLvj0dFVRtjWCc5iAXBczsltf1xEi9Q8hmAqAcUEIcdZ2wNWVZ+cRSSsKf4SPgEB6mTry9Xx6TotHmsXUgtG5rnMuMTiSUvpbU4CTrQ+7tys5qnjNFaV2l9Z6YWcVoLLhaQP2l0uChhCMwbJ16pB7DA58fqv1MtwVqzuz1VIBAX29+xbX6p3Ja69PE3JnaWBJlk8ly/TtT3aaVihbBPqioH5fOFf5ehZmIiwddT/gNRxZF+D7QM1ITwdGp6QHeEg1wzKb3qBhyRcgUZvfRVpRWaYAbRHAxgQL+3Z/yjMfN3AAst/OT1OKqixtDxYPM95Rpmf7hgUsxO+uSPcY8/VivyCUzJ2zB1Q/pfdkGC97iF/mX7vbl79+iG30G71tLQpWayZBY7hJlLUTf7nwZVV9fMUneYNpSFOxAeaNO7oXJ98VVqF+KhnefWPURxvCK/buBP+uISQGUvqdE17dBnkKvNjq5aNghFinOHbBkVTjuTxBTSFRKxu6o2GI9GvKSDDTGf5cyRSuwn2z0jG/Bw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(38100700002)(38070700005)(4744005)(4326008)(71200400001)(66556008)(9686003)(76116006)(66946007)(83380400001)(7696005)(8936002)(66446008)(6506007)(64756008)(8676002)(66476007)(122000001)(966005)(2906002)(186003)(52536014)(86362001)(316002)(5660300002)(33656002)(6916009)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NTVaeFBkTWl6akE5NXNibnNqamJKYytDVHhWb2IrVDVEOWlXQVNtR29Qbkh2?=
 =?utf-8?B?bjE0NmxFY2hrYXY2NFlndGFlNEdBdVdySnNqdDlEUzhvcVpkckJQR3V2dGFI?=
 =?utf-8?B?U0tGSnFZWmZHazZBZlllNHNRbXpCOWdMYjRaU04yVHBCd1JvTVRBbE5JWmRF?=
 =?utf-8?B?V3lrWXFwZzV1a0pqcHlCL1NrVFNnSjU5c3hWU1dWZ1ZzWUxQUnNxSExsYjNT?=
 =?utf-8?B?dVdKcHk5bE9XcnBVNURqdmJ3dFBCUEJ1dWpWbDAvMUgzVndqMzB2OXJzYXA5?=
 =?utf-8?B?cUZ2RFVTWDJVbncyRW05SFdSRW42eUZjbk5rbkpPT0RUZ3FvZ2dZQ0VRS2s1?=
 =?utf-8?B?VWxVa3dvdENXRndNNW5IZkNpc0tmTUhNRjdyMFowYnN1dnZUQ0xHUGxsVmNJ?=
 =?utf-8?B?enJybWxvYUN6ZmhCVERaeE9yMUg0VUVZVWEyRVFVeDVnT08wcDZVd2c0Njhr?=
 =?utf-8?B?K1NOOHI4RndxMEF0VGVWMU4wSWNmd1hNeWZRTFZnazBWdGplWHFUWVdGVFRt?=
 =?utf-8?B?VDV6NnVqaE0rWFI3aXBja0c5b3YzUFV3ZThTVlpFVHIvOVlVZ2IvVFYyL2d5?=
 =?utf-8?B?UFdqTHRWNlFhd1BKNjdDMVM3a1RJR29DbXU2a250ZHg2L1BZNkhIOW9TVWpt?=
 =?utf-8?B?N1pGZThlR0g0d2c2dlR0NEpCYitHem5OZDF5NFhrQTV2MS9nMVRMMExGQlJJ?=
 =?utf-8?B?Yjg0emRTa1NyL3IxNUxWNURaUXltN3YzeHk3dndUMlN3Z3p5NHV3WjU0SDhq?=
 =?utf-8?B?MnRxM1BpSi9tQlcwTGI3Skw0K2tCeVgyUmxrUkxua2NmNG14UjI2Q0REWWFP?=
 =?utf-8?B?a1FqZXdIdzZVNHM2VmZ1KzhZTzYrclM2VUtBbVJ3UWNWTzQxdS93MjlNKzEx?=
 =?utf-8?B?R0RRQ3VLTlpVUnNWUVZ1SnNaUytQS0tGRVd1T0h0L3FnbjR2MnhIRHNualh5?=
 =?utf-8?B?MUlxOW4waEdRK0daaDFZeFpBY2tORXMwZ2JzV3dJeGlPajN1V0xwTkpMSWhu?=
 =?utf-8?B?K3BqeXU5dFF1cytkWDVFdVR5TU5LMW9FOEZwcUY4MHJpQTNVY2IrWENkcjc3?=
 =?utf-8?B?OXFwUnFtQ3pqMjVxbW9YMHUrN3hWb09qLzl5RnpvN3I4bmVpNzk2SmliN3ps?=
 =?utf-8?B?YzlPSHlVeDVmYkVuaGswb2t2NGlCQjdvZnJ6WVdmU2oxVHV2Y0FlMlZ2U0dU?=
 =?utf-8?B?b2tTeDltNUFXUDJRKzErRWkrVWtYWnIvcTRZelA2dmxXQStFOS9PUjZXQUNO?=
 =?utf-8?B?dnFQM3o3L2M3VnYrdlZ5dFpZS1N0Mit0eFp5Y2RkeHNYbUJReEE5bDVGR3J0?=
 =?utf-8?B?NXdENjZ3ak5JUjAxdDJyRHVabDFJVnE1WEdIbkFYUFVvem9oUlRYakFYaFV1?=
 =?utf-8?B?ejI2RGVFR1VzRVNCam5BcERycTRleDFUdWZnTXhpd2VUQ1RPQU9HWGhlN2pl?=
 =?utf-8?B?ZTNtcDBkdmd3azdWU29FRkRZKzBGUzZGSnhrUkxwNFNXamsrckllcW5wZms2?=
 =?utf-8?B?aUorUFRiV0xNVmgzTGJZcEx4RWszb0FLY251TzFQTnk1Mm1pb0lHLzdvdVNk?=
 =?utf-8?B?eEFpWmR3cnpTQlY2dGhEYTdseUxheUs4bC80K0pWcEdVQlA2bVVsekxya2Fm?=
 =?utf-8?B?YjlYb0pqZFJTR3dyQ3Q4U09OMDBvWHNjSndMVDhUdmM5WWpuZk5ueVlsaXZt?=
 =?utf-8?B?M0d4dHMyWjZ2dzI4Mk41U2RPYWF0M2NnM3V0bnBjWS9YV3hIOWpqMXdKWDMr?=
 =?utf-8?B?Q1VPdTRaQmdsc0M2eldDcXlnUkYvaFAxWG41eE9naVZmbVV0ZTRuVy9RM2Uz?=
 =?utf-8?B?eUwzbVRuRzFibmVHc0pDOWFQS3hPeFExTzJidm1EQ2Z6N0tUM1VhUElkaG00?=
 =?utf-8?B?eFVyYW5QTjdyK3dUQVpnSjBoL0dFaWRwbW13bUVWbUEzVXJWMGJUV29Md2gw?=
 =?utf-8?B?MGpmYzJodkFhMG5mazJueTZidEs0YzRucEVrRzJoT2xQY0NBVUI2T0MzRGVk?=
 =?utf-8?B?TFJxaG9DWFJ1L1Y3T2tPUFYyVG50ZjBQK3BUTDhMTHhyWmVHclZFKy90TW5k?=
 =?utf-8?B?Sko5QnNyWmx5eVZ0bzNLUTROL2Q0RnFVOFB3WnhoZVlsamg4TWhIV0djV1pB?=
 =?utf-8?B?WEkwMVVSbFhLZ2x1RW5CTkFHWTFtL0syY3I4UE9ZWnlqb0dubitHbk13Sito?=
 =?utf-8?B?U3BhL1F0TElWVEtHS2FUekFaMnE4akRjYmI4cGJUN3Brb0tnd1QyRDVBQm1z?=
 =?utf-8?B?Tm1uYUN0MUFEazZ1d0ZKNlNPUWlrTnBnVDlnbUp1c2xmb0tBSHdnbk02dUs1?=
 =?utf-8?B?UHp4dktQRjlOaHJ5QWljNldYNURZVFJNVU1wL09NMFp4WWluLzJYZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ce8d2128-bdf9-4796-1028-08d9da7f13e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 12:35:57.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 qhpY/bbH1pPN9/sEtpTpno4p+3O+3Y2gT32Up9jjQVccnDhEWOvTiOPt3xWHQKnnrel7eE6cv1LoppP1MlDwjqzW9YY6EJu4DOhkVyCK2gSdmpetJeu8MNa/ZPiLROnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4233
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jan 2022 12:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7465

SGkgQ2hyaXMsDQoNClRoZSA1LjEwLnkgdHJlZSBidWlsZGluZyBpcyBmYWlsaW5nIGR1ZSB0byBh
IHByb2JsZW0gd2l0aCB0aGUgdmVyc2lvbiBvZiB0aGUgY29tcGlsZXINCmN1cnJlbnRseSB1c2Vk
IGZvciBrZXJuZWwgY29tcGlsaW5nLiBUbyBzb2x2ZSB0aGlzLCBJIHRob3VnaHQgaXQgd2FzIG5l
Y2Vzc2FyeSB0byBwcmVwYXJlDQphbiBlbnZpcm9ubWVudCB3aGVyZSBlYWNoIHRyZWUgY291bGQg
YmUgY29tcGlsZWQuIFdlIGFsc28gc3VnZ2VzdCB1c2luZyBEZWJpYW4gYXMgdGhlDQpjb21waWxl
ciBhcyB3ZSBhcmUgZGV2ZWxvcGluZyB1c2luZyBEZWJpYW4uDQoNCkkgaGF2ZSBjcmVhdGVkIGEg
Zml4IGFuZCBNUlswXVsxXSB0byBzb2x2ZSB0aGVzZS4NCkNvdWxkIHlvdSBjaGVjayB0aGVzZT8N
Cg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQpbMF06IGh0dHBzOi8vZ2l0bGFiLmNvbS9j
aXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1jaXAtY2kvLS9tZXJnZV9yZXF1ZXN0cy81Mw0K
WzFdOiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtY2lw
LXBpcGVsaW5lcy8tL21lcmdlX3JlcXVlc3RzLzI1DQo=


