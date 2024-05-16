Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B05CC25B77
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 12:03:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.11798.1715860996080461086
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 May 2024 05:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 44GC3D1O2836962; Thu, 16 May 2024 21:03:14 +0900
X-Iguazu-Qid: 2yAbdMiuYzpsfWb6g4
X-Iguazu-QSIG: v=2; s=0; t=1715860993; q=2yAbdMiuYzpsfWb6g4; m=D0RP6gz5o1GEEiWmW8xCW1st2Uappe/fEFwtQfx08wo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 44GC3Cju2372780
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 21:03:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTooPN5nCnmK88w6UdjM0VoBCx4Zfib/kWmKzLUXO2POOFs931L+srccQixk/I0vFOANUo6iX1SCmszYW3kXAMsRn7KX2q/DrYLN8jTahFUKm4odVK9XtI/g4laaN4oN4DkGWhKGOyRHgR7bDbIuSpzRXZH3xvmEn4Hnptm9FyZIQIGsFiprRn0t5bn26uAxlvlFtVQGRTOHqbxDuEb6aCBRgL62uxfQFzg49m4pFr2tl8511i85g40x8/+iwoa/FnP2iz3si0BZ7ceY2fCbY2gJSKvtVZcQSfL7z6+y82TqY0A4iLz0/xT4E2UgyZVd5d5hFaUTRP3muScax46EPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhm57WCtetFNx00dBP9Hz7sP8a8JKUIogZhe8ivV7Wk=;
 b=efMkqJMhq0WzMeky4wStt0ECnMXNf/A9Wk9c5EI8f8gAIblwYgGu+kqf9XRmUbduO+rOPf6/Hqsktxj3hagLRdVr1V3bAPIBcahyHOvKEAJQzCFw3iBFFd6QNtnA3mtYq1u33iGLtSVQbEV68zYSOQfTxKNmyJYGkCgYsnUnfhnAQYJ4SRmwRXxriPcW0KTCI/Icl016yA3ttnLoAr21FNjBFMLhO22JGBkrxQOaHBSoWjfxokoXz6BOwYLuSkC3lAsygCvSOjMVNnEW8GCOBr4H7FXkJI5FxK+GjYNoC5IfW5bhrY4u1blsTkPn7dBhFgc+m7zWkYUvkIjoBrZsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHap1FvxuCA/JXS8kCCBFH/6hOg17GZwpEg
Date: Thu, 16 May 2024 12:03:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388C68663AEA6DDC2CFCED592ED2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <00f28daa-1540-4e09-a476-32fd2570402d@siemens.com>
In-Reply-To: <00f28daa-1540-4e09-a476-32fd2570402d@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS7PR01MB11880:EE_
x-ms-office365-filtering-correlation-id: fe6dfde7-3c0a-4d05-3d88-08dc75a027e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ay9CeFM2Yy96MEpiQ2pwM1V2ZFFRSlhJaHFSNk1wQndUbkRkc2I2RnltN21E?=
 =?utf-8?B?Ykl0NGtiNmlLL1F4bFcwbUhZdjV3UUlTOXhWY3ZwM0p0bE8zbkNUMEx4YnQ0?=
 =?utf-8?B?VGk2ZEtqd1BWcG5aREZxWTA2NWN4T2JHWldzM2NNTE0wSmpqUG9hTlpRVzBv?=
 =?utf-8?B?NmhKcXh1eGZPSkRTSlBHYkNRdmR0aXpyR0pCQ2dIV09yRlRGV3VwYTROdzhh?=
 =?utf-8?B?OUhBOEdXRU1FQXhDYk9UZHMvd3Vrd1lmdW93VGVQVUhRU0RzNTd5dTdvUmdr?=
 =?utf-8?B?UHhzY3NPVWNuRitqS2pCbnJudHlZdkFocjVOZEkxdXhEMzN2TDVEVDdWVStx?=
 =?utf-8?B?Wk5rMGtpUFRIWXoxN1l4bnlacElRZ1RWU0xxdlBmTVh6R0h1L0NacmIrTi9O?=
 =?utf-8?B?NTRDSnVVQ1ZlSVFaM0lJalhFd1VKOHFyRXpCZ1B5Z0d4cEp6OG1DY1d0OXdh?=
 =?utf-8?B?Kys3Sk1wYXZFUDVJOUpvRDY4K2t2Zkp1VjNuS1hZNGtrLzVmWVlpdzJPVjIr?=
 =?utf-8?B?N2c5eXBQWnZwaTBOVDRjVmdTVzhrMDZGQVpPSnVXb0tmSm5EeU5MQU55bk5T?=
 =?utf-8?B?c3dlY0NMVzFnOXhKdGMvWmxmSVhhUkFKSi9mM081aW5NTmltclJOTWJNM0pZ?=
 =?utf-8?B?RGQzQUJnbnJPMGxJN3g5RUJObDZaTW54N2IwZ25ONWlvcDY2aVY1dk41bzdO?=
 =?utf-8?B?aThXMy82Q3MwRU43eGxoMVlXZUkvSXErQ3cvUVg4bUt1QUR6QnhMdjRHcE1J?=
 =?utf-8?B?YkJrRDhxcGRFbXZVWTh0NmthVnpCTlNJaU5BS3dJZ1QvVjVDZGNzZTltWFk2?=
 =?utf-8?B?MnpXbVdHWFJEVTRGb1JGV0NIeW5hZDBxZjNNc3M4ZWRDdnZlTXNNQ2VyRytD?=
 =?utf-8?B?T2lQcGNkUEU3MWtrcm1MWmtPcVVqanRWZ1RpQnlTd0EzNEh4UWNEbmdJRXZP?=
 =?utf-8?B?Y2FuWUNzeWhkNzkxamJMUytzWTVId0pXZGdyc0JpVnNuRDFoekU1U1NZbmZL?=
 =?utf-8?B?bFRQT2NTM0duZGFMRFVpTmcyRUovbWFPMUFncTVBVi9mUlJLY3IxNlY2R1NC?=
 =?utf-8?B?aTlJREo1TUFwUC9VcEZ1RTQzdVF3RWpiL1B3dmV2aVdNOTBmWTBadVI5VlZI?=
 =?utf-8?B?SW1uNzhPc2dmKzd4WGcvUWphSkdTMkM3SCtvRi9SRlNtQVh4UjZrUlZCUkpl?=
 =?utf-8?B?U1lBNU5wbERvZVVqUTdxNFdXcUhOOFQ0Rk5ZWEUyTUt2UEo5NkpicmJDand1?=
 =?utf-8?B?VDh3QzdYWkRrNFJJWXpaeWExWE95Wno4dWRVemh5S0N2MURuNzkvVC91SHY4?=
 =?utf-8?B?TzhYNjhHazNIS3ZwTjRRQ0hWdWZIVUZVZ0ZWZDJKV1J3T0R6b0kwajJMSHAy?=
 =?utf-8?B?M1lqNkxuMndNbkpDTWI2N29LTlhRbG9VODBuWnA5OHZ2ODd6RGhHK1cyNnRV?=
 =?utf-8?B?U1BVWEFKTHFNdjIvOTA5S09RMUlzaktRbVFzMi9tcE80RzZ0QmxSK2RXaDc5?=
 =?utf-8?B?Y0ljaVowRUp0ZGZJTlFnSjgyUkh2TmsrVDErOEYrMUFjUGxXZmptWkk2UjFm?=
 =?utf-8?B?aGUxOWNLTk1Ma0J5SXRkNXFobHFDeWdDYjhLOWl2cUFaMzlqUElLMmxpUHhx?=
 =?utf-8?B?ZFJHK0VOWVYzdVRpY0RjUEo0azNPbzF3Zlc2S1NKM0t4alNSa3M0blRxL3JE?=
 =?utf-8?B?TkVVWVc1MVR0bmwxTzhrWTZiQ3F4WXN5ZmFwRnRoeWVkZkNTL044NC9nPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTZjQTM1Mzd3eWhZZFo5UFNjUTc4b0xPeVJTVjRTQXM4b0NySW1LUVVqVjFB?=
 =?utf-8?B?ZGZ3MjAwWU9jUFRKcE1rdThHa0JNZVg5U0pISE40ZnZNWlRDM2VRd1ZUb0VT?=
 =?utf-8?B?VTdydjJUNFF6OVVJRmtQMlhGSEdPNTFTd3lxUm9mQjJyUktSTThYc3Q3Rjlw?=
 =?utf-8?B?SXlOL2IvSGhkSSsyWkNBRDgzYm96ZzhMNXdkcWNOcjBrRzJjR2YvV3o4c25T?=
 =?utf-8?B?T1lRVG43cGZaZmRnRHZ0Y29OaXBXOVlxYzhGcmE0N1RQUU90VVpRQU50OTlO?=
 =?utf-8?B?a1hIZEV0U0JudXluRm1aUkM5TjNvcWFKbWkyVXVqa1ZXRjRCaEFkdjBBd2Jh?=
 =?utf-8?B?L2pCZHB4VHZzanVkZEFuUElGRytiQVNWcnJNOHFqNXRkcVZpVEpXd3d4b0ox?=
 =?utf-8?B?UXJ2R1Y0RElXS0tGWGJtdUwyUlM2OEVZQjdHQXpSN29nSlJVNkRKKys4RUtM?=
 =?utf-8?B?KzZpMEZ5ckhrdWJiQnd4RlkwY2EzZzFxMUpmb2VIUE16M1l2MzBYdDZPd3Fm?=
 =?utf-8?B?VHk1dnUrR3NYWEN4T0s1MTJvaXBYMUJNTHNXQi9JcVV2YkMyUEZuU3dTZzZR?=
 =?utf-8?B?VkE1czgxQ2lZeldWVUs5TUtVUjZsUk9zdndvaDhid0JVQkhQNXY2UDVxaEpq?=
 =?utf-8?B?Vk81S01VV1gzK3JOOU5jNkt6dVhsNS81UjFxKzhDWDBrc2tUYlBZY3VFang0?=
 =?utf-8?B?WjdnMERoZEY1SEFCMDV4NHJmc1pLVy90eEQ1aWFVMU5KbmN3Ym82SGp2QVpV?=
 =?utf-8?B?WUwvaFlFak8zcU9uVkZEUWE5L2paNGd1dmVhd2JHZUwwUjRCNmJrYkhSMU9i?=
 =?utf-8?B?N0Q4Lzl3V1JmbHVWWWpuTlB1aG9rMVVyMjJ4R3BOdFNlYlJqUWV6a3FiYklN?=
 =?utf-8?B?YXRXc2hwbHlLUFJ4QUs5Q3IrL0QvZVpKTS9qM0huK3Jzb2hheFBqM2dvd0JT?=
 =?utf-8?B?VU1FMlFEd0xBWndJa3dUUWgwUmVFTWVkRWtOVFRIQUtvT0J0MlU5c1o3QU9E?=
 =?utf-8?B?bi9tZjc4b1hMQzA2aTVHK05NbFhXL29GZ2hqZzNBMk1kU0VuVFpHWHY1YzRT?=
 =?utf-8?B?MFJuL0hSZXlGTWZtbnNRTVp4ZEpZYndUK2tFUEhDR01Scm1qSFpCdktJSkRk?=
 =?utf-8?B?YzJSYy92YnM1N0dXNFJKdTM2NXZFV0hDd3FjRGo2ZDJHbVVJQitJS1pDVFdL?=
 =?utf-8?B?UGV6Z2liN0wrbVNkQmE4cDF6RFRaS2JnYWlGell5Rjc1aFhqdm00VGlZUTUx?=
 =?utf-8?B?R1Fqall1MG93YmQyRjliV3lCanMwaGtXSldwNG0rQWp0ZUVZUkI1OTZpVzdX?=
 =?utf-8?B?L1NzQmVlbmFtejFHWWlxSk1wZ1RpVllYVG01eXBMV2VDUU9NZDlFQ1ROYU1R?=
 =?utf-8?B?T0lMTGcxQ3NQdzdzVnd2dUtqZ2xtSUNYZ3R4V3Z3U3ZsbWdMa2pOaGIvcVh3?=
 =?utf-8?B?Tm5KVDRRTTh2dUxTam9LcWNLSCtaUmJSbnpTOFMwdk9keEZIT25ybTlySXdu?=
 =?utf-8?B?clQ1SE1HUExxOWx4Y1FNbDFKQmlVM1J6UlFIMDJKT3k1bkJ5Q3lKd2NtUHkw?=
 =?utf-8?B?dU92ZU1wZHEzeEZnRFVpTnFqSHpMYzJCcE1CNWllTHdlWmFtMFJ3d25NSmNa?=
 =?utf-8?B?NjAra0FuSUdhYWFicGdjS3MvVnN2VUc3amNuajNTVlY0NzBVYVJrL2diWFZC?=
 =?utf-8?B?d3NzRmxCSllhUGl3dFlPY0xBQ2JFRk5IVVhSYUZBcSs4VFhsR2o4TUtZbzkz?=
 =?utf-8?B?NVdHeWpoSGp3UExJMkNwbksrdE15TWgxRGtDYTFvNzZ2a25vbTFwNU9RZFN4?=
 =?utf-8?B?SG4yMnpkbHZtRERBM21zczQ1VXFPdjZRYmtOOXo4ZGE0VEJYUmVQMmtCWkoz?=
 =?utf-8?B?VVk5Vm9GR3VOVXg1NDBTaTJObG9kN0QyOHlMTEw1SHlBaWd5RHNJY29QMkVR?=
 =?utf-8?B?ODNwR2ZRZlRxdW5mb0cwRTIvV0FnMU82SU5PbVVqaGMrNGRVYzFPL09MK3JE?=
 =?utf-8?B?U1RLSFRIa2dCYUJqZmd2bHZTaXhwOW00ajRaU25XM1VXN1g0ZVl4U2dBaVMr?=
 =?utf-8?B?ZzBuL2UxK3B2UlRVTVJvRFRaMDJuenFySjcwa0htOHZReHF1OW0yOXI3TDd5?=
 =?utf-8?B?WG5pT2xuMEwwNC83alpicjZqMDcxdDUrdE5HWlVsSnFpUVpPSVRYYkZ6eGd1?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6dfde7-3c0a-4d05-3d88-08dc75a027e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 12:03:10.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONTIYTNSvypRLa4ZGxs2MUB2ixs+l7FliKKk/pWFQuAiv7xkQg+L2qv6ehBXw2bdvKUlGzINg0ETHUr0TdGepyU9wOK78zgpgeHECGRkRRzdKFgRoC1lD2fZKec7FjuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11880
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 May 2024 12:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15906

SGksDQoNCkkgY2FuIG5vdCBqb2luIHRvZGF5J3MgbWVldGluZy4NCg0KPiAqIEtlcm5lbCBtYWlu
dGVuYW5jZSB1cGRhdGVzDQoNCkkgcmV2aWV3ZWQgNi4xLjkwLiBBbmQgSSB1cGRhdGVkIHRoZSBD
VkUgaW5mb3JtYXRpb24gZm9yIGNpcC1rZXJuZWwtc2VjLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5w
YnVoaXJvDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9u
DQo+IEJlaGFsZiBPZiBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU2Vu
dDogVGh1cnNkYXksIE1heSAxNiwgMjAyNCAyOjI1IFBNDQo+IFRvOiBjaXAtZGV2IDxjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4NCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vl
a2x5IG1lZXRpbmcgdG9kYXkgb24gbGliZXJhLmNoYXQNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtp
bmRseSBiZSByZW1pbmRlZCB0byBhdHRlbmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJD
IHRvIGRpc2N1c3MNCj4gdGVjaG5pY2FsIHRvcGljcyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuIE91
ciBjaGFubmVsIGlzIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAgICAgaXJjOmlyYy5saWJlcmEuY2hh
dDo2NjY3L2NpcA0KPiANCj4gVGhlIElSQyBtZWV0aW5nIGlzIHNjaGVkdWxlZCB0byBVVEMgKEdN
VCkgMTM6MDA6DQo+IA0KPiBodHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9jay9t
ZWV0aW5nZGV0YWlscy5odG1sP3llYXI9MjAyNCYNCj4gbW9udGg9NSZkYXk9MTYmaG91cj0xMyZt
aW49MCZzZWM9MCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZwNA0KPiA9MzcmcDU9MjQxJnA2PTI0OA0K
PiANCj4gVVNXZXN0ICAgIFVTRWFzdCAgICBVSyAgICAgICAgREUgICAgICAgIFRXICAgICAgICBK
UA0KPiAwNjowMCAgICAgMDk6MDAgICAgIDE0OjAwICAgICAxNTowMCAgICAgMjE6MDAgICAgIDIy
OjAwDQo+IA0KPiBMYXN0IG1lZXRpbmcgbWludXRlczoNCj4gaHR0cHM6Ly9pcmNib3Qud2wubGlu
dXhmb3VuZGF0aW9uLm9yZy9tZWV0aW5ncy9jaXAvMjAyNC8wNS9jaXAuMjAyNC0wNS0wOS0NCj4g
MTMuMDIubG9nLmh0bWwNCj4gDQo+ICogQWN0aW9uIGl0ZW1zDQo+ICAgLSBwcmVwYXJlIGJsb2cg
ZW50cnkgb24gU0xUUyBrZXJuZWwgc3RhdGUgYW5kIGNoYWxsZW5nZXMgW0phbl0NCj4gKiBLZXJu
ZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KPiAqIEtlcm5lbCByZWxlYXNlIHN0YXR1cyBbKl0NCj4g
KiBLZXJuZWwgdGVzdGluZw0KPiAqIEFPQg0KPiANCj4gSmFuDQo+IA0KPiBbKl0NCj4gbGludXgt
NC40LnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRh
dGU6IFdlZCAwOCBNYXkgMjAyNCAxMDozMTowOSBBTSBVVEMNCj4gICBsaW1pdCBkYXRlOiBGcmkg
MDcgSnVuIDIwMjQgMTA6MzE6MDkgQU0gVVRDDQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51
eC00LjQueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVh
c2UgZGF0ZTogTW9uIDEzIE1heSAyMDI0IDA3OjUwOjMyIEFNIFVUQw0KPiAgIGxpbWl0IGRhdGU6
IEZyaSAxMiBKdWwgMjAyNCAwNzo1MDozMiBBTSBVVEMNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+
IGxpbnV4LTQuMTkueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJl
bGVhc2UgZGF0ZTogVGh1IDI1IEFwciAyMDI0IDExOjU1OjM2IEFNIFVUQw0KPiAgIGxpbWl0IGRh
dGU6IFNhdCAyNSBNYXkgMjAyNCAxMTo1NTozNiBBTSBVVEMNCj4gICBTdGF0dXM6IE9uIHRyYWNr
DQo+IGxpbnV4LTQuMTkueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJz
aW9uIHJlbGVhc2UgZGF0ZTogRnJpIDAxIE1hciAyMDI0IDA4OjQ5OjIzIFBNIFVUQw0KPiAgIGxp
bWl0IGRhdGU6IFR1ZSAzMCBBcHIgMjAyNCAwODo0OToyMyBQTSBVVEMNCj4gICBTdGF0dXM6ICpM
YXRlKg0KPiBsaW51eC01LjEwLnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVy
c2lvbiByZWxlYXNlIGRhdGU6IFRodSAwOSBNYXkgMjAyNCAwNDozMjozMiBBTSBVVEMNCj4gICBs
aW1pdCBkYXRlOiBTYXQgMDggSnVuIDIwMjQgMDQ6MzI6MzIgQU0gVVRDDQo+ICAgU3RhdHVzOiBP
biB0cmFjaw0KPiBsaW51eC01LjEwLnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkNCj4gICBsYXRl
c3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IEZyaSAxOSBBcHIgMjAyNCAwOTozMjowMCBBTSBVVEMN
Cj4gICBsaW1pdCBkYXRlOiBUdWUgMTggSnVuIDIwMjQgMDk6MzI6MDAgQU0gVVRDDQo+ICAgU3Rh
dHVzOiBPbiB0cmFjaw0KPiBsaW51eC02LjEueS1jaXA6IGludGVydmFsIDE1IGRheQ0KPiAgIGxh
dGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVlIDA3IE1heSAyMDI0IDEyOjMyOjExIFBNIFVU
Qw0KPiAgIGxpbWl0IGRhdGU6IFdlZCAyMiBNYXkgMjAyNCAxMjozMjoxMSBQTSBVVEMNCj4gICBT
dGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTYuMS55LWNpcC1ydDogaW50ZXJ2YWwgMzAgZGF5DQo+
ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUdWUgMDcgTWF5IDIwMjQgMDI6MzQ6MDAg
UE0gVVRDDQo+ICAgbGltaXQgZGF0ZTogVGh1IDA2IEp1biAyMDI0IDAyOjM0OjAwIFBNIFVUQw0K
PiAgIFN0YXR1czogT24gdHJhY2sNCg==


