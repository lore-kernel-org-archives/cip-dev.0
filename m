Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F2DC05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 11:40:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.21194.1675251594185189636
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 03:39:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 311BdpMQ028555; Wed, 1 Feb 2023 20:39:52 +0900
X-Iguazu-Qid: 34tKO57CrWtsykiJJU
X-Iguazu-QSIG: v=2; s=0; t=1675251591; q=34tKO57CrWtsykiJJU; m=hBRZlT9zdO93CFUSkRRywvBEEuxnSRMDu9rylD5DDgQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 311BdoWT039526
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Feb 2023 20:39:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9kkLM0zQy7ob76zH9jrctlFRs3jrhVagNn1rDMhbjk/+ykJYjG1f9Ngh9KfPH3HlwZ8apS4NkP57Mhe03ew68mS1W4cIP1QTKl0lK/gPStkf9H+1BKgqQEqywHNkASw4uiUv0IxnNx1cS4MUDQEHFyF6kZE8QoDobgcUM7mpiNLSAUF1EUeiVOMfsKPljjKmKZu0sajgsA79qOySxvjfpBYr7AsDPK9UYquQNtAmFFka2XdfR2qoBPlpP8pZhHzrXiZBs1HlxJA+eIDoT82aCYlRQUNXl4TffOiOMvp8TWE2Y7I6m9cJ0xk1PAGtbFkw3GGSYqKgK85AsBGuEWJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cekEC48dVR7ZfSZSIEt2ivKnk0ieJQOXNCe9OoWHG7c=;
 b=Uyu1O2GYlSjb43Hpi0o/NUy8QQrkC/6mQD7CWRnSJPX8AtJXNbxmHjuTIxowjHndNagCoKPtLYnFMNWVan60sA9Mtku4cw3hFIhG19SdzPsO09ElcJaIL3DUyAzQ/ZLrqDoAPbPj3Evp+YdQnYB5bEXpmK946XnG42WCtjIfjdOur7UxHvwIJmSa+gBUhZo/X2CFMzh3eXr4Iq7pgP6sSSo9AuijSJoYvQR444a5zrVu+G7qQNR59he2Zh9KGAHMt8YDHCMB7x/cONq2ugZwr/hCqxHHXV04z52L6aMG1kMvxlkwT7J0kRMLsNN18qKGa/mjomrVyAufi30O7t2+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] How to overwrite IMAGE_FSTYPES variable in loacal.conf
 using placement of kas file wic-targz-img.yml
Thread-Topic: [cip-dev] How to overwrite IMAGE_FSTYPES variable in loacal.conf
 using placement of kas file wic-targz-img.yml
Thread-Index: Adk1lJkhdAoAy8u6THaeGpMSmHwfvAAe0fKAAAebvqA=
Date: Wed, 1 Feb 2023 11:39:48 +0000
X-TSB-HOP2: ON
Message-ID: <OSYPR01MB55424BC4715306ECD35D5396A4D19@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <OSYPR01MB5542AD9EF2424FAEB3FE588AA4D09@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <a45a8fa0-af8e-4f3c-ab11-c6e5bb771cc1@siemens.com>
In-Reply-To: <a45a8fa0-af8e-4f3c-ab11-c6e5bb771cc1@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYAPR01MB5915:EE_
x-ms-office365-filtering-correlation-id: 7d97d159-1eac-4a06-a816-08db0449063f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFKkLtCk3dyX+s+JQW/ksWg31VTtEx24OyJT0Id01p6vE8Mt5HUjxk7OCXI50ND1tHEDvmKf105dcOGNlaf4zVYzhMnkOjyBCriXFn9TJrfjtN4ozsGkuZw5tG17z8QJfz5pUQsnxCj3Laoosfg2XNfgEgODXvTJJcYZd5xLxoQ7bqYZqSp/qOfCVNe2WLFiqiuCaa2/mko8CHS2bpbRdRVW0eyh2CrjUEWIfAQjDyq6CEpsThHHDTKsVMKnG54uxyHO1Dtbcp2hCkl27tnVQ64UWANjKeQrGwLprXF4PDGGiR60ZaBwEzFFpMkh3T02QoO/766CTccUy6Ui55pzJbCqtbLTDp0poKKTjsZHONZGAzPYA4FjRh3AffJzgg+6EiVjj19pv7DOBbk1HQO7Wsigzhhxezgz6MSF+Ii7o9HddZ57faDDDt82YCte5B1e9LgVAj8oln5JG+uLNLBsH9FS4EjJcfZ2rlFGl6zhpi+5P0GhjRAlsbMypgiucoE65u70xrX9tYMAEKBUvkQkLxbVacaTACLatXhx6n3JrREIbKBBVcCFRQTMTZB2kcyj2xWpZH6i0Ur0MRKRgRa/IZgbNxW3L1Nk6Z7fbhDpdMU2ULEMKDAWjTP8oAKkqpnsUmfPUcO5Eouw+trPI59ryDoSgKLT762Jijyn6ZUyTBrrJc27kAqP6lkId7hl877S49o8jl8WXd7/4L3OWGWPdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199018)(33656002)(86362001)(38070700005)(85182001)(122000001)(8936002)(52536014)(38100700002)(66446008)(8676002)(76116006)(66946007)(6916009)(64756008)(66556008)(54906003)(41300700001)(316002)(55016003)(4326008)(66476007)(83380400001)(107886003)(2906002)(478600001)(9686003)(7696005)(26005)(186003)(71200400001)(5660300002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3QwWk5BclNsSjNvaC8rbnU1VDEvTitRNzJ0VXpGTDd0em91ZWRPekpadTVT?=
 =?utf-8?B?OVBjMEU4aTdVWXR0YWcrWnhrMUphV1lMRjFMWE9jM1VSMXdYUDA1Z2owbmMy?=
 =?utf-8?B?aCs5OWJ3K2JTMDY4M25yTDdadUJWU2prVVQrRnlxcWp5a0grVnRVWXREV2d5?=
 =?utf-8?B?T0lvZXBaWVNJUzVYNHI2SGRQemgzYjV2V254eEpQaWJ1WXRNU1ZFS0xKc2Vv?=
 =?utf-8?B?Z014SGlUamVFdm1xcDRZdzRYamxuRGcwbk1FS2w2alNtZGlKRnIwNTcvelc2?=
 =?utf-8?B?SGZJZWZNb2NkVmVCVW81R2RHTFdIMVpLZXZmV3Qrd2xIVFZWb1ZnSGhzdHox?=
 =?utf-8?B?eFUxc3F5OFdmTUcrNXhSTzFwempSNVh2a3lBNGxnOTVENzdueGU1eXliZmx4?=
 =?utf-8?B?NDVOOUJIYythR015YVpqck1WMWJxZ2l6QzBQR1RObmxiZTRJeWRYdENkMnRh?=
 =?utf-8?B?WEtuTTNndkpVV2tEaEx2UzVZc3pvbWpWUktraGdtazM5TGF5UVRLeSsxSTh3?=
 =?utf-8?B?dGpNT045S0QxaHhXT21GVEQ4NFoyY1MvQ2QvMGRTdVlZNUkxaWg0ajdYREo4?=
 =?utf-8?B?SGMvNFJSRnFSeHZiVVg5VkZpbDhTZjNQN0pQVUEwU29wOTMyRnUvcW9XL2k0?=
 =?utf-8?B?SlJPUk16aHFoL0w4dDR1ZnBIV3RZVW81YnZ3SDlMUTBaREpBR3p4M2RPdFkw?=
 =?utf-8?B?VDdpaUlvU3oyaXAxVDRhR1dzRnFicDFFTUdrVzBpMUsyZEIvOGNrb29FY3hW?=
 =?utf-8?B?R2RHYTMzejF5SlNkUDdUVGY4bUJBUk43RE5SWU9wT0R0NG1ZcDhWeGc0bkl1?=
 =?utf-8?B?VENlNmZXczR4eWs3bzd0Y1FxaDNETUwvejZjTjJKdlVicUJuRjF0UEQwYnNH?=
 =?utf-8?B?MTdkMkxiR0lkNGhFNGVyRCtsb0ZLRVV5dzRzZ3loUUJZbytOOHRQcGJtTzd0?=
 =?utf-8?B?aFZjK240aTZPckl1ZElrS3BFQUg0aE1tSkxTdWtFalR4Y0RiRnd2UXc4c2ps?=
 =?utf-8?B?M3VjelBpekxJaWc5U0xTVldQVXVCNXRGck13K2VHQWUzQUpocjdSemExYmVT?=
 =?utf-8?B?SVM2dmtFbEQranBGWHlCNnZtTWdIUmhrWGJUMFhEMkErTWFxM1pITmRTV3hE?=
 =?utf-8?B?V2RwbkFqRDFORXptRnBzemF6SjVEY3ltK1U5M0dpYVdsczlSMkVkcHovSHAw?=
 =?utf-8?B?MGkzSXBnNnhSWmY0N3FaRGp3UzBSaXMwamxlbnp5U3hJM1MyYlZyZnNhdE5s?=
 =?utf-8?B?L0tESENJYVgwdmtTVVF0My82WUJWRlFOcWZWeWVoMW1pMS9hUUtvK0o5dzJS?=
 =?utf-8?B?YjdrbFNrdHRmQzRqQkFRRE9mQ2xLT01mb2pTRzBhRVYyY3ZhalI3eEluRm9Q?=
 =?utf-8?B?bWlpV0NUMXRYNzNLZkNNT0FnNSsxTXpWQ002R0F3U05IdnpEbWR0dWVaQVli?=
 =?utf-8?B?SWxQaEY0b08xaXN0WmxVemFRaXQxelZBM3BFSUxHQkZZT0R4R1VjUVFEV3pV?=
 =?utf-8?B?R1lGQms1UFlyN3ZOL3U5VE9lTGdnTWF6bU1ZQkJObCtJN1ZwUlgrVTVOelR1?=
 =?utf-8?B?NjFHMWVqbUFCbWNUbk9KRVl2S083WHZ0ejRsbFpkWTBWWEg3LzA3YWxhMXJ4?=
 =?utf-8?B?SEtwYXdXVXJ5eFV5VXFTejhyVzVSR0ltbWgrYVRUSFdNY2RNcUlyTzBNaUc4?=
 =?utf-8?B?UmtYc0NROS9TL1lkOURTRVZnNXFIU21VblFMYnNCVkRhY0JFc1NmRGpPRmtm?=
 =?utf-8?B?alVDMTY1VmxPdzVqeGphZlJJd0d1Q3l4eUc5b3lFSmVGQm1wZ3gyNzYrY2xj?=
 =?utf-8?B?OVc5dC9BN0RvQzJPcWRWUytiVmlEYjVDcW1wZ29EcDNUT0ZPeDlJa0pHU256?=
 =?utf-8?B?NFBneEcxZjVQQVRzNGlpLzc4aWN3V0YwTHQzaGdnT1BoK0xPRmNtSnc3NHZK?=
 =?utf-8?B?NGYydFkveXBXK2k3V3A2N2NpTW9DYW9yU1RobVB2bVpXYzgrZ0w1UFgzL2Q5?=
 =?utf-8?B?QWdKR0ZiYW52NlM1Q2dRNHNTSkliTm5xZ29jZTJSdStiT3NmcDg4dEhEQjdN?=
 =?utf-8?B?S3BtODRUdHVKcGZXTkhNeXhFRXNVTkViNDZiMkZTOVRzT1NIZ3hFblRISFhr?=
 =?utf-8?B?UUR2aVU1MGRoUDhHYnRCeTBTVzZuRDErM0ZWTGlPdVhnRVBYNkxyVk02SVhE?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d97d159-1eac-4a06-a816-08db0449063f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 11:39:48.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wY67Yg2+Y0SECeH/EqAgB3v0CbnrKu4rQJZpIdjhw1k6sA0PaBy9Q2C0A32LzQWYA1n7hsgYR9DkFh/IxeVUkZURATaUYUWYuXwfJbnUQz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5915
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 11:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10554

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmDQo+
T2YgSmFuIEtpc3prYQ0KPlNlbnQ6IDAxIEZlYnJ1YXJ5IDIwMjMgMTM6MDYNCj5UbzogcHlsYSB2
ZW5rYXRhKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPFZlbmthdGEuUHlsYUB0b3No
aWJhLQ0KPnRzaXAuY29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj5DYzogZGlu
ZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0
b3NoaWJhLQ0KPnRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIOKWoe+8s++8
t++8o+KXr++8oe+8o++8tCkNCj48a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj5T
dWJqZWN0OiBSZTogW2NpcC1kZXZdIEhvdyB0byBvdmVyd3JpdGUgSU1BR0VfRlNUWVBFUyB2YXJp
YWJsZSBpbiBsb2FjYWwuY29uZg0KPnVzaW5nIHBsYWNlbWVudCBvZiBrYXMgZmlsZSB3aWMtdGFy
Z3otaW1nLnltbA0KPg0KPk9uIDMxLjAxLjIzIDE3OjU1LCBWZW5rYXRhLlB5bGFAdG9zaGliYS10
c2lwLmNvbSB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IEkgYW0gdHJ5aW5nIHRvIG92ZXJ3cml0ZSB0
aGUgSU1BR0VfRlNUWVBFUyB2YXJpYWJsZSB3aXRoIHRoZSB2YWx1ZXMgaW4gd2ljLQ0KPnRhcmd6
LWltZy55bWwgYnkga2VlcGluZyBhdCB0aGUgZW5kIGluIGthcyBmaWxlIGRlZmluaXRpb24gYXMg
c2hvd24gaW4gYmVsb3cNCj5jb21tYW5kLCBidXQgaXQgaXMgbm90IG92ZXJ3cml0aW5nLg0KPj4N
Cj4+ICQga2FzLWNvbnRhaW5lciBidWlsZA0KPj4ga2FzLWNpcC55bWw6a2FzL29wdC9lYmctc3d1
LnltbDprYXMvb3B0L3dpYy10YXJnei1pbWcueW1sDQo+Pg0KPj4ga2FzL29wdC9lYmctc3d1Lnlt
bCBpbmNsdWRlIGxvY2FsX2NvbmZfaGVhZGVyIGFzIGJlbG93DQo+PiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gbG9jYWxfY29uZl9oZWFkZXI6DQo+PiAgICAu
Li4NCj4+ICAgICB3aWMtc3d1OiB8DQo+PiAgICAgICAgICAuLi4NCj4+ICAgICAgICAgICBJTUFH
RV9GU1RZUEVTID0gIndpYyINCj4+ICAgICAgICAgIC4uLg0KPj4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+Pg0KPj4ga2FzL29wdC93aWMtdGFyZ3otaW1n
LnltbCBpbmNsdWRlIGxvY2FsX2NvbmZfaGVhZGVyIGFzIGJlbG93DQo+PiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gbG9jYWxfY29uZl9oZWFkZXI6DQo+PiAg
ICAuLi4NCj4+ICAgICBpbWFnZS10eXBlOiB8DQo+PiAgICAgICAgICAuLi4NCj4+ICAgICAgICAg
ICBJTUFHRV9GU1RZUEVTID0gIndpYyB0YXIuZ3oiDQo+PiAgICAgICAgICAuLi4NCj4+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pg0KPj4gRmluYWwgY29uZi9s
b2NhbC5jb25mIGdlbmVyYXRlIGFzIGJlbG93DQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPj4gIyBpbWFnZS10eXBlDQo+PiBJTUFHRV9GU1RZUEVTID0gIndp
YyB0YXIuZ3oiDQo+Pg0KPj4gLi4uDQo+Pg0KPj4gIyB3aWMtc3d1DQo+PiBJTUFHRV9GU1RZUEVT
ID0gIndpYyINCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
Pg0KPj4NCj4+IEV4cGVjdGluZyBjb25mL2xvY2FsLmNvbmYNCj4+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAjIHdpYy1zd3UNCj4+IElNQUdFX0ZTVFlQRVMg
PSAid2ljIg0KPj4NCj4+IC4uLg0KPj4NCj4+ICMgaW1hZ2UtdHlwZQ0KPj4gSU1BR0VfRlNUWVBF
UyA9ICJ3aWMgdGFyLmd6Ig0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4+DQo+PiBUaGUgYWJvdmUgaXMgcG9zc2libGUgd2hlbiBJIHVzZSBuYW1lIHdpdGgg
aGlnaGVyIGluIGFscGhhYmV0aWNhbA0KPj4gb3JkZXIgbGlrZSAnemltYWdlLXR5cGU6JyBpbiB0
aGUgd2ljLXRhcmd6LWltZy55bWwNCj4+IGthcy9vcHQvd2ljLXRhcmd6LWltZy55bWwgd2l0aA0K
Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IGxvY2FsX2Nv
bmZfaGVhZGVyOg0KPj4gICAgLi4uDQo+PiAgICAgemltYWdlLXR5cGU6IHwNCj4+ICAgICAgICAg
IC4uLg0KPj4gICAgICAgICAgIElNQUdFX0ZTVFlQRVMgPSAid2ljIHRhci5neiINCj4+ICAgICAg
ICAgIC4uLg0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
DQo+PiBJcyB0aGlzIHRoZSBvbmx5IHNvbHV0aW9uIHRvIHNldCB0aGUgb3JkZXIgb2YgdGhlIHZh
cmlhYmxlIGFzc2lnbm1lbnQgaW4NCj5sb2NhbF9jb25mX2hlYWRlcj8NCj4+DQo+DQo+bG9jYWwu
Y29uZiBub2RlcyBhcmUgYWxwaGFiZXRpY2FsbHkgc29ydGVkIGFzIHlvdSBhbHJlYWR5IGZvdW5k
IG91dCAtIHdlIHNob3VsZA0KPnByb2JhYmx5IGRvY3VtZW50IHRoYXQgaW4ga2FzLiBHZW5lcmFs
bHkgc3Bva2VuLCB5b3UgY2FuIG1ha2UgdXNlIG9mIHRoYXQgdG8NCj5hY2hpZXZlIGFwcGVuZCBi
ZWhhdmlvdXIsIG9yIHlvdSBvdmVyd3JpdGUgdGhlIG9yaWdpbmFsIG5vZGUgeW91IGFyZQ0KPmNv
bXBldGluZyB3aXRoLg0KPg0KPkluIGNhc2Ugb2YgaXNhci1jaXAtY29yZSwgd2UgY2FuIHJlYXJy
YW5nZSBvciBrYXMgb3B0aW9uIGZpbGVzIHNvIHRoYXQgeW91ciB1c2UNCj5jYXNlIGJlY29tZXMg
cG9zc2libGUgKHRob3VnaCBJJ20gdW5zdXJlIGlmIGl0IG1ha2VzIGFueSBzZW5zZToNCj50aGUg
Y29udGVudCBvZiB0aGUgdGFyLmd6IHdpbGwgYmUgb25seSBhIHN1YnNldCBvZiB0aGUgd2ljIHN3
dXBkYXRlIGltYWdlKS4NCg0KVGhhbmtzIGZvciBjb25maXJtaW5nLA0KSSB3YW50IHRvIGNyZWF0
ZSBzd3VwZGF0ZSBpbWFnZSB0aGF0IHNob3VsZCBnZW5lcmF0ZSBib3RoIHRhci5neiBhbmQgd2lj
IGltYWdlIGFuZCB1c2UgdGFyLmd6IGZvciByZXByb2R1Y2liaWxpdHkgY2hlY2tzLg0KDQpJIHBy
b2JhYmx5IGhhdmUgdG8gbW9kaWZ5IHRoaXMgZmlsZSBrYXMvb3B0L3N3dXBkYXRlLnltbCB0byBp
bmNsdWRlIGJvdGggaW4gSU1BR0VfRlNUWVBFUyA9ICJ3aWMgdGFyLmd6Ii4NCg0KPg0KPkphbg0K
Pg0KPi0tDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVk
ZGVkIExpbnV4DQoNCg==


