Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878C4C433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:58 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.93])
 by mx.groups.io with SMTP id smtpd.web12.4465.1664537816739562745
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:36:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=C+rYOFnZ;
 spf=pass (domain: renesas.com, ip: 40.107.113.93,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itFN2HlRlxHRz+QtzepY109gtQKbRNapepdkijG79tsQjgswYxpyf5OXy3r+tnmqtFLwGyu0J1AeuvULA9DeBwjR4rNoZV687KgtTPmdOAyVcr09ZeofvBFGVoojicTM7caLnmsZZ4jZ5zpU04RT14b07qDymgCbCaEy6NtBGoGBfrgy5x/NFYZ0cWTFGpQnaSsfFU4r1levHfx+3Pkk53IWl+YMUUt/baroleR62fDELTezgoZXuPufzws8WsPaabqbezSy2JpycJBjAzwnDwzN3G56H0k1VYXbt1ClMzyZaR+/q4sTk8bdH8CEPVRULOzwlZkPh2d70M4wkUyEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a434ApXwTGoBtzjW/+tIzczHAWokCrjjV4RcXc8tNS4=;
 b=gkW3QQLLrcCwd4VL0EKaIsJ9PC2swGU7UXOcZxd7EWKIOR6x4anEaB+yM28fJthISUNm0ZJCRSmU/uNkl9QOSh0syDIDjlhsvCoSEiQ4Odod4GyRsF+6+P9YwnaPVMxPSqsWn+vLEkyEhqBeT1soACHEXgim1JZEbaDI/X9H30wkcOheP0QCcfGuS6L/ld2XPAV8BlrAWBK05Es0qsRd2bKr/zQgoT13RiU4bitAnUo77G0coYn6DN/WOyads1Z+HDlKjLSxqky0rIIF0llSBwYevr/JBQgzpEOL+W88abQKxFMxmbOs2Jwe8JM5b9Od6hgVf43Hjapzvi6WFG8uEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a434ApXwTGoBtzjW/+tIzczHAWokCrjjV4RcXc8tNS4=;
 b=C+rYOFnZP1mzly8uZsMu/TsnoizPrRIHjGtDyC9rqnonPqEVBgd4ehG/mu3hcJCE8i3LuuGB0nWcrGreJaxafsyZ+EoTpXyt14XyKuaTykY0V7LQ2tB9MCLcrP4H5v8No237KpXQKIENfC8iK+jOn4qkw4hfPdyjjBvUi2tYhUU=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OSZPR01MB8670.jpnprd01.prod.outlook.com (2603:1096:604:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 11:36:52 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::68d8:5e72:53f5:ea7b]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::68d8:5e72:53f5:ea7b%6]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 11:36:52 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>, "Adler, Michael"
	<michael.adler@siemens.com>
Subject: RE: gitlab test failures -- job failed ... pods not found
Thread-Topic: gitlab test failures -- job failed ... pods not found
Thread-Index: AQHY1LqD736Cemy9y0G88cTlOE3pAK331CBw
Date: Fri, 30 Sep 2022 11:36:52 +0000
Message-ID: 
 <TYCPR01MB1058887BD9BA7DE6BD1BEA1F4B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20220930105048.GA19081@duo.ucw.cz>
In-Reply-To: <20220930105048.GA19081@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-Mentions: michael.adler@siemens.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OSZPR01MB8670:EE_
x-ms-office365-filtering-correlation-id: 485a58c5-5fd6-41e9-fe47-08daa2d81213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RgvUIUUGZK2qj5MQitEQ3dfn84Hjfxx0RfEOtEAkcZowSk8Yz+DAIXErTr9pRbUvpFDTSCJZGIZJ1KWB0d2V0vQbLCDkNRegLHQBetmZb1ZP4g526srdQD8UbaCuHkromzfo5DzqTXKzP4TpTtrSxYStUTefSwpoTRkPPEZBucaxfkIIvHcdhmfm98fR6IcXF/t/3GCNrzxiRhAwjtOa9PkxOypyyagvfR67iShK46QeMbmIuZ7Rpmv1geJj85TiR/8T6yHrkb8BMthvbcTtz0TvQDtPA7dYmZW03Io0XabmbpVPpZdrHBjBn9CWgkUuoJQV86eaIEGLaRWsJKqsm10h8Fu5Hts8a5S+1fM+TfLEKZaq2kbur6rOkxCDJTIBLVCNt30ORZu5A/M85xtbDtDjRrDqdNloVlDg7L7nEiWfVdds8QqMrNiZNsn5OxHPf8j/EBMEhaE7Hiuo2YMgUMoWPL1M9euzIeKYavIFBVwI2nYbadfibl4VWeAZN9HyRjo5IUSh6OB41vt2PQ2tx3uruX3pD1pXHW/Cj8P2DR7PRy8Q4MJAuHrJSL8/INUbCFKpzLej3G5FPyJ5SvXF+axZ9fdV5nWycqzwiskJokv28J8HkIUjJoHyVP+Ykrd9vu5P+oPvpY150XUdMQIgUjhLwslJad3GMm4h4zq9UEsWaKr4AU4EK2Fv1wCQ/0B4FXzutub1hkrDWc+dlnfNG7wk3vTpXt8sPQ3AmPtFRvAmVEqNOeNcwtqPgN/vzi8wYKS9WfJwbwSuQD9q5xnUhidmJURs4HwQfzLjE9CESfn/JE+E6LsxtBOZgjmraIxRCLXAVQF6ej2TWtvVOQdLGw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(478600001)(38070700005)(316002)(110136005)(55016003)(966005)(71200400001)(8676002)(66476007)(122000001)(33656002)(2906002)(41300700001)(66556008)(64756008)(66446008)(7696005)(66946007)(38100700002)(76116006)(6506007)(5660300002)(26005)(83380400001)(8936002)(186003)(86362001)(52536014)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?0Af09boTPl8mQPZuoBjAJxd0W1VGxGktBUNWjhtn9c467/2fuJTsZkUt?=
 =?Windows-1252?Q?qDiznGtdQUXi2ZUC2l7TK093dIkHnMjdGyMj0TwxOKWMWJlyHgz4ePqT?=
 =?Windows-1252?Q?195pxxr2j46oBY95u6LaZBssYXnN9v1vjV3RZsebGtMKmhS9N38Xf6jN?=
 =?Windows-1252?Q?cMdiopqEawFkHkG8JqYEGk6WWZIOMT3A3ZatzrLEBOKRFoJ22A7vhVOn?=
 =?Windows-1252?Q?pujdxJe3gWfyRZrHLwcCwr+C8mf4HbW5lr3pCueihR8mgB0WI2JT4LZV?=
 =?Windows-1252?Q?xgroJU4MZnGpYcKJyz7VYwuSkf49Li4HBwiDgGIGwZrNmuj5zVWIBwDK?=
 =?Windows-1252?Q?p5z+L80HSsXcOynqMbs+qRrPo9Wwvp+1ZuY3g5rozzhKTf6a3w4DlOxz?=
 =?Windows-1252?Q?ag1AgzwJ6vZbjyZlCcbl+dhdSzEX78T+pIkAn3wg0vzglwxZVJLbtRML?=
 =?Windows-1252?Q?AOTfciapwy8wRPOnwSubAhkyTHs5dGV3K3apzVYYlTdnX63yc8oNlCpQ?=
 =?Windows-1252?Q?9T3rHA6+GvVsIcriKxlbScZxgsBNRW1flIauGnqZv11yaSEKQgPaJRGZ?=
 =?Windows-1252?Q?RZFYvL8nXY5N+jNFnH9tOSmIO18uVQaeHG3CoGtPPrNCRj93ZkDwRLGQ?=
 =?Windows-1252?Q?R+KGLCvGgQ3N2XjozgDNjWIiNBHlNmPvQZAtJijnmHhDm3lIQt3lTdi4?=
 =?Windows-1252?Q?WnUh7hdl72X6hmUxYWCfN7qINnI6Hqc6jllt5kNMOzzuNQJCz9yoqOgu?=
 =?Windows-1252?Q?K4T1DWmGJN9yJ4WnQtuYPD4HbFrT+9Mabk5Pe9JlsETSw4sXXGGuFsIs?=
 =?Windows-1252?Q?BRFH0+w3yEqQNVDRCln51FvRMmN+aIaA3kwlPvGpks2CiBCbxbToj4yO?=
 =?Windows-1252?Q?nSjtZQCMxfwhGw3pRJlODxn8V11WzFeDX53myJqoiUjTGT1OK19CaT2Z?=
 =?Windows-1252?Q?C1afab0S0TJ3lkxDVlVMVjrUgaZeWO4FRFStcRsumgmmFp9w2lZYlk7J?=
 =?Windows-1252?Q?RRztwjvDIPzFATLIIPw+oEfKJggZdgw4inGmToBkwiG3kuNpCl4dEU6p?=
 =?Windows-1252?Q?mvLP/X4Z0Q2dwaDpxL8oVMUT7CTWKeW8Jo1LAfnHwJUU1fxXSkQL09L9?=
 =?Windows-1252?Q?l9pYFvoLay4k9jqAzsZku0DIif3HAPjiFYzsGYmVZPwu8q65qTDmJdwn?=
 =?Windows-1252?Q?XQQOlJ5pS4WsfUmOpFEZQkqzmZv/64uRNLCTgBNfaa+za/a62fSIU82l?=
 =?Windows-1252?Q?Cn1eSMqc05HI1is0j8UndatkiIvp6as2pmQvGGZ5GxXI1PO77LTEQjZy?=
 =?Windows-1252?Q?J/CB6nol/eTHRRJ8U5/YZ3vMf9jwLj4KIhntD3ON+wHP/yBx6o7YPbB2?=
 =?Windows-1252?Q?sdnQ3TWqZEaU9wxe1Sw5LRI/uQba1Gq4pED3UxSWkHGFrtnNtA3++Wcu?=
 =?Windows-1252?Q?B8ZpLh0c1dAbXaj3spAHOdiARQCwAOUCbiEBJ2J/nTXAgfF15VD1JHIU?=
 =?Windows-1252?Q?MxL4Eb2QLTS7HeHoqn9nC2foPdflzQtDx3BqCjdupTgPoFVMVQBmtrNs?=
 =?Windows-1252?Q?My7J8WoKuJFcdq9J2r43Gz4rrpvHoqhTGatXA3ZCnDVl3L9fnchcf/QT?=
 =?Windows-1252?Q?PT5sSK5UCYbIbTzsJAAqIwxnApaSpiiZyNm11LzViewc/4J47mkUCD5m?=
 =?Windows-1252?Q?jUnTU6cL34W1rVrJIAH6sY0c1WZTLRPZ0pyVDXNzjzDeMy8jLW3CfQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 485a58c5-5fd6-41e9-fe47-08daa2d81213
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 11:36:52.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 euSM3HyY1sAF6GULbj2mUhGRNOt0yKaNDieanKXUD+DK6s/zkO1OhtsNVSpt62W2QtVJAaWZ/QjfZUI7nlIDseTHsUDLzxDtZ+7gE3pm1Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8670
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 11:36:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9582

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 30 September 2022 11:51
>=20
> Hi!
>=20
> I have test failures all over the place:
>=20
> -----------------
> 44Creating test job
> 45-----------------
> 46Version: Image_ctj_zynqmp_defconfig_5.10.145-cip17-rt7_411cd76b5
> 47Arch: arm64
> 48Config: ctj_zynqmp_defconfig
> 49Device: zynqmp-zcu102
> 50Kernel: Image
> 51DTB: zynqmp-zcu102-rev1.0.dtb
> 52Modules: N/A
> 53Test: smc
> 54------------------
> 55Uploading binaries
> 56------------------
> 58
> Uploading artifacts for failed job
> 00:00
> 60
> Cleaning up project directory and file based variables
> 00:00
> 62ERROR: Job failed (system failure): pods
> "runner-bwzp7ahx-project-2678032-concurrent-0pstk2" not found
>=20
> Initially everything failed, so I resubmitted everything, then three
> succeeded but no more luck with resubmitting.

Thank you for reporting.
We recently upgraded the gitlab runner versions, but that was last week so =
it's a bit strange we're seeing issues now.
I've resubmitted a few of the jobs and as you say, some seem to work, other=
s don't.

@Adler, Michael, could you take a look when you get a chance? Could this be=
 caused by the recent upgrade?

Thanks, Chris


>=20
> Example is
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3109431179,
> I'm trying to test 5.10-rt release candidate
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/654967302
> .
>=20
> Any ideas?
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

