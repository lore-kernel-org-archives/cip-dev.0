Return-Path: <SRS0=LVZa=B6=lists.cip-project.org=bounce+64572+5160+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E7C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:27:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAF2208DB
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PTNA9+My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAF2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5160+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id K1LgYY4521723x0D22Cdt90l; Thu, 20 Aug 2020 01:27:37 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.105854.1597912056307718885
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 01:27:36 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 07K8RY9C007174; Thu, 20 Aug 2020 17:27:35 +0900
X-Iguazu-Qid: 34tKqQuZ1S1HnCi8rD
X-Iguazu-QSIG: v=2; s=0; t=1597912054; q=34tKqQuZ1S1HnCi8rD; m=aIADP+hWEzhSe+p79yNzsKDrPpkdlf1JERWQ3sxtghk=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 07K8RYGf032767;
	Thu, 20 Aug 2020 17:27:34 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07K8RY6b026297
	for <cip-dev@lists.cip-project.org>; Thu, 20 Aug 2020 17:27:34 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07K8RXSj021159
	for <cip-dev@lists.cip-project.org>; Thu, 20 Aug 2020 17:27:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7mOW2gEG5v2fURPS+jyOmoycxsG5HYCVpWKphEFJERngHVHONwH+k7kkYmGpH7xT4QbnqP1GWi+gzyiAoiMDvay2v1PnCCWNa0t7kMdSxl7OzFg8Bbd6kg+U0IGMTlk6ohR43pUBRtGv/R/DAXz0mvXxJ4/+ITrfEk4azH/1hf/Y9VHjXVqZwmvUXeQkwnlkVpDgDCKEjgFRNavq+zZZRUpbg8dyNm86Qg4bU4hZhF90uMPnhdEJb2ol9ToyauRoTpZzleYib8pBmwT4wWcYQsANa/DveoMWXOg3di0ec1F1SjREw96Mydc4NMgZ/Pu81BFDSPZTVdtlgrurFdsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTD2/1rDA5myDdRzy1qBX+PxEZHkPml8sRK01pOSuQM=;
 b=BQUnKsjs4wMfYA9ARgYzu1f5SokqmaV1FzKkeqNM7uVnKcaMjPoDa4V9Rb6XyWqrLYfQRgbwYvu5fzm/4LEEY48ZMJVoF+dmhGBd5zrlw0QYht6nnxudihRV3Pur3ftxuhuuL/5ulpHwRzWeV8xaOZmQMEu7MYfI34Y+EB8n5h4n/rqA39at/8tGpzc1nozgwy0WBJAGgsqWGhq1TsjR3iBWFH2KE8QQKNyJOHuZrP+BVCqtnn/bUwN0kfoGz/7zk6wuP4avjROI/Ig89N4mdZf1xYhh6OcVaU1smlKfj2E66VklPrpTJMV6azjBd8WpW3rgS0nmdNEkRhU/aKECHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
Thread-Index: AQHWdeMimvCiSuPwBES9XOG7ooREhak+9ScAgAADS0CAAADggIABslaA
Date: Thu, 20 Aug 2020 08:27:31 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983A71A17CA3D3D70FFA097925A0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200819044201.1255803-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <436e7176-7fd0-086e-6aad-784e3ea1e68f@siemens.com>
 <OSBPR01MB2983FF1811B79A187E85921D925D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <10bdb2ff-1f21-5a3c-2af4-ee275e117215@siemens.com>
In-Reply-To: <10bdb2ff-1f21-5a3c-2af4-ee275e117215@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a4d75b6-e962-42f6-5193-08d844e2e218
x-ms-traffictypediagnostic: OSYPR01MB5303:
x-microsoft-antispam-prvs: <OSYPR01MB5303F8F8891A50EA69791981925A0@OSYPR01MB5303.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TX/3RcnwT3oZgNFPkyG1TPq7HuUm4Vudx9ogH3rOOYMnU/mQswuZsfDVP87mU296g9tVswQCrlsJwuw+ahxkU4mcvbI0bvUx5S28EJ0S1orNsApaXsPzInl8XN8zqUpl7/BpWIWPoVR+jfzcZRhSzzqtZRL9P5fV/VUWXqEneCoDFGHiEdtK4a3UJv00G6al82hcgwis9bxy4hagpqAOJB+sWPFCZKXk4gySJy+TbZZz0HhlsNWgwMKoFTYcw8AuMBLFp7EzGrP7o6Lc2kJ/1xvOagYdY9quu2GyLVLWjl402K7DH4Jag0Am6Crf+JZ3
x-ms-exchange-antispam-messagedata: u/MLA/vh2wL08CB9Cm/esoFnZrfpT3Ub/EsgdidmoDpqM+yZTy1es+/R7dcfFb3TZI2bbzmYo7LO55IzvxMM+ccnIWRYz6dyzpSWXtsdj8d8+Cqzfpqjhz2yDywSmutVP9y2S+ta4jkvuxTnO/zNrrwHgykaxyNdnHUZqfg2s6dLUyV39McZo4zkT9CiAYRsdRAGMwQFB9wfyvcIeKAzE4UPkNEsrEV/k+Wb1szna/e27o1ZiNdHLAsZMoafzvcnRIYK1E2GSmTIfMRDgRevfHurkYUryk43ATnHWKXDWXH7IOkFze4htBY/0BxYGqwNvA1oyYcbI+FQjeg2srYLOsu/P11Lash2+X2flrAZkSReu6tVJFhq4MNrAnsRmfbV2WsBxnySTX6wGRIn2+kMDSKFijxNahChieU3oQgox9k1WTOHJsM/KaFqU0fyDFQoUNnA53FRHjrvkWvoiMhlTPv1lYm3Jscbl5dO76umH44FqNX55JKanVi2bfdOfmW+dxqMPv9itNlGqMISIW4HSEOBsEqXTWaGKWXFPUNnTBAgOPG6sClL0uWZW/5M9OHwlZqlWO3LkMMql9LOz0nnPcZ9KaBrYp6voZfaYk62snW5iXSxchDStz00u5DXS1rl23u1JtaPzaqaiH8W4BHYZQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4d75b6-e962-42f6-5193-08d844e2e218
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 08:27:31.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dud9wVOKX+gM7YkPsd39mDJWw1oIj6rbDKr0CiOxFfg6PGYkPvveFdR6hjaby4qvZVrFmk75EBhkr0nQCPSa1E/rUzzplqpKQm/RoxVLABX+BR+9uCqDSN9kxm5fRd3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5303
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TGvzUkEVwoYGrDCIWKJJObsgx4520388AA=
Content-Type: multipart/mixed; boundary="G4IQFkQfrt3AYjiXFGuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597912057;
 bh=dX0Xa/CSFTG5TD3Cw1qeO12LIYe6gj4jwh30mIMisH4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PTNA9+Myp3U8V4VqdGLeUJCFDv63ihPePv2KuthdDgNtMbl0oyHMB3sFeuPuMXu5MxL
 qEcHuvu03iAe3BIOaxIoUCLEc4TbonCUZ1ELY6EFZ1Pv8vHz/Nfwx71w1bc455pI/aC/4
 jrBhOEw8IaS2h3xb08Nfrs0zgH8e/FbsaDQ=

--G4IQFkQfrt3AYjiXFGuH
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTksIDIw
MjAgMzozMyBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPv
vLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lz
YXItY2lwLWNvcmVdW1BBVENIIHYyIDMvM10gdGVzdGluZzogQWRkIHRlc3QueW1sDQo+IA0KDQo8
c25pcD4NCg0KPiA+Pg0KPiA+PiBBaCwgbmljZSBzb2x1dGlvbiB3aXRoIHRoZSBfYXBwZW5kLg0K
PiA+Pg0KPiA+PiBDYW4geW91IGZvbGxvdyB1cCB3aXRoIGEgcGF0Y2ggZm9yIENJIHRoYXQgYWRk
cyB0aGUgdGVzdCBmZWF0dXJlIGF0DQo+ID4+IGxlYXN0IHRvIHNvbWUgb2YgeW91ciBpbWFnZXM/
IEkgYWN0dWFsbHkgd29uZGVyIGlmIHdlIHNob3VsZG4ndCBhZGQgaXQNCj4gPj4gdG8gYWxsLCBv
ciBldmVuIGhhdmUgdG8gaW4gY2FzZSB0aGUgQ0kgaW1hZ2VzIGFyZSBkaXJlY3RseSB1c2VkIGZv
ciB0ZXN0aW5nLg0KPiA+Pg0KPiA+DQo+ID4gWWVzLCBJIHBsYW5uZWQgdG8gZG8gaXQgYWZ0ZXIg
aXQgd2FzIGFwcGxpZWQuDQo+ID4gSSB3aWxsIGFkZCB0aGlzIHRvIHYzIHBhdGNoIHNlcmllcy4N
Cj4gDQo+IE5vIG5lZWQgdG8gcmVzZW5kLCB0aGUgcGF0Y2hlcyBhcmUgYWxyZWFkeSBpbiBuZXh0
LCBsb2NhbGx5LiBKdXN0IGFkZA0KPiB0aGF0IHBhdGNoIG9uIHRvcC4NCj4gDQoNCk9rYXksIEkg
c2VuZCBhIHBhdGNoIGZvciBDSSBvbmx5Lg0KDQo+IEphbg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5v
YnVoaXJvDQoNCg==

--G4IQFkQfrt3AYjiXFGuH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5160): https://lists.cip-project.org/g/cip-dev/message=
/5160
Mute This Topic: https://lists.cip-project.org/mt/76280651/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--G4IQFkQfrt3AYjiXFGuH--
