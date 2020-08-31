Return-Path: <SRS0=xvg/=CJ=lists.cip-project.org=bounce+64572+5342+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1418C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 22:49:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B03820E65
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 22:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LdFl1rDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B03820E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5342+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YVp2YY4521723x01sgbfYuhT; Mon, 31 Aug 2020 15:49:54 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.534.1598914191626455437
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 15:49:53 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 07VMnnbK009374; Tue, 1 Sep 2020 07:49:49 +0900
X-Iguazu-Qid: 2wGrCcip2uAOQd2d17
X-Iguazu-QSIG: v=2; s=0; t=1598914189; q=2wGrCcip2uAOQd2d17; m=INe05sl+31TpPyYv0e8bOl/uqLzNffLTskR9pETKejE=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 07VMnmpn010801;
	Tue, 1 Sep 2020 07:49:48 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 07VMnlDm002949;
	Tue, 1 Sep 2020 07:49:47 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 07VMnl8H006455;
	Tue, 1 Sep 2020 07:49:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haoCK2AqIyMhNEcHoh99eKaFUSWWZkas0Fbx4jBriBN1ECWjXC8+/kaq7tqsmKZlMfDU5uKiqmuTrie+tdGq1P7p9urIK3YZc1Ojuh+hShLJowBp9IG/DCgvVx3vO2LqZ0fknJCTYsJfrW/Dh68P1NxcFZJCMGF/7D/GHFIYNGgPwnCMD6kAGQWKe+BnV6qlCaxR0l0b+PeZ8ygnbn6JP+U+T+IRDFROYzXROTmFFJQBeIfYoMNLQlR5orcJCM9YqdB1ykBYjDVvxzV4S+itgTOiPviVqAjtskALWwTm52P+nBupQ2HPuFoHQd9cllz6kNzwC7ZLDA3e+Qo4Jd9MyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZt6FHi2MPKz65K9te6uHiIz8/WUI0tD+70pVpvpuOs=;
 b=UAaiZAv/wM97xuoltBq94wqO020blgIr+ENIRzEvmS3YXeqER9opQ8N72FOvGUrqtsNKcH9ueOc85OZ5WOkeWrVCVTnX3WQPlJVBc9tY3mJaLjGbPl6jvez7OkTHW8tUqBteqeFXUGdVYRXf/L6QzyqdninLDDFbaNOJ/6QRS02xrm+bC6XqsrBQdbayA9JE61ahDfQzWKXVgEoUj7UwXnkcRjtdRJVvZNbx+y3HyCqtby2vAApyJqsxB1DqkV632mn+HkaIOe84uwBcQdoMpILCxLX2r9PEUa1vXOG0bOcpC+Dhm7ss+BMOq7YDeHSj0BtAtsam2z5hzFZ4eY2qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] hihope-rzg2m: Align kas filename with machine name
Thread-Topic: [isar-cip-core][PATCH 1/3] hihope-rzg2m: Align kas filename with
 machine name
Thread-Index: AQHWf3gq0bryUWM+SUSfsW4CmtBJJ6lS0kkQ
Date: Mon, 31 Aug 2020 22:49:45 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983C801A1741BAC9555164992510@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <cover.1598865682.git.jan.kiszka@siemens.com>
 <9be5523d6a3ef4bdd3a01b3b8c834b9a4d140a64.1598865682.git.jan.kiszka@siemens.com>
In-Reply-To: <9be5523d6a3ef4bdd3a01b3b8c834b9a4d140a64.1598865682.git.jan.kiszka@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cc78ad8-7dd0-4e75-56fe-08d84e002893
x-ms-traffictypediagnostic: OSYPR01MB5381:
x-microsoft-antispam-prvs: <OSYPR01MB53812701A10EA41EA9D174DA92510@OSYPR01MB5381.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LjGThPoaA9yhlvxpDYJqRpX3nnMU2a+ujEKSJMaPBh9K2DbKIPXJDLTpw348Rj0vcJav67sbqoIN2Mr84vnwaYK+M0SlDfRkcwiA/SpPbHU++qPIa7WhGPz3+riQEIOy99R8sQaOrePhRpeRMc8TbHjzbv6KDpyJ4uvAKN1r8Wpsez7wD1aKUheLqsgSMUohPC7QTnt9FHok60+kshxe1dCXrGin+/fns6ntK9ulq5Uu5PcDrWlU0hf6huCv4eWdkG/J9H7Er4S7PKMzAvfYxZi1UuPRA6V6V5tTgsJZoAfMOcHWlxiqk+S8CUDglWrz
x-ms-exchange-antispam-messagedata: Q7iV9QyTKKsXRpXVio6II4oHpdEJYDhimHmWloZIVi/mus6UdmXf/pln+XHSAISXpc/l2ld/wBnnCiXk49GXl40m1Gi4jHMrE+Apt0ZRMs2tB2ipo2nQF5XZfSORsEVy1h+JXW41oxlxZP/48eSZd3I0O+MhFnXQuRkkCHwaxf3aZXUNWhxHJbZ4bJ9+bUu+7Cxf2H8+q2Ithh46eJ6SoQ7Os5Qm/BUUpFJMqbinWFpgOs33lk7szURLpVRlzIartQ8C4J4mn3gGbYO7sx9T98ykXP8qHpEGUCK/Pn/096LVNmDCADB71lZh+JjJCCW5zaVELHfHxGGWy2sT5oZb3OAYnqw9KpXkEv03wTtKKsf7D/PVEUjC33XWoUJhMkLOshpGsxjsHwrvCgmi1LN2Vs4kFzSiu/gvQVT+HsbngJoPoVpthc9HRFT5faRQHGyEEtE8aQhxrAicAIIfveh17qKbNY8g8rSFv3Kpjc1jdU2frPvRTRHVvQpDcGNOnL917b0hSguuCwIh1GNO8ELJBY68KtZFe3pTuUf6hNt43uHohRY5+w+Jb1ovOYTV9bzaLgCLEqpqPW+KqG57+P09AcYz9vPiqkDb0QPfcxyV7cG8gAierUHL98uCLetjxFCh2lkEvmmrUsmxGSM5MBpkqA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc78ad8-7dd0-4e75-56fe-08d84e002893
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 22:49:45.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9wjoHH2Va87fpKyhyZx6GvYuQex+08ya9muIEhp2kuN7o/mhxeUwp5lxFfXJGjSd3l2zZBT/lGT6qrjKDDn00mOkwYU3Zmf0N8ONjl4DJRZ6muODbFfiSS3hYWfCTuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5381
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hOO9GJJRDdeEgTaS49IE9HiJx4520388AA=
Content-Type: multipart/mixed; boundary="5TI3zilpAdsJrxb9dHCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598914194;
 bh=csOoo5FAI3AA08sGJ6WMj1ZQkbJfgNxbA2qa3MtftnE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LdFl1rDweHvVNT53H5BR1IqKyZNpSFduy6rzm6U7VFidTLkCi3zkYuzBvOUzxVQ359b
 MYpikOoe5W+zitL2M8Fh+W5FanMktLzfdAxJinEWqKXWyw94W2/maHREJPXb5SF54eAIp
 7FDQF/UoO3O8wXlVi4io4TjP7xa6RBGMGYY=

--5TI3zilpAdsJrxb9dHCE
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCg0KVGhhbmtzIGZvciBmaXggdGhpcyBpc3N1ZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIFttYWlsdG86amFuLmtpc3prYUBzaWVtZW5z
LmNvbV0NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMzEsIDIwMjAgNjoyMSBQTQ0KPiBUbzogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IGl3YW1hdHN1IG5vYnVoaXJvKOWyqead
viDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRv
c2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAxLzNdIGhpaG9w
ZS1yemcybTogQWxpZ24ga2FzIGZpbGVuYW1lIHdpdGggbWFjaGluZSBuYW1lDQo+IA0KPiBGcm9t
OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gVGhpcyBhbGxvd3Mg
Zm9yIGZpeGluZyB0aGUgZXh0ZW5kcy1iYXNlZCBDSSBidWlsZC4NCj4gDQo+IEZpeGVzOiAzNTEw
ZjhhNjZmODAgKCJjaTogUmV3cml0ZSB1c2luZyBleHRlbmRzIikNCj4gU2lnbmVkLW9mZi1ieTog
SmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE5vYnVo
aXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLQ0KPiAgLmdpdGxhYi1jaS55bWwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCA0ICsrLS0NCj4gIGthcy9ib2FyZC97cnpnMm0ueW1sID0+IGhp
aG9wZS1yemcybS55bWx9IHwgMA0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ICByZW5hbWUga2FzL2JvYXJkL3tyemcybS55bWwgPT4gaGlob3Bl
LXJ6ZzJtLnltbH0gKDEwMCUpDQo+IA0KPiBkaWZmIC0tZ2l0IGEvLmdpdGxhYi1jaS55bWwgYi8u
Z2l0bGFiLWNpLnltbA0KPiBpbmRleCBhZjkwMGRlLi5jZDI1NDM3IDEwMDY0NA0KPiAtLS0gYS8u
Z2l0bGFiLWNpLnltbA0KPiArKysgYi8uZ2l0bGFiLWNpLnltbA0KPiBAQCAtNTcsNyArNTcsNyBA
QCBidWlsZDpoaWhvcGUtcnpnMm0tYmFzZToNCj4gICAgZXh0ZW5kczoNCj4gICAgICAtIC5idWls
ZF9iYXNlDQo+ICAgIHZhcmlhYmxlczoNCj4gLSAgICB0YXJnZXQ6IHJ6ZzJtDQo+ICsgICAgdGFy
Z2V0OiBoaWhvcGUtcnpnMm0NCj4gICAgICBkdGI6IHJlbmVzYXMvcjhhNzc0YTEtaGlob3BlLXJ6
ZzJtLWV4LmR0Yg0KPiANCj4gIGJ1aWxkOnFlbXUtYW1kNjQtYmFzZToNCj4gQEAgLTk3LDYgKzk3
LDYgQEAgYnVpbGQ6aGlob3BlLXJ6ZzJtLXRlc3Q6DQo+ICAgIGV4dGVuZHM6DQo+ICAgICAgLSAu
YnVpbGRfYmFzZQ0KPiAgICB2YXJpYWJsZXM6DQo+IC0gICAgdGFyZ2V0OiByemcybQ0KPiArICAg
IHRhcmdldDogaGlob3BlLXJ6ZzJtDQo+ICAgICAgZXh0ZW50aW9uOiB0ZXN0DQo+ICAgICAgZHRi
OiByZW5lc2FzL3I4YTc3NGExLWhpaG9wZS1yemcybS1leC5kdGINCj4gZGlmZiAtLWdpdCBhL2th
cy9ib2FyZC9yemcybS55bWwgYi9rYXMvYm9hcmQvaGlob3BlLXJ6ZzJtLnltbA0KPiBzaW1pbGFy
aXR5IGluZGV4IDEwMCUNCj4gcmVuYW1lIGZyb20ga2FzL2JvYXJkL3J6ZzJtLnltbA0KPiByZW5h
bWUgdG8ga2FzL2JvYXJkL2hpaG9wZS1yemcybS55bWwNCj4gLS0NCj4gMi4yNi4yDQoNCg==

--5TI3zilpAdsJrxb9dHCE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5342): https://lists.cip-project.org/g/cip-dev/message=
/5342
Mute This Topic: https://lists.cip-project.org/mt/76530565/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5TI3zilpAdsJrxb9dHCE--
