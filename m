Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9578C3ABAA
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 10:02:17 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.54])
 by mx.groups.io with SMTP id smtpd.web11.15608.1746180136561077945
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 03:02:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OjzxtqUW;
 spf=pass (domain: siemens.com, ip: 40.107.159.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoCZmMw8b6ZLnM5fT4ygJIPyURrw+oMhw9v8SMw92mwdfkOZ31mnmQ96i/XXZDnNjyVwxJPPLwfn4KFkmfsM83aClNZoN6bPEF7Q8iDNJ4K5OF/lx3O2vHHivmi9wCit8D4IL/rM+IheMxkc/5s8yT612GEGVAJTS3Gb2GGW4AJoHqb83U+42t1CtSJvZ53diHvXw548F7wilqf+32gZtafNlC4gguY1QOFWGY8dIzAF41coHQM5UUwt95gPIbJzn/PDtaRw0lOv4Kf+r8CNMJTrPOp7S8K8+4G8oAfMJbKFcVtOZa5rV7ytTiLHij3vFyWG35EJdYbO5oVumw7/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgYYmTjP2o6mqBoRtl7eLOIDI2Si5ayU60ARc0sbYas=;
 b=llGjgylctMmwg/WGRd1MD+zZu9tNe0J4P9nDBGhht70trCnWwbDhBB0iHtljjn2k8l6Lj5Zr/05rOcbGg9s1aO/Omrj4ruQTwhPF6He9ByGgzwGMd/N79dfUV1NXghWfwf46IiMJNl6VpVs+RAqtm0laCftkW2TmT8T4R0OXGSlRKdLHfWY5zVVEDeaI/INoDl0EMKQH8M/USPTepODft6DWrWGsRW7+Ii/D3coUjPwLDwMdzzx/EkCuLDMZvJHyxCj2r/j0D+YOkZZoUVAkQgMkN3Y073wjAHAmEO00aZcweLO4ZiiLGn96lQK5C+97X6WwaU+P+sCKkJR5CcEwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgYYmTjP2o6mqBoRtl7eLOIDI2Si5ayU60ARc0sbYas=;
 b=OjzxtqUWlHy2+RZO5NBh2bEE7zwSJp1HFk5FJ4p7Z+jipdu1CIYGFziYcFnDpUcjvitzPREV+tegXkpipMl+7qZBT+FyJW+ITE1X5M1Z1XnHQRPtPkUS9yKSCsyw8tx3sEBVhlishC6U6BP4cy+Lm9JzZ3y348FvTCa7NhxNqUEq84HOfNlA6lXyh9b/8574xOdR6zSZ61YW3AJ2TjTZ+w9lMPI08oz6vT9Aq+ZvStPSKvX8qafc/GumYhTYK19dbhP1mrwKNUivNjff6pVH+SOfRIpLsLxSqtnS01k2NuFfhKA1jCVCL9rGiod37Q8qfMmpqtNq/ajzM3aKWqT0GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.37; Fri, 2 May
 2025 10:02:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 10:02:12 +0000
Message-ID: <4d71892d-54fc-445c-8960-6d1a8edb1729@siemens.com>
Date: Fri, 2 May 2025 12:02:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 0/3] Enable secure boot keys mismatch
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f8105e-b21d-4cd3-af0d-08dd896068d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUpuZlFGZDFsK05sZVRsS0tKWGY4WUlIRVlaWDRrTVNXQTVWU1pYSHdSdTJo?=
 =?utf-8?B?QkpKQ2duTDZJbzcyMjNPNTB3MHFtK0FKYit2TTdDZTBaR0FINXB0TWR1dzc0?=
 =?utf-8?B?T05ZUzZHNmZhclZCVVhQTllWc1RhVXVDY28wYjk5Z0hpeGVUNjhBRkdtdXNa?=
 =?utf-8?B?ZlJWZGZiTVJlWEJwUGoreHNhSWIvbldiQko4Nmd6MnZlb3oxR2JmTXRaNmF0?=
 =?utf-8?B?UUxJTnBOd3JMam91L0QvZ3AySHBGRTBxeGpNRWMyK3JWVmtML1pYYWlUOU4x?=
 =?utf-8?B?SGdPUmJWT3NpZ3U2RDZZTStVYncvWTdCWk5VS0VqVmJPWkQxOFExU0RnTlNO?=
 =?utf-8?B?dUlpNGdkYTNPY0VBNlRBeXcyVUxEZ3c4cHhkTEt3VkxOWHMvOHhIWlZBbEI5?=
 =?utf-8?B?QndwV3hzT2hDcnlVY1NXV3BIbWw1MVdpQVcwMjI0V2JQamI4ZkRUaG5OVFRh?=
 =?utf-8?B?RHU1NWRUZnlpTjVVTnZ2WWlUdmhJWjQwM0RuaDN4YXVmUldldEhKQU1xT1do?=
 =?utf-8?B?M3lkWHlaUWRwOGJRUXRoaVladjVNR2RHQm1lM3g0Y2kxbGtwbllRYWZkclY3?=
 =?utf-8?B?WWJyZDhJbE5VZHBxVjJra2FnV2xmaWJxSmcrVHh4SEtiNW1meTNyQ2wrWFF4?=
 =?utf-8?B?VmEvOUhnckJsQWdzODRrZnhCa2pEUXUrTW8raGdZYld3ZjNKUERTZFlBeDlJ?=
 =?utf-8?B?SzJKSm82YmRoQUNXU1NzNzlWZVpVNjRsWVNFY2FGZEgyNXNVZ0hXVUJxa0dn?=
 =?utf-8?B?UWRSYUdHSEFCQk9uQkgybVk2UjJrS1ZyYlpDTy9zZUFQWEh0S1Z4ZnV0d2pY?=
 =?utf-8?B?aWR1WXZlckdSb1ZaRVBmNnFWeE43NkNEV1lRQ2tCaGFpTjJNbGJaSzIrK05o?=
 =?utf-8?B?VWpaaFl6cFpvb3dpbGdXRVhxQk9zM3lPcGxMLzZPaDR0L0FyaEpIRHZ2V2dR?=
 =?utf-8?B?bi9aWlVNZEhXS1BFbVR3NWhON1V1bkZsb2l1dk8vYVNocm1QVWRkVFoyWUUz?=
 =?utf-8?B?RDB0c1pjOVl4M3ZWeHdIMXFxM1hhMmt4U3BXaTN6SDk1NWxobW1aVlNVd3No?=
 =?utf-8?B?NlVGWDlHZmdRL3ZBTTdKRHZnNTVjWXV2ZDZ0eHNtcFBxWVFWcmIrSnNGa1cy?=
 =?utf-8?B?a0dXQzJaenZwUFdSQUoyU0l2MEdFUXVzWmdiVUx0emhBMVN2U1FiRDlpQ0Qw?=
 =?utf-8?B?S3M5REdNMXBzY3B1SFNOL3FhM2UrM2dBcFRCM2dpM2d6RlFuZ0M0cEFBeGtZ?=
 =?utf-8?B?TU1DKzhPTDU5VjRzeitpV3BIWWU2UXlxVDM2QUt4dUNMQmtTaXZRcDExeFNW?=
 =?utf-8?B?dGovTU1hSnNvQ1pGdDRFdkNKOHRlOG9kOERZWVhnSlJBdy9FL1dvUmVtTTBj?=
 =?utf-8?B?ZFN2a2djY2ljdjU2bnI4TlBzbHgyWVdYTmxrT2hEa2t1dm4rczNxazdhSUx1?=
 =?utf-8?B?OVV6dEsvcHNibHk3emdMeXVTQW5vY29ZQzNWSWFUWUQ5UTMyYU03VDN5V0hL?=
 =?utf-8?B?b0lQSVNON3JrYmJ4VjdMbTZudjkwN251dis1d0F5M1RKRksxTldqdmFBVlh4?=
 =?utf-8?B?cDA1RWNaZDdhVExiZW5ESDlvZjJDeXdXcG01OE1IQ01VdGtDaWV2T2VlaXRp?=
 =?utf-8?B?Z1JLTUUzbzZXb3hQaFhEb3dGSlJ6MnA1T3JQLzZWNjIwbnpNVUZ2U2QrWk82?=
 =?utf-8?B?cVhEbVlOT043YWYxdnFDMEdyeHp6VU1heDVsVkJYVitLdFROaFMycFdkSUZi?=
 =?utf-8?B?NkRteFRNRFdqN1Y0UmpNWlV5NmM3Sy9xdGRnVlJ0amdmTGd2Z1hyTjFFS21F?=
 =?utf-8?B?K2hNSWhJZEdiN2VvcWF5TkhBWGlNaldxdjBpaGlEbFVkT1JFd1Zhb1Btb1lK?=
 =?utf-8?B?d1pocXNJRTJDUm1MaW0yYWJLR0NvaExXL0ZTcG4xMHN2ekw1enlXTWVkc09n?=
 =?utf-8?Q?SNip4NXWmEw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Kysvb1dsTU5Yb2E5Z3lueGM5WU9vNVJ2UGR1STQvM2x0dXR5bGw0SXRlOHc3?=
 =?utf-8?B?YXJHUlJMYmRzU1NIVENWR1ozamI0c0hyZ2JJRWFBVWdiR1pkMHZVZ0x0Q2do?=
 =?utf-8?B?U0lXekliZlhHZU42d1dKS3BqQm1DRjJDYnVuV2RaclJLNEdRMi9qbTdrb202?=
 =?utf-8?B?aVRWeE9UdHZ0elJRay9Na05IclIvcWtmd3hHRHVQQXIxVUFLYXdiQnRPcUkw?=
 =?utf-8?B?aUJ5MnQ3YnJWd3Voa0FBbEVsdlZlRG9XL0NGWGthQXF1enB6ak9xZjVZZWhI?=
 =?utf-8?B?V2NwdFdCODhjOVFvQXIzaHlBY2NtcCt3OU03ZVZnaWdmeGdnQlNPaTNEb0p2?=
 =?utf-8?B?aGFHaDlKMHNYYVY2bmJ1UVpuZm5PbWgwOFNLZVU1MEs4RXQySitTUi93M1ZN?=
 =?utf-8?B?OUtGY1ZvR3lKOHRTYm16dGNrUzJqRXExMkJZSVVMT3ZOV3JsVDNFT1c2MnM2?=
 =?utf-8?B?YjZXYjJHYnB2am52SHV6SjhUdU9TM0VXc3B0ZWxLU3dBT0RnejJvQTNFS01E?=
 =?utf-8?B?bXdyTnoxcEwrbndGVWEzemF2QndZUlYrZTJmNStmOCtvUjNXRGczNU9BTnpN?=
 =?utf-8?B?am5KOXFIMVRmTzJCWU9FaGpSWVM4Z081K3NZRnFVdWFpYjNUVGRkMExGZWNY?=
 =?utf-8?B?V1F2anFpWkFGTEN1WVdmV1o3RlRNZ0hxVkhBRVJZK2huM2Q1Y09VWDQxcjFv?=
 =?utf-8?B?dXltYUhQKzhxbWh6Z0FmS2U0UzV3REdoTGJmVVhyYnV6M0V5aW9aYk5GQm9t?=
 =?utf-8?B?N3hYOWpFVkVSaWt1bmNMempMeUpRTHBSb1MwTWxsazNvWFJ1U0RTSFlDUmpr?=
 =?utf-8?B?Mm1yZmMxWTUrMmdVdU9Oc0k0ODAyOEplUGhOZnBETGhNN0JhSEpRUFFzVnhK?=
 =?utf-8?B?VURUd2prRVd6TE85ZGJIb0FhY252VnBOUFd4N3h1WFVVblBnandDd2tJTHVR?=
 =?utf-8?B?TDhyL3I3N0p5aFNiTDQ0OFRxSUNNYlBHdGs5bkcvbXpkREpManlNMTJ2aHFi?=
 =?utf-8?B?L29YZDdzWU1qbVB5RWxvczZ2Tks4dStQcktZYWpzQVpxK2xnY1hmVDdyRmRs?=
 =?utf-8?B?VWlzMklydlVXRloydGRaSXdxQklscjFneUtYL3oxNTg0c3JuakNQdUZRU1BP?=
 =?utf-8?B?b3NMaGlZSWNWTUg2RHNaRVdUT01YSkpheGdXTm1MYklhRm9DUnFQN20yL3Z2?=
 =?utf-8?B?RjdvbDFISUtOREVLY3dZcTl5a0hsV1Y5SHdVNTd4ZTVjL2VlcXNvbUpPS2d4?=
 =?utf-8?B?RlpycVNqSG1UdEpKSmdNZWRJejdxRHlOSHBFc2RZMG1seDNMeVRsYXRxUjls?=
 =?utf-8?B?S1l0djRqQ1hWbFpFdTVpTVBCMDZXMXdnZFp1WUR6S3VIaXZSK214elJqcVlR?=
 =?utf-8?B?Smh6Y1ZmZDJtUTRwZjRGV0ZZcU5WUkRGYmc0ZUJGTXJjWTNMOXlWYlFLSjA5?=
 =?utf-8?B?cDMxSjVGY0tINnlqalFwclpNa3FWVDVzdzdSbFdyWGp2WHg0alQvSlVUSGZr?=
 =?utf-8?B?dExnTy9ham8rR0lVd1hwdFE4bWhEOVJFOG9xcHBVSUZJa0tWYjdON0lrRngx?=
 =?utf-8?B?Q1FySVBiWExuakhreVVGbWl1S0VVVGtNWjdBd2M1cG5KZmRqSlNldzNjMnN5?=
 =?utf-8?B?bElQRi9FM3BtVFh0aTlNK25iKzdlU2tIeEMyekFKa3g4cXNtblE1OURZaVpl?=
 =?utf-8?B?L1JXOWZPODFZdmVac3JySEJrSnhDZzF4Z3JxK0ovMVhOQmhuSXpmN1grYXpV?=
 =?utf-8?B?Zk03VVhXQWx3Uk5Jb3dJeVl0UEt6cUJ2K3VRNkNCSnpRekhnYTMzNVJzT21q?=
 =?utf-8?B?L2JkUXhJRm55NXJMU3JWc0FPLzlUSHVNK0pneGpCdGtFQWNFcVRYT0JNUXdx?=
 =?utf-8?B?TW5uNGtxQjJlak5BM3ZacDBsR3pMS0dJcERMQVVMdzRGM1JDajZKVG5RRS9a?=
 =?utf-8?B?b05JZmlXOGNKTHdNWDJrZE1ybUdEQ3E1MWtLY0dzRHVhU0ZPUzAvWjAvZ0xz?=
 =?utf-8?B?NkJacFBhVXZQQ0JSRS82U1B0elpMbFA4WDBaQkpSWndqT3lSUVByb2JWcXYx?=
 =?utf-8?B?TlhwTVdSTEgrb2RUYnhoQk80TDNtVWlqUDZOVkg1aVVXUDV5dExQMDhqQnFD?=
 =?utf-8?Q?y688Ax0JxVVqn6Wn3htku/9Ds?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f8105e-b21d-4cd3-af0d-08dd896068d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 10:02:12.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7O2y/vvpJ36vMFcdcLxgFWqjIIudDhBJLA5wMK5XmuRTHG2LuVPRHgqtaep19OEKucC0pUh9Z4bZ3hK5cimdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 10:02:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18756

On 29.04.25 06:20, Shivanand Kunijadar wrote:
> This patch series enables the secure boot keys mismatch scenario for
> amd64 architecture.
> In secure boot, the artifacts are signed using disto specific snakeoil keys. 
> In this scenario, trixie version of OVMF keys are used to verify the artifacts 
> which are signed using bookworm snakeoil keys during the build.
> 
> Shivanand Kunijadar (3):
>   submit_lava.sh: Update script to prepare job for amd64 secure boot
>     keys mismatch case
>   scripts/submit_lava.sh: Remove passing readonly=on for amd64 OVMF VARS
>     file
>   .gitlab-ci.yml: Add job to verify amd64 secure boot keys mismatch case
> 
>  .gitlab-ci.yml         |  8 ++++++++
>  scripts/submit_lava.sh | 16 +++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 

Thanks, applied. I've improved the commit message of patch 2 along that.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

