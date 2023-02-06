Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BF5C05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 15:38:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.56423.1675697911231768469
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 07:38:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 316FcSO5026507; Tue, 7 Feb 2023 00:38:28 +0900
X-Iguazu-Qid: 34tIWUr8qQuxXijkYM
X-Iguazu-QSIG: v=2; s=0; t=1675697907; q=34tIWUr8qQuxXijkYM; m=efZhMO2aw/HECT1vpvY86ZU1gAYiaWlMRCDqKl/ivgA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 316FcQ0o011034
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 7 Feb 2023 00:38:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egx6kSwBYd7osjsZnqKS1Cc+hea5SCphbIPhlEJbDYnaS9acdjDGtmMcgLfeaeOwLRNCjmTYd8iswg9Mfk0NUspMnTbrDpUa7b7lTQY0h9/TONcWgYT3OGcZLYhMm1XFuw+bcIu47galy0YDxH20196CaMufooEWru5e9+hmGVEGasP7LFTaPo0pdI27B4n4WBHM/si8Beyi/EwwDSLori58IN0xhZoja4qWpT4sKHU1T8xU4TiGvlPioB75A+jOTQZmpCcCVSZRyeYONBHcqdnCoP3DwW4Uai5Y1XJidY8x6x8cYRd42GL+JHunmahO3QiG7poZ7l9kr3CJmk7MrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rec5HxEEwUo9InCO327NQxSjRLM3a/3M/HfkSTpPB8=;
 b=bai+bvMQSe534MRXX7Qq1qSVo2Rpqo8P+HsVZO2AoYCb4HhVYC3ONtwLDj52wzg1pw2xTcIx+m1rAT2Kbk0RBk6IModWTA+yN7nXMiMtYQt529qh5P2b7OWg0KG25fYjJa8ovgr6oie/+WZGFjmsyZUxSPBXbZHGMdgTFpyU4FmKFzmf0JV5XL1GfUHgKrDU6PeLK1eP7Cz/rQedOIm+wrUX7ENP04KBPPKVmgTxmsJeQGmd7Z7IEl09ZJzOLliuU3YiJe2/c3hrJRu7VsmiHE0y6mmPb3n16cKuF5md3Suzsvkl8+AlAePrRMHFrH5scswr5+KT5XJPaAbvp1ziNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] generate_rb_kas_file.sh: Add script to generate
 rb.yml
Thread-Topic: [isar-cip-core] generate_rb_kas_file.sh: Add script to generate
 rb.yml
Thread-Index: AQHZOiT+puNuDGaaXU6omEw5TYhtwq7B3EUAgAAti/A=
Date: Mon, 6 Feb 2023 15:38:22 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB554256F08BB8F7FC177080AEA4DA9@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20230206121747.1633-1-venkata.pyla@toshiba-tsip.com>
 <6303f836-c50a-4236-5b76-52b1b8e6d6b6@siemens.com>
In-Reply-To: <6303f836-c50a-4236-5b76-52b1b8e6d6b6@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYCPR01MB11988:EE_
x-ms-office365-filtering-correlation-id: 50f1c546-741a-49a7-0027-08db08582e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUrv+JYJ4J/LlIF1vWJ8KrXLIfJPQkrbNdy/MdrK17XVJtCJC1M8EW/l2RdpMF6qhFKyLG4H2SyGQ5Nj+7VO1q82LWLM9bArr7U0KVJUl/uwpaKaeAWzisMMYeqRSJvbVGl5rZTNVX0buuBu170MD+tllT7jhJ+E2ylmCMLvf3Cw3NP9uIHO/lHyEL4VvLemLwirMA7PtCCbj8LaFRCtzaGyj8CMTq6yOzG86kLzSIwwpoHjNPWGG4zW/j7+UJ/nuhzS5OEgX4qQNfR0A2nkrijUIzw7yKDRbTQTDJUN/nK762in3X00PzyhLqXryqnX8LtW9sc6jB/rWhYDPHCUq/GWw0mnuLlS7kj/5SKlFr6OA1D7wCr0WkP5rZcjnbafkCv75vKTvLNL+aMRIFJpfgRj0Dri4FC6Siv9mnqY5KPf6gwjjj37u8srDep2HITiTRlVoNpWoZRr4S2vMHOoo4fKU6R6Ma0cRBSWX2Sw7bTl/JC023CnyLoOVy5xidluAnC4DmOYM2PXS2KntBZnYwaV1khEpMlue8SsLYSieohK1XDspw082Tn1zTw8geR0GREZ3+kAIOdGsYjx1Ex95cbkEBcw53jJaCx5zycwLI1rnzfU0sTa2Xn1VjmIRJDOKnAbIXVew1BQhYKYQ7tnpIN1BcWOCBpKyMCsIXMxlP4plwFcHL8OHcFoOGC+CWKOgG1Tial4M2j8l27VGbnv1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199018)(83380400001)(110136005)(316002)(54906003)(41300700001)(52536014)(8936002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(76116006)(107886003)(6506007)(9686003)(26005)(186003)(478600001)(71200400001)(7696005)(86362001)(33656002)(38070700005)(55016003)(85182001)(2906002)(5660300002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUxJTjlaUnFqaWpldUI3eVhoWnlBU1VPL2pJQW9WWmdrb0c5M0ttbkE4ZUhz?=
 =?utf-8?B?ejBGNHhKV0xKZWYwYzh3SlFhLzFWRHRjV1RWV1JQY1VDUWp4bGhJNWwxUlFE?=
 =?utf-8?B?NlA5Qm9QajRkeThwd3g3dUVnOTM1TmtrOXhUVk1BMzJMekJNUnJqcDBSRlZV?=
 =?utf-8?B?MUxoblJLU1VNVGZMRlljYXBjZmMrMFM2Wkg1TUI3K1J6c2NmOUI1ZVlMdUN1?=
 =?utf-8?B?bG5qSUtuOS8rc0NwR0tIUTBaSGNFeXFXU1FldGhQa2owblFMLzVGQ2hsSkNy?=
 =?utf-8?B?YllnY2g1UGNoRExZWHRZQzcwUU05TjlYc3d6bWV6emRoWGdUbzhnV1pqbTJO?=
 =?utf-8?B?V24zUXU5Y2FYMm5EaURES204Zk1NR2hpanQ2VkYyQXdaRm5nSThnZTJ0UjBj?=
 =?utf-8?B?ZUIxNFc1UHk2TS9yTDBic1BmU2x5RzgvSm5mWXVVNzZGNjQvMDlQWjJtSEtX?=
 =?utf-8?B?ZHlJTlNjTXVrRlQvbk4xek92akc5RWxRS3RmTnNWR2lqd1lDeHlKRjFxN20r?=
 =?utf-8?B?dmJ3VWRoc2R3Z1JvdERmTUNpSHI2RjNjM05zSjdYc1pTVXJ4SHNmaUhhWGhn?=
 =?utf-8?B?TlppWWhsR0ZEeFE5aVE2QkNjejc5NzZVZlV3RGhYNVJ0L09HMEF3VmkyRHB0?=
 =?utf-8?B?OC8wcWRWdG9mNEdPWmREdERxdjF4SER4NmZFYXlGaGhQVlAzVTJZR1NNUHAr?=
 =?utf-8?B?OG1tOU9NL1BKUENvVHNYenFQQUJNV2JadWpsMHljQzA5OUJhZzJvc0Fva1JF?=
 =?utf-8?B?WnEyQ0M5REpmemovUHUyS3R4NlArbFNZWmdSY2VnVmpxLzJmWDR0NDN1bkRC?=
 =?utf-8?B?RGlzMUtUdnNpWWZaSFlURlRRZktOUzYxQ1lyV3JTS20zZlQ3ODF5dFhpSVpV?=
 =?utf-8?B?R0RLSm41bi96NzJrUC92VmN3UTNNTk9nZTc1ekhXcmI1cC93UnROYWtJMFBO?=
 =?utf-8?B?ZkttTi9DZUU5aXlqdmduSDhzZVVoZDR6L0QwSmZjVEEyYlZGanlYVmlvL3BW?=
 =?utf-8?B?ZXFDKzFUYWJtRnpxTWxxN1d6UGMyYXhTNHNuZVV3emRnYmdOSUQwYVAyanAz?=
 =?utf-8?B?cjhOMXpPV0h2MFF3Mk1TbVBaNHo3eUhjU3RSbm9PQThYRlE4KzNTYXR6VEdN?=
 =?utf-8?B?aFAzdTdYTlVGZmltdnFEWk83MFQ4SmdWZEJUZlZNdVFweXFvNVhwZERCZFVT?=
 =?utf-8?B?Y2tSMVVaTTdyaXp1dkJNVGRocWVvcXVGZFVXbC9SU3dVWkNtN0puYXRuZDdw?=
 =?utf-8?B?U1plNzAxS2RpM0RKdFhMdW52T2ltVS9aTFFqa3dMVktubm9EU09iYUFxSldP?=
 =?utf-8?B?K2l3SG5tMW5uS0plQnFkTWNuN0NZOExHVHdjaGlEb24xY3NhUW5Dck53R2w2?=
 =?utf-8?B?dEUwWTZ5U1RWR09TckRQMTlvbmFCVlhDNkhYRGROdkN6NkdFUWZnNEM2Ulp5?=
 =?utf-8?B?SE44QlBaejdLaW9xZzRKZVVuVkw5SHluSDd4c09FekFzamZOaW9scTVTNFU1?=
 =?utf-8?B?STU3MEZ0b3lxUkR5aFIvcnM1SHlmSURPcXRucTZycUhNdUhtY0VJcVROalF3?=
 =?utf-8?B?K2ZXWVlCRWZHR0t5bVVMVjJPWWVyQUdHQ0dIN1c1ZkVKTE5UbG1NZStwcmlw?=
 =?utf-8?B?YW1jUitPbnRnR2dLNGIwby9MU25mck9jbU53cVQ4NG1vS1NZTGF3YnZvbDVl?=
 =?utf-8?B?OStPN29lbzZOV0w4ZGRFZ213MTZsb2dzZ0NHMm1UL09SMUZhMEdXM0xlajRz?=
 =?utf-8?B?bUNlR2FZbitTU1BITzNjUmc0MktMUk9PTHFwVVFTeTgrQndWYk4yZkh0L1B0?=
 =?utf-8?B?RFRMaXYrUXBVanN4STlXRVd3ekJUdDNqZEI2RzJVWG9FYVovLzQwQnRmOG11?=
 =?utf-8?B?TWlkSlY4WVlFMG5ka2RSaVNNOUNhMFZuMVZFUmdTQWxoNm94Znk3RFV1cFdM?=
 =?utf-8?B?L1hML1c1STdyT2hXSmJDUUo5OThzTkVsZG1PTWNhNHFWUzVRQlJaZjg3U091?=
 =?utf-8?B?NkNLd3pKZGFDL2ZLK0Fic0lVQi9YUFVGWVprUmROMEsxSHBxdmJmb0Yydzc0?=
 =?utf-8?B?VEtkYUpOaFBSaGpLUXk5bW51a09tb2pRbXhvQWVjNUlxQmtTK3NQUkE3Z2U1?=
 =?utf-8?B?TWUycit4RDExRUNUVXBLbjNNNERCR3BXYTJkdlEvYk9GZFU3OGNCaWxLd1V1?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f1c546-741a-49a7-0027-08db08582e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 15:38:22.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3S0abSMtPMUvgEoFBmfV91pAhVZ1992QNGxRBVfuGfwwQqS465VcympDKkqeCW+c79JpENyHJgBDE58Wm62f7TBJR+iciL4lqVywjg8pVLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11988
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 15:38:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10608

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogMDYgRmVicnVhcnkgMjAyMyAxODoxMQ0KPlRvOiBw
eWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxh
QHRvc2hpYmEtDQo+dHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPkNj
OiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1
bWFyQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah
77yz77y377yj4pev77yh77yj77y0KQ0KPjxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpw
Pg0KPlN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZV0gZ2VuZXJhdGVfcmJfa2FzX2ZpbGUuc2g6
IEFkZCBzY3JpcHQgdG8gZ2VuZXJhdGUNCj5yYi55bWwNCj4NCj5PbiAwNi4wMi4yMyAxMzoxNywg
dmVua2F0YS5weWxhQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiB2ZW5rYXRhIHB5
bGEgPHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tPg0KPj4NCj4+IFRoaXMgc2NyaXB0IGhl
bHBzIHRvIGdlbmVyYXRlIGthcyBmaWxlIG9uIHRoZSBmbHkgZm9yIHJlcHJvZHVjaWJsZQ0KPj4g
YnVpbGRzIHRoYXQgaW5jbHVkZXMgbGF0ZXN0IHZhbHVlIG9mIFNPVVJDRV9EQVRFX0VQT0NIIHZh
bHVlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IHZlbmthdGEgcHlsYSA8dmVua2F0YS5weWxhQHRv
c2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICBzY3JpcHRzL2dlbmVyYXRlX3JiX2thc19maWxl
LnNoIHwgMTcgKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSBzY3JpcHRzL2dlbmVyYXRlX3JiX2thc19m
aWxlLnNoDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2VuZXJhdGVfcmJfa2FzX2ZpbGUu
c2gNCj4+IGIvc2NyaXB0cy9nZW5lcmF0ZV9yYl9rYXNfZmlsZS5zaCBuZXcgZmlsZSBtb2RlIDEw
MDc1NSBpbmRleA0KPj4gMDAwMDAwMC4uY2YwYjAzMA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysr
IGIvc2NyaXB0cy9nZW5lcmF0ZV9yYl9rYXNfZmlsZS5zaA0KPj4gQEAgLTAsMCArMSwxNyBAQA0K
Pj4gKyMhL2Jpbi9iYXNoDQo+PiArDQo+PiArIyBHZW5lcmF0ZXMga2FzIGZpbGUgb24gdGhlIGZs
eSBmb3IgcmVwcm9kdWNpYmxlIGJ1aWxkcyB3aXRoIHRoZSAjDQo+PiArU09VUkNFX0RBVEVfRVBP
Q0ggdmFsdWUNCj4+ICsNCj4+ICsNCj4+ICtzb3VyY2VfZGF0ZV9lcG9jaD0ke1NPVVJDRV9EQVRF
X0VQT0NIOi0kKGdpdCBsb2cgLTEgLS1wcmV0dHk9JWN0KX0NCj4NCj5DYW4ndCB3ZSByZXNvbHZl
IHRoYXQgdmlhIGEgYml0YmFrZSBmdW5jdGlvbiBkdXJpbmcgdGhlIGJ1aWxkPyBUaGVuIHdlIGRv
IG5vdA0KPm5lZWQgdGhpcyBzY3JpcHQsIGp1c3QgYSBrYXMvb3B0L3JlcHJvZHVjaWJsZS1idWls
ZC55bWwuDQoNCkkgd2FudCB0byBjaGVjayB0aGlzIGFwcHJvYWNoLCBidXQgcmVhbGx5IGRvbid0
IGtub3cgaG93IHRvIGRvIHRoaXMsIHRyaWVkIGJlbG93IGFuZCBnaXZlcyBzeW50YXggZXJyb3IN
Cg0KU09VUkNFX0RBVEVfRVBPQ0ggPSAiJHtAYmIucHJvY2Vzcy5ydW4oZ2l0IGxvZyAtMSAtLXBy
ZXR0eT0lY3QpfSINCg0KQW55IHJlZmVyZW5jZXMgdGhhdCB3b3VsZCBoZWxwIG1lIHRvIGFjaGll
dmUgdGhpcz8NCg0KVGhhbmtzLg0KDQo+DQo+SmFuDQo+DQo+PiArDQo+PiArY2F0IDw8RU9UID4g
cmIueW1sDQo+PiAraGVhZGVyOg0KPj4gKyAgdmVyc2lvbjogMTINCj4+ICsNCj4+ICtsb2NhbF9j
b25mX2hlYWRlcjoNCj4+ICsgIHJlcHJvZHVjaWJsZS1idWlsZHM6IHwNCj4+ICsgICAgU09VUkNF
X0RBVEVfRVBPQ0ggPSAiJHNvdXJjZV9kYXRlX2Vwb2NoIg0KPj4gK0VPVA0KPj4gKw0KPg0KPi0t
DQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExp
bnV4DQo=


