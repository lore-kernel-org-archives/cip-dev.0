Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D92CCA476
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 10:58:38 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.48])
 by mx.groups.io with SMTP id smtpd.web11.40963.1760353111900226586
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Oct 2025 03:58:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DOL+pEbl;
 spf=pass (domain: siemens.com, ip: 40.107.159.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL0gMdbrNfVifP+SH37AQfmE87PvjwXNdyGBTsUjDivDmchXhen9R4mvKEXlO0CIHvmEvyYvfD3Fr6Wcps+zKKOPI+9utpwnChtP6d5NFvKSwHR93rL1J+/kCAIvRKVPMRwWoJY4waF1lVwmEazm4LE/OIevhfKAwan+MKuwx04WRGkPklaN0ibTxZ6Ly7dmSrlRx2RUw/JSh0RCTc6gbuhG+IET+W3hTyNKqHyDYGSjg8C/JfmC7NStLdCX0rJC/aUT1aIC2LdKG7gPRd28xcYyXcLL7UgetxVxyHpa0m5mCvDfE78VZH8mJp5MKKtPRqYpjkOATF2RPUYNJNp3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSDIPVmdzlMl5Lmpr/GW0t3JBzFcIQgAQbmxTOxkqEU=;
 b=wn20B0timPcIN2Kn/aTXzI8I3YnS86rBbzeHh2vH3YVDhir76V+50OxkzY6DZdhd+VMnqHnx4QlgGEjKUhDrjyW1dao1zFtk9cgFhW1YJU3v337bJiis2a9pkUIccIWYvHFtymP7sR0EDTyU142RXT0HzcoH2nFdsUdHAznMbkPo7nA8x4pNhtCLJwXeqI9JwUdXznmDwJ0BQONhRI0ZXWjTAQ9Fh5nHoeRhNNURzbfKQI6zQi8RBZi+DqVYOHAiYhAa2H5UO6hGAa/o1rI+8CvUvMbMa1v6fpAsT3rcD9etW7YLFcW8qlSeIG0xHe6l29k/3vDn7Z5b0xJJl1khtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSDIPVmdzlMl5Lmpr/GW0t3JBzFcIQgAQbmxTOxkqEU=;
 b=DOL+pEblHhRyI3zwkOE1pZf3F98Mqb1bHzQgt0WWQ5BW/GCkvV0R71nvGlsR3skEEUOpT2Q6dPbu9ToT2NGlZrVR/K3IZWYAJ+A+hbgVpyLwDMOgiCKkUZ2TGVnAiDqHz0ZLWpAz/4FfVwrraDpBwou2z8RiVxe0u4fp8v+/OgjRqnG1ZiwFHpWJEQ1u3nAGYpnUkN3PMv/hRBaZ8/aYgsytOR8A+k1l5nhTkkDaRCwsuR3DP5wVoYzwbVy0+WPLlcHvvDl03Jabx0YoC8e7HubXa21exQMNu6qvSvLCmbLMvnJmxRpkbSULLz21F8wSZ2BildgL+jkQmuO/xDWrkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 10:58:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 10:58:28 +0000
Message-ID: <30cc4852-ed8f-471b-8d6d-bece689c465f@siemens.com>
Date: Mon, 13 Oct 2025 12:58:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] kas: Update to 4.8.2
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20251009054448.4134620-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251009054448.4134620-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb2bcd4-6e23-4dc6-0e68-08de0a4770a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VlVVR1lyWmh4bXlXSlhYS2FTdCtaVEhwNksvb1NtcFg2T2xFcU9QQTVHb1My?=
 =?utf-8?B?L3JmSDRHYTlTc1pqTGRHREx2bkdYTnFkOGQyQS9sd3YxNHV0WTFtZTdmc1ZU?=
 =?utf-8?B?YlFWcGZPR3NZSHVQMW10bFdkdEZ4dkkzM3RoNEpQbnpESmtZSzhJd2QraDFm?=
 =?utf-8?B?TC9BVGpoQTRkaG5kSzlmZmdUd25sVW80OWFiTUF6dXZWR2RVRmJmM0llUW5y?=
 =?utf-8?B?R1I1QTFQTUVHL1AweW9OS1RRTzdibUdVUktDSE0yb1lPdDZhVGgyYlhTQlRS?=
 =?utf-8?B?YWx4YlhBWStYdXczbUxNY005bmgvVno4cG5JeDUxaU40YW1DTjJQNlZqdVFF?=
 =?utf-8?B?aEc5M0NkWHpzcDJHcmNIbVJHMWNaczFONG5OOXRJd3hNRnhxeG9GMHJnRmVn?=
 =?utf-8?B?cE1qTm1WS0haMHRHdmV1REU5S2lSbWlzQTJ2Q21sNTgwU2dBZm1yR1gxU0Jq?=
 =?utf-8?B?Y0xaR0FEU0xmdFNZeEt1Tk40OWsrMWdlMUhxemd6ejBTaHhENmZ0RFNjQ0dw?=
 =?utf-8?B?S0RTd3hQb0xmaVlDdmNKQ0ErRmdyY0pxWXNiWHhmdUFaZkVYMjYvNEN6WG5y?=
 =?utf-8?B?OTBuQVJOVDdoSnJTOTEraXg3OGtpcDVNMmpwK1lJdSs0M3pvQ0g1djRTck1V?=
 =?utf-8?B?Ni9BeE5uV2M5UWZjQVJqRGpwcmwvTEtZanVpSDF1cjVqbW1YakNkUmlVZkNu?=
 =?utf-8?B?UC83WHNVa2hEWE5WYWluREZRUmRGNXRRejN0dm5Qam01MWtCaDdJOW5vaE1F?=
 =?utf-8?B?eDVVV24yMTUxRHVGUmtyYS9IS1dDZ2FsOXJSUGJQS090QVB4cG1zWlh0UTNk?=
 =?utf-8?B?K1BJN012NitBZDVFaUREbzVyR0lQZGV4UEZ5ZlFuVGtWQmNhWVRIelNmMFFt?=
 =?utf-8?B?LzV5dkd4Qm55MVpBKzYvVStha2k0SExQd0gvMEpuWjcrc2k2ZWd5TnVWTnd2?=
 =?utf-8?B?dHU3YVFtck85c3RucllQbDJlUHpCN0FSQmxBUEFBaTJqYVZOR0RSNGQvMFRj?=
 =?utf-8?B?bG1uSHZCd3BtbzA2UmxQa05CS0dDOWtvTmJJVzhaVzhaNDNOZ1ZOc3NkS0FC?=
 =?utf-8?B?YzFwSHpkc1AySkwrWCswUkNZTXBpRVoyRmRaZDZFdUluQXk5Zm93R2ErZi95?=
 =?utf-8?B?WDFmeUoxVExDWjUwQ0gyK1V2SlRzZVpOQXNJNm82VHFOcnBRSTYxOHNqUFNz?=
 =?utf-8?B?ZW1pYWxpNkJTeDFHVXN2R2VYUnl4blZGbklQNGY2NzF6d0xsYnRYNnVqMG5X?=
 =?utf-8?B?aS91T3J5ZGsyb0JCMHYxTDA1TkZPcTB5clljWkZjaFdTLy9abTBoRDBHT0xT?=
 =?utf-8?B?NmJYVC9KQW1vQ3FxMzFYa0cxOFg1eHBFY2YvSHlwTVI4MVlVWFJRTExWUk1l?=
 =?utf-8?B?TjFueGZUSCs4aEpGRFZEdm1jbEhoZ2hPZkVnQzBvNW0wbG85eG1yUFpPYjN6?=
 =?utf-8?B?NTNmZ2N4TGUzd3ZTTk5aYXRNOFVNMmIyTkh6RWZoVHJ2bHVQNTFQTSswN0Er?=
 =?utf-8?B?QXhJT25aUHlEdW4vK1VlWTZacW8zRXJqQndjaitiRzcwcUNWbXFIK2xMSDlp?=
 =?utf-8?B?MDd0a2ZnMGtaQVpoMk9yUzhxTUNSc0Zma3dDYWlNcWpJQTEzaVp0TW1kSkJn?=
 =?utf-8?B?aGFrKy83Y1NOZ3VLcytudUliRjc2UmhhK2JCaVpUU0ZCWnphSERPV2tWWjFJ?=
 =?utf-8?B?dXhlMldJL01mNExzSVBJanBNZWFHQ0dXYVU0LzRWNSs0bmJ2U2lxTEIrcEFW?=
 =?utf-8?B?WmF1WUYwbHJvRVBRNWVwVGJBcXNUV0Vtc04xQ0FiU0dyalYycVJtRGtKZ01m?=
 =?utf-8?B?cEx0dXJIWHcvYThHeTFPdkc0QmJySzhhVVBlcmtyTlQxVTlEMVpoc1BoL2Y0?=
 =?utf-8?B?d3NubVg3Smtla0hrTGtiTmxEV3NpUGhRVFd1d25PSDZjUnc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWxvRjBkeFljSDJrQVExTU8wRjh3SFVqVE1za2JXaHhHdFZQOHMycU1kMFkx?=
 =?utf-8?B?VUVyV2EyUEgvMTN4ZEEvRFcyNVYreVQzZWRVUXJFd0dOR0VvR2JDRmlMRWpZ?=
 =?utf-8?B?Z0VTSmM2TDNyai9hZUw2Zk54ODRJOEZvR0hGL09TOEFpcVdQTDZiRk9vL1lq?=
 =?utf-8?B?OGhLMEllb2RVbGNPcWpPYS9QeFBKQmxnWXpVWmtzTXpjdGxpcTJSYkZvRkxR?=
 =?utf-8?B?MnVPU1k5d1hPUFRTcWdxN2FXNnB1Q3VncFhxRmlFREsyNkc3UXhwWHlGb3p0?=
 =?utf-8?B?WXEzdE9nTEZsNVY1ejUwc2tGVnYwYmxka1FkKzdMb2QxTWsxMGM5OUdmODk0?=
 =?utf-8?B?clVFdG1PWXl1WHZZSzJnMzNjOUJhRmd0UWhUTzA0SCtvOER5cUZRZjkxQ3M4?=
 =?utf-8?B?US9haTQzRmw1MHdqTEVKczJpN3ljK3JjRkJtREVham9rYTlXSVJObCttUlJI?=
 =?utf-8?B?cGxHTWpsUnNuWk5hUzNlL1JjNUNxWEtTZjBzUHNTRkNhOFhRVHkySU0wQzho?=
 =?utf-8?B?MEVqdzRxUmFCWElhcFBQVXcvUGVwWjdEUWlWb0t0em05WDA1MDdFZlE4Q1Uv?=
 =?utf-8?B?YVgrcUNDclpGcGxiK2pmR1oxcW93bE5qTEpheW5qNXpPZ3BqOWYzZGp4ZmFI?=
 =?utf-8?B?eWdEMnR2N3FxM3lLWG1scFEvVzJXT3RtOWtPMDhzaitjeTlyU1VWVmpMeUNj?=
 =?utf-8?B?NTdRMHlRYTA1NGR1MzdTUW1lUzFSc2R2Sy9GSFFTd3YwbVppbDhtZGdNT0JO?=
 =?utf-8?B?d2tsL1RocElxcmR0a3N5VlpwMlJ0czFSTllNV3FydWpyTk1HcEJwK2FEUlZZ?=
 =?utf-8?B?NGR5dWJPbDI1M0FhMkpzcjRuRVhmTFBFajRZTHNTV1pGdjlKWVlZcnA5a1Er?=
 =?utf-8?B?VnhBYTNndFpsMmE4NzRXWTlsMzlOOG5pN3JoeENsNnZMbmM4Rk00Qk9OZ1hK?=
 =?utf-8?B?TXhZWmhZTFIzUFUzN1hwWWg4SXUzNXNsUWkzMDU5MXROQmtNbXMyZXFIcnBw?=
 =?utf-8?B?T0FuK0tlVWU5bDAzSkE2emYzSisrOWJjdFBrdzFHUFpHalNtenJRZnJub0sy?=
 =?utf-8?B?S0lucFRRTnlIa1BscE9uRDluNWNIYjFvMVptcXBIMzd3UFVPRjFOazcxK09B?=
 =?utf-8?B?VmN5alBHb3FJcnVvSytNeDM4RS9HN1hpVWdUV0Y3WHdTdFNHNzlGeU90NHA4?=
 =?utf-8?B?NnFzbm1OeGZSMmRsR1ZwMW9VM1I4aWJoeGl0bkxualViUUJ1WkNqdk5hM0hV?=
 =?utf-8?B?VEdXUy92RC83S013c3QvRzBhMmtwU0I4NEZUa205SWkzemhlaWg1U1JLbEQ0?=
 =?utf-8?B?eHJnRDlJM2FObmNJRXpZb1l4TFNRSXJnMzAxQWQ4emVtb2tJbzlydk42NS9z?=
 =?utf-8?B?OGh3YUMwaWN4UGdaWk04Qm8wTVFzZkVPWVlleEphZER0SGs2Mmwrc3NYZEts?=
 =?utf-8?B?Zk00WFAvZ0h2WVRmcTdnRkxQN29OZmdoR21KWWFiQlZaZ09TSTB6MUFiVzhR?=
 =?utf-8?B?N0tlYWd2ci9nWU1iajJwRXExK3UvZXE2VSt3cnFEMDZQK2x2MmhFQW9tdG1Z?=
 =?utf-8?B?NlozaEk3a2VwOTBqUkliUWJqU0NBUldmaEVCUjZDTFYwY3hZVWhVM0UxL2VX?=
 =?utf-8?B?TEpEUENtVHl6ZjJrNngrUmhVd2JNVWNNSEdMWGVpLytOVnI2VjhzNEFiVU9p?=
 =?utf-8?B?R3FWQkhYZjR4VlRkM3dFNjlKdXZ4cjhSdFo3REcveFcrajEvTGx4VHl6MjZ0?=
 =?utf-8?B?aFBGZXpaVmRtTkF3bmFra0s5M3NuRzROSmVmakNFWkZqRFprNm5hOWdlSE1M?=
 =?utf-8?B?QmplQVNTcldEZVpETnVuT0Z6dkliTElLOU9Gb2ZUeE5nVWhIY3lNc01FeTNR?=
 =?utf-8?B?WmxnQWxVNkh5M3Bta2N4UWYvdTBKUW5idm5tZWlDWUk4L1VQTUFIZjByQUxC?=
 =?utf-8?B?V2xHYTRib3h1YnU1QkcrSTBnQ0JwWnRhMGF6eHJuTmFtMzYyajZkbjZYOGxE?=
 =?utf-8?B?ZFN2bjFXRTFGTThCWmNaTEtORHg5K2kzOWNGRW0ya0tOQWIxK3NSbmo1RXo4?=
 =?utf-8?B?NlpJckd2TmFDT1JiTkVzK3hlbUtPNklTeFpmdzhWSzNISWdzUDJrVVZYQStn?=
 =?utf-8?B?c0FOZWttcVFyaFgwZzJjUHR5TzhhSVlTQXU5VDAvY3pKTjU1TVB6OG95MEND?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb2bcd4-6e23-4dc6-0e68-08de0a4770a3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 10:58:28.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjj5dlV1FYjs8bmYwnIJ1WTXOvYCHy9j7b1I49HGKo+8ix8X/XvyOqJ3mxxbrJIsydibfMoPvuN4j7MmkYFRyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4049
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Oct 2025 10:58:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20171

On 09.10.25 07:44, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 

As no reason is provided, I assume it is simply version housekeeping,
not a fix that justifies a merge before the final 1.9 release - or does it?

Jan

> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  kas-container | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kas-container b/kas-container
> index 0e99898..476724c 100755
> --- a/kas-container
> +++ b/kas-container
> @@ -27,7 +27,7 @@
>  
>  set -e
>  
> -KAS_CONTAINER_SCRIPT_VERSION="4.8.1"
> +KAS_CONTAINER_SCRIPT_VERSION="4.8.2"
>  KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
>  KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
>  KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas"
> @@ -454,6 +454,7 @@ done
>  [ -n "${KAS_CMD}" ] || usage
>  
>  KAS_EXTRA_BITBAKE_ARGS=0
> +KAS_FILES=
>  
>  # parse kas sub-command options
>  while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
> @@ -686,12 +687,9 @@ if [ -n "${SSTATE_MIRRORS}" ]; then
>  	set -- "$@" -e "SSTATE_MIRRORS=${SSTATE_MIRRORS}"
>  fi
>  
> -# propagate timezone information
> -if [ -f "/etc/localtime" ]; then
> -	set -- "$@" -v "$(realpath -e "/etc/localtime")":/etc/localtime:ro
> -fi
> -if [ -f "/etc/timezone" ]; then
> -	set -- "$@" -v "$(realpath -e "/etc/timezone")":/etc/timezone:ro
> +# propagate timezone information to entrypoint (requires systemd 239)
> +if command -v timedatectl >/dev/null; then
> +	set -- "$@" -e "KAS_HOST_TZ=$(timedatectl show -p Timezone --value 2>/dev/null)"
>  fi
>  
>  for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

