Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBDFD767F5
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:44:28 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15114.1766144668001794354
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 03:44:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qWoMrygj;
 spf=pass (domain: siemens.com, ip: 52.101.83.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b03kPQb08Lq6s0x564aeU1TymePcefLfA+zqqIeb251pPoVs3VhPqvrmMGHVjeqELdOZYEztBnFejpR8tfkLsahq0W8TAUAn/tbUImaf+AfZgDGPZ5RfWyD1khOZe9uOTAlTo0Fdko3NLwglakvNim9z7MugjCUPja40pbM6K5VxkPpn5G+zEzHl24fB++oGjNSUxX0dA0IYreQZEe+2KBeDB2Df1w2MrN9l4PFErqVvUvqi8g57GS2Si6QDKfZ2HyS0wLZxj3wpXdY0Z4oNhoob8HLEvteJBvodpB8V/8EzzrAMky4ZF5Hq3UKSjztrNU/KJu/fUiNtq7Z4YTk/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JW2qyjqFSebYErFxKYittCHqYH12gptIQDkHuFbfII=;
 b=GZkEMrXUcMWthk3gSqBqeASqvVyyvXZ1QyGCVtOyy0sZa5fC0rUfjEZEBOuLgQ+SCaxLA5JRoy/2A8c40YRgaObTKH/5Haq3ptL5HvGaahhmgNc8quCoHt1gAkeKbQHIIRvI2SwCBpFD5qqITtsFL6W/GcVgY6DsHkr4R48RdFUXe0MQoFseEQUo3ytscp/P4lYbfjr35+GsjF2VskRJkhPj0gR6nu1w8UpsTXvfXPDv9/iz742i/lr/3GMlCmVfbwTFrTNm4hMtjxlYmcSH7bdAGCczX0kZVpYLzgmEXRI6dVcparmumpRYwvCNN6P75XoxbqhbqmFTLTH4lMB1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JW2qyjqFSebYErFxKYittCHqYH12gptIQDkHuFbfII=;
 b=qWoMrygjGMt/crT7511lhtRYc6b+SAPBnJ7Yl6WrJDlpkkUe3PqBuxD7NUDk6J9W8oouzTW2kJwGlE9ikgk/YJ6QIybBmUqDg0m5IMjeaR5eipuhtWcH8JEAjbJorXtUyhMnsA2qO0kEMwAZAX6s6XxUOaJFqgLmdrM0FC3vVcnIG/ier/WNickV1RLMQG+JnqRY0lB2niiKDy2LlEss1QHXizeJ1ooVgkUHzKO0mAjDf6PEC6H1KvoEAv9oFJ9c7bHKtXTQiNPNJsEi56GLW6m86daf+C0mfc4JzhZSc1QFJIRVaoCycXKQQvQWdEl3LarzXHY8odITv/C3zaWrlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 11:44:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 11:44:23 +0000
Message-ID: <606597b8-7a06-4aaa-b8cc-2dbf5d6f615b@siemens.com>
Date: Fri, 19 Dec 2025 12:44:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] start-qemu.sh: Check FTPM_STMM instead
 of TPM2_DEVICE before setting RPMB options for arm64
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251219104403.191807-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251219104403.191807-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3935:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f30451-4666-405e-26ca-08de3ef3f478
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SmpDWVpMK0JnWHJjU0M3WFEyd2VmbmprNzB4YXNvR0p4ZURwdHpBQ0hOYkJ4?=
 =?utf-8?B?VFZqU1NIa0hsSEhzZ2JtcUV5dU1UTXRuNzVxNFI4MTVGeFZNQWhzOGNuQjFt?=
 =?utf-8?B?RnBqRW5BVHVsK0NSSDhUdmV5Y25mR0lqSUk4Q1ZYTTJPSFRXUm5EWjNRWlVV?=
 =?utf-8?B?NnEyc2JqaGJDK0V0c29WRXdEU3gyYlJQLzRHQVNlQUswSkt4OWFnK2gxM2tM?=
 =?utf-8?B?OFZ4SW8vZGNXYW9HV2IvcmFCaHJyc0d3bHJNMjdFc1llaEg3bXVUUzdUZkcx?=
 =?utf-8?B?dVhFVGZqc21VVEJHMjNUNVFFSG5uZmxwaGpaS2FtZHUyV1M2SzBYVXJLTDZ3?=
 =?utf-8?B?dTJDdzhXTTlia1JOamFZZ1pmSjgyRW1ISEpjN2ZuTjRiNTV6U1dwUlJpdnY1?=
 =?utf-8?B?YXBVWUhZSUd0NXFTclJHeDJ5d2haMzdjcjRDVVZoY2ZSWldDMW9sN25wZG0v?=
 =?utf-8?B?eWpqbER4Y1R0bmk4WE5LSlphTVBZV3FDMnpvem45elFScnU0QjVtbFUrZ3BN?=
 =?utf-8?B?cFJSems5YTg4TnJLd1o3TDI3ejJ4aTREazBXbkp0bEFxOGxTNUhkUEZ6VmlG?=
 =?utf-8?B?Q2FLSi9EOFA3SHBKakVHalNvUndlem15K3k4QUFtS29JWENUWUh5WDE2TVcz?=
 =?utf-8?B?RFRscXN2M2FzMkRRMEpvZTltYUlLVDhMUlNwS3Vabno5L3pQa3VzZzlBTVZk?=
 =?utf-8?B?ZEtlU01XSUYrNVZSRTVzOEh1M012WXZZbkcxSVZMVytVVHhlWlkycHVRYlFE?=
 =?utf-8?B?WkJaNFNndi9kZnVFTGlJY2hvZkNDUnZGM21TdmhMZmRXc2NockxyMjYzZ0dD?=
 =?utf-8?B?Zm5IWXo0emZUb2wrUFo1Rks1eDV5RjhBT2pSMHBBd3RJSlZYMnYrSld0SUZr?=
 =?utf-8?B?a1o0dVlCS2c3M2RvTUJoVDdNM0ZYVDhHMzhnWm1nRXFGbjRaQ1cyK2JQL1RI?=
 =?utf-8?B?VkJWUnhnUnp2azArTXMrRmJYVXZoUTI1bXFJY0oyWUpUeWdoQTBPZHdvcElT?=
 =?utf-8?B?SFR6UEpkaEovdWFYS1N0cnFOaE1INTlYQklaeUpzK25raEhlYzFzMzVLbUtj?=
 =?utf-8?B?QVY0MFBaVVJQNW9YRWtVSUJ4L0VLVm5UQThoNWVab1g4WG0veFN4QmlKVXdw?=
 =?utf-8?B?d2IvejdHQUFQK052cTVRMkF5bWNVQmlWT3didlRkWkRoOWRsanZpT2dpUXFu?=
 =?utf-8?B?eklGVncyUWIwVmQ2Rm1JeWx2eEZWYm1YNG1JUUVwUnJwZVZNRzVHZkhIQVlZ?=
 =?utf-8?B?anZTaW95eTZyL3NOdnFjZVp4emtUM0NrQTg1S1ZYaGErWFZlYjI0ZDFLZ2hQ?=
 =?utf-8?B?ZXVWeWpiMHVRRCs0WC9HNGY2Q3JSTktLRTVmQS9GUFVHZUlGRUVGZXpVbjZp?=
 =?utf-8?B?TFVQMHQvb0hGTmpaVm13akJRaHNlaWY5VXovMWE5YzVNTGZMSjVTMll3SE9N?=
 =?utf-8?B?aDdyMjZiWm5ETm1LbXZXdmRwRWl0eDdRQWhXTTZPSjZrZitqQlU0WUZjdVVo?=
 =?utf-8?B?cTZ2MklBVTlMOXliNnBWNDBLQ1lGaDMweSs0RHp1bU5IRU8yeDNJbWM4aUNx?=
 =?utf-8?B?d0dRSHNIRGZDclJEL3A4U2kvZWs2VFkrT2NXbWdrS29wMjZ5U3RIbFNtODFt?=
 =?utf-8?B?ZUkvU2VscXVUdjdZTzFOdldKbUdMTDVXQWhGandqMGJwVUE2ZWxuL3NyV0px?=
 =?utf-8?B?NGhuUTQ1WkZ0eVUrWnFoN1o0MWFuSnV3eGcrTW91RCttWjNnNVZOSHVQTnU2?=
 =?utf-8?B?L3M4bEpEc3NoRmNCcHdSSjJZZ2RuUDl4VUtMOWVVbWk1KzNDVHBTZi9PK21r?=
 =?utf-8?B?VmpvSml4MlIvWC9Hd3oxS3c4T2wvKzF6andpcmVWNlM1REFYV3ErY0RTSTlE?=
 =?utf-8?B?TGhOZjVEODNBY3FUM2ttd1FqL0ZBNmdHM1g4T3BpdFNjUVJCNXUvMjVKQjJm?=
 =?utf-8?Q?HHAJqCuwJukQi5XOOgxj2o890kYLYOUW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlMycmpvMGZFOFVGS2RoLzdJYlNpdkpoSitIQjNKRzhlMXkvbVk2ZE5UemYy?=
 =?utf-8?B?dEo0cTF4U0lDUzNNV2VNSVBOZUx4OUcvYk4rTzhOSVdIZEx6S1c1bnhVRHg3?=
 =?utf-8?B?TzdOWXpRY3ROc0NZSzM1OXNoVjUwSGc4T0NyYUhDQyszSXQ5SjI5YUdhSmpN?=
 =?utf-8?B?Z1lCN1pMcDJsa2VpKy93Sy8xNlI3K3JuL1czWDRwYlZQVHl2K0lXY1BjYmNF?=
 =?utf-8?B?YkR5ZFoxNDkySzNXVVRmZUNFUC9qMjV3ZGJZOVhKbGxOcm84dHpxTlQvbWw1?=
 =?utf-8?B?di91RWsvTVlGb29NTzVORDdlUHc0ZTF2MUo0aUpXV01sOExFWHhqVXMwQTJ4?=
 =?utf-8?B?Kzk5enVhbDVMdXM0d2FaNkFFOGpYd1YrVE9mNG1vNDk3S3krVjl3VEZzU2tz?=
 =?utf-8?B?L3ZxZnYxSElsdjVBTHZnUTVPQjZBUnluY1FFRTczZmhJaDRTMkw4cVEwZ1Fw?=
 =?utf-8?B?Q2w3Z2diYlJjTGp0Mk5wWjhpY1lXOUk4U0Rxd2JiNXMrWlFudTIyVTMwR1pj?=
 =?utf-8?B?R055dVE2TFRWSnNJMCtxSWhqOSthQ1pNb1VteTJwMzB5bytucURaeHBSdWdC?=
 =?utf-8?B?RERsellNaENpQjkrYkNjYXJvbUlIejdYbFF1UEsrS1k2b0o3MUhySWczZnNH?=
 =?utf-8?B?UXNNNk1jVmEzM0w5YjF0Y0MybVJtRFA0blo1UnZtM2dua1pxVEladG5MOWNx?=
 =?utf-8?B?ZVdPYnQ0azg4MEtTVXRDVGtHWENGNldvSFZEczdpbEQ0UkREMDdTMWdocjAv?=
 =?utf-8?B?ZW9pdHp2a2JuQzNybzI3a3hVelRHbVVRbUY4RFFQVENqeUZ6MktyZHd3UWZn?=
 =?utf-8?B?NnRZbER6bGZVd0F5VzFkYVlSS2x1d0FTWlpuVitaUEJmVWptOG5OVlkvWDdU?=
 =?utf-8?B?ck1Wd2Q1T1hHcDd2NTdtMm9aYVpXaG1JeDN4Uld2MEJWK2FrRk05TjQ3QnpC?=
 =?utf-8?B?UUpSWkd0ZnRxeVU3T2luMjdzSVdXcjlVM213NlFXbFo4Q3dPRXcvV1RmRTRQ?=
 =?utf-8?B?ZDNQeVNLV04zNTJmUlBqZDdjZElwL3BuOFRReU5vOGhocE5lNHBKcjB4ZXpQ?=
 =?utf-8?B?WDc1L3F3blFmbGt4YWExak16ZmlRUjRGb2EvbGhZODUzZmhQT0RDY0VhNnJ2?=
 =?utf-8?B?Q1NUNnRDK0FuR2Yyd0hxVzFJT3BtYkxZbDdnSzlWNDBMY3JyakxCSFF1QnIr?=
 =?utf-8?B?L2xDZHp0aDVRWFY4dDl4Y3V3Yzg2aDYzazhGYlJLaXAySFprK3pIelRiSHo3?=
 =?utf-8?B?TGFEUjNxdkphUnl5Y2Z1VlBRQ0duMm9NbEJLeExicUM4eGR3a1k3U0Z2K3RF?=
 =?utf-8?B?TjlKbVY1dVJHWUNFdklqOFJzUVNDUFZKb25ZV1NVY1BGcHIxZkU3cWpnSFUx?=
 =?utf-8?B?MWErWEtYaFY0dVFsR0dnK3QrcWpjcVY2N1BXOGpob09PZ0xvSHVUd0R2UDZD?=
 =?utf-8?B?RWlMWUNuS0J3TTE5NllCck8zYlN2TjhXYkVIczBUUHlnenlyS1RkNE9mQjRt?=
 =?utf-8?B?VUoxWm5tR1l5RG1NM0Vxbkl3aFhzbHhyMXZuK0syTjZmR01PeElmL3UwZ25I?=
 =?utf-8?B?dzdraVF2K0wrOHBBQmRjTjIxWGxnZytDNlRNRTJYZnN3UkFDbUFJeW5TVlgz?=
 =?utf-8?B?Sjg2NjJqT2tKK21VdzJKRXhYNXZvRDdjenB3TVFUREpaZ3M3RExhMnNPZEk3?=
 =?utf-8?B?KzkzbmMxRGZxdHVkUHdwdEhMZVk2TDBmbnFkRUFDZ29IelFlUGE2QmxzR3RW?=
 =?utf-8?B?T0VOSlVJN0plRW9LYTl6Z3d3S25wcmdiSzNhVElYK3F2TXRrWUJBdXFMSE5G?=
 =?utf-8?B?NGY1dnFValBqazhUdkhCR0FuUlVkU25OMzNWZ2lMakxYL2J6bGhoYjR2dHdr?=
 =?utf-8?B?bEpPbXlEdjdlR1c1dFl3aGQ5NitYY1R3d2JXcnkzV1RtQkJ2SklMTis5bE41?=
 =?utf-8?B?SDQyZkFWNi9GTlN1SWdiZ2Y4WDhPT21iZExaaCtmaTF1azNFWE1ScXQ3ZDBV?=
 =?utf-8?B?VUNRM090a1ZJZ0RqWWRSTjRIeUtnN1gxVGNUeGJ5OVlUamlkcFY1VlROaHNY?=
 =?utf-8?B?UkNNVE1ZZ09rcjhCeTRwa1UyRkY2ZlFXOG1UQnRWdG9rVWhUTWlQSnVpRzFS?=
 =?utf-8?B?YjM5b1F4dGdWMmNYb2ErZ0FZQ0xUZEdFdk42OTV3N1dtWmZHQ05sMjFjWjRU?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f30451-4666-405e-26ca-08de3ef3f478
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 11:44:23.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxb7r7tYJ0jcXdIkFAhBQDys8MXNtU1LEg3bweBiGteey9rDUXYDsuGXJCtI+cP9WqyYkGpKAzuq4i5lEM0wXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 11:44:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21173

On 19.12.25 11:44, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Current script checks for the absence of TPM2_DEVICE to set RPMB options
> for QEMU arm64. TPM2_DEVICE may not be set for a SWUPDATE only boot as well and
> the script looks for the RPMB image even if FTPM_STMM is not set.
> 
> Instead, let's check if FTPM_STMM is set.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  start-qemu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 0eb306a..7ccbefe 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -124,7 +124,7 @@ case "${arch}" in
>  			-device virtio-serial-device \
>  			-device virtconsole,chardev=con -chardev vc,id=con \
>  			-device virtio-net-device,netdev=net"
> -		if [ -z "${TPM2_DEVICE}" ]; then
> +		if grep -s -q "FTPM_STMM: true" .config.yaml; then
>  			QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
>  				-machine virt,secure=on \
>  				-device sdhci-pci -device emmc,drive=disk,rpmb-partition-size=2097152 \

Good catch, right in time! That was hurting us when encryption was off.

Applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

