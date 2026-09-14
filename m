Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6641C88E67
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:04:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14101.1789365871938330585
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 23:04:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ZWJzyN9N;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789365870;x=1790575470;bh=IMoh/c4dQt0YrtYNwvsELN9rs2kkrxvkCH5gZ
	pMNayw=;b=ZWJzyN9NeQjYWr4UNP0O6jtJgqx+/EoNie6yTL/hISGpcrQ9omt9oHvXiqrD99P3meM
	curRw8phVqLoHahrkyoWPyW5xWoKu0pIDLSxE/+AIH1+NgbNQbS1J2r8ntNzFM61EqMCr9tbpSMTG
	3Okuk3KHwO0gC8aF3YHXO4eJG2TNONUhyozqBoGiVuEVyXG2uz3yUW/O/C9DGhpuCl7fc1ZpQv9lF
	vPLb6y2/Pg1Rh3Sapu4VZ32AQmeasD9ijNcoMaPSo5OFtj2PWyYYNumL6Ep1vccrULFa5rOKYNtNa
	GqecDRoTyjthIIp0rKv252149Pkw+Gno2oj4OJLpDfMQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 68E64UfL2087699; Mon, 14 Sep 2026 15:04:30 +0900
X-Iguazu-Qid: 2yAahSAkWTIsawjG6V
X-Iguazu-QSIG: v=2; s=1; t=1789365870; q=2yAahSAkWTIsawjG6V; m=tA41EgtyIlFwltZzgaX0+FlAV/24KQMjCj5zSLsYc4M=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hjvk56fhzzyPQ; Mon, 14 Sep 2026 15:04:29 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2vG2h61b18sLIcywzZOnRK3bAUc9JYHS8PrGOsQz2yO14GAOd+UeO57RhWhkgXOh7ocN4f9VUrltFqxnvIT+2u9Et8p7zUIV2jeYV9OJbNvhODJe98Z5T2bMCugfia3xK/bc6QzuWorh6t1s4t1k3T9zrDSDMxysTpq3LWjzhVNM0gEv+XtaHfFM29WQ0EpUszlrjzOYzspOBXTUWa1Lo53+9+6+2bt45D+J5jlp6skqgfedzknzDLuJunvx+MuVBUcjgW5jgeA6jh8Q9jYkHgMoK0nexS8illWJpcwAVD8i6WGBft1Qd7C0wH/TCj1XdZZFAphj/Okcr4P3X9yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvhuiIl1YUNOrd98XkPNngIQgNrmSn7dRG6b3rcduqc=;
 b=smwmHHB1lldZemPTZGWo9QjjD8LuYfYPVWmYUVwO26NhAzrp1BWczZSCEOHzoy+lL5jUJ3d1ZoMlWRg2XpfMU8r0POm/UE2AEQ5ykguRyCrtlPzFoU/LvpkF2gtFnNQod+bSiBsX7CBDoxtnss2gEpDPmic7J9rVDk6JFhPofazsIqUyNSeBTK/eDZt7wG/pJOEBVDdV7x81qvQIWBjrF1UK8thVeSPii9EIifvc53Lx3ez54TanGSCRZVGMwdi1Ajv8GQgK8RvjMenbzzvU6l/5FvxgS/3e11WM0OPG3O5ZIlpb8ScA3iBX8kTfG5G6KooK3xVXDhwpQBe1eIGFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH linux-6.12.y-cip 0/2] mmc: renesas_sdhi: Backport support
 for RZ/G2{E,N}
Thread-Topic: [PATCH linux-6.12.y-cip 0/2] mmc: renesas_sdhi: Backport support
 for RZ/G2{E,N}
Thread-Index: AQHdQfZO6OPfuj3fSE66J5FNRZDwWrbNmc6Q
Date: Mon, 14 Sep 2026 06:04:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188FD3311B30DB2C98085DCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260911140311.2119765-1-claudiu.beznea@tuxon.dev>
In-Reply-To: <20260911140311.2119765-1-claudiu.beznea@tuxon.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9574:EE_
x-ms-office365-filtering-correlation-id: 5df1b739-d466-4a45-51a7-08df122608f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 zTKkkXIh9S2UNgUSeGFg1YkQqtofuVd0DLMA6S72xi/tNrWeVPSKgbQujpYZ4+LYcf9LGwY+r9SG6M6oxD6XChbyFPdkJpUPh+61Sww5fDtk1VaxRZsO8XmKTAExPgu3IAnZAzkOjQ9SUXJNJFOCb1oQUcf2qgrvC0NniPymLRX+6TrkemyWdwqXyIMiloYRU8kna/K6K1Rm46H0rDEJ9wSaMfISfL+wI7XNy2JrRwQVSjzJXG6X7sxUbgZ7pRXTcSkUJER7HFplPdFVSB0yF2XOQqkW/JKoV00QnAb2Ir0Hl2FEVPThv6CRzX1U/Zox05NRIuIdKHZL5VO/0Zlw6Cjs+uSYBffuMXpWFvI7zbH+h1HAgILLox7DL2bGJYj4NI2TcXFhHDt7OSaBgCyVHEPLaZ/asoM4PX06065Jq0mOMyljIMsCabWzHMdf/SXv9J1HfvFiO0XJXbH3v/5bzfGgipRJncxvcIKAx+aCmJJAK4C7PN0e42JRtew+U/ZnkGnHFp0pJrB/Voh54xH2TO8wLz6/EPSTIISmtSPSwCyOvehXYeY27JS7VH6a8xkeN2IEeQY73AFTBf2gZdU5v7013uSmozu7uoskAejKYZ/Xvy2KgI09FymZ4TIQisAzpa8t9wKk3X3/8GkWOZknjnRvSG6p4lFHUH/Q9knCz5v5NRf3YLt5Syw9Djicht/JSwmBBfdhJfyE4kgorBX/qlqT/ZK0CuS1/h+uMB9+QAo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V05XZk1xczMyc2JyOTJXbmRoaHF2ZTdRMmZZZ3h4NmVDOTJBV3ErREJE?=
 =?iso-2022-jp?B?b0wvY0ZaSERsTGVSeGE1d2JPRXRPNndYRHc1T21ScUNzcUNqUjV4aTFx?=
 =?iso-2022-jp?B?OWN6K2R5S1JSU1RzK0FQK3FUODhrOTlteWNMQUxkd2NMRkkyU1BxaXVn?=
 =?iso-2022-jp?B?Sm9OUWl0QzZ3a3VKNHBxZmVkQ3U0WXBCK2t5V3F6Mm5KL3dhMVI1OXRG?=
 =?iso-2022-jp?B?Z3VSN0cxSm1GdUhJVmVBa3hsYk55RCtSYVVuWTlqeGNMUVNDRzRpRXY2?=
 =?iso-2022-jp?B?OWVTRGFGc3VFTUtMQjl5TGNHak9hL0lVbFR5WVZFNmt5S1E2UnFHdHY2?=
 =?iso-2022-jp?B?NTg3eWVXZjA3aXJXUHI5MkFwTUo2L09oemZjS1R6TnM5UVRTODVDRmZn?=
 =?iso-2022-jp?B?dEwzUklNN3hPMEVOYWhVdWM0UXdjQlBRZ2s0a0RDa0JuNWhnMnFTN2dT?=
 =?iso-2022-jp?B?dDBQTUU3UUtHcjI3LytqMGJ0MXQ4WHFnM2ZXakgwbUN6SERQbFhBbVpu?=
 =?iso-2022-jp?B?dTJZdFplVnQxN1hsQU9FYzl6YlFsY0czQ3RzTzJiV1hBMnNNWGhML0J5?=
 =?iso-2022-jp?B?WkMzRm1aT1VsU202STNGU1FndHpVMGhnNnJsV3dFaWtXdFNVejArZEtp?=
 =?iso-2022-jp?B?SkxRT2JGb1hFOWFzRFNGb0ZWOTUwQWhkR2FScEx5VUdMbW9xSGlkdTVX?=
 =?iso-2022-jp?B?MnpNTGRycUpYTDRnSk1rSVNFMWlnaUpUYy9kVEsvQ2N0MkY3K1d3ek5q?=
 =?iso-2022-jp?B?OEdVVmVHZU9OVG9ybTNMS1hKampiSWs4VWhOcFNXZFoxT0JER1g1cnlQ?=
 =?iso-2022-jp?B?RVo1QzZMNGpWejBoa29RTUMzTU9CdUhkNWZmb2xXckNzMU9sWUFibVFU?=
 =?iso-2022-jp?B?MjVmTWpROTBidHNjMVFxamdKQWR6anZaMUViT2hidnh0MWh4bDlRZUtW?=
 =?iso-2022-jp?B?SXYxeVVRTjNPeU1sZTg0bDZ1TEdkMHlmeWxteFpzY01CVk1BaWtKQy94?=
 =?iso-2022-jp?B?NWdjNUZMei95UnNQSWFCSFRsWThjSHNoN0N0dE1HRmJPcUt2a1hNbnFL?=
 =?iso-2022-jp?B?c055a1FSSEhIWGxlZ3hPK2wySnZWYVR4RkNTWUFSL1dSMDJQbHZqSk5q?=
 =?iso-2022-jp?B?b29RenEwbjdJeHJVNmIxYUs0NDJvTERWblQxZ01RaHNIdXVKaVFwSHVU?=
 =?iso-2022-jp?B?YTZXZGNFU3RYTDY5S0FTTmMzeGlCVnRKRGh6ZnNYRTlkdUJ5R3dIT29u?=
 =?iso-2022-jp?B?TjBOT3RmNE5wUkFMUXY5YUJwNHNPSkRtbXJjUWhGNC93Y2RydlFONmRp?=
 =?iso-2022-jp?B?VEkzakd2YURNRFFSd3FocGppWXRvbjF3cUxHV3pUMURya2p4Lys1bDNr?=
 =?iso-2022-jp?B?MzdZYTUxMG9PWFVEQ3NIZG1aTCtkNXVCVldiQnIvNUlaYmJLS1lXNWdh?=
 =?iso-2022-jp?B?dkRySmxtMDdPU0EyVncyYllHa3V4bC9iSFNZT1NWbndEREk1YWdrTXNL?=
 =?iso-2022-jp?B?RzlaZmZEMmxRWmJJams4ZVdGRDBMb3UvaVhXQklhZnJyakJQbWNOZ2Z3?=
 =?iso-2022-jp?B?WnBiZk1GbFE5aWp4bVdqMnlyVmQyYjc5SkxWOXZEbCtiK1BzWXY4UWpo?=
 =?iso-2022-jp?B?Zlh6bDluZFdtMEZBZnNOalVMRUF4cmZFYzJGRE5rT3lIVjVBQ3h1dFVS?=
 =?iso-2022-jp?B?YTBuOVUyWFVQd0I5OGhrM0syLzFtdU1Rck5rbDFsOTQvTDZiNkdUYjFr?=
 =?iso-2022-jp?B?ajdBek5NZ2NwVDlFZW4wUCsvWFlqMEF1M0JqaXpYdmVrR0p3SG0xcTgy?=
 =?iso-2022-jp?B?NEkxNTZQempDZU02cTRMYjBMeEJmN0JBWFdZcHNGMjZDYU1GR1hKdDNW?=
 =?iso-2022-jp?B?RW8xbnRPZWpyWjZyUmZDbnllMy9OZzRZK3VVdEpuRWI2WmlYQ3EwQkp3?=
 =?iso-2022-jp?B?ZzlsTmhiWU9ZdmFGeXJqOW5STmpERjh6WUFhd3VyL1pUazdyT3pPc2Jy?=
 =?iso-2022-jp?B?TE1pMFQ2ODNaVVllcjFoLzVDVlpMUmtLaHhleUEzbXllcE9SNnhCMjFE?=
 =?iso-2022-jp?B?Y0c1ZGd1bk9CdlJSbGMrU3ZnbDNFVnoxd0d3amlnM0JORklDTFprMit3?=
 =?iso-2022-jp?B?V1VPM0pHNnV1b1JMRlVrZ0lPdHpBR1lFR0FWRDVUZ2E3cFQ0djJma09w?=
 =?iso-2022-jp?B?dS9jWmR2MFgvL3h1eFpHUHp6NGFVTmJvTjlFQUtITldFREVVSFNWaEtG?=
 =?iso-2022-jp?B?cUFVcnU5VjZidmx1R05RMnpFTU42ZHJweEZXRDFFbkgvOXM0WEloU1VN?=
 =?iso-2022-jp?B?cTFpVDlQWDNiWEI5UlpEbzl0MCs2QlduYmltTjVmN0FsSU5LdXdON0M3?=
 =?iso-2022-jp?B?SEMweFRQSFBIMGtMTjYzWE15Ty90ZzZGTitia2FXeE1GRmwvUXRuVVB3?=
 =?iso-2022-jp?B?bGJaQkpCMmxUVkRVallkR3FGZ3IyK290V0ErOEFBYWNwc1VMeWJEbVVy?=
 =?iso-2022-jp?B?YmlCRnYrSDVQMVFUQ0lGL2lqem42U3N1WDFnWjFjZGpQM1FVOEdzWWlV?=
 =?iso-2022-jp?B?cnU2RkV3VT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Cxvv7nBJC5pgzKvXt5zcaRDQHP8aU81cTqVyRYYAh6+cv1hnJ87+rEStFL4kWH8sRXDI/eh/ifMK2Gg3YAvjITY2EJ3wozunNSB6/hV8F/a21nEmM4ULBESACIpVTyt/H0k61USGJi0PFz6qQQzsB3wVEXxWq4YDqimisb3snbaSgb/40fsWhddHgwm+kLGU2Ajjf3Tstg7hC0Tbt2RrOq/AXxmZ9/fjHvmKrkOuoOWWODjl1EdWHsLPDJKYtJ2QGKBxt8ndjZ0FrCUpDQSR4q5Md8EshhLM+oTeALuuBy4cs1EqWrLK4fAFOwyIr70BbAhi56/3LSDwCXeLUPfnFQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df1b739-d466-4a45-51a7-08df122608f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 06:04:27.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bg0lktlRZyLo7hJ5t/MsnG2f0ejy1YHx4BRl3TqgmB4g4SNgxqd6kxAePz+6mm/8N9k0C2W7vtcBuTH2EvYZStQjvE7tDWQq23/JSj95GxpYRJveHFiRX12zDDfXB6tE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9574
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 06:04:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24164

HI all

> -----Original Message-----
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Sent: Friday, September 11, 2026 11:03 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH linux-6.12.y-cip 0/2] mmc: renesas_sdhi: Backport support
> for RZ/G2{E,N}
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series backport patches to enable SDHI for RZ/G2{E,N} though their own
> compatibles.
>=20
> Thank you,
> Claudiu
>=20
> Lad Prabhakar (2):
>   mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
>   mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
>=20
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
I reviewed this series, looks good to me.
I can apply this if tests are OK and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284=
5750901

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


