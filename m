Return-Path: <SRS0=p7R9=CM=lists.cip-project.org=bounce+64572+5387+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6793C433E7
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49369207EA
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HHZTJY+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49369207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5387+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FKmGYY4521723xtwq1rjboJt; Wed, 02 Sep 2020 23:20:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.7801.1599114000266789709
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 23:20:01 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0836JqxS027156; Thu, 3 Sep 2020 15:19:52 +0900
X-Iguazu-Qid: 34tKNrBeG2RBitPI9c
X-Iguazu-QSIG: v=2; s=0; t=1599113991; q=34tKNrBeG2RBitPI9c; m=PYPOxRo34gORBZnzL39EC5AbZXK3NASwLr6EHY2ssxw=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 0836JoCC026620;
	Thu, 3 Sep 2020 15:19:50 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 0836JoKW005118;
	Thu, 3 Sep 2020 15:19:50 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 0836JnFP013612;
	Thu, 3 Sep 2020 15:19:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2kAnk9HY51FWgq2r3FZGO/vMmX88aA6O7p35dCKwS+T8pHUfNrzMrInona7ktSeRqdc3lsZK1N4l3ZK/Jh0DLba2+Q/CGJeUBRkcuB2m99cxvbIwdIh+8r2kPewl18zpXXbjyZz+AUSVgf0qY3pPx/GTd0cwZc60UqB5nKH16J6jStnz1IhoCf+g68F9Zr3qes8AYR2zm6qBesuY3yclega9buAWx58ruN+W4cZFO0kChR+lt5W3fo6t8ibeGNpAuk7MwekcoOQKKnyVO2hOPflP7p8QVbvYy3upRrutuViQdUdfZ3zOofawPT8AnfTSjAmiPetBwkY6f4AyRcsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i4NuimfaW3Y8BQ7kORW8S6dLAHk6YioZ9UucGzSaZ0=;
 b=a6gdAwhe6Euh6UOzq7P3V+08YzYaFDcH1DFjQsQfx5PN+IE9do9GExNBybjnMveK8P/0s9FIqmUTxsn66t8lyi07dbKnlkvVUvp93RFMa5ZrIYOsIsWSUdca0eYXSwrln3L+esQD9jJLRwebo7VvXkPDiZX7YPmoLXcEBGvmKSJBz+mu3fl2vzQV/ZrTvQhFVWARvEYXFMGpx2CZbgXZB9NiVUauzpD6IAzkxPpXjabooSoIxNBfR9SGg9B1OTgIFDVaGpuwsRf5ClGiKp0WKjGzO7EWNGHj+RXG450Tbzv33uQz2fmMUedPqjlVvQLe6qLE9ff180kWDI41r3RSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Add RZ/G1H WDT/Thermal/CMT/MSIOF support
Thread-Topic: [PATCH 4.4.y-cip 0/9] Add RZ/G1H WDT/Thermal/CMT/MSIOF support
Thread-Index: AQHWgULk1OXt1IVC0UOE1qWeC7R5CKlVuaIAgAC4BoA=
Date: Thu, 3 Sep 2020 06:19:46 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298391D4512E05C3A76A0164922C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
 <20200902192012.GA25230@duo.ucw.cz>
In-Reply-To: <20200902192012.GA25230@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de9dc848-5a0e-48da-3b96-08d84fd15ade
x-ms-traffictypediagnostic: OSBPR01MB4039:
x-microsoft-antispam-prvs: <OSBPR01MB4039E7ECB944C3D652DC9C3C922C0@OSBPR01MB4039.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EJxzpIRAejGqhohZ16JL4Jnf1Fcgbx1n/2rCoCxZSV9lDVL7GvUNsNPE9r+QajJMj6Yr4FrmeyiJB8k2HmnmYMRkn6j/nRUqKvKotoXLO/t767tnolFc6OYn+aNHXjsR0wpAHYqks0oNuXl612Vd+2pBKhgmoA+0pMLP2tBprvJx3mYFHf8aZcdLtxFWvX4mNBGcSZm87RYHQd0E/pEYIPlqOlbA71+6+kFlwein4E8XszC5GfJXPvTdWlpKMg7XVCEqYKJDRwrRmK3M3bYIL1mV+Z9+hhw8Ew02AV+cd7cKyvJIBFG9oJAg8Y2sss4sGlhHrruYL0eKNSKSlgfT9Q==
x-ms-exchange-antispam-messagedata: Cfpec1pRCgOqkGMmefZpkjCFGEmq0nx7OCigKXZIwNieU3/+ZyQJeTDJHk8ZprQ1S8Uu+XwCX45IHI1NIGgON8ZFChYWY8ZyIaZa4n1As24MnFrrrPysbXFM7937n/v6Jh57kPdUmGcW4T7sAdEI7vsCA2Ow4lcrCIA/tnvWwCnqvF9XX+WEcfN1mgT4si/J8WpaSsklqnQSArkZArwCIISVKiDifn8Asv0kBq83EN0ABb3sSCGJJHbf/vvsPn0PuLCex/17kintUe/IRbJlUkek/Fg6UBdqbDTAWSpXYr+g9ahN3sH9JM4jUXTXq+5KCWA+YkwN/UYl2QPoFkyWLDlvdHaHcmN9z49CzxMn/p5mQBJ2h4fV5Wg97AdE06K68Uy5RxCQIl3icVQRHDroIJWGOj+fs0MFUBhDV7jpS4JNADdwh/ohr81Fk3r/wwO+lsVmNV6FP9JvE/6asnFkgdcHFNNPtY83zhzYKSTMZbOGTretq14oYvFajXGtb5DGQJhXDz6FNwqPpgB8vM0CFSuOr1ehsMbBdLwNLkDPwlAdsE4zG7w54FHtCBqE1J3goT4iC1arPYDYIOAFrwZE6FUe9XIkAcCi3VIS1Ikvp41C/DZtU44dYA96RAm21uBwdro0juD4gVTadLGIZdp4CQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9dc848-5a0e-48da-3b96-08d84fd15ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 06:19:46.3208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1ELGmA+5GZt5CTdM3YC/snCJ3b9LnhZafdrr1qwo8aPd4NS4aSdZrzQrhOnPJ1SEPJji5h+hDRBp8CNNRFh/aZlNbE7R1FhIbGINUY8tcgCD0cQRCkIm19uwsNc0t7R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4039
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UKoiJuf05Wm6UsUJxlLMaxSqx4520388AA=
Content-Type: multipart/mixed; boundary="0CcpA198ZkNT9UMcJAa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599114002;
 bh=eTwSGVrfNpMVlxyfU1JBUqmhkXa6DvSyOD+nsCvJ8O4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=HHZTJY+Xeo02RufXOfdWzgZXhpdtqjWQdTeOU9YRmHmnHaJ4Ovp+h6G/sEtmYqJKKVP
 4ZYJuW9+/wf+22O6rr/nJFGswauftwwVsK1ojJIQHlZH8QX/qixxBPprV/OA+W2NzcuJN
 GrTAb7aCoRTDV08zN64AXraEzJjnS02GQmQ=

--0CcpA198ZkNT9UMcJAa6
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAzLCAy
MDIwIDQ6MjAgQU0NCj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4N
Cj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjl
sqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4gPG5vYnVoaXJvMS5pd2Ft
YXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgQ2hyaXMg
UGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2FzLmNvbT47DQo+IFByYWJoYWthciBNYWhh
ZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDQuNC55LWNpcCAwLzldIEFkZCBSWi9HMUggV0RUL1RoZXJtYWwvQ01U
L01TSU9GIHN1cHBvcnQNCj4gDQo+IEhpIQ0KPiANCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBhZGQg
V0RUL1RoZXJtYWwvQ01UL01TSU9GIHN1cHBvcnQgZm9yIGlXYXZlIFJaL0cxSCBib2FyZCBiYXNl
ZCBvbg0KPiA+IHI4YTc3NDIgU29DIHRvIDQuNC55LWNpcCBrZXJuZWwuIEFsbCBwYXRjaGVzIGlu
IHRoaXMgc2VyaWVzIGV4Y2VwdCBsYXN0IG9uZQ0KPiA+IGFyZSBjaGVycnktcGlja2VkIGZyb20g
bWFpbmxpbmUuIFRoZSBwYXRjaCAiQVJNOiBkdHM6IHI4YTc3NDItaXdnMjFkLXE3OiBFbmFibGUg
Y210MCINCj4gPiBpcyBwb3J0ZWQgZnJvbSBsaW51eCBuZXh0Lg0KPiANCj4gVGhlIHBhdGNoZXMg
bG9vayBnb29kIHRvIG1lLg0KPiANCg0KVGhpcyBwYXRjaCBzZXJpZXMgbG9va3MgZ29vZCB0byBt
ZSwgdG9vLg0KSSBhcHBsaWVkIGFuZCBwdXNoZWQgbm93DQoNCj4gQmVzdCByZWdhcmRzLA0KPiAJ
CQkJCQkJCVBhdmVsDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K

--0CcpA198ZkNT9UMcJAa6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5387): https://lists.cip-project.org/g/cip-dev/message=
/5387
Mute This Topic: https://lists.cip-project.org/mt/76585838/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0CcpA198ZkNT9UMcJAa6--
