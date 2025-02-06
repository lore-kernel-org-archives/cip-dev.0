Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA13C02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 13:20:05 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.69])
 by mx.groups.io with SMTP id smtpd.web11.40761.1738848001700225125
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 05:20:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z+yvnfgN;
 spf=pass (domain: siemens.com, ip: 40.107.104.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M91l6T6IeYHeeYmuUV+cCWVvdOa6dskumEJcw3E+gIiJExrHlH7qlCnQdpd8RJeginnB/MvUGknkJEC+W/MEDzkb7Ss7Jb2DXo/ZeDTjLndFUrvJ4eBbDMFSgmPtRv0s8EUbbMJgzt+bpLDF25N+f92gGy3PyauPEdciRD5guK75XoK0hCZECH19bncXB6wlqgMbGq8MsS33LMigXHNfHuHaZOZSa4NZ3weV+jxH5JrOWZGEET79in4XrkcgvXcytSOpG7cxc2ECA6EXLncl3353eNhfMtx95Fo+zwEzMMaUiBCipviJmZJvJKycSy8FkiYW6Sceh32vJPYBcYG45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz4HAJal39GY74UDT9Wi1FfO1WSrBAe75VfHRR5gwr0=;
 b=ILkHmnZqc15y8oQXZP75xpaM5zmoPv81YLuXX3iSrOn7aKEhEkygA11RbKKln9qN8U5jwPrbTEqKvggmQXt7ZjtPGt6u7ZpOI0JUW7usNfE5HPuCzR1v85zyS4s0TuMFqvNS7EivlTubBfTb750fDJUMH3rSXfT0vZv3tLnw3R7zd+oomqapYSge7MUyUFm/JBlLjZyJUmVPR7dw0Ze+aIeQLb64Y0Vbk8Nm1pNoDa8IHQaJuT6smpfgUboM38yN8SPhccDDQtyBUmnV9RvFadweDpFsSYU0avphSntwF/VSl0L2YS2D72Nl5tqzRaDSF/d0x2hs6jnaERLLZOlv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz4HAJal39GY74UDT9Wi1FfO1WSrBAe75VfHRR5gwr0=;
 b=Z+yvnfgNaCX+8Tb8r2eEhc/mTDZcmFzE60MV1M+XzTzDotVVu4mNFzvp4G51PrkVsxC3etfgAzJxVCnFrfGnE7eMDwmEbV0eNU4h03HX3dghaSJ0FNNFrGojx+oVV0li4MyYLFL7Aw2oEx2lTWDPuToCNNwalqV9Ji/yCrWzWteJ7YxVwcQSmcpubJeQODszY4WLH37f50T3/QXdsNPRzOvy8bKM0DxOs04S1248NWDI9c0Fc0v+nziiNa+DoWkAcWlQwEltyfuwxd7rFkBPEGm9Qa8HM0+3C0IkeBDZSa1yjhPoh8qvSRy6sS+fwplM+lbp+2bVYiEZP1fAN/VIlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.6; Thu, 6 Feb
 2025 13:19:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 13:19:58 +0000
Message-ID: <a678e64e-43e7-4b54-aedf-030bfb1ba5c3@siemens.com>
Date: Thu, 6 Feb 2025 14:19:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cip-kernel-config: Update to latest version
To: Michael Adler <michael.adler@siemens.com>, cip-dev@lists.cip-project.org
References: <20250206125655.164793-1-michael.adler@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250206125655.164793-1-michael.adler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 952f49cc-2fd8-4310-c671-08dd46b0f408
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHRUQWVRMno2RzRXTG5qVWFCRENNeUlIdW5mZnVKdjh6Yk1xb0h2M1RkbUd5?=
 =?utf-8?B?MUFQSFFycGw3VHRhck9wNEM1QmxNL2RCd1RiRHBnQnoydVlBZlc5WnJFWW9r?=
 =?utf-8?B?ZWg0QXJPY0srS1Nwa2hJNDFXZ1htQ3ZhQUUxYXlobmpuSy80MzIxbVF1eXBF?=
 =?utf-8?B?Y25OVXB3dU5FZlBUQVI0UFJOVTNnNm4xaWdpcnk4dno3ZzhzNWZTWUl4N3h4?=
 =?utf-8?B?d0lDTWkvMzFaRkEreWNIOG5QTW1SNFgyUmhTUjZONUg1RnpYcTZHTzBIUVNn?=
 =?utf-8?B?N2E3UzNFU0kydFRLYk5mdG0rbC9OSWxqTTIvc2QzaDh5amk0dU9RZHNLU09a?=
 =?utf-8?B?TlVsTVNUelNkZWN1UjJNa2t0RXZZUkdDVVBjdDhmVUFPVUlsTWFjamFtMUdQ?=
 =?utf-8?B?SEpRWjlnL0IyNmlDbjRBL0RaYjhEVWVKVXlYN3lJMWRPaDl3T09BUlAyQ3Ux?=
 =?utf-8?B?QmxpRW5nZ1VXd3E1amxQb1VIOFZGUW9TanJkTlZtUjRiTFVCaWZwZDIwY1B0?=
 =?utf-8?B?T000UW5YdmY0NGNqdXhoMXprWUhVZTlqVlNkbDA1andjbjJ0cE9mamE1VmJk?=
 =?utf-8?B?RnpXVzV2ZndrWFhGeC9BSE00c0MwL2FHQUtZWkZRaXkzOWZHZ1RXZXAxeGpB?=
 =?utf-8?B?YkhFMkhhSC9uOXhRcllLdWlPc3J1Z3dMVDgxb2ZxOU1zMGJyNTlaVUZWTXY4?=
 =?utf-8?B?YWo3eTJxRWdHYWNRWkllUU9MTHlPTlJGSjBOUVBkdWdBQVQxWThTTHBpNFo2?=
 =?utf-8?B?VXF5dVR4ZVRia1VsdkpqcVlqVS9mVkVwWHk0U1FNNjZZeng4aGVWeTNQR041?=
 =?utf-8?B?REFwM29EYW8vWk5wa0thMHpZYzhPdVVzNWFkYW41cWRESU56ZGltRVNBcUhZ?=
 =?utf-8?B?WVBhcVBqQWtiWVFvVUphQ0tsbUpUR1VSWnBLRm9RQ1gxQXd0VUwyRHdxL1Qz?=
 =?utf-8?B?NytKUjYzdkQwYXo5T3N0NVo1MkdWZ2h0NENzQmhzeHlLaStsbnU1eUhLeXdQ?=
 =?utf-8?B?M21yRG1XUlAyZGF3L2FpQmQyMGdxRWltdUk0QTZldFRLQ25RdUh1N29kRVhz?=
 =?utf-8?B?VHU5eHhvQ3ljUWdkeUdZWVBYTXBhS2JMamgwb2hrOFR5dFV4MTlaNFdSbTZF?=
 =?utf-8?B?MDZHNWdIeHFlSnZ5NWwyY3VUenBZTTVJdkdydG9ETXUwRDBFWERtTmYyNlNY?=
 =?utf-8?B?YTd3R3Z1cnlEdGFtUHFOR1lRMlNxMXQwZ25PYUJvNy9kYkdUaE1FYXBKS3Jr?=
 =?utf-8?B?ZVVvSVRCUkZMRytmWmwrZlgzay91b1Z0aCtOZndPRmRMcHVRdyt3d1UrTnlq?=
 =?utf-8?B?dkJnZVV4SkV1SjFBaVhvMmpqRk1HSFNYdGY0WmNuY3BYWkdTRXQwNWR4L1A4?=
 =?utf-8?B?aXFhWjdPSEpuSFkvNzFEdXVEdno2c1RQdXlJUWpvY0pYZGoxUDVCNTA1ZzhN?=
 =?utf-8?B?aVN6Ukw4UjV3dFN1K080Z3BOQzY4ZTNvSmRlcGxYTW9mQjRNNHRKZEpFRWMx?=
 =?utf-8?B?ZjE3SENnY0RHUFVwTFdCQjRSaVZtOS8zT1hsU2FjS3pQN2IyYms0ZTdPUEpt?=
 =?utf-8?B?cEhMS1o3WkkrRmtmZ1lDNGtHQXJnMFUyeWszN2VzQktpekc0dXBDb2pvVktr?=
 =?utf-8?B?eXZhb3F6Ny8zTVhzMUlLbGRHWlVDUENHREo0N2RBc1p1MFgxbFlaWERMSE9s?=
 =?utf-8?B?aWRRcHpIdHl0b25OZFdYQ2s4Z0RaZndzbTQwY3BVM0RhSGZ6U3NMUEgrNVg4?=
 =?utf-8?B?ZXdhZUdrVWlrOXBheFFMQm03K01XVitqb3NOOHUraStGMTFXRWJsNDBjdzRK?=
 =?utf-8?B?OHY4QWJSVUJBZ0lzeFRNWGZtNDUwSDlhMm83aW5rVCtGWFFZZXQwRzM3MzZO?=
 =?utf-8?Q?Bw9hLYsvvyhFh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXZZVklQSXljR0VYSTFmNDlyWCtTZ2ZMWjBOaXZ5dWVUL1h3OWFwdXYyTWJF?=
 =?utf-8?B?d21QQ0VuWEFzd0cwNXI0a0d4eEdwK3k0ZU1RaXo4ZG1XSnU1djZqeFg1Rzh0?=
 =?utf-8?B?S0ppZSt1ZE5mTmFqYVZDSytNU3EvSHk0MXU0YmNMdHV0YkIzUS82Rmx4Lzl3?=
 =?utf-8?B?Smk2dXVjaDgzOHdad08rSzQvNUF1dzM2MVUyNDdQbHRiRmxkb0VHaXNyODZC?=
 =?utf-8?B?am5xNEsxaGhxclUvMkkyamFmd3dqdXk0TmJNTTRVV2ZVUGZtMmxXZmNNRGFD?=
 =?utf-8?B?Y2sydHEzbDRMSnN3N0xxemp0eFp4aGNybXJsMDBMcnRTM2VtOXE1WkVHN3Rx?=
 =?utf-8?B?ZkZEN21CbHJTT2VJUnFSWEIyWDFOS0dJckdUd1EzS2tLRHk2NHpZeGlrTzEx?=
 =?utf-8?B?NmRXSlNtWGlDcWRtdzRqQUVHVUpNWjZ4OEJ0b0lTcklURHdZOTZiRzBPd2lv?=
 =?utf-8?B?Q0I4Y0lEblJ0S2wxOFpQb1UwOEJsYUNHRlpJY05JY0EyWnVPcU1lM3F6aTZD?=
 =?utf-8?B?N1RocE41YWxyTHlLVi85eWdPN3A3R3UzL1A4dTFjTnZJMHNEMFpReHVGQnJ0?=
 =?utf-8?B?eXZiZHY1ZVNaZ1FOWng2YW9VQnVYb1JUbnFkVmpLckhZdmVFMmoxWjF1blV6?=
 =?utf-8?B?T3JCcVpVYUVERVZhblpvTTVvOFNRQ1NKdWRQclY3clROSVNOMzJZYU9mNU5P?=
 =?utf-8?B?YU15Q3ZvTTg5SHJIVWt5WTVVbUl2bnB2ckxHYStYRzdwZVhoZGRCdDBDT3gx?=
 =?utf-8?B?OGlMcjEvTkx2OXp4SkN0TElPS2JpbUk3b09FR2taQ2xVNGFVdGVMcmNsUzJ3?=
 =?utf-8?B?VHd1YkY5QmpmT25EWi9pbjRibXpQZUNTMGoxa1lmQmorbGt1UjAwSGdZWjEx?=
 =?utf-8?B?UjlmbVExbWxKT0hHYzcrS1I1eXZYSmxoZ09CUURmWlVSVk52R0V3RXNHR1l4?=
 =?utf-8?B?YnlzR24ybHovVmkzSzNJOXdDWjBub1ZPT05PZ0VXMnNKRUFhZTFxcW9vSkxF?=
 =?utf-8?B?WllUWE1KM2xvMVBtVUtMUCtUMExMZjQxUVIxUTFYWXhiN2wwSnoycUt1NTZo?=
 =?utf-8?B?dHBSYS9ZUlRqWGs4akYrTktTa0xKT3k4ejZBb2Z1U0x5ODBxc1ZKM2pvRkY3?=
 =?utf-8?B?Q1JKcFZlenE5WG5aQlRzYitpbzMrYTk0Z1FHc0xtRGpRc0YyNGFHQkRFL3Y3?=
 =?utf-8?B?Q1N5Z0pyaEpWdWx3Zkw0QmE1WUh1aDIzRERkT0NZZnUvV0paTU04QmZwUkNS?=
 =?utf-8?B?U2NOR0JCbmxaMXhPK0VHeWhOQkF1ZDNlVmE5TkVsVFFZcUhLc3orbis5dk5M?=
 =?utf-8?B?WEtPQlkzSVQ5Q08rbkxKRzF6OVhzMGt0MEpINERoY0g5b2ZRUG5uNmwyT25y?=
 =?utf-8?B?dWs1Q2h4R3VhcE1LeUorZzlRQzRQTVN0cWtrbkNVRUxoZUJIYkhGQkRXQ09t?=
 =?utf-8?B?OTFXcjFPdTY5TkpvWVZIQWNxZVUwMnBOV1Z3eXhIZFRmTlV4WEl2TFQxYkVC?=
 =?utf-8?B?bTRtZEMzQVBjQ2VBODVkRnBPeHNIWmdjRDgvS3Y4RSs2MXQ4NVVlbWtpc0R1?=
 =?utf-8?B?c2JJa0NRSmN3a2ZPbi92Z1djZWZWeEN2NWNJWWJYSmY1M3BXaERRYzlrZjQ2?=
 =?utf-8?B?ZnRCOVUxNVlxb08zalJPQmNITjhVdWxMdktJbnAzYWxBUnYxRzh6NFFzdk1v?=
 =?utf-8?B?NkFteUMvU0ZhcTFMTWZRZ1dlRUMvamZwakQxVGVTWXBkbitRaDNYUjBTemhD?=
 =?utf-8?B?K0h6SEFrczVmUTJxem8wem1JcGk5bEZHb25PVVhIaXdVMFQ4VHZXcmQ5bDdq?=
 =?utf-8?B?NzllMG9YKzh6UzNrcmZ0aElqeUNORGtHTFBYRmgrWWpxcGRvcTB6QitBU3o1?=
 =?utf-8?B?YzBHcVordlhJOHdtcjZOOXYrbXJ3cGp6L3FjcTZtSDdDaitrdytmSUJ1N0Zx?=
 =?utf-8?B?cTZpbGYreTZWUEJjRVBIZDZCL01pMGVWdUg2TS85b3RYZUUrYkIweW42RUxo?=
 =?utf-8?B?RnJDL0doUmMwbmY3dWRRQk5LOGJTWGZwWE1hT2svWkozdWdpaWNkK0Q2N1dT?=
 =?utf-8?B?MnhUTGkxR2ZBTS9xbU9UaHVWYlpiR2hqZmZNeWJOdnlUUldMOVB4ZGJlR0Vx?=
 =?utf-8?Q?DFMTf0Jz6hMSeRseDETvvUeZQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952f49cc-2fd8-4310-c671-08dd46b0f408
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:19:58.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi3APrOpVmvzvue5ZfSO60fClaOBXVRyFbhTA7gC7dCsTUX+zj59ovIpQ8eiUjhSCkuy1BSypiHwLyssS2WreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9182
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Feb 2025 13:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17762

On 06.02.25 13:56, Michael Adler wrote:
> Enhances support for container engines (e.g., Docker) on arm64 and x86
> architectures.

...for 6.1 kernels. Thanks, applied with this hint folded in.

Jan

> 
> Signed-off-by: Michael Adler <michael.adler@siemens.com>
> ---
>  recipes-kernel/linux/cip-kernel-config.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
> index d26ff3f..53bee8f 100644
> --- a/recipes-kernel/linux/cip-kernel-config.inc
> +++ b/recipes-kernel/linux/cip-kernel-config.inc
> @@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> -SRCREV_cip-kernel-config ?= "b14ada5877ab5280188f3549c21891b7a830896c"
> +SRCREV_cip-kernel-config ?= "e486c93a916cb6f78b4917b7345e8818f96069f9"
>  
>  do_fetch[vardeps] += "SRCREV_cip-kernel-config"
>  

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

