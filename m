Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3AFCCF9EB
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 23:39:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.37820.1693957191487706605
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 16:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 385Ndfku1339850; Wed, 6 Sep 2023 08:39:41 +0900
X-Iguazu-Qid: 2rWgoVec2OYMdS7yrK
X-Iguazu-QSIG: v=2; s=0; t=1693957180; q=2rWgoVec2OYMdS7yrK; m=2IDUgkN+p2RdWKZvd0DTJ9sSMmgR12oEhVlw5pHCV/I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 385NdcmL3608247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Sep 2023 08:39:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSK1He8Dqr2xoCQwWO9taRwM6QAd0cQ5zh1i8siCYlpakd1T2a06fmILBdeyO//4DL1XE/sMbD8p893SoypOETEe9LFNrMh0QKGCGyxyAZ91T0iVL7Xc62mO8YfKiVG4cQ3EYcYd4aCUybacf7pd74wjPFn2m5rvZx+WDTAgZ6FKH9hSAn14wjUL9u+THD5FvLA9IoaMxLFAbPl/NxQuGvqoFFXbzkW+JjfghRmEvwGORA4xG993LwzboXhJJPf23/R4jEZMSzWNrL4tEXPaPSD0oqCuz/LqTReSmZF0E2Mv5o1+n52rAXjnkJ4Vd0TK+Onavchy6W0T/9bFHXxNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtEyJzUvpp/IiwWZAlpJ8Sa3UsaewNilIm5naJF+DoA=;
 b=GeA3SNaPxthQErPrNC6H/ifSPicWcOq4NHlc9+D2/Z+6y/4X3WjFLqzzxiWJkNvjKvEqh77vH+34nWy0e14kQsq3pfTCLIwTG3Fxz76JMD093pSyYR4IZvICy4JOAXTxz5Uk5OoFAFl/zxVUWGlBsphRHEBQf9xW7RuTdQduZW46SKbcpjS7yYhmkMpHMGzAPHeXGknCXk7y7AZ4bVj2tuJaYuuoRUikChiEgmgk6EV6QjI9pYVFz3AJN7W75BXgOVNDn8Sbs82p1tJTqEwJvQHialaWT2oHcV9IR0RQQIqijrwPeTFh2XM43RxDF+iq/Sm2CdIhPbHE6k9HWu8qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 16/20] arm64: dts: renesas: r9a07g044: Add DU
 node
Thread-Topic: [PATCH 6.1.y-cip 16/20] arm64: dts: renesas: r9a07g044: Add DU
 node
Thread-Index: AQHZ4BMzvS50al8ViUmNZuF4U5fJWrAM4+LQ
Date: Tue, 5 Sep 2023 23:39:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420DFAB5C48DC0BE933CB4792E8A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
 <20230905160737.167877-17-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230905160737.167877-17-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB5959:EE_
x-ms-office365-filtering-correlation-id: 72515c4d-fd4b-4db6-8a2e-08dbae695db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wSJMcHHrJefCOPQd3nG+UvCyrJc5E99iixB+Apm9zGzir6KurEuDoeT7MdOKoEK8ezohtEBbh2DJ16Dsix8/ccI0w6/sjeJF/AIZFyOi7foqkbHPgN6WURHlATL6a5nN3tmZlG8H574Qqtnc/DsE/h9DuI6ANT5HOMA7jB/19QX/zRnuy51FBhQcvuLHFthr2M6kcY9sVYDnU55u26cwYI0Sp9v8HM6Uf6jZDuCrMKD+E0Ba2f0nyxkyuI0p+laXs1X/oXNY+NWpIGdCNUb8/MpGzPXchERBAtTEpnbfLrkwtsE26OEttrrOawdT/LdA1L/u8eYmRPN5hMrb6WTqqhGA58tbsoIYzpu/wjU10nNCCERMbfTEgrP/Dp72A5ySbxcjyhhNcofQEagmnxfNbyvYZlXJKnLZX3KJixvwt1GUnSZcUuhBJ31XJjQoO4acJ8oFaPQdJbUWmUkLif+/pCm2XvLuyFQeMANYToIeFL4934OUERFsWgpMXpbYcuN3L/BcZq176JpFTk1XfpZdhYvDkwcEaHe3NqgGRP//iAWBhjfz7wHLR7wzt+j/oPoMzO3ryFmDtgyvBGYLhVz4jFa7ieVxOUfES7TbaPdWVIUDX1GcYnSRXXG2Hqws3Rw6FsdmgZBbncUuwP0Snufl+g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(1800799009)(186009)(451199024)(55016003)(2906002)(83380400001)(7696005)(110136005)(6506007)(66556008)(122000001)(53546011)(66476007)(66446008)(64756008)(66946007)(316002)(76116006)(5660300002)(71200400001)(478600001)(52536014)(41300700001)(9686003)(8676002)(4326008)(8936002)(33656002)(38100700002)(86362001)(38070700005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R214Vk9OMjAyRmVGckNpVGlPbk5IdUZRT2h4Q3Y2R3hyTmZWREVLL203?=
 =?iso-2022-jp?B?NFp1ejJTckcwOVZCNDVVQnc1bEZhWVJvT25HNEdjL3JiRTVsWXROMXYy?=
 =?iso-2022-jp?B?MGZzVlhJNTJHWWFZWkgyb3lBT1lBc1FHT0NqbnkyMWpXdzRlWWZuMVJJ?=
 =?iso-2022-jp?B?MENLVkE3Rk0vZW1BeDZMdDR0UGFpczRpOUxkMldmV1VLM0JHWE9ZZkR0?=
 =?iso-2022-jp?B?NGJYeFozMit0d05VVE9weitDRDZqeDFYZ0ZNUnVzSUV0aG1qandaQjY1?=
 =?iso-2022-jp?B?QXI2eW5GaWppdmEyNGxya0pYcGYzbG5oaHpncUlVY0JWVnBsdlo0WWho?=
 =?iso-2022-jp?B?cEtMTThna2FGSUNmd0I0SklST3k2WHhFbGNrT2c0Wk1JQVR4YVUrb3NB?=
 =?iso-2022-jp?B?SmRBZlEyOER2WW9GZ2JGRmtWYlB6MC9yb1pGV0F0SCtjdjB4ZFd3cEQ4?=
 =?iso-2022-jp?B?RzRCSy9KLzhQdXVxNXlobjZ6WktkbGJhZWtOU2MyOVJySzFISmRENXN2?=
 =?iso-2022-jp?B?OEJZNUM5b2JCQzB2bFJHaDlzYWIwYk5nTFN2c0F5aVBtTmdjd2xNTGZo?=
 =?iso-2022-jp?B?WENzVklOamdxZ1VwQlhESVU4TWFkTzlvUmJ2WXZIc0xPRDV0VlpTemdH?=
 =?iso-2022-jp?B?V0xLV1B6bmlueFdyck1OSU1WQlNnN2J4aTFpdC91RlNPa0haSFpVUnFG?=
 =?iso-2022-jp?B?QnBjNit3V3cvTTRTMDdwdWxWZWMzQ3hTMTNhRUJqbHFwZjFTdkJya3A3?=
 =?iso-2022-jp?B?YjF1Y1U2MGlaVS9aZXNRMnA5VDJxY3FDRG9hNlZ0RnhXOWdFT3BSRVUw?=
 =?iso-2022-jp?B?R24xUzdja2E5eWE0NHZyMSsyTkIwdzMwY2pSRFVza2lyb1M1dEJUQjhn?=
 =?iso-2022-jp?B?ZFRkZjRQSlhKZmRVKzlseDRLaWRaajB0Q1FIc2cySmNURU5KdFJsOEs4?=
 =?iso-2022-jp?B?bFRkc3liSkJVdGQ2MjcxK3k4WDBCNHNDamduZ00wRlo4ZmxuaTVhWDhT?=
 =?iso-2022-jp?B?YlFhM3krQU9jYUtGTmswOFdLMDB0SjFHUzZuSUxELzJ4MnR5b1htMTVz?=
 =?iso-2022-jp?B?ODhQV2pPRG1KNGk0T0QxcUt5WHRKODNXenhaSG9sUHVENkdZUE50c1A1?=
 =?iso-2022-jp?B?SkZqTnpCS2RJQjVNbERZN0dtYUxkZW1NVERuMmNqaldkVzNrWXFyd3JE?=
 =?iso-2022-jp?B?YzByODdYTForUzdZUDRxNFA0VFpORk94aEtVSmdUdmdnOHNIVXhNbmJO?=
 =?iso-2022-jp?B?S1Vvd0NWNzEzbndWQWFJZDd5WVRodVNaTldKRWMwbTkzUXd3NGRQYlgy?=
 =?iso-2022-jp?B?bXFBcmFnbGFCdHNuUW5yY2xwSGZkVno4TVVBNWtYak1mc2dCeFhEVFY4?=
 =?iso-2022-jp?B?U29zeEFBcEFmcHZiU1JlK1lUREpEa3BhanYvZDJXNlJTVW5MclBuY3Jn?=
 =?iso-2022-jp?B?dmw2Q21iV2FYRkVXWGpkUWhwSG8vcEl4SDhWdzJZZDRpVFBPbHlwOUc4?=
 =?iso-2022-jp?B?UTF5MlJLUDBaMCtCZy9qVXNJQzFXSEZ4cVRyYm1lZFhWczV4U1M2cVV3?=
 =?iso-2022-jp?B?dEJzbmc1Sk9GNXh3R0dEWmlyZDhCSyt3OTk4K0VHd1NvNHc3amRvM2ND?=
 =?iso-2022-jp?B?QXJybmJQQkV4Wk9GaUp2Uk1iUEN5VVFLM1NVMnFRZE1oRXcxdlhRY0k2?=
 =?iso-2022-jp?B?bCt3S0l4WWRPQTRjN2dUNWhPSGR1bnFwTU5PMFRkazkzMVQxNVcwN3N0?=
 =?iso-2022-jp?B?RXh1eG9LY04xUnRHbjliUHpFeExXL1E0aHk2TUJjOGZ5QUhzWjNGb2ZW?=
 =?iso-2022-jp?B?YkNieVJHM0FNazNLS3dJRTFMMTE5KzNjOEc4VGF3aVM0ejNENzY4Y1Z3?=
 =?iso-2022-jp?B?MWtwN0xNeUcxTncvWk9Da1ptaWoyZWdQNHJEcEFqVjZ4ZDU5SnB5VnF6?=
 =?iso-2022-jp?B?SlRmSXpJNFU0KzJ2NTVNMjRyZGxsd0JsN255eEJYNEM4bXMyUmxwOEtL?=
 =?iso-2022-jp?B?YTQ3SkIvOS9sM0ZERlRiSjFHTjg0amY5SklrM0JBbUM2SkVUM1hxSkVl?=
 =?iso-2022-jp?B?TXFRR01WcTZoRnBDRVdtSzh1SGhmeHdGVFJ0andDcjRiMjN0QmdpeE5E?=
 =?iso-2022-jp?B?N2t1YW8wQk5mQk5YRkpubnVBeVhjbFRDSHk5bytFRzNLbHNLMWpUd3RK?=
 =?iso-2022-jp?B?d3FaU1krT1lRY3N5V1lCblg1RGdmVXUrb2Vzb1lrNlVhZVd0SDRYTFJ1?=
 =?iso-2022-jp?B?WjUwT0pEamYreFdQcEkvOFRtNUNGNjMzbGZpODUrOFNMRnJ5L0U3Rkds?=
 =?iso-2022-jp?B?cm9Pc2VTd2RvdDVCTnI0Yi82TkY3azVNYzNRdnJObnBibk1OT2hpaDFz?=
 =?iso-2022-jp?B?MzZkV204cDdiWVBiNnFZajJVc044QzIzeGp6QzNWT29oY1JRSmZTU0xS?=
 =?iso-2022-jp?B?U2tEcDB3PT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VusCqK8+EycY7bcGLdAN31/tuO2pRqnfao2gE+FH6vF+jzc9/fHXprWDHMdFZxwizRskTtDSb2oD7oOdg0R5KxxvSd5X9mKWuzce01BmQNs/wuiV5n1UYGvAU6aKSnPhPEMftOHhvCLyc+HjVHh/rAbYOszQ+aI6c13eFanquXZKrayja6+R1qCiMMGi4wI1ZwK3dH87v9sTx+Ohubnag0Rq2uB8QHw/rz8ttPL36SdCmWmqW/KwgLVNuLW4d8r5WnggeJDwDTyuV7LkngZTZr5UQ686cBUiH/1wfN7ivhEMJFVSd63CU5OH5FnFZu7Qgqegwt7YLi8aySE/gMNqCszfWq0KqnHfRixLoC8TbVpY94RQCZ9ibR9ZnxaZpqqf9dTqVgiB5QkguMdLAj6VgIT/9Ps4C80Y9r7h+tHJf8sgprymzPvvKR2ZzYOTrspfxW8nj3iAWMZs4IPs2+DFEQKOYXYBMtQi+zvS+LfwBUElq12dH7Jgbx4z+2ekVtNnI5L+5+MFAMXuzR3582lu7yeGk9N4iVLs0BzZP0kZxc/d+VR0TWuo5WXrl/E5IxHouSo9cNeQz4G6AN5mVAk3AHn1mY0e8kAzpUiMwdnXeygjSDao6XehwwjcNBJwEGi1q5YWGQ/uEIvtXJmwtfgkOkULvVO1UD5MPSCRxFbOmIHV9Uvhz7vsXmvdgAyOaX+cFWhtWuu20cxP1sgEn6ALsQqWcwTUTtEX1mpblmuIsrsD0Fu10qEdgiYxvJSrYMhZbFkm+KDvDzOZCDY7SMHgMDSaCqk0q6QeznpnHb0e3FAtSjobSR6UvTCBv9bWg0XJzMs3mCL9EDsW83PXDSXdnmZIPK7RpKYCzTmZrFjzQA3x734bgab4Qh+FZBX3jn/f
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72515c4d-fd4b-4db6-8a2e-08dbae695db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 23:39:36.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pymM5Loez+W1haD99OuDxhDNtcZsE1bMMrsSrMm1IgBDhTnx8KxXKC5FBn7mKj595DPzNB/ZT3pvtlp7yiazUr5xechfvsVn2iIh6qkZTloAN5FNI57THJ/WvLE9imMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5959
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 23:39:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12968

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, September 6, 2023 1:08 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 16/20] arm64: dts: renesas: r9a07g044: Add DU n=
ode
>=20
> Add DU node to RZ/G2L SoC DTSI.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

You forgot to add the original commit ID and Signed-off.

Best regards,
  Nobuhiro

> ---
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> index 52279d3222a0..2eba9e8e5ae7 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> @@ -741,6 +741,20 @@ fcpvd: fcp@10880000 {
>  			resets =3D <&cpg R9A07G044_LCDC_RESET_N>;
>  		};
>=20
> +		du: display@10890000 {
> +			compatible =3D "renesas,r9a07g044-du";
> +			reg =3D <0 0x10890000 0 0x10000>;
> +			interrupts =3D <GIC_SPI 152
> IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cpg CPG_MOD
> R9A07G044_LCDC_CLK_A>,
> +				 <&cpg CPG_MOD
> R9A07G044_LCDC_CLK_P>,
> +				 <&cpg CPG_MOD
> R9A07G044_LCDC_CLK_D>;
> +			clock-names =3D "aclk", "pclk", "vclk";
> +			power-domains =3D <&cpg>;
> +			resets =3D <&cpg R9A07G044_LCDC_RESET_N>;
> +			renesas,vsps =3D <&vspd 0>;
> +			status =3D "disabled";
> +		};
> +
>  		cpg: clock-controller@11010000 {
>  			compatible =3D "renesas,r9a07g044-cpg";
>  			reg =3D <0 0x11010000 0 0x10000>;
> --
> 2.25.1


