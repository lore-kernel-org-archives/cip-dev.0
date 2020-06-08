Return-Path: <SRS0=QgQz=7V=lists.cip-project.org=bounce+64572+4753+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF63C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 10:52:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269062072F
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 10:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NAPBNf6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269062072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4753+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ITZkYY4521723xFbIejrMWSm; Mon, 08 Jun 2020 03:52:01 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.54])
 by mx.groups.io with SMTP id smtpd.web12.27409.1591613520186118557
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 03:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqDXOJV92mLzcibnPndOpAeI+VDPL+0k8PD5Db+IMYdbo9qOB7wBqb0t7NYoaJlLiJMqKw1Co4GUmI6HUP1jnz9VCo1tprsHlGIttxBFjRylajTxSPKueAAVy5NV1iUvwhmHYlExTEzU4IsonPyMbeefjhW9fr4gikXKIlwjHf/YhRvNy6HuXic4QY5XxW0uTlVdGf5qEiogx10NlEY8f1ERVX9B9mWkSkwDn4ayjhzN1EuDnWme9SsVWz4qpkw1bcAc/XWSwgejajcCDKKpfEMRBqvsn7hJrbkkZ/lCsGRmW56RkMTTNC3XwCIU75/e1Jap2R8MzL3zKfyOT+46cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpBPJhiUk5xJ6Kf9b1pj6ssyVSrUl6Oou/Q9mVZC3yg=;
 b=TUMY3l/rx0QR0iO+FwCEm+2lZWdmfod5X8H9ht0alfmdmoCfN4lTeM8Zck6CKNM0u/qR7jslDIDJ7QQaIgrZXzpMg92iPw92n8uTanpgfYWie4AZ8//2x7rqPSldqRijBbGSrkxdrvqP8HsEi4xjpeNtZISu9jxMgXy10wvPkhbIS1E4rtQIj/883ftRd02q6WuU7rB0ldni9P+N9ugUMysacgeK06HXIXX2q8Km8HiWTTx8ryH97XAz6cKUtpm42ttoQbBpMPKQ7D2HmgqIxW/cgn3XtWluyxVnGukDGMBK0ksywaIEryGlAMtpIhUPeIVjJzfmQu3W+T0WHwrlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3219.apcprd01.prod.exchangelabs.com
 (2603:1096:202:26::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 10:51:56 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:51:56 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel
 Machek <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux address with macro defines
Thread-Topic: [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux
 address with macro defines
Thread-Index: AQHWPXz3m8Oq8l9Bi06Yy7524OP+n6jOiWKg
Date: Mon, 8 Jun 2020 10:51:56 +0000
Message-ID: 
 <HK2PR01MB32818C637F6FB1F0AE969A95FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
References: 
 <HK2PR01MB3281084A8DA1542518F65818FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
In-Reply-To: 
 <HK2PR01MB3281084A8DA1542518F65818FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec4e4390-8299-4e6c-f1b9-08d80b99f685
x-ms-traffictypediagnostic: HK2PR01MB3219:
x-microsoft-antispam-prvs: 
 <HK2PR01MB32196AE8C58EDA68A4635523FA850@HK2PR01MB3219.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Mpy9V2sJK1KiVaQeTeonmKOSlFyPBcQzsFVdY9vsg51E/gKKNNXsA7Ilvhq3OCdwyJpXMqu4UBLL4/a5eC4fmrK0WkkGVKSWyNTzde5Rj0cdbky3Ww3Fh49AYM6sKOZFAFyZKbJw0ue77qqCsIPLY/De2zD2RdFRkGswuEMlchUX2o2jH5Nsm0LDNaoXi76ynr8GEBA7foKPS6kURk6yKNvXhSBw8unO1kA8ufMtbtmrS8LUt27OPr1vyXBxntMpN/r+Fq1bD46Cek3klh1M9fb3Cf2rkr2TfmHk8O3CbG39/rj8nuw7K7GF8S/jpiStUu6dwK8E2/29mIkWbL8bBA==
x-ms-exchange-antispam-messagedata: 
 ycD9oolVTFSpNUcgbiCC/JphmgUu20iMl3JlbtJsx1z4Yg8iqs0DlZqTK9roLlgKu8nk+85Zli4BA3d/5ABpStj0QJwzq51LgF6GvlEZEMIJcZOeK3/l0koC4p94vFhsQoJkgahqh6P6qGGIloUQb7t4DimFo74RRE0ATVklRiaeQfVXM+aCaquYZJ8Cm8Nhd+XZok6e4kxfF07ItOszUqwdScCyBbJdH/S3HMVyZCYMakL2C2sVJFFfN4m+I+OydNnk9U1IazrJ2Qj7Gcjd7J3nt2NiVWI4zWxvCyEPf7hMF4FFHRc4Fej+YOJFfczfawiPdSthIWgomaqnfvTEExFGDy3LPXTkT6zvydqGFQ1TNFjCm4G99SgRPaCAXkyCFIy0u8gsN08jZUsTyy1TEB7R5y7Rd3gYEj8WHE1w6LWD9w7a0l+006GzWdsBM/ouIr79JxPEMlb1pRMK4ax+b6aLvn1vYkiEMq1+JM+67fE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4e4390-8299-4e6c-f1b9-08d80b99f685
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 10:51:56.5071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrRQfp+duSl4Csz7tMtMuuftbj8K8iW6DZiC/1LcDTNv9ewwwTirHRAqRRY9EJowXKcrCopSeMlEmMRe2H3tTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3219
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: i9UtLBoGyBHOlG6ixqrGjCxjx4520388AA=
Content-Type: multipart/mixed; boundary="VV5LMZy2wIzMlvR1c3RI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591613521;
 bh=zbI8DdWhHJY1WuiDnGlB209rkhsgf8D0wWFBBi/oQjY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NAPBNf6Qfa5scIs+yJ8XcXQMYKOHFRDsj9cPV211MBhi22zmgJCV9A3KMfnRfUWtGMy
 w2ldsn1vUWBkfh7b4CUYh8R8jX/DCm5S3iM5l/7/eE5WmahNXW8P6LHeO8g8zZnyus7Qi
 495/tRjQjyZjtINWxIYF75q2Fkn0ZCNltlM=

--VV5LMZy2wIzMlvR1c3RI
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IENocmlzdGluYSBRdWFzdCAoMik6DQo+ICAgQVJNOiBkdHM6IGFtMzN4eDog
QWRkZWQgbWFjcm9zIGZvciBudW1lcmljIHBpbm11eCBhZGRyZXNzZXMNCj4gICBBUk06IGR0czog
YW0zMzV4OiBtb3hhLXVjLTgxMDAtbWUtdDogUmVwbGFjZWQgcmVnaXN0ZXIgb2Zmc2V0cyB3aXRo
DQo+ICAgICBkZWZpbmVzDQo+DQo+IFRvbnkgTGluZGdyZW4gKDEpOg0KPiAgIEFSTTogZHRzOiBh
bTMzeHg6IEFkZGVkIEFNMzNYWF9QQURDT05GIG1hY3JvDQo+DQo+ICBhcmNoL2FybS9ib290L2R0
cy9hbTMzNXgtbW94YS11Yy04MTAwLW1lLXQuZHRzIHwgMTE2ICsrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcGluY3RybC9hbTMzeHguaCAgICAgICAgICAgfCAx
MzAgKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5j
dHJsL29tYXAuaCAgICAgICAgICAgICB8ICAgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE4OCBp
bnNlcnRpb25zKCspLCA1OSBkZWxldGlvbnMoLSkNCj4NClRoZXNlIHNob3VsZCBiZSB0aGUgZm9s
bG93aW5nOg0KDQpDaHJpc3RpbmEgUXVhc3QgKDMpOg0KICBBUk06IGR0czogYW0zM3h4OiBBZGRl
ZCBtYWNyb3MgZm9yIG51bWVyaWMgcGlubXV4IGFkZHJlc3Nlcw0KICBBUk06IGR0czogYW0zM3h4
OiBBZGRlZCBBTTMzWFhfUEFEQ09ORiBtYWNybw0KICBBUk06IGR0czogYW0zMzV4OiBtb3hhLXVj
LTgxMDAtbWUtdDogUmVwbGFjZWQgcmVnaXN0ZXIgb2Zmc2V0cyB3aXRoDQogICAgZGVmaW5lcw0K
DQogLi4uL2FybS9ib290L2R0cy9hbTMzNXgtbW94YS11Yy04MTAwLW1lLXQuZHRzIHwgMTE2ICsr
KysrKysrLS0tLS0tLS0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL3BpbmN0cmwvYW0zM3h4LmggICAg
ICAgICAgfCAxMzEgKysrKysrKysrKysrKysrKystDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5j
dHJsL29tYXAuaCAgICAgICAgICAgIHwgICAyICsNCiAzIGZpbGVzIGNoYW5nZWQsIDE5MCBpbnNl
cnRpb25zKCspLCA1OSBkZWxldGlvbnMoLSkNCg0KDQpCZXN0IHJlZ2FyZHMsDQpKb2huc29uDQoN
Cj4gLS0NCj4gMi4xMS4wDQo=

--VV5LMZy2wIzMlvR1c3RI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4753): https://lists.cip-project.org/g/cip-dev/message=
/4753
Mute This Topic: https://lists.cip-project.org/mt/74749053/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VV5LMZy2wIzMlvR1c3RI--
