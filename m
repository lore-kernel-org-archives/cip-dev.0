Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396F9C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 19:01:02 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.75])
 by mx.groups.io with SMTP id smtpd.web10.1535.1713551889729641357
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 11:38:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pe/sI+w6;
 spf=pass (domain: siemens.com, ip: 40.107.8.75, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLN0fHdqQPoFuYNKvJQ2CqjJ57/RCdJN02ODgSALnQqPf5YQeh1Cx6N40LiSp6WTU3I24Xjo1pCox2vjZRPyGtiyD/O7vlYPt/X79QCKWo2H5d2Ntx60Ekcl6ME1JiP70GpYaZ6Cgrys2h9WSnOFyN+cXR+mfMB7OfDB9Y+FkFAJP8Cmx392na+0RvueyVkfq4I38106O6QiIRDJCrNcEJD64smQ11qSGY1g6/xB6RHYc2ieDku0/k7mWSmROULHJFDYFnBfZrcwEZd+gTymIojcYq196RqW8TnShxnlcmiH8adMCizh3fvwjQjT2awMD0vpNWhl+JCMH2EQxj+v0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgfhkyyQABOuWv1M3pp38aRHvfFOyttrcTrYHqn0VNA=;
 b=fvscc+bJdbpf/eJsU/aq0Sm1oe3eRSAZQnUU1+GLjomQpsKFQs4ZSzHSbZF4mko0EQyXK9lZZ9Z8OstWOFKkN+2dzIyrtKP0GdB8s9OPAXEXVv+J+k5ySATW+inycIER8sKDJ3N3TUBxL6Y/6DCCHTgeG+6E5+ybSiWXHWVMfvPzwYJhf2hUB+UkhYsHmMo6UeKhjrhyUduI5K6q3t0BGW0aO/aw+PiuRavj9KcscLlweUw2bmFEQvEdBxed121PiDdlG6ZlHKwgcKoHVNSdoU9RkzOjVBNfFiScgorCTVe/abHqPVyZMMD3WVqu0MIN7uTQvPDAJXjk2yk24umflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgfhkyyQABOuWv1M3pp38aRHvfFOyttrcTrYHqn0VNA=;
 b=pe/sI+w6JaA8O/mkjZQXblza/mMXGUw5zTK1gIdU7DHbnPFhbEit/ekgGcBpv+zKyhElUh6oVv6RIzytiTzycV1ND3shDneTvq6gaLyZij4Aht8spNuk1wIHLwMjMNZaedWA6FEnRwKCOWoemrAiQj3NSvMDrD4dEUDk+7tQIOyF7lVBQ8rNA0zRm1EdPKUicl+8KubbjIbjr5S1TDjxKyEbh2d22TDC0/hYEHuUbN32C8kqSsazm7nkFZ9IiDa+AiS35nzJGZjJHNv6IZqGA498qht1obRNVxobMf8+rpmEU9DZIok8aywJNXbzVU/UqEthO0e8oUp0biK7TZ6kvg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DU0PR10MB7027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 18:38:05 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:38:05 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, "Sai.Sathujoda@toshiba-tsip.com"
	<Sai.Sathujoda@toshiba-tsip.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 2/3] swupdate.bbclass: Generate swu for delta updates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v3 2/3] swupdate.bbclass:
 Generate swu for delta updates
Thread-Index: AQHajyIQ4sCzc87XC02UUo1VEZYVhLFqS1yAgAAClJCAAgxEYIAC5OmAgAC0DAA=
Date: Fri, 19 Apr 2024 18:38:05 +0000
Message-ID: <394041536ce937b3e2fa1dc645ddb51076e8c608.camel@siemens.com>
References: <20240415104610.3073497-1-Adithya.Balakumar@toshiba-tsip.com>
	 <20240415104610.3073497-3-Adithya.Balakumar@toshiba-tsip.com>
	 <daf58173cf5f860c6d2bafca6febeb354679a15d.camel@siemens.com>
	 <17C6A85A6EC64CBF.13290@lists.cip-project.org>
	 <TYCPR01MB96690F57920D475F109579ABC40F2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
	 <c0af497c-b598-4376-a72b-9764c6bd5da1@siemens.com>
In-Reply-To: <c0af497c-b598-4376-a72b-9764c6bd5da1@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DU0PR10MB7027:EE_
x-ms-office365-filtering-correlation-id: 200f8f48-884e-412d-9eb0-08dc609fda1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eoUdCsvZy5nFoNzSY6RUaU4rVd8UqLjDwht/dkUcbDF9ENO4faOFcLDiVlfUmSYtWU7szoSrABzj/Tt06usjkFtiz9junR2dxv0KQgiKk3DDHd8UmehllZ6D1aHSgQA7lpD7EdEea/HxC7Qq1+5F7NqsXfzvLzOlC32ew1CyNBHbWWtkOYesqHOqczGsX9NRIenYAcBQH2qk73ZBvqehhp0XvdXJaZGzDsRHhYiUK0y/geaIRlLWcUuqHZUG4UQRDNTFnLDAjN/NN9Saoq2gAMwVJyZSyrrGPV+t0LPzpGZGsTTLSNpNSiFR3MxAYaHMEoOs8zoO+W3XeCkTv8QehyIxf2qb7aDBAfzmLzH+lgUBqdt1SigQ5n6LOndUfLErBhapLRwf78QIZ25hI5I4PpGxaMEje52ZrAbB6LgYXAqxlKy0T6MVpgiIVzJT+LqtrJvck0PY7TrEWvomIx7hRaZtrmHjvpBevIO7uKD2HPD6SavVBac+K0r0lbKBzTLd0ksw3EMNb+AhWaIxzVDNfDO+eR9y2lnENuJeMs3mQ41+XBnQCrtM9N/CGLhENccyM8sUDlbL+Vhhcl7vcubmKAN09yhXMvsGSvutPDYa+m5FiwcrWZ84PrEzkrGf7HaA4cNJ1D2ya34uLFsB6Vx8HkfA4MLCzVC3fUYBtjFTez+7BMQm4LHdx6N4ccxsAf4YK472wHj77XxZRe18DY8w3HPuPDqOQvdlhthea60OwdM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cnltZTF2ckNUMGhCUWF2a1J6UnJFMHFTaCtERTBha3U4Njh2dktEQkxzUVVa?=
 =?utf-8?B?dENWcW9CRHhkZ2I4YlFOMURjaHlWcjd2UEw2WXhaUndLdnpSa0cxbkRzMFZl?=
 =?utf-8?B?RGw0c2Zrcm5TZ0FTNmlNZ1M4Ylh0ZVVNQ0pkZllKTm1pMllXODRid1ZoOVhY?=
 =?utf-8?B?TjhrUE04dEl3UGs4c3pVa1pTZFdNem9qMEJKRFhHMWFhZTJGTEdyejh2WkVz?=
 =?utf-8?B?eVlDUzB4NFhYYVA5b3prc2xyTzVLdWZpcVRCTDVETXJNME1nbE1Qa3pKbUZP?=
 =?utf-8?B?NEhzSXFPbzVLdUhYNlFreDhEcldrWXJlQkZkeStjazgzMUd3T1l0UUdtRkw1?=
 =?utf-8?B?TkZnZXpacnlCRENHZGxXZHlCWVlDU09pQVVVdEZYS2orV0d3dDE5cVIyUHVC?=
 =?utf-8?B?Um0yWDVVK0NUWnFEZFJaU3JBM1hGZHEvYjR6QkNzNTJ6OThOek5ITE0yOFB0?=
 =?utf-8?B?OXcrQXlrcFFOUzB3enAvNDlCYkpYSXNseDQrNXBlT0dXaXFUZmlRT3BlWjQ3?=
 =?utf-8?B?VVFKeSthMWpoRUdpWDB5dm1XSkhhcFhFd3VZbG56cmNZTTh5NDhBbXRHODgr?=
 =?utf-8?B?YW0rUEVPRUQzZkRKRUJTTG55UFFXdW9UVGJqMXFjSzVQYWR2YmhEMDhSZ2I0?=
 =?utf-8?B?czVneWFUTk13bTFUNVRualFHU3V0UkNWSll0Y0lIMjJrN0dMZnI4cW5FdmZZ?=
 =?utf-8?B?M295cmRmNHdKRTMramFud0M4TmhPUzY5bjhQeGdxU3hCUmlLZ3o0Sm43UXVh?=
 =?utf-8?B?S0NES3E5VWVWRGdsZkdIKzN5dCtIOFdGNGlnenB5cG9NWmt1SHZ3UGlGaGF2?=
 =?utf-8?B?OHlCNTJyb0k4SXVHREtIcEVLbm1oYUtvMEEyQlJObURmUG0zVmluT25WOGRY?=
 =?utf-8?B?QTVPY3NNeTgrYU5yU0NKbmtEQzU1K214UGhlQ0VnRXdCaU4xOVVKUllhT1Np?=
 =?utf-8?B?aHh1MVBqY3FpNHpPV3lFTDR6Q1oxajVZMHJxMTVFaGp5ZGlqUFRTTnF4bWUy?=
 =?utf-8?B?K2ZYVnhMQ3MrNHBIRk9icVNmVUg3WjhlVGtOdkttYTZyNzl5bndxTG1JaTI0?=
 =?utf-8?B?SFM0NHRMWFhWSEgwMjRIWjIzTnAxMU1qYVpOYXJ4a3ZkcVVvditvNjMyTGJ1?=
 =?utf-8?B?Q1I2RHAwd1phOVI0OHBCeXRubVdTNGpSekFucmNrSG5Qa3NqeFVYaDBzLzRD?=
 =?utf-8?B?Tk5XYVNidW5DY09WU2FnQkNtNmp6ckRYeWg4MzlRTE9VbzZqWWZTWlJQUTcw?=
 =?utf-8?B?NmZPVFJ4SDB0MWFlSEIvSVJNOFQ3cGlqNHFUS296Q0lXakZkRCtVZVcxanh2?=
 =?utf-8?B?Z1BEWFZQb3hneFlWWFVHOFlwenJqRit2SzhZb2QzSmZEVjcvNTJGdjJJSkRH?=
 =?utf-8?B?YmVPQ2J6cTVJcGxEVGppNEFLRVF3ZDdkcHhMM01pVTV3V3JtSkR0Mjk1TUdU?=
 =?utf-8?B?Zk9Uc0dJcE9MNU05djZQdGptbmFiYXhoV1hjQ3o1c3JiMjR4TzV6cDNUQUpM?=
 =?utf-8?B?ZnNISDEwN1JqRC9taTZJZDMxUTNLSTRQSVdWQkhtOG9Calh1NUJYTGljd2RT?=
 =?utf-8?B?YklVbFFpcE5mbGRSYVFnZVIydW0xV1grN0N5T2lqWXo4K2cwVXk5Q21adDhS?=
 =?utf-8?B?Y0xWZys3anVDeTRsZFVpTDlOYmtnaTErMnJyYVpZdnZxUlB4UmJOdE02bXJN?=
 =?utf-8?B?dTdGZlhnWll3SUNCd2o4MURXRDc5NnA1N04zUUFkb2M3aWppVnBvaFNlTGlC?=
 =?utf-8?B?K2hsanVSd1BqQVBINzhJOGF0UFM1ODl2Z0lYZnJJTit0ZWQyRjY0TGw1RkZs?=
 =?utf-8?B?TXllV0JKd0pTTUpicUxIc3puR24zOUpKek0zaUZOVTFZZXNtcEF0WFVhY1Rk?=
 =?utf-8?B?OWp3OVJkL3cvRlErcVVDL3hHdDV6d2c1S3FVWjJVR0xadHU5UHFJRzU4SnVt?=
 =?utf-8?B?aXdiZVliaG05U1diaFR5djdhN1ZsTHlIY0M2Umc5RWJmbWdKazFkODJSdU1M?=
 =?utf-8?B?cnc5ZUMzSzEvem9EdFVKYm9yRUp5MjNQVWR1RTdsczNpVGpKMGFINGlrMzVv?=
 =?utf-8?B?cTFKZmRZZVZRLzFYdEdpL2VaTWlUcitpZm84L25OR2N2ZHpSZThVK05KdjFy?=
 =?utf-8?B?RTJuQTFPTGdwdzljK0NlaVJxek5sVHBkNnJoWEsvSlZySVNaczduU05WZWdX?=
 =?utf-8?Q?88aUlLTLQ8qaW6j8ZC5w3g0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 200f8f48-884e-412d-9eb0-08dc609fda1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 18:38:05.5131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxNMebIP6VtvHn0i+rnokc4E5V81CIv7GJr18A78RqNII5ik6brVpmd4scvr8XyfCpQUoFal6RbMBG9A/jCBoHzlP5bUvMq7boqE+TJWIfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7027
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <728C7D8407E38D4E8286C0504216173B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 19:01:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15707

PiA+IA0KPiA+IEhpLCBJJ20gc3RpbGwgd29uZGVyaW5nIGlmIHdlIHJlYWxseSBuZWVkIGEgZGVk
aWNhdGVkIHN3LQ0KPiA+IGRlc2NyaXB0aW9uIGZpbGUgZm9yIHRoYXQuIENhbid0IHdlIGp1c3Qg
bWl4IGluIHRoZQ0KPiA+IFNXVV9ERUxUQV9VUERBVEVfUFJPUEVSVElFUyBpbnRvIHRoZSBub3Jt
YWwgc3ctZGVzY3JpcHRpb24/IE1heWJlDQo+ID4gUXVpcmluIGNhbiBoZWxwIHdpdGggdGhlIGlu
dGVncmF0aW9uIHVzaW5nIHRoZSBuZXcgaW5mcmFzdHJ1Y3R1cmUuDQo+ID4gDQo+ID4gRmVsaXgN
Cj4gPiANCj4gPiBbQWRpdGh5YSBCYWxha3VtYXJdDQo+ID4gSGkgRmVsaXgsDQo+ID4gSW4gYSBj
YXNlIHdoZXJlIEkgaGF2ZSB0byBnZW5lcmF0ZSBhIGRlbHRhIHN3dSBhbmQgYSBjb21wbGV0ZSBz
d3UsDQo+ID4gSSB3b3VsZCBuZWVkIGEgc3ctZGVzY3JpcHRpb24gZmlsZSBmb3IgZWFjaC4gSGVu
Y2UgdGhlIGFwcHJvYWNoDQo+ID4gdGhhdCBJIGhhdmUgdGFrZW4gaGVyZS4gUGxlYXNlIGNvcnJl
Y3QgbWUgaWYgbXkgdW5kZXJzdGFuZGluZyBpcw0KPiA+IHdyb25nLg0KPiA+IA0KPiA+IE15IHRo
b3VnaHQgd2FzIHRvIGhhdmUgZGVsdGEgdXBkYXRlIHN3dSBhcyBhbiBvcHRpb25hbCAvIGFkZGl0
aW9uYWwNCj4gPiBhcnRpZmFjdCBhcGFydCBmcm9tIHRoZSBjb21wbGV0ZSB1cGRhdGUgc3d1Lg0K
PiA+IEluIGEgY2FzZSB3aGVyZSBhIHJlZmVyZW5jZSBhcnRpZmFjdCBpcyBub3QgcHJvdmlkZWQg
KGF0bGVhc3QgaW4NCj4gPiB0aGUgY2FzZSBvZiByZGlmZiksIGEgZGVsdGEgYXJ0aWZhY3Qgd2ls
bCBub3QgYmUgY3JlYXRlZC4gQnV0IHdlDQo+ID4gY291bGQgc3RpbGwgY3JlYXRlIGEgY29tcGxl
dGUgdXBkYXRlIHN3dSBhbnl3YXkuDQo+ID4gDQo+IA0KPiBGaXJzdCB0aGUgcXVlc3Rpb24gbm8g
b25lIGFuc3dlcmVkOg0KPiBEbyB3ZSBuZWVkL3dhbnQgdG8gcHJvdmlkZSBib3RoIHRoZSBmdWxs
IHVwZGF0ZSBhbmQgdGhlIGRlbHRhIHVwZGF0ZQ0KPiBhbmQgDQo+IHdoeT8NCg0KSSBkb24ndCB0
aGluayB3ZSBuZWVkIHRvIGdlbmVyYXRlIGJvdGggLnN3dSBhdCB0aGUgc2FtZSB0aW1lLiBIb3dl
dmVyLA0KdGhlIHVzZXIgc3RpbGwgc2hhbGwgYmUgYWJsZSB0byBnZW5lcmF0ZSBhIGZ1bGwgc3d1
IGlmIHJlcXVlc3RlZC4gVGhpcw0KbG9naWMgaXMgYWxyZWFkeSBhdmFpbGFibGUgdmlhIHRoZSBv
dmVycmlkZXMuDQoNCj4gDQo+IC0gTXkgdGhvdWdodHMgZm9yICoqbm90KiogcHJvdmlkaW5nIGEg
c2VwZXJhdGUgZGVsdGEuc3d1Og0KPiDCoMKgIERvd25zdHJlYW0gY2FuIHNlbGVjdCBkdXJpbmcg
YnVpbGQgaWYgdGhlIHdhbnQgZGVsdGEgdXBkYXRlIG9yDQo+IG5vdC4NCg0KWWVzIQ0KDQo+IMKg
wqAgT25lIHN3dSBpcyBsZXNzIGNvbmZ1c2luZyBhcyB3ZSBuZWVkIHRvIGEgc3VmZml4L3ByZWZp
eCB0byB0aGUNCj4gZnVsbCBvcg0KPiDCoMKgIGRlbHRhIHVwZGF0ZS4NCg0KWWVzIQ0KDQo+IA0K
PiANCj4gLSBNeSB0aG91Z2h0cyBmb3IgcHJvdmlkaW5nIGEgc2VwZXJhdGUgZGVsdGEuc3d1Og0K
PiDCoMKgIFdlIGNhbiBlYXNpbHkgc3VwcG9ydCB0aGUgdXNlY2FzZSBmb3IgdmVyc2lvbiBqdW1w
IHVwZGF0ZXMuDQo+IMKgwqAgZS5nLiAxLjAgLT4gMi41DQoNCklNSE8sIHRoaXMgaXMgYW4gaW5k
ZXBlbmRlbnQgdG9waWMsIGFzIHRoZSBkZWx0YSAuc3d1IGlzIGdlbmVyYXRlZCBmcm9tDQp0aGUg
aW1hZ2UgKHJvb3RmcykgcHJvdmlkZWQgaW4gYnVpbGQvcHJldmlvdXMtaW1hZ2UuDQoNCj4gDQo+
IElmIHdlIGRvbid0IG5lZWQgYm90aCB1cGRhdGUgZmlsZXM6DQo+IFdlIHJlcGxhY2UgdGhlIHBy
b3BlcnRpZXMgc2VjdGlvbiB3aXRoIGEgdGVtcGxhdGUgdmFyaWFibGUgYW5kDQo+IGdlbmVyYXRl
DQo+IHNpbWlsYXIgdG8gdGhlIGViZyB1c2UgY2FzZS4NCg0KVGhhdCB3YXMgbXkgaWRlYSBhcyB3
ZWxsLg0KDQpGZWxpeA0KDQo+IA0KPiBJZiB3ZSByZXF1aXJlIGJvdGggZGVsdGEgYW5kIGZ1bGwg
dXBkYXRlIHdlIGFkZGl0aW9uYWxseSBuZWVkIHRvIGNvcHkNCj4gdGhlIG9yaWdpbmFsIHN3LWRl
c2NyaXB0aW9uIGFuZCBkbyBzb21lIHJlZ2V4IG1hZ2ljIG9uIHRoZSBkZWx0YQ0KPiB1cGRhdGUg
DQo+IHZhcmlhbnQgYmVmb3JlIHJlcGxhY2luZyB0aGUgdGVtcGxhdGUgdmFyaWFibGVzIC0gdGhp
cyB3YXMgZG9uZSBpbiBhIA0KPiBwcmV2aW91cyBpdGVyYXRpb24gb2YgdGhlIHBhdGNoIHNlcmll
cy4NCj4gDQo+IFF1aXJpbg0KPiANCj4gPiBXb3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgaWYgeW91
IGFyZSB0aGlua2luZyBvZiBhIGRpZmZlcmVudA0KPiA+IGFwcHJvYWNoID8NCj4gPiANCj4gPiBB
ZGl0aHlhDQo+ID4gDQo+ID4gDQoNCi0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXgg
RXhwZXJ0IENlbnRlcg0KDQoNCg==

