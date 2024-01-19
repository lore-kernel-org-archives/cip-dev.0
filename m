Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049BDC47DD3
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 17:09:52 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.138])
 by mx.groups.io with SMTP id smtpd.web11.7.1705684187057019671
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 09:09:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=IlvOHQOp;
 spf=pass (domain: renesas.com, ip: 40.107.114.138, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVYOmrjGmovXoEjREdxK/ma+QZetRhb9VieUFcdsAs3BqE6I4uItbsURM3SUJGN57pw8aMAXznybvQkYZ4joiwDpH5QZmAYxPYlIqBujQ7t5BAMOURXVzFQ0W/+6UorFx37F7sMLFss3pwT4gzMuKKmG01IUDqvhDnqFH6WSsnOLssYfPYVubhZJhEzSbYMIkiT/qPNJeirn0um6bBSP5S5gmtcmT+wa+IxEFcE3LTN2/CE1R8CKHhSuMHWlK/WqtDv1YCpRDu2KuZO9HGpMME//n4M0PGHkeRkFZHeXp5Q3HsrTni2LhauQUgs8CFDmNNph/9ZUJ3j7mAWlZDFVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsi1QBGsUOAJNHQyC1qqfK14gPm7AANEQjlCnZz1tOA=;
 b=HEGEnn0PJwAp8XwrMKK6H0B+MNZFRWeAR0k073blyRERSzO5hNo2WdI2Fu/DE0F69h2QENv5tqlR2KJgQoE24P9yFHToythK8F5+oeWRBEruXTSqhtrQewS8r3Hw9okqLmXsFIa0TIbBLJAQU/VS+E8hpKNeqO4LDIy8vUz/vIMSlGp1s8oG2wOEn7WWtc9Uu3IxkaNxeIbL5sqZHLP5EAX+yGQt3+s+8nsrQTUxSNcxB4/N9EmF6fWIJblLqmz/kr61XM1wHc7WCGRnEvlk0OHbYctAO457Mzuripc105YIWQqApB3Lolwop/wFnnQaLeuAEnfPMDRvkeA25ReFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsi1QBGsUOAJNHQyC1qqfK14gPm7AANEQjlCnZz1tOA=;
 b=IlvOHQOp41LFeuo9DWv4h7lZNDP0E+8/WSyVgPUbRx4CSsYXDpVwmYi5+4+aRANeU3PK0raKTaTfFZsR5FZ4XooE3SeqqOhwbOWJGctMd7iWzZDKo9e32R8ZksvmanbdWLGoJy/tSqnAtbOZsVkjnIAr8+6WZskPapmXZB6Gh3M=
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com (2603:1096:604:13b::10)
 by TYWPR01MB8346.jpnprd01.prod.outlook.com (2603:1096:400:161::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9; Fri, 19 Jan
 2024 17:09:42 +0000
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899]) by OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899%2]) with mapi id 15.20.7228.009; Fri, 19 Jan 2024
 17:09:42 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][PATCH] ci: Reduce build runs
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] ci: Reduce build runs
Thread-Index: AQHaSkBCOJJNVLqIsUyAVg7lZhiTJ7DhU5SAgAALJoA=
Date: Fri, 19 Jan 2024 17:09:40 +0000
Message-ID: 
 <OSZPR01MB6816125011CFB3BAD83B6CA6B7702@OSZPR01MB6816.jpnprd01.prod.outlook.com>
References: <4c3c0db9-d5c5-46d9-b45b-edcd5093bc67@siemens.com>
 <6cba0c0b-0e8f-4a78-8acd-580c6e04b9cb@siemens.com>
In-Reply-To: <6cba0c0b-0e8f-4a78-8acd-580c6e04b9cb@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6816:EE_|TYWPR01MB8346:EE_
x-ms-office365-filtering-correlation-id: d573b13e-8d3b-4360-275b-08dc19116c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 s0BIni0sxO7D5B7nnE6Unp8h8Rtwxs9q+mW+aBg/uen01lEduIUBqlMMRA1GlYPw/N9GDTMtq2eZy3QeFIoE8CIRLZ2KQjNM2Cq6ymqSBVvYt/XOfdX9kkM5sWQMVJg1kkt+0tunO2t/aWfXeI6fKQj2QLowYPubauGOfoKykyGas4cW1shG6o+yQ3rCbpnQqx21M7W5CMcznfPqMGZwBt4vI6MNKOAkbZgSTfUudmuT28009bfmQpoJ5BynS71s/8YZPUZxwUpHEQEByhDDHjjb7RUwQFe3aqvcfnhEO1oSOIjcv6phyC6IzjWK1B57ffIY05hIqbTiwn62MiNbYyj3MT1Q5679oLtgZPBU4BB+wDoHUbd1vRVw5EduaakivL3J/gxyt6vEc7rD3/YijZv2Pmk/65rpJ3adcfa6mUXBMxSZMgbdlnAySwmk3Xx2BAHADaNrLeHIpiRKpmzIMOR5TW0Js15O6sfrNJHkKc/jY3VYKVuimpxL486lWNOMwh8wfRwYc1xgtH/W6dc2h/5SG4d49F64q1GjGPUQ57dyJqG2Cb+eNOG3A213HJidJGDnZ8cr9Mt6tjVKWQnaGV8zXgjLI+hYHeLxCFj15qCtDr7XM5wn9fCDDN+pLe2h
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6816.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(122000001)(55016003)(71200400001)(41300700001)(478600001)(38100700002)(26005)(53546011)(7696005)(6506007)(9686003)(33656002)(52536014)(6916009)(316002)(86362001)(64756008)(2906002)(8676002)(8936002)(38070700009)(66946007)(66556008)(76116006)(5660300002)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QW00aXplZWJDRFZ0eFhSejFjaXNSSTd3a3RDUzV2TnNRMzl6OUtqTXdBOHRO?=
 =?utf-8?B?RTNOUlAwRXhZVXZvSGkyRldSeHhNYUhkS1RJYUcwenp3SlBHZ3c2Zmt5THpH?=
 =?utf-8?B?V1BacEdzNHdBSDlZbWFUTUU0UVhGYXlCYTlLdUxNM2FEOTdIVm1ZTG1rYWFm?=
 =?utf-8?B?YmVoU0dMSUc0YThvK1NBbmJhRlhlRjVhNVNVeW02K0JINjdQRHJ1WmF3Ylpq?=
 =?utf-8?B?d1ZNSHJpUWdGZHAzanpxNHc5eHE1YUxFQ0VaVjVCOWE3VG1laDYvencrUmww?=
 =?utf-8?B?NTY1aVBqemZIOERndThxU0VEYUtySlJHWURqSUNtTjd2RUJXb2FSZmpMYXho?=
 =?utf-8?B?NFZtTzdVMjhWOERsa2VUaXlDbmthN0psV2JjQVNFeWRuYnBLSk56Y202MHRM?=
 =?utf-8?B?dG10N3ZDbGswdXJ4NCtBcnZPeDduVU42aC9VWHg0UTNzMitSTDN3Z255ek1K?=
 =?utf-8?B?OS9HY1F4VG5UL28vWERNdytUQmhZK0hXcE4wblEzQjBiMi9VTE8wb1BlQkx0?=
 =?utf-8?B?QVNrK2Q5TEt1TnlqaWdYR3EzbU1McjhMb0xGSzFMamx3ZkRzaFZKUkNDcE0v?=
 =?utf-8?B?cVRlTnZyQ1lYY25xMWM2aGxibnJUVWdEUTRWUHVlRU43QnlxS0VaNkFOVWU4?=
 =?utf-8?B?cTNNUTE5QTZkMDRjSFVHMTRHY1dOTGp0bXplQUNqSTRrSnRIVXJuSGNKMkVK?=
 =?utf-8?B?MXU3OUVCaWtLVURoaTE5QXowUXFaQzJLTmFmRkxsOWdLRnorWXRxUkx3MkUz?=
 =?utf-8?B?aUN6cStrcXZSYnc2VUdKVkpDMWE0SjBpdmtVc0JUbm90SDNQMmtyRFljcVly?=
 =?utf-8?B?bytPNXg4MzRkZ3psN2M5eXEzeDRZQ1lQMUNsbkJzTzk2bzA5TFdSVFlNak9E?=
 =?utf-8?B?YnQxbkR6RkNaVFhFMGxaRytHL1JTbXZCc1E4cVU4d3BvRSsyc0YvZUdNOURS?=
 =?utf-8?B?ckRwTUljYWliZm5oMUdhcXR6dmg2MHRCOVJYd0NVTUxnaTVrdFNZeDd2RGNH?=
 =?utf-8?B?VHBQVjdIRytLN0NFS0lzNXNNUTFZN1dXYmRJb0xLVTJKNThLdGNicGFRRVdr?=
 =?utf-8?B?VGNJTHJrLzZENkhXRWpsV055Z09xK2xURUxpRHVJOS9oUm1OUXRaWTZVY0Rl?=
 =?utf-8?B?WUtaRHpCMTE5ZlFGV1VreTF1ckhJb1prREpxRllnaG81SUt1WVdJSUxpMzA1?=
 =?utf-8?B?VXhQQnp1Z0dEYW5FT000UC9uV2Zwd3RLMGFuQzRUNkExdkFydkpGWG1SYTRP?=
 =?utf-8?B?cjAxeTFwV0pQOEZHS1ZsOUpBUjNCWnpIdFUweHh0ZmtGVngyb2Q0THZLSXRL?=
 =?utf-8?B?WEhkZFRLMUpYdlVvdmFKY0lFWjRxNXFmWUpUUGx1NHc2VTdOYjdhRDhoV2NO?=
 =?utf-8?B?d256bWR4a3N0N1ZOSG90NVJVdS9sUGNyZHlCREZJRFZjM3dqZVk2Rks3aWpr?=
 =?utf-8?B?WGVtQmFzaUYwUnA3OVV5ZVhja2VsQUdveUdScUpOdzVFcWQ3UUhZeHhwK1pU?=
 =?utf-8?B?aTNhYUc5VkVES3kzSXgrdzVJRjNtSVRyNlVETWRyNWlpUGxlWW50dmtZOVNj?=
 =?utf-8?B?djFwN1c4cWsyQkpuNkRTVHFGbi9GYzhhNGtqOGFnZTczMTd1RkVaMnRBUVky?=
 =?utf-8?B?ZmZCaWZ2SEk4TlhPQ2xtUzRTZ1JEVmhzUW5PcmxoQXdPbUg4QUtuQVMzbEJ4?=
 =?utf-8?B?ZXlWUGtoNjNtVkIyZW00bkFUd3BnZkV6a1ZPWFhGWkQ2Y1lHMlVTc3BZK3ZR?=
 =?utf-8?B?QnlIcXJkQkIxalFXRXJWK3V4Q1VFdFRwem9RY01mZllESk8vbDJrSHRVZ0ww?=
 =?utf-8?B?Uy9UYWJXNW9mMTUwM0dRS251bnB3U1dhVFJ1VmI1MGdybGhHOElvVmNwMjJV?=
 =?utf-8?B?djUyUzFxVGVEQTRmN2pBMFAzdWNQTmx6UTl2YlU0aDE5RXFoNlo2THVqOFFP?=
 =?utf-8?B?RnE3eWphRlYrZ05yY1RpRklDaEc1QUpmLzVkWFgyTWh3ejFzbFR0VlQxU0J0?=
 =?utf-8?B?ZFh6U1hRa2U3OEZSb3NJTzZaZFdJWCtZOWpxNWZlbTAxalIraW0xaXNaamts?=
 =?utf-8?B?UGxxR3VnTWhnam91TjhLdCtmOTVneUlTREFnWVdpYndzTXpWQ003VE50RW9C?=
 =?utf-8?B?WVNGNkJpb2Z1U2VtWmhZaFNzY3NaRFE4bTBPVHd2OElqcEk1YVRZT3BqTkpq?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6816.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d573b13e-8d3b-4360-275b-08dc19116c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 17:09:40.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dda0P8KTzwCI0wYotfz0iOWhYszoT654vKhh6SI5/L2B59fUD3l2Cy4lyRcefWWJYoWOp+UX7DzMw5KyAttmxOzF56FUSHGqNU773+TCyrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8346
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 17:09:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14430

SGkgSmFuLA0KDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTksIDIwMjQgNDoy
NSBQTQ0KPiANCj4gT24gMTguMDEuMjQgMTk6NTcsIEphbiBLaXN6a2Egd3JvdGU6DQo+ID4gRnJv
bTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPg0KPiA+IFVuZGVyIHRo
ZSBhc3N1bXB0aW9uIHRoYXQgZXZlciByZXZpc2lvbiBpbiBtYXN0ZXIgYW5kIGV2ZXJ5IHRhZ2dl
ZA0KPiA+IHJldmlzaW9uIGhhcyBiZWVuIGNvdmVyZWQgYnkgYSBydW4gaW4gbmV4dCBiZWZvcmUs
IGV4Y2x1ZGUgdGhvc2UgdHdvDQo+ID4gY2FzZXMgZnJvbSBidWlsZCBydW5zLg0KPiA+DQo+ID4g
VGhlIGV4Y2x1c2lvbiBvZiBzY2hlZHVsZWQgcnVucyBpcyBqdXN0IHRyYW5zbGF0ZWQgdG8gcnVs
ZXM6Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiAgLmdpdGxhYi1jaS55bWwgfCA4ICsrKysrKy0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvLmdpdGxhYi1jaS55bWwgYi8uZ2l0bGFiLWNpLnltbA0KPiA+IGluZGV4
IGJhMmNkYjlkLi40Zjg3ZWMzNyAxMDA2NDQNCj4gPiAtLS0gYS8uZ2l0bGFiLWNpLnltbA0KPiA+
ICsrKyBiLy5naXRsYWItY2kueW1sDQo+ID4gQEAgLTQzLDggKzQzLDEyIEBAIGRlZmF1bHQ6DQo+
ID4NCj4gPiAgLmJ1aWxkX2Jhc2U6DQo+ID4gICAgc3RhZ2U6IGJ1aWxkDQo+ID4gLSAgZXhjZXB0
Og0KPiA+IC0gICAgLSBzY2hlZHVsZXMNCj4gPiArICBydWxlczoNCj4gPiArICAgIC0gaWY6ICRD
SV9DT01NSVRfQlJBTkNIICE9ICJtYXN0ZXIiDQoNCkp1c3QgYSBndWVzcywgbWF5YmUgZm9yIHlv
dXIgdGFncywgdGhpcyBydWxlIGlzIGJlaW5nIHBpY2tlZCB1cCBmaXJzdC4NCkV2ZW4gdGhvdWdo
IENJX0NPTU1JVF9CUkFOQ0ggaXNuJ3Qgc2V0IGZvciB0YWdzLCBwZXJoYXBzIHRoZSBldmFsdWF0
aW9uIG9mIHRoZSAibWlzc2luZyB2YXJpYWJsZSAhPSBtYXN0ZXIiLCBjb21lcyBvdXQgYXMgdHJ1
ZSwgc28gaXQgYnVpbGRzIGJlZm9yZSByZWFkaW5nIHRoZSBuZXh0IHJ1bGUuDQoNCk1heWJlIHRy
eSBjaGFuZ2luZyB0bzoNCg0KICAgICAgICAgICAgIC0gaWY6ICRDSV9DT01NSVRfQlJBTkNIID09
ICJtYXN0ZXIiDQogICAgICAgICAgICAgICAgd2hlbjogbmV2ZXINCg0KT3IgdHJ5IG1vdmluZyB5
b3VyIG9yaWdpbmFsIHJ1bGUgdG8gdGhlIGJvdHRvbSBvZiB0aGUgbGlzdC4NCg0KUmVnYXJkcywg
Q2hyaXMNCg0KPiA+ICsgICAgLSBpZjogJENJX0NPTU1JVF9UQUcNCj4gPiArICAgICAgd2hlbjog
bmV2ZXINCj4gPiArICAgIC0gaWY6ICRDSV9QSVBFTElORV9TT1VSQ0UgPT0gInNjaGVkdWxlIg0K
PiA+ICsgICAgICB3aGVuOiBuZXZlcg0KPiA+ICAgIHRhZ3M6DQo+ID4gICAgICAtIGxhcmdlDQo+
ID4gICAgdmFyaWFibGVzOg0KPiANCj4gVGhpcyBydWxlIHNldCBpcyBub3QgeWV0IGZ1bGx5IHdv
cmtpbmc6IENJIGlzIGJ1aWxkaW5nIHRoZSB2MS4zLXJjMSB0YWcNCj4gbm93LiBCdXQgbXkgcHVz
aCB0byBtYXN0ZXIgd2FzIG5vdCBidWlsdC4gSWYgc29tZW9uZSBzcG90cyB0aGUgbWlzdGFrZSwN
Cj4gcGxlYXNlIGxldCBtZSBrbm93IG9yIHNlbmQgYSBwYXRoLg0KPiANCj4gVGhhbmtzLA0KPiBK
YW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXggRXhwZXJ0IENl
bnRlcg0KDQo=

