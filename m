Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0535C10F1A
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 06:22:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.55])
 by mx.groups.io with SMTP id smtpd.web10.5196.1715062915274213213
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 23:21:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SB9CKMf9;
 spf=pass (domain: siemens.com, ip: 40.107.22.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDtBqbgCT1pKwtkyUeTd/taervtsSS4GZTWntJiNQNqDRuBj8SWWh4K21XnAVpe5E6YReOsV15IXvCa6g6tqH3m3IjIjngTPb80ApJpd5xPIWwlAToftCT9tdCHGzoSW+HoMhWYgXxa34Vu88Uwq3DpQJvJzemhC6JXwi6FUFQmBPI0FinpK4B8nOAdmGrBeISOUh6jE73bt4Ff7TIaNlzc90rCK/JsN8ambQ2/tpmemF8kvRLlGy6kcejw6X3BfjQGyLtTCsGbiQHT1Jqg5i0LG1P3OLGSFdfTE7EWFEMdWyrVF2A45fEeh2wuZJldHQANPx3dsUQ2xshZzxL5+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbkl0cEmdyNYSS9X3vR99xl4BoZdnr94PI/7TQAYRww=;
 b=LsD6ug3zEoiHgfSUvdBCKzJ9U5T/eShjlMtOjl6uckEREzHK18VyNhPZsadFcrdMstpebgYyqEYBWtt15UgjeYNs+8VXLvqZi41lHYMXwuaqlJMZ10riWjWb03aVfhqlLDAih28WwUFIDBqfi4aIsg2dnB2tDQnhpOI5LIROiVxY2NeQJriSrWcbwRlHyAq1bAozozFOi5Ge8Y6ZiZ5zfeVSApt1SVdNO7YEvdgAl3XFgXSxIYYM+MaSOkvLoVUEgqqV6+1oNXYPgwyUtMu2WLY2ts/U/RK9ZR9qiRTzCEuYHUFiNKE9ALfdCp67FI+Puw2dJZFB63C6UlduBqwY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbkl0cEmdyNYSS9X3vR99xl4BoZdnr94PI/7TQAYRww=;
 b=SB9CKMf97OFOkaKUj0gm5ZmeOOq0JVEs2ioCj/aeetM3V8iaPbkCquArgX0SYdKhm8EpCQkS+NUdJ/r9fbs8Ypn5zRojYoZR5xelYvKSDl9j4rk9P04VHDxg2bCO1oHTDcSlXO1xNyx1qyUwoeJC16Y11atO8gPM1ATEVaWmeANOPYUpBGGgW60PzXe6rpJqQLvcS1I5XIqO1CMxP8z3DuJANDWFo1WDTqNPq9J8/4//x6I+cBCXrufAXGxRiBOdhIER2Hq3ZPs55JEm5Xt9V/jbiJjY74yQp1gTT2zt6hyUD94F7TQw4BNAmzVRtMbbykouBik3IJJyOoHcEUNsig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 06:21:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 06:21:51 +0000
Message-ID: <798dc2dc-4f74-4e61-8de3-4f8d67c0497f@siemens.com>
Date: Tue, 7 May 2024 08:21:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v5 1/4] Add Delta update support with
 rdiff_image and delta handler
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240506154130.840349-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240506154130.840349-2-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240506154130.840349-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5533:EE_
X-MS-Office365-Filtering-Correlation-Id: f20ed4d8-8310-4ac2-69e3-08dc6e5dfbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?djlNSFNKcGJ0dDFmVTY4YXNOMXZCNXhmVkFIWEQwaEp6MmJEaVFUZWxoQkpU?=
 =?utf-8?B?Und1N1pjeTBUbjc5MGlaYWxxQmpNeFBFekRmYTFEOEVpVzBiaEhITUZZRnJV?=
 =?utf-8?B?RHB0cWUyeUU5RUhSdTVqZFBVUENrdk83NFZjcGFTYzE4V09RK29jVHF6Z3cx?=
 =?utf-8?B?MzlMVkNEOE1wcDdXbFNZSVlERElld3Y4ZFhpUWh0K3N0TXp6bmk4NVZqenM1?=
 =?utf-8?B?dFd6RE05M003WkhQOWx2NkFlU3UrVGZHWWd4RS8zaXJRd2hiRkxrZ2tyKzUy?=
 =?utf-8?B?SW90YmI3WU0xS0ZPdzlWNy83U01lRWFDYzhQdTgxQ3JMZExtSTF1YTR2QmJR?=
 =?utf-8?B?RDJCc3pTUTYvdTY4OEJXWUxhREthZUhueEdCaEEvTFMxclRTR2doM3lSdE5a?=
 =?utf-8?B?THYwUjdGUlJhUGF6OFNSUkhYVW1XS3EzTEtLM0pYTTF5WFZGbWVBSGFHaUdp?=
 =?utf-8?B?RDUyS3BnVHhCcTBVdURkWHJMaUJ1ZXdrYlY4Qi8zZWg1dzdubDJ6ZzFIQlVM?=
 =?utf-8?B?VUI2OVp6Z3kzbWJRWUtNckJ4VURtd1QxZy9ZdW9hTHR6blNzd0VqWFBHTHAy?=
 =?utf-8?B?UDRGQ0ZGbmg1M1Y2OHQ0OW1oQ1hqeXhKTy9sZmE5WHhVMmN2RkovQWk4M1Qv?=
 =?utf-8?B?SVNyWHNIZ3pqZS9nZmRMaVA4Y0dqUDlVNW9QTElFenZ0M05IaUNpZzJGSnhm?=
 =?utf-8?B?aHllQXRCc1I0S3NrdGZ5RGlWT05aUHAzMmJNVURKV3JiZjVyL3h6dTdNSzl3?=
 =?utf-8?B?WlhIUC9BQWxZUXhpMVBTajBuWmdVdnRDeS8ySEVLeTNVMk1MM0U4MVlQWFcw?=
 =?utf-8?B?Ry94VmZ2WDJrcWYrYWRxSUR1MHlycGx6cXY0MkhzZ3pYMG00WWZsN1RlYzgv?=
 =?utf-8?B?dENtYTQ4ZkloZEdjd0N5VjJqSHlQazdvdXpONmgzOUNBNUR2MzZZMytlYjd0?=
 =?utf-8?B?d0JoS2pLeGZsajU5SkJ5ZGxPOVYrZ3VwTlM4L3hZa3hnMzM2QTFtTFczdHBY?=
 =?utf-8?B?RnVNY1ZQOEZxWERuejc3SVcxK2pJZHpuNHNIL2RseWxacHo0bXYrZysrdWxB?=
 =?utf-8?B?QVQxcExBSldIbGFsR1NWdFZIWWF1cXAvMU9iUFh2MmZjR05lckxRV1EweXhP?=
 =?utf-8?B?WVVwbWdydjFaeVNKby9hVkRJV29PMVJ4cVI5SndHRW14WHhxK0YwUkR0bnJT?=
 =?utf-8?B?RHExVTlkdHVURmx6cUpRYVVlNmpiNlZpR0M2Nkp0RXJDR2wxaDQrV1poTkMr?=
 =?utf-8?B?RTAyeTcvdXFtR3lHcWZ4SmJJREI0dHJZRHk3S0hteFBiQWNNVU1QTTlVZnZI?=
 =?utf-8?B?VkhueHZoandiVGUrWUhoSGl1d1pxREtyM2lhRlhKdXhZVVAzVzVmcjBaUVdl?=
 =?utf-8?B?TEd1UUFlc1FwRldVL3RtbU02RDFuVEdlcklaeURsUDJvNVp2a1NyWUo2M1RJ?=
 =?utf-8?B?UGV6UGYyUHNhUXlvdDZLZ09HMjRiUHd6SFBBQ2NQbnF1eVc5TUR3YjhiaFdv?=
 =?utf-8?B?N2ZWZEFYaGxZS1ZoK1dnZUFscUU5OFd6WmlHVktaV3NiSHVkZWVBYXV0WHR3?=
 =?utf-8?B?bEpnNlk4eXpjelYxQ3lKNDExWnJ6Rnd0bUhBdUJaNDhqU1VnSTM5MGxYc2d5?=
 =?utf-8?B?VGZJY29WZk93cStkVUVmcUh2Z1ljMjNNdzBFWVRBOU96RjF2ZWowMnF1azhw?=
 =?utf-8?B?VWM3MHNRdkw2MlI2bkQ5aG9Cclcrb29OSlNpdkI0TUswWTJNa1BOd3pBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDFIMGRyaENONWtEeU9uQTFLdmdHYm9Cd2ltdU1Fb2R1M01QWUZlWlV2aXpR?=
 =?utf-8?B?OVRSRnZDajQ1QVFKMEJ4UmF6MFJIVm43WVlFZldXRzRmVVZ6SkZsUDhmcEZa?=
 =?utf-8?B?QS9zNUNOcStnUFh2amZXc0ZVSUJIQUxPUlBzcWtKd1RKY1hsVXN6WC9maVBp?=
 =?utf-8?B?TkRwWU5OUENjWGtWTjduTUFUeFR4aEZMcndNZ2ZZbkZQVHJKQVk2U3p0NCsv?=
 =?utf-8?B?UzU5bVNKa2JSVnM5c1pVZldkRlExaW1HTzI2cUt6aU94ditkMHQxSmVaaXhz?=
 =?utf-8?B?L21RZXFlbm1IdlRlZUJqbHJNNDhxcCtDVnM2K0l2N0RxditBMnJnWU1yclFa?=
 =?utf-8?B?Zlc5d2U5ZzIxcSsvUEY4M2xXc3V6MllXSWFneDYwSFJoNWo1RVp6dWE1REZW?=
 =?utf-8?B?V05ucE4wSzlLMGxFNjE4MUMydFgxY0JOQlNaaC9sTzFKTmhSUTFlQTY2ZXIv?=
 =?utf-8?B?TkhiYXM4anB2UWpwWUpUc2JGeTdmY3ZFUFBoT2s0ZWhwYWJtbTNORnQ2ancy?=
 =?utf-8?B?ME5Id1lyeFlkZFpHYXBWTEV0aUZrZ3ZhVFU2TnBRWHNMS21Zb0UzNXFiaVdo?=
 =?utf-8?B?NHl3dU9tN1VUVFkvTXlxQTVhbVpOTmg5Q09PNWFzUHE2ajhDLzAwTks0TzFD?=
 =?utf-8?B?OCt4R0h5WnQvcnZYY2liTjBHVVFiRWhEMkNKR01YT016QnYrWThuaDFjZUJG?=
 =?utf-8?B?RkxmcXBoYW1QWURQRzhYWUZWdHkzVlBWUkhqVlhMOGZsOW53aXR2anI5bXBK?=
 =?utf-8?B?Qm04bHlCWkd0ZThMT0RqT2RSMFBYRExidDMrUklaTVRNUGhhdUlQMjVJanVw?=
 =?utf-8?B?bytleUFpdGZtNFVDTytEN2U1YnFDV0MyQU0xUVZPWUJoNVRhTmdsR041UFBK?=
 =?utf-8?B?YTY5L3ZtUlBvaC9jZENwRHM5ZERnNzRpWmxyZVo4QWxQd0hkdStvZDVTdzlX?=
 =?utf-8?B?d1M1S0ltZEJMblovT0xueTlNUVBGUkdiNFQ3RWtlREZPTjFLNDg0Y2VUM2dS?=
 =?utf-8?B?UnRHN052a3Y5UnNpZFJsS1ZYL244YUdwbmxhMVBvOTdIYjJLL0xyb0grOU9s?=
 =?utf-8?B?WGErWkVHeVpvRUtxTCtCOU1mbkNSd0lSU2YrN1h1VFQ3QjVEV0VKQ2F5eCt0?=
 =?utf-8?B?QmsweldoandHUG04WGtTT2JKdWtCV2pYMzhyei9xYk94OVAvaXBZNzJHY00z?=
 =?utf-8?B?dkVmTVpqYWdXMlRjVXFrTGVFak5GRUp0ckhmQllZOXFMY01NQ3ZTZmZUSmZr?=
 =?utf-8?B?Q3dLcXZxM3cxUlhiOHBxYkVJNk1nWFl5M3VSamwzdnZPbXZMeCtBdkpGQW81?=
 =?utf-8?B?V3pVWGlMZEJhaEZScXRGeHVPN3NZNzhjeFRHYmJGUnBpSFNXMUI3VjQzaWdV?=
 =?utf-8?B?c1piSjVHS3hlZWQyektqd2xvS2lEMDJWVmhWM0FQR3RkNy85ZmJCUE80VE9N?=
 =?utf-8?B?dzVIbkd6bnNjMm83WEJLVFJPK3BpWXphUUZNLzR5RUw2SzN0Y0JvZWNsSmQ2?=
 =?utf-8?B?ZkxmNCtTZHc5VWJxdWdyZk9BeWpUOVh5US9OZFlxazh6a1V6Z1M5OHY1TjJs?=
 =?utf-8?B?Y0ZTYzQwYWZjOVFWSklVY2lEMUF4ZjN1VUlxKzgyNzVOMFN0YnB0b1lUZStI?=
 =?utf-8?B?VlVzM0JTMlhheVV5cEhHMVlqVWd3a2JTS0dsUkxjSEt0ZXlER0dtZFZUaERx?=
 =?utf-8?B?WTNMWnRpUVdEYWN5TDVWdEpVUE5uTTc5V0lyelg2SjZzSnhiRmhVZEJiWlh2?=
 =?utf-8?B?VHRJbnl5WWZMdm42dHllQ3kvV0dMNlJiMVJjVUpOcFc1clpwSWxOSjQ1VWkw?=
 =?utf-8?B?RTdvTEV0S0l6ZllwRk1HR2hvakt6MWNNT3lFT1hiVDdQdnhFRXdENVpiUE9z?=
 =?utf-8?B?YkJSQVNmbDE3TzJvVVJNV1lVZjF1eFgwMU5IMWd2T25HVUd6ejZlOW1QY2wz?=
 =?utf-8?B?Qk5ETWpMclRJdFZwS1hIUjY5cEUzeEZWQnEyY01OcUNzOHg5WTkyZnpmWWN5?=
 =?utf-8?B?eHBGQ2RCd1RMQ1lWSGM5cTdoaTBwSnFQM0JQOThoc2svNnJHTFpjUnNPMVY3?=
 =?utf-8?B?a0JNZ014SitwTXdmTi9zRkg3aExJd1lkNFg1ZlZueEM0MFRjTFgzNE1xektx?=
 =?utf-8?B?clNFVk1qdkdmb3hZS1BEcmNiR0VHOVA2ZEMyK2JjZ1IxQWYzTTBpU3RYSVZE?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20ed4d8-8310-4ac2-69e3-08dc6e5dfbf7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:21:51.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGcU337J3rO3GRoPmh8jh+/h+jALSd2bhQeKIYFhgUaMkQ6+IE3hRj3mWuiQh9E/UVZGxOK93FrOR9OimjgwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5533
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 May 2024 06:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15847

On 06.05.24 17:41, Adithya Balakumar wrote:
> swupdate supports delta updates with rdiff_image and delta(zchunk)
> handler. This change adds support to use either of the handler
> for creating delta update artifacts. zchunk based updates are supported
> only for sid.
> 
> DELTA_UPDATE_TYPE, DELTA_RDIFF_REF_IMAGE and DELTA_ZCK_URL variables can
> be modified based on the update type in the delta-update.yml file.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  classes/delta-update.bbclass | 102 +++++++++++++++++++++++++++++++++++
>  conf/layer.conf              |   2 +-
>  kas/opt/delta-update.yml     |  20 +++++++
>  3 files changed, 123 insertions(+), 1 deletion(-)
>  create mode 100644 classes/delta-update.bbclass
>  create mode 100644 kas/opt/delta-update.yml
> 
> diff --git a/classes/delta-update.bbclass b/classes/delta-update.bbclass
> new file mode 100644
> index 0000000..cc95274
> --- /dev/null
> +++ b/classes/delta-update.bbclass
> @@ -0,0 +1,102 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2024
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +IMAGER_INSTALL:delta_update .= " zchunk rdiff"
> +
> +FILESEXTRAPATHS:prepend = "${TOPDIR}/previous-image:"
> +
> +DELTA_UPDATE_TYPE ??= ""
> +DELTA_RDIFF_REF_IMAGE ??= ""
> +DELTA_ZCK_URL ??= ""
> +DELTA_PREV_IMAGE_PATH ??= "${TOPDIR}/previous-image"
> +
> +def disable_delta_update_tasks (d):
> +    d.appendVarFlag("do_image_delta_update", "noexec", "1")
> +    d.setVar("DELTA_UPDATE_TYPE", "")
> +
> +python () {
> +    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
> +        if d.getVar("DELTA_RDIFF_REF_IMAGE") == "":
> +            disable_delta_update_tasks(d)

Why this line...

> +            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")

...when we fail completely here?

> +    elif d.getVar("DELTA_UPDATE_TYPE") == "zchunk":
> +        if d.getVar("BASE_DISTRO_CODENAME") != "sid":
> +            disable_delta_update_tasks(d)
> +            bb.fatal("Zchunk based delta update is only supported from sid")
> +    else:
> +        disable_delta_update_tasks(d)
> +
> +}
> +
> +python do_fetch_delta_rdiff_ref_image () {
> +    if d.getVar("DELTA_UPDATE_TYPE") == "rdiff":
> +        path = d.getVar("DELTA_PREV_IMAGE_PATH") + "/" + d.getVar("DELTA_RDIFF_REF_IMAGE")
> +        if not os.path.isfile(path):
> +            bb.fatal("You must set DELTA_RDIFF_REF_IMAGE and provide the required files as artifacts to this recipe")

Please print the path so that users can double-check it with what the
provided (I confused the ending in one try already).

> +        else:
> +            d.appendVar("SRC_URI", " file://" + d.getVar("DELTA_RDIFF_REF_IMAGE"))
> +}
> +
> +do_fetch[prefuncs] += "do_fetch_delta_rdiff_ref_image"
> +do_unpack[prefuncs] += "do_fetch_delta_rdiff_ref_image"
> +
> +create_rdiff_delta_artifact() {
> +    rm -f ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta
> +    # create signature file with rdiff
> +    ${SUDO_CHROOT} /usr/bin/rdiff signature ${WORKDIR}/${DELTA_RDIFF_REF_IMAGE} \
> +        ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig
> +
> +    # create delta file with the signature file
> +    ${SUDO_CHROOT} /usr/bin/rdiff delta ${WORKDIR}/delta_interim_artifacts/old-image-rootfs.sig \
> +        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE} ${PP_DEPLOY}/${IMAGE_FULLNAME}.delta
> +
> +    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.delta
> +
> +    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> +    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +}
> +
> +create_zchunk_delta_artifact() {
> +    # Create .zck file
> +    ${SUDO_CHROOT} /bin/zck \
> +        --output ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck \
> +        -u --chunk-hash-type sha256 \
> +        ${PP_DEPLOY}/${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}
> +
> +    # Calculate size of zck header
> +    HSIZE="$(${SUDO_CHROOT} /bin/zck_read_header -v ${PP_DEPLOY}/${IMAGE_FULLNAME}.zck | grep "Header size" | cut -d ':' -f 2)"
> +
> +    # Extract the zck header
> +    ${SUDO_CHROOT} /bin/dd if="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck of="${PP_DEPLOY}/${IMAGE_FULLNAME}".zck.header bs=1 count="$HSIZE" status=none
> +
> +    DELTA_ARTIFACT_SWU=${IMAGE_FULLNAME}.zck.header
> +
> +    # create a symbolic link as IMAGE_CMD expects a *.delta_update file in deploy image directory
> +    ln -sf ${DELTA_ARTIFACT_SWU} ${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.delta_update
> +}
> +
> +do_image_delta_update[cleandirs] += "${WORKDIR}/delta_interim_artifacts"
> +do_image_delta_update[depends] += "${PN}:do_transform_template"
> +IMAGE_CMD:delta_update() {
> +    case "${DELTA_UPDATE_TYPE}" in
> +    "rdiff")
> +        create_rdiff_delta_artifact
> +        ;;
> +    "zchunk")
> +        create_zchunk_delta_artifact
> +        ;;
> +    *)
> +        bbfatal "You must set a valid DELTA_UPDATE_TYPE (rdiff/zchunk)"
> +        ;;
> +    esac
> +}
> +
> +addtask do_image_delta_update before do_image_swu after do_image_wic
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 6198e1b..c652a61 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -23,5 +23,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
>  LAYERDIR_cip-core = "${LAYERDIR}"
>  LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>  
> -IMAGE_CLASSES += "squashfs verity swupdate"
> +IMAGE_CLASSES += "squashfs verity swupdate delta-update"
>  
> diff --git a/kas/opt/delta-update.yml b/kas/opt/delta-update.yml
> new file mode 100644
> index 0000000..a2f583c
> --- /dev/null
> +++ b/kas/opt/delta-update.yml
> @@ -0,0 +1,20 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2024
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  delta-update: |
> +    IMAGE_FSTYPES:append = " delta_update"
> +    DELTA_UPDATE_TYPE = "rdiff"
> +    DELTA_RDIFF_REF_IMAGE = "${IMAGE_FULLNAME}.${SWU_ROOTFS_TYPE}"
> +    DELTA_ZCK_URL = ""

Jan

-- 
Siemens AG, Technology
Linux Expert Center


