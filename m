Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835B3C47DB3
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 12:07:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.21168.1706875655660347244
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 04:07:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 412C7S5K249592; Fri, 2 Feb 2024 21:07:28 +0900
X-Iguazu-Qid: 2yAbI6ncWlihZXdg0W
X-Iguazu-QSIG: v=2; s=0; t=1706875648; q=2yAbI6ncWlihZXdg0W; m=gXRJsGSv5hyu4IcaN33oi/mebKkWXPrrpGro43uIkFg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 412C7R0u2888227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Feb 2024 21:07:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlT6Dhcw1xK8MZdOb4yfy+q+XE0C6K42BOVIbreSjFrAv6jLLRw0teKF69I9LRaW0v4VG8A4uY/Rle5iQVgav+GheiyVhB4hN+UabvhTs2+rYNuDiQ/wP13UtBXuyDU2hBGLTNb7einle2j3SRrUdD4qA6RYqebDuZ9Jp+CA0LRjk+jdt6LA/ZXjjjv8blVx0qC3RAs+I1S0PoAvhCLkosvsC8/YlhNYvnIw8T7hIm9ds4WFtCqq7OlG7oSQ6WFH/2wfvNb9DirEozRpwM1hSKH5jtUdfHpTzJkUTK5Xqwbs5hOXCkENkJv2aAwESMJRnoXxvGxPhRC9F9YFE5Wa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+65Mvs4rddvFk6t5SUCA8ko/3mmXhGVXs8imgrCLLwQ=;
 b=Z0Uw/jfyK07eotT+UkhqPGhNukNY8B/rjKF5g9Km13kdyRcIIi+uhzPX4JB9ZFUgcjy+BlllJYWNw7LZQnmPZNuCBiJmJpz1Ngv8WnCWigDDnsLrO+Bbigk1dmg367eisRZXr+0OvrGx8TvFfXemgQ7AdahZExjImnSr6+Z9gIoPinPZ0Q3gWEBb/yfElTMK5J4ViwgGUSeAjYjicBp82WP+0p+eQjIR8eQLOZGle8tqepRQg5H6SEqIYVE+FECkFHO9wfbvyYi8FZ5U5r+sWCbpBQOH5GE2JhC/Yhl1xt2yUHFWnIVS+dZUJh8Fg/m7XYIXktLLgmwewwh+HIxQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 4.19.y-cip 0/2] Drop undocumented register definitions
Thread-Topic: [PATCH 4.19.y-cip 0/2] Drop undocumented register definitions
Thread-Index: AQHaVcMXmDzOHQFsC0eZ1f09fhorBrD29RTQ
Date: Fri, 2 Feb 2024 12:07:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB638896E67835B158BC93D8C592422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8262:EE_
x-ms-office365-filtering-correlation-id: d8d48f89-3341-4ce6-3119-08dc23e78532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KBR7as7PbZxcUb3yMpWlkLW3xJ1OQ0NheGCNFPTKhUi7X6ll5eZTVgvXl5ZX9ahblDP/W0l8IsUU18O487Ps+7yQwsmWPZrrriL5BXWKxRd7ELjOyHFA+GP4bqW7fPAMXGtYiaHU7k1S/Dfm2mlLnzT7qh6uQ6GjbfLNdKhidyO5Umk+bvzHlenOvftklCUBjbQpQXorw92xlTTc25DmbeAHW0rS0CWd5o5r8V+ZabyCAAYvcrEVX/M/4Rp3z6cet6HeQljaRVOy8nILfOQw7RJ/jcXt4loqdEtTCUNtitLLGi/8zZLAFigaIjTj4y6INyBduYLJcN1Fh4D6Of6GEUCHgDRTJtq0RC6p7Ou8DS3X53Dk6e0kE30yAn7U5/ZIfTGustfwHFmHPApQYaaD3bojUns1w3MFtc2c7vgvowa6WqRrbw0ULk/6SYleJaAzExn4J+8ip72pu+tkC/557kai4JMHHUQLnqjI6QQpPs1xFp829Wq9bJvtmOf0uNYbXw4fVTWkUk0rBR+P89noZS8oKxrrJnpV/csFGGBZFB/PK1CYjaLMcbJZnoeku0G01XT8IXRBwYQEwXruQzwWAvYXtXWXoonR9+67qd12C4mlqCO/7y7ajAho8g5gMIxY/U5BVeM9/9i1rnjGv4M7Iw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66556008)(64756008)(66446008)(26005)(83380400001)(122000001)(86362001)(41300700001)(38100700002)(33656002)(8936002)(66946007)(76116006)(110136005)(52536014)(6506007)(2906002)(5660300002)(71200400001)(53546011)(316002)(4744005)(478600001)(66476007)(8676002)(4326008)(7696005)(9686003)(38070700009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VFNpRHhXYTRwT2daUVZ5MXN0M3RRTXAyeXB1R1ZucXF0cStqNWFsbG1S?=
 =?iso-2022-jp?B?TG1IZnZlREFyU3Q3VS8zNC92eUVnVmQ5REQvQXlpSzFoSlMyc25EMUh1?=
 =?iso-2022-jp?B?dUFsSlRQVGl5aTdKMUZwbHlzbGd6WER2aDBoVmJwNUJNVmVJaDhOdC9z?=
 =?iso-2022-jp?B?dHU4enZ5ZXRUeW9Nc20zYWt2YlBUQm9ZL3J6RVluYlcySm0vb1hKcEtX?=
 =?iso-2022-jp?B?QnRSeWMvYkVhUC9jdUt4cmJxRDdMVGpES29yV1Z4NTYyem1MZUNHUDhw?=
 =?iso-2022-jp?B?Q0p5clBGa1Zvc0UxTzViMVE0a0hOQUJ3dStLa2IvbVBNd3pFdW12QnNy?=
 =?iso-2022-jp?B?cXMwWHlSNXAvTHRDYkNscDVMMUI4akFXbDJueTViZFZFOTE5dHdVTWdu?=
 =?iso-2022-jp?B?bHpITk1Xc3BjWWE0c0dxY0hvQ29HYjd1NG82NjFCTnZtM2FpSWdUVlBl?=
 =?iso-2022-jp?B?R0ZmMEd6c3lOclpBMWdkMGVuelVxVGVTS3JrdUdSWWttT0Zzcjd5dElO?=
 =?iso-2022-jp?B?Q1FMMVozZm9TZVQwckY3K1NnaElKbzlibWZvVlFkdUdBMTUxbGhUbjZI?=
 =?iso-2022-jp?B?cytBRXlXM21MbDlzaUFITzRiYlJEaGVvc21paEFJRkdkM1B5L3ZZUEp2?=
 =?iso-2022-jp?B?am13NW9BT1JTazZMN3ROSHFkTjVZd2xRN1RYNTl3aSs1N0Qra0xQQUJI?=
 =?iso-2022-jp?B?MWViRTVoWkpvdGVYZkRQbzJWWnFmMStKNGhuYStsTTlVTWJiay92QlBk?=
 =?iso-2022-jp?B?d2Q0bTNWaTdmVHJJU2lSZHNNUVU5M0x6ZlJJYnlINjhBQjBEK24vRmdx?=
 =?iso-2022-jp?B?UGdqb1VpSW96aDFYRDRyUThjbTFuT3paSTVOMWczd28vemlOcE5KUElQ?=
 =?iso-2022-jp?B?NHB3RC8zVXlENEM0V0h0ZHlqbDBVZ2RxeXY5d1BBc1VaMlVxaVZFOCtT?=
 =?iso-2022-jp?B?ZHdaL2JURUtBakF6Rjd3eWdROVpuTFpUTHJGNkJ1MURnU2k2RkJ4K0JZ?=
 =?iso-2022-jp?B?QndjSDFIS1hnLzFDc09lczBrdENlVnpkRnpJaVFEVDhlQ1NLNTFXMVE0?=
 =?iso-2022-jp?B?UXkrajV3d05velF1ZUhhSS9KQTViMTA0blFvbTlrQThVWUg3MXcxcUJt?=
 =?iso-2022-jp?B?Y0phWEExMmduSVEwK1FoRWlFd1pxMzJpL3pidTQzdDFIZi9PVDkzc3FP?=
 =?iso-2022-jp?B?RFpFNTVjRG0rV2lhNkcwcHQ0S2hvc0p5Qm1XUnF5R0cwVkVUNzBmT0tx?=
 =?iso-2022-jp?B?SDZydmZ5ZDY4dWppbnlMZnNtbHlpcUhjM2JuWVpUdEpTbndOa3VkRktn?=
 =?iso-2022-jp?B?T3c1MkcwS3M3cVI1ZFEyNUxCM3pqallGSmxnLzFFOHBuQ2dWU2pyeWI0?=
 =?iso-2022-jp?B?YkRKUE5SQTNGRWljbUkzT1ZlRWMzR1FyRVg0UUtXbmZkdU0wd1F3NE50?=
 =?iso-2022-jp?B?NEx6d09mZ3RORURTVWxOdUJVZWdBU1VDZ01jd1J0NWZ1ZEVFd3M5L0dK?=
 =?iso-2022-jp?B?dXpYTFhFMU5lNjl6K0IxOGpsM2Z2QmpLSzVEaVZwY2N1dmhjVHlKcjhp?=
 =?iso-2022-jp?B?eTB2dytZRHk1RTc5RE1tcDhDSjNaYTdEd2pqYi9nUU1HVHc5Y3ZHSGZU?=
 =?iso-2022-jp?B?aWlUVnVkUVgvVlVWMjF0Y0pNTjBsd1lJaFhpdU40YlE3cVlROHQ2aEVj?=
 =?iso-2022-jp?B?UHY2dHJqRldnWGRSbDNBVlVzTm9yZ1VJcHh3NnpZaDUvbjRudXRPVlk4?=
 =?iso-2022-jp?B?ZGttRlhYOE9mYzkrMzFibjhBRisraVhINkg4TUg3M2hiQUNNL3R4TUoz?=
 =?iso-2022-jp?B?WmZnSnA5RXZ0UUdCWXpUWjVQdzFMK1BaY3JEdE82cEY1WEsraFFUenVq?=
 =?iso-2022-jp?B?VkVYUmZ6dnlvY3V6Q0ttT1ExZWhPdjlOV0ZZb1ZLZlh2Q3haOWM1d2ky?=
 =?iso-2022-jp?B?aTg2U21hTG9DVzdETHdxQ3B2OHhZZ3NWTTdFSFRNNXBaQlhYejVYbDF0?=
 =?iso-2022-jp?B?UStod0E2cm40RE9LTjJHZk5ZUWtXZU4ybmV4TFhWaWs2WE5pTmFlVHRI?=
 =?iso-2022-jp?B?cmdPRmNZWEJFVlJTZ0sxSThWWGpmTWtybEZlOU5UbEMvY3RWTm1xRWlh?=
 =?iso-2022-jp?B?UWNkeTBGM1lSQ3lEL0NoOS9YS1VBdjN3VVU4MHphaXVkdjluVkdyZ1Fv?=
 =?iso-2022-jp?B?dGV2NjFYM3BKcVpaSS82TkMyL0UrYjdtTkFBZDFoWFYvWWxJdFZ0T1FK?=
 =?iso-2022-jp?B?dktOWTVFQ3ZGakZKNEtJYTBWWHhkNEpsbWNsckw4K0RqUnVzeHR0bUEr?=
 =?iso-2022-jp?B?SmFsTWtIMTRFdDgxd044VGo2SEFtUHdJQlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d48f89-3341-4ce6-3119-08dc23e78532
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:07:25.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tokwPL4VHmPR/5BJPbjuyRd89uxtSmNyEj8d3+qMVJnndAWPwutkc/hQ/3IG2HeieyI6i04dJWseZ4509SGjEmbhTZlEemI4QYT2uhnDsWJjRQwyVl7QK6oL9Cp2T1Mo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 12:07:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14625

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, February 2, 2024 7:32 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 4.19.y-cip 0/2] Drop undocumented register definitions
>=20
> This patch series aims to remove undocumented register definitions on the
> ethernet driver (ravb.h) in 4.19 cip kernel.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Sergey Shtylyov (1):
>   ravb: update "undocumented" annotations
>=20
> Simon Horman (1):
>   ravb: remove undocumented endianness selection
>=20
>  drivers/net/ethernet/renesas/ravb.h      | 27
> ++++++++++++------------
>  drivers/net/ethernet/renesas/ravb_main.c |  6 ------
>  2 files changed, 13 insertions(+), 20 deletions(-)

I reviewed this series. I can apply this series, if we have no other commen=
t.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


