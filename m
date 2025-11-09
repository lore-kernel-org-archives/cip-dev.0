Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33314CD1297
	for <webhook@archiver.kernel.org>; Sun,  9 Nov 2025 10:11:05 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22401.1762683044106684617
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Nov 2025 02:10:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gzP0fnS4;
 spf=pass (domain: siemens.com, ip: 52.101.69.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8nhAHbl1FewXLsZMFTCMfNVQxdzgHToX4W5rdBnYUUNDDAw0W14ioUUXtSJfOT+TvZTTRq/77oOyS9k+5KMsVTmNGYmb0Ww2OEurz94AVCBYTA79GDsPC6D3bGV64OE/mzbGcTS98+9l4VQh6+LID/mu0ZoUGNZlaLbME8wwE3D7MlozkmxOBNBohnkQna4gjMzOw2LQH3jRCTaB4TAI4X42/LZ397P0luLsU7pQh1XKDSPWY76Frl1UrukWxenXfCG5myQsZKRTOD7qTJs9kjalLsKwo03YBFy2TV/Ch4aDAlAQ3ZGEPIsXTLpoEVbxHbUYWuipJZ6D37lKvQuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQEy+iDYWiRCBa+mGbp9SKXaBnuPWOGdXLGQCStfIlU=;
 b=Q00BKk1eoAM/tmQYFHdPOhUr+6zQp51Hv+R8DPZxL5yQYJZnZR85+OYdW0Tfooa8xNxyKE90lQJZd7Czd12W1QbHx1KPlyT3AEmBURXimeV/aMGCGDhunc6r2J+aCxz6yXIm2saKRcE+qp3WrMJSIeH7nrfDKFli9P/ANFOTxL7rEhEzs9KaORv6M21EemnAJWoGY1AcOkv2FrHuaOHYXUvrn7S/lnJSqMsiueBDJb5XLay7a6k9rgAg883k4qRw9+INbTrgyd11CfQdhNzZBdhP+1gX8FhV8yHc72S848RA8ZMJUv7egTVeYTeJuF5oRL7JH/3PcqvhMDeg15B7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQEy+iDYWiRCBa+mGbp9SKXaBnuPWOGdXLGQCStfIlU=;
 b=gzP0fnS4rCjN/n/VOAvYQvoGaW9ly3NYJ0ao0hwuba908iyBfpwH+FhYdsN5LhvsClZLX/tOJEHVOQ7IpStLJPG4AZeGSmd8+P8eas6bDaDJ08k0HR52N4tai3POVxVqvQj7vnENhm0Gv0tl9l2GnLuZi9kT+QZ4PnYEOkuY2rDcImKsL/mg0g7uFpFNJG6Rf32Sv4xjR3LKSX5kRP4VCD97iZHgf8UDL12XHuox8JQWnoYVIzZHLaGweAEDxUSJ5fuahBkeMOGQt3zf3jeSdsPG5ddSad8DNV6pfD2zL4Jc1nuc4ANyVqP3nSpn4VH6w5eWKX0l0oEXXmxStps56g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 9 Nov
 2025 10:10:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.010; Sun, 9 Nov 2025
 10:10:39 +0000
Message-ID: <25d8c857-fb9c-47b9-88dd-7450cf4490c3@siemens.com>
Date: Sun, 9 Nov 2025 11:10:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 1/3] scripts/deploy-cip-core.sh: Support
 deploying artifacts for RB tests
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251108111517.752691-2-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251108111517.752691-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 407ee826-34c6-4885-eed7-08de1f783ba2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bDdNOGxBWjFac0xrUktTaVkzejJ0MkRqbkQxSnptbEVYNzdHT2ZGVVVMRmJi?=
 =?utf-8?B?RVk2YXlyU3hraFhOVHFHUkJ2dlVkV1Qzcjd2a2lldkNhZ3hKbituZVArUW1W?=
 =?utf-8?B?UGlFdDZMQStpa0lFSUc5aGMvakk1UVJJTnVOc3JTNXd2NUVtejRKaEJLWmpx?=
 =?utf-8?B?L1dITUZKaVkwUm93b0tkUG5MS1ptMHNtaEtwV1U2Mnl4Ti9zNWNiNlBHVHNx?=
 =?utf-8?B?VnBDaW81NUFaV1EybWdIYkk2TktobGYyZ1NtZDBzN0VjQnhVeTU0YjFXbGZy?=
 =?utf-8?B?TkRRdDlSZjFUajhXeGJuTTR6NkRPbmRobW02MldqYzVYU25zZDBPYmdxeXBP?=
 =?utf-8?B?YmF2cjJkdlFUdm5POEJGZlQweUJ3STg1WU40RkR5L2IwNlA0ajREYUJxMnlJ?=
 =?utf-8?B?UDFlblNjajFDVUxjNUIzRnVMMWNiUTBZWFVyTnVUeWFYRmp4emwzSU5mOW8r?=
 =?utf-8?B?dVprMEpCcHpjYWdKQkZuRVN5RzNzYXNVQy9zWkorV2s0WjFUblFNQ3Fvcmc2?=
 =?utf-8?B?UnBHbzlDTkdxVWF0Q0txUUh1YmIzWmFKWUwzMkVjOWVWckY1MWRWOWhJdk43?=
 =?utf-8?B?WWdjUDBLK1c3RTRWMFhNK3dBMFBGbGlVQzBkTGRRTnI2OCszSlFrVDZVS3dJ?=
 =?utf-8?B?VWRwbHc0VjFHaU1RamV1VjhNSmlnL1B1VnNIaUxPbTdkS1NDZ1R3YVA4YmhF?=
 =?utf-8?B?akFLdXgzSnJxakNqb2NmVUJLamJFUjkrcjlFTFNHSnUwL0JheC9xOEJCYW4x?=
 =?utf-8?B?ektZSW1YbmI2YitVMWxVMlQxdG0xbmVkNzA2VHpWK0NRMVVXdnJnWENCa3Mv?=
 =?utf-8?B?YkRkcEUxT0lqb2xuckVsandoTk05NE9BdnEyTWRqdVA1MDFaeUpYS3RuTU8r?=
 =?utf-8?B?NWdxVzhNTU9pM1d3WUE4b0YrbkNBQlJBTjJKbS8zclFLc0tJNFhLQnFwWXBj?=
 =?utf-8?B?OHlXdVJSVXFKQzhHTlk5d2VVVEZKRE9FeFgwRmtGdWQ5Z21yZ0xRcFhhM2Ry?=
 =?utf-8?B?ZE5JOEluOTk0c0s0VWwxWlUyRFlrZml0VHNtbGRzcTlGOTRkTXN2UmRHcjhq?=
 =?utf-8?B?T1FERnhidHFIbW9zZ0hIUlF5QkozZTFBZHRLMi9rOUZCeW44L0tGeXpiWEU3?=
 =?utf-8?B?eExnUmVvRldWNjc0RDVqY1ZTVS9xODhUVHRnYjFFYUhvMC9iaXg5LzhMMmZI?=
 =?utf-8?B?RHZnajlYMEVFb3FyNTVpZ3ovRVhkRVE3WGRjTHBRcFk4WFlXclEwL3B3YVFP?=
 =?utf-8?B?VFJUOStoRkowVHhabXJvNUNCenVYbkJnYVgybGt1d2tiaUw1RVFWV1EzY3dt?=
 =?utf-8?B?YjlubVY2dWhJNGFIZlpRMlVRVjhRN2puZFZ0TURIYVd4dmQ0RmVtL3hRRFdr?=
 =?utf-8?B?cFM3UGUwOXgxM1F5VHM4YVRHMnExaEtmNVdGdFYwWkRBNlZWSWQ1ZndoUXBW?=
 =?utf-8?B?ZXg4RVNVWkpZeno5ZEp1RngxdTFYTStFL0JOQXVIVGdZakI0ckFLTHhDMEZV?=
 =?utf-8?B?aTBETFJBYmR3VktUUjNGY3AzdTNad0Nra0lWbVNMdW8wanFEM2hrelhkQmxY?=
 =?utf-8?B?aUx1UDVjZ0VhOHhqUmJEN2NOZS9uSmhiSC9Mam5tQ3dtTTA5ZnJxTm9ReEFB?=
 =?utf-8?B?cGlpOUtpd05yM2hZZ3pEcDhTK3JLSXlLSm1mUmE3UzdIS0t0UlY1REZiR1Rr?=
 =?utf-8?B?dU9qRmpKcUw2K3NwQWNxSW44STE2bTJRTWpnTUNqb3NtVk5NMFVUSkFSSXJG?=
 =?utf-8?B?QkN5dEtIUTNlVFdqSU91cXNmdmNsMzJ3M1hRak5tNzAwMXp6c0NLT2NqOHZO?=
 =?utf-8?B?a05uTWg4NXhBWlZSOXVlV3p2aUlvSUlIU1RIUjVjWXU5YStEdS9tbWMxeWp4?=
 =?utf-8?B?U2JCMllNUFdxd2xJR2ZFNFNGRFVyZWF2QzMzZmVBcUtmS0haVlc2eFVMTG1C?=
 =?utf-8?Q?Yp+J78YHdipsVO4U/TktA4kraGa52Ee3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0VYZ0FMWUxRRTY1QXp2TEM1aURyQjZYS0tFVDFvYnR6OWhCNFY2MUZrMGJY?=
 =?utf-8?B?Vmlod2ZnYlh1Mll2S1Jwc0RHLzVKWWw4WE1LN3BINjJ5Mm8zVGR2SlV0YXh0?=
 =?utf-8?B?aFNsS0U4Z1JrbEdlV1R5OEpPaEdtSzFmaXRWeXZYMFh4emhKSVZYL3RFdnNw?=
 =?utf-8?B?akZoQStkZzFpQ0lteU9GakJ0QzRmVGRJcTlpbkNmR3V0dFpRbnBqU3hQMnpv?=
 =?utf-8?B?MXdHN1llQ1NMZzR5U2NWL2tRU29weklwanVqZXNFU3EveU9Nd2w2V2lvMUk5?=
 =?utf-8?B?YndxZi82L016RXk5YnA5aklrNktpT1ZoaXd4aGp0aGJseWs5TjNHd0syVmlr?=
 =?utf-8?B?Z09lcUxna1dTdjZTNFZhd05FU2pnaFh6bUhLSVI2RjFub2JZdk9kWTdXTHJK?=
 =?utf-8?B?M1IvN203VE9RVUZDQnBHcXN1YnlDcEhZajQzRFlGUHZTem9qRUtDZ2Y3bUNE?=
 =?utf-8?B?Z0xvQ3NIbWpHdlI5cS9qSDJIUWtQemEzTXRYZk1IQXZudmc3SWd6K3lZckVn?=
 =?utf-8?B?eDhXNWg4akYyaWhwN2llRy9OZ3Rwc1pLTXJ5aDc3VUtlS0ZGK1QvQkV2bmIz?=
 =?utf-8?B?aFpzZmt5QmZ5MkFMZzBhWDhmdzdmVC83ZU9ENjRTeDJLRG5xeW9kU1ZPV1R2?=
 =?utf-8?B?NmM1bGNFbndneGRrVE1EZm9VZ2NGV0VJZnFadldWWWdtWFZXdGpDVkZYTzJn?=
 =?utf-8?B?M2RWNWZObnY5ck1DYk9NZVU0MkcxTUlDWUZQVkF4SlZ5WWZCc2hyWkVQWWJq?=
 =?utf-8?B?NHBDdlQzbDJRNHg3RERMazRFMVlDbmJuL0JoVUN2cUNsamI2VHVYMTBqTlBx?=
 =?utf-8?B?TnpiMUdGSlRlcXVYUUpzZjNoSDJjVTZNSVVsOHRpTG9SMUxQV2ZNeUgwUlNX?=
 =?utf-8?B?TmJXVzJsYXdack5NL0M5SHhtU3NjN1FMWFF1dGQ2dE4wNk1aLzRpMjZVUVF4?=
 =?utf-8?B?d3I2MTFZRmNOT3F1QnBjNU5YYWxNK2REWHFaaFQ0NG5HODhqUlNlRlZVb1hC?=
 =?utf-8?B?NzFkK01TczltN3V1bmRLanJnd0RuY3AxcUNhdnFPZ00yVkRrY1Y3dGlMaXIx?=
 =?utf-8?B?TXNNZnhiNnRaS1FqbHFIWXRPcGgrNGF5S1kvRVVUNGVTVSs1UmNsN25FcVh4?=
 =?utf-8?B?YkRsUXhOYXk4bXFtUUZqeFJEYU1NYXNyblVOQzJua3dqM0dha0k5R3RsTkJ0?=
 =?utf-8?B?bE94Uk0zM040dHdzK1lSVmw1NlRBejBsQ0ZUYnExelBaQndWRmxCRHBUVHdp?=
 =?utf-8?B?YS83ZWFQbk5tbnJzQTVRcjNiZzR3em5BSDJzdWF2MjJDT2pBLzVTbVAwUHZo?=
 =?utf-8?B?RWhSdkVoOWJTQjVrSUNZMWV0d0lZbTR1QUxXRDhGQ3A0ajAyZi9Fa2xZN0hr?=
 =?utf-8?B?TkJuOFJQUGVydnV2cVY2ZzErZ2lyYjdhMVpZRlM1ZUdyVnZUOVJUaWpQWmdD?=
 =?utf-8?B?clFaR3VVMmszZ1I3VTZZUVhTeFIxcWNaQzBlMGxOcjNoYkV6UEVaeFZUZnlS?=
 =?utf-8?B?ZVZDdzhPZldKbEphdG1IZDVMOFFlSkE2UlFJRFpZV0tDVzBXUmNPMWdEODAv?=
 =?utf-8?B?Mk4yT0kyTDRWamYvUDdWNjBFMlQ4dlEvRzlmVm5sek5rek5SUm4ycnh5TnBN?=
 =?utf-8?B?V3RORng4UFR3cTcvRGg2TXJBdU0zSGVCZkw4R25EVWdBMXRPN291YnhNcjR4?=
 =?utf-8?B?SkNDWEdiRWJnNzJ4bDd4RWtwb3ZYQXdFMG9CeVpmSGRrbnVWTkJiVTUzb05k?=
 =?utf-8?B?RDBxSHhVRWUwMyt4TTJyUm9XZUtKWVlGQnBQaTFFYXNqNjdsMVptL2dQTm9q?=
 =?utf-8?B?U20wUFVVZDZKcXRsYTBuamxzaEhZbTNyUEFBYXNQU1FqQjFLcm92S2w1YSth?=
 =?utf-8?B?REFDditqeU05NmF2MDAyMEc5RW45TE5lRy8wYzNHWmFZVmxuUWd5V08rMlNL?=
 =?utf-8?B?MkllQVNkcTJDd29OSE1rSE1CSzBjcWw1OEJNbDBrR2VLVFU5cXo3VENhNzNF?=
 =?utf-8?B?SjM0Z0RzOFpsMm9lNGZyYUtXaFhPN0ZUd1laZGxzKyszanVoL1pEcFg4MENz?=
 =?utf-8?B?YUREbXlocXUwV1RibGxKd2thYThJcXFSSnJFNXZ0aXpFOURmUlQvK1N2THpI?=
 =?utf-8?Q?838VAd89gqmzyC7bgi+QYK1gy?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407ee826-34c6-4885-eed7-08de1f783ba2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 10:10:39.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFUutrq8EH/qFZKIXP9iPZRIuTNKWLEp1SYa4/5ws1oqqInof8iBhwJQUKS4Bw7KqguyWEyLRGQ69dCsgutM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7381
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Nov 2025 10:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20483

On 08.11.25 12:15, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> RB tests require two sets of build artifacts to test for reproducibility.
> Let's support uploading two of artifacts to S3 when RB test is enabled and
> also support uploading individual wic partitions which are useful for the
> RB tests.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  scripts/deploy-cip-core.sh | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index 5647381..aeded7e 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -16,7 +16,12 @@ EXTENSION=$3
>  NO_KERNEL=$4
>  DTB=$5
>  REF=$6
> -DEPLOY=$7
> +
> +# RB specific variables

Please write out RB in the comment.

> +RB_TEST=$7
> +RB_BUILD_NUM=$8
> +
> +DEPLOY=$9

Unhandy argument ordering: You now have to provide all 9 args, even if
doing an SWU upload. Make RB_BUILD_NUM optional and keep DEPLOY at
position 7. RB_TEST is equivalent to DEPLOY = wic-partitions, isn't it?
Then we can stay with 8 args max.

>  
>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>  if [ "${EXTENSION}" != "none" ]; then
> @@ -30,6 +35,10 @@ fi
>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>  
> +if [ "${RB_TEST}" = "enable" ]; then
> +	S3_TARGET="${S3_TARGET}rb/${RB_BUILD_NUM}/"
> +fi
> +
>  if [ "${NO_KERNEL}" = "enable" ]; then
>  	__BASE_PATH=${BASE_PATH}
>  	BASE_PATH="${BASE_PATH}-nokernel"
> @@ -51,6 +60,12 @@ if [ -f "${BASE_PATH}.wic" ]; then
>  	echo "Uploading artifacts..."
>  	if [ "$DEPLOY" = "swu" ]; then
>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
> +	elif [ "$DEPLOY" = "wic-partitions" ]; then
> +		# deploy individual wic partitions, helpful for RB tests
> +		cd build/tmp/deploy/images/$TARGET
> +		tar --ignore-failed-read -cJf "${BASE_FILENAME}-wic-partitions.tar.xz" ${BASE_FILENAME}.wic.p*
> +		aws s3 cp --no-progress --acl public-read "${BASE_FILENAME}-wic-partitions.tar.xz" "${S3_TARGET}"
> +		cd -
>  	else
>  		echo "Compressing $BASE_FILENAME.wic..."
>  		xz -9 -k -T0 "${BASE_PATH}.wic"
> @@ -100,4 +115,6 @@ DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}.dpkg_status
>  if ! echo "$CI_JOB_NAME" | grep -q "$1"; then
>  	DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}-$1.dpkg_status
>  fi
> -aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
> +if [ "${RB_TEST}" = "disable" ]; then

DEPLOY = swu

> +	aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
> +fi

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

