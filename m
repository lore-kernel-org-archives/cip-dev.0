Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926D3C4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 13:18:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.18280.1713878315958908840
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Apr 2024 06:18:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43NDIWqw3303003; Tue, 23 Apr 2024 22:18:33 +0900
X-Iguazu-Qid: 2rWhclmqQsThg28Mqm
X-Iguazu-QSIG: v=2; s=0; t=1713878312; q=2rWhclmqQsThg28Mqm; m=LEl0Rb7lA0eOq+eHOydozCdr1ohsL9izkvfOtQnR9ss=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 43NDIV7D3443634
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 22:18:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A31Mi+f844Fl20Lsoxw2IHyF7m9/nEw2RN4HvOM5SLGYXChJy7lJlii7SGZWnDuSSE81kI/qauKyGeodQ01+96cJ8U7SqPFrZfVKYOjrxUqaDs+4SH1f7eiXn4+MDhQ/CMYj0fdccVn4jVWggWS5uPx4PhZ2M4fx1o5K/Shnksy+I7FF9ucDBsXV5yBDu/uGEkPnFNB0kb6S3LeXk1N17gVohNMMhD3dvZ7O1CIozUTdv5GMqkdGPMSGMtuWM3+DDOtWAtXn0r3bCJGN/XmbXzL2W5NEq9yQDOu8OkC5JjUU0e2YOxLLNh85l5IlwrwAlF4gvBivxc3ckcIoH46WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apjGZ11LROFy4V6RELbB7hSmA/m3IqLFn0UmCnpsjHQ=;
 b=bSt5ogqBM1h0Akm0iDe9qR+AR05GxYZgvGW9AKeZFrh44iZ1W7kv7OhqGv1HkqomQ3NLOLwLx6myVmsHuN62bcQhMwTI/CBcpsUHuhnL1tUZS5typlu/SIAUuqZsGoTw3xMtyV8kCsa5jk+ig0WI1iNsHYDI2avU2aSDgSz8+aM1PMP2qai7feyIM7L5L0e86HPCOfQwhutzmieEEn+2GN27AA0H3OtQXr1zMtDq2PU5229WmhkcDwj5KKa7wHZ2/zol6lnc+VdL15TLLeRWqbLMTynpFn0U24VRZXYwFdsRkeunPpdSgh5ZdgO7ifpnashpjcwohgP+3cvbAmqE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <schilling.benjamin@siemens.com>,
        <cip-dev@lists.cip-project.org>
CC: <Chris.Paterson2@renesas.com>, <minmin@plathome.co.jp>
Subject: RE: Generic x86 kernel configration (RE: [isar-cip-core][PATCH] Add
 support Plat'Home OpenBlocks IoT VX2)
Thread-Topic: Generic x86 kernel configration (RE: [isar-cip-core][PATCH] Add
 support Plat'Home OpenBlocks IoT VX2)
Thread-Index: AQHahyxyY4LBwup8/E+w5N5S8lGX9LFjUpsAgBKfzrA=
Date: Tue, 23 Apr 2024 13:18:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63887693ACFE968011C6315092112@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <TYVPR01MB11245F45500C758184F6369A092C5A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <5367.1711107559199640802@lists.cip-project.org>
 <2fa52e58-0ba5-4865-adac-3dbe03c9b83e@siemens.com>
 <OS0PR01MB6388EFEF8FAA99557205AB4092032@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <5c49bdf7-5909-418c-a8ab-683797f6b141@siemens.com>
In-Reply-To: <5c49bdf7-5909-418c-a8ab-683797f6b141@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB11378:EE_
x-ms-office365-filtering-correlation-id: 68fc9aca-426e-471d-907d-08dc6397dd7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?djNjQncydFVLUmtvKys1MVY2am5ic0FNK2NZdGxHSGZOQThVWFV3Ym1qNkdM?=
 =?utf-8?B?Z2t5UkExSUwvRmxxYWszb0RMckp4NWM4VE9wZkt0ZGhyejl4Vld2a1V2Q2lS?=
 =?utf-8?B?d2dGamtEUTdnUW10ekVyaklsNDEzRVdiWVZwQ1dMR0hYYWdMcjlDWk5oWmcw?=
 =?utf-8?B?VStpd2FKenZOK2lzRUtBcVRxeXJ2cGozdy9qUUszeEQwM1RxZkhaMkdYMmFa?=
 =?utf-8?B?TldTL1FxRk44ZU5tdWtBaTlEWWhHRGdXbThpcjJULzE0SGxqeW41czJ2bWtR?=
 =?utf-8?B?TnJyaVA1LzFWV052b1BJbDcweHpObjlVcXgyT0pzYUZLd1ArTm4zdmlMUHFy?=
 =?utf-8?B?VDYxVU1LcmpDZC9LWWRTVXZ1ZmFnRll1cHdCOFJKbVlHdSt2R0hSR2lTU1dp?=
 =?utf-8?B?bnMzSS95ZTVHYzJ4TWJTRWVSYkd6TnlGczFTWFd0VHp5Q1AzOS84QXNrdWhn?=
 =?utf-8?B?Y21NQ0JtcXlhSW1kYXpseEdyN2RZeGd6eWxBaDg2VUNNcExReUdFV2NaWWg1?=
 =?utf-8?B?TmtNS2svREFhM2hYOG1PaFFHVVp0MUhlNGRtbzkzQmE3ZS85N3FlZ0IxQUtr?=
 =?utf-8?B?MXpjYVVCOUFjQ3JEUGExeVpGejVUQ0dxYlUxTWRyNmtodDc1VWFqSE9DTjY1?=
 =?utf-8?B?QndaSzRINEtSeDZWalRwbXlxU1NMN1JQcUZNTnNLTHhlY2UzWTQzU3QzdnJz?=
 =?utf-8?B?bTNEY09BdktOUzUvRjdhNTFGSlhKRnYyR3pWQ1ovU29Iem0wcEo3VkpuS3lK?=
 =?utf-8?B?SlB4Q3dFMk84Ymw0ZjVxK3lFQzJXenl2eXhWSjRNUzY1b1kxVUhjdzlmdnQy?=
 =?utf-8?B?bXBWMnhDUlNRcnllRGhzcCttZWM5R1pyckNTd2hJMm5zSURQUG1YeW1ZbnZu?=
 =?utf-8?B?NkNUcjhhVTF4RnF5bVJTbTNXcDFaSlY4OUdCK1pMTzJxblZVMUFhRnRBWTZD?=
 =?utf-8?B?YTc5MTNZNkkxWFBKcCtIcmgzdm1lckRoelhsRyswdWpOdGgzbHpMSWNGMzFw?=
 =?utf-8?B?NWFGYVpub3pCc2tOOExnWWFyZWVkZFl3VlpIdklYTjhBQ3dxQkdCOVZHMkFi?=
 =?utf-8?B?dmVGVDc4TDF3WjNDUFJhT1NwLzVFVWZsMnRtVlExSWx4eTFiQUhYSHJ3aDU4?=
 =?utf-8?B?UURJMFV6VjJmbFZiTjNiNnhhRHJFZ2RVMlNsVENXMFRub0JzQmtwemNvdjBY?=
 =?utf-8?B?c2NkMEtQeUtidzhrSXpMUzZHSDM2NzY1SVRlcDRjWWRRYWp6YWx2ek5XTlRO?=
 =?utf-8?B?K2JJMHBYeTgwSTdMUkVveDJCc2kxNXZTQkxVd1hGSXRtK21BRzFwYUhuemNV?=
 =?utf-8?B?cWU5ZEc5ZzZ0ZkpRZTJidyt1eThVMEZLMytweDBMSEFDWHZaZGpyZkVJTngv?=
 =?utf-8?B?ZHg2Tzc5QS9wUFlLMDZjUzl3N3BZbW1uT0JJVXZkc2pjSGgrRmkycEhBZTBv?=
 =?utf-8?B?MG5vbFlKbTJjcDZFWllXWDJ1VmVwQ3FHMkc2cnEzUXhoSDNpTHB4TXd1aGhB?=
 =?utf-8?B?LzBKUDFHYWtHTTF2UjE0WjNxY21JUWw4YkVBMW1XYWJDY0dNQldZbHFINDZI?=
 =?utf-8?B?L0FxVEFWVlIrWnFSNUw2RzBIMHg0bVRoakthTkUwaHlRalNQWXZ1NVFiemNx?=
 =?utf-8?B?MzQ2eTBWV01CcnZLWXZZa3V2Vjg5Z0szcmxTaGZLWEREU0tXQ2g2dENBSURC?=
 =?utf-8?B?MVpkMVVsY2ZuSFVMaTdHYnJPY0h0S1FEV2dPM1BzK3FFVjFWT21BU3VRdEIz?=
 =?utf-8?Q?Ir0KRT2/Cq8lmYAIL0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WVFlNnN5TzMzUFZVbWlCWnVUOE1NZXdKeERmeVVQdm90N3BDT3lPbFp1MXVL?=
 =?utf-8?B?ZFVmejN4cUVZQVArOCtUSkZheXR1SzNaRnc1OHVJZnJRMmpKMHVadWY4N1Rt?=
 =?utf-8?B?bERxcmRpK2xjT0pQZjJTakdtbU1TM3FhVzBFVjUvaVVWV3JXeVdRNngyRnlZ?=
 =?utf-8?B?OWlESk5zdjdXVCs4dTUyQVRDUG93Rk00VXZxcnpvV2xYSk95eExKMTBUOTlV?=
 =?utf-8?B?NFlvVHdha0NEZUpzQUMwM21XZ0NiWXpGNTBwN05oaS94YnY3ejJmL3lkRVNr?=
 =?utf-8?B?N1k4RUdkbHk4UlpSN2dvRlhwUkFJRnlSODRsdnUzVUkrRE1zQUw5WWJidTRY?=
 =?utf-8?B?c3d2bWZqQ3NEVHBVMUVRUWNERFUvSkR5emNaRXh5aDBueVlmZldjVTRrOWpN?=
 =?utf-8?B?cWVOVXpab01oaitiZzd4ZG9iWXMzUllUUlY0bkhLOUFadjlEV1E2M3EyVkFM?=
 =?utf-8?B?aVMxUzQxeWVCdk1hTGZiNG5qaUFYeTR5SEl6MEwwY3FtRkR1eVBJNndWK0dj?=
 =?utf-8?B?bTJHWS9DWWNTYnBiandRTm1pK200K0NtcXZtMkVrUDRzY21GdmMwOG53azFQ?=
 =?utf-8?B?OGJoSU9ReWwwYndGYVJKY2pRMmpkTDVxYXNLMXdKa3JObFZRVnBqWEhQR1RV?=
 =?utf-8?B?U09rVmttL1liWUdvc2VWVE9CeDV6SlEyWEZhZllVanFPZG5qeEQ2cUg5RUxi?=
 =?utf-8?B?ZFVyQlFIdmhkMEdhVFdmWHR5UjhUOWx3bmZ4MzNzZU9IZjd4MWxhc1Yvc2tF?=
 =?utf-8?B?bk5VTXBPd2V1L0d5TVVyVmdpMXIxa0Y1aFBmL1ltczJUNWdrWGlKTWFjY3VU?=
 =?utf-8?B?ejJNR3JUQ0V1S1NxQlNtcXlxN1RBR1ZrUjdiWk94b2hhaURBWGo4SkgvR3BJ?=
 =?utf-8?B?Sk0xNnJKSmZvek15Y2xXSCtDWncrSjZVcmdYZWNBRFZRK2t6bFljZWJ5VjZ5?=
 =?utf-8?B?dEMrY3R2SEsxY3JJOUJROFdEd2Q3YjhaaU85TlNCQk0xa0UvOFdNNk1MNlRH?=
 =?utf-8?B?K01LdE1kdTF3SmdVOThVRCt6SUY1TkNrQWR1a2xhSyt0V054T0pMRlJnTGNV?=
 =?utf-8?B?M3NxOThvSzlqcDV2L29JM2xFeHZldk8xZjM2QzRoY3JQcjVSZWU3YzIxU3FS?=
 =?utf-8?B?NUtjeXhodGZTSUlLVXp6TFRwdnZ2V0tGNk5Qbm1oMjZ3UnV0MUFlS3NCOGZq?=
 =?utf-8?B?N0tRWVJaN3ZacW45RWtyUUNFN0lhbUJNZkR1Y0oydlpCa2dNV0Rab0l2aWlE?=
 =?utf-8?B?dGdaR3ZFZUR4QWtuZUFpakJYeXVHSHpoZHlkcHZ6VjBrK2h6R256VlllUitW?=
 =?utf-8?B?K08vKzAvdG9YYm43aXJUajJsTEUyTzY0dnFBREh3anpqYzFvUFE1UjZoSTIz?=
 =?utf-8?B?UkJXSmdFcTgyWVp0SkRqZjhwWWI2U0p1UUMvbHR3bEdRZU9YWjlLYnROVjJr?=
 =?utf-8?B?Y1R5NUQxUjhKbDZKZ1FDM3dSRnloUThxTWFnbzMrVUlyNXZyRXNuYWRCeWx2?=
 =?utf-8?B?d0lLdkRNN0hkdmdFdmI3bHptcTZlTmxycGRxVkRhSGFMMkdVbzRKamtFVUtz?=
 =?utf-8?B?QmhLdkdjY0xkZUZ6T0FSUWRFa0ptczVCaXE4SkQ4clMzSlN6VzF5VFVrR3Nm?=
 =?utf-8?B?RjdEejlERzJpQ1VDN1ZLZ0J2V1JSSTg5QnNQSllmeEJFdm5jU3FYbGE2ZjZF?=
 =?utf-8?B?ZUxObkljUkJtZXVma1FaVjJsYzF6ZTU0VWNmeXp3NmVDczdGdytiNXdjaDlQ?=
 =?utf-8?B?WlJWK2Q4SGVuSmkyTjJDVzQ3WXZwU2ovSDc2V2JZSHJlcUY1eVpXdWFwYW9y?=
 =?utf-8?B?d1MvT0toRlRtbzlHU1dRcjhSeXh1cUJzWitvOUFqdzNtUnFLbTI4eDlLWXRo?=
 =?utf-8?B?NEJ0ZUZZV3ZGb1NmNldJRnJIejBqbnJjeXZUWjNHMHJMUm40ZDhzZ3MyMFUr?=
 =?utf-8?B?TFc0K3k2NXBYbm56WWxEYTdvbGdxTEplNVk0V3JDWGxwTlVlMWNrbW9vaGlF?=
 =?utf-8?B?QSt6WjRiaDIzMVdZWHRhMXJTZW4rSHpTMUI4WFVXNmpxdFFBNkhiMVFxc1pO?=
 =?utf-8?B?SSt6a3BDcnpGYUJjWFZQSXNPcG9Xc3ZPL09ST0hFYTVjL09JbktnL2FpbFFi?=
 =?utf-8?B?WGZYQlhQUFZkVmJSQ2o5YTQ4WExTelhJWkE0UTlNNFVHUkp5TmtWQ3UrWUpm?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fc9aca-426e-471d-907d-08dc6397dd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 13:18:28.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fN0kJEmPHa3+enevQPIvUyJGGp3+crGAI00ln02zODTKGdE2OIhOJ4TCTRa1jKSAnDgHdDUGWlaiH+gkneDtQwADfkdLdUCF1JeE7RsopJKw8qJMD5txvKSCeKVqBEdx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Apr 2024 13:18:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15741

SGkgSmFuLA0KDQo+IFRoaXMgc2NyaXB0IHdpbGwgbGlrZWx5IHByaW9yaXRpemUgdGhlIGNob2lj
ZSBvZiBsYXRlci1wcm92aWRlZCBjb25maWdzIG92ZXIgdGhvc2UNCj4gZWFybGllciBsaXN0ZWQu
IEJ1dCB3ZSByYXRoZXIgZ2VuZXJhbGx5IHdhbnQgdGhhdCBmZWF0dXJlcyBlbmFibGVkIGluIG9u
ZSBjb25maWcNCj4gYXJlIGFsc28gZW5hYmxlZCBpbiB0aGUgbWVyZ2VkIG9uZXMgKHN1cGVyc2V0
KS4NCj4gSG93IGNvdWxkIHdlIGFjaGlldmUgdGhpcz8gUHJvYmFibHkgbW9zdCBvZiB0aGUgY29t
bWVudHMgSSB3b3VsZCBoYXZlIG9uDQo+IHRoZSBpcGMyMjdlIGRpZmYgd291bGQgcmVsYXRlIHRv
IHRoaXMuDQoNCkkgc2VlLiBJIHRoaW5rIHdlIG5lZWQgdG8gY2hlY2sgdGhlIGNvbmZpZ3VyYXRp
b24gb2YgZWFjaCBkZXZpY2UgdG8gYWNoaWV2ZSB0aGF0LiANCkZpcnN0IEkgY3JlYXRlIGEgbGlz
dCBvZiBjb25maWdzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5z
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxMiwgMjAyNCAxOjUxIEFNDQo+IFRvOiBpd2Ft
YXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKX
i++8r++8s++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgc2NoaWxs
aW5nLmJlbmphbWluQHNpZW1lbnMuY29tOw0KPiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KPiBDYzogQ2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tOyBtaW5taW5AcGxhdGhvbWUuY28u
anANCj4gU3ViamVjdDogUmU6IEdlbmVyaWMgeDg2IGtlcm5lbCBjb25maWdyYXRpb24gKFJFOiBb
aXNhci1jaXAtY29yZV1bUEFUQ0hdIEFkZA0KPiBzdXBwb3J0IFBsYXQnSG9tZSBPcGVuQmxvY2tz
IElvVCBWWDIpDQo+IA0KPiBIaSBOb2J1aGlybywNCj4gDQo+IHRoYW5rcyBmb3IgcGlja2luZyB0
aGlzIHVwIQ0KPiANCj4gT24gMDUuMDQuMjQgMDk6MzksIG5vYnVoaXJvMS5pd2FtYXRzdUB0b3No
aWJhLmNvLmpwIHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEZpcnN0IG9mIGFsbCBJIGNy
ZWF0ZWQgZ2VuZXJpYyBrZXJuZWwgY29uZmlndXJhdGlvbiBmb3IgeDg2IENJUCByZWZlcmVuY2UN
Cj4gaGFyZHdhcmUgYW5kIHBlcmZvcm1lZCBib290IHRlc3RzLg0KPiA+IFRoZSBjb25maWd1cmF0
aW9ucyBvZiBlYWNoIGRldmljZSBpbiBjaXAta2VybmVsLWNvbmZpZyBhcmUgbWVyZ2VkIHVzaW5n
DQo+IEtFUk5FTC9zY3JpcHRzL2tjb25maWcvbWVyZ2VfY29uZmlnLnNoLg0KPiANCj4gVGhpcyBz
Y3JpcHQgd2lsbCBsaWtlbHkgcHJpb3JpdGl6ZSB0aGUgY2hvaWNlIG9mIGxhdGVyLXByb3ZpZGVk
IGNvbmZpZ3Mgb3ZlciB0aG9zZQ0KPiBlYXJsaWVyIGxpc3RlZC4gQnV0IHdlIHJhdGhlciBnZW5l
cmFsbHkgd2FudCB0aGF0IGZlYXR1cmVzIGVuYWJsZWQgaW4gb25lIGNvbmZpZw0KPiBhcmUgYWxz
byBlbmFibGVkIGluIHRoZSBtZXJnZWQgb25lcyAoc3VwZXJzZXQpLg0KPiBIb3cgY291bGQgd2Ug
YWNoaWV2ZSB0aGlzPyBQcm9iYWJseSBtb3N0IG9mIHRoZSBjb21tZW50cyBJIHdvdWxkIGhhdmUg
b24NCj4gdGhlIGlwYzIyN2UgZGlmZiB3b3VsZCByZWxhdGUgdG8gdGhpcy4NCj4gDQo+IEphbg0K
PiANCj4gPiBBbHNvLCBib290aW5nIGlzIGZpbmVbMl1bM10uIEJ1dCB0aGVyZSBhcmUgYSBsb3Qg
b2YgZGlmZmVyZW5jZXMgaW4gdGhlDQo+ID4gY29uZmlndXJhdGlvbnNbMF1bMV0sIHNvIEkgdGhp
bmsgd2UgbmVlZCB0byBkZWNpZGUgd2hhdCB0byBkbyB3aXRoIHRoZW0uDQo+ID4NCj4gPiBBYm91
dCBNLUNPTSB4ODYsIGJ1dCBJIGhhdmVuJ3QgaW52ZXN0aWdhdGVkIGl0IHlldC4NCj4gPg0KPiA+
IEJlc3QgcmVnYXJkcywNCj4gPiAgIE5vYnVoaXJvDQo+ID4NCj4gPiBNZXJnZWQgY29uZmlnOg0K
PiA+DQo+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2NpcC1tZXJnZS1jb25maWctd29y
ay8tL3Jhdy9tYXN0ZXIvY29uZmlnDQo+ID4gRGlmZiB3aXRoIGlwYzIyN2Ugb3JpZ2luYWwgY29u
ZmlnIFswXToNCj4gPg0KPiA+DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRzdS9jaXAtbWVy
Z2UtY29uZmlnLXdvcmsvLS9yYXcvbWFzdGVyL3NpZW1lbnMNCj4gPiBfaXBjMjI3ZV9jb25maWcu
djYuMS44My1jaXAxOC5kaWZmDQo+ID4gRGlmZiB3aXRoIE9wZW5CbG9ja3MgSW9UIFZYMiBvcmln
aW5hbCBjb25maWdbMV06DQo+ID4NCj4gPg0KPiBodHRwczovL2dpdGxhYi5jb20vaXdhbWF0c3Uv
Y2lwLW1lcmdlLWNvbmZpZy13b3JrLy0vYmxvYi9tYXN0ZXIvcGxhdGhvDQo+ID4gbWVfb2Jzdngy
X2NvbmZpZy52Ni4xLjgzLWNpcDE4LmRpZmYNCj4gPiBLZXJuZWwgc2l6ZToNCj4gPiAgICAgNzc2
MDU0NCBieXRlcw0KPiA+DQo+ID4gaXBjMjI3ZSBib290IGxvZyAobWVyZ2VkKVsyXQ0KPiA+ICAg
ICBodHRwczovL2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi8xMTEzMjU5DQo+ID4N
Cj4gPg0KPiBodHRwczovL2dpdGxhYi5jb20vaXdhbWF0c3UvY2lwLW1lcmdlLWNvbmZpZy13b3Jr
Ly0vcmF3L21hc3Rlci9pcGMyMjdlDQo+ID4gLW1lcmdlZC5sb2cNCj4gPiBpcGMyMjdlIGJvb3Qg
bG9nIChOTyBtZXJnZWQpDQo+ID4gICAgIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hl
ZHVsZXIvam9iLzExMTMzNTYNCj4gPg0KPiBodHRwczovL2dpdGxhYi5jb20vaXdhbWF0c3UvY2lw
LW1lcmdlLWNvbmZpZy13b3JrLy0vcmF3L21hc3Rlci9pcGMyMjdlLQ0KPiBOTy1tZXJnZWQubG9n
DQo+ID4gICAgIGtlcm5lbCBzaXplOiA3MjUxMDcyIGJ5dGVzDQo+ID4gaXBjMjI3ZSBib290IGxv
ZyAoZGlmZikNCj4gPg0KPiA+DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRzdS9jaXAtbWVy
Z2UtY29uZmlnLXdvcmsvLS9ibG9iL21hc3Rlci9pcGMyMjcNCj4gPiBlLmxvZy5kaWZmDQo+ID4N
Cj4gPiBPcGVuQmxvY2tzIElvVCBWWDIgYm9vdCBsb2cgKG1lcmdlZClbM10NCj4gPiAgICAgaHR0
cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTExMzMwMQ0KPiA+DQo+ID4N
Cj4gaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2NpcC1tZXJnZS1jb25maWctd29yay8tL3Jh
dy9tYXN0ZXIvb2JzLW1lcg0KPiA+IGdlZC5sb2cgT3BlbkJsb2NrcyBJb1QgVlgyIGJvb3QgbG9n
IChOTyBtZXJnZWQpDQo+ID4gICAgIGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVs
ZXIvam9iLzExMTMzMDMNCj4gPg0KPiBodHRwczovL2dpdGxhYi5jb20vaXdhbWF0c3UvY2lwLW1l
cmdlLWNvbmZpZy13b3JrLy0vcmF3L21hc3Rlci9vYnMtbm8tDQo+IG1lcmdlLmxvZw0KPiA+ICAg
ICBrZXJuZWwgc2l6ZTogOTIwMzI5NiBieXRlcw0KPiA+IE9wZW5CbG9ja3MgSW9UIFZYMiBib290
IGxvZyAoZGlmZikNCj4gPg0KPiA+DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRzdS9jaXAt
bWVyZ2UtY29uZmlnLXdvcmsvLS9yYXcvbWFzdGVyL29icy5sb2cNCj4gPiAuZGlmZg0KPiA+DQo+
ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmFuIEtpc3pr
YSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjYs
IDIwMjQgMzo1MiBQTQ0KPiA+PiBUbzogQmVuamFtaW4gU2NoaWxsaW5nIDxzY2hpbGxpbmcuYmVu
amFtaW5Ac2llbWVucy5jb20+Ow0KPiA+PiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsg
aXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqENCj4g77yk
DQo+ID4+IO+8qe+8tOKXi++8r++8s++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNv
LmpwPg0KPiA+PiBTdWJqZWN0OiBSZTogW2lzYXItY2lwLWNvcmVdW1BBVENIXSBBZGQgc3VwcG9y
dCBQbGF0J0hvbWUgT3BlbkJsb2Nrcw0KPiA+PiBJb1QNCj4gPj4gVlgyDQo+ID4+DQo+ID4+IE9u
IDIyLjAzLjI0IDEyOjM5LCBCZW5qYW1pbiBTY2hpbGxpbmcgd3JvdGU6DQo+ID4+PiBIaSBhbGws
DQo+ID4+Pg0KPiA+Pj4gSSdtIGpvaW5pbmcgdGhlIGRpc2N1c3Npb24gdG8gc3RhcnQgaW50ZWdy
YXRpbmcgdGhlIE0tQ09NIHg4NiBzdXBwb3J0Lg0KPiA+Pj4gV2hhdCdzIHRoZSBzdGF0dXMgb24g
dGhlIGdlbmVyaWMgeDg2LTY0IHRhcmdldD8NCj4gPj4+DQo+ID4+DQo+ID4+IE5vYnVoaXJvIHdy
b3RlIHJlY2VudGx5IGhlIGhhcyBhIHByb3RvdHlwZS4gTWF5YmUgaGUgY2FuIHNoYXJlIHRvDQo+
ID4+IGZpbmFsaXplIGl0IHRvZ2V0aGVyLg0KPiA+Pg0KPiA+PiBKYW4NCj4gPj4NCj4gPj4gLS0N
Cj4gPj4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiA+PiBMaW51eCBFeHBlcnQgQ2VudGVyDQo+
IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+IExpbnV4IEV4cGVydCBDZW50ZXIN
Cg==


