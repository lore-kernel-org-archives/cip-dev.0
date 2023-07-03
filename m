Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0FBEB64DD
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 12:56:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.31898.1688388998307374156
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 05:56:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 363CuZnx2010777; Mon, 3 Jul 2023 21:56:36 +0900
X-Iguazu-Qid: 2yAbM4uBPvUMtpi6d7
X-Iguazu-QSIG: v=2; s=0; t=1688388995; q=2yAbM4uBPvUMtpi6d7; m=jvMFt1rfXz58ApUsHQL/0w5fcz3Q3iBWKZUo58NSA+U=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 363CuYvf2384577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 21:56:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq8yKJbgweVHD7n5cfIuYDPAsMTld+n1zGf8N/1SHy2dnw9AfV2cpf5eMY5EGjwfTKtBm/EyqGUJ/yQgU0NOZt0GhjzAjMmxiKTtLwiMlvqwbVkfIMdm5myy2H0geiHVV8khyFHhqhx/aLVRFP2S5SbtmhdMFcosCbTzSWNqTNA5grNyILNh5SZFuk4YBy7NltSrpAIZiY+2cl3H6UKPgaQajFURWaLX+0OmqmG8EMq23u4+rqzmllxRp9SfSqOkg6En6j04rIkMxxcNBbqai/7jFN4W1Bp39H85U9SakyDBtTxF0E4TcSXystjHktqFgG+r1sZheV/eC9FaILMdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/45ktJEYGUy2BF2CHViRUBb7IO9lh4kbe04q2y8UhU=;
 b=YLaj7vih1Mwio+KwrYisXpRc4ZdA/Z50P6p+rAZeN/paigvrR5pktlSXBLPyUic3h9y1mEWPYRE/AaXJLDrozLsCfefQszY5GI1LmGuLNPNsYf02swJRkLcVQHdvEtNR9mlkyBCBTsPEP3bgzd2dBviQCQ3iaD6zDjYWwRq7Yo9OT3Zx4urDzFHhbfoS8Z6o7BgYexIS6S+I4gDdNWNaCkw87xM/5aPUeqn92C0jMX81ZPr6C+2myzBG9+oKghCzcGWspMj6y7OHr4+/ovRq7Fg2/gIdzt2q+cYm3pGMbry3/LLe78nas7K14xfDK24ayYpmAwBgtpBV52T43Z3S8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core v2 6/6] swupdate.bbclass: Fix file
 timestamps are not reproducible in swu file
Thread-Topic: [cip-dev] [isar-cip-core v2 6/6] swupdate.bbclass: Fix file
 timestamps are not reproducible in swu file
Thread-Index: AQHZrXbDArUjYdWQ/kmknQUHSrKX36+n3tYAgAAf/1A=
Date: Mon, 3 Jul 2023 12:56:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB554234148FB63F3766AE4D7DA429A@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
 <20230703062231.18183-7-venkata.pyla@toshiba-tsip.com>
 <83abf77f-5c2a-1e10-25ba-e63cb205bdef@siemens.com>
In-Reply-To: <83abf77f-5c2a-1e10-25ba-e63cb205bdef@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5542:EE_|TYAPR01MB6059:EE_
x-ms-office365-filtering-correlation-id: 9537f3f6-66fb-4b3d-58d4-08db7bc4ed17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Eu8WtuIkUpoxKp6sDvqxwTZTrJs82sZY8P5Ta+A4l8zwVUt5jpXjcDOrcu7VgzRbAXbYPQe0+XyfxAg4gqcyLLju5Ud+oM6+7WpzuctfNT+9dcKX+7gWzB88/HA8KpHtI5h0XoD4JZeXZvQo8r/W8cGuttU3VojG40giwXULP/wnENxhritK+W+J5owA3bLWAQgdmxVIjhXQwyrsgMgiG0Doe64aA+rlU8kBD9ycX+IwcZYM7IAWcin/EpNTywPlynbF3oinV6QoKR03lvYFDPq6OGxYFx9e8elSpWTNjiNfBrx6KnxMysvAtvBdIXvNRucJ06WUB/Ld5bvqN0ni0zoQCs7vV6qwswSxzcCC6FYd+Jr9T/WPxYhyBRn0AMYGB8SQX0vyzPS74Wg4WbO2UXOp3Aydb2QUI9MusyfVYeGn9RYDOrhPTK2fEA0pAr5f6EEvDe7JmXH7v0vSuMQJWaJ9wI2N0usjxyGA/HvX7vuOffVNJqwW+TFFaaHBUDR6UzN9TcnFopsGbp0FXMNIu67r4rJMKX3ItG19Zp7pWS5oBit5WrsXMSkLNZ9XDJ7JyvKCygNFlkj2Yuzy65KSk+DkMRC07Ldy3ftO55y1ENk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(26005)(107886003)(478600001)(9686003)(71200400001)(6506007)(86362001)(186003)(38100700002)(54906003)(66446008)(6916009)(66556008)(66946007)(64756008)(4326008)(66476007)(83380400001)(55236004)(7696005)(76116006)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(38070700005)(41300700001)(2906002)(55016003)(33656002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?N3dnQndnWkc5SGJDWHRXTWpmREJQalpYd2pKeGlwS3JiQkpYVTFTcmROd2g3?=
 =?utf-8?B?Q200ektmV3BtNktwdjQ3WlJvYUU5Q0VXUlJIM1ZpUkovbmpZVjhTT1U2QWNa?=
 =?utf-8?B?cW1NNUY2YzkwemF4OHJNalJpL0k3VTNuSFRPTzQrZGdEcE1MSjR2d3hnaGhH?=
 =?utf-8?B?VW12TnVTSEc0ZUZlRHpid2orS1ZoaVJnUitGVGEvN21MNFpnT0FMUWRjdS9J?=
 =?utf-8?B?TmZraExINkVJUGplRjN6RnRwSUFOVlNxblJUN3UrQk9TRkNtVDJwNmJRU1Fw?=
 =?utf-8?B?RThMNWM5ajFaQWlBb3VmYjVvZHlocXFLREJLbExrOC9rUmlUWVg0di9UQkZD?=
 =?utf-8?B?S20vZElvRDlhb2xBclk1SXp3ajFvZWphMUtUOFQ4L2RJTDVRM3l2VHI5Y043?=
 =?utf-8?B?UVY2VkQyZTNGcjBlQ0d3WW5NdFU4N2ZXL2tLa0dkVHhIQlZKa0ZSQkJXQUsz?=
 =?utf-8?B?ZEtRNlM0VWtSSmttVGJWa1VuWndyWm82NmQ2U0s0bkRVcVFUaHAwSjlNS2xU?=
 =?utf-8?B?VXUwdUhCMURHVnF1MUlxQlFrSUdUeGltVEFUdmxPYkswZFNVS2dOL3lmK0RB?=
 =?utf-8?B?dFJwNDNZZDduMFRUMmc2OEg5aEROUXZCaXc4d0liUW9UcjRrbTMreFlwaHhZ?=
 =?utf-8?B?QVJxaCttcEJqQXRIeUthak1yUmQwQU52ZythYXo5YzRHc1FMZVJCYXp1WmJL?=
 =?utf-8?B?TUsrU3k5UGpjUzNlZ1dkdkZWc3grWEh6VjRFREVYajBjdlozbUMzWEFhK1Iz?=
 =?utf-8?B?Q2FmSlBELzJtck1ScU1YcEVJSjNjUlErUUZGTTlYbFlZS0tDVm5sdVZhKzR2?=
 =?utf-8?B?azdURkVVMWdxVDhOR3lpL3crUSttcW9tQ0NuYUhBeTYvcXd5aFU3eXhUcjRN?=
 =?utf-8?B?SDdTL1hxSDlQRjJ3QTk3bFJRbU9ITmRHQi91QVhsSmFvaklQWXhoZXRuN3lU?=
 =?utf-8?B?QnU2MTRpNGxRUHlmY2JmSXJzNlZtZUJ4TnYyY2I2T2cvNXpLR3hOb2hGRVcr?=
 =?utf-8?B?N0pLdjhJMWhadkxYTTFhc3NLeU1mcGhWdkpCL3ZhTEw1VUtYbmJBN1BZd0ww?=
 =?utf-8?B?N1ZveGlVTGRvaGs5S2dGbVp0ay9BRmd6T2FqejMwREJPNURpYS9IamZkTnFM?=
 =?utf-8?B?UkFwY1FOQngxdUllMnhoNnNTc1ZMWEI3U3l5LytzZzBXckpoaDRjNzVQbGQ0?=
 =?utf-8?B?VDIrVDBQWTVuWjd1WE5sM1JOamdVQXBXZWVWMytHK05ENWdHeVl4TEE0am43?=
 =?utf-8?B?ZUlUK1Qrc2l0alRSSFRSajZLTEJLbWs0dEtxazltZ21TUlY1Q2RWZTZEUlN2?=
 =?utf-8?B?d1NsT2ZpQmh3RVFuUldpcE1XcXg2ZFJXREwyYU9GVks5SFVDWEpRaEdvWS9s?=
 =?utf-8?B?RXdVYitMelpXcEszc2ZhUXc2dnQxenlwMjJ2MklBSWJ3cHRvaWFPQVRYdkQ2?=
 =?utf-8?B?ZldqbE1OSEN1RWxtRGM1dGpKTUNubElRQ0xZdStscnVIcDhxL3RrTlhmcUVv?=
 =?utf-8?B?SG5HekhJWVgzMWQyMjNJN0pHaVBXQ0FkakRmYVhRTmkzSFlvRVYyMW9FTkxj?=
 =?utf-8?B?Y1NtR0JPb3oxS2F2QWxtZVVPWk1vQkpqaFF5RmRjNkhpdi96aUpOdXVHM0dn?=
 =?utf-8?B?YnoybDBGaUdWZmRaNWV0QlBwL3l4K29lblcwU2hPQWM4VUxZTDFOSkNaLzZk?=
 =?utf-8?B?THM4MGM4YWJVMVVwaWVTb3FsQS9zZE9Nd2VZZjBqb05ldEFyeUZmbDUvaExD?=
 =?utf-8?B?bythVnNxbytQcmlBU092dE02UnR6R25HTGM4YWFtQzkvKzRsVEptT3FjZ3E1?=
 =?utf-8?B?OWlOZmNzaVVNaCt5d0orbVNhRlU1MVh6Q25qZzIwZ0VvZnNvcC9aclg0ZDVE?=
 =?utf-8?B?NFZBTkhaZjZnQWJ6LzU4VS8yQUoyN3NvY0liY0Q3U1QzSVZSRzBsWlpBa0JF?=
 =?utf-8?B?NzIva2txaHV1dWY3QjBSeWxvdXl5Y1g2ZUQ0Tit0UFlRSkZQRkZGR0JqKysy?=
 =?utf-8?B?aFpvZWNySGdRajF3bVRlMGFudjRTazRPRjdEV1M0VllBemV6OXVJZ0t6eUo2?=
 =?utf-8?B?TzhPVjNVTFpsNGtXdDEvNW94bjRSVzhEODJQZG5XU2tBMjdLT1pUZXpkNy9o?=
 =?utf-8?B?b3YwWjNjZm1DMW5BVUJxMnRSN2dwUW95bEZDeGtKUXRoTlc3MHVhWlJORjZJ?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WdH/3ruC5++D222doR1YvJtu/Fwi0SfSV8TTCf8YqshiVcwODfrFM42B5+cOoe5S5hVs+DbeZsXuS4qX4OVRbBQz2Mn1UFLLyDSoucZsvyNS91VSGqDV8IeLmU/8Ek5lke1t3McQDD0f0eQ1peD3mKVnpxkCSfM01ncy3kppQ0//scepCNlQA3n21eOClIgtPYNBEiLO5ijPHpCRwq3Njl6eZtdaOVQ0So/OQKQLjLErCPghQLESOk8pJlp1GpIatqCaSrDVLzCyy/ZfHDvs8oDDChGQ9QZsBXiieNZE1OY54ZoEdZRlzDL7fK/TVUU/oywrLP7d0zqWlheSQQFP2T1bO1vJV49YLten0AmT6sZqtVww5dbQ2Q7z8yt1o/mAgRFhyCZDreOuzLcONzHByGkB6XqCRFwT0AjWr7u4lswvlyckZm76ikFh1ghSDT7jzfWKgigqvvljSVf6t/xQb5rwJgrd37DYv1sQWZvcmEbL0urL0N4g8EzaYojkqO6T7T8r2copvdUvuRPQoFG0ytOeGIpOCvk1LlB+j4p5ALjzTcksVc9mXVo2J/Abmq+8qZtjmDO6e2tPlXLcLFgODXZtus+PnP97fv4iG+sC+m9xyQ5L38vT/0gzPo0id3Fgv1AfJyqGtJKYPeQOmk+xwDScZWM+giAyznrVkKA/eIdcNHL9zPq9jqIe4BrlHlU3ju/oiPuab76tyHtj6P8UqH5SK85cVAWwLj4QMyQ8LWyXroRX1+ySr3rneb+z1GNfW+kVZX5YiB379iyPtB+4M6QiqL/gHB+DcNbaleeiklK7sueLL8kN6Lzite9LFk/h
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9537f3f6-66fb-4b3d-58d4-08db7bc4ed17
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 12:56:32.4201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Efju20+M17ZpyKquImcq4YOHUww2KUKJ5frdYrRKWZ8/FwS07obWZiTt08f5Hx5bRSzOQJ1vbOFkzEOBBApoOWlWzYnUBPC6BZdXjl3LDac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6059
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 12:56:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12181

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+U2VudDogTW9uZGF5LCBK
dWx5IDMsIDIwMjMgNDoyNiBQTQ0KPlRvOiBweWxhIHZlbmthdGEo77y077yz77yp77ywIFRNSUVD
IE9ERyBQb3J0aW5nKSA8VmVua2F0YS5QeWxhQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPkNjOiBkaW5lc2gga3VtYXIo77y077yz77yp77ywIFRN
SUVDIE9ERyBQb3J0aW5nKSA8ZGluZXNoLmt1bWFyQHRvc2hpYmEtDQo+dHNpcC5jb20+OyBoYXlh
c2hpIGthenVoaXJvKOaelyDlkozlro8g77yk77yt77ylIOKXi++8pO+8qe+8p+KWoe+8re+8sO+8
s+KXi++8re+8sO+8lCkNCj48a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4NCj5TdWJq
ZWN0OiBSZTogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlIHYyIDYvNl0gc3d1cGRhdGUuYmJjbGFz
czogRml4IGZpbGUgdGltZXN0YW1wcw0KPmFyZSBub3QgcmVwcm9kdWNpYmxlIGluIHN3dSBmaWxl
DQo+DQo+T24gMDMuMDcuMjMgMDg6MjIsIHZlbmthdGEucHlsYUB0b3NoaWJhLXRzaXAuY29tIHdy
b3RlOg0KPj4gRnJvbTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNv
bT4NCj4+DQo+PiBUaGUgZ2VuZXJhdGVkIC5zd3UgZmlsZSBpcyBub3QgcmVwcm9kdWNpYmxlIGR1
ZSB0byBpdHMgZmlsZSBjb250ZW50cw0KPj4gYXJlIGNvcGllZCB3aXRoIGl0cyBidWlsZCB0aW1l
IHN0YW1wcywgc28gc2V0IGFsbCBmaWxlIHRpbWVzdGFtcHMgdG8NCj4+IFNPVVJDRV9EQVRFX0VQ
T0NIIHZhbHVlIGlmIGl0IGlzIHNldC4NCj4+DQo+PiBDbG9zZXMgIzY5DQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+
IC0tLQ0KPj4gIGNsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcyB8IDEwICsrKysrKysrKy0NCj4+ICAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcyBiL2NsYXNzZXMvc3d1cGRhdGUuYmJj
bGFzcyBpbmRleA0KPj4gYWM1OWMwMC4uM2QyYjVmMCAxMDA2NDQNCj4+IC0tLSBhL2NsYXNzZXMv
c3d1cGRhdGUuYmJjbGFzcw0KPj4gKysrIGIvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+PiBA
QCAtMTE1LDYgKzExNSwxMCBAQCBJTUFHRV9DTUQ6c3d1KCkgew0KPj4gICAgICAgICAgZG9uZQ0K
Pj4gICAgICAgICAgY2QgIiR7UFBfV09SS30vc3d1Ig0KPj4gICAgICAgICAgZm9yIGZpbGUgaW4g
IiR7U1dVX0RFU0NSSVBUSU9OX0ZJTEV9Ig0KPj4gJHtTV1VfQURESVRJT05BTF9GSUxFU307IGRv
DQo+PiArICAgICAgICAgICAgIyBTZXQgZmlsZSB0aW1lc3RhbXBzIGZvciByZXByb2R1Y2libGUg
YnVpbGRzDQo+PiArICAgICAgICAgICAgaWYgWyAtbiAiJHtTT1VSQ0VfREFURV9FUE9DSH0iIF07
IHRoZW4NCj4+ICsgICAgICAgICAgICAgICAgdG91Y2ggLWRAIiR7U09VUkNFX0RBVEVfRVBPQ0h9
IiAiJGZpbGUiDQo+PiArICAgICAgICAgICAgZmkNCj4NCj5Eb2VzIHRoaXMgd29yayBmb3IgU1dV
X0FERElUSU9OQUxfRklMRVMgYXMgd2VsbD8gSWYgSSByZWFkIHRoZSBjb2RlIGNvcnJlY3RseSwN
Cj50aG9zZSBhcmUganVzdCBzeW1ib2xpYyBsaW5rcy4NCg0KWWVzLCBpdCB3b3JrcyBiZWNhdXNl
IHRoZSB0b3VjaCBjb21tYW5kICh3aXRob3V0IC1oIG9wdGlvbikgY2hhbmdlcyB0aGUgb3JpZ2lu
YWwgZmlsZSB0aW1lc3RhbXAgaW5zdGVhZCBvZiB0aGUgc3ltYm9saWMgbGluayBmaWxlLg0KDQo+
DQo+SmFuDQo+DQo+PiAgICAgICAgICAgICAgZWNobyAiJGZpbGUiDQo+PiAgICAgICAgICAgICAg
aWYgWyAtbiAiJHNpZ24iIC1hICIke1NXVV9ERVNDUklQVElPTl9GSUxFfSIgPSAiJGZpbGUiIF07
IHRoZW4NCj4+ICAgICAgICAgICAgICAgICAgaWYgWyAiJHtTV1VfU0lHTkFUVVJFX1RZUEV9IiA9
ICJyc2EiIF07IHRoZW4gQEANCj4+IC0xMjksOSArMTMzLDEzIEBAIElNQUdFX0NNRDpzd3UoKSB7
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgLWlua2V5ICIke1BQX1dPUkt9L2Rldi5rZXki
IFwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAtb3V0Zm9ybSBERVIgLW5vc21pbWVjYXAg
LWJpbmFyeQ0KPj4gICAgICAgICAgICAgICAgICBmaQ0KPj4gKyAgICAgICAgICAgICAgICAjIFNl
dCBmaWxlIHRpbWVzdGFtcHMgZm9yIHJlcHJvZHVjaWJsZSBidWlsZHMNCj4+ICsgICAgICAgICAg
ICAgICAgaWYgWyAtbiAiJHtTT1VSQ0VfREFURV9FUE9DSH0iIF07IHRoZW4NCj4+ICsgICAgICAg
ICAgICAgICAgICAgIHRvdWNoIC1kQCIke1NPVVJDRV9EQVRFX0VQT0NIfSINCj4iJGZpbGUuJHtT
V1VfU0lHTkFUVVJFX0VYVH0iDQo+PiArICAgICAgICAgICAgICAgIGZpDQo+PiAgICAgICAgICAg
ICAgICAgIGVjaG8gIiRmaWxlLiR7U1dVX1NJR05BVFVSRV9FWFR9Ig0KPj4gICAgICAgICAgICAg
ZmkNCj4+IC0gICAgICAgIGRvbmUgfCBjcGlvIC1vdkwgLUggY3JjID4gIiR7U1dVX0JVSUxEQ0hS
T09UX0lNQUdFX0ZJTEV9IicNCj4+ICsgICAgICAgIGRvbmUgfCBjcGlvIC1vdkwgLS1yZXByb2R1
Y2libGUgLUggY3JjID4NCj4iJHtTV1VfQlVJTERDSFJPT1RfSU1BR0VfRklMRX0iJw0KPj4gIH0N
Cj4+DQo+PiAgcHl0aG9uIGRvX2NoZWNrX3N3dV9wYXJ0aXRpb25fdXVpZHMoKSB7DQo+DQo+LS0N
Cj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+Q29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGlu
dXgNCg0K


