Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B777C47082
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 16:33:19 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.101])
 by mx.groups.io with SMTP id smtpd.web10.6328.1649235523456812103
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 01:58:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LrbgTEUv;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.101,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2kNqxpx5nMoR56XZecdsYL7vW2gi8D3WcQlL8/dMaELY2tbjMVPohDfiHM+o37Ca3TtXWcQT/Vr+tapoaT8z6rOH25A4UE3kVfR4ZduJv8uiyKBI38I//4mhrlKxR/vA6n/IpkOabUk386ih6+/GxBydlOIlUWCgw+M4i7iKaLnXL0+5BNDe2b5vU+BCK8kovRgxAxHJs2o/A0oQuny2gUJsrTUYg0NocpeVr5pBnaRSUiCNiWQSiWlr0Hwknn8OhW3KEvFNoXFQ74xEF5E60G/b+QPZMPVRetGLjI6Br14xaCK6Jgn4m29TgVZMcszUfkQiw1xUPQCHFQ90+J6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef470VfVqSzddAMx4ni0Iiroz7bmhpbFjOPJM7YPWG4=;
 b=AVhYVflBQ2Fqwly6egvX2ZX3ym3M08lZt8bxnetZICYLsD0rZ9P4uOl8neg9hQLc8ioXivTUmy3mMntQfEFWYwPBdPaCLQzY88TLj5Styvlhvlw7q5n7gsnNCzC7MUhG3RL6c0ozEVPWJIxhbTBlwlF/Xb/+GaZNQWzzV2MTl0jvqu4n80+vgJU1Q/7Jk90hiV/lrCsY289XDzkgC6HXfIXQ4sScBdtdqJ49BUrloZS0uWBzhbBcFevawtj5QFZ3FibwCH4lFSquxXPl2HUu8BPkAGaTbw9vwzN2ldKq8JmGoBoTM8A/+s+SGbDkNG3+NvhSdzZKeVpfhfHrXK5sXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef470VfVqSzddAMx4ni0Iiroz7bmhpbFjOPJM7YPWG4=;
 b=LrbgTEUvkJtmWUOUMietz7EvhwFRLf1w1oSYGbea9wGTUo04plWXmtsyzQ9cX1jAV4ppkIrBki6N82vnN75rpwb0UAvkp/edFDh8qQ8m1xajfWHlg3fPbysATXhHQ/nRs0yH7A/i4KBX1IhllNG0FApR3AE45WSGkXh32jFAy3E=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB7141.jpnprd01.prod.outlook.com (2603:1096:604:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:58:40 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9dda:1c9e:4a15:bddf%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:58:39 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 26/29] thermal/drivers: Add TSU driver for
 RZ/G2L
Thread-Topic: [PATCH 5.10.y-cip 26/29] thermal/drivers: Add TSU driver for
 RZ/G2L
Thread-Index: AQHYSSA5PD9cb8x9i0eUTuMhGzs0YazilcXA
Date: Wed, 6 Apr 2022 08:58:39 +0000
Message-ID: 
 <OSZPR01MB7019699D238A47207EB40806AAE79@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404123553.25851-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220405190610.GC27445@duo.ucw.cz>
In-Reply-To: <20220405190610.GC27445@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d58a6b2-6313-4207-c815-08da17aba4e6
x-ms-traffictypediagnostic: OS3PR01MB7141:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB7141C881BDEEA2EC5C66BCF1AAE79@OS3PR01MB7141.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5fTWouwxuJlD3hWneRfmobQDEQH7zNai1W9soZ23Ejgpn7kAq22bJC55rQFf7oCnUD2dBAJY2Z6vkvTOIH44fxKresvLhUWI88KTEN68rL6HnYeVFUzaAZZGxeTTqwLAca+JTOC+hdZ1tVf4VnQftc70Zvz7AKzO6rmQA6ZRiDFoXU9gbPwM+8HQIgYTo5XWHzGaRwEZ3W1I2jZKmXlDB3TgjoPVyq7FsYoeExVjOiSXQJ8xfF1GBlQZ07DTujX/KYoXDN7CMxGzyJ16TdDshDERNd2mJsl6kbYTzdEczqhJCytxX3XsrzsLKF3wipF3uMP/BXevcyM3EL3Zn7lp7P8dsXrx267TUEaY+A/qaRoe9zyIbq0IIqn/Jz+kMsU89EKqOjNRGRrXRoEoII93KReAfl9fdtoW3HoNtCsTcDTir46mRA9zffmX/3vekwbAPnKN9l8EGugTsCXi0lwRUsvve+tfUeHKWTaBU7s3sejo7CaGjFCgdDHH7mBFgqDZTTgvRGBtgwvjck7ixRCcG7VI+9qNcnSwu0zqEsMNfpu9vRwVHfYBjhrEPCMbx5eSSZDZUakKLnBhqfgJzADslmDN90/MZvPOreW181/RR5Yota3VyXlhUAYPjrDFW7qRs5B/ffIY76HeAj3hQ9yhPQTP5LOFqhkcqPqdxewtdWr5NXZRsRzmlxgFtQA8HBvkkBkT+PQ1xCq0f9RnPHqLhg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(66446008)(2906002)(53546011)(38100700002)(4326008)(38070700005)(9686003)(71200400001)(66476007)(8676002)(5660300002)(52536014)(33656002)(66556008)(8936002)(86362001)(64756008)(55016003)(508600001)(6506007)(54906003)(316002)(6916009)(186003)(83380400001)(26005)(122000001)(7696005)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?alc1eEFmbzl2STdxNDJiSDNBS3ZENEVPcXh5OXgzUWtsZjA2cFZSMmZMTnZi?=
 =?utf-8?B?TFJIVFBEMm9KdlJnUEJSWkRDTXdqbzMrMUgrM0toZ0JGUDdrMm5FTFNqcjU5?=
 =?utf-8?B?bnV2RjFaenNjMVJoMmZPS2xjS1psOWszN1N0aFBGWkY2L0JLbjA4UlNzSjlJ?=
 =?utf-8?B?a1JNYjdmZkFucDU0ZTBjWGhUbnZyQXVqeDNQbTcwaFFteUh4MDAwcEpxMUpF?=
 =?utf-8?B?TmpkUC90TlcraGdURkJjQWhVYW90SjJFRnFmNVFyVW05enhQaWZ4QW5iRW9v?=
 =?utf-8?B?NWI0bUtOQzdtQTR0VzBtTTVxT2tLNEMyNWNsMjB2UW8wSlVEbWI5UGVYc2tr?=
 =?utf-8?B?cW1TcUtGMmM1SUFqTzR4WFIwL1kydnB4RUpVcDhrbzdkck5DdUhvRXlkdEhO?=
 =?utf-8?B?TTdQVVR6WkhIOEY1OTFkdzlpZVJJVUtkTXlvbk9VWWJXMWE1MFY0TkZlUllv?=
 =?utf-8?B?dnBubEt1ZjhOVks0N204Zk02TC9IS3I1M241cVVPL1hoa1BjOWtWVnFsR1VB?=
 =?utf-8?B?RmhFazNlRG1ESzZVTXplWEVQTUZ6MmJuZDhJWDNmYWRXSHJhSmJ0ODRrQTY4?=
 =?utf-8?B?S0lqWHRtNTQ3UGpkYzJIcENZaHlxVUJVcVZXczQ5QWNPd1dEQWNBeFdseml3?=
 =?utf-8?B?dCtadEdzcEpwZFIrRU9nSFlFZllBMHcyZFJ3dm5nSDN0cS9xSkZ0VUt5YXRu?=
 =?utf-8?B?Q1ZtMUNoQ3I5Q1NIV0c1bHcvdmNBOFo1UGJ5SFJEQmUzZWlXMEtPdkVKeERu?=
 =?utf-8?B?alJWYWh1OTJxQmIzY1owRXJNN24wN2hOdU5HSnp6bXhBWFBIS242Y3FyUVFM?=
 =?utf-8?B?elV6QnZJOVZ6ZVJhdE9kT0N5ZmNKanc1b1JuUzZOcm5CTnc0cGtvb041WGxt?=
 =?utf-8?B?eUtoVTAxTFhUZzBLYTdWbFZiTnIzMlBrckM5cVhXd0U2VE1rZmkvT2dPc1dY?=
 =?utf-8?B?MTdVeXgwMXNsNEFjRjRzQmlIaGN4bFlBaUI5WTBKbnNyUjIvQVRRMGZkRUVq?=
 =?utf-8?B?MjVXd2xnM0FkRHh4M2c0M1JuSjdmUGdiQWRqK0Q2ZmZKT3p3UDhaRkRUWnNt?=
 =?utf-8?B?R3lGNzZFMHRmbXl2UnpyNXdTZ3p0SklBZFNSc05nLzhOQTNMMHFST1cvdkl1?=
 =?utf-8?B?VVZuZ1YxVS8yc21qTE1rMlE3K1BtRG43YTlERExWYW1aT0NEKzJscWxDWXlK?=
 =?utf-8?B?blFSVkFTT3l5eG1uSWpGNFZDWWRxRUVoMXB4ZmFCaWY0blFtV21qK1JjUjYv?=
 =?utf-8?B?d2ZKT1EyYkZrdjdDS1gwTVNPMFpnL0tad1pGTXNtMUcwZ0FBNFN5dTBURnRn?=
 =?utf-8?B?V25NQ0trdkd1S3FWUUptdEJHdzE4aTc1c1lETTNhRmdoTEpKcTQvQVhaaXQ1?=
 =?utf-8?B?N1NqYnI2aFB2bW9EQnJUYlJYZlZMNFBTa1VMSzJocWxMV0dHcmhXTWR2OWwr?=
 =?utf-8?B?bWpPVEd3T1dxYzRaeUdDVUpNSDViQWhabGs5NWNSQjI1WDJCVlZ4KzlKNEp4?=
 =?utf-8?B?NWZ1dEgxMFQrOTdab1lZM2VOcEhNVFMrQlkrOXFBcTNjTEJyYUI2R3pwYjR5?=
 =?utf-8?B?bTZiYW82MHd4clpwRWMvQnRVYnFBQWZvSm5SM2RQbzBuS2haREhNeC8yVytG?=
 =?utf-8?B?YWVlVnBXekpVajBpU3puU2RRSjM1cytjYzIwdFUxWFZHbDRxWG1vVWhPWWhD?=
 =?utf-8?B?NkM4VnUxM2JmS3pMUEFsQzVPTUMvUUx0b3c0L1B2NG5QN2VDMnNSc21iZTFz?=
 =?utf-8?B?TUVkVnBuZnVoQnhEenEyeXovUnA1VTBia3dTUllnMnJTOUtJeVZwN0xaN3Qw?=
 =?utf-8?B?RGtGbWJ6NGlLaFRWVm5OSEhBbCsrSnhCNlNlWnRvekJDR0RoRlZBbzlwNFUy?=
 =?utf-8?B?WkR3SzZkYlo1UkhHNFQxT09MUmVoYjlHRG1tdDMwcXkrMGxkRnkzUk5DNzh2?=
 =?utf-8?B?MGhCUlYxc2N4R3YwQjdBemFnR3VXZmNxQ3NoYnoxaWZYdFJCcDBCTnlHaHBp?=
 =?utf-8?B?U3VXUEZiTXFlWHczdWd0QkVaU2c5ZnpLblVDZTA0dWZqNTJCNEF6MUlTeER5?=
 =?utf-8?B?Rjlrbyt6WU8rdGFXMCtOVXpFVE1EL2lTY0poM0l6aTJpWHBiNXF2YW5zV3Rq?=
 =?utf-8?B?QXZPNWE3VkI2cnQveWhUQmxvQzVleVo0OUJjWWpMeHVVQTQrZzh6Y3NaNFgw?=
 =?utf-8?B?elVydTdhTXpuMmhIcVJuVXQ1U0ZoOGNud1QyUGVVSFRiRFNFeVRrNWhIU2NH?=
 =?utf-8?B?a09jUGVtM2VPL0VJNXFqaTZhMTJnOUxyc0tQZktSTEJiK3JtbDdXZFc3alg4?=
 =?utf-8?B?SVdmbDVuR2xkdkl3RWNxdW1oV3ltUkFSbEY1VlJQTlo4V3NNNU5OTjRoU3I2?=
 =?utf-8?Q?sETvtgH2L8xoSaQb26HSpP3v4dZykNmUxvrZ9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3d58a6b2-6313-4207-c815-08da17aba4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 08:58:39.8687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 wd8l8RPZOCryl0fEgMcmXEzdfSPk9LgS6WI9B1yAevS69oACFl2dfFPBx0wk6dyqoT9O0fxtbeyekO22lwIQySMmjS2HPVSEUNQoVk/cAZAnwYpmeiJPNuYwHdUcA346
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7141
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Apr 2022 16:33:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8014

SGkgUGF2ZWwsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IFNl
bnQ6IDA1IEFwcmlsIDIwMjIgMjA6MDYNCj4gVG86IFByYWJoYWthciBNYWhhZGV2IExhZCA8cHJh
Ymhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBDYzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc7IE5vYnVoaXJvIEl3YW1hdHN1DQo+IDxub2J1aGlybzEuaXdhbWF0
c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IEJpanUgRGFz
DQo+IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA1
LjEwLnktY2lwIDI2LzI5XSB0aGVybWFsL2RyaXZlcnM6IEFkZCBUU1UgZHJpdmVyIGZvcg0KPiBS
Wi9HMkwNCj4gDQo+IEhpIQ0KPiANCj4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQo+ID4NCj4gPiBjb21taXQgNjczYzY4YmQ0ODM5MGRhZDAxZjdkMTc2NzBk
ZTNlMzNiNjA4NjBhYyB1cHN0cmVhbS4NCj4gPg0KPiA+IFRoZSBSWi9HMkwgU29DIGluY29ycG9y
YXRlcyBhIHRoZXJtYWwgc2Vuc29yIHVuaXQgKFRTVSkgdGhhdCBtZWFzdXJlcw0KPiA+IHRoZSB0
ZW1wZXJhdHVyZSBpbnNpZGUgdGhlIExTSS4NCj4gPg0KPiA+IFRoZSB0aGVybWFsIHNlbnNvciBp
biB0aGlzIHVuaXQgbWVhc3VyZXMgdGVtcGVyYXR1cmVzIGluIHRoZSByYW5nZQ0KPiA+IGZyb20N
Cj4gPiDiiJI0MCBkZWdyZWUgQ2Vsc2l1cyB0byAxMjUgZGVncmVlIENlbHNpdXMgd2l0aCBhbiBh
Y2N1cmFjeSBvZiDCsTPCsEMuIFRoZQ0KPiA+IFRTVSByZXBlYXRzIG1lYXN1cmVtZW50IGF0IDIw
IG1pY3Jvc2Vjb25kcyBpbnRlcnZhbHMgYW5kIGF1dG9tYXRpY2FsbHkNCj4gPiB1cGRhdGVzIHRo
ZSByZXN1bHRzIG9mIG1lYXN1cmVtZW50Lg0KPiA+DQo+ID4gVGhlIFRTVSBoYXMgbm8gaW50ZXJy
dXB0cyBhcyB3ZWxsIGFzIG5vIGV4dGVybmFsIHBpbnMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFk
ZHMgVGhlcm1hbCBTZW5zb3IgVW5pdChUU1UpIGRyaXZlciBmb3IgUlovRzJMIFNvQy4NCj4gDQo+
ID4gKwkJLyogVFNVIHJlcGVhdHMgbWVhc3VyZW1lbnQgYXQgMjAgbWljcm9zZWNvbmRzIGludGVy
dmFscyBhbmQNCj4gLi4uDQo+ID4gKwkJICogdHNfY29kZV9hdmUgPSAodHNfY29kZVswXSArIOKL
ryArIHRzX2NvZGVbN10pIC8gOA0KPiA+ICsJCSAqLw0KPiANCj4gPiArCS8qIFRoZSB0ZW1wZXJh
dHVyZSBUaiBpcyBjYWxjdWxhdGVkIGJ5IHRoZSBmb3JtdWxhDQo+ID4gKwkgKiBUaiA9IChkc2Vu
c29yIOKIkiBjYWxpYjEpICogMTY1LyAoY2FsaWIwIOKIkiBjYWxpYjEpIOKIkiA0MA0KPiA+ICsJ
ICogd2hlcmUgY2FsaWIwIGFuZCBjYWxpYjEgYXJlIHRoZSBjYWxpYmVyYXRpb24gdmFsdWVzLg0K
PiA+ICsJICovDQo+IA0KPiBJJ2QgYXZvaWQgdXNpbmcgbm9uLUFTQ0lJIGNoYXJhY3RlcnMgd2hl
cmUgcG9zc2libGUuIC4uLiBpcyBub3QgdGhhdCBtdWNoDQo+IGxvbmdlciwgYW5kIHRoYXQgc3lt
Ym9sIHNob3VsZCByZWFsbHkgYmUgLS4NCj4gDQo+IEFsc28gY29tbWVudHMgc2hvdWxkIHN0YXJ0
IHdpdGggLyogb24gc2VwYXJhdGUgbGluZSwgYnV0IHRoYXQncyByZWFsbHkNCj4gZGV0YWlsLg0K
PiANCkFncmVlZC4NCg0KQ2hlZXJzLA0KUHJhYmhha2FyDQoNCj4gQmVzdCByZWdhcmRzLA0KPiAJ
CQkJCQkJCVBhdmVsDQo+IC0tDQo+IERFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21iSCwgICAg
ICBNYW5hZ2luZyBEaXJlY3RvcjogV29sZmdhbmcgRGVuaw0KPiBIUkIgMTY1MjM1IE11bmljaCwg
T2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGwsIEdlcm1hbnkNCg==

