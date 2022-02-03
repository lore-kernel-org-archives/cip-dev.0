Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B65C433EF
	for <webhook@archiver.kernel.org>; Thu,  3 Feb 2022 17:59:34 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.134])
 by mx.groups.io with SMTP id smtpd.web10.1296.1643911171664653463
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Feb 2022 09:59:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=oGwxdKYo;
 spf=pass (domain: renesas.com, ip: 40.107.114.134,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJVKb3PargZSAPinFjABuTVNnRy6kwEulxzhIwgwYlFSMZIek4Ah3RshbQWycgycFuJqQGmYWLrBFZtaDOIaKagH0RAzXDDov6TnpRDG20WWcCInadRAQ9+fqYPjvZa/48MLNXJYal4InuMU+W6p9cmyVdAJgGxJs/L6LcNEyIJ/R37cdyJInIMEEPHivI83WXuCPfcGDszZgjNPreSp+88RnG5XtachKyLnSAZe3Fz1OHqGd9gnUz1KRHTC//d1gB88VitxVu0tcO4vq7DUInk/kLZcB/qU8JwasTr3zCl2tkeKDcu+A3kz0+dOtPm6GGpQuUa91jvj8yIBL+DAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z5Jo2hfjIOS3H1uwrlmnUsiJbMFlIDpVCj4zXHsDgo=;
 b=amtH4pEgJVX2rQ2g9sFw1dEFfll96lCIWnoTFfKN+m1Wuv54PtYXyk8s8Gh4dRxaI3LNHyyM9doDwqfa55TG+WAIW/ieq1xdH9rSwhBCKr2IsDB1+mIKU+iray0wLBB6bD0OXGCqKjfezE1qsDjOOz7bmim2wsSrH/yzU0NLEbb7IWULWqe7YrP6fyyhiyDS/+F0IuQtrhD15d1xzOeJh9v/Ec1jidN8PX4drQulXfX4qVQ1ke9J2SMINwxvRhJhN9QWM+OX5LdrM05woGA2Hd92H/j8jXRe3efRvRTuw2io5+tyg1gmv0cuGYoPXG4u6AgYuh+H+qAOcfJV5Zz4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z5Jo2hfjIOS3H1uwrlmnUsiJbMFlIDpVCj4zXHsDgo=;
 b=oGwxdKYoCC+gAqHywI2Ee9xy5d6J4c4hXxHL2MDEsNzmRngaN3+cz7hLxWYLanjjX3R8R/4wzXSbEOzsfDIaL8ZlDagOkOpxo9wBCVxLF3IhIpr5BHGryUcq78XtZCpxYNfmSPem51jhZccFudLvv583RRwr6zaDx9C+bhdn43M=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by OSZPR01MB6816.jpnprd01.prod.outlook.com (2603:1096:604:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:59:27 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::1995:fadc:db7d:f055]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::1995:fadc:db7d:f055%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 17:59:27 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Preparing a container for kernel compilation using the Debian
 compiler
Thread-Topic: Preparing a container for kernel compilation using the Debian
 compiler
Thread-Index: AdgMY9eyAPGayKlPRVGrKjqb5zpAXgMw7mCQ
Date: Thu, 3 Feb 2022 17:59:27 +0000
Message-ID: 
 <OSZPR01MB6877611FAD7B8E95E5A9C756B7289@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB6252AFDF07076F430E2CD1DC92589@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB6252AFDF07076F430E2CD1DC92589@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cdb4a31-3c56-4901-8516-08d9e73eeb99
x-ms-traffictypediagnostic: OSZPR01MB6816:EE_
x-microsoft-antispam-prvs: 
 <OSZPR01MB6816393460474EB3CB41B45BB7289@OSZPR01MB6816.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 i5kKOPLzba4M5VEwavrlUNEyjQVa3ESOCO3Kv0YuCPhSiNl698RTBXjoALI1Gf4VR2gc92dF5NqkgXx/PiAtKpJq/efQE+txAKLXA3tD+k2DL27cbmLBf5OycfuWZA+5HOi1oErbLXv1vnU1KjUdtnpAeQt6JnkRtl2VQIqzWon0DHtMK1ebHgjpvcpPB8SdJTQ5luPFXckrme6UXoxuG7lpEWmAJKZ2wKxnxnCkfSsLMVCE6PwKinNpqdMkGlHqtWmXK+i55stXhU4Wp2Nf4wu5Ov8nm085ylYW2UmPIlFIr3B1tOJxrprO0YjgJhryNog2Ua8lXc+Ow+T/QJl6Hss4BUA5Sy+QJDjaDXUrmmY/B8mx4d5wuPr6EpJiilIXOu8ztMdwSzoaaASKnbgY3AwEDklqGlbSjRNIGmu1OiEKEQ+WgOZW4M+T97i1jidu7IxenCMRwkRdo6rvbQt0LRRcYbd3H1ErffGmMA4RXOZG3mpbeVS+4ysYpz+ELfrLuOCLspeJETF+sX2kFkWiaxirKJ+ih30hkq2MPqbHz+Q0V4tzppEE2PAW/2qVapkdXyHY0j/BBvcjzixTIVZybaafs7q4Nab4hVCx+3MNnFWx42Kcp1Ok8tmcPlOvr5WI6y6Lz1mjAyn2+JyOGMReG4DyqayX4gp+NbGFlSDNx6wQjYwMN2L0BlslZsFpRo/YSHKJNVZb+YuRtQb8c0mS0xMpmfI8u9tRtd/WTdtCg62CQEPct17I15jOhfCKRB4yeWHePEBbPZMPwKhzZv2l+c+39tqj+2PgLMfkzd8r0DA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(38100700002)(186003)(508600001)(86362001)(38070700005)(966005)(122000001)(45080400002)(5660300002)(71200400001)(66946007)(66556008)(64756008)(8936002)(55016003)(66476007)(8676002)(83380400001)(2906002)(4326008)(7696005)(6506007)(9686003)(33656002)(26005)(76116006)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?D+VucPkYYxcwdNrJP3fZwgPhvEzPmKwpsIB0Eiv7Pk64kvsRuON3v16M?=
 =?Windows-1252?Q?SXND0y1p1GIYjn/HjAV8VR1ce++jxhi1UIBYrpaglJQZwy6EXIeYtre+?=
 =?Windows-1252?Q?gcAuSa+Jp5a4JxaulR79FiXMRtqzW++1Kwu1vWlRYyP8BJ01I5y9hJTr?=
 =?Windows-1252?Q?4pmTszPVWusFPBpsFaktJdWCEpFZYYGBo0YonHuc045exdJJsq9VFr8n?=
 =?Windows-1252?Q?LUUvAvgMgRPJGXyCxCq7/JFMQSI6SKdaM839Qqw8OJ7COYMDJTN7gLSc?=
 =?Windows-1252?Q?VlnWwjtrV1YyGOYPv0UN1N/o2NHZzHrF8WxCH46oBeYMsKuxwd7d/cR8?=
 =?Windows-1252?Q?0mR0bf4IOjkooQ8bmxc+PLm+GhNMFCrO6wftAwPUg+PCYZZ/b5MdD042?=
 =?Windows-1252?Q?rAde2XL0qtMn5dQXMe4u2nWV7z8cXEp/ORgvUume+VbXIoe9qTBCmLxL?=
 =?Windows-1252?Q?NsVtoKwXWAvwgpg4gthDRrZG0Y+cuOoUqXxy8R1j946D5A70hzjZnhXI?=
 =?Windows-1252?Q?0lHqv2e67H1XMbby26Bj/7Kc2a8SiGpzMPQW/dD3KRaeiZsu8Vmpqjnv?=
 =?Windows-1252?Q?NxyweYjKcYHrOAtf3+tJ6wVXT6KhLcniwx6G14QZIq95l0J8y/aeCS7W?=
 =?Windows-1252?Q?AEReOXqBEYtoi+HeQndeF1tmfft9QnKaia+h1wmN6UpwEdJZavWxUZec?=
 =?Windows-1252?Q?ExE16VejTYvCxTp1tjdsPEqy0L5rEoL1n+/6E4N1VfRbCwQmKhEFKxf+?=
 =?Windows-1252?Q?OPVRH/uhi3jO+et88b7dxK8r5pZFXG/Lcl3e5RLKIX5CW1jUCIklil1C?=
 =?Windows-1252?Q?+tEhaGGvarJCOjinQrGc+rk3BlhdzyQ1hrYcpTNNVao4aYMYuAtzLUah?=
 =?Windows-1252?Q?bfLyYOcvjmKUKS3rssvKnEpj/9HpsFpT52x4Y8Rj2gBiOJ6OsSA3Wolr?=
 =?Windows-1252?Q?qd6o6O8PwOes1wSGTriYkhhP18DRcwFIRIfqdQYmgzc0AKtjSbdYjPgz?=
 =?Windows-1252?Q?/TYnSqOEp696B8m1sD34EOxPJbpqi38oFcPh+YbgqsANB9iBltOsBS/n?=
 =?Windows-1252?Q?6rdrU5QzIxAtW3R9EkhX0j2HYNSvzsbUv4mykJlPn0sTFivVqcLrjnmB?=
 =?Windows-1252?Q?0mvoLYNLrBDV/DhFdp1N9b7A3guEO6tpPkjGrShLw1mqeT/CjOkip9cE?=
 =?Windows-1252?Q?ALloQEQpOhWNaKBZzXJ0I0bdRh9Exlau7pjfHz1NMTYLaLrT30dvIfQX?=
 =?Windows-1252?Q?raUxEKoifz1eGfhwV9m2r9XS6XY+NfZXuzlekvIJaVWlMxSS7EyfMg8O?=
 =?Windows-1252?Q?5GGcAGN+adhzlRrViG0O/X5La1vye9MmIaW+O1C4JYJ6g9gza+wUtnDg?=
 =?Windows-1252?Q?wD93Ei1cR2fr0Zgu4334DKU9itroFZQuyUeIzFU5ZEmgmlwQM89k4mq9?=
 =?Windows-1252?Q?taY+axKqb+hM9wEEd5qd+45v5WNekpQrlPQ/ce/OJzV+XWqWSfUWA3ux?=
 =?Windows-1252?Q?5pUNw0rx6/HltCrDbXsORYk/c/Ho9R1K8SWne2JSQBaDWCTGDkZPhOwj?=
 =?Windows-1252?Q?8a5ZksVD6uDExi9UPD/JZOI8oUJaHgpdwZB2d/ayuUvXOhJqth2zidy5?=
 =?Windows-1252?Q?lxWStD9UjMIRIirA0XGcslvGJyZ84wfgXwVuAvZ9q/SIPA5H5u22tA1T?=
 =?Windows-1252?Q?lrGQN0qipzEotNlzY3Y6tRG2qUo3gbEKUNtvMBDBkjiXLGdy0qej3rAA?=
 =?Windows-1252?Q?iNIIvBSW8cWxSYJVUnhpNQmtG14VMMYp2KbJ4PhJgjpDl14pRrxaZo39?=
 =?Windows-1252?Q?dc+L8g=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1cdb4a31-3c56-4901-8516-08d9e73eeb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 17:59:27.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 3JauCUlj2yLhJucRZZ/urbwWLvdEPk18P5uAIkH65F5W+pOeiMI4JQW2zUhAdNIbEqi7TPLj9UvEQqANsLxOyp9vTcggehJsoZQlZCH3154=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Feb 2022 17:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7570

Hello Iwamatsu-san,

Apologies in taking a while to get to this.

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 18 January 2022 12:36
>=20
> Hi Chris,
>=20
> The 5.10.y tree building is failing due to a problem with the version of =
the
> compiler
> currently used for kernel compiling. To solve this, I thought it was nece=
ssary
> to prepare
> an environment where each tree could be compiled. We also suggest using
> Debian as the
> compiler as we are developing using Debian.
>=20
> I have created a fix and MR[0][1] to solve these.
> Could you check these?

I've added some comments to the linux-cip-ci MR.
linux-cip-pipelines MR is approved but obviously the first MR needs to be m=
erged first.

We can migrate to cip-core-isar once we're done with this first step.

Kind regards, Chris

>=20
> Best regards,
>   Nobuhiro
>=20
> [0]:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-cip-ci%2F-
> %2Fmerge_requests%2F53&amp;data=3D04%7C01%7CChris.Paterson2%40ren
> esas.com%7Ce01604e9a78c4a058b0208d9da7f2b4e%7C53d82571da1947e49c
> b4625a166a4a2a%7C0%7C0%7C637781061993287282%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000&amp;sdata=3D%2BxpkKQJX1QrSJrNnVbAFCmhHR97nZhre
> rqfc3xjgj6M%3D&amp;reserved=3D0
> [1]:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-cip-pipelines%2F-
> %2Fmerge_requests%2F25&amp;data=3D04%7C01%7CChris.Paterson2%40ren
> esas.com%7Ce01604e9a78c4a058b0208d9da7f2b4e%7C53d82571da1947e49c
> b4625a166a4a2a%7C0%7C0%7C637781061993287282%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000&amp;sdata=3DNESpNj06G410KlYrpKIhPoGIwQp6Z2ZFfeFF
> 6mesvHE%3D&amp;reserved=3D0

