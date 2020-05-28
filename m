Return-Path: <SRS0=WFb+=7K=lists.cip-project.org=bounce+64572+4651+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97515C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 03:28:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B972088E
	for <cip-dev@archiver.kernel.org>; Thu, 28 May 2020 03:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ggI2hJur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B972088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4651+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gIBhYY4521723xgc7fHCkVDO; Wed, 27 May 2020 20:28:28 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.5220.1590636505925788353
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2020 20:28:27 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 04S3S782004870; Thu, 28 May 2020 12:28:07 +0900
X-Iguazu-Qid: 34trvY1fG3B1TnSIcz
X-Iguazu-QSIG: v=2; s=0; t=1590636487; q=34trvY1fG3B1TnSIcz; m=6LAY1eGIHL6Mh6fjgBHvH0kgNY3GkjXZZquzpX174vc=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 04S3S5JT000437;
	Thu, 28 May 2020 12:28:06 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 04S3S5OR026170;
	Thu, 28 May 2020 12:28:05 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 04S3S4Na025209;
	Thu, 28 May 2020 12:28:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUk3NtoalodMiwBOu2sTN2+ZiktaGAjaxSOXmKaWZC42CSn/p8nbRiHi8Ad6nBw1gPxnzeRetx9jf0NwYvwZzwPTly6INZcNu+XmHXPQX7WLUyZaaXET7n+qbJpckJI05qcZYupydB4IhRpduUj0hkL4pUKUcZqZl6tcVm4bn7tdmjc6GZMnuTCp44uXNbLHkrpPfHc2iiX2yQaSkCGQWk6AzDkvycSwL2nQxpDANMwTcVtEuJBYup5lz4ENk6mzQWc1ntR84l8RalUsVybW1Lz4Hrt46hfGztgBXY1/YSe7sWqUDjIsZR8AYMLDNNh2Z1twncWwG+86fh4b/scEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4MlaqpMAYrdOn7VixpxSdnum7p80MNnni3pwhcJexI=;
 b=JnptdkokYhcz5iWu1qWjweTHQGY8f903LHfHIVMh+yWFci9RlKLVkp1A6qtf548qd9KK5SRzHXxu2s7XFBWgsESkKEb+Dezsa6QCV58FnQAARQAWqdlsquVYfcFRwv5o0jzo42iOUr+XRCj/DvM0+z1woYvoNtjc4zeYK+ezF+y7x0valno4lMMnID0vS+KRdt3ixMT8a0iqiVUEVkXm6H1CScBQvrr56rfMC8zXf55HmDzE7V1Zp6+h5BIsayGi8w97FXcpRZKB39pYjsj7Uej+o4qZKZul1F6DFG/k0CB0LIGk6Zu9a3PdYkCUT9OxMD9mDEZJ9+zQFALbc/t8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core] version management
Thread-Topic: [cip-dev][isar-cip-core] version management
Thread-Index: AdYthqu0kcefdkDOSNuvyCjETy2KPACst5AAAJlXsdAALPNagABSWqQQ
Date: Thu, 28 May 2020 03:28:02 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20535801BA206E07A299F805D08E0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
	 <15ecf2778057028f916e644742e6a66ed115f052.camel@codethink.co.uk>
	 <OSBPR01MB2053A08090E5533C7323928DD0B30@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <1d9dc0f0e1d9689eb7b6578127e93f2907c54b17.camel@codethink.co.uk>
In-Reply-To: <1d9dc0f0e1d9689eb7b6578127e93f2907c54b17.camel@codethink.co.uk>
Accept-Language: en-US
x-originating-ip: [124.211.28.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f01811b-f2aa-448c-e814-08d802b720e3
x-ms-traffictypediagnostic: OSBPR01MB4614:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB46145D75E9AF84BEA4D9270AD08E0@OSBPR01MB4614.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SGPec4y6b8EsZURmQdsDXp23uJtvvGgvBXAjijDRmFI7ZiFiBpRFPodIwBmzKSvNemwXBEmeSHWc/UU2E/12yFMJaUH8R2wjdaUu+kBszgyxk98Ueiqf85fiNw8OKhI+WAwD7M8eg205lhEzmYRv+OglL0VOqpq2ZyHGdvpbPqEXDnW7S1goxGciF5S0/W6XGL6UXM9nKlDBOHRU8HpxCIt0rNrWtYXtGQ+4MSVq2bO/RXZ1ezzIWpEh4++gJjCRe8/RcPxrj49+yyY6W2EFv9IY/o3vPa4tZgqSiBro8LX30D2uDGo3AeBZ0qRUwbCLbXka4aPT9wBoZllwhjfH/Q==
x-ms-exchange-antispam-messagedata: jA8tt1lT7bCZNkdpiLpqMQzgmBCLRmZnx6zcktBoOUi3fapgivD5Tfl1wwHIeuWHNU0J/Ql7X1oN9GERp8wh6GEx4MmL63e5lWStC/TsMf+dXmibo0zNOz14dScNLizaWqs1RKGAocDlAN7YOtRyl5eOYH7CXvgB5MemihgdB/NaFMcqV+BPvCGzey58EEUvoY6mIrZb5yYzT1bDDnAU4X2JQzSk2FcvKY2bgdhGQ1sNQSnOczniO1ugTFSIG97QelHXcb0hvAeVvnTTQ9lehinb5j8dqTVOs1EOB+GObx1AxZxCK6mMfGTQJ41QW9BNhHxKRlvYPOpG0lhk2ImwxTapuJ5NsUnkE6X0YcrDfsISBdzDofQF592rshTWV62N9lLmUIupTQ0cZY7INtnLLXnWWfQAHgl5AiP47/s5xLttfvFCvkFKE9qAMjj8Bm4dwx0Q1/Ggn03AAstyT1dD8CwvU7ZKaKrSsUERIWgHHUA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f01811b-f2aa-448c-e814-08d802b720e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 03:28:02.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToJelDtiR8derbSlsM9w4BpA/zGo1IvY11SD4XvgYy05ehWCsH1pn1E/hijeFO8MeRar2uoWW9OX+Vy2SHeXfO2KK0ngZ0QIzYcJj4MsrI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4614
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: L8sPTU5qXoAAUHq3YSPIoW0tx4520388AA=
Content-Type: multipart/mixed; boundary="CN7KsUGX0dlX7Z642XhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590636508;
 bh=D53Kq24IbhTjXdYI86dRVCLmrw82WpxQ7UTlDDcbWfw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ggI2hJur+GaOKJE7DxEGq9ChHYiipVdS/g9WhzZAVzk2zpL++5D+XrjKLfXki9KIPoM
 Kuv2MijUuJU0811/mfVWhZtAkTqNykgd4JgNiu2qX0JiORJrAtiNkh99jZHkRDX4ENGDw
 NPUYMmECS2FZ7qbxNfsL6WpSuL7eFiQGYe0=

--CN7KsUGX0dlX7Z642XhV
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gQmVuLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMuDQoNCj4gRnJvbTog
QmVuIEh1dGNoaW5ncyA8YmVuLmh1dGNoaW5nc0Bjb2RldGhpbmsuY28udWs+DQo+ID4gV2UgY2Fu
IGNyZWF0ZSBhIFBHUCBzaWduYXR1cmUgb24gZ2l0bGFiLWNpDQo+IA0KPiBQb3NzaWJseS4uLiBi
dXQgdGhlbjoNCj4gDQo+IDEuIFlvdSBoYXZlIHRvIG1ha2Ugc3VyZSB0aGF0IGJ1aWxkcyBhcmUg
b25seSBzaWduZWQgd2hlbiB0aGUgc291cmNlIGlzDQo+IGZyb20gYSB0YWcgc2lnbmVkIGJ5IG9u
ZSBvZiBhIGRlZmluZWQgc2V0IG9mIHRydXN0ZWQga2V5cy4NCg0KV2UgY291bGQgY2hlY2sgdGhh
dCBhdXRvbWF0aWNhbGx5LCBidXQgd2Ugd291bGQgc3RpbGwgbmVlZCBzb21lIHNlY3JldCBlbnZp
cm9ubWVudCB2YXJpYWJsZXMgb24gdGhlIGJ1aWxkIGNvbnRhaW5lciB0byBkbyBzby4NCg0KPiAy
LiBZb3UgaGF2ZSB0byBzb21laG93IGtlZXAgdGhlIHNpZ25pbmcga2V5IHNlY3JldCwgd2hpbGUg
dGhlIENJDQo+IGNvbmZpZ3VyYXRpb24gaXMgbW9zdGx5IHB1YmxpYy4NCj4gMy4gSSB3b3VsZCBi
ZSB3YXJ5IG9mIHB1dHRpbmcgdGhhdCBtdWNoIHRydXN0IGluIHNoYXJlZCBpbmZyYXN0cnVjdHVy
ZS4NCg0KTXkgaWRlYSBoZXJlIHdhcyB0byB1c2UgZ2l0bGFiLWNpIGN1c3RvbSBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMsIHdoaWNoIGNhbiBvbmx5IGJlIHNlZW4gYnkgdGhlIG93bmVyIG9mIHRoZSBy
ZXBvc2l0b3J5IGFuZCB0aGUgYnVpbGQgY29udGFpbmVyIGluc3RhbmNlIChhcyBhbiBlbnZpcm9u
bWVudCB2YXJpYWJsZSkuIE5vdGUgdGhhdCB3ZSBhcmUgdXNpbmcgb3VyIG93biBrdWJlcm5ldGVz
IHNlcnZlciAobm90IHRoZSBnaXRsYWItY2kgc2hhcmVkIHJ1bm5lcnMpLg0KDQpJZiB3ZSBhc3N1
bWUgdGhhdCBhbiBhdHRhY2tlciBpcyBhYmxlIHRvIGFjY2VzcyB0aGUgZ2l0bGFiLWNpIGN1c3Rv
bSBlbnZpcm9ubWVudCB2YXJpYWJsZXMgc2V0dGluZ3MgKGVnOiB0aGV5IHN0b2xlIHRoZSByZXBv
c2l0b3J5IG93bmVyIHVzZXIsIHBhc3N3b3JkIGFuZCBoYWNrZWQgdGhlaXIgZG91YmxlIGZhY3Rv
ciBhdXRoZW50aWNhdGlvbiksIHdlIG5lZWQgdG8gYXNzdW1lIGhlIGlzIGFibGUgdG8gY2hhbmdl
IHRoZSBnaXQgcmVwb3NpdG9yeSwgdGhlIGdpdGxhYi1jaSB5bWwgc2NyaXB0cywgYWNjZXNzIGt1
YmVybmV0ZXMsIGFuZCBhY2Nlc3MgcGFydCBvZiBvdXIgQVdTIHN0b3JhZ2UgYXMgd2VsbC4NCg0K
PiA+IGFuZCBzZW5kIGl0IHRvIFMzIHRvZ2V0aGVyIHdpdGggdGhlIE9TIGltYWdlLiBTaG91bGQg
d2UgcHV0IHRoZQ0KPiA+IHB1YmxpYyBrZXkgKGFuZCBmaW5nZXJwcmludCkgb24gdGhlIGltYWdl
IHJlbGVhc2Ugd2lraT8NCj4gWy4uLl0NCj4gDQo+IEkgY2VydGFpbmx5IHdvdWxkbid0IGZlZWwg
Y29uZmlkZW50IGFib3V0IGEgcHVibGljIGtleSBmaW5nZXJwcmludCBvbiBhDQo+IHdpa2kuICBJ
dCBzaG91bGQgYmUgc29tZXdoZXJlIHRoYXQgaXMgY2xlYXJseSBvZmZpY2lhbCBhbmQgZGlmZmlj
dWx0DQo+IGZvciBhbiB1bmF1dGhvcmlzZWQgcGVyc29uIHRvIGNoYW5nZS4NCg0KSSBtZWFudCB0
aGUgZ2l0bGFiLWNpIHdpa2kgaGVyZSwgYnV0IHllYWggdGhhdCBjb3VsZCBiZSB0aGUgQ0lQIHBy
b2plY3Qgd2Vic2l0ZSBhcyB3ZWxsLiBJIHdhcyBqdXN0IHdvbmRlcmluZyBpZiB3ZSB3b3VsZCBu
ZWVkIHRvIHB1dCBpdCBvbiBhIGtleSBzZXJ2ZXIgb3Igc2hvd2luZyBpdCBvbiBhIHdlYnNpdGUg
d291bGQgYmUgZW5vdWdoIGZvciBvdXIgcHVycG9zZXMuIEluIHRoZSBlbmQgd2UgbmVlZCB0byBi
YWxhbmNlIHVzYWJpbGl0eSBhcyB3ZWxsLg0KT2YgY291cnNlLCBoYWNrZXJzIHdpdGggbW90aXZh
dGlvbiBjb3VsZCBwcm9iYWJseSBoYWNrIG91ciB3ZWJzaXRlLg0KDQpJbiB0aGUgZW5kLCBoZXJl
IHdlIHdhbnQgdG8gcmVsZWFzZSBpbWFnZXMgZm9yIG5ldyB1c2VycyB0byB0cnkgdGhlIENJUCBz
b2Z0d2FyZSBvbiB0aGUgc3VwcG9ydGVkIHJlZmVyZW5jZSBoYXJkd2FyZS4gV2UgY291bGQgc3Vn
Z2VzdCB0aGVtIHRvIGRvIHNvIGluIGFuIGlzb2xhdGVkIExBTiBlbnZpcm9ubWVudCBqdXN0IGlu
IGNhc2UuIEFuZCBmb3IgZGV2ZWxvcGVycy9wb3dlciB1c2VycywgdGhleSBjb3VsZCBqdXN0IGJ1
aWxkIGFuZCBjdXN0b21pemUgdGhlIGltYWdlcyBieSB0aGVtc2hlbHZlcy4NCg0KVGhhbmtzLA0K
RGFuaWVsDQo=

--CN7KsUGX0dlX7Z642XhV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4651): https://lists.cip-project.org/g/cip-dev/message=
/4651
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CN7KsUGX0dlX7Z642XhV--
