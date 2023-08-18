Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C84C001DE
	for <webhook@archiver.kernel.org>; Fri, 18 Aug 2023 11:14:32 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.76])
 by mx.groups.io with SMTP id smtpd.web10.8641.1692357267341425213
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Aug 2023 04:14:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=c3lbpTWk;
 spf=pass (domain: siemens.com, ip: 40.107.104.76, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGLiVxk02HDoFXLbxt6rn9SM7q6HsqbrOVCwcakatMzphUVWaRzILfYzGgrmWufz81xtSaYkHY8awcjLJQ2vq2+OYt5+qTiPLaL2CCeVcDcXDrTrogGd2tfoFTwCiTeD6npN7L1VKwrl5E8jg4WrnObGbetZGZx0uugzKvCTlBj14Gro8ceiSUCU1A1rC4EyVaMWOPw2HqhEFvGmlir/1yNC42H1OFRD7610E05oJyi92NnBh5Lsnndp7QMATYfQRdukuPHk9FBCBARv1bMTFp9lqT9JxRpus65I2se2oizx/uuZU5JJZ7ANdjYcoalh6r6p8K1w//moo6uZvLdK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH6KwK1I0rgnErwFnXR+7rQMe71wNM6rKAa0NhWWHMo=;
 b=ZxhMLd4cVgu2IU/ebYfXW/uNYREZDQ1gGxNux5s8CbTSdEQ2JDlU7/ngoenEZ1UcFoDKKAGZ3xYQ1VaF0N0C0NsNKREnguKgs3Efzfg4PH7iQBNeuCVVlBeXudV/CGhK1daQEwlWiZNzKXRj9sghHn9DzKhWqhwMmWCxI9xJsal9F7HCXWwsUxaZFDeKkWlPKd2XaYevGpeskVqa8lpsgqBH/1XFeRXlGyGjpwDOXQZabLeuSegX6981G25McdKyrNDKJtovdYIgyK8k0hPeLhOHstrtiQSklckQdw9DFMFDmk18Y1YGqFIq4A9vJz00khRDlTTF3pcTrmXJfpjZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH6KwK1I0rgnErwFnXR+7rQMe71wNM6rKAa0NhWWHMo=;
 b=c3lbpTWkYmqdEBD3QBfueYLzqGjyBiQfzc5SA/LqZPYSz0lvVO38VLsuahTL84CRvcnnDbrSD8X/nm1Vys/ohuIvOEsK34PiahjfX3Hqm75vd/WEoKjWXky/ptj5cxC0h2KfdNpcoVgsOpiq2s6NBUshg5290TUq8TXEgNodgTKpTkvKAYpoO3A8wc9cyt4+T6tv5cz2anAZM3DnzLic/mK5zldxCPWnEqyE8oloYLOYQt78XVbyp3RDcHKsCKaaskpp9npM5Z1Mpwez34+FwuVgB7MfENFKYcGQhccu8vdQJJ58fZfMQMDNQC1wPqjCLgHyTAB/5V9qtHcEmw9dCA==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB3630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:14:24 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:14:23 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [isar-cip-core][PATCH 2/4] initramfs-crypt-hook: Check and repair
 filesystem to prevent resize2fs failure
Thread-Topic: [isar-cip-core][PATCH 2/4] initramfs-crypt-hook: Check and
 repair filesystem to prevent resize2fs failure
Thread-Index: AQHZwWCFfF8H8bWo9Um6DxiEYrEsc6/jabiAgAZauACAAAKgAIAABQUAgAY7coA=
Date: Fri, 18 Aug 2023 11:14:23 +0000
Message-ID: <701896ef84ac88784dbb5bfe576a0b9c4a2333be.camel@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
	 <20230728143320.3891194-3-stefan-koch@siemens.com>
	 <dada78d8-aa43-470c-bdb2-d55c7f90dbd1@siemens.com>
	 <88fa04c6796b3b2c69adb7d507f9a6b54b531c96.camel@siemens.com>
	 <5d54eeeb-cce3-451c-a28a-95eb669694d9@siemens.com>
	 <cafaaf41-dce4-3da8-f14f-dc7ac4c20db8@siemens.com>
In-Reply-To: <cafaaf41-dce4-3da8-f14f-dc7ac4c20db8@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|VI1PR10MB3630:EE_
x-ms-office365-filtering-correlation-id: 80691830-0a88-4716-5c1b-08db9fdc4730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EXXK3M5C56hM0Qj3B7xSTwGrHxhMnuZyj7bayelHRhptCXvEClQzkz71FknohEZQbPEWEcC2XtteLw7+nlEGfVLwBvQbusow5U+r8ZyaQRPxIrXtkD4+lDas83LlPYTUtrbQaMYlqJYRGlkQs/VRzSrFhXWSujeddctm6kUg1tN/3tc+mNOGlzlkBnZVmSQB2gSvWLN+1Nxb1A3YMYjtnrL7ZKO9wa7aqfAFOTm1z3h5kqZ9SoaZWIIgfMDu+aZ/K3SQ8eSIwnYHpC4cA/q8697cz/SyCw5XqRehE1L2Hmhbe/Tw7we8KnVtwaNOGK7f34dnvHYQu5eehzNWoYLrAqoRxY2qfDFc3IjZOHmp3DCrfrBtGUDz5dFDegQKopqrIj1uEaiKmWdwanh1nwlQPMJCRMu0xXYe4hxKffoGLGWFeEo0MMJp7R6T11lm2q6oJ87xK4eVSkDhPKOgA9nN1WCqOuQdhK3MdhyIZ8Bonwo45ywYVCLcS5kYTQr+DADNXwO4qK1LQeY6NPhsz38022xcZMUdhCEgVK3AhxPFYfplkhWkprAakZwyrk1DUWX5lyQTc/CKJ2hCoYJg551WJJ/ktTnTApOTpXl8bsjIyerWqVU8DgazRVa6qkPAJ47Dy9xch/dotma0Ac0v2Ig0wjd4LMdJUGWc9d7XzJ1W7ibFOxyK/kUuCXvGiPWSvG1V
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(15974865002)(86362001)(36756003)(82960400001)(122000001)(38070700005)(38100700002)(107886003)(76116006)(966005)(2616005)(5660300002)(45080400002)(110136005)(66556008)(478600001)(6506007)(66946007)(66446008)(66476007)(91956017)(53546011)(6486002)(54906003)(71200400001)(64756008)(316002)(6636002)(26005)(6512007)(4326008)(8676002)(8936002)(41300700001)(83380400001)(2906002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RFY1by95RER6aVlvTytTWkV0T3ZtaUNGaVltVHUybzNqem1XdFpRQjFQWGd4?=
 =?utf-8?B?V1h2a1pjV1pkKzhjcEdJRGpkZHFoSmFySFBkNXdIbUhDL1NSRDUzbFgvYUlW?=
 =?utf-8?B?Vy80N0N6QTBiS3FkWGpZOTRyeE1ESXV1RE44VzRJUEQyY2h0R25mQnBMVVFO?=
 =?utf-8?B?Z29PdGFUSHlmRzZ3Q3JoWGZxdFlkU1grcU02V1lKRVFna2NUMmxDZFpnR2Vx?=
 =?utf-8?B?ajhPVmdMbTRHKy9KOUswd3o5bHhzSm95cWY0UEpzMUd1dm5neFZFOUpuSkhK?=
 =?utf-8?B?TnVaZEpoSzN3UkRLTTZaZXRwZVVoWHBRZldJY0kyMHlJcVluUmRaZVpMZ0lo?=
 =?utf-8?B?NGtrSG9pTFlWY0JBK2VmNW1lUWdKdmVDV3MzcHg5U0J3SXdwMHJadm9oTnZh?=
 =?utf-8?B?VklIQmM3eWlsRUR4dVZpYi93a1pxVk5hOEU0ZjhTZE13eDYyMjdVZ01ZOGlS?=
 =?utf-8?B?d3djS0RuTitINDlIUEJxTVAvak0zTFdLWFcveFBhZTVuQUhFNjZ0QTBEVkRF?=
 =?utf-8?B?c1Z5SURZbXAwN1dmT1dkN0pRa1hkVm1HWC9LV0ZDZytGaS9aSE5yeURSREV2?=
 =?utf-8?B?Tm9CRDJQTzNDM0ZnZjFaaHZrTFZiQjBVMUhHbnp6bzJFUHM1U1dqaWhTVW5o?=
 =?utf-8?B?Y3dKT1dSQW1jdjdKRGRIZEN0SVQ2WEhFQXJkNG0vZEhUcW5xd1FnMzNGV0da?=
 =?utf-8?B?U0pzVzNWMG43a2xjb3JibURaSWs0WW5oblJXUWp2ZEJOTnkxY3Zyd1ZBZTFm?=
 =?utf-8?B?ZGVqOVlaK08vZ3ozR1ZxTmdBRlgzTEhzeTFmUXVBbUc2ZWNuVkNwYUsyKzFy?=
 =?utf-8?B?TTJRNTJ1WW0vNTBvQkdOVENkd1NiYmRlTjhQZ0dxQ2txOHJoOVdTaXA2RU9K?=
 =?utf-8?B?YVhZaEpGM0VScnpyc09yT0hWSU9hU1RWTUc2L041UlFmYXczbXp1V1FDS3JN?=
 =?utf-8?B?SDdHbXFIczU1YlRnNzJOcHk1bFBVUDRHaHJ0Smc4OEpsY0dPcmRYMXBIR1gr?=
 =?utf-8?B?NkdYNVRFSDJQK29pYkw2a0lGRlYxNTdOdW5Sdzlwa0V5UXJZSFloc3FTUW0y?=
 =?utf-8?B?VWd5NlpIU0crK3U1SjVLckhuT2lTYlpEZ2hIMUc1WmZ4djZ4VUVQU0txZE9V?=
 =?utf-8?B?amVybDZBaXFEOWEzMFJ3QUZnZWl2Sk53Uy8rdEFOQlBQSHFQbEdsU1o3Y0hp?=
 =?utf-8?B?czF3NW51TEJZdStmemF0c3B4VlJjWFJBalNHeThzK2NCcTZ1a1FCQk1lY28r?=
 =?utf-8?B?eDdlYUpzQ2d6ZWN3NGk5S3M1TzE2Qzk3WXIraEVFQ1dLazBwWnk5ZW81aHBm?=
 =?utf-8?B?SEttV0F5MDZobDlkWGRGK0ZGcTdJLzJjakdocHNxOTJUekl4RUlCUzdBNWVz?=
 =?utf-8?B?NU5Va2tqYlFJZDVhRXpyWjFxRlNlYjFVeVdNTGpCUDB5aStIM0FCVi84Uis4?=
 =?utf-8?B?VGIyNEFpL0NuSWJtWUt5RXYrNWoyZ0JnSEZBcHpKWG1HcVFSd0I3M0Vlc3Nl?=
 =?utf-8?B?L1Y0U1pEQzF5NWE1Sk5SZFRjTDlSUWlWQjRLRVZ3WTA1REJRNjI4RTlKTkJ1?=
 =?utf-8?B?MXEyODFmSjdRcjU4cHYrL2xUbjdMQS9jUVJtTWFEaC9ZU3h5NFAyaTZWZXQ2?=
 =?utf-8?B?NnVIdFVUU0JRcTI3dzUzZ3hHN1hrZmdtUFczcDBLZ0I3dFVTMmJ1U0VHLzZF?=
 =?utf-8?B?UVlWR29MSXdzSHZWRElRQjNMcmNNS0lHUjE4K2V1Mzh0VUplNzdmUHZYbFJ2?=
 =?utf-8?B?ZmltRklCSWRHU1BraWhMbkZSZHlSc0RPM0ZXTUNvRjdGUmtqcTYzM0lKeXc2?=
 =?utf-8?B?SGRUdmgyTlpjeXZpcHR5d0NXaHk5WGF2NG9GNHEyNndFaWxpQmU1ZStCeXBU?=
 =?utf-8?B?azZ2THNMbHZ2SWZCOWFQOXRlbmNGYkJKODZ4Wk51RTFYbjJLWkc2c3Urc1lF?=
 =?utf-8?B?WWdxN1JnZmdiejhXd3dHVDFEL2NZWjBmMzFBY0JLT1g5WmJkdDVFSE1TR1NU?=
 =?utf-8?B?alRHYTc5Ty9nUkgvTjRSeU5pbHBnQS9tVnNaQkhpbm1mS2NpbG96bENBaWVv?=
 =?utf-8?B?R2tJY0dCQmtMUHRZU2RSNERWY2pyaHo5VDZMOXdPTkJhcjlKYUpMU25BMkYx?=
 =?utf-8?B?SGNXb1VuaFV5c1MzWkNiNll2OVVPQ1FyQTN1Q0tDdzZBckVyVGNXUXlwV2hH?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C889FECCF07834AA1AB72365300811E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80691830-0a88-4716-5c1b-08db9fdc4730
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:14:23.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aN2XGS0KWr3HxVWO0o5WHYPWnnigMMr7vaddcki4rq++vSqabDispZcuv5M8yHIysSAXWDsGAwxVP7MWdWbmEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Aug 2023 11:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12787

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDE0OjA0ICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPg0KPg0KPiBPbiA4LzE0LzIzIDEzOjQ2LCBKYW4gS2lzemthIHdyb3RlOg0KPiA+IE9uIDE0
LjA4LjIzIDEzOjM2LCBLb2NoLCBTdGVmYW4gKERJIFBBIERDUCBSJkQgMykgd3JvdGU6DQo+ID4g
PiBPbiBUaHUsIDIwMjMtMDgtMTAgYXQgMTI6MzQgKzAyMDAsIEphbiBLaXN6a2Egd3JvdGU6DQo+
ID4gPiA+IE9uIDI4LjA3LjIzIDE2OjMzLCBLb2NoLCBTdGVmYW4gKERJIFBBIERDUCBSJkQgMykg
d3JvdGU6DQo+ID4gPiA+ID4gVGhpcyBjaGVja3MgYW5kIHJlcGFpcnMgdGhlIGZpbGVzeXN0ZW0g
Zmlyc3QgdG8gZW5zdXJlIHRoYXQNCj4gPiA+ID4gPiByZXNpemUyZnMgd2lsbCBzdWNjZWVkLg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEtvY2ggPHN0ZWZhbi1r
b2NoQHNpZW1lbnMuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICAgLi4uL2luaXRyYW1m
cy1jcnlwdC0NCj4gPiA+ID4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQu
c2NyaXB0ICB8DQo+ID4gPiA+ID4gMSArDQo+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWlu
aXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+ID4gaG9vay9maWxlcy9lbmNyeXB0X3Bh
cnRpdGlvbi5zeXN0ZW1kLnNjcmlwdCBiL3JlY2lwZXMtDQo+ID4gPiA+ID4gaW5pdHJhbWZzL2lu
aXRyYW1mcy1jcnlwdC0NCj4gPiA+ID4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5
c3RlbWQuc2NyaXB0DQo+ID4gPiA+ID4gaW5kZXggODNjMzIzOC4uYjMyYjJmMiAxMDA2NDQNCj4g
PiA+ID4gPiAtLS0gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+
ID4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLnNjcmlwdA0KPiA+ID4gPiA+
ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiA+ID4gPiBob29r
L2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuc2NyaXB0DQo+ID4gPiA+ID4gQEAgLTg3
LDYgKzg3LDcgQEAgcmVlbmNyeXB0X2V4aXN0aW5nX3BhcnRpdGlvbigpIHsNCj4gPiA+ID4gPiAg
ICAgICAgICByZWR1Y2VkX3NpemU9IiQoZXhwciAiJHBhcnRfc2l6ZV9ibG9ja3MiIC0gNjU1MzYg
KSINCj4gPiA+ID4gPiAgICAgICAgICByZWR1Y2VkX3NpemVfaW5fYnl0ZT0iJChleHByICIkcmVk
dWNlZF9zaXplIiBcKg0KPiA+ID4gPiA+IDUxMikiDQo+ID4gPiA+ID4gICAgICAgICAgcmVkdWNl
ZF9zaXplX2luX2tiPSIkKGV4cHIgIiRyZWR1Y2VkX3NpemVfaW5fYnl0ZSIgLw0KPiA+ID4gPiA+
IDEwMjQpSyINCj4gPiA+ID4gPiArICAgICAgIGUyZnNjayAteSAtZiAiJDEiDQo+ID4gPiA+ID4g
ICAgICAgICAgaWYgISByZXNpemUyZnMgIiQxIiAiJHtyZWR1Y2VkX3NpemVfaW5fa2J9IjsgdGhl
bg0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgcGFuaWMgInJlZW5jcnlwdGlvbiBvZiBmaWxl
c3lzdGVtICQxIGNhbm5vdA0KPiA+ID4gPiA+IGNvbnRpbnVlISINCj4gPiA+ID4gPiAgICAgICAg
ICBmaQ0KPiA+ID4gPg0KPiA+ID4gPiBXaHkgaXMgdGhhdCBuZWVkZWQ/IENvbmNlcHR1YWxseSwg
d2Ugc2hvdWxkIHN0YXJ0IHdpdGggYSBjbGVhbg0KPiA+ID4gPiBmcywNCj4gPiA+ID4gZnJlc2gN
Cj4gPiA+ID4gZnJvbSB0aGUgaW1hZ2UgYnVpbGQsIHJlc2l6ZWQgb24gZmlyc3QgYm9vdC4NCj4g
PiA+DQo+ID4gPiBJbiBvdXIgY2FzZSB0aGUgcHJvYmxlbSBjb3VsZCBiZSBzZXR0aW5nIHNvbWUg
bW9kaWZpY2F0aW9ucyB3aXRoDQo+ID4gPiB0dW5lMmZzIGF0IGltYWdlIGdlbmVyYXRpb24uDQo+
ID4NCj4gPiBWaWEgd2ljIG9yIHZpYSBjdXN0b20gcG9zdC1wcm9jZXNzaW5nPw0KQ3VzdG9tIHBv
c3QtcHJvY2Vzc2luZy4gV2UgY2xvdWQgYWRkIGZzY2sgdGhlcmUsIHRvby4NCj4gPg0KPiA+ID4N
Cj4gPiA+IEFkZGl0aW9uYWxseSBJIGhhdmUgb2JzZXJ2ZWQgdGhhdCByZXNpemUyZnMgYnJlYWtz
IHdpdGhvdXQgZTJmc2NrDQo+ID4gPiBjYWxsZWQgYmVmb3JlLCB3aGVuIHNldHRpbmcgdGhlIGJy
ZWFrPSBrZXJuZWwgY29tbWFuZGxpbmUNCj4gPiA+IGFyZ3VtZW50LCBhbmQNCj4gPiA+IG1vdW50
aW5nIGFuZCB1bm1vdW50aW5nICh3aXRob3V0IGZvcmNpbmcsIGp1c3Qgc3RhbmRhcmQgdW1vdW50
LA0KPiA+ID4gbm8gbmV3DQo+ID4gPiBkYXRhIHdhcyBjb3BpZWQpIHRoZSBwYXJ0aXRpb24gYmVm
b3JlIGRpc2sgZW5jcnlwdGlvbiBzY3JpcHRzIGFyZQ0KPiA+ID4gcnVubmluZy4NCj4gPiA+DQo+
IFNob3VsZCB0aGUgc2FtZSBiZWhhdmlvciBhbHNvIG9jY3VyIHdpdGggdGhlIGV4cGFuZCBwYXJ0
aXRpb24gb24NCj4gZmlyc3QNCj4gYm9vdD8NCkkgd291bGQgdGhpbmsgc28uDQo+IFRoZXJlIGlz
IGFsc28gbm8gZTJmc2NrIGFmdGVyIHJlc2l6ZTJmcy4NCk5lZWRlZCBhbHNvIGJlZm9yZS4NCj4N
Cj4gaHR0cHM6Ly9naXRodWIuY29tL2lsYmVycy9pc2FyL2Jsb2IvZDQ1NDM4MWZhOTA4NzRmYjlh
ODQ5NmY5YjU5ODBlYmRhODc0Nzk0NS9tZXRhL3JlY2lwZXMtc3VwcG9ydC9leHBhbmQtb24tZmly
c3QtYm9vdC9maWxlcy9leHBhbmQtbGFzdC1wYXJ0aXRpb24uc2gjTDc5DQo+DQo+ID4gPiBXaGF0
IGlzIGZvciBjYXNlcyB0aGF0IGFyZSB1c2luZyB0aGUgcmVlbmNyeXB0IG1lY2hhbmlzbT8gVGhl
DQo+ID4gPiBwYXJ0aXRpb25zIHNob3VsZCBiZSBpbiBhIG1vZGlmaWVkLXN0YXRlIGJ5IGZvcm1l
ciBkZXZpY2UgdXNhZ2UNCj4gPiA+IGFuZA0KPiA+ID4ganVzdCBpbnN0YWxsaW5nIGEgaW1hZ2Ug
dXBncmFkZSB0aGF0IGVuYWJsZXMgZGlzayBlbmNyeXB0aW9uLg0KPiA+ID4NCj4gPg0KPiA+IFJl
LWVuY3J5cHQgaXMgc28gZmFyIGRlc2lnbmVkIHRvIG9ubHkgcnVuIG9uIGZpcnN0IGJvb3QgYWdh
aW5zdCBhDQo+ID4gY2xlYW4NCj4gPiBkaXNrLCBub3QgdXNlZCBiZWZvcmUuIEknbSBub3Qgc3Vy
ZSBpZiB3ZSBoYXZlIG1vcmUgY29ybmVyIGNhc2VzDQo+ID4gbHVya2luZw0KPiA+IGJlaGluZCB0
aGUgY29ybmVyIHdoZW4gd2UgZXhwYW5kIHRoYXQuIEFuZCB3ZSBzaG91bGQgaGF2ZSB0ZXN0DQo+
ID4gY2FzZXMgZm9yDQo+ID4gdGhhdCBleHBhbnNpb24gaW4gaXNhci1jaXAtY29yZS4gUXVpcmlu
LCB3aGF0IGRvIHlvdSB0aGluaz8NCj4NCj4gUmUtZW5jcnlwdGlvbiBhZnRlciBtb2RpZmljYXRp
b24gd2FzIHVudGlsIG5vdyBub3QgaW4gc2NvcGUuIEkgYW0NCj4gc3VyZQ0KPiB0aGF0IHRoZXJl
IGEgY29ybmVyIGNhc2VzLiBleHBhbmQgb24gZmlyc3QgYm9vdCB3aXRoIGRpc2sgZW5jcnlwdGlv
bg0KPiBpcw0KPiBhbm90aGVyIGlzc3VlLg0KPg0KPiBUZXN0IGNhc2UgYXJlIHJlcXVpcmVkLg0K
Pg0KPg0KPiBRdWlyaW4NCj4NCj4gPg0KPiA+IEphbg0KPiA+DQoNCi0tDQpTdGVmYW4gS29jaA0K
U2llbWVucyBBRw0KaHR0cDovL3d3dy5zaWVtZW5zLmNvbS8NCg==

