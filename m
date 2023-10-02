Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09A0E776C6
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 21:34:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.94989.1696282489829987762
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Oct 2023 14:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 392LYkkY4189713; Tue, 3 Oct 2023 06:34:46 +0900
X-Iguazu-Qid: 2yAbzM2tfBZ86aAU3U
X-Iguazu-QSIG: v=2; s=0; t=1696282486; q=2yAbzM2tfBZ86aAU3U; m=sS9BXLj7P3k2EUN8ZS+3ng+HuoS7ZQ+tJq5tCYA5LMk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 392LYipj3005154
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 3 Oct 2023 06:34:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATEiNgFLzJf1NySx61KnXYhzfNOVxNw8jJ5Su44+e4OReD07yEiHEjFyCLTsmAGYVCUZchHc6qj6AZTeZRfGuQnBxlbWkjnixg62BUZ0lDpT21RG/fxV4qg3wkwQoFw6vLUuB3iCIa7+ZjrUAQZE0B7ipva7mk32QaV+N0N15CwZdIOwNPpo3y0wx4pplopzJYBQOylYaATYR4ld6GYOVRsR2APpYKNVDHnDYzG4cf0c4BeNWCDp20wJnreNs8ipdA2ZORtXgQTaNt4M/I0Gy/iU1IYwSGpZ09hhG3G7LMCDv5FBkjQmkaTax2HWG3GoTHgLqd6wWtzrIe9w24KL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxc0dw9WBgSu3gaNrJBJ7eHlbUz9gUDRmPCx/kbRT6U=;
 b=HMLl1Iu/OYsf+I2T44d6kk4U+YLfCtGIoyxPRUmA8yTKU1SgkJWif5hw9vuz+VNb5WUV4gSbk85+j/nbnsoFTBLWaiD/3JSWuMF54XjHuv2csgxL+2iCj6X0tNe6jVE7SWdRnkBgpQk4alL/0wJ0zEO/erck3pL9UbzpeCje1Eoh39Dv9z3fxOm9I+gYJxCOCXS6bIXL0q/CzEYSpdokqgl6aasUg9rKruCtEybr3bDhfRw2wUfQ4TyAx4tqMxZZ3h2LtbltQVzGRFi23rftFzl0jusJvvrECaLfb2Hs0XCC0iOjXh2ZXQpxQ5G13narjyAUmOH/kfuqw6U5AtJHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <iwamatsu@nigauri.org>, <minmin@plathome.co.jp>
Subject: RE: RE: [cip-dev] [isar-cip-core][PATCH] Add support Plat'Home
 OpenBlocks IoT VX2
Thread-Topic: RE: [cip-dev] [isar-cip-core][PATCH] Add support Plat'Home
 OpenBlocks IoT VX2
Thread-Index: 
 AQHZ1Wf5/CLWZkRDa0OLNZTE4Lk26K//SywAgAAaeyCAF+S8QIACp9MAgBvk4SCAALMngIAAutBQ
Date: Mon, 2 Oct 2023 21:34:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245F45500C758184F6369A092C5A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB94205EE74FE50218B3F3001B92F1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <bd108908-8c22-4eeb-9a60-f386e300a2a9@siemens.com>
 <TYVPR01MB11245B2B585370AFFC3C2E88F92C6A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <1f5ee65f-5845-4603-9894-6e22ef29cfd6@siemens.com>
In-Reply-To: <1f5ee65f-5845-4603-9894-6e22ef29cfd6@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB10310:EE_
x-ms-office365-filtering-correlation-id: 02cb20dd-56d9-4b9a-23db-08dbc38f639b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 MOT88teFobOjiqQG5CR23KVmZtY9BGn1+mpXI91Z97UHDmKeahgYkM3tdaN4CkkhZWDfD+zCQ1E1U6DFZktfRGkOSZK/c98wO4qDN6U2eAYvz688rTUfJm9V6n9tTz+bAKYN7cX/V4Gh0FHfmzF7ZZKWViLQYHzn79Gxf5hGX8GVb4m7H+mLsSh+Am0vfvX/18Es9cgMsr5SphuVOZUHBYGtas8DhuZUQ2I6XV9QucH3oG4cK9fpbJj6ndFBDdZYu8AGinDwz2I33L1SW7bmkddau6Sh4w/u6b1vjZBGdCNCY+UpEcW8q4xfkhO1ucWARvQmyXDwMLGCfdgg9wvxMJBYnRiIoyHibarIhyxGglQvhTP297JHUL5rjwpj4EnaAtAUUwlsagG8jyBrP1fKwGjU4WDgWsiqCarCi7Dx//grtSCpgthidf9coTF7a6Fp22ZOlWS8fk5ERFJpFwWHiL76xnVZUm6bmF7joz+Wk1s12X+NKKhvBSGkI8Q8ApSUDNQK98+w6Xk6QKBCfmJV1EJztHL6TPaZGkf+vk49QZ/7PaukhIqngD16ytNJgLfBwRsAhBQMJjO/VxeUOKQG2s4MbtGtiMvunLGA3m0GId8/gFbBrieSdl7qGQc9Cvx2nmCyXJvDJA7O/JZ0HMejIg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66476007)(66446008)(66556008)(64756008)(54906003)(66946007)(76116006)(26005)(110136005)(6506007)(9686003)(55016003)(71200400001)(7696005)(122000001)(86362001)(38100700002)(38070700005)(33656002)(478600001)(316002)(2906002)(4744005)(4326008)(8676002)(8936002)(41300700001)(5660300002)(52536014)(151773002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dGZsa2VRUGJKaGdFSkdqSVhHendvdC9WNld0allpNi90T2M4VkdYbHFzbmlT?=
 =?utf-8?B?NDlJZlRJVmJwWjJGYWZFallBQ3hxUHlIcW1UUmcxWFdBbEJ5cnU3TW1KaDJh?=
 =?utf-8?B?cmdmV0ZNWnhMTjVYTWpjTkZDR1lqSmcxMStLaURzUzVtTzR4VUxSbFZ4ZEFz?=
 =?utf-8?B?bnYxT2czbEtBQ29JdXRUaHNRVWh2cVpNR1VrUzZ6dDBtNWxiWVlYSTJJM0FP?=
 =?utf-8?B?MlNha2tZRzlZcENaNVNVRlluVVUvdW9UdDBoa0U0Ty8zM2lGYldtS1lSVkxM?=
 =?utf-8?B?cS90dTMxU2VwMXhINHR3a2JyTE4rZkowaGNMNVZ6My91VXg5SGtTNmdOWitZ?=
 =?utf-8?B?SFY5WHBKK0hoUEtwbXljNUtka1Y4TDcrbzNvd2lacUkyTzd4Y3J1Wjk5eGwv?=
 =?utf-8?B?UjR3Y2ZCeXo0YVYvSk9kRlRhUElIQk05TllLVkhvUlY3TzJZUkhxdytMZmNW?=
 =?utf-8?B?d3BuWUcwWUErcGt0cjJXL3prbThmZnNxaWErcld0SGI2b09qc1BLSEE4MkpE?=
 =?utf-8?B?NHZ5dURPaWVyTlk4TXdCT2N6R3VQRFNkalpGamlETm4xS015S2NjQzJoM0RV?=
 =?utf-8?B?NGpoWWhibThYU1lUMDVGN20zallFSWhrWU5mdFN0SnlPdkhCZDhoWUNoVFVt?=
 =?utf-8?B?M2dZSmVlOWl2UlVoSUFGRExCbHVtRDl4UE9vMGNXRVlGeWZJaU1rai9lS05I?=
 =?utf-8?B?c1hzZWlLbkRRVjBOVlBtL2NXL2FML3BpRjFabCtDYVZIZER4emZGYTZSK1My?=
 =?utf-8?B?VHBNQ2JxQ0UzWUZHRUYzZVBzYktUdFl1VVlJK1FDQytYNlBSZGMxa01oMzhi?=
 =?utf-8?B?cjc5bnVqeXRwanIwNThHbWVBbGNkU3NLTnVXY29mYzBUNWt0RFYzNjk1Vmx6?=
 =?utf-8?B?eFVqOGYzRlBZTS9vMU0yWVhpS1lTbi9JRlh6MUJGRmdTY0dvQ3R5dW5yb1hW?=
 =?utf-8?B?RXlaYUdTS0lkdTYxQzZ2a1dCN3BER0JHRnd4Slk1ZW00MGpBTWRlUVBTZjZV?=
 =?utf-8?B?R1MwUXpIY2d1bVBCSGVHQjF1WmdzNG5BdkN0R1FFSG11ajNOdlg3dVRQQ2U3?=
 =?utf-8?B?NW81ZlFZMlJXcEcvbW9adTVUeGN4S2dud0M2ckZ3cHdUN2FZelU2RWtFcVZQ?=
 =?utf-8?B?UlJFdUwrVllUajNSUW5XMVlmSmJhemoxeDV1KzBhcUNkYUphcHd2K29ySXkr?=
 =?utf-8?B?UHREVHAwa21zZlBKeUNtaUxqTEc2SHlJOUFLY1pPeEl6cnV2bE5FUFBqSjFL?=
 =?utf-8?B?WDY2VkEzU2xrWk5QR1V6VDhBZW5VZlVQamZ5SDFobjNHQW1xNnJQanJtMDZk?=
 =?utf-8?B?VWErODkwTXltalF1SUJURTdvM3NJTlc0NlUvcGFWTmtuVWlQVmpTNzVEK3FC?=
 =?utf-8?B?VE9MdUxnSWYwZ0Yxd2xxaEx1emMyTkxwYVhTc3FTM0pqZXAzTGNFajA4MUkw?=
 =?utf-8?B?S1BISzVQZHArVnlzQi9TUmJ4bE1LVFV1YXFOUC8wT0JaZzNCREFSOHVKeVZX?=
 =?utf-8?B?TTd3NVhIZEpHVVJOYUloR3Jic1dYZXovZHczMHFOaFYzM2t0MENyRWtIcVk3?=
 =?utf-8?B?N0hEN3dwL1JnNHJzaWtvZjlCd1ZrVFNiVWEwVFNuWHJRaEMyR2dGNTM5YTBN?=
 =?utf-8?B?OWdKZ1NONVhIck04UW90d01pZVVJZk1LV2RSTUoyZ0tkRW0vTWdoU0JkRUFm?=
 =?utf-8?B?QVBTTUQ4VC9odjZVTm1PYmlYREk4TGRqR3Z0V1Iyb3pUSDE3eTNianFibWdL?=
 =?utf-8?B?RXFyamhjdk9RekgvY3VyNC82Znd6ZlN6UkRtRlYxVjJNeVA3aDNZQndpTEdn?=
 =?utf-8?B?bEZiVG1tRTJwdHZselZVYTU1cTVKSE82UWMwalRpQU9ycGZmaVFlYStOY2Fs?=
 =?utf-8?B?Z2RNY3R4VERKeEZGRXJnTm95VzlhZExKdEVMTHE1OUFFVkxFT3JoTzRXSURj?=
 =?utf-8?B?Ym9vVUgwZnFmS0ZML0dOWk44bUVlcjVEcVFTbzRpVURpOFRyU3ZXaGRlck4v?=
 =?utf-8?B?MDlOdFNoWktWSTk5bU1OU1lMTk5yU080RHQrdzg5ZUZxeUZiam1ydDNCM1BD?=
 =?utf-8?B?ZzVhdWd4RmtmR3NmblBTZzgrVTlta3g1YUZJTVlBRDdWYUhVQ1RzN2xnMFdu?=
 =?utf-8?B?RXRPMTZmbGhXQWdSY1Q0MXV0RFdKbE5EcGQvVHhCK3EwYUFpQ3hyMTl3OGxl?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb20dd-56d9-4b9a-23db-08dbc38f639b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 21:34:42.1796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIMG9JTZZRb3Y69Cy7A6bGaeNne/QxPLVAa27ngidoLKX9pCFNepDbzOkK/TrkS081ZbkgY9T9Gbk8W7FzkK3QhUNsMt3Vu68j3EzadvObn8oqgO4Hw5FDYi/GyigT5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10310
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Oct 2023 21:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13263

SGkgSmFuLA0KDQo+ID4NCj4gPiBpcGMyMjdlIGFuZCB2eDIgY2FuIGJlIGludGVncmF0ZWQuDQo+
ID4gSG93ZXZlciwgc2luY2UgdGhlc2UgYXJlIGp1c3QgYSBjb2luY2lkZW5jZSwgSSBzdWdnZXN0
IHRoYXQgd2Ugc2V0IHRoZW0NCj4gc2VwYXJhdGVseS4NCj4gPg0KPiANCj4gSSByZWFsbHkgcHJl
ZmVyIGNyZWF0aW5nIGEgZ2VuZXJpYyB4ODYtNjQgdGFyZ2V0LCBub3cgdGhhdCBhbHNvIHRoZSBN
LUNPTSBkZXZpY2UNCj4gaXMgYmVpbmcgYWRkZWQuIFdpbGwgcmVkdWNlIG91ciAoYnVpbGQtKXRl
c3QgbWF0cml4Lg0KPiANCg0KSSBzZWUuDQpJIHdpbGwgY3JlYXRlIGEgcGF0Y2ggd2l0aCBnZW5l
cmljIHg4Ni02NCB0YXJnZXQuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


