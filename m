Return-Path: <adithya.balakumar.f33@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD39C79FAD
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 04:11:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4038.1788927076516968260
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2026 21:11:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adithya.balakumar.f33@mail.toshiba header.s=key2.smx header.b=l9JRGua5;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: adithya.balakumar.f33@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=adithya.balakumar.f33@mail.toshiba;
	s=key2.smx;t=1788927074;x=1790136674;bh=xP5yS1+PdpaqTEsQ2u45+7aOaTBXpIGMNzhiV
	DZbvLc=;b=l9JRGua58WaZQOfFezrAy0CcowhO3FewsLhYqR46trI+kDAM9XIV8UNmz5IyqgZlg5H
	doefrDQWt9NtEBkm2hJ4bclT56SkTiR82ejz205oxh/6U79c7cBaq9pjkznBGkOUvfpjNqCcIqA3g
	HtEraPn0Rcbl09wXokI20F3WO2GoGp2dbhJqsvKC6zsxqA+0561LJ2nnTV91QAUQIjshPoMlmTj/S
	EIhdybCZrtE7Sv/b6ZSYpLREQXMMCGA176Rx/GL9KVgJdQnENwta7vliZKDCqCZqn/8ZjDBGtWPMl
	wgSBdLVei/66SHAp+TfMCS6bQ79SXpjFPOfC0wrAiFXg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6894BDqu2025330; Wed, 9 Sep 2026 13:11:13 +0900
X-Iguazu-Qid: 2rWhJyGID9Uo1jYdwx
X-Iguazu-QSIG: v=2; s=1; t=1788927073; q=2rWhJyGID9Uo1jYdwx; m=EzAvZ9ESovfp/DT97XKEmpI5MYuMreV7/VaCW9DrwfI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hfnRj1mkZz4vys; Wed,  9 Sep 2026 13:11:12 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez6Q1bzcGaWN3kFrjwbzMSsSdBkCwwFmrCq0KXo7KcVsrDbtRIMoRq7xcM/ZDBgD7E7AbQmQH3lZT8IcJzNmTQ8UUbC38XUv0IhLqOPn5Bosbrsc7QzUQKnP2+qdgIYAnjeeFOZNv8LjouqMe3TKMn04G7PMeDjMtL7M0PtaEEvKEtzEWwoRPF1bkQQxhpuysuh1jKFU2BRt9GJ9uOV23zpw048/cCJwmKZF6daMsmYIbVS3hTdT1X7oCnVpy+E7H4wOkLW8fV2C7ivW6HCLbiMvJwcdjIb8zmYi5x/ti02JSBVV6QdQAOLP067ydEy1vpPjU6QAPm/hHsysRgNtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP5yS1+PdpaqTEsQ2u45+7aOaTBXpIGMNzhiVDZbvLc=;
 b=N9vNyVt3Ex4ZajC4htwjHC+v1wsDIhEksSmnLUksKAamDbMBLGW8ARXOsHovAvDgeBVJMs4WdOGoQ5m1BtWygHS4IMeC8D149K0az+qxAZ0byabh15OhBq65FWFzKjWeDNLaocMXmAbuBNsb0ssvOAtG57XquFPO7PgZ8zFcYahey5sQ/d/gydLDQCIzdwnL7iXPqtr0nClI2JDRelTzICVFNgKORpgU7z5pcQgK2PEBUK5NHOUdj+d+6gWUP350DCezrB+3E2brSHvNdJJP+CCaP+pxaIfsEW9Caa9YXZdwH+eFhM5wGpAN347aK1MGeNbWp8vfzNeScBuAqVwddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <adithya.balakumar.f33@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <shivanand.kunijadar.v45@mail.toshiba>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] ci: Use debian:stable for
 reproducibility test
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] ci: Use debian:stable for
 reproducibility test
Thread-Index: AQHdP7f9udczEJjNs0Csrwq+1X/xVbbFA8+AgACdpcA=
Date: Wed, 9 Sep 2026 04:11:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB8819AA8B3062D5E097289CA9D7B02@TYCPR01MB8819.jpnprd01.prod.outlook.com>
References: <5e3f44e0-ad5e-45b3-9b68-b476cec7a05e@siemens.com>
 <44bb5467-186d-42d5-8e24-3789ad8a8b7d@siemens.com>
In-Reply-To: <44bb5467-186d-42d5-8e24-3789ad8a8b7d@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8819:EE_|TYYPR01MB15679:EE_
x-ms-office365-filtering-correlation-id: a4b190de-4eea-4cdd-6ef7-08df0e286102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|3023799007|22082099003|18002099003|11063799006|56012099006|6133799003|24072799003|38070700021;
x-microsoft-antispam-message-info: 
 WfhVU77KWOiVWJU+yfbksdQqpQvwjLBUCeBGMKhsHELe+2DU//sVrt637i39zZKUURBvpPNAxpsX3Z7s1kIvsMUiYBbB+OoXO74nJ76tys+la31/lPNmo+jT2bvkND+0LItqoNsFbjMXVg6O8vLQOU4O+XkWRZXqUCTA5Ge87GuTac2NygFEZF2UIqiRtAWoesffGpiNzQ+sM1pCfBRJpRzjryhajLFFea/EBzurUN9n/ZJN1Rz7Q9LC3NFXeRW/0t8zQEA0IszirWTFvWGXmt/nJaMhnuRZRoMyPpAFJaETFvmE45mByVVqj2PA/cDfiZJ7j3JYMJ67yOHHRxfRZdYrxMx9RTcAUmATcVylyBg5hEjUjaQKqbrwPXzZg1qrHivHY029Xbb175Xf7/FU/aAiHI3qWIgUqkeEjm3RRamtBm5ynBlS2IFdHr9k1ESVVrP4ZkVmRZkG1uqOrYmczmmTfPwwbdRufXvBAZda0BAo17Kvuk35usdJWS1vBSRRvW2rPZKIGwE5OAdjuftpA2J2uXJEwGXxancZF1buemDQWFsLPFUY1qFLCZltkvJL58oE2RwZDy+SYjlfqs4kkRYVijI5VY63VymU1P0UBoNIp7KWNJW0yHnDNxfuD9kSpCp7zNuNgJPYEuVuzkZ/92+cEq6n+zhPiIYWR14jcPw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8819.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(24072799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WVdzVlphRE12WThhNDQ4dHlxKzZmMFoxU1ZsYWQvVkhqaTlReTljRjRuWlYv?=
 =?utf-8?B?d0V4NE9hd0xhaHUwSlhDeGxqZ0hIbWoraEIxNm1xMytDR1hYNWFHeFVsTEla?=
 =?utf-8?B?eFRPbitMYUx5VjQ3UkU1YlFWNGtkZXdzVzhWNkNuYkRVTDFMeEV4NG5TZWEx?=
 =?utf-8?B?LzlRbEM3Uzh2YkNjd1ZMODRNVWJnZC9zTEVLYXUySndUZm9PRnBmc3pxbERy?=
 =?utf-8?B?aXh0MHFrcmp6amNaRnpEWVgwSHBuU0hTVUVGd0M4Vk5URmI0MDd5cjNuNDhV?=
 =?utf-8?B?THBrZlJwRVBUWVBLdHFTQ3dmQWxRZXozQ0pzU0tXbzNSUmVqWlRwYk1JMGlx?=
 =?utf-8?B?YnZKbG9RRGRpa3h5NXp4UUVUOHhPSzJLejRMZFhvVFZZTUhablRDalJaRGJR?=
 =?utf-8?B?dUdNZzlGWU9vSllpdWtUT2tIQXdhMzdzTWNDcGlKc3NVZE15MFFJL3RoUzNl?=
 =?utf-8?B?VU5jREtDZi9jcjJYZUN2N29JbW9sa2Vnc09yVkVGUm5IcGNKU3pKVnRBbElE?=
 =?utf-8?B?N25HWExkbExqVVQvVUlIdGtlK2NaYjlsTkZ2dE92MkxqL3A0ZGdPM3htcTJ5?=
 =?utf-8?B?RU9jeUxUOFhvY3FWV1VpbTIzOSs1M2lYTmlBTGEwbWNaL2tta2YrSm1VMHNi?=
 =?utf-8?B?ZzF6eWZJMkdpclUzeThEclVKdXd5dVFiQ1JDZ0I0V0Y3Mko0VEdTK0s5Szd0?=
 =?utf-8?B?UGw1ZzRBY1FQRENwSWY3bXV5N21ReTlGM2hCQXpXalpkSTNDM29lSmxYYkRI?=
 =?utf-8?B?dUNVdXAzR29jOXM0ckQrelZKRWFLN2xCMnV3a2ppM2lZbzdMakNnUlNTekt3?=
 =?utf-8?B?OUlsZjhRYzMvVHNVVCtWSXFTZXRWcnZic1c0T0gvL0YvNVNySHlUZGg2UmQw?=
 =?utf-8?B?ZWM1WW03SDFXdVRMWjhaR1VGemVWN1MzM0F4M2tiTU9wU2dWVFd6MHpuNnpP?=
 =?utf-8?B?K0pSOW1JL2dhUE9laFpkU1RHdFNEaVZRSi9uWlhrNDdvQ3NHdjQyQnZqK3hY?=
 =?utf-8?B?d0d6clBRRlY0c0dGT2J1UHNEZDlacExwVzZ6elAwdG5yL1BreUNUNTM2NGlN?=
 =?utf-8?B?WXR1TXBOOGwyNjFNUDVtek03bGpGalorY0JBaHJ6bzNjclJFTFh4RWc2K2ph?=
 =?utf-8?B?elUySk5KSUp6M2wySHBmNGNVSmtmWkJHUzUyOWFYM0dzd0xYR3o1WTRYRXlM?=
 =?utf-8?B?THZiN3kxWFhSQ0JWN3lKb2d3VXNrdHVFWC92QjhMVEI3OHZGeTgwY1pIVmNI?=
 =?utf-8?B?Sks0UXlpRy9Zc1JCRmNOdXdPUjBKV0hjdyt1MWxwRjJSTU5yOENZNVdZc0N3?=
 =?utf-8?B?MFdKRzdhKzN3Y01YMUp4a1FEVWhYS2VqQUxJOEZ0UHVHb3hoUDI2NHRlVGZD?=
 =?utf-8?B?VHJXRFQwMWtwVUxpQkJ6ejNoRGpaOXkzMDV5bm1pVE9adzBjb1hFVHNLSDY2?=
 =?utf-8?B?dUtNeUluNmFXRWZxWno1RXV3SnFMN0p4ajhHQkpva2VsZll5ak5vdjE2T3BI?=
 =?utf-8?B?UnQrWHVpOWJPT1FQY0pRbDdWeGdjUjN5NG1uSGtNdE1HK1k1NE9kK2NyNlYx?=
 =?utf-8?B?QnlweUpVeTVzS2pyV2sxejdUR01zbFRvRkJUZEJUdFZ2dmtZSTc2cHlEd3M3?=
 =?utf-8?B?NXd6eWRubXhMd1FTT3pkWDdNUXp1MEJycDE2aC9jLzdJenpQQzQrYWh3TDlw?=
 =?utf-8?B?R242M1EvdzA1YWdaWXlDM3VKSE15QnJ5WUdpS2ZZcHZucjhsSUhNcVh0VzVm?=
 =?utf-8?B?N1J3aGZJYmxCbVVjaWxBSnh5anVIKzR5OFBpUjk0b1B4YnRIeE5kTmdhdTNs?=
 =?utf-8?B?ZnhQbWpwNk9Bd0VXSno2QnlaNmRLTGRrS0QxN2VmU21HWkVTZmJvUkFwbndi?=
 =?utf-8?B?V205U1ZzTWJnak9pZ0pGVHRLTGE2Q0IxN0pnNXdxSkhNc1d0d2JhWkx3ZENk?=
 =?utf-8?B?ZDMwNDU4MkhaQ0d5ZTRPNUhjei9kTW9rRXM2L212WS9UdHFFWjdWN2tJQXl6?=
 =?utf-8?B?cURpcXl1YUoyemZ5THZCVnpxSHNpR0JQbHhzUTlMNElGZC9xZEtaeXdsV0ZS?=
 =?utf-8?B?eko0UmNmVWtVbVpjUWVVQnl4d0ZiN0IyZnc2aktCcldXTXUvbmpBbWdzRElX?=
 =?utf-8?B?aHB4VmE2SUplQ083NS9ZNFRyWk56S28yVkJ1NUtqcFA3elA4ZmZkQWVZVWRI?=
 =?utf-8?B?NEhoR1FvL0JnYi8rT1VCWUdrYVZidTEwMElvU3VFRFZNejVjbCt1WW9HNzV2?=
 =?utf-8?B?UStQa1FxSVVlK29wSERRQ1FYMk83TndGTHFIWlpzbEtGRDRBeUszbzdYaXdr?=
 =?utf-8?B?dWM1YVRneW1wM21LQXM5RlM2OERkc0lIUm13MjJMQ3RYRlpBZUM4YTNrWWRO?=
 =?utf-8?Q?+MXYapxLN19QcIA8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	UlotlFGEt5msX7Ej+HF7FeMDEFjwkIBtrOSi3CgA/CgiPFHvaTCHw2w6FAIue0KYMSKzEw94Uv+exZXiAdwGCxersn4lBp7pWLlEF2d9ijB/YSsvRI7+WxMDen1UqeKMR4BBXCHBYkRY4HOgqUoSvH4oFycVnn6evdKOn1G56vGXicLZkcCTpF313OvL3VmfkQdm5IKtSJJWw/cpSTJdsZniFlzrITRUHRB3097ZKD5kJ7l2KjbGWB3nE/9EbsIcCypsbH8BitUGneqEt+9PAB65zrVwWT1fqUotmGszNgJ+ssCNb0j54sM+OCVDDqkWHQ/IKGy2MhAts4JX30WRBQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8819.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b190de-4eea-4cdd-6ef7-08df0e286102
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 04:11:09.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6YzH5CR/eBdSwy9ySEK6i7pCY3XGAouW0vpwJr7vxqtVNCZ0sIo+ODTdwcip6MoxWWLgArWkoUzwmkljsULgrodNBcG1r10K+geY6/4pdjzzrBol6wjGnWDWVmYSsAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15679
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Sep 2026 04:11:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24106

SGkgSmFuLA0KDQo+IEFuZCB3aGlsZSB0aGlzIGFsbG93cyB0byBydW4gdGhlIHRlc3QgYWdhaW4s
IGl0IGlzIHN0aWxsIGZhaWxpbmcgaW4gc29tZSBjb25zdGVsbGF0aW9uczoNCg0KVGhhbmtzIGZv
ciB0aGUgcGF0Y2guIEkgaGFkIHRoZSBzYW1lIHBhdGNoIHJlYWR5IHRvIHNlbmQgYnV0IHdhcyB3
YWl0aW5nIGZvciBwaXBlbGluZSB0byBmaW5pc2ggeWVzdGVyZGF5Lg0KDQo+IFNvbWV0aGluZyBp
biB0aGUgRUJHIEZBVCBwYXJ0aXRpb25zLCBhcyBJIGFscmVhZHkgc2FpZCBpbiB0aGUgV0cgbWVl
dGluZy4NCg0KWWVzLCBub3RpY2VkIHRoZSBzYW1lLiBMb29rcyBsaWtlIGEgcmVwcm9kdWNpYmls
aXR5IGlzc3VlIHdpdGggdGhlIFVLSSBbMV0gaW4gQk9PVDAgYW5kIEJPT1QxLiBOZWVkIHRvIGRp
ZyBkZWVwZXIuDQoNClsxXSBodHRwczovL2NpcC1wcm9qZWN0LmdpdGxhYi5pby8tL2NpcC1jb3Jl
L2lzYXItY2lwLWNvcmUvLS9qb2JzLzE2Mzc0MDMyMjQ1L2FydGlmYWN0cy9jaXAtY29yZS1pbWFn
ZS1zZWN1cml0eS1jaXAtY29yZS10cml4aWUteDg2LXVlZmkud2ljLnAyLmRpZmZvc2NvcGVfb3V0
cHV0Lmh0bWwNCg0KUmVnYXJkcywNCkFkaXRoeWEgQmFsYWt1bWFyDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBsaXN0
cy5jaXAtcHJvamVjdC5vcmcNClNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDksIDIwMjYgMTI6
MTEgQU0NClRvOiBjaXAtZGV2IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4NCkNjOiBr
dW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8sCBESVRDX0RJVC1PU1QpIDxzaGl2YW5hbmQu
a3VuaWphZGFyLnY0NUBtYWlsLnRvc2hpYmE+DQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2Fy
LWNpcC1jb3JlXVtQQVRDSF0gY2k6IFVzZSBkZWJpYW46c3RhYmxlIGZvciByZXByb2R1Y2liaWxp
dHkgdGVzdA0KDQpPbiAwOC4wOS4yNiAxOTozMSwgSmFuIEtpc3prYSB3cm90ZToNCj4gRnJvbTog
SmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gDQo+IFRoYXQgc2hvdWxkIHNh
dmUgdXMgZnJvbSBmdXR1cmUgc3VycHJpc2VzIG9mIHN1ZGRlbmx5IHJldGlyZWQgcmVsZWFzZXMg
DQo+IHdoaWxlIGFsc28gcHJvdmlkaW5nIGEgbW9yZSByZWNlbnQgZGlmZm9zY29wZSB2ZXJzaW9u
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNv
bT4NCj4gLS0tDQo+ICAucmVwcm9kdWNpYmxlLWNoZWNrLWNpLnltbCB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhLy5yZXByb2R1Y2libGUtY2hlY2stY2kueW1sIGIvLnJlcHJvZHVjaWJsZS1jaGVjay1jaS55
bWwgDQo+IGluZGV4IGRlOWYzZmJkLi5mOGE3OTUyNyAxMDA2NDQNCj4gLS0tIGEvLnJlcHJvZHVj
aWJsZS1jaGVjay1jaS55bWwNCj4gKysrIGIvLnJlcHJvZHVjaWJsZS1jaGVjay1jaS55bWwNCj4g
QEAgLTUxLDcgKzUxLDcgQEANCj4gIA0KPiAgLnJlcHJvLXRlc3Q6DQo+ICAgIGltYWdlOg0KPiAt
ICAgIG5hbWU6IGRlYmlhbjpidWxsc2V5ZQ0KPiArICAgIG5hbWU6IGRlYmlhbjpzdGFibGUNCj4g
ICAgdGFnczoNCj4gICAgICAtIGxhcmdlDQo+ICAgIHN0YWdlOiB0ZXN0DQoNCkFuZCB3aGlsZSB0
aGlzIGFsbG93cyB0byBydW4gdGhlIHRlc3QgYWdhaW4sIGl0IGlzIHN0aWxsIGZhaWxpbmcgaW4g
c29tZQ0KY29uc3RlbGxhdGlvbnM6DQoNCmh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9j
aXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vcGlwZWxpbmVzLzI4MzA0MTc1MDkNCg0KU29tZXRoaW5n
IGluIHRoZSBFQkcgRkFUIHBhcnRpdGlvbnMsIGFzIEkgYWxyZWFkeSBzYWlkIGluIHRoZSBXRyBt
ZWV0aW5nLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dp
ZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


