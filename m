Return-Path: <SRS0=ikhr=DI=lists.cip-project.org=bounce+64572+5486+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F7C4363D
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 03:03:34 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8CA21D7D
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 03:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZX84iSXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8CA21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5486+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 39VYYY4521723xX9pp5x9khH; Wed, 30 Sep 2020 20:03:32 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.3937.1601521410152702600
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2020 20:03:31 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 09133RSm002063; Thu, 1 Oct 2020 12:03:27 +0900
X-Iguazu-Qid: 34trJE3d6h5V7YLNBj
X-Iguazu-QSIG: v=2; s=0; t=1601521407; q=34trJE3d6h5V7YLNBj; m=qgbbInrWvtZEcyGQjs7W8A+B7DJQyoBmVU7ShYdRALc=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 09133QQq006626;
	Thu, 1 Oct 2020 12:03:26 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 09133QZI029818;
	Thu, 1 Oct 2020 12:03:26 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 09133P3A010410;
	Thu, 1 Oct 2020 12:03:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfEW6azUn+3lR1mpb9gA0oQ69cQO2Z4btP6Oo1xJQzzRdteqwp9+9drMCKtFgMk0fFz9U1nhczKbfijmW3sFkigFgsbRfT/DXsYlf5/hOZECX9P+q+/blsv0k3leGbISl+/DwfIGEkiRnP8exws10aLkrqwlfojmdPxpi7M0sZyfb9lg5ARKzWWP+zRWxnlZE8PoGbeKPZzIK8/SQBvNp+Xsd6v0lnYw5d//PEtmTgV50ysBGu6FDzfblvhyIHlLnbH3dQaoIJScvBmqEGg4OlWbY9cPJB5Vlowl3k0INzSQHRk96AS5IE2NBXuU2jEI52MWyVh2iO6lRbnGsvC8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6frPpGO7uxylKQbq0UtqpC8zZs7nsQHleZckcN8Efs=;
 b=lU9dINwqZCeB5o3MdY8yuqupcXirMfubDHDms26mx+Jm9zoO+Q5VoJm6eCfsG0bs53IY5KpduWvpjVXc+VkiYCpRFPKhs9NX2qa62Vhaey7CdFErfDj1DvTXBHYdtz6Kaho9khMNll+RqyaKZG31PjhPkGQxPThcjWPSfvg3RRsSIgzrGCQ1uPglvK3WaGN/zSt2/CUlS0GrzIwtzF9Fnn78twZLschWN1OejXleS+bCsF0xNTUGEtDHxJfmmeBTQF8UreIqhqzgZjKS29DVrl583nIdC/qwXXCW66w/S2s20Azyn0ZV+XBmz3Z4VZQbjRUVnQHSUERRfCfpdFbUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <jan.kiszka@web.de>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core] image: export dpkg status file for debsecan
Thread-Topic: [cip-dev] [isar-cip-core] image: export dpkg status file for
 debsecan
Thread-Index: AQHWlvjz2mwSipOuB0+WVfLbj9/OM6mB5CHwgAAtPJA=
Date: Thu, 1 Oct 2020 03:03:24 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053F771D826EE8349CCA258D0300@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200930020815.2474349-1-daniel.sangorrin@toshiba.co.jp>
 <20200930020815.2474349-2-daniel.sangorrin@toshiba.co.jp>
 <7596cf39-b8f9-cedc-3b51-b164553b3ee4@web.de> 
Accept-Language: en-US
x-originating-ip: [124.211.28.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18a56402-66aa-4207-30b3-08d865b68fc4
x-ms-traffictypediagnostic: OSBPR01MB1815:
x-microsoft-antispam-prvs: <OSBPR01MB1815FB1D74D1DA501C08FB21D0300@OSBPR01MB1815.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vqbMAZTVo50P7oD/MAX6JCxzJT9oSaBKlZ0T/aKxgn6UF2oKTvA95YP0aNiaFDiTW43SntpiI/8GjwxwtMJmGXCaJ0j8OWpf+7InZ2f4CxcyvF9nYfzpvmh7Rs8o7Nx3YHcAJvN+JrR4ESlm0SoDwjWFD+vEYk4xngdV8+gx24A31Z5LznYje0eqjKzZbuVB6aLzgp7vwjzofAoR1uD2V+NiyFwYMxGmDDNdhSw19EHjZck0XkIxALBnLL/0FSOH8qu/QeZJBUWwlZfqJNBLaPu0SzpvTgwP2CWBCEZLyY1k4tn0sNRv09PvRE915GdyE6ClOmoog/FKRK2i3b+WLfmkecimgzi/MX2Ugu72lviUar1NjwGFYgmLh+K80xWN
x-ms-exchange-antispam-messagedata: 8DWgYCvr1IGMrnpFnZMcrTGPifeQr08/UcHXhzqK3RdTnYIitVqrVznzUcL3HkZFpBqekVMp2G+BMgomO5CFxx/oqdwy1FTMQVbMCY8zc6FBs7vx1ra736hL9a9fAnC3Lp3c7E1RXkTgvfx4WYMYyEI+c3/Y4mtf9SYQs4pYV0Z56WDhHRZQZV+GY3mMfgCpeSW4sV0IBSi9WvTf0EOAN3pPII6BFmvGHnhUx7RR+JvuLyN1A3iAdXKJ1EkR4FtW1vSqtAYMhgholj30nbsOjH0vvNTNFpfRPAm3u0GlA9TUMw/7U5RTYj9MeGptXP/hf8VIhkyWnmqW5Y1pw1RQtT/79HHaL6SDnrKsRn8niN6TedL20tsIsRlTemhI/SwX3PSSvKdIVWBONkvSF7eH+gMFiLC+TfKq900Kaf0vb+bkO1XMp0lq5f3M2kO+J0TCsIqj1ICFT/EJV5W4JJrRZOZ2Q2zN7nSmDBDLrxhrTcD8h3zpBpar9fpJoHX9OWCwFn4luMC6aLaNJ3LgjIJE20p7YjjawKHq6/ODxYaTBN0fYKd2j2LWi00sgnW1T0Dxq4PhrgihMRSovK1mk8SHRZWO6wUhIRtiAMn9zB7VXHeHethT0r/SnUljOiiwuqpEGMO3AKkqLYwIdKjKCjWj1w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a56402-66aa-4207-30b3-08d865b68fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 03:03:24.2868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ot96Vb78Mf3MKBYFTDdC3+bjO1VUMiFmSvaBbmo6qTFogzPYcfkr0PCwX5z0mDbevz8Gr3exLG3iKSYz6/5sl2aAjYFAnuzPM9WKsjEjN5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1815
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zKXVUOOSSWgIGWyUFJ19obM0x4520388AA=
Content-Type: multipart/mixed; boundary="9rpAlGeMRRjPqnvVYQHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601521412;
 bh=u3aYKaAq5is5rd3MQb0sdhcxUoJ7GCrASv/lTNoWo/c=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZX84iSXkNNL1BLAbDkvBUlTP8ON5zgnuxg9SjlfJ4X2xT5E29ofifAnSX13+pWABClE
 kUHBqpRIVgVDjLFy920QOEfMpM+2XPJlgAuJ9V6Iuc8h7mBF1m7esp97WD9i1B5e8JKHC
 Vz/LMRtKemiaGzJXV0HT3W/U6hH8lhVo9/U=

--9rpAlGeMRRjPqnvVYQHC
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQpOb3cgaXQgc2VlbXMgdG8gd29yay4gSSB0aGluayBpdCB3YXMgc29tZSBzdWJ0
bGUgaXNzdWUgd2l0aCB0aGUgdXNlIG9mIHF1b3Rlcy4NCg0KVGhhbmtzLA0KRGFuaWVsDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FuZ29ycmluIGRhbmllbCjjgrXj
g7PjgrTjg6rjg7Mg44OA44OL44Ko44OrIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4gU2Vu
dDogVGh1cnNkYXksIE9jdG9iZXIgMSwgMjAyMCA5OjIzIEFNDQo+IFRvOiAnSmFuIEtpc3prYScg
PGphbi5raXN6a2FAd2ViLmRlPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3Vi
amVjdDogUkU6IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZV0gaW1hZ2U6IGV4cG9ydCBkcGtnIHN0
YXR1cyBmaWxlIGZvciBkZWJzZWNhbg0KPiANCj4gSGkgSmFuLA0KPiANCj4gSSBmb3Jnb3QgdG8g
cmVwbHkgb25lIGNvbW1lbnQuDQo+IA0KPiA+ID4gKyMgZm9yIGNpcC1jb3JlLXNlYy9kZWJzZWNh
bg0KPiA+ID4gK1JPT1RGU19QT1NUUFJPQ0VTU19DT01NQU5EICs9ICJleHBvcnRfZHBrZ19zdGF0
dXMiDQo+ID4gPiArZXhwb3J0X2Rwa2dfc3RhdHVzKCkgew0KPiA+ID4gKyAgICBzdWRvIC1FIGNo
cm9vdCAtLXVzZXJzcGVjPSQoaWQgLXUpOiQoaWQgLWcpICcke1JPT1RGU0RJUn0nIFwNCj4gPiA+
ICsgICAgICAgIGNhdCAvdmFyL2xpYi9kcGtnL3N0YXR1cyA+IFwNCj4gPiA+ICsgICAgICAgICR7
Uk9PVEZTX01BTklGRVNUX0RFUExPWV9ESVJ9LyIke1BGfSIuZHBrZ19zdGF0dXMNCj4gPg0KPiA+
IFRoaXMgaXMganVzdCBhIGNvcHktb3V0LCBJIGRvbid0IHNlZSB0aGUgY2hyb290IG5lZWQgaGVy
ZS4NCj4gDQo+IFRoaXMgd2FzIGJhc2VkIG9uIHRoZSBnZW5lcmF0ZV9tYW5pZmVzdCBmdW5jdGlv
bi4NCj4gRm9yIHNvbWUgcmVhc29uLCBjb3B5aW5nIHdpdGhvdXQgY2hyb290IGRpZG4ndCB3b3Jr
IGZvciBtZS4gSSB3aWxsIGdpdmUgaXQgYW5vdGhlciB0cnkuDQo+IA0KPiBUaGFua3MsDQo+IERh
bmllbA0K

--9rpAlGeMRRjPqnvVYQHC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5486): https://lists.cip-project.org/g/cip-dev/message=
/5486
Mute This Topic: https://lists.cip-project.org/mt/77210404/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9rpAlGeMRRjPqnvVYQHC--
