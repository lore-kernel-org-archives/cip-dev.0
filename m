Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3AC433FE
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 22:30:30 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.129])
 by mx.groups.io with SMTP id smtpd.web11.17214.1664922627777607832
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 15:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=aylE6Hxq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.129,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZPr44Tw6xZuzbBrHpIpjRpBi5iQnEbnqz7wAHugYNiciBBPAiMLS68Z03N7IcD3lESvbbmpdR3MpMQUTZo8qagOzQqPD2MABcB7Akri+AnO0W0r9dfC0JWF/8roO+nCmJeJoVkN7dx5pks/CRzN9RZx7Z7PfgtFmRC9L757DLftZFma9e19K45H3+BRNZjq5cZ6dhBF4rRTAl4cSvJkocmFHDeeS1doxFLlA4pJEZaRFCw9EAsri4lbWam8pMNZEKO8G+1JSzwDmmkEGCkhmJRAEtSc0zlu6KC/MzoRCXSfZZq2ZqpD+IbAA8cBtSzfXsAjmAoEHSVL5ihYlYaumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg4EeptQc6xm4p1ix3uAqIKvchAC5ejI1uRGLbDpprw=;
 b=iBYVX89ABkYdTsz7B53PAmVQEc+rCsjCbelz2b4DLN7ehlZPOTwiF1KEwCD+pLFEfj25F3i7uV4Yf2YKI5LHJR5ZDv9QjpXs2TIQmMKM+QcJUtNURkNqyz+hpDTiYeplex4hK1VPdt2/7Lc5bI6ylxUsR1mp4Qo7n90l3Z4pcvkiK5S7EyNBhZEyoOuMpclUo05BlTDlqQLQDLv12l5f/4y/YrwmLYk2X3AUhQMN7dhmf469TDooMvrSNuYZbAlcSCZnka7vvYVxBEsSzBQT3xYcYxIZrWqHE0WueEOYh/h4Y1EReLHBqlFUNwsGsvwhnDL2PKtLVuWrMMFsvFecgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg4EeptQc6xm4p1ix3uAqIKvchAC5ejI1uRGLbDpprw=;
 b=aylE6HxqPxfG5HdZFkHUNj/pdmiJRFzDQ/W+Kaat8DNgSgRN6MpGHN5t4I81p/TtsljXwJVkgXfKJNrkKi/a2WjUqEz2YZ89SqG2us9cuR+cqLDJbr6wxC0rM1kdJLO8mELG7Zm7j0e5lL8spiC6ARBpHzMsYihLrcLGAhi5J64=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB9738.jpnprd01.prod.outlook.com (2603:1096:604:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 22:30:23 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 22:30:23 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Jan Kiszka
	<jan.kiszka@siemens.com>, Hung Tran <hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: Preparing isar-cip-core for RZ/Five
Thread-Topic: Preparing isar-cip-core for RZ/Five
Thread-Index: AQHY12R70oH/O7MJs0O1EcsG6E6zC639QmdA
Date: Tue, 4 Oct 2022 22:30:23 +0000
Message-ID: 
 <OSZPR01MB7019EC85B41F057AEB79E630AA5A9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB9738:EE_
x-ms-office365-filtering-correlation-id: dde9a1a2-4149-4273-f0f8-08daa658077a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tKomyzUrZHxQS2NyARuhIbz5EibmAPRt+y6Q1PUcls56gtx96l/cpBxKh1HhATgIPzaprRFhoLjMNn3zU6WZTuLDHLPrWPH5bsVkmowLMpBDaBmYRZEqGyH07eyslJTCjGv90vSB6aAAhl0S/DKS7X6B1DY9XccbYGB6bsnIuTBTQ3LqAUCkwqDiDciwJ9xx4NCcOQoUipQqZHu+Zg50Kj7PEE+IYyKl77ccW7ZaaqBkusN3hyQw6jiaou/NBn4h2k/J9FiGUBrfyqV/GaVKavqitRQBhcJDJoUT1YhnPWhQhSoCC7aT2smNCVslPkvFBSP+BOhJodh2HGdlAIVamlMWQW1Jw/+WaXX2QLgE5l+6syr+SAN2Xm+DxyMFaaZT9yZuoBC+9t0gFpsz5HInvLjFj9fSFkCYcu85pjDXatY02m7O1H53nPyWJtgfGC8LZzXbKyQ+5YyHrbqSDJ8ER/iiL69uMRtI6WBGPHae9D8Spq2um3o/Gxet1BQAa/mWHI8zFhurvX7qYBpGVlX26XO0d4iA+uLDc91OAXwr5/brw9slmKLQ421gI9uuz3BxeE6aiA8+poizo7eOVARaI0NcB6piwQ5Ek3ExQJs6NLMtxpjY0FOOE5gzeXU78cENmFdwQ/84YHQETlSOjLanO5Vk5grj3QqzA52pqFuBOzkMNmZs+Tbl7VwOJfqKdXUlgiaT/9Uvvx8paucFO+aWAQBkTCSAoiio/yxO8QCi3d/GLNPFa7zneYwJ1K4clDz2xoKDJS9/6pBm+PqM6es9lg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(5660300002)(478600001)(4744005)(8676002)(55016003)(66946007)(71200400001)(41300700001)(52536014)(4326008)(66556008)(66476007)(38070700005)(76116006)(8936002)(64756008)(66446008)(122000001)(26005)(9686003)(6506007)(53546011)(33656002)(186003)(83380400001)(2906002)(316002)(38100700002)(86362001)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R29Jb3cwbjlkcVZiQVZGbFZDTWFRYmNmRTNJQ3craUwrY0FxU1VSZFRPUXBj?=
 =?utf-8?B?dkFydWtmbGtxQkJUSE9ESklCWVg1S2RQRSt4RnhFQmVQSUVPUFN2amlpYWR0?=
 =?utf-8?B?NEZNMmhyUmxLMW9UVHNyb3phWVJQZ0VOdURrWWJXelNTUUh2TmExL1dvbnZY?=
 =?utf-8?B?SGczeWZPbkphRFhOc3E5Sjh3R0QxMTVtMWovR3dnUkw3WCt6LzFBN2MyYlN1?=
 =?utf-8?B?RElLN1BhUFBSOHFNdG1UdnVQSUpoZ2EyL0p6aElzcFFLdkFmcDNJaTZsbFBk?=
 =?utf-8?B?R2tibk1pV0hhcnpnTDVrUmI1S2cycmVhczRCMy9ZQ0lIUDJSc3ZuVjZsOWEx?=
 =?utf-8?B?RW1XUDlVTHlRejlXbzdxSkRFZjlxWG1PeXpFM2E2WUVPRVI2eG40WXByanZD?=
 =?utf-8?B?NmZ5cVBucENQYTcybEVjTHhtZ0wvNjA0cU10d1hlQU5hVVRrQ1MvOFB1Yzgx?=
 =?utf-8?B?ZFVLVXNwUWdUUFBNc0t2d1BQL1VGU3F6R2hiUjBHa2drK05KalBHQ2c1QTA5?=
 =?utf-8?B?NVVsQ2xrTXgxck9BVDhlRmNvU2l5S2JoTnlEQjJLcCsxbFVuUVVhc2JkYWZJ?=
 =?utf-8?B?WmdoTHU1ZUxveTRYV3ZSZ3FqTVhRYk5DZ0VtbTBUaGpLQkZ5SkFyTmNBcWZp?=
 =?utf-8?B?VkVhR1pMbWloOTliMDNmMy9rRkI2aUJvcU1hLzZxUEZKajFqVXNCOVZadFJs?=
 =?utf-8?B?WHRiUVg2ZmVDNnlST3lPMXBXTzhEb3lBaTl4VHZaVVk4b2JYUy9tNVpGZVV1?=
 =?utf-8?B?bWgrdmFwbnFjSkdzM2QyNkFsc0dkeFV0N2dybGxzR3RGaVM3NUYxYnBrUGJw?=
 =?utf-8?B?NjRHSTdjTW9QSjJHRXQ4R3lnWkphYlVJV2d2Z25JOS9xcmVmTHBjWUlqUEpB?=
 =?utf-8?B?TC9ncjlNZHU0eU5ndlBKY0xkdE1BeFlsZTJ5Q3NmUHcyOHV0VTRzTCt6alR3?=
 =?utf-8?B?Q084WWxrNGhuSGVyOXAxM0M0OCtoRjZXR0Z1d094UDdOV1JYbHpVazFoNEZP?=
 =?utf-8?B?VnFDYmRGdWFDVGhHUE1PdlNJRFZJZGRnTTFhSlcxUSt4QzFuUjdRMStuRVlq?=
 =?utf-8?B?RzJMWGlGWTBteTRHTzFiVjlmemJ1bmJESUxHLzVTbmRuRkJWUndnbDk1M2Fw?=
 =?utf-8?B?N3ZWRXpYc2ZuNk40Z1ZPT085RlhkTWVVNUtwU0srdTQyb1l2Y1dBQVNFeWVY?=
 =?utf-8?B?YVN6anN3UEdxVFYyTUpkN3JwMi9GRUUwQVFaK1VabHcxTFg0V3UrV29sYTF4?=
 =?utf-8?B?T3V5OUU1dHpjMW9NbEdKdDBaRzN0R3lUN1hSS2syejNkd1E2eERMUTBBRXBU?=
 =?utf-8?B?dE5kOWpZOTk1c0JrVXlPMFdpQkxiYXlhRVdERFRDZHMzU3pDbmMxRGJ6N2xk?=
 =?utf-8?B?dHZaM3VZRVk2UGRWSjB4cWVuV2UrZEVQck40YlZYUVBJRGdKWWltRkRJL0xB?=
 =?utf-8?B?dXJITmIyaHQxaFlkL1NzQ3dGWGIwckQ2cnVnWERYMjRaNlI1VWw0RDY2cFJu?=
 =?utf-8?B?QTdrWk55R0VmcDFJOFF2K1JSTzZrSUhDUmZ2elVTWStMdGVMNUZYN0s2ZEpI?=
 =?utf-8?B?ZzV5dmhjSkFWbVF3Vzc5Vlh6NmR4bnl1RzgvM2c1MlpyeDh4UmcxV3BIaUhv?=
 =?utf-8?B?V216N0YrWGJqakhmSXVpc2YxWENjY3hqc2FOOXRnR2tFdjRvaklCL2c5RVVV?=
 =?utf-8?B?T1AvOEg4MUpjRHhoVWNWMlhZRmI0YVMrczJ5Zy9DcWZiaHFsaWhyOXVlUlJx?=
 =?utf-8?B?VVY2eXFDaFVJeEl4a2VlMEtOVTE4STdKZTNza2Y5MkZxT3ZTcjYyQzVKVDZH?=
 =?utf-8?B?RVNwWHk0aExDZGlMVURxZE96eFdJWGQyTnpDOWpvOWxXTWh6WlA2bmpsMHV6?=
 =?utf-8?B?c05aNkg5dXlTRGJOSjZPMmt1S0VKUnY3ZEtYOW1jMTduQm51ZjUwQS9aZUEz?=
 =?utf-8?B?OCtjcnBkTGJPS3FEM1NiQzZKNFBYRmNQOS9NNXN4bEtlMkZKSVNIWWdwbVFP?=
 =?utf-8?B?QWlvTkM5UzM3YWI4S0EzMVQxY2M5KzgrYXo5bzdEa3pnVk03Z2dDT1JGMWxy?=
 =?utf-8?B?K0ZTaExDN3RRMzNXOHJDUFg5U1o3cEE3aUlMSU50UFRGZGQrd1kwd1JiSC9j?=
 =?utf-8?B?bEQwV2I5VURhZHBubXFXRk5uMnNYMzZuRWJGclBOdkZKWGVlRXhNbUZEdUFO?=
 =?utf-8?Q?KsBYZMzTUerwzvgmvvTZlyY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dde9a1a2-4149-4273-f0f8-08daa658077a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 22:30:23.8864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 WBlBtNlK9iM6mN01etVT53V2cYdcAECNpDfBCQW1kIqMcIBec6WYCcmjvpPVzVivBslRzzrsSfiKVXvYQV05T6u/vvz5uErnjxGtNY32hFFghqINRGNAY+SA6oVteQqB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 22:30:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9640

SGkgSmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzIFBh
dGVyc29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+DQo+IFNlbnQ6IDAzIE9jdG9iZXIg
MjAyMiAyMToxMw0KPiBUbzogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IFBy
YWJoYWthciBNYWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVz
YXMuY29tPjsgSHVuZyBUcmFuDQo+IDxodW5nLnRyYW4uanlAcmVuZXNhcy5jb20+DQo+IENjOiBj
aXAtZGV2IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4NCj4gU3ViamVjdDogUkU6IFBy
ZXBhcmluZyBpc2FyLWNpcC1jb3JlIGZvciBSWi9GaXZlDQo+IA0KPiBIZWxsbyBKYW4sDQo+IA0K
PiA+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4gU2VudDog
MDMgT2N0b2JlciAyMDIyIDE5OjM2DQo+ID4NCj4gPiBIaSBDaHJpcywNCj4gPg0KPiA+IGFmdGVy
IGdldHRpbmcgcWVtdS1yaXNjdjY0IHJlYWR5IChwYXRjaGVzIHdpbGwgY29tZSB0b21vcnJvdyks
IEkNCj4gYWxzbw0KPiANCj4gSHV6emFoDQo+IA0KPiA+IGhhZCBhIHF1aWNrIGxvb2sgYXQgdGhl
IFJaL0ZpdmUgZXZhbCBib2FyZCB5b3Ugc2hhcmVkIHdpdGggdXMuIEJ1dA0KPiA+IHRoYXQgcmFp
c2VkIGEgY291cGxlIG9mIHF1ZXN0aW9ucywgbWF5YmUgeW91IGNhbiBoZWxwOg0KPiANCj4gSSBj
YW4gdHJ5IDopDQo+IA0KPiA+DQo+ID4gIC0gV2h5IGlzIHRoZSBkZWZhdWx0IFUtQm9vdCBoYXJk
LXdpcmVkIHRvIGEgdmVyeSBzcGVjaWFsIGJvb3QgbW9kZT8NCj4gSSdtDQo+ID4gICAgbWlzc2lu
ZyBzdGFuZGFyZCBkaXN0cm8gYm9vdCAtIHdoaWNoIHdvdWxkIGluY2x1ZGUgVUVGSSBhcyB3ZWxs
Lg0KPiANCkl0cyBqdXN0IHRoYXQgd2UgdXNlZCB0aGUgc3RhbmRhcmQgY29uZmlncyB3aGljaCB3
ZSB1c2UgZm9yIEJTUCByZWxlYXNlcy4gTG9va2luZyBhdCB0aGUgdS1ib290IGNvZGUgZW5hYmxp
bmcgZGlzdHJvIGJvb3Qgc2hvdWxkIGJlIHN0cmFpZ2h0IGZvcndhcmQgYXMgRUZJIGlzIHN1cHBv
cnRlZCBvbiBSSVNDLVYNCg0KDQpDaGVlcnMsDQpQcmFiaGFrYXINCg==

