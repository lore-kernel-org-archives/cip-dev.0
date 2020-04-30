X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.70])
 by mx.groups.io with SMTP id smtpd.web11.825.1588217608235827769
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Apr 2020 20:33:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@moxa.com header.s=selector1 header.b=HbtZCbLN;
 spf=pass (domain: moxa.com, ip: 40.107.131.70, mailfrom: johnsonch.chen@moxa.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1tNoXP66vGQ43L14VNZjBfLMab1JsIqKhzI3HeMh5qXgOAa7+leBqOyaUXHJLFIJzcOn7efN28T2dtWyzALhIBfONcJD0xaViJ8rfc6Lgegiuy/KJwwR+rOu5y7Wi++GR2jrsNmwda1J3J4I3cIDCtqjRSDPXUVcTpFxDf63WPnE6H60XrxKvwwq6r1tJK7OhD9ogC0Chpn+TJK9IeZOsz1b9ZPTcU+3Z5nTtuTEPri/6NURnOBxIN8txtQFWG1CJD16dJ4Z7j5PM39wD/K/qFfEZdfq+P3z6lRz7r64v+m7OoWoqcxjavmt5YdUlvn4aAAi+KygmgJFksXDVU54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxpWt8kcbWS+AYn6kj41FkFMEoOgZ/2r87npp92ST00=;
 b=lIn8/+kqERMgngCjiFFFl9RrbIr1ZFqbAOaEwNdzE6AFTeIGMVEw9cXVOr5JHVgrHRhasQa5A2WMmXqsE4V2XH8USzcbh3EwW2QKY01HHHVJGd/R1tfT4UZVjHZuzb1fTplLnFz/4Ywxft4RD5CJk0pfZBtEvHQTORwlASUbwMiBditKh1bauQ2bpWKtHUuktAxxvy9Pf8LFBpuA74LEdGj+lr8PcOuyHmV1wqy4Mjp5GP2jH7v9EXCK8wMw86bWZ+THy1Y0BNn6SDSq2wGQilORiBkP9zpkiXJknaa35n+k0+52zZ7FiOvodHqgtHqIzvNj5fmlytTORe3tcnul2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxpWt8kcbWS+AYn6kj41FkFMEoOgZ/2r87npp92ST00=;
 b=HbtZCbLNzkm9EfbbG7Smz0N9tOPtD1D8jGTjG1crfyUlxwVICNz7w3HgC0q2fHbLkrtztikfxC2rDMA/HDCK2PIYhpOaG/SuG8tggZC1uqry8Dhlb7voWRxhWiYIxFJnHAHGoMKnT84NpjzOyA0D4HTWJgqQLzPZYIIk+BHGiWI=
Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3313.apcprd01.prod.exchangelabs.com
 (2603:1096:202:19::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 03:33:25 +0000
Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::f0d1:8e7c:a9aa:46b1]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::f0d1:8e7c:a9aa:46b1%7]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 03:33:25 +0000
From: =?utf-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?=
	<JohnsonCH.Chen@moxa.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/3] Add TI CPUFreq/OPP hw-supported driver
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip 0/3] Add TI CPUFreq/OPP hw-supported
 driver
Thread-Index: AdYenvv3s7SU2aaJQLW/83AlIfO9iw==
Date: Thu, 30 Apr 2020 03:33:25 +0000
Message-ID: 
 <HK2PR01MB32811FA86BAC56B8CDA4B1B7FAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=moxa.com;
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0028a0ff-263d-41b2-199a-08d7ecb73d9f
x-ms-traffictypediagnostic: HK2PR01MB3313:
x-microsoft-antispam-prvs: 
 <HK2PR01MB3313B045C5945B6B864FAEC0FAAA0@HK2PR01MB3313.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iqwTrI2fWMqLYNuiiZ0ivuTNQO4ZTQrv0vtqGI3Gz0edAk6iVaCypDdjZyzbvHhHVn/Dxqct3H/ETMLDiSf8Rbc5sQXZSppVAdUvmFzWJ7f2JP6oN/4n3vWH6JGN5sVvuiCqc6UmHKtgqsp3Tc9Qf5ANA1PBdaDplerzsJoAkeQTiCmTmd27PXEkfRatuR/E5CtdDbL06dX9Ck8inZg+9FAhuNRwVASD1mS7nZ3N0j1o0E/07my6xgLYooPlHByFPBU8M5koijah1tRcH36uoqOfMvnTNHpsAACFdmgKDX+h8JJi5O44XiFxheyKsgKnokf8UUtM43Kgmqssgx11sK6BXAdgGbD/ES5nL7U+o+7tdB6vlfphzKVbzAbZDujASIjrHc08kLlDbdIA+fPWS26bE4ZW+MnczazrccI6Tw3Z/sTiC8TtGEPp1kC0yNQp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR01MB3281.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(366004)(396003)(136003)(346002)(376002)(2906002)(71200400001)(55016002)(5660300002)(86362001)(4744005)(110136005)(9686003)(52536014)(316002)(8936002)(64756008)(66946007)(66476007)(33656002)(8676002)(66556008)(478600001)(186003)(26005)(66446008)(76116006)(7696005)(85182001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 nh9jkSKVO2N3RqwKv50VjTTIrzrE2TsEl7lkpBcTQDBp/cfOYi9onMKAHNeESdKSSP2Ia6a45neCz/jCbBb80G6S0gTB2wd4XU01oQTOroRbghPqb2HoeMtJeFPG/EvNgNiR7VmWk6/6UcNEiULmi5OM38ea+HuEFstQCAVVrVNJfMDPuWdr+3uqfiGH5ZHwZbF/1ckouBHrZaylU8UgpkBSPQf9lYueLeXV0mPDScx2FLELHWNclnrKiGctV+E215hM4963U2p1QXx4NJYauz7MpQ7kSQ7qvI/fuR0eC7snuMqsyTkBm/i7YTnm8EfC5ypOwH7+piazWnzwoT9l3+AQ30vkcEyD3KgdPi8If7owENmfq91YpdgpB2TUZy8NvXvBH+cPxjw0+gHw2OucR2jNULCWHLCHd36FNhNeKgp6BoJS+RbA1ahehL3KlIKj0EInMZb/82RUUsiLIPS+OewSfkACNhOe2s9grotDRQi10jYsTWqtRu6MABiltqB/ULqhidU1cd5NwA7uP8Izw+Ni+2S9TkaDiT7+4XGErP/lcKQu322XnMkHn3U8yoEYwYUscclag1iree6iYRdTjKKoT+1WiEquR62aXiA8Ih/uVKQjb/DCBeGWDgCwPoDEN3c9i/hCwlwOMxHt9zvH7dwmObYwbtYXz0NVs+d6XFyjn5w3EoQ+BAcMLvje0OYIutq8nDFvvW7vM/dK0jg2siWrcUOQJInWNFzldRrSzlq4hkpl+D477Sh/W1Nyvg9ijej8zNl5URh85CCJZFwodw9ji+2CeFjiz8ZKD1oupDg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0028a0ff-263d-41b2-199a-08d7ecb73d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 03:33:25.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45uW0r0KtOF5lI6r6XSFaKyKgrl5qL9tpMxUk78z3IAgD5KXRIULeYu8eDbaqD/Kzl5u5KImt1hKYymnw0eX4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3313
Content-Language: zh-TW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

VGhlIHBhdGNoIHNlcmllcyBzdXBwb3J0IFRJIENQVUZyZXEvT1BQIGh3LXN1cHBvcnRlZCBkcml2
ZXIgdGhhdCBpcyByZXF1aXJlZCANCmZvciBjcHVmcmVxIHN1cHBvcnQgb24gQU0zMzV4LCBBTTQz
N3gsIERSQTd4LCBhbmQgQU01N3ggcGxhdGZvcm1zLiBCZXNpZGVzLA0Kb3BwLXN1cHBvcnRlZC1o
dyBhbGxvd3MgYSBwbGF0Zm9ybSB0byBlbmFibGUgT1BQcyBiYXNlZCBvbiB0aGUgdmVyc2lvbiBv
ZiB0aGUgDQpoYXJkd2FyZSB0aGV5IGFyZSB1c2VkIGZvci4gICAgIA0KDQpUZXN0ZWQgb24gTU9Y
QSBVQy04MTAwQS1NRSB0aGF0IHVzZXMgQU0zMzV4J3MgU29DIHdlIGhhdmUgaW4gaG91c2UuDQoN
CkRhdmUgR2VybGFjaCAoMSk6DQogIGNwdWZyZXE6IHRpOiBBZGQgY3B1ZnJlcSBkcml2ZXIgdG8g
ZGV0ZXJtaW5lIGF2YWlsYWJsZSBPUFBzIGF0IHJ1bnRpbWUNCg0KVmlyZXNoIEt1bWFyICgyKToN
CiAgUE0gLyBPUFA6IEFkZCAib3BwLXN1cHBvcnRlZC1odyIgYmluZGluZw0KICBQTSAvIE9QUDog
UGFyc2UgJ29wcC1zdXBwb3J0ZWQtaHcnIGJpbmRpbmcNCg0KIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9vcHAvb3BwLnR4dCB8ICA2NSArKysrKysNCiBkcml2ZXJzL2Jhc2UvcG93
ZXIvb3BwL2NvcmUuYyAgICAgICAgICAgICAgICAgfCAxNDkgKysrKysrKysrKysrKysNCiBkcml2
ZXJzL2Jhc2UvcG93ZXIvb3BwL29wcC5oICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KIGRyaXZl
cnMvY3B1ZnJlcS9LY29uZmlnLmFybSAgICAgICAgICAgICAgICAgICB8ICAxMSArKw0KIGRyaXZl
cnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVy
cy9jcHVmcmVxL3RpLWNwdWZyZXEuYyAgICAgICAgICAgICAgICAgIHwgMjcyICsrKysrKysrKysr
KysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9wbV9vcHAuaCAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDIwICsrDQogNyBmaWxlcyBjaGFuZ2VkLCA1MjQgaW5zZXJ0aW9ucygrKQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvdGktY3B1ZnJlcS5jDQoNCi0tIA0KMi4x
MS4wDQoNCg==

