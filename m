Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D35C83F17
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 00:21:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.1418.1753748499906076624
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 17:21:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=RID65fsr;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1753748488;x=1754958088;bh=7iAiHp3t04XptDWgY1aQkxUVaKMkkZuSLvcP8vh
	bESk=;b=RID65fsrhNkzaa8tOCCsJJRpy806X7o2zM/QYPSB9HrnoTb16gH8kBCiyHiFBgD0bnKoA
	Ov2KwNnYYWt87AEo9cmGmI4up5gj761TWSCiRsBWGVmUlDQJ53S+Fblhyfe5TcQtLlE8XkX9TfKfI
	dBrYMyskI7iOWFMzfGlTk8udVcliSjlm+zfNKZZuQn30mOtYwQxI4hvo9MYcfSY6qRTOzmgBMGWXs
	ob8UI1wAFdl5+knZqWaSqSvlbZIf1IPimsTPkZwmmJ9Y/eEUdRAO/89tXurA4C8VF1GIfaii9B/VV
	YOCNc4g+6trojGYEZO/fQ8xdiaSBl934YTcN9yn4Yg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 56T0LRii3913714; Tue, 29 Jul 2025 09:21:27 +0900
X-Iguazu-Qid: 2rWhMjEQMwbwfmMjTQ
X-Iguazu-QSIG: v=2; s=0; t=1753748487; q=2rWhMjEQMwbwfmMjTQ; m=6dXAwL+1D99JiwAzqktN4vrItAiLowEs3unRt75BR2U=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 56T0LQWZ1631010
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 09:21:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgjCHID3VJr8TLVEoJO2h7U6CZX/sItXZXajnfjKcWIbEmGnC4VDaVNqK1Rs4zPx1YxYER69BoWH38FRwhiiIFwhZKHT6Fiba07UkDopIbwKb+UqJxtBttXhNhtgE3xW5oF+GHvE/GZdfnWIt/EU4c4dn6FSNqTTfngNUCRcZxvNI5UwkTMMsDvzk7tBOZzfemgdbCZa8BI8EYNmu6gxW8Ae61nhWfmc5Hx7E4OA/VVTv6Uyd0czW6mGwer5jfmqhToM3mE+0kY/zxq9MXN4a/IZpQEQvje50R4qqJvqv3gBCvwtEDV5YlvTF8RFfWOFqMYAxY9PvHuH5JNG3ybpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLnj1y8exBWKraL+ciVPloBYl733dqkfoZZDvkMp+68=;
 b=m4YVKsn8CcP25FTJWbeXmnjLwHRRxVoo94XSB/5xUkVmp2TsI7uXyhoSoeMM32zIRUFJ2Z1WMYAfmvK10KQ+Z79CucVTObKFsOPqhiE/WK6s+1Vjv3UycrR8bVgJpUNpaKsoMzkP3uAI9pbetkjWCi8xKqhZRkHqrFm1a7N0vCvJ1xMOsfSrIcCaSwDPjV95riAeQfre+LcIpoHf+sdpPwhCZebvWyAe308qRXqTcgF+cLUUcX+kTtWMbZomzq0gsnJfg3T+mtjgoVPBll6DILeXs8e8r+FJtgBU/NSI7oT7YtctL1hR1GRdJyQ4s9hBF69GADoP4DOD6Xf7yLgrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.1.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
 Add I2C2 and PMIC support
Thread-Topic: [PATCH 6.1.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc:
 Add I2C2 and PMIC support
Thread-Index: AQHb/8ZEkPsDxGjePka7wTLhBAsQjbRIPbQQ
Date: Tue, 29 Jul 2025 00:21:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481837A0F76FEAB4D5FB583C9225A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250728134731.1287791-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250728134731.1287791-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8612:EE_
x-ms-office365-filtering-correlation-id: d6d2649c-8192-4064-ac4e-08ddce35da01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?T0Q5eEpPSnk3M3BUaGVMUG0zRXdxVlFHWFUvRy96TjBpeEw1dnZDekIz?=
 =?iso-2022-jp?B?dDk4RHMrai9HcEdyb2RYa0JaN0VVeklUL29ETWFrMG5GRGEyMk9qMGht?=
 =?iso-2022-jp?B?MFZnZ3FGYmh6VHBENzMrMGtwdkgvbmNWWjJzZkhMdGsyS2EvaFoyOG9x?=
 =?iso-2022-jp?B?OWNWWkQ2bjREd2RBaEZtT0kyK201cUhFRmNLOHgwSEdqS0hXRmFTTWhz?=
 =?iso-2022-jp?B?RkdIS0c2T2YxRm9tV2RjdE5Qc2RORnh3Uk1hdFV4NEZWUHV5bUxYa3Zt?=
 =?iso-2022-jp?B?eWNIRko4RUZsKzZYckhTQjk1TlFaZXoyTGw2Z3lMMW9kRnRsUEdUbk5Z?=
 =?iso-2022-jp?B?KzlxcEFOZjFHbWh4SGM1aXZHaCtzNVJieEUyeHpJVHN2b1YxN1VtelRE?=
 =?iso-2022-jp?B?MThyZTlZQkpHQW9KR0hnWUpHdEpsQVpyMTIxbGpmMWU0dEU3TkkvY0F4?=
 =?iso-2022-jp?B?VUltcVhRS1paWkZhd0l1Y3BzcGMzcmtWdGVGT0lGTy9FWDZxQmVWMW15?=
 =?iso-2022-jp?B?N3FoMGxvYmozY1hkVzUzd2Vma0lxSTZUOU5kbm1UWnBCd3ZVRTZVQ1hE?=
 =?iso-2022-jp?B?dWFFRmpWc0piQ21OendlSkkybzdwWHRzdTZEMFE5K0ZPMmY5TVFOaEtC?=
 =?iso-2022-jp?B?UFZDeWFYaHluYVZqbXlOS2R6KzBjbnBOdlhGSFRtMnpmYXpSS040bmNQ?=
 =?iso-2022-jp?B?b0N0c1c1YnpGVjVrZ1p4c00wUlJ6bXVIQi9WcDVtRS9GaUdneVVTTkNx?=
 =?iso-2022-jp?B?YXc0dnlHYjE1d1hOcDk3bys2a2F3eHdqblNCZzlrV0E0TWxWRDVHSkNZ?=
 =?iso-2022-jp?B?Zk5mc1J1VUljckRrT2gwd3JkcVZXZ1Myb3ljS0hOOFdqd3Z5WHY5c0tP?=
 =?iso-2022-jp?B?STVwQ1BJZTM1SmpFRnlwMUZnbzJvTmp5cExxSWFmeWVtZG9wWHhGOE5k?=
 =?iso-2022-jp?B?bTRXR2o4V3NBOHNPRXVadGR3YmFWQmp3K3E3cXFSOUlMaTR0VkpzOEth?=
 =?iso-2022-jp?B?b0hyckFPUEJoT1hUbFpsU0lVc3grSFN1YXU0VmJWS3FFTE5ZYnZ0dHMw?=
 =?iso-2022-jp?B?T0VjSkVad2U0NnQwUWNMVXhIWEU3S3NzejMrRFY5bVJEQ0QydG84QnBk?=
 =?iso-2022-jp?B?dy8zdkVlZ0haNWxVYkErYjVmb2NuSG9jSFJISDhJRG01U05qUk5vTnpS?=
 =?iso-2022-jp?B?WlBzekV2dlZydVNZUWZHNXpwY3FVbmRMTjlmZm5BMGhnMXZkN3hjUW4w?=
 =?iso-2022-jp?B?OEVud2czNUF2M0FXWDRsQmxQYjRKU1BIY09XclVPbWhQYm1TNWFtb2Jh?=
 =?iso-2022-jp?B?a2hSTkFqQTNzTnh3QUJvNTI0bGZNSTNRT1kwbWRUMnV0QjZrbUdkTys4?=
 =?iso-2022-jp?B?ZkVwaXhDRTlBT0tvZ01rQnFuM3VTUHpqMkVBY0hkYkZLcWhGdjVMUStv?=
 =?iso-2022-jp?B?VG56Y0dqR000TzlWWjhxN1NhYjM3Q3pwdlFQSUdkWDlsM3k5RDRkV3BK?=
 =?iso-2022-jp?B?TG81YXBIRlFGN1BBenJQZWxJS28xbEliU0FQWFM5SnpKVnVFaEQyVUJP?=
 =?iso-2022-jp?B?bm1WYmVjRHozRk04dXM2OWkweC9KaE03Sm5ZVmVCYnFRQUh3cUJrMmlM?=
 =?iso-2022-jp?B?RXpFbTVVc0pack9vUnl2ZXJtcCtaNWdYbmVmd3dnZmhyUnZJUXlTUDRT?=
 =?iso-2022-jp?B?ZmdjR2dzRlZzZ2pZQXg0V21acUNFVVdYeDRQUk51Y1p4YnJmcGFuNG1N?=
 =?iso-2022-jp?B?bHVFMlJEMEJKVWxUM2dBUExvV2dCaUdRby81cUEzQlZaTWJ1Mlc4M3I3?=
 =?iso-2022-jp?B?RVBNQlBXUGFRYncyZVNkNVpraE5KZ3BSRmVBM2cramdDM2Y5MmpnWnpB?=
 =?iso-2022-jp?B?TkpBcTFyZ0hsakJSS2h3TEVuMDlPZVowN3lDSXp1TzY0WFNsb0s3SXJB?=
 =?iso-2022-jp?B?Wmdvc01iSWhNb1A2V3JnN2FlL0c4aWNvdEZQZ0p5K0h6bTh3aHdoY1V1?=
 =?iso-2022-jp?B?dG1BbGx0RElUSEdlTDIxcmozWC85OU44OGdNOGoyN0x2KytNV1RyRmJt?=
 =?iso-2022-jp?B?NWJjY0REV0kzUFJvV2RYTHJtNmVKVWo4enNtRFdvUlZkVHA1SlZWRFYr?=
 =?iso-2022-jp?B?aEZPbjB5ekhNUEhQVldmSkliekY3d3Z1RHZuditjSXhYbVFEMlBOK1F6?=
 =?iso-2022-jp?B?RWRFPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WDJNbXRPdDBsdFpRSjNSN09KWmJXcnJvaUhZQys2aHJHeEhuYXpZVVE3?=
 =?iso-2022-jp?B?ZVZVeGNzcmM2UVQxMHJQRXFPZVRhbm5KT25tZHc1LzlQQkxYUjF4RHlj?=
 =?iso-2022-jp?B?dXdoTGU1YnFrM3orY2ZLZXZycEZVSEw2WlJBVXJGSEthb1BnTFF5bjdk?=
 =?iso-2022-jp?B?NEdZaDgzNVJrWXN3dTE1bVY1V29CVmFTV25CY2FwNDl2MkdSNFlONzFH?=
 =?iso-2022-jp?B?eWNIVzlMWEJGY2JMWmx2VWtXNGRBSE1KdlhMdGFoU1dNT1k3T0lLSmJa?=
 =?iso-2022-jp?B?T1c2MDU2N2xEbU5WZTcrNkx2U3QxczhBL2l3RVk0RmM0RjIzN0hXNm90?=
 =?iso-2022-jp?B?ekwza3k5V2s4L0p2QTZwT3lCK0F1NmZMbFpYNWZ5WGdhNUdCTnBNc2ds?=
 =?iso-2022-jp?B?RWNpa25ubXA4T3lpdG14cE9JL0hUUmFiK3QwUFRUMkhwZTQ4Z2gxRVBn?=
 =?iso-2022-jp?B?YnRhcHFRSExoaU13TC9CQTIxTnd0SXF4T2JDWlcyV3ovRDlsVzZwTmpI?=
 =?iso-2022-jp?B?YUZueiszWWp2MlBQV0lmdm8rNXdXanZTNmkvemtuQzFiNENyZ29jY01F?=
 =?iso-2022-jp?B?K0JkdDJPYXdqd2E5Y0tTWW94dTdXVk5ZNXRzMHpqbmtVMlNYUUZIYkxO?=
 =?iso-2022-jp?B?Uk0wdDFwTUlRVG93eURDNlBNcjFkbnJyTWF4amwyUjQwcHFrY3V6eVVu?=
 =?iso-2022-jp?B?SXoyWUpMQTkwMmtIS2l0engyaUtXeVByTUtpMHJCakFZMTl0SldyS25H?=
 =?iso-2022-jp?B?MXBzTDFQOGNlaUFxSW5kanZ2d3lUTkN1TzhzRGc1THpsK0lZWkNnbkdE?=
 =?iso-2022-jp?B?UzVMZ3lkS0dzczdNRFlCRGhnaG1vUXhtZjd3TGF1TjZ2TkZIR28yQzZx?=
 =?iso-2022-jp?B?SnZ4OTlkMUl4Yjlob3ZHZWZVQjBjenZ4cDJ0Rlh5VGhWU29hdzN6YmYx?=
 =?iso-2022-jp?B?SVdZOFhtdUcrUlhPMlRGMmJLSlUxTTZGSWRncjBUc3JnbnhxMW5HSDlR?=
 =?iso-2022-jp?B?eUhGUHJRRjBTcTBFTHl6di91TFRDSGZHdXFVc1M3TW5IaHhuU2V2d3Mw?=
 =?iso-2022-jp?B?VUlxa0FiVHVRUHRxeHFORnczRytEZStUNk0yVXlGMndLRWplL1A0YWFs?=
 =?iso-2022-jp?B?TmZTc0Z4RW5uQnZuNTQ3V09iYzU5eklFZmowYTE5czR6dE1YVVI0cmlD?=
 =?iso-2022-jp?B?dDdhNjFMd1luWDJQNUFWdUkrZEhlY1djY2crRURFNzJ0RDhJeWplVEM4?=
 =?iso-2022-jp?B?UVZTdHdLcVpNL2owU1B4aFJSSHJzMGNzdktIZnduTndtZlZ6MUZySjhP?=
 =?iso-2022-jp?B?Z0tyYkFNZWZqcjFNTEpXSEtSY2NGRWY5bjZaVjFpRnFFOEU5T2g3eUpW?=
 =?iso-2022-jp?B?UWR6UnU0S1lqcldpam1Qa1IxUTdtaFlXdktHZ0hldEFpQVFCcXJQaDlU?=
 =?iso-2022-jp?B?TGhTdTZOcHp0cFliUEYzOU83NFk5cEo2NXY2RVViUzFOT0lJdVVMTkZV?=
 =?iso-2022-jp?B?Zmg3OWI3WG5XSVJsOERVTUdxdDZGZFk2b1lZTnJMSVVJdGVKTFFDZk9G?=
 =?iso-2022-jp?B?OTBxNG45MXowTHdEd0hmalB5WFJIWHc2V0xLYnlTbzk4OGJobEdNcWVl?=
 =?iso-2022-jp?B?N1ZNSmFqN05RZGNZRE95VmF1UkxuT2tJNThNQTJUaTZjTTV1cFBRa1Jk?=
 =?iso-2022-jp?B?UU0wT2dTYUhuMlNQbGhYWk9vRFlScHZxUGdncnJGaU83Wm0zbmg2UzNq?=
 =?iso-2022-jp?B?d1h4QURkcGpnNmxQTnlrNVNyeEQxODBjVGNyRzZLTW0vYU1MWGJ0c2JR?=
 =?iso-2022-jp?B?am1IbHVXZGVUakNWTzRmOHhsL0RlOGdMRFZUQnl4QklSc2diR21MdUw5?=
 =?iso-2022-jp?B?bGdOL3pRcStwWllJSkxOWTkzWnpUQ0tYaUdHV3lJNjNIdG1VR0E0WHRL?=
 =?iso-2022-jp?B?VEFqVk12VGpxb0tvM1MrSHVWbUN5T0k1cXhZZzVOU3dPeGF2ZG1KQW9O?=
 =?iso-2022-jp?B?b210RGZ1d3pKOW1jZVcrZGxEVnJXVExCcy9pSUlKZ3Z4MnZ5MGRhRkNn?=
 =?iso-2022-jp?B?cjVnNGVUanpTNkhQNktWL1VhbEJQSElCYlVYMHlZSGN4Y24wVlN6dlRt?=
 =?iso-2022-jp?B?d3EwZE4rLzJidWcrN1ViTlZoNHc1clh0Z0g4dE92MHFKRGJOdWs1UVVm?=
 =?iso-2022-jp?B?aVNFV1RnNVBkbFZPallZZzRUQldhQXBIU2ZQQTNDQ2N3NWRwbFFQQ0J0?=
 =?iso-2022-jp?B?RzVoN21GQWhLb3k3NzNDY2EybHhkbWFjVnN1S2JBMVFUdExOZ2pNTGdy?=
 =?iso-2022-jp?B?MEZKSmI2SGdlSE9FSHNJTm9DbUhFbzRaMFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d2649c-8192-4064-ac4e-08ddce35da01
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 00:21:24.2074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsqsdV4Ctgg4eWhPshUNM4sp5CaFgYeyLiSFHerWmLLzTCES0HVrotZyshTvZsFGObjFoWPIOpiXHWmbXQ85oqLm8SSs9nuwev/Pf9RR/sohYXToXypMgEH39UMy/d31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8612
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Jul 2025 00:21:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19611

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Monday, July 28, 2025 10:47 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.1.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc: A=
dd
> I2C2 and PMIC support
>=20
> Dear All,
>=20
> This patch series adds support for the Renesas RAA215300 PMIC into linux
> 6.1.y-cip kernel, on the RZ/G3E SMARC EVK board.
>=20
> To enable PMIC communication, the I2C2 pinctrl configuration is added fir=
st,
> followed by the RAA215300 node.
>=20
> Thanks & Regard,
> Tommaso
>=20
> John Madieu (2):
>   arm64: dts: renesas: rzg3e-smarc-som: Add I2C2 device pincontrol
>   arm64: dts: renesas: rzg3e-smarc-som: Add RAA215300 pmic support
>=20
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 38
> +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20

I reviewed this series, looks good to me.
I can apply, if there are no other comments and test was OK.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/195352990=
4

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


