Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72442EB64DD
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 16:26:07 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.99])
 by mx.groups.io with SMTP id smtpd.web10.22025.1688574363054288530
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 09:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ieC0fA/S;
 spf=pass (domain: renesas.com, ip: 40.107.114.99, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/68/XM+S4G3i/oFPLyrOpmbGsEJ/idnEFUyIUf77h/rywKFb5ITZW2e9/sPcBfx5bMEeOeFgk9HxJ7igzrNt95KHOcXa/BDjL+JWzQHfYLunyaZXsT8QPdRJfLD6eVoSKNtLS8ule7X9zhMf18QUVS3J+unNfki+xe5vkXGXUdjEMo64sAJMP47MgJGKl5gUmRmp5G01OoBZH6tBZRIsr4rOmOUzoqTUfl04m9B5njdSdAFF2Slk2pP4Png46uNXM4yjoiynh0B2qT2ZhAROcpjmmjPcraapbjBGNVaY8iOUYEnX2xr/RhjqCuOh+5/5Kn9mFcnibQ9PA8YHpvU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGRAV5bv5sEVYuRQD6e2xi2bIlexYR8BXbuvxKHTtco=;
 b=BcKvWNDlxclgcUOquS0upnmMlow8xDyrJSFFjtIk0VILMQFrSWmz0UzX31Ym5SbQRJyezsiXB0CleI/XyuQ9/uwhqAf0grcTk97xTYvG0TD7iQS5wG0ejUrvF/bGF2I+P69W6TVy//oooHTY5IrMqPCvmVXeQIfuwJiIjNPmaTkXC5IF58qQJIP4aKkQZAkPG4+tA3Shaj1n33NMpKpJ6l38IiEZyKyUGdYUYMZ0nDhDWO3cF5Suht7Yk9nh5+4Bc1/wFL7FB1EgRuS8Ss9ZrBei/BB6BKw69CBm+4Nxuss2kkjI0Qn+9zyna9GFdFlV7X89ARQNU2700dsh/2eWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGRAV5bv5sEVYuRQD6e2xi2bIlexYR8BXbuvxKHTtco=;
 b=ieC0fA/SPAqj6tDACqXjx/v0sFOyW6lKJeirks31bUsqTmkY82nvV+YiRh+Gmf/dhxfSWG+6xzWsqvZRNBdN8ur6WrouUksY7RZ90em9t7AfDuqacI66NE6qM05s+4zrSmV4QF4/9P3xRMCyAZz8isJa9p2/C9lNgrgXifjFglk=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB8171.jpnprd01.prod.outlook.com (2603:1096:604:1a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18; Wed, 5 Jul
 2023 16:25:58 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 16:25:58 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
Thread-Topic: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
Thread-Index: AQHZrrV2VJYA8yGF4k6g2pbxA2VRKa+rBvKA
Date: Wed, 5 Jul 2023 16:25:58 +0000
Message-ID: 
 <TYWPR01MB877577E322B7F4A166F605A0C22FA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
 <ZKR/3wD7Lf4WVMQ7@duo.ucw.cz>
In-Reply-To: <ZKR/3wD7Lf4WVMQ7@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB8171:EE_
x-ms-office365-filtering-correlation-id: 6580486b-e255-4049-847e-08db7d7483e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bhmFFt5gEMwoHge+iAxbSvf0JTJdhYxP4d5k+njQNfbsYn1UISLvSC3B52TjHZ2nK5slKgoF9D9e/e0LXTRspDPI9/UN0hHkA0j7uPo3AcQjfR4pgyAN/nZoh0yKTy7C1ZZ1gLRlz/i40ax3oRM4Tcce6E+Dsya2e39+EjgX6pfhNyutiAA2lHmi8Umd+l3dM/4fplaYNcoGmzEAsjRIw/VpdTgZlMTZ6MANh+s53pvQuQIry/oZ++peoai3fLBPCZVkFoAo7VrTn5p/zjw/MzbnKY5Dh86VecolMC1wkBfQmUWzXXQjl7PehEabzLpQx+RsF3oAoshghcAasputSwYRJzhtUCe7FiWJ+lqieFWhsuYlZ8WxECP5eeYItlF/3j8X8XmGUmhmIvH6hajZf/msjelIFP1jBBkCfTjQGQ9nQ2RAxbogE/dIZ1nAGSh4H50DiS3v3R45crFWPBSdWdHSS5p49AxMWk3tpcAfwi3aBNwhXUju2YWLT54JNwEsgJysBBvisIPogKDbopPNP67UyOxpgv5pfm6gJUl39A6QmJ5j8qomDTbPjZBRuJFUJwkhHeIf6bAxtEeMaxvNyLYIREDjWYFPwMsdu5fXU6Q4vAEVra7cDvcEPpqqkLZf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(4744005)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(52536014)(55016003)(122000001)(66476007)(66446008)(66556008)(6916009)(4326008)(64756008)(66946007)(6506007)(38100700002)(76116006)(86362001)(186003)(71200400001)(478600001)(26005)(9686003)(54906003)(33656002)(7696005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?B2/Sn+A9pdlCJocqWjsx7FB80aJ4Jksk4dB01hvb7s44cF7xh8JQx1r8bWHN?=
 =?us-ascii?Q?mN4t5LAOtjd9aceHEs6fR/PdZYWO7XYhxE92iDwDsZ5sGOVgaxzcAgGBV1JB?=
 =?us-ascii?Q?AnaHjKYgC6Qtm3ULRCcxUQ0a3/pXqzOJhRN4NrLhZEYFXg2W94evCy4FaZdV?=
 =?us-ascii?Q?PkcQOxNAJBadAVh4S4QZaODUF89BRRZKt01fOfuC63dfe89oBj+0h0C/fPhX?=
 =?us-ascii?Q?cEKTTcJdW+L88TVPxIW/HFmVuQe4g3DJvJu3zqtsqGbfz2g/qgcHVKhD7xqG?=
 =?us-ascii?Q?+mCeCafWBgyqF+fXSzQOB7P0CdJ/8D0IE8X04MVwPOulHl3riM55tVrEQvFA?=
 =?us-ascii?Q?j+ahOYYHZ2Ax2ByR+z38v7ovp9RSOEmGyTU2Wc9NN6NHaIarpAKVg3lsp8q4?=
 =?us-ascii?Q?xk2w9rlud0gbIZxoEB7NlVDKk4dYgAKLEPOvODdzAq192jx9LF+FOqfpcfyi?=
 =?us-ascii?Q?vhyEtXxnAHqyflFoeNm/aWRS5esuS01pPO+vxE4RW6513uEbT+38eWykjVk5?=
 =?us-ascii?Q?osqNnZvSGIUbclYjy3gE9/qpKtmy4tnYLL/D6q33GZbZc69ZIIuWoW+rhWPB?=
 =?us-ascii?Q?9tXg1ZyPdsJ1kG3HS3n1zyz0vo+wPPoVHnP+pmn27FC2APPnGbr9d4RcSgR5?=
 =?us-ascii?Q?O/CeMMO+mRTgnL3SWadtWSb3Eqi5gHI++b3t6s20fwxXIONSC8a+5IU/7EnV?=
 =?us-ascii?Q?8wQ0aRBo0LhHr803rqIsGjLglSPFCSyf/fdXwIID/H77SDBJ5WjF4u3FJE7a?=
 =?us-ascii?Q?Dp9K37MwAaMaT2zrDrByGFPfxlbG2t6tuN2gsMYF1tfBduF/aY2REzVoHpLB?=
 =?us-ascii?Q?/2fZEop6OihLuL6e4twIXZnHxdTbO3niFfVGZ5eTwzahkf57/TiWyw8cGE2C?=
 =?us-ascii?Q?//czeK6IQhBUaKwik5uHzRQUz8gNf7JYvGQbGxJLGSN/kWd7rhsCfB/PSRSn?=
 =?us-ascii?Q?e+i/jW6IA1+nB28ubuv9+HQ4q+xNBmFs1aC7MleYkbMbPlEZbfyW52rf10hZ?=
 =?us-ascii?Q?4hsFF/8nqUBsKHNsINl1XK9uX/ON6I9dXfkJylyjWUkcfi7kHGopiT8k5mR5?=
 =?us-ascii?Q?xPBmvS45+Ezp//zjrK0m9/kfj839B+8GmDJJbJ1nM58ChK3RFdIz+IIJoRft?=
 =?us-ascii?Q?fqCuqc5pn6VGykJAsJCtTP0US5y0juByB54XdggW/Fe8vCPu2svMnRwT8Hr6?=
 =?us-ascii?Q?X67jMff5dbfsiMAtEq7NObbvCls+YiFoH3csmd3qge3TvHh5qnz0OBMMMM1S?=
 =?us-ascii?Q?0MGHonxXkYt36lOJvEoE9IVIwoTl94hTlb/xfAieeqV5MyTmzOavoUB+Z3wx?=
 =?us-ascii?Q?YIfXEVWE57aA/Dnp4FsWX0e6mkcVwtV/Ygo2cctK9/P7hoZj2xwf+9V/ZSfk?=
 =?us-ascii?Q?J0C4LN5NgFYPGl5XnJL1+Y0duTKt/g8vrMPYm0OBkhLnkbdTTOmJcGG6v7hM?=
 =?us-ascii?Q?KOLSmd0++jOr4vXRRITlb4WgMMyDQnn0FUTpUwTNszrY7sAyaMM1w2f9gX+m?=
 =?us-ascii?Q?8/fNmkF/ojg+naqv3fB7bhaShnNGO8HMWOUHhF3L3xpS95to1WSiYHgFk/4/?=
 =?us-ascii?Q?wGENG+HC2bUgwZnY2ySpvkqpF3D1IOmhYi6ciXtTnwHKzXKsLDkV7d4Ps5yV?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6580486b-e255-4049-847e-08db7d7483e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 16:25:58.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neRU4kEOFCG+DhMlFCQIZCc8wfrP0s7PzQ/+oNyq6XHC9nCfyK7UEX3vBn0bAGmpJGk6dCY44/XLakxuAikjaIf2KH+lMjOV+p9IhvTVunY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8171
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 16:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12235

Hi Pavel,

Thank you for replying.

> From: Pavel Machek <pavel@denx.de>
> Subject: Re: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
>=20
> Hi!
>=20
> > this series adds support for the PWC IP found inside the Renesas
> > RZ/V2M SoC.
>=20
> General-purpose output-only surprised me a bit, but it seems this is
> the way to implement them.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
> I don't believe equivalent series is there in v6.1, and this one does
> not apply, so I expect we'll get 6.1 version, too?

Yes, I will send another version of this porting suitable for v6.1 soon.

Thanks,
Fab

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

