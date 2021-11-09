Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F541C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 13:05:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.11530.1636463108392957824
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Nov 2021 05:05:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1A9D55c0010990;
 Tue, 9 Nov 2021 22:05:05 +0900
X-Iguazu-Qid: 2wGr0wVJrXnd9BXFKd
X-Iguazu-QSIG: v=2; s=0; t=1636463104; q=2wGr0wVJrXnd9BXFKd;
 m=gKdiKtk9HZVEe9tPVJ3/z0QR9UTXcDsjkXO0gWM6Iis=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 1A9D53fV035792
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 9 Nov 2021 22:05:04 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 7A1491000C4;
	Tue,  9 Nov 2021 22:05:03 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1A9D53SA028298;
	Tue, 9 Nov 2021 22:05:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbVOqyvaHOeIgEoAq/eXW/M3lP/LGU/npeVdr1cFWSY5ky3iACxiqlPCLgIFhXXX6BKVvvALgAo40ZjZDMM9wR8eTZwn8O7dGw1nimVcoWT+u0628m1zgOdRH0g3vkL/y7PQpAtsZIyvGnvD4wQvWgpWj37U2+cWnbMRvG1zYoa+kQ0wKQgmxXABkY+HXsfaSK1k1M1RAsQhiJFmpYZBUDTKS6AJjlOwpd+oyzj4i9BJmVq/33hXD5ZQfaXQkKmFcZznTpM/KHk1Faf+DwowIkGkRHl6TseSe322eZMt7QrYuBwQJ98q0lGftZ0TQ06Q+dYIlekDXqBd46UEPa/ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULwTgiBdMrjauZqlqu/JJjVQiIkWMP8iB+2i0AE6hxQ=;
 b=LgdQbbDvXDQpl93qEtx5rMZGBqqdfAxwm/yhtTNGT6SAFOxNuiMjsOHzTRzTQ5QTgEdpqjd5UGlFP6YAY9wpisJEIklREKyFbKSw7q55ZO7zJ6UGbhhFGSlU1BotdL4E8xcE7OKaeOQ1BnOSj7HxLUWhAMjDDFlV8PK+3jEcIeILFUInmA7d7kqvIqW1go7HKYLoplsKRdb2ltaOVzYqxiuDVO13GTq+aBHDdbgGjhYVlqTqa2O9vsZm/CiuYz6//UlPSLO2MczK5uB86It3EUDyJ5MovQocC7YfbOamZFXClCbxjNx1Si2g3m7DqXdpY72O3313hlBIXXf8QUgWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core][PATCH 0/2] kas update and menu support
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 0/2] kas update and menu support
Thread-Index: AQHXy8MHqTJlcN6iS0+o01n6U0wKyKv7F8IA
Date: Tue, 9 Nov 2021 13:04:51 +0000
X-TSB-HOP: ON
Message-ID: 
 <OSYPR01MB55427C8616B0C1D8F7A5D1B1A4929@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <cover.1634924446.git.jan.kiszka@siemens.com>
 <149e6d13-9472-8a5a-ca37-b16416a9fd6f@siemens.com>
 <a8b2ad8e-d7b7-744b-37e4-7f2ca63ca42d@siemens.com>
In-Reply-To: <a8b2ad8e-d7b7-744b-37e4-7f2ca63ca42d@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: siemens.com; dkim=none (message not signed)
 header.d=none;siemens.com; dmarc=none action=none
 header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d4c8c54-a880-4575-d51d-08d9a3818468
x-ms-traffictypediagnostic: OSBPR01MB3814:
x-microsoft-antispam-prvs: 
 <OSBPR01MB381478B8C32D0A9F116845EBA4929@OSBPR01MB3814.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vE9WrHos9Z5OMySShty723owFaw0I98nwudBMyQQjkye2yNF5sKOaBVmdWt2AKCdF8o19owlFKE0yKE4r0gXVGtKhm+/yqEOfhz4GPnQSZbkOXJwmHGMjfkPQNCucGq273hZ0ClCU6d0E8ZPgw40qCELaw7JfXlbXlIpu/ZzV66WSAxfXUQqgRLxvan1DSTn1dTHhHBi/3GsdDQRyGuIdX+UEuzoWxHxvMwwrHVFKSI5TKUMZ66PNc8wdSMPoPCTBGJ7rXIdut/Kz1bvqbh9Zo+jwHu6GxlAgKzA+EQeF2FrgyqZn73Lk+bjCdqWxZSCcPvH7I5FduGDoBmeEySZn5NyN9iEiIWUtnBEYAIFqYuVhqEMYWi8QVR9SDZkRfU5GLhairzsS+vhUPx5e41XR8/3oj/bVl99RSWPnI+2xz9vqr+2LqkiKTJU3iBinC+sw+PvwSicKocC5lkDnBL88iUl1l7NmTdpf12aaVltMY3wXvcTaCICr2uMMvP8pvF+fwybIL3RDP3N4Z4CB8OaJS11GIPsMO9BDQdWsTAzNmHcdz7LZFkHN+Eru73Tube/AN7Jcw9SsaFv6pbkae5ZY8ttWH4BiIs0VMmf6Qd2Fy1xr3fH32wvXhSJpD/n1h7E/R98Lo9kwfnpyl6Nvd87J9aWQ5d3+sX/wch+OC4xvrPEb6EHMLaFVKSdYBRSduCWDQYRwLPq2oV3QksYvLP4Tw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(8676002)(508600001)(2906002)(38070700005)(7696005)(316002)(54906003)(15650500001)(26005)(38100700002)(6506007)(33656002)(186003)(71200400001)(4326008)(53546011)(122000001)(6916009)(55016002)(66556008)(83380400001)(86362001)(76116006)(85182001)(66946007)(66446008)(9686003)(64756008)(8936002)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dEU3WlJtUUhxeDI4Qjd2RmM4QnhFTmlYVEwrQTU5aW9DT253N1BqUyt5Kzh5?=
 =?utf-8?B?dDRxLzJFajZLbGEyL0pURWlJMFhSdHhTSSthbU9Hd0djRG1zZlhJNW1ONXZh?=
 =?utf-8?B?cWw5MHZKM1dOQzF5NHFlZG1uMlNiZjVHY1gvQXdsQTlVbGUxRzd6SFcybzBC?=
 =?utf-8?B?MDYxeTBmUTZOZnIvR1d2bzVyV1ZxY3V0UVBOQzU2eDE4cHNMSWlEaUd5aFlK?=
 =?utf-8?B?dm5kM09EUjVHUTMrb1dvNHBwNGhLemxscHYzNlhsejV5N1dWR1M1eUFpZUlr?=
 =?utf-8?B?amc1UDJFMEFxN1ZYS3JuL1ZpaG9RS3FmSHc2Rm9HVWlnRElsOVRtWTI0akMy?=
 =?utf-8?B?RWlsaEpzK2IvbFV2bGk4NDRDbDNmMXdzY25BVlc1ZnpLZ3ZWUjVmVHVSaUtP?=
 =?utf-8?B?eDAwSEhwMkFJc1lrWnZkZ0EvMFRGenh6K2swdXIyTHpYN095NGxVd0VEVk5a?=
 =?utf-8?B?N0lpc0hhSUVrS3JWRGFLcXE2WDg1YW1hYTEySkRkL210MHJiNWZ2ZXRmdm1F?=
 =?utf-8?B?MGRyc0lsSXJhV2xqNVEzTXJpd1hMMDB4MHRScWdjNmlDZG03R0E0NWMxVFJQ?=
 =?utf-8?B?SXBWRmtVMU5vbi9iT1pLM1pQdi9oMVB1UjV5Q2FpVGcxNmZLS3g3dWNKSDUz?=
 =?utf-8?B?bFc3UHAramNIVVYrQmRHN0h0b2tlOUNBakpTeE5uY1VzWG1WUnFabHdXdm9z?=
 =?utf-8?B?Ly83aTh1TWVweWZVdXMzVFdvczhERFlEYzhleHIwSFVsRVVOR0tKYm4wV01m?=
 =?utf-8?B?YitVQXliN01nckZ0SGlub0xLSHNaWWpCQWxVb3duR3pZUmMrbmZyY3JjejRJ?=
 =?utf-8?B?M1dIYVhxL2pvK3ZKMkVHSEt1b0thM2U2Qk1jcmxHZkExdTNWVE9IVTNicE53?=
 =?utf-8?B?OU9mVCtUN0Nab3RQOWJaMnNSOFBST3oxbzd5cmh4QjZRSFROSTZuYXZIeUNs?=
 =?utf-8?B?MEMxZG5PSWtDdFpwMzN0VUg3SlJzNk5WOUkxWmc1S3V4cy9xdG8zaUJhQWFK?=
 =?utf-8?B?RnRIUThpcXdMYVpObHNLZk9IaUxsWnBqN2Zzczg2RHVjYm5uNXRxRm5lS1lh?=
 =?utf-8?B?Sk5ld01XWWlhb0VBeUJ1Q3VVVEx4WndaUGhSWHNpU2lSWlc2RGdqbzRWWjZK?=
 =?utf-8?B?Z013WGQ5UzRvYlVxbEF1SHYveFlFOVVhYjJ1eFNXbTl2aXh6ZVhhNzU0VnNa?=
 =?utf-8?B?bnhZM3lOUTRYMUliOHUwZ3k0R2tFNzVFRFU1VnloclRTb1RGMDJrbUwydWRQ?=
 =?utf-8?B?MkNwblFkR1JndGw4NS96WjF1SEc0R2h4czBKbzJjK1BLWDViNVMwcTcrT0JR?=
 =?utf-8?B?WVUxVmRqb29kbk56b3dmekt2SFg2R3NGUDBQYjVsREovdFk4ZlYwY3d0a24v?=
 =?utf-8?B?NEFSOGFkZytnUk5Wb1NEcU5UcENobGxsYnJEdVhabWQvaWU3MUo5OXJGOWwv?=
 =?utf-8?B?eCt3K3FnQlhpYlZRZ1VxVVg2NGoxc1ViSjk3VCtTU0xOOWxjMEd2OVBEUmtl?=
 =?utf-8?B?V0cwRk1jeDlrdXMyTUlUYnB2aEhQblNHcW85dnJkTk1NL3VSSWhURlNOR2VO?=
 =?utf-8?B?dFN5aUx5WEticWNXWXR0TjdVREVhdVpFR0ZjbVFpeVNzQkFtV0pFbVlPWUcw?=
 =?utf-8?B?TXNjdnFjNUFHL2hBblN5TGorYXI2MXo3d3FKd3pvRWVHV09McU1nOFFZeGZi?=
 =?utf-8?B?S1FsU3lHb3J4QlY2eXZuclN1OUFMUGJCdkhXTXVobUlIdWQ1aFg4QnZLcmVm?=
 =?utf-8?B?SU1lTGw0L3R3NndSek5WWEtBeFlnR3dYYk04aTZMTXg1S1QybWpSYXd0R1Fh?=
 =?utf-8?B?OWFwVGUyU0thaWZndzhQd2xyZ2FROXdZb3pkaHUvSDNpNklDdk0wSFlpQXQy?=
 =?utf-8?B?K3RPbXR3aHArVEY2N3dPSmZ4UUpPWmNxRFh3WFJpQXRVcWNTKzl5eFUvbWZu?=
 =?utf-8?B?TVFEMEU2Y3p5NXNaYzJSbkZxYmRRcE9HZ3AvdzlYNDBlVTArRU1ZUk81aXJy?=
 =?utf-8?B?ZnNpSHhLUUFKMHM0VkZQK3l5N3lrem1tNERwT3N1eGVsNlF3d2Z2TS8xMldw?=
 =?utf-8?B?SFg5U2RLSytFQ2VvRm9JMHJwOUh1WUswZUVZS1FZOTZXQXNpcjN2OWFVYm1I?=
 =?utf-8?B?SCtZU2ZkMGZ3V3gzdTNRWHVFaHBGV3A3YTg4bWdESmlQZ1BNV3dVY2puUmF2?=
 =?utf-8?B?QVRlODZpUlhnNmZIWEtTMERmTHFINzVFNHBpeGJkYVV3eTd5VFNMVGRTVmRX?=
 =?utf-8?B?dEFlYi81MlNtWFNVVzRjb1pMelZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2d4c8c54-a880-4575-d51d-08d9a3818468
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 13:04:51.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 cY6NXOvrSbMRkdbusWuw1Zzm3Jg9GJm0FK54GEPmpN4ffqli7fBlXJoNlB4YdNUfMEGXEkChgyZsEUqeiuhIZKPPcqBUJsLTx1m00j9kuFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3814
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Nov 2021 13:05:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6871

SGkgSmFuDQoNClNvcnJ5IGZvciBkZWxheWVkIHJlc3BvbnNlLg0KUGxlYXNlIGZpbmQgbXkgaW5s
aW5lIGNvbW1lbnRzLg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+
IE9uIEJlaGFsZiBPZg0KPkphbiBLaXN6a2ENCj5TZW50OiAyOCBPY3RvYmVyIDIwMjEgMTE6NDQN
Cj5UbzogR3lsc3RvcmZmIFF1aXJpbiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT47IGNp
cC1kZXZAbGlzdHMuY2lwLQ0KPnByb2plY3Qub3JnOyBweWxhIHZlbmthdGEo77y077yz77yp77yw
KSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+U3ViamVjdDogUmU6IFtjaXAtZGV2
XSBbaXNhci1jaXAtY29yZV1bUEFUQ0ggMC8yXSBrYXMgdXBkYXRlIGFuZCBtZW51IHN1cHBvcnQN
Cj4NCj5PbiAyNi4xMC4yMSAxMDoyMSwgR3lsc3RvcmZmIFF1aXJpbiB3cm90ZToNCj4+IEhpLA0K
Pj4NCj4+IE9uIDEwLzIyLzIxIDc6NDAgUE0sIEphbiBLaXN6a2Egd3JvdGU6DQo+Pj4gV2l0aCBr
YXMgMi42IGJlaW5nIHJlbGVhc2VkLCB0aGlzIG5vdyBhbGxvd3MgdG8gYWRvcHQgdGhlIG5ldyAi
bWVudSINCj4+PiBmZWF0dXJlIGFuZCBtYWtlIHRoZSB2YXJpb3VzIGltYWdlIGZsYXZvcnMgYW5k
IG9wdGlvbnMgbW9yZSBhY2Nlc3NpYmxlLg0KPj4+DQo+Pj4gUXVpcmluLCBwbGVhc2UgaGF2ZSBh
IGxvb2sgaWYgSSBtb2RlbGVkIHRoZSBkZXBlbmRlbmNpZXMgZm9yIHNlY3VyZQ0KPj4+IGJvb3Qg
YW5kIFNXVXBkYXRlIGNvcnJlY3RseSwgZXhwb3NlZCByZWFzb25hYmxlIGNvbWJpbmF0aW9ucyBh
bmQNCj4+PiBkaWRuJ3QgZm9yZ2V0IHNvbWV0aGluZyB1c2VmdWwuDQo+Pg0KPj4gSSBjaGVjayBp
dCBhbmQgYWxsIG9wdGlvbiBhcmUgdGhlcmUuDQo+Pg0KPg0KPlRoYW5rcyBmb3IgY2hlY2tpbmcs
IFF1aXJpbi4NCj4NCj5JdCBsb29rcyBsaWtlIHdlIHN0aWxsIGhhdmUgc29tZSBpc3N1ZXMgYXJv
dW5kIHRoZSBzZWN1cml0eSBpbWFnZS4gRm9yIHdoaWNoDQo+RGViaWFuIHJlbGVhc2VzIGlzIHRo
aXMgc3VwcG9ydGVkLCBWZW5rYXRhPw0KDQpXZSBoYXZlIGltcGxlbWVudGVkIHNlY3VyaXR5IGV4
dGVuc2lvbnMgb3JpZ2luYWxseSBmb3IgQnVzdGVyIHZlcnNpb24sIA0KT2YgY291cnNlIHdlIGFy
ZSBub3QgZmluYWxpemVkIHdoaWNoIERlYmlhbiByZWxlYXNlIHRvIGdvIGZvciBJRUMgY2VydGlm
aWNhdGlvbiwgY3VycmVudGx5IHVuZGVyIGRpc2N1c3Npb24gaW4gc2VjdXJpdHkgV0cuDQoNCkkg
aGF2ZSBjaGVja2VkIHRoZSBjdXJyZW50IGthcyBhbmQgbWVudSBpbXBsZW1lbnRhdGlvbiBhZ2Fp
bnN0IHRoZSBzZWN1cml0eSBleHRlbnNpb25zIGFuZCBpdCB3b3JrcyBmaW5lIHdpdGggYnVzdGVy
IHJlbGVhc2UsDQpidXQgbm90IHdpdGggYnVsbHNleWUsIGxvb2tzIGxpa2Ugc29tZSBzZWN1cml0
eSBwYWNrYWdlcyBhcmUgbm90IGF2YWlsYWJsZSBpbiBidWxsc2V5ZSwNCndlIHdpbGwgaW50ZXJu
YWxseSBkaXNjdXNzIHRoaXMgaW4gU2VjdXJpdHkgV0cgYW5kIGZpbmFsaXplIHRoZSBzZWN1cml0
eSBwYWNrYWdlcyBmb3IgYnVsbHNleWUgdmVyc2lvbiwNCmFuZCB0aGVuIHdlIGNhbiBlbmFibGUg
dGhlIHNlY3VyaXR5IGV4dGVuc2lvbnMgZm9yIGJ1bGxzZXllIHZlcnNpb24uDQoNClBsZWFzZSBs
ZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IG90aGVyIGlzc3VlcyB5b3Ugc2VlIHdpdGggc2Vj
dXJpdHkgaW1hZ2UuDQoNCj4+SmFuDQo+DQo+PiBRdWlyaW4NCj4+DQo+Pj4NCj4+PiBAYWxsOiBQ
bGVhc2UgcGxheSBhIGJpdCB3aXRoIHRoZSBvcHRpb25zIGFuZCBjaGVjayBpZiB5b3UgZmluZA0K
Pj4+IGFueXRoaW5nIHRoYXQgZG9lcyBub3Qgd29yayAoY3Jvd2Qtc291cmNlZCByYW5kY29uZmln
Li4uKS4NCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBKYW4NCj4+Pg0KPj4+IEphbiBLaXN6a2EgKDIp
Og0KPj4+IMKgwqAgVXBkYXRlIHRvIGthcyAyLjYNCj4+PiDCoMKgIEFkZCBrY29uZmlnIG1lbnUN
Cj4+Pg0KPj4+IMKgIC5naXRsYWItY2kueW1swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQ0KPj4+IMKgIEtjb25maWfCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTQ2DQo+Pj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gwqAgUkVBRE1FLm1kwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzOSArKysrLS0tDQo+
Pj4gwqAga2FzL29wdC9lYmctc2VjdXJlLWJvb3QtYmFzZS55bWzCoMKgwqDCoCB8wqDCoCAyICst
DQo+Pj4gwqAga2FzL29wdC9lYmctc2VjdXJlLWJvb3Qtc25ha2VvaWwueW1sIHzCoMKgIDIgKy0N
Cj4+PiDCoCBrYXMvb3B0L2ViZy1zbmFrZW9pbC1zd3UueW1swqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCA0ICstDQo+Pj4gwqAga2FzL29wdC9lYmctc3d1LnltbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqAgNCArLQ0KPj4+IMKgIDcgZmlsZXMgY2hhbmdlZCwgMTc3IGluc2Vy
dGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBLY29u
ZmlnDQo+Pj4NCj4+DQo+Pg0KPj4NCj4+DQo+Pg0KPg0KPg0KPi0tDQo+U2llbWVucyBBRywgVCBS
REEgSU9UDQo+Q29ycG9yYXRlIENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=


