Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC0C001B0
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 00:31:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.77980.1691541063825444894
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Aug 2023 17:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3790UrMv1884015; Wed, 9 Aug 2023 09:30:54 +0900
X-Iguazu-Qid: 2yAbM4uBQvUcjedcLj
X-Iguazu-QSIG: v=2; s=0; t=1691541053; q=2yAbM4uBQvUcjedcLj; m=UYThqR5sJfmaoNp+sgrR3GFmoc6Nb2b94SSrGhIO9GU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 3790Uqnj2139135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 9 Aug 2023 09:30:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSV2L4kujtgiGfkbaDFWT4I7nOn7B/8tIrHNbsyCx6CXx7GAGHJ2dEWamKzlS8Imrxy0Y7dceJN5DATKXAlARuRSk95OGQwnLMP4qPrJ2guX5Hb1VMJiD7014itwvpv7fbV5XsmwICaFuoI4qnBUuSHPEpSMmRc7L0qeqoygfChBFMorCdaopIbtJS0fZDqzDrrwRApFC2NOLTdNgwpmWOY9S+UdZ/oIQBfji91rrnRqQMDigoNMQ5FuhUG5w9skQVmv4TOmfWc/oNbvopFTKU0GA77J1I87rLquNhRg49rxKzQxn12sX0TSj7RqwUOebOXjbL9eYg5rnIGzjpMwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLlBlhIZW3ZPK2UxxdzmawyP61xECAHZSJE4OpcS5N0=;
 b=nR7OiGoEac0S7i1plw6GA8RhXj+bQ+carRlufIc2VRXwdck5eRvBwrJ0KcdMTHB287dxYDJ1cxPd/hTN2GB/kXAWdDPp2db7yfawiIa/33JWgdfEW/lBaHbgCHVD/f+yrR9uUOQ8vxX67499j9kOtieEGsYrDx0ZYL/+kMeyGLgOrLjaGBr6IN1UpdEN2KSin+A0yVj4GhwRqD5sU+wbj+3bnk9UFqWfTZT8LJtEr2h6XL2Up9iwEYewt7yahFLuJp584518KSr72nMz84M2RxdjfUNe5qqwApxU1ZX3MvNy7VCepvB6Vb6I6DrRPslyRWB0kFKFz9grAYsibXBG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l: Update
 overfow/underflow IRQ names for MTU3 channels
Thread-Topic: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l: Update
 overfow/underflow IRQ names for MTU3 channels
Thread-Index: AQHZydrHCZQ6p5tpP06efR9isAdGBK/hHV9A
Date: Wed, 9 Aug 2023 00:30:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94205434034D19DD563A8A9B9212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230808092849.32139-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230808092849.32139-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5856:EE_
x-ms-office365-filtering-correlation-id: ce9fde20-a0fb-48e8-f5d6-08db986fe199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 N2wjJf1u5OdqFkJE1l7PbYLPX2W1bVEKiGEp8M+GUm0h8GWccQJ2sw2FEhLFbMGiivAFac2wlmBaaBFxYo6RMtAcAaSYI/XiWnU46mJ6ce+Aliy2vMqTI94wNqOYOTZzA3xLDKum6TlXwTmSwIuFDh8galWw8MUkzlQWk08P1vaisZV3WxdQBuo9eQTkHfqf2pmznR4DWMyymw3oIckYavb47hm8yYO75xVdfQQR7ECszWBZoktXKKtrukcV12nwFwC6a+T0K9cuOwDJSsgTaISuONnl152Ut44HL7UgqkVM3pbz/sIzwOINSyT90YRE4Qx/fnADapqF0kISpf2+oTNktgtgzzVH4RWLUg/un+uNrJvFunZYkDD9Yxiz1GjotqpcaHc4q/tNiwM78EfRRh9BUuWsl9qp3veW3E03uHZIx0ZtyPas3qQzF71IkASjhm5sIEGsVtMnQQgaH80dmNtn7/F5HR6raE3/DD+3xECpHuC3G82VwcpqHAECrrk6+/dpW+QqyIQUsMUDN/VCr7Sij2CoJpVIB5uOKsVqJ60Fb5skx9DiM1eGT58WUTXahmXLonE2NYYULaGEmqn++30eflBu+yPMOkEyukjn2U+FotQxcNbQeJXAf85D8DI6IJaveJCKLlKUYARJa5xgcA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(1800799006)(186006)(52536014)(8936002)(38070700005)(8676002)(5660300002)(122000001)(55016003)(38100700002)(15650500001)(2906002)(86362001)(71200400001)(7696005)(110136005)(83380400001)(478600001)(33656002)(26005)(6506007)(53546011)(9686003)(966005)(4326008)(64756008)(76116006)(66946007)(66446008)(66556008)(66476007)(316002)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WGE0U0UxU0N3MXdyeGd6TVpwd1l3T25DTm0yYmduSlVIZW1YVkhON055?=
 =?iso-2022-jp?B?WG5wZEc4SlNIbmN3YVYzSFlMK1FkSkdLRlA4YldtNjZWR3dwbVkvejZz?=
 =?iso-2022-jp?B?UUtNTlFiT0lIM0QybnB6OFVHYU5sMzlCOGFhRml0Vmx6ZjdtWXlJMCtj?=
 =?iso-2022-jp?B?TzNvbHd5R2Q2b1hYcEpEd0lwaHk5UWpnRnNxOUY5M1p2YlgzQnJDZERN?=
 =?iso-2022-jp?B?LzlTNm5rNGY2ZjJQbjY5MGd1d09DNEtMemxvSUd2NWlDaHNUTk4xeDVQ?=
 =?iso-2022-jp?B?S05tZlZYNG1mQWRRV3A5aTdjWG9yazMrcGxzekdnbHFhRXBWcHlPKzVj?=
 =?iso-2022-jp?B?UmpneTZjNWhTV2JYQWhTcFlHQkZGeWd5U05LKzBsYjhBOXBQc3lHTHo3?=
 =?iso-2022-jp?B?VUdFSmFTeEZ2NW11Vnl1cVUyNWwvUWF4ZUVZZVZVMTBPTDBGWENaNlha?=
 =?iso-2022-jp?B?VWxERGZiQWRiSEtXbUgrRTdOeGQyNjlLR0xBV01yVi9FSWxLelpoSlZ1?=
 =?iso-2022-jp?B?Mmd3eFdRQW16NGloTS80bEZ2c1hZR2gzb2ZoZXhoaWVoYU5LMmRhaEpD?=
 =?iso-2022-jp?B?TXVqVUx6UVBtbEIvcWc2c3dhZXBrbnZwUHhwNE1hVm5nTHkvdDBnanNI?=
 =?iso-2022-jp?B?cXNISzdhYVlabTdJa3ZKMnRROWxJb29hRCtuWkV2T0NobU1LQUlwNnJW?=
 =?iso-2022-jp?B?WVh5c0MzbWR6MDhQZ01tSnBiZ1dmLzUweEpSY3FZQnJabjEwZ1NHbjQ5?=
 =?iso-2022-jp?B?aXZyOWovRERmeDQ1Yk9LUFZQZXc4ZFhhODBST3ppU2N3bzFReXdkNFgr?=
 =?iso-2022-jp?B?eStVUk9uUy83S296VldEQmxqbGhrZTVjcGJKV3c2VGwrSnNZNzRFTVpv?=
 =?iso-2022-jp?B?bEhURUxsdC81M1gzQkU1T3pmNC95SkJFSGxUZXNEK0pNRUVCbWtaQUo3?=
 =?iso-2022-jp?B?ZGdMemhsQVdPd3l2OFdtMEw2eWxMT2FibVZYZ3ZIU1g3Mm1STVlHOGlH?=
 =?iso-2022-jp?B?TjJmZHA4QUtndUFnRTYreTdob0N4VkplU1dCcjJlVzdNeE5LKzUxbDZV?=
 =?iso-2022-jp?B?aEc3aEltK0VNZkR6Zk9yMHlWQWNEWjJISEhqb0M4d2VyMEFRd3ZvSmxE?=
 =?iso-2022-jp?B?OWV4NTZDMk54aTUxdS9JVG8wZ2FTODVjVTE5MnlkUGVDc0Y4MnVOdmZH?=
 =?iso-2022-jp?B?NytOaUVNM0kzQ0NtOUJ0eTZYclVsWWw1ZWRQTlk1Q3NHRGtUaHoxNEZy?=
 =?iso-2022-jp?B?b2tHeThpdDRia1l1SitMeGxxVHVKUUpTUTBmYVQ1SXY5WGpxUlJsamFy?=
 =?iso-2022-jp?B?eTVGb0ViUEQxVVVmN2QxRE90WURqZC9HT2ovQnRqSFo4dk90YzA0SW9V?=
 =?iso-2022-jp?B?UmhhMzhYNk8vTExaMkRURzFyQ1oxRktRSU9oNUZ6bFRwUDRMUVpFTE1X?=
 =?iso-2022-jp?B?eGZITDFnQnJGRURtTXFEcjZHSlAyK0luL3VjMDdSb2ZVUWNqMVNLWWhB?=
 =?iso-2022-jp?B?dTV0ZDl3RWdQTHFuSTFrcVkrU0VWNGtRQ2RsT1NhYWxFV2dRdWFmRFlZ?=
 =?iso-2022-jp?B?WldSUjJ0Vno0Wnk2cFVLbmhOQlVjNTNNYTVycUViZGhHT3lyY2orMmF1?=
 =?iso-2022-jp?B?c0lGdVV6U2hvL1NUMzVjYTZ5RTJtMEdkUndGNHF6T3JoSTFaOXBoZkZC?=
 =?iso-2022-jp?B?N2dKVS9yWWJCcHdacHpoZ1dXcDBCVUFYSFJZTG9qSGRzVWVpQkZsY1A4?=
 =?iso-2022-jp?B?eFkyTXpObnFGWmNvK2FlRG44STRFb2RHS0lhMU1SK2V1aEZGL1phOU1n?=
 =?iso-2022-jp?B?bEI3TzZnUjFjVjQyaG9JcEFGVzRkaFkvWjFFZGlFZCtBa0wrZXdFQXVX?=
 =?iso-2022-jp?B?N1g2em1CRG9uTzhZMGxJV0htUmRMd3MxTlJFVWttb3JLR3h5UVAxZ1R5?=
 =?iso-2022-jp?B?VGdPdHo3SFpFMjQzaE5rTW8vdy9lSU5vQytCUk93Nm9WdktKMUFSenpp?=
 =?iso-2022-jp?B?aW5iR1J6MkVWclVzRVlhMEtFeVpBSUM3UWRHREtiSHR0SjdaUzBIVUY0?=
 =?iso-2022-jp?B?MU1VS2g1TVV4L0xFSHZWL0Vla2lMZFF2UmpscWsxNGhkYTBFcnRHZERo?=
 =?iso-2022-jp?B?dWF6VEpmdFdxSExVZjlIUXRDQzE5Y040WVk0QkRwNVBrSExEcGxFVFNC?=
 =?iso-2022-jp?B?L3doSDhabFk3d1dSMXcwTlltTENjZ1hka2NxS1MzNTJqRkdpQWlsVGFE?=
 =?iso-2022-jp?B?VmVNbFVFWmhaVGtleTVWaVV2d1NySURsY0FSMElQb1U3bUNoNmtzaWpZ?=
 =?iso-2022-jp?B?WmV0ZHAzaFkvRVd1aHEwQUN1STI2YnVqQmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LoIBu7dHPuY5g3jbfd0eAakJ4aRazFt5m0jY+K8kKAXkFIOOEpFJFcU+avgsUPl5I9+W3eTmqzern0Z4kHeeo+CLdlXzdk0GLh1mEpVta2wu82/fGKAkosAu9n8uQE0ZzvqH2DWS8IJq9TXu+WRyfu5ZoLPgU8L03RTzDgBzDzOz21SMida2vVFmMOTVNSfE0Pqccp8DzNC1WlyW0WmbZD56LhtR1MGxbSqG/BuXyCAVAu0itKo6pcXkRpR1Qu98V2ab0gNCc6umkffaFfpH5YZFT3f+6bkqHeo0vQZQsj06pfzgWb3PR+JSaFP50r+sR2Lyx1EDBHlsjMMOqvbFnwH2SgoA/nkpEFpnp9GbqTKm6SJqxqioCXqfBpyssPWIZMgI5S365ga+4edqZwqBVrDwqFejy7SanHq4OS5TlhCWQe+tTJtEuHY5HAJpxF+Atr0Q8aLvCnh2FKzOUwzgbg9K8yHt9RujAHZGSg3tMfioFR3xoV89hTr0H6ty+l6AT/9WE2JHKpl92GpzIbjdqsmclye1hLw3GND7dZrHuU3hJG18FZ2ToLNPHJUxYjwOdPf8u0RRvLl+6I9gVQxVJgWlUw08vrKfARWF3awSK5eNoC6YP1Nhja/zXDlSmNTK3Qz7YbEqXiGOSmn3L6jWecYs8QdOJQ2knMYyDp8Uqd4aeHQiawzhc925UOSGbDcZl3n3FDzpEw1T3P9Rlt4Y9u5w3CfYiICFr7QxJ3i4WA7OaV98hZ7IppcGiwHHz4Pd/vZlnwSxLEgJXyMpkMw4dG2AITkIw4Ftn+bInC++8wDapGle2YcJ0YTObPbbISnPP49nTD/MY+HkRZeRj8whZA+fGJjNbgncL/hn0A+hBnaMpp3wt188PU95pNdvrn+R
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9fde20-a0fb-48e8-f5d6-08db986fe199
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 00:30:49.6199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qx80Klc72d73HR0DDtVcNGt2WC02TZ8x7uYlZmFS8r8GtceSpOvhYD8fgmT/DtKGom3k+VGOzxLy4HR4/0GQ/eWTvbNJU/0DyL4+CLzBmmUFPf4lhZlTJA3+8RwvblTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5856
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 00:31:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12565

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, August 8, 2023 6:29 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l: Update
> overfow/underflow IRQ names for MTU3 channels
>=20
> commit 4c188fa183ebb45238ef16504c4c7606955cf9d4 upstream.
>=20
> As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
> interrupt names start with 'tci' instead of 'tgi'.
>=20
> Replace the below overflow/underflow interrupt names:
>  - tgiv0->tciv0
>  - tgiv1->tciv1
>  - tgiu1->tciu1
>  - tgiv2->tciv2
>  - tgiu2->tciu2
>  - tgiv3->tciv3
>  - tgiv4->tciv4
>  - tgiv6->tciv6
>  - tgiv7->tciv7
>  - tgiv8->tciv8
>  - tgiu8->tciu8
>=20
> Fixes: 26336d66d021 ("arm64: dts: renesas: r9a07g044: Add MTU3a node")
> Fixes: dd123dd01def ("arm64: dts: renesas: r9a07g054: Add MTU3a node")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20230724091927.123847-5-biju.das.jz@bp.renesas.=
c
> om
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 16 ++++++++--------
> arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)

LGTM. I will apply if there are no comments.

Best regards,
  Nobuhiro


