Return-Path: <SRS0=rcXV=GY=lists.cip-project.org=bounce+64572+6123+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF337C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 04:14:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4403B238E4
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 04:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4403B238E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6123+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iwgNYY4521723xxLRgAFq61S; Wed, 20 Jan 2021 20:14:58 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.2634.1611202496515560086
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 20:14:57 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 10L4EgQq030766; Thu, 21 Jan 2021 13:14:42 +0900
X-Iguazu-Qid: 34tKHZCCIUwB4xa0gD
X-Iguazu-QSIG: v=2; s=0; t=1611202481; q=34tKHZCCIUwB4xa0gD; m=QhTRusVCWiDP9RnhWQv1NcAWss0uN2VGNVgQ36DhMog=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 10L4Eemn001508;
	Thu, 21 Jan 2021 13:14:41 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 10L4Eevd006086;
	Thu, 21 Jan 2021 13:14:40 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 10L4EeOQ012528;
	Thu, 21 Jan 2021 13:14:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C42WJ0qMZgPV35GRSZRY/YzC5zM8Ajb42dnOcdKXiimHLwHKKZbPwqr57XHq8/FclO5NOuZGQYc96mz+v1BSyrqcNRGmu0T3kfDEIeBY2/aOwtW1+/loxMkrIob6bd9rb20BMQnHvGDxNarT1ZFQb6QzKQCewXTN57NN7PZO9EZRgWPZ8syorSGtZBRsk6Ch7/xk/qOltwtI2bPXhkpZdjk0MvQlZQBhbUF1TboP6AmA53bDDaqzqR1t0BZIf8YxLRyP74eq9qL2jnD3s6DHDf77VguK2wk/qPjDbhyUQjuhI8BTqniHqmPK5lClo/o0QiOe3c9NBgBHQJYnxHu4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/SkUe0TuLN/+4DiB9/U5Ct75eUvGf/P8aT9MDcy6k0=;
 b=Lw1LiSDLP0l+5KtmIrV6YDHDzOqO8ov+ltk7DpnPWCCJvyaujrpoYcXOFfRsa3Jb6lrvadPUJ+eETHX+5b+3lqxQM5YEQY0P0I6T+20frhhZFX9RUvuYCPF/JDOFpI7Bi67ePRTcMuVwUfUq2zBw7jGFK+7MUdb8cvWoPVwbVG0tuR/vBw8pbGXGsy7hqZukgt0yqg4xqWyPnJL2v9Y2ifWEvNhJy+WAFRAO7meD3b/U0pJNe8nOFSqu5yFJtiTGhaXUxbmJ1DG1fxKaQ81RR2oph9oScn2VCgoQNLUN/w+yWnSMCf8yPJHDwRUx7sUGUB4WZ2ugrRMbTH/uu8LdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <wens@csie.org>, <jonathan.sambrook@codethink.co.uk>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
Thread-Topic: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
Thread-Index: AQHW76i25o4Y2wvUREebiN4Nd1rnmaoxeMcg
Date: Thu, 21 Jan 2021 04:14:37 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20533FBEE9901A816B78204FD0A10@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <CAGb2v66bGEX3sCBNnYdv07cuojOjNe1Gf-D3Mb4Kik-He3nt0w@mail.gmail.com>
In-Reply-To: <CAGb2v66bGEX3sCBNnYdv07cuojOjNe1Gf-D3Mb4Kik-He3nt0w@mail.gmail.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e36c8c5-08c8-4e0a-52a9-08d8bdc31114
x-ms-traffictypediagnostic: OSYPR01MB5543:
x-microsoft-antispam-prvs: <OSYPR01MB5543083BBD8712972EECC5FBD0A10@OSYPR01MB5543.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QEkgYZm6AXTux0n33ZMNMaflxEOJz4Haw3GSmABR9lrUSMHKqtPU5o0zooU9hd3+B89G/ZqFwalti89IqIhkdQNpH03VdyvCcQ00gyv744F60UwtgC/XilHy3PZi6hAAAS3CcwM1k1VJoZz+w5y7lc7EF0vdDGWSRfmMpsd3TtcT9UAF/51OkPkJGcqC5r846tf4wVfny1w3VuI5tRXpqdRZ6TlzyQEFIyzkf6yaqntZ9WgHMOVlQqTBGwNoHpMj+/ilSvRVNHm8jrRlxox/2RixsSIlDd1xTBaR2vp+QlkCi5xnKbi1cYCIgEAEZVo1Hr7ENzC3b+Kf+tFkxdxDVi8yaq/ElhBLtz5KUI7/lurieiKqfHXV7agZcCTJGEVmXyMj9ToqF9xVP+s+elztIH/Yyrfzb0O7hpXAn3C0sXtyrSpKykJYVqU8ikN/blXPrg4rrP1QQN2E12DVh7AB0Q==
x-ms-exchange-antispam-messagedata: =?utf-8?B?L0hKbDNBa3Y1Z21tbG1xdVBnWHQ3eXdiamtXUGlvSnNhNXN1S0xsZ2NyRVZW?=
 =?utf-8?B?aG91cS9XZXNmZklobDI3TFdxTHZJWU9hMEo3emt6TmdjT1p1bTdSWmozVHdC?=
 =?utf-8?B?TnR0ejJlSFNzcDRUTjJTb0VTeVg3dTZmY1piMzZuOVVXOHVadVcrR0RuM012?=
 =?utf-8?B?QmZXNnc4RmZKbkxDSStMZXA5RzQyMjZqbEV6MkFITlpOdkRKdVB5aHNnMjhI?=
 =?utf-8?B?alRucTdERWdEdlFjdm9ZQ3IwcW9TU21rWEF0UFB5OUIxRHJBd00xVWFacjZT?=
 =?utf-8?B?WFZ2cUFDQ29ZODkrdWRQT0lzcEdROGJRWUY3MWNydTZ1QTZCOFFEc3NZdkFw?=
 =?utf-8?B?T1hBcGRRWTZpVm5qeHc3M3JyVHB3VlBKN2UrdmM3ZEhrb2paajhvUEJrVHJt?=
 =?utf-8?B?anI5M3MyMU5xRTlwOWFUNmJqNXo3UGw4clBmSnJXK2xJbldXNENTcTRaaG44?=
 =?utf-8?B?dkFsZ1hFNVl6VFZsaEt1emZGTlZtM0l3OVVMZHhzYytkanFxTXB0dGt2QUpM?=
 =?utf-8?B?YjN1emRVTGl1QzljVFZ6OG5VL0pWVWwrY2NxY3FkYVpwM0VETTFrTWFLMnRT?=
 =?utf-8?B?S2lyaVowcTVJOWRreXBtQTJOM2FtNGtkckhybmZnUkxUTDB3UVcyMVdQU3g5?=
 =?utf-8?B?RFB5eGFWNUwxTWdjelJWa0YzanZkeEV3aXRIZGlScjg2YnJuNUEyeGliS1FS?=
 =?utf-8?B?MXMxNmtpZlM2U2FJa1hoYTRQS3hmY1BNZFNzVkRDcW5qZHJibU9GaXNWZmNT?=
 =?utf-8?B?Q3NjR2xTN3IvTEdiajE5QmhhWkRHMk5FL3hzc0prK0NkUGlLYmczcUZ2RG1m?=
 =?utf-8?B?ektET1FMdFpIS3MrUi92bFljVzBBczhFNnBqVnpaY2g0MnNTQ3NLWUNVOWJt?=
 =?utf-8?B?a0xickhBSEQ5eW9hRENBc2VGQ3ZmRUo1ZkpNYUR5NWNaTi9zNjdCdnZvVUx2?=
 =?utf-8?B?ekdVMFRseXgyRW1iZ0F3c29kbm1JVEkzLzJCUGVkY2s1WmQxOGNNWW1lZktF?=
 =?utf-8?B?eHZGM1FXVGtVZC9FMEtsVlV5RXRCd3dmUWZZblNoWGxWNzlqaXVrOGw5ZE1q?=
 =?utf-8?B?dHNYNlIvS3ZUTkdHZGxaUXRJakd4aXBQTWxQR2RVS29VbWRiU2xLeFhWSTFV?=
 =?utf-8?B?UzRlYVdRQjBQMjdPeUEvbmhkTVZYYmJsTmI5SFhYZUM2dUZaNlBkWXI3ZHdJ?=
 =?utf-8?B?dERoV3JDNzh6ZS9KZVJsMkJwRE10dzFNNVU2S20vd2VBcks1SlYxRlpHMDJj?=
 =?utf-8?B?OXZjaWVWZWlNYUtrYzhEUHhnNm8yelc5NndBRDNHUVZLTGEzcW1TTkRRZEs1?=
 =?utf-8?Q?qxJ1GxkjGF0Pk=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e36c8c5-08c8-4e0a-52a9-08d8bdc31114
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 04:14:37.4469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aakUSNQERoYav29W82wGKDUa4ScZx20KkqZjjOJZ93TM3Gk9sAd8uPDj9kI9/vA8CFDd74wU5CMaGd9OtHJkNNKBUhUJh9+MumYK48ugUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5543
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2OXDLtsC1GyuzpBWEGep43RVx4520388AA=
Content-Type: multipart/mixed; boundary="gShMiTwvj9yPI7EfaYO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611202498;
 bh=ouDyf/8bQlsepUH1MXAzP5wOKyPHP6T342tdZRZWwXc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=sBhCpT6iymIUhoB//a2HIBhEUQeUf7O2KJoqJMV1b4PUQjVZb6DhSzrO7Lu1TXvLT7L
 +PEFdL7nCr8NbHtbVZqS4ESZ2Ex83vdWYvQWvIQrYn4BJaKDqsRI04AuoKHQeU0+r2Xz6
 awnbpmSYNbXF7dXIoTBmPDmZevgv2JysIRM=

--gShMiTwvj9yPI7EfaYO6
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gQ2hlbll1IHNhbg0KDQpJdCBzZWVtcyB0aGF0IHRoZXJlIGlzIGEgcHJvYmxlbSB3aXRo
IG1lcmdlIHJlcXVlc3RzIHRvIGNpcC1rZXJuZWwtc2VjDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9jaXAtZGV2LzAyODJhNTFhLTY4MmMtYmI1ZS00YTY4LWUwMjBhYzBlNzZkNUBjb2RldGhpbmsu
Y28udWsvVC8jdQ0KDQpEaWQgeW91IGxvb2sgaW50byB0aGF0Pw0KDQpUaGFua3MsDQpEYW5pZWwN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBP
ZiBDaGVuLVl1IFRzYWkgKE1veGEpDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDIxLCAyMDIx
IDEyOjUxIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogUGF2
ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0
iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5j
by5qcD47DQo+IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwDQo+IFN1YmplY3Q6IFtjaXAt
ZGV2XSBDaXAta2VybmVsLXNlYyBVcGRhdGVzIGZvciBXZWVrIG9mIDIwMjEtMDEtMjENCj4gDQo+
IEhpIGV2ZXJ5b25lLA0KPiANCj4gT25lIG5ldyBpc3N1ZSB0aGlzIHdlZWs6DQo+IC0gQ1ZFLTIw
MjEtMzE3OCBbbmZzZDQ6IHJlYWRkaXJwbHVzIHJldHVybnMgcGFyZW50IG9mIGV4cG9ydF0gLSBm
aXhlZCBpbiBtYWlubGluZQ0KPiANCj4gVGhlIGZpeCB3YXMgb25seSBtZXJnZWQgaW50byBMaW51
cydzIHRyZWUgYSBjb3VwbGUgZGF5cyBhZ28sIHNvIHdlIHNob3VsZCBzZWUgdGhlIGJhY2twb3J0
cyBpbiBhIGZldyBkYXlzLg0KPiANCj4gSSd2ZSBhbHNvIGFkZGVkIHRoZSA1LjEwLWNpcCBicmFu
Y2ggdG8gdGhlIHRyYWNrZXIuDQo+IA0KPiANCj4gUmVnYXJkcw0KPiBDaGVuWXUNCg==

--gShMiTwvj9yPI7EfaYO6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6123): https://lists.cip-project.org/g/cip-dev/message=
/6123
Mute This Topic: https://lists.cip-project.org/mt/79996445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gShMiTwvj9yPI7EfaYO6--
