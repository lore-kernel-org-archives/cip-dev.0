Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94856EB8FAF
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 10:44:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.5465.1693997086673627684
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 03:44:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 386AiZaO3879857; Wed, 6 Sep 2023 19:44:35 +0900
X-Iguazu-Qid: 2rWgbWvRzzURUGgmyA
X-Iguazu-QSIG: v=2; s=0; t=1693997075; q=2rWgbWvRzzURUGgmyA; m=fdzBnGOzPyiABP+Xe8ZMpwTTaWLMlZ7z3pcNv3ADYAs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 386AiXbw952005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Sep 2023 19:44:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zyx4gvPj8Mmp1JlSq26CObaW2+NQnt7KfoogMqbef/Vp4WHogWdBxIOAaDF3aS7BYTt3ri93zMVvcvNQW79GCqDZ2a/m6+Hkq6T9FgFNKrgO9vXeXbUUMPjr7LF0cZEptMA2pUmMzHU/wkqV4Qe/O83CddfkRXLe5xbWbPQFVzF2RooC6FVmwzX/IxLsWt1bzPtWlhQ6RkEqb0cBj5EikpLQxX8CcfmPsmi4Vjs5CKAlDCDkXsw2qSU7rAZ2a/NwLE8rMFp18FJnYlIoyV5J+4M2Ws+McqNakY/mgN9cLIf6hOJVfIYLliDAkAVZIXunMxjDzeMNwFF8ZLZzn5eSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgzSUUVktNcSG6fxjHwWx0jeW5mMQVYfBYaiIHgl0go=;
 b=AIm7wIhRiZVCi/dJlDaHE/sn2X5KQA4SUva1eHwxG3yFPDeAgx/VqsQB36HHBvs2/RuMMNyNgepLSjY3TtjcnCjYEva2uYcRV6fF//kGTsKbPPqHYov+ZtSVL/Uig84Qzj1qLk3tkPHXVfuSvYqwRu3RjNLRqpz1s5skbKby3mFGr2XroRSE+7jf/SS8urzsp4JRBgevR3wnt17d56GSQCP5T53K/qb/XOjNLJrCu3RYbzD02rslt7Tb3j607A4LMAh1OFid6ToYgwyr1qW0YVjzX3vaLI6K+YVXDxxsG2SjGN1EVOajo9DGZ0J6yyRXF7T24Y+7F3dwyA4HhBQ6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/20] Add Renesas RZ/G2L DSI,VSP,FCP support
Thread-Topic: [PATCH 6.1.y-cip 00/20] Add Renesas RZ/G2L DSI,VSP,FCP support
Thread-Index: AQHZ4BMf1Np8XbUUSUetCyyaZtZ6ILANfWCAgAAf9XA=
Date: Wed, 6 Sep 2023 10:44:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420204038AA15EE4A27B69D92EFA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <ZPg8n16XTqWOXhMf@duo.ucw.cz>
In-Reply-To: <ZPg8n16XTqWOXhMf@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB10776:EE_
x-ms-office365-filtering-correlation-id: b91cd916-3db4-4d0f-ce60-08dbaec63fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fGPP6MGvjasvbHoGlf/iW6nKMfyKYrJ3AmiRA/i8dpTCDEzYM97ycWoWnn5kZA8ps5sjBeOlphu3/T57dqpy/oL+K594q3Iq1BCDKon5deIcxHWLDJnOIEnBm3DtqANGNYKrI/rqzEnW+A37dB4C67fgmWZcE0QgALVz6Kk7X+5bs68gnfWL8Gu2GF7NR9ONPMtQkLtaZlXaDqMSWy5yvX6ijkZSV+WYG4iqaG5HgqGufS0+SxXCkjQ/0K6Aewk7zJIL3UainuCzZtl8oACB6HFLCBWxHaB6umdo/cyRioByTF8EAwSMe2LvADG3+Xnum2BD9GsM3EbnCFHHqJzBnQ9rfTK1sAQ6HJ8jFSKbBjaKJ38TcAS175FLz68YdOZJwBGNFUi/UwdC115cFCjfS1My8MyucFuIasXXsEXu5vmpqZTkZgTe4VpvVmiBoTSgC6MqGLjgeiMOiC7kJLwpzDZ6LTr11mXCXEQroSoRsPAQX5+OQRobP7aeQr0+Rb3a8AFYVTeCvEY4pZpW5Upx5uOkgYnh8nDsk1lcfCT1HYLidLqPEbcR2w0Vy/E/UeMYyOpZKsf9/7O4B1QzY8huF22ZWesKWrsn9J9jsdKYhsxtTSRAa66J0r3ekCeV8KQYGCr0qLPoSgGOqzlWA/0eKQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(8676002)(8936002)(4326008)(83380400001)(52536014)(478600001)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(110136005)(64756008)(6506007)(7696005)(71200400001)(53546011)(9686003)(41300700001)(2906002)(4744005)(316002)(38070700005)(38100700002)(122000001)(5660300002)(55016003)(86362001)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UWJ1RFgxVWFKeU0yT3lRdTNtUXRnbkFiVlVNNUlUTTNPamJUU1RWcGd6?=
 =?iso-2022-jp?B?SDBoQlVxbzBWdXFGQ09XTmhMQmFzZnhWTUJVZ3lETkNPVWJlR3ZrMklD?=
 =?iso-2022-jp?B?cGtxVlp4eGFCSUNJRXRaSFBVaUM1STMrN1I0aHgxN2o5dEtQaUdxeWRS?=
 =?iso-2022-jp?B?M0VDWVNBVXpZamY1QnpYd3hybURlM0UvL0xxU3JJN0dpaWFyd1ZYTkJr?=
 =?iso-2022-jp?B?RW1xZ1pwbXNkTjlLc09Zc0t5eFJsNmtrWHlYT0k2cWNIYXJFS29TQ0ln?=
 =?iso-2022-jp?B?bDNJY1hOR1p2U08xdzZOL0dHSnBqNjc5YllocElGN0d0VHoxaHRMaW9t?=
 =?iso-2022-jp?B?K2U4cG8zNUtQc1B2bVFWbFcxb3pqcFJJakJ0bWFnQW1ORTZreW5FRjZM?=
 =?iso-2022-jp?B?SFBYS2J1ZmRSYnZUS3ZmRXIzVlhYcnF4cFQvN0dqUFdHNitQOGpwTGpa?=
 =?iso-2022-jp?B?TmhJalZycDZPNEN3NjJrUUc1eXVKUjZ2YkY0RjNMZFMvRGJNNS9SSHlE?=
 =?iso-2022-jp?B?MHkyS2I3OGw5QUl0WGJKS04raHNHY2szek83aTNhZ3oyVVhvMzV5UE0z?=
 =?iso-2022-jp?B?S1UrTFVibDdFaTRXclVsVTlpYXk0NUthZFIxdXkzRGg3TEI3Q1FXY1hO?=
 =?iso-2022-jp?B?dzhIa1U5RFNTdGJuVjdyNGx6dXNvL1N3VHZ5SEpIemZXajlqd1NnYklB?=
 =?iso-2022-jp?B?RGVVekt4M3VJZGN3WUZtd3VrL1VJYml0U0tzNGJPR3R1Q1JJVkRsRGph?=
 =?iso-2022-jp?B?MmV3QzBTR3VKYWIrK1NVbkh0RC95aVZqN25TaEQvbXoySnM2RWRyeGhC?=
 =?iso-2022-jp?B?TUt0NC8xY1pjRlAzaWxlUGU2MDRPNS83S0s1UUo1SlFyaDFoTWRzWnFY?=
 =?iso-2022-jp?B?MTl0U3JjUjZYOFlScGlLbzZFMEFKanRuZ3dkVVFrR1YvOVRnbmZ3OW55?=
 =?iso-2022-jp?B?UnBuVkY5WWdTMHlmd0NUbndlSjBQTU00eHA4b3QvZUJaTVYrdldrNm9y?=
 =?iso-2022-jp?B?L3ArUC9YdWdKWnJrRXN5V2ZIZWFyb09Yczk3TkRDWEQyN3VNS3hzT0pl?=
 =?iso-2022-jp?B?WmRNUUFGZFdPdjlUZmtNQ2RDSW02U3ZPd3Bhc2xIQmFCRDYxeFF3ZGtN?=
 =?iso-2022-jp?B?ek1kcWdmZkdweUhmYkpoTXZzTXJlM3VQMkRaMDVZSVAxQlRCRDcxeEFH?=
 =?iso-2022-jp?B?anFzaUFSNlZxL1Y3WTFFUEg4Nkx2RVJJdXRDcEJsNE5GQUFqaGR0MVBW?=
 =?iso-2022-jp?B?OU9DRXN6Zi9PWDBibDAxNXBlQW1JT2NVZkQ2eFRrei9KcXVvUG40U1Zh?=
 =?iso-2022-jp?B?emxMUUxKTk5PZFRCVTI3MDNEVmtKN3VwOVFabVFpTEpwMml1WGl5Vklp?=
 =?iso-2022-jp?B?cGlCeXVRZ1U0MDBUU3NpTHJRUEVyOVNkL0IwMXNBVDkyQ1VEZkNKNUxv?=
 =?iso-2022-jp?B?VFNQakJLbVhycE8wQ2VuRzFldTNaS2VoTmtWdE02WTBscmlIM0JydnN5?=
 =?iso-2022-jp?B?cWZISzdQMis4eFA3YlV0RmF1ZTU4Y3RtdE40a1VIdEFHRHA4azlNNFdV?=
 =?iso-2022-jp?B?VTBNemIybE9KMkx3RWdxRENpdjJCOUMzd3MrZkxTSFhuSG1zQllVcFBQ?=
 =?iso-2022-jp?B?aWVYam1qRU01cXhFNFQyOXhvNG5oK3pIai9IQ05uR0IxWWxBbHZvWjdZ?=
 =?iso-2022-jp?B?RytjeHdhdWtaeGxZRmhvRHVFTDRsSUlJTzlUK2pVMFZkOERtRFpQbjFK?=
 =?iso-2022-jp?B?SXhCdVlRVmtMN0gvT2s3TXJ5cGM2TGl3UUJWT1luWnM5YUxPNXNheW41?=
 =?iso-2022-jp?B?bE81eXZQb28yVUM1M085UTh3MXhUd3VWMEtOSnQ3SjBxVXZkZjNYYjA3?=
 =?iso-2022-jp?B?aStGbmFwNzZ6Nk9GNVhlaUplcUl4bnhlbERmM0NKV0xFWitYbHovNHBs?=
 =?iso-2022-jp?B?L1hINW9jb0hDK0RzNEhjbXVNZG4zb0F3eGJHQnNXTHlsZklsUytSbmxh?=
 =?iso-2022-jp?B?N1V6NENPaFZ1RHZGZTNwMktWelFUOENLS0g3YmZ3NUptTkRxdkN3cmkr?=
 =?iso-2022-jp?B?S2RyQnRwSnV1WUZxRHBOR0hHUTRseC92cFFLV2hKZ1owbVpuV0p1UGdS?=
 =?iso-2022-jp?B?b05pYnpxVXl2ZTFwMXFkTkpqSEFST1lmNjllZVRyY05JQlVoNlR1Q2tW?=
 =?iso-2022-jp?B?ZDFSU1RJMEFVRGxOQ0JYSWFuUzFQU0NCa2xPUFZnZ0l4cGpmQy9TUzZN?=
 =?iso-2022-jp?B?VWdVMEMzQ3RNcmJTaVNscjc2Qko4U2daUU9mZkxYVnI4OWI2N0piaVE0?=
 =?iso-2022-jp?B?NWI1aUlkRlI0MTRzSUNiUDV4N1d5ZnFaZ0lDeDdndWQ3Y2VLNVNITFRH?=
 =?iso-2022-jp?B?T1BLWTNLNzNVYnMvUlJDRDFQblE4ZGVTL2RxTGRDY0RxeERKVWt2SERr?=
 =?iso-2022-jp?B?RjFoMHJBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iJiFRPBUq3AUgXwoj7B0M9yYHislSpHuf1VFjHTAm/AXNOX1Zy4VlTcjVM6ni/egj7khIMJmqupoqka4fL7Vmq9OJ28UQb1DtGTvcRXj+wcnqRcmrqx3Yw7rpUDEAnG+/DKj/bZMcBTMh+5NzpH8pbURXXLJEY0h3CUot0SkKtahrPnT37jZauHDKFTRtZNdg06OR6r2YzMp6/0f6DeBVZqOeiVUlREZTi6QY69O8au+bDPj/E0d6qmYfeH2PB1A93x6JoE4qLDLKDIEbKnXco5UtC9wynAdrbVUTiiphl6DVN++mpJCKx8wvBuf5/Q4cV89ETJsChsR111Aek+7V/bTJEilB5Lzh+35JOaQo2+54vSignES7rMp7XMu5MSi9Odnve1DFNh3c9zVgZCmMqpsUr9FdO89+swfGNBRo/8ryw92TN9DVrCjeX6L/V4CNHJTnKTL+nly76CGYQs7xtLM5aC1v90/g21dPdkM7xtmLikZf9fWrAxiFjjBVBPS5s2VTF9NOXyC9tg9JtY8jknBa39b1wpvt/cFgVw73Eh5bvO+VQuLYuOarZoo9L2s6xNobVatGAJjdLrAF49HT8Fh6RTyDwz/kUlR92qvowvLzkzJNDuztNiLK8isnGym0MdB0yXOqw6pkzjZkMNe19MJdm7tNSjsXikPbAoCsn/0fmH5BSXjfsoBJP/WepriDQONi2k0prnruiF5Wrk0I5xK4F48aB3uJ/t79QwPaNSS2tqyI23ArMJdNDgMqA1HMaMhyanJuwRX3UjhzHqjQGpBG2pHQVmezmByGDFKq9nhH38yNrPbrOVbf/g/jDlvOFGaK93pgsTtHbcY5U63V75HNq8owdg8rjnRr1VF4DRQSDI6fwk2r67/Yy24Z8gL
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91cd916-3db4-4d0f-ce60-08dbaec63fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 10:44:30.3338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1AFVwLK2UVA19BmLnnHXT7wX+nKBrSHpj56ffll9wBE84aGwhnn3P3wkG+c/4zAz+h8A0om8k6UWM5eq/VlDW1lwyKlKtpTELiKNcAbdPsnpnDjueMQPzkvVc0YIDiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 10:44:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12986

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, September 6, 2023 5:47 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 00/20] Add Renesas RZ/G2L DSI,VSP,FCP
> support
>=20
> Hi!
>=20
> > This patch series aims to add RZ/G2L DSI,VSP,FCP support
> >
> > All the patches are cherry-picked from the mainline except the last
> > 6 patches.
>=20
> Thanks for the series. I only found tiny nits in the first 14 patches, an=
d they
> pass testing, so I can merge them if there are no other comments.
>=20

I reviewed this series, LGTM without last 6 patches.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



