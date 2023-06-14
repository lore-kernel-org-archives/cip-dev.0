Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450CEB64D7
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 00:40:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.736.1686703205467199840
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 17:40:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 35E0dtTo016337; Wed, 14 Jun 2023 09:39:55 +0900
X-Iguazu-Qid: 34trEg1Q93Mlaz0i9I
X-Iguazu-QSIG: v=2; s=0; t=1686703195; q=34trEg1Q93Mlaz0i9I; m=xFX7Np9mU1l5h7FIDwtGwuC6jYF12NrI4zWasGASahk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 35E0drGA028626
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jun 2023 09:39:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4GDlQ7iyTK8cE19MRWAM+xZgxTm2TtPppdGlWGESoQ4RvA/pRweqAvgLInd26mVLksNNWf33Nkg9XwXOr3jkjYBZ3Oqw+ZT8X75p4UhNoXXjH7U3Bs0ATGyHink91OZcWP//gjle5BvTYhR2h4d2YFNYpLrS/4ZLb+dqWS2ycIzqR8QfjtxEO3XSSWHWvWkv2k2nP6MBC88tXKeEH3Nu/DG3nfDkuOE2XimG1lOEpexmg6uV9XhYxClj2afoG0kIpJGDJoOiFnh/A+Oa2jNC4uundkscacZbLjt5vmaCI+fWf/iN+rn7ezODtkW5SbZXH2cTXlDOWnWc0W3P+LpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNZ2LVp7rq+wzp1yyA2Ka57JWP9Y7EzRCxh6O3nkQuI=;
 b=Mxo5BadLastfKlZflerEOrQyLaCMlSo4LaCvdx6mbfgadDoYLvY7BT4h7GFWEF/5Sp2qAfiYtyO7DM1XEMWaNK++sxtJdK6ZJ7sRYRUkVDGvgh7NqYkTlm30VKniRc4qDG+ow59Szzv1/GBm4A6wUnva+bSiZgOmIN9LxChoMgpGbhX6srpuDWgBWj9fgOPhgO9IlIut04gyPk41/ZCu3QMp/spmdalo6UGCoLpwxFaIz2dE2QXL6y+zWDY12UbrSkXbqWKaeqyndsKEACH7g/FxRbMlSIRvyIKbC2xXSG0+NCN1qYYJHC9nGExobZwvSr+y8alji6ihbKUydI/Rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/7] RZ/V2M UART FIFO support
Thread-Topic: [PATCH 5.10.y-cip 0/7] RZ/V2M UART FIFO support
Thread-Index: AQHZnfpM0flLYPYuU0WjLgu0tRsTFK+Jcnmg
Date: Wed, 14 Jun 2023 00:39:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB941805A1C76870231B1BE9D4925AA@TYCPR01MB9418.jpnprd01.prod.outlook.com>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9418:EE_|OS3PR01MB10248:EE_
x-ms-office365-filtering-correlation-id: 28c756d2-2db8-40ec-c4ac-08db6c6fdbdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LIPBjyv77e/q+nH7+fC2ijenehBDjZl+pdQXPXQnwy2JTGHVlu3au29Bgq99mhSqhH42wjZVVfKORqYBp6O1U9dqqAjA3E1vRnCf9/pR6bDdcWeIA2rRbSoRC0jpE5DHoK1fS7YxzPFePWlMhXvoUXUHI1TjGiLi13QqH3OQpHbmBVwbiqWYdIxvkLHVwGDU7qSAYK3XEqD3E/0ZFmFvTDajKyrGLZX0cQ3GyfQtV0cEwZiYeVJaGhalyn97xeVL54Uxeqp3eQ4OoioPyXwDE+EaPbYIgpzb9uB+g9dn9TMN2XnJ1+9KftBbc8O5xTUK2jMnMYZ96w+qW0NidHicqMZ4MUPt146rbDaN6ZEWGUB3PWJjkTeKVwZV12eawBxZUDe8F9MC7gZxH9SLwWUqGUTDboLd4J0ULDvFLdvm8C5KHLoB6LZodEVqn3f9nikjehIXvygOjigKPO4NfF2e+aW85Rn/30bZQLFC5ItaFAovKeXA2PK8hOujQzyXsKc+AGDxsqgB1gSwwmEfASNSSnU3xL5wWOLWL3ErwVdrOk0ujlu3LsfXtb69g+skVF2DYtNdJm2npSjYGDICbA1V19+O2UOYopg1bDftBKH1ZrETBTjoKMFg3NUGDdHMH5j4xzuTXeGzHm6A9rGG2im1Ig==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9418.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(966005)(316002)(7696005)(41300700001)(2906002)(83380400001)(86362001)(26005)(6506007)(9686003)(186003)(33656002)(38070700005)(122000001)(38100700002)(53546011)(55016003)(52536014)(5660300002)(8936002)(8676002)(64756008)(66946007)(76116006)(66556008)(66446008)(54906003)(110136005)(71200400001)(478600001)(4326008)(66476007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Rkc2WE9MMlhSb1luTFdOellFRXNnRFFFQ0RJb1o1MG9kUmhNUnU1UElj?=
 =?iso-2022-jp?B?MkZqU3pMaDNmU2sxMW1VSC9obUxFd0R0dS9ITEkvZWZOakVnNWR5VGdu?=
 =?iso-2022-jp?B?Tm9McmhtYUVYT1lEak0zWXRrbEl6U2pDNGExdmo2M3c0aUNQTVlySGJ3?=
 =?iso-2022-jp?B?Q1ptK0F0U3F3cGt4WHU3dzBOVmdyOVdRdm51VEp0RGdMdnkvVzJ4OThD?=
 =?iso-2022-jp?B?emlKYUozbVNzRUJ3MnpiR1R1ZklNWFpsVnVGYkRoaDh5bWNxVlBld1Ux?=
 =?iso-2022-jp?B?OXFmNDNEekNzbEprUFlNNDBESG9WbGd6ajRtSmgwTkJPcUVMV0xNMlRU?=
 =?iso-2022-jp?B?RlR4blUwWUpkYWlFUmVmaktGWGNPTWxNVDlndkhEQW10aFcwU3lyUFhn?=
 =?iso-2022-jp?B?TGFpQXdjN0pCczhhbDZXVFUybm5hcjVOcURyTTJFU0JMUktYUldwdG4x?=
 =?iso-2022-jp?B?N0F5YlhYVEFrMGJTYWNJL1JwalVES1gybVdrcE11K01LSHhaNG1VTmdp?=
 =?iso-2022-jp?B?b3lWajFPdUpWalIvUk1SNGdZUlBVSThmRDlZL3oyT0JOczZob1ZScXNk?=
 =?iso-2022-jp?B?ZzlOanBxcU41MkNWT3ZIcldZa3FscXRhR29idDRUSmtyTG1pNS9PR0tQ?=
 =?iso-2022-jp?B?bFFra0V2WlpsaVpKampNQTRKNUx2T0ZOZ1dVV0tZT25EcXVRbW9PWng3?=
 =?iso-2022-jp?B?VE9LVlpNWDhpdElkS2VhS2EvK2RuNEZNRncrc0w0WngxRFJZQ3N4SjFP?=
 =?iso-2022-jp?B?NzJrM005RTFQVnA3QjRtajJRQVlKL0NzNERqMllhd1dxWVNETzdRT3dz?=
 =?iso-2022-jp?B?NURTQkZoeHh0ejVORnFMZTE2UFpDbVc1dWZidkVGc2Q5eFRodWQwc3VL?=
 =?iso-2022-jp?B?Vnl0eU5zRkEvMlN6VnErV0tGRExRVFllY29nOXBXTEdXZXBZSm16eWNB?=
 =?iso-2022-jp?B?YlJkTTBlZU5GQW1tZDhQOStPZDJOR1dPVGV2dWhEcmk5ZlA2MHV2M3pD?=
 =?iso-2022-jp?B?aDhSblhIVS91eUt6YnM1T3hoTjRKMUtjbTBlZ0J3VWNqclZtRG5BMmZt?=
 =?iso-2022-jp?B?QlplNnZDTmNqVFRINUtBcFBGa0pBNGFPM0pQQW5FSjY1RWQvVWEycktv?=
 =?iso-2022-jp?B?RDcxSUJNeTB5c0JDYXd5MElzczNJMHZ2MHQyQnNxbThNVXNCQ3ZjZjlM?=
 =?iso-2022-jp?B?VXYzMzZRbnFicmlPemF3YTB4WVdmTVk2b1g5azgzVDRodFZmWDBKUWdV?=
 =?iso-2022-jp?B?TmRJY0QxckpNUXFFUXFKcVQ4VW1rcEVHdWNnNlMyYjZJM2JpMWVQM2ww?=
 =?iso-2022-jp?B?M1FiMmQzd3VCeWRnRi9vUjRobjkrbTNidlhiSDEybGhaY0ZrQ25EcW5Q?=
 =?iso-2022-jp?B?YWRHeXIybmZkOUhjb3dibVU5SmJaN2Q3UFJRUGg5Y1JLL3RiYWsyMGFw?=
 =?iso-2022-jp?B?SDc1dm0zcVJLWi8vOHNpS3VOMFk5MVpFczlSWFkydnFEdlJVSFZwUkpy?=
 =?iso-2022-jp?B?M3NTZEVoZ291TitzbVBObUkrWkJDcENDUE1Vb1pNYThUUjZ1eE5WenJt?=
 =?iso-2022-jp?B?UFZYSHJaU3NxNGw2U3ZJNUFVdVR2OTQ3MXpHaktEcEtHUytONzRJWUI3?=
 =?iso-2022-jp?B?YW9sYTN1ZXBJTFRTY1VEWngxNEpMc3l4Q2ZQNnhDN0R1MEJSODYwdVhE?=
 =?iso-2022-jp?B?LzVabUZwOHFoSlpaZ0MvQmJqTmZSQ01Db0dwVmRpd1pFWUxoSlJVaXJQ?=
 =?iso-2022-jp?B?SDZRVzdpU1VCV2g1TVhIdTN2MjdCVDZHWE1OeEIvMFRjRmVGYXdJdUMy?=
 =?iso-2022-jp?B?SUhGT0VNQVZBMFRlbHZNem9aNUorQzkrOG5vV041R01xajQrdE1pVzZI?=
 =?iso-2022-jp?B?SmpOSUplZHBLNzlDUXJIdFdnYjVTQlhDQ3dkaHg2TG4xRGprajJYTDJI?=
 =?iso-2022-jp?B?amtDRlJZTFo2MXZXSjJ6bkhSWk5GWUlyeVdjbmJzTFZhUGdiOTlkaUsx?=
 =?iso-2022-jp?B?VEdIUTdhUURYczhQbG00SHFIdzA0c1Yrc21hV3hpdXVZdkhMUzFFcm5i?=
 =?iso-2022-jp?B?Y0lROE9TOCs5QmI0ZHovY1d6WnNURENCWDJVOGcwcnVNUlBWUC9iRUNJ?=
 =?iso-2022-jp?B?UzBrenUvZ3FqSjZmNkVUOEdOeHZxV2ltNmZZZk1na2swdWJVbnBTUzNa?=
 =?iso-2022-jp?B?RFNUcGtvSHh6R1JxV24wTVhqSjdQZlBTQm9qRld3WlFjUDB6ajY2TjI1?=
 =?iso-2022-jp?B?R2RWVDYvMXM5RkUvZ1FQbHROaHFVbHZWUS80ci9lMTNNSlhwQ0dEREZ1?=
 =?iso-2022-jp?B?MVAxUzQvcEtuTkxzR0lCQlYyZTVHTzJwUEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UND3EsdprpML+k8wi896lh3+ngf81ZTRmbZz7ykMh0o9b/1ZVKkDqLkmE9ow9dJxuPZr6xHe+Aa7vZHJofuxWAzIqxUreetm7elhaTrFmBeQCCG6+x766AjmyQXefDeP7iFbB71JfWU1kBavKo6jUFcEyNoPVCBSpKKj9m7P4jA3zHj/v9VygfEv4+gXCCLf6DWS+8C7F+14cIUe44zf74so9i8F4TRLBevqtdFN6wwrFiWUIX/jjsX8hc3s6jnwD7lLKNSKW+gXf9Gvm6jvb/e4Ab4KG3ZrfjHICvCDi1WaYpMOO6/Q/8C1Pa/7bSyjjC0G/s4Wt4iTjKWqjYV5OY5v5U6q5Covh6T93Zl19sb9LBFtCaPFd/TcrCLb7AwyIkPyKsDQB1O1/jzzZgFjHUSqcZ2cbY30Vzqye1R5WvRbzGDSf5BJhNLVvUyaY+GWbUI6149fS/UMnM20xe8rti7jtlfB0ZcORykE5/5WfQoJVGFpSiGdbmpwZWvLeXN4rXtFHdqfPCl35zvhNX1XafgvF5AKETTIBmSp7ZmMO6FF8UPS9hRsmDiY9tmKLI7n5JBNRnLE3HzKqq025dWqg1RfT2E1jP2zSf3eMkp3jdx66htm1ABM3ugTXUTFOprSgXOC/VY++Z399HoynFkUtUSYZUBOspssszLN17Lqg+ui1OT54y2Mpkujtj+pE12ZA/rnLZcj97NqtqjqkwgVd42+fmtcsrfrW5f+fwhvNSfrEk+wZLkhiXF0p1AXAVJpFGckw1O5Lc2vytoZ2cnphdU31LTN5XcYo5ViqjjWZA9CKc3bth7kflrROTtdcEc3jOju3mTPozmGB0b2Fk2gzEM/fzdhHhEx28QWQzmY//kdySxZK4AICk0qqrZz9+SM/oU4y7TI2H+0mQh6NNFVaQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9418.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c756d2-2db8-40ec-c4ac-08db6c6fdbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 00:39:48.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJyS8rX2DOsTIel4OFxocyovIKQhMM6D1UsMsogp3EkaEnchipbsAwOTVFT9CJn1ws+rKUQmlts6T7WEJn/pnY88oX2lEraKtvJDhY5xinsIdOi5GJ6t8fMgd/K3Lm99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 00:40:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11996

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, June 13, 2023 10:24 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip 0/7] RZ/V2M UART FIFO support
>=20
> This patch series aims to add UART fifo support for RZ/V2M EVK.
>=20
> All these patches are cherry-picked from the mainline.
>=20
> Biju Das (7):
>   serial: 8250_em: Simplify probe()
>   serial: 8250_em: Drop unused header file
>   serial: 8250_em: Add missing break statement
>   serial: 8250_em: Use devm_clk_get_enabled()
>   serial: 8250_em: Use pseudo offset for UART_FCR
>   serial: 8250_em: Add serial8250_em_{reg_update(),out_helper()}
>   arm64: dts: renesas: rzv2mevk2: Add uart0 pins
>=20
>  .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  11 ++
>  drivers/tty/serial/8250/8250_em.c             | 113
> ++++++++++++++----
>  2 files changed, 101 insertions(+), 23 deletions(-)
>=20
> --
> 2.25.1

I reviewed this series. Looks fine to me.
I can apply, if there are no other comments and issues.

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/89910=
4272
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro=09


