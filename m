Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCE9C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 16:01:51 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.60])
 by mx.groups.io with SMTP id smtpd.web11.21007.1714060901476351990
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 09:01:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UxljwGbz;
 spf=pass (domain: siemens.com, ip: 40.107.6.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4d3pIsEslT5F8L7AnQFL3pK+bMooxhWn9NzsJy9pz+uwfIzaCc+H0czXYhbGeaKOi6StAZy9N9Whaz1utAaWUJjHbmvEQqvf38b+ehJKs7zpCZqKWwXsnSF0P+pHzx6Z/dVCOk9DJpNAgpFNbHU6g32Xmg3rikI+DX8H+bqtsjr30QGgXMDlHMDbCJ8jwZBwT8NYMU+debkgfKporiyv6P1eXXexT/yHpJqBj1rXjDT3fMhKB8aN0HNYfLcNIgJX1umBZUs18jolNYWnOWMByctyfRER2miPMDZrYlnEtL5VOPfwmtSzzbyJ1Eeyt9qNk7CIlRn+lMQrI7MHGPWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrhkfuU+VCX/0InsczcIZe1b/FQ9rM2OiT8gL+u+RiE=;
 b=G4UZ/DzoeYPYlnyGHfuZx7kGu2RQR5mVzt1vLSBPm/91TJntJS9LUxgVRmcU+9vA6O7ct6DVP/qVQpyjLjzoTmWJbhM7kbGuExdqUVU/Zl5CMs8Ex76x9LO3T+pI3AAdyaFQhBL3NcCg+w4X5u2l7w+cEIUWEDdJgWvSfhaxzcyEvcWR/PdZCqtzBsJ7S84Fsy+8/zyb0ZNusCIls3J4aRL12zd40PN+ssGb+oJLbj/jVkAv6S4iRng2JAAG30KgRLyjItXfaRjytvv15jTYzA1hTxnvbcxtJidXa4YMdehHTR0ZTmpBrNFgNvT+q/wq0/UKITLvkHH5Xy4ri0idBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrhkfuU+VCX/0InsczcIZe1b/FQ9rM2OiT8gL+u+RiE=;
 b=UxljwGbzkBBKHBN2Rh4naT8Y6SaQ7ZWaANsYnTYVuxlabkJuuuOlT4o0n8VdWp1n02ApF95cvKZ7tCAb2Wz48emVIw653YYM6rOg3NKzCncpZiOJLeASrolYIgOtZXQI0YGi0/UKm1imUq4eyKRxxYuXxagZn9od4wnyd/2P/AgyPsZ0A8YwrPS/mFNIYpPZchS8PK+K44zVR3dmFimlZjyFrIdbvnhkqj7sabRXUMNXbcpDvvIdjwFbubCXpbmEiPTMyqQM2TBn0LpOppHxPAdnDBR3Y0sacrf/QR23Y4r9WPD1QNoaFs6I3Yy3JBrMOimzK4u6ceLqoNZSGvkCiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 16:01:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 16:01:38 +0000
Message-ID: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
Date: Thu, 25 Apr 2024 18:01:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] [PATCH] update ISAR to latest version
To: Rakesh Kumar <kumar.rakesh@siemens.com>, cip-dev@lists.cip-project.org,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <20240425092608.685136-1-kumar.rakesh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240425092608.685136-1-kumar.rakesh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3268:EE_
X-MS-Office365-Filtering-Correlation-Id: 3385b775-0caf-4b7f-37c9-08dc6540fd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WjBUOE9MM0dKNlR6VTNCTmp1OFNZUENqd2VjQ3Z1Ui9YNzJpNHg4cmdqSE9M?=
 =?utf-8?B?VmJiSm9zYWtTOUp2cXRTRzFLRm5Ha2lrOG5teTNEam45MGtJdXBFVmFiUGIw?=
 =?utf-8?B?RHlwNWhlaDVtek1vemk2OEwzN1FQL0dTN3RiR0NqSmtlQnNSclQ5bGI2cStP?=
 =?utf-8?B?dVJ6aklxYndlOTJzWlcrMU05WmdOdnVYY2w1enBMaVFzMWRSeXhCK3AybXJ0?=
 =?utf-8?B?QU4ySERqbWFBQUFxR205aTVEZE1mcGlpKzRlNzRHVEdRY2tBaTFRR2ZwSTFV?=
 =?utf-8?B?bSs5KytWVVNYaVg1b0ZVcVdxQndUL3pYM25WUE95bEVsYXRPazVuc0VxV3Nr?=
 =?utf-8?B?eTFpZzRacC9tQklvVFRiNUpsTkNCSWJwUkMxTUpNVElwYmZQZThxeGpqanBk?=
 =?utf-8?B?WllnZjFjUVp0WVc1RFV4b2ozYVZRWGVsaFY3Mkh0bGNtN0dxTG9vSy85ZHNG?=
 =?utf-8?B?aXNqdzdEcmVpRzJDYmZHS3FMQjVITmZWUWVkbmtTZFdJaU96SUpBemcvZ3Ux?=
 =?utf-8?B?VkhWZ3ZEV1ZYUllsM2lVZHNaQlpNM0trV2VtSXRpZzFaK0kyeTFPZzFuUEZT?=
 =?utf-8?B?NUhVMm91VTg2U3ZqeGlxMjNXRnI5azVqVURMRTRRN2hMU3FpVEphS1V4d2dP?=
 =?utf-8?B?WU9BcXVZa1NDbE5QaGVnRitsZS9TUG55MkkrYkY5Qk5NUnFWNUkzRllSZUly?=
 =?utf-8?B?K3hXSzExSWxBWFp3aURHWW0wWFA0aFk0dFIrV1pwNGRCK3pQUlVUMXNhSjVB?=
 =?utf-8?B?RzlNdXBYVjhjQ2dtSVhQcmJrdzNoTWk2UXo3WlFicFhZYjI4Slc0Yis2MTAv?=
 =?utf-8?B?RTltWVZHZ09sRG5sejBzd1BYTDl2L2NQYU14YVJuK1lOMFNBb3Y1WFc1R1RX?=
 =?utf-8?B?RWhFZnVvbnRwcnltaFZDdkFIUkxFTlVmT3Z6LzliK3pxZnVPa3k5ZEkwTkxq?=
 =?utf-8?B?Y2xteTM2clR2ZWRMd0xOVk9TRnoxdnA0WUZaU2hDaFUvQ1I5TkVCcEJSdjJM?=
 =?utf-8?B?MDA0bytjcEs5aURvNm5Pd3liVXUvMEdGYnYyTmJiM1QrQkpLMXFkYVBpZzNp?=
 =?utf-8?B?SVMydjZQakNadThWSEZBK2hkK01haE1FQnNPTzBNbkFXRDUyZDBJbUxDU2tz?=
 =?utf-8?B?OFl2MXdFNkVtTWNhcEsvV2lZMWxsOUN0VE1PdXg1SEF0bEttNkRGbzFDZlhD?=
 =?utf-8?B?bWlPLzlIMGhnUXZhZlB5bExNR1c0Y0x5M0RqbmRuaEdHdkJwaHZPQmlOOUx4?=
 =?utf-8?B?eC9xZnJQbzZHZHlPSnE0SEdqSWNkNGF0ZzZLR2F2TmEvTFZlUmRkZ20rS1h0?=
 =?utf-8?B?eDBvOHlJVDBKWkpkbDJCZnRGZTczT2dtckRINlN3YjJrWmN5cUtoSkp3MWdq?=
 =?utf-8?B?eWJhK2poSUwxVTMyWTRFS0lvano5dEpkekJpSUdyNDJJQ3d0Wjh6algxdEE0?=
 =?utf-8?B?enk2TXNPZEROaS9kUFRsNUVLV09DcmZVaHdnRVRCTFJFUFJPQ0Z3RHk3d1FG?=
 =?utf-8?B?VHZCbE82a3pTNnVlV29HMjdZYjVxcnNxdUtnQmVlUWZtZGtOeG9ncG81U2ZE?=
 =?utf-8?B?TnB4dllIRGJaWUpHdUZNRzA0MGhnbTZzY1lYVHZFYWgvaGRvQ3pPd0JyRWMw?=
 =?utf-8?B?SlRVUW1DN0hLemEzc3dxdWlGNHdHQ3ZweVROR0ZwN0tFQ3pHKzdrQUtSY09M?=
 =?utf-8?B?Yk81c0kzK1oya2lQVkxqbGNzSDNHOUFBcEFyQ3pkenlIV1BLTmNRU29BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTlhQ09yM21mYlFwRGhlOXJUOUxqNHBiWFdKbHUrVE1LczI1Zk1aaE4xTS9Q?=
 =?utf-8?B?YkVaVTc5SlUvRnU5dGdBeTZVaDFNNHdSdFpwcVlSUEdpSVhQNXpXZVRrcVRO?=
 =?utf-8?B?M0wvTFFidjZiRmFwVmVXUEczQUNyNGp4OW5pUVZUczVNb3pqSGtGVjBiTHdx?=
 =?utf-8?B?MkJFbWk0cDl2N1Y5b0FPREtRRXRldDNtbGFTVlV2L0J1eExVdGU0REZ2N2lF?=
 =?utf-8?B?ZVNFYzBUMTdHSjRyVWZkS2MwZmVYVkJnZVNPaUlMbkZMYWlvQXVKOVRrSk9T?=
 =?utf-8?B?ZHpNTjRpbUpURFU1QnN0b2s5dGpjbjlnczdmMnd1MVFqK3FGSUhKaXlWUmdL?=
 =?utf-8?B?NDRiZ3NyQTMyMFhmcjFsZDZNREp4a0NncUxQSU5xSHBCU3Z1YytKSmFTaXcw?=
 =?utf-8?B?VkpuNUFXMzNhcXBLQUd3c25xaVhXL09sKy9KR0U5b3RjVGlXY0pxSitzVURN?=
 =?utf-8?B?ekVPQWM2VSttUitFQTVXTUNja3cySXJCTk1DdWZVK0c0SmpydHJmSnVOeHc3?=
 =?utf-8?B?YjQ1WHcvcy9lb0xSUjBmUmF6MEdmdm5PSHRqSG42M3h5VHRUQXc4WkFkRkhJ?=
 =?utf-8?B?RS9LVEI5a1AwWFAyb0tRRXBkWk1BTm1PTVcyUVdnaUFIZzJOenMvaDhET0tE?=
 =?utf-8?B?V2xTV29WYm9uUUo5TkRUd245YnNTOWx5ejZIQTZEMGtvWUhkcG1sTXBQVUtQ?=
 =?utf-8?B?dEllajRQckNWQ2doamtlRUtDMVZsOVB6ZUxuSjJtSkI3S1ptQ0lRN0JPei9N?=
 =?utf-8?B?YUJMcnF3M1dwS2k5Z0N1enhUbzBkUnU1WUo5RGF6d3o0MXVTbEJiMDl3Qyth?=
 =?utf-8?B?Z1RFMk5xWVhzZ3FzOFk5b3RqTFBjemxZWVlFTlNHQU9Ld1ZUU3dqSmdScm9H?=
 =?utf-8?B?VytyUnQvWTlvVzE2TklYMWY5anAxNyszc1ZIYnBhbXZtNldCbHdwcmRYWVpu?=
 =?utf-8?B?bVpLemlPdS8vZ2h5L0lpS1dZU1FDTUdWZm1JRUoxK1Ywc0xBdGJMSEd4NVho?=
 =?utf-8?B?ODN6bWtHVlZzUDBGM0kvdmFEK1BYam9iL05CeFdJY2hKWE1abXNZc1ZqUkEr?=
 =?utf-8?B?Ulh5b0dnckZ2TUtlc1FVV1ltQ3ZMNVNjZTZBZHozSGI4QXVuY0YxNUh6aGlY?=
 =?utf-8?B?eEhnMjZGNzR6ZU5zVldkcXRPbUw4cVA5dmxxYlZJOU9qSVJReXNZZ2M0ZnZj?=
 =?utf-8?B?dEdPZjBwdEN0SGhDL01FbUZGSFBEVWVja1RRQUlEanlwcWVabHN2TDltdTkv?=
 =?utf-8?B?cE1VSFNtelBtN0YvQndpYnlaaUR5WWM5RHoyL1RmNXl0RWxBY1NJTzdTTnRh?=
 =?utf-8?B?dFVGNkRKaitsWXFUMjB5UXB0am0vNGRRUTJjWUJZZ3ZQZzVaRWJ1eWF4em5L?=
 =?utf-8?B?eE1rTDI0RytwN3ZZaW5DOGlwOHpCRnNZOVZoems4cnV6blJjL3hqRTA3Mmla?=
 =?utf-8?B?K0U1Rk5MM3gvcld3aTM0SmFYSnE0RnZleVBPTU5pYXk1K1JhOVpOVHQ1Yjlo?=
 =?utf-8?B?QlhEZVdJYklUWGpkQ01sY1pBWXBGazRFNEVjb0RxckxhWFVOSGN3bk1Fdi9H?=
 =?utf-8?B?Tk9pQ1gvUWVtYlVqelAwT21Ba0llandCQU5tVFpOdzRFdVZpd0d2dUFjSG5u?=
 =?utf-8?B?aW4zRzcvWWl5d2RNbWE5SzluRElXYmVZd0xhMDBML2xYWXJDd1pabmUzMmdM?=
 =?utf-8?B?TzNyalFGQlpsd0QzN05zU2NWNE1sRTVYT0w3RmRpK295TkxTR2I5NUNSSEJK?=
 =?utf-8?B?QlY0UVhXUlNWOFFGNHFVTVFjTEVqMml1S3R0Vm9MazhzTFRZUnkxV08wT3hs?=
 =?utf-8?B?WnVGQU5tYURNZ0NtVElaNlpMQUgxSjcvT3VyMlZySXVWdFA0bHQrelhQVS9u?=
 =?utf-8?B?N2pmajNJeTduK0VQSEtzeFlvdlhlUXNubE5NcE51RU9vcVpSS2FJT2ZNNVRt?=
 =?utf-8?B?R1VkOGQ1ZEF0eGFiUVJGend2Y1JJQ0tWbXYremw5Z0lLUHc1bU0ydDZheXk0?=
 =?utf-8?B?Ykk4N25zZFUzeWZEbUw1NVhOVkw2My9MeVhwYUhXRTBUWGE2U0tzNndncjEr?=
 =?utf-8?B?bmxKbm5ia0xyTWp6a0pPbFJyYVNMang5dTJwL0JDTEdFSzZsd3hHSU5IMVln?=
 =?utf-8?B?SFNzcEdSMGN4NzQ0YlBtbU0vNVIwS0RtQyt1R3JscG1ZRTJyNzE2RU5YVlJr?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3385b775-0caf-4b7f-37c9-08dc6540fd17
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 16:01:37.9667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfVnG4EeGEWPJl6I+LZQ4/p9lwvKwO3wU2ZH9A+uiZU2qQYi3B+s69JwpKINdvXnB4iO0hClmPIA7SU2gwWDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3268
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 16:01:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15769

On 25.04.24 11:26, Rakesh Kumar wrote:
> Update the isar to get the latest changes into cip-core.
> One of the changes is DEBIAN_PROVIDES, which is required to
> resolve the duplicate Provides problem in secure-boot-secrets
> to ensure that the build process completes successfully.
> 
> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 2c3c8b0..8a83951 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
> +    commit: 3327e66994e1a487eb1b609902c12f383faa3b3a

This is current master. I suppose we could even include current next to
have Felix' snapshot changes for reproducibility available as well.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


