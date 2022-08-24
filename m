Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B95C32793
	for <webhook@archiver.kernel.org>; Wed, 24 Aug 2022 01:55:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.6359.1661306119781345779
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Aug 2022 18:55:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 27O1tD2x017553;
 Wed, 24 Aug 2022 10:55:13 +0900
X-Iguazu-Qid: 2wGr4t84ToSlXBvMwT
X-Iguazu-QSIG: v=2; s=0; t=1661306112; q=2wGr4t84ToSlXBvMwT;
 m=HBJ7eMWnIiwpn1tbiuUfKzz2jtxnOa2UL9vq8HHRNS4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 27O1tCrR037029
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Aug 2022 10:55:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAy51c40QxNqCDcFurWFhxWf7dnrm7tbcJvjSY8fSc3rpw/laBrvdq/fGAaisHi1tAihyuQezxIr6ZR670/YRghEAQ09KUTBqUnlRKr1dLYOOgZws8Fjxg0F20B6Nn7cG3Kk82S75mPgl3v/dit2GF+mDRu0lklPx703mOyaWazzYVlofeFEJ6nq0StohFwMLOsD1EXjq+Ti1GWjAxy/wn1pN5DVq9G+ZCqiL5FQiHD47bR6xtLr9lsTpSgT2EjJOjd1uWGHurhMAE433uCZWfOX2PCpUAOG0YMGfEpEtvKyfbVe+YpR0cY/18r9IA3bRd/i/psIlN0XIkTN2sI91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5CS6AhIjskd9ilI2XvDMQ+zRH0JzH/5i7O3NSoz5MY=;
 b=A1pizeuNyvbQnuRko1yFqOY5JTAi8jO6SlN9Z/9FL1Ry9PS5mdAqVkhOOwvFktFPc1yE3kFVEtqlOLiexML46NgIMl8K7569X63ZfjmKhld1OhQsmGaNEcpJPnsc0nJyFXkFnL0TSKFpUPu/KgoZU8EWoSCiuXeRe1/k3WH96JwAIcrcmSwz1kgsHfrF/JDZPiOgYsCARJSVshorqtzttoKMpcbMnoabOU2fFNgff5vso4QNejI4nFu0cuRPHbDAbTE/bJLR+hozNIPO9FfgYwOL0xgo1KTlum3LZWkkAB13NfXgK2TKiDomDN+5bd3eB9EfDoqr0xLmb8p1upJ52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] PCI: Drop PCIE_RCAR config option
Thread-Topic: [PATCH 5.10.y-cip] PCI: Drop PCIE_RCAR config option
Thread-Index: AQHYtx9zAqb9yL1TAEaR46k4FGqz1a29Sgew
Date: Wed, 24 Aug 2022 01:55:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420F6E288EE7FFBBB0D133892739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220823183729.29203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220823183729.29203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 013654e4-f6f2-4339-eb98-08da8573acdf
x-ms-traffictypediagnostic: TYAPR01MB2254:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wMZrYdonVaBp1Y9Pso7jbYjrVZbJyHVJw0OkxQnv9IAmiCoIoaz7Vjv9bqOCxW/WN+1HZF2qI/Q0y+R+TjbfA8zxHyTOwfkjhCco5Ve/f8cGT+Sr6AuYxyBLgDkeNbOl3qB6nd30tW9IdpNdC2oGNc7z5mkmW+10St7uHmlWX8yWg4ux7aKEB0E9E2GgACGiFL7y8/QdgGFlXFeJlfr3kLKyKlQ4wjjPr+KpMQgMpBcT1VsJSSmnD9JeAiCeOpCwJEmpcUPlRNvqo+2aMUUP3EMaYx2zQ11YPW7GcUgTYZJQkdvpNQswGNqgWtJ65F/NA3nAbcrACfhkWS//vc02g1YtrWBFe1MnYMbSFMQxojAnIizS627CQfOPWXDOZv39jp9SltO8oklCzu/HF6OsUsRLE4Bdh4o3qWJu6e3geYxLyc9EBkVKlZ9Wy/KeNMUzvAbzSOyZ4tHqpPPI59Mqpz1uqImYpFsV0yHjZ/bvx1jThRt+rUzCL7TqhCPi/pfRFAgBBqUEaGP1MK5XFiQ24C0ZI1LSoiGScRa99e8OtMtOSMyhTTXnoOjmH1CU1hYyQKNO8TVwVpAqlasufp5q8ab4Zc/rwAWjChBqGUQ6WddTWdKgh6N0giHomR/t6/7abRqD6kNNm2S//hDS+xQOlWg/bjjQ5M3o7L+tYJwZR1jlzONMlIg8l4jlS12J1Tkk3UGlasL2vbP6b01EPiqAQFQ5AlqQAu52v03hHHvC17BZCUpkJ1E8VF+OWbLneIpblsXI7FkYD5y1jMHOYQQ+we8wP8HD1bqCeycy5deZfm6X4RO0lzJLocqQ/UrTobQMuboLOWfsEVTA6fyNW/pFGQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(41300700001)(6506007)(7696005)(9686003)(53546011)(26005)(33656002)(86362001)(38070700005)(83380400001)(186003)(478600001)(966005)(71200400001)(4326008)(76116006)(110136005)(66946007)(66446008)(8676002)(64756008)(66556008)(66476007)(316002)(38100700002)(55016003)(5660300002)(52536014)(8936002)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SlV0NFpqbUR6QkorZ25INDFBZWUyUWkvdlkxY3FUOUdQSXp6aHg0M2Zh?=
 =?iso-2022-jp?B?RUNSVVlSWW9rbk5TRzR4d0FhRzZPZXV2S2NKQkVEUndqSUZWZ1JKclE4?=
 =?iso-2022-jp?B?Z2JzRlJJSFNPZ2ZTRndpMXRabGVob0pGblpMYUIzN2ovaGsvd1ZXc0V4?=
 =?iso-2022-jp?B?MkJrQWFYeGJpVkJLUENEN0hLZlBFTmJpemsySW90SDZhd05Mak5XZTd1?=
 =?iso-2022-jp?B?TU1kdjhWRVFFcDZMSjZpMXVocnlYOTRZQk84M2c2UnQ0dnh2ZlBGNFJD?=
 =?iso-2022-jp?B?ekJncHI1cnRaek5uMjNtTHlVOHNFZEVXNmtkcEt1Y3hlNGNyb0RtNkts?=
 =?iso-2022-jp?B?d1BNdzZFZHZhZHRzTTMvTjVQUm0wSGorOVVFOHpQT3RMeFBiTEx5cnhW?=
 =?iso-2022-jp?B?Z3lvNWZOTkJwaS95RG00NG16NWRTcFB1dnRhOFpINDh1MUxJeVpEdVFR?=
 =?iso-2022-jp?B?dnp5NkpzMUNyNTdtcDVjVzVpWld1QWZxdjZjeFhtKytDdlUxVENBWW52?=
 =?iso-2022-jp?B?NUVtZ2J5TlRIZkcxYUxSdzl1NHdRTzNmZWtTcmlMbXpmRHU3cW05Ukw3?=
 =?iso-2022-jp?B?WCtsWTVzYTI0dlVXVmQ4ODZPV0tJbjlFYTdNQzViMEQ0WHVsdDBSelNi?=
 =?iso-2022-jp?B?aEpGNUlWUHo5WDJBeHpiWUpWdko3UGRUb2FRTVFzMkRUaDk0QWQwSUZY?=
 =?iso-2022-jp?B?V0ZWclNWMk5RRWI4ZFJUUUZ6NHM4SlZ0ZGZJc3RIK1JaY0V4WCt0R2RT?=
 =?iso-2022-jp?B?TFg1dysrVys3WXhMZ3ErZENEUzFwUDBrdmVFdk5WMitEUCtpeVRKZWFZ?=
 =?iso-2022-jp?B?Y2hYdkFBMHJNTHBhSnAvczJPSHFUU0FrQk0xMmZzZWVhK0FWMTE2T3hp?=
 =?iso-2022-jp?B?MEEzRkQvKzV5ZVFoZmxZbFF4R01OUkVkZmdNUWJIbDVWZEVuMyt2MXZP?=
 =?iso-2022-jp?B?R3JUQ2tETlE5OElIeVM4R3RXcjNPMyszWlNNQm1haHZuN2pINThINnVL?=
 =?iso-2022-jp?B?Ujd4STJhMEwzY3NyYWphaDRYaHlEamtjUm1nMkVFZDlkQ216QkdlKy9Z?=
 =?iso-2022-jp?B?TGN2Qkk4SmFocHZxc3I5eWhzVWxnOSsxMUllMkdkcjZaZlNBVUZGNWdN?=
 =?iso-2022-jp?B?cTdIMDJ4Q09uWWNzUXZCaG1kVnFJTEJyWVZSblZSaERjejVYbVJDRHNQ?=
 =?iso-2022-jp?B?V1lnNXNyWjFZU1hMSGRlcDRlV1ZCbGxuR3RpMi9QWlkvSmVBYmdsSWo4?=
 =?iso-2022-jp?B?a0sxaGlsVWxjSXV0S3o5bDFrWUphQ1BiYTZIS1JudGlRZWRKSnBYNzlv?=
 =?iso-2022-jp?B?QjRDQlFiOFFORGcxKysxekJxYzVEcDRQaDg0Z3I1VHJXNmQ5a25IV2RZ?=
 =?iso-2022-jp?B?eUZyYzNMTENUc3hlRjhwRkh1a0NGSWcwYjBTUlBsSkZxdUZrT2hCVWxD?=
 =?iso-2022-jp?B?V0RMVEVPVE5YcHNDRnJQRnJ3VStydysyZFk2ayt6OXRyOE9nK0tNYUFB?=
 =?iso-2022-jp?B?c1ZEVk1RUi80NWd6TzlJTUhSZEM2QkJpUDVyT1ErRG95QlIrLy9VQzhu?=
 =?iso-2022-jp?B?R1p2b1FSb2NlTVdhNHFUeG1GRkxMMDdiMnEyOVc5RXloMUdGM1NUUnM1?=
 =?iso-2022-jp?B?MzJvRmdsWXBQOGgyZXNoNE5Hd2dORkoxNHEvVlpSVXFQa1dXZlphN3BR?=
 =?iso-2022-jp?B?UG9TUXFVWFhHYVlWcXhteHVxYlZtbE9RUVJvSjQySDBRQVFTWGhCS2pa?=
 =?iso-2022-jp?B?Qm9seWVKVW5qeUFZeGJMejNHZW9ZdmI3ZmVMYkZDbVY2Q0ZUR3hiWW9C?=
 =?iso-2022-jp?B?Mmd4SnVhMEZURjFCcFZYUk56UTFVZHJtMlZtV0Y1clhOSnpBNDBmbUs3?=
 =?iso-2022-jp?B?dG9nY1JSTnd1U3hSK2liYUI4MTVkRjdEMGl2UElvT21Qd0dkWjU4dWRt?=
 =?iso-2022-jp?B?WDJmUHJOMWhaVmk3TmRkeWlPdHJzOHBQemw1VjdiV084Y0RXdmtWb3hZ?=
 =?iso-2022-jp?B?ZUhLNWJ3ejE4SjlTejgyV3MxWnZmQlpONUtBSEdWam05L0lzMklwdjFJ?=
 =?iso-2022-jp?B?cEFSOHFjbGM1RCtuS2tUUEFMQTBRQzM4c1lCaHMyWXl5cjlEbGp5aG1z?=
 =?iso-2022-jp?B?ZkRTUUhHY0N3QXpmOUtEbjAxOFVXZlprbHlGNkc3aXFxOG5nTE9NVXBz?=
 =?iso-2022-jp?B?Y21Fbkc1RGk1RGZLWkxJTlJ5Umt5TnZTK0lqZjY1NWprb3ZXWVJReEZa?=
 =?iso-2022-jp?B?aWl1b1kyVXNoa1V6eFBIRmptRlZzNTY1ZWNZVU5mdFpGeHZ2OWtYbTV3?=
 =?iso-2022-jp?B?OER1WERwNWo1b0NUanVqV0hBM1hZdTBJTGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 013654e4-f6f2-4339-eb98-08da8573acdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 01:55:09.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 y0Oe4e4eP/bkh1HyG58KJMVvn29Iwd9XGNBVg+P6i2n5mjjycTmu8LbeHeYNw4Elg0YfMAJYe0sqGuY/0+dYU7oJOAg1/6Eni79zMOCvEKpBtoy1MsC8rgF7XbvEbz0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2254
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Aug 2022 01:55:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9316

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Wednesday, August 24, 2022 3:37 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip] PCI: Drop PCIE_RCAR config option
>=20
> commit ff591f7490cffef49c022e802b64499edb6137b6 upstream.
>=20
> All the defconfig files have replaced PCIE_RCAR config option with
> PCIE_RCAR_HOST config option which built the same driver, so we can now
> safely drop PCIE_RCAR config option.
>=20
> Link:
> https://lore.kernel.org/r/20201229170848.18482-1-prabhakar.mahadev-lad.rj
> @bp.renesas.com
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note:
> - All the defconfig files have been updated to use PCIE_RCAR_HOST
> - MR has been issued for cip-kernel-config [0] [0]
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_reque=
s
> ts/70
> ---
>  drivers/pci/controller/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 64e2f5e379aa..0d98d8dd448b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -55,15 +55,6 @@ config PCI_RCAR_GEN2
>  	  There are 3 internal PCI controllers available with a single
>  	  built-in EHCI/OHCI host controller present on each one.
>=20
> -config PCIE_RCAR
> -	bool "Renesas R-Car PCIe controller"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_RCAR_HOST
> -	help
> -	  Say Y here if you want PCIe controller support on R-Car SoCs.
> -	  This option will be removed after arm64 defconfig is updated.
> -
>  config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe host controller"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> --
> 2.17.1

LGTM. If there are no other comments, I can apply this.
Test pilpeline:
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/621098021

Best regards,
  Nobuhiro


