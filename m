Return-Path: <SRS0=2I5L=IR=lists.cip-project.org=bounce+64572+6296+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA70C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:05:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BA364F62
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 07:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BA364F62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6296+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Cav4YY4521723xxRjAs8BZgT; Fri, 19 Mar 2021 00:05:38 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web11.2867.1616137536227622185
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 00:05:37 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id TQAA07258A;
	Fri, 19 Mar 2021 16:00:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CizjbziMKGSvl4yeHreQPQXLCnLsJAATiGqm4QIOBGF66oiMhnnvkmH5deEcw+E3hpqDq6LFKposhgm9NtVfqZlMPmR8V0JhF0eht2gqj1QgEmiYpj/bCS+IzSPujIzX8g5Jl3zGSS7TEyupG0+CsktE6mCZIy39VWWMTSS0lbUQ+N4IZFd3OG3UG/fzYEeZaTHfFCkni0yVjfTyXnfWc0I6DmT/mYheybvW5Gyva5hmFVnOrdcGtZm/d3ORgNavnpWDCRKghwz4Dl1Z55dcVI0q7T10/pR8KtoJSMKrNECfg6mp4BXLcJViTuz8iHgRTUlU25BYspqxuvTdoInKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d0woPCsqBTurpyl6viEu3rkHbW2F1fNizn8Fzx608Y=;
 b=lEqeoqiIbxJi3PUrjtYBYA6BaqVALMwyz+gZWWWtIUt8Qq2UJdNko2JmDN2uA+Mbh6z+SvJp9s0QpC3jB4jud0KOGBeSJ7iFD6Az+VRVREclaAghJIGwn5WVzaWVbhUtjtYUqLOyE4vSdwhUp0/E++UG7vJ9FS3UtQ2c6E9AEc5JeamxioqKUd1oMw35o6dRl3exbHjoA9rdSaEeCUTfMz3AvOMAUG0rBB43cNTx/SpTfsWTzukl8C32/ELG3Ft904z8JLPaxU8nKX36uppHW85je56ZUwkBF2AkCJhLttJD3vpx/e7UBjSBioGPJiz8+grdZgp+/IkHMMsymzMfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5338.jpnprd01.prod.outlook.com (2603:1096:404:8030::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 07:00:00 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 07:00:00 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <minmin@plathome.co.jp>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <nobuhiro1.iwamatsu@toshiba.co.jp>, <wens@csie.org>,
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for Week of 2021-03-18
Thread-Topic: [Feedback Requested] RE: Cip-kernel-sec Updates for Week of
 2021-03-18
Thread-Index: Adcb155JKC5WxfCIQN+IRDjOQ0ZrGgAtTvCAAAAbxlA=
Date: Fri, 19 Mar 2021 16:05:32 +0900
Message-ID: 
 <TY2PR01MB49725BE3622C7C3A726381A7A0689@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <bbaaff0c-aace-4c0d-2c48-00d93653416f@plathome.co.jp>
In-Reply-To: <bbaaff0c-aace-4c0d-2c48-00d93653416f@plathome.co.jp>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f751810b-bbac-4bc9-862f-08d8eaa49cfb
x-ms-traffictypediagnostic: TYAPR01MB5338:
x-microsoft-antispam-prvs: 
 <TYAPR01MB5338165E4893054D8698A221A0689@TYAPR01MB5338.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 ouaVH1rFDAqgtl5NlWKD07pF8iObutQ5tO8oCDKHIpVmGh98WqLTtrFIAGmDFbabdGbzlVN+qhKGkh0kL742j6M+UESjsk5IdJ+JUjZp1H/xEF+J2My6WVkMI3xxva45UxshfKUqlBPZ+lov0uQt8JhceUQMQpF8b/Xprw4HZpqem2kW8K170WaHe0DwbSg20abzAm+KTcoX7xI3RGyR53FVeHth/Oi4bpNHFRVFcRwLW+iZ+lPcqKhWetX5EzMDLPdMeZHOuN669mEiaoNDB6ndUScm8cmxGbgjeFzFmCIP+ewagXONKEjLMDl7wQePcTGvzUC1F/0w3qivUqSxI26SgvsxpAVYMetLbqKV5QyYaohlNwEyMwHbA10t5tPEKEB0ATH38hbipNwRYGTkTSwpIJr987PEYNWYgn0EjX2QFyJ5sDEnl10kTKp0Slgf14NoapcuY42zAasmVyylsUpxTIfl5jdBKPBeV6DsEAXBZ637WmvhNDeSmgX7lKMuHEi2wjTmh5OCQRtwjr1v2IpF4d7wTvnWY04uBjr6+w3V2q65QmCoVMRRbyC01vFhE8cnTaP2uWn3mSywxHEQzd8SachLkPRKnX7l4qEa7EhKMfQMqwsEVD0/q/rLydhw1Zd6CRcJwIriO6QAYEEo7ST8HJckSZ/pnJcTWIBhNm4=
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?UEhjZDdweWJhUUJMYzd3NDhKS0tvWnYxMXJkNkZUY2oxMzlJMGxrcXFRUG90?=
 =?utf-8?B?OW5QbWtnMFNFVHQ5QnV5VFVTZ1dFeXFFRXZFY0V1TWg2aFJEc0xmdTRzZUR6?=
 =?utf-8?B?S2hFb3JLbWpDSGpBcnNMM2hLR2V4dXUwVU5IVDk4V1J0TFVFSzgwcWhiRWxI?=
 =?utf-8?B?Nk9vRCthZS9YV0NGZGJvMHdEUGZWL2huNG54V1BjOWRWbVl1M3k2dDZkblkr?=
 =?utf-8?B?bU1YcEdSR2lNRGlQK2NFT0pCb2xyLzI3L09vRUQ3TUZyRUlJQmxpWElMWDVR?=
 =?utf-8?B?bU9VbTZ1RkZVWXFJVzE2STdINFU1TGNPaStrcHIzUlArOTYwYVVzUHdsZ2tr?=
 =?utf-8?B?RzdjZlJHKy9YTFZKdmFmZU5LT2x3bXJvR01QNmVXV1lZakUyc3QrL1Jyd3JU?=
 =?utf-8?B?ZUpzQlJWS25nQzNBZGl2NXp3bzNlUmNKYTNQc0RQdDQ5M2ZDdWNqTmpoYUJm?=
 =?utf-8?B?QmpiM25rQXRvRnpzOVVvSWxmZVVoeFZKMHZDMnZnUWxNNldDVDdLeVFmaTBK?=
 =?utf-8?B?YU5HUCtSd2pZUFdrYUZYcUltUU84dUt2c3FGRi81TXNZNFg1dEY2bmloSGdZ?=
 =?utf-8?B?bDFrSVlsdUxkcDg3Q0UzOW4xNGovb0dCQ0FoMkdKbExqSXZTbnlLdmkydWNr?=
 =?utf-8?B?cXp1eTJkdTA4RFZrd1MwODF6SXVyRUhLRiswVng0bFVTcmJQbzdaL1dRdXZj?=
 =?utf-8?B?ODdSalRBVTVlWnFVbGxYb01kUE5ES09LSWZnazNPVzE4THhoNmsydU5kcVA1?=
 =?utf-8?B?cUhuNjJxWG1oZ2lFKzJHMm9jUkhNVHMva3lsdFdjQmx4eWNuL0x0WnZVSjEy?=
 =?utf-8?B?ZXNCbFhUZHJpeksyUHRjcGJHZkdmYWptWkZ6amFJcXRrNGdTcm5OMTNCTzNG?=
 =?utf-8?B?YTJScnQ2UVNQQnRXa2FUVDFYbWJKa3p6VUtHaStENkJJOFRpSVVYNDEwK3pl?=
 =?utf-8?B?bzE2SGVUVUh5dDNUTFpjWVhEcG9EVTBJeVllOWNGZ2hDdjBVNkU4ekxYZFpz?=
 =?utf-8?B?aHQvU0xUU2JOSUJQQndNZFZvek9TWVBUb1RtTmVtdWJpeVNlREJWMHVVcjBN?=
 =?utf-8?B?Sk9Vam1yM0dmRWpnbUJpd0h6M0JZakMyRWpmOFhvTDhsa2VEclQ5RVU5OG1l?=
 =?utf-8?B?bEs2bmpCVzBmZ2YwQ3VyY0kvb05JZEduRk5TRm40NVVvTlZGcWJ3WkZadDl6?=
 =?utf-8?B?T3piYzdadmJMSEQ2Q2NQdEk0U3dDV0t0ejNYNFRDUmE4d2gxT3lvdlJrdk1R?=
 =?utf-8?B?cWZBYWZ6ZjRmcVAyd0FBNG5BQ3NMenpGdVBJeXpPWGtuazRTNzFPSjdRRTht?=
 =?utf-8?B?RlN5YkM2YnBpVjlxR1J0Vk9JcDV0VytXRlppaHNuZWJHTkJnMktSWUxJYUta?=
 =?utf-8?B?NVhablBmcjBHS3BCcUhJb0s2Y3N2c090eGl0Ny9MSU9kUUt0RTFXVWRCVW5N?=
 =?utf-8?B?dXY4R3RNQnFtVU1PcGZTSlJrKzgybS9ySVRwUFVvSU53bEVaMFc5R1AvRWJO?=
 =?utf-8?B?cGM0VFBHZ3NTYjFKUTNaWjZDSTBveTZ5OWVvajNLMGdLWDUwT25HU1lmVGgv?=
 =?utf-8?B?MnUyVUlXYjJnM05walBOUll5dHM2UHd0SXpsVmVXcnppUUlTamJRZ1BwZ0Yz?=
 =?utf-8?B?NVVzTlVmWFFlN2dEUzRwNXlDbWxjRzFDaU14MTcxS0hlUVRaSTJ5M3RCTnI2?=
 =?utf-8?B?QklucURJRzI4VE41eElSSUhTV2hxZ004Q3NHTDlNMVpPKzVJSXZNek9KOHVJ?=
 =?utf-8?Q?Z03n2jfCUh2TCuxK5gmvBeZFudg5TBg+PwplLK2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f751810b-bbac-4bc9-862f-08d8eaa49cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 07:00:00.1311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCNqre89saHn7rYcb/I3j6Oyu7OnAMfCicHRAki+K5Auilk68RLBonq+9xFqULI1ldyIgP6Woa78twOiA6RuQ3kRjk/fMn6z/yDhjAP2PC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5338
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lXTeMbKRj79uaPbDxp237g0wx4520388AA=
Content-Type: multipart/mixed; boundary="zykyOkPt4sjYuUB7vvfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616137538;
 bh=CvmiPZ7/eQ0bXmE+Lbg+w31ZEHkIMG7JIZ0c6oKcQtY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=IN7CbEtHhVPi4MVSHnf9fUF9kNr2sKFsftxYnZRm34sND5n1ePfBekytSmuxGB36P+L
 U1q05v1NhMod+zmJM5S+H91skPMpMIrlFn3MHtrzcEyse+T4dheE5a/MubA886aXhqGy4
 4kT4bK5DJgXDlZqqr/wCON8GNbFCnlfDmuY=

--zykyOkPt4sjYuUB7vvfD
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIE1uZGEtc2FuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29uZmlybWF0aW9uIQ0KDQpJd2FtYXRz
dS1zYW4sDQoNCkNvdWxkIHlvdSByZW1vdmUgInBsYXRob21lX29ic3Z4MS5jb25maWciIGl0c2Vs
ZiwgcGxlYXNlPw0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hc2F0byBNaW5kYSA8bWlubWluQHBsYXRob21lLmNv
LmpwPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE5LCAyMDIxIDM6NTYgUE0NCj4gVG86IOW3peiX
pOOAgOmbheWPuO+8iENUSuOAgE9TU+S6i+alreaOqOmAsuWupO+8iSA8bWFzYXNoaS5rdWRvQGN5
YmVydHJ1c3QuY28uanA+Ow0KPiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzog
cGF2ZWxAZGVueC5kZTsgbm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA7IHdlbnNAY3Np
ZS5vcmc7DQo+IGphbi5raXN6a2FAc2llbWVucy5jb20NCj4gU3ViamVjdDogUmU6IFtGZWVkYmFj
ayBSZXF1ZXN0ZWRdIFJFOiBDaXAta2VybmVsLXNlYyBVcGRhdGVzIGZvciBXZWVrIG9mDQo+IDIw
MjEtMDMtMTgNCj4gDQo+IEhpLCBLdWRvLXNhbiwgQ0lQIGtlcm5lbCBtZW1iZXJzLA0KPiANCj4g
T24gMjAyMS8wMy8xOCAxODozMywgbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanAgd3JvdGU6
DQo+ID4gLSBDVkUtMjAyMC0zNTUxOSBpcyByZWxhdGluZyB0byBYLjI1Lg0KPiA+IFguMjUgaXMg
ZW5hYmxlZCBhcyBmb2xsb3dzLCBidXQgd2Ugd29uZGVyIHdoZXRoZXIgWC4yNSBpcyByZWFsbHkg
dXNlZCBvciBub3QuDQo+ID4+ICAgICAgNC40LnktY2lwL3g4Ni9wbGF0aG9tZV9vYnN2eDEuY29u
ZmlnOkNPTkZJR19YMjU9bQ0KPiANCj4gT2ghDQo+IFRoaXMgY29uZmlndXJhdGlvbiwgInBsYXRo
b21lX29ic3Z4MS5jb25maWciIGlzIGZvciB0aGUgT3BlbkJsb2NrcyBJb1QgVlgxLiBWWDENCj4g
aXMgdGhlIHByZWRlY2Vzc29yIHRvIFZYMiBhbmQgd2UgZG8gbm90IGN1cnJlbnRseSBzdXBwb3J0
IFZYMS4gQWxzbywgVlgyIGhhcw0KPiBiZWVuIHRoZSByZWZlcmVuY2UgaGFyZHdhcmUgZm9yIHRo
ZSBDSVAgc2luY2UgdGhlIDQuMTkga2VybmVsLg0KPiANCj4gVGhlcmVmb3JlLCBJIHRoaW5rICJw
bGF0aG9tZV9vYnN2eDEuY29uZmlnIiBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIHRoZSBDSVANCj4g
a2VybmVsIGNvbmZpZ3VyYXRpb24uDQo+IA0KPiBCeSB0aGUgd2F5LCBWWDEgaGFzIGFsbW9zdCB0
aGUgc2FtZSBoYXJkd2FyZSBjb25maWd1cmF0aW9uIGFzIFZYMiwgc28gdGhlDQo+IGtlcm5lbCBm
b3IgVlgyIHdpbGwgd29yayBhcyBpcy4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gbWlubWluDQo+
IA0KPiANCj4gDQoNCg==

--zykyOkPt4sjYuUB7vvfD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6296): https://lists.cip-project.org/g/cip-dev/message=
/6296
Mute This Topic: https://lists.cip-project.org/mt/81425316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zykyOkPt4sjYuUB7vvfD--
