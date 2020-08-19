Return-Path: <SRS0=A4iX=B5=lists.cip-project.org=bounce+64572+5134+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D1C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 00:01:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A882075E
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 00:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Gmm960ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A882075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5134+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3KnYYY4521723xhE2g4DKZwQ; Tue, 18 Aug 2020 17:01:17 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.78369.1597795273331512011
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 17:01:14 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07J01BF4021825; Wed, 19 Aug 2020 09:01:11 +0900
X-Iguazu-Qid: 34tKNrBeFcUsIvzHmv
X-Iguazu-QSIG: v=2; s=0; t=1597795271; q=34tKNrBeFcUsIvzHmv; m=lL9scsYVdpc6iMpmhOwtcrkNJr5rpFtISIzZuoLzDX0=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 07J01AXu032383;
	Wed, 19 Aug 2020 09:01:11 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07J01ALt004507;
	Wed, 19 Aug 2020 09:01:10 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07J01A2B031831;
	Wed, 19 Aug 2020 09:01:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E24U2u8Iq3UyQ+CagwiRAwb5uCZA8p1sfDuJG+ESuV03wOlorBMdFSmo6D9DofgwcePXXF5T0OVodPlDP7qL9r4hFoS9VM/564WZuRvHmgwApVqBOXDUUgdWuAlM81BhgirESSnRaFyxePtajJVeYnKsddTjG4X2K64A/j3uC8zevBEyiiPSi2iFs6t8/RFgoOU6uH485aSoQh8Qn8UUn/xLLMluFlEhAHyXa+hesCRMJ77YI16RIBGk0EmaKxvf2cKc1RggjoPNqOrtAb8EoK+ovotFJSGnXIOd71xOJ4IPwYXNKQS/UVNtLVsbpEAzrPVamNC6MsEDugj6sL5Yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMnhOVZd+/zEGa5SRNLttlpDQvRkdYkZq54zKBjPcaM=;
 b=R/gkDK+k7kVUDWFhrBsCGGE4pXRtOcyFcWs/F8nqHxsc9H1j65Tw2L7tshchFs1CJwVOMlB6wuTNTIUTKDcvQ9r3E6pVa3wyMCiCSpm3yIhzkJdBOz02HIG7Vas20oRpUK987+PxzYuwYT9HNIpcp1FSCH9IQ7QhQg0HM/fPJOAqOUyTH8GQPQeNHCtwYYb9GHDQ+0kQ6IBoobYPEvjO7R+C2tIbaM284b2JOMOHcgqk2GNNwHSc4BXjUlDVb1MdLognZinN86GC8KGh7ca+wTE1hN4dQaIl3kaczjI9vDSzDAvoYMUYr37YiE5QGzniRunJSFEET8X6wzxbxU671Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add recipe
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add
 recipe
Thread-Index: AQHWama7Of7RBEN/RES+OIG1P/Dsiak9YsAwgAAJkoCAAIpqcIAAAwoAgACoRnA=
Date: Wed, 19 Aug 2020 00:00:50 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983A946DAAE7D3E25A87363925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <16281511DE955BB5.19258@lists.cip-project.org>
 <OSBPR01MB298327233BFADC291456E190925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <b2289205-5f7e-9f57-ba0a-496a4c8749b3@siemens.com>
 <OSBPR01MB2983367B30C868D82CA6B7AE925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <e525e738-22ee-ce33-e515-23614bf82837@siemens.com>
In-Reply-To: <e525e738-22ee-ce33-e515-23614bf82837@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 172d6447-4930-43d4-f0c1-08d843d2ef39
x-ms-traffictypediagnostic: OSAPR01MB3475:
x-microsoft-antispam-prvs: <OSAPR01MB3475ECC92EA7CF489CDD6062925D0@OSAPR01MB3475.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XwVGLt2yzcgcwQSu7Iozlz49MebnMIZJHBAdCURxUirMZHrx0wtxMNbCgNoI0okPqMp5kpt0tnyzCEoxkaeuykSs/mClBkblaQ09gIHpD7BUaaVMNJtrJ3dsaLPQjrzKuygv6Hq20DlXV8R6/SGiHMPVZ9QxbXiowWOHIgcYUU6sSoB5jjqPJGAxieL1HNASblippF3HVZiQTIXVfvMs39vCXZMmR5NHuuQr5UQ/zdHGRFeIzckecM+hLrTEVsAtj/Aqljn8aP59A4Cbechte6RfYhdwVuYUpqCNefhBQrLGs9rFKdEHcvsv55L4LBlk504VFCDuJb75lARp56O17zu4h0rpEyQE+hpbjK3BZKm5u8kZjDaz7+hDasTn4X5L
x-ms-exchange-antispam-messagedata: QyanPMVxqpqWIhvLbN4qmSlG0/pUE8w9L12w8ZcL3qyWfhSSMbsvAnCOR0c6SpDeOFVkUMRdt+V3EdAYfyJftOcqmY2B6PSbZmF59h0P3Ck4uGgRsaGzN67+n0ngLH35b3H55BGYFCjuL8YFF/Y1JUTAlLhOXmUSANOwAaDYVui071Dq+/w7AzA3SjZwufXNfnejnLr/Rwvl6/sNyuzvG7HjjcgxitkxCR66ullOi64463KPV7YIcJKTOpsV0kVASI2G8tDVze8p4xyNhcFXxlxe5rNXTdxUp/PvooGDMLQQXutNW6Wr4VTl3wcDkbQLioUUuuWKl2lDiGb1olKuTpxitb6CyN43TZFx/YcebuPBd7VbdVlL7zf+K9FDG2UeilU1eRosu4VfIYOiXn41zWJJmcaI9T7XtprzFe+7c20xdD8HBwYuPtJ++PomaZxHilxgg1xULuTR02eKWyRoEWwRjg6Rpv0oSDOyMbl0QSfVvkYVODNm5ScDaOSdHND4jvczDOK88CL8DfKx8vyFUv5hH7ii0LAKhNiiakRl145fQ/k2w6c9yzZSorA/AhxfG51ELKzwCbHbJFvNKZJnF8sArEsNqhrz2vmlnqYEFIaIhikMaQzqaRb2AhBzYe9BZGKJgwK09krNdKqrICdHew==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172d6447-4930-43d4-f0c1-08d843d2ef39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 00:00:50.7580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLMKdvAL+5k1PKU/oOjgHsO/dDJIxYnvYVVqDrRlWn22B0FoKBnvf6Hn4Zyl38YXE+PgEGS0hMS5c9H7evmYb0E4yrzT9IGhBrOLPMjiPa4uTaEogsQfc/1WW8pfoABU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3475
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5028xfpoYVlMJQXbbweNwJjtx4520388AA=
Content-Type: multipart/mixed; boundary="IjeWhDV5KHzK3nXP15kw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597795277;
 bh=L1gKAtpOTZ67bFyUqxoMh3yJOkdlJhhWx7iw9ZlDhzU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Gmm960lyBzCXH2a1B5SzmbNb4yOXTnrCkYbUyWOtX8MvEr8QXKsW1iGDkwHPnBrIQql
 1KuYDK5AOUKer0Ut1mnKR78rDS5m5FwecNvwW/JJNJbihXhH8s/DbH4As9aL/nxDwNQ/r
 UvZYvXXHl3XkDbcw8TGGlvPMoyRKiZDDh7I=

--IjeWhDV5KHzK3nXP15kw
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSBb
bWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAx
OCwgMjAyMCAxMDo1NiBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDi
lqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5q
cD47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRl
dl0gW2lzYXItY2lwLWNvcmVdW1BBVENIIDEvM10gY2lwLWNvcmUtaW1hZ2UtdGVzdDogQWRkIHJl
Y2lwZQ0KPiANCj4gT24gMTguMDguMjAgMTU6NDcsIG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJh
LmNvLmpwIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IEphbiBLaXN6a2EgW21haWx0bzpqYW4ua2lzemthQHNpZW1lbnMuY29t
XQ0KPiA+PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTgsIDIwMjAgMjozMCBQTQ0KPiA+PiBUbzog
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDk
v6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRv
c2hpYmEuY28uanA+DQo+ID4+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVd
W1BBVENIIDEvM10gY2lwLWNvcmUtaW1hZ2UtdGVzdDogQWRkIHJlY2lwZQ0KPiA+Pg0KPiA+PiBP
biAxOC4wOC4yMCAwNjo1NywgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+ID4+PiBIaSBKYW4s
DQo+ID4+Pg0KPiA+Pj4gQ291bGQgeW91IGNvbW1lbnQgb24gdGhpcyBwYXRjaCBzZXJpZXM/DQo+
ID4+Pg0KPiA+Pg0KPiA+PiBBaCwgeWVhaCwgc29ycnkuDQo+ID4+DQo+ID4+IEkgdGhpbmsgbm93
IGl0J3MgYmV0dGVyIHRvIG1vZGVsIHRoYXQgYXMgZXh0ZW5zaW9uIG9mIGFuIGltYWdlLCBnaXZl
bg0KPiA+PiB0aGF0IHdlIGFscmVhZHkgaGF2ZSB0d28gKHJlZ3VsYXIgKyBzZWN1cml0eSkuIE9y
IHdpbGwgd2UgaW1wbGljaXRseQ0KPiA+PiB0ZXN0IHRoZSBzZWN1cml0eSBpbWFnZSB2aWEgdGhl
IHJlZ3VsYXIgb25lPw0KPiA+Pg0KPiA+DQo+ID4gSSBzZWUuDQo+ID4gV2hlbiBleHRlbmRlZCwg
dGhlIHJlc3VsdGluZyBpbWFnZSB3aWxsIGhhdmUgdGhlIHNhbWUgZmlsZW5hbWUgYXMgdGhlIGJh
c2UuDQo+ID4gSXQncyBkaWZmaWN1bHQgdG8gZGlzdGluZ3Vpc2gsIHNvIGl0J3MgaW1wbGVtZW50
ZWQgYXMgaXQgaXMgbm93Lg0KPiA+IElmIHlvdSBrbm93IGhvdyB0byBjaGFuZ2UgdGhlIGdlbmVy
YXRlZCBpbWFnZSBmaWxlIG5hbWUgYnkgeWFtbCBmaWxlLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+
IA0KPiBJc2FyIGRvZXMgbm90IHlldCBhbGxvdyB0byBvdmVycmlkZSB0aGUgaW1hZ2UgbmFtZS4g
WW91J2QgYmFzaWNhbGx5IGhhdmUNCj4gdG8gd2Vha2VuIGl0cyBzZXR0aW5nIGxpa2UgdGhpcw0K
PiANCj4gW2lzYXIvbWV0YS9jbGFzc2VzL2ltYWdlLmJiY2xhc3NdDQo+IElNQUdFX0ZVTExOQU1F
ID89ICIke1BOfS0ke0RJU1RST30tJHtNQUNISU5FfSINCj4gDQo+IGFuZCB0aGVuIHlvdSBjb3Vs
ZCBvdmVycmlkZSBJTUFHRV9GVUxMTkFNRSBhcyBkZXNpcmVkLg0KDQpJIHNlZS4gVGhhbmtzIGZv
ciB5b3VyIGNvbW1lbnQuDQpJIHdpbGwgdXBkYXRlIGZ1bmN0aW9uIGZvciBhbGxvdyB0byBvdmVy
cmlkZSBJTUFHRV9GVUxMTkFNRSwgYW5kIEkgd2lsbCByZXNlbmQgdGhlIHVwZGF0ZWQgcGF0Y2gu
DQoNCj4gDQo+IEphbg0KPiANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tDQo+
IFNpZW1lbnMgQUcsIENvcnBvcmF0ZSBUZWNobm9sb2d5LCBDVCBSREEgSU9UIFNFUy1ERQ0KPiBD
b3Jwb3JhdGUgQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==

--IjeWhDV5KHzK3nXP15kw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5134): https://lists.cip-project.org/g/cip-dev/message=
/5134
Mute This Topic: https://lists.cip-project.org/mt/75987091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--IjeWhDV5KHzK3nXP15kw--
