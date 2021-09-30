Return-Path: <SRS0=Lgx5=OU=lists.cip-project.org=bounce+64572+6764+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF4C433EF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 06:33:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580CA61528
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 06:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 580CA61528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LY90YY4521723xXWhZL5hGCo; Wed, 29 Sep 2021 23:33:14 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.8923.1632983592906693969
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 23:33:14 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 18U6XAN3013830; Thu, 30 Sep 2021 15:33:11 +0900
X-Iguazu-Qid: 34trwupu9UHZohaQw3
X-Iguazu-QSIG: v=2; s=0; t=1632983590; q=34trwupu9UHZohaQw3; m=1UpwPB3ILnKuho9bG16TRrdPNSyev43htEiLp+TsrP8=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 18U6X9f8027953
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Sep 2021 15:33:10 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id C7ADD100113
	for <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 15:33:09 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 18U6X9SU004019
	for <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 15:33:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDSf0QZ3Dp9dJzQA+xe18rNqKkJp8dahtEF2aUYVwCwb7HRGiqmtYBIORlsjJjbfyspSXzYe1WAQnQuv/nY3L7IwvHCyeWFCEaTzj489f3mt5XI3/GnUO1ywqiW/5EtVBbru4k68Cwa9R7wtqtoQIqT6oBLFk27HMIJ4jgHeDmIsEAg1p65cg2U5Fm98sTyG4mX757wHAZW618CnJNx55HBPiVGJtMXUrok7hpkYCXUL6OD5jdQysn/YQSNouumBRiSa20nXtDjcGsFhVLHzuUlmb/lyMz0A8bkymckCPdsGR3svUwarilpTwL9wIObQs3XIsjj6tZh2WMiFQYjEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rSTFrRWCkJgNDszz9gqEXyqLsdx2l+JSOGG6LobwfRI=;
 b=SadGF7k+LmDUW1Z4GMxNMomeKYK10zKYWNchQOS+Flg5D5LcGToCv3WoUj5hTQ6aIrcj7N4jlTerjFAZSsGy4QjMlFZl//Xoi4fYlhUkhRNkqNETJm9/aP4okx6rVWLgaW3I17EwkK+vthTu7to0xo1oo+97jBJQ7b4hUynxNGNjIwzmv0NTmg5Bq3H7VyZjf0QZA1vsqD/w8lyTOqf4OM/kfJJCxyguizzF7lCAh88w4LuuLXaSHbNddAm4FcfhW+RB+zaS0ntGIzXGsvoITcPc83/kxsiq+CbDqKmUn4phbH0pEZ69Hx988rwDt7aFHUKscq+m+KWM8yDVVNWqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entry this week
Thread-Topic: [cip-dev] New CVE entry this week
Thread-Index: AQHXtY/3Xg+1LvnEi0iopeVfzjZuL6u8HcQQ
Date: Thu, 30 Sep 2021 06:33:06 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625208BDE921AFB1D540B83D92AA9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <CAODzB9qObzKXuh+WaSqh_KD=T2NfZw79d-NnXFX1vmNGj5wsqQ@mail.gmail.com>
In-Reply-To: <CAODzB9qObzKXuh+WaSqh_KD=T2NfZw79d-NnXFX1vmNGj5wsqQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: yes
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb4e9218-75ca-4858-84af-08d983dc29b1
x-ms-traffictypediagnostic: TYXPR01MB1805:
x-microsoft-antispam-prvs: <TYXPR01MB18053303C7890AD7904CAD8192AA9@TYXPR01MB1805.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: mQYpa/3T8WVw86o/t6YDgMHuDr27Bw3bJGLfcBjBay7WlpOeR/10CFyvKoRxkTJfCK3CNJmCf2pFvINUwZR+3auF8QKo6WAYJVZfqqRP3xpMCrDt6QxsYI2vwM7fzZ4C06NddAi9yaYp86gPOtpsqA4BDX41Og7Qik9Qk8YF3V1NJYXw/PF301xrnjHmggyoFlLpFXri+eEJ1gbOZFzdlsRFldchWuOUOHZmBNB0BPSCdL9amzlZAIS4QejBK4IVcpyr1d3SrREDbEqDZaORRttqfMmZDdaczzXumZgD41cUzTFZLP17eM6UKYmtNA18T2ac9TQLBrEppiMMbqGrvbkRyW7BKzfBfQas0rFYWK4qWk1TMyaTWWi0zPbweuXgffQu23g+bSJS4/U8nynYTQ7+JMCpShqyKrNEvNMWOZ+1kEXScNhkz30GyX6abw8EJnyDhVSuyHI8BwEx54Xk5Av1Hro+2JSqkhotpPE2zjfbbs99Zj4gtlUaY3d5kbAWKvm53WflTLmbdqZCGA5jrdm/CCkWvq47pcazkW6/Lfyk9DakwUuzstNFfw050gHsPZ2Xaoc3W9QTRJ8YDPOMbTypNhRf4TIxB4bof5xiUzveGxAYBZkTjdsDxM3ONtoi9ffeF4RsN1VKbJeNjTPMYdUNFDmmdHrmxU5c3Rpg2hv4ayD6h+dgdDMYMB9YBOjZfIP867xXFRLIPdVU2oIDzB/1Yxb3jmSOOadiIRb+8r4PvsL6/ZeLJDsDNN67moBuCv2hrTJTUHKxUlq0ClcfpKmRsMPbi0qUzFO2TZ9DabY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFo2cS9MSERJa1c5eUJ2K1Zwemh4Z1RhSG9aM3dnWlRnTVBWYisxdG5mWHpD?=
 =?utf-8?B?bmRra0M1dVorcDR4d0xqYmJ2dGgvV3Ixdkg3RGRIdlNrUGtMczUyNFVXdFlQ?=
 =?utf-8?B?SXcxTWd3WmhJYTMrUmdQaGJ3aUUyQm1mWnNqZ01RWUlmYStveUVCdEtCV0Vl?=
 =?utf-8?B?QUxscUJ3bUdiK0c3U29MMlVuRFhCRDR5UE1sMHFTZG1oMnJaZ3B2QzB6Wjl0?=
 =?utf-8?B?aEFERjZGbkw3L2Q4cTU1bXhwZUV2OElpYXZaQVUwVGFxSmNqOUpwKzlEWEc3?=
 =?utf-8?B?Z3dhWnJxUTRHaEtXYmFUd0NRZnJFN3hUV055SE40eUd5VXJEYVVmQVdWUTMr?=
 =?utf-8?B?TThra0w4UVRJanFPRkFDbHJTMzc5WTdxOGltczF6a3NhRWpyWkN4YzIzZ2di?=
 =?utf-8?B?Ri9UTGdrNjNETEtxVVozRnk4SzArRzRaNjFqZjRndWdLTFBWTzRXbkl6UVhX?=
 =?utf-8?B?MnpzQlpvbm0rWUxqOWorTTE1R2Z6MFJsNHlSNk5sbmZQRUdUYWpicU5Zd1Jp?=
 =?utf-8?B?empzbG8xTEt4dmRiOGIwc2RWZ3d6SDc0L3ppRVpTaFlxa2FOR3lOSkVZODVo?=
 =?utf-8?B?S0ZVZFo0OFdVL3Ftd0pBT0liZFB4TUlTN0dpS1BQV3FGOE4xRDZjMm5HN2sy?=
 =?utf-8?B?R3pKdmNBZm1JMVYrRnlycW5pbW9mSGZ2UmlqQVgrUkdlYjJpRmJZQ09zQnRR?=
 =?utf-8?B?UkI5NitzdUpKYW9RUGtvcUZPeFdQMS9DN3ptZWpOWEpNOVlDdmZlTkpiWjhN?=
 =?utf-8?B?aWQyWkVyYzZLSUs4Rkw3UVU0dWpvOStxU2dIcUtsazdPZUlkR3Q5dGdCWE00?=
 =?utf-8?B?VWRCOHFaaHk4TDhDbXFNNU1MQ1ozZXBRTjRDS1RuYWF4OW8xQVh5eWRCR1BH?=
 =?utf-8?B?QzhSZHlSbDA4SVVHelV5dElaSlprblpLZ0V1aEdlYVJFVnhiNmxjOTMyVk5M?=
 =?utf-8?B?TktES3l2bW9ObkdMam0yUlhEVmtIZENGSU9ZL0N4N2g3WDlPUW1FNzBZTTBv?=
 =?utf-8?B?OWMvVFlPTldQYnFaVW5iU2dWeE1xbnk5SFpDWkc0a2Rrb1pHeDZQRUNXMTY0?=
 =?utf-8?B?MCtuN2NvVFA2RlVNUE80cTc1L2VDckVBTUlTdlhBWDU0RTFhREtsQkdZNWx1?=
 =?utf-8?B?NC90V056VTQyN0NVTytKMFRRc2NSemQ0dVVnd3Y2Z3FUbUMwK3BtbUc5Z0Vw?=
 =?utf-8?B?Wlo0bzAwbXdteVFtRXFWS0FYMFZVbDVrTFpaSUZjTVU3T0RoY1dPSzZPcWZk?=
 =?utf-8?B?NzF1dmNjREo5Tmw4cnJ2bmg1UlpCR2NBVTdjczg4RXZ6QXJKOEJ2OGZLQ1BH?=
 =?utf-8?B?RnpzMmJPV2tmQTdrUTlwMldad0YwMFZQNWhYUEJlSW4wVENndlRPR3MwQUYy?=
 =?utf-8?B?amJHMlFBaDVkclpTVzNGZ0k5cjJWcnNmZ3h6S3kzN2J0M3pXNTFENUhNUWE0?=
 =?utf-8?B?T05yb3BLRUNNMVc2eG9SMDVNMjVCa2MvekU0ZTBqSm4xdHNTRlZjQmkwSXpY?=
 =?utf-8?B?SHJwSkpCeUpjNWZjVlpTWGtjZHBqaFdNUnlUbzhyVTRkS0VRbnhXcm5Ya3RI?=
 =?utf-8?B?YjNFaE52RkRhYVRULzUwaTc4ZVRuNTNORDhzUnpHckwrMEd5akNjaEFKUzc3?=
 =?utf-8?B?VGF5ZkVuSitGY3BEa1JIZGZBaTMxVGt4SUwvcEk4OHQvcFJHK05IZlpsekU5?=
 =?utf-8?B?ek1sYy82OERvYS9UNVZpNmh3TU04Z2NEWlNmRWgweUgzM0xEeHdqZHpTa2Vm?=
 =?utf-8?Q?o5H5iHdyd3fJEtsLy6HyWYxgr4bn7Q0z+OADsz2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4e9218-75ca-4858-84af-08d983dc29b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 06:33:06.4094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CF2jOG0KHXzchSmbMZXCTxqvVwU6gYQXotw9bS9HcCbeLjix+W0wENiUUaedF5G8mY0sFK+AsdmcDowJMj/RfF+2NpCXD+Zf/DpDG6JawjPD5dbI1Up0B7D8y5HgSqaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1805
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
X-Gm-Message-State: 9m9UqIgR2jEKDVo1bD08xZWkx4520388AA=
Content-Language: ja-JP
Content-Type: multipart/mixed;
	boundary="_002_TYAPR01MB625208BDE921AFB1D540B83D92AA9TYAPR01MB6252jpnp_"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632983594;
 bh=YrUhWSK+BxyDmup+e1xRwiyWadBIzgpAN8mG/1dwtPY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZJGC+890ZXzZ6wOUHaEbGiO9rFnQPEYEJhO+2eBccK0rxmvB3Dwq6gaiWqK8d4VKcLT
 z/oV1staimE/ASI2PokE0hPs2UXxdkuOQahWEyt3TgQXDxj3mpPe9RinluO5OrHoFlK9I
 KjFZHyyFkPzpJ8L4pwCQVCvVg9zBWq0l6hs=
Message-ID: <20210930063306.Dm47sBrbyTNlujrjKESX2wVAlUKl6alf2B1URTsVNvM@z>

--_002_TYAPR01MB625208BDE921AFB1D540B83D92AA9TYAPR01MB6252jpnp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
XSBPbiBCZWhhbGYgT2YgTWFzYW1pIEljaGlrYXdhDQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1i
ZXIgMzAsIDIwMjEgOToxMiBBTQ0KPiBUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmc+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBOZXcgQ1ZFIGVudHJ5IHRoaXMgd2Vlaw0K
PiANCj4gSGkgIQ0KPiANCj4gSXQncyB0aGlzIHdlZWsncyBDVkUgcmVwb3J0Lg0KPiANCj4gVGhp
cyB3ZWVrIHJlcG9ydGVkIG9uZSBuZXcgQ1ZFLg0KPiANCj4gKiBOZXcgQ1ZFcw0KPiANCj4gQ1ZF
LTIwMjEtMjAzMTc6IGxpYi90aW1lcnF1ZXVlOiBSZWx5IG9uIHJidHJlZSBzZW1hbnRpY3MgZm9y
IG5leHQgdGltZXINCj4gDQo+IFRoaXMgYnVnIGhhcyBiZWVuIGZpeGVkIGluIDUuNC1yYzEgc28g
dGhhdCBiZWZvcmUgNS40IGtlcm5lbHMgYXJlDQo+IGFmZmVjdGVkLiBGb3IgNC4xOSwgcGF0Y2gg
Y2FuIGJlIGFwcGxpZWQgd2l0aG91dCBhbnkgbW9kaWZpY2F0aW9uLiBGb3INCj4gNC40LCBpdCBu
ZWVkcyB0byBtb2RpZnkgcGF0Y2ggdG8gYXBwbHkgaXQuDQo+IEFjY29yZGluZyB0byB0aGUgZGVz
Y3JpcHRpb24gaW4NCj4gY3ZlLm1pdHJlLm9yZyhodHRwczovL2N2ZS5taXRyZS5vcmcvY2dpLWJp
bi9jdmVuYW1lLmNnaT9uYW1lPUNWRS0yMDIxLTIwMzE3KSwNCj4gaXQgZGVzY3JpYmVzICJUaGlz
IGZsYXcgYWxsb3dzIGEgbG9jYWwgYXR0YWNrZXIgd2l0aCBzcGVjaWFsIHVzZXINCj4gcHJpdmls
ZWdlcyB0byBjYXVzZSBhIGRlbmlhbCBvZiBzZXJ2aWNlIiBzbyBJIHRoaW5rIHRoaXMgdnVsbmVy
YWJpbGl0eQ0KPiBzZXZlcml0eSBtYXkgYmUgbG93Lg0KPiANCj4gQ1ZTUyB2MyBzY29yZSBpcyBu
b3QgcHJvdmlkZWQuDQo+IA0KPiBGaXhlZCBzdGF0dXMNCj4gDQo+IG1haW5saW5lOiBbNTExODg1
ZDcwNjFlZGEzZWIxZmFmM2Y1N2RjYzkzNmZmNzU4NjNmMV0NCj4gc3RhYmxlLzUuMTA6IFs1MTE4
ODVkNzA2MWVkYTNlYjFmYWYzZjU3ZGNjOTM2ZmY3NTg2M2YxXQ0KPiBzdGFibGUvNS4xNDogWzUx
MTg4NWQ3MDYxZWRhM2ViMWZhZjNmNTdkY2M5MzZmZjc1ODYzZjFdDQo+IHN0YWJsZS81LjQ6IFs1
MTE4ODVkNzA2MWVkYTNlYjFmYWYzZjU3ZGNjOTM2ZmY3NTg2M2YxXQ0KDQpUaGlzIGNvbW1pdCBj
YW4gYmUgYXBwbGllZCBkaXJlY3RseSB0byA0LjE0IGFuZCA0LjE5Lg0KSG93ZXZlciwgb3RoZXIg
TFRTcyBuZWVkIHRvIGJlIG90aGVyIGNvbW1pdCBvciBmaXhlcy4NCg0KSSBhdHRhY2hlZCBhIHBh
dGNoIGZvciA0LjE0IGFuZCA0LjE5Lg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--_002_TYAPR01MB625208BDE921AFB1D540B83D92AA9TYAPR01MB6252jpnp_
Content-Type: application/octet-stream;
	name="0001-lib-timerqueue-Rely-on-rbtree-semantics-for-next-tim.patch"
Content-Description: 0001-lib-timerqueue-Rely-on-rbtree-semantics-for-next-tim.patch
Content-Disposition: attachment;
	filename="0001-lib-timerqueue-Rely-on-rbtree-semantics-for-next-tim.patch";
	size=4443; creation-date="Thu, 30 Sep 2021 06:32:37 GMT";
	modification-date="Thu, 30 Sep 2021 06:32:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYjM0M2M3ZTRhY2JjZDc5NTE3MDE1YjRhZTk5MmFhN2IwZTM0NWNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZGxvaHIgQnVlc28gPGRhdmVAc3Rnb2xhYnMubmV0PgpE
YXRlOiBXZWQsIDI0IEp1bCAyMDE5IDA4OjIzOjIzIC0wNzAwClN1YmplY3Q6IFtQQVRDSCBmb3Ig
NC4xNCBhbmQgNC4xOV0gbGliL3RpbWVycXVldWU6IFJlbHkgb24gcmJ0cmVlIHNlbWFudGljcyBm
b3IgbmV4dCB0aW1lcgoKY29tbWl0IDUxMTg4NWQ3MDYxZWRhM2ViMWZhZjNmNTdkY2M5MzZmZjc1
ODYzZjEgdXBzdHJlYW0uCgpTaW1wbGlmeSB0aGUgdGltZXJxdWV1ZSBjb2RlIGJ5IHVzaW5nIGNh
Y2hlZCByYnRyZWVzIGFuZCByZWx5IG9uIHRoZSB0cmVlCmxlZnRtb3N0IG5vZGUgc2VtYW50aWNz
IHRvIGdldCB0aGUgdGltZXIgd2l0aCBlYXJsaWVzdCBleHBpcmF0aW9uIHRpbWUuClRoaXMgaXMg
YSBkcm9wIGluIGNvbnZlcnNpb24sIGFuZCB0aGVyZWZvcmUgc2VtYW50aWNzIHJlbWFpbiB1bnRv
dWNoZWQuCgpUaGUgcnVudGltZSBvdmVyaGVhZCBvZiBjYWNoZWQgcmJ0cmVlcyBpcyBiZSBwcmV0
dHkgbXVjaCB0aGUgc2FtZSBhcyB0aGUKY3VycmVudCBoZWFkLT5uZXh0IG1ldGhvZCwgbm90aW5n
IHRoYXQgd2hlbiByZW1vdmluZyB0aGUgbGVmdG1vc3Qgbm9kZSwKYSBjb21tb24gb3BlcmF0aW9u
IGZvciB0aGUgdGltZXJxdWV1ZSwgdGhlIHJiX25leHQobGVmdG1vc3QpIGlzIE8oMSkgYXMKd2Vs
bCwgc28gdGhlIG5leHQgdGltZXIgd2lsbCBlaXRoZXIgYmUgdGhlIHJpZ2h0IG5vZGUgb3IgaXRz
IHBhcmVudC4KVGhlcmVmb3JlIG5vIGV4dHJhIHBvaW50ZXIgY2hhc2luZy4gRmluYWxseSwgdGhl
IHNpemUgb2YgdGhlIHN0cnVjdAp0aW1lcnF1ZXVlX2hlYWQgcmVtYWlucyB0aGUgc2FtZS4KClBh
c3NlcyBzZXZlcmFsIGhvdXJzIG9mIHJjdXRvcnR1cmUuCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZGxv
aHIgQnVlc28gPGRidWVzb0BzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIg
PHRnbHhAbGludXRyb25peC5kZT4KTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5
MDcyNDE1MjMyMy5ib2pjaWVpM211dmZ4YWxtQGxpbnV4LXI4cDUKUmVmZXJlbmNlOiBDVkUtMjAy
MS0yMDMxNwpTaWduZWQtb2ZmLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSAoQ0lQKSA8bm9idWhpcm8x
Lml3YW1hdHN1QHRvc2hpYmEuY28uanA+Ci0tLQogaW5jbHVkZS9saW51eC90aW1lcnF1ZXVlLmgg
fCAxMyArKysrKystLS0tLS0tCiBsaWIvdGltZXJxdWV1ZS5jICAgICAgICAgICB8IDMwICsrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCAyNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3RpbWVycXVl
dWUuaCBiL2luY2x1ZGUvbGludXgvdGltZXJxdWV1ZS5oCmluZGV4IDc4YjhjYzczZjEyZmM5Li5h
ZmYxMjJmMTA2MmE4MyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC90aW1lcnF1ZXVlLmgKKysr
IGIvaW5jbHVkZS9saW51eC90aW1lcnF1ZXVlLmgKQEAgLTEyLDggKzEyLDcgQEAgc3RydWN0IHRp
bWVycXVldWVfbm9kZSB7CiB9OwogCiBzdHJ1Y3QgdGltZXJxdWV1ZV9oZWFkIHsKLQlzdHJ1Y3Qg
cmJfcm9vdCBoZWFkOwotCXN0cnVjdCB0aW1lcnF1ZXVlX25vZGUgKm5leHQ7CisJc3RydWN0IHJi
X3Jvb3RfY2FjaGVkIHJiX3Jvb3Q7CiB9OwogCiAKQEAgLTI5LDEzICsyOCwxNCBAQCBleHRlcm4g
c3RydWN0IHRpbWVycXVldWVfbm9kZSAqdGltZXJxdWV1ZV9pdGVyYXRlX25leHQoCiAgKgogICog
QGhlYWQ6IGhlYWQgb2YgdGltZXJxdWV1ZQogICoKLSAqIFJldHVybnMgYSBwb2ludGVyIHRvIHRo
ZSB0aW1lciBub2RlIHRoYXQgaGFzIHRoZQotICogZWFybGllc3QgZXhwaXJhdGlvbiB0aW1lLgor
ICogUmV0dXJucyBhIHBvaW50ZXIgdG8gdGhlIHRpbWVyIG5vZGUgdGhhdCBoYXMgdGhlIGVhcmxp
ZXN0IGV4cGlyYXRpb24gdGltZS4KICAqLwogc3RhdGljIGlubGluZQogc3RydWN0IHRpbWVycXVl
dWVfbm9kZSAqdGltZXJxdWV1ZV9nZXRuZXh0KHN0cnVjdCB0aW1lcnF1ZXVlX2hlYWQgKmhlYWQp
CiB7Ci0JcmV0dXJuIGhlYWQtPm5leHQ7CisJc3RydWN0IHJiX25vZGUgKmxlZnRtb3N0ID0gcmJf
Zmlyc3RfY2FjaGVkKCZoZWFkLT5yYl9yb290KTsKKworCXJldHVybiByYl9lbnRyeShsZWZ0bW9z
dCwgc3RydWN0IHRpbWVycXVldWVfbm9kZSwgbm9kZSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9p
ZCB0aW1lcnF1ZXVlX2luaXQoc3RydWN0IHRpbWVycXVldWVfbm9kZSAqbm9kZSkKQEAgLTQ1LDcg
KzQ1LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIHRpbWVycXVldWVfaW5pdChzdHJ1Y3QgdGltZXJx
dWV1ZV9ub2RlICpub2RlKQogCiBzdGF0aWMgaW5saW5lIHZvaWQgdGltZXJxdWV1ZV9pbml0X2hl
YWQoc3RydWN0IHRpbWVycXVldWVfaGVhZCAqaGVhZCkKIHsKLQloZWFkLT5oZWFkID0gUkJfUk9P
VDsKLQloZWFkLT5uZXh0ID0gTlVMTDsKKwloZWFkLT5yYl9yb290ID0gUkJfUk9PVF9DQUNIRUQ7
CiB9CiAjZW5kaWYgLyogX0xJTlVYX1RJTUVSUVVFVUVfSCAqLwpkaWZmIC0tZ2l0IGEvbGliL3Rp
bWVycXVldWUuYyBiL2xpYi90aW1lcnF1ZXVlLmMKaW5kZXggMGQ1NGJjYmM4MTcwYzcuLjdhOGFl
M2Q1ZmQ0MDU3IDEwMDY0NAotLS0gYS9saWIvdGltZXJxdWV1ZS5jCisrKyBiL2xpYi90aW1lcnF1
ZXVlLmMKQEAgLTM5LDkgKzM5LDEwIEBACiAgKi8KIGJvb2wgdGltZXJxdWV1ZV9hZGQoc3RydWN0
IHRpbWVycXVldWVfaGVhZCAqaGVhZCwgc3RydWN0IHRpbWVycXVldWVfbm9kZSAqbm9kZSkKIHsK
LQlzdHJ1Y3QgcmJfbm9kZSAqKnAgPSAmaGVhZC0+aGVhZC5yYl9ub2RlOworCXN0cnVjdCByYl9u
b2RlICoqcCA9ICZoZWFkLT5yYl9yb290LnJiX3Jvb3QucmJfbm9kZTsKIAlzdHJ1Y3QgcmJfbm9k
ZSAqcGFyZW50ID0gTlVMTDsKLQlzdHJ1Y3QgdGltZXJxdWV1ZV9ub2RlICAqcHRyOworCXN0cnVj
dCB0aW1lcnF1ZXVlX25vZGUgKnB0cjsKKwlib29sIGxlZnRtb3N0ID0gdHJ1ZTsKIAogCS8qIE1h
a2Ugc3VyZSB3ZSBkb24ndCBhZGQgbm9kZXMgdGhhdCBhcmUgYWxyZWFkeSBhZGRlZCAqLwogCVdB
Uk5fT05fT05DRSghUkJfRU1QVFlfTk9ERSgmbm9kZS0+bm9kZSkpOwpAQCAtNDksMTkgKzUwLDE3
IEBAIGJvb2wgdGltZXJxdWV1ZV9hZGQoc3RydWN0IHRpbWVycXVldWVfaGVhZCAqaGVhZCwgc3Ry
dWN0IHRpbWVycXVldWVfbm9kZSAqbm9kZSkKIAl3aGlsZSAoKnApIHsKIAkJcGFyZW50ID0gKnA7
CiAJCXB0ciA9IHJiX2VudHJ5KHBhcmVudCwgc3RydWN0IHRpbWVycXVldWVfbm9kZSwgbm9kZSk7
Ci0JCWlmIChub2RlLT5leHBpcmVzIDwgcHRyLT5leHBpcmVzKQorCQlpZiAobm9kZS0+ZXhwaXJl
cyA8IHB0ci0+ZXhwaXJlcykgewogCQkJcCA9ICYoKnApLT5yYl9sZWZ0OwotCQllbHNlCisJCX0g
ZWxzZSB7CiAJCQlwID0gJigqcCktPnJiX3JpZ2h0OworCQkJbGVmdG1vc3QgPSBmYWxzZTsKKwkJ
fQogCX0KIAlyYl9saW5rX25vZGUoJm5vZGUtPm5vZGUsIHBhcmVudCwgcCk7Ci0JcmJfaW5zZXJ0
X2NvbG9yKCZub2RlLT5ub2RlLCAmaGVhZC0+aGVhZCk7CisJcmJfaW5zZXJ0X2NvbG9yX2NhY2hl
ZCgmbm9kZS0+bm9kZSwgJmhlYWQtPnJiX3Jvb3QsIGxlZnRtb3N0KTsKIAotCWlmICghaGVhZC0+
bmV4dCB8fCBub2RlLT5leHBpcmVzIDwgaGVhZC0+bmV4dC0+ZXhwaXJlcykgewotCQloZWFkLT5u
ZXh0ID0gbm9kZTsKLQkJcmV0dXJuIHRydWU7Ci0JfQotCXJldHVybiBmYWxzZTsKKwlyZXR1cm4g
bGVmdG1vc3Q7CiB9CiBFWFBPUlRfU1lNQk9MX0dQTCh0aW1lcnF1ZXVlX2FkZCk7CiAKQEAgLTc4
LDE1ICs3NywxMCBAQCBib29sIHRpbWVycXVldWVfZGVsKHN0cnVjdCB0aW1lcnF1ZXVlX2hlYWQg
KmhlYWQsIHN0cnVjdCB0aW1lcnF1ZXVlX25vZGUgKm5vZGUpCiB7CiAJV0FSTl9PTl9PTkNFKFJC
X0VNUFRZX05PREUoJm5vZGUtPm5vZGUpKTsKIAotCS8qIHVwZGF0ZSBuZXh0IHBvaW50ZXIgKi8K
LQlpZiAoaGVhZC0+bmV4dCA9PSBub2RlKSB7Ci0JCXN0cnVjdCByYl9ub2RlICpyYm4gPSByYl9u
ZXh0KCZub2RlLT5ub2RlKTsKLQotCQloZWFkLT5uZXh0ID0gcmJfZW50cnlfc2FmZShyYm4sIHN0
cnVjdCB0aW1lcnF1ZXVlX25vZGUsIG5vZGUpOwotCX0KLQlyYl9lcmFzZSgmbm9kZS0+bm9kZSwg
JmhlYWQtPmhlYWQpOworCXJiX2VyYXNlX2NhY2hlZCgmbm9kZS0+bm9kZSwgJmhlYWQtPnJiX3Jv
b3QpOwogCVJCX0NMRUFSX05PREUoJm5vZGUtPm5vZGUpOwotCXJldHVybiBoZWFkLT5uZXh0ICE9
IE5VTEw7CisKKwlyZXR1cm4gIVJCX0VNUFRZX1JPT1QoJmhlYWQtPnJiX3Jvb3QucmJfcm9vdCk7
CiB9CiBFWFBPUlRfU1lNQk9MX0dQTCh0aW1lcnF1ZXVlX2RlbCk7CiAKLS0gCjIuMzMuMAoK

--_002_TYAPR01MB625208BDE921AFB1D540B83D92AA9TYAPR01MB6252jpnp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6764): https://lists.cip-project.org/g/cip-dev/message/=
6764
Mute This Topic: https://lists.cip-project.org/mt/85963258/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--_002_TYAPR01MB625208BDE921AFB1D540B83D92AA9TYAPR01MB6252jpnp_--
