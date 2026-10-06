Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B12FCC6B38
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 06:25:01 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (SEYPR02CU001.outbound.protection.outlook.com [40.107.44.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41826.1791280481787174595
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2026 02:54:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g/Ii6My8;
 spf=pass (domain: siemens.com, ip: 40.107.44.28, mailfrom: badrikesh.prusty@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYnBRC2tj1g7QFMWLgMc02gVqDzET6jMQ+KgYcSx7Wwb1RLBO1xX/oEh0RW4+nMQwNmNNCDAgO2E58X0OhjSVkuAgfQD/jmM+yNyXT/haxvhl4LfGpcvfRpoY3dGwYH1DbvWicdZSI6tNrI58I3mHGKI6cDTD6iBa/eS4tQPeXOSJahVkMMihLQ9PH/tgMYmbq6+Y4WYaECa2ud7tMU4T2Fr5doq7xzXqP5cfyedP8WjXr0On7V+wHmDeqenEakjNAjx3xrF+wC5hwHRw08+4DRsfyl4xr+oZGVTGEOvMfhxtKfP+P3gqej5RN5bDI+XTTQ5meMdS27oZ+hF71DZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxYl4+gf8ijUpTHJRenJQh3B9AXnNljicTtM9gR0Iug=;
 b=jj3dLsFHpvsosR+U0LFZhdwthb6U1Etq8IdSAQ3awLvUmQhM5CRZw4jB2njMuxXc1rXfWvSgrtqt+gQCiT44X3XRNcV5GQv7O5FzMKbkZzRYIPGiDsFIyUPOlOwwCh6tHgFdTthohUL0Pm0svLtExPYJmKi0IfQcFr55WSJQq92Qw8lDGTE2Nqj1SVMFm+FKQgGnJ8yx6xhgNMKBq2CZJ402i3roj4JlcRa5fuytE14EeHmUmryFcIxBCkqvw6txVyI6LhkP7w7E5gHbuuEzO1ZLHXdUWxd/Ax+b1g9T967BiB2YCSZvfDbxvfsxDZCKBksLXaF0euyiJKx8IzBrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxYl4+gf8ijUpTHJRenJQh3B9AXnNljicTtM9gR0Iug=;
 b=g/Ii6My8GFkG06zu1qV8g6pmYusDKSDxwGEfJjkN37mSGGY61aeLKwCNep/z3wwkH+uxcLmSYWXncgbch98Epuif9x2PV/T8Mf/SP12DWoxq4kO208UvC1bTNwTItZSBbNmLgntGyzYwZ3M775nfYpcSMqsLeeyGeHJafjWL2v2St24Jq5rzdXN1ZiKYkEtsys2tsaTgFyeE6QC6NUOAZpvWxAJ7VCjl17PEA5/7y+pJNGHmOEuLBeyxvNjOKAIyfG8JS8Ad2nfhlo84HJbcWHXVNaZjKrEjTGN+IuGuZDT7aSrit/Hq7DO6+gNO5G97x9DVReob3v/BwGWVFnommA==
Received: from JH0PR06MB6656.apcprd06.prod.outlook.com (2603:1096:990:2f::7)
 by SE3PR06MB9195.apcprd06.prod.outlook.com (2603:1096:101:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:39:29 +0000
Received: from JH0PR06MB6656.apcprd06.prod.outlook.com
 ([fe80::6009:8c68:86fa:d195]) by JH0PR06MB6656.apcprd06.prod.outlook.com
 ([fe80::6009:8c68:86fa:d195%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:39:28 +0000
From: "Prusty, Badrikesh" <badrikesh.prusty@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>
Subject: Re: [PATCH] swupdate-handler-roundrobin: Fix Lua version for bookworm and bullseye
Thread-Topic: [PATCH] swupdate-handler-roundrobin: Fix Lua version for
 bookworm and bullseye
Thread-Index: AQHdVUNmRy+PMovw3UKkM6iB6xVhPrbwGLwAgAAl3+A=
Date: Tue, 6 Oct 2026 09:39:28 +0000
Message-ID: 
 <JH0PR06MB66564EFFFD8AB7076AD5375791952@JH0PR06MB6656.apcprd06.prod.outlook.com>
References: <20261006033242.301666-1-badrikesh.prusty@siemens.com>
 <4853f7c5-df38-431f-a7cb-7b80e2a781ee@siemens.com>
In-Reply-To: <4853f7c5-df38-431f-a7cb-7b80e2a781ee@siemens.com>
Accept-Language: en-IN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=cf78690e-07ad-49e0-bd2f-d9498f8878f7;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-10-06T09:25:03Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR06MB6656:EE_|SE3PR06MB9195:EE_
x-ms-office365-filtering-correlation-id: b0fcd1b3-b9bb-4873-1951-08df238db79b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|55112099003|6133799003;
x-microsoft-antispam-message-info: 
 KytHSGmvU/eMUFidsR3gEpquoQ5WT7sj8pLlqDAj3PEOUUwD+l5oneUqX4bawV13ahQbcK2rdZKOyaP4BBZw0sc1YMzk7U3gFqC+v0jw1KWYu4Z8YCNEPfw8oISlE9zenVJ1cN9Y/lQbopuBFi4qZniKpqiXuOlLmrW9UA77Pb/Ax7x0aPJww7ISIbzUiTxZpLCOqrgYvddcHnt7KfRFPVAwszFUlmE/xiGqAPaflPHrzuALMUibNRo+ucThp4xSx3vjJxB5c+3x9M04KzMOdY2v2o37iMQWtszRWMNFrWlZvYizTOGMtTMvs0KlD10klFo8DI+ez+/66oEesnwe55uWHl5XruSdRrZHUTSiCDNcV1ZS65ygN7xaEB7DN1mITrht0xFPpONs+pxZYufOGkuV5d2jXNGe5xQuJpZbsC77r/PgCvLr1AvwylKsXfFpwij6T7tuNE5l7DiXepaTpLFJmaQ3qdvM1yS5DRa9q+omewJCPcyDCggV3uJXpvC6COVi6F7JUpoHCSLu9LvZgq2hbUbsNAv/Ro4AxF9KlfXtyLVftfZVUr7m0pyt6+Yv+zOd7FByAzock4b/XZtcfRJYuSHXMjK4YBIHcOoht/FU40RpvnJi6iLNhSgpHmkX/tniYa+HZVIwfLYg6gqqnPThBI/lL0me+YY9lP12nxLs/V+b4tCFDUNQ1FmoBLbc2HXOT0283zJHEqTtwTviFU9azFHm83Te7Q4C5/iJECE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6656.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YVFWRHYxQi82RnVVN1NEL1g5b0hvY0FaQnRMeWFVTnBOMHhzMERDcGx3cWJy?=
 =?utf-8?B?WDVxeU0xeWZwVC9YdU42K2drUXcza2N0dGFPRWFYNUdCVmZ1OWV5ZXl4NGRN?=
 =?utf-8?B?WXdCQTJlVmFNRHNVUDEyNi9mbzFqMzFhdlJmenFTVGhiNU5nRUNHNTl3STdC?=
 =?utf-8?B?elFYcWZHallmRWUxdjNTTlFMd2pvblRTMnh3Yk0zdWNQYzRXeGFIbUpWdUpH?=
 =?utf-8?B?WVdyaGRnc1FRUmlZMEJFWmdITHFLeng1NHZYYWZXcnhjTDUwK2pvcnJ3b25j?=
 =?utf-8?B?KzdsTHNmL3dYVzZneDhJRU42WWx6Z0R1allRRXJxc0dMZFdQUFk0ODE3YkNy?=
 =?utf-8?B?dFFoQjdGSXhuZ2QxR1FZL3RTNHVOeThGczVaeFM5UUJSTFV6U0xZV1EyWjB2?=
 =?utf-8?B?Q0RDbVpxM1Z2dEhvRzFNZDFvVGpXeGh5aHBzWlIwYkd5bkxYc2xGUHdQSGJi?=
 =?utf-8?B?UE5BR0V6VDAySWd4Z1dNUFpweGtGSVJQRVNLejB6WktIMVhJYWlFNzQwa250?=
 =?utf-8?B?TCtQOVM5TXFHdzB2WWNPL05zWTVhTUlIY2NsMWNINlN4ZjIvVUw2Y20zdjhj?=
 =?utf-8?B?dGJXdXhocGRNRWU4UkZhY0ZOTFRHb2JpQlZJZktjY0hpcFdnQVg3Wk5xS1N2?=
 =?utf-8?B?YlJibkdXL3loUm5xdUJVbTB6UXVZa05OM0xsRkJqQXVTbHE4dlg5VFZZTi83?=
 =?utf-8?B?bWNNY056WFJCVmFTbkd3QjdYZUZ4OFl1MG9yU212TzhrVzYyaEQxbGVBL1B0?=
 =?utf-8?B?dmVBMW55MXRNdjhPVnpGRHk5Z0VyOGEzU2FQUERUbXFCTVV4VzZWSEtaeWRT?=
 =?utf-8?B?ZUZpMnRKaG5IT3J2VUhBbjNFWFJkSmQyYjkwQ05ocG9wUytrYm9IcWZ6Y0NY?=
 =?utf-8?B?Y0hwZG05V2Z2Y3FUM2crRVhmMnViQTJVaHdIMmtROWRqanhMZkFndjZmOVhw?=
 =?utf-8?B?SG9jN05XWXRsNVhQd2M0QlFXcXFkN0dpRldZeEQyM1RINFVmdVdST3Q3b2pm?=
 =?utf-8?B?cWc1U21oMCtEazNsakV1eUU4SzV6TkFPY3JqVGpGVzBpUDI2RU5NV3UwUlVV?=
 =?utf-8?B?aW9oOFlKLzlxV1Q2VW9aUW5jVjhMTHdlWUdaNjFxVVYwN2NJK1pVNTZOZGZQ?=
 =?utf-8?B?SzhYejZxTEE1L2FkZE84czhubjllVVFiWHZMYlhBYmJTckRhVlEraTN6MTVv?=
 =?utf-8?B?cmJEc0ZtV05WZFgzTHJqRDl2VXdZUks1dXlHUVZaK1BKeERkT0lNcjZWRjNx?=
 =?utf-8?B?L0JZVzRmbk9PZzVtZEhXRm9XS05lbjVhS1NoTzVHZE9LSWgwanBES0R3Zk9R?=
 =?utf-8?B?dTVJQUgwQURLakhGUlRLUy8ybjlZbm1rcTVaM2s3K0cwV0FWYjFKeHcrcnBE?=
 =?utf-8?B?SGpsM2l3SXUxNHVNZWNkNllOSnlGVEtKaHFQOUdKY2VjZGZsSFJrWUZvSWFM?=
 =?utf-8?B?T2lQUjNERDVJSWFpL1U5OUlkMXZxUzhZTE9IQ1JUWDU1RTRFWkVURStjNUd4?=
 =?utf-8?B?OHhDUytSQUFnY2hrMHU2TXNZY0VxRG5ZdXFjbzcxREhUOG1GMjFHZ3FZVk50?=
 =?utf-8?B?SWtudXFRLzlIb1k0eHpXL2lTbldKYkhMUWxZWWZQM3Y4UHVlZjhzVUVRNmU2?=
 =?utf-8?B?azNjY3N4MlhYTE5mbjQrYXpnczFzRUNaQ3VKUWxwemhTemR5OWFVazFwREkw?=
 =?utf-8?B?Ry8xNHVwajFkWWtxSnFWOWQxeXlLWnhhYi9ORGx2VWFoc0trZ3VwNjV5SU5j?=
 =?utf-8?B?YU9oa3VrQjJvZllES2hmbTRkUkxlZHQwYURwRExwSGMvS2tjbnlQenAyRjBt?=
 =?utf-8?B?cVZkK1h1OWRSRzNOM3dET0ZvR1QyeHdRV2R3Yy9Xc09vTjdPaGtESURpd3RI?=
 =?utf-8?B?NVlSZFpER3hGeWxUekY1S2lMT0NBZ21tSnRBT0VBVUpZekF4aE9yM2lreDdm?=
 =?utf-8?B?YUxvL1lUNDIxa05Rd3FkdHlsemV3NkVDbTBROHlmdGQxaXhUK1BKeWdROURo?=
 =?utf-8?B?OGdjQ2JuREZrZ0dGdzJhNEIwMzVjdlRnNnRvL1NJNDg3Z0MwSHpudDNBb1Ux?=
 =?utf-8?B?U2l3VTByTFBjRVlMYjVtaGh3ZU95OUIyTkFEK0hUbE1xNTI3VzNSTGtVMTFZ?=
 =?utf-8?B?WWNGenZsUGdlbTRQQU4wRXhHM2ZBT3FZWjhRMjM4U3h0SVgyWFlNRmV3M0Y4?=
 =?utf-8?B?Q2puZEI5SlpqQXdLSzU3TnlmMHJQcHRNQXIzS21VTkF0b0FtWFdVYkMwbjl4?=
 =?utf-8?B?TlZvampiaGVLMW1kWWR5NnQraUpzVDRnc25ZaFR4NnZ4YzZZMmdXSlJOYXpp?=
 =?utf-8?B?M3dHSGRHaUs0K21pVWVLRmhVRlA5bEZVRkgvUEZyRXplWEpTcTJLZFVWU08y?=
 =?utf-8?Q?mj8I3Emvi7LFgLUA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6656.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fcd1b3-b9bb-4873-1951-08df238db79b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 09:39:28.7508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwoGsvaISRi3qwTL+d+8qTMo46/xCAdNYiaoE3I2bg4Pzf7scN0Z7HeYkm3UnygIce4QySTHC0UbGQWnrt4OyhhdZ05wOX3Auagzpa9A5oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9195
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 06:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24470

SGkgSmFuLA0KDQpJIHRyaWdnZXJlZCBhIGJ1aWxkIHRlc3Qgd2l0aCBEZWJpYW4gQnVzdGVyIGFu
ZCBjaGVja2VkIHRoZSBsaWJsdWEgdmVyc2lvbiwgaXQgbG9va3MgZmluZSBhcyBtZW50aW9uZWQ6
DQoNCmBgYA0KPiAuL2thcy1jb250YWluZXIgLS1zc2gtZGlyIH4vLnNzaC8gYnVpbGQgIGthcy1j
aXAueW1sOmthcy9ib2FyZC94ODYtdWVmaS55bWw6a2FzL29wdC9lYmctc3d1LnltbDprYXMvb3B0
L2J1c3Rlci55bWwNCj4gZ3JlcCAtaSBsaWJsdWEgYnVpbGQvdG1wL2RlcGxveS9pbWFnZXMveDg2
LXVlZmkvY2lwLWNvcmUtaW1hZ2UtY2lwLWNvcmUtYnVzdGVyLXg4Ni11ZWZpLm1hbmlmZXN0DQps
dWE1LjN8NS4zLjMtMS4xK2RlYjEwdTF8bGlibHVhNS4zLTA6YW1kNjR8NS4zLjMtMS4xK2RlYjEw
dTENCmBgYA0KDQpJIHRyaWVkIGJvb3RpbmcgdGhlIHdpYyBpbWFnZSBpbiBxZW11LCBidXQgaXQg
ZGlkbid0IGJvb3QgZm9yIG1lLCBpdCBpcyBzdHVjayBoZXJlOg0KDQpgYGANCj4gcWVtdS1zeXN0
ZW0teDg2XzY0IC1ub2dyYXBoaWMgICAtZHJpdmUgZmlsZT1jaXAtY29yZS1pbWFnZS1jaXAtY29y
ZS1idXN0ZXIteDg2LXVlZmkud2ljLGZvcm1hdD1yYXcsaW5kZXg9MCxtZWRpYT1kaXNrICAgLW0g
NjE0NCAtc21wIDYgICAtZHJpdmUgaWY9cGZsYXNoLGZvcm1hdD1yYXcscmVhZG9ubHksZmlsZT0v
dXNyL3NoYXJlL09WTUYvT1ZNRl9DT0RFXzRNLmZkICAgLWRldmljZSBpNjMwMGVzYiAtd2F0Y2hk
b2ctYWN0aW9uIG5vbmUgLW5ldGRldiB1c2VyLGlkPW5ldDAsaG9zdGZ3ZD10Y3A6MTI3LjAuMC4x
OjIyMjItOjIyIC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PW5ldDANCi4uLg0KLi4uDQou
Li4NClsgICAgNi43MTUxMDVdIG1kOiBJZiB5b3UgZG9uJ3QgdXNlIHJhaWQsIHVzZSByYWlkPW5v
YXV0b2RldGVjdA0KWyAgICA2LjcyMzEzNl0gbWQ6IEF1dG9kZXRlY3RpbmcgUkFJRCBhcnJheXMu
DQpbICAgIDYuNzI2NTA2XSBtZDogYXV0b3J1biAuLi4NClsgICAgNi43MzA1NDZdIG1kOiAuLi4g
YXV0b3J1biBET05FLg0KWyAgICA2LjczNzQyMF0gV2FpdGluZyBmb3Igcm9vdCBkZXZpY2UgLi4u
DQppNjMwMGVzYl90aW1lcl9leHBpcmVkOiBJIHdvdWxkIHNlbmQgQVBJQyAxIElOVCAxMCBoZXJl
IGlmIEkga25ldyBob3cgKFhYWCkNClsgIDMyMC4zMTUzNTJdIGt3b3JrZXIvZHlpbmcgKDEwNykg
dXNlZCBncmVhdGVzdCBzdGFjayBkZXB0aDogMTM3NjAgYnl0ZXMgbGVmdA0KYGBgDQoNCkknbSBu
b3Qgc3VyZSBpZiB0aGVyZSBpcyBhbnl0aGluZyB3cm9uZyB3aXRoIHRoZSBRRU1VIGNvbW1hbmQs
IGJ1dCB0aGUgc2FtZSBjb21tYW5kIHdvcmtzDQp3aXRoIHRoZSBCb29rd29ybSBhbmQgVHJpeGll
IGltYWdlcy4gSXQgbWF5IGJlIGEgZGlmZmVyZW50IGlzc3VlIHNwZWNpZmljIHRvIHRoZSBib290
aW5nIEJ1c3Rlcg0Kc3d1IGltYWdlcywgd2hpY2ggd2UgY2FuIGFkZHJlc3MgaW4gYSBsYXRlciBw
YXRjaC4NCg0KDQpNYW55IFRoYW5rcywNCkJhZHJpa2VzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogS2lzemthLCBKYW4gKEZUIFJQRCBDUEMpIDxqYW4ua2lzemthQHNpZW1l
bnMuY29tPiANClNlbnQ6IDA2IE9jdG9iZXIgMjAyNiAxMjo0MA0KVG86IFBydXN0eSwgQmFkcmlr
ZXNoIChGVCBGRFMgQ0VTIExYIFBCVSAyKSA8YmFkcmlrZXNoLnBydXN0eUBzaWVtZW5zLmNvbT47
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogU2hpdmFuYW5kLkt1bmlqYWRhckB0
b3NoaWJhLXRzaXAuY29tDQpTdWJqZWN0OiBSZTogW1BBVENIXSBzd3VwZGF0ZS1oYW5kbGVyLXJv
dW5kcm9iaW46IEZpeCBMdWEgdmVyc2lvbiBmb3IgYm9va3dvcm0gYW5kIGJ1bGxzZXllDQoNCk9u
IDA2LjEwLjI2IDA1OjMyLCBCYWRyaWtlc2ggUHJ1c3R5IHdyb3RlOg0KPiBTV1VwZGF0ZSAyMDIz
LjEyIG9uIGJvb2t3b3JtIGFuZCBidWxsc2V5ZSByZXF1aXJlcyBsaWJsdWE1LjQtZGV2LCBidXQg
DQo+IHRoZSByb3VuZHJvYmluIGhhbmRsZXIgd2FzIGJlaW5nIGluc3RhbGxlZCB0byB0aGUgTHVh
IDUuMyBkaXJlY3RvcnksIA0KPiBjYXVzaW5nIHRoZSBoYW5kbGVyIHRvIG5vdCBiZSBmb3VuZCBh
dCBydW50aW1lLg0KPiANCj4gVXBkYXRlIFNXVVBEQVRFX0xVQV9WRVJTSU9OIHRvIDUuNCBmb3Ig
Ym90aCBib29rd29ybSBhbmQgYnVsbHNleWUgdG8gDQo+IG1hdGNoIHRoZSBMdWEgdmVyc2lvbiB1
c2VkIGJ5IFNXVXBkYXRlIDIwMjMuMTIgb24gdGhlc2UgZGlzdHJpYnV0aW9ucy4NCj4gDQo+IFRo
aXMgZml4ZXMgdGhlIGVycm9yOg0KPiAgIGZlYXR1cmUgJ3JvdW5kcm9iaW4nIHJlcXVpcmVkIGZv
ciBpbWFnZSBpbiBzdy1kZXNjcmlwdGlvbiBpcyBhYnNlbnQhDQo+IA0KPiBGaXhlczogOTAyYWQz
MjYgKCJzd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW46IEtlZXAgZGVmYXVsdCBsdWEgDQo+IHZl
cnNpb24gYXMgNS41IikNCj4gU2lnbmVkLW9mZi1ieTogQmFkcmlrZXNoIFBydXN0eSA8YmFkcmlr
ZXNoLnBydXN0eUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+ICAuLi4vc3d1cGRhdGUtaGFuZGxlci1y
b3VuZHJvYmluXzAuMS5iYiAgICAgICAgICAgICAgICAgICAgICAgIHwgNCArKy0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCANCj4gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluL3N3dXBk
YXRlLWhhbmRsZXItcm91bmRyb2Jpbg0KPiBfMC4xLmJiIA0KPiBiL3JlY2lwZXMtY29yZS9zd3Vw
ZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4vc3d1cGRhdGUtaGFuZGxlci1yb3VuZHJvYmluDQo+IF8w
LjEuYmINCj4gaW5kZXggNmU5MjNlNC4uOTY1ZTBmNSAxMDA2NDQNCj4gLS0tIA0KPiBhL3JlY2lw
ZXMtY29yZS9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcm9iaW4vc3d1cGRhdGUtaGFuZGxlci1yb3Vu
ZHJvYmluDQo+IF8wLjEuYmINCj4gKysrIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlLWhhbmRsZXIt
cm91bmRyb2Jpbi9zd3VwZGF0ZS1oYW5kbGVyLXJvdW5kcg0KPiArKysgb2Jpbl8wLjEuYmINCj4g
QEAgLTI4LDggKzI4LDggQEAgU1JDX1VSSSArPSAiJHtAKCdmaWxlOi8vJyArIA0KPiBkLmdldFZh
cignU1dVUERBVEVfUk9VTkRfUk9CSU5fSEFORExFUl9DT05GSUcnKSkgaWYNCj4gIA0KPiAgU1dV
UERBVEVfTFVBX1ZFUlNJT04gPSAiNS41Ig0KPiAgU1dVUERBVEVfTFVBX1ZFUlNJT046dHJpeGll
ID0gIjUuNCINCj4gLVNXVVBEQVRFX0xVQV9WRVJTSU9OOmJvb2t3b3JtID0gIjUuMyINCj4gLVNX
VVBEQVRFX0xVQV9WRVJTSU9OOmJ1bGxzZXllID0gIjUuMyINCj4gK1NXVVBEQVRFX0xVQV9WRVJT
SU9OOmJvb2t3b3JtID0gIjUuNCINCj4gK1NXVVBEQVRFX0xVQV9WRVJTSU9OOmJ1bGxzZXllID0g
IjUuNCINCj4gIFNXVVBEQVRFX0xVQV9WRVJTSU9OOmJ1c3RlciA9ICI1LjMiDQo+ICANCj4gIGRv
X2luc3RhbGxbY2xlYW5kaXJzXSA9ICIke0R9L2V0YyBcDQoNClRoYW5rcyBmb3IgaWRlbnRpZnlp
bmcgdGhpcy4gRGlkIHlvdSBhbHNvIGNoZWNrIGlmIGJ1c3RlciBpcyBzdGlsbCBmaW5lPw0KDQpK
YW4NCg0KLS0NClNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4
cGVydCBDZW50ZXINCg==

