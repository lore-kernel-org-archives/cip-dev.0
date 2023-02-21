Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BDDC61DA3
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 23:28:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.57767.1677022073035364772
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 15:27:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 31LNRgYQ010956; Wed, 22 Feb 2023 08:27:42 +0900
X-Iguazu-Qid: 34trvWc6x0QX17ONO5
X-Iguazu-QSIG: v=2; s=0; t=1677022062; q=34trvWc6x0QX17ONO5; m=WygSDfIUUx/EoMiPtWqCLIVUzJ5w+PJsLrApGMGpiSg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 31LNRfF0005765
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Feb 2023 08:27:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRybbMK3ttGyRc0TJa3eGJQ/ieb/o4yOfTCM+2gM3fyolSxPG5IZcNgizMVmXl4gXo8s/myhhQ+1cBGMCoa+jKKlLvb2qRO1KxS7uTELMOaUwFia2TAtvgM/1k+F9paAwlhGysesCI3vcqGC+W0ro5W1bZd6CjBIwVNZk0Pz9psvrdheqEbqopnaXprLhYK/TSD/3/dtdlfL5kNj/XrnJH0rJPI2pfdGJU77LFnoOD2h0Oj7rIkHEGR56Ey5dP+FNr/4g9bCGX8ZSV6ZdLS8n7VC7Cyctqz8t46vFrz74pwkddkp3NvJtqg/OKQ08OqEykqlObbgmJGETQn8r8Qjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khG/HsHonvPsFSa2IdCvwJ2B83nYXmIV5V/LqthdsXE=;
 b=b59NWWvOZ9JoqBju29bKTfZL1Da4YyXuw/7uEYuN8MjPqmWcxjb+NVRQGrYfgfG3+qKjagRa94yjf0GnNIjEKWk+OUe5DxTB2ocWbk9oby0zHOfwWOO9krOQ6Lo35QmQe3WHE1OQ5QDzNx4JjlVIB6ZovL7q2JH7DGx0m9g/FUHS4cUZep40sCpIh025n2+NEor8sSmnTR9NSBKP+FkO/3hRwLfES6FgE9YYs/Uy4dy9rF4Lfqe3gFciulUX+o81AMPnQCHgGDOjk4rbfdNkYwyF/w/1PqjB9a0BgBPzvzxpHc+rrR9Ai5vAyWB+RZwFJ+02/GoFu7PN7Nyjq40lmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl
 improvement
Thread-Topic: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl
 improvement
Thread-Index: AQHZRcrnnXCEw7h4o0COsL+BsWK0dq7aC9Og
Date: Tue, 21 Feb 2023 23:26:57 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB942011DEBBC3C691EA12CEB092A59@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB11194:EE_
x-ms-office365-filtering-correlation-id: 0c2eb546-1ec0-4c1f-4b8a-08db14631ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ow/DBztObTstjqwIxny5wGKPCP8EpFJI0uZZXTG6ieH0qIC4OFd6dpadPSPXEJVnbb0m/53FsrVA8EAZ5NvVtd6b6CXxzz2lBbjvigGaS6GZDk3KL0wCMDANPLmsYYh0dRFuzUPSq4yRVEGii6TKdIuT/nPuwtp0zy6A8vWxoZFgfHbp5O43CXVj3+CgfK7o3uq9SWTXI+8ch+j3nmx6dPPfPDKVjaIhnxw07WlJZB4NayVLN4fLbTuZe11pUWuUCIYdj1TDSZNzmAOz0v0stLNdAVg3XTLL31kVg8qxu+ubSrurEcVjUCEOTy3Fw7yhzuwZf5Nc+GEJkj2CK1wC+CwdMNf1eQIm5PSTwoNyyaMiqh4DhnBx91OjWsdilbm7VFAqU87qB8+xZu9dov+W2brRPSvK4g8/oWXDdLfea1XPgWjRdAjoCQmCc666cGAxHtVIRr2nd8clrsaSSjqbWoBuRNZdP7/yEYaMaUDkj6nlmLI+BoxJ4XLXagl6npikhaZIFxJ0a7aqNDO4vJ5jDO2W/YbT5TYkiWZXJ6o5URdSJspP8pXCmupnlli1ia1QfCXLsKxmk2UxqkxBcPnU1grA0kaBvV6jsh05XoCTX98ykDBPbhQalLGvqgwFj9YcuyC1WTd2WBYVlO1K1DW4cqsx6z+q3LyAnUohB6LKd7bmnbgy8InmxOvxG6+ZWkr5qM58tO8QGttbKspedmOWFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(38070700005)(86362001)(33656002)(4744005)(41300700001)(52536014)(8936002)(5660300002)(122000001)(38100700002)(83380400001)(2906002)(66446008)(478600001)(66556008)(7696005)(76116006)(71200400001)(64756008)(54906003)(66946007)(66476007)(110136005)(8676002)(186003)(9686003)(26005)(53546011)(55016003)(4326008)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TnhwcDlCcVpJbjFZKzh3R3ZzQmErZEU4clVKajlTajd5OUI0dDRGN1lS?=
 =?iso-2022-jp?B?RWhNZE5VNVFnL0o4YVNaWkZIR3pIWGVMNmY5amNhUm92ZGxVMFBoRzJ5?=
 =?iso-2022-jp?B?NlB6VDJWcmtWMDBmTnI2THdhVmZ4eTNZaTZxTkMrTW5JMUZiYzdUSkRJ?=
 =?iso-2022-jp?B?ay9jeXg1dUVGV0t4YUtDeExUZkZZbkg5Nk1ycDVRQ25TS0lpQkRmYXhF?=
 =?iso-2022-jp?B?NjE2aTZINml4V2tNTWJZbUp1cEgwRDNTeUNlT2pFbUpuNnEwY3RmUGpY?=
 =?iso-2022-jp?B?N0YxV1N4TkpuR2pIUVQzOGEzVG1CenFuSDBLNnM1ZlhFdUJjNG10bk5P?=
 =?iso-2022-jp?B?ZVhPRjdnU0RrQVNEZWd3aUV0b05iSkoraGdtM0lGOGU2K3RtTUo0SkVm?=
 =?iso-2022-jp?B?SFRUc2RFNHgvS0VYbDRsUTM0b2Y3QVNLSDBtc2RPRHcyUy9abVkydGg0?=
 =?iso-2022-jp?B?WDlCY01FMG85VVNPWDZBQjZzTjdJbVlTN1BVOTY4Znd2TlAxbk5wMTZZ?=
 =?iso-2022-jp?B?ckFvYXE4Yjc3R1plbjBvUDBCeGMrWXgyRUVBWWpqdm9odWUxOUtrLzRW?=
 =?iso-2022-jp?B?OXNPVVl2U2N0UWpCVUY4SWVsa1pRVzExaUw4NzJraVVLLy8raWZzS2FH?=
 =?iso-2022-jp?B?RkUwcmI5ZCtWb1oyMmk5Rko2TEw5M25nb09hN3lQUlIvV3ZwZHIwMS9j?=
 =?iso-2022-jp?B?M1dDTmhyTk1QbGNidkI1Rzh3SDVhMVpaL3BHT3FLQ1BCVVh6MmMvK2Ja?=
 =?iso-2022-jp?B?TlVCNm1VVG53RlN2bndNY0cyQll4NFlDSFd1WWxJQTNDNGowZ2dQaDRG?=
 =?iso-2022-jp?B?UmpSenNhOEFmaEVVTWFvSXpFWkk1TFZwNk4vQWorT1pzcVlvMmpSNTRu?=
 =?iso-2022-jp?B?eGdCdW83ZFlJSzJ2Z29KamI2aWpCMDBKODVlRExLSUdxZXI3QTE0cThD?=
 =?iso-2022-jp?B?R1pPeEQwamdId00xZnZPaTdkanlBbzFBN1h0YS9maTJ6WjJHZTM3dEdq?=
 =?iso-2022-jp?B?cjBDVE9nMnpRSStYdzcyeUpVMmF4NlhvSS9JYkxQN1d1WjVLdlFUa3RL?=
 =?iso-2022-jp?B?eHZiV1NkWjd6NlkxMWIrWkZ5aEFpeGFCVEV1TDRldGZ1QnhDeFZMVjBl?=
 =?iso-2022-jp?B?Sm5hQU9hU1dseWVsbFB2OUtNSmVuLytFZFlKdVBNM2lkR0lxNXhLUmxR?=
 =?iso-2022-jp?B?b0dvdWRWRVg2U3hYYjE5bm1GRTdMc0xZUWhOelUwbzF2d0xMc0x6Tktq?=
 =?iso-2022-jp?B?ejFneXRGVkxyRi85N3F4VnRPR0NGVWk3Uk4wcXNZVENHajVrS1F6UW91?=
 =?iso-2022-jp?B?WXhtWkZXTFJHV2tTdWovZFlva1VjdnYwMjM3VUswa0xVd3NSeUoyL2RF?=
 =?iso-2022-jp?B?WDdVOXE0RHNlcWorVFJrQXpJdENTSHY1cldmd1ZROUtOUVVDbFpUMllW?=
 =?iso-2022-jp?B?VVpkMGQ3N0oyVnQzY0hCVHlMNkd4S1ZCcXViSTZZd3JoMndWOFA4Ylky?=
 =?iso-2022-jp?B?QXVzRTM2ZEJZRG5yQXNGRkorQkNIQ2NtOXE4TFk5aUN0ZWZueURwOGJ2?=
 =?iso-2022-jp?B?Z2NxWFlaeWRyeVVySlhkbG1hYTRxRWRXTTBSN2djbHVtT2pZRFNKTXBy?=
 =?iso-2022-jp?B?eEEzS1lqV3h6SmRScURTMndWRWV4cTBpYlkvdHQ5a3pwam1rNjNnK1hK?=
 =?iso-2022-jp?B?T1djOThGVllqWC9xSHB0dURHaVUveWFaVEpLVHFxSk5tSk8rWkxjUlV6?=
 =?iso-2022-jp?B?b0pQWTduN2tKclNvWm93NzNaSG1YODdFVDJ5cm5pak44bXNDN0RWcFoz?=
 =?iso-2022-jp?B?aXpxdUdtQ2h2RytuWmRaN0J2eWI5ZzJXallnVVJUbGo2WDluYmlnaUxy?=
 =?iso-2022-jp?B?VXdyUC9ydzFwMzlzdmNNaHE2dHlmamF1S1dneUxBeXhmeDhVbUhLRklL?=
 =?iso-2022-jp?B?V0hwcUFDeXVUckVNM2VlUnplTHhGVkRpc2xlK08rOGxGMTlOdDNxR0RN?=
 =?iso-2022-jp?B?SlNaazkzV2doT3NQaFBMbmZBdk8vNGU2YnhMQnFLSVRXeW1ZbDNhVkx3?=
 =?iso-2022-jp?B?Um5yMTI0bmJENGcrMXZGdVl5bHpzR3ZwSjlJNWx6YUNJRytHOXQ2WVdQ?=
 =?iso-2022-jp?B?bkRIdVVqT01Hb1BWcWtGeEUyVzVwbThScHF5WFBNRG9VaE55KzBXN2Nk?=
 =?iso-2022-jp?B?NWQxWmZlUGh1dnRRQWkvRWcwSnhFOVNvU3VIUXFyT2lyZVlQSElKVTNQ?=
 =?iso-2022-jp?B?R0pTc1V6OGdsc0hPMEtkbzJReG5YTlhjVjZWUy9xTXJDWEoxNzFYL252?=
 =?iso-2022-jp?B?ZngwUzBIRUh1NG1VeXRra2JnQjhNdUZ0Rnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2eb546-1ec0-4c1f-4b8a-08db14631ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 23:26:57.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kF3fs4NEB89yKehpdqjQnvG6ABLkEPw4GKWs4C5CnjhRXE+RNh6dIzHsAG+QpeX0wEGa59BpEKSu1m2tgXB9X/wClNqWnYn7uiy6fl6xkWdBpsoiokQ7dio2sPtVRf/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11194
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 23:28:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10765

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, February 21, 2023 5:03 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl improveme=
nt
>=20
> This patch series aims to fix reset issue with watchdog driver and remove
> unnecessary check from pinctrl driver for RZ/G2L alike SoCs.
>=20
> Biju Das (1):
>   pinctrl: renesas: rzg2l: remove unnecessary check from
>     rzg2l_dt_node_to_map()
>=20
> Lad Prabhakar (1):
>   watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
>=20
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c |  3 +--
>  drivers/watchdog/rzg2l_wdt.c            | 10 ++++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>=20
I reviewed this series, LGTM.
If no opinion, I will apply this series.

Best regards,
  Nobuhiro


