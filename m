Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB07C5AC82
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 11:59:05 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28126.1786363141565786904
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 04:59:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=l2UCKkiG;
 spf=pass (domain: siemens.com, ip: 52.101.72.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9t9qb4FsVwTLiaUwIDLb1iX7hn5tixRrAA4ShjJohM8ZkdQyU9CBSMxhIj4uqKge/I0pVd7LLNS6/Nspc8Ta/NgRzxSERriPmceFpU+b7xOzGF/K5xE8DNO4THaZVe3LeMuFbi5Q6z+iw9m2jeHkUfrV4MPGKik0fG953IkM5D/JuzmmwESY20rLygo1MZ4cDAAlOLA7x3H12SxIPh21YDgHhcsHJgXLsk0IaL1ELnTuvXrBPe8DaF8R7KGy6BQqqXqTbQk8hlKQ+7nwtoF8zh0o4QJHjNZsZFLySchZxoVbqXHKNqFpOZn0W0ZmxKK4J3Mhqj/wP6bKE528nyYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9prODrSOPecPin/7su9kihT8DtjfUTnnM36S0Cim8Aw=;
 b=sDfuTAGp5uivoDEojtpZPp1ipoGQpY820xArgjNTiPe55KE8YdKY+KgMdi0vG28oJutZETTEyYO6talouqTroYsCrTtyRe6+iaaRCfn4He1neAOGTuCbe5Hi4NArc+J5hPigG9n4ivc7H4mvXiQ6qxiHhjI2LpQXkmLjoG47fhvMWPaET4YtRMiV+M2eq8OJ+gv2HtlMppolSImG7eubTwU3paRbOIfYzzZE4EXfJVTuJJkCkODvGta3RNQNXeL7ZRO2SKjgM9Xd8dicr/HgFtxpThWSU2YbQEtVNkulLdHKKFeGmfWV/kpG9wdw9QP1ybHYZqCHIJGYp9wafmubDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9prODrSOPecPin/7su9kihT8DtjfUTnnM36S0Cim8Aw=;
 b=l2UCKkiGOJNw5CRbuDFnyBhpt+LEcTPZlWjixIg0pNAfYkyWyAFsZm7ygxSCejVXwW0d5ag7dC9wEmr8Fbssl3mtJd59q0wHwkT1WZB1CyKRJz1ooByFAwHKjSaguR6kwZbaIhQS5sdMdVwCfB2OznP4god9fxZ6ms8r7tJgHv7iM8wUtgLOAKnjVN7PS+AxdGsnCTGiodnBoe/9pQcJIrNvuGbif2ATM3HciBbxrPJvcRYweMcAyvAALzW0XopWYnBYybXXlqIyVppScI2OHDIlMmrta+pdQDjKSIHgC3Cgbix25bGwKQwzkSvMvsnK9IPzaqtJGeL6i7gVoIoUKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:58:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 11:58:56 +0000
Message-ID: <5d1fea4f-8106-4a76-800c-de1e51ddb558@siemens.com>
Date: Mon, 10 Aug 2026 13:58:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Fixing comment on
 prereqs.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20260807143855.324433-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260807143855.324433-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b306863-22c8-43c0-55a3-08def6d6c17c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|55112099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	95n7D0IxDRSgpevs/KmDNQDVybFaYR1CUvmLLgyh63Nmwcw9m6EyVesYouF8x1l7suUVC1SqC6ZUqOH9phBdA52OZQhmYS7K0RNtmW0vLgW4UrjUAypZ7XvVcM+Ac7yDJN1mi4mg2Euj2unvIfu4rYv33VIjJ/QkSwOc1UibCNcZixd6n8OG60/oWMhx2V2J1PqunR5XLTMAop4zgCWwDkcgazq+1x///Tm720g5uh9yWA4I3nZDm59XtadTY/cYQt7hhjnq7oR3rVOtmzQOaJqxTSlQPMGTbeNcDKisov47UErUMkXdr/WXk2Cg38+gPEDCmXHV7stpjCq0rcoEzA0ntDEMHB0P+dqdd5ycR+S3BDiJ3MPr2ntl1hU2IJocFme1CdEwX9Dg8RaZWcqh93Gt/+CTsU815yRB1SB1eHWPD1SqXGXNAnVjeWetWNTnpRl7aUZDhOKbYhUJB6Vqnoxy6CZwABTrjBVvYljA2FCkGjgj1JO28eFIBYvbHoUJXl2g+LLdbBoTDobCnqXpaY76xzYnB+H4w3kWJ8bWdlXGaA2kR02pcPmYbPPG4OXiiKAirhBcCMVgosQmWQefY9PVK+eU8ih7RemKszs+8qy3wnBiGjqXfnMpgtv5cAa5vcpz4kl/wlxqlq603guXXeI1oim6sWoUFrX4pThpF0Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(55112099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bG1yMEU0dnlHcldNNmZ4dzg0YUZQR3JZVGxxUnhaWmEwZWtKbkJEUlZ5WGFB?=
 =?utf-8?B?anVHalN5QWVLUzZnYjVOclFTRWxpa3ZZMC8vdWd0SW5YNnJFRE5UanQ4c3ZC?=
 =?utf-8?B?VExKcjQwZjVxYjc3THRSNEZtaWlUZ1RvV2RVRnA2UVlmWlQxVmx6NkF0TGZN?=
 =?utf-8?B?YUtxV1YwVytJd3ZoSmdKcjBDeGVESkJtUXJzaWUyRmlFbTVkaksxbmZPcUF1?=
 =?utf-8?B?bkIwWUFkVG9mRzRnQU5udGdYYUZyM0NRdmNTTFhhMmhyQ2RGdng3MTBheUU4?=
 =?utf-8?B?d21yNTBFVkUxUjdJczhYeVhFUW5NSjBPMy9hUENrYzZKMG5iVEdPclRlUEtM?=
 =?utf-8?B?Ukluby8rN284V2ZlWWwzSExLTWFsUVBzWS9paTBKNkVqNGdpdkMrNk5qWity?=
 =?utf-8?B?TS9DSGVUVmJHN0wzOE1PU2JFYmluVm8xVFVZKzFHNVlkNXdjSHlhWnZzcVhr?=
 =?utf-8?B?TE8vRmRjQzZFdm9uNGNYOENUT2N6NnBlWU1rSHRtMVAxQjJDSlIyc29EK0pT?=
 =?utf-8?B?NXpzUW9aU3MwWHZQUTVlVjIvQ2NtYW5VNngwVTdaK2hhZWFLYVN3YklCb2RI?=
 =?utf-8?B?THphYVFheUxldFB5UUM0KzhmRnJubUpSTUwweGtENGNCdzJwWE02NkhyMnJ6?=
 =?utf-8?B?cWgvcDUvZ1JPWUlEOHRVbEJxZWpmWWIzVU91dWdGODhYWkRMcFJtMDhtK0c4?=
 =?utf-8?B?YzZUY0VxMExSQ2VuTXhwNGUvODlRMGxXVnF2RTVDeTVMSmJHZ1FZeU9uQXJM?=
 =?utf-8?B?bE83MExWSzU3UGhrZGgyNXZEb1FTYlZSUDVYUnFoL0U1OElXQ2w2eEhyWXlB?=
 =?utf-8?B?bXBQNDZ1N2RROFh6dkZEYVFwdTArYmdUeE03eUZ4OGZJOFJDbzF1VTRkR0I2?=
 =?utf-8?B?amdDZ3VqZ2NSQnQrZmNza2hXa2xSblpoNGRNOEMxRTJKc1RkRU1mZXdPSjdJ?=
 =?utf-8?B?bTJNNjRLT2F3aEF4K2h0NGJTMHhSWVFCNTlROFNwUVN1SG1vWGt5blQxcjIy?=
 =?utf-8?B?MWxKUmI0anFVT2Y3VVo1L0FzUW8rcUMxTVZMVFVXYzllOExnMVJsQlJrUEds?=
 =?utf-8?B?V2FFNC85U0owL0o1SkRaaEZBUk43TW9sVGd4YkdoRG9VTWdlY2ttK0RRSzBD?=
 =?utf-8?B?QlZUbFhKWE9lOHUrZVQ3NWRUS0c4RDAvYmpEcURxVWFjSGVzR25YK1VrMExi?=
 =?utf-8?B?bzh4WGdJaHBrT0xsbUVNNTlCUG1LN0gxeTFpbE0xak9pbkVEUmdYcm1pUHNY?=
 =?utf-8?B?dk1nbmVsTkxiRmNtMXpIRmZVOWVEUjIzb2VoWDZNOEhWMHJGRHliRy9CV0cv?=
 =?utf-8?B?SDRCOVlRa3NWYVhjdlR0VmFNMkJFRlNzMnk5OTYxQllZOTBHaTVKeUxoTE9u?=
 =?utf-8?B?MTN4MC9rdXlSZ2p1eFlxNHlYeWdrajV2ZjBBbmdHaEVyRXBRcXhGTGdwa3Bw?=
 =?utf-8?B?Q2FleUtpdHk5aDh4ZzZzU3QwK2Fadyt3djlocUQ3cGk5U0dNMmNuYVhxdmU3?=
 =?utf-8?B?TVh0U0hXbGpBWkQzeXpzUnJGdlR1b05QS1ZMSzlUdG1NVU1jWGFRZ1pUbGxT?=
 =?utf-8?B?aTNiR3dFSGx1elRVTVlkOEdFSDN1aThnQ2tKL2duWVhCdlNyTEZwWXIwQjhQ?=
 =?utf-8?B?THd3YTVDS1VZdFdHZ21OWnpwczNiTGh0OC9ZOWIzQ0NFK2xLTFplMWZkT1B5?=
 =?utf-8?B?MHdMR2pBZ0E2aDljdnlNcUx0ZytCdjdWYkt3RnRuOUM4OVozWkRlUjBGOU05?=
 =?utf-8?B?VEdBdUE0WG9uV2kzQ1BkanFoOVZYKzQ2cG0xc0dxT3dWTWQxN0RldTBDQXRv?=
 =?utf-8?B?YjBMbmk3TDk5Y0Y0VnFmcG1VNHVPMDRiTW5ZODVBQlROaDFXeGloZHhXalBx?=
 =?utf-8?B?eXUrSVlnbzRwb2oxUC8yOVNJRmZYMldxVXhra3JHY05qcFRjTzNJSkNBZUNT?=
 =?utf-8?B?dHBtTWl1MTduM0xnQWtNdGVqRWdUc29LSkh0WHRiNnprTEtTQitJbW90WXZU?=
 =?utf-8?B?NE8zU3dvTXZWZzZMQUFvSkRMa2VYN3dIRnNOUHlPcDRVSjhxOEdRb0hCR3hL?=
 =?utf-8?B?OHBEV280ZXJiaGl5bnVQOEdwbXFjcG5lQkdkOEpPc1o1Zjl3Vnc5ZXJYbHIy?=
 =?utf-8?B?R0d4MjQ5TUlDSHhSeVZSOVpDZk4wNE5qV2lmVURqb095K3lUanBsaFE2VGZJ?=
 =?utf-8?B?UTV4Z2V2eWc1cWlReUVQYi9NMWZTWU9aMVZhbVFWdUdXQ1ZmZXNSRWtDVEJ4?=
 =?utf-8?B?NThwMnRPb3FSTjcxdXBTckNZaXl4L1BBa1pjdVY5YVB0NjlUck9nZ21iNXZz?=
 =?utf-8?B?Z01iR2MyblBXVnA3Y3FKODBFdXV6NDh4b1ZEZmZtMHRXMEMvNDQvZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b306863-22c8-43c0-55a3-08def6d6c17c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:58:56.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar95FeOa8EpMbbGLrLd5RfpEYL+qYOtx8OFA3UXRKlJJZi7ABniq7tx2C5jZ0s0/z/LZ6Bustlyh4WiYn/MWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7725
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 11:59:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23883

On 07.08.26 16:38, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/local-top-complete           | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  mode change 100644 => 100755 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> old mode 100644
> new mode 100755
> index 1044f2a..963f82f
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -12,13 +12,13 @@
>  prereqs()
>  {
>  	# Make sure that this script is run last in local-top
> -	# If the abroofs or verity hooks are installed, this script
> -	# should still come after them.
> +	# but before abrootfs, verity and cryptroot
>  	local req
>  	for req in "${0%/*}"/*; do
>  		script="${req##*/}"
>  		if [ "$script" != "${0##*/}" ] &&
> -		   [ "$script" != "abrootfs" ] && [ "$script" != "verity" ] &&
> +		   [ "$script" != "abrootfs" ] &&
> +		   [ "$script" != "verity" ] &&
>  		   [ "$script" != "cryptroot" ]; then
>  			printf '%s\n' "$script"
>  		fi

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

