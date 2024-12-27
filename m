Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86359E77188
	for <webhook@archiver.kernel.org>; Fri, 27 Dec 2024 01:19:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.6133.1735262359664369408
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Dec 2024 17:19:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=r8Fsrhqp;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1735262334;x=1736471934;bh=UO
	0ZopXBkwazLhtCmmzOHjtT44kTTVWn74VVlrpHFZg=;b=r8Fsrhqp/Gl9QvyA9c1k+WjMvuZH1kiF
	4xPPMC6FByykPM7CXvQiQsIdhjlG2eLnP2yydG90CKpubtsANnsKc7l+HsCtcEguf60fNMc2oLfdu
	es9WVByG42UtgRC+0K2v9CwOl2psGh67zAxLj3vspwXLKSgTvSRW6/7wJhr/6Wj4vMNM2wXAS2Q6E
	kfoPCCMswWb+vmxQt4H0N0rqQN6U2HAms5YpXlXO9MIoyYeGJ5BQWVh1BtzrXKFq6OW3uj5mD66k8
	vsDHXRYBtha8BfihzEDSS5enmoodbRVSUU6BDqx7OhKp0vBL134JcDwt5lmM29ghyPmvvnRRgHag8
	Wg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4BR1IrMB272989; Fri, 27 Dec 2024 10:18:53 +0900
X-Iguazu-Qid: 2rWhMjEQH4yCRrQjoG
X-Iguazu-QSIG: v=2; s=0; t=1735262333; q=2rWhMjEQH4yCRrQjoG; m=vJf2jwdyGNYLNw6gH7umhkKUXEIw+drs9o0/bKYq0GE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 4BR1Ip3f289738
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:18:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfDsVdBoWx5yS8/44Chkc4uykXaSYFJ+COqNkDq4kklZMjmnHdrQgtICMp/3NYGOJm8RwyqeOL0OlyaUoHPFn0Tw5zJmZRDXZHX0cebqU9dGTAsfUN0EdDYkDE/I0UutZhtduyXoBDB5YZY3NpNlB0TLM1mtAGE9i82OVS6puWOwgLArb6M3SiJRelvBAZ1/YV4I9WTtWnN1bqAdH+CkAal4oke2z5RuU52LoLVOEp7HNetXVQnwIIu7LxPrz1s6JShf9R26o9L7akZCQGjRAZfeGOUeDuVfOAxovPLiPS8t//Y2bL6aUOAsK9W5pOMtFypMmqIkE5q+VxA91TCXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/rQcu2lonRZn1WS/ig1qTbeU7ZDwZXKfc8a5xGh3hc=;
 b=uJkmWz/nYKaM0n9Uo0kBR6mipsmD+XnQ3mTHYwY6zWBdjmS7SosntrEnRxiqZvKydR0Gb8vaK4parWoOzYP7amhExNWvB57kCtkzrZ9dj9bruFX5vA32oitvEhJs5Tnj5hocpoFHy1GC45yAKJ3FNy3v70KMzEUDHMk7aKa4U1ssGFRi+X47WQncezreAnW1mNL3/4a51G91rmpOBrTdYc34JKkul+vk7l9rrcZf8D4Wvp59juo4vBeouxnf7VT5BCfcEzZfuQWWavMoIJvj3ssfmINpOM2/z+hIHY0mdwjVE73rFyfUUnmPcyokySBUui8KTMgXDK7EfMqbf3nA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.121-cip34
Thread-Topic: [ANNOUNCE] Release v6.1.121-cip34
Thread-Index: AdtX/TAQW64O8lQYRmiWt7WfR8FVcw==
Date: Fri, 27 Dec 2024 01:18:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63885C46EB16FCF11DD94D68920E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB9313:EE_
x-ms-office365-filtering-correlation-id: a77ccb9b-83dc-4706-0528-08dd2614680f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bnFFRXphOXczY0ZsTWgzbGlPRTRuNG1YRkI1S3VPZm5ESUxBNVRsTkF2?=
 =?iso-2022-jp?B?WjZRODV3WmpLdy9zWEtFV1FsZ2gvaXJDNHlMa1lsZGFpbXQzMUhqM3Nq?=
 =?iso-2022-jp?B?UCtOK3RCVlU0eTEwbEllSWhTQW9pRDNVZnVXQzZsd0kwSzB4bVo2ZTlS?=
 =?iso-2022-jp?B?K1RxNFNCaDRBbTVXWmZSMzAzZXpWUHRWa3NXei9LY1FxYkJzVEd1bGwr?=
 =?iso-2022-jp?B?YlFrTmYxSjFPK1Z1N1BjZDdBU08vN0JxTWNKNHEydlZWb1J0NktHZS9F?=
 =?iso-2022-jp?B?S2dUNmpETE4rWGFwZjMxMzYzcStad2VwRmxvMnZvSGNWa0txelluZGJn?=
 =?iso-2022-jp?B?WjhvR01LMWRLZ0ptNEN5VkMvZC9FOWxrbGZUbndBNG1KYWt5Z3VGclQ2?=
 =?iso-2022-jp?B?MTZGNVZWK1lXNTAvU2s2T1JkMTlyQTJjaXlhNmFHZW5VOUFJeHVoSTkv?=
 =?iso-2022-jp?B?Q3p6cGNsbGdiYWdGWmc5OSszSTdiOTE0UkdZdnVERmxzZWk3NXZXV2hN?=
 =?iso-2022-jp?B?Y0tRZWRSVHhhQVMwOHloUE5ieHI2VDNrSVRnc0FhcFNlcmdoR0lWNDZ3?=
 =?iso-2022-jp?B?Q3laSWVDanRoRnBETm1mcUVqMXNjNUFVOGtqbjlEblAyT241Q2c4ckE2?=
 =?iso-2022-jp?B?ejNwOGRadHB3ZXVPNzJNVjNRQTN3bmFFdjVTYk1lNHdUSzZIQ3ZYOUQ5?=
 =?iso-2022-jp?B?djdXZ1pxOHJuY2xybzdCeUtaQlRBbk5qNWVFOG1FQ0NqM0wxZStUQmNa?=
 =?iso-2022-jp?B?ZDBPTThPbzYycWkvY1NzZTVQVnNMaHNSV3E0NzNUeUFHdjQrYm1nT20x?=
 =?iso-2022-jp?B?THFlNm9IRVlGUlc3VDNmdndpWGdOakFobGtJWDg2bmdOUFQ3c2tIRWVZ?=
 =?iso-2022-jp?B?RktMcXMzWkdVUmI1T1E5K2ZqK0dWSmw5RU1VaG04b05nMXBuc2dtZTBB?=
 =?iso-2022-jp?B?ZkYzdHJNZHorc3pCaUtDWENFbGplQTlMRHZwdTRORi9SY2xnS3BqeFkz?=
 =?iso-2022-jp?B?VXdVYnhNNFNENmpSNkpVMFI3WDA1RzhqZkdPanhtT3lGOFZUTWtzR0or?=
 =?iso-2022-jp?B?UFRzN1JKTlcwUGR2MU5XdWR0ZFhWeHl1WExaTVNnVmViL3BzaFZnMW5R?=
 =?iso-2022-jp?B?N1R0WGN0QlZKMHloREJFbjI2QzR4QWRjR09MektzUDAyL2x4RXp6Q1F2?=
 =?iso-2022-jp?B?T1FMN212WGtHMnJHR1FsSGtnaEcwcmRiVW5iWTdZeDBxUTR1eFBlcmR4?=
 =?iso-2022-jp?B?ZWJ3M2pKanE5SS94bC9ibE9uMnlnTmpPb3l6TWxiSndHaHNYVzlkMmRz?=
 =?iso-2022-jp?B?NWt6U3I5c0N3bHZ5L0pnOS9MZmQvNWFKeEgvQUorMXVZV1ZUeDRqTkM1?=
 =?iso-2022-jp?B?VURtNlZYUFIxckc4UWJhbkUvdDU1bzRrbUJSSW1Leml1bUI4ZEJncXBt?=
 =?iso-2022-jp?B?K0hwRUZqNFJ3eGE5M1ZpUm1mM2ZBMG10ZENML1BxemNXUStJenNJTVNZ?=
 =?iso-2022-jp?B?MXY4cHZFMUdocDR1SC9QbXlWUFdMZk9naHhJWXc4bkw2TFMwMS9XaGI1?=
 =?iso-2022-jp?B?YnhHZDFILytoNTMremgvK2N0Smpkd1JCMlJZWGhjMHZnRnZCTTNxamQx?=
 =?iso-2022-jp?B?UWQ2eVA4WitnRzc3bjZXREVnUHIwOG9MZCt1b0JMWXFIWWhBTUpqL1VH?=
 =?iso-2022-jp?B?V1BySGMyOWY3UUQwU1d6THhDNTdHZTFZc05KT2xvYmxPV2h4TXJLd3Zu?=
 =?iso-2022-jp?B?RnZrU2JVMU5xS3UzUW8wWm9PSS9kSjMrbnJmV3RlR1FBajl1MkdOeVBK?=
 =?iso-2022-jp?B?RWJhT3NtOGgxaG9taFhERTUzZllNSk53VVAzRDRrVjNCRzd2ck9hQWR0?=
 =?iso-2022-jp?B?ZWhkS0xDQVNYZWE5dEJBbXRoQkhlWnhIQ2FBVnliWW5rUEY5b1Z2dENs?=
 =?iso-2022-jp?B?T2dWbU1qM3pvclZuNDhrdVFmSTJaSVhhMVl3OUdnV1FxaU5USlZZVGFu?=
 =?iso-2022-jp?B?WHIvYll3a0l5cVgwekJFSUVtWGt3emJ2N1dwcjBSSHFuV2JtUTUxamdI?=
 =?iso-2022-jp?B?WGxCSXdRZi80aXhGVGJPU3h2b0cxNHZESlQ5Yk5VVldxREJqNy8yczM0?=
 =?iso-2022-jp?B?RjM3ZUQrb0RwbTRweHVmcm8wLzMwaDdRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TnBiY3ZMRkt5Z1ByMkg5NWQxSnB5L1NUbjM3OFNaSCtyemlISk9TaklM?=
 =?iso-2022-jp?B?UFFvL1RSa25SMDdjU1lOZnVhN2lFQWx0dGRoa3dLeEcreHEveStEckc5?=
 =?iso-2022-jp?B?cm50NmoxT0FySG80bjN4akd1SzhHTUV6YWFjVTRpVFlWM1BWbUZ6WlNR?=
 =?iso-2022-jp?B?R0ZKM08yaVg2bG56alJuR2hRNWxSZ1ppWVV5QVI5MGxlRXlGamx2NExN?=
 =?iso-2022-jp?B?b3NabkFGNzVMR2hqUmlhMTBlMVJvR0hFdm1ZdmZCamNJdVlmTWFtb1k2?=
 =?iso-2022-jp?B?M09pREV4cG1jRnJaNndrM0FuUmNabXpsSk5oS1FVV2drZGNjZ2gwN3Ja?=
 =?iso-2022-jp?B?VU5SVy9vNERaRC9rWTMzeWcrUGZoaGlYYmZSZElGV3ZSRG1CUDZKbFJF?=
 =?iso-2022-jp?B?bWYxZm5yTURGdUF5ZklvbUp4U21OS0FCNzNrSnlMd3p4eFgzZlE1YlFm?=
 =?iso-2022-jp?B?UkIyeGM5L0x5Z3FaSEdqRVpvMzQ0MUhhbGFYRW1SSnd6NnY2U0pFVThV?=
 =?iso-2022-jp?B?RnlkdXl1TmlET0w1SzhSeDR6VEpFL1NLMEwwRWdHZWdIeDVMdDYzemd1?=
 =?iso-2022-jp?B?UmhPZFRKS1V3dFlwYjVnbGpoUG5EeHR5RUxmdFFNcXZReTk1ZU1Sblht?=
 =?iso-2022-jp?B?eTRiaGVzZmVqakJ1eVNjeHpKdFJ3SStaUzYxdXNjbEdqeFZzNWo0ZHVp?=
 =?iso-2022-jp?B?UGJmM2JmNDBRTXVWYlN1SnlNbnNPVWNZSlAva1VudEQrRVN2VDgrSDdK?=
 =?iso-2022-jp?B?S0RqeUdXZUgvdUxBZmMxN0thdHZhZ043VlpsQTJYSkVEV2ZnaStpMitJ?=
 =?iso-2022-jp?B?Sy9MejgxeDlQYnM1L1BJVVY2Sno3MTVsenVjdDVyS1VVWFlxWkdCRDEz?=
 =?iso-2022-jp?B?RWo4M2QrK0MrZkxWc0paUmhsRG9XOFNaa2hEUmNseWZOWUo1MGpoL0pu?=
 =?iso-2022-jp?B?SkFxL3ZidXVWcGZIUm9uMkhndkkrYUxUZmxxZkh6YmVPaVFDSXBCUGdj?=
 =?iso-2022-jp?B?RUgvN0JLNlo2T2NBaVUwTmJuR0NHMzhxSStuMGp2VW5Ga3M1cmsvK2ZN?=
 =?iso-2022-jp?B?NG1lUHZKZGtnYzcrS2tWVkxYR3FJaXl5eDlPV3ZuTTNHQjY3TzBHNXRM?=
 =?iso-2022-jp?B?MU5IbW1adzdZTllIaWUvL0hjV2Rha1dMZlpoYno5YTRHSHlKRW9ndVd1?=
 =?iso-2022-jp?B?YmxxZTIxRnV1cXJmYzB0KzBuSmJLazZkeDdXS2hINHBmdEVoVDlaV2xW?=
 =?iso-2022-jp?B?R2dnWVljeXMxM1dxM2VBTHBGd3F2MFprRzBjWTV2OTJSQlB3ZHZPUWtk?=
 =?iso-2022-jp?B?TFdydUplRWJlaVpnbDMxVzJDR0NxSjYrT01RL1hJWTJKV3Q0OHhaSDhC?=
 =?iso-2022-jp?B?Q0JIb0dNdGw5aEpwYnFyNVRQSmE4a1V6Z3JCM0hlS3p3dXViRW5oU3U3?=
 =?iso-2022-jp?B?SkRsZ2M1QTF4Q3dTaVVybTBENW5sMlVpZmFwL29UbjBBejJISjRjZkg1?=
 =?iso-2022-jp?B?NzJadk42UVF1dlo5cTlKZitLcmtoNUJxOS8xRjhXQkFGMkV1dHVGTTJQ?=
 =?iso-2022-jp?B?NzJ4V1ZXdWlFRlpxZ2ZLWjNUQXo4MU1kcm9YK0QrZExmL1ZkRG0xOUlX?=
 =?iso-2022-jp?B?Rm00N3A1S3psNEl3elozdXdpdmVxN1ZqME9ScEJhVmw0U25rd053Y3R3?=
 =?iso-2022-jp?B?UThVU3hrYXZBTDVKS3BLOE5HcWZKUlNuZDArSzRyVjZQbUdCOUpYQlFo?=
 =?iso-2022-jp?B?OHg3QzdxRU1zWVZYdkFQaXJQODkzYUdOMEkwZSt5c3gvd2dmVm1LLyt0?=
 =?iso-2022-jp?B?NjZwTTAzS2h4em4zaWg4T3BKRjhqMGZHcHZrRjlmcTdDdDZoL3pxNEFI?=
 =?iso-2022-jp?B?STY2VEFTTUZOM0Z4TGYxbWhNSkk1VnBEM0k0TzdKYk5qRldINW54Z3Zw?=
 =?iso-2022-jp?B?T215WWNWQjQxb1JDSzcxSWoxaUl0blFnUkQvclltWEJNcVMxUVFZZXFx?=
 =?iso-2022-jp?B?aW1lSzJYcmVSMm5BbXArZmU5K1dSN3h2QWRrNHllbGhXcHMrY1owVVMx?=
 =?iso-2022-jp?B?Y2FBZ1kwWkV2NUtEeVhDNGE4UVpZZUhQd1U1ZC9qeTRWLys3dTh3eXhZ?=
 =?iso-2022-jp?B?cVJRdVlIdjhjckl3MkRqU0hxSnpUc0FrQzEwcDVNSS9SZ2x3RS9KcG84?=
 =?iso-2022-jp?B?eHlyT1NjNzZZTkUzUnorb2tNUXYrNldJVzcrVlJWRERYeDhtWlZZbHRl?=
 =?iso-2022-jp?B?K0doOW1INzA0RVd6b1dhOExlVUVrTXJNRi9VYjg1QWVMMkhudnpodU4w?=
 =?iso-2022-jp?B?dmNzQVp1bkloeENyM3ZvdlIxREdmbFMvYUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77ccb9b-83dc-4706-0528-08dd2614680f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 01:18:44.3426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URUlpQ4dFeuvZ4TRqKTGwbJ7hKtqT0ccwSI4nPhypWeyNYOAJUBfb2QgJog5I7Y2KKoblyMJzRtDADFPM9ZUzIonv2DhWHCXCx/7mCCPXpLz6Vv5tzj6vj45cKimmb35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Dec 2024 01:19:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17496

Hi all,

CIP kernel team has released Linux kernel v6.1.121-cip34.
The linux-6.1.y-cip tree has been updated base version from v6.1.119 to v6.=
1.121.

This release includes updates to the Renesas ARM64 SoC watchdog and pinctrl=
.

You can get this release via the git tree at:

  v6.1.121-cip34:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      a91fec1e69bb3107000e5cc4d4816ade61d36c9a
    fixed CVEs:
      CVE-2023-52916: media: aspeed: Fix memory overwrite if timing is 1600=
x900
      CVE-2024-26595: mlxsw: spectrum_acl_tcam: Fix NULL pointer dereferenc=
e in error path
      CVE-2024-27407: fs/ntfs3: Fixed overflow check in mi_enum_attr()
      CVE-2024-35870: smb: client: fix UAF in smb2_reconnect_server()
      CVE-2024-35956: btrfs: qgroup: fix qgroup prealloc rsv leak in subvol=
ume operations
      CVE-2024-36479: fpga: bridge: add owner module and take its refcount
      CVE-2024-37021: fpga: manager: add owner module and take its refcount
      CVE-2024-41014: xfs: add bounds checking to xlog_recover_process_data
      CVE-2024-42252: closures: Change BUG_ON() to WARN_ON()
      CVE-2024-42315: exfat: fix potential deadlock on __exfat_get_dentry_s=
et
      CVE-2024-42319: mailbox: mtk-cmdq: Move devm_mbox_controller_register=
() after devm_pm_runtime_enable()
      CVE-2024-44950: serial: sc16is7xx: fix invalid FIFO access with speci=
al register set
      CVE-2024-46809: drm/amd/display: Check BIOS images before it is used
      CVE-2024-46841: btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_exten=
t_info() in walk_down_proc()
      CVE-2024-47745: mm: call the security_mmap_file() LSM hook in remap_f=
ile_pages()
      CVE-2024-49861: bpf: Fix helper writes to read-only maps
      CVE-2024-49874: i3c: master: svc: Fix use after free vulnerability in=
 svc_i3c_master Driver Due to Race Condition
      CVE-2024-49891: scsi: lpfc: Validate hdwq pointers before dereferenci=
ng in reset/errata paths
      CVE-2024-49897: drm/amd/display: Check phantom_stream before it is us=
ed
      CVE-2024-49898: drm/amd/display: Check null-initialized variables
      CVE-2024-49899: drm/amd/display: Initialize denominators' default to =
1
      CVE-2024-49909: drm/amd/display: Add NULL check for function pointer =
in dcn32_set_output_transfer_func
      CVE-2024-49911: drm/amd/display: Add NULL check for function pointer =
in dcn20_set_output_transfer_func
      CVE-2024-49915: drm/amd/display: Add NULL check for clk_mgr in dcn32_=
init_hw
      CVE-2024-49917: drm/amd/display: Add NULL check for clk_mgr and clk_m=
gr->funcs in dcn30_init_hw
      CVE-2024-49925: fbdev: efifb: Register sysfs groups through driver co=
re
      CVE-2024-49926: rcu-tasks: Fix access non-existent percpu rtpcp varia=
ble in rcu_tasks_need_gpcb()
      CVE-2024-49929: wifi: iwlwifi: mvm: avoid NULL pointer dereference
      CVE-2024-49934: fs/inode: Prevent dump_mapping() accessing invalid de=
ntry.d_name.name
      CVE-2024-49939: wifi: rtw89: avoid to add interface to list twice whe=
n SER
      CVE-2024-49951: Bluetooth: MGMT: Fix possible crash on mgmt_index_rem=
oved
      CVE-2024-49996: cifs: Fix buffer overflow when parsing NFS reparse po=
ints
      CVE-2024-50055: driver core: bus: Fix double free in driver API bus_r=
egister()
      CVE-2024-50248: ntfs3: Add bounds checking to mi_enum_attr()
      CVE-2024-50258: net: fix crash when config small gso_max_size/gso_ipv=
4_max_size
      CVE-2024-50275: arm64/sve: Discard stale CPU state when handling SVE =
traps
      CVE-2024-53105: mm: page_alloc: move mlocked flag clearance into free=
_pages_prepare()
      CVE-2024-53125: bpf: sync_linked_regs() must preserve subreg_def
      CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_i=
p_uadt
      CVE-2024-53142: initramfs: avoid filename buffer overrun
      CVE-2024-53145: um: Fix potential integer overflow during physmem set=
up
      CVE-2024-53146: NFSD: Prevent a potential integer overflow
      CVE-2024-53148: comedi: Flush partial mappings in error case
      CVE-2024-53150: ALSA: usb-audio: Fix out of bounds reads when finding=
 clock sources
      CVE-2024-53151: svcrdma: Address an integer overflow
      CVE-2024-53154: clk: clk-apple-nco: Add NULL check in applnco_probe
      CVE-2024-53155: ocfs2: fix uninitialized value in ocfs2_file_read_ite=
r()
      CVE-2024-53156: wifi: ath9k: add range check for conn_rsp_epid in htc=
_connect_service()
      CVE-2024-53157: firmware: arm_scpi: Check the DVFS OPP count returned=
 by the firmware
      CVE-2024-53158: soc: qcom: geni-se: fix array underflow in geni_se_cl=
k_tbl_get()
      CVE-2024-53159: hwmon: (nct6775-core) Fix overflows seen when writing=
 limit attributes
      CVE-2024-53161: EDAC/bluefield: Fix potential integer overflow
      CVE-2024-53240: Backend can crash Linux netfront
      CVE-2024-53241: Xen hypercall page unsafe against speculative attacks
added commits:
      CIP: Bump version suffix to -cip34 after merge from stable
      arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
      arm64: dts: renesas: r9a08g045: Add watchdog node
      watchdog: rzg2l_wdt: Power on the watchdog domain in the restart hand=
ler
      watchdog: rzg2l_wdt: Add suspend/resume support
      watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
      watchdog: rzg2l_wdt: Remove comparison with zero
      watchdog: rzg2l_wdt: Remove reset de-assert from probe
      clk: renesas: r9a08g045: Add clock and reset support for watchdog
      pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}
      pinctrl: renesas: rzg2l: Configure the interrupt type on resume
      pinctrl: renesas: rzg2l: Execute atomically the interrupt configurati=
on

Best regards,
   Nobuhiro


