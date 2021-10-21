Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9BEC433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Oct 2021 08:42:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.6559.1634805722059040834
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Oct 2021 01:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 19L8fxvN007290;
 Thu, 21 Oct 2021 17:41:59 +0900
X-Iguazu-Qid: 2wGrZzhrwJOVXP8SF0
X-Iguazu-QSIG: v=2; s=0; t=1634805719; q=2wGrZzhrwJOVXP8SF0;
 m=O03qaue/cK8BEEhrNvEuO1mGl8o5eQqmSlhmOFl2GHY=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 19L8fw6B023321
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Oct 2021 17:41:58 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 4680B10013A
	for <cip-dev@lists.cip-project.org>; Thu, 21 Oct 2021 17:41:58 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 19L8fuo3008953
	for <cip-dev@lists.cip-project.org>; Thu, 21 Oct 2021 17:41:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkmFD5LJMcvNlHaADZr68d5KFZ0paFusQC7Fkm+Wxnfc8CDQgWfnIVwXP1L3FkenejaUz1c1hw+roDx6c/n28hXEqX+LD6kn4D3xNHh2RVsjyLSS0mVBROFgm8lsLpJIhXbEO4bdmFfw/ifT/ya2Bm05bOH6hWIfMx6TMto3O7r+xJRJss9KDVCcQctLSMGU+ZPkt6cCdHXcX7EsALr91yweoHXHUSJMEABzoQmJyydUVll3qzc8uLep/Ta0F4Q47H0u6t8U0o1iihiwuMceBNwZ4VKG1nrLdXdlMHtFpqn5LGGNHsohbaflbEZWA2Obxx6ccs+Nkf3GyJGctVkp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSfxlrYBPqso9nR2NnyBnw05Pgv2qhXpIHtt9R3An0Q=;
 b=XcL5PMVQqlOlzP1sexv39AGWlVxxHe1lVMLhMnIEjZN+E8s01RIOwLALicDAEZALQLw6lWNTx8hr8sUH14ln8t4qt8K6jGKeLTTaqWkHb5H5WjVCucAFTmL4ZMli73PIW6bLsllX8wFPMJiT4k6MtANr+PHOqhS5BZhs3OnehlViuUQ6Eu8NUAutzoLG2vB1dYImyz5fxKevoXGi/AVKcjozXDyt1CGqFdHc0BmwvevSBWNv5Jp4W0aBeFeQLtB3o6pBLyPtsAtZrI6g1qGkk+H8NmDeCMp1oeN3SXHF10Ph4K9AfUNOpPu9Tx2W+1FYSQcdqPhl0qzZR0t5b0yeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] New CVE entry this week
Thread-Topic: [cip-dev] New CVE entry this week
Thread-Index: AQHXxhoWt4LQTotfvUurT+Bu62vl6KvdIQWw
Date: Thu, 21 Oct 2021 08:41:56 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252AC6CD63FCF8BEC76A78C92BF9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <CAODzB9pMmbJugyNLdvOOifW1Tm+1NhnsUi+zQBdRaj3Z=aC+fw@mail.gmail.com>
In-Reply-To: 
 <CAODzB9pMmbJugyNLdvOOifW1Tm+1NhnsUi+zQBdRaj3Z=aC+fw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ede8d3a5-2c3e-4174-045b-08d9946ea3bb
x-ms-traffictypediagnostic: TYAPR01MB3855:
x-microsoft-antispam-prvs: 
 <TYAPR01MB3855A46D70DC112F1C7F45D892BF9@TYAPR01MB3855.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nMzmbkYzLRgt0H6SlZWibvf5QX1i+yMLa0PZ1OLwcw3+TsFu4q3YYZKV7H/vRACSRyen44DO6OHxP91oLbaHyMWugAQ9szBpxQ2HVkWf0lZ5YLqAT0bJFZD8ZL4KzCe0rbiXLxcPuvR83IOiV7lfNfek4/f3YwrprWC2AVB0QJOOBqIvZIfmRF+PyEX0O8ves1CYTEif44yDGR1ksFvNiU56Nd4zsVNVIo8X6wVE1jYvt+YeeqWXsDP6yg+YUrIbgwCegtshMlCe1sEpQ0hgrp6b5bbwDd8fCvYFJpUK1QRw6BMXPKa9POrnAiN4Xghxk242ZV9m7xfvX/RVluJ+zxlMRjbJF0+piC9roQw8/UX+2SN1MOnQNQmiyPJgqCfYqatwwgayFsm82ZePcfgGOdiknP72YeITMK3N578d7SsbwIMdq+CyNok7hcdKWUNWe1IZzyuY5ZUfyjudYTgWmxNUGZar0G4gqvU98E8yt0RKYiOFtNSxlgQ5JnTSHYZu65CdC6M13nLu/S4qaTDY/OPpildDT8+w7qa4FhPfYKUmda991p1FrNnQU/9nRoxbhy6/YEhpGifLlF5QussSJxNcmcLytvzokaYds2gk1zYWGofRSsPeNjn/pXx/s4WzZBmawukSmH6bZ7X5kpi8fYhhHnXBR6tq+4FhB3w+dLAKwpMvgO2Ui/kk8Nm+51KR7ZqdpE+m+1/tvS2vec+f1ceAPLxQQpTloYl6FbEWk78jp8dUyK38Vff1+vaDwaaEAYvZ9j3kUaxL6VPvP1FisHZEBBgQkYEUW2yeSmI88VY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(71200400001)(122000001)(53546011)(6506007)(26005)(186003)(7696005)(8936002)(508600001)(33656002)(66556008)(76116006)(66476007)(64756008)(66446008)(38100700002)(55016002)(66946007)(2906002)(38070700005)(9686003)(6916009)(5660300002)(316002)(83380400001)(8676002)(52536014)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cXhjSU9HRGczTE8zaXZuV3pLcXdWUHhmR2RXNk9NUm5xVUtVeC9wNmFnOURG?=
 =?utf-8?B?dWEvbVoydk1DKzUzS1BEdmx2dm9RQ0xiRFcxdkxvYzcxcnBpUmhKcVZYTzJ3?=
 =?utf-8?B?dlpxbWJPVjNadm4ySnNmL2k3WXlGTHZkcGZHNjVZTXlkUEdjem5VNU1lYnVZ?=
 =?utf-8?B?ZTZqRjRSd0RsRjk0OHlPcllTL296UXoxdzcwMGpJVkw3U0t6TVppWjR0QlR3?=
 =?utf-8?B?Q3ZyY3UxdGorNkVNbVNoWkJ0WHBlSTMxcWlmMmR0c1JiYVBCb2tpR2ZmQXlC?=
 =?utf-8?B?MXJwYkNhMDBoTjdKYjUrbENwZWtOMzZ3YlJyamdYK1NrUXphMllxWXcyeHlF?=
 =?utf-8?B?OGNpc3N6MTJaMTVPaWd6bnlrcFZWVWo5V2gxTXlzZFczZlZXY3pUOU9lY21D?=
 =?utf-8?B?RmNSbktyMWFwYUZKNnp4cE1yRVhZS01jbWdoTzdqcmZaNzk3K0xyVjQ4T1FH?=
 =?utf-8?B?c3lPYzU1WHgrV1A4OUJaVkFuVzVzd3k3RE9QWTlZaUNUazJsdjRHNEFwS3da?=
 =?utf-8?B?UHFTQWwzVmhsUTRTd0FZNnYyM3FZd29Cc2FiUURUaDdjS2dZcFNGOGcxcUV2?=
 =?utf-8?B?Z2ZjbmtJcGF1djhwaTU2R3h3Zy9tZnBFOVRyMytyK1VKT0ZJbG1lR0Yyc3FB?=
 =?utf-8?B?cll1Zk1MVGMzRmlwZDBXVnQ2MUxtcmRlazZHNHczNzBMdnpJV2pSWWI4bGx3?=
 =?utf-8?B?eXg2bkxZc0RwU004MUhwYjdRY0h6OU1ZTVIrUmhLblQ3YTg4UXNYNWl6ZE1m?=
 =?utf-8?B?NXFKQ0h3djRiblFQU1pZSjRReHRQeDE4SlQvT2J4S1JBOVZmR0RkUXg2czBM?=
 =?utf-8?B?Wnpvc3FPTTRlT1BTUks3ZFNoODVwNVExR1hGNnBQczBQQzRnLzh4SGxGNmJX?=
 =?utf-8?B?N1F2cC9wWm1OV3V5UXJldkE0cDlPY09LMEdLOUczNllXSzdMZ0ZGWk5Yeldo?=
 =?utf-8?B?TURsTEQ5Z2xIMjVrRnZmRDFQZjFYU0NUOGp0ek5mdThORTRJRWlvMWR5b0Iy?=
 =?utf-8?B?REJUWk94RFhLQ1RKNnNUekdxRjVjcklMMTJzTHY1UUtqaS9lVzVoRCtPNVF4?=
 =?utf-8?B?VENkQ1FramxGbnpheDd1WXAxTG5WblUvaUZuWk55dmMzNklWWXNVOGJWYnRj?=
 =?utf-8?B?NldJcmRlWmZsUUh1QXFMc0RUcjhtelhscm9pbjloN0VFdlgwVFE3QldqUmhH?=
 =?utf-8?B?ck5ZSm1pdjFEaHVyMk1BTU1JK0MvaktGQW5hVUlqQXk1cnpvV1AvRzFYWjFZ?=
 =?utf-8?B?L3liQkdQRVYzMEN3aWpXb0MrY0djYmd3WVY3S3J3YWJkaVY1Y0lRaE5uWjVY?=
 =?utf-8?B?M2xwM0xjWWFsRk5rMmFiY1ZjWmJjRjl0WFVFZm00bVNmNlk2V0QwRk5JNENy?=
 =?utf-8?B?REdweTZndEZuY3A0VlViaGRlZjhCZ3ZjTGNoRWJ1a2tTbFh0WDh5Rk1PMU5a?=
 =?utf-8?B?cWtzRmJuaEYyTEpkWHdmZjhWT1hPZ2FJYldmVVE2NnhSMW5LSGF4Z2laY0dm?=
 =?utf-8?B?aVUxdzRkY2RrOU1SOEdnT3IzNXd3SXZnN3ZMYks3ejhIdUZyNTdoSU95Vk10?=
 =?utf-8?B?N0tvR3NucjRtNzZ1Y1JHcTZQSTNSMzRXVDlOM01CSU4yR3lYcnF2TWlJVENx?=
 =?utf-8?B?ZjRkUWdQYzBjQllSZnFIeEhUQnYyMENVZXhUdWRNanFkU1lHeHVsQ2dOa1Ux?=
 =?utf-8?B?bjZFMUsrbjd2VEV1Ty9BRERyR2gwZU5WeFBzeDR6UURzMElTN1pSeXBtb3Jm?=
 =?utf-8?Q?bnx5QOkL+lVTFaGoQalebZvf6irhpkQayI4MpPd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ede8d3a5-2c3e-4174-045b-08d9946ea3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 08:41:56.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nobuhiro1.iwamatsu@toshiba.co.jp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3855
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Oct 2021 08:42:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6834

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIE1hc2FtaSBJY2hpa2F3YQ0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAy
MSwgMjAyMSAxMDoyMSBBTQ0KPiBUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmc+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBOZXcgQ1ZFIGVudHJ5IHRoaXMgd2Vlaw0KPiAN
Cj4gSGkgIQ0KPiANCj4gSXQncyB0aGlzIHdlZWsncyBDVkUgcmVwb3J0Lg0KPiANCj4gVGhpcyB3
ZWVrIHJlcG9ydGVkIDcgbmV3IENWRXMuDQo+IA0KPiAqIE5ldyBDVkVzDQo+IA0KPiBDVkUtMjAy
MS0yMDMyMDoga2VybmVsOiBzMzkwIGVCUEYgSklUIG1pc2NvbXBpbGF0aW9uIGlzc3VlcyBmaXhl
cy4NCj4gDQo+IFRoaXMgYnVnIGlzIGluIEJQRiBzdWJzeXN0ZW0gYW5kIHMzOTAgYXJjaGl0ZWN0
dXJlIHNwZWNpZmljLiBQYXRjaGVzDQo+IGhhdmVuJ3QgYmVlbiBiYWNrcG9ydGVkIHRvIDQuNCBr
ZXJuZWwuIEhvd2V2ZXIsIGFjY29yZGluZyB0byB0aGUNCj4gY2lwLWtlcm5lbC1jb25maWcsIGl0
IGxvb2tzIGxpa2Ugbm8gb25lIHVzZXMgczM5MCwgc28gY2FuIGl0IGlnbm9yZSBpdA0KPiB1bnRp
bCBzb21lb25lIGJhY2twb3J0IHBhdGNoZXM/DQo+IA0KPiBDVlNTIHYzIHNjb3JlIGlzIG5vdCBw
cm92aWRlZC4NCj4gDQo+IEZpeGVkIHN0YXR1cw0KPiANCj4gbWFpbmxpbmU6IFtkYjdiZWU2NTM4
NTllZjcxNzliZTkzM2U3ZDEzODQ2NDRmNzk1ZjI2LA0KPiA2ZTYxZGM5ZGEwYjdhMGQ5MWQ1N2My
ZTIwYjVlYTRmZDJkNGU3ZTUzLA0KPiAgIDE1MTFkZjZmNWU5ZWYzMjgyNmYyMGRiMmVlODFmODUy
NzE1NGRjMTRdDQo+IHN0YWJsZS80LjE5OiBbZGRmNThlZmQwNWI1ZDE2ZDg2ZWE0NjM4Njc1ZThi
ZDM5NzMyMDkzMF0NCj4gc3RhYmxlLzQuOTogW2MyMmNmMzg0MjhjYjkxMGYxOTk2ODM5YzkxN2U5
MjM4ZDJlNDRkNGIsDQo+IDhhMDkyMjJhNTEyYmY3YjMyZTU1YmI4OWEwMzNlMDg1MjI3OTgyOTld
DQo+IHN0YWJsZS81LjEwOiBbZDkyZDNhOWMyYjY1NDFmMjlmODAwZmMyYmQ0NDYyMDU3OGI4Zjhh
NiwNCj4gNDMyMGMyMjJjMmZmZTc3OGE4YWZmNWI4YmM0YWMzM2FmNmQ1NGViYSwNCj4gICBhYjdj
ZjIyNTAxNjE1OWJjMmMzNTkwYmU2ZmExMjk2NTU2NWQ5MDNiXQ0KPiBzdGFibGUvNS4xNDogWzdh
MzFlYzRkMjE1YTgwMGI1MDRkZTc0YjI0ODc5NWY4YmU2NjZmOGUsDQo+IDZhODc4NzA5M2IwNDA1
N2Q4NTU4MjIwOTRkNjNkMDRhMjUwNjQ0NGEsDQo+ICAgYTc1OTMyNDRkYzMxYWQwZWVhNzAzMTlm
NjExMDk3NWY5YzczOGRjYV0NCj4gDQo+IENWRS0yMDIxLTIwMzIxOiBrZXJuZWw6IEluIE92ZXJs
YXlmcyBtaXNzaW5nIGEgY2hlY2sgZm9yIGEgbmVnYXRpdmUNCj4gZGVudHJ5IGJlZm9yZSBjYWxs
aW5nIHZmc19yZW5hbWUoKQ0KPiANCj4gQ1ZTUyB2MyBzY29yZSBpcyBub3QgcHJvdmlkZWQuDQo+
IA0KPiBBIGxvY2FsIGF0dGFja2VyIGNhbiBlc2NhbGF0ZSB0aGVpciBwcml2aWxlZ2VzIHVwIHRv
IHJvb3QgdmlhDQo+IG92ZXJsYXlmcyB2dWxuZXJhYmlsaXR5Lg0KPiBQYXRjaCBmb3IgNC40IGlz
IGFwcGxpZWQNCj4gZmFpbGVkKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8xNjMzNzg3
NzI5MTQ4MjBAa3JvYWguY29tLykuIEl0DQo+IG5lZWRzIHRvIG1vZGlmeSB0aGUgcGF0Y2guIEkg
YXR0YWNoZWQgYSBwYXRjaCwgaWYgaXQgbG9va3MgZ29vZCwgSSdsbA0KPiBzZW5kIGl0IHRvIHRo
ZSBzdGFibGUgbWFpbGluZyBsaXN0Lg0KDQpUaGFua3MsIEkgY2hlY2tlZCB5b3VyIHBhdGNoLiBM
R1RNLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg==


