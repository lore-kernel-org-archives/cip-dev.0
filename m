Return-Path: <SRS0=jEKc=NY=lists.cip-project.org=bounce+64572+6716+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782F6C432BE
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 07:10:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9D761026
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 07:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC9D761026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id r0ifYY4521723xrjyHJZ2XCf; Thu, 02 Sep 2021 00:10:32 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.3693.1630566629782405476
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Sep 2021 00:10:31 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1827AR5O032382; Thu, 2 Sep 2021 16:10:27 +0900
X-Iguazu-Qid: 34tr8rsmqYIOhVNLaa
X-Iguazu-QSIG: v=2; s=0; t=1630566626; q=34tr8rsmqYIOhVNLaa; m=eCFuLD85QE/MGBVERDgVJ3zfyGCWKuxe0Ku6+XjW0Wk=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 1827AQwE018814
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 2 Sep 2021 16:10:26 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 2BCAA1000E4
	for <cip-dev@lists.cip-project.org>; Thu,  2 Sep 2021 16:10:26 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1827APsJ024804
	for <cip-dev@lists.cip-project.org>; Thu, 2 Sep 2021 16:10:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnPeLpDxggaGqe/usKMMh3FCShXdgRTHCjybT0yzPfLFwATIIWC22mB51pA9GATiJBzYPS9W4eJQNq9tQJAWd5Ntx2vTeNGh73V2+8WW9RIWsH6XhbnJINrTvd1Z1N6aW+0j98dfPNIVbD23NGZkdI7PcqMLXwMruByZxvgvgG+VtpA/inc3WO3SZqg0niVMHMYVcHGRBZbXt1dXZ1F2ze7aGj3SedECxKW6ejM+E/GZs2OIKoEueN5RdFAV0WpUEb7fM5ov3o44OeKZTJ8S2qOctDsw2jW3OpTllntZ/l2BkhsYd7+JqvHK09xv7UPj2FGB11tLC/NdykDDOinNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIRqVKAuaSNAwCfHWHBsTAfZNzD1NonodKfdyURwnTA=;
 b=WCVGxATIrfh739Aaf3vwo0lqRxOrtFkzDbmtSXdacvea1Qo0vafU0OO6bLpxoy/4Nd/ynjPNjf0qPTylmpJ1Bi3lWXOYekyvXj+l5Wm2fzoDBk0Bsz2DWH1fEJ8LuitTx8ziZuuxgeo4/JBLCjXGY9ICkQMxm90Stm+AfgyBxz9Rw2XLy18kgw+TRQDNuqz9ELnUEIimyZigYa6GXT9OdNDGjR05z5/I+TpmK4hTAJm/sEX4NNqkrbnQtoSKSgO6hDnIh7qek5kvycYUK7dU5vVji6PcQOdC8ep47VdX5qD0sLaJ+MnRg/jGDANqpvEuJoH4uEuvwlGyVhrw6ffS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entry this week
Thread-Topic: [cip-dev] New CVE entry this week
Thread-Index: AQHXn5boGbkcBK+UukSEdzNRutaAtKuQSCqAgAAKl+A=
Date: Thu, 2 Sep 2021 07:10:18 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252C197216C4E7AD01D007292CE9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <CAODzB9orf2AFV9fRwu-VBJxOiJTKvcyhHmihpy3EXH3yB5PEXA@mail.gmail.com>
 <20210902062759.GA25051@amd>
In-Reply-To: <20210902062759.GA25051@amd>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9628c5bc-de31-4a9e-d184-08d96de0b868
x-ms-traffictypediagnostic: TY2PR01MB3705:
x-microsoft-antispam-prvs: <TY2PR01MB3705C843882A9FB6A297EC8B92CE9@TY2PR01MB3705.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: rkEU9BpfCA8KuPMARCaJbOJe438IklEajKFg1Pzc1qrOPMSJl7FtrBI3Un7qLkQKdFagMaJgJhj/LdwrigBFVJkMk2G6asK3lrV/AfryTMS1thYIGcHLMkqL6azG7v0HMi5KM//zAEP4UwY70Wu0SjQFG/rc1kutLGzB9LlH1uQabueRX9wv4dzeS7B2z4do6rnJ82tYl/63p005xrELeSOS6zkw2Rubz3F8HFr3l1QpZ8KVqEqOcYy3OUdnOtrM5FvXmKvYF54iu67x2zU2Ez+ycxGwzF0qqfTN/OyzmBCX18ZepVb/xBfRwVP07TDcXw1xf5sG2FFglcUxIWOwBO3mf/wHP1aqL1Lgy52f50Au63EWENZSwzo3jy2MiUVYwniFGJFD0qeHuSyoXcb2JAOQVQAMjt9DoG6VhXC49qfThhdea/yQy+9GhHs3fHkOTXvGUeMfmMTlzC48NX7i9pe2vpFOPKRMt3HpDAQdHjglxgvK/hUc5LLENi5mD5yTAh46k0aRqGzA3/TPzyRStOhT9wNwqXvInEz0NY9v0NA038ve7RMsqccHhO8CCzmWnQhrYUkcywxwZkHhlVx2eaRsojpJBD3AY38Z3uds9BGAbMJRIWLOHpm7y+7/DBCaticjtTociJzggGk7cMwWWN33CXhkkOuQUMyo38UBTLKTeKComPXr76Fga7hVzBrn9quS1seVG8O9S/JEUMvDPg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SC9mRnc5L0tSL01ob05hUnZ4QWl1WHBZdnBUSUdqVUl6T0lycU5oendNbUh5?=
 =?utf-8?B?YXNTRy9tODVYMk9idlk5OXp5dGc0VlAxV3J1K2FKZkw3ckJwenpuTVh5RUpI?=
 =?utf-8?B?VHpQRGFCRjdzb2xEaElPZ2M2R1JpVkxsalVwTStaMkRwS0NMdVN6Y3pUR3pl?=
 =?utf-8?B?UkpBOE9OcjMzeHQwYXNtZXM5R2NXaUZkSmVpUGxxaGJEaERQbU0zbXRmdWxk?=
 =?utf-8?B?ck14YWZHS0NnR3ZqeEtlQ3NVNWlxRERWeWp6ZUJSZ3Z3aVJTUE0zTnh2aGlr?=
 =?utf-8?B?RVMraVZ2T3YyYlI3NC9NZkcyWDVWUm9DQWw3NGZIMXJycnM5bjRiUG5razlU?=
 =?utf-8?B?RmtFK09vaUdXMEhEeVpRQWs2Unl1eWhPUXgyM3ZyS0dxZXRLV1hUZ0NjblBE?=
 =?utf-8?B?V1pDc0FYU3FGbEovT1dvZ1l6cmhTMk1QNy9Oc1JOY1BNUHUxekZPdmVLTEFE?=
 =?utf-8?B?OXlhTVV1cjZoaWYxN1JhMEtuRkFCb3h5a0phd0MvU0RoOUNseXRaeXBCc1dh?=
 =?utf-8?B?ZFE3VmkxaDlRcHlPMHN5Q2N2ZVZxa2QwWTF4V2h0WnZxSWNHZEJ1NzVUOFFt?=
 =?utf-8?B?UFZ5ZzFuOWtIU3R3NEdsa1VHTkdJOVU1aktEQld0emhoR2U2V3dnQWd3bjIw?=
 =?utf-8?B?Q1cvVkhBcWV5ODh3SURUNlIyMURUYU5lTU1BYnE0clRuYm91ci9WMlZwWDdy?=
 =?utf-8?B?YVovVkdOZXROQkpMYUg5bHdRS2dGTmpyMkdqMGFocFEzenBKdVZsbUk0TndV?=
 =?utf-8?B?K0h4S0tvcjNERW9Vc0lwcWFGTDRiMGcvQ2FxRUpqTnUzTHJITG5GSTEyb0p3?=
 =?utf-8?B?L0NNbzRGaHFJblBYOXppZkRzK3orTkxNNWEzNVZoREtueWtIKzZNK21HWmdU?=
 =?utf-8?B?bjd0ZUV2OFF0ODZWa2pFZE82QkhxL3FxYnllc2RTOVpITnErR1ljLzUyekRp?=
 =?utf-8?B?NmJJY0NpbkxpQkkzZ1dVWHJNTUdxWnhBTjhwaC9qd2VsZ1pBZWwveUY4S1Z3?=
 =?utf-8?B?WEkvblZNTkloSzloandkc0JHZDB0blNpdU1wUm41U21QQmdxREV0cThEQi9w?=
 =?utf-8?B?RnBFU242RHZIZWRzMHh2blphWC9aMlc3b3JDS3hkZllmNnA0dEZYZ092dEFC?=
 =?utf-8?B?TVh0WndaVGRkZG5JamV4L3JuUmgrWC9nMlJjd0F6eTVya2NNODZuMUFVZk15?=
 =?utf-8?B?eXhldVVwb01WYXJzU3NFMkUycEVrdE1yeWt3cHd6TlRiTTg0dDJqSWM4RWVt?=
 =?utf-8?B?ZUFhcnNPbWNDK1E2MkVMQ2VsQ3RoSXp0ZVYreG54VERBQTEwUkh3RWdyaHpH?=
 =?utf-8?B?RmZxMGQ0d1U3ZFlka0k5WDBBM3pHMk56a3dUVThWRzZjZG1zMUN1R3Y2Wm8z?=
 =?utf-8?B?ZFpIRVByVzNUSm42TkwxdmJUYXB0aXRUOG0zK2tRNW9oM0kxaEZLZTRNOWlD?=
 =?utf-8?B?WjVrWncwZitlZXhmOVJJVGFMZEFDWXo0ZUR4ekJoZU1PSVVEeFcyVHRrellB?=
 =?utf-8?B?dm5rcDZXd29VR3ovVjNmNW53SStsVUpVTzdVd3dzdE85TURUVmxXOGNzWGk2?=
 =?utf-8?B?bXJnbVZaZFVkSkdXVWpQY3FoM0luUjVKWVBhb0lmWk1CRWFuRnVUUTdvLzNJ?=
 =?utf-8?B?am9xVnRmWGZEekhPSkxGNEtjM1dabmtzRlA0WGtyQUxVU2ZzalpWc2ZkSWF3?=
 =?utf-8?B?WUZWS3h4T0xyR3A2Wjl3S3dGcHU5RWxaYW1TUGFPbEJGdGR6QnBLRXNUWGJx?=
 =?utf-8?Q?2G0cg+wFKtR0All47M=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9628c5bc-de31-4a9e-d184-08d96de0b868
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 07:10:18.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+KHfEDx/1OVYlzn/XfsmEAfx6w6O1jvuVBKcLt6uY41YrWv6wQn37+DMHXGxcZBu47aGv0K1a9g/zBn414hlrpEFTPevNZKHgOOKnECy3G4EXUs1KS8ja/qWA/LTryc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3705
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NxYPNrVSnn7dHUuqroLjstVGx4520388AA=
Content-Type: multipart/mixed; boundary="5nj6usQDCTa1lb8mgWrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630566632;
 bh=cdCi63VC8kmy33omWq3tzZhyGotGTXcFN5CoQdoszrY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=COnlMg7M5p4QKa0j/BkX0RmsqEFBKrTp7OVUiR9/Y323EII/JM9KFqy4VPcs6fUIHOx
 KUFwKoUY4q7UOXAkh3rWPisnaP2NTKPSMNpprrI3YgwqecS6GvbxrmV59uVfuiyik8tEa
 NHKsFO6X6m0iows/NyIF3DhIt0xL2doSXYs=

--5nj6usQDCTa1lb8mgWrt
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIs
IDIwMjEgMzoyOCBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtjaXAtZGV2XSBOZXcgQ1ZFIGVudHJ5IHRoaXMgd2Vlaw0KPiANCj4gSGkhDQo+
IA0KPiA+ICogQ1ZFIHNob3J0IHN1bW1hcnkNCj4gDQo+IFRoZXNlIHN1bW1hcmllcyBhcmUgbm90
IHNvIHNob3J0OyBJIHNpbXBseSBza2lwIHRoZW0gYW5kIGdvIHRvIGZ1bGwNCj4gbGlzdC4gUGVy
aGFwcyB0aGV5IGRvbid0IG5lZWQgdG8gYmUgaW5jbHVkZWQsIG9yIGNvdWxkIGluY2x1ZGUgb25s
eQ0KPiBDVkVzIHdoZXJlIHdlIG5lZWQgdG8gdGFrZSBhbiBhY3Rpb24/DQo+IA0KPiA+ICogQ1ZF
IGRldGFpbA0KPiA+DQo+ID4gTmV3IENWRXMNCj4gPg0KPiA+IENWRS0yMDIxLTM3Mzk6IGJ0cmZz
OiBmaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdoZW4gZGVsZXRpbmcNCj4gPiBkZXZpY2Ug
YnkgaW52YWxpZCBpZA0KPiA+DQo+ID4gRml4ZWQgaW4gYnRyZnMgdHJlZSBidXQgbm90IGZpeGVk
IGluIG1haW5saW5lIHlldC4NCj4gPiBUaGlzIHZ1bG5lcmFiaWxpdHkgaGFzIGJlZW4gaW50cm9k
dWNlZCBzaW5jZSA0LjIwLXJjMSBzbyBiZWZvcmUgNC4yMA0KPiA+IGtlcm5lbCBhcmVuJ3QgYWZm
ZWN0ZWQgdGhpcyB2dWxuZXJhYmlsaXR5Lg0KPiA+DQo+ID4gRml4ZWQgc3RhdHVzDQo+ID4NCj4g
PiBtYWlubGluZTogW2U0NTcxYjhjNWU5ZmZhMWU4NWMwYzY3MTk5NWJkNGRjYzVjNzUwOTFdDQo+
IA0KPiBUaGlzIG9uZSBpcyBxdWV1ZWQgZm9yIDUuMTAuNjIsIHNvIHRoaXMgaXMgZ2V0dGluZyBm
aXhlZCBmb3IgdXMuDQo+IA0KPiA+IENWRS0yMDIxLTM3NDM6IG91dC1vZi1ib3VuZCBSZWFkIGlu
IHFydHJfZW5kcG9pbnRfcG9zdCBpbiBuZXQvcXJ0ci9xcnRyLmMNCj4gPg0KPiA+IFRoZSBRdWFs
Y29tbSdzIElQQyByb3V0ZXIgcHJvdG9jb2wocXJ0cikgaGFzIGJlZW4gaW50cm9kdWNlZCBzaW5j
ZQ0KPiA+IDQuMTUtcmMxIHNvIGJlZm9yZSA0LjE1IGtlcm5lbHMgYXJlbid0IGFmZmVjdGVkLg0K
PiA+IENoZWNrZWQgb24gY2lwLWtlcm5lbC1jb25maWcsIGl0IGxvb2tzIGxpa2Ugbm8gQ0lQIG1l
bWJlciBlbmFibGVzIFFSVFIuDQo+ID4NCj4gPiBGaXhlZCBzdGF0dXMNCj4gPg0KPiA+IG1haW5s
aW5lOiBbN2U3OGM1OTdjM2ViZmQwY2IzMjlhYTA5YTgzODczNDE0N2U0ZjExN10NCj4gDQo+IEZp
eGVzIGFyZSBxdWV1ZWQgZm9yIDQuMTkgYW5kIDUuMTAuNjIsIHNvIHRoaXMgaXMgZ2V0dGluZyBm
aXhlZCBmb3IgdXMuDQo+IA0KPiA+IENWRS0yMDIxLTM3NTM6IEEgb3V0LW9mLWJvdW5kcyBjYXVz
ZWQgYnkgdGhlIHJhY2Ugb2YgS0RTRVRNT0RFIGluIHZ0DQo+ID4NCj4gPiBDb21taXQgZmZiMzI0
ZTZmODc0MTIxZjdkY2U1YmRhZTVlMDVkMDJiYWFlNzI2OSBpbnRyb2R1Y2VkIHJhY2UNCj4gPiBj
b25kaXRpb24gYW5kIG9vYiBidWcuIFRoZSBjb21taXQgZmZiMzI0ZTZmODc0IGhhdmUgYmVlbiBi
YWNrcG9ydGVkIHRvDQo+ID4gNC40IGFuZCA0LjE5Lg0KPiANCj4gQWdyZWVkLCBmaXhlZCBpbiA0
LjE5LjE5MiBhbmQgNC40LjI3MC4gTm90aGluZyBmb3IgdXMgdG8gZG8gdGhlcmUuDQo+IA0KPiA+
IFVwZGF0ZWQgQ1ZFcw0KPiA+DQo+ID4gQ1ZFLTIwMjAtMzcwMjogU3BlY2lmaWNhbGx5IHRpbWVk
IGFuZCBoYW5kY3JhZnRlZCB0cmFmZmljIGNhbiBjYXVzZQ0KPiA+IGludGVybmFsIGVycm9ycyBp
biBhIFdMQU4gZGV2aWNlIHRoYXQgbGVhZCB0byBpbXByb3BlciBsYXllciAyIFdpLUZpDQo+ID4g
ZW5jcnlwdGlvbiB3aXRoIGEgY29uc2VxdWVudCBwb3NzaWJpbGl0eSBvZiBpbmZvcm1hdGlvbiBk
aXNjbG9zdXJlDQo+ID4gb3ZlciB0aGUgYWlyIGZvciBhIGRpc2NyZXRlIHNldCBvZiB0cmFmZmlj
DQo+ID4NCj4gPiBWdWxuZXJhYmlsaXR5IGluIGF0aDlrIGRyaXZlci4gNC40LnktY2lwL2FybS9z
aWVtZW5zX2lteDZfZGVmY29uZmlnDQo+ID4gYW5kIDQuNC55LWNpcC9hcm0vbW94YV9teGNfZGVm
Y29uZmlnIHVzZSBhdGg5ay4NCj4gDQo+IEZpeGVkIGluIDQuMTQgYnV0IG5vdCA0LjQuDQo+IA0K
PiA+IHN0YWJsZS80LjE0OiBbMmNiYjIyZmQ0YjRmYjRkMDgyMmQxODViZjViZDZkMDI3MTA3YmZk
YSwNCj4gPiAyMGU3ZGUwOWNiZGI3NmEzOGYyOGZiNzE3MDlmYWUzNDcxMjNkZGI3LA0KPiA+ICAg
OTk1NTg2YTU2NzQ4YzUzMjg1MDg3MDUyM2QzYTkwODA0OTJiMzQzMywNCj4gPiBmNGQ0ZjQ0NzMx
MjllOWVlNTViODU2MjI1MGFkYzUzMjE3YmFkNTI5LA0KPiA+ICAgNjFiMDE0YThmOGRlMDJiZWRj
NTZmNzY2MjAxNzA0MzdmNTYzODU4OF0NCj4gDQo+IERpZmZzdGF0IGxvb2tzIGxpa2UgdGhpczoN
Cj4gDQo+ICBrZXkuYyB8ICAgMTEgKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBtYWluLmMgfCAgICA1ICsrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ICBhdGguaCB8ICAgIDEgKw0KPiAga2V5
LmMgfCAgICA0ICsrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiAgYXRoLmggICAgICAgICAgICAgICAgfCAgICAyICstDQo+ICBhdGg1ay9t
YWM4MDIxMS1vcHMuYyB8ICAgIDIgKy0NCj4gIGF0aDlrL2h0Y19kcnZfbWFpbi5jIHwgICAgMiAr
LQ0KPiAgYXRoOWsvbWFpbi5jICAgICAgICAgfCAgICA1ICsrLS0tDQo+ICBrZXkuYyAgICAgICAg
ICAgICAgICB8ICAgMzQgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgNSBm
aWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gIGh3Lmgg
ICB8ICAgIDENCj4gIG1haW4uYyB8ICAgODcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwg
ODcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpJIGNoZWNrZWQgdGhlIHBhdGNoIGFw
cGxpY2F0aW9uIGFuZCBidWlsZCBhdCBoYW5kLg0KV2UgY2FuIGJhY2twb3J0IHdpdGhvdXQgYW55
IGNoYW5nZXMgdG8gNC40IHRyZWUuIEJ1dCBJIGRvbid0IGhhdmUgdGhpcyBkZXZpY2UsIHNvIEkg
Y2FuJ3QgY29uZmlybSB0aGUgd29ya2luZy4NCg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJv
DQo=


--5nj6usQDCTa1lb8mgWrt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6716): https://lists.cip-project.org/g/cip-dev/message/=
6716
Mute This Topic: https://lists.cip-project.org/mt/85318439/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5nj6usQDCTa1lb8mgWrt--
