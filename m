Return-Path: <SRS0=yslp=7P=lists.cip-project.org=bounce+64572+4664+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F73C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 23:29:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C422072F
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 23:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RVs1xdCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C422072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4664+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AfYxYY4521723xVTK8udbDJH; Tue, 02 Jun 2020 16:29:54 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.2575.1591140591639103496
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jun 2020 16:29:53 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 052NTnHa008432; Wed, 3 Jun 2020 08:29:49 +0900
X-Iguazu-Qid: 34ts1iCWLIkqg6WuSw
X-Iguazu-QSIG: v=2; s=0; t=1591140589; q=34ts1iCWLIkqg6WuSw; m=5BAeyPRMql2fn28gKE4s4EV/Vg09gNtqGBAuc+q1AXE=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 052NTmMI031438;
	Wed, 3 Jun 2020 08:29:49 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 052NTmbw021967;
	Wed, 3 Jun 2020 08:29:48 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 052NTmT2023639;
	Wed, 3 Jun 2020 08:29:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSY5ZGM7SwmO3K8eL9oplEUDTwxqaIGg3PzmEb/TpB/qhyEpbi72dDCbREcoWGKLT2LwNUWBhYVGj/4LOIJAXC3g7tKlpfR6QwXEPZzj0SPZOOKfF1Axn7mOqXIxeZdenoTvNzoB9s5s5iLDXZzSO/uLc+ynhCzQHSo14UJJ+DNXTnYdewNl9fUafIe/F9yjZKXmu/OFf1QS5wzkcSYpw99sG5pCHQJDOqsJBII2m6JVFCz/C8COUwv7HEXtOEs0o4AVAkgrGBVRt8PtOe493Aox1kwtiiT26nB0iHCL8roJNKoWJcg+Xq/8iQVLT6vL/b7QDrqewgOuYoU82+gcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnlCRihJVjQMdHUya/P02MZzCGbCpaeIBln1MoJbieU=;
 b=gYAJ+f4fk9rZ5TvX+Qb5wzLEPmrU/bGic5UNB2oYUzz5UlqN55kb5cLfYEZvtz+2b/ASyLfJhX2HDnVZpoiZSkIY1FI4lWhcyGBbJUin51zTZIKi3+WkGPI8Ff8el2YU7u80LeTHSUeTfSdWrrzHoClH0//hspfEDp/OnOIuZT/opAH9z0J0ZuRJfzXILEWjUQNuuUiBHhABZIYSR2hGajtmQJgd8ew3O9LU2FbHSftyBCak0DDp9rfYNSyiSJARarIGPbuDflItvTE/l5YQN4Wb/p+MgycSFKfE++F6d1BFGARJd0AI3G8B6I9MCX6Bo6h7Uxs3UAY8Nsxdwd+JSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Thread-Topic: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add
 LCD support
Thread-Index: AQHWOLoUc2i8sKHiqkSDUEMppJyp/ajF+PTA
Date: Tue, 2 Jun 2020 23:29:46 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298388B7BE773E7DD4284E4A928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
In-Reply-To: <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14d06d47-ad09-4636-cb57-08d8074cd616
x-ms-traffictypediagnostic: OSBPR01MB3830:
x-microsoft-antispam-prvs: <OSBPR01MB38303A39444BB5E2E79B85E0928B0@OSBPR01MB3830.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aWFay8ANiya5REzcwHSThVD9fMA9GyIkyV8VMXY8bq84BGkGs0g7lNFXYlBpB/dxYdEtmdN+xV/TooTHsF6a2CEHr8lwk0nZqoLFi2o8tQvyR7oFKSYL2lxybR8CeUKWoGMvudrn8CK0E98gx0rueRCxtneaAEALkX3rulHnA11fb72MLPIzaz8WJ+yUrTVteRoj5ZYy31vYuMnpU3hej60Pjkzl/xANtRJkFN6SOD7PyUKIvoce1e2QanyQBIFqI1IxiNiIv8S5uYHyoPsuHcdqzENOOk50I+3yQ1P/lPhd7i7xjCkCflAkqha3GwkYiJULFf4VM7TQ3EimGGXq9o2hJ2+6fWTIroeqKViRxnzj8ZexzYD9r+Ar+oP4ZtfnbdIYdFq9P4+g8bRYC89p8Q==
x-ms-exchange-antispam-messagedata: bOZb24A+gjkFXz4vqrudDHSYQxuttSnZA15qxVHpwI71gwivFkZiC2NIci4YnbrS81CNtXkopAUcJLzeEHE4sQsZXsZiGB62Gu2OJBgk5ZVgxHYfIxWOVjD6taUtiDg+XZYm9eIovQlLAEpgCZmCVnhyzLmBjNE8o7SS+yJEW1sq7yHk5veFdXZ2QE3l+mDDatDjHWQqnlA5RahEFMVUGWZu451A/MGo2fWlGBP7EARntXVaezvHFy82G85EF3tAgftTm9hZAf6Ig2A+6DaFqig+34oUjaoSvLAG0bqObgw1eJiT24hw9hu83S/Y1WtYZ87+l4hN2uFwFOSvy0aEIKyF2jqZ5FeoXKUtfYml1vYGu1rVikEfSThOTJ1Dbf2xPtKs3GcbBWHdXK/eEc/lK5hff2O/QybNjbTPMLQJGXhkT6r2mNQ1JOrV8NVPC4OC2SJQSCZTw1tUaR/eTn/Ju3zTlEDvSIqFuC6+2kMWCpg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d06d47-ad09-4636-cb57-08d8074cd616
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 23:29:46.3322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiqbjS5bKM1nbMIqV4dhSP2lEIYhTAPFq8msvg6o1FmxBhwcqV6n7RDOacECzOjOw4D17P9SgOqt7lCmxkYKXjP6hoNAHNLF0OmqL6jTb7rQLGBV+eDyk48BZeKzybfP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3830
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EpnDS6BAtkCaoa1MRlfEYmFPx4520388AA=
Content-Type: multipart/mixed; boundary="buaWmzpFLTbEN337jLyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591140594;
 bh=LCYWxMwb76EMS/6z4mIZiS0CV9Dl52EGCFO6R2VvSI4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=RVs1xdCX0GjYRttSh+FEQzUq+BQCQu6ZFO2rZvegKLWAm2MFphdP0ec0kBES59dmVbT
 pzkxi+ksOn79bH5qIilZ+njr+0T/K1mM9zoH3a1CHVHU0nN7yIuEFW/vviiIWSy8+4y90
 iRXCES33JM1mgmsRWhNz+hYhygcbWPHCtrw=

--buaWmzpFLTbEN337jLyz
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1DQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bmUgMiwgMjAyMCA1OjQzIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0K
PiBDYzogQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2FzLmNvbT47IGZhYnJp
emlvLmNhc3Ryby5qekByZW5lc2FzLmNvbQ0KPiBTdWJqZWN0OiBbY2lwLWRldl0gW1BBVENIIHYy
IHY0LjQueS1jaXBdIEFSTTogZHRzOiBpd2cyMGQtcTctY29tbW9uOiBBZGQgTENEIHN1cHBvcnQN
Cj4gDQo+IGNvbW1pdCA2Zjg5ZGQ5ZTkzMjVkMDViMWY1NGQ4NjBkYmJjODRiNDJhYTQwNzU5IHVw
c3RyZWFtLg0KPiANCj4gVGhlIGl3ZzIwZCBjb21lcyB3aXRoIGEgNyIgY2FwYWNpdGl2ZSB0b3Vj
aCBzY3JlZW4sIHRoZXJlZm9yZQ0KPiBhZGQgc3VwcG9ydCBmb3IgaXQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryb0BicC5yZW5lc2FzLmNvbT4N
Cj4gQWNrZWQtYnk6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJv
YXJkLmNvbT4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8xNTczNjYwMjkyLTEw
NjI5LTExLWdpdC1zZW5kLWVtYWlsLWZhYnJpemlvLmNhc3Ryb0BicC5yZW5lc2FzLmNvbQ0KPiBT
aWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJl
Pg0KPiAocmVtb3ZlIHRoZSBMVkRTIGRlY29kZXIgYXMgdGhlcmUgaXMgbm8gZHJpdmVyIGZvciBp
dDsNCj4gIGFkZCBwYW5lbCB0aW1pbmdzIHRvIHBhbmVsIG5vZGUgc2luY2UgdGhlIExWRFMgZHJp
dmVyIHJlYWRzIHRoZW0gb2ZmIHRoZQ0KPiAgcGFuZWwgRFQgbm9kZSkNCj4gU2lnbmVkLW9mZi1i
eTogTWFyaWFuLUNyaXN0aWFuIFJvdGFyaXUgPG1hcmlhbi5jLnJvdGFyaXVAZ21haWwuY29tPg0K
PiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2l3ZzIwZC1xNy1jb21tb24uZHRzaSAgfCA4MSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaXdn
MjBkLXE3LWRiY20tY2EuZHRzaSB8ICAxIC0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgODEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQoNCkxvb2tzIGdvb2QgdG8gbWUgdGhpcyBwYXRjaC4N
CkJUVywgd2hlbiB5b3UgY29uZmlybWVkIHRoaXMgcGF0Y2gsIGRpZCB5b3UgdXBkYXRlIHRoZSBr
ZXJuZWwgY29uZmlnPw0KSWYgd2UgbmVlZCB0byBhZGQgZHJpdmVycywgcGxlYXNlIHRlbGwgdXMg
d2hhdCBrZXJuZWwgY29uZmlnIHlvdSB1c2VkLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJv
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaXdnMjBkLXE3LWNvbW1vbi5k
dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaXdnMjBkLXE3LWNvbW1vbi5kdHNpDQo+IGluZGV4IDAx
MWRiYWIuLjUyYzE3ODcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2l3ZzIwZC1x
Ny1jb21tb24uZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pd2cyMGQtcTctY29tbW9u
LmR0c2kNCj4gQEAgLTQ5LDYgKzQ5LDQwIEBADQo+ICAJCWNsb2NrLWZyZXF1ZW5jeSA9IDwyNjAw
MDAwMD47DQo+ICAJfTsNCj4gDQo+ICsJbGNkX2JhY2tsaWdodDogYmFja2xpZ2h0IHsNCj4gKwkJ
Y29tcGF0aWJsZSA9ICJwd20tYmFja2xpZ2h0IjsNCj4gKw0KPiArCQlwd21zID0gPCZwd20zIDAg
NTAwMDAwMCAwPjsNCj4gKwkJYnJpZ2h0bmVzcy1sZXZlbHMgPSA8MCA0IDggMTYgMzIgNjQgMTI4
IDI1NT47DQo+ICsJCWRlZmF1bHQtYnJpZ2h0bmVzcy1sZXZlbCA9IDw3PjsNCj4gKwkJZW5hYmxl
LWdwaW9zID0gPCZncGlvNSAxNCBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwl9Ow0KPiArDQo+ICsJ
cGFuZWwgew0KPiArCSAgICBjb21wYXRpYmxlID0gImVkdCxldG0wNzAwZzBkaDYiLCAic2ltcGxl
LXBhbmVsIjsNCj4gKwkgICAgYmFja2xpZ2h0ID0gPCZsY2RfYmFja2xpZ2h0PjsNCj4gKw0KPiAr
CSAgICBwb3J0IHsNCj4gKwkJICAgIHBhbmVsX2luOiBlbmRwb2ludCB7DQo+ICsJCQkgICAgcmVt
b3RlLWVuZHBvaW50ID0gPCZkdV9vdXRfbHZkczA+Ow0KPiArCQkgICAgfTsNCj4gKwkgICAgfTsN
Cj4gKw0KPiArCSAgICBwYW5lbC10aW1pbmcgew0KPiArCQkgICAgY2xvY2stZnJlcXVlbmN5ID0g
PDMzMjYwPjsNCj4gKwkJICAgIGhhY3RpdmUgPSA8ODAwPjsNCj4gKwkJICAgIHZhY3RpdmUgPSA8
NDgwPjsNCj4gKw0KPiArCQkgICAgaGZyb250LXBvcmNoID0gPDQwPjsNCj4gKwkJICAgIGhiYWNr
LXBvcmNoID0gPDg4PjsNCj4gKwkJICAgIGhzeW5jLWxlbiA9IDwxMjg+Ow0KPiArDQo+ICsJCSAg
ICB2YmFjay1wb3JjaCA9IDwzMz47DQo+ICsJCSAgICB2ZnJvbnQtcG9yY2ggPSA8MTA+Ow0KPiAr
CQkgICAgdnN5bmMtbGVuID0gPDI+Ow0KPiArCSAgICB9Ow0KPiArCX07DQo+ICsNCj4gIAlyZWdf
MXA1djogMXA1diB7DQo+ICAJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gIAkJ
cmVndWxhdG9yLW5hbWUgPSAiMVA1ViI7DQo+IEBAIC0xMjMsNiArMTU3LDM1IEBADQo+ICAJc3Rh
dHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gDQo+ICsmZHUgew0KPiArCXN0YXR1cyA9ICJva2F5IjsN
Cj4gKw0KPiArCXBvcnRzIHsNCj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCSNzaXpl
LWNlbGxzID0gPDA+Ow0KPiArDQo+ICsJCXBvcnRAMCB7DQo+ICsJCQlyZWcgPSA8MD47DQo+ICsJ
CQlkdV9vdXRfcmdiOiBlbmRwb2ludCB7DQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArCQlwb3J0QDEg
ew0KPiArCQkJcmVnID0gPDE+Ow0KPiArCQkJZHVfb3V0X2x2ZHMwOiBlbmRwb2ludCB7DQo+ICsJ
CQkgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZwYW5lbF9pbj47DQo+ICsJCQl9Ow0KPiArCQl9
Ow0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsmZ3BpbzIgew0KPiArCXRvdWNoLWludGVycnVwdCB7
DQo+ICsJCWdwaW8taG9nOw0KPiArCQlncGlvcyA9IDwxMiBHUElPX0FDVElWRV9MT1c+Ow0KPiAr
CQlpbnB1dDsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KPiAgJmhzdXNiIHsNCj4gIAlzdGF0dXMgPSAi
b2theSI7DQo+ICAJcGluY3RybC0wID0gPCZ1c2IwX3BpbnM+Ow0KPiBAQCAtMTUwLDYgKzIxMywx
MyBAQA0KPiAgCQlWRERJTy1zdXBwbHkgPSA8JnJlZ18zcDN2PjsNCj4gIAkJVkRERC1zdXBwbHkg
PSA8JnJlZ18xcDV2PjsNCj4gIAl9Ow0KPiArDQo+ICsJdG91Y2g6IHRvdWNocGFuZWxAMzggew0K
PiArCQljb21wYXRpYmxlID0gImVkdCxlZHQtZnQ1NDA2IjsNCj4gKwkJcmVnID0gPDB4Mzg+Ow0K
PiArCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMj47DQo+ICsJCWludGVycnVwdHMgPSA8MTIg
SVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gKwl9Ow0KPiAgfTsNCj4gDQo+ICAmcGNpMCB7DQo+
IEBAIC0xODMsNiArMjUzLDExIEBADQo+ICAJCWZ1bmN0aW9uID0gImkyYzIiOw0KPiAgCX07DQo+
IA0KPiArCXB3bTNfcGluczogcHdtMyB7DQo+ICsJCWdyb3VwcyA9ICJwd20zIjsNCj4gKwkJZnVu
Y3Rpb24gPSAicHdtMyI7DQo+ICsJfTsNCj4gKw0KPiAgCXNjaWYwX3BpbnM6IHNjaWYwIHsNCj4g
IAkJZ3JvdXBzID0gInNjaWYwX2RhdGFfZCI7DQo+ICAJCWZ1bmN0aW9uID0gInNjaWYwIjsNCj4g
QEAgLTIxNSw2ICsyOTAsMTIgQEANCj4gIAl9Ow0KPiAgfTsNCj4gDQo+ICsmcHdtMyB7DQo+ICsJ
cGluY3RybC0wID0gPCZwd20zX3BpbnM+Ow0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7
DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiAgJnJjYXJfc291bmQgew0KPiAg
CXBpbmN0cmwtMCA9IDwmc291bmRfcGlucz47DQo+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0
IjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2l3ZzIwZC1xNy1kYmNtLWNhLmR0
c2kgYi9hcmNoL2FybS9ib290L2R0cy9pd2cyMGQtcTctZGJjbS1jYS5kdHNpDQo+IGluZGV4IGU2
NDMwNjQuLmVjNGMyOWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2l3ZzIwZC1x
Ny1kYmNtLWNhLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaXdnMjBkLXE3LWRiY20t
Y2EuZHRzaQ0KPiBAQCAtNDIsNyArNDIsNiBAQA0KPiAgJmR1IHsNCj4gIAlwaW5jdHJsLTAgPSA8
JmR1X3BpbnM+Ow0KPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IC0Jc3RhdHVzID0g
Im9rYXkiOw0KPiANCj4gIAlwb3J0cyB7DQo+ICAJCXBvcnRAMCB7DQo+IC0tDQo+IDIuNy40DQoN
Cg==

--buaWmzpFLTbEN337jLyz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4664): https://lists.cip-project.org/g/cip-dev/message=
/4664
Mute This Topic: https://lists.cip-project.org/mt/74623758/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--buaWmzpFLTbEN337jLyz--
