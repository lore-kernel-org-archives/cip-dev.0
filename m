Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD95C433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 05:11:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web09.5988.1637039483462097064
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 21:11:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1AG5BKGA027610;
 Tue, 16 Nov 2021 14:11:20 +0900
X-Iguazu-Qid: 2wGrDIThzazbccqYa0
X-Iguazu-QSIG: v=2; s=0; t=1637039480; q=2wGrDIThzazbccqYa0;
 m=MuYNpq0lhLP8tGRYgWzEW07CXuKLCYKOaBX52mfxN1o=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 1AG5BIQS038409
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Nov 2021 14:11:19 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id CA3CB1000C0;
	Tue, 16 Nov 2021 14:11:18 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AG5BI1B025545;
	Tue, 16 Nov 2021 14:11:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA8ZQcNLUN6ss1RxKpzCfsG15CZspMQLjdSUogqjNgaX5XFd/OrHKRhCg8/Ue3U7GG/XayfHUy/d2XGTbhr1E0IKfb14uJiAw5wYUaHWpgcacnRtZb8jf7lEwIQ8rN122wUJ8DV964VwPRgba3BRm9kYs1AYeQd4yfn99fqcllh2ygBLCPFZeU+aYFsKiN71c+7Ve+eeueOJ1/NtdhdO1ZvXzLqk/ZJ02onkiyuIDE/pigsYrHskgrMbY4rKkh2Tx2UzlAZjNLPn3HqvWGgqBCKxAUBJLYXdUpIRcHnX+kwxayE3k8AYjBiks3f/LtGAVcsG8JuxjkfpfDqBvMd+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/dZwDKRHj8yMNsAvt0WXUL0MzAhr3RfQj//9H3WFfw=;
 b=KIhwE31uoMY/0mgENpKOqRXz5HGwDL29DdqCRoLl5oMDH+hiP9heeek2w6iXOVzEbHrNF8ftKElvBA3i3b5oGXb4P+tbSh4Su1dw0l93+1lTcPNFMYW3awdFbn9cUTcdnEaeBE7rKe8ADQAQKaaRTXhrdhUnq8309RRXBUd/BUW7sbNTu8Aq4n9aw1WzAtB+POqwX46jkdWCp/WPnzMKmCL9Rqj9aBCvMCIp8DxijcPxo7EP4a2LqlQ8jGV3TUBIxNZyNGfoPWUfQzTnlvojXVblH4a0lT8U2ickvHwI5vxAZLvKQDasPhPEjraqzUjVm/Th0RmGH1aNahmAP4AiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] [PATCH] cip-core-image-security: remove unnecessary
 dependency package names
Thread-Topic: [cip-dev] [PATCH] cip-core-image-security: remove unnecessary
 dependency package names
Thread-Index: AQHX2lEjpYYzxTgk+0Oddx0uF1GSvqwFiZSA
Date: Tue, 16 Nov 2021 05:11:16 +0000
X-TSB-HOP: ON
Message-ID: 
 <OSYPR01MB5542E50807C642D356B91EFFA4999@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20211115161554.24270-1-venkata.pyla@toshiba-tsip.com>
 <f222455d-19e3-d047-a4b8-afa5ad6f7700@siemens.com>
In-Reply-To: <f222455d-19e3-d047-a4b8-afa5ad6f7700@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f46c9d7-072f-4cd8-919e-08d9a8bf8488
x-ms-traffictypediagnostic: OSAPR01MB3923:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3923A928BD4974A127D50635A4999@OSAPR01MB3923.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 izb89KMRVOz8ZiVLOV5FfWBJrQLUiZeoNjcF04WynelOJuYAoJ6Yx/LUGMgs1HcFFUa5cHhaaB/94fFsMxn2ZtuvmZKSizlgtaIJSOz1eNiEp2O1b08w2j+gSo1NudHPklsvrj5PwcBVFDoAgGL28l5a1s7GLLYCBUX26hbLTt0PVFzQzOVVk9i4V2UTKLFxkkifFttKKg9XKYBXwTIxsMxa5HG3QgzSJ/kkEW3EH5ns0XuKBrlDoh/07Q0PocLTtYWZtYP4vxJ2C/TCWG9cWaCNikmw4mrAzi8/1tEhFHkSWtcWy/HEABOaPlBwMMXeBMN1R3qH7oyEbUN2XvnIKxeuyN0HUdaeU8ZhWWwO3bHO1mZHYAEFGtvN66vKii/kMrCjFSwB0Z94/cJKhhbDCWXkBY6HreTFDK14qVtDc5m0415AqG98XldnE/nfO7dpaKlZpfXNcToz+2Zavx3JZgjMCL4fLeNaz53KdL0aci7S5wfW1faVPHgSIU9w8vHg6413YsGES+N6T1r4uSSnYd77nbQEJZdu7CfnF9RIZw3JX4sNRShC+SrdBkixjZGqyZjSCJk1ZD1APxHD4+7RqYs5uVn8A2Vala3sF7HefNjl4/9GRqTcUYohAglVkyt19HSWaBTte/IGHynvHArCKAT3gpHyHrBa8I+zoLF9ghBevRdZSHo6KaUjxQxIk8knRc/80SjEfw6VafkXd7zZeA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(122000001)(2906002)(8936002)(83380400001)(5660300002)(38100700002)(38070700005)(15650500001)(66446008)(7696005)(8676002)(86362001)(52536014)(186003)(6506007)(64756008)(110136005)(316002)(66556008)(55016002)(76116006)(85182001)(33656002)(508600001)(66476007)(66946007)(71200400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dGE1RnhCZXkrdlNVNnlHemUxdkhoMHQ2WG1FUTJCZmFkM3VKVHNkSmlnc2hF?=
 =?utf-8?B?emJUYUI1QlJtNDI4eVdybjBacE5HWlFNNFlvQ21KOUw2aUNxT1hGRmJOM09t?=
 =?utf-8?B?cXVDM0FadzhvWG5oOG9MaGNic0lMUHRQMWtCVXJIbUUyVGc3Uk9DdlBvS0tT?=
 =?utf-8?B?cEJoS1g0T29qVXpXaFZwWEV4TTNlMUVoRzNuQ0pjL2JQcUxQOS9HUEdxTmt6?=
 =?utf-8?B?eEphS2VpckdVZTlCaTBMNVRaTGkzQ2tSczJRZDdRYlYwZjl1aExoM0toZkF1?=
 =?utf-8?B?QllaV0ZkSXpDbE5LKzhuM3NtZjNkQWlIMjg2WnFYR3hLU0RhNHdDZXphQlFw?=
 =?utf-8?B?SThYTTZDZnFwRnJOYXlEVnMrMW1BQktBRmlmZU1sTEdGajA4TFZjT08wV2dX?=
 =?utf-8?B?SmVqcVlJL3BuV3FXZ0FrSG9nRTl3TlkyblpLY1NwK1gxMzRLZGZ3RzE1Z1Uv?=
 =?utf-8?B?eXZ0anY4eWF3Q3hmUlliV2lNSGZWMzBIUjFMSHUxQ3dVZGFZek9hbnY3R251?=
 =?utf-8?B?RzZ2VEdHcEU0TEFPS2xjNzJ4WGQyME5FelhMaG9ISGo1eGQvNlg1WERGOHdB?=
 =?utf-8?B?RW5wWDZ4bFp0T01GeVZGOS9RRkFTbC9MZldRSmRMRFF6YmJEWmd6OGlDRWRO?=
 =?utf-8?B?UlJra0p1c2hkRHpRNWVybW9HYnhHaVlOODZJSVQ3UmVaM1BGNkFUY2RBQ1h0?=
 =?utf-8?B?aUR1SWUyRHVMaHdpc2QyamREZkRhY3ViY0lGdENCVkRtZjJ3S2lidjJERkJM?=
 =?utf-8?B?STZvaW9XT05GSTFIdm0vR1RtekZlL1F2T1RSSWgrcVFzUHFtelRGRFUwRTZQ?=
 =?utf-8?B?L1dTM3JXdmV1eExMblZVQktXNHhmVXJIVWVQbTMwR2ZCdFAyNGh0d1V6NkMv?=
 =?utf-8?B?MGNGWGJleklrTGF4Y3R4THhYVVc1U2JQMjFsdWEyR2ttYTdHTkltY0hEQ3Vh?=
 =?utf-8?B?d0gvMG5uRXhIUjUyWllKMTI5OGVBay9aYW5nNXZwRVNRSkJWQ1pTYWlORGhx?=
 =?utf-8?B?bFhqM0lWSVBrTjE1ckR4UzNWcGh0c2RNMzVmMVgvK3pQZHd1SlMvaTlUcmxp?=
 =?utf-8?B?ajJIVzVHT3hkcGNBVTA3VzRaVGQ3WldFdlk5eVZtVW9IRTQ5NSs3cit4RS9C?=
 =?utf-8?B?N3puaTBBSmdGM3d3RWczVVVDRXlmcmxsWTg5ZXZVRkJDdXRISHZDWTJlOGgv?=
 =?utf-8?B?TkJENU5XUjZDUXI0UEFjM0pZM3k0aDBuTWppY2ZPYzJPOHhEbFZKYlJ6UGtM?=
 =?utf-8?B?MUhaekd6ZjhrOXFseENtdWtCRmhUaUEzazBrUjBOSW1xQlo1dWZXWFNkdDRJ?=
 =?utf-8?B?bm9TUjQwUGVFM0lBQWtIZmNpbHVhWmZ6MjdWWkRONThFamh0dWVKNHNOdCs1?=
 =?utf-8?B?T3JVR0h6NnJETC9hTXE4djlmWVdEYUZHTHVuOWUzUDBWMkNYWUNyRS9YR3RM?=
 =?utf-8?B?cEl1MWFEM1d4MFVvNXJVS1BxZEoyRlVVRmdrUUlHeThrTFBOYUU4cGt3NWZl?=
 =?utf-8?B?aEl1K2RkZEVJV2ZENXhTUStJZ1ozRUNHMUs0OTV2VEhQclNweVBwNE1OQjAr?=
 =?utf-8?B?SDdMbUtQejVEbmZFc1RQSWxkQUxaOEp2MEQ2czc4NXpiaDdPbkhidlVJbU1S?=
 =?utf-8?B?SzFCRkZTOTA3akgreTdpM3kraDQyeUp2VTQwazZLUWllays0T3VQY2hpR1Ay?=
 =?utf-8?B?by9zb2ZuVVVnOWlIWmZVK0pjMnoyVlpDUnZCamE5djkxdkJ2MmxyVkJ4YmZq?=
 =?utf-8?B?L0ZnYUZMT0J5SGJab0V4OWozT0I3QUZvN1FLOHVJR3ZFUkRrWUVKRmdCR2ly?=
 =?utf-8?B?MjFYSjE4bHczRUl0elAyWmtoeEtocWx0TzdtTG9kZ3dpeTRVVnUxMFhVUjFR?=
 =?utf-8?B?UEZXdkhFWFJOZ2k0NnplZkp1aUlOUU8wVlQrQ0tPajN1eS81WTFRb01YS1VQ?=
 =?utf-8?B?TDFOcFdqQitLU1B5S1dnZjNpbDU5cWlWTmEyS05hWVVHL3hhS0JsWlNsaEFt?=
 =?utf-8?B?ZFZDWE1Uc2cwRXM0UG01WTB5ektZUC9GRHBHNmxZNDVMTGY4b09CYzVqQWhC?=
 =?utf-8?B?SUJIeEdnQjllNVVjaEp1WVVYWjk2R2p0YTRrQXpDQTh2QWN4ZjZza2dueDla?=
 =?utf-8?B?Ykt3R3J1UW1LcG91WDJPUkhXRnFuenZxTi9OUURFTkNxRHZ6MHBhWHJOdEs4?=
 =?utf-8?B?OVAxeXFTanRrRUMzdDBrNjdjWmtiSVYyb1ZnQXBIa2pmbmEvbXlFWXpkVWZN?=
 =?utf-8?B?MWdTZWRxWjBlK1QwMkN4WVdQdER3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7f46c9d7-072f-4cd8-919e-08d9a8bf8488
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 05:11:16.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 W+XfGS6HeqdHdtw8RKHgspkc9KNyFiEh3XJfxayXEVzYRkC0InCFzTtseCrJNestvakQVEujQEAvDbudYdxUICmSfG338kpV6J/Uj1n+OcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3923
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Nov 2021 05:11:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6922

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
DQo+SmFuIEtpc3prYQ0KPlNlbnQ6IDE2IE5vdmVtYmVyIDIwMjEgMDA6MTYNCj5UbzogcHlsYSB2
ZW5rYXRhKO+8tO+8s++8qe+8sCkgPFZlbmthdGEuUHlsYUB0b3NoaWJhLXRzaXAuY29tPjsgY2lw
LQ0KPmRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj5TdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtQ
QVRDSF0gY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHk6IHJlbW92ZSB1bm5lY2Vzc2FyeQ0KPmRlcGVu
ZGVuY3kgcGFja2FnZSBuYW1lcw0KPg0KPk9uIDE1LjExLjIxIDE3OjE1LCB2ZW5rYXRhLnB5bGFA
dG9zaGliYS10c2lwLmNvbSB3cm90ZToNCj4+IEZyb206IHZlbmthdGEgcHlsYSA8dmVua2F0YS5w
eWxhQHRvc2hpYmEtdHNpcC5jb20+DQo+Pg0KPj4gSXQgaXMgbm90IG5lY2Vzc2FyeSB0byBtZW50
aW9uIGRlcGVuZGVuY3kgcGFja2FnZSBuYW1lcyB3aGVuIHBhcmVudA0KPj4gcGFja2FnZSBpcyBw
cmVzZW50LCB0aGUgZGVwZW5kZW5jeSBwYWNrYWdlcyB3aWxsIGF1dG9tYXRpY2FsbHkgaW5zdGFs
bA0KPj4gYnkgaXNhciBmcmFtZXdvcmsuDQo+Pg0KPj4gc28gcmVtb3ZpbmcgdGhlIGRlcGVuZGVu
Y3kgcGFja2FnZXMgd2hpY2ggYXJlIG5vdCBuZWNlc3NhcnkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogdmVua2F0YSBweWxhIDx2ZW5rYXRhLnB5bGFAdG9zaGliYS10c2lwLmNvbT4NCj4+IC0tLQ0K
Pj4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmIgfCA4ICsr
KystLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFn
ZS1zZWN1cml0eS5iYg0KPj4gYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLXNl
Y3VyaXR5LmJiDQo+PiBpbmRleCA2MWRkYzM5Li42YzQxYjAwIDEwMDY0NA0KPj4gLS0tIGEvcmVj
aXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPj4gKysrIGIvcmVj
aXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPj4gQEAgLTE3LDEy
ICsxNywxMiBAQCBJTUFHRV9JTlNUQUxMICs9ICJzZWN1cml0eS1jdXN0b21pemF0aW9ucyINCj4+
DQo+PiAgIyBEZWJpYW4gcGFja2FnZXMgdGhhdCBwcm92aWRlIHNlY3VyaXR5IGZlYXR1cmVzICBJ
TUFHRV9QUkVJTlNUQUxMICs9DQo+PiAiIFwNCj4+IC0Jb3BlbnNzbCBsaWJzc2wxLjEgXA0KPj4g
KwlvcGVuc3NsIFwNCj4+ICAJZmFpbDJiYW4gXA0KPj4gIAlvcGVuc3NoLXNlcnZlciBvcGVuc3No
LXNmdHAtc2VydmVyIG9wZW5zc2gtY2xpZW50IFwNCj4+ICAJc3lzbG9nLW5nLWNvcmUgc3lzbG9n
LW5nLW1vZC1qb3VybmFsIFwNCj4+IC0JYWlkZSBhaWRlLWNvbW1vbiBcDQo+PiAtCWxpYm5mdGFi
bGVzMCBuZnRhYmxlcyBcDQo+PiArCWFpZGUgXA0KPj4gKwluZnRhYmxlcyBcDQo+PiAgCWxpYnBh
bS1wa2NzMTEgXA0KPj4gIAljaHJvbnkgXA0KPj4gIAl0cG0yLXRvb2xzIFwNCj4+IEBAIC0zMCw3
ICszMCw3IEBAIElNQUdFX1BSRUlOU1RBTEwgKz0gIiBcDQo+PiAgCWxpYnRzczItZXN5czAgbGli
dHNzMi11ZGV2IFwNCj4+ICAJbGlicGFtLWNyYWNrbGliIFwNCj4+ICAJYWNsIFwNCj4+IC0JbGli
YXVwYXJzZTAgYXVkaXNwZC1wbHVnaW5zIGF1ZGl0ZCBcDQo+PiArCWF1ZGlzcGQtcGx1Z2lucyBh
dWRpdGQgXA0KPj4gIAl1dWlkLXJ1bnRpbWUgXA0KPj4gIAlzdWRvIFwNCj4+ICAiDQo+Pg0KPg0K
PldhcyB0aGUgbGlzdCBwb3NzaWJseSBpbnRlbmRlZCB0byBsaXN0IGFsbCBwYWNrYWdlcyBleHBs
aWNpdGx5IHRoYXQgYXJlIHNlY3VyaXR5DQo+cmVsYXRlZD8gSWYgbm90IG9yIHRoYXQgd2FzIGlu
Y29tcGxldGUgYW55d2F5LCB0aGlzIGlzIGZpbmUuDQoNClRoZSBvcmlnaW5hbCBpbnRlbnRpb24g
b2YgdGhlIHBhY2thZ2UgbGlzdCBpcyB0byBtZW50aW9uIGl0IGV4cGxpY2l0bHkgYWxsIHRoZSBw
YWNrYWdlcyByZXF1aXJlZCB0byBhY2hpZXZlIHRoZSBzZWN1cml0eSBmdW5jdGlvbmFsaXR5LCAg
ZXZlbiB0aG91Z2ggc29tZSBvZiB0aGUgcGFja2FnZXMgYXJlIGRlcGVuZGVuY3kgcGFja2FnZXMg
b2YgdGhlIG1haW4gcGFja2FnZS4NCg0KSSBKdXN0IHdhbnQgdG8gcmVtb3ZlIHRoZSBkZXBlbmRl
bmN5IHBhY2thZ2VzIGJlY2F1c2UsIHRoZWlyIG5hbWVzIGFyZSBjaGFuZ2VkIHdoZW4gZGlmZmVy
ZW50IGRpc3RyaWJ1dGlvbiB2ZXJzaW9uIChidXN0ZXIsIGJ1bGxzZXllLCBldGMpIGlzIHVzZWQg
bGlrZSBiZWxvdw0KW2J1c3Rlcl0NCiAgUGFja2FnZTogbmZ0YWJsZXMNCiAgICAgICBEZXA6IGxp
Ym5mdGFibGVzMA0KW2J1bGxzZXllXSANCiAgUGFja2FnZTogbmZ0YWJsZXMNCiAgICAgICBEZXA6
IGxpYm5mdGFibGVzMQ0KU28sIEkgaGF2ZSByZW1vdmVkIHRoZSBkZXBlbmRlbmN5IHBhY2thZ2Vz
IGhlcmUgYW5kIGFsbG93ZWQgcGFja2FnZS1tYW5hZ2VyIHRvIGluc3RhbGwgdGhlIGNvcnJlY3Qg
ZGVwZW5kZW5jeSBwYWNrYWdlcy4NCg0KQnV0LCBzdGlsbCB0aGVyZSBpcyBwcm9ibGVtIHdoZW4g
dGhlIG1haW4gcGFja2FnZSBpdHNlbGYgaGFzIGRpZmZlcmVudCBuYW1lIGluIHRoZSBvdGhlciBk
aXN0cmlidXRpb24gdmVyc2lvbiwgaW4gdGhpcyBjYXNlIHNob3VsZCB3ZSBoYXZlIGRpZmZlcmVu
dCByZWNpcGUgZm9yIGVhY2ggZGlzdHJpYnV0aW9uIHZlcnNpb24/IFBsZWFzZSBzdWdnZXN0IGlm
IHRoZXJlIGlzIGFueSB0byByZXNvbHZlIHN1Y2ggc2NlbmFyaW9zLg0KW2J1c3Rlcl0NCiAgUGFj
a2FnZTogbGlidHNzMi1lc3lzMA0KW2J1bGxzZXllXQ0KICBQYWNrYWdlOiBsaWJ0c3MyLWVzeXMt
My4wLjItMA0KDQpUaGFua3MNClZlbmthdGEuDQoNCj4NCj5KYW4NCj4NCj4tLQ0KPlNpZW1lbnMg
QUcsIFQgUkRBIElPVA0KPkNvcnBvcmF0ZSBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51
eA0K


