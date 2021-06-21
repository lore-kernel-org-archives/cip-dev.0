Return-Path: <SRS0=zfEB=LP=lists.cip-project.org=bounce+64572+6545+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E47C48BE5
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038F56008E
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038F56008E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6545+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wIVEYY4521723xxq2tIq0Xj9; Mon, 21 Jun 2021 00:09:26 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.98])
 by mx.groups.io with SMTP id smtpd.web10.43565.1624259364831624928
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 00:09:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7v7vxJ5xHVagPjA6/mKwdzkEMi8DvNNwPaD5E4J0tIzvfptFCrES/e1JCVYmH8tx+AXCoodKPmAmq/V+6IiCtObuORrhKMwsKE8kGKBvErG+VyE0qh7wR3v4OfCwT6CNlwk3GRMGU3HwPeNYqi/Jv61aos/uCzBCH8yJV725F2FFK6vvqNwdrYSyo+ldR9NPxfCh1r9SjWhtIxLrFl1lQ9pPn7c6JInfMnjqKPcKcmkEWFcykvRA9gB3ATzm7rxq/nfBUto7qPukLK6V7kCrxVH2Bqshm/2A8R0OjppXqRjxSoQziWz+WKjGDjwFMleGR8eldQX9tuOpU2jOUm1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcVXGuRmPmbOMVz0cZIl+n3p4F0YpS3bue6bdfIAPgA=;
 b=lbPq4AcoRju6PJTABWbdrKegSk6qcO3QpVri+jNJ+C/X6L3UhdpdrFpq60/6HczGpeXFs8mtuivpw2hEY/kUjGyL0WF9mWI6ePP4jqSqQf7m3r6c+QdfGsD5BMoE+eTuBzexyoUFBbssnikxNFJVD5hFCI9Up6IJjz4F/TahUBJOAkzn8rGJhh1yfMiKdKZa2jOYsNJNXt6Z8eBuOxgbpCG7i7ohjX0Z89xKZ4DS20HX6eQQ8/9/GfUig3qcQJ6r+MBMCNtT67ONOC+E2lvN5ybwz6vaWHwoE6A7KAFzKNxB2Vlxm4MUF11XBE4MrhBjiddvJT1lE5FQHTUkDjQm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OS3PR01MB6151.jpnprd01.prod.outlook.com (2603:1096:604:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 07:09:20 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::d99e:8b7f:9620:c032%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 07:09:19 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "hws@denx.de" <hws@denx.de>, "Smita_Gumansingh@mentor.com"
	<Smita_Gumansingh@mentor.com>, "pavel@denx.de" <pavel@denx.de>
Subject: Re: [cip-dev] lab-cip-cybertrust will be temporarily offline
Thread-Topic: lab-cip-cybertrust will be temporarily offline
Thread-Index: AQHXZmi6SrSeB7YR20ubrh622k5wqaseB5Kg
Date: Mon, 21 Jun 2021 07:09:19 +0000
Message-ID: 
 <OSZPR01MB687770E7EDF300D434CF1259B70A9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: 
 <CADPJy8XpMaqq+PsX=LmZJzmsu0o3Rus=_Tho6F684M_LbtMbjg@mail.gmail.com>
In-Reply-To: 
 <CADPJy8XpMaqq+PsX=LmZJzmsu0o3Rus=_Tho6F684M_LbtMbjg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-Mentions: nobuhiro1.iwamatsu@toshiba.co.jp
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06c7d62e-c98a-44de-9eda-08d934837cf6
x-ms-traffictypediagnostic: OS3PR01MB6151:
x-microsoft-antispam-prvs: 
 <OS3PR01MB6151EAFF47F14D7590C74EF0B70A9@OS3PR01MB6151.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 yyUF58fEncnvY0KAF7kPgVNJrzwSCYDR6NxTkNbTutlqiubLXBJUJOJfvY1QQOievbigHfspiLeCjsD77FT3lGUCxoISFmr/oTlfuyFsJGQyP9TObW1UqI+c7m8zmIZgn/M8CIighCwWDAeY3kmCM63iv0gYxf7tUMbl43w/S6DlUZ0XEQYEVJXZHKTAAxVjrBJFVLZHVppi6da3vCXV5VRVAIHVJ07rJVmAk43/1rFVac4EVDx8nKP6T4TlmJjSTqVM3vREStXnYTXnTxM6WVU0zIVg+Yn953FcSX6ntQNNnAKEcP5HIa4I7iOK9g9/Q4iUU9BRReSEsteLvPLfX5KapWa1A5/TtU0NwNjyhKn3AD2Rix/izMIEaSt5r2HIDkQYm83IIuUoNpYyNsxReEbQMM//N8MVVdxGgi5Nw8QoxgQ8lF8pi9KV1Ddp/7GDST3uWvPTflDmDWP+gkYL+ctC7QhIrrZIXC1mBZVDwJppaVoDdK2En2YQk2jOz98VxAFS7AwGqXw1qnrgPPX3wTPYysFQFbUdwSanUUTr9NuyAhhEQiWVlq4Yfgf8BxEKsG/C+jcbbpSO6Gso0adj381xddtv/KRGuviCJ/pMJMM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVR0VGJaaEZJNlRqU00yZEMyNFNCTGtpQlFacnU5cDhCQ2tvd0swd0dhTVFW?=
 =?utf-8?B?SzNLRzBaVlZmRytlc1NrNjZwWk1LUWJBYm1pUlVpR3FPNldBdTJncUhwYUtH?=
 =?utf-8?B?cnZQZE1qbDhyNGx2U0s2eG13T3dONGJKa1FIcld6cjJsdTBBTndMTUl3Y09n?=
 =?utf-8?B?bXd0R1VSbkMyM24wc29Ta1BxRjZsRm1NY0NFYngvV1FTcVNMVHJDLy9wRDBE?=
 =?utf-8?B?dlBzYjM0UCtBVmpmdjdvcGhEd2ZuaTZPZ1Y1UzlsWGlaa1N3TXlzS2RRZFFR?=
 =?utf-8?B?US8vREVWeHZzUmhRczRCMVk2NUNhYld3MzZMREtnbU9IdkZpNVVDWHlpVklR?=
 =?utf-8?B?dVg3SnU4cThqKzF1ZzV5RFJFODJRSUdqL1FNc0dkMlZZV1p4aElQeFRQSVBN?=
 =?utf-8?B?elRkblpUYjd5WGMwbnUwNi9jU2c5YnovNDBISWxHbWpuTXVUWTZodGc1OVJV?=
 =?utf-8?B?elpxQUl0WTdlakwwc1BmblF4RnRERnhOOG1TSlArVS80M2NoL2VPN3lsVHN1?=
 =?utf-8?B?QWl1Y3d6U2NqN3lDZ0lvNE1oVER1ajAxTTBUV1RybWhmYlIyckp6UzlwV2I0?=
 =?utf-8?B?c0RRZ3l3YlZXSnR5L2NhNWE3R1NKaTU0dHZFdzNBWDBLZlhUUXgyMlhrcXZK?=
 =?utf-8?B?MTJuRDV3SHlDcnhLN09JVUFLWTNmVWlnNTVER1VFTE9RMWJIOWVGTkpBQXNY?=
 =?utf-8?B?QmdKOGowZ0VRKzF1M0FBNVNvNVFsbkpFOGJFRDZSOUtYVi8rRXNCdXpCQmJB?=
 =?utf-8?B?eVluYkxVUS9IWDc4SFF3c1R3UGY0UlEwdDdpYXp0SmZXUFVmQ2U5MWN5RHVX?=
 =?utf-8?B?cFIzcUVUbkJ0cTdQZzBkcWMwWC9xaDVCbTlVV0NJWmx1UWp3bkMrcDRpaDB1?=
 =?utf-8?B?T3JDSHFNWG5qQmVUSHptNS9ZWUtGRTluZVkvODQrSXZGclVYdTFxRkNsNGlG?=
 =?utf-8?B?cGdERXJoSTZubkk1aFhrUjlDSzAwWDJEOVdzd0lTWmxYZmZaUFN4QXFYbXZF?=
 =?utf-8?B?b0xmWVN5WHBSalZoUlAyY0tTWTUxeGM1ZXJMSkFkQWpCdHN6ZEo3bzZ4SUdW?=
 =?utf-8?B?cjYvUGNTb2htSUoyVUJrVXRIV0JZY0EzL2x1cGpLMDBrNDhjeWFtalJMNFVI?=
 =?utf-8?B?WXhPNm5JUk5LRjB2QkhQS21TSXBUSEcwdG1seDZOUml5M0dob0tuYjVEcEt2?=
 =?utf-8?B?RlNVVVVwbGJKaVNNVTdQRUE4bEhDWEJXTExnSW0zMFE3R09DcS9VVkNjMXZa?=
 =?utf-8?B?eGxpbkJxdVJNdXpQdkgrOE1RRUxIQ2dwcXMvaUs0UVd0eWh4NDJGMmlMT2tH?=
 =?utf-8?B?MEpPN2FIZmpVdWdsZG1UZzMzaDZVWVJ4QzltVUFsMkhjdlRubWJNdHNhTXJO?=
 =?utf-8?B?WmNIbkVHS1Q3djBtK1hWeUUyTEpRT0swbldLS0QyVFhIdFNQbFRCam5KZXIz?=
 =?utf-8?B?RTBvQ3FuU0drTE5YRlh0citOUlMvc2pGWE9lMFM2RUhHcWNOcmFUYVJ2ODVS?=
 =?utf-8?B?VGQ4TlFXMnVsTHN0MFJ4RW9XaHp4Qjd4c01aaHRsRk41U1BQMVJ1Y1lLY0ky?=
 =?utf-8?B?YkRKNkRadDM5SmxYY2s4dXJwSDdUNGlla0RqYldJbmhaYWNmZGh0R0cvVW1y?=
 =?utf-8?B?cTRuNDdNWExBaEVXcWwxSndGWUw5ODBFRDVuMklOM28yZGtRaWxRTUc3UUtF?=
 =?utf-8?B?b045QW5EMjBrWkZPRDBDL29pRllKeUhSRFdJN2Z0L1NpTXhDOS94VkhaNnBa?=
 =?utf-8?Q?YOYMLhRzSoBoE90YiN31JF5xOqOzgXBC7P3Wy9J?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c7d62e-c98a-44de-9eda-08d934837cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 07:09:19.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THxsy1o/G0qKom8QW7XUOQvsK+4eCq8eWq0j97qdtHCaJBVFhUQ8Mo4rSTSRPVlpdCz1jIDsGBYZIXl9yuhkHwU/o60RsHy33K00R6bo3bY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6151
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xe5A6g9i1vTVfNWWVnPleU0Ex4520388AA=
Content-Type: multipart/mixed; boundary="4alfo6JDoExga8SWXnU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624259366;
 bh=mZ0vdN5CPBT0/2Z3hzmBANEy8Fa6aVhAKrpdjzt3Xdo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BzudmpkapB+zvkr8CX0Qdq70ad1kDbv8FNMGz9gWbp++OdjXYJbnw0wZZPCQBIFiWzA
 y4AqVcCrS4zivVt8R53YAGj7n/TDNy2oRVOPezJ5lBg77hOwnf43nNv6CXEEIjPr9pt+l
 nQq56In5O6nXl5lMLHrtfYR5CKtpPz1FNhs=

--4alfo6JDoExga8SWXnU6
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gVG95b29rYS1zYW4sDQoNCj4gRnJvbTogSGlyYWt1IFRveW9va2EgPGhpcmFrdS50b3lv
b2thQGN5YmVydHJ1c3QuY28uanA+DQo+IFNlbnQ6IDIxIEp1bmUgMjAyMSAwNzo0Mw0KPiANCj4g
SGkuDQo+IA0KPiBUaGUgbGFiLWNpcC1jeWJlcnRydXN0IHdpbGwgYmUgdGVtcG9yYXJpbHkgb2Zm
bGluZSBvbiBKdW5lIDI1dGggZHVlIHRvIHBoeXNpY2FsDQo+IGxvY2F0aW9uIGNoYW5nZS4gSSdt
IHNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4NCg0KVGhhbmsgeW91IGZvciB0aGUgaGVhZHMt
dXAuDQoNCkBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcCwgd2lsbCB0aGlzIGNhdXNl
IGFueSBpc3N1ZXMgZm9yIHRoZSBuZXh0IHY0LjE5LWNpcCByZWxlYXNlIChGcmlkYXkpPw0KQ2Fu
IHdlIGdldCB0aGUgdGVzdGluZyBkb25lIGVhcmx5Pw0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoN
Cj4gDQo+IFRoZSBzY2hlZHVsZSBpcyBhcyBmb2xsb3dzOg0KPiANCj4gSnVuZSAyNHRoIChUaHUu
KSAxMDowMC0gKFVUQykNCj4gLSB6Y3UxMDItMDIgYW5kIGJiYi0wMyB3aWxsIGJlIGNoYW5nZWQg
dG8gb2ZmbGluZS4NCj4gLSB6Y3UxMDItMDEgd2lsbCBiZSBzdGlsbCBvbmxpbmUuDQo+IA0KPiBK
dW5lIDI1dGggKEZyaS4pIDAxOjAwLSAoVVRDKQ0KPiAtIHpjdTEwMi0wMSB3aWxsIGJlIGNoYW5n
ZWQgdG8gb2ZmbGluZS4NCj4gLSBsYWItY2lwLWN5YmVydHJ1c3Qgd2lsbCBiZSBjaGFuZ2VkIHRv
IG9mZmxpbmUuDQo+IA0KPiBKdW5lIDI1dGggKEZyaS4pIC0xMDowMCAoVVRDKQ0KPiAtIGxhYi1j
aXAtY3liZXJ0cnVzdCB3aWxsIGJlIGNoYW5nZWQgdG8gb25saW5lLg0KPiAtIHpjdTEwMi0wMSB3
aWxsIGJlIGNoYW5nZWQgdG8gb25saW5lIGZpcnN0Lg0KPiAtIHpjdTEwMi0wMiBhbmQgYmJiLTAz
IHdpbGwgYmUgY2hhbmdlZCB0byBvbmxpbmUgZm9sbG93aW5nIHpjdTEwMi0wMQ0KPiAod2l0aGlu
IGEgZGF5KS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gSGlyYWt1IFRveW9va2ENCj4g
Q3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg==

--4alfo6JDoExga8SWXnU6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6545): https://lists.cip-project.org/g/cip-dev/message=
/6545
Mute This Topic: https://lists.cip-project.org/mt/83683050/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4alfo6JDoExga8SWXnU6--
