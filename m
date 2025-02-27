Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3754DC19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:42:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.79])
 by mx.groups.io with SMTP id smtpd.web10.12049.1740667368801200499
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:42:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YDx9D5OV;
 spf=pass (domain: siemens.com, ip: 40.107.21.79, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkSPKgCh7WA6/MjJ8F1nHY/n67MvmTYcyIewhuM2H6ap6a0oR1V5JRn6YiVu0MtF+0OeLnOWQPqz/Ba25c+icQG6VAwGRFzmGp7CxnHX93H+q50p425ehAbqT6Ptx3T59gF2dZ984dkJIpOBvL8Q5AlDmYwOXpxYniypkwQ1lhL+es/cRdh6HmZf96PIgr5Gnaf0xOBxlYeMMtx+ffffHaavySa70OzNyO0OEb2ar4E6QbnkNEF8fezFnzguONlBwKRPwYyVW6atmArZT8evmWpG4NrS+IR63QzuKckX8Ba6js0QjUX6t/VzQczO5KYJdXrN+/OPF6xiSjqfJ1Ppcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLZ3gTc2+kd0fBjKRDCAZC7ABWtet7R0C7GtC92cOZM=;
 b=lfNt7LnpLWM8vqHM3vf/29VF+qNJZuMeJg5Uc+twpdsdGUOyR1MyVcK0gdSxcaytqZtXm767aIQAAJGMKXsji9JPWPKrFPJsv29i5RjRE3/JcTC7eD85pX+it7AyZyFIPuSryC5Y/x8sakmO0MwafvuDuXAeTT8poNzfUG50So1bqwX7EJ7kGSpcpCKvtKUN3X8Fo5Hkam9XpqnpQz/5SfH9flFeRrxx77crd9Sh540x7yK0qjnE/8Pj/UyuT2c18qvjVrQ7vC0F4n+y+FMV5dEOq3A/f6F/8MZ4vwYyIaxLewJt4hNWY4JWUKfiEwlpsPIaTee5DVzwhEp9p0L69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLZ3gTc2+kd0fBjKRDCAZC7ABWtet7R0C7GtC92cOZM=;
 b=YDx9D5OVBK8A8JXKHuFKdTC05unMLU7ZkN7Ldhpb9WwIJ/cvDjCOoVMsVwVgNXclxXRrhzdMiEloTTFio/Q1RBITY9lLSoL/XuykMilmZk6tL538W2bdUfC20aSBReoTplqCqRTfGSnxjopbW6FsyYVT4q8O2w3jUKmbKLbWZcAgvVSEIZBb4aOBMPnSAHFJgMV4pD68jbIac3pLzxBYp/MtM6glyXamcwZfl5QfnhCO6REMxbvI7ADEOwAmndsnRPw3rWfPCBI/qt8DdytgUy3SkuJBSO8QppuXhSfYDXvcABxDOMEFPvQkDLwGlfGeOIsUOwAcS9k426BqRD72fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5547.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 14:42:44 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 14:42:44 +0000
Message-ID: <56a7a225-2213-49b4-980e-0c288b1e8874@siemens.com>
Date: Thu, 27 Feb 2025 15:42:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-3-ch@denx.de>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250227143022.323950-3-ch@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2096a40e-16b7-47f1-a980-08dd573cfee0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a0JSeXNyN2FaTDhQUjVnMGtlQWlPNjFscWltd1lZMG9kdm80bU5mZTlLaXFZ?=
 =?utf-8?B?Y0o5MmFCamJYZFp5Ty9ZbW9ySXJBV0g3dnZ0TmdZNy9xbXZjWWwrN203SkVI?=
 =?utf-8?B?MVJXSjlrQ0pUdXdEN2dEU1JOaVp2R1lHS0RybE1XNXU4cVRZNUEybXJieTRC?=
 =?utf-8?B?NW5HczBxM01ZUUtNeG91UUFTeXpVZk5JMEN2QUVXYXBBMGtKeDNoWTdPZU1X?=
 =?utf-8?B?TDVlREh1WUhxYkc0TUs2c2tWMnkvOTZ2WEE2Zkd2MFc3dll1Si9RRE5tZGxS?=
 =?utf-8?B?VUViVGVDdCswdWdrMnlOS2ZJdGFOcE9GVFZQNUxjejlsYktUOU5BVW1lWUFx?=
 =?utf-8?B?b0ozWW1TWnRzbzBCMkh1RU1HVkdJSkVIYjZCa1lYQWEyMmt6aFRJOEl0RTBt?=
 =?utf-8?B?Y3BxYmZkdUU0enNrb0pNa0VXTTIyT0IzUm9TZ1ZjRjNualA5RnJJRmRhcWQ1?=
 =?utf-8?B?MVMvNVp5VW4yTEd2Z2F2TWlqT3VxZHc0TnVhanRDZk16L3NJNWtpS0tEUE1S?=
 =?utf-8?B?dlVIV09PWW5qV0xxd2I0RmovcG1aUnl5UUVEZ1pRdHlETU8xMTNrR1hDN3ZS?=
 =?utf-8?B?dXBXVEJjSndZeUNxNXFHV2twS3daS0xwQnIwVGRZalNOWGJGcVNDemxUanQx?=
 =?utf-8?B?dTI4KyszSUN0dXlRRlc1QTZTaTJOTTFlNklwdFBpMS9nZzFSOWM0VEdXN1Q4?=
 =?utf-8?B?NHZGc0hkZlo0d204V1loOUp5SU1wZVByNFJwOHhsTmxvcitJSGxGb2xpV1Iz?=
 =?utf-8?B?bTV4R25YN1ZRUXBqVGZ3T2FlWGM0eWhveGJOdXZERUNBVFdvaVVPMzNUbnll?=
 =?utf-8?B?RTZyL2c2d01WTmNLU0luTVErTFdNNTNTWGVSQWFhTk5DR21WQnU1YnAycVpj?=
 =?utf-8?B?T250VVExeCtJdmtRMW9aS3BBYWtJZ0srUGI3R2F3Q0srVGNSandYbGdORlpr?=
 =?utf-8?B?bTBDQ0x1RHpGRkExRSs4Y1YvSTBEZVJmNmlsK2tHSlNuL1o1NHVpNVZuOWpt?=
 =?utf-8?B?My9La3ZuUFN6S0MvUnQzL0x6bm1UMXdFWnM5OUVHSFJVUVYrMDcwclg5MnFL?=
 =?utf-8?B?cUs2KzYxVTRUNVpaR1p0amNSbzcxcGQ0ckJVTVpUaThybEx3UVM3M3lPRTN2?=
 =?utf-8?B?Y1FHMVphQm5RUSt5eExBRHpwaWxXNi9QS1BEV0Q1QkVLdmtGRnFlbUVqeFFj?=
 =?utf-8?B?TytmckhEdWxPRjUzK2l4OUpRYVdIVzFwYVVJa1NYNUQ1K2w5OVYwazUzWmpo?=
 =?utf-8?B?dkR0Q3gvUzVaTXBtbzlMeENqSWI5dGsxZ0k4cnNTR25qejdGd0RRUkFjanFk?=
 =?utf-8?B?TUUxd2tjcjBLNWM2all4V3J1QkxSZytCNm5rRTFxZ1U4R28xY0gzT1ZIeWRn?=
 =?utf-8?B?c2prUG9ZM0hERUM4TXpiWVlUNFEyTmZmQUxzTGdRYVFHZjRIeU9EK3BKWkFX?=
 =?utf-8?B?RWpqODFabHFHM1RhY2Jzc2FYS3M5a0F1UUtxY1RLSERTd284Rks1TTZNZmVB?=
 =?utf-8?B?Vy90Rk1lajZyczR3ZFByRVNvYTh5d3pCTGpjMkpXVjd4dDNaVnI2WU9tK3ZQ?=
 =?utf-8?B?N3FndEd1Kys5L3g1cWpxbnlFWTNUM3R1VS9jTnNxcUFHV2VjWjdHREwyM2E1?=
 =?utf-8?B?Mm44RDdSWmQ4VHlWQklrY0VpUVVFQjEzNUpwZGF0MDVINVJueTFRWFhEZHNP?=
 =?utf-8?B?QmxnV0s1R0RpWStBbXhQamhaYVZYZGZ4UWdQY1NpKyt6UndZU3Z0U3plWjV0?=
 =?utf-8?B?Y083aDZvR2crbllGOU9CaWNLMFZGMkVnWW1uOFh3YlUwYVVMRmpiVk5VYUcx?=
 =?utf-8?B?SjNMQjRKZGF4cWl0WFRwQnUvaUlFeWZud1JLT04zS2NrR2NwMEZ4bTd1OUFT?=
 =?utf-8?Q?eeq2EQ9PDSNw2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHJMOVJEdUFhSzJNT09vSUYwQWVSc2prbjdJc05PQlFKVjMwVjBTdVlkQ29D?=
 =?utf-8?B?d0RwMkZSUFR5ekN1dzdtTmFtc3RKYUxjSG1obkpJYlhXbW5HQ3NvMVU5ZFE1?=
 =?utf-8?B?TGcvUGhBK3FGdWc3QjFHRDhST2l3Z3dvZWg3NmZBNUtzdmxyTEJhRTZUSXZK?=
 =?utf-8?B?dXk5bVdod2E2b3Z5Tk9zMUs5OWZqMFlNSFdUMVBRNHFrRW5GYUJ0S2ZyelUr?=
 =?utf-8?B?c2dBV25sQ1pKS0FzSDlCVmtWak04TU9KdXgwbXd4aXdiVFVMYUlZVGcxL0pE?=
 =?utf-8?B?eTUwcVVKc1BwM2l6OHI3R0Fibmo4c2g0V29DdVhSMDB6eW00VUpTQnltMmhU?=
 =?utf-8?B?MEI2bkVPS2lYVWJsSExPZkUrR0hINU9Yb0phaU51aUIvZ3M5SUpHSjB4MGFZ?=
 =?utf-8?B?dWRTUm82allOZUJDbDJEYnBwRW1JTmhTdy8yZ0ZkNENCNWNFYXBTMmt3c3Mx?=
 =?utf-8?B?WFJPUzczRWJDTjBjTVU3bG5Jb2xpcGE4VHFtaHNlbXJiei9Rc3hSdHRHdzF0?=
 =?utf-8?B?ZmVUcUl1Z3gzN0JUbHVId0svK090TWhzc1M4WUV2cElsdk5VQ01lVHRHYkZr?=
 =?utf-8?B?Wko3R09WaEVjVWEyblh0TjZaTjVDVnplRVl6NjYvRy9KN3l1VkduS1I3SUxR?=
 =?utf-8?B?WGdZcXhPNXRaemJSdmsyVjkwcDk1U2pFUVNDcEhrL0QvT1VQUWhOeWZ2SUpY?=
 =?utf-8?B?ZnJkQnlTdEJPREJNaUs0SHM4Z3R3UEkyc0cybDdlaHIrSG0zMGUwQ0tDVngy?=
 =?utf-8?B?bVZJMHVmSldhSEJvTURKSW0xM3RFZGFmWDlrVkNrVmlXc0VvUHJURjFPVlBT?=
 =?utf-8?B?MHFkV29hMSsyVSszUmtQMzJWeTg5TjBNUUF2bU1vdm1HZWlGTS9jQzB6STFQ?=
 =?utf-8?B?bjVaY3U4bFVlU1NMMFBYZzZrVFhSNkZKY0twaHppNW1ITGVSdE1aZW9CR0k1?=
 =?utf-8?B?SkpURlhqeXVnQXJnS1g2VmkySHk1SGZ0NzVuSkxkUlNHMU9Yd2NlL0lramRy?=
 =?utf-8?B?V1FnRGFjUmNjY1ZjMlVOaHBkdmZ2YkhTRW41QUJqSm5xTk5WaXJ0cVdRdGhv?=
 =?utf-8?B?ampWRU9BVGM2RlVnbFN2TS9SbUFtWVhxR2hrWGpIMWdneUNHRWRZLzNQaUM0?=
 =?utf-8?B?dGdCNUtpK1NDOGVEaGxiTkEySnFaUm5zK256QlhsdWFGZFp3U3M5NGIycjJB?=
 =?utf-8?B?cjYzRDdLZjRPNWNqd3FMazJjN2VZakZBN1VuMU5ROEhyRm9WdDR3empyK3pv?=
 =?utf-8?B?aHFrdFpWdDRQaFFndmRKN3duelZrZmtqMWg0Q0dYSGoreWd4TVlDZ2p2eDMy?=
 =?utf-8?B?dWZSSWFxUlJWSzN3YU9PSExPQ3VoaUJueVlsOWo2UGpmZUE1YkZ0QnEwcXpm?=
 =?utf-8?B?RGdMVFZ2QzVzMVR5WTIwMitIQ2RrWjZRUHpuVGtoQkhyUis3QmVaclJBRit1?=
 =?utf-8?B?azhNajMvcUM4a1FkTFd3eUpyQk94c3lFK3BoZmR5ZHMza1czRlFya3BXbkhH?=
 =?utf-8?B?Ym95Qi9kQ3JScXU4RGtZNWMxZXVKZ21pbTNsMUtVY0hRSitkcDhMZFJmb05R?=
 =?utf-8?B?RVEwV2ZtUENLT201VjZnQ2M2MFVRUy9Db1ZLbFE5a1Z4YzlWS3FEZGpCMVRT?=
 =?utf-8?B?UUNQMGcrVllDKzEwUUVVUXZLcmk1UUlia2U3d3JhREdUeFN6RUxHb3RiUUly?=
 =?utf-8?B?dW1uNW4ySkZUbHFaYUpIcitiZzFobityQi93eXQxSGFSdDBxRWRJMmkxRmdv?=
 =?utf-8?B?ZkZYOFlzR2FIZzlaNDNJdGNTSFkxVjhqUFVoK1RyaEl5QUtOS1hHSW82Q0RC?=
 =?utf-8?B?VzlUTmpOd3VFRFpmK1hwTEJKZGQvWUVjUzZTbXFadURDTW44NTZXMHp3Mklu?=
 =?utf-8?B?VEVjRmJvMHBkMkxrWnRZa252bDh3d3dRZkFIcVdPdnBHWjJWd04wYzFhV25Z?=
 =?utf-8?B?MXI1ck5GdFJ6RUlpck5KdHFpd0NQTkR6amZreGxvNm9RTzFKR1VES0NIZU9I?=
 =?utf-8?B?LzVzZ0VOcFdSWk1GL0EzSGdWUi9rWmljbFVWK1dvWUJGV2FqUlBBemo1SEhQ?=
 =?utf-8?B?LzMzZW1iSm9paXNGUmVHU0g3RTBmYm8wSFVNaWVzenk2WVFGMVY5MzZZZ0NG?=
 =?utf-8?B?NWlkbFN4akEzeFBpQWZNcVM3TW5JQWJRWE55Lzg3MEJuU1k0NDRjTVJCa3Rh?=
 =?utf-8?Q?mOVuGGg7phb9+mRL5+OoCRk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2096a40e-16b7-47f1-a980-08dd573cfee0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:42:44.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF5WM+EydwJ4DFcBUjXvIIfIveq/DNYx2Om4o+vUDB/ajjNgZpoysixx+S/XXIM7rU3GXvRYGdKDg/McPd7AI8hYXl1o6SveUenmJsQ7k04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5547
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:42:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17947



On 2/27/25 15:30, Claudius Heine wrote:
> In case encryption needs to be enabled via an update, while still
> allowing the update fall back to work. One update step where encryption
> is supported, but no reencryption is taking place if the device is not
> encrypted.

The scenario this patch tries to solve is update from A to B:
- Update is not confirmed
- the encryption was successful
-  Error occurs and we fallback to Partition A

Is that correct?

Quirin
> 
> For this the `noencrypt` hook is implemented, which requires some
> restructure/reordering of the `local-top-complete` script.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>   doc/README.tpm2.encryption.md                 |  3 ++-
>   .../files/local-top-complete                  | 24 +++++++++++++++----
>   2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 3f7e89f..a503095 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>   ### CRYPT_PARTITIONS
>   
>   The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>   - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>   - The `mountpoint` is used mount the decrypted partition in the root file system
>   - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>   - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
> +- `noencrypt` will not try to encrypt the partition, if it isn't encrypted already, but will open it if it is. This makes it possible for an system to support encrypted partitions, while not encrypting anything on their own. Useful when updating from a system that is unencrypted to one that is, while supporting a fallback system. For example, with a shared data partition, the fallback system would have the `noencrypt` option, while the encrypted system would have the `reencrypt` option set for it. Now the fallback system can still open the data partition if the update to the encrypted system failed.
>   
>   #### Encrypted root file system
>   
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 502fcc1..67722fc 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -211,22 +211,36 @@ for partition_set in $partition_sets; do
>   	if [ ! -e  "$part_device" ]; then
>   		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
>   	fi
> -	decrypted_part=/dev/mapper/"$crypt_mount_name"
> -	# check if we are trying to mount root
> -	if [ "$partition_mountpoint" = "/" ]; then
> -		echo "ROOT=$decrypted_part" >/conf/param.conf
> -	fi
>   
>   	if [ "$partition_expand" = "expand" ]; then
>   		expand_partition $part_device
>   	fi
>   
> +	# If partition is already encrypted, decrypt and continue with next partition:
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
>   	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>   			| grep -q "luks2"; then
>   		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +
> +		# check if we are trying to mount root, set ROOT to decrypted partition:
> +		if [ "$partition_mountpoint" = "/" ]; then
> +			echo "ROOT=$decrypted_part" >/conf/param.conf
> +		fi
> +
>   		continue
>   	fi
>   
> +	# If partition should not be encrypted, continue with next partition:
> +	if [ "$partition_format" = "noencrypt" ]
> +	then
> +		continue
> +	fi
> +
> +	# check if we are trying to mount root, set ROOT to decrypted partition:
> +	if [ "$partition_mountpoint" = "/" ]; then
> +		echo "ROOT=$decrypted_part" >/conf/param.conf
> +	fi
> +
>   	# service watchdog in the background during lengthy re-encryption
>   	if [ -z "$watchdog_pid" ]; then
>   		service_watchdog &


