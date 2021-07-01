Return-Path: <SRS0=ZzJo=LZ=lists.cip-project.org=bounce+64572+6590+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0905C11F67
	for <cip-dev@archiver.kernel.org>; Thu,  1 Jul 2021 23:18:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F044A613BD
	for <cip-dev@archiver.kernel.org>; Thu,  1 Jul 2021 23:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F044A613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6590+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id itSrYY4521723x9R0O6w5Mhp; Thu, 01 Jul 2021 16:18:17 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.2561.1625181494648730473
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jul 2021 16:18:16 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 161NI7fe025828; Fri, 2 Jul 2021 08:18:08 +0900
X-Iguazu-Qid: 2wGqmO4t0KmbNc2Dfl
X-Iguazu-QSIG: v=2; s=0; t=1625181487; q=2wGqmO4t0KmbNc2Dfl; m=PXnuJRFagz0itBn4LPN1zaEuoVlxT7coNEoOwvepL6c=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 161NI68Q022903
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Jul 2021 08:18:06 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 87A3E10012B;
	Fri,  2 Jul 2021 08:18:06 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 161NI52x031586;
	Fri, 2 Jul 2021 08:18:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3ydW0kA4W+wCBMQIy29yz6n2SnctoUUqjn1uZE3FhxoOnSC5I0PO5IyLc8X9rjaGW6Oi05xEh0hd88UVws+n7JiSxGaWcHzKkIMOz87JMqOMBHFSbrSxuADGUbCI/UuJyqplaC/UYevyxfTMPk+TQr65ftg4f5/8nVaYZqS2bzTr8hcIORvJm7C2CD9zL6pM+p09D5RE8034jM40HJHS3UiX9Oj1ElE0dDQY0lyQe5lSFsft3hmCcp+crwHR7fC7Fi4PcwUTCCLhL79CRsGlNLXdajac+/ZaC2z/slDuuz/QSigMRg6eUP3s9MVk1FmffgDS/tNnsvw/S3L7Y8ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsF6bdv5fdnCQqz+uc7sWtrVtvfprjn+jETq8hGJsIw=;
 b=jLiWZirF0UeX1RsqeW6WC4LRkgvEarIuWlKsri7Kx2L9NQpGuAbDGGexXi+JHlxcsisKL/1od4aFtEzUMjviES5eW71jgcQXc3wUdO3gOO7zao80aOMiXjwtIXc7rBpYraGF51QsjV5uOiQ7QfDGnc6E6vcTAcvilYu7Xm4lrUsHcf8mGaO23jkeTvSUH6xtOwYC5xp3NSqbxZ1mjcIdbUItE7NZLOl9kBWgVaqbvM/Q4GrO0NpbHJhr0niRyoRz3CmQwFhcomzHCpBDBDl2pj1Hoau3uT0BDfbRuaidpocUACctSYdVKodQhBvMboV8ZOz0O7dCDR5puPiOXw3buw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <masami.ichikawa@miraclelinux.com>, <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>
Subject: Re: [cip-dev] cannot push to cip-kernel-sec repository
Thread-Topic: [cip-dev] cannot push to cip-kernel-sec repository
Thread-Index: AQHXblsx++i51107kkq3TRJw/9+POKsuwWBA
Date: Thu, 1 Jul 2021 23:18:04 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62526A8771F8EE626C4599C392009@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <168CAFBE1BE94C78.17502@lists.cip-project.org>
 <CAODzB9rLz=+TJLgR+FQ2F+1yKpJjitGMhqK4G4zVn45PcXDytg@mail.gmail.com>
In-Reply-To: <CAODzB9rLz=+TJLgR+FQ2F+1yKpJjitGMhqK4G4zVn45PcXDytg@mail.gmail.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be217cc0-18d2-4d92-da0e-08d93ce67ab1
x-ms-traffictypediagnostic: TYAPR01MB4318:
x-microsoft-antispam-prvs: <TYAPR01MB43188879984E372FE2B42F3692009@TYAPR01MB4318.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4hNqbVOEyevlePHZW2zkFqCYcwxbUd4QIVK08zGIS1nDfkaHBa/VCl7LkoJK6lDP+lXh94f4uk+/GB/wib93q1c5xRB4wPHmZszErn0YV966oZFA8w90qvtTLskUxf9+qeVDGertAmKex++bekHcCF5hnXfcw7c03EcLugs8TYlmvijweiH0dd1pEeQwEP+h+t4JqlVgn9SgrifZjGgqS7YayMkPeZPBD2eZw+YNPRLJaydi+H9xkuqwCe5HKh/MkdiH6xogosDQtt8PRM0fv45mTJVMZcqwHuzQlY5xTILyfNdJF2OCZKqEfR5ApXoHMVMWbVkBikVyNGwSvP10WgOOMA1A1BIAJZaoQIUl89Mb4yY/Ch66G6f5T/yOJLSGfdvVsPcCjiGYEZS7r4/9gtSiYlUteRkeEdsbmtb3+bTdNAIg9DGNaEIGOgszYjWgN5EjtsLENMHmMQ+qEKWeL0FstvDZi5NdpR9bT8pajCuucCDOBXCIZ/5v2FA8y55ZQvEjZJ2aj1QEmJ85oB2rQD6s6BOpT8iJvugxXdhlvt1fHBwB5f6uLGoowy2eyKRC6DNbDqDeOkoVjYGgh3lwe02TcqfgN2Yl28Qym1uTE0yMOV9eyxZu6O3St+KDtJHz/LDZmN62Xipd7gyHa+44PO8ndv+hDu2rROvT5gVmc4iUjpvp8AgNC6vGJKjG3ApqnfJySimhIKukxqyBDWGV+LGYljCznpvyYJEUofjau0lZCaakHXj25Mt9ndanOeYb2GrtUoKoEBHOszKBQYiBHJMz07lfD13gKVMqu/CmvNivT8j2FCap4d8c3eFIRRMA
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlRUblZmQ2lUOFc4MkNwWE8vNVpPYWgrSVdaQjh1WktpMGFSbUozNG1WaG9Q?=
 =?utf-8?B?dk1hME5xK2hqNEo2aE5VZURnQmlLcWlFQis5UVpKQjRtNlVTeStSUWdra3FS?=
 =?utf-8?B?TUUxU05tdXRUVmt0S3dxTVM3TEVlOEh6c0dQdUhocHIzdWpLbVhNaU9acDBj?=
 =?utf-8?B?c2Z3eWtHck9nc3V3NlZHY2pKV1ZZRHFmOFJacmV3clVmZHJWMk1IYXNzWHND?=
 =?utf-8?B?M2U2WHE3OFp2WU1YWnZ1TWFYY3BPNHRrTUJLbnFkc1owNUQyT0FPZyttNXpo?=
 =?utf-8?B?cjY0Y3NocmNGQUhXaUZ5SmZ1WnloVFV2U3dpdzdXL1d1cHRtYWtzb1c3TTVz?=
 =?utf-8?B?U3dSRGxjdkxoMjU3WlpPTDYwQ1lmYmlhT1dDMjdjZ1c0eS9icnM2RldsSjRQ?=
 =?utf-8?B?SFh1ZWxyS1hMSFBpYjdLWTlqNXZldEg5cHEwZHE2T1NWZlVpb05ra1oyL2gw?=
 =?utf-8?B?RlhwQm8rZ0N2K1ZwRjgxajVPczZxM29PZVErVDd3d09MRTVMUzl6Q3BtSTFN?=
 =?utf-8?B?WDBDemRIbEEwczgwdTNtNHM3VTdUaXZtMnJmdUE5OWtZUmpqd0FJQjhVUDY3?=
 =?utf-8?B?TnV1NXNCZUNkTVVqQmc0c3BqOTNvaGY5T095TjNjbDl5Qm1uYzZ0Q0dnQmls?=
 =?utf-8?B?MGg1VEI0RzNTVEpwRFVEbnN3OXVtQk1ORFQ2T2tiZ3BmalBPdDgxWWh6TlVQ?=
 =?utf-8?B?ZGZrdmF3NTdkUWZGVElTb2tUL0JueStabHZMWWgya1ZXN0d3cyttbk5FcnZZ?=
 =?utf-8?B?ODR1Z01zbmxvL1pWbUFtNFFNY3V0bFVQdUYxc21uRUtEQmsyeFR3d0lyLzFD?=
 =?utf-8?B?MmNUbnRKUnFwRWxyR01FSnZncHRwL05mMm9oL1J6UUY4TS90VVA3RjFSQ3VU?=
 =?utf-8?B?M1E4YVhkUUluNnNqTkhVQlRPeTFnRnJmYkRjQjBIYnoxMVBycW9CSzFmNVpI?=
 =?utf-8?B?TURhY3ZwQ3FOSWxzRnFqek9Rc3R2NGlrRGRWdTZVd2FPYkdreFdpN3grWmsx?=
 =?utf-8?B?Z1NmM2szTnZUdThjZmxNdjdFeHEzTThmeTQ2a25hM3dSVzZKeTVLR3VTR0JF?=
 =?utf-8?B?NVBtTEg0UFhRNlVSb0Y1SzVtc2ZtT1BzVHNoVjBCQ3VBM2p1MklxM09yNkQ3?=
 =?utf-8?B?VExGWmJSMmZQdG1YUmgrZFZGbm5wMHhjM0NiODNJN3pDRW9YN25XaGdIclYy?=
 =?utf-8?B?bldHQk5VYjlveHE4TFRSS0N0YVhtUlZyOTYzekJwVFlxRXN4Y1k1b09zV1Iy?=
 =?utf-8?B?YWFVOFJIbjVDR3c1aUdVSnN0alAybi8wcW0ramEweDRROElJdXlramVZSmdw?=
 =?utf-8?B?c2JPdnZxcU1RU0FSb1hTc1NIeVk4c2N5Rm5nZi9jUkNmbUs1aUxuRWtIRzNK?=
 =?utf-8?B?Qm8yNFR2NkRVdEdGWjYyamtZZ3NXVmVYWGpwM0RtTzRELzA4Mk9zNHRHQXJo?=
 =?utf-8?B?WmY1UDJPeTJOcVlQaUx1R0R3dVM4aXRhcGU2bXNKUGZqY0xTSlE2NzFaNlNQ?=
 =?utf-8?B?T2tNRnRqWk5EWmFNOENTUHQ2cHc4dm9WQTJGYUV3eUdFbmd0UU9NV21NcTlE?=
 =?utf-8?B?a1lqRmR6U2JqaGo3alh3TXk5MTZObEp0YXRhMTR3WUVHL243RkprYWkzQ1ZL?=
 =?utf-8?B?WlgxZnBTdmtISWdNSjhHa050blZFeGVzeUxiR043SU5XRjlYOXpXZmkxQmlz?=
 =?utf-8?B?cEhZNmhHdE42eFNNYnN0Q3dteVBzei9SeW11Mk80emlhb3Q1ZUJWWms0MjND?=
 =?utf-8?Q?QcTNEJ0WZhxvW9JtHM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be217cc0-18d2-4d92-da0e-08d93ce67ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 23:18:04.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnU1ve02f+kUvMLBJV+vg7pA8wY/dWgKECANlkRkKUvkkOx6ixPS5j4w6kzEyN5oqpk7bKxJSR68q3IKhV6wE+Ru11rv/xbGcJmTFH+PrPbN36HuvzIHj38mcWXyffQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4318
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ASwLKu1YpWwQdfQ8ViD7Z8hIx4520388AA=
Content-Type: multipart/mixed; boundary="lKZzFOUMjJIug9EMnuhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625181497;
 bh=dve9xGiqQKk9Ylh74e6BqllqKOtSEnnHluXrXqJ4r/M=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=OT+esoGQyauln1praAkaQFT+saChNqWhrpjV4QI1nNgxJ1/gy+No535fbyQuM9uHXrQ
 MhuWye/fUEPmr9talPVdYyocjV6b4sf31UjpGQpCt8HjPDYcQVDNvs0layz6XJhyi352B
 SG/GBe9ehqZXk/R8RaPQIcdvukHyYQTkrdo=

--lKZzFOUMjJIug9EMnuhE
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCldlIG5lZWRlZCBNYWludGFpbmVyIHJvbGUgdG8gcHVzaCBtYXN0ZXIuDQpTbywgSSB1
cGRhdGUgeW91ciByb2xlIGZyb20gRGV2ZWxvcGVyIHRvIE1haW50YWluZXIuDQpDb3VsZCB5b3Ug
cmUtcHVzaCB0byBtYXNldGVyPw0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFzYW1pIEljaGlrYXdhIFttYWlsdG86
bWFzYW1pLmljaGlrYXdhQG1pcmFjbGVsaW51eC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDEsIDIwMjEgNjoyNiBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3
YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KSA8
bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQo+IENjOiBtYXNhc2hpLmt1ZG9AY3li
ZXJ0cnVzdC5jby5qcA0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIGNhbm5vdCBwdXNoIHRvIGNp
cC1rZXJuZWwtc2VjIHJlcG9zaXRvcnkNCj4gDQo+IEhpLCBJd2FtYXRzdS1zYW4NCj4gDQo+IFdv
dWxkIHlvdSBtaW5kIHRha2luZyBhIGxvb2sgaXQsIHBsZWFzZT8NCj4gDQo+IDIwMjHlubQ25pyI
Mjjml6Uo5pyIKSAxNjo1MyDluILlt53mraPnvo4gdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0K
PiA8bWFzYW1pLmljaGlrYXdhPW1pcmFjbGVsaW51eC5jb21AbGlzdHMuY2lwLXByb2plY3Qub3Jn
PjoNCj4gPg0KPiA+IEhpLCBJd2FtYXRzdS1zYW4NCj4gPg0KPiA+IFdoZW4gSSBwdXNoIGNvbW1p
dCB0byB0aGUgY2lwLWtlcm5lbC1zZWMgcmVwb3NpdG9yeSwgIEkgZ2V0IHRoZSBmb2xsb3dpbmcg
ZXJyb3IuDQo+ID4NCj4gPiBtYXNhbWlAZGViaWFuOn4vY2lwL2NpcC1rZXJuZWwtc2VjJCBnaXQg
cHVzaCAtdSBvcmlnaW4gbWFzdGVyDQo+ID4gRW51bWVyYXRpbmcgb2JqZWN0czogMTU1NywgZG9u
ZS4NCj4gPiBDb3VudGluZyBvYmplY3RzOiAxMDAlICgxNTU3LzE1NTcpLCBkb25lLg0KPiA+IERl
bHRhIGNvbXByZXNzaW9uIHVzaW5nIHVwIHRvIDIgdGhyZWFkcw0KPiA+IENvbXByZXNzaW5nIG9i
amVjdHM6IDEwMCUgKDgxMS84MTEpLCBkb25lLg0KPiA+IFdyaXRpbmcgb2JqZWN0czogMTAwJSAo
ODExLzgxMSksIDE4Ni4xNCBLaUIgfCA2Ljg5IE1pQi9zLCBkb25lLg0KPiA+IFRvdGFsIDgxMSAo
ZGVsdGEgNzQyKSwgcmV1c2VkIDAgKGRlbHRhIDApDQo+ID4gcmVtb3RlOiBSZXNvbHZpbmcgZGVs
dGFzOiAxMDAlICg3NDIvNzQyKSwgY29tcGxldGVkIHdpdGggNzQxIGxvY2FsIG9iamVjdHMuDQo+
ID4gcmVtb3RlOiBHaXRMYWI6IFlvdSBhcmUgbm90IGFsbG93ZWQgdG8gcHVzaCBjb2RlIHRvIHBy
b3RlY3RlZCBicmFuY2hlcw0KPiA+IG9uIHRoaXMgcHJvamVjdC4NCj4gPiBUbyBnaXRsYWIuY29t
OmNpcC1wcm9qZWN0L2NpcC1rZXJuZWwvY2lwLWtlcm5lbC1zZWMuZ2l0DQo+ID4gICEgW3JlbW90
ZSByZWplY3RlZF0gbWFzdGVyIC0+IG1hc3RlciAocHJlLXJlY2VpdmUgaG9vayBkZWNsaW5lZCkN
Cj4gPg0KPiA+IEl0IGxvb2tzIGxpa2UgSSBkb24ndCBoYXZlIHBlcm1pc3Npb24gdG8gcHVzaCB0
aGUgbWFzdGVyIGJyYW5jaC4NCj4gPiBXb3VsZCB5b3UgbWluZCBnaXZpbmcgbWUgcGVybWlzc2lv
biB0byBwdXNoLCBwbGVhc2U/DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4gLS0NCj4gPiBN
YXNhbWkgSWNoaWthd2ENCj4gPiBDeWJlcnRydXN0IEphcGFuIENvLiwgTHRkLg0KPiA+DQo+ID4g
RW1haWwgOm1hc2FtaS5pY2hpa2F3YUBjeWJlcnRydXN0LmNvLmpwDQo+ID4gICAgICAgICAgIDpt
YXNhbWkuaWNoaWthd2FAbWlyYWNsZWxpbnV4LmNvbQ0KPiA+DQo+ID4gDQo+ID4NCj4gDQo+IFJl
Z2FyZHMsDQo+IC0tDQo+IE1hc2FtaSBJY2hpa2F3YQ0KPiBDeWJlcnRydXN0IEphcGFuIENvLiwg
THRkLg0KPiANCj4gRW1haWwgOm1hc2FtaS5pY2hpa2F3YUBjeWJlcnRydXN0LmNvLmpwDQo+ICAg
ICAgICAgICA6bWFzYW1pLmljaGlrYXdhQG1pcmFjbGVsaW51eC5jb20NCg==

--lKZzFOUMjJIug9EMnuhE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6590): https://lists.cip-project.org/g/cip-dev/message=
/6590
Mute This Topic: https://lists.cip-project.org/mt/83840144/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lKZzFOUMjJIug9EMnuhE--
