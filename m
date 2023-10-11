Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B65CD98E0
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 00:04:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.5183.1696982636486830847
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 17:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 39B03rCs113641; Wed, 11 Oct 2023 09:03:53 +0900
X-Iguazu-Qid: 2yAbn6s0GQdjJpY9tD
X-Iguazu-QSIG: v=2; s=0; t=1696982632; q=2yAbn6s0GQdjJpY9tD; m=dmYt/THlm7Qh3+rF0yGtMPmujkAHgDClrYfDr4cgQLM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 39B03pbF2885021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Oct 2023 09:03:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtvizhD4yfDaKsuqfobURUr13XXATjym7miZif2X0iZ35HQk5KV6cY9eFql5XGWr4QaSLaDLrPajywi5kugoY9D6cciGJRjKgrctZZZ6Uiw9nWcazDGLcjUnDojFAVh3vfK3Do3ZeZ3EAZGOyybjCPODtbn1zjQsRLnkexxvsih2OXDWNcz7+1buVaXmsHUV+i7etPIRp1kiT6VIVLAGWCnCCFFdNmYdp+0CZMOYM/fG+cc4SzxfhcJZOQRXAarfmMddLbNQ12SKAcy8UTVkq82PuA1h+VQ/nt8bmylKBQ5d135b0//nlaihDQiz2VV11rN+b5UunfHB243hMcLsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqWvt63s+UBM2YvPXi0txk60BXHFzKOgqzkW0wrrN9M=;
 b=koj0D5Hi6ufj8Z8x/BAl93aWZT0p9bzF8teFbqsogZYu/VCbQORhoRWtgNldnFHuID+8WWZ4BEdR9jH8r/Ve9INv8Y+HS2OxlHyH/x3hd9A06IxDxMiqyoPsswGtE/PJSmvSH+/OuFJd+dju0WbbqBB/KoCqWHIqU7MuXQQKZl6qT/Yaq6IIq7tCpL4yw46l17+zUFGyNhikjMh41CFVlPQzg3DzG+qS5UrYEhY0k8gQkBQLSjsjp/fgDG6pEN1UfqJnqdUbzEDwb0gsl032xkaxlz8fTFclGanP83hZ2wdeqsCEID3MusUiNWa1vmcTc3mnZIcwxiEi4SlSvbSfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <minmin@plathome.co.jp>
Subject: RE: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT
 VX2
Thread-Topic: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT
 VX2
Thread-Index: AQHZ+1FTAtHCB/vwW0aQeKQEbMcuubBCsgqAgAACjsCAAE86AIAAr9yA
Date: Wed, 11 Oct 2023 00:03:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245513900059273FA943B3092CCA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231010081034.3762306-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <3781349a-2426-4fc4-9e9e-1d543112375f@siemens.com>
 <TYVPR01MB112457EF240E3EE05EF931A5592CDA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <e922619e-545f-40aa-bfdd-9c716d6d1413@siemens.com>
In-Reply-To: <e922619e-545f-40aa-bfdd-9c716d6d1413@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYWPR01MB9541:EE_
x-ms-office365-filtering-correlation-id: 4a3295e7-e290-47ac-2e28-08dbc9ed8b5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OkFinXINNvytKI6hanqQE38Ln/0TVwf4dlMnoQSHbjLlnM4eVyqNTSSSglvmrTR1qOT2a0VJ4raE5V2WRRDMnhML4SONjQFQcNose0NCZ2y5m3DwnOYRH6ACj75pNdmXsEccXd6+7UP7+/NVbKX7y32Ey6aEWx1bZwNSrPFrbVifORHisQupSJcgRPCzMP0a6r9PTCiSDYFTIEwCJvlLO3W4Tzr+hVR/dl8G1U5HCt8hBK4w2CjlFPIgwaRO/Ygs9Kp9cbPu7svCVCoKFyDwhAPATkpWkh/32EGWQL7VEq7+txM9iHaldURV3E6l3qOHIN7/Ad0OMRTovvhL1jxCd4F9td5/6q8d3IVCos5j9hQAveIosGKCaZXSy3g3UB13xFr5W7QG7A4BYH5tgOfQwJw0FNQ2NnTmz0Hg8hPgLnlTAj2Wyfzg58x5WCioZXo1xQlFUFgV1ZgmMvUJlC6NJlLH82laZXk/4djuMgrYCJbCItnfwXmlKoMi9nijUPS0BpYWsMy5VpoA6xUa5TmpM1SP24WQUs55Q3rk84O+HksOq2BpkwE9mcf1enO9JeEL+knfXiwtUVgEb5yIa4n0YSgbm1ZG6yiuDYZgnBXwlt9Z/9rCc1gBUEs3CJgz6L+b
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(26005)(6916009)(64756008)(66946007)(66476007)(66446008)(38070700005)(33656002)(316002)(76116006)(54906003)(41300700001)(66556008)(53546011)(38100700002)(8936002)(8676002)(4326008)(2906002)(122000001)(5660300002)(52536014)(55016003)(71200400001)(86362001)(7696005)(9686003)(6506007)(478600001)(966005)(151773002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K1E4OUhiclVRY21yT3JoWHREMWpqOTFSUGo3Mm5xT2M2dGVYb0NmL09iSGZ0?=
 =?utf-8?B?c2ZiczhIdTdFeW9UYXV0MzlYMTA4K3hLSkgwS0doWmtEdE5oNldUcWVjRUdl?=
 =?utf-8?B?WFllK3ZodEJIYzlsTUJDV2EweTBqaUh4TnF4RUhjQTV5RXNlZWU1djYrZ0ky?=
 =?utf-8?B?aEVqYm9FQll6eWpQV1F4ZDM4QytWMnRLQ3dPTVc2Y0JOV0tWQVFCYlp4Y09T?=
 =?utf-8?B?QXpEck9Hc2JTTVBIaWpna3ZzSUNXb0dReE5vOUVZQ241SDFsWnRoaXhMRmZw?=
 =?utf-8?B?QjNFcHEvS2w1SlZaSDlXenJXV1dqRTZ4Y3RCZTBSd0Z1clNyNGNtQk9oNTJX?=
 =?utf-8?B?cUxQc3dvblJPcmNSSnhoT1NTRCszNllwSndjVVkzcVlqVlNaYjNjaTY4Q0JI?=
 =?utf-8?B?UnBqenBmbzZjaTJMT1g1V0FNejk3TkRkR3R4RXZnMGVRZk9wSUtwYUpvY0c2?=
 =?utf-8?B?TFptazk3bzl2eCtZeFVSUlJheUpzR2tEVnE5SFBtVHIwNlY0aDFPMHhrbFNx?=
 =?utf-8?B?eHFxaTdabHVKRjI3RDNYTGhpVFFYazVCWUwwZUVDcWZiR2xlWDZFcG9xQkR0?=
 =?utf-8?B?eHNnUmdGdk9TYjl4VTJ3T1kwT284TXZFd0lxN0hpZ1ovT1FVVVYyUXUwdGZQ?=
 =?utf-8?B?WHNINjNxNllPRUpKRklzTy9YWi9QaDIxa0VvQzJlaFQzWmp6NjhCYXBpbTJj?=
 =?utf-8?B?VkcxbUR0ZnFVVXlEMFp4MzV3SEVnbTFwaUdsUzFUOVlvaW00TXJUUDZQcUJR?=
 =?utf-8?B?TzQ3aXNNSnFkVnh2alZnK0xuTmcwc2prRngza1UwMzRScExtMXpONXV6OVNT?=
 =?utf-8?B?M04zWUc0c2pzTDJxOU1tY2hZbzE3OUpDSm1UYzQyTEVPU2w4ZHZ1VlBXUUxq?=
 =?utf-8?B?SG9mZFVJZEoyQVRwSm5yeGZQbm12TnNZZVBZM3VPZDVROEQ1YzlVWHY5VWFK?=
 =?utf-8?B?ODQzZ2pCMGx3Rlo5Q05VdW1DM3ZhVHBlNEcyR2c0QjM0K3V5QkRzZGhFR1hz?=
 =?utf-8?B?ZTV2TFQ3emJacjY5MFFZZG5vaFk4RUpqYUxDbms2ODdDODgzblJ5RlR2L0lT?=
 =?utf-8?B?bnZZaDNkVk8rLytNNGVaMk1nR1F5TDg4Q0FxaWF4N2svd1ozT2kvcDdMSGxB?=
 =?utf-8?B?aFFnbXQ4NDNweDJmUVVSMEtZNm1HTWEzNjhjd2NMWXJuWnBqdzhvRGM3WWpO?=
 =?utf-8?B?UGZpU1E3RSt2R0h6T3MvdXZETnIraWk2aFRLSEtXUkF2ZFp2d1VLbE0rdzlZ?=
 =?utf-8?B?MmYraC9hb2FTMURDWUJvOXNBZEZva2QvSFVkanpoQzZUT0hDWi9QbDRQRGlC?=
 =?utf-8?B?dlVubnhmZjZxak9zK0lyNFJWWmdzNVhRcU9nTVBPcUhyV1dOWHliaWc5dnVJ?=
 =?utf-8?B?UzFuaHpjMS9vcm1PT2I3SE1zdyswUGFHOExyMHp1TTRsYWVWcmxtcGoyVTR2?=
 =?utf-8?B?b0Jadjd6MmN5a2RXTFdRRnhta1BLOVdDaURyTGJ1ZktmMk4vSTVET3Ztc3BT?=
 =?utf-8?B?ODVJMVp3a3NwVW52THZqYTIwRFVjeWF5bythcnhkRkF5dGdwNHc3SklyTFZY?=
 =?utf-8?B?aTZqaVBycE5mSm02MjNPaTI3MTM5WHRvbUV3d0hZdE1jTUg3THcrSkRzS3hM?=
 =?utf-8?B?SHVUcitGN0VPdE1YMFVsWXQybTVEak1MaUg1Yzd3NVJiOXM2bllZMFVBVytW?=
 =?utf-8?B?Q0pXS3FtMkNLSkNVWi9QejN5eDZWWVhCZ0FIMU9wNWhicWdtc3hyZjJ1cnFS?=
 =?utf-8?B?L0VXT2kxaUw2aFRJR0dzSktSamVkeWNUTmNGR0hhcTkvSDNROUUrYzlvT3Ju?=
 =?utf-8?B?dGxvcythSW4yemgwT2pjeWtyNjduSk1vY01Hd2k3L1FaTC9JNTk5R243U29u?=
 =?utf-8?B?ZDRNT2JuZUliQzQxL1N4cy9kMVh4dlE4aEFnSExJekRsWWgxbnZGTmhKaU0w?=
 =?utf-8?B?dWJYLzVYRitWL09MVGZNWXhCdnQ3QmllTUNvSUF1MGxlamt6bk9JT3R5bExF?=
 =?utf-8?B?U1pkN1dNSDlzRlUrVFU2S1lwMTBRWVEvMlhRSkE2NWRqTmgxK05JWmZRU3BE?=
 =?utf-8?B?WS9HOWpoQ2lWVkFnM0drNGV2bXA4QmtJNEN4UmJQWXk3SFNVMzRQa0NyRGds?=
 =?utf-8?B?c2VKenBTWUk3aGF6UUltbU1ZZS9jZm5yZUtrV01kWDF6SVg4OGVaemFJQTQr?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3295e7-e290-47ac-2e28-08dbc9ed8b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 00:03:48.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNREWeRHvPNOcMeAHN9e1v7/wnapWldJwroqIficuUys37oeCoZb2lNUC7IzDlGNMOQGZacLmgCgGdem+TU4Et2axwfmsDalceFzOgJZFTnFp8EFyRKlPHyH8+mQtkd7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9541
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 00:04:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13382

SGksDQoNCj4gT24gMTAuMTAuMjMgMTU6MjMsIG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNv
LmpwIHdyb3RlOg0KPiA+IE15IHVuZGVyc3RhbmRpbmcgd2FzIHRoYXQgaXQgb25seSB0YXJnZXRz
IHdrcyBmaWxlcy4NCj4gPiBZb3UgYXJlIHByb3Bvc2luZyBhIGdlbmVyaWMgKipPUyBpbWFnZSoq
IHRoYXQgd2lsbCB3b3JrIHdpdGggb3RoZXIgeDg2XzY0DQo+IHJlZmVyZW5jZSBIV3MuDQo+ID4g
SXMgdGhpcyBjb3JyZWN0PyBJZiB0aGlzIGlzIGNvcnJlY3QsIHdlIG5lZWQgdG8gY3JlYXRlIGEg
cmVmZXJlbmNlIEhXcyBjb21tb24NCj4gKHN1cGVyLXNldD8pIGtlcm5lbCBjb25maWcpLg0KPiA+
DQo+IA0KPiBFeGFjdGx5LiBKdXN0IHByb3Bvc2VkIHRoYXQgYWxzbyBpbiB0aGUgVFNDLiBPcGVu
IHRvIGhlYXIgaWYgdGhlcmUgY291bGQgYmUgYW55DQo+IGNvbmZsaWN0cy9ibG9ja2VycyBpbiB0
aGF0IGRpcmVjdGlvbi4gQnV0IEkgdGhpbmsgeDg2IHNob3VsZCBiZSByYXRoZXINCj4gc3RyYWln
aHRmb3J3YXJkLg0KDQpHb3QgaXQuDQpGb3IgZXhhbXBsZSwgSSB0aGluayB3ZSBuZWVkIHRvIGFs
aWduIG91ciB0aGlua2luZyBvbiBob3cgcmVmZXJlbmNlIGhhcmR3YXJlIHByb3ZpZGVycyBoYW5k
bGUgdGhpbmdzIA0KbGlrZSB0ZXN0IGltYWdlcyBhbmQgdGVzdCByZXN1bHRzLg0KUHJvdmlkZXIg
a2VybmVsIGltYWdlcyBvZiBDSVAga2VybmVscyB3b3VsZCBsaWtlIHRvIHNoYXJlIHRoZW0gd2hl
biBydW5uaW5nIHRlc3RzLCBldGMuIEhvd2V2ZXIsIHJlZmVyZW5jZQ0KSFcgcHJvdmlkZXJzIG1h
eSB3aXNoIHRvIHRlc3Qgd2l0aCBrZXJuZWwgaW1hZ2VzIG9wdGltaXplZCBmb3IgcmVmZXJlbmNl
IEhXLiBJbiB0aGlzIGNhc2UsIEkgdGhpbmsgd2Ugd2lsbA0KbmVlZCB0byBjb25maWd1cmUgdGhl
IHJlZmVyZW5jZSBIVyBhcyBiZWZvcmUuDQoNCkJUVywgSSBjcmVhdGVkIGEga2VybmVsIGltYWdl
IGJ5IG1lcmdpbmcgdGhlIGtlcm5lbCBjb25maWd1cmF0aW9ucyBvZiBWWDIgYW5kIElQQzIyN2Us
IGFuZCBjaGVja2VkIHRoYXQgaXQgYm9vdHMuDQpUaGVyZSBkb2Vzbid0IHNlZW0gdG8gYmUgYW55
IHByb2JsZW0uDQoNClZYMjogaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9q
b2IvMTAxOTM0OQ0KSVBDMjI3ZTogaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxl
ci9qb2IvMTAxOTMyOA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


