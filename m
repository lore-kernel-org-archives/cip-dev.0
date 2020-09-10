Return-Path: <SRS0=jSOx=CT=lists.cip-project.org=bounce+64572+5440+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB382C43461
	for <cip-dev@archiver.kernel.org>; Thu, 10 Sep 2020 07:08:18 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E021520855
	for <cip-dev@archiver.kernel.org>; Thu, 10 Sep 2020 07:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bB0AiM/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E021520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5440+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q6JaYY4521723xyAB2Ku4Z30; Thu, 10 Sep 2020 00:08:17 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.16357.1599721694820685127
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Sep 2020 00:08:16 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 08A78CiR010171; Thu, 10 Sep 2020 16:08:13 +0900
X-Iguazu-Qid: 34tIYF04NXhy42jJ4H
X-Iguazu-QSIG: v=2; s=0; t=1599721692; q=34tIYF04NXhy42jJ4H; m=AyrakINrwfUmiFrezOfl+zLGBxXufYyfcBbuVCaMbA8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 08A78C8c031307;
	Thu, 10 Sep 2020 16:08:12 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08A78BYb007895
	for <cip-dev@lists.cip-project.org>; Thu, 10 Sep 2020 16:08:11 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08A78BkL012752
	for <cip-dev@lists.cip-project.org>; Thu, 10 Sep 2020 16:08:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5RnMlOG74fF/4RH9q/IF909uPb3fDWr6jxnKZ7NGE+l7EvtDB89mEOWnrTX2t7v8sM27wooaZpEix7lhuBmUQw7LiTBH54riufhaT86VKx6sNIQrKgkFeXJ00mnUNpGd34XR3q4fKOXRpiHrk1GZ56SutWty90CPEoS7s+/7QgzqSI0Xpl6J8lyX22wPDl38Q82s4P5h8zkGjzlFMCbsQkhq/kIeenkVxs5jA1muKz5YmlefP4AD1A2kEysqBqRLORBFYs4gMcnKyrfNBIlvz301DmCl9YfNEdE8axBhU0NuwPVEclIylz6ifeXJeB43SpRz+VM1mlY7OfKwMsq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E91ooSglE/qKqMC219+tkfhf6LbiiEijmSiDJrqFoHw=;
 b=e+cnFBRZi6Exm3caOVCKaiamn4lWXnYsEUe5yyQJGTZLSU7NoDuyHVjULcLNE7Io+Ug6N0+HyFtZgg9C/Ut+731AfySrA3WqZWOnWL3KaFf2YsCIBcNZeP5wajLIML93o8pG3EKURNbOgn98DLz5eBl0jEi2PgAeshcr7mbWeNzwx8/xxGm+LDEhXTtVdjfOf8MUyDHxf8BxSBG3wj0KN2RmNvjCU089PAIKhoZx/y4WeM3Pz3eRJI/7aiIqmMtS+1RVm5t+xFmy9kShIut6FfQ+AxpR9mQxkGYwEwaJ90WPXy1K8l0yo4L7StwffunUSt7uY4qP4urzFvyhFFhn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdaHCJZTskm2rTDGTwOhy1OSZnZU2QAOAVTw
Date: Thu, 10 Sep 2020 07:08:08 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983A33747F78F5E6611AA0792270@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497270686C7A7E2C068315AEA0270@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497270686C7A7E2C068315AEA0270@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f7de7f-579f-4d02-fea5-08d8555845c8
x-ms-traffictypediagnostic: OSBPR01MB3144:
x-microsoft-antispam-prvs: <OSBPR01MB3144E319A10E203EBCAED45392270@OSBPR01MB3144.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EUx33/woxIPC/fdZT7T/Vp1IXzf3RuPPe/65+BXBTcWrCXMg1Gm1P54CI4c+7DD8EkjgyHdgpMUqosbxH5Q8ohI9WfLPJ9dHrQ7IxG0ewX8aITDmyySdtOdyZ5wMGpiSohumh29nCunuBuZaVu6ThpHxpzuagaSHj07g8Mida1/rS9biaFChe/1KDa3UoLWb9QeTfBo4+5admMyTdE2LKr7IzmmCGfyoM6ik2uwfgPr1lqcTIJyoQslez73qi0eF3PMED+z5eWU1zC2CnBr/Q1ou68QAXrkcW9jlzQ4l3P454yG9AYe2jSQPnQK5dAb7sP0jyn2JsPCdRfM7+PMu7R6DnOlC5KcDWrb7enz20YScBXT3JJplQk6jsIINxA48v416b9ZblqZWnd/+mHa8dg==
x-ms-exchange-antispam-messagedata: X4I1qd6dvqXljVcWdAI7u3fBJUgPW01BSF5t/iuXpA5mHQ2z/dcJ1+6yudsGe4iNeNMd90LBwpVRgXKVv+nPe0yLvVstMts+pwj5GHA1KN0tP2kRT4OBkpc4TXiJElZ7mmfRWBKSRXsHjeTALzaaGr3WFCi7viB82rbchk3aZ+Eu9Xa0boygvCIBqiMpgopv/h7NAKV027d4rLTnS1XPWSTqp11rKPm/aNEyQKiTSJ3y975Z59raPTl9y6pj6vzf/zc7viqFpizVoHoJYJtk6LDBw8vB2dSgyP12nVQBJuM8sPAHLNiddJhMKA5Wi+fm300jFWrSu6RfC6xNvdOovDz3EHpBGiqfzTEFRn8ZOXTYTDJ6x4TTWB+KU1jVujz3m7/bcISW6SVD1p3quxJAXc7HIq6tJUxDfbN06OVhx6Nub2XAa/hTrOFPAFA+qTrlh2wQdiC20gmNm6Juj3/baUvP6123pFGYBgwdVsTNsKM73a8+G8Fk6tjvQB3IlKIvlcaWpSrMwAJG1u9Nojr8MDS9JfogVkJHCqGN8nirQtzZBc+Nm2ygyDJwx/2o9/9zbZRnpKy9BMns0/NTacthFq4DX+LypaE60/qgI+K6HjjabPi49ram+JwyiWUEoAmRUWxhGiId5VZhQnquBfgKGw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f7de7f-579f-4d02-fea5-08d8555845c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 07:08:08.8618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwieOsBlBUZwXXr/HwiskvhktHMAgy8OWJbYh9IWeuYcSqPmb0TKgl06jlhfqfMXt+n1k1hRo3Pl0R2FGxDHVjZC6jEquQoVqqFWSpKMP7L1WpdnLMhBqJgZJ/qcK9m9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3144
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BUzvUK4Zib62JTqIOZhH6I4dx4520388AA=
Content-Type: multipart/mixed; boundary="5cdxYVWlQsqt8es7SxsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599721697;
 bh=zITUN54PSEqNdiKK89ZALjppgOiqavc3KaMxwvjYmDE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bB0AiM/Bk0MBgmDqh33oMFDzddeFmytPI4W0ZZHP4xbRLDj4OY9RsWBgxw/yYrssLNn
 IrN9HxFyUrYTXzxs47AjBI5Gg0KaI3Km6cgnNCTGZ9JJuNDMqsyJZwwiwIiebjPd3r8l5
 TJLZXjmRa+kiIQSE/coMG/j/OMLxaUc4DOI=

--5cdxYVWlQsqt8es7SxsF
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGnjgIBLdWRvLXNhbiwNCg0KU29ycnksIEkgY2FuIG5vdCBqb2luIElSQyBtZWV0aW5nIHRvZGF5
Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmddIE9u
IEJlaGFsZiBPZg0KPiBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcA0KPiBTZW50OiBUaHVy
c2RheSwgU2VwdGVtYmVyIDEwLCAyMDIwIDk6MjMgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5n
IHRvZGF5DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5k
IHRoZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzIHRlY2huaWNhbCB0b3Bp
Y3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5Lg0KPiANCj4gKlBsZWFzZSBub3RlIHRoYXQgdGhlIElS
QyBtZWV0aW5nIHdhcyByZXNjaGVkdWxlZCB0byBVVEMgKEdNVCkgMDk6MDAgc3RhcnRpbmcgZnJv
bSB0aGUgZmlyc3Qgd2VlayBvZiBBcHIuIGFjY29yZGluZw0KPiB0byBUU0MgbWVldGluZyoNCj4g
aHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRt
bD95ZWFyPTIwMjAmbW9udGg9OSZkYXk9MTAmaG91cj05Jm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0N
Cj4gMTc5JnAzPTEzNiZwND0zNyZwNT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QJVVNFYXN0CVVL
CURFCVRXCUpQDQo+IDAyOjAwCTA1OjAwCTEwOjAwCTExOjAwCTE3OjAwCTE4OjAwDQo+IA0KPiBD
aGFubmVsOg0KPiAqIGlyYzpjaGF0LmZyZWVub2RlLm5ldDo2NjY3L2NpcA0KPiANCj4gTGFzdCBt
ZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjbG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3Mv
Y2lwLzIwMjAvMDkvY2lwLjIwMjAtMDktMDMtMDkuMDAubG9nLmh0bWwNCj4gDQo+IEFnZW5kYToN
Cj4gDQo+ICogQWN0aW9uIGl0ZW0NCj4gICAxLiBDb21iaW5lIHJvb3QgZmlsZXN5c3RlbSB3aXRo
IGtzZWxmdGVzdCBiaW5hcnkgLSBpd2FtYXRzdQ0KDQpObyB1cGRhdGUuDQoNCj4gICAyLiBQb3N0
IExUUCByZXN1bHRzIHRvIEtlcm5lbENJIC0gcGF0ZXJzb25jDQo+IA0KPiAqIEtlcm5lbCBtYWlu
dGVuYW5jZSB1cGRhdGVzDQoNCkkgcmV2aWV3ZWQgYW5kIHB1c2hlZCBwYXRjaGVzIGluIGNpcC1k
ZXYuDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIFNvZnR3YXJlIHVwZGF0ZQ0KPiAqIENJUCBT
ZWN1cml0eQ0KPiAqIEFPQg0KPiANCj4gVGhlIG1lZXRpbmcgd2lsbCB0YWtlIDMwIG1pbiwgYWx0
aG91Z2ggaXQgY2FuIGJlIGV4dGVuZGVkIHRvIGFuIGhvdXIgaWYgaXQgbWFrZXMgc2Vuc2UgYW5k
IHRob3NlIGludm9sdmVkIGluIHRoZSB0b3BpY3MNCj4gY2FuIHN0YXkuIE90aGVyd2lzZSwgdGhl
IHRvcGljIHdpbGwgYmUgdGFrZW4gb2ZmbGluZSBvciBpbiB0aGUgbmV4dCBtZWV0aW5nLg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg==

--5cdxYVWlQsqt8es7SxsF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5440): https://lists.cip-project.org/g/cip-dev/message=
/5440
Mute This Topic: https://lists.cip-project.org/mt/76745849/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5cdxYVWlQsqt8es7SxsF--
