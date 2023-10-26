Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9873C25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 10:07:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.67133.1698314818098049510
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Oct 2023 03:06:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 39QA6uMY2898664; Thu, 26 Oct 2023 19:06:56 +0900
X-Iguazu-Qid: 2yAas7v1hP15UcNciR
X-Iguazu-QSIG: v=2; s=0; t=1698314815; q=2yAas7v1hP15UcNciR; m=r9FysevepoquHPt1KbLYo409LDz8KmZYRggHEDZjX5Q=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 39QA6slD165649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 19:06:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnJTmEBh8DgeloNQPfzC19luJT+gfzRji0th5nhav795BMxXMum5ThwxpNpUM6SSjF2nGeTbzbFmzVs14rNnIkTdDDJHKzYqBt9dqTv0KmOVYGZFCRm7Cypaj98yQw8B2St61HvkBRELB//e/P9XhhM7tSmzS/ISAfQjvIP6JKBlnPy1Uw5H9PftexJBkFEN3pBa+kiCOCBduuulms61D+539dvRA/cTd5h0f+H4dF9hIqf1UiZWwCUo8iYhEECTLydJuxxm4DmAJKTcmtTHhHit0YpmNA6vCzyCfeu2bj7LwdymXC4IW3G4Wygp4blPacBuy2TgFRlucoWFVN5yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0F6I3pTXPEjxI+ar4Wbjs1vhO9jXQxq1CWaoGqPKqM=;
 b=em4NiM2Cv4gyAJ6rfspvFl+y6p1IsyMJER+ZFld0/s6GOMnTxj+jRN4051CIzzt842wg5oXorKtKVaUN8/5Kik6dAU/DIAX2gq1p1uVsb4RQidOfyqnM823OKBFSJYdIXf66ETOO7TjQloiwiM/rJ2mv95qw3TTjpUZg4IHrYoWoztdKg96ro6cG11VQk1ncMN3hmDNdXfbG7qWu/VQ8SvxSb3TGcMmF+IheFZlQ5pbF87hpHpk/up5de3YR7Uf8k6/ucdu/xEwHrEfQkjDdYZsR3ERnHGrbxvkKPgkY8qnUqi6ugh/+J5ZZe2AC0uJ7vOZTXeWBvNxL9+03GXN7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 2/2] README_version-release-policy.md: Add product
 description details
Thread-Topic: [isar-cip-core 2/2] README_version-release-policy.md: Add
 product description details
Thread-Index: AQHZ3K0R/NWd0/zpEkSBOxIQR7HOIbAFx9IAgCiIKCCALd2YYA==
Date: Thu, 26 Oct 2023 10:06:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB4945F04BEDC0D632D88376E9C2DDA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230901081943.1816811-2-Sai.Sathujoda@toshiba-tsip.com>
 <03e48c84-2497-49fe-a61e-2e1fe6b95251@siemens.com>
 <OSAPR01MB49456019A81DE8EA4D79E820C2DDA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSAPR01MB49456019A81DE8EA4D79E820C2DDA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TY3PR01MB9699:EE_
x-ms-office365-filtering-correlation-id: efe932e4-bad2-4ff5-2be5-08dbd60b45ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tlKHUWVHZgikpYGKS+eVt5GXFbfwh2kH+5IxGP9uir9LCPQ89v5LnUvCIjLH6ZGXQa63Jn4uE1hHlbeSDNgroVdJYozkTYu3bjx6lW+heLuvWYSHkZHSxfIn5MmDcaelRsn2zfAqH1HC+2JyKc8YimA3YJJovd5mCAXoc7+y5sjLtFATEdqkkPIhWf6n217zrZhSwmuc3VEt2V+FMJOUWx0eHzT+X90gOIGWqyJ11wKVEzWoBRFOVr0KYXQiNB8B9n/zDChA77q7e8a5ohOAaw6rAb0r5f3Y0BL0+j8vTm9IbHE0sHwWdPlDyrBqM0pd8DSwQIpQTgDm0LYAjFWy6XnIlcWH34v3sj9bVHzYVbKp0J3DhIF5SH96pIdCxpYAt0gDDL1HjNTr8KsGY9KOBxhrWBLXQPxVZcMbtfmpz6YPU6lXazCkASCv+NzTOaUhvUKennKBIJa0AAB5v8ANQZhmyFc1AEOEIEew8vzP9kzi7AmnWkb0F8pEvu9AFrJeo0J0zyOyQKWdyyjJNDjJRsBU4gJJxYN0hlzOs6Q0fK9sOB9AItxR5e1Kfnt5++HdGEn3Qnv5p5+Vttq9FoXivSHbwf50DYDsF7Mp1+Fe9eg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(52536014)(5660300002)(8936002)(4326008)(83380400001)(7696005)(6506007)(107886003)(38070700009)(41300700001)(8676002)(26005)(316002)(2940100002)(9686003)(66476007)(55016003)(66446008)(66556008)(54906003)(66946007)(64756008)(110136005)(76116006)(38100700002)(53546011)(122000001)(71200400001)(478600001)(33656002)(85182001)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RHdFUmsxZmdCNFFDNmxQVnB6MWxhLzVpOXRHUE02WSt4YmtOVWhsamxlVThv?=
 =?utf-8?B?anNrc1VsMFNjQmtjVVJwWmJXTURwanlxWG5uZkFHaFdySitZK2dNendhd0Ro?=
 =?utf-8?B?dHJOd3FWVU51TGErWThjbjdOdGJpZ3lDQUZMeXU3ZGRwb2JOaWhTbE1sMTBR?=
 =?utf-8?B?akRHTXp2QVRTZ1dJNUZoQ3VwNmRDdmdKQ052Y1pyanZzRURXOUJUT3BmbTVT?=
 =?utf-8?B?MklVWHpkNW9nLzIzTlh0ajUza0UzV0FOc29iQmVjaCtuK24xQ2orbWkvVk5o?=
 =?utf-8?B?L0ErTkdUMi9JZjU3T1dCY2MxTVVwbzVCMmVJZkdtRzBHMy9SN2F4U2ZSMkVH?=
 =?utf-8?B?YlJiTFo3UEU3dnZJOWFrNmJnTms0V09ueDByQU9nc0JaWEFTVHBtblEyL2JM?=
 =?utf-8?B?QTBrN1ZYRXZHekwwRzhZTmRIcHVwMjNXTWlzUXdSU1lRaU5Md0FqcGRuQjcx?=
 =?utf-8?B?Sm1ONmFFU1l1WHdQVjVGbFJDQTEzV3VFQlZZRjYwOFJiR1hTaGMvYklmVzBi?=
 =?utf-8?B?SER3Sjl4bDVjbzhhRzFvU2J5Mm9oTTczM3dlSCtIVnp5TFpra3RhOWhZalZX?=
 =?utf-8?B?REM1TGF1VW5nVXF6cXlrc29ZTTcyQ0VBMHY0ejAvMGFybHgzWjhzQys5bmJh?=
 =?utf-8?B?bUc0SXhkUEdnV1NiZ3NhKzMySnh2STBiTlNoZC9mbENMazg3S2drUHZjaW4y?=
 =?utf-8?B?RDhwNDhrRzFQT1BCb3ExcWs2QzRWdTJybGJRcGc4ZHhEQ2xDT0RCWUx3ZFVp?=
 =?utf-8?B?Zzd5UERRVlN2TnNQWXI2MnQ5dTMvZkxBMVRtOWx2RlFGNVpYOWYvV284VGRN?=
 =?utf-8?B?MEpOOXlvY0g1R0hSSWgvNjBxSGxtWVdpL0VFcExPYlVjYkVGVmRIem0yWmtM?=
 =?utf-8?B?UFJXNnVQYU5Sak42QW5BaldaSGhjQU8xOWFLL3J5MWdMeUs0YXp3S28xSWh2?=
 =?utf-8?B?eGF6Z0JncXhHUmpEUCtZUm92RVNvY2VxdTZJNDFtdzNHSThReXJVWC8zbGE5?=
 =?utf-8?B?NDh0Ym95ZktnOU1jMmZseFZCSWMybVZrT2ZFdmxQcUNUa3NiZkNNSVJjNUo2?=
 =?utf-8?B?QklkSk05YXJFQWhoSERnQmhQbnlWdmphSlhFaE1YWSt2Y1lSRDc0QXk5blBa?=
 =?utf-8?B?d0VjSjdONG1ZYjRFL2kzYkZtT3Vad08yUlc0b0RtMmhqdTNiYWpMWFZJWVdq?=
 =?utf-8?B?SDBhWFlvcVNRSjVlZTFWWnVJemZYNjI5emJ4YWpsN1dnSDNnc3hNSkVmN1hH?=
 =?utf-8?B?dFNYWlBNV3gyWkVQUW9iWWVHMkx2VHVhN3VSaEI2OUc0KzVXcUxVMlQ1UDA2?=
 =?utf-8?B?bUR3ZUw2WEt5akdMckhRN2tVWkZMMkswTWZ6Ri81bHpuZCs0WW1GOWdPUGF6?=
 =?utf-8?B?dFBjaHBLZUFWQzZheTlsSXd4VzNRL1IyNGZsSGVkTzlhakh1MjdjZDFzV1FZ?=
 =?utf-8?B?Z3BBOFZhSlpFdytaSUpZeTEwY2JmeUVLSndMekZBU3RQNStZT0lSTlRVMVZQ?=
 =?utf-8?B?T1JBZnZEN3FJelY1VHVDMXVpRVh5bGZsMDhQQ3VSalFVNFNCQjBWQjlSeDBi?=
 =?utf-8?B?aVczWEMwVHpWdFd3cUYzL0htTzFUSEVHQUllZGdTWHBKaElOY29pQzJ4bnNX?=
 =?utf-8?B?eEc4K3MyeDhGSWlWdk1WTkIzTGxRdTExbGlTNEhhaXZ6c3dLckJpc1J6R3JD?=
 =?utf-8?B?VXVENzB5VzhTUWVZTnBxVy9QNVUyZ1pENlhrVFpGeTBQSGtRZTZGeWUrU2xB?=
 =?utf-8?B?Nzc4R2NqZyt4MEcySzl3Q040djdrMHhZNG1xVFVEeEFnaUdCai9tRk4yeDZq?=
 =?utf-8?B?YnpKRERJVHExR2pkbUtQeTVNV0tJRmQ0Sk8vTzI5Y1EzaXBzSUljRDJycXBC?=
 =?utf-8?B?SjU3UHVLSmZVQkJBbEtSQ21ZK2VqOXpMR1lsbDdIaHUvaGsxaGVKMDkzMEg3?=
 =?utf-8?B?NGg1RmVuSCtDVWlCS2t0UFpBdXdrb0d2S3E2UFpWNnUyQ2hCeTdUREtSRlEx?=
 =?utf-8?B?dk84Mk1mMXJxT2pXTDZDL0dVUy8rM0w0S1ByRFBmTWdGakJYWmZTUXZ5ZGR0?=
 =?utf-8?B?RW04VzBhaTBTODBKazVzaXJJYzlUeXdobG5DTFpwOU1jZXltb0E4dm5tQWlM?=
 =?utf-8?B?Wi9nN21pQ25iQ3dGMG41OWdJUDRidldNL3UvajdEelB3aTFPcWdSSC9ocWQ3?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe932e4-bad2-4ff5-2be5-08dbd60b45ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 10:06:50.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljsKZOzcSXGAjr4GYGzd9QW9SsXjGmoGmrq5hpXEcdrj9Oj3POq1iD7v9PhcWC/TEdx/jk0d+KO5XlW1E1R8SwZsxoBGTJrKsO22JabwXNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9699
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 10:07:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13462

SGkgSmFuLA0KDQpTaW5jZSB3ZSBkaWQgbm90IGdldCBhIGNoYW5jZSB0byBkaXNjdXNzIHRoaXMg
cG9pbnQgaW4gbGFzdCBmZXcgQ0lQIGNvcmUgbWVldGluZ3MsIHdlIGFyZSBkaXNjdXNzaW5nIHRo
aXMgb3ZlciBtYWlsIHRvIGF2b2lkIGFueSBmdXJ0aGVyIGRlbGF5Lg0KDQpUaGFua3MgYW5kIFJl
Z2FyZHMsDQpTYWkgQXNocml0aCAoIFQgUyBJIFAgKSANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgDQpTZW50OiBUaHVyc2RheSwg
T2N0b2JlciAyNiwgMjAyMyAyOjI3IFBNDQpUbzogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFy
KO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRz
aXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnv
vKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNv
LmpwPg0KU3ViamVjdDogUkU6IFtpc2FyLWNpcC1jb3JlIDIvMl0gUkVBRE1FX3ZlcnNpb24tcmVs
ZWFzZS1wb2xpY3kubWQ6IEFkZCBwcm9kdWN0IGRlc2NyaXB0aW9uIGRldGFpbHMNCg0KSGkgSmFu
LA0KDQpXZSBhcmUgdGhpbmtpbmcgdGhhdCB0aGlzIGRlc2NyaXB0aW9uIHRhYmxlIHdpbGwgaGVs
cCBpbiBDb25maWd1cmF0aW9uIG1hbmFnZW1lbnQgYXMgd2VsbCBhcyBpbiBmdXR1cmUgd2hlcmUg
b25lIGNhbiByZWZlciB0aGlzIHRvIGtub3cgdGhlIGZlYXR1cmVzIGZvciBzcGVjaWZpYyByZWxl
YXNlLiBUaGlzIHdpbGwgaGVscCB0byBjcmVhdGUgaW1hZ2VzIG9mIHRoZWlyIGNob2ljZS4NCg0K
RS5nLiB2ZXJzaW9uIHYxLjEgbWV0YS1kYXRhIGlzIHVzZWQgdG8gY3JlYXRlIGV2YWx1YXRpb24g
aW1hZ2VzIHdpdGggc29tZSBzcGVjaWZpYyBmZWF0dXJlcyB3aGljaCBtaWdodCBoYXZlIGJlZW4g
ZGVwcmVjYXRlZCBpbiBmdXR1cmUgcG9pbnQgb2YgdGltZS4gTGF0ZXIgd2hlbiBzb21lb25lIGlu
IGZ1dHVyZSB3YW50cyB0byBnZW5lcmF0ZSBhbiBpbWFnZSB3aXRoIHRob3NlIHNwZWNpZmljIGZl
YXR1cmVzLCB0aGVuIHRoZSBpbmZvcm1hdGlvbiBpbiB0aGlzIHRhYmxlIHdpbGwgaGVscC4NCg0K
UGxlYXNlIHByb3ZpZGUgeW91ciBvcGluaW9uLCBKYW4uDQoNClRoYW5rcyBhbmQgUmVnYXJkcywN
ClNhaSBBc2hyaXRoLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuIEtp
c3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDEs
IDIwMjMgNDoxMCBQTQ0KVG86IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpv
ZGFAdG9zaGliYS10c2lwLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzog
ZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBUTUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1h
ckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNoaSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8
pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPil4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNo
aUB0b3NoaWJhLmNvLmpwPg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlIDIvMl0gUkVBRE1F
X3ZlcnNpb24tcmVsZWFzZS1wb2xpY3kubWQ6IEFkZCBwcm9kdWN0IGRlc2NyaXB0aW9uIGRldGFp
bHMNCg0KT24gMDEuMDkuMjMgMTA6MTksIFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbSB3
cm90ZToNCj4gRnJvbTogU2FpIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+DQo+IA0K
PiBUaGUgRGViaWFuIHJlbGVhc2VzLCBLZXJuZWwgdmVyc2lvbnMgYW5kIGltYWdlIGZlYXR1cmVz
IHN1cHBvcnRlZCBmb3IgDQo+IHJlcHNlY3RpdmUgaXNhci1jaXAtY29yZSByZWxlYXNlIGluZm9y
bWF0aW9uIGlzIGFkZGVkLg0KDQpyZXNwZWN0aXZlDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNh
aSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiAtLS0NCj4gIGRvYy9SRUFETUVf
dmVyc2lvbi1yZWxlYXNlLXBvbGljeS5tZCB8IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2MvUkVBRE1FX3ZlcnNpb24t
cmVsZWFzZS1wb2xpY3kubWQNCj4gYi9kb2MvUkVBRE1FX3ZlcnNpb24tcmVsZWFzZS1wb2xpY3ku
bWQNCj4gaW5kZXggOTE4ZTc3YS4uZjhkZGUzOCAxMDA2NDQNCj4gLS0tIGEvZG9jL1JFQURNRV92
ZXJzaW9uLXJlbGVhc2UtcG9saWN5Lm1kDQo+ICsrKyBiL2RvYy9SRUFETUVfdmVyc2lvbi1yZWxl
YXNlLXBvbGljeS5tZA0KPiBAQCAtNCw2ICs0LDcgQEANCj4gIDEuIFtPYmplY3RpdmVdKCNvYmpl
Y3RpdmUpDQo+ICAyLiBbVmVyc2lvbmluZyBzeXN0ZW1dKCN2ZXJzaW9uaW5nc3lzdGVtKSAgMy4g
W1JlbGVhc2UNCj4gcG9saWN5XSgjcmVsZWFzZXBvbGljeSkNCj4gKzQuIFtQcm9kdWN0IERlc2Ny
aXB0aW9uIGZvciBtZXRhZGF0YSByZWxlYXNlXSgjcHJvZHVjdGRlc2NyaXB0aW9uKQ0KDQpXZSBh
cmUgbm90IGJ1aWxkaW5nIHByb2R1Y3RzIGluIHRoZSBDSVAgcHJvamVjdC4NCg0KPiAgDQo+ICAj
IyBPYmplY3RpdmUgPGEgbmFtZT0ib2JqZWN0aXZlIj48L2E+DQo+ICANCj4gQEAgLTI4LDMgKzI5
LDEwIEBAIFRoZSBpc2FyLWNpcC1jb3JlIG1ldGFkYXRhIGZvbGxvd3Mgc2VtYW50aWMgDQo+IHZl
cnNpb25pbmcgc3lzdGVtIGkuZSAqKngueS56KiogZm9ybSAgQW4gYXBwcm94aW1hdGUgdGltZSBn
YXAgb2YgMyBtb250aHMgaXMgdGFrZW4gYmV0d2VlbiBjb25zZWN1dGl2ZSByZWd1bGFyIHJlbGVh
c2VzLiBEdXJpbmcgZXZlcnkgcmVsZWFzZSwgQ0lQLUNvcmUgcGxhbnMgdG8gZ2l2ZSBvdXQgcmVj
aXBlcyAoaXNhci1jaXAtY29yZSBtZXRhZGF0YSkgdXNpbmcgd2hpY2ggdGhlIHVzZXIgY2FuIGJ1
aWxkIHRoZSBmbGF2b3Igb2YgdGhlaXIgY2hvaWNlLg0KPiAgDQo+ICBBbGwgdGhlIHJlbGVhc2Vz
IGNhbiBiZSBmb3VuZCBbaGVyZV0oaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1j
b3JlL2lzYXItY2lwLWNvcmUvLS90YWdzKS4NCj4gKw0KPiArIyMgUHJvZHVjdCBEZXNjcmlwdGlv
biBmb3IgbWV0YWRhdGEgcmVsZWFzZSA8YSBuYW1lPSJwcm9kdWN0ZGVzY3JpcHRpb24+PC9hPiIN
Cj4gKw0KPiArfCAqKk1ldGFkYXRhIHZlcnNpb24qKiB8ICoqU3VwcG9ydGVkIERlYmlhbiB2ZXJz
aW9ucyoqICAgfCAqKlN1cHBvcnRlZCBLZXJuZWwgdmVyc2lvbnMqKiAgICAgICAgICAgICAgICB8
ICoqRmVhdHVyZXMqKiAgICAgICAgICAgICAgICAgICAgICB8DQo+ICt8IC0tLS0tLS0tLS0tLS0t
LS0tLS0tIHwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tIHwNCj4gK3wgdjEuMCAgICAgICAgICAgICAgICAgfCAgQnVzdGVyIDxicj4gQnVs
bHNleWUgICAgICAgICAgICAgICB8ICAgNC40LngtY2lwIDxicj4gNC4xOS54LWNpcCA8YnI+IDUu
MTAueC1jaXAgPGJyPiA2LjEueC1tYWlubGluZSAgfCBGbGFzaGFibGUgaW1hZ2UgPGJyPiBTZWN1
cml0eSBleHRlbnNpb25zIDxicj4gVGVzdGluZyBleHRlbnNpb25zIDxicj4gU1d1cGRhdGUgc3Vw
cG9ydCBmb3Igcm9vdCBwYXJ0aXRpb24gPGJyPiBTZWN1cmUgYm9vdCA8YnI+IEVuY3J5cHRpb24g
b2YgZGF0YSBwYXJ0aXRpb25zICB8DQo+ICt8IHYxLjEgICAgICAgICAgICAgICAgIHwgIEJ1c3Rl
ciA8YnI+IEJ1bGxzZXllIDxicj4gQm9va3dvcm0gfCA0LjQueC1jaXAgPGJyPiA0LjE5LngtY2lw
IDxicj4gNS4xMC54LWNpcCA8YnI+IDYuMS54LWNpcCB8IEZsYXNoYWJsZSBpbWFnZSA8YnI+IFNl
Y3VyaXR5IGV4dGVuc2lvbnMgPGJyPiBUZXN0aW5nIGV4dGVuc2lvbnMgPGJyPiBTV3VwZGF0ZSBz
dXBwb3J0IGZvciByb290IHBhcnRpdGlvbiA8YnI+IFNlY3VyZSBib290IDxicj4gRW5jcnlwdGlv
biBvZiBkYXRhIHBhcnRpdGlvbnMgIHwNCg0KVGhpcyBpcyBsaWtlIGEgbWluaSBjaGFuZ2Vsb2cs
IGluIGFkZGl0aW9uIHRvIHRoZSBmdWxsIGNoYW5nZWxvZyAoZ2l0DQpoaXN0b3J5KSBhbmQgdGhl
IHJlbGVhc2Ugc3VtbWFyaWVzLiBXaGF0IGlzIHRoZSBwdXJwb3NlIGlmIHRoaXMgdGFibGUsIHdo
byBpcyBleHBlY3RlZCB0byByZWFkIHRoYXQ/DQoNCkphbg0KDQotLQ0KU2llbWVucyBBRywgVGVj
aG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0K


