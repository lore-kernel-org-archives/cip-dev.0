Return-Path: <SRS0=YxJX=DI=lists.cip-project.org=bounce+64572+5484+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B49CC4363D
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 00:23:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8767207C3
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 00:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RqfyW1xE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8767207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5484+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fVAyYY4521723xdyclLmGeRO; Wed, 30 Sep 2020 17:23:25 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.1254.1601511803036230591
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2020 17:23:24 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0910NKpv020769; Thu, 1 Oct 2020 09:23:21 +0900
X-Iguazu-Qid: 34trROXa0zVpabvFtq
X-Iguazu-QSIG: v=2; s=0; t=1601511800; q=34trROXa0zVpabvFtq; m=47Iy8BxoS6w/r8UhaQcGemiSi8Mwz7nzor+H//Hx2l4=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 0910NJd7015485;
	Thu, 1 Oct 2020 09:23:19 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0910NJJo028267;
	Thu, 1 Oct 2020 09:23:19 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0910NICd028613;
	Thu, 1 Oct 2020 09:23:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy2rOuQ7nOqDcqgTSCXkFZACHlsSOzxKDzvIjKQUaRHvkh92gnZJkZfwVTnOiTE3PyfQDGMiaW+hU4SWxfdH4ePaPvebZq1DfCnWZXMoyCxE3aTJDm8hoh53cMYG45GkKbYdd7AuJWObtvzdjE2+s+2NnTWMLMh71XIkwy9wnwPltB2bYn6sCs1ohsl7sNIfOWDSU/KnbxarbceghyH8hj6YMYh4V/007NnFlO62FtkguDeZxdj0Y9bPsFAZvXFpyw58q1/oJmMmqe+fr36dHZd0D9Zxzm1guILHxJ80sMlcREPvDqbTYCM2eW5taqM0BI0700xelqh0/m7MZHD0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwxNjKoJrKJfK/mjbM4iIY9UQTtiF0ieYX4Xovga2Ag=;
 b=GhxXcD0DONe797MSK0pcSA1Hm+kXDI/hvcFb0Kh08mAd+oxeuvuK+XK12p4xegkAfiW7qNT5t6sfV/NWLb5OVitD+xPtzbDe28nnc2boL/9KXGIogfo981cWj+elRIZV7S+PrM3UVvCaN4QEpET3OEDC+DvMCcy4ZZaQ8jhu2WO2W5PvEkwS+5ZP4lHm8Zsz9Vd8DRebYrOuFL+CoKokAc23TYJjk4a1CBxdBbFsjtmUa2Rgo3vb18aBKXcqwryvHwqGc3K53Vq8TgFiLl8yOBWmuTdenpFi4/oEj429DvZ559ENjrI98r3iVc25ovz65bMJiSAUpRUC4FdcNnCCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <jan.kiszka@web.de>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core] image: export dpkg status file for debsecan
Thread-Topic: [cip-dev] [isar-cip-core] image: export dpkg status file for
 debsecan
Thread-Index: AQHWlvjz2mwSipOuB0+WVfLbj9/OM6mB5CHw
Date: Thu, 1 Oct 2020 00:23:07 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053CCABDC615E47F16BECE3D0300@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200930020815.2474349-1-daniel.sangorrin@toshiba.co.jp>
 <20200930020815.2474349-2-daniel.sangorrin@toshiba.co.jp>
 <7596cf39-b8f9-cedc-3b51-b164553b3ee4@web.de>
In-Reply-To: <7596cf39-b8f9-cedc-3b51-b164553b3ee4@web.de>
Accept-Language: en-US
x-originating-ip: [124.211.28.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ddc6763-f17d-4f6e-0c39-08d865a02bb8
x-ms-traffictypediagnostic: OSBPR01MB4808:
x-microsoft-antispam-prvs: <OSBPR01MB4808AE1FCDFCAE31E4D98EACD0300@OSBPR01MB4808.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /oByAPbQnsrv+Bj3K9oNKCk1bvSk5JhQLIgzNHrBYvx08LMLV6bThul4G2sXvcGnQnkXfPkvLKoU+nHF7h9Gy/tmdva6AdkvsJFW4ZyOySPlEiVusfcUsSFH0MGL1ox3SP+Ek6KM+mr96iljF6B4ePn+B+iCIRRaX3U8KSVKVZgKhaQMZvyuxzfsoyLvtoZ/jVA/RokafMH+tkDmJyh+0Lm0yrzqsIvSPWBytdHM+XiztiXsJQ9sAqMz1Qr7CtzLjImsCR0Vbt06ka0YNzfMX+N3SYm3PdiCBxtmO1PnMwwgDF3mgSCuT2JQz2vp/NUvL5WZllY4JDKY0g9zLu42/Q==
x-ms-exchange-antispam-messagedata: Vk8kZ1GpbpVCAC03lUTvDJDzzwo/7ScWMoeuV9jfqOeMZzftIxh+elM3kzmuutwOIC2TTevzWcyYTTyYJGlhbSs1Uf1T9jgwnIW0/m1D+eAeQ7/YU1Bv148oERxm2+DOTKDjLBiepB6XY8lttMlPyIbO2x3wyLkP5Z2DFlqc4ZYu0Hh1qAUA1ZeTWJKHRd9JhHFIBiJQeRRJm6ArUig3CJ4NOkEpLmy1kL5DOvPI93ePP9ufTB7KTrUShrhB8LKfkr/IrWt0QWbAvdqth7ZnG1Ac+6vGi1yczLS+is3aqjIjBKA423WPSzO2khkH8ZCxh3FDjRjmmV5HSTpB8BoJzpMdZ0gNtfDecp4sGMjbgPtq+CfK30azioRvaCsm09wKrOKyRZlgP3UcSFaFLK6kF4J/C2cOY4Z0UJwaJZaZ0k4y4kkvx+k9Si545LB7L1wVaxMI0oCokWnydCPao1fB82MGgG7NZpbvjgQS1y+/NDcinN356pNzrNKVCfWzzu2v4nVV2G1kSc7PMdOWcPGYP4vcmol+GfIUDuHsok7jiR0puTgL8b7rPvOfwwXSfQ676Cs+nJSC/sAUXb1fLsXfCz+wnwpX3zE0aK5w7ViGU5gRGjKMR236lApabZ1kqrtlMdF9Oo+5aYWtbIWPEJck3Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddc6763-f17d-4f6e-0c39-08d865a02bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 00:23:07.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7yY0jJhFUrp+RUq+U1SwEyFckeFk+/z/7K0HFjrizoLgH4hWQpBpqsgad3O4Y61ct7hDU7Ev22JXATd1srbYdsHzVp8Dt+NdZ7kh28zt3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4808
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7Fi1OLpmc2LuiGRzvtEKi5Esx4520388AA=
Content-Type: multipart/mixed; boundary="SNy42m8fYRJhA8E8P6S7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601511805;
 bh=tRib5qeEAgCv5FDiLaP1WXhuT3qOj7vnYbl7Qs9D5TU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=RqfyW1xEzLvRCsECHjh+xRMimyI+mwkII0HAG9uo8GaZSsGQFLHkZ2WxAAfx+zA1bvs
 3StwBQZkKwIbnUaCG/L92UuQH3P6Uet4kfgxEDfmKCzgN7vWn3ECRFlcOjp4egmNJGFGo
 /o2t87HTIp8y9hZr/Bi84bNXu/AZxc9eNwQ=

--SNy42m8fYRJhA8E8P6S7
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQpJIGZvcmdvdCB0byByZXBseSBvbmUgY29tbWVudC4NCg0KPiA+ICsjIGZvciBj
aXAtY29yZS1zZWMvZGVic2VjYW4NCj4gPiArUk9PVEZTX1BPU1RQUk9DRVNTX0NPTU1BTkQgKz0g
ImV4cG9ydF9kcGtnX3N0YXR1cyINCj4gPiArZXhwb3J0X2Rwa2dfc3RhdHVzKCkgew0KPiA+ICsg
ICAgc3VkbyAtRSBjaHJvb3QgLS11c2Vyc3BlYz0kKGlkIC11KTokKGlkIC1nKSAnJHtST09URlNE
SVJ9JyBcDQo+ID4gKyAgICAgICAgY2F0IC92YXIvbGliL2Rwa2cvc3RhdHVzID4gXA0KPiA+ICsg
ICAgICAgICR7Uk9PVEZTX01BTklGRVNUX0RFUExPWV9ESVJ9LyIke1BGfSIuZHBrZ19zdGF0dXMN
Cj4gDQo+IFRoaXMgaXMganVzdCBhIGNvcHktb3V0LCBJIGRvbid0IHNlZSB0aGUgY2hyb290IG5l
ZWQgaGVyZS4NCg0KVGhpcyB3YXMgYmFzZWQgb24gdGhlIGdlbmVyYXRlX21hbmlmZXN0IGZ1bmN0
aW9uLg0KRm9yIHNvbWUgcmVhc29uLCBjb3B5aW5nIHdpdGhvdXQgY2hyb290IGRpZG4ndCB3b3Jr
IGZvciBtZS4gSSB3aWxsIGdpdmUgaXQgYW5vdGhlciB0cnkuDQoNClRoYW5rcywNCkRhbmllbA0K

--SNy42m8fYRJhA8E8P6S7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5484): https://lists.cip-project.org/g/cip-dev/message=
/5484
Mute This Topic: https://lists.cip-project.org/mt/77210404/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SNy42m8fYRJhA8E8P6S7--
