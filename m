Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBFDC0218F
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 05:46:07 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.69])
 by mx.groups.io with SMTP id smtpd.web11.9765.1738215960832456320
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 21:46:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=By6SqbzD;
 spf=pass (domain: siemens.com, ip: 40.107.247.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPN+XvQNnwA8nzLf5YXxfXTvYn574OYl6YilvShY84OA4YwMUdzR+M4he5vdKCI7sAXVL4Nwh1PhR/Q2YN/2hIKea6fmATBQfOBmQrXWaWgLYIDzbT0tTALCuCiSoF/E+HdurkxdPswrhKjH/7V/bUB60bwbnXYspZ2R7QcIid8CxfMIEVjtaDaVAxR4NT8R1KvdFiVhSlvGmlgpo4TjfgSeEXA+sYZOii8wJJlFlSs956u1fLtfraW9wSs1mzIuCobRR++NAbkahBMwGduTD49ycgf1JxvIK4bGVxZO5m3oAZyzdKLsrKmtaBFQHnhFQ+IkkjtHEnelsej/ZAs+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioXJ6+RkgwZhm9eX+t/IMasdcDKntQEi3oBE+wdDEmU=;
 b=Cq9akCNxxfFPNQ3y+2Yfd7zZnWG9LpQCy8jOmVwxvSl9fkrwbSElIHBvJg/93C5vOSObJj1XYtf3kYgrHWL4wc6pgfSfVVGsjgQ9L0ebhOa7+t1mzFkIWgOvFV+78SXdo0PyMZF4fjX7NmfAIXKV5q+4y8+7fIaX0AzI6pkTW0NtVHKFHt3D1t84XJMpbqsBmooiUw0hONaoWpiwPNsjiqV1y3jEfxWyu7+f36qXarA3yQoiShF7Ep34IE7L9frLzXoy6G1fC3XfsP0gxh0xU8XcghnB1w92SI1WGq6XUdSN7p5GtESPSeM+55YXXg/DJVQ931cHrjpV5in/gQlAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioXJ6+RkgwZhm9eX+t/IMasdcDKntQEi3oBE+wdDEmU=;
 b=By6SqbzDq9wRiPnzWqF/FFdLDMtTa54/pBuplah083qWsGMrNFIQcw58QyWsGb8YjVoaC547SjPbqxoXEplnghG65If+KcumN7LkWz0jiGOjktJ32zhjLYdPBmZJhTHql5VZP5bmIsCIE6GdW+lEErd6xAzRQgim91Y9AewjXbG8Z+SbAxutEjOxou2Wr5Vr6Vo+Uw4gmgMVUxXRjxhHOSnAVISVDR9bilrMKESCiGKM87oHYJwYjXH2cxiFYh4ZsHMS4D+aEiBeAaoDakA8a7+qtNeafounpIaXBQ4IUjAMeGLYMYsPG5Dq98IvAqOnSMVlim3w3GEk49uuH3RlCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:51::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 05:45:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 05:45:56 +0000
Message-ID: <c0b3dcf6-d75f-4ed8-926b-f0385704f999@siemens.com>
Date: Thu, 30 Jan 2025 06:45:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Add check if a
 swu file is greater than 4GB
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250124162308.250651-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250124162308.250651-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a393b55-46ba-456c-1fe0-08dd40f15dd0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RTB3NHFSRXQ3K2Z0WFNyMlpOTHpvTVhoNDBxK2ZpdUxvMGwrckoveG5wdHlX?=
 =?utf-8?B?QXpFbTBaQThDQUNyWWduNDFMTUttbnViOGtrY3FlVWp0OUdoMStpN1dvZ09n?=
 =?utf-8?B?YnVJMHNneEN0YVVtSDdlSlNzZ2lzdHdFSkNiMEdMY2dVT3o5TnlyT2V0OHlN?=
 =?utf-8?B?SFd4ZnNPZDZ6QUNISis1c1hhd2JBTU5YS1pSM0RkS3R0aE54aGtIRXFEUmRl?=
 =?utf-8?B?L0drR2d5VEJMRVdMWXA5RUx0cmdYMnpaYWZteEpqRHZiMCtTdHR1RVZHOEZW?=
 =?utf-8?B?VDJBeDlMWm1XZkh0Zkc5VVkveGZ4TENJZlBiMkNiTVlrZTZiaVR0cnEwTUYy?=
 =?utf-8?B?K3B3RTJORy80SnNjLzFMTEp0NHYrMW9WcFNtKzFEYktGRlluWGVoQkg5blBC?=
 =?utf-8?B?UlJ0RE1XY2xrcGNqNWxWcUZlTS9WWXJQUHI3M29RNkZaclB5d1EzZXN4L0Rq?=
 =?utf-8?B?cDdxOFRnbWRpam1sQjFHS0NpS0pBUkx0OHhYekdnQVMzeGx0dnp6ZjVzQzFs?=
 =?utf-8?B?OWF5eW1KTG1sUnN5NC9aWDZWaHBMbUxFNTRDTkNnbFFkT0JnRzUxbFozT295?=
 =?utf-8?B?ZjUrQ2EvaGFuY0JkdGU0cm96NnhOcHFoWGZNUEVaRjR6bkQxQVp4ZkVkRDBt?=
 =?utf-8?B?b0VKaEJaemNmUkdmUjhRNWk4UGx2MTRLRFVmODNKM0xRMFNyMkpsUEdHVS9F?=
 =?utf-8?B?VFVIcHpVSHA4VmhzTWJ6eFJVajFINmtJTTZ3ZVdTOXl1dStGcDdqZU9TL0x0?=
 =?utf-8?B?Q21EY083L3h3RlkwNEtjYk9DS0EvZzZEd1ptaU52bWhuK010N3pQQklSME54?=
 =?utf-8?B?eTdVc2JOTXB0b29DZ2NOajlaVWRaZUdTaS9NTThaNzl1SUkyOFRZbHdFSHRU?=
 =?utf-8?B?ejlXTFRLZTZLMWp5N0wwZlhFZ29NRlhMNWRFTnN0Tkx3K0RETk1FZGpjaGlB?=
 =?utf-8?B?emhuWlNGVW5zVnZwdmhjUHRpem5iVzdoVjkrQjZKU2FWQ2xieTN1NUI0eFpy?=
 =?utf-8?B?NzBob3BTdGVYRSs1b3p1QzJpd2JVMUZkUVpnR21FNmNtNjQyZnozbmZqVzAy?=
 =?utf-8?B?cFlvbmNZMGxyYmFJaFl1SmxSa0NSd1dMTDMveGpGV3RBTnF3YVQxbTBiYVN6?=
 =?utf-8?B?Vm1iZ1Y0MURIWnpoOSt1UlFad3g5Sk13UzlGMVpPSElxMzYzQ25VeWgxMjI5?=
 =?utf-8?B?TlpGdDBLc1hxcXB5RFFkU3FsQkYvNGRYS21sek5oekZGdzdBd3QrTkp0NWxF?=
 =?utf-8?B?WWdMb2xIdGpsZlhZQ2o1T1Zlc3ZOa01rSWgwM2o3WVJJdTdBZjJvTHlmNGgr?=
 =?utf-8?B?c0NKYytQL0dHaUtYSHhRSE1wVndMeGU4TFFLc2NiUUsyd3Ruc1pkU0Z3ekpr?=
 =?utf-8?B?aVErcEd3SnVSNHRVWUF2c0F4a1BZa0dEd3hJM2JMZk5Oc0l3alFqTjUwTE5V?=
 =?utf-8?B?YTdWbWcyc1AySTV1UXMwalVhMG9oditZSG0zNnVkaWo4dm9LRDd3VDhILy9o?=
 =?utf-8?B?WHVSZGJWNmlTcjlVYnFtbXRIRUttNUVlUmpDdDVjRnhXVXJDVmIwWmd5Uncx?=
 =?utf-8?B?Njk4NjN6SzhFTjF4N0x5ZFRuUjM5WVpjeExwaFRGZkRCVXhXN2NhZFNpTjIv?=
 =?utf-8?B?ZGdyaWlvSkhJeWpuSkc4WGxwaG9DY1JxWDBJakJqaGl0WUdyb1V3L0QwSUdx?=
 =?utf-8?B?a2k4Rmd4ckNSYWwwZThoUGJSUFRBSzlTRHZqbG5ZWDRZaEg4Y0dKeHhzUEd5?=
 =?utf-8?B?Y0E2VDNvYUNxazFWYWVhbEp4MzhnV3ZDNWxtZWRDZFQ5S3R5aGwxZWxPc0dp?=
 =?utf-8?B?bVZzRmR6RnIzeHZxRTM4bzI2WUw5VGNkTFhnOWdXZWdFclI2cklwM0pIWmtO?=
 =?utf-8?Q?fDFub1zeui0C8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnAxUmhCYi9lQ1g1S0Y0cHlLSjBFNnYzd2Q5ZXJjSjVSNWlpdkxhQ0pMUTRH?=
 =?utf-8?B?TnNvcExVeXZtZHBQY0ZKbWh2aVhqazlkNDI4eE1wLzBTVVBEZGduVUlKSXJT?=
 =?utf-8?B?QytJekdyNXpEQjF4ZXpwTkhRc0Z2bHc3RjF5RUNYbEFrN2lkSHkwUWV4dzI4?=
 =?utf-8?B?VHRPQUFEdmtJRENnT3JqaXQzKy9WbjVTVklSWDRtNUpweGlCSFhQVzBBam5N?=
 =?utf-8?B?TTJScjBaU0tyMlRXaTVuMmpiaFd2VmNZRkI4M3c5ZWJwZlJ2QWhpYUxTeE1z?=
 =?utf-8?B?M241VU9WaEIzU0x6Tzdld2NWdFVGMG9ZR0I0YnBiQ0pPNmxkdm56YTU0K2Va?=
 =?utf-8?B?MUt1VVA5VEl6Q0piRzhQdWpoZDFhRVF3dDgrSmxtakVIM3EvazVadkFJQTRm?=
 =?utf-8?B?eXpSQnBSMEhGNFlQNk05MU5LWDBSdmVua2ljbnFNZWl0WTBxbm9MUlV0OE93?=
 =?utf-8?B?MFoyZE90eVp5WDV5V3lMVWc3c2dDR01Sd1c2V2FQb3JzenB6VTc1TENneU5M?=
 =?utf-8?B?Mk8xRXRKUjZyMmlZZFRvcGhuQUpjM3cxeUZNbTV5SzdoNDhyN05qdkhTcGow?=
 =?utf-8?B?ejVjTktEa1hUTDNmUDhMNkZaMkFsWGZpQkZlWlJ6R2xjQjNyWmgzYU1LYVFn?=
 =?utf-8?B?YXVYVFZKMk9Sd1V3RjlDLys4aUJjd1pRVWw2WkRWZzBkclY0YXFuSTdRVzJU?=
 =?utf-8?B?M1V1TzF6SkxYa2tZZ2xMbzFrU2docGxXYktGMUJDYkJDK1hlZ0w3YW9mRWQw?=
 =?utf-8?B?emNBVllUZ0ttQ2xkUXZYZ0FKYnpTT0NiL05pN2tzMWo5S2pTUTM3UnhZWURY?=
 =?utf-8?B?VldiSUh6UjRLSGc5ejNidVNsWnpvWmlNRVFOcVhqcWFIV1ZUcExuMlYzbFBL?=
 =?utf-8?B?enNNem9HYkxHaWl6aDdscFc2N2NvU1FVenAxdmxJSTRackZ0NS9BZDVkUjVo?=
 =?utf-8?B?c3laQkhRZzFvZHdrUk05N2FXeFgzbExML0gvZW1yMVpIUFc0dlRIQUtPQTRB?=
 =?utf-8?B?YkJIQjM4TE1leWNabHdxS3l5d3kxQTJmZnFDNld0SWhWa1lseGZYeE9Gbndh?=
 =?utf-8?B?VTA4T2lOcVBkbUQ5Ny9PZHJLdzVkVFY2czUxUHZpY2NmVlNGaXZkcDR4M2hT?=
 =?utf-8?B?dy9CYUM1T2xMYmRRSHdET0t6S3AyOHdLOUZYdmtWN3V4YWtIWm1CY2VWNUt6?=
 =?utf-8?B?WG5RZW5Ba1ltQ3dtQmFjak1QdWN2RzJYTHp5bzdueU9leHIvUDlxL0Y5aE5p?=
 =?utf-8?B?MzB1NmwxVHZTdkNWaW9Sa0N4OWppS3MvZTdNeWE4bTIvaUFoelpYeDZ0aFp6?=
 =?utf-8?B?KzJCS2JxUjZlUGxjTWJDazJMQjNmZ0lpRTYyb3h0K2MyUDQ1a0ZNWlUzdTNS?=
 =?utf-8?B?UUZHRmRvMzlENjRqKzNOT0lvanowWDdDSDhFRWc2bno3dHZHelJGM0MvUVQ4?=
 =?utf-8?B?VnFPZk5qRURuU3BoRXN4YkUxTHVmR0dSdVhQazliNG5jMC9ieklibnVEdzFS?=
 =?utf-8?B?Vk10L1dnWDFsa09nSythZmF4VUdJcWkwbzl6RnpVYUZ3Tm5xWWRseXF3WlhF?=
 =?utf-8?B?MmdnUnVWYTQ3UHZMd0FsQjA0NGxCMjVIRFYxSXd2andLaGpQQTNscW5QVnZi?=
 =?utf-8?B?L1JYbW52MmRJWFhYVnhQNU1iWGF0QUtudEFNTU9iZS83dlo0bS9ESHVWbGxa?=
 =?utf-8?B?NUQrUUtNRS9PbzZMMDdiT2E5bnVUVEJabWt0eWVvOHNtUjMwRFNzWlIxa3lu?=
 =?utf-8?B?Nmh2SDBGUm9kb3RkclZaVEx2ZlJKSWFXWHZIZWxaOVdWaWVrZVNSRm5mOWw2?=
 =?utf-8?B?NURJZ2htV0N0bS91MkQzSWVsd2VuWEhNVGZ4a3RGN0JMV2pOMFdVVDJaNEhv?=
 =?utf-8?B?cGlMS3JDblpiazNZNEFjWnNNNGxxeVFIbHZLelhOWTEzdjR0K0JGS05jd1dt?=
 =?utf-8?B?L0hIWmtsakxwamxCM2lqVzBYNnFOQ0I5MjJIV1hxYlBHR0FXb200dldhK2J2?=
 =?utf-8?B?cGFuZ050ekVKVVJlZ0lGcmNVcytNRmNwUE9uWFBYSVZyMVd0SnBOZDhqWStl?=
 =?utf-8?B?MDU0cjFTemRubmkvVExBZGplQUZFQ2JZRVN0UEM4cDZxSHBCVVc3aWVEcU9F?=
 =?utf-8?Q?AGKbLUF93pqkkw2MSwY/54J0K?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a393b55-46ba-456c-1fe0-08dd40f15dd0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 05:45:56.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn5ySz/nCp6wYyAE22arbMWjxHzSUcYohCnpM8m+Tb9EiNqaUe0oGBMVU5GgU8Bu6pme7sMuV+XeGmD3U/ef7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 05:46:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17682

On 24.01.25 17:22, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> 4GB is the size limit of a file in a cpio archive. cpio prints
> the following message but returns zero in that case.
> 
> ```
> value file size 10 out of allowed range 0..4294967295
> ```
> 
> The sum of files in the archive can be greater than 4GB.
> 
> This fixes Issue #125.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 3243f67..05291ee 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -247,7 +247,17 @@ IMAGE_CMD:swu() {
>                  fi
>                  cpio_files="$cpio_files $signature_file"
>              fi
> -
> +            # check if swu_files are less than 4GBytes.
> +            # This avoids the limit of cpio
> +            for swu_file in $swu_files; do
> +                file_size =$(stat -c %s "$swu_file")
> +                if [ "$file_size" -ge 4294967295 ] ; then
> +                    echo "The size of '$swu_file': '$file_size' is greater" \
> +                          "than the limit of the swu format of 4294967295" \
> +                          "Bytes per file" 1>&2
> +                    exit 1
> +                fi
> +            done
>              # sw-description must be first file in *.swu
>              for cpio_file in $cpio_files $swu_files; do
>                  if [ -f "$cpio_file" ]; then

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

