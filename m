Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDDBEB64DA
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 01:18:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.11687.1688606320130162005
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 18:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3661IT9H4088920; Thu, 6 Jul 2023 10:18:29 +0900
X-Iguazu-Qid: 2rWhi9UHc0xoLVf0GO
X-Iguazu-QSIG: v=2; s=0; t=1688606309; q=2rWhi9UHc0xoLVf0GO; m=pfYyhGzMlT4ofNSenODAzP0G5UNpPTiavOJk8PwLdaM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 3661IRmK2518714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Jul 2023 10:18:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbRQc1zfRVEEa1rWwvG6XGhFaJ7do4vSGqIX6Q02xuj+B4XY2RqogwVUxYU1NYPkTYxz48CGHuWeDsBWbUM/Y5Nmgg8wUQFo0jFaayPV8b5OcuJ8Hna9VU3FDoFLb1Ea9PV55yD3o8j7fCZw7+56l39NT4xX42ogqwXsx/kMn6qCJx9CZfTgeQN+Aq3AV1UF5yfAx3d/ZvTed2hrPt0P/YkCJWH+pzwm/6BKZNDTA1LxSQCe/z2j69frp+i6LaTRFXklyFh/hEaiv2Oeb7I4tOlUPOncNqwebGiKOEhSiSHmmd3MVGcg0Lq6CoxbjPnL5CWuXNSGHRwQawX5R6eoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x88/oVI0ui03sQvAKxcvg4zrQq7gxzCnf3zUE/lbsLo=;
 b=XXcE0VeWpySzy6aAuYoJv93YCWfsrB2QylMmjpq9yhbjb5E8A4gRGmglNf+u8gMiY5O85gkleSK3vLzZCMPRMWmuOUkgCfymHIzHxGqvLlBn7H+0SbnbKSw9xVhyI3L5PPj/8SwbcubMaGr6JFnaohXfZA8Lnrpsl4mZ+kdWfLfDKp73xwGgxTMRKxeO+kYQYTB7P7Q4JR3CwQXNpu118cnpX1IOq/7mTaaq0JxuEzdEMJu1OCbjY2raJdnsdg9RbiEG93AcgyFmdFcMiavcGcKT2QCoDgs0vv/NQoxV8Nh14GmApdv7fus7fUZREA1681DENSHxoi1YXEhhLX96Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <fabrizio.castro.jz@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Thread-Topic: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Thread-Index: AQHZrdIvwzFkWROBpU6Hu8sA/RB8YK+r65ww
Date: Thu, 6 Jul 2023 01:18:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420D58265BF325B0FB9F9A8922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSRPR01MB11857:EE_
x-ms-office365-filtering-correlation-id: f12602f8-1b6a-4813-ccf3-08db7dbee5d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ms+syn7MhoEU5bJ797qSA3XTXz+5xr66dDU1UQNQFVuYO2+JvOonayFOopoOQhFDhimEk2subWFzoWPOim/tta9rteOIVcNC4rxEnPtxiMlcO8c4ecBI7YAc74EvbNCSrD/QL161UGQhtjwt3UM9xnsbprngODeQpgh2rbfI2nT79rOtT+LF6MWLy3vJEHR9gSgVOA9KweMW4Kcb6aV8NdShYiPceKTh8XyzkJ66ZibbJjCrzhXXuX5vyB9Kmd7ZRxvD++Lzzu1CMs2njHDhRzlH2KYzjrcKTA+cxokUlRk9KRplpjGEea61qzKf0BDyacozK6sPOLXLeOZqE9Uh4G3vJ350C7CgnLJKnnq9bGxjFLmeRgCvPLq47kCkYj/yrOi6ppVVxSZLU4bXiC/VqlhnAcdF4bW1FlRjFEwAZyNrTr/TU23f2VHdOijontBiuBZKBcGjD0xQeyctkdgK9cPDp4jTyhCHmjdykTEyiExxBVnJnADRqt0Xt7IutXtdzR7OCdp3gG8P8EJNOdV8xjPT45GJdm0BiwDqD2qatK6xX/kcMNvllIASMjJ5leb0pHoefRpvNWH/AwCTSYDZXPzL5cRuEAyM8FIc/IxJl0BxQT5LTgrIQTLy7K/gZ2dj
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(38070700005)(38100700002)(186003)(122000001)(53546011)(55016003)(83380400001)(6506007)(52536014)(41300700001)(33656002)(8676002)(5660300002)(8936002)(66476007)(2906002)(7696005)(86362001)(66556008)(66946007)(966005)(9686003)(76116006)(66446008)(478600001)(316002)(64756008)(4326008)(71200400001)(54906003)(26005)(110136005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TGswSW9MenF4Q240c0RBbWFXeExWU09qeW9IUkFzWTFIRm1CeHljTURB?=
 =?iso-2022-jp?B?dlVrUnFJckIycU12Q29Qd1RYOEtac3hkRTZUa2p0SkR5SHYyb1dEZ2tO?=
 =?iso-2022-jp?B?ZzlGbFVqaWM3cTM0OG9HcEs0K01yaDAyd2pQQ3FVZ1p6QXY1aGNmRmVr?=
 =?iso-2022-jp?B?ZjZxelN0cVJ6UFV2RTJJdVdTQkE3YjBrR2lLSTYrcmtLQmNMUWwzY0NM?=
 =?iso-2022-jp?B?RHNUV0w2MU0yNUYwS2tmY2hsUThnbXQ1MHpTbVJQWUQzeEJDVDlJcXc3?=
 =?iso-2022-jp?B?N01nYzRlU3FZTHY3MllDMXpaVHI1K250a0RKaEM3YUw4UWI5MHpSU1Zp?=
 =?iso-2022-jp?B?RHU2cHVVUEtvbmxLWFgxVXIrNCs4Y1FCWFJjU21KV3QzSjc3VW9WcUpW?=
 =?iso-2022-jp?B?bXFrRTNkQi9EYWFpYWxidEdNY1pqa3J4MXZpM2NpcHJPTENhWU9kWUFh?=
 =?iso-2022-jp?B?VGZ6SUFaZ1BObUhoYnc3eTZ2RlB6T3V4dXArR0JRd1U4cUtjNU81UkIv?=
 =?iso-2022-jp?B?a0I3TGVhODRjWWM2Z1EySkdwTE9ZSVFjU3VVU3BvT05UYWxQdXJ5MWE1?=
 =?iso-2022-jp?B?RGFNeVVtQzlSTzhlVGFTK1VzdTREQ2hTTXdueGM0OGZVd3pXQUhyak9z?=
 =?iso-2022-jp?B?NXRLS2FiTVVWYWVKM1pHeVVzSXh0TTZ6dVg1VTNVL3BKNmVrcVpHSGtU?=
 =?iso-2022-jp?B?bnVoVHp4LzE2VVBtcmdZK292c2pCQlFDTEVjcUtmWGdCSUVaSGxweW80?=
 =?iso-2022-jp?B?eld1dTlPcmVoeWFidGpkUysyckhqWFBlUmM4NllFZmVSa284bmt4TmV2?=
 =?iso-2022-jp?B?a2F3LzZiblJYeStHYjduTWpTWkRMTkR3Qkkxelg3TGtXdHl1UEpQdDd0?=
 =?iso-2022-jp?B?NzRpQXNicTJqb0VGTFcwY1p1RGJTZjc3WnA4elMrQ2lhY3pXaTlmKzh3?=
 =?iso-2022-jp?B?dmRmS3czb0V5anpRb3BCOERzR21TQ2R6aUZNK2NWUlRGeTl6NkRnalhM?=
 =?iso-2022-jp?B?OUdqZUpFb3dSWDhHTHY2TGUrQ1A2QmtCOVNtOGpHQVJXQ1hsSXE2M1Vj?=
 =?iso-2022-jp?B?bkloUWQ3QngreksyR2Mxc29MdTMyb3d3czFad0xlM0tPa21RSm9PRVA4?=
 =?iso-2022-jp?B?cU5yZXVjVmhhQk52aWgwaU8wQkF1cDYwVHJNRXhpMCsxWUdNTTgzQVJS?=
 =?iso-2022-jp?B?QWQrd0ppc1prRjlkUFBjMXVmQ2FrWWxTU2x6RWNvQUZDdmVlMTB2S2JF?=
 =?iso-2022-jp?B?TWRtUnZXSjE4cEhEOGpSRi9LdWFrZ2YwYW9HZmJybFI2WkZ5ZUo3azdm?=
 =?iso-2022-jp?B?bTI2SHY5YktycDZGNGtlOG9sTW45TERJUGdjNWZlVDZ3aXdIT3NqVlJq?=
 =?iso-2022-jp?B?RzZ5eGpuTzdpU01jeXJlMmVHWjlaTVplcDNaWmErTVRjR05Zdm5DSnpU?=
 =?iso-2022-jp?B?VUZWUENpMTNiSjkzWlZ5K3dTWlFlbFJVLzRJVVo5dEdqNHlSYmZubGp1?=
 =?iso-2022-jp?B?SU4zek0rMGsxRXBVWFlGZ1hKam9NM3pXQnRDM1pKOHRUdmppSElOSVp0?=
 =?iso-2022-jp?B?UktxZkdGUFdNcVdpQ1AyUWwrU2VJbHJLTTJmSEkxalUwdHpzU1hSTWUr?=
 =?iso-2022-jp?B?RDRDT0R0VDF5cVF5OUdXQjdwZ0VOeFQxWjJDREo0cVVReThHaHdIRk9w?=
 =?iso-2022-jp?B?dVREdWZCWjlXc2I1V3hQcXhWZ252MnRqN3F2R2hhaEdDTjA2OGJCKzFM?=
 =?iso-2022-jp?B?Y2toVStRbEJIbjF4UVdSY3kvYS82YzNNMzFUY01XcWJoQVlybTI2dlF3?=
 =?iso-2022-jp?B?ZkU2M1MrNlVJcEZDcklONC9MYmYxSnhuYitIN2JpYWdtSUhaT05NSitz?=
 =?iso-2022-jp?B?dzl5alUwaFIrZThoRmNSL055dWpqUWpRRi9DWnJ5T2V3NHp2Mzh4Z3g2?=
 =?iso-2022-jp?B?MUNpOEowd3RJZ204NTR0cWZ0TFNadGNjUVBEaEZkaEhaeEJhZFpQM3N1?=
 =?iso-2022-jp?B?c0prdHZFN1lZV1luVnlLQ3gxMS9NZ2c4bENndk52bHRxQ1ZSazdLQUZw?=
 =?iso-2022-jp?B?LzZPTUQwOVU5aS83blY3ZnlnNUZYZHgvZlIrUDdEVlBRcjBlR0hnUjUy?=
 =?iso-2022-jp?B?UHFYVFJnTW4vN01oc3hGaXpPOVhmN1AzQWJ4M3Y4VmVqTmVYeTdCdDhm?=
 =?iso-2022-jp?B?WDB6aTI0Rnd5ZFV0amw3NTEyaS95dTlPQXUvQmdwbFhmamFGYkt0K1RH?=
 =?iso-2022-jp?B?dUw4UVdnalFnTmtzcy9sSy90YTdnTTFZcDlIZ1FWRUJSSXRFUjJlM1c1?=
 =?iso-2022-jp?B?TmcvYVhkakpFenBPWm9rVjVyUHJST0dFNnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sJNYs2CWEEFy/kaXJGhd3BjBc/Z2jdAxmfeOjZLBZBV9CoQguCY/KYfpgYdJ5D1FmOPcwJeAqm4aec5Lh+TvmcUH5Cekhni2Vlzkjg8c4owK6rmfWvew1gtCw8pET4lC7nHAO5n2ApWy71kHX6mR62AA9hPmvfuReOWKwq0t9TQfSpTqtgTpj1yB9m79GLcbU9UtZy727udChAVUitMZBHyxCMHUoRIBBHek/bF3HDGY7GTa47B+h8xMfjNWUPIwQL743kPli/ctpVLp93cGPTLYFMKlzCQoKWp23yrMTsj+wOLtHFqqHm7WJ4fAj3f2GBOsfWuumz4BiGXOhdEL7sTd2k+fQCH0mAie4lkb3bCrZ63T/hMyHNzNOCcuc1SUOO/EaBZ5J5RNlu23q+jS4wc3GAVPZdBumGIGkmxJrXmZ5x0stl0+nnvkoXcRmN8gFIPUjDvcg7II6rhkLfRLd2DatkS+LgrZKdUswQWbbt5MjLA+4IKgzwK8j/Xyr3CyPX50o5XwVX3TIha7vAQ7Gmzb+Vh/6jhclynI1Ws9+gGGUszECmDt0yzP5pY6HuaRmuI3qxCFIcpqD4SSTVk+9hGD+MG98TSnv4iHnFMk97uQGaIp6j+Rb3jivALIPqrrj2Q/OuPExJLSrnvSBTYU/3BUJNl+Cv5PiJ3yOO7hBmB5b1F28dgvkDbvZ1RYtbDTh04VI8wCkekRDjU+p2K3Jh+TfxECvqmkmqD0+TZ6jI7HLTmIzdfAexr4cW2L/OHMWByarkjipcc+gLQqLWIlMNLTajfpomRstgrrTdh3S2nnPa5ZU2En2qPOGI9UhNu+/V5xqP1ANTYPlXGBYHEZKJc3tAfEtlomRHmelOq4Q4SGAJha0a2IKltTuBH/tRS05ry1xeAiv0yS8Ee+AgcScg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12602f8-1b6a-4813-ccf3-08db7dbee5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 01:18:25.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdm/rn+YKTfFZV8Gp6SjlpnXcD7JhP47GVs7SpdoOgEVrFjuOg8qw76Xp1twXHphMvJ3x+rS4IeML5TtoLkXDQC+6L9vnCLv7dSHd3R3J7tDzFhV9GdFG+UlzTr3gkim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11857
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 01:18:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12242

Hi Fabrizio,

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: Tuesday, July 4, 2023 2:17 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
>=20
> Dear All,
>=20
> this series adds eMMC/SDHI support to the Renesas RZ/V2M SoC.
>=20
> I would like to highlight that the driver patch looks fairly different fr=
om upstream,
> and the reason for it is that the SDHI IP found inside the RZ/V2M require=
s a
> couple of quirks.
> The SDHI quirks have been reworked quite a bit over time, and the
> implementation the upstream driver patch relies on depends on changes
> spanning the renesas sdhi core, the renesas internal DMAC implementation,
> and the CPG implemenation.
> Considering the amount of patches that would need backporting in order to=
 get
> a similar solution to the one found upstream, and considering that the ch=
anges
> would affect several platforms, I thought that adapting the solution for =
the
> quirks found upstream to the solution currently available in v5.10.y-cip =
is the
> best way to go, as it adds the required support without introducing
> unnecessary risks.
>=20
> Cheers,
> Fab
>=20
> Fabrizio Castro (4):
>   dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
>   mmc: renesas_sdhi: Add RZ/V2M compatible string
>   arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
>   arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support
>=20
> Phil Edworthy (1):
>   clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
>=20

I reviewed the patch and found no issues.
I can apply, if there are no comments and issues.

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/91994=
5015
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


