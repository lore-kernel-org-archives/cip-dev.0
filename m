Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD5C05027
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 12:07:15 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.70])
 by mx.groups.io with SMTP id smtpd.web10.9757.1676018068274630840
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Feb 2023 00:34:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YnldT9BQ;
 spf=pass (domain: siemens.com, ip: 40.107.14.70, mailfrom: adriaan.schmidt@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijNKQbUQTupNFf4KSyVhaW9Z9cpjnAQGC1M0jTAD/m1ZzzUJqOuEMRbii3g/XrLHA+7qJf+F1BQzrefaIiBqbOWcdFGoQCwyHdVlyw94WP8OlgRCn1N0H9s04JrbMDrU6uQNkonEXL+YT74oi0Gq8IcTYy0yX3g8axFzGeATbw8xA4Nuv5jLfSHVAsXgRnGUtVMI0sP2B2bpG3goLYk5iQv0Aj3eUb44QTEQ7Gb5YoguzMnzj64OKi8HNqCncrW5U3wRsIi1V6trlvyDZlHkrw9cq1+5B7LdhfECGccg23J/DENfrJopp9vQoesWYS7kBUatpfqsGWbcWJQJQizIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LPiUSSjfFkd/1cLvwE1w5NayR/b5XDJOOWOhjvIppw=;
 b=nhT4mmcMRNWf/IQ3ktzPpWWMZHfOl9nHsFcLTfUDdjUITQDT2cRHwh4jldLILbefT+355YuD6hELUgOHnJyPv828bOLL5KmpkfimymuLhBNHU+Q2h7UY8ZhHyf7EybtQX+E/cdu8t0tgeISAkTfUOkAe29nL6ktuBxqLNOiqlSkdzx7NHhZD7R1kLS/WDA0Kx8RIh8yk7Js3WCvYKxzcnIONNOmm+1Rp24wr/67B8VnL3vnQLOwvqWpmIGuJLSW+DtXjCNZWpLhKW/bOeUSCKiEMNl1D7BwAFds1NpQYGd4SQ5XC048vKYRyvkKIwlsbXZjLmvLD9K+hCo9bnaor8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LPiUSSjfFkd/1cLvwE1w5NayR/b5XDJOOWOhjvIppw=;
 b=YnldT9BQMGPufwuuLSz3LwbcYeuM/CYM2s7OG0KwP1PxDnVHcKm2b0TsWVsdTt02THT+Co4toe1D8VNSzmhBw9cyNaYa45SLp/OhCzOZONEVtsU50FDBql7UJcpKtO4T8gEVCCDctUwgTRyoYCGSKzYXnzOA8WxPeJzxZmjT18KdGTz2shUiIotQ4a9UMC+W3soDU0ZpLslYe6y0sECKC8c0Rf1Qspyaebo6xpCXGXVKXzopSyE1wd7AvNS5xu58OyY+G5q4dRsK9y9lGgJJD+N6RBQKC7GoqWV0TWfaMTdNMTb1AQsQLb4+NX6022yyepalwOt3lyT2anvv2Enn9w==
Received: from AS4PR10MB5318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::15)
 by DB8PR10MB3241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:115::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 08:34:24 +0000
Received: from AS4PR10MB5318.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ca8e:2edc:4314:adca]) by AS4PR10MB5318.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ca8e:2edc:4314:adca%5]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 08:34:24 +0000
From: "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
To: "MOESSBAUER, FELIX JONATHAN" <felix.moessbauer@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2 0/5] Rework image classes
Thread-Topic: [isar-cip-core][PATCH v2 0/5] Rework image classes
Thread-Index: AQHZPRs7YAHdwgo8gUaOtRC5mPSbu67H1tOw
Date: Fri, 10 Feb 2023 08:34:24 +0000
Message-ID: 
 <AS4PR10MB531852D99D71D762AEE73D51EDDE9@AS4PR10MB5318.EURPRD10.PROD.OUTLOOK.COM>
References: <20230210064503.706699-1-felix.moessbauer@siemens.com>
In-Reply-To: <20230210064503.706699-1-felix.moessbauer@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=75bd5a64-bbc2-4ae7-99e3-4918101175a9;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-10T08:20:22Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5318:EE_|DB8PR10MB3241:EE_
x-ms-office365-filtering-correlation-id: e75e62d8-94e4-4fbd-c52d-08db0b419d74
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 U+854ibj5E3u4nzjOio1+yTLayRrVBLj7UKGaCJALuQp7FewNL5Tc+4UoiqC+AhQvAir/zJZ6yMzscVMKlJybY46LGDD8lgar08P8uVr16UUrAPwBpzg0yiYfkP6vzfO6gkiujXXGrWvb2miRvQc5dhdBe9alPGCcJ99602NCHW8Ijg0Bkp23VKYVWStFWK/g0qbRYome+nfffJTDWrAzw9sRqw33+QN2zPzrumiuOzHyMqNwzs+Ya6wU8e69alP4rRJ0SPo/kxozx3ViJ35mMtNfwLAwjuBEt++SGpxWHtANFfTWztepVpuhwms7xIjwDlmoqVhKkVPdXg42CpZkOC86pDdfwrotI5Q/wgEoDnHjLmkZTPCrA+pFeSxqWAxjmT/Hliz8WPtYr3DhrCYq49HqG4AU294I9xdjo/p63msubalZZvKKZ7H01NHafBYCLmIXt3WU4OLuMJ25yVdqiQHoXg7hfSDHyCLohPi77qWocKSuuqZcF+EiwNBtTjCBor0KqGwgS7YnSqV4QezHSZoEcjJGgwB5G1ZU+aMq4OZPVjjy6CfGUI0ib0s48RcRr1BOttQ3u13pMi47M7fFF4aEmC4AOJSMq5d5u4JOu9tqqCS2aiHZTHbIerTXUyxHBLTqUgSSgrl36woOl6OkNmj0+Jl8lyO3SIvZJIshpjRoCVaCP3BJBWzJ0GxrZEgU+fJE1gFjOAV2oTy9g55PQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5318.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(9686003)(71200400001)(7696005)(8936002)(55016003)(5660300002)(26005)(186003)(478600001)(107886003)(6506007)(316002)(110136005)(8676002)(4326008)(33656002)(66446008)(52536014)(76116006)(66946007)(66476007)(66556008)(64756008)(41300700001)(54906003)(83380400001)(38100700002)(82960400001)(122000001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0SLnvjubi25YZNOlA/vaqm/tNmOloipp2j4Lkybb82+/Hxf+uCY+1zdTgE6b?=
 =?us-ascii?Q?shSVXgJMWMcFS91CIILOf4GbwsleXU1F9zlDgnZ7vHnPd01+cQQimQ8EOg+8?=
 =?us-ascii?Q?Ej9/FV7fQRcQTiSzodDYJiHLUHojn3I+SZpuRUMB7ZdtrgXeUMKDjtq9R08M?=
 =?us-ascii?Q?ppcDkkTbysjBl3tmeRk2sdnPoU2O8XPa5JU4Xy3RUrNCzuRs1h1AQ3DWnDbC?=
 =?us-ascii?Q?a5+/VVkX0TYYG5a1xwculFuarWJRQ454IdWgHG7xIYa7PhcQj1L+9T3Tg+DG?=
 =?us-ascii?Q?s6Hk8EJdKENGkNdWabkqqQYwm88E7g2Stugx2R8czVSFKIhr3zQY3GOZoB1m?=
 =?us-ascii?Q?KinWlZoELQA9M55dxb0rvCb8TQkcdCKydHnjD3HvvpdBxisqhKIAL/4lY2l5?=
 =?us-ascii?Q?69DGP+/1hNhLKMvFbbqnrrinrYXNRfjUt/tYm6qovYlQQOlNw/Q/xgJWBvaf?=
 =?us-ascii?Q?+qbanFgD/+KoyZiRmdLyV8JZW3vbWO13ty578RJpQxStpTf4bNj1t1elVD6z?=
 =?us-ascii?Q?VPbz2kSVdYCUeJrgdj9ceSE11vkUOrPelnDxQ0x5ffY3eNf343F4pPu+Ziue?=
 =?us-ascii?Q?6c/8ryX1Gt7YaD/kaER8ukoZc3TQ7GMJv/3EVNyFtc4BvPT9IcWWfCZQiZue?=
 =?us-ascii?Q?fGIop5CuvmfxG0kLU8ue5ioHvUKkfvij/1vEVFXxYwZsODDc35TnQ9gIwHue?=
 =?us-ascii?Q?K/ghByvgC4xnx0wQ3lsFhJ3GBiBUXvPMuKVrEAOtVVQ5AgpQxzuK4/GaNFlt?=
 =?us-ascii?Q?Ry9MbPG5q68nupNxOAT5L4Lw26gCXPgnD6swKLwfC4gWV5FxA0g41rF5Gfac?=
 =?us-ascii?Q?rXZdghtXgZ/wtt8nKhin1D7CGPdXddd0dIjEh7TKlXZvmKlm1LpMmpFepcgC?=
 =?us-ascii?Q?Sjxnj8WH37+m/oP4OxGIQfOp3dPMrDK04LCmKPLuBhjL5uifyLCIFKY6HWs/?=
 =?us-ascii?Q?eBYz51GCjjypu8cyL3ffaj8psDiBjQI0uECqy52Y8cG3d4+aaS5w1TFZ5H9c?=
 =?us-ascii?Q?ROwyRrUPM8YfF7wsfvHpFqWGQR8CrzBR+ahikDl5jO8hViGBHqSqjIG+6+QP?=
 =?us-ascii?Q?Gk046Z0qHJ5kOtt3T0rVpBdaJj9Ym5/6s2aJq9wWrb9C/nZTPANjXSLWKtZl?=
 =?us-ascii?Q?tdEtkf8SoKkCdkm4Z+2dnc4oXWGuZACKGIU/G+vf4qVlabTTlktr5W7PdfGL?=
 =?us-ascii?Q?WkG3tju7p0XR9T+KS8jHTBRuEg0EuaIclP33O1GkJ00o/37Ur4CyZieFO153?=
 =?us-ascii?Q?6XSrqM3ZofGYtyLqILoWnJLK4C6MBQruvg2dTJ0iWzAt/4E9K5enBNQU5JTy?=
 =?us-ascii?Q?NxRs0+boU0P61VO7fI3KhzwkjaPzCt4UfUP0BMH2aU2epGOn6xVXZY4Pq7kv?=
 =?us-ascii?Q?De3P60vfYgxXe+9eMMldJQdczCciXxtBHSYj/aUBKOtJc3a06I4QPMkCfLvh?=
 =?us-ascii?Q?82xeno1PNqX1Iwfu1iiNArohNy0sK3FCZ6aGZ3cNQIb4J98K4oTzBuBgshQn?=
 =?us-ascii?Q?KT8f45lVLGoiOCg8DG77OpU99HljPn3UsU/BjaxSTGnAnaQmMky9XJB/LutQ?=
 =?us-ascii?Q?rlEa1sQcvNt1O9tlVDdh+2zuJEUHf5uM6hIJhGrdqKaZln/BMK2vbb72T7ft?=
 =?us-ascii?Q?4Q=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5318.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e75e62d8-94e4-4fbd-c52d-08db0b419d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 08:34:24.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wO3Yo32cxLeVRy9Pbv9YWto1jONcrO73BrCEUWj4ht2Nh+BGNteofI504RNM7R6toijXZrCwekxdjYUv5eNSujzD4MLdq7xQ7zOrG1wQ6YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3241
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 12:07:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10649

Hi Felix,
Had a quick review regarding the use of imagetypes and dependency mechanism=
s,
and it looks good to me (infrastructure used as intended, and resulting cod=
e
seems simpler than before :).
Ack,
Adriaan


Moessbauer, Felix <felix.moessbauer@siemens.com>,Freitag, 10. Februar 2023 =
07:45:
>=20
> Changes since v1:
>=20
> - separation of concerns: do not append to :wic typedep in :swu [1]
>=20
> This series reworks the image classes so that they are fully based on
> the existing imagetypes infrastructure. Issues with swupdate on non
> default partition layouts are solved by directly using the underlying
> image / rootfs variant instead of a fixed wic partition. To support
> further customizations, an interface is provided to select the type of
> the rootfs image (e.g. squashfs). The verity class then uses this interfa=
ce
> to configure the swu.
>=20
> [1] As we now use the image (e.g. squashfs / verity) directly to create
> the swu file, we also explicity need that image type (compressed).
> For wic, we now explicitly have to state the imagetype again, as we copy
> that into one of the partitions (but this is not an aspect of the swu typ=
e).
> In addition, we cannot simply always add that type to IMAGE_TYPEDEP:wic, =
as
> otherwise always a squashfs is built when the swupdate.bbclass is include=
d.
> One key aspect of the imagetypes is that they are non-intrusive. By that,
> the classes can always be added and only become into effect when selectin=
g
> the corresponding type.
>=20
> Best regards,
> Felix Moessbauer
> Siemens AG
>=20
> Felix Moessbauer (5):
>   register image classes via layer.conf
>   refactor: use imagetypes for swu generation
>   swu: directly image from squashfs rootfs
>   swupdate: only check partition uuids on swupdate
>   refactor verity image creation
>=20
>  classes/swupdate.bbclass             | 30 ++++++++++++++++++++--------
>  classes/verity.bbclass               |  7 +------
>  conf/layer.conf                      |  2 ++
>  kas/opt/ebg-secure-boot-snakeoil.yml |  2 +-
>  kas/opt/swupdate.yml                 |  4 +---
>  recipes-core/images/swupdate.inc     | 20 -------------------
>  6 files changed, 27 insertions(+), 38 deletions(-)
>=20
> --
> 2.34.1


