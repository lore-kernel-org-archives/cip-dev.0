Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABCCC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 22:43:02 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.87])
 by mx.groups.io with SMTP id smtpd.web11.4358.1707345773639190963
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 14:42:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=cWU8BjpW;
 spf=pass (domain: renesas.com, ip: 40.107.113.87, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhvDFDU1gY4l3pKTcfE6F4+ORwLpCaUzjC8aPgd9evBbl9vWjKaE47wXJm1heGL+jTdsU4etXlIKcUKwSBeFPimR5r9zxsilXUCMdh0g4N9LGGWJfVBe9xfaKzJBX6u+Qr9ZobWxPi/rPlzAfdl222dJ5NTqWxfUv7HbC+HqctIhKQaRhkkjdRcsK66XKY7A0EN57vjwnlKRBS/3ItSz7M3rLlvosZsCJ0QMDCTRAZMgdX8OYBXULJYc1gzLJcCmKF9WHrcO1BCl4k9vcJgRlcd+MhwmjMKsUlRGdDGHChv0TtPFPhQOtlpL8W7jeApL6qDAG7OCcPaf9TAyP7SDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kZ93Jgnr0tka+xV7glZqiNQ1J/8OaA6uyU/Zz1A+JU=;
 b=hVK5eAVeuEUV6NarAgD3B1iejATNUciwWR/93/BKBf1x0V0cqr3qnuvWpzNVt4XXKd97kjS9xv33SShp/YtYJeSqBBbKuuWz/ADoD4T0Xf41nUorAXS6yDmbrRQnyg4mnH79XW60wxjJvDmdiDW/hmRX6YnQ7ZHbc1+C8g3OI4//HKIWEFD4xYVd/OPMRRXMK8wriyj09P5tsJqnLS6xk/H7ifHyuS9XSxIT5LP28uaLVQacPA9QQLgYG0kAGjysrAI9HFP6tiDzvmV38meGVci/nXgnKkIVaLNgZafaZbwaF2eh72QNjajLXq3wUUR9rsmnonRGrI6sH4RWUbqUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kZ93Jgnr0tka+xV7glZqiNQ1J/8OaA6uyU/Zz1A+JU=;
 b=cWU8BjpWHBTt/T/qaremkLMKLzLRQ8Wyh6LMxhdL8ZE8j4e4g7Y4WBfdy0qo7wW/LVJl+VNutllb7ivEEt5J+/2FT8KTiMSdxhnQYXL4goQIRCi9B0SB4nqjIV1BPQQMSHXRA8c6QFw9yxmmWsDAPrpoEENfSHV9PlNtMT0YvcE=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS3PR01MB6117.jpnprd01.prod.outlook.com (2603:1096:604:d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Wed, 7 Feb
 2024 22:42:48 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7249.039; Wed, 7 Feb 2024
 22:42:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [ANNOUNCE] 6.1.75-cip14-rt8 (rt23)
Thread-Topic: [ANNOUNCE] 6.1.75-cip14-rt8 (rt23)
Thread-Index: AQHaV2GxNl29CcVeuE+8OcRDkbGx9LD/flVw
Date: Wed, 7 Feb 2024 22:42:48 +0000
Message-ID: 
 <TYWPR01MB118625C9FE455349759A8E4AAB7452@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <Zb98QfDdB5RfqD2Y@duo.ucw.cz>
In-Reply-To: <Zb98QfDdB5RfqD2Y@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS3PR01MB6117:EE_
x-ms-office365-filtering-correlation-id: c96d9e8c-7dec-4701-82c6-08dc282e1c3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 R0ndw/qLwuUQyCM0xlizKeF2E9PtFEE6tpPd3X10jgqUyOr8545ur/g1Q6lkowpHIpv6K7+dj7SOjcE8Erx/g6dzd/BO53S6RvzNtqIvvMoqRrYBHMc3Tg2gI3f/3zzUhRSgLEtNv7kW2WLhMvuUcFhg/BOY2nbNaL9n1LcT/vg9T82vgvBPTXVcmpH1k+LTAXdOPJUoNQKEhiGmnVQXTc6JiWWTeohO8t7JnRxvg4NBmLz8eKFLOoPIxhbFmw8QzObHZvpJ6ILQPNDfPWG3YEl/8d4e37TfaMIouiUOrokCxbCqFsRzKE07pus2gHUXBgdopqJIE2oAUAdetDj7tmmBxeaRaE79o8sYnJQCxHSDX7c0KOFRSHtdByiwHGetbkVit4fNLUqWQtOYO231Ek3zDgJ5mOpT7sne4yQABWZF85SNozjLVyoRJXDvKuMyvCfDn3mzzmZIwWZmffTkryvcqXkeTIYeM2Z+B+6Mz8RZZtKtIAbx8JgBBPIQmPUPBiAJrozT4DBkAHEN2JY7zkLWJyGbpn/k7i0X2QonaidxL80tjjlAVQy6tDqrNTVFDxIzQkLfNxzyaoM0N1i1iIzAX2pPuB5j9HcLF1KO3ms=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(2906002)(5660300002)(52536014)(84970400001)(41300700001)(38100700002)(26005)(122000001)(86362001)(9686003)(33656002)(110136005)(6506007)(7696005)(8936002)(478600001)(64756008)(71200400001)(8676002)(66446008)(66946007)(76116006)(66476007)(316002)(66556008)(966005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?pr5LC8ygudndLGVCXEGNU5GQ5CZtlr+BwFDlGa74q5EZTFKZfnamazXn?=
 =?Windows-1252?Q?uT7cxNaiTeGL4Zdh4kPV9gj5e5lizwedMZHMOvpf9Rh3KimlhRt8wIZV?=
 =?Windows-1252?Q?LeKnTPk3d1xHYF6peGGUZQvw/4kevHoZc/+pJz2eB1wO6N1zDYKULEry?=
 =?Windows-1252?Q?mE8sL8qHhUUg27jVxiBDgE3Ch1jm0ep//2LdAp11pZtUsWebEo4N0AMN?=
 =?Windows-1252?Q?JbCICo/AAl77DVkS4XO3ydcrYjWnuoycDcySptpyAdsEbzcaQ7cp3s3L?=
 =?Windows-1252?Q?YM/qqBPJKPq0c6KniR1Cyaomega852lx3De3HpTqgyqySGfATsfwGn3W?=
 =?Windows-1252?Q?rmeAAltAOBJ6WMlDbh/NJpeS+EXtk8O19xap9YShpbxZ8LP/jRvaalL4?=
 =?Windows-1252?Q?pW0elk/uwcsxXfWGJMADbIm4/TyntnFgVPkTfnOXdCqrcqeVd0EWNNnq?=
 =?Windows-1252?Q?WZQzNYGAZmeiPyQ9X1QA3VlievMgpFvGKJux9NK/zsFI5QTN4/T94dxm?=
 =?Windows-1252?Q?zSgaNMOGBCVYM/cC39c+49FmEjU3nHkM8itZKpCW0iuCorJOVnMPHzyS?=
 =?Windows-1252?Q?RKyusZlrrUz16eR+UAhyLsy/mCMJGf2W8BO0B89WIUSR56b0o3wnfNSy?=
 =?Windows-1252?Q?etYwrmbCO1ACbITaj7/eUi1pa9V/RBhL+wn2vVkP3cAqLRMOe2k5U2jv?=
 =?Windows-1252?Q?tdxmuK6r7BR8DKCkXZbABUoXGXf9lYfXMC3KgWCv313G0WJc8b7aav8N?=
 =?Windows-1252?Q?V6K732FY/lj5B1wE8pfEeGajz3bQ8FU9F6NtumgwoMQChr4AuTiOmVyc?=
 =?Windows-1252?Q?OJK0PIi5p0Yol4+wsvY+P7c7KFNWFazHCxbwII1SPsOLZ4jLoMyGUrGs?=
 =?Windows-1252?Q?1XJ/PcgjZ2906HVNhlGBvOGv1LFr+/ALknu5Q2kcmf/4Y+P0HwE12EO5?=
 =?Windows-1252?Q?zcAuoIGhS7yyYVQae/B5NGvoQyJN1wcZ6w1JaYN5ENjVYPvAnplcDrqk?=
 =?Windows-1252?Q?b45QjH8U1rYGRYjEY0YxTe98GpdK3c8VTIyLu8adUIXynV6aSg8xkaEX?=
 =?Windows-1252?Q?E1amfzoaPXapukK8u+ss3nPFOxK+Yud+MZD1XQbR/rUlSYmE/gxDvOUh?=
 =?Windows-1252?Q?kNH3nGZ1xtGzBOsIHGrp4nIKSBLDjJPpB52blm7/EUoJRSOBiuD2ItYI?=
 =?Windows-1252?Q?WM9BqCo7uHKB510t3EpI52KK1+HXVDq6rjl1xgYeORHKxrmeuJxKcMlJ?=
 =?Windows-1252?Q?TdroL0BPLI5KHJaRa/xdL97guqnnVRP5mYYbAZKTx9yuIV04YTrGqAPa?=
 =?Windows-1252?Q?mWljsRer50+ueVDzibL7It7MPdg00hz5VWc+ViyQXkyqtCGTOsEhamy6?=
 =?Windows-1252?Q?f0f6G3+COYLfEBrcc+VRx3gZhgpmpOD+XuAfi5bMvjDy7my75+4AXUR2?=
 =?Windows-1252?Q?q0JXt9UpnULyygrQ5YNDIh30Ph6EJ4s3ALLbh9cNZRIVUWwfc8OBdFQ1?=
 =?Windows-1252?Q?i+lF+e93fVz6nG80Ai0i6JCukmZ1ALf1AFCQx/wv0CarPmdN3DJN87kw?=
 =?Windows-1252?Q?0aH9FOWz1I8flMuGMFFeFR2ppAn68zT4EC0fZ87z9G366zjtdPcMSe1W?=
 =?Windows-1252?Q?5BsAeS9FnbjZVgxbjbkyR98jf4+2RFmre3Kiv9Jv6jOFGytKaHRXnESl?=
 =?Windows-1252?Q?KeKz81y05/xP4YSt0LRa21xmywe+43OjYiABoHrqjD78BPp0W3IRSg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96d9e8c-7dec-4701-82c6-08dc282e1c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 22:42:48.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uyNbT4r+glG6aSgS8bIG9BIa4DM3bNWfxW/KJd+/WVwMviy7iyXHek4S8K7VHKNyF/1HsnTVTBlrbVw44bMiqnFZUzZ7QPPG7NsuA0/dPCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6117
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 22:43:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14912

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: Sunday, February 4, 2024 12:00 PM
>=20
> Hi!
>=20
> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-6.1.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/?h=3Dlinux-6.1.y-cip-rt-rebase

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip-rt/buil=
d/6.1.75-cip14-rt8_6e54756fb/
- Results comparison with previous release: https://squad.ciplatform.org/_/=
comparebuilds/?project=3Dlinux-cip/linux-6.1.y-cip-rt&baseline=3D6.1.67-cip=
12-rt7_38253b890&target=3D6.1.75-cip14-rt8_6e54756fb&comparison_type=3Dtest
- Summary: No new regressions

Kind regards, Chris

>=20
> And their content should be identical.
>=20
> There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
> Best regards,
>                                                                 Pavel
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

