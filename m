Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA67C54F30
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 14:00:39 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.73])
 by mx.groups.io with SMTP id smtpd.web11.52646.1748354431666695861
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 May 2025 07:00:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y3idy8H2;
 spf=pass (domain: siemens.com, ip: 40.107.20.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTo6r/GeqAHM21bIBd50QT2T7aXWL6fUzDGTyUP6TBYWup4S3CnMDVFLqnWO3VVHGgpNCv1zFwoROgrpXKUy1ZMuS3+nyMhwYftY2Q4McZLtPfQ0aN42BDvm6hj3ttNj3fsK+rZLNaATdodLhM3t+QBBIXbkvzYuxizpVKsWuOZmLxbmB27Vu7Z0tatVxrA3jhrXdkUoptssj8k7NV0ofTqYokpeir4jHo1wfJTslZYipTV7BK3kroa3kkgW+Lw/jYLsXz5DccdMTWh4Og8mM3TAjA2A8y0SiT4wM50CXEKOL8guRcr8JX3VaXZsKZsrzYT5F95CMhM2MAK8Hy1XIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHyeQfmxAFhJT8A8gUxFu6e8Rc0TFQehquzSLwl+s+8=;
 b=b2CZoKA3nfVnwXt4zVwE8GRYWghE3RNAEU7S5t4WpmdP5Sb+lI9klGRv5xjSbM3RPgGAHj7pixVtkJawc+4PSt0Fp77g4pXePLoSP85EY+pYNKbTpL/VvHe8qVe8K8RW0sX3vxxm/9xy5KXDQ96Gny4/9tfdlC8ZgaAgmoZ07vQCmK+Oxyztt71GhrfI7gB6WyQTBd5L1j3MisFyQ0sYkJNCSO5wyKx3Pr73TEVl/BOsBUKCX4ohcgrLPT3P9uT1YMvgGL7e7Yns59Q6S0ccAYfhqIKeUs5+1UnfbjgD6Pz34FspGWJvFC7XjDQr3THLpFRgD0Brn+lPHqxepujphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHyeQfmxAFhJT8A8gUxFu6e8Rc0TFQehquzSLwl+s+8=;
 b=y3idy8H2BWO2eEjy3etmWfP9NkueOiVrwPUIjeXQYd/A3tBGTwFwXcDzgcvxsShOL7+Q4ZVwSD2wFZXdxgvU3tzYJx5eG4GiC0MJwzExAhpUFcC3h6vc2uhyTgmbk5ZcbL2QQTnGdrMMNkrAU9WfpB756NSXaY48BVpEoGturfV1OteML1maTetcZDHH1gSDrS2AzokvP0Rtt3JuaFL5kh/xKPO+sZ+Q/0/64H4ULk8iMtl/Y/KEdPiH6+zBhTo6cN5DllAsuqGSt0hXGkkR+euARsc0Mo68YYKF4DmPFFpc8mgwUa3r9q0yqcjezXPs004g+iVMKtBC6S8bu2Tvww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8964.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 14:00:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 14:00:28 +0000
Message-ID: <7626a1eb-91c1-4cae-b589-9b4cf1b1a2e8@siemens.com>
Date: Tue, 27 May 2025 16:00:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] IEC_template.yml: Update IEC layer tests
 revision
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250527070413.2285223-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250527070413.2285223-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d39219-d44d-4788-5238-08dd9d26d63e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TW93eXhVcStyVjN4bTVuc2t0YmFCRUUxZWxUdlg3cWczWmJPZ05talhhN3NM?=
 =?utf-8?B?b0VzaXRNN2tud2h4MHJhenk3ZmJEa0NIV0o5RG0yUjBXeTdjdDRKdmNhdGdH?=
 =?utf-8?B?Q2dKMnRkVjY1QjNkR29sUWY5SVV6dnZEQStYcGNyR3BiYlM4WWJiRkMxSG5T?=
 =?utf-8?B?THV6TkxjNmtGSXc1OHBBTmRjcXhFTzI3Nmg0RGFTYzhGNC9KazVLRlZBSU9h?=
 =?utf-8?B?cXRTVDc5RnhYMnJKTUVLRC83MHBuM240MjVQbTZLS3U3cXF3emVoOGRMbTVF?=
 =?utf-8?B?eEQ2RDY5cnpwKy93MklWbVdLQkxQbElZM1hJbUhIY2d6ZDN3WlNOdUt1SEdu?=
 =?utf-8?B?NGVpOUNRbG03MzVKcHhkWWpnRUYwVE94OVUySmt1Tm9SMEd4azgzR1QvOTF1?=
 =?utf-8?B?WW9yY2E1U3pjTkt4a2Nnd0JWemw4NXd1cDdQZjhHS2t4My9Pa3Z2YlNMQ2tE?=
 =?utf-8?B?YTFlVWRhaEJGek9EV2Yrc2JVOVU4RVo5VlcxZXBvTHd4RjBFTUsycEhWUnJp?=
 =?utf-8?B?Tnp1cEh0Zytnc2hiWS9rRFEwcG9Ta3NNMGRsVUhlSVJJM2FGczZBaFBpbXcr?=
 =?utf-8?B?RW5XaFRhMHYwM1dmU1ZTTmpWbXExSTdMK0dKL3dhWXlCbmcrc2tiYm8vOHhx?=
 =?utf-8?B?dmZkRXQwcVhtdmliaDMrSFNXYUl0YnVrRnpwc0pJMUdCL2lNUE52c2ZySkRq?=
 =?utf-8?B?SEttMlJBeUlWQVdHMjlYTDVENEZTc1FSekJrbzdvSXRzN0tkdkNpOFppT3Fr?=
 =?utf-8?B?akcwbXJTb0hIdlJidkkvTTJ1SXQrT1E4cXA3dTl6UWIvTTg0MGxKVTNsM1JX?=
 =?utf-8?B?clI4d2NJaU5oZlU4N2JmbGdmTXRlYlBGTmF4RTNSdnF1aDlKNUZ4a1lob2Zx?=
 =?utf-8?B?SWx5TVJ4dXJkWVBHWkkwc0JZZVllUmtYTE5JYXFCd0lRRkRJanpScmRBUkFR?=
 =?utf-8?B?RjY2UzNjSkZab2UrUVBwYldQNm4wUHdkV1BnVmZLMThSWG1zMGg3RHNhR0JX?=
 =?utf-8?B?Yk0rUlNPb2xDNWxpZE9ybTVBbmc5UUFVNWZ3dnpITmxvL2tmZXNyTndmbGwy?=
 =?utf-8?B?YXgySHdWd0N2L0tTQWhMMEZGZTlkblM5S0RRVC9semYyOVI1eVI0VFhBTklO?=
 =?utf-8?B?Y1UyTGo0ME5OQTBJZ3I4SnZrYWs1ZE1IQzJlLzgxQTFvaHNBOUFIOGhYa0sv?=
 =?utf-8?B?SHIzMGNWZ1hkZzBMbWJqRkU4M1FaOUU4SmdwVExvTm1xKzF1eFF5SFllR0NX?=
 =?utf-8?B?Y0hucGR0RWxtaWhYWlhWNVF4MjFGb3NXMHR6aXZ6NVd2NmwzL09rRTh5NmxJ?=
 =?utf-8?B?UHdKSTJ1Lyt1MGpxYlJIdUxHYXZVckRiZFYyTmxBOFdsWWlnSVdmWXIxZGZM?=
 =?utf-8?B?cHg2bnBWK0hMcWV3OXRnRHBucjgxWlZZVjdRK0JOcHoyRUt3WWVzL0s5MDhn?=
 =?utf-8?B?MXd4cmVMMEJrNnRIcW10UU45ZGtCQ2lPZkpOVlVFOENtb2dUdzQ0RlJCY0U4?=
 =?utf-8?B?M3FoN2RnZWVqYzFrZElIY2g4eDZ2U1RhVHgzK0o1RUhJM3kvbHRFRW5xbjkv?=
 =?utf-8?B?cm1jd0FhVFJhdjVTcVRlaTN6cUg5NHFkOFdNczZqOUM3bUJ6cTgyb3drSHpV?=
 =?utf-8?B?T1Vqa3laVy83aUZIMDUvWkNrUTBUQmJPREt3RTljTUJCOWtocFpYL2lxcTRx?=
 =?utf-8?B?K2lGSFNQYk04c3RDUm5UWHpIbG1lR3RCTC9UWitFU09kOTlKbkYvSVpaRURH?=
 =?utf-8?B?WFpYUDU1Nk9iTGFvN2FYMjRJZFg1TmNsQ05Mdmt1RjU4SEFPSDNaRTIvdDZG?=
 =?utf-8?Q?9Qhu0xtzpbRBaBvsRw1hS3fD40psulRKoVilE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SFczUHd0Nml6cmdiZE5UY0gzQkxKSEU2UEQ4U253eTQydC9EbEsxc0JtNHpQ?=
 =?utf-8?B?S25qa2pxb1BycjBHcC9VNkU2NTNxeGZkWXR5YkIzQnBwVTZuUFNZV3lYUVFy?=
 =?utf-8?B?bjRxbFNpbVlyWU1MOGJXNGZQdVJhdk5oZnJEd1pTZHlwVFVzb3dhTW12SzVX?=
 =?utf-8?B?MkVXanhSRVZZTEF4dm9jRG1sSlp5blZSZUYxQmp3UEJiaDNsTEU1bU1ocGJO?=
 =?utf-8?B?VTRyVU84bzdIVVo1Zzc5anBiZHdzZUVTR1JScVNUL3VaMlFraWdBR0o0TWRW?=
 =?utf-8?B?eEsxRkZudUoxcGtseWxVcjVzc3IzSEFjUTN5aXhwTmlpeFJHbGFLeVBBcmJ1?=
 =?utf-8?B?R3o0ZStmR3R2cC9IK1RPZC9mWWkwYXh3VmxFWkMxVk0rOHptZUVSQ2VtaXJI?=
 =?utf-8?B?aFF5UlRZK0Z4aWt3MkUyNnJXLzJaOFJBS0lSd2lRV3hXMkZXZ21ZY2gvTUxW?=
 =?utf-8?B?MDVVTHpWQkNScThxZXRiM05YNUZqWHRNb3RPR0ZZQVRwNWVKN1VadWFhbHhZ?=
 =?utf-8?B?TUd0THVibXQ0T0ZISndJQ0VqcC9mUlA4bEZoOFNwc0p4aDdlRmtYTlFaVUtz?=
 =?utf-8?B?ekFEZUhybHk2Q0F2OEdzcGNPT1laN2FiZng0c2dSWVNhUDlZRHBGbW92emtp?=
 =?utf-8?B?OFZZd0lDLzdlSzM2VW1RamhoWTVZWG95cHJqclFRd3RwU2krK1gzK3VUTVM1?=
 =?utf-8?B?ZnoxRm4rTWdEQ25ISjZZRVlwMEdEN2hvenExUG4vUm80WlIvT1BTT2g5UnJR?=
 =?utf-8?B?QklPbFh4R1JhRXgzN0NFY0c1NWQ5TklXQlJHZjNkdHBFdk0rVU9CejdGaGta?=
 =?utf-8?B?cUVlR0ZpcXBray9UQnFVVHVMb29zaWRuZ3ZNMXJNcm9LVDljbHJVVjhpK3Ri?=
 =?utf-8?B?OUdvNG54ZG03blNnZEgzaS85TG1TWDVGeHJYQkt2QXlXd2tGMkxvaXlUSVZ4?=
 =?utf-8?B?RThTeUwyOGdDRVVqSWJHVW5wanp4QWVTQ2xoVzhiS3FHRnh0V0RMdmdTTWRm?=
 =?utf-8?B?WmVSNTdLWFpMcFNJb3l1ejh6V2hsYTdTaWs0N09mQkJvTVQ3ZWdobm4yWmNI?=
 =?utf-8?B?ZmZTcHhXaDlWTGtYdlR4VTVncjJzNHlFOWNNcFA1NTZiektkb3NBSFgxREFX?=
 =?utf-8?B?clQzb2pURGJrWXc1KzVmMjNwcmRxZ3BjdUVueHAzTlFYTCtoSWswYjdncmtD?=
 =?utf-8?B?SlFPQmQ2WUp5eVVSQzVoNS9OTmpESGJXSER2elpzd0VJNGdkMVd2ejR0aW1M?=
 =?utf-8?B?cWZ0V0lzMERGbjl4VFN1dUpiRVlBZnZLUkY2bDdQRi81Y2Vhb1Y0NkYxOTZR?=
 =?utf-8?B?UDAyd1FRTWtLNGtyQkE1NHlRWWFzSWoyamxSbHdyUFRRRUNHYWlEbGtrQ0VW?=
 =?utf-8?B?ZFhZdnk4SUZGeEkwNVR6KzNNQmVnY3ZVNVR2bVllREN6R1kwVnFZV2FOQmg4?=
 =?utf-8?B?OHdabktMaXFLTnNLcU1QbzdhS2hXT29ZUGI2MklKY0t2cnJyVTd3YXIreGZL?=
 =?utf-8?B?QkdIOWtQOU9jVmJ3aXpNb1hwVnlqcnA4bE5zWGdMY29Hb2ZBK2pGRjROTFh0?=
 =?utf-8?B?RE5VeWdjaU9aRGp6YVM1Vk9kK0oxQndqQXV6cElyVEtCTDBJTVZGZUllV2Fn?=
 =?utf-8?B?enF2NWNjZmVndFNkamlrYlRkcWVLTkppWEdaVk1NanBmYiswL3dUUFRncGNw?=
 =?utf-8?B?TXV6N0x1VVdnQ1RUMUFWNEpjZUhnRUZRNU1rdGpjUitvUWhMMTJmYXg3aG9U?=
 =?utf-8?B?U0gycTZlNkkyd0IzR3JOWXB6OWZGNXZCZXZCYitwZnZRZmRxYU9ka1pTTENo?=
 =?utf-8?B?dzl3YTlyc0kzdXJXdzJNdEZudi9HaXN3UVZZS1NUZDBndGdhVDJ5Vk94bVFa?=
 =?utf-8?B?aCtDQXZMTjJ3dWZ0Wk1ZSk1MdWcvbGhFM2xqb2ZSTkF4T0dGd0JSTDNpeUhm?=
 =?utf-8?B?MnlIQjQxNFl3SXZvSVY2YUdOMzk3UDVkTFJZTS8ycEFVNVF6b1lDUUFKb3FP?=
 =?utf-8?B?bzE5ZVhBbHZlSkdtOHBNWkk0eUdwZmdVQjFsbzl1RWdIeWtyZUU2NkplclFt?=
 =?utf-8?B?OHZuc211djVpRzZhdEhMWmpvYmN0NkZaOFZTVkVsRTBhNUc3d1BMaGVYVjdJ?=
 =?utf-8?B?OEhHcnkyWFllQ1Vibnc1c0xjNG4vSVk0bENOWjduelRJTk40UTVDclR0aWFN?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d39219-d44d-4788-5238-08dd9d26d63e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:00:28.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zow2Mhhl4ohWfFs537v/pomNpJ1sRxMA0qAhsP7K+5jzpzkA/kZ3MR4gEkli9BMUbaLauezI1/mZI8prXFspLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8964
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 May 2025 14:00:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18951

On 27.05.25 09:04, Shivanand Kunijadar wrote:
> Major changes are as below,
> 
> 1. Fix the rules for aide tool to support for symlink case
> 2. Update to tests to print the summary of IEC layer tests and
>    time taken to execute each test case.
> 3. Check /var is CRYPTO_LUKS instead of /home as it is moved under /var
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  tests/templates/IEC_template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index b93ed4b..fe4132d 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -64,7 +64,7 @@ actions:
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git
> -       revision: bb19990c2b29ea96eea309e54124c74ea3246f18
> +       revision: dee76c8b6612439ac648fd18709088ec8fea7e40
>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>         name: Security-Testcases
>  

Thanks, applied.

I saw some sporadic failures of test in the past weeks - do you have an
eye on those as well? The last one was just a download issue, but I
think there were also few test failures.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

