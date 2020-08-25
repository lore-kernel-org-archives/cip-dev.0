Return-Path: <SRS0=T2xX=CD=lists.cip-project.org=bounce+64572+5238+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA3C433E1
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 05:33:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4B7204FD
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 05:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="e1MKld48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4B7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5238+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nXs7YY4521723x5ejxTgnnh3; Mon, 24 Aug 2020 22:33:28 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.7756.1598333605766245422
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2020 22:33:27 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 07P5XNTk017027; Tue, 25 Aug 2020 14:33:23 +0900
X-Iguazu-Qid: 2wGrGhpI0VFOIupZHk
X-Iguazu-QSIG: v=2; s=0; t=1598333603; q=2wGrGhpI0VFOIupZHk; m=7Wbdk9NM1PWJGuSqSippq8GxVi+S/wsSKsKLIxTNZt8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 07P5XMhR003440;
	Tue, 25 Aug 2020 14:33:23 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07P5XMPl008763;
	Tue, 25 Aug 2020 14:33:22 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07P5XM8J018665;
	Tue, 25 Aug 2020 14:33:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAUehN5CKq501+YvTym70/OUQEAtnE8C8nglitK8eZM6rS72NtCe4VoPmIakepBKe/uqtq229x/dXBmAcMbm5s67PgIlwUy8YTkUSpBiaq1XFuEKcFhC7JdyLX+z10QvnmoAjbN/UPbD2sjciLOLK5HXnfRdBR7JohgI/4LTDFAduTafCuBBd2VkqGur1zOwCRpLwuUULD+W7qTqUWbFT+Dl74fd2SybFn4lTm4g5ZrU84BLoT9B8ovrzrvLe4viuBJEE1Fr9hZWzavxxsPvD2y+iCDJ3E4NBOvS0qDMiPDPl3iKST5xYemhxapWuAA2rf0qcenh32gYtdpZ7WxPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcPHbyFzAw5Ect0IrY/zYFvOyDSRh+D8OXgui4DB72k=;
 b=ApT16lQJhhg/FjCqDFL47NPO52/5ozgnWNbY3wUrQSuQFh2jND3mGifw4wxfQsvoZ/CLpaKs4ks9Y6Q+MVNlLVYsdfRV8PoDIjafLk4cZLPoSGFk/CAqXJsBmfa52qwGEtQFs9fQWPTjdoqZhONn0cxZJB7AZpIcYbNojBvtOtXBCGZ/9pLniTaMUbzb7MqBnlH+Ly999522iLnoBQBYdNa0lIe7iI4O3uoCOF+7ndljueWoLRS2/z1+JBsx7ql7B5ne1D1x9SoGdC2aTIT7rKDmxbsITmuHnAeERZbrQw/v7euMOtjdWjH2Ql3ZokpU9bOvypqg8MSTdpNgCHCHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
Thread-Topic: [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
Thread-Index: AQHWdstrqupfwJHHTUq10neeZGUu7qlCq0mAgAAb2ICAA5IEMA==
Date: Tue, 25 Aug 2020 05:33:20 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983B674E98AC8D3B5B960E092570@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <4f1fd7b8-4fc0-714b-8205-e6a6b93929d8@siemens.com>
 <997dba20-23b6-a170-6a89-b6a894b13e69@siemens.com>
In-Reply-To: <997dba20-23b6-a170-6a89-b6a894b13e69@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f996101-8ce6-4f4a-48fe-08d848b86083
x-ms-traffictypediagnostic: OSAPR01MB3332:
x-microsoft-antispam-prvs: <OSAPR01MB3332206742D61F7177C6A36F92570@OSAPR01MB3332.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jPzJWebY6wvfzxQDF7bk5cHlY0tKzP6TNMpcFk+BrRZdG/bDiM+Pe4Eyl5FSN0NVwPwDhb7gUiSdjdqra9BJnNZg5iS1GBdC93mBGHqL8KFJZDGPGokjhMUU/Xdknf3C+i6QXprmXhptipCsjDtZvzfwQq+4uPXG2nfaUyEMUPDMI1J8pan7euQFKoNKvzcJvHG/0Cibxhp+aNqYbXs8kcq6RZZAoQlvHfhb4UOXBd+WDucQnYnrAnSWwVTn3zmwCRK/sf3Vz8I/xB8OaYepFt8WEA9CT3RgfFd4sBtGBBV9pPXPKi/dLtCs+k4lSwlMXcmpwz7g6Cdigdx72I6fYpduEn1YvzE0J9WYxUXJATgqcdzvlUE2y9r/nqNkk0RkOkFE0KzATCJjOqdyo5uJeA==
x-ms-exchange-antispam-messagedata: nGHZ5BPM2NaVDMH7hj0M7U+DTxtyHlM01Z2tqt2RHysn2VOdeIz1Kuh7tJJTzH5zKge+K+S4rmUYr+oW6N9oyNkVlNnpSX+l4DZdavGGqvpcGyASKPyRv6p/rTBT9MM2+UXQreBKkrmSigzl+E30f4NY/hTmjGmgjJXy2T58/4j/1AWXtc5Ob2l9eZKdOgFX72oHGfTV3zLv6EUYUG3mrr8kycwHxzugb0E2MUtu4EoBytCOLPOdToIA4Dr0bDnjtLJiTmQfbeRxLoCxWv/GJ1uXiJRwoDvNIOmeIEdCGVrhE7Tqy1ofzgsqrLfIDxflg1MJqVH8by60NdF8GMKfI0HLqczN6Qytc1kNCBjLUk4zxbRd062Sng9eCo3mwexSGRiY6R8Uaz15sq++Q1LF3/v9bzSLtkiKWHM7CezpJMvk1EkdquEs7NrTjxKezxJWWJudZ8W5i2072R0Hsda6Xpgc/bqeUxiABhylh66eNNamecBj261G8aIxPY0U9DeKe/Y5y3Gn+SZUdgNeSuRIURFq5hPyOxfdzMpJtgg3SEIYtPHEaR/iQVjmyRBKM//XTQjvn3110LBQfUa9UaT/5+eb94EIrYOpF8irqYVM5Ks5DlrqqssfXb69+OAs9bHf+RieDZhoae1tTfod5pp4fw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f996101-8ce6-4f4a-48fe-08d848b86083
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 05:33:20.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYqoI4Xd6OzxRTqrjTAiVwebWY4l9siUY7gIfEJrYncVWgojVlwqiuvF4RwmGoOnW/zJe85TTlubu6a7vwLgTOB0qt/p2xwol3fC3RhbuaB6Oatsi8Tly1ZQ9Jo37EHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3332
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mtEr87mwQZn8FBi2Hg58aExZx4520388AA=
Content-Type: multipart/mixed; boundary="V1ICdlnM18iRPpWERw9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598333608;
 bh=t5rUkt1uySGA3RftVDpCltEHTxsYorSrm6eZrgU1L6Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=e1MKld484j+a6dYAwb2g1gZOG48WKvYG7+hESLKDeIGgF75/jiFSiWYX9rpMO1DtXFs
 6UyO2ePYhLgm4Jxve05vJBE8eZvfDpoxeu/NAtY1CMcj7gfJfn9iuJ21chu8MJFI04VOQ
 2dO5lzNq4ysGk+9NbxVymojH1YSBRll9NkI=

--V1ICdlnM18iRPpWERw9X
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSBb
bWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3Qg
MjIsIDIwMjAgMTo0NSBBTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDi
lqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5q
cD47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbaXNhci1j
aXAtY29yZV1bUEFUQ0ggMS8yXSBjaTogUmV3cml0ZSB1c2luZyBleHRlbmRzDQo+IA0KPiBPbiAy
MS4wOC4yMCAxNzowNCwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiBPbiAyMC4wOC4yMCAxMDoyNCwg
Tm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3
YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPj4gLS0tDQo+ID4+
ICAuZ2l0bGFiLWNpLnltbCAgICAgICAgICAgICB8IDcwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tDQo+ID4+ICBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaCB8ICA4ICsr
Ky0tDQo+ID4+ICAyIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9u
cygtKQ0KDQo8c25pcD4NCg0KPiA+PiAtaWYgWyAtbiAiJERUQiIgXTsgdGhlbg0KPiA+PiAraWYg
WyAiJERUQiIgIT0gIm5vbmUiIF07IHRoZW4NCj4gPj4gIAlhd3MgczMgY3AgLS1uby1wcm9ncmVz
cw0KPiBidWlsZC90bXAvd29yay9jaXAtY29yZS0qL2xpbnV4LWNpcCovKi9saW51eC1jaXAtKi9k
ZWJpYW4vbGludXgtaW1hZ2UtY2lwKi91c3IvbGliL2xpbnV4LWltYWdlLSovJERUQg0KPiBzMzov
L2Rvd25sb2FkLmNpcC1wcm9qZWN0Lm9yZy9jaXAtY29yZS8kVEFSR0VULw0KPiA+PiAgZmkNCj4g
Pj4NCj4gPg0KPiA+IFVuZm9ydHVuYXRlbHksIHRoaXMgc2NhbGUgb3V0IHRvIG11bHRpcGxlIGpv
YnMgc2VlbSB0byBjYXVzZSBkb3dubG9hZA0KPiA+IGlzc3Vlcywgc2VlIGUuZy4NCj4gPg0KPiA+
IC0gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUv
LS9qb2JzLzY5Nzg0NDI3Ng0KPiA+IC0gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2Np
cC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzY5Njk0NjY0OQ0KPiA+DQo+ID4gRmlyc3QgdGhv
dWdodCBpdCB3YXMgYSBzcG9yYWRpYyBoaWMtdXAsIGJ1dCBpdCByZW9jY3Vycywgbm93IHdpdGgN
Cj4gPiBtYXN0ZXIuIElzIGtlcm5lbC5vcmcgdGhyb3R0bGluZyB1cyBoZXJlPw0KPiA+DQoNClRo
aXMgbWF5IGJlIGEgYnVyZGVuIG9uIGtlcm5lbC5vcmcgYXMgc25hcHNob3QgcmVjb25zdHJ1Y3Rz
IHRoZSBpbWFnZQ0Kb24gdGhlIHNlcnZlciBzaWRlLiBJJ20gbm90IHN1cmUsIHdoZW4gZG93bmxv
YWRpbmcgaW1hZ2VzIGNvbnRpbnVvdXNseSwNCmFjY2VzcyBtYXkgYmUgY29udHJvbGxlZCBieSBr
ZXJuZWwub3JnLg0KDQo+IA0KPiBBbmQgSSdtIGFmcmFpZCB0aGVyZSBpcyBtb3JlIGJyb2tlbiwg
bmFtZWx5IGluIHRoZSBkZXBsb3ltZW50IHRoYXQgaXMNCj4gb25seSB0cmlnZ2VyZWQgb3ZlciBt
YXN0ZXIuIFBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgZmFpbGluZyBqb2JzLg0KDQpJIGRvbid0
IGhhdmUgbm8gaWRlYSBhYm91dCB0aGlzLg0KSWYgd2UgcmV0cnkgdGhlIHRlc3QsIGl0IGlzIHN1
Y2Nlc3NmdWwgYW5kIHRoZXJlIG1heSBiZSBvdGhlciBjYXVzZXMuDQoNCg0KPiANCj4gVGhhbmtz
LA0KPiBKYW4NCj4gDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLQ0KPiBTaWVt
ZW5zIEFHLCBDb3Jwb3JhdGUgVGVjaG5vbG9neSwgQ1QgUkRBIElPVCBTRVMtREUNCj4gQ29ycG9y
YXRlIENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

--V1ICdlnM18iRPpWERw9X
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5238): https://lists.cip-project.org/g/cip-dev/message=
/5238
Mute This Topic: https://lists.cip-project.org/mt/76304024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--V1ICdlnM18iRPpWERw9X--
