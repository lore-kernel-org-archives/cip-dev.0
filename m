Return-Path: <SRS0=WDV7=EX=lists.cip-project.org=bounce+64572+5804+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA92C56202
	for <cip-dev@archiver.kernel.org>; Tue, 17 Nov 2020 11:39:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88C522240
	for <cip-dev@archiver.kernel.org>; Tue, 17 Nov 2020 11:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="t2Y2KTUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88C522240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5804+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5f2sYY4521723x367U59VG1l; Tue, 17 Nov 2020 03:39:10 -0800
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.48])
 by mx.groups.io with SMTP id smtpd.web09.6596.1605613149656649541
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2020 03:39:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp9pc11XFCKSQnelmgaE62UYM3t9zUAQ4lRcxw5EbsnsUHghnR7zKFyE1Vh4Sz8pfNdaO9k3YTbzdcGhcF23Xj5kHvjtCHKTT0uU8FC/FXFcJRdl8dVOz/rHWALjvU/eGjT/O79Com+6Wd4xlEaA22JWCvHkyg4IXLtPfydXVh6AM728t93hVouK3X61e1TCd+JyWX4vVY37E1tlM3IAuX59YWBTgOrkkSZgR6E5GrnIqWiBuY2SycVkcRlVwbcZ0A3kN6OTwuxDXmhvkacogUMi45vfu8JBab5zq12ulBDSlqPnYRQOnWCJf6DP76t+GSQmCW8FyyjRna9j8kZJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPCk+z4C8yA8MnsNLVmzbhWf9L9wSpraenNH2EqLPOk=;
 b=HmZPUfTt0QzHTc+ZNrrLjH6hCUtpn8enFl+kfUMKroZ3diLvU25O4cE5I/4Ndv8CfbgbXsqw8Ygps2cokeEMeRbxUaWK/7jVH0Xy/fQsohBRrEoeeSX5w4951sa/CLjiTXhS7p0nKMcycCG7HxX/qSDrbZS8N8Tst8udEpQQpTj1+NMq7K+izp7kvyfZROYTtCa39HDJ7RTbeR+JhDComlQrHDqr5dZ8aDENugxQwoEHJs2CjcV4dMpWAhGh3osuE3rHYjpXfZ77t7aBX4gdv8q7HEyFe67dfskyeHYiYTDI1im/9e9RvdWGhLlcS9RshLy2JmU1xd5k5+Ynk/GGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3c::12) by HK0PR01MB2561.apcprd01.prod.exchangelabs.com
 (2603:1096:203:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 11:39:04 +0000
X-Received: from HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::356c:79f8:86b0:6e42]) by HK0PR01MB2450.apcprd01.prod.exchangelabs.com
 ([fe80::356c:79f8:86b0:6e42%7]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 11:39:04 +0000
From: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Joining CIP from Codethink
Thread-Topic: [cip-dev] Joining CIP from Codethink
Thread-Index: AQHWvCBy42mkyHBgDEiMu9fhBArl2anMKFVg
Date: Tue, 17 Nov 2020 11:39:03 +0000
Message-ID: 
 <HK0PR01MB2450F2350CF15EA9ECC342FEE2E20@HK0PR01MB2450.apcprd01.prod.exchangelabs.com>
References: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
In-Reply-To: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.43.160.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a3c266a-53cc-4ff3-9975-08d88aed62c3
x-ms-traffictypediagnostic: HK0PR01MB2561:
x-microsoft-antispam-prvs: 
 <HK0PR01MB256149A4770EC6CFADD823CBE2E20@HK0PR01MB2561.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 emUmjyMRkLGQXhJqaJZI+aJV5T8A4uIuAvulukELcPX3/y/zPkXXRrmEgiJigceV9FAKv96V7jRw7B0hcU2WbbJbdJoy/9XMRxe9hdzFxXYPmiGmPmC7Pp37Vin1TAHVjaP+O36wmdc7nZutNz7aJK8hGHEwxosfTREriRUJZGYfw35PaB06tSrv7rssycBA6C9it1yGoGwGRCdu6MaEJwZ1vyWdqMNS2wa9LrFhNbXDucEiWzTdk6+cE+eX/o/W+UFSDhoBaJyQRmrRZNi4av8N1os5fcfmED4ZgbuXGit80E8XPG/FLJy76Ty/C1rs5ZNzJlXEzSn+ZrBQjavD7Y/TYUtyr/N6i3LwLbWObgMGAVaaOD4/tzY67a1WBEMJ
x-ms-exchange-antispam-messagedata: 
 KO4F9hu8S+dznHodYjc99qw1dZucqTLebG83goXNlHm6H6tqWJYsFxKZVVdiLzmI1+Vool0gBJo4burLfz7mf9pZ37xVip+WN8+3PY4vH/6vMP7ONcEzPwE8zZ/c09vSp+6KfBNDwRfuTa7p5ef2w7mZoCLALFIWKX+sxYf4JzVZfTSSeWGk6v/762FmrcqWF3sSriOT6/wdgygMMBf2zI1KpkbLM/nV0rl4YWlFkBfia5v2762skBrbXX1ZPvsZ9wNKtwpIF41anh9G4P8vrMleqnKt8ujYRxPxXHFsGuSWtFUToHPph7fBNFdWXMFQ5lBfo8UAIuHtVg1MHMYuS71tmjNc+r/wLKgx1q/7udboTPCZWgptnvUQwbxzIPddngE3YKvTkyF8FYXUF08KeOj+6mzFHuIFA1uPJn7x70J1YkJprHuohYyi+4PTjfDan4U0uquVo6ITqsL2Rx5TynWzp5uJABDqsGsTJFhuMCJIk6BGiApvag93CWL/Rx0vNk1vuKAsOVFYJgbRAc2skBNghoDORc1horXi5HV5PAfVAb/1MN3sYAdw9aBVeogF7la1VRsQ1ZZGKorsV1rXcAIwJKo+upsSJv79+zTeLQfsVqI6aUbezQfWlk7g8RdJBJqLQcr3gRMe52+DwoNbbQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2450.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3c266a-53cc-4ff3-9975-08d88aed62c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 11:39:03.8705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMgJYd5uYrnMDahvEaPADEF8O8SY1wvN+s8ce9H0uojTSu1C68Q67C2Vrm2Kzt6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2561
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rKb0Ywagowjuw2JwWb81nVBLx4520388AA=
Content-Type: multipart/mixed; boundary="lzSdZazYqXaA3BP6Vkm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605613150;
 bh=SjWfNtfSZat9LD7aV//hSIh6rjpR83yL2P2rhDxbtr0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=t2Y2KTUVjkkSqhraE7IWEbUp6Pd5UfJiOxaW1o5aqo72faMMo6/jUrjwSl9aAn71/Ai
 V3nykmWBujqqUGB9lH1Lpeg5H+d/lK13qkYGbbEcldib8LVvGbOGuyGuPdjAp3/lkkaTt
 d7cUSKB8E5ZuPv8kF4LOI21jy5TbnwD+bJI=

--lzSdZazYqXaA3BP6Vkm8
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgU3VkaXAsDQoNCldlbGNvbWUgYWJvYXJkIQ0KDQpTWg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mDQo+IFN1ZGlwIE11a2hlcmplZSB2
aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTYsIDIw
MjAgOTo1NyBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVj
dDogW2NpcC1kZXZdIEpvaW5pbmcgQ0lQIGZyb20gQ29kZXRoaW5rDQo+IA0KPiBIaSBBbGwsDQo+
IA0KPiBJIGFtIHN0YXJ0aW5nIHdpdGggQ0lQIGFuZCB3aWxsIGJlIHRyeWluZyB0byBkbyB3aGF0
IEJlbiB1c2VkIHRvIGRvLg0KPiBUaG91Z2ggbWFueSBvZiBteSBjb2xsZWFndWVzIGFuZCBleC1j
b2xsZWFndWVzIGhhdmUgd29ya2VkIHdpdGggQ0lQLCB0aGlzIHdpbGwNCj4gYmUgbXkgZmlyc3Qg
dGltZSBkaXJlY3RseSB3b3JraW5nIHdpdGggQ0lQIGFuZCBleGNpdGVkIHdpdGggdGhlIGNoYW5j
ZSB0bw0KPiBjb250cmlidXRlIHRvIHRoZSBzdXBlci1sb25nLXRlcm0gTGludXggS2VybmVsLg0K
PiANCj4gDQo+IA0KPiAtLQ0KPiBSZWdhcmRzDQo+IFN1ZGlwDQo=

--lzSdZazYqXaA3BP6Vkm8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5804): https://lists.cip-project.org/g/cip-dev/message=
/5804
Mute This Topic: https://lists.cip-project.org/mt/78291887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lzSdZazYqXaA3BP6Vkm8--
