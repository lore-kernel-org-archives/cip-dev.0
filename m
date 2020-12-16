Return-Path: <SRS0=E8V9=FU=lists.cip-project.org=bounce+64572+5966+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67131C4361B
	for <cip-dev@archiver.kernel.org>; Wed, 16 Dec 2020 06:10:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6609C23343
	for <cip-dev@archiver.kernel.org>; Wed, 16 Dec 2020 06:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6609C23343
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5966+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YIoLYY4521723xEK5ok6syeD; Tue, 15 Dec 2020 22:10:16 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.133])
 by mx.groups.io with SMTP id smtpd.web08.3545.1608099015002488974
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Dec 2020 22:10:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9K3ZGLCSBSIZ6ZNy5YIxARm7tgzC6s+khFAFY+kTxIW2D17kpu75IaBotnr4Fv0OX0/Q8X0vXmi/7c0nTXA/GeV2dwzafNyY8LndrS764AHqU4S4xCtHGTuKb33ZLrXdx63KsROCWF2VNH0bh1esFfNBfQOkSZiEYvCvM+jvGDa1la8D9biAAm4vSRuLIFd051uDDNLN7a+74xhImmuJUpRdJceJByFlbewQ+ZkOJ50s2m9XNkrY9fRyobbghyUwDA4dwQIQV2bUwIvYksSWNitTdOxhUmMgUhGjbf6opnFieWpe+YGLHIzXqwg8CZdDzb7THsWYkjea+fqzqP2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/dMNMqaSMoYf7PPofdNHytBZaNNyMSl1EYuhFVTvFw=;
 b=IxAWwjm2GUINfulLNuq22OWnq3ZLPhWuqo1TFW5LJcv+iwnZ1/Hgwot7WVDCpi8CJzDWuNTNXy3U4UN7/63YdzKsV2kipXGbMHSG0UHL+wE6gq5CZTa8OwxKSQAzOG16BwhJsdLXdqa4VPKw80HuQaW+MW4gq5l/lm7xI0hcs7cZEUELPcQgML/s45zSXVNV8qq+6xxI2Cl3jvEokobqP8MWEAL+RsOGdeVH+YSD6WB9Uu3NH7s18QdISCvqWEHrM6xXA96Qfx0KtWi9Dw90nYYZhBfs5FkApM2Ot9f+iZCFrGG7/GqEWw8l4dtpiFFwOrBoY3xTonp+QUM2+VVKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5930.jpnprd01.prod.outlook.com (2603:1096:404:8055::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 06:10:12 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e%7]) with mapi id 15.20.3654.024; Wed, 16 Dec 2020
 06:10:12 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>, <cip-members@lists.cip-project.org>
Subject: [cip-dev] hitachi_omap defconfigs
Thread-Topic: hitachi_omap defconfigs
Thread-Index: AdbTcPgiOigQlKwYRJOXEiB+bUAieQ==
Date: Wed, 16 Dec 2020 06:10:12 +0000
Message-ID: 
 <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8dc138b2-99a8-46d5-a895-08d8a1893fbe
x-ms-traffictypediagnostic: TYAPR01MB5930:
x-microsoft-antispam-prvs: 
 <TYAPR01MB593027DE8B8262B251670920A0C50@TYAPR01MB5930.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 IOrHqFpEZBDRuaRryjLeHR3vtvfHs7amme30y8XkYp2xZj731fjRt/QosLXwR+FFHdMLyfX85PTltC9+nNRlQyBcQiAv0nPj0HI/pm5nX//xnt2cLkKaGNfoXoH1vg8w/FbJ2WLvpaAvFCsNdOxSGmvW066j0Gfm8d/aoVbpLsiFavu3r110GxrESWbEFCZAB6a8Lu9lwFmIvlUR+fxmtvA5EB9G3sXt0CEiIc61CdpMjGC9NxT1B6Z8688KgITA+ssbo4omoBn2XTrUo8DX41m2O/c4AZJv6qADQrkJf4XYT529+Yxy8Ye8deqay4u2QCpH/uoVZWIAoJBfShsK91TFxMDGmSd+jmPdVPHOJ5g/FeQvRF4U8mqPC2YwYWfyEWtcK0PU8pt88RCLnX0zDQ==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?L0E4U0pCU2RRcFFZOG5RZ1dETCswbzlRb0N2NzkzWXdqN0NqaHRGaEpx?=
 =?iso-2022-jp?B?cXFOUjZLSk1NYUp0UjRPQjFQaWF5Vy9qemJUUjVlVGd0QTJiMVZTREpN?=
 =?iso-2022-jp?B?WWw0eFlKT05lcEROemdZOWVvMktSNldPSkV0VVI1UHBUQ1c5dTg0UWdT?=
 =?iso-2022-jp?B?ZXFBd1N1anRQd2ltcUtpN2hwQmVQMWpOdEY5SVRmOHV2enY4aTJJUWhj?=
 =?iso-2022-jp?B?V1c5VGhuN2RIbE4ybGpzaTUxODBlODRBcTVpc1Vzd3VWUUpZalVOcnJU?=
 =?iso-2022-jp?B?eTVQNVVBOWIveHdlT0ZJT2hlK1dFTUhnTDY2TkZKSzYyRC9EMWhIVldx?=
 =?iso-2022-jp?B?TXlXZ0g4T0tFakZzaXVtRVkzdGFpSnpPbFhOR3JVNlBMU2MrYlNLV0s3?=
 =?iso-2022-jp?B?SGYwK1lXMHRkQWNOWG1wZTRNMUxnYmhIeGN3ZnhESEt3Vnc5cERWdmJr?=
 =?iso-2022-jp?B?WkFXS1FPZ1JEYUJaWThPb3BsSkhiRC9RcDdKdGMwR3NMODhONTk4Q0I1?=
 =?iso-2022-jp?B?OUZCU213WUsrRzNVR0doOWovcjRWdGFPa3FtZnBJckNRQXpvMUtHV0Iw?=
 =?iso-2022-jp?B?WnZ3RGkvQ3p6MHZtUTBSMkFYMllEb2VZVmwxZklmdmpKTnhqcVJEMDRz?=
 =?iso-2022-jp?B?N2dtMUJucUNsam9nam1rZVN2UmZDa01oMm9XRjJwUk5uV1poV1F1aEJk?=
 =?iso-2022-jp?B?MEVHVWxSREY2Qk5SaEtLR0loL00yK0k4RmhKYmNrOHRvd08xWjhRQlNH?=
 =?iso-2022-jp?B?QkROOXZ1YXNHODhXdUNOR2hub2JjbktwMlExNmozc2JPSEVhMlU0a1A4?=
 =?iso-2022-jp?B?UVlERVlhSmRBTzNMK1I2T1I2Z0todWJBQzJyWkxuN0dKV2ZmZ3pkL2Jv?=
 =?iso-2022-jp?B?K1hsTXMzQmt0eUF6TUR1VHo1N0RzUEl5eXRqTDNiUHltc01EZ0dNNHlm?=
 =?iso-2022-jp?B?WWlEa2g1MHh6NmM3K283RUF6Q1FYcDRYT3UyQ0ROaXhkWlJFRG96Wm4v?=
 =?iso-2022-jp?B?MnhKUXdlUWJvNmNuRWwwcElvUStVNFU3WTZ4ZlQvb0FvQ2c0emZWWWtt?=
 =?iso-2022-jp?B?QVA0ZXB2ejAxQkZNOUkyUjBIWU5YYnhMN0tnZU15RUlrNEZ0NXhocDRZ?=
 =?iso-2022-jp?B?YVZMeDJTcTVpckt6d1dPeC9NWHNwOC9RaUFEY2hjUnhKMmdnN1FlZWVa?=
 =?iso-2022-jp?B?VWpJN1V4blYxMG9jdE1RN0JUOUJVcC9oaHlFYlQwU05vbmZMUzB0NWF4?=
 =?iso-2022-jp?B?ekpKSTZIVVdPYWh2ZGVOTExpWlRuKzNnd2NwaTFQU0ZqeXBMRHJOVHQv?=
 =?iso-2022-jp?B?eGQ5UmtNS0MxbXVVb2FBTDBCZmp1UzFPZmgzK3VqNmE3N0FxSFY2TklP?=
 =?iso-2022-jp?B?NStacnRwdS9jczNTTHJnWmxRU2xVU1RhNUFSajBRWXlORHFFUT0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc138b2-99a8-46d5-a895-08d8a1893fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 06:10:12.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zmo3gfe5ItKUu/ZMwzmTWZldArWpo8zQExkfY/fgH8QK1JOO/6Vxy1V9ItqS7qQv45dIa+Li8ITvuKEX8zp2MJm6nNawQrQCOw0a35ed4c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5930
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BTurw2N6BMrDcSuiAoTYq1qPx4520388AA=
Content-Type: multipart/mixed; boundary="9Tx3j9QpHmYFYU01u59z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608099016;
 bh=0n8/pUCQOW4cCjfkkHF0waQwxvuArL/uAfD1ogWZFPA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=TZLjtAhGSf4+FVCvZE8YdFYUK1AgIUYu4zV1J/ls86S5YtqXaBp5+r9SrjsWq8uG/j2
 7EJYodDF+NKd5BbiBjZOmv0LDv3RhM93uRjzrYfFmqAYABLHmDtntqwKBqtsjafm0rRWd
 wDL4mjvra/0HJLOMyeaBvz0FjzgYTiSzbO4=

--9Tx3j9QpHmYFYU01u59z
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Hitachi-team,

Last week, CVE-2020-27820 [drm/nouveau UAF] was reported by the following e=
mail.
https://lore.kernel.org/cip-dev/CAGb2v641=3DSrfdDh9CS4fwWVrfuCG2O2oni9V_QsV=
JEza+g5mRg@mail.gmail.com/T/#u

According to the kernel team analysis, it seems that the nouveau driver is =
enabled in hitachi_omap defconfigs for both 4.4 and 4.19.
However, the configs are for OMAP platforms which, according to our underst=
anding, don't have PCI for a graphics card.
So we think that the hitachi_omap defconfigs should be corrected to disable=
 the nouveau driver.

We could be wrong, so please advise us. Once you confirm it to be corrected=
, we will go ahead to change it.=20
Best regards,
--
M. Kudo


--9Tx3j9QpHmYFYU01u59z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5966): https://lists.cip-project.org/g/cip-dev/message=
/5966
Mute This Topic: https://lists.cip-project.org/mt/78995356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9Tx3j9QpHmYFYU01u59z--
