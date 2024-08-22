Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD309C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 06:00:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.68])
 by mx.groups.io with SMTP id smtpd.web11.7200.1724306439704705581
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Aug 2024 23:00:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=la1/7Rhm;
 spf=pass (domain: siemens.com, ip: 40.107.22.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnLt+cwagme6asIMQynvVQdujhOaYnpWw4n3m7uje2UHWtHrj1s1YYXaMgF9UskqNH9LDB/N2bguzF3nkIdK8w4NhLmbqIgkfrkJCo0BWwNKon5z5ewsFF3S2KO3dmA8pFgRZrj/D/WmHp5+3M8OFbEE4SfaBG7dNbLIjcP1K0Vpcwwe/pamq492M1jUadVPXV8Dy72R5K1RyQ/AnpU7xpVcqEE2Q1LQrpeeXoD1yEprH+FR3cv+Xtd92NNf5oXKoMeg+SPhqqLvVs4DqNsZxDyD556E5D5QlRhQVFrgnDF0PUoOwv7tG+jS6P2thUJrrsFbj/tOUKsVnKtxMEkbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/w6BWyRKlfxdpKCk1EA6vWpNL9UEu/+yoxRC4iCngQ=;
 b=ERp/eykQHg2mhKGMjXayGf8VtW7XC//jaYzF6NMPiNosy0v2+4hFBYsUaGUmyKnlr+vUeW2w3zadLJpBmX8pF5YlauuIM8uV+lr46PIWeA8REUXiJX2cgKYDxSpR76xu2BVlmav74oJK3JImHUbhZeTnSCEXDm2QBrXejEs5cr5OKyRMdYFBYR26yDvU1fAavYLiCn7XnjkZ5mDzf/E+d6jjx7VMOYRaQtnWKYZxhk+fd/eKRs9kpYMzoiwcCD+tlLJ+ReDSOj7LjUlxkU9NX9rIZDSlR/8ZDKuJX5lr/OTM567r3BNQVmB/kscHgC0KtNogKOJ6bfmGoX2iyoXCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/w6BWyRKlfxdpKCk1EA6vWpNL9UEu/+yoxRC4iCngQ=;
 b=la1/7Rhm0xK1ww8v5DR26KOZXF/gUeDjxCjJI8UYNF9rnk7KpeqRdpMFIFE2gtfUld3kW79E83nKFTO/KH6ffTTNTd7Pp0/jLJ8+BUz6b3a63NPsv7r8lZ7DkDfLttWXoVuRoLsmY+LT26bo4U8FKWPpIm/GCrdl6dCJzAGrz1LO8X1vRJzH0kg88/eX7n++YuGvt0USZybQgmlMaEXEFAZEzWV8TMGEyzdBTHppHGV8bZURkV+9TxW98W2spodF/Rt6S64FS+thhMb+jY5E8sG3IJJOdKQk5pa+FmkyP3f82+plKhYv+BFe3FNd614gcGVIFsZZsbHcXE2bFFfgMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8667.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 06:00:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 06:00:34 +0000
Message-ID: <70d59c1b-4be5-4809-809f-a16e4282f94f@siemens.com>
Date: Thu, 22 Aug 2024 08:00:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: 86edef3a-1d90-49a1-87dd-08dcc26fbcc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUlRUURwNmxscVVmQzhHMTYrMFVCUVY0YVA5RUFCUUtRZ1k2eE1CcE1DRGRM?=
 =?utf-8?B?c1Y5VC8vUjRZRUVWMFpBNG5hcHRvanZBRzhWREk1VU1OSEtyQWZRQ0dwSDNq?=
 =?utf-8?B?V1pURCt4akNPUmlmV3pDb1QwV2cvK1lrMXpqZmg2MTArWkR4d3FqNXc5eW5I?=
 =?utf-8?B?MjZpNUF5T3N6dnRrUEdYK3BOeHI5MFNxRzlPYkdNNENCRnppamwzcnlHRFFo?=
 =?utf-8?B?bkpZRlBtNnhyQWlIdWlOYkVsWWVZRWU0Y0Jhb3diQmVSc2loRWJZL2xGbnMy?=
 =?utf-8?B?MERzWVdyYnozUW1xUTQ3ZlpHQTlQVlVTWVRZTS9TSENxektRbVJHZWF3dTN6?=
 =?utf-8?B?MGpmSmdOVG9TaWNvVWJnV1pRYnhlN1kxSS9sSDB3VFhlUzFPdHFjWWxiWW9J?=
 =?utf-8?B?UXQ1aU04Z2tuRzVSdU9QUmRxR3owdGxBVXhGakpqd0U5Y1ptVks0Q0FKN0U0?=
 =?utf-8?B?Q2kxVmd5MlMyaFlQWGFlOWg3MUwzQUZFMnVRSWtjdjhxZ1p0cEliazI2LzJC?=
 =?utf-8?B?RzZtc0VCeHR1ZGNiQmh0YitQd09oaElxUTJIVklWQVlkZEVDK2RvK0xJZXVa?=
 =?utf-8?B?YjA3dkFab1Y2cVhrcDQ3TEZ4RnZFaXZObDE3MFdqVTZlZStwQWVaRC9pNjF4?=
 =?utf-8?B?a3pFaU01Mm41R3IrNzdXQVNrbncybml2dEFNMXh0SVl3WmtRVHJHODRsamlm?=
 =?utf-8?B?ajY5REFobERwNkZEM0NneFpEcStQcldaM2o0SDdqa2xqS09NVldvcHBmb05V?=
 =?utf-8?B?dDcvVmhJRDRXdlAzQWx0eVBGcXVsVjV5OWJXWWd0d09YTllzcTVpWk5lT2hQ?=
 =?utf-8?B?SlJMTk5RbWYxMzdsVUtEdjIvZWlla3pTTDBoUkpuQWMyakxOejBLUklyQTdt?=
 =?utf-8?B?S2JBVWFwUHVSQXhudFhxVkRMWFY3SlE4bEFOdnl0UjlsTDI2MFEyV2lCVHdU?=
 =?utf-8?B?UzdleEVwWHZwT3dpSXRVTVRGR0U1bFFSRHdXL3oxZHpwTFI4RzhteWdtREln?=
 =?utf-8?B?dVhLV3g4cVVySzFVWW44L2lOeWVhRTZEY2UwdnluTlhaWG5mNmFBUkNtdEdD?=
 =?utf-8?B?RmtsekRTanF3aHgydXVaT3lJcWZxaC9jUGk2N1lDZjcyZjFINHV2VFpoQ0FY?=
 =?utf-8?B?Y1MyQVlhVGpSemRHL3RuVkt0RE81UHVXZ0NMNGVEbHZaTFJJd2NScGRkQ3RN?=
 =?utf-8?B?U0cwaFpoY2swSWRwU0M1RG1oZkNhSlk4WEpuVFNRSHB2ckVEYnVJZ0RkSXpx?=
 =?utf-8?B?a2hqcWdPcEV0UVRyTGdyL3FYWmRpZUdWcU1QeURiSlBUSmdBQlB4WVVzNWFB?=
 =?utf-8?B?WDhnQXdYaFdrdHR0Y09LaSthT1RIWnhoblEwTzN1MG51MXZZdFpEWkZGanl1?=
 =?utf-8?B?UkJVUzNVei9vUFl0LzFpOFVwR3FJN0lBa1pzRkMxMGRnWlh0OGVQRzlxSzBp?=
 =?utf-8?B?Nk90SjJKekxYd2dqQ1NqbCs2SXJiSXFvanRQb1JBQmtRRXI3N2lzaks0RnB6?=
 =?utf-8?B?bWV0R1k4YTJucWoxS2VJZ1cycUl0Zy9SWGRzZi9SSFYvUW5BN0RLTHhMbGRm?=
 =?utf-8?B?bUp0bGlLQTIrTlUwMnQrRzBjald5Tmg1NUdPV2c5Umltc2lIdnE5Yk9ueC9V?=
 =?utf-8?B?MlJwY2wxWitZWWpSMkhnZ0VtODVUSWpyeDZpV1BNQU9sTVZPNWpUdnc2dlpC?=
 =?utf-8?B?RlBvK0d3b2FabW1rOFg2K2FSaS9xcjhzdmFsRXIrMDR0ai81NEZkT2YySkJq?=
 =?utf-8?Q?bQhBhieMmZUMesliiw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnI4dUlZY0VUSFJzSUhENVhCN3d6UlRVOCtYYWtPVVoycjZtc01JWTdTZmdU?=
 =?utf-8?B?aG94NU8welBhTXd3Yi9WOHljZTcrU1JwQ1lTNi9jTUdxNU5RL0c0OHRxNkY2?=
 =?utf-8?B?KzlGT1lPWXBBSkRLSzMzM2s0YkIrMUxJWmhFNGhLTVhiVk52NCtxaThMMEFE?=
 =?utf-8?B?OVBhbld3WWxidjVmL1l1ZHhjS0l5MnFDTUtGQWNNVmxsdkpTNGlIZDJhU2lP?=
 =?utf-8?B?dXBvZWtDTUlBTWpHK3BtK1VyNXpvVTlSZnVTSGZGK0NNN2hRRmNkYXNYMVRh?=
 =?utf-8?B?SUUzSzJhdjZZa0d0TGFXWmIyUTU4MjAyTkc0L3JzbGdTL09xQkhIeXlhZ3pi?=
 =?utf-8?B?dW1MdFBpSW80RkJsMkwyYmlVYXlreFB6UTJ6TEhBd09qVEVacnF1TVo3RXRt?=
 =?utf-8?B?aEwyTko0aUxocm5xOWhka2oxZFZkcHZpYmd3NE9oUmw2MGxOeTFVRXMwaTlo?=
 =?utf-8?B?bDN2RE1QZk9mVUkrbUNiN3pNa0Npc1Z2V3hjOUlwd2kvYXFmUHFieEkwVElE?=
 =?utf-8?B?am54NEhnRGVqODc3VEJ6MlVMamZzRmJic25YQzNFSnJkcHRmcEk2WC9oYWRE?=
 =?utf-8?B?dkt3MGpSYXphbWhRTjdkRms2Y3A0cy96N09XZFhQb0h5SFkrZDJDU2FOeDYx?=
 =?utf-8?B?SCtpamd2enI1eHVTNm1NU0svNmRYaUVUa2w1eUt0VmYwMEtDM0ZaWlhJZFcr?=
 =?utf-8?B?TmkvQjNCZVRyc0crM1Y3UStXbnZ3V2N1NUNnelRrbGk5Z3o5cjVMVjhEdDNV?=
 =?utf-8?B?TUl0UnI1SnJSRlcyZll2OVIyVC9rTjEycllrRmpFeWhGSGt5OWV0Y3lPUmRL?=
 =?utf-8?B?WG1iRHRVeDdZUkx0Y3hBMzRYU1FBS3JwUm52ZU9FVnNGQUxXby9TVmNCTHhR?=
 =?utf-8?B?TzM4OWZQOG51U3BrTkUxTzdhRURpSXlpVWdOSzExNktadlBEVmwzTTVxbzZC?=
 =?utf-8?B?d0xXZER6QmhEclB5TE00UDJLdlk0RTNRZllMQTlkSERXRXoyUEt2MkdpV2Zk?=
 =?utf-8?B?MnE5ZlppbkN1bWhjdm5QNUQzSlpBWFM0N2E2SStqNHRBY3o0RDhSQjRhZVNi?=
 =?utf-8?B?aVQ5K0RpSGFPNFV1TzVDbmVTLzE0cWM2aUlkNWw1WFlzTVczZ1VTRFlVYkpa?=
 =?utf-8?B?bVQwSGxFMlZ3Q1hIN1Rnc1p4RjFjUVpQTWI1T2tpZWVSTzlTTzNDaExWQm9L?=
 =?utf-8?B?SVUvUmxCNHo2MStvbGM2R0JzMHAvb0tscVdseXRyQ3d4dE0vWlFiNndHWTg1?=
 =?utf-8?B?eXR0Tko0c0FrOWRwZmlTWHFCYkgwTU9MZGhVL2ZKeHUvd2F5RStIZ1FFN1dO?=
 =?utf-8?B?UWJuUnlKOVV2N1o1SHpldXduS3JNaXNkWmZnaHd4QW1CRk9IU2VJeFdkRnpW?=
 =?utf-8?B?NFpQdy9LUkNraVBXKytwVmZFblQ1Mkh0VVNXY21rOERZT3pNb29oQk5Rc1li?=
 =?utf-8?B?UTMvT1ZtNDE4ak1LMlRhWnRiOGFPZFRZRlJVUHo0WHRjc252cUp2MnQzUlhj?=
 =?utf-8?B?NW5Lak9EMlJ1TXpkdFl2cEh5MXVvUVh3eUp6S3lmSHFGVVA5MHpwTGxsZXBD?=
 =?utf-8?B?aTI0WFFneXR0QWp5OER1N1FGRmZKa1VmT09PQjVQeUh2QmYwSFo5QmFIR0JI?=
 =?utf-8?B?czdyYndkY2RSYVovS2xFaHlZQWlGUDUwd3hpVUp2RU4vWnVUUkJqUFJOTGFy?=
 =?utf-8?B?WEdtSXcvU1RBeXNPUlg2NUM2eEI4NnF0Tmh6UEI3ZGR3ay9vcFFMU01GWklK?=
 =?utf-8?B?UjBmSVhxWDlFYmovdWFrVUYyUDZSWTZwZ3dOSi8zd0JIR3JIeVdIdGNvRWV2?=
 =?utf-8?B?eUQ1UEpNSllpdjhKYTQrVm8yMTVSN1lySW54bmNDNE5wN2FLVVRYTThIaVdR?=
 =?utf-8?B?MlBkaGQvZXc0QkUxQzR0amhWSWlIcWYwL2w3aGhiMk9hQjYwZndWUTk4azlu?=
 =?utf-8?B?Zm9YanRVS0ZrL05jblZPZklKRkEvaXJiMzRLaDFCM2dvbm8xdkFPVzVkMlkw?=
 =?utf-8?B?eDlQa3hIVVFuMk9lZklvd0ZzNkJqTmM1WXZuSmJvZ2YwM3phRi93cnVxMko0?=
 =?utf-8?B?WVlQNXZpZ0RXWFByUE05ellPNDB5clI5UThmcEpnQmJsR2dEend6Y3JKcWhW?=
 =?utf-8?B?dEk4VU94M003NGlLTFd2NG43ZHZGc1NrcmJmamtsTXJuS3FiY3ZmUFNsQi9m?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86edef3a-1d90-49a1-87dd-08dcc26fbcc3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:00:34.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fTKyvJ70UGpx8sn+oN7nZlOVcLeynsw9tZwLnM+hWEhiomOT+V0KGhno65BWu60Cst8G6gjf4t9TW5QV7fSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8667
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Aug 2024 06:00:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16808

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=8&day=22&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/08/cip.2024-08-15-13.12.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
  - look into CVE triage tool [iwamatsu-san]
  - clarify role of linux-6.1.y-cip-rebase tag [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Aug  7 09:06:02 AM UTC 2024
  limit date: Fri Sep  6 09:06:02 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Aug 19 09:14:08 AM UTC 2024
  limit date: Wed Sep 18 09:14:08 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Aug  9 01:12:59 AM UTC 2024
  limit date: Sun Sep  8 01:12:59 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Aug  9 05:08:44 PM UTC 2024
  limit date: Tue Oct  8 05:08:44 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Sun Aug 11 09:13:17 AM UTC 2024
  limit date: Mon Aug 26 09:13:17 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Aug 11 07:14:28 PM UTC 2024
  limit date: Tue Sep 10 07:14:28 PM UTC 2024
  Status: On track

