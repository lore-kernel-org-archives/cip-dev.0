Return-Path: <SRS0=kVGQ=BR=lists.cip-project.org=bounce+64572+5106+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4721DC433DF
	for <cip-dev@archiver.kernel.org>; Fri,  7 Aug 2020 21:31:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA4D22CAF
	for <cip-dev@archiver.kernel.org>; Fri,  7 Aug 2020 21:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Yp4n9/Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA4D22CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5106+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YY2MYY4521723xY7pSybRvOO; Fri, 07 Aug 2020 14:31:42 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.6268.1596835899836745497
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2020 14:31:41 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 077LVbr1007592; Sat, 8 Aug 2020 06:31:37 +0900
X-Iguazu-Qid: 34tKNrBeFJcoruMOzg
X-Iguazu-QSIG: v=2; s=0; t=1596835896; q=34tKNrBeFJcoruMOzg; m=xjQ4o+yohFEDBNGFOEHSbTOypGmO4vqQCyCPzUatWno=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 077LVaAr007202;
	Sat, 8 Aug 2020 06:31:36 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 077LVZbr002856;
	Sat, 8 Aug 2020 06:31:35 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 077LVZxn003498;
	Sat, 8 Aug 2020 06:31:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G38JwevsdorwOsyRFeXX+6o+YaWj1IvaA+qVqKoaPtk8KV8VGWPIoAFjrlHlJ9K1/YiQjMGoxjH1zfeW/RwQZctpTWuOyUrOjNXMown85g9h5gMfek9nRG/BVMPTUOUPBD5nYyVKKcg4ZITcjgvdslmT8AfV4IHNls5r0s35N56tL3zQ05aA21DCfhUkv/Htc4fc7MTsRAe22mwgCdDR6Bz6XgIkr2aZM7V5qe20mA64ftMKhGCCu0hZswzVuvZueSiPOYNLy4xhlH9JYeVhSB5qWT8CNGsUICLw/BplhcK70Z3D3sUHPeCizRhTuCSXkoqXAa7bZOppsSf4NNNJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXouBeb8JCM30fTlAsEwWWlKX9LgcJpygYgrVhsF4aM=;
 b=ez1lhovIA446+hYDbvBLzHquFOr91V8L7/KBy4iwD6LsyYwx/nNm7fBdjFXUuNrUPjba/SXUwkpZu0bGjScLkfkIJ5Y1vzJiLlHEtnTyZjsYyzO/ts92RlqKUppuAkTM96MRSHHS94dBqE0UpaEtbkT9UKfSVHGlk4pzfOL/Rzj/1KPA62QwqG8yxkiPILk0GdNFacY5iSxSHnC/3XOSDQ6mkUY51DCJ8UWXLjNJPL0CNhnmKtqfgoHkoHliItDOaKIgWH2U7Uhtu8vPHOIiqcV47yBUweDZObd+i/sQMMqm3wlv7BW+m8gKGEsK9+rZOVIIyN4B5NioPsxcJAhRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <daniel.sangorrin@toshiba.co.jp>,
        <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add EFI_STUB to config
Thread-Topic: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add
 EFI_STUB to config
Thread-Index: AQHWaX6lfBZmtPjHaUaZ6kNYeyjoB6kqp0XQgACA/YCAAghzEA==
Date: Fri, 7 Aug 2020 21:31:33 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298341D4C5B082E32DB5587792490@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200803101217.6961-1-Quirin.Gylstorff@siemens.com>
 <OSBPR01MB298330C0C2BA66778FAB84AD92480@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <c0e08e23-2cc0-0ded-6266-2c4da2ccf4af@siemens.com>
In-Reply-To: <c0e08e23-2cc0-0ded-6266-2c4da2ccf4af@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 501e8f07-7690-40b9-06f8-08d83b1941d5
x-ms-traffictypediagnostic: OSBPR01MB4887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB488745B5329C1C6D3E7C576D92490@OSBPR01MB4887.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dQnL0nov9IQt1qWC3HaOmmjc4T5enMSpkZJycfnPG1Sz3NjghQ3GWO+yTkJEI8Y9u0A37CS5aXsKDsab9o1yxp1MRJnvfqOevco+JTK9PLr38P2Bciygx9jNpwmDreuJtlbsO1Xy/BbqzqaIWL0hm4KYoS1Liqm6vGErDljWPCGXeP/EpabJll2rdNVtFXqYUjU8hdQ9nroVVVlFms7nCmo1miwNHnU34S5uWcxxQ1a10BlBQxRH0lVmPPs5If8HEb1/WNM86d7qR9BEY8F9kxj+LEgFsmvWDqsdEjr7BTYyPBhZ+bRd+5qtS0WInQDe
x-ms-exchange-antispam-messagedata: a0lGyuoeDH6eOJP6bYhZvu5q7e3VEEFY5oD10YsBFNSylGJ6Eg9tn90tHw7vAa8EbDoXqvjIX7LIhkajXLdbISUVsaryL/BMiZWDkF+jPJ4giuMI1qelDPVzZerL2S+bi4KKpuvJZawXV3CVH411jO4Fkd/cjVCAC3CuFgTq8QzMX3bCIYmNvHlGgrDDMq5Cv809GhoAefYufcHZhz+sPLLr+O+F9rngILJN8YRzQjWkKqTN9+fd0bwWmi4vmRS1pgiwTLkH4c+S335I5T1C1z0iK3Z91cF9hWneob0jHqYEYFSm6yRUqo0+dcLSIDKrViQsUVddJMkKIXRQrLui5BfF0NU8QeuGfTnQSogFOm8DqN3j8iAtbsR7kYiK85af3ed9OpzsIRFutdzT/llV3IkqAgbMYC0D2Vnq6oETUKfVoiTv+sNhrRVKQ0UmpLHtMDf9DLI7CKBy4fQdj/MFpgfuLw/oQEUHcjXl6sBSDsJ+0tes8pvxerwGVpGnQwGA8x2VFoWyJy2FM6KNDLiLbT7A3LFrILdHtyPQqMsRZOohhgx9aK51psr8Pd+ctCRWcvx6voT4fqGaYIlJcwOjk6wWSc0XLgKX8WZfq5x+hwHB00yIvnwxQ5hnrVF8RXB/Z5dPHIs0h7LBRz6Tm7WMUw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501e8f07-7690-40b9-06f8-08d83b1941d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 21:31:33.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBXWX8S9cIxYyaV2ojNVR1iLU7TJvF3LF5PpLOgkdkynSJe5z1Vx7ymYK9a5Tkd7fMhSC53dA41851tN7m2qP74nNrFr3QkevKUr1nMsqKYRVT9mxDlwQfHi43hb5til
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4887
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RCExqTBjO0M6SNq39nXfAngMx4520388AA=
Content-Type: multipart/mixed; boundary="B5ZpNgRgItB553LFjBGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596835902;
 bh=iq4h66h1yC3gbUAZw1/xJBR7g0462cx9JsbC/uI/PdI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Yp4n9/JmXEXxbVMtXy9v4YaFo99CGkehzZGrlKHoKBBcjUwPONBd07rwU14D56Uz0Id
 nWKY/UFW1QSwbSLGjRSv4Tl8SvbdEpibNymrZaZwBiXvSLIPp6+eiR0ls7T9khaPA+kZt
 L1J69psYBG4JPLGmBxSV6cQia2ACcVkaU3o=

--B5ZpNgRgItB553LFjBGG
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFF1aXJpbiBHeWxzdG9yZmYNCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCA2
LCAyMDIwIDExOjI3IFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgc2Fu
Z29ycmluIGRhbmllbCjjgrXjg7PjgrTjg6rjg7Mg44OA44OL44Ko44OrIOKWoe+8s++8t++8o+KX
r++8oe+8o++8tCkNCj4gPGRhbmllbC5zYW5nb3JyaW5AdG9zaGliYS5jby5qcD47IGphbi5raXN6
a2FAc2llbWVucy5jb20NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbY2lwLWtlcm5lbC1jb25m
aWcgUEFUQ0hdIHFlbXVfY2lwX2RlZmNvbmZpZzogQWRkIEVGSV9TVFVCIHRvIGNvbmZpZw0KPiAN
Cj4gDQo+IA0KPiBPbiA4LzYvMjAgODo0NiBBTSwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+
ID4gSGksDQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9m
IFF1aXJpbiBHeWxzdG9yZmYNCj4gPj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMywgMjAyMCA3OjEy
IFBNDQo+ID4+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgc2FuZ29ycmluIGRh
bmllbCjjgrXjg7PjgrTjg6rjg7Mg44OA44OL44Ko44OrIOKWoe+8s++8t++8o+KXr++8oe+8o++8
tCkNCj4gPj4gPGRhbmllbC5zYW5nb3JyaW5AdG9zaGliYS5jby5qcD47IGphbi5raXN6a2FAc2ll
bWVucy5jb20NCj4gPj4gQ2M6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2ll
bWVucy5jb20+DQo+ID4+IFN1YmplY3Q6IFtjaXAtZGV2XSBbY2lwLWtlcm5lbC1jb25maWcgUEFU
Q0hdIHFlbXVfY2lwX2RlZmNvbmZpZzogQWRkIEVGSV9TVFVCIHRvIGNvbmZpZw0KPiA+Pg0KPiA+
PiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0K
PiA+Pg0KPiA+PiBJZiBFRklfU1RVQiBpcyBub3QgYWN0aXZlIGJvb3RpbmcgUUVNVSB3aXRoIE9W
TUYgZWZpIHdpbGwgZmFpbA0KPiA+PiB3aXRoIHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZSBg
S1ZNIGludGVybmFsIGVycm9yLiBTdWJlcnJvcjogM2AuDQo+ID4+DQo+ID4+IE9WTUYgZWZpIGlz
IHVzZWQgaW4gaXNhci1jaXAtY29yZSB0byBkZW1vbnN0cmF0ZSBzZWN1cmUtYm9vdCB3aXRoDQo+
ID4+IGEgdW5pZmllZCBrZXJuZWwgaW1hZ2UuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFF1
aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ID4+IC0tLQ0K
PiA+PiAgIDQuMTkueS1jaXAveDg2L2NpcF9xZW11X2RlZmNvbmZpZyB8IDEgKw0KPiA+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gUGxlYXNlIHVwZGF0ZSBjaXBf
cWVtdS5zb3VyY2VzIHRvby4NCj4gDQo+IFdoZW4gaSB0cnkgdG8gZ2VuZXJhdGUgdGhlIHNvdXJj
ZXMgLSBhbGwgLmMgYW5kIGFzbSBmaWxlcyBhcmUgbm8gbG9uZ2VyDQo+IHBhcnQgb2YgdGhlIGNp
cC1xZW11LnNvdXJjZXMuIERpZCBJIG1pc3Mgc29tZXRoaW5nPyBPciBzaG91bGQgSSB0cnkNCj4g
YWdhaW4gbGlrZSB0aGUgbGFzdCB0aW1lIHRoaXMgaGFwcGVuZWQ/DQoNClRoYW5rcyBmb3IgeW91
ciBjaGVjay4NClNvcnJ5LCBJIHdhbnRlZCB0byBjaGVjayBpZiB0aGVyZSB3YXMgYSBmaXggaW4g
Y2lwX3FlbXUuc291cmNlcy4NCkkgYXBwbGllZCB0aGlzIHBhdGNoLg0KDQo+ID4NCj4gVGhhbmtz
LA0KPiBRdWlyaW4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--B5ZpNgRgItB553LFjBGG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5106): https://lists.cip-project.org/g/cip-dev/message=
/5106
Mute This Topic: https://lists.cip-project.org/mt/75962579/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--B5ZpNgRgItB553LFjBGG--
