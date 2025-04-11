Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D87FC36010
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 13:42:01 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.12])
 by mx.groups.io with SMTP id smtpd.web10.26286.1744378911101648790
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Apr 2025 06:41:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bMa7ZHoV;
 spf=pass (domain: siemens.com, ip: 52.101.72.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chgyBTvfxfv/FH9pv/7HsECoz7YMYOq2WB1Cg7+V0CD81+Zg+VYqcs4X8KQ9Pq09ntplILIA7XdSmlcoBG/UOkT4sgohIXNbYJ2EcCJV4Wg9jMpDMv+e0EMDiLRvtqTr4Qy+Qp3K5eumx4ct2eGzyvvkraFM2ts8qWGnZD1p1xPpCen2NsHHVX+1l8VRNxRYBNUNNmUtO4u8HNBTYwQTBH+KVfMDviF+beA4acLW6KdUsuVTRRArEKYsklMjbCWEW/VQaGdWYQX+IhTgbuz3H3F6VUeMs10SB4lN22CkLs2EFai2ICCxRLKheCZDGGEnSoNrsJF2Fg1JGjiBwJmrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB+rufSZQGwyvakJQSCsrzb+nQ9ttw2raJA4QcEZPNE=;
 b=I8zClOemmubNj4f4hFW4GMtVBDHo4Qb2pRi85gfeU8DSkfFM3vW6hrUfJ4srHBce3afrCWNUhAg3yKCjXutRDplnzNszfFeltWQ7OHd8HCDaayJZP+F55sS2xcqVcxbKOQlnT9m1KGexNJmaqBFyWamVXu08pDFcukKBsWbixxfErUniBEPObna79Eosrk6flt4iStam+b6mG4i1FcO/6XyLMiCMf3cqN5dRZaXebJzGwdhDUrZbHSUE8JPFA7tt1E6GUIxmVv3EFGSSDjibrItQ96CC2WXYV5AbGCRRVxzJylqbYPRa4r+0KG+vmyGSUuir/W0q2FBc9tFnJOreBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB+rufSZQGwyvakJQSCsrzb+nQ9ttw2raJA4QcEZPNE=;
 b=bMa7ZHoVom8NN5p3MDMpShffgEAvexLTDMtQ9ufxPNCjlBDiAYEotbNLxbBUINsske6bJ9OZDvtbQsKH2SpaWOGE+NHAt8XNzYiRGkas1yFYTg7rlysCd+ZqqMxYumVnizTlkG38+aqaLwe02SO2/HxlQyqNGtSyNpCLhdyO2Ph3DKw35vwPw4+JgaTN7OoxKE0I3rWKtwEv19oBdW7PGYKgKOAY3MahJqg5lvj6vjzfw6RN8suXt6lavT5q9Jk83BLbOvYj8Dm0T6u1yiYhJAGCYNA9rCNXmTz8P6jseUbFIaIrcNg7vAhbSHBaBQMKfOejIALn9orsEUD4HApIqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8337.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 13:41:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 13:41:48 +0000
Message-ID: <53b4ebd9-2056-406c-8fc9-5c3020527e2f@siemens.com>
Date: Fri, 11 Apr 2025 15:41:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] scripts/submit_lava.sh: Set test shell timeout to
 60 mins in case of M-COM
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250411103028.2081593-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250411103028.2081593-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb8642e-ab05-4079-422d-08dd78fe9b39
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cnQ0VExzUW5PRTlWb3dUT1laZC9mbUczbHd6cWFPQjdMbzNRdXNPWU5DV3Fq?=
 =?utf-8?B?ZEVuYXp4TStudkJ5Z3YrcHp0UWJpUmozTnB5RzB0dk5sb2xtMS9HYUNRV1Vv?=
 =?utf-8?B?R1JUZnVKbExYTHVQSXRrY2tJN1h0TWRROENCTVUzTVQ4QzBjcW5zbWQxUkpx?=
 =?utf-8?B?RXFrTFJsRTZqbThIcXU4eEtjZnJIOUdDVmpWa3ZMRFlFTnh4VXNidGVGZmpQ?=
 =?utf-8?B?dzdOTHpqS1NXVVBvTFVtSmZVeHRERVkwNURGTm5nUWJpdXloNDFBMThRU2Vs?=
 =?utf-8?B?SGFrcVpjcWcxNkxTRUU5SVZENW9JNndUcDU1T3dDT2NDQWVidmZqZlRjOUhv?=
 =?utf-8?B?eC9GREY3RzNReDlZTWgrSUFzUUwyR3lkM0hrM1QrdzdRM2ZrbFpUZ0dVekk3?=
 =?utf-8?B?S1NxcGlDWHVXMHhPckdacGtqSlpnbFljbWFKNDNUZFplSXZoVDJLSTJDZ1dB?=
 =?utf-8?B?RElRSDVZYlgrSW9YUjhnL1MwNGxGWWFzQ1hlOFkxR2xBUlFFNm5hOFdhR0VR?=
 =?utf-8?B?amRKQ2JJL2VPZmhHejlQRWdGZGlaN0Z2bmhBOEVKV29Eb3JzTnQ4bnlwaTRF?=
 =?utf-8?B?QlZoY1lWUThuMTRhSjBWVHVlRk1WVDk3MEVhZVpwUmFuT3BRZTdadkp6Vjh3?=
 =?utf-8?B?RW1ON2tXMlNOWHRXeU5hUFFKSjU5bHhZR1d2dEVwaEpORGhocXB1OUNHT3Q0?=
 =?utf-8?B?WFpVa09zMVd5a3ZRaUJJUTE1LzJxbGRwVUgwUW9IVjVZdVZWUjQyK2NZSHd0?=
 =?utf-8?B?Q09HTjdocm0xaFpGVC9oNlpZZHEvTjc5d1F1T09GejM1NytLaVRPUXJ6bDhY?=
 =?utf-8?B?WDhzdlprRU9nR1lmNGp6QTd3U3dlUnhhaHk5UndrUVdGTEIrM1ZwRkFPemNN?=
 =?utf-8?B?d1R6MXRSYjlYNnkzSklSamNUeTJ1WlBoTWJLMkNJVkU1cnVVWjRBa2R0bHJo?=
 =?utf-8?B?aFB3TWlGTEtIMTl0VE9hMUlHbEd1M0h2WVZGMzF6NlQ1MGpvb2ppbXo0Vzhl?=
 =?utf-8?B?STZrQzRDTFpTYWdiblJmSC9adnVZS2hldUVET0MvcHhlOHlLM29kemFtL2Ro?=
 =?utf-8?B?UFFuMVhKZUVoMUtSUWFycWFWOVJiV25CQWo2U2RGTHJiUkZFbzA2Y3d6NFkz?=
 =?utf-8?B?bjYvNjdFZTIwTUhERTV2Mldlall3R3BabFZDZW1KK0UwMzVSQ3JjQlczN09a?=
 =?utf-8?B?UkV1L1Ivd1V5blhVRnpSamg3ZHFUNDU4bGlQc0hRUUJrSHRZVWVTc05OUTcz?=
 =?utf-8?B?ek1SRU1ybTVQOEJld0JNZ0VaS3c2bHB6OXpiaUY1QWl3Vm1uc0pQbU5tRStV?=
 =?utf-8?B?V1E4YVh4VmJGN1BNUmFKa0NrQXE3WkpjdFRHd1QzK0p2VXhzN2xYVFJ3TTZB?=
 =?utf-8?B?aWdlOThQcG5PRjZPVFltQ2lRUk9IMWRmS04yNzlrVndUbFhkaTBGQ21NaVlO?=
 =?utf-8?B?dDVNcGNmYUwyeTVGZ1dEUTB5WG5zOEJWUEZnMGk5OGEyUU1JN0UrMk5IQmdp?=
 =?utf-8?B?SWF3QkxjU0pCK2VSSWQ1L2VBeVV3OUo5dmM2aFpjek9FVWE0cy9ESHJXUzNX?=
 =?utf-8?B?eU9SQWk0aklmdDZ4Vi9sSlNoR2xXZkE5R2ZsN2FKcTZMREt0NEphdmNsQ1h6?=
 =?utf-8?B?N3I3anlZclRUdGJ3ZEt0UDJzNHFvYURrTm5PS2dnZG52MHFtZHZLNXhHd1BG?=
 =?utf-8?B?OUJuWGlPUjZOOHNtcVZmOGFiRHBwQmlVUXlVb3l0RFo5R3RNL1VRVUQvS09X?=
 =?utf-8?B?NmhvdThDV29VNkVaQ1VHQUMvU0x5d1NPMllNQm5nLzM4cWdFQnE3ZWNsb29Y?=
 =?utf-8?Q?/PtEe2GdjEUwvaXQ4VNqTAaeRJRe1WZuGZkds=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUdZNmhpcTNaYjhadG1EdEZaaDg3R2RTS0wwbitkQ0lmQStnSEJRdC9wYW11?=
 =?utf-8?B?WjE1MDFzWWZKSUNabGhscVBsM2hrWDFNZ0dBU0U4MG9OUzdrZEN6M3BEczJR?=
 =?utf-8?B?dmRnTWR0NUZSRWVCRjYxZlo5SlVqSW1MQVFSWHNTRHFvSk10cjZrbTRKL2cy?=
 =?utf-8?B?Z3o1bWloMjdsQlcxaGhPaW1oTmFlbGZ3Zk1hdEl0eEFEVUFRaW5lMUtOR0lM?=
 =?utf-8?B?K3FPMDdvOHdQcXM2S3pZMVV0Y3doMzkyaVcweGUzUmRFQThySnNOZ0ZkNVdi?=
 =?utf-8?B?VGlEYkNGdkRDSTlBN1grR05GMDFLK2lzSU95V1ZGSGw1N0ZUc1VjcjZxN3pE?=
 =?utf-8?B?aDlYa1hMcklHa2VaVHdRUXZoWGUxVW1rT2t6eGJWS0UzaGpHZCtiLzZneSs2?=
 =?utf-8?B?WGJpTTVWMXNoeUhvUllTWklhZnZLY1ExdWdpbmdIS0hxd0lPWFd5REJnb3di?=
 =?utf-8?B?MDdIYTFqK1JOdW5uNXBRZWNxWFB3SC9FL3d3SVZNbGtXY0RBb2lGRGg1Rmcy?=
 =?utf-8?B?VkVuYm1SdTl5NTN2NVgxbkozUjJDc1NFSC8rT2NScGVkRUUzNzhTMDhXemFY?=
 =?utf-8?B?aXNYQUs4WDFqd1gycUNqN3hFOWs3V2h5a3RvbHkrZ0trdXUxQVVKcHF6elF0?=
 =?utf-8?B?ckFkd1dEb1g1d3pxU3djM1BFVUtJVWtiWWQvTm9kWXVuVWRGaHg4RzRFSzJU?=
 =?utf-8?B?RVhxWE1SNlZsdk1PbHJTM3g5ME5sc0lPTC9abVJkM0p0MlpibnpjbUhTcTBt?=
 =?utf-8?B?Si9XRmo1alFDOWRTWEdPNFk2OEc4ZjFQN1IxbFRRNEsrR2I3OXB6SytjUklS?=
 =?utf-8?B?bVV0Z0RBbitoVS9YOEpRQ1dXQmorTEY4R3JOY2xkTFgvNE5vVmthU0RjVlJP?=
 =?utf-8?B?NmpWZmNNckNVWC81WlNEY0tQeHJYYStLbkdXQWhoUFFOWjRiaTNRQWdla2li?=
 =?utf-8?B?QXFQWG9UdGJWOWtjc3ZQUSszRU5XVlZOWTFtdFNxQ1Z6cmFjY29BZDNpZGMy?=
 =?utf-8?B?dFhyZUVrT292dUlPc0luK01pc0Qwd01PbjhmT0tjdWVRVHFIYTJhQ2NhemVX?=
 =?utf-8?B?WDJ1eHpJbDVOYWxodWRXOStsaDAycldTWW9wcFFiU05md0pLZE9EV2plNXhi?=
 =?utf-8?B?dllWRkVKSTVlNjZTZ2VXUDlJZjVlTUN3UmxjKzErMEZBM05EbnRCZ20xV3k4?=
 =?utf-8?B?WXg2YXNEQjZqSllxalpuQWZhYkV1dGdrZ0RIS1dUTlNtK0p3a2hRV3BqMTNB?=
 =?utf-8?B?Y05UbWpXSXRqVlBwd1RTRi9EUTVwMU1uaS9YRllJMVpJVDJEVGNiWmFsQkFp?=
 =?utf-8?B?UHNzMWNNRElBbElQZmZkWS9Id2NnQ09NV21PMkhzWXZkT2RNL3dtNGphTjdk?=
 =?utf-8?B?ajR0R1Z1cEhBRzVPZ1ZjbWZsdndwMmFSa3h6cnlNbkJKcGVtcnY5bDlXWkph?=
 =?utf-8?B?OTlqQ1pnM1pQL2ZNeVhpcGNJcDJtbHI5MEdFVHl5Y1M0eHZZRmxhNXFSOTRS?=
 =?utf-8?B?cE0ra0hpWEtGY0tycXM0czlNTnJST1JIMG12ZzVtLzRkcTlZY3o1WjhGOEVS?=
 =?utf-8?B?bCtEMWs3VklzWEtQbzFWWVd4STBwR2lkWEs4Yk4yWjNkL2xlQ2hvQ2RYTG4z?=
 =?utf-8?B?azljUXVTVWhucGhWQ1dqU0RqTE1SMU1vVzhNYXJ3K3U0SklFa3JqMzM3dytK?=
 =?utf-8?B?ZEpSTXF4bHJJdnZKcDZRMnhVRHVJdjBBMjJtRkJyaWRSUHdSRDE0dlZySElT?=
 =?utf-8?B?MkwwcXU0SWQ4L1p0cGpkZ3FaVU90UUJBS2tpR2ZkSVNQMUVYeit3cndYNGgr?=
 =?utf-8?B?RzFCakl5NE5yRkxNMkdaSkZuTUg2L3JoeUtKTWJ1aXg5b001OEtuU0REckFv?=
 =?utf-8?B?UjBVNTFtOWFTTHllTU9mejd4NWR3R3VDbXRrOUgxMmt0RDRwL2pCb3RWcG5z?=
 =?utf-8?B?RlhZTFhWekZwemJHd3BITWYwdm00Uk5XN3F5NVM3Zmx4Znh2ZHBTcE1xVHE1?=
 =?utf-8?B?amhTY09nTjJ3TW50cVRCaElyOGg0YW5VTnVocmQycU5oZnhMaWx0M1dkc0RD?=
 =?utf-8?B?K2tTL3VGc00ySkUvc1pkRTk5ZWh0MlJqeEFkYWVNNkt3ZDBCUUYwUnlrcEIr?=
 =?utf-8?B?V0xOQ0lxWTkyL2locHFyeGVJcnJOci9qYW9wWnNVQWFvWVVpM1hSTlBSLzh1?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb8642e-ab05-4079-422d-08dd78fe9b39
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:41:48.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tozP1Mt4cM9OOi0N4NQ7Xu7gL+m8c8u4MRRDJZmTR9Jc3SLkBrDU3/YG1XXWmSumFdthyWgJxt6CnEHG207/Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8337
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Apr 2025 13:42:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18504

On 11.04.25 12:30, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Based on recent observations, 40 minutes seems to be insufficent to run all
> IEC test cases on M-COM x86. The test execution is quite slow when compared to
> QEMU. So the timeout has been increased to 60 minutes in case of M-COM x86.
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  scripts/submit_lava.sh           | 2 ++
>  tests/templates/IEC_template.yml | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index 0e437e0..61f08e3 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -55,6 +55,7 @@ add_firmware_artifacts () {
>  create_job_qemu () {
>  	if [ "$1" = "IEC" ]; then
>  		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
> +		sed -i "s@#iec-tests-timeout#@40@g" "${job_dir}"/*.yml
>  
>  	elif [ "$1" = "swupdate" ]; then
>  		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
> @@ -163,6 +164,7 @@ create_job_mcom () {
>  	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
>  	if [ "$1" = "IEC" ]; then
>  		grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
> +		sed -i "s@#iec-tests-timeout#@60@g" "${job_dir}"/*.yml
>  	elif [ "$1" = "secure-boot" ]; then
>  		grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_template.yml" >> "${job_dir}/${1}_${2}.yml"
>  	else
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index 72901bb..e50f041 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -60,7 +60,7 @@ actions:
>  # TEST_BLOCK
>  - test:
>       timeout:
> -       minutes: 40
> +       minutes: #iec-tests-timeout#
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git

Why not passing this value via the environment? This is what we do in
xenomai-images:

https://source.denx.de/Xenomai/xenomai-images/-/blob/857f36132697ff398a9de89b56c2a730f6e00ac4/scripts/run-lava-tests.sh#L41
https://source.denx.de/Xenomai/xenomai-images/-/blob/857f36132697ff398a9de89b56c2a730f6e00ac4/tests/jobs/xenomai-qemu-amd64.yml#L73

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

