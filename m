Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD3C001DE
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 02:08:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.79557.1691546875209472584
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Aug 2023 19:07:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 37927jFb2222054; Wed, 9 Aug 2023 11:07:45 +0900
X-Iguazu-Qid: 2rWhJyZQZ5F6aIDJQm
X-Iguazu-QSIG: v=2; s=0; t=1691546865; q=2rWhJyZQZ5F6aIDJQm; m=uw4Dc7GCIJJNeonGvl5FcFLa+YfURP4Lw3jxFlUJwKs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 37927hB21128370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 9 Aug 2023 11:07:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8Y4wAZnfhEyo09CBSvAb7vxXSf1v56y25AL6M/gm2adOCBb2aKEDvPFTNoNVbhfPWUacRBYbufi3v/K0Yn+pJfvpl2nvigth5wslstaMKzyTpgqZFMdgTeloZSFkW2XMwCxDILPpS+gZlhAmgBSItzrtXmRTkcJNMaku2k2S413kEJItLyf3UYbniaRavHszS0hxNdM9it+vnIwbWfOuHHcJtqBLDutRN4mYbo9b3lUch4YidkcswS8ynRgsRa1Hgc2M79XrrGrjRNDx/cP+GV1HUY6w8GxaXWOUVs99S8s72P8oDmpEQU2bxn3FCNHIMTtjKjKNy2phQ6ZARD30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EDnofQk84B4XBYIRNc1fydCJsBYBk2/addZKveexO8=;
 b=RG7aEmpPZz+E/9oMfJTxhkegefffp0JoGd6CGWIigjbv5evtpEsrfqp86LCiG7GUlBwzK8zKEBQBXFIcyKJ8hE87npgt7R8+yXDx8Tb8Q8FE9eGRxT2JxsEYwtg8ew3HgICyZSLQ0tHL+L/J7LUfnbZN999ES/sHRL8PKzYAOwbbFk2vROfSFW6iniickEl0d7jWEkvCZZSYdWrsWjf9Dtz0VOoVavF84PKCzzJwzBBq4NBhccDO03skyrwc6zN3HW/CRqBgJvUE+uGpRU17a6ulruU31lLU6yVdBM0PKIX1uz7p6jLscoqLRhvQzhg67wOvfF98bnzA6Jz6iVMnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] tty: serial: sh-sci: Fix sleeping in
 atomic context
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] tty: serial: sh-sci: Fix sleeping in
 atomic context
Thread-Index: AQHZxUxcs8Njbamm1EOSlSYqo7XSrK/X/2yQgAA6h4CACQfJQA==
Date: Wed, 9 Aug 2023 02:07:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942021A08D58D504F0D4570C9212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230802141919.474558-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942035A7B11C466B09ADF4C99208A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZMtheQLIQUHJwhS2@duo.ucw.cz>
In-Reply-To: <ZMtheQLIQUHJwhS2@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB9660:EE_
x-ms-office365-filtering-correlation-id: b6cfdfda-1a8b-42c1-5bbf-08db987d69ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CwXCipw26Rqxu4dNAGqY3GleVK4mzKqPpTMIWYn/hwvj4N/VMhuItlhVSOZ9rGvcM+vpboMBhXjUCH6Iho8JXWunlxoq5fHDTP4k3bS0hFV+I1uogPwZEj5aOe7BDW4HnkOBXRTnxSChniJ3G2IL4zlrCrSNo05Kk4t5JbrFtXSxaazDjxyQ1ILGIesL4r7gatWJnoCGT5Rjida2rQDFByz58MpfbkWUnsQoWc5GH1yCjwAYQ7Ia/C+ueL5X2f9iWrfzNqdWJRF98I5K4ZhmDxd4gjKGKUTyCl4lZ6W5vi5tP9IuWifxnyKwn6mv7PuFt2IEKFE3XQ7L/pVPjj5b4ZgH4ouFqY11euq/jYoIiQ5+S2nmE5J/gcSEhsqrBBGAGwLy3dH9nCyTAEkK3NPP9RYdbVV5Sqt/8kagkXQYlSckh1EldCdf4mDmlQ2X8i5hYSg1Gk6htkQBkQTrrD4h52Xb72gawQ+uJ8xZk339hLZg0fSL1UhHhm5BMWo9SIX9J1p/sbI7x464DTFBuA3+Eo4qj6HHeXYxPCGIRSFa6h2ql3PIOPOmvLu8wipwenUh2O28icKJzkinmiU4QunOLlLtxxXdB2xwX1ipKnPaDBJR36r1u8/FqN5QHkGHcF9CMJHkv5ymP237iKSCvZDfPg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(1800799006)(186006)(53546011)(6506007)(26005)(33656002)(9686003)(71200400001)(86362001)(478600001)(54906003)(83380400001)(7696005)(6916009)(41300700001)(4326008)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(316002)(5660300002)(8676002)(8936002)(38070700005)(52536014)(55016003)(122000001)(38100700002)(4744005)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TEZNcnJmVkJRMVBnR0JRVlhpRThFTjIrS2JzUXBpVnJ1RHpQeVdTKzVB?=
 =?iso-2022-jp?B?ZTNYWHJYUjZMY1BPWkRxRS9SaWUzUHF5SzFsK2pMRzNEcXZaVUhVNCsy?=
 =?iso-2022-jp?B?aFVPN2lqYU1YeUM2RTFHQ3ZJZ2hTak9aU2tEblh2VkREWUptS2JlQU5u?=
 =?iso-2022-jp?B?K1dEZUY4UytWWUNmeGdJL2lwUVY2ZFFYY2xuNGhuRDR6anpGOU9qWUhy?=
 =?iso-2022-jp?B?NW44T1dCZmpPbDltK1BIRGNuSnJNZktqRG5xNjdoMXJUQUxsYlpzcXJS?=
 =?iso-2022-jp?B?Sm1vUCtnbXJoZHlaRlBYem1YKytrTTNnZk9wc1Y4aGl6YWl4UjU4QlEr?=
 =?iso-2022-jp?B?QUxpbTB3bGRGOUcrL2hWdTdxVlg0dTk1SjVNU3pyejdHVy9ta05XS1Vv?=
 =?iso-2022-jp?B?Ym1VWWdNaGlBcTVsV015UFRkaWViOVVmNXprQlc5d0syZkpCYVAxbkV3?=
 =?iso-2022-jp?B?Nk1KY0dMd1o2RUNGS1pwMStESnlQMFZSVCtyMzJ3bGdPUlJXbmxvandv?=
 =?iso-2022-jp?B?cFl1RzQyUk5RbkNQOVR0dTdhOFFyRGtBL3g3blhvOEpMY1czK0hZOExi?=
 =?iso-2022-jp?B?bXlDWWFLdEFScFg0cWp2TlVQeGZoWTJFeUhlTGZiOTU0WVVrcXpUSlRV?=
 =?iso-2022-jp?B?cnUrM1hlbTRjRzN6Mk1LbWZXV1o0MnpFR1FPN1pVaUdrR09zeXZtTVBR?=
 =?iso-2022-jp?B?RlI2NVNLcnIyZTJJSFZQL2hOTjh2ZzNDcW9UWk5JUUZLd2I5SFhUUTd2?=
 =?iso-2022-jp?B?K1hrSEVLSVNGb1ROOEFBSHJvMkJobkc0YjhpTkt2VnJqUUtQRHpIeGRV?=
 =?iso-2022-jp?B?SEtRaDRhV1J6SHAwV2d0bEpEMm5BdVY4by9CRkNTNFdieEh4eEtlckw2?=
 =?iso-2022-jp?B?NGF3VmczWGJZN29YYmMzSElpem84SW5vN3JqWk9KNmY1ZzJkMmtPc292?=
 =?iso-2022-jp?B?L1lLb1FsNmE3TVBEQTAzWGtPSXpRZTJYNlN4dEVUMENPb0laUDA4WjZN?=
 =?iso-2022-jp?B?SWl1Tm11eEZZSHV2Z3o0cVBjeCtvM2FyZ2MzTFBTRElCbURucmt2YXJW?=
 =?iso-2022-jp?B?Qm9LczdaR1FFNlVoQzlYOFVJc05WUlJheHJ6cVFqT2RYaHVabkx5Uzkz?=
 =?iso-2022-jp?B?clhDQ0pab1FLNEJ1aXJwZktaR3lJeDNiTzdFc1pxNE1YVUQ5aU5XL2VT?=
 =?iso-2022-jp?B?MFlWRDljYkZvNndCNW91RWkzdHJOZ01DdkNuYjBqV1dwbDNwUGlJdWxu?=
 =?iso-2022-jp?B?NDJJTE5UQjJWME1McURlcjlpVHRoeGN3MUtaU1dLaDdCK1lmTkdmQ08y?=
 =?iso-2022-jp?B?eW8zK3pVdEpOSGpocXV5MVFCZVIxV25xdkhuWXBGQW9tOUY0Ylk2dlBD?=
 =?iso-2022-jp?B?aVhFQUxFb05HOXI1RlpEb0k0V2UzdTNjZVg2S09JbkFmdGZ3aDVXSzBz?=
 =?iso-2022-jp?B?K2RlaEU3ZXpWSmNMWWxJY1BNU3pOd09Yb0tiZGx2Tkg5dXVTUkpqMDNF?=
 =?iso-2022-jp?B?bnBIVVdCTjE0akt4NVEvMmRucXBaZ3FvRTFzL3VlRGoyT09XcVBOWERB?=
 =?iso-2022-jp?B?MExNay9DUFllYzJZTzN3TzhKTVBOeXhMZlJoTnBTK2dmK0hjZTluK0VD?=
 =?iso-2022-jp?B?STJGeTZJSUZVcDR3OEZ0V2hoRUhObSsvTkNHb3E3UjZsVEliaHRUekY1?=
 =?iso-2022-jp?B?anJuRWt2bnF5Z2RDb2c0RzhhdjR4ZU1rSlBXekl5Q3FOT0JvWC9XbEhT?=
 =?iso-2022-jp?B?S3NLWW81dERXV1VEVkgyT0FXVHlnaStJSlhleUJoUjZSanVlMG95WnRt?=
 =?iso-2022-jp?B?U3RzbFRiVkt2dnNqWTIrcHU0OTNrcmY5M2dnZlMyclBlM3JOc01tU1g2?=
 =?iso-2022-jp?B?UzJyYXBWbERLMlpIVGhSL3Z5cUFLd05EclhpbGoxWERqbzdrcjlTL1A0?=
 =?iso-2022-jp?B?Sk51MkxDLzRzVlFQR2lEeVFJbXlBNnhuS0tNN3A0dGh6YVUydzRhSFFa?=
 =?iso-2022-jp?B?TmpmT1NkL0FOT3BWS3hzOHh1ZUdnKzNIQnZjTzIzNWIyV3h6MGIxSmVy?=
 =?iso-2022-jp?B?ZTQvUTBHaTZBK0xRMnJzQkJucDFEM25EOW1SSG1abGpNTTVEUk5SOEtw?=
 =?iso-2022-jp?B?THFpV1FhajhGc2w2bCtVUndyaVJuOTZqSzZLcW5kWDhqSFM5STdyWnhN?=
 =?iso-2022-jp?B?NDFGYjJhZi9OYWpsNksvLy9Wc2lVUzVRcVdWc0VmMm1uQkRpWXhTajYv?=
 =?iso-2022-jp?B?WVFhK2QzdnZDc2tSdS9pVkFFdGQ1N0lsaUozZ3BFeFFLZWdJVzhUeTJK?=
 =?iso-2022-jp?B?QUwrN0lHanBka3NtWWFRTjN5enprbG5iOWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ARrk/O0fT5Yz4cQkCZjHpv+5VJCPmNCzLqToejRYlDpwSCD6m0FiV69r4zxmXbgGtCj4mRuYkNMhHx47MAEJh2q3fWirVGL8eoiZHazAavj4Uwch9RDH/i3dtIQo05NaV1z8lfYHUUQPnaz2dStKgePT0WxW0gFeh8H6aZTUVNJtXMr/OTdEh3ULCehDSXDjSA8430tvRyWUl+zug8uQpCjDTsLnd+skpXkxIxmd7OFglOJd7cLS5AC8PWreEOJN7bXIAz3WYWASVIaREq/BoWEM2dcXNaIElr2jT+6HlA037MrHI1d5psGjlrAyHLFUmWgSc9zVBWP1PEec2JQMvpQEt6FSkyeTBNjIJC7zpmvVc2hHpgMmNjABNM+2eIUoGIBfmzbbKwaTu08LhjvD5Pjb15p01Ml/2rxWsh9cLiEPSszEnsxjpNPNaqNCaOgUk/xHhTLpDVyw6VzEjm2dnbwotw+kBv+LsuHjll2XrOvSgGVYX9G2eaLMj3wrZLUneosoOoZUXyGqEvoZx3kQtWLhQHX8s0bfDuO3jA8hBtUcRpqRk8jXY7rVXcvI5Rsz2jlhjz9U0wyCNya7KYXuP2Q96LRQ10HMQwDo46MT3751lFTsd2FWZh5PADEX+58j5zB0ku5i/J4NX8tjL07M2jOky+Wu6nhd+7ThWD/N/IRjEJcIpk2TP9aA74EVx6ORRQJ6blH8WBKjVd1PyZiu5d5cu9ilqx8DO+i/pRHjDNh4bA4h5+ov5wySw/W8gn56P/WXcz46bgzAS+Vkgc9dnGDehSbrsaGaghHceW8ROyELIZy83OQaCy8lyMKqMATQwABP6DlUpyg+CUYjbZmIrvcqJWvEj+b4IifIw/xCNalWzobU2nd4UJ/uI835xBbG
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cfdfda-1a8b-42c1-5bbf-08db987d69ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:07:41.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mpSOpcXbB4LRyMwlq0/GYRTjk/aR3EZpOU+8DOz8d7l/fepPSESJUMeh46xlATz8RzUPYdFmkSNnHxVuSerDfmWXgZQBrZu/S5TyKcuIz/NBqX3xSG3qAa6cic2VZWn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9660
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 02:08:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12573

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Thursday, August 3, 2023 5:13 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de; prabhakar.mahadev-lad.rj@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip] tty: serial: sh-sci: Fix sleepin=
g in
> atomic context
>=20
> Hi!
>=20
> > > Fix sleeping in atomic context warning as reported by the Smatch
> > > static checker tool by replacing disable_irq->disable_irq_nosync.
> > >
> > > Reported by: Dan Carpenter <dan.carpenter@linaro.org>
>=20
> > LGTM. I can apply if there are no comments.
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Looks good to me, too (both 5.10 and 6.1). Go ahead!
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20

Thank you, both applied.

Best regards,
  Nobuhiro


