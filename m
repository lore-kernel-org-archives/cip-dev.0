Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12418EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 09:57:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.9336.1689847025636660642
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 02:57:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 36K9uwLN260029; Thu, 20 Jul 2023 18:56:58 +0900
X-Iguazu-Qid: 2rWh1qS8006Zk0cHWi
X-Iguazu-QSIG: v=2; s=0; t=1689847018; q=2rWh1qS8006Zk0cHWi; m=iTV9uZvCAyPGLqFmmgcPpcGbIVTkrsmjzc2p0hUMfX0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 36K9uuHB3551634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Jul 2023 18:56:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAW0sEEsYCXMmW+LIurw3tia5XjbN+jbtejm0OhD1NSTtFcO1AvkrkPUU2mRlQvVvIXRrENg6mCLyzMfLSBDe5SYszEZDVjWwf9Y8jl4p7Wsz2orWgAhNo7YOh06vzfs1KRWaSHIMxvw+B3hBv5R/CPEeQmb0P8MxgjLYmPQLNA8XuxuCqYKl6cVctY3ZU7IQ4xn5eO8aXX31AwBEV8CVkfBQcwKobq2eg0xYJu9VhJEaPIUv7UNEM2y96LCw0OLnyGAHXSvlW6epIzL9UsjPkdwcb1DCDNs7/A2sO6tZKTTgqux/iPHbp0BuONfp7aGGBBqn+hn3zAtsoyHld1UXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf8g+Rx9MUso6UkF9uKtyaLSf3lvtym48dx+yPZ+sww=;
 b=JQEtHbch6YFPcKE9+HtBUIrDAuPMzPKoShxQpWqF3ziOnIkXMNVNqRcGf6wjeY3/o0Uw9vXLQts9wyyOgPi8waGLg0lrFiEv8FyYmbsetjMf/CTGxk1fgPlrOHjvdGskl/m8qfGFeV0KCHlDuHGBJpbeDlq4Ra4Cpa1j5osQ2peFC2J92IK58AthkXBsCHfdXhiTf3Iv618OfA9EN5WlIhJvhQJtnYBi3t2IB31qDaRqEVn701sZn3OzOg41BdggN7iFwYtWxqZe4dK20E/XpaBMGO9gGPSoLDkvdeS0+G13r5yEgD5RadsieHDytvIoYCJVm6boceSvILhKM88t9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <fabrizio.castro.jz@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Topic: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Index: AQHZuY0N8eyxyECesUSIVq2Il7Mutq/CbcMg
Date: Thu, 20 Jul 2023 09:56:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94206BB60C37FC05D49F8641923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB9965:EE_
x-ms-office365-filtering-correlation-id: 82ff8907-024f-41f4-6a86-08db8907a635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PLmVfErBPRuSXEIvCFqqTcbCJH0Fu1cqgiWgq2ko+VaDTU55yJi9S4wBtSnRMCKCCI8e5HoaSZfneM1hNKm4jZA3zmGrMoHCEPGgORHtkZLZIyeapkVU2EFdL7rTbz9OrcXX11TTpGab5Sz3h/0eh9LgSM7ND6V+RawJO3/IyAAa/z0zCk0e6Ncu1aWpnI/wGVAkmokO4Y0F14dAgi42+dhxAHBA6l9T5K3hrvSW+tiFCG/oJidvT8PBPGGsnq+o8b82tpgxzpY3JjW4y2a0Y5RB7U8xsvvw0s7SSi+QUdDTUEbP2FywaMEzZru3kya3hxEn1zv/9Js9WZT1JJqnkCV0tTiifQUuAu8IQjZaIXeSpgNlsxz0IECS6whrPzdU6KQq/JNdl0sado06Ylugtt2td7wIK7o0RtpY0mgQHdNKs8vx7suGJWldvCIYPnnYZ8micVi7bppELkSs3VUDM71XMz98lFnNQWCLyDF3esTF0cGs61pV04kM4UPmkBB+QvCXvJfWpbCdgnB+UBJBeY9HCyovqdq02S7lUQL5G0xQ+zI/wt8E7z1AzfFD7nr4ktwEJ8Aqp1H9EMidZ+pew77476jnV5jIXctxXx3IRVsR73Q88+xhRNTOi9FXfYXNYShdDMvDdbLB9ZYX7fgU+A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(53546011)(186003)(83380400001)(26005)(6506007)(54906003)(7696005)(122000001)(110136005)(38100700002)(8936002)(4326008)(64756008)(66476007)(66946007)(76116006)(9686003)(66556008)(66446008)(316002)(41300700001)(5660300002)(71200400001)(478600001)(8676002)(52536014)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Ly96SjFTL0ZzTk1aUzJnbzZOTkwrVGFsc0hYVEFqamlvdG51MVUvZXYv?=
 =?iso-2022-jp?B?dHlYQjFDbVZwVFQ4UFBQZCszWk5VZ0ZIUzJPVUpjWm85TVB0R291d29v?=
 =?iso-2022-jp?B?SGtnUHZpL1FWT2tmRHJJeUJ5VE51RHpxbDI0cXlSem91RHludGErQllV?=
 =?iso-2022-jp?B?Uk5EaC9WKzg3WE9CbFBJM0hjNjlaWWxIN215UFp6OHVVVXNid2Z3R1RF?=
 =?iso-2022-jp?B?aXQ0clVLRlBNbUk5M1hMbTIvTkl1b1dOdytBMWNEZGVBOHc2QTRoQXYv?=
 =?iso-2022-jp?B?OXhwUE5kbHpYbWJOUWI4Zi9SVnl1aytnNjJqWGErVTZZTVdqUlJBVnRR?=
 =?iso-2022-jp?B?eSt2UlRqTm1seGJ6Qm5jTHU1TDFXSUs0VEV3dWlPbDEydHdDcnF1VllJ?=
 =?iso-2022-jp?B?bUVJL3RRN1BwaWdxUURzUjh2cGlBU1BQL1E5ai9VVHBFbWpSeEp6S1RE?=
 =?iso-2022-jp?B?NVFmbVNpaVllYkVIUkt5dzhBZVFNNGZ6aE1DWkhocjE1SElQK3FnanFU?=
 =?iso-2022-jp?B?WlhTb3d6VFJXY0hxa3hPZTM5RkROU0N1NXZldUZ0dWFWNDliYUJVU0VW?=
 =?iso-2022-jp?B?Q25PVTRQQ1RyWTRzbDJMdGk1MEhtZ251aGgvODRzMFFYVzNtd0gwM2k1?=
 =?iso-2022-jp?B?SUpNOUlNWFluaGVlTzlpV05jSjZaaDFLNUNYcUQyaWhaSFlmeHVvL25y?=
 =?iso-2022-jp?B?N082NVhOVWJtcjdySjA5K1g3MTFhQnF0Sklad1F0YWgzVGMzUXJWMXVZ?=
 =?iso-2022-jp?B?T1paQ3AxYjNWTXBJaVNPL1c0OU1Rd3RxeG9hSlNVRU5IU3lDNVpsbjBi?=
 =?iso-2022-jp?B?R0hDcXZ5cXhDLys1RlJSaW5qbFNBYzRpd0IzOTBieG9HQlN6a29qYk9I?=
 =?iso-2022-jp?B?YkVGcUNzTHIrNlVuK05iVWFDbHVZR0twemNHR1FnR2Z5MFRic29XZ2Nx?=
 =?iso-2022-jp?B?UGZ0NkpRSnVJVnRLcExya3dlUVc5Sk5TUXRhN3UwYndjcnNKNURER0pI?=
 =?iso-2022-jp?B?QU5yVXlNTFdZNDkwM0N1YVMrYTJHMDMyTEF0TVN2dy90TXlpOFVxM1Nn?=
 =?iso-2022-jp?B?RU9ZU2RISlVBWnZMK05wTGdaY3N2SStIV3VEaU1sTEhNK3h1a2dmQjc3?=
 =?iso-2022-jp?B?RlBWS3ZzOTM0WmRNVXc2czk2cndlaUgvMXpXTlRyeDIzRmlvcG5JSWVT?=
 =?iso-2022-jp?B?RmVQT1lVRmoyRHVrbUVjOHpUbHJ1UkZpOVRPVHg5b3pDekxJVEZka3RZ?=
 =?iso-2022-jp?B?TTh4b2FQdERnbFRsdlU2c3FCR1ZaclB5S3RXb1dlRkx4SWZtTTYzUmEv?=
 =?iso-2022-jp?B?ZVlvdUlYRVlmL3E2N1RLQVVGakxaM0Z2Z1R0VEVUeE9VbURSOXM1M0Vi?=
 =?iso-2022-jp?B?T1F2bFBEVkJMUStmMTU3dTByeXNYTjBCUE9Odk5SSVdXRWcvczA5aURY?=
 =?iso-2022-jp?B?cEtPWmIzSDQ0WU9KTWsrdEQzVnRHTlpZbGJkbC9FaU9NcFVML213MWlk?=
 =?iso-2022-jp?B?U2c2UTR0clhGTFlSVVJaUlJ4aVA2bytPU3Y5T3dZYzAzak4zaGQvVytR?=
 =?iso-2022-jp?B?R1JrRkV0aXdleTBBdG4xamVlZm9qLzVKZ1BqY2JlZllONW1DYzZTWU9j?=
 =?iso-2022-jp?B?ZHdUY3czRFpqeEtRRVNlL082SjkwU2V0OTNqaXF6bEFOaThUK2NWOVRa?=
 =?iso-2022-jp?B?bmVBTmFPaVc3N3I3SmhxZGZxZU82QkY1L2pXbTB5amhZV3dGWWNRTER2?=
 =?iso-2022-jp?B?ZnpyM2VGMW9aNzlLZ1locnpOdnFUMFYzU3hudjhxRk1VSkJkTmMyem5Q?=
 =?iso-2022-jp?B?UHR0UW9KVG4yVFM1cEdEZGtDbGxyMXNjMnFPZEJCR09tcjN0L2ttYTBE?=
 =?iso-2022-jp?B?bGtOTEh3MVl1Q2Q3eDB1UEplT0hVZDdsMnpjeUZzNFRrdldYWmpsaG1B?=
 =?iso-2022-jp?B?dTZWWnl1ek8vZkI5dm9hSjBUYk9LSFJ0cDVtOUVzb1RzRHJLZEtidDQ1?=
 =?iso-2022-jp?B?NTRCSmFDRXgyRGdtQTQ3QzZPUDZXUytkRy83U3BQRXdRYlNFVjJVUVlH?=
 =?iso-2022-jp?B?ZGJ0U1pmeml1ZzhEeU1jeDA2QnVIdmVENG54SVozb3pkMWJLaU1OQnIw?=
 =?iso-2022-jp?B?b29iL09nS1V4TWFJakxHd1RHaUIya25FdmhWRTZEbGd1andPR1p4czgx?=
 =?iso-2022-jp?B?K0xGUkpMSW4vdjAyZTJ4dE4rMTNnTXYzVEMxLzNXandJZkFQSHZDV1dP?=
 =?iso-2022-jp?B?aGVjTENZekZDMTVkRUpzK2poZmd6RjdId00yeDkySGlzcDlBSkVod3ZI?=
 =?iso-2022-jp?B?MHM2OUF6V3ovWTMyYzdzQk96UVFER09UeFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X0yMykwbn3jfyN7i6egGtI5Jh9u7yYjW03SsbMo86od4Bd38YuWBKFW02YMEHm1L/Ojyfp5kZyloYPU5TTK5BUY5fnTRyx53Q7XSoi7FwKbsFgTyAqE5jUzksiz9A8jTBxWrVyY3ZRFJp3rl5kUBA/29j8KV28eEOemhghk8MkwsDfmlzg9xC9o6gSwZ8OdW1K08F/cr0c1maK+e5gN05Lfjk3koE49M62jBZvyaDxCX5FjyU7DS+U00CU9VBjDNtaMNs2N5rPeUrR6kqW6t2p/EcZTrmPbX8KREMPL33oRM8wYRL+d0XI5bM6DAl0JyUCo67E7iWi4MG7e5NhBLZYfGpijog/nRiC0+ni6zazfLrtzqE4kd/srrYcwtUSAEjPvfydgRwaFs5ILs9ueiVhftfoV3KAX6Qwm7XwL5ji8mMPbmK4NPgDyaYoQYVNK96mOXnnoGHl5CUyT6HB/ARPm53NZvaIwEMgAuz3nUXn2HUEGENIQSSZmWr5ZifFFRpFD8KVKui9D7TsO5JDWjwiDSaTDOt5yXeBGNn7X9hmBvjuz+w4ZB5YdzPRD44UKQC5M8UEjt77LEKA7NbPiPQEqaXIPfvgkLBlnWy0+YFY1m6eYFiPRAdy/beGsEI828iU0jiuDgmDkC80NsqdivRKE+2ors/lQ9+5x0Qfvn3iCtHRShxYwqh693p8QVpzaQQUjapKnrI+E0LwwMWcYa6dZOyk1lYMKO0XSqN8n61VE2WCpuPikztnZklelTd7VbgHXd3I+Jp0LgjE8UBPJxi8X3M5SAl0zd6jbnEfo9/p3k881JYrZR5a/1gSq5gVAiREo/1fAOTTalzgAdHg4LiAJJMF+ralxHHPb6TKkHKCNPnlqQcyeMk9p/80KYVX7f7xE5kkWQJYVgsNO4J028ng==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ff8907-024f-41f4-6a86-08db8907a635
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 09:56:54.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZFygApoa3ku69SnMrQ9lG8I7uDWCG6M1k2M01POHV+MKpR1U02j4gAkSNLvczui71DDD8o5x8X6r+gNZDno4AIxzVyDuVTR0WG5Iid3z8smRW/GTpyuKUIGeS0nEL0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 09:57:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12442

Hi all,

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: Wednesday, July 19, 2023 12:32 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
>=20
> Dear All,
>=20
> this series adds eMMC/SDHI support to the Renesas RZ/V2M EVK v2
> platform.
> All the patches are cherry-picked from mainline.
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
> Geert Uytterhoeven (1):
>   pinctrl: renesas: rzv2m: Handle non-unique subnode names
>=20
> Phil Edworthy (1):
>   clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries

I reviewed this series, LGTM. I can apply if there are no comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


