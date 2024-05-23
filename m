Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F818C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 06:13:09 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.88])
 by mx.groups.io with SMTP id smtpd.web10.9033.1716444780758015836
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 May 2024 23:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z8rvd0L5;
 spf=pass (domain: siemens.com, ip: 40.107.13.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5ZSFmJ+RLWbXo8rP6ZNAi8F0VaNPHaPoBuOr8DeNsuvcNjzDQ93kT7in1MsXLKqhxy/x9d5dynbBhwv6T4q6ko7uvcb/sjVtGsgVAHRyM68laxnLAU9ydBKySeUL+RkDvi8ERpmIJBVmr9AzuD1aZC7QvozuvZx1cZPeQmIqGBeMM6YyUWtOM9GU23xhMW0Xmh+ODHVrTGg+OC5qfopkEVaYY6MkQxykcuZGGGl8VAaYZs4gyLvjnhub1ego569PiLUGgucxuf3cl5lJFXe+4kmcy78gclBfTrLniKjHiCOmbyks+gV2JNrOswxzvk49GyH1LJyZC27OzM7/rmyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+opN+b4MmaRbtGfSbm3Mn0pEBl7ICA60CbXLZaEL7QM=;
 b=MJqVA53p8Pwrczt7qSkzweFeCqnoo4G8OEUYdPEg2BJiBgF/dKRKklCvSIL5uXeV8YmELSK+GyyElKSdEntnCeCDu0Gz8w32/4vWdzSFK+L08ZiuKlOD8xWldoe1wCxls9zEHa1UIeGirHtqjKUb/cyp4z6G+kXLs0r0kPTP1xL5sTf5fLyoxaaK84fa+bAyOp1y3fFFFzswSweGYwyCD8WRkbj6kMZDOdImKB7W9Dl5BXKRT+h1hPSUkjRZLj9qgxQPBw3bIl00MI/QZu1ZzolXNf33h12mFlIFDWIPyYsiK88HgziTYyj3qR8h8wEZ6yimORb9DAkS8XecK4llsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+opN+b4MmaRbtGfSbm3Mn0pEBl7ICA60CbXLZaEL7QM=;
 b=z8rvd0L5qL9DP0uuOusdymeZxGtFB6XczFIcsKqBqVs69qYmNWfbrDOE6h1izj+dvqfvaFCEy+ZAWthU2Tt4d7WIvBO9K8Pe0Xk44hjTrcjBJ5CI4xghl3bL0jyhPJEdXLDtOFbrMqfAmNyt9Mfx1obT1ZvRMlqyxqopLcDff0bow2HhOdtUyrH7+HDZ5mG7/XAfNjB0JlpBxkwNm9AYcwlqzR5oxrT6dvJdgpNelcCEH5DCEd4hikrh8Uz/BNPLNMnwLOJG3ewTMrh8GCP0bSeRWT3qSdjsMHFezx0UDL9SaBsY31dzy+Wvi98adp5rmQ75bMWXL37ceD/7eJ3I7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7816.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 06:12:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 06:12:57 +0000
Message-ID: <d9349919-2154-460c-8952-38e374b6f6cb@siemens.com>
Date: Thu, 23 May 2024 08:12:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [kernel-cve-report] New CVE entries this week
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <CAODzB9pO==EZEVU-weviDj06jaHWEco7QTweYS3bvZaKq48NHg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <CAODzB9pO==EZEVU-weviDj06jaHWEco7QTweYS3bvZaKq48NHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: aa29b187-584c-48da-978e-08dc7aef63d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q09xa3dTRVB5TmNoY0VSb0p3SW9WZ0Z3RWdJVFkzTVhzMjlTTDBtQ0NnQjla?=
 =?utf-8?B?TzEwdzFXRTUzbWpjTTFpRXZldlZFcVFPVFV2NmU5dExiOG1mUnZXV2VCQ29q?=
 =?utf-8?B?WTNsempyOWFPOEFwSnVIQ292ZHJ6QkZyQmVmNjRHMlBKUUxjWFU2L3JvTm8v?=
 =?utf-8?B?S0NKQ3l5akc1NkJGcW5EZExrWlpSUkNYNmFlekRNblludUFzUnQ1SVZ4Um5X?=
 =?utf-8?B?dXBGanF3OG1VTm9pT3piMFkrTkFFQWF2Nkt4WWJCVUJpYWFNbldZaWg4L0Fi?=
 =?utf-8?B?N0J3OXdGM1pJY1g0TXlJMlFNc1Q0UW9MZkpONFlRQ2g2MS9lQ3krT2lTTit3?=
 =?utf-8?B?bWswM2N1LzQrSWNVM0Q1R203dTZXbm41eklVWTlra05yQktweTJrRGJ2YVg2?=
 =?utf-8?B?T3VPWEg3TFFSM2VhMGxqcVNKVnlwWGkxdWRnNGt3QjQxWEF1cjBuaVVEMHBI?=
 =?utf-8?B?Z1Y0bW82U2dXWEJVR1FtNERUTjZ4RnF0TVVLM1ZmUVlnc2xQM3BCUjR0ckk1?=
 =?utf-8?B?QmhNblpCZWlhVzlTZjJYWFVxM0Z3aS9wdVNBZXdWaVpWc0U1RHdSRkZnWWtx?=
 =?utf-8?B?Z082Zk5US2NYUlk0UmgvVGpCcGVqYSt5QVc0NEdMQXFDdGkxQUFNTlNkcUlF?=
 =?utf-8?B?bDBSWWdIajNBa2dvUmRzdGxmS3pUUlUrSHNpSDVVVmw3S1J2bHF5UFZrZGg4?=
 =?utf-8?B?d3RSVHJudVZOdSt5K0lDd3FjZUNYQnZqSHVVOXdISGNKbm9Wa3ZRMnRnc3pl?=
 =?utf-8?B?QW9tK0tQMjFpZXdzQU80RUlnekhJQXdFYTJkNXJJYkZJOXVtbjhQTnZrU2VR?=
 =?utf-8?B?aG1BSCtDK1RYWWtzK0xlRXJhcGVtQVREaTBrRnRFSnhkeHlGM1p2ZnkzalRz?=
 =?utf-8?B?TGx1d2Y0Q1BydDdIU2Z2SE9ZYk9SWE5VTlAzamtwQWUybUFWR2NJeUlkQWR0?=
 =?utf-8?B?Z3FHeHJMLzZPekpNR0JXbmlrc0RUclJacDNiWDQyMkZhNTNlTWRzaVZraUQv?=
 =?utf-8?B?MkpvT0QzbG5teUlsZHZnTHpnOTFBWVowZUxUckR4VFhoZFpJd2tDWWFjU2d0?=
 =?utf-8?B?cXVkRXNtb2VPZlYzMmdicVduM1I2M3dBcXBxdnJmYmpPS3ZiSHRrLzhIZm9a?=
 =?utf-8?B?aC9ha2RRMWpSdXphd0kwUXJtUDdRUFJFZ0MrTkU5cjdXZEptZlRrY1JnRzhq?=
 =?utf-8?B?WTVDbHM0ak9GN1FUSEhNMHo4bSt2VUhtMUJEVDJlMGlMTytueTB3TDBTTG52?=
 =?utf-8?B?d0Qyck55NEoxWFBxRHVtMko3dk4wM3NxZGpLaFJUd2V6R3RiR0RpVWhOQ292?=
 =?utf-8?B?NUVqSmp6Z2owZnZJUHVvTWlNRnRjQ25wYjkvY1JmdTQ5T2NZempJeDRuOEp0?=
 =?utf-8?B?QjVka0dOQ3h2eHBWdUpVck9RN1BRWitFS2dSTjVQRS9XeFpQMWlBeUpaR1J5?=
 =?utf-8?B?N21tRzUyU3hpZkMxMDVMb3dZazhRN0RqckdialN0REFWLzQwelJKYzdKT3N1?=
 =?utf-8?B?S25KQk1hQXNSbllpWEYvQlNCNXVRMytrQ1o2TW05aUlyYmE3MngxNXYxdURm?=
 =?utf-8?B?Um9WZXNNYUsvSzlVTGNkUjUxYjdKNUd1djR5TzZsTS90SWU1WCt4ZHp1T3k3?=
 =?utf-8?B?eU1pd2dwMCtLeEhsYndNbHhjTmJCTEJoaDljL3FpRUZOMkVSQmtvaUtCWGpE?=
 =?utf-8?B?emtXemNjN0lmY29laVhnVVU0ZmNFRVQrcTFMN1lNV1VPZE1HSHMwZldBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3VxeGNOeHdoUThDQmMxeFhRaVJYQ2NXQnFNQ1FxNEJrUURGUTZWbEEzbTZl?=
 =?utf-8?B?ZTJ3MHlmaGhKbXJYMTlia01lY29xZ2txUW5RZFE2bi9zVVcwZFNDQy8xMzNT?=
 =?utf-8?B?Z3BFVHBVZWM5OXhSdVMxTEM0SGFINWhlSklhT3VYbWZTYjQ5UW1wZUhpV0p2?=
 =?utf-8?B?d3I2bnBGSEdHbkhId0RmQzBiK1IwRjNtdy96cHZObUYzc3pCL2NyQnlpY3JU?=
 =?utf-8?B?TTN1UFBKNzhQOU5yRjVVZGZFRW1JTFNNYkZRY1d2cHVBZXJQMHlZVFdaL25K?=
 =?utf-8?B?enhjNFZ2dGVxM2pLZHA0YXV6ZXVJVGx4NTNwdXVSOXJ0U0w4K1o0NklXVTlW?=
 =?utf-8?B?VmpNck9NYzRBeTlvTTVET3FXQmFBMitLaFNDTFJLeEpDT1NvbXdjYTVycU5U?=
 =?utf-8?B?djA0Wk1hVlM4REZYMlR1ZnFpZ1VFNDllMVN1UUVYTVVjMWpERkdDVDB6MGVG?=
 =?utf-8?B?ekthS1BsT1BYNmdveXVITWpXZENHdG51c3oxNWgxNFh1QnFrMks4SHFZa3Bh?=
 =?utf-8?B?Rkg0cTZsN0dmZUdrV0p6eDF5RUpDTkY2TGRKM0ZLNGs2bVpPbkNNazRucTdi?=
 =?utf-8?B?U0ZjYlFYYnZMYVlYYmlsWjloY3ZWY29nOU1tT0Z2RGFSM0ZyWWVzMWpUMkZa?=
 =?utf-8?B?NEpaTExVYy9oT1BWOHQ5K3k1RzFFSlJtR2ZTT3lrOG9QODM0QU55YmVObnNJ?=
 =?utf-8?B?cDFaWWppRWpEN1lUU0dRb2ZUNzZQaHdZMmIzYmp0OXdmU3FVVkxLbWN0WTZi?=
 =?utf-8?B?dVlhZlhpN1AvREg0b3hlQzVIMTBVaDR4Mmk5S29hNVczeFdYZjJmaXhCS3ha?=
 =?utf-8?B?ZjV4dnJnbnFRK1hnT3NMRUsrYnhnTU1WOVFkNk54OWV5dFZDOVBjZXNOMyt6?=
 =?utf-8?B?eEtxcW5iN3ZFcnFQNWVVMDlCVnFTb21YalFWVjk2Q0syVUNQN3UxWDM1V2hP?=
 =?utf-8?B?dVZySEhKL05ncUloZzN0Q25pemUrZ0ZvS1Nqc0NWdEFSMTlvN29CWGczK0Nw?=
 =?utf-8?B?WC9QOWI2QTFOOVdqVVk3RzIyVGZCU2wxTno2cjgyb2Mva2lpbmtXYzI1QTd3?=
 =?utf-8?B?a3p5aTVBQ2JXUmtmdzZ2T2xTZHVmT084UmVCdzNHWDAyWVNzSjRmc09SSjBs?=
 =?utf-8?B?R3UrbVJKTWRmSW05dkszRVdTNGNKcnlGejFCL3QxVzlWRmtnSWJLM3NEb0pL?=
 =?utf-8?B?VWpZVU91dktjOU52WitFeGZKTUdSRGtxRG5MZDFYRlFrR0ZKTW5oSDRLRE9V?=
 =?utf-8?B?OVArem9jVWhFSEdzUTFNTjRWdm1xRVZiWUh4WE5TdlFhTE5iVnl0VkZFbGJV?=
 =?utf-8?B?TWJvbzlXN2ZLNHVYeVJZYXlEUS90bmhpdFgvdHJSNWVoN2pwUE1wRUR1QWFO?=
 =?utf-8?B?T2kyN3BiMm5VNVZSREdnN240R2U4Tk0zbGN1ZDVKRTArZG5kcUhxaVNhY0hh?=
 =?utf-8?B?VXBCT1pGL0gxR25YL0lpckRIRDZHY1kxRkMyZXFRQSs1bEllNi9TZ0YwVlJm?=
 =?utf-8?B?eU1nT2RHeXZuMTIrenVYUEF0UjhIMExpakUzeG8yQUo4V0JGOS82ejJkQlpU?=
 =?utf-8?B?K1pZK01nTFZhT0VEZTlhcXhNbHAveVkyVTNPaDA3VnVSQ05uSW83SjRaV1Jz?=
 =?utf-8?B?dktxRmVJanVKdTYxbEV3YmJmVlh1WE9SZ05SRUxXbzBhMHdIY1BjYnQxUUxN?=
 =?utf-8?B?QUVDd0RSZ2lnVWZza3ppaHd6dWJjS1hDbUlSd1ptMFc0MDdBeEQ1QStRbkNV?=
 =?utf-8?B?SnE4YXRsSlFNQWtiV0ZvblJvdFlQaGZsQ2FyTENMejVjOHpVTHBPY1BFTEpV?=
 =?utf-8?B?d1lRVHlGVjBFSHVleG52dVNXNW8wc1lzdTNpcG9xbnpLeGdpTDVQOW5HTGRU?=
 =?utf-8?B?dGQvNXRJQkFzV3RVaEVsRWRLU1F0ZmlrbzlYRkdFbkdMMk41bWRJUmtzMUcz?=
 =?utf-8?B?RzE1Yi8xOVNhZjd3T21OVWgxeDloNzJyNGU5VWt6YVRPU1ByRkh2MXh0Wlpu?=
 =?utf-8?B?ZEdocmhrNHlCYlZ6ZVBVVG5CU2FKOHp3QjEvUzU4b1lIY1BvV2J6TmVGaFpk?=
 =?utf-8?B?L2w0TUlJUXJEV2dwdmorS0FDWFpFSGdFdWxoOURtN3l4Wi9ONHFFNFNYeDBQ?=
 =?utf-8?Q?MqXYv1APYMstUbkmWPK+vFJFE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa29b187-584c-48da-978e-08dc7aef63d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:12:57.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVq74rZe0LPwXFGsdfTH4+EqaUBQt9RtbS7TdNS1ikhzMRsAStSDMCuj0wY3mxkD4N3znf0JCDwGIz0HGROBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 06:13:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15926

On 23.05.24 02:56, Masami Ichikawa wrote:
> Hi!
> 
> It's this week's CVE report.
> 
> This week reported 685 new CVEs and 8 updated CVEs.

Ok, that "compensates" for the calm previous weeks...

Jan

-- 
Siemens AG, Technology
Linux Expert Center


