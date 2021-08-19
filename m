Return-Path: <SRS0=TLuD=NK=lists.cip-project.org=bounce+64572+6701+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19545C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 13:22:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953466113D
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 13:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 953466113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FpK1YY4521723xsfsIxlZ1Ns; Thu, 19 Aug 2021 06:22:10 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.69734.1629379327337566744
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Aug 2021 06:22:09 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 17JDLuGp011736; Thu, 19 Aug 2021 22:21:56 +0900
X-Iguazu-Qid: 34ts0AfxhNSFRpJCK1
X-Iguazu-QSIG: v=2; s=0; t=1629379315; q=34ts0AfxhNSFRpJCK1; m=Q0kr49J5y9uUUZ8C5C32BVjAxs/Vc8iyC3Vf7cJPXsI=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 17JDLsc7026594
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Aug 2021 22:21:54 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id B9D62100132;
	Thu, 19 Aug 2021 22:21:54 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 17JDLsiK002450;
	Thu, 19 Aug 2021 22:21:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc0xyjtHyK8lQZ1eoCaS20Cbu/NTOec5xRvxaAAtPhd0iRoaUes9CdLibjp4h1L/wtDXjgLQb0poEnv+UkjRdDHolw/bvbRsAMP+CbK0WxSihmZUKpp7BFZAiVzq+23xjKmFHF5QpwVFDsvn1l7BUWPKemUAJTZKLo+a1rSyTVqT/WiHGuABJku8iyCz38JLIxenxES+Y7L8uovPk2cmV/PJGrq+EwM+7/ZK7DJd3rjop+HgJv4MtnhkDKGRb/YnpvvRKzc7F7bAv4hOCgZuiI3WUc2RN0fYeovVVoXABrayDre4OYPBIbX+4FI0RUXlrDuBSPaoOihslsIqTbp0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QwDDYXCwhE+II9sVbd7UPE1AhaKqkgTNeNCfq2K6bA=;
 b=ZrHZBdlXNhhvaxqY8zDv2ygzt+6FBnVXl9pZlRc8rM5Rn+YHe4rkDJAWHZfRPfOqAerXO/3HfelL27/h/NId5ohFjGCMJhoS+MFBvtGZy9r/uv69ZGnoNfodrn7LoOKa0mK8N2bxwn96q1BzS8rn568C4busBgkTR2lpFuidnfCGl4pji7t2sVuhKWzJvsrP44gjwIfpzdCBjSIdTrOuJSOtpUNjobPvaH7ADCt69dibe1629U2DRxZeMwYia8ovZbwipKSyoC9gLBVmET4G292dvbmQFirYq9G0/tcgNkgauAFjku2SXfDF/Yg7Ec5CMQUy8Ao7/9DJbBnc9cygcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.204-cip55 and v4.4.281-cip61
Thread-Topic: [ANNOUNCE] Release v4.19.204-cip55 and v4.4.281-cip61
Thread-Index: AdeUnd9mJdFaa5KgTKmLqq1Z6yeR7A==
Date: Thu, 19 Aug 2021 13:21:51 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62521141EFE40AA48A36824B92C09@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24ba9527-5bae-4134-b0dc-08d963144e58
x-ms-traffictypediagnostic: TY2PR01MB2777:
x-microsoft-antispam-prvs: <TY2PR01MB2777681426EFD1DB5D2C01C892C09@TY2PR01MB2777.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: tT12UPvFp3xM5EsVaP2XPyTHXGi3bQFY76U2EB3GkQtT0RKmnJQH4SFk2r50s/OZaG9MRCCYrc8mOO+6sqVQuixCUcHZC4AyeQ0Oj0gnxhBWZFRW+n91jN2PfvZU7xYisK9lpzX5Ad6dppWf5RMcwHxRoeoUeCGNcCP04IZT5h3o24kDLRN4md1TRarV2veiLcqdHaR7w3U9Ykq2CkacpvDfCQ4x2835Ec93W+IiIP3cU0T4UfFH3JuBzwKxzwd8n94anNblh/EPW/BJyQKiMI6IHQi+Oi/GoDufa1Qg7XiYWcMKt1ohhdUt1nQYG2oPbOzQhpGHSQDgQ6Q85ABjdZh5IHkU2kyxiOlXBc9TKfPnpMojkfAvpeWAq6n68Sj/eYMB5k5aYmqQHvpkxiWqBSloQgb25WCcKNW02oTUrrj44UFcmz7AcagEazamnbt4E8epmAorGt6SUiHTW1HNlic8MA5UER0ZvMeD6vso1GSCxDDDGcgVRH6szk8i5WvXvjb0+GUW0GsI/UulDbaR1xLboYU2rh8OSJZ0nCZLA2UuF75LxfWYrziQa2tOn2YkaXroI0cMWbCTUCyAPzGGlyELDxRax8ayUeKqZbUfW9NPX5fSwPdcB4+rqJiLqCI8ZGBysoSlMpzFd6q5wJClAl8PIDqtUo/+ywHABHWRA4zX9s+QF7LbfLeeiWxNPWttQ0X8d3E+8hSATwEzYF9T09SYM6FvzrHSXBfrRCMuSArrY4zGU/5zP8g9VqEt1xfWS3o16uRMiqSABS+tKruRFH01Z25UsakpRQK92A1naaU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWp5TUltZFUrT3p0bHJib3lLNUNYdnVuL3ZTWkR4WGVndFFSMDUySlNFdDZr?=
 =?utf-8?B?bSs0ZzNFd0pLb1pET05VU3JUbGprT3p5OCtRZ0VrbXlaSVZZTzBnZU1FRjMx?=
 =?utf-8?B?R2lpYm9zbDhzemZJTjl3ZG5aNEprWFA2NXNQQ2NuWjJERHNmR09jM2J4YVlK?=
 =?utf-8?B?djJIb1Fyc2wwRkIxWStoNC9wVkI3VU4yTVM5ZjJUME5pdkFkcG1HdnZ1NXBt?=
 =?utf-8?B?RTRrRG16MU5EZTJJUkZOVUgvaUpzcHNsN3ZJS0R1cEw3K0ErdHVQSS9UT2Vx?=
 =?utf-8?B?N3FKM0lCcHRlRmtoclliRkVqSDlEa283OXUxdWV4SjFPU3c4K3RjQnVCOVFy?=
 =?utf-8?B?NVkxc2ZKdFBZR09OZkNwQUpTRmpBOTVRckxyRS9sdGYxajBhcHFxL0tQT09D?=
 =?utf-8?B?eWxJbUtIN0QzUzk5Uk11MVZwa01YeDl5b1BhZTBlV0srM0V4VUVWTGRzUjU5?=
 =?utf-8?B?cHFjRlNIOVlxczRvRDBaalJ2U3Zaa2VvR0ZFMmVLRm9YK1hGZnFyNWQrajlL?=
 =?utf-8?B?ZDVJTURtS3g0K2Q0RkRhTEloSXlRL2crZ0RuYVlGWmlZOGU4Y0ExckM2RkNP?=
 =?utf-8?B?dkpiaXJkRWhyQU5UdjFPc3RoU09JTk0wYTYxeERrMVM0MDUwNzNjZ0tUVmIz?=
 =?utf-8?B?MWhuMXR5R2VZT3RKbXVwcmtacytNM0dvRDZablo1QTZ2dWx5SXJDR0hFWk5C?=
 =?utf-8?B?TzIwMkpHRHJqVnYzQ1U4c0orMDdzd2JDRUlxdTBFMnNiMG9wRTB6WGpKWXph?=
 =?utf-8?B?MTJxY3ZCRzlhcnNUM2hTRUdCYUNMRGhBVFZ6SHRZUG0zQzVqVTFQYW53eFY1?=
 =?utf-8?B?eHhORWExV0p5NEdtQ1VXbDhrb3UxZkJFdElQeFJXOTNldlFoYVNGUy9aM3Ur?=
 =?utf-8?B?WFdyYlFQZXBkYm9qYXVEY0Y3N2lXdXJTNHEzTklqWmJ6R2FJWnJrUUo5eURC?=
 =?utf-8?B?V1JCa2N3cklDTFIzQy9aWXdJa1BBNjA4eXhOSUwwMVBCZHl6RnQwdjZ5YXky?=
 =?utf-8?B?TTlKemlVWXVpUCs0N1MvTHNhNWJrblZQYVh1WS9UTkFCdVkrR0IyZzNvQUlG?=
 =?utf-8?B?UnMxaGRvbmpPUExMN25JTm10RXFCUGlYWU5UMng3Z21kalZVUkNyTkEyazlm?=
 =?utf-8?B?SXphekplMmhiV2U2UUs0dlFnNEJnQnFGZzZocVBoSzRKVjNWaXhZRStNcnln?=
 =?utf-8?B?a2U1RTcvRDkzWUk2Y1IrUjNEdURtUDNyZlVoaU1WZWtSZ3AvSXdyOUtuM2RO?=
 =?utf-8?B?Yy9lUXRkb0JYc3dodElMaUlJNENZQ1RrUk4reXlSUDVCd0paTUtzeTV1ODkx?=
 =?utf-8?B?bm1WbmRZNllYd1F0eDJMK04wT0hBNUNFNUdjR1BKMTE2V0xaMDdTVkFCRit1?=
 =?utf-8?B?TlQ4dXBkR0NNem1kUy9zQ2dZT2p1SEFnWjltNCtoUldWN3pjVE1LaGpkK29n?=
 =?utf-8?B?VVg1aUQvR0RrSDdHKzNWalJDSFBoZEMwUWlrakZXTm5DRlZGaERmK29wdXV5?=
 =?utf-8?B?ZFN5MFNYc2Nub0c4bnUvK3F2d2xrYkdiM3JRZEZnWkxDU1c5T0ptNUorSUdM?=
 =?utf-8?B?TlNDUDRXSlZWYStKdkhQTS9xdHhaRVZnOUJvNEprTWNhWHJxZS9US1FWM1Yr?=
 =?utf-8?B?bFNiQ0EvbjJ0Rm1SdjdORklnWVgxS0JnSGVtbE9rUG1SeGtJLzc5VCtZUndt?=
 =?utf-8?B?RTlFdTg3dHI0R2FrVmNtLzR4eE1LanJSQWNvOUhjdzAweldNNmJIMmIxTnRz?=
 =?utf-8?Q?GKNKkDubSqXCdNyUwCsmxTfg6CuXXeWCswYS7Jw?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ba9527-5bae-4134-b0dc-08d963144e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 13:21:51.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hcsb/rqf+YJ4OZpviC9kzovyHWZkqg5eMF3jBSFn1jh6SZ/Mwg+S2qd/p7yeDBAGdSmsIOq8ah7KwSWimlejjVmuuhVF/CVPZ91pp/yHFYHICn0rLs6yoIceW1YgBsEh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2777
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
X-Gm-Message-State: xXdZY2lkjkrVGCYOLUMIsL2Bx4520388AA=
Content-Type: multipart/mixed; boundary="vzqfLMeQyjvXpRPgop2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629379330;
 bh=5h3xQhuJypuUtwp1SYOtshu9VdC1o2tXxX38P7qG27g=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=a4T1vvYvPpBXg+sPEBWYNGkc29sibpU8/6eH3wtc1Hq+vK22QAWwqOf7e61sdPN1YxY
 xt7GpPXKFANJHsj8GEWUAu4Fg8xFFhsA+LCpsQ+tj2fRgi8dUOL7KZEX5tmAk+JgrjAaF
 4wyHFoUFLo8b62PXO97IX96Wf8TvJiGhhs4=

--vzqfLMeQyjvXpRPgop2J
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClNvcnJ5LCByZWxlYXNlIHdhcyBkZWxheWVkIGR1ZSB0byBhIExBVkEgaXNzdWUuDQoN
CkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjIwNC1jaXA1
NSBhbmQgdjQuNC4yODEtY2lwNjEuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhhcyBiZWVu
IHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTk4DQp0byB2NC4xOS4yMDQsIGFuZCB0
aGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNpb24gZnJv
bQ0KdjQuNC4yNzcgdG8gdjQuNC4yODEuDQoNCllvdSBjYW4gZ2V0IHRoaXMgcmVsZWFzZSB2aWEg
dGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjIwNC1jaXA1NToNCiAgICByZXBvc2l0b3J5Og0K
ICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lw
L2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00LjE5LnktY2lwDQogICAg
Y29tbWl0IGhhc2g6DQogICAgICA2MjA4OTg3OWE0NTQ3YmUzNWYwYzIzZDg5OTJjNTFhYjU4OThl
MDc2DQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9uIHN1ZmZpeCB0
byAtY2lwNTUgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KICB2NC40LjI4MS1jaXA2MToNCiAg
ICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00
LjQueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIDRlZmFlZWEyMWE3Njk5YzA0ZmRkYzMz
ODFjZDg2YzZlMzc2NzZkMjANCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZl
cnNpb24gc3VmZml4IHRvIC1jaXA2MSBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpCZXN0IHJl
Z2FyZHMsDQogICBOb2J1aGlybw0KDQotLSANCk5vYnVoaXJvIEl3YW1hdHN1DQo=


--vzqfLMeQyjvXpRPgop2J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6701): https://lists.cip-project.org/g/cip-dev/message/=
6701
Mute This Topic: https://lists.cip-project.org/mt/84996458/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vzqfLMeQyjvXpRPgop2J--
