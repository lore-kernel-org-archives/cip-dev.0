Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A1CC7EE2A
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 07:25:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.web11.3091.1750749907169920042
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Jun 2025 00:25:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=JnNCftQw;
 spf=pass (domain: renesas.com, ip: 52.101.228.70, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsNiu/LgWq/BRLnImHeRzeVytfJ8/AQsWcZNby8naQniPLihd0aZYN7BZUMy+oHtFaKVu2gl3Mz+OSADLjEopIyROBkP0bABVnr64x2FMl96S0Cy8zC675JmaCq31E1xwqRQ8V3fOdCDPBxqJh93Zn8ewvMjIW4PZor9myHrAHO7Ny757g3nK7GLohPTgruZv8HqyEG/m2eE4guQOyag9MoL7V+B/b/kc/8FLsAUhVFy884U8nqYAe6iS/limJorzznv6hSqdUe3zF4ak2tOGaAqOQiWVe0in/lKex2+6bmgcwLMF+1cs0m1GIjjBJV3FXcG+aW2BcsDeQpZWaVaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBHCmLYBKC91WC2xgZzUbjl4MHlx3wtH+GAHCwsszok=;
 b=v9nDLHTJQnevNkQNE3GMYvLf2TC+czY2PKrc2+a6atUhj8YEiFe4nqA3CKXQcJRTZ+8MrgUAhnswUBCTdU2ZlMMmevI/FdoE7SiE/J/W2rA+hTc+m+p+C/CiTlAjEBRFoPlyBNzF7/LHPaifzleTuM/L1nUHR5QtDn37jbh6vuQrbcGxR4aGEJuvmbukIHUiyBcujjze22Y2owM6gU3ovHJvrfcx+Mxb+qXP3KgIQgnC49o8iqvNFjuyWw3or9XvLdXuZJpfIq4OkkusGzbmoaC3Ajo6pvYjsQzYfTLMvy6UJH5H+4M28XbSOx0Xqze12VOIUSybpOk/cLymN1idIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBHCmLYBKC91WC2xgZzUbjl4MHlx3wtH+GAHCwsszok=;
 b=JnNCftQwCInlE0alz3PGSrDfqNB/whlwKLWbIQtCwk9Kjk6s3l2uF82y7xbwnPzXdt8loM4hw4IyuPtA+gtGRrFc+NmwjOwN8nI808aKNwbrte5soInj6sf6f7Fcjf8c58YxsyPfGTidYQpx3LnHjIJJmEle2qtqR1n7NhTAh0A=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TYWPR01MB10788.jpnprd01.prod.outlook.com
 (2603:1096:400:2a4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 07:25:01 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 07:25:01 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: 6.15.x testing, gitlab mirroring
Thread-Topic: 6.15.x testing, gitlab mirroring
Thread-Index: AQHb5HMnA83r9pgd/UiDGBOKTQRxGLQR55jQ
Date: Tue, 24 Jun 2025 07:25:01 +0000
Message-ID: 
 <TYYPR01MB151323EA13C59E45719D04E3BB778A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <aFmnuI/5U3dZ4FaB@duo.ucw.cz>
In-Reply-To: <aFmnuI/5U3dZ4FaB@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TYWPR01MB10788:EE_
x-ms-office365-filtering-correlation-id: 91db39ce-baf4-4a21-edce-08ddb2f03b46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?5aNtHfrfvc8pttmRa9oUeToBsGSnkaowBrYbbcchMbjQR6PAKh1o/k6v?=
 =?Windows-1252?Q?XZprCTVMjxP/CaZT7rI/qUZ5Kw6ItjtZKVU3rjA5XK6dqr0vQ9Rukm2L?=
 =?Windows-1252?Q?XfdU8qC976fR9bYwbl26SHcWj7t2F9DUSTR8lwisqpraYtMeinQiioSL?=
 =?Windows-1252?Q?QqQ0Dft8Ia7pXCbWmfzPxLcc4duCbUFQjJ0moQNXePOxQ9Z6Pdlj2b4m?=
 =?Windows-1252?Q?uj2bxtmKkGFnhNnsx3jz+UDCtBweipxBzN0pzEABR9FpoOaeZ5LTlgYt?=
 =?Windows-1252?Q?2M9ZbMUADhhfH8ctDq2qXgVITBg9mQjSGAy981h9L6pMVmniZ18hKkr4?=
 =?Windows-1252?Q?/dDKNqzSC/+nL3bBi8gxiKe0a5XR0b2TdafSKfu/0b0Fu1T5Ro1cDJkf?=
 =?Windows-1252?Q?i+iuRgxAMGCo9KdbJMZpgVyXYLjVYxuIMXb+L55VzhhgZaCKKFTqBLOb?=
 =?Windows-1252?Q?ZjudHShCMJsHeKzbRObDL+hwAmqejt3f5S0h5KueTDuaTJBfc/Q0UEPb?=
 =?Windows-1252?Q?PurA54iigO5v16oJHdCL65h/Jwd/cBD+wygkQGSSGrlPxMO06asZ9ZtS?=
 =?Windows-1252?Q?vPo5pqBRg1cKnJ9KS4tbW6ebcQmgV0JfTwnDVH/pk5ERLzRLJas5pK2y?=
 =?Windows-1252?Q?TgEXDjOQ6o93w/rt8RPoI6mpwlS1xSDamtfWFNLizombSa5Vy4TsfkmP?=
 =?Windows-1252?Q?NCKA+e/0BumSEDvO8OotAUoR8JPde/WWqikO8OSkzqqmxzZmW3AbPOks?=
 =?Windows-1252?Q?F/0rjBFC2mN8xGuhN6pKNOHQHxdnSDsLTjmXdm1krKPW4MoFDRLqnORd?=
 =?Windows-1252?Q?w3WPvt0Hblg0etqRYJqAU/30uw1IYoOCF/p0jDdO8usggz9FFa9PVudn?=
 =?Windows-1252?Q?asE/rKeg0VAU+yAS+SWSdt6C8m5lyVf+nOYZX5AyWhXFEGysEJlnLFR2?=
 =?Windows-1252?Q?vwJYvbY/pChwYjRLed5r8V94eV/U6BNxnqYgkqkxpb76cyA3un4ttBmQ?=
 =?Windows-1252?Q?OPuODvjBZFdyr4P8WD7EHR/R+ts95tGCO5yuwFnsvbzb951jgCuUgOCc?=
 =?Windows-1252?Q?cdz2PTsuJTjK0p6zRX8nrmv5TIHI2PvRvUks3MB4STrNyWDiH64ewqQN?=
 =?Windows-1252?Q?duaDvt1z50iy0fYUyQylMcdF4+uStNAzc9YNVteiAEG5TRVbSkMx06Zv?=
 =?Windows-1252?Q?sX1qzVTO2hsfvL4DEgAeEbALh2yCKVgzvrXSLPViwQRxbKVkKg2dnOSL?=
 =?Windows-1252?Q?pTw5LwwUHpphs1Y67OL2xktO1AxE+wGrxhvho3amgdixp3cWU64Q6LxS?=
 =?Windows-1252?Q?vwsYJfm2+AQ1wT8D7J8EglMD7WKscClLKeDQb3RmwzqVOMzX9MV/4Of8?=
 =?Windows-1252?Q?uFeXXCFR9XJ33Aqpn5qbK77TXwk2ylgk60/fqmUBORdojjaz2HjKD5em?=
 =?Windows-1252?Q?lR0yBeWaqPN4YKu/vh7HesbO/bSJ1K2+5v5XEBk0zNvJnwIr2hM/FMh/?=
 =?Windows-1252?Q?I1X1Ytw0UdE8BMMQpxDcnOkydJz6OD0i8bzCqL9GbFa5pU3pOPg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Tej8CIdLMTWQNgpgZHQtvrqqFyz8MUJJI1HlDhCnsbxwMwbsx1dleKkf?=
 =?Windows-1252?Q?OykVSW1Oqq4eBXqupQJiLDl6MBp6o5mbWXVaJhgZOqvcosFoHvO5Tqpk?=
 =?Windows-1252?Q?VM7rCutym2ZiahD8CuPSLSxCD1pWklW2XpVdDF7pptXSURlx2mCJeIO9?=
 =?Windows-1252?Q?YOPaMCxFTpIcJFRMR9JAAW7BLOSvwIBRsyitwMn2IpNSMpqQNLJWSXDd?=
 =?Windows-1252?Q?puv/4Z8jJuM8CNkykMxSxwVM/JKv/eqoXmP7lPRc7N39/O59TC/1DGhi?=
 =?Windows-1252?Q?wr/qob9Fmn8xXyUcMo5mnY72J3T1M/qC1pBIYxUjFR5v/wvjKn0iEhzu?=
 =?Windows-1252?Q?Lz/tfPOSgoIfjTCs02g23l/+GmLqxnN5ZXAp2aG7vZ2F9PRvb2Mumvwp?=
 =?Windows-1252?Q?NLuLA54rWwYVAvfnuquILk/FrsKYw8eWrJMFBTKm/6/vAiHSSj7Fqc0y?=
 =?Windows-1252?Q?82dYReaQYVB4T/z+yhU9EKB/B+7bDUuHnZceADUnEhcE8RagZAbP/PdA?=
 =?Windows-1252?Q?Peh8arrEodB77TcT4yRzCfmt+MT9OQDWHLHMWNJKV/aCCjeiCDBsxB+/?=
 =?Windows-1252?Q?vF472ZN3aFwHWwpoqWQYTDt8K0Srh4H3BDrnSgdeX5LvZiF1w+7qgPTT?=
 =?Windows-1252?Q?DtUoJwrNwAb1fiJ5KP7pDQ6tO0xmF19T38wMeW2geNHrXExvGqP0tonh?=
 =?Windows-1252?Q?2EsV7F88+0g8xovCo8WOg8ENQERx4lAQUEbLJVnoXSbCypd3sGCwnkYC?=
 =?Windows-1252?Q?lk5UhP9ze3EaZA2kenbk8zfr6vGvC2Zb18mDE09HIePvfAQLl7/ddoYg?=
 =?Windows-1252?Q?8hIqkb/vO+/2R8n538JSniOKDDfZpG5nAEDB7Bc+Qu06eXqUOYNMdMAO?=
 =?Windows-1252?Q?nV35ns6XcwjKOp+/XFgqF59yTh0yfVohbJcIIFUEXdRL2B6ORD+BxOI2?=
 =?Windows-1252?Q?rV1jsiHPLQpSaAO8p+KjgJGKddLmXylr9hpyk0wZY3WtsdHnYsXHN4Dr?=
 =?Windows-1252?Q?Y9vqafR9+FvTvCjj+Kok4BS2wLj5GcVeQhkgCaHl3R8RqyzGHCVLeFUv?=
 =?Windows-1252?Q?+iI7HkFOGAc0zjmn3XurBuQqloKwRYJh4qK0HnEC5QujtrRexYTZp6ob?=
 =?Windows-1252?Q?esO3GFPeXjTVXA11ysOPZ0sgjMhV9T0avXj2y1DJuWucPKoP4MO6Ipeu?=
 =?Windows-1252?Q?P1VIcbjkc3V4mksztt3+4gN8i2wUFWuGGsiE6bkV6/IWTm7HSDDmhYGy?=
 =?Windows-1252?Q?tvCx+aHw4yCqO4OFGRk6PZxhmNrLid47IMOBFSBBXKocqIAxIjd/Ryio?=
 =?Windows-1252?Q?cbfJnGbQip7bxWzMJxYMuworjCwhMdeHDpK1KG/RM7BTrRjDfCoKz7zo?=
 =?Windows-1252?Q?/ic8XagQGdjTw6E9FCmhPCWk1BbU/LfAyumpwlRm1yIvOfRvk5u0G+3g?=
 =?Windows-1252?Q?LlY45k2X1GrC9M4g6XCEHk1vKZ82uI7UGbo1hf2unuTNn73ciwTB8H4m?=
 =?Windows-1252?Q?8+i1aec6COy7G9OTHIiLdukqhKexPAVs5kj5MyF/9lGm33FOVqgdPo1J?=
 =?Windows-1252?Q?TRhkturlBtTuNHh+u7Euq+cIMsTFQ/8i7Yu0NQOkEQNQ5RMMiMaG5zSe?=
 =?Windows-1252?Q?547ukTG/nekzaPMI61cXzb0wV22VA8zyLN3vu6vkf0UeMcWhT3Ab+5lN?=
 =?Windows-1252?Q?zo/z4e/tRra48buY1oNkfdeHzB5unUIWGav9/4RKIAspqqkWA4CBKw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91db39ce-baf4-4a21-edce-08ddb2f03b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 07:25:01.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVGaYsIJRSLfHhqPpEz7qv2iNbtEzanjDIAnLxJY0DcJKFQ06VHR5PZoJh61VUjQUtEodUx5yzqB1ueO0EknEXIFU+NkNSYqrLKqeLcvkjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 07:25:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19224

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 23 June 2025 20:15
>=20
> Hi!
>=20
> Greg pushed 6.12.35, but I can't see it being tested on gitlab:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /tree/linux-6.12.y
>=20
> 6.12.34 is few days old.

We had to change over to the Google Source mirror of linux-stable-rc a whil=
e back as kernel.org wasn't reliable enough.
For some reason the Google mirror is a bit behind for this branch [1].
Indeed it looks like it's behind for more than just this branch.

[0] https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git/
[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git/+log/refs/heads/linux-6.12.y


Recently(ish) the kernel.org repo hosting provider was changed, so maybe it=
's more reliable now, so we could switch back.
However, I got the impression that kernel.org was trying to reduce the bots=
 and epic cloning going on from their servers, so maybe we should stick wit=
h adding the load to Google.
We also tried mirroring the linux-stable-rc repo in our GitLab project, but=
 it was too big...

>=20
> On a related note, it would be nice to get 6.15.x testing going.

Support for this has now been added.

Kind regards, Chris

>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

