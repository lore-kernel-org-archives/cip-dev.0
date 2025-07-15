Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ADC83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 09:54:36 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.46])
 by mx.groups.io with SMTP id smtpd.web10.4727.1752573274889066518
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 02:54:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mUq2/1SL;
 spf=pass (domain: siemens.com, ip: 40.107.159.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN6dqmaNJ8nVc7hkQSazh35QPiCkh0hR9UDbGFgoT5aH98nW1YlFdSNQOIStRaM4Evsw2JZ1ock68HjD6l+x3cUgQanOkIJ7DikML0j2ZxwB8nc0+0Rd0axwHbMZnj4sR0Dep7WrhW48/ISCmTz4aq4Ongu/Z0VVtIPxdtYWiDXsOvsXM4C5ddH/jZJ0aDKNN4q8wprmZq4iD4UB7BPm1X5ZiSD95JbTxZcPTshlznwMuFFQIjNMhhNFCZAEcQ83kzhmxcEKxfIMDwgNBYHNSlZMXizYyAvxhYhp3C+vge0CynpTCRQUm2jcNaYo6RHDR4KOBTmV1TaZzVza0N+meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tcfk/YJJlOyPBq9aPba+eYDr6mI5Q7lQ/yTw/e53Bo=;
 b=Z55fh1SpP1Yge/qyL0OEueBeH1lzo2YYvhDDw4Ecbtj4ifzOM6QTn+p9fZOm3orkuP/QQgG4UG8+KdQ77ZRUAAixAWF1gJQQDWdNLnjxSzRJiMRGSlVTTy7wfiTq1qlkyjzX3fFYsjDwXmqzZ3cenIrH9Gu0SbrhTgXcE3ubohrknerlOzx2rIw/A0GyZOanShD88M1e29GG3gUgh32HLctSBrHMwTDf3vRo5bIe5DtO/m6qs5RZ8vGhffSgtPlyZIb+2bYspEsazeJGLFj8OV8VWJ2qf2AJ6DV2rCaW1doQWYOVpQBiBtGK4HcRwcXQLMMDqxTnVbzHY4hB6evBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tcfk/YJJlOyPBq9aPba+eYDr6mI5Q7lQ/yTw/e53Bo=;
 b=mUq2/1SL/AUi7NkjubBUR0+SaD0MAvYCgpwIsUmy3GheEDRVZWATd4lmJxHmM5l2tMLHZXlB4x7IZbcLajK2fwFD/+K5CrpMTnpkgCHrOhnT8gNQdRWwiDEsFrdhR5BQGu4TvGfTE0RxEBhq0GHGHhjF2Odk6BYhbERfjc4miXIf7bnpUoY7KDgZdEgVFYGngMJgxBccvKHikyVDjpLN+sgE8gTXvAaXHsN74u6N8/4k5YXkD9PUL1LEW6gW0DEnEiRxJb0kgrvZF2iGm4WaSjDXG67s++jS5y3Lag5iVOaP+wZQ/MW+ZJFj5c6GmLsAUM8JwsL7IXk1GuajUPxGMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:54:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:54:32 +0000
Message-ID: <643a6b8c-feb3-4b27-8fe6-f76a30ce0a3d@siemens.com>
Date: Tue, 15 Jul 2025 11:54:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075915C17031D280B208A16C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075915C17031D280B208A16C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0197.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 24994c27-10f9-437e-247f-08ddc38598cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aUl1R1d1czFVWnVOdk5MVERqYk8rTzFhUVgyMkM5Yk5SMXUrdXVIOUN6dXRh?=
 =?utf-8?B?UWJOOW1mN1dOVGdQR1N3RUM3T3pFQmhqa2t3SEMzakRjL1AxZDRxMTE3Zm1a?=
 =?utf-8?B?OVp2S1FXKzhMVnFBa2tMUEwwRENGczcrWlBXMUQ0WXNid3paUDJ0V0JnWGRB?=
 =?utf-8?B?TlR1cmhKRks5SWR6dXVFZEVJWFE5NXFXTDNLY0xXUTRiaXNiM2xVdzNkZjJ2?=
 =?utf-8?B?cE51TU9EV29lUERpSmNqYnBSZnBWN3A5cTl1ZVBJZ2JnL2w3SUpwVnR0Z2g0?=
 =?utf-8?B?SWVSSEUxSGdiWllCWnJreSt4NUQ4UjFReGFHSnlsU0hKWmJFaUw4a1Q0SEI5?=
 =?utf-8?B?aUhpVFBUQ2ZzZWNnaGQvNmdmaFBpZ293VENlS0krYnVWamdhMUo0WWwxSjJ5?=
 =?utf-8?B?T2Rnb2U1MWh0dGU5RkJLY2lSdEdiMmlNTGVUSWFWa1FEU0RXbzh0R2dGaFY4?=
 =?utf-8?B?ZFVsb1grTUpSREk5SnZBSU1XKzlGeHpqRGlXWWRsT29QWDdWMno2cFpJRHJn?=
 =?utf-8?B?ZCtycnNSdE4zd09zZEZrd0oyd2Q5b1dqVllnL2pwSjVoVktzYjhNa2tBZW10?=
 =?utf-8?B?TjRHYXNteVJjVmJCb2huNlh6dGpyWkV2TXNLU1pmdmFTdnRwNDJUVmU2czFp?=
 =?utf-8?B?Ryt6L3NQS3BSdG1kcEdTWFZJS2hlRmRtSDdnR3R3NEZKa29YQldIaUJxbDZI?=
 =?utf-8?B?QzZrekRaUE1vMUZPU1VRaFRrbU9GY0g3RFA2NEN2elF3TlBYcmFycXI1dTJh?=
 =?utf-8?B?ZDc3QzFvejJEZ0JiQU13aEM4blJHaW14VDVmUW12SUg1VHVSKzFKK1R5cTd3?=
 =?utf-8?B?bmt0TW12S1ViRmppRmFCL24xVEVNaWo0R1JKNVgwZ3RUVmd1aFJ4QmtrZkly?=
 =?utf-8?B?SlJTaklRVXpDUHovN29YMnV6TnZRdE5xZFJVZXYyU3VTQmxROFZmVUFwbldh?=
 =?utf-8?B?d3Q4cjcwRG53aWxQS2pQc0pJNkErR2Z4MVhxNU1YK28vd0xkRUpMMXplTUVw?=
 =?utf-8?B?aU5la1dJYmZCVXhSSnpIUUdPK012ektrY2xyVU8vMnQ5WEU3cGlLcTBpTU9J?=
 =?utf-8?B?ckZKNlNMRStPaERuRUgyemJ2dTREMjVzSmtCd3AzQis1eXg5TGhkcFFXM29m?=
 =?utf-8?B?TENHV1E0VWk3ZXNNOFU0cENGMmNxc0Fpd2hhMWtZNTJuaU1HcFFGYU1tYktO?=
 =?utf-8?B?ODh1QjhTSHNRU3EwTFd1TGZRMXV5ZWpPY3ZBSCsrY2s2ZXBIZklpRWF2WXg0?=
 =?utf-8?B?S0VWOVlGd2lKM2MxTytiN1c3N0ZwdDBFMlNLdGpxZ1NzYVdQc1ZFcmZ3Z1Qy?=
 =?utf-8?B?bVdxejFQaklTZlowZ0hxMlNVL1pKQzJTR1c3NDdVeDZSTDlveGNBQzhDUWlw?=
 =?utf-8?B?ZkxOL3B4MGEyWXF4YkJFUXIzS1dRc1hMcGNhRllGUVNwYkdGcWVnbEhjOVVY?=
 =?utf-8?B?VEY5RzZVblNjT1lrRUg1WEQ0ZHVHNHNnODlDWUJOVDd6UzNOUUZ0SUFsbUdy?=
 =?utf-8?B?ZnBSTkNNV0ZjeUNzaG9VQm45aXdMN0p2TXJSdENGck9wR2orVFNhSm9SSzFX?=
 =?utf-8?B?K090dG4zdjVUSHB3NUlaMC82cU5FTjVEKzJqb3praGVyZDJzS1pZai9BcTc3?=
 =?utf-8?B?dFBBSGRhRmQrdnNPWC9DMjdGVDNpOC9ISWlhZGR3REZETFI5WkRkRGF0MDZ2?=
 =?utf-8?B?ZVRrdW4vRjhYUGk4cldsdlZCU0thTDkyTHpDR0hJWnJTeHNZYUhaMEpXSWRi?=
 =?utf-8?B?cld0L0dPeUxTQlpjY0Ura29BbU9GUTlDTnFvaE52MkNXMjdNd0dIaFBRMVpB?=
 =?utf-8?B?ZmZISmxYUWZyeDFFWE5yYVMvSEVsR3lOL3hHVGJySVVFU3lsZCtxc0R6djZj?=
 =?utf-8?B?MnZqQ09uaDJGajlVaVpmSUF2REVhL0orbE9jWGFyQlhPc01zNERoT1RRdEpn?=
 =?utf-8?Q?rQssbCy9Zeo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RE5kZ05BRmk1QUt4c3VwektQS2tsWjhTQzlPeUxRTVhnRU5lR3lBOWI4Nm9u?=
 =?utf-8?B?RGFTajlBdGsxU1lXSVM5R1JhdUdIVjRVeEs1cHRYWVlrOURGTFVTVWVhZFhP?=
 =?utf-8?B?NG5VUTN4Rnk5SllnVmtwYmU1ZWtpUXkxNFVBWlNwRDlHWGs2eGtOdGVBRVQx?=
 =?utf-8?B?L0ZaeGdYYkhZRUNFajFUQS85N2dwcFlENFNkamRSeXNLV2xRdmRnRWVlenBs?=
 =?utf-8?B?UWxoUW11TUhHOExlZVc1ZGt1Z0hFdCtPUjFxeGdWbk8yK3ZNMjA2Z0hsMDVw?=
 =?utf-8?B?UFM1ZkEzRFhkZk9XY0pDaHlLdnc3WXBCVm5kQzB0bUduVVJFSUVZSE10MFNJ?=
 =?utf-8?B?d21Pclo2em9MQ1JBQTZjVVJYNEtMR0FRQnowNzJrem83bHp4bTFyY3dYQXA1?=
 =?utf-8?B?Ymw4YkJpTmlyTkIyc1Y0UTJFeHYzWlhEZ1laYkFjMnJZbjVhNmFTN01URTQ4?=
 =?utf-8?B?OWhpNFJKV1Z3eE9pY1JXNVI3Wkl4Sy9MQ3BYbVF5eU84T3FmcXF3ZVZCMkJS?=
 =?utf-8?B?dzdJU0xQUE5IS2RQaXpFQTNXcXpLdUZIZHlWNmNnTWVMYjVQVHhOWHhPTXg2?=
 =?utf-8?B?QjVKQ2djUFlNQWhTeGlNRUlOZWx4UFN2SC9FMnlzOGo1QkVTUVJGaG5SUXNE?=
 =?utf-8?B?ZUtOalFva0UzLzg4QzV1cHBoZCsrZHY5Z01JNHpxWkhoNU8rYjJmeVM1cndM?=
 =?utf-8?B?WXhTdXlBc2lTUm9mOHREZ3RjYXFLQm9kVHJvKytDOFN5VFJob0NCNVRlSkZZ?=
 =?utf-8?B?UlVtaVNtKy9SWGZLNVVzN29VV2h6cWYvMkNLdHNIMFRXd3dqcjNiYm4xcG93?=
 =?utf-8?B?Q3NBdjI4MlUxUEdtemd1WlFXZVo5bzRseTZvR0tkekZiL2dRdDdZY1ZobmxM?=
 =?utf-8?B?TGwyZGdqZGFaV2xOMER3aVpMUTBEUGRSMTcreS9Yc04zN1dYNDN6Rm5yNmZC?=
 =?utf-8?B?eGFBcE5xSzQxL005cW8zYk1DSTg1YmpWS0loYVUwaHFDc2NhVVdBNXlRdzNE?=
 =?utf-8?B?WnU2RFMxQ29zclI1RHpOMDhGM2tzQXdvN2E5aUlWQ2RYY1BKdVduMVZGaTdP?=
 =?utf-8?B?aDlHeVJzblR6Tkk2MFlRR2NWbUsyWnpEdEhIcDFQMC83WFhDenZpOVFFc29V?=
 =?utf-8?B?ZXhvdlg3ZXFIM1JBbHkxYmlCRjJaUi9hYjNYNlh2NXFhZkdUZHh6aXVYUWJS?=
 =?utf-8?B?dERKZ0pGNTNtSFRzTHpIVXZjaFBTNmtYc2dnZWVkRCtHV2I0S0prRXN6TlNZ?=
 =?utf-8?B?eUZlaGVycEd3Wi80Vms0cER2WnFPVENqNkJnODZFa1ZDcDA4SHVRa1hxUERu?=
 =?utf-8?B?Wk9mMnFPOXZyeWZoVzRMeW5TVEdzUXdhMkp3V0hOaTRBYVI4dUlJU3FXN0RQ?=
 =?utf-8?B?NTVWb1cxYUZOSnNSSnlZaXAvbU9tYTVXd2pmOVFtUmV1bkJCdFRFQXNuSU5q?=
 =?utf-8?B?Ri9MZ1cwemo1SWRZY0wxcXNTTWxEZUMzeEprZStRVEEzV0Yza0h3L05hcWRq?=
 =?utf-8?B?RldoR3ExTlo2eGMvc3FiSVF3N0ZGWWJRRHNZU2ZBbmlCUDN1QXJmVk1zZ0RT?=
 =?utf-8?B?aHJJMjMyWStlaUgzemhJVUNwazIvMW9HY2ZYamYwaUpOMFpZN0ZpU3JILzl0?=
 =?utf-8?B?OWorUGNHVmwyelBwUVBnbnFOL21Ec2syNUpFSHA3MUxGUlJ4RDdRanpQUkQx?=
 =?utf-8?B?SlJzL0JMTDlxaWM0VUZ5cEhHdDhCK2ZZc1ZyczkydFhiTVdQYnByWnRwQmdU?=
 =?utf-8?B?S05nQ0tSdGdQOXZ4cm5xNEZJOWNQR2dSbzRKVWQ0eWxlN2d1NVRYOUF2S0d5?=
 =?utf-8?B?Q1RQVi83QzB0MzlnTG9VUmFKdUZWVGQyWFZRSk1iTllidEYrT0ZjbjZLeGdr?=
 =?utf-8?B?VytPcitYMkpYK0NkckpKUkNTQlVCWVIyQUVKTDJwK1lpSS9mVnhvLzRYTTVP?=
 =?utf-8?B?Ui8vSmhGQnExelNYN1VkQjdZd2JVVEN5UXlQbXpZRlcyd2hBZUFXWlZJanVn?=
 =?utf-8?B?bnljanZrWHB6eFA3akcvY2Z3N0ltRDQ3RmpwOGRIdysyd3JCUWlDMFJNbHJI?=
 =?utf-8?B?dzdzZmgvUkdiRWtzakl5MEQwUDA5VHNjemh5ODlwcjlBSHFEWDh1QWhJNllj?=
 =?utf-8?B?V1lMbzZjb3VFam4wTGxkNGxaTXk2U1J0S1RTRmh0UXVpR3VvNHZrM2tBTXhQ?=
 =?utf-8?B?V3RpbkZiNEl1NnhqcWVWcEs2cm01Q254Uzg5Wm1QUEdNZ2xkZ3lVaW40Zlc0?=
 =?utf-8?B?cUh4UWhNQ2VMSDlaN3hrUmRnM3V3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24994c27-10f9-437e-247f-08ddc38598cf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:54:31.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQEoSPs+jsIXlb+g6deDJAbpjx5mGOSrQCmzTR+AHjP/wxJsvMjRdVg6tlyiRT5Z8hnEJvMKd1hPt4kYGqX4zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 09:54:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19536

On 15.07.25 08:21, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan & CIP members, 
> 
> I have investigated further and found an alternate way to simulate the dm-verity corrupt issue in LAVA. 
> 
> Step 1: Extract the .wic partitions. 
>  
> There is tool which helps to extract the partition contents from .wic file i.e 7z 
> 
> $ 7z e cip-core-image-security-cip-core-bookworm-qemu-amd64.wic -oimage1
> $ ls image1/
> BOOT0.img  BOOT1.img  efi.img  home.img  systema.img  systemb.img   var.img
> 
> Step 2: unsquashfs systema.img (ROOTFS) to extract the actual rootfs contents.
> 
> $ mkdir temp_dir
> $ unsquashfs -d temp_dir/ image1/systema.img
> $ ls temp_dir/
> bin  boot  dev  etc  home  initrd.img  initrd.img.old  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var  vmlinuz  vmlinuz.old
> 
> Step 3: Create squashfs image again and write back to .wic file.
> 
> $ rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-bookworm-qemu-amd64.wic | awk -v name=systema '$0 ~ name {print $2}')
> $ offset=$((${rootfs_start_sector} * 512))

How do you account for the dm-verity container here? What you get it
just the dm-verity container start, no?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

