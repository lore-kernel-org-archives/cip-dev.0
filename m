Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6558ECAAA2
	for <webhook@archiver.kernel.org>; Mon, 29 Aug 2022 05:14:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.67135.1661750045455121728
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Aug 2022 22:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 27T5DreQ027306;
 Mon, 29 Aug 2022 14:13:53 +0900
X-Iguazu-Qid: 2wGqjFaMJGQi28EVqU
X-Iguazu-QSIG: v=2; s=0; t=1661750033; q=2wGqjFaMJGQi28EVqU;
 m=H2m6xrMEEylNDjtPn/EIN9QXFXMHT5tfuIP2YhnLlwQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1111) id 27T5Dpxo015009
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Aug 2022 14:13:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB9KKI9+1dE9Z4GDIq7nPgv//aXQokY6awjOwcEOwk0xtW5pehMUdswgvJvUmBeMvyTGp0dfoOKMHvr96nUpZd10CXOZJnUn07P7Ij0+R1ZzwyuVx9/hG79QjuwjyE41DpimSEmWB9bMz1+jlAu5VWBLqhYafPeAVFymTH+hKV13Ujwbph6aIPxbHz3SAJ41EUjU/8TdX89NTXqtdUP6dqJ5p3lcsiWpF/EZ9E+4INIaZ7LQA1ZurHoBPVME2M3rv334XG0S26wgZzuxkiPQ39CM6LhTUfFqdK4stMEQvwUjZwpFM4pUO9DLOsQ01aObio2fV6uOUOEdlM3Xu55HFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP3SsVt0rT6DHf5DLKaup4fw7I4jExTkn5M73dQhlqM=;
 b=S2C1cRtNM+dkBSgne+3u0Zg0+BobVtyXbdgKbbIZs7I1SRXLZ+GII3VHAf71Q7C3R9UIoYENLhAq9THgPlWrztXwLuIaFkhbSZgKxfU9AEWuhBJk0GFe6+f5xb96UenCH49siQ8MSAhks84CRGB70E/TG0HaACCuTJZURlb2zRnoVIcSSQ6AuffzcesIxw5SavzxIJdOilupVlrGqHur/rrTQqL7FKWyQS9/cpE+iBZqSMSqiJHPaBteBiqtHBPL1Hl+KzebeW28FUy8Xac0w3o+E6F7QK3d95hbDBfCwFhvO75gDPAQjY9GGp8wSHDI9x0qGYTg7vCtqWsfCLHM9w==
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
Thread-Index: AQHYtx9zAqb9yL1TAEaR46k4FGqz1a29SgewgAgTxCA=
Date: Mon, 29 Aug 2022 05:13:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94208912218383B8981C322892769@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220823183729.29203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB9420F6E288EE7FFBBB0D133892739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420F6E288EE7FFBBB0D133892739@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b8ede7a-ccdf-4afd-bd3b-08da897d418c
x-ms-traffictypediagnostic: TY2PR01MB2426:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8L96PzeTDOWmVQVa/A/pns3hspq3QhCHYLvrj3d1GNRPVjB1rccSkrvmsKCe2D+W02ue98Fvqr6lomxAb2OhOEY5qFAdTiOrTZvuGuz6gOHV/sQHtndZtMUEKjw4lU2PZEhHDGhETV5+a7sDT9TWXRM3M6hzgCFs34SA7Mfpu8ty7TsLBAyqBy9rZAtNNBhJb0HPu9S2khmidsA2AGYr1j4H/Kd4G2NRTThbA3I3HRJyTIVAbUO8076pwuh+V/4nm0MUEKbSf88/HBqblX7uTJTxGTw+uTfkuqPftsdxR4FsL8wEuudDzxPP+kAl0vs+2pWI11ZF9iiILKCkQ3x69uWs7sBN9e/Rsko98SFC3kzNiBBe3Gbiccc2dWFX7tNDvc2IgnAnqwjboWTbwsCKlYOZNmF8OFIxKJ0uUa/cN55cNn+NOPTpfTgw1kwf1OWPqnW1tD3ezs0M8YjLmj1zqI8gGG9kJwiGdAdxlBplH+fRLLoFpN/gv+qzHnn7gVcHn0koejy8tPjERB7y0JTHYZZpqdbNRL4pMjUuCokFvjxhVR+nP7j2MS6gs7cHpwGS3fblitmz0PCIlIiJQgyQSYMK4Jy1c9LTp3AVNL/bOUavBBiSsSGQlc12jsXn/p4hACQl3hTS4pRZbuwXaamOCi2qby9P7MvOFfNAJEtzZVWK8CK6anfVy/OjJmp+vSYAW3zgOiiXp1gjcLpIjASU4bMR6Bfpk6/50S5rHoYUrmltLPFbFHGajKy8iPfJ0sgEa+kmyCOh6uSpY6sLY+MSNCEzX9O5uZYOyuCPSTLwVmwXeFLxesdBQ6FwZ/wJrhOfit7Ph/X7vLSP6XhJBvfIhA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(55016003)(2906002)(4326008)(66946007)(8676002)(66476007)(64756008)(66556008)(66446008)(76116006)(110136005)(8936002)(9686003)(7696005)(53546011)(6506007)(478600001)(316002)(33656002)(26005)(71200400001)(966005)(41300700001)(86362001)(186003)(122000001)(38070700005)(83380400001)(5660300002)(52536014)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y2d3ZnU2OWo0RElKWFltMXFhK2hqMU9MZTJxT0EwYWdCVGkwOGVNL053?=
 =?iso-2022-jp?B?cjgwY1F3eUVQN1Iyck5za0ZjRmI3empXTHppQ0JzQkxFLy9vdTBJaTNO?=
 =?iso-2022-jp?B?VlhnenVsZXVMUElTRTVkMFlGNTdoUDMxRVJXTXZ0MGI1alRObFNYNExB?=
 =?iso-2022-jp?B?S2FsY3UrVTEveWUyYjJSZGhLT09GakYvQnE4V2ZPWjlWdHZkcHBuSzNB?=
 =?iso-2022-jp?B?eDMrcVVrblQ1bWg5SGZHUGRmZjdkK3RVRHV6bTJJak9TN1NUMW43THdh?=
 =?iso-2022-jp?B?THRaVzQxWHkwaDJlMEU4M3hwTmVBdkpYdlZFTHdacmFRNGRjWFBjekQv?=
 =?iso-2022-jp?B?dWdNcmlGUnJyczhrOXBVRnZ1Q0ZiRnA0RkdsbHM0dUlveWJUNTlWZWht?=
 =?iso-2022-jp?B?MW9yK0pUdDE4YmdValRRNGRReWFkS0xVNjJ0RGI3Rk9DWTlOMzlMS2hB?=
 =?iso-2022-jp?B?N0RpV0owRXNYV1AyWjFQMnUvZjcvWGd2dGdTNEtpemlCRFF2TEhYd3VB?=
 =?iso-2022-jp?B?ZENwVGFqZ0RwUUk4ck5QTEsvK2xIUExzMGpQeklZaWpuRkt3SHYzSkZz?=
 =?iso-2022-jp?B?ZmNSS3A4bXZkUE1xV25iQ3FmSDBFU0VVZ2hlNTI1SWQwWGhzdklnVVRC?=
 =?iso-2022-jp?B?emtUYXJ2TTZBWWtPL01LV1FLbUM0Uzc4UlgrV29pVFVvYnBrbXVNa3dw?=
 =?iso-2022-jp?B?M1B6NzZCZ2dnUEQyT3RLRHFrdE1kcmNMOFdpZlNBem9KTXl3OUxsb3FR?=
 =?iso-2022-jp?B?RzdESEhzZCs1SThHVEZQdjVJU1MwMjd4N0N0VmMwNzNHVDNFV3FFQm9L?=
 =?iso-2022-jp?B?LzY3YXhidVNzUVJUTThiYVErRWJnclBIZERoL01IbkE4TC9IMmhlbDIr?=
 =?iso-2022-jp?B?TjAyVDR6dzNOdjhRWEl3Zmk0QmFNeElnSTNTa1IvdHdnN0xJTXRJMEk4?=
 =?iso-2022-jp?B?MlU5cmpoN1l3WmFrbEQxdU0wMHloQzlydExONFF3UHUxbFZyNW5ZbUx1?=
 =?iso-2022-jp?B?MUpvc1FTN2VwQWRzTlE4Tk1TV0lGWjZUUlMreVpnRVhwYlYxcnB2dEp1?=
 =?iso-2022-jp?B?MU1GZWNvTlU1dC9Ob2VzOVlrdzgydnFPQzVIeUNFRGFIVU53SkkrZHBl?=
 =?iso-2022-jp?B?TTBTa3J5SUppWVl3eWY1UE85YWFwNmRZa29naG5Tc1NwSUZJazNjRlNx?=
 =?iso-2022-jp?B?UUJDZEF0UFM0MjBLSEpnT1ZEVnVyMjRaeE5SSEVycEN3d2NXNUpNaHpM?=
 =?iso-2022-jp?B?b1g4ZkNhUnlYT3luWVh4OEVnUW5mNDRzUGFLclJOWUxKN1VBeUR1Q1k4?=
 =?iso-2022-jp?B?eWVzR1dIR0lqQWhGelJnMm9wQzlBN2l3ZzVUQ3dmbWREdEdUT0J5aG42?=
 =?iso-2022-jp?B?eml0bURHU1cyNmN2RlVWWW95ME93d285cGNIQ0psVmJCTFVSWHF1aVRq?=
 =?iso-2022-jp?B?akZkdzg0TlU3Z2hRcGwyOFVOWFJzVnVEZis2SFNocytQbWRRSVNNOUVB?=
 =?iso-2022-jp?B?aU1YMWs5ZkhLWU83MVVMRDVNbWhCOUpXZ2lEbjlySk0xVjdWazYzekVC?=
 =?iso-2022-jp?B?Nzh1R1k4ZEwraUI3RXdtbkRtWUhWeTJlOUFINzRnZDR1Y1lDbWRoTWU3?=
 =?iso-2022-jp?B?L3hocjNPWHhUV1NDMStXR1YwYkkrWnphTEhnRWpKSVZ1K3Nxcm8xWllT?=
 =?iso-2022-jp?B?ZDNwQjI5QkUwRHdhWWFheGQ1eGFWQ3RYZkl1V0RGeU1tUW9qVmJQVDhH?=
 =?iso-2022-jp?B?d09zMy96ZmgwRE5vVVVJSHJlRWFLYzdUWjVqYnlvZm5nZGNYQkVuN2Ur?=
 =?iso-2022-jp?B?MUhTblFCSGhSQythaU53SGtJS3RZbU5QVlBYZ09WRGRNU3A2bUR6SnhQ?=
 =?iso-2022-jp?B?aEptSUt5SWZiRlplS2VITDl6OHFaMy9kN0ZYdzhQTWE5Q0xqMG5kSWZY?=
 =?iso-2022-jp?B?QXMzcUU3R1BhWnQ0ZEpxSXJHdjZLNlBDaU8wZ0R3ckY4TWZzQ294bTQw?=
 =?iso-2022-jp?B?OW5IZkcwV0Y1SXRtZ3YyaEdpQ2tkbTd3eHZGSTNnbGxFNCt3RjJMcGNP?=
 =?iso-2022-jp?B?NU92MFp3OHpxdTNmRng5R20vV0luWnc2NTNiZmtRaFZ2ejdoTGpXdzU4?=
 =?iso-2022-jp?B?c2wxK0tUZEloR2NjaEQzQVkvOFFzVnQ2OGdWbkFwQWExWklUbmJSaHcx?=
 =?iso-2022-jp?B?T1hHVThJM2NEY0hNS0M0endhK0p1aFJ2YWZDOWpRSGkwek90ckM1aUpY?=
 =?iso-2022-jp?B?anpPWTgvY2MvMGJWTFVvbUhvemFINlVLVWlYaTB1OUtNR1dkTURmUjFn?=
 =?iso-2022-jp?B?MnJWVnJKeVlqTk43cERZRlNLWCtFNFhyQlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9b8ede7a-ccdf-4afd-bd3b-08da897d418c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 05:13:48.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 La3fT6wnRA/Q7/x1/WnYTDk3tXYykzMh7E+3qs5GUVNHx2dbfzmUAFZ4wL50wy7gFQZqdHflVFyDZiuYx+FPC9aINhyJoBF2ThVT30A2jTs5gYrdWRJ+Mwf4T+0azM2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2426
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Aug 2022 05:14:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9321

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C=
#T=1B(B)
> Sent: Wednesday, August 24, 2022 10:55 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip] PCI: Drop PCIE_RCAR config option
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Wednesday, August 24, 2022 3:37 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#S#W#C"~=1B(B
> =1B$B#A=1B(B
> > =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip] PCI: Drop PCIE_RCAR config option
> >
> > commit ff591f7490cffef49c022e802b64499edb6137b6 upstream.
> >
> > All the defconfig files have replaced PCIE_RCAR config option with
> > PCIE_RCAR_HOST config option which built the same driver, so we can
> > now safely drop PCIE_RCAR config option.
> >
> > Link:
> > https://lore.kernel.org/r/20201229170848.18482-1-prabhakar.mahadev-lad
> > .rj
> > @bp.renesas.com
> > Signed-off-by: Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Note:
> > - All the defconfig files have been updated to use PCIE_RCAR_HOST
> > - MR has been issued for cip-kernel-config [0] [0]
> > https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_re
> > ques
> > ts/70
> > ---
> >  drivers/pci/controller/Kconfig | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig index 64e2f5e379aa..0d98d8dd448b
> > 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -55,15 +55,6 @@ config PCI_RCAR_GEN2
> >  	  There are 3 internal PCI controllers available with a single
> >  	  built-in EHCI/OHCI host controller present on each one.
> >
> > -config PCIE_RCAR
> > -	bool "Renesas R-Car PCIe controller"
> > -	depends on ARCH_RENESAS || COMPILE_TEST
> > -	depends on PCI_MSI_IRQ_DOMAIN
> > -	select PCIE_RCAR_HOST
> > -	help
> > -	  Say Y here if you want PCIe controller support on R-Car SoCs.
> > -	  This option will be removed after arm64 defconfig is updated.
> > -
> >  config PCIE_RCAR_HOST
> >  	bool "Renesas R-Car PCIe host controller"
> >  	depends on ARCH_RENESAS || COMPILE_TEST
> > --
> > 2.17.1
>=20
> LGTM. If there are no other comments, I can apply this.
> Test pilpeline:
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/6210980=
21

Applied to 5.10.y-cip tree.

Best regards,
  Nobuhiro



