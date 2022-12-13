Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BAC4332F
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 15:34:28 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.127])
 by mx.groups.io with SMTP id smtpd.web10.76498.1670945659855930757
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 07:34:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=KC/SgQIE;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.127, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeSikqATIbqAcTS3Q8Qp3hEy0GlsGBTzssLS4hD9y9guvATxWSGPSC3/WiRx3EDxZH4QjXImg8rgsGdgbub/xyHZIh+snZHqSbuqxzTlAo+nB7vnuxqqWWnuW59cKgpBHkI5sn6c81GQ9s6PebF72CZoDBG8f27aVNKFt3x4l2EjYvI81RDAG+/3BMd2Yu1iY+jJbheN87NTC3LoTcR7SaAWIIX/ok32unAWuuMCx9/fxMRao06Nl0YZqBDskb21dXPkXM5qmX6/u2ArNg9jNhrPFnwyfP9u18S2xxorCpXYo22GOG+H3vwmNwULEGaDZGfjCPu5Q5Sg0nCyL8jeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ofGzL3upwHygcMsUW15V50y9MVzCA1Q0xudIexCcVc=;
 b=oZeVZm19LWex0m0P6iAoYbK0V8jOoOmRFra3j1N0RN5PHclZx5zPt/EO48jdzGGCrTzhu4TMEySNYGrZv/huz4HFGAjYF+yAWDMqIyxnftXCWgBQ534f+wOIN01V6nRqnLM9XX39TzIRyaYcnikSprkyK6CJLJLD9Xt3tpVGYklT5CDhcA5Wba/k2gvq9N3TM/V/d3KgJAeunKL/fP0Wm4pVvCyr+LRGlVeYGa6SeHyL092P0j58ap2ZRmDlYzIZH8QLEU7TGST58ZB9YR1o/p724sumehoR7UFxRnChakwqmR8PGmzUrV2ZUAJ16kp1r906uHFnWGkuNd6/0MhJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ofGzL3upwHygcMsUW15V50y9MVzCA1Q0xudIexCcVc=;
 b=KC/SgQIEGBhb2U0Ei+Ft+kmqP6Y3lyNfdU4J+mEPo2UDzPRzpqdOC32bQb7fJkA7mno3ddTdwK2wMzikJ/4vzu6gv5kF61ze8GKuSZQmEm4omRBzTiKLdfNe9MKSA6irKiBBbjyWImTEb8TbwV5b/sdz8inHGtCS73TIN0q8qSo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 15:34:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 15:34:15 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Thread-Topic: Regarding  commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
Thread-Index: AQHZDwY4hOYrVHZLX0+FYgabGelo+q5r8m1g
Date: Tue, 13 Dec 2022 15:34:15 +0000
Message-ID: 
 <OS0PR01MB592266CED3CCA24F54312A7E86E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
 <a633020e-7436-8d86-7eb6-34482af700a9@siemens.com>
 <OS0PR01MB5922918719AC879EDCDC70A586E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB5922918719AC879EDCDC70A586E39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: 0b956960-c0ae-4e4e-1b42-08dadd1f7e3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2Xnka+X6KV7kFkTx32EJAAzjTTiVTkPhiJnkNBs/MBBcGIbvt0fk5dNpM9A4T3QqeyHp0lDVIC0H7cMxER8/TlvqLoCxXT4SO6unH8tXY4LIn6zizl3xzqtZ9ry+oYVugQtTdQie6icXOr0wVIvMRiUK2+5+T3hwWKf/pDKeIqR0YLUq360CfFMowOjacSH44vNLFdK65IDcczJEi67nYfzUMmzrTAbeF/1zxNa5RCiNn5wYLkU0b18e30dq4tZzYZPqgSkVmIzOFn6fOa8Q9HsYGXXUoZj+gpgaB4Uc5eVpdquxGVLq5gwjtlLLjxJen4xBOPNTmdh/8mr2ztRZyl9K9zHygyMMB7QLrv/p1AcgrpN5pIqdJbBc9Rlw0oYcALjGFxHtIgvaxpQLpVA8kwBR3/HjLa78XhhVwB7zKjDFD1XsRpHSinoSifJDre54q9E9faZBUOmYYt9XvDI7R4htuoIFMjpmR+pOd4t2UJPrUvG8B+mis6c8n2jVtgRYLuDMrlfbI1PnwZh9sjbzAVjHhLHrr3Ocx77v4tmP3HnvNop/21uL66jd2V9WvdnSHi/QwDFoBRRuzhAxcsI12g2tx5Aq/TAL11FvSc1qYrLSMz81mVYXdStbUdrXcDXOSBiySWVHcXps81LGbeEjaalTnGl2eFx7yDdC6EVCZxldX5zRrqkyt5DfHcDzbU8gaLEPezinSADwSTz74AeiI2531dyaWdIAqZDIG4BFb1ZJZO96vNp6o3BaaeH4n3PU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(66446008)(76116006)(5660300002)(64756008)(8676002)(52536014)(66946007)(66556008)(66476007)(71200400001)(7116003)(478600001)(966005)(186003)(41300700001)(8936002)(53546011)(6506007)(7696005)(26005)(9686003)(33656002)(83380400001)(316002)(110136005)(86362001)(2940100002)(38100700002)(38070700005)(84970400001)(55016003)(122000001)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YwVEVRGmCOkOMt3u8mQhdRu2bIsnLiY6xLbjLIoS5wOaf3u8BstJ99BaCtR2?=
 =?us-ascii?Q?6hDpjf4owSPVfnpguLKqdRIOwu0Po/xsdL78gNMN00U7iH5wIpk9Vo+/OPkp?=
 =?us-ascii?Q?jcQDRKiV3C0aiNB0pvNmQMlG0fKX3Zeryd04poTFFFhKkXSqi5yMPXKCHPe0?=
 =?us-ascii?Q?YUQbRx4XYFQG8Jw8jxUbP5lGDwnmu8ELd7zPqSpBfp5szC10fLL3p4k+3BOs?=
 =?us-ascii?Q?bMgV3JCUKs5WVLx+KwXEHFKD3V+DHa/DjcfViHjpIPJW7hpVVZvdmdniD8Hk?=
 =?us-ascii?Q?0JT/JT+7Fm8YY9tyQWJdS8iBk8AL2bWd8ELWxadEuKJUOX4RALFPidEAMRbV?=
 =?us-ascii?Q?J2nQnrUL1aLbxG2+dLKbdr+ns1I8L4QeZX9g2QrbJKPvZB60pReYaPWMsBXZ?=
 =?us-ascii?Q?KRl6I0PqTneP3aXiFD7lcu+nTnwf9+nCITSaV0BLOikkSOpS/6KBmRurbCnG?=
 =?us-ascii?Q?GQi22GTr1gb9KuLV05Hh6WH5IAfk7IUwYP2LAgSIBNbbyM9dACCxEywg1r8Y?=
 =?us-ascii?Q?X3nRH1lQe3rApCaDSUUpoonOzKOs5NRZD8184NYrDPV1qKh8gletSy2xKBg/?=
 =?us-ascii?Q?t2EfGKsPU1RTNG/ITwjJ6twz4xr6nEoV+kzF5TpV6WgM4FrddnQdk+H6Nb8Q?=
 =?us-ascii?Q?rByytXszgjlyYMkWmHlNoOUuKQBx1Ar5t5Kxr8g7z4bEq092wgKCgFVcH703?=
 =?us-ascii?Q?69t+ZpTxrJDonxA8B8d4m6vablBbMIMehRfdwKvynaDN4rWMsJ5XpYp59fEI?=
 =?us-ascii?Q?wCumqV8O4e7UHEZWbqNZ320IhBpT+OgCoXhQxpKmxdw9wXupNRs3vfOHd4DZ?=
 =?us-ascii?Q?Sok2BpKBwGBUKaizlrGAnPvyHskdpc0Oi7hGfcdTxDY+VfwiJkwSGPoZf0X/?=
 =?us-ascii?Q?xUAhLTTvyFTUKBNXhhNDV55cBxq9zQOsvVplQBMxBOl0bnFC/xwnib2LKtZY?=
 =?us-ascii?Q?0lQsQvyaPB1AWi0cxPv7V+gtuIJ0n9ilBHu70gUDz9FwyIzu1wT9NrREenkt?=
 =?us-ascii?Q?cYXe2RLRvF5Qe84RkDxmJIVBzLs8vfR0hSonharJ6IHTKDj5gdPLh/nErD4l?=
 =?us-ascii?Q?zyjjjfyCcoofPG99LyGn3QcnCNz7E4OpNrNb0t+GMRmNiNpNKlifTvYjpfMt?=
 =?us-ascii?Q?YWYAo5RcGWTmPztLyllpvFmm+PhXabCAd9T/u/puQI/31AV1Euv+TittlQg5?=
 =?us-ascii?Q?zK/jBNp4Q0TUtgSt5+Gf7k7VGN2O+jA4OBNBui61dwdLKaBVj+f+fQKNNWjI?=
 =?us-ascii?Q?srV5dswawYoV7RIAYF8XMtIN5WH1Q9/p+efMs2L6YrAt1w9MZUWk2WJX1ZGt?=
 =?us-ascii?Q?bVOWdoHQANYq9mXCjlzaA/2ENMfEkR+Wb2xUNHhzvUrLGONNQ6stPhvd4MrR?=
 =?us-ascii?Q?y9t8LPGQSvZKdrRCI2Ti4bKWqF2WE2LWqzgPfwAz5QfamX6ckMJ1T3WZbViR?=
 =?us-ascii?Q?3qXOyRn6LnctTiRW8RSCW3XOOGsFk91IFzPyw04QVwoS9jRBj1pggjRIFpcC?=
 =?us-ascii?Q?cjKlbneyD8YHMb9mxdnktCIENWZYPuMY3WRAytFU974IUnsoMw3voxq3eSVZ?=
 =?us-ascii?Q?gL8WMtuRFwqNmO9YtJa+uqkgYiNEBABKgcYLtYHgojyC258BvRns+XLSEYIy?=
 =?us-ascii?Q?SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b956960-c0ae-4e4e-1b42-08dadd1f7e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 15:34:15.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U79a4bOqZwo+Pee5py+KCXOqm335rI8qpT3JboQfMj08zLYvD6k+vQcLXAk7gmSWo2WQaJ03pi+QCZuQcXLpXKUgM8LpVvW3IhnAo045hy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9414
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 15:34:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10217

Anyway, I will post this patch to CIP ML today.

> -----Original Message-----
> From: Biju Das
> Sent: 13 December 2022 15:19
> To: cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>; Nobuhiro
> Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Regarding commit eb69c07eca22ffd8621d9de9378e4b3ce7965190
>=20
> Hi Pavel and Nobuhiro-San,
>=20
> We are missing this patch from 5.10 stable[1] in 5.10.y-cip[2]. Can you
> please add it?
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h
> =3Dv5.10.158&id=3Deb69c07eca22ffd8621d9de9378e4b3ce7965190
>=20
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/log/drivers/net/can/rcar?h=3Dlinux-5.10.y-cip
>=20
> Cheers,
> Biju


