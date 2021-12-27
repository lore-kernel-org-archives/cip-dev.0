Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4487BC433F5
	for <webhook@archiver.kernel.org>; Mon, 27 Dec 2021 13:45:15 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.93])
 by mx.groups.io with SMTP id smtpd.web10.26229.1640612710605087791
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Dec 2021 05:45:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=OHGkOmaK;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.93,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3y9NtqPUVBXUkU5uE6AEjiDxDsm7pc0l3yzUpOT3ll9XlOevPJKJOxDci8R+TpfdDYrQ0oDttc1Qh4JHmWrjIzCuJzAcbH/1j0Ki8LY/F426qbX8F6NuNWsbnND/MCjKzSa/ed5NlEO+BmU0nS0Ovh9vvUjJ+ef7jpuKkKBMyuNsjo2Vnglo/Tu1dB/b2MZ8wS5GSjCzIxZj70Wm3ID+UsICqXaauSikdURlMqx3U4ltykAkeY0kZmHIVtHLzLOcVEFbJIjOEOMVje45du2Xbd7hajM0JaRweJSHBYauHNpYEAi6CjCPpEd2CpY8aUXAre7sbpTh/Y2v32fJHo6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LB4giWcKdDa7SLLKMFoaCOOsXTFHFxTde158kSsSaD4=;
 b=jiAlKPqwXOGhscfYNSkTGBV9tWBKo6XlezwUqr9rD5t6T2+/tjGM+BYSGTmNSeJG8KQdHLJbgkuBPgv1mwkVeUnq3/CSQYQfOTnBai1pFujUAHnyyRlU8GgPO7AkQqXgyxxnYHpAgqqTXJ2ec3zHReVjLbsLvEtUn6bie4YarF6yx04bS+KPDEl2bJxS2yAK+9zt/0cILeZ5KMGkpnqx5B2fGLVbP26QB0Sz7s01jEjKgapEhpe+sTKRj/ANNbHTHeQTSdnGGRol3ivXC56BPr3ab330Se5xYRH+4S0rBdWNoNMInVFSpG1yXnyqyVVFaevmLPJS8GkYi+rWXZ1+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB4giWcKdDa7SLLKMFoaCOOsXTFHFxTde158kSsSaD4=;
 b=OHGkOmaKSFCZLvbHNZrLw+gothRyZdlWmG98wbT3c3cNthL2ITe59OUk8jYxJmrUYk2w67i9fCDKhqUx382DloY/b/RNIfYtBtbQ7rqG0RQH3gfvCREQe+i0dMnjUgKisDed1XDHKAUdPe5I8TAojsEOjGLg8varCX32qWJBN9k=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB3763.jpnprd01.prod.outlook.com (2603:1096:604:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 13:45:06 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%6]) with mapi id 15.20.4823.023; Mon, 27 Dec 2021
 13:45:06 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support
 for RZ/G2L family
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add support
 for RZ/G2L family
Thread-Index: AQHX94mUzk7tRvWCQUa44NcIyYtON6w/KcwAgAXMtv+AAWoLsA==
Date: Mon, 27 Dec 2021 13:45:06 +0000
Message-ID: 
 <OSZPR01MB7019F973C7483B12821C2442AA429@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222134951.19432-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211222231343.GA25345@amd>
 <OSZPR01MB7019D83A9F1DFC14AD31114EAA7D9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <16C376847BE1186B.4760@lists.cip-project.org>
 <20211226160809.GA13169@duo.ucw.cz>
In-Reply-To: <20211226160809.GA13169@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07993b24-9e9e-4a3e-9880-08d9c93f175a
x-ms-traffictypediagnostic: OSAPR01MB3763:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB3763B9300234EB406FC694ECAA429@OSAPR01MB3763.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 k8B/XwI7tpSwcbmfQvSPwTyK4ajrKpFs0nRC6+Ls5OMt2ntYJlaJE29mLj4vitv2R8WuwfHlu/0KtHqStUX4ujwvjsfQ0Lkg7g4TZ7telijWbWcP7XENIdzjKLXY+I5761HCU0Py5n4CEwhTC7fhG5vfqgbal/t/e7d6wcHb4PiYkt9UtMeppseKp3Y+dluKNlc9bJOr3b3cKie1LdxaWjfWTNO7SZ2d4Kss+9oml77GoksWDgme7ejDKuK/JRo8LBoQTwqXh+x+4dhCNOQky3nbff9C6GgOXfJJoyYdXyBMqxqKAQ4HYRGVutE2l6gq36OwosasOzik3tjUpZnRC7Mv46s4Wg+XzQeTWmHiJfFhRtv5ZrSSM+tWeeMxvUwLTSvtRHiBjTPjyXC9phFqJuxwz4+XTmhnsv0urSFejqKIvaLVRRleYl5z+tAj4cJG76jySZsdqnMdMDTHcH1cXqmZVuvLYffyGm9vdk1k3gO9n8++ZWEvmbq7/Jq2BXe+Vg0SwbfHEIIusKnijzT9MsTjU8NTV12Ol/+CgPuMVB2OZBAuzhzMzOC710ys7nQ4LAN7R8Dz3ON3IVmchrR1doV1Ju9j5BScIcyseibTLwgURQY1EL56AZtFEh1UdIKs1dva9HERZqVzofxVkd8TIWHtwR25s5kiSb99z8COKLpkjqnwBw4Q7CsmktfBwad2tY1pYzmodrnPPQDde60NPw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(55016003)(38070700005)(8936002)(6506007)(2906002)(53546011)(9686003)(4326008)(52536014)(5660300002)(26005)(54906003)(4744005)(7696005)(83380400001)(122000001)(33656002)(71200400001)(66946007)(508600001)(76116006)(8676002)(38100700002)(66446008)(186003)(316002)(64756008)(66476007)(110136005)(66556008)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aQztvgdBZU3HOOUzFNkGkruH289Pf7aVnpMTdyegMMX/fWSZUdUiy8Oa29Ie?=
 =?us-ascii?Q?jWK7UPzeW20E2tfvKUKs5IFXlRNeURA9rzdclMSTd90jGyTaxnMOCI4PcUv2?=
 =?us-ascii?Q?FXSdgVS5U9rvB7sqQmy/0jrLT/S0+TKo0qUWXhQbyja9HKb1iqr2Dz2Mj6LK?=
 =?us-ascii?Q?/gCe2pK9sV1H5MslfRwhS+FAFealyX5f+opjeYAOpd4u+3ZGGwxLeWbFEdf8?=
 =?us-ascii?Q?wcatrOOjsbfmiXa53zFQhSv1uU/+drWZBFN672h14eIS09w7D2KVCPr5NLab?=
 =?us-ascii?Q?yt9LYzjVOPWJA3xJi6BJ7cFEoz2/EfCRLvjSxrC0M+ED0GMyspb33cmVnabv?=
 =?us-ascii?Q?hY595ewhzP2P1Wmz1zulwoBCQQ8jmKE2Gta/w8ghTOqQklTv58JJVvePU1/5?=
 =?us-ascii?Q?g9wQGwIdu6Na2lrPwWnSjjisu2peKvRdS6iBjKrP9Y2IQjimLGxHLMirRMhr?=
 =?us-ascii?Q?iYTQ02YyiwAWVB3Q8eSUq+5XxqE2/DWmKu8fG8Fk52D4UQeCNBzYxpL/Vogk?=
 =?us-ascii?Q?iPlYCQycxCh3P43uhlIuq67+IWpbTYVkaGEBdgrH4vi8Zfi1V18FUOFUdB0F?=
 =?us-ascii?Q?xEJ85zdBwnxDz0bN4VFSJtklbPgPcHEGuE7/dj1aUDNxDiryGu7WDtFBh1cp?=
 =?us-ascii?Q?Aomvrze3c6/C2aUnNT1XtcFYQtemsKVVWsp/Hln3VRTUVZBTnsdIcFbhwEKI?=
 =?us-ascii?Q?B3uS/qTlkSqGBkGZ8OI4AMP9slQVQWaocYexsC3buInMQxCLZGaKcVkuK58k?=
 =?us-ascii?Q?0DV5b2/ff7+wOvpgBhdMh7zQFlG+eCxdEenhPKwYa4+7EI+/FxC37VkgsBrL?=
 =?us-ascii?Q?eurNNnzyqMX6z4B1DF+1tMEgM3UsIaiF2v/NjoOHVbfyaeau2b3Gk2wH7+ky?=
 =?us-ascii?Q?hlwe6kv3lRPwhIrOe9JCucJd4oNjHqqaPgUd4WJtFZPOWjgaSoZxyqxV/u9O?=
 =?us-ascii?Q?mDa1xXeNugY15ue5H4The0shnqS+47CTe4TFMtfX3d2M7q52G/oXAnF06qfi?=
 =?us-ascii?Q?ENkwkvUuNV348uLUigenKX6khUSUbaIxpluwM0p0Qlj0pB+1ynhNVNZu/ZyY?=
 =?us-ascii?Q?yaOl8OK1O+5+D3QVuGNXjmA/mfNqQLWzrIF9Sh9rlfEAlF5GWMMZ7px+MATk?=
 =?us-ascii?Q?U+ShqRqX0EN9GisuNPR5JwLi/+KHwVItr6OinVJrAUk1bbmOuAE9YWzb1OdV?=
 =?us-ascii?Q?MqXRd99GmLEf/dLnzLocdqdAZvP/3/pHTFL02e1Goq5ckAJUGdCvDU1pX3Qm?=
 =?us-ascii?Q?S9v1TZHpBqEnA7GPw4S67IIZt7lKHZXAEty3qkhe3+D1If3+oVy4PR2zWf7/?=
 =?us-ascii?Q?ue4JWCYsX2IQeYtPRJgN5AlCcgntcZ0erRFoX6phyAv7udqbFqUv2JZiYKR6?=
 =?us-ascii?Q?Ks72Uy+OX8jjjihIivnWtAmCvKjc5IJPtKDFOupbKL07LlGw8PYsPQNRCK5f?=
 =?us-ascii?Q?VHWa76iHNaowQ+xwGL6QlvRU3rGXCJxlpGoVEochc5D9qmP2LWSGp+zXbhIN?=
 =?us-ascii?Q?NuCcuixiX5l6mE9wVkDktWpe72FrOD51N/18QAPOL2c3qmS2ajr6Jhss/bot?=
 =?us-ascii?Q?fXnY6SVc27OlbOruMgvUlDEas2fNidsPk+KJSyWVLsyjmUseNO3rtcfQMsVx?=
 =?us-ascii?Q?uN4YgvEw+U7wv1Nyi8WIKXDPa3+CGHU46w56rxSNG7gD2tQkRceMZGw8Nhkw?=
 =?us-ascii?Q?nDSIzIpEXhqJDs2kf4tpjDzSP0ZlcPk5Mqcs55AwlS6j6dytQ+4Xzk+VDAIx?=
 =?us-ascii?Q?FxwdDJeuKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 07993b24-9e9e-4a3e-9880-08d9c93f175a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 13:45:06.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 9Ih1DH3JVgsZ/8tn5sFEw+S9Gs3f4/EKXrhIRw1uAUoSAh7CZw8f31yXpX8rN2l1QPD4RRlLUy+htlErVdtavUSrr6l+mUyHOPtBTOSpXD7Tb6FYOIkDOYvvkyYQDk1H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3763
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Dec 2021 13:45:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7275

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 26 December 2021 16:08
> To: cip-dev@lists.cip-project.org
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Pave=
l Machek <pavel@denx.de>;
> Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.=
jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 15/21] can: rcar_canfd: Add supp=
ort for RZ/G2L family
>=20
> Hi!
>=20
> > > Agreed, this needs a fix.
> >
> > Yes. OTOH this is just a problem in error paths. Other patches look
> > good, so this should probably be fixed in the mainline.
> >
> > I can apply the series if there are no other comments.
>=20
> I applied/pushed the series.
>=20
Thank you, I will backport the fix as soon as its available in -rc.

Cheers,
Prabhakar

