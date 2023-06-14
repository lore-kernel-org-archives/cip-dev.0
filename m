Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF1EB64D7
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 00:41:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.758.1686703252362806160
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 17:40:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 35E0egOI018908; Wed, 14 Jun 2023 09:40:42 +0900
X-Iguazu-Qid: 2wHHnX26Cwwae3JXzZ
X-Iguazu-QSIG: v=2; s=0; t=1686703242; q=2wHHnX26Cwwae3JXzZ; m=l68NZRpLzxVi1jQ94XlfRJ8/xZFIsyc9N3VFKGgQRp0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 35E0ef8h022295
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jun 2023 09:40:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4l3R8DpneKUhQQwA+hFlbqk751nF/FBIzzXeqp+K+zEHRACxPwW8KL55wj8pNDgQxVAJSn3gBcgy2CVp8vVhmRLuRK5wNAlbt/jII7FcuVMtN9YMcuPf+cCN2pHSAn3C5zRCbBptDhec83pUhE4OiDt1icV8NcC3qD0jWEeKMORsNsptQXeBK2/XiPuBCteTkIgkBsFmjMkmXL0rxHfTuLCzq5DMH/FjCfvhL9AKyPmeGCs2NkX9GI9lUzQvEJS2jZJ+S6jyiPbGBDpvMZxRk4ngzDVSkVbt//T64mKGLVJsQ5rqmqGHv9H5Tr2fG0Xt4mLNmCsuRSrPcVgXSCDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+HJYBAgK/dVVQ/5mn21Hpx6GSyF4yDv7R/siM8Xhvg=;
 b=TgzsF9Y+5iHwMU4RO1NuJfTnflGf5NufpPwl3PnLxLYKCk+G5p4TuSBFnH/w+0nyOqj1AVZeB2qjD/3wmOwK+yfeTYiH/OD0SF96mGuWLoMEsNLTtDVt1A7w9SufGdLEIfKwOO4/AHYdU4/bQRjbORjcNskfLX8VXfbqyslrm+ohauQald3Dm2Dr0TFTPY7+NWMoar9Aj5A66ojSg81QIOSIktvnKtkUwBsCd5xkiSIjlQ0BCh4/dba+rkMa74wWZcEdntLu3Pk2Gnlw/Utd4T9X8NM0f0PYwRA8vQe2zsk36rVXPhTWNt91eG2rZAM5s1ciXHV8+mATj0kFfhigwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/7] RZ/V2M UART FIFO support
Thread-Topic: [PATCH 6.1.y-cip 0/7] RZ/V2M UART FIFO support
Thread-Index: AQHZnfqslGGkmsfu8UOmtgRwQtGB/a+JdYqg
Date: Wed, 14 Jun 2023 00:40:38 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9418B4EB28AF68095D5979B7925AA@TYCPR01MB9418.jpnprd01.prod.outlook.com>
References: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9418:EE_|OS3PR01MB10248:EE_
x-ms-office365-filtering-correlation-id: 76794d5e-0f5e-479d-3d97-08db6c6ff9a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3xxMcb/fkmCSeAwsSsEY3SLJ+fnL/lPr6WUPbsI61mzxknFRVCCSjmOWGcWtW53DpA+Un1VvAMm0bGzOwAx1rmZHTDQCmoxjHDwAa2o6WZi2q5FCuwGh76eLIxiBlPsmbAbC00mu38G22qkrvoX1EycrkPpcgWZ2YE0ek+r+x1KvFWeyhF/YOWg2MV8gur9gDKGiSJvTcBCZcpj/xyIT6YVMY7rQGWLYYXhnDap2z5xexzX0+NYdsBu/CMPr8C9sDgar7WxPOefltq9pnf70oC6pT0s98MH1nwqXH/rBFOcs6/wzW6L7mmR4u4/LQ8HLao+OhtZ+My6aUa3bRZ8gB761BwpF3uS2RGJF+IsMCctj7a+/4gDOEXbTa2pk/QGG48rRtPLEphUEIA8jhynKe398agQXzS4cCtLNLXPXmFPyWhLKy+P1ElYOxUnZVdV+v/GFOXlMw0ZQXPewz+hfcfKoGnYqphPI6siMKsWAQKo1I06Ah0QWwt540hiVbczace9nruiUtyf3p3OoZ4TxrFtA1ZCQrMDWdG4NYAN0Wzzn4dsOjZ7ygjyahvE9bKEK3d85BzZsucEmmSnx0uzkkGs2L4ru215qtFN7EjydEjl9BPQuWMnIda+NxUrvVGeIyFW3HHb7kg/pWaSNCGsnUw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9418.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(966005)(316002)(7696005)(41300700001)(2906002)(83380400001)(86362001)(26005)(6506007)(9686003)(186003)(33656002)(38070700005)(122000001)(38100700002)(53546011)(55016003)(52536014)(5660300002)(8936002)(8676002)(64756008)(66946007)(76116006)(66556008)(66446008)(54906003)(110136005)(71200400001)(478600001)(4326008)(66476007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U3BDR2FRblZ5M3BkYWRVSHBCYXhPNTVITnBFRmxjVGQwVjV3YThpV3hE?=
 =?iso-2022-jp?B?cmlUOWM0YUlhelczV0t2NTBaMk9wWjl5TUhxQTA3cGEwYkVtTngrOGNE?=
 =?iso-2022-jp?B?c0VTTkhiOUxyWDY1S2dOVUZmVTlYZlU1bGFORkYzc29wSDY1SFV4ZFdJ?=
 =?iso-2022-jp?B?MGNZSmhocUhnTTBDYjJpd3h6THIzK3EwVjFBcDJnMnBmbzNGOXk3Y1BW?=
 =?iso-2022-jp?B?ajlsUEMreUc2alZvakJ3S3VKQWltOGdRTDN5NGhaTFlKV2ROVmJYMWRu?=
 =?iso-2022-jp?B?T3B5amJaOGNRTlRzL3JYNUpEL0ZaR1dPcm5rQitLeGt6bHFDVU5WU3pW?=
 =?iso-2022-jp?B?bjN1RkE0ZEs0eUY2ZWF5ejJkMUxyR3pBMnRaSCtNOTUrVUlTWVhGd1lr?=
 =?iso-2022-jp?B?ZXR0d1Z5WE04M2RQeUpPbFNsaDdSaU41emE4OTdRWm9SR0VLaXNMb3dC?=
 =?iso-2022-jp?B?YzJrNHFjSFp3NTJvZDBGSVU4MTdwWHhIaGNQcTBlYUxlOS9NenJJeXJB?=
 =?iso-2022-jp?B?Z3F5M2YvRlozb04vd29IOU9oUEVwS0J5dDVZaWJkUVd3SGQwVGV0dk12?=
 =?iso-2022-jp?B?UndDY2taUCtheG01cWE0TS9QYXRieXJ6UXdNRkNSQzlBRm05MENvUWJr?=
 =?iso-2022-jp?B?QXNJaEUzMC8rTWlXRWZ6SVlTNW11UktjOWllM29FWEovMFNDeUdYcWx5?=
 =?iso-2022-jp?B?VFMya0VrV1VTaVlZb3lySEVqOXcrY2ZETytqeThYdC9Gc0sva3dlNEFT?=
 =?iso-2022-jp?B?QzkvVWlLaXNWcDh0MW13OE9pN3dDaHRTRURITTltMUZEUHlVUFhpeTds?=
 =?iso-2022-jp?B?eW5yNDdjWjkveWxNSHc0MysyRkxJSlhMdnl6enNUK0ZyMUpiRTd1Y1Ni?=
 =?iso-2022-jp?B?aUtibmlxR1pyZW1Jd0psWXBjOUZqOXo5RjJHTXA2b0wxaE1wdWR1T1B4?=
 =?iso-2022-jp?B?dmx3QUVWZEZESExMUHoxSG1KaU0zRk00R0xReGlHSE5heWl6WEVmRUxj?=
 =?iso-2022-jp?B?NlphZEN0bzBtMUZBNW9WcUdiM0tnbHppdEQvOFFFaUp5dUVhWmxlN2c2?=
 =?iso-2022-jp?B?MnJxQnVkMVJBTW5RY0tEdE1IOXZSMHlnOXNCSlV3Y3VzTjVUd0RpZTZn?=
 =?iso-2022-jp?B?aVdGbjVjcTZyK2NZKzFSRldBVUFYNlArNi9yL2Z3ZDZNTE9VNWtCVmFo?=
 =?iso-2022-jp?B?RXNBSzJucmJOZkdjVzRGSVhSQS9ETVNRQ0hEdEJlS3lCT05PUmVjR3Nl?=
 =?iso-2022-jp?B?MzlhSzJ1Vi80eXNrTGcyY2ZDeEorVVJMQlp1YTdKNVVIdkxybjZLcnhv?=
 =?iso-2022-jp?B?M21vMTlQSWFhaDAxelpWNDVtbjZSOGlENGNFY0djcUV1TWp0b2xMdVNT?=
 =?iso-2022-jp?B?S1BGb2NRRGY0cUdHbElMWlJVaUd0VDJaa1dWUGxES1pQUWo3S2E3QWlW?=
 =?iso-2022-jp?B?UjVMUmRjVDJycEpUSTZLMVBxa3YzN29NYkVaVHNjcHI2eHJGNy9ZOStE?=
 =?iso-2022-jp?B?M0tJaFZVbVJLY2FuTHp3bG5lZjVmNWZsZThrTlRnNlF1NHZrVVgzaGds?=
 =?iso-2022-jp?B?bG51dzM1b0NlSjBWUHlKTXJjY1c1SUVrbDYvalZlUnA5b25kSm9PRmVF?=
 =?iso-2022-jp?B?UlRQODBDME52SEtMckFBVGZmbzg3bjlydUx1SWEwNmZiNEt3M0x3YWxC?=
 =?iso-2022-jp?B?MlNtY0N3S0JIN3hyZTYxVUxJZGYvVFpoaDJ5aTNwdmRMaHpuNjVZV3h3?=
 =?iso-2022-jp?B?SEp4V2hlUENrUFhFNU1WUDFSaXZ5RnN3SDM1SGx2UXRGbmRjT2NoRzlI?=
 =?iso-2022-jp?B?TUVQRTlVYzNpbzRFZE8zbTQwdE9XRnF4VzNCWTBkdmJNczllYTVQUzJh?=
 =?iso-2022-jp?B?RXZBRHhpV1VRRjJQeE13bjlFVU1SYmsrRmRsWU1YVnRtSjBPT0plcGwv?=
 =?iso-2022-jp?B?VmdpN3Y1V0JVYkxJV2xXZ0U1dVdpb2xUTFc4OEtQUmYzZmZoMWR0N2VF?=
 =?iso-2022-jp?B?bk80R05GaU5SeG9FNUhzdTl0U2tTUVpnb0lFMi81SVpjYjN1V3Qrb1Zj?=
 =?iso-2022-jp?B?VEgzR0oxQi83bnhMQWFVQTA3VFhWQUgzemxlOGJXVjZzYmFyYUhHcTFY?=
 =?iso-2022-jp?B?bHZRUVZya1BaelN0bVljQlhaQnN6clRwNmg1TGxjRnRjNzZYQkVLV3g0?=
 =?iso-2022-jp?B?T0RhNWZ0K0czZWtCT1RCZzJXSGxGZlgrUDgyNFM4cSt6U0RRTXVFQVE0?=
 =?iso-2022-jp?B?dlpFczIyTEVwcjVBNkgwdlUxNzhVeGpPcjVaSTMyWUY4bWlxb1FCQ0Nt?=
 =?iso-2022-jp?B?ZTZhRCtBejk1Q1A1aXNrMDIvSzBVWW1xa2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Db9jEzTp05lX7I+0ByeYkQcMyhBsRXJOt2YrxuB7/RnBVy5ejP+tJyevGYDtD5MbGr9T7vtfmR4cPN/1s5ta00VjHpBDJ31adgdD7qAU0CC6PxMwlXqzyx57hYOF4h223fX/gIEDSLWs2CAIcYrkKs8r5961RLwCsokjCEKjeqjs25BTU78A6J1pZKGzCFIp6h9QYEKQzVjMW7h6adnMiL6W7703pnO0bc8oIbIEbStTvrW6rtukNy4TFo7ioVdB4Q8tCfIOXPPX5IPZ4OVwcuUwk8CofXUM2xZVbrsfxOQ2rIiTCZ69VTaw/8F6VfR6GDSSW2EBdbqH+b6GBk8Pp9rC2I9tNIyJgf/aGJG90zKoFizI09rSH4TqJGaPLKjgDOVEhXGhiJjZek4LUneDojuO9B/gmVMqu5SxPCjYcjexC7L2sLIvCCWSm7pjrdtVNFZAC4KPyduyupka0EaIl3fDDqsoU3dAjz0AXVDJBuxXg6U8OHe+Kb1kVvvQEge/fS/rNlBOWua344acJ6Qh8TWkBMEFiLT2y2S5JTT9vbVFJxQWME+/pRy4cw2gAR1Y/8e5rFQQbC6AEz1x2R8QIaM5Npo8qnRiHoATCSoR15aGAac0Js+MDLlAXE7og+1BEOiHBctzYlT+W/Y+grS+SMjbPAphsDQuI5FqRDZq2uGvm9o6VXb+KJ+j4DJghi9HwoGVRz1+/JwnY7V2tdQQFzOxKeDSZqiIABZzkMVb890/I351NTJDBG+TAhhX6gpASzhYKgBwPCy8s0lleDGtXXaqj+ZirsGXs0+yedCrJtuaoH2qHh0Y1hXqB8BDEJDeuowTJ0zsk+2NwXaIwJC+mJxHyMQ7OjEasV1Borfyz4Tn8EfGPgisyPYNEap6Apzzqj30Kzf89WDY45zjJXZ9KQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9418.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76794d5e-0f5e-479d-3d97-08db6c6ff9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 00:40:38.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBxBB6v9DH4iaQYLiMKXksT3XDqzps0j0DqdohgpnVc8LSr3Rv6OIyVG8HidcWi32OWH7g8/R0xl+A4CtUkoQoX3/hBg9VFm6EKzHg9JZXqwiDZx9enMVazx96MnwI+V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 00:41:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11997

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, June 13, 2023 10:26 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 6.1.y-cip 0/7] RZ/V2M UART FIFO support
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
3569
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


