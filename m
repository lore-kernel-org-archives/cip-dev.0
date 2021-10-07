Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8C1C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 02:26:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web09.6249.1633573569786688877
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 19:26:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1972Q5lV002442;
 Thu, 7 Oct 2021 11:26:05 +0900
X-Iguazu-Qid: 2wGrVQwHFxWoqUiXKb
X-Iguazu-QSIG: v=2; s=0; t=1633573565; q=2wGrVQwHFxWoqUiXKb;
 m=hzH5pul7LGjCvKz9UplpzS0+vpOou8oAf8/wZ0F2CMw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 1972Q4bi018598
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Oct 2021 11:26:04 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 0309D1000F8;
	Thu,  7 Oct 2021 11:26:04 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1972Q3O7010622;
	Thu, 7 Oct 2021 11:26:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3ITzfuV6ErYzflMKq9m5dApcetzFdnzGT/PPiDPjqZXs7mNdcEutz7VL3jdT40ORUEzNQjqGw6DXM6i/LjPpiKE9kybf5L5H0XMDfD38ey8qr8XRU8YJhqlr34RWvG1x5dWdYDYd6Jk+tRXhcm2lXlTn9mZ1nQ2FY4vKNjOd62II9hlvDDUirqT6DtRkX6HScrdLzS/DXO2+MBH2rYzMj/+3U0NtLYHZDQBvk1Aem+WxH79WJirp4YNShWURLF1l54OOPj4qLUNYZOyENX3oG7t2cum52z435yXa/wz7pfsTIMVL/zvEo3PfUV3YSKugIEFnKJR6uGuGYpG7K7bSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHjqgxXgIaP86XamJEfE8BW/9/1vJJSd8Ekec96TR3w=;
 b=LSc5n1CUsv+DeFNH82zlIchZJGWJ2MnZDO+Vd+1mGoW7juI2qT5Oxjf8hOOdDfvYVC3ri6cfdKqwqTFn+i2WJfyZ5cgOl2TN5w+6XwpAzTnsNGxZsmdcpL4fAlvn6CjFY2DNvQIkXHGXur/W1YKV8BWnRXGgRuYQMwA22grsk4DymEO2EAogd6+fj0F2yWflh2c0l9fDuKwJqKvhehmwR0iDXx2t/FrZUx/6848lHXGF9Alxi5q7tJnYgv0vHRklnvIrO36MnhXsrkqTuVWL6/GY9QjamhTCayedTXEpk6YTMjKNziHdDZXqrF9Dua2FoDX0HM03bPQwkA1RrNvOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <sergey@coolautomation.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Deby project status?
Thread-Topic: [cip-dev] Deby project status?
Thread-Index: AQHXus0EoaE7jZru7kGwEeqidCtMzqvGtH5w
Date: Thu, 7 Oct 2021 02:26:01 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYBPR01MB5502BBD5380806EECB4ECBACE1B19@TYBPR01MB5502.jpnprd01.prod.outlook.com>
References: <20211006161233.ehdsr7n34dvr66rq@cool>
In-Reply-To: <20211006161233.ehdsr7n34dvr66rq@cool>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: coolautomation.com; dkim=none (message not signed)
 header.d=none;coolautomation.com; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24215013-7ee3-4abb-3f62-08d98939ce48
x-ms-traffictypediagnostic: TYAPR01MB4912:
x-microsoft-antispam-prvs: 
 <TYAPR01MB49128957B4B305DDBCD446ADE1B19@TYAPR01MB4912.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Nzc3dOCObrIN6/40j9zTYBSFAYrULZsafG9Z1kzuXqFUV/Jweyw2Su89+8l92qNp2MhgTnc6ZG6U6swRzf+WTwoo0GyBvHHs47loCb+UyEQm4ftfk1wKZJw4Mit3we1ZeK1cgHji+Fdn+q17JB5h0ycsknMpWn7wrUEtfUZ1J/cNKPKcfzKK2kaahRMKxQqzrG1kxktlKXoWK5Aw2CxyjoW8aaCUqCCC+1ZHk7b50QsWXJolp9Q+qbeAeFkPnTTLjYX8+EQ4hXs8JEihDikhNlnXYby2ZU1NTRvFYHvt1DQqNTVcRYDze+r+OhhO0W7kQ07ZDVVqSJt1IbDgeD70g7NRsdc9A/gYXFFY4JplAyjC0pzYGmMEvzjIxmg/nAGd175Jhc9aCAtzUxuQ0DKzv7lVPGdNaJvYLhoveuSuzkUnBzBabQNnJSvJmKSsmXIBUtu5M50MKs28uEBDuh4sY8h3LSn4M2kpTZQ8DMT55tEhvNs/MZF9g/Qj9Rf6cc4Afxal6+tji1l62Pzejzuo/i0kWol6a63iV86ojJ82vMfNGCavwBlmLniDiGtiLjdLzuGaJw/o7mNzOSyVPd/7inWsZR8/+bTIPdIb89rz0+gw5jtE/27Ab/lWtcWOAWy2g6OQtDgVPngpS5GmWyauUg3Ef+N/tJrivphghbo9NCz4DVQ389EVJ4OWExm9PzdO+Qyp6OXM07fF9zabNCRavw66UvKAIsrYEMCzy14PuskrC6J5vVxY7AYgELY910UOFZwJGZ/F7OXUHPiptPgUsMFWSKZVE5FkaZVXrt4Vj4c0lGjCnVouLewpXsLZZ8176pUMQzq7a++M+nUThLtWHA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5502.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(508600001)(38070700005)(966005)(8936002)(110136005)(55016002)(76116006)(9686003)(83380400001)(2906002)(71200400001)(316002)(33656002)(52536014)(7696005)(66476007)(66946007)(26005)(86362001)(53546011)(64756008)(8676002)(38100700002)(5660300002)(122000001)(66556008)(66446008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dEFhN1JQUHl5R21xN3B1RlRDVmJVeG5jWnBYd0hOUW5DaldFV0NFMS9ORUNO?=
 =?utf-8?B?K1FQcWdvTkhXbDhPd3dmV3RhQ3FsMmU0N1dpMmRtbjVFRGtXQnhXTXExd1py?=
 =?utf-8?B?U2RRdUxOZHMrbEVpQzAzVExUNmVQbWZnckFPanlJZnV2TlFnWWFqK08vUzNt?=
 =?utf-8?B?TXlnTjJneFZYRDk5ekIvVHNQUk9SdGtTTkZNUTk0OVR5NlAvMnNUalhOZDNi?=
 =?utf-8?B?UzNCY0pRdC80WXRCNUgwdmtTdmFnOG1ESTFlQ1huVys3bE03RGZwbFpMUTFZ?=
 =?utf-8?B?N2xnOGNUV1RxS002bFdzQi9IQlNRZFlITmw5Y3h6UnhwSGE2a1R1U2lRajl1?=
 =?utf-8?B?aUpscFBveC9pNitFQTlBbFlpYTRMWEhyU3VTRkU3WWh6TzV4YU5MNEFqdWJt?=
 =?utf-8?B?Zm1GdjM5VWFaMDg2NmFWc04vNmZtUmdvRHBuNjhWRHZIY01Kc3pGVEZScFVS?=
 =?utf-8?B?WDRmRXFLVTZ2bnp0R0lLbmFRYytRTFRZdFc3dndHWnJNazZLQTU3NUVHcUkz?=
 =?utf-8?B?bzV2MzhTbWhJcGwxNUFaaVdMWDJlalppYzJucjBNUnhhdDI3VWw3YTdYTWp0?=
 =?utf-8?B?M201TEJZM3pTRllhZi8vOHNQNzZucSs3b21CTUdkRGxnUHBEOURaUTRWdGM5?=
 =?utf-8?B?L1hISXZpY1NWNDRVdTFRQ0h6eDJoWjYwdGZwNmRkTHA4UXBDYlFUT2Z3YkdU?=
 =?utf-8?B?em8rK05VdkNjNnRqWTB2WXY4WFJiR0hHc3VpdE1YSjhLb1JwQ3lXczNDdUwy?=
 =?utf-8?B?WllPd1hFVVFKK2JiMDBrQVJIcm9mMVZ6Y0tpZGtPblJ6c2wvTVJSTm83c1I1?=
 =?utf-8?B?cXRaYjMveElkK1FoeHVCY21zM2ViOTh1RXVhNEdkOE5pRytwV3BuODRMZUU3?=
 =?utf-8?B?d2RQazcvOFhxY2NvTml1dGFyQVFvSk1wRHVjRzA0N0RuTDg0MHRIQ1BGdFAw?=
 =?utf-8?B?MndHOUsvQVRDVE1STXJ2ZzllMUdUZEhEY1E5d25LQ1VzTzd0WStNZ0U4Um1v?=
 =?utf-8?B?U2lrYlBxYlM0dm1UN1FDREkvRmwvd1ZLalU1YTFJdnVlK3VMR1ZCK0Q2VHN6?=
 =?utf-8?B?L1R0TjhDeCtsRlRETzNrT3QydjZyUHR4R3U4bzJrZTVxMytlbVJLTklHVVZy?=
 =?utf-8?B?UlNWU2JwaEhDZ2RCM2lWbjlHMTdabzRnZmxhV2RuMWNSUEUxMHdHeVJhS2kz?=
 =?utf-8?B?SC9vN1FUMlBZZmNxQkQwSnczMlBNeDdJMXZsc0s5cjNyYWdUWGl1STI4a3o2?=
 =?utf-8?B?TmxMcTdVemJ3MnlabEc5MU85dzRKWGtCZUNwOWQ5RTB2dHJISmx3dGt4RWdE?=
 =?utf-8?B?dUNpRVp2ZlBna3lkRloxL3BuUW93SXprSTlhNW9iWlFSN0Z5NDl6dnlIVkw5?=
 =?utf-8?B?Slc0UlcvTnZjVTNqMkg5aVRHTG81ODRKQjIwa1o1a0hDaXE1cUdLZmpIZVZV?=
 =?utf-8?B?dUlBUklvc0YxaUtyRldLRXBmaGxmNm1uNVdKajBNMVBvUThMM0h4dUN4djNJ?=
 =?utf-8?B?bUU5dlljOFNCS3UrRUswVEw4b0RZTjVrV3NPTTVlSEVUaUFxelpTZ0lmVitT?=
 =?utf-8?B?cXZEZ25WanZ5UFYvWjJHNDdxMmxSRy9XdUU0RTV1Z090SzlIRnVsaUdjVERJ?=
 =?utf-8?B?V1Z5V0p2NHpaTVY2eXRtRTRoeEJXV3ZyWXF2dDNqVkNxWjRpSWp4c3RNQnF2?=
 =?utf-8?B?QW4xRlBLVzBHR3BJQmtNY3ZTekJtek1vNlBNN3VmUml3RE00aGlpQUVCa1Jx?=
 =?utf-8?Q?mkn6uD0SdxBW9rtz9r4l0kgDAHfVaaFqPoEr+NR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5502.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 24215013-7ee3-4abb-3f62-08d98939ce48
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 02:26:01.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 b/BV1aSFMGzqYi9NYSt74gHggzETVNDu0I3qCnyud4sYHFVHNZpB4gmRSBLlikxFk48FK96nHoNHHBqznL6YmNPR0OXr5FCVga++yp1GMR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4912
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Oct 2021 02:26:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6799

SGVsbG8gU2VyZ2V5LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcXVlc3Rpb25zLg0KDQo+IC0gbGFz
dCBjb21taXQgaW4gY2lwLWNvcmUvZGVieSB3YXMgaW4gQXByaWwNCj4gLSBpdCBidWlsZHMgd2l0
aCBlcnJvcnMNCg0KU29ycnkgZm9yIHRoZXNlIGJhZCBzdGF0ZXMuDQpBcyB0aGUgdXBzdHJlYW0g
cHJvamVjdCBbMF0gdGhhdCBkZWJ5IGlzIGJhc2VkIG9uIGhhcyBiZWVuIHVwZGF0ZWQgYWxyZWFk
eSwNCnNvIGl0IHNob3VsZCBiZSB1cGRhdGVkIGltbWVkaWF0ZWx5Lg0KDQo+IEl0IHNlZW1zIGxp
a2UgYSBiYWQgc2lnbi4gQXJlIGFsbCBlZmZvcnRzIGFpbWVkIHRvIGlzYXItY2lwLWNvcmU/DQoN
Ck5vdCBhbGwsIGJ1dCBtYW55IGVmZm9ydHMgYXJlIHJlY2VudGx5IHByaW9yaXRpemVkIHRvIGlz
YXItY2lwLWNvcmUgYWN0dWFsbHkuDQpUaGUgYmFzaWMgcGxhbiBpcyB0byBpbXBsZW1lbnQgZmVh
dHVyZXMgaW4gaXNhci1jaXAtY29yZSBmaXJzdCB3aGVyZQ0KdmFyaW91cyBwYWNrYWdlcyBhbmQg
ZmVhdHVyZXMgZnJvbSBEZWJpYW4gYXJlIGF2YWlsYWJsZSBhbHJlYWR5LA0KdGhlbiBwb3J0IHRo
ZW0gdG8gZGVieSBpbiB3aGljaCBwYXJ0aWFsIGZlYXR1cmVzIGFyZSBpbXBsZW1lbnRlZC4NCg0K
PiBBbnl3YXksIGlzIHRoZXJlIGFueSBwbGFucyB0byBkZXZlbG9wIERlYnkgKG9yIGFueSBvdGhl
ciBkaXN0cm8gdW5kZXINCj4gdGhlIGFlZ2lzIG9mIENJUCBwcm9qZWN0IGZvciBkZXZpY2VzIHdp
dGggc3RvcmFnZSByZXN0cmljdGlvbnMpIGluDQo+IGZ1dHVyZT8NCg0KZGVieSBpcyBub3cgc3Vw
cG9ydGluZyBEZWJpYW4gOCBqZXNzaWUgYW5kIDEwIGJ1c3RlciBzb3VyY2UgcGFja2FnZXMNCmlu
IGVhY2ggYnJhbmNoIGFuZCBib3RoIHZlcnNpb25zIHdpbGwgYmUgbWFpbnRhaW5lZCBhdCBsZWFz
dCAxMCB5ZWFycw0KZm9sbG93aW5nIHRoZSBsaWZlY3ljbGUgaW5mb3JtYXRpb24gb2YgQ0lQIFsx
XS4NCk9uIHRoZSBvdGhlciBoYW5kLCB0aGVyZSBpcyBubyBwbGFuIHRvIGRldmVsb3AgbmV3IGRl
YnkgbWV0YWRhdGENCmZvciBuZXdlciBEZWJpYW4gc291cmNlIHBhY2thZ2VzIChlLmcuIDExIGJ1
bGxzZXllKSBhdCB0aGUgbW9tZW50Lg0KDQpUaGUgZGVtYW5kIGFuZCB3YXkgb2YgaW1hZ2VzIGZv
ciBkZXZpY2VzIHdpdGggc3RvcmFnZSByZXN0cmljdGlvbnMNCmlzIHVuZGVyIGNvbnNpZGVyYXRp
b24uIFRoZXJlIGFyZSBzZXZlcmFsIGlkZWFzIHRoYXQgZGlyZWN0bHkgdXNlDQpiaW5hcnkgcGFj
a2FnZXMgb2YgRGViaWFuIHRvIGNyZWF0ZSBzbWFsbCBpbWFnZXMNCihlLmcuIERlYmlhbiBpbml0
cmFtZnMgYmFzZWQgY3VzdG9tIGltYWdlLCBldGMuICksIGJ1dA0KbW9yZSB0aW1lIGZvciBkaXNj
dXNzaW9ucyB3b3VsZCBiZSByZXF1aXJlZCB0byBpbXBsZW1lbnQgYSByZWxhdGVkDQpyZXBvc2l0
b3J5IG9yIHJlY2lwZXMgaW4gY2lwLWNvcmUuDQoNClswXSBodHRwczovL2dpdGh1Yi5jb20vbWV0
YS1kZWJpYW4vbWV0YS1kZWJpYW4NClsxXSBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3Qv
Y2lwLWxpZmVjeWNsZS8tL3RyZWUvbWFzdGVyL2RhdGENCg0KQmVzdCByZWdhcmRzLA0KS2F6dQ0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
IFNlcmdleSBOYXphcnlldg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciA3LCAyMDIxIDE6MTMg
QU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFtjaXAt
ZGV2XSBEZWJ5IHByb2plY3Qgc3RhdHVzPw0KPiANCj4gSGkgYWxsLA0KPiANCj4gUmVjZW50bHkg
SSd2ZSBmb3VuZCB0aGUgRGVieSBwcm9qZWN0IGFuZCBJIGNvbnNpZGVyIGl0IGFzIGEgY2FuZGlk
YXRlDQo+IGZvciB1c2luZyBvbiBvdXIgbmV3IGRldmljZS4NCj4gDQo+IEhvd2V2ZXIsIGFzIEkg
Y2FuIHNlZSwgdGhlcmUgaXMgbm8gYWN0aXZpdHkgaW4gdGhpcyBwcm9qZWN0Og0KPiANCj4gLSBs
YXN0IGNvbW1pdCBpbiBjaXAtY29yZS9kZWJ5IHdhcyBpbiBBcHJpbA0KPiAtIGl0IGJ1aWxkcyB3
aXRoIGVycm9ycw0KPiAtIHRoZXJlIGFyZSBubyB1cGRhdGVzIGluIERlYnkgc2VjdGlvbiBvZiBD
SVAgY29yZSBtZWV0aW5ncyByZXBvcnRzDQo+IC0gYWxsIGlzc3VlcyByZWxhdGVkIHRvIERlYnkg
KGUuZy4gc3d1cGRhdGUgc3VwcG9ydCkgd2VyZW4ndCB1cGRhdGVkDQo+ICAgc2luY2UgbGFzdCB5
ZWFyDQo+IA0KPiBJdCBzZWVtcyBsaWtlIGEgYmFkIHNpZ24uIEFyZSBhbGwgZWZmb3J0cyBhaW1l
ZCB0byBpc2FyLWNpcC1jb3JlPw0KPiANCj4gQW55d2F5LCBpcyB0aGVyZSBhbnkgcGxhbnMgdG8g
ZGV2ZWxvcCBEZWJ5IChvciBhbnkgb3RoZXIgZGlzdHJvIHVuZGVyDQo+IHRoZSBhZWdpcyBvZiBD
SVAgcHJvamVjdCBmb3IgZGV2aWNlcyB3aXRoIHN0b3JhZ2UgcmVzdHJpY3Rpb25zKSBpbg0KPiBm
dXR1cmU/DQo+IA0KPiBUaGFuayB5b3UgaW4gYWR2YW5jZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gU2VyZ2V5IE5hemFyeWV2DQo=


