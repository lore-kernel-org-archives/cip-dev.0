Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A9CCF9F2
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 00:24:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.702.1693959841710651712
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 17:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3860Npm11500384; Wed, 6 Sep 2023 09:23:51 +0900
X-Iguazu-Qid: 2rWg4AOIlFTJpAxZuy
X-Iguazu-QSIG: v=2; s=0; t=1693959831; q=2rWg4AOIlFTJpAxZuy; m=EMvWaqwvwu13i2cUBMUSw0LwATGp8MumXs4cM6wLzQQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 3860NnDd3198227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Sep 2023 09:23:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm+f2bYR21LN21jGVnGHlihSQRjxoAX2hpYHruCoXnQVmWrn0WNCEm05ZWL6ZcYGmUj6uI7bt58125tnlczPMde+VNxhv0Q4bSZWtrngcU8jsq7M9SZL9w/tWVavClBQ/avs2OBnq1Kt+By7yjtKEiLvciTfXZDc1N8Bxv1Z0IlCUn+rztLXJKexO5AWdt4NwrWAn5aJpikutxOl8SJtFP9TfhGc2BObb4RANssBX8R/h1HOnPl5o9vgKc5VhBJPcO/i08RhjVCGRE+3I3WLZZguLAkA23BA2+mnjMq89TgviX/iQTd1yjBtVMwFB5bZWuLXFqV15Yh+Hw2NTs9CFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/smzUKYL/ozRQ1qn+NykMc6DhhMYiTxOcC8U/TdYjI=;
 b=IHHLjXxQWKJH9QPsLaS3rt+8HTaCPprptgj4Vl1R2YiSWlwWg/ZF+Rau0hrqDN1pg35/kbXqRhxdjqNXfql4ZL0WU8SKN4i6ME3FZorOQvmtCKj9q8Y6e7RxfTzi9BZiPZiHyk7dd0L71bl1zfZdMOe6LM2X2OB0CLDOCPu9SN4OzLCZDjLR6gWC1sZYMGKgVQw3O5XTcHKxasFahfVoB/FesEbkM0yhFwXDC1h19pgcJauYjyeOrJ7ayvAYuXypty+SwGkf0WGS2fBU+hCacgM/NebQTGupCFSHooz+iZOVZ/dqh7JcIDqvO8kRQw+UC2QA/IrUI/y+MaFNqhFZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
Thread-Topic: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
Thread-Index: AQHZ4BM0YKB3L5egb0OYRnb4ah8VErAM6lhg
Date: Wed, 6 Sep 2023 00:23:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942095E6CB6A4BE1B9A5A87C92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-16-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230905160737.167877-16-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB8447:EE_
x-ms-office365-filtering-correlation-id: 0a423773-2536-4634-d6eb-08dbae6f8953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Hx4rWqu+GACTXU5Gl1vFY5RuRIyudt+g7zA41C9d0clmqG5f3rmlfR/AOCTYSO8hwB8+ZdSslp9WdDc2cjaMHo/zyBPXvBKdrVRdD45zmWj9OkiZKr9WC3L4V1jknnYkKmzRQI7FyzLVwuizr7Pgev+E5vOrV2FcmYpKdKTkSKJApYMQK6ctCwtkV1go8XIfWQwX5R5IMkAQ9j6Tco/s1fYWgOMVdEo+oC48Txo8d/47RiBKPCnDacYKaDe4WVmUrY8X8LrVItJU93Xu5VrNB/L0MFrG+mQgbZ5GolhdBGQlOlrY+vn2ni64gR3FJKaTI7d3s0ACkLLEaAJ0lsYUmsyL9fX+36PDPFcDZ51pscJRFvev8NZiTCw1eYDIX/+4DRdY72ku7F/EsyVsZPmk0alna4r0kUD+XU0LGGJ5iayvD7E0YEsEv+u92F2mJ2Vcm7Z6r4GstYo3xmYTNFMfKCrLq7vc2Z0vUB+E+ifB+q1wU6DYqO5KRcI52lFWwGnHtrXEKtd31QrJPk0UZ3Csatcfw5QgNPD56GBpD4zYsbco/eh+Awp4lxVeU9kOe7LopdV45LhvKQtEC+Xq+No+PpmoSA71CZHUyI/jpYQqK4W7mnwBrAVZKHyYcQmKXk7cihbGldzmA2ZYJZPhOIe0qA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(1800799009)(186009)(122000001)(9686003)(53546011)(71200400001)(6506007)(7696005)(33656002)(86362001)(55016003)(38100700002)(38070700005)(2906002)(83380400001)(478600001)(52536014)(110136005)(66946007)(316002)(8936002)(8676002)(5660300002)(4326008)(76116006)(41300700001)(66556008)(64756008)(66446008)(66476007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bENyaEJCQWFuMmVPc3lqenFSQTFibHphM29zZEdVaFNvUHV1NmowZ2xL?=
 =?iso-2022-jp?B?RnVTNlhFZUR5aVBuSngyOXRlV2gzVTQ4N0loSjRxdi84RmEvd2RiTEdx?=
 =?iso-2022-jp?B?V1hET1BjaVE2bTY0cTB0TjRaMkptVTRRVG9NV0hrMUlZYkRleGV4VmZ3?=
 =?iso-2022-jp?B?OFE3VUM0TXNtOHZ0blhXeDFiVFhNcHdvZ0xvTlpBQjZCc1ZxQ3dUWWFu?=
 =?iso-2022-jp?B?NEt4dkFQUk9LTDViUzZTVXhqWENCbVROMG9XbGRjYjIxY05kUEVyb08y?=
 =?iso-2022-jp?B?bjYyMklPRXJDdEFpTnRKRytpNDNwVVRWWG4zNHd3QVZVUzF0SU9ObWpr?=
 =?iso-2022-jp?B?blVMc1ZSdnpBd2d4M0diZ0QyVmZEdTBYWWNpTHpYc2U4QXl0eFY0Zjhz?=
 =?iso-2022-jp?B?OTF5Zm5WaDVUaWpRYmVhbzZnbFlWVVNMVkJybVRTanBieVJYSFFBakNU?=
 =?iso-2022-jp?B?c3FaZ2E3R282NkVwUWs0UGxzcHY3amRmUldYS3NOVFNVbmF6YTBSMVJL?=
 =?iso-2022-jp?B?bTZJVEJ0MDBxa0ZNN09OcnczVVlUbzd2RjlKWG1hb3FxcTlxc0RXeXJj?=
 =?iso-2022-jp?B?NVpUR0wxWkh4VEdKMFlRT3RNZmNnN1BkUTZ3cDBXaGQyaEpWclp5Qkpl?=
 =?iso-2022-jp?B?cWRpeVhIcmNGR2JMSG1mZjBHVjRjd1JJQWlQZml6aUZqRDY1Zys3RktK?=
 =?iso-2022-jp?B?c1dKMDN6ZmwySWY1TmpHVXdJVWpxRzVZUXYybURubVZvcjlRUENGQVZM?=
 =?iso-2022-jp?B?OGd3N29ONmhhcGZ6M3FYSW9zL2Y1WXp4Uzk4OFcrVEZSMWRrQjBVQ3RD?=
 =?iso-2022-jp?B?em0wVURWbmRCWGlGWjk3eHRhNkxmekFRSlA1Yjg0dG9NVW5NcEc3ZUFm?=
 =?iso-2022-jp?B?alJPVy9TazFEWWQyOVdkZHNndzhrVGFpVDU4ZnBqSU9vSEtiNmN5dFRu?=
 =?iso-2022-jp?B?ODdsNXVLajdMbUtxVWpnVWx3ZC9WdXBIMXpOSkM4RG5pZUFRb2ZsV1FB?=
 =?iso-2022-jp?B?aHExRmIrRENEeTVWMkJUMVRndWZFaTh6bDE4V3hHOGQ2UVk1NmFRZ2Fx?=
 =?iso-2022-jp?B?Ymk2Z3l5QzBFVEM2aWtOeEhiT1FGUkMyWjIwZU1GZnlIQWlGWUd2SVNS?=
 =?iso-2022-jp?B?VU93c0NObTBHdVhEczdabUNGTVFXT3hxbjZENnVra0JEQi9wdVlPb0Vp?=
 =?iso-2022-jp?B?czJWWGJ3N3FzeXVGY0EwL2ZTOGhGdERIOVpsZFZPK0hUc0tWQlQrZlB4?=
 =?iso-2022-jp?B?NE5qMzVieFAwcjdoUlhpR0U2NnRaSU4rL2V3NVY4MldHOFNYYWVtNm4w?=
 =?iso-2022-jp?B?WkF1Vkg2TjZmaEIrR3lDYmpyK1Z0Zm9VMUVibmNRZGpNZTZLUXhxdi9L?=
 =?iso-2022-jp?B?MWlOcGlUMjFoeDdINHpiaDNVOWU0UFhvampHNnJEQlN2Y0I0cmJiWVhI?=
 =?iso-2022-jp?B?M2VkbjMxbFduTEl5aWs3dERpOEs5NVFTdnN6Y2hZZEt2NVk1ZDhhVFg2?=
 =?iso-2022-jp?B?Z0xMVmttRmovRDllNnNnaUFHMCs4bG9sMGZuUWg0Tm8vYmcralRkRi9S?=
 =?iso-2022-jp?B?K0lLRWkza3BzLzhZWjhMVzV5ck9qY20wdFNPNmJTL3Z2aHlHWDh2anZw?=
 =?iso-2022-jp?B?b0lkVlJVRStUY01uKzJDMmNseGcwV0s1eS9NZXpoWnJ2SXNjLzN5UTFV?=
 =?iso-2022-jp?B?by9sRDFQQ0lub3hUdWpHaHpwVUNORFBxWXh2NmxtRy8vdnVaYzRIR2dY?=
 =?iso-2022-jp?B?TVFyY1l0dzlMQXNFMlJLdXMySXBsSDlzeTdPNE1GSUZudXpEdUZhbThF?=
 =?iso-2022-jp?B?TGc5OGM5aWY3SWF5blBjaG9SeVVVMjM0b0tYWGwxcWNFRmVzejc4dXRv?=
 =?iso-2022-jp?B?UHZNa0dyZCtSZjc5VkE3ZlhaNGRDNWJiVVUramxINW5VZ3g4b1VsSk1j?=
 =?iso-2022-jp?B?TFZmZFBZNnhkVHhYM0dvWitpWG95M2hUNXFQNUNyaUwxM3hoU3JIdzg5?=
 =?iso-2022-jp?B?a0hIVkc2ZFJiT2xuVEFoWmFEaTdrOFAwOStBNm9Eb2VVdDhPbFBUdjlP?=
 =?iso-2022-jp?B?eDRvVythckpZTUk3cWsrSC9TYTJPK2NQL3YxM1l3U2NIOVpIdTNBUjhF?=
 =?iso-2022-jp?B?aFE3NXp2WDBaalgvNDB6R2NBVWY0MzQ3bjRQWk1pOTluQ3VXQ0R0RUc3?=
 =?iso-2022-jp?B?MnljckxlTXVkVHJpMGhSVGRaSmFBMGVRa1Ryd1JCNXl2TVV1aWlOcVVK?=
 =?iso-2022-jp?B?MmdhbFRma0I3enltSTE1cnBVazJvYytFME1LSU9XbTFKU2dkNjU0Q2xW?=
 =?iso-2022-jp?B?ZFFUYXhBci9ITk50OU9CeldOT1N0QnJaeStselUxVG1UTnlRR0loNDJp?=
 =?iso-2022-jp?B?V2VSYzR6clpQRUt0YTJSNlZBVVhMN1VXOG04aWMxbmNaMkRML1JjUWc2?=
 =?iso-2022-jp?B?VThSQlp3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BdxjncIN5jDmUeXH6lefKkJD4gEB0I0eDxQHuzL/1lsY1JhRedFj6w7KBBHtQx8PTYXgwwYLQJMgWNvgmZhjzKIH+mkmXbjENt4on8qkmuEf2KjVjhfFOGHCr6aUAlHrZRVkfJB9R/5rYvI68TuJbPvRWuxThFhFDG9HkDhfsB6xuWSQZnQW9fbc+555RTM6KgrModi1T1weeE+cnAi2vUS4u+hGLQpUbjer8nc9sZyOSrfIOAJcaADvW8nBj9vzn7EyMdJjDtwapT7KcbXHCTQ4tbSnNe9XrvszomxvdbG6bSwHn8jgYi/xAoqI8Dy+u6sixp8ZxfeBuWDWdz0cLy6nBuCuK9m1EbkeRdo1HqiVcV7yEtRZAu9/eHQSPL8KCUDAj366j6GASV1US1OKXs/XzpT865o9LrpQmHk6pX097DzF2irHKWytPMptvmEWUQSiq0rip7Kb3RU6+dlfqyVM3Cp/yt6VzR4IXTtwWe865AtWurn72QBK5mFn4JL2pk1r3u9m47R6h4hmdhjeFHWEWtDIt6hETyYdgFlYnlvwNR26kvO6zKhs8PVcEHdA4MCNZ7o1wwmIgp1QPWPL8eSsVbUbphDNOmESQfYOBtImgD3OviwEj6aeORWyQ+wIKfX6JgyH7QszLyp1b32Gm1oG7nNwILOTrzX2YvohURRRJKWvBYUd8oXagrrLIF8r4SFmG+pH1feaELB0knCwkFoAGPKYgHMHD+0FyoE+N16gJPEV0/5+dS5P5XROeb5k8b6rba0AExwsOeLUPYhhZAX7CnUTIJFmQT4KA60mTnTBjGE72doaHZOtQpjcNCJkjpSVaL5ewMmtMp8YFyj6DgxgSIwWsZGAB6YOj529lcZ/GErjyqAxvKMy/CU8z77s
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a423773-2536-4634-d6eb-08dbae6f8953
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 00:23:47.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb1ixzh6oKkRX6V7Mco82EsO4r3+06x6BIirRWqJUqfG4mHGvEVk05ycWRDe1ZKAcsW3qeUkfoK2VSCY6dBJJVwKchDTC920AvuIWGvEDN3bSOt2+qkt46b5KCGGHtVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 00:24:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12969

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, September 6, 2023 1:08 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 15/20] drm: renesas: Add RZ/G2L DU Support
>=20
> The LCD controller is composed of Frame Compression Processor (FCPVD),
> Video Signal Processor (VSPD), and Display Unit (DU).
>=20
> It has DPI/DSI interfaces and supports a maximum resolution of 1080p
> along with 2 RPFs to support the blending of two picture layers and
> raster operations (ROPs).
>=20
> The DU module is connected to VSPD. Add RZ/G2L DU support for RZ/G2L
> alike SoCs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

You forgot to add the original commit ID and Signed-off.
And I could not find this patch in upstream tree. Probably any patch after =
this one has the same problem.

> ---
>  drivers/gpu/drm/Kconfig                  |   2 +
>  drivers/gpu/drm/Makefile                 |   1 +
>  drivers/gpu/drm/rz-du/Kconfig            |  12 +
>  drivers/gpu/drm/rz-du/Makefile           |   8 +
>  drivers/gpu/drm/rz-du/rzg2l_du_crtc.c    | 599
> +++++++++++++++++++
>  drivers/gpu/drm/rz-du/rzg2l_du_crtc.h    |  92 +++
>  drivers/gpu/drm/rz-du/rzg2l_du_drv.c     | 185 ++++++
>  drivers/gpu/drm/rz-du/rzg2l_du_drv.h     |  84 +++
>  drivers/gpu/drm/rz-du/rzg2l_du_encoder.c | 109 ++++
>  drivers/gpu/drm/rz-du/rzg2l_du_encoder.h |  32 +
>  drivers/gpu/drm/rz-du/rzg2l_du_kms.c     | 711
> +++++++++++++++++++++++
>  drivers/gpu/drm/rz-du/rzg2l_du_kms.h     |  43 ++
>  drivers/gpu/drm/rz-du/rzg2l_du_regs.h    |  67 +++
>  drivers/gpu/drm/rz-du/rzg2l_du_vsp.c     | 469 +++++++++++++++
>  drivers/gpu/drm/rz-du/rzg2l_du_vsp.h     |  97 ++++
>  15 files changed, 2511 insertions(+)
>  create mode 100644 drivers/gpu/drm/rz-du/Kconfig
>  create mode 100644 drivers/gpu/drm/rz-du/Makefile
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.c
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_crtc.h
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.c
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_drv.h
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.c
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_encoder.h
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.c
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_kms.h
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_regs.h
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.c
>  create mode 100644 drivers/gpu/drm/rz-du/rzg2l_du_vsp.h
>=20

<snip>

> --
> + * Initialization
> + */
> +
> +int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
> +{
> +	struct rzg2l_du_crtc *rcrtc =3D &rcdu->crtcs[0];
> +	struct drm_crtc *crtc =3D &rcrtc->crtc;
> +	struct drm_plane *primary;
> +	int ret;
> +
> +	rcrtc->rstc =3D devm_reset_control_get_shared(rcdu->dev, NULL);
> +	if (IS_ERR(rcrtc->rstc)) {
> +		dev_err(rcdu->dev, "can't get cpg reset\n");
> +		return PTR_ERR(rcrtc->rstc);
> +	}
> +
> +	rcrtc->rzg2l_clocks.aclk =3D devm_clk_get(rcdu->dev, "aclk");
> +	if (IS_ERR(rcrtc->rzg2l_clocks.aclk)) {
> +		dev_err(rcdu->dev, "no axi clock for DU\n");
> +		return PTR_ERR(rcrtc->rzg2l_clocks.aclk);
> +	}
> +
> +	rcrtc->rzg2l_clocks.pclk =3D devm_clk_get(rcdu->dev, "pclk");
> +	if (IS_ERR(rcrtc->rzg2l_clocks.pclk)) {
> +		dev_err(rcdu->dev, "no peripheral clock for DU\n");
> +		return PTR_ERR(rcrtc->rzg2l_clocks.pclk);
> +	}
> +
> +	rcrtc->rzg2l_clocks.dclk =3D devm_clk_get(rcdu->dev, "vclk");
> +	if (IS_ERR(rcrtc->rzg2l_clocks.dclk)) {
> +		dev_err(rcdu->dev, "no video clock for DU\n");
> +		return PTR_ERR(rcrtc->rzg2l_clocks.dclk);
> +	}
> +
> +	init_waitqueue_head(&rcrtc->flip_wait);
> +	rcrtc->dev =3D rcdu;
> +
> +	primary =3D &rcrtc->vsp->planes[rcrtc->vsp_pipe].plane;
> +
> +	ret =3D drm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
> +					&crtc_funcs_rz, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
> +
> +	rzg2l_du_crtc_crc_init(rcrtc);

Will this work correctly if rzg2l_du_crtc_crc_init fails?
It looks like the error in rzg2l_du_crtc_crc_init cannot be caught.

> +
> +	return 0;
> +}


Best regards,
  Nobuhiro


