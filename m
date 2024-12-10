Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB9E77182
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 11:57:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.8610.1733831876974069317
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 03:57:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=ZPCHOlnU;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1733831866;x=1735041466;bh=WP79+/gUibo5GWiW2mENH053Ic5fHNEjLZPriQ0
	T5cM=;b=ZPCHOlnU+xa8VH6wTj+72TJ276xzL1yQXZ8LMhpOVEwQuJkz5yKRdSbDssTM1fi9B+4DG
	31ElXTITnFjCgMHwJV305obFL+/uybgzhIdw2XXzFgm0NhkQOrQhyeiqYbuu5MNnmFTv+KEkAo6hS
	ACLwjdtrusjeZ/BBM8MGQChh2ucewoR+tm+Gg+RISTCVl4rAdXqLlPVFxpG46e3Sa65hcQMPm44+R
	80xJBxKAMRPSEm8U0SMLU0zU2zBw8aXBpPfojMgF+Vj2CArGjF97v32XK0y+sOlOak9zguwkXcMez
	HqM5UQBKGpr3MduOFYQFOyAHoxX5FH6HC5zwfyoAKQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4BABvj5Y1847316; Tue, 10 Dec 2024 20:57:46 +0900
X-Iguazu-Qid: 2yAbaKzOe8otRHzNju
X-Iguazu-QSIG: v=2; s=0; t=1733831865; q=2yAbaKzOe8otRHzNju; m=u5E6bIAezLpSwPYv5ySPQqcQJo43jFD2KHrABqu9qdE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4BABviUY2082438
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 20:57:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyWi+dIe6Nm23LRqhHm54SvxWQ2f14KlPG0pgA2H4IwoLdY8Mg/e9VO4nO0YPaaUVmyvrbsJ2turQGMeZt1f6btvTq2xsaQJnFfPR+gYRCXpjytcyR1K4mPvGghGwDDHJphteSEHbJLIXWKKUzxZVxt7025QFxgjO9P9w+SMF0SibdTLsblSxt2dsUwzszuYNmJNXbfI8Yg6y043EbFEt1weKPDw8qjxS/APsKuNANQP6RGpph0krtQXoq9tCFLrAMnIQd9wfpZBqSoX4n3IsMfJ0N5Na656gYnN3HivuUvODlAcHwrwevhiMGWavq0yBfucwmm/ZqoYC5DrELH3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqWzzXoibsQvx0+2KDq2pVrvh8zUCx4QTEjEwfe6eXA=;
 b=fITJhBVdMMVamLYcBCXgB4jkoQ1r80Jgg1vc+w3GG7Lt2UsaIZWHslvHi86d7Xm4+Vu1QX4RNPN9VRnuvmHe4k0RKU460F9qAGESslE6G7Jp7mgNZhF8K0pUR2c6ZbpaXTRXNXOyZJpkTvFoJpmaK4cjfhN6gQQQth+dwhSQhTpNa3+Qt11mTpEJk8EL9ev1dJnEHffbm+zdv00IQwmtvLExPJZJIoRlcvhuZhH5loz9+w0btU6CD2as5XiRj8I0PlS6rAWYv6psGJmd6A2ssuavBRhb9rwSNmFmzK0fl2TVEfDNNJLM64Xy5npxcrMprT2ahfc7ynzSSs4zSHXgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Thread-Topic: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Thread-Index: AQHbR77ad1VaFxKZRk+n3x+FC0/OW7LdcdeAgAHx/SA=
Date: Tue, 10 Dec 2024 11:57:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388158FEE661B8A4D9EBD4B923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB63885D768D71D58AC391B09E923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB63885D768D71D58AC391B09E923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB9963:EE_
x-ms-office365-filtering-correlation-id: ae0ee253-f2ad-4218-b8e6-08dd1911daa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WTgzYTJyMTFNb2N2ejZkdzVhbXE5b3djcExtYXdtWDNsUUNrbUE4dW5s?=
 =?iso-2022-jp?B?SDgrZzFYL2hxbFM4MWg5NDBMSUZuZWlRbThmT3k5WW9uUFdlVDZmeDhm?=
 =?iso-2022-jp?B?cVBGaUljR2hqVFU3WGgvdEVTalA5cGk5eXJuanpzY0plTVFHZUd5UXpP?=
 =?iso-2022-jp?B?SHFDZHp2YzkzaHVvOUE3aEQ5L2FSU1hGVEVYbzQrbXd3bWFKdXltUjFQ?=
 =?iso-2022-jp?B?Y3pZTjFwdWNHMjA4T25Pbk9QNnZ0cC9ETVp6bkJNZDhvSTV3NjcyalJ6?=
 =?iso-2022-jp?B?YkxZSGdSU29GakRoQlloUmFFMzFLa3RUa3VmeUFwT2NtU3lXbXhrOXRS?=
 =?iso-2022-jp?B?Tnp1ZVAzaDNCR2FVU0dPZU5uV00wZSs4OVRBOHZ1OURMTHdTVHM1Nk9u?=
 =?iso-2022-jp?B?cTNPSS9tR05adG9JYkZNZ28xazlRVFBXKzA3cDVzQnREMzVXU1o5SFlF?=
 =?iso-2022-jp?B?dmhETWh3Tk5nMlJDSy80MW1EVDN1MWlLZEk1TDBWeXRrbUhFMDVicUwx?=
 =?iso-2022-jp?B?aTNvTU14a2pSYXdUKzAxTmY5NnlnQ1lNU1hkUGg0QWF1bXduL0p2eVZE?=
 =?iso-2022-jp?B?Si9jUmFPSUMwL2VOWHByQUZKdWFsM25XbFZjRlo0c1FYd2xnSnBGSU9W?=
 =?iso-2022-jp?B?bC9tV3pIU1RnSFNCc2xsUE5sNCtHbGNoYTBybXlmNkVFU1c1Rk4zS3Rk?=
 =?iso-2022-jp?B?am9jeHQ4WnlJSHNZNFFUUDdxejFpaGRueEVMMVN1aUVlZzd6bVB5TUdv?=
 =?iso-2022-jp?B?OVhVQWJtTFBOb1lPL2xZU3V4VUNmT01qQkpScU1yaWxsWEp1QlhnQ294?=
 =?iso-2022-jp?B?QWRvMGMxNzRYNW93cTV0Q3Q2TCtHWkE0aWc0cWlOZW0zVDRUUThNc3dT?=
 =?iso-2022-jp?B?UitiaGM3NmhBRUpjcDRiQUp5MjUzK08zeFE2UjBuOG9xWTFyZWtUR1gx?=
 =?iso-2022-jp?B?TjJMMDNOQTBXQ3duZHF6YzdvbjNoY2s3dDh5dGYxaFlDRmpNN3N3cDlv?=
 =?iso-2022-jp?B?eHRWY3JqRm1HZkdCSEJpcUd1Q1NnQWs3Qk1ndy9LN01FODd5d2FTU3pC?=
 =?iso-2022-jp?B?WVllellvTlNiN0JQcjRYSitoSUVtSDBxcGVtZzJTdmg2OFZQcXkvQ1lz?=
 =?iso-2022-jp?B?RGY4aXBoSisxdnN4ViszRlh4R0w3T3EzbWhNeHRuVWZyT0VpaGFnV2g4?=
 =?iso-2022-jp?B?eHUzZHRlRnh3bTljRVZsSE8xYWcwYUxHYlpvd01LYXZDK0F6SnJrMEJ5?=
 =?iso-2022-jp?B?ZWw1YU9RUlhyc1hGZU5tYjVaWGxWcytreEhndTVRRTNUNEV4STNsa3dU?=
 =?iso-2022-jp?B?TENLUmsxRVFlQ2hKTmpGMUV4V3hUYnJSQ1FjRURKREhSZU81RFdKTGJi?=
 =?iso-2022-jp?B?anVjRTEzU1JkTFlNRVk1NzJXVmxvRzVTbXJsOE9MTXRFMVVMamN6U1lk?=
 =?iso-2022-jp?B?eVE4Q3ZTM2N5amc3di96cEFSSVRxTGdFOXAvOHM0M1dKR0VFV1U3QU80?=
 =?iso-2022-jp?B?TkIrRnpiZmI3cFIwZWxqbUJPTGxacGYzK2lLME52dENpVU8zdnRDZ1Bs?=
 =?iso-2022-jp?B?clBVSWtEbDlEL0h4ek9RZGUwTXNLMGg3eEFXZ2dBdUk1R1dKa2xGZ0hX?=
 =?iso-2022-jp?B?YXZ1OWtpUW5FV01zSWFBdktvdHBQd1c5U3RyRk81czJKY1FzbjIxZWNu?=
 =?iso-2022-jp?B?MnJJdERJb2tlYzVlcGppcDdkdzJJdkhiODJHK1k5SytYK2xITVl2YVor?=
 =?iso-2022-jp?B?NWY0eVBGZjdralBJbFhLeCs0WWlsQ2lmT3JFSHI2aWdpbFY1SVdYamc4?=
 =?iso-2022-jp?B?VVRldS80RXNlWThncklkdURLYUlOS1ozOXJ6TDVPMm9Md1o2dVBtR0hr?=
 =?iso-2022-jp?B?NDkzZ2JSMTc5Wm1DeW1xTFppRkVFMk03bXprcHRSTTBaVi9JR0hreXVZ?=
 =?iso-2022-jp?B?emNRQVpDZCtQeHBHcHFtSnFqMFNyRFFqZDU2MW5oSnRYQmNha1FCSDBE?=
 =?iso-2022-jp?B?dlVlb0tjdTI4MFhMcmlqQmtNcUtSakNObVNETlBZSTQ3UDBYSFBOSkU4?=
 =?iso-2022-jp?B?TnMxNG1SdDg0VldhZUJ3dVZGcVA3V2c9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cG5HMm9LVkFiSjJETnZIdWNUck9FbFZUTlR4UVVubU54dE9rVXpVajlT?=
 =?iso-2022-jp?B?MnlWTG5YUWNkdkV4dmxaeG9WbG1OSUtndnplRUUvTVdSWUJSSkpXZVNl?=
 =?iso-2022-jp?B?WjIxeWNhdkQ4eGZHc2JlTXcvaVBNTXpTMDk1Ni90YXE1NTZlV3hzMk55?=
 =?iso-2022-jp?B?b29iYWppeks4c1V2SE9tSGsyNk1vQjB1eG9xV2w0bktrN0NvaWJDRm1v?=
 =?iso-2022-jp?B?YURQS041OXJpRExPR2VubCtRd3pKQ01TcjFjaEdDclVKTDJIdVFvelY2?=
 =?iso-2022-jp?B?SjBYUUp2OFo0YkRoVmJGTXU3ZXVFcHNDZnFGSWxIMGl5MmliWTBXTXEv?=
 =?iso-2022-jp?B?V2ROQkVrRDMzV3o1amxGejZKcHpJS0JUa3IrczFFSEd0Z2xBSHR2eXE2?=
 =?iso-2022-jp?B?eTZ6UFplMkhuM3pzMUVrUnJtMldzUStuZ0NIK3FmQ3pOMjIyWTlsZVRE?=
 =?iso-2022-jp?B?cVpvT295eGkyZXRnL2NtZVJacWZ1R3E1bjROOXNsK1ZsYVJENWwxc2hu?=
 =?iso-2022-jp?B?T3dHcWVaaXJFYkJ4NVpzVVB0emVybVNXdElTT3F1bTVDM2RnWkZickFV?=
 =?iso-2022-jp?B?OGoydWJ4dEZHVnNGUVR1N2NjaCs2N2tTdWFpZG5ubFdvNFFKY0xvYXNI?=
 =?iso-2022-jp?B?VjZZOFVYVWFDdzJ2SjlxQW1RNHBoUUNXWmVBWDhFK2ZkTzhoMVM0dGxP?=
 =?iso-2022-jp?B?T3RBbDk5NXp4Z2YxbHREUm84OWJJc0l6MkNJbkgya3JkRHFhUkRYTVAw?=
 =?iso-2022-jp?B?OCt4LzU5YVhzbG1LT25nOU1ucXpNL1NET1lFenI0RkFmU2d1OWtsZnNC?=
 =?iso-2022-jp?B?NU1jTEI4dDFTSGFSbU9HZk1kejZxa09hbXJFT1U1RUMrVzg3bnNYUFBJ?=
 =?iso-2022-jp?B?MkZkKzhmazRrNExCNWV1M0huM2J2UEpDbmt4SThIdEVtOHIrM1VZM1hJ?=
 =?iso-2022-jp?B?b1UxMXJrM3N6U05Dcms4OWJQSDFJV0UvRUlnNGs3ejZmZ2ZTWTBVZU1P?=
 =?iso-2022-jp?B?QVlqVnBpS1h0dERNbm9VTWd0RkRqMkNzWWZjclVEVnBETW95U05pbVA3?=
 =?iso-2022-jp?B?QU9EMG94Uy9HSG5IamlnbDJ2YU5vY25OWUU2MFJuZnFrN1BLRVE5RVdI?=
 =?iso-2022-jp?B?ZDc4Y0VyRW1UQU1XSS85NGtzVmoybGpHd3AycnhrWTI0ZFBuR0tFdWxh?=
 =?iso-2022-jp?B?emQxaStGTHMySjFkVHpHWlhaNS9PUDdsN1A2eTgzQmtlTndhTjc3aXV5?=
 =?iso-2022-jp?B?aGsva1E0QVRIU21GZ0dWelZhMFd4Zlc4RGxaUy9jNm5lYkM5M3lOUnJJ?=
 =?iso-2022-jp?B?L0xDbis3QU0vZ1R3enBNdDJnSkNDVk5iVEFkelJReVcrTE5QVUFlN0Nm?=
 =?iso-2022-jp?B?aktOSCs3RDYzSjNoT1VaeGpPUE0vd3U0RU9icHg2MDhKM3RqRDg1TDZv?=
 =?iso-2022-jp?B?M2FVNmZPeEE1VVpXWE0vMHd3UEdZSFFpOWtGT1JBdTRXbVpLRC9YT0ZQ?=
 =?iso-2022-jp?B?UDFvbUhSU0Zuc0FOQTlzUEhQcTNZNW9RQWR1WGV5dkdBZU8waW0zWThp?=
 =?iso-2022-jp?B?WTNXb0VTYjZvRUIyS2JsZUxyTC9WcUxGQmo2K0lPK3AyTEdKYUlTeHRC?=
 =?iso-2022-jp?B?eWV4Nml1M25NVHU1bFlkUWdTUndlZ2VPR0F6TDBwZjI0M1pmd1VjNndw?=
 =?iso-2022-jp?B?TXl2bk1lR09Xbk95cXJpQkI4N1NKSzZxZ2hYNFA2bklkK0JlT1ZnOWNE?=
 =?iso-2022-jp?B?aFlDTXBwd2RVWFhDQzErNEsvYmovaDlkaFUrd0pqNnVIam9zVnZjb09m?=
 =?iso-2022-jp?B?anhRc2RPcXhGd25kU3RveFhTT2VVcUd0ZUV2YWtsekEyOWRkZng5ZDFV?=
 =?iso-2022-jp?B?eU14K2gxcUdPT0huMmUyc2t4QzA1eGRFUjB0M3JsbmxiSGFsZnk3YjE1?=
 =?iso-2022-jp?B?N3I2bS9WTVZsQmRaUjArSWw3aTZKcldhUjFSQ2RYQWprcHhENEg2aHJq?=
 =?iso-2022-jp?B?SE9SMEZyVnJOYTJrTEtIcVhUUCtuS1hNeDZXZEpxZWJiTXVwVFZ4VHdN?=
 =?iso-2022-jp?B?clZudzl1M05nWXdya3p6U2czalNCTFFGNldMaGRRWmZrL3lrbE1hOG9O?=
 =?iso-2022-jp?B?UTJpQktxbTJleXdGUDJBU3dEMnZpWUZqYkp6WjZjc2xKYWE5QkVGRHl1?=
 =?iso-2022-jp?B?WC9pQWlqd1FzSEpZZVVqTXJ3K0VPMEhiUkJFNG9jL0NKU3R5bUlZMm01?=
 =?iso-2022-jp?B?NlpNWlRaR1BvcE1CTXJLeWpqYlhRUHpNT1E2alNhbVVwbXZzWFVheWVM?=
 =?iso-2022-jp?B?WS9pY0NWWktYTFZ4aTU5TnR2c1J1K0NVb0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0ee253-f2ad-4218-b8e6-08dd1911daa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 11:57:42.9233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ct1TEOXIN0ja8ZF3QiEws3enZU4NtLPRpwaknUYW2UqpjeIWaqNF6I7HytmKQef9qlXYWAhV/2204RI/peEMwBaIWFB5Yv6NrG7OgkSLJK18b2HYmQVu6rCXoScTSa2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9963
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Dec 2024 11:57:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17388

Hi,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> Sent: Monday, December 9, 2024 3:12 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Friday, December 6, 2024 6:11 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
> >
> > Hi All,
> >
> > This patch series aims to add RPC-IF support for RZ/G2UL SoC and
> > enable it on SMARC platform, along with enabling tx width to 4 on
> > RZ/G2L SMARC platforms.
> >
> > All the patches have been cherry picked from upstream kernel.
> >
> > Cheers,
> > Prabhakar
> >
> > Biju Das (5):
> >   spi: rpc-if: Add missing MODULE_DEVICE_TABLE
> >   memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOV=
F
> >     pins
> >   arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
> >   arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
> >   arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table
> >     for spi-nor flash
> >
> > Cong Dang (1):
> >   memory: renesas-rpc-if: Remove redundant division of dummy
> >
> > Geert Uytterhoeven (2):
> >   memory: renesas-rpc-if: Always use dev in rpcif_probe()
> >   memory: renesas-rpc-if: Improve Runtime PM handling
> >
> > Michael Walle (6):
> >   mtd: spi-nor: sysfs: hide manufacturer if it is not set
> >   mtd: spi-nor: remember full JEDEC flash ID
> >   mtd: spi-nor: move function declaration out of sfdp.h
> >   mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
> >   mtd: spi-nor: add generic flash driver
> >   mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver
> >
> > Miquel Raynal (1):
> >   spi: rpc-if: differentiate between unsupported and invalid requests
> >
> > Wolfram Sang (1):
> >   memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
> >
>=20
> I reviewed this series. Looks good to me. I can apply this series if ther=
e are no
> other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Applied, thanks.

Best regards,
  Nobuhiro



