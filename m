Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62093C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 07:16:17 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14715.1789370171767778468
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 00:16:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ont8Xqod;
 spf=pass (domain: siemens.com, ip: 40.107.162.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryjhb3hpMY6TN7o6naBg3tDjP05YQd+SQGSkO/HG7BzQ/DSZNjo4dXt7Whe5nkWTK/V8FIF4yXIeMzU0EC6d4RentIJdmfs/d20aXF5xqJHIc398K0Pt51jpBAMCc40hHmPQ+2mA+oof7C1eZDsZp+f3b1NZF1rE2UKIlhuW3ZosFjr6PneTkDBM7Pu5tVX+rs9ZXmAwqSKsBVjWKAAwFA/yEKUo5F/nInKiwBIOZSuBjtENZo3hcnFtK3rO4T9QZLq1nh6kTadWKpRyvCuW36t1Ucpjm1Vgs5yZwNcAx9hTLEsvqjcgZi4grfBzYXQtL2JNRpZHgwdcrQwfpjEwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph43/gXhVMNF5f1ee65KaYujbJ6YdguUnL1PRP6uCyQ=;
 b=Rq6Lpk8z6HiDXNlUUqAZOUMm1Rnpmk5Bjrk65Njmd5u6dK+T1ZfibbfGpzcnRwsGlHInWqq5zBaOVc/RYJXZlBEkuJpaiPur4rdAEcN9wTBKnk4KjLN6S49P56Rxg0YIJkPD8h48NjXNsT027vFXDy2ghDG69bBx0AyMUIQh/kQOn2QECUrzuj2jNCe09tD7eBtbxroG+wxx0BsdSxS2sC8LbocbNjq93qw2qXUVrvdpiUWWrsDe0yPdCoXon0A24ArYP4rgJBxc39YEn+/HmfHCdKr8LR/ZjvgXQs8WB7ui9IuYYAH7YeMqAbX1zwr0eBkArJQSXp+TuPT24OObbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph43/gXhVMNF5f1ee65KaYujbJ6YdguUnL1PRP6uCyQ=;
 b=Ont8XqodkzsLgjwCxiO1ty8RwlcujbsuW5VA4tNOUD4vg6i/HE/DLT4FH3F8UuDL9x14rLV1S8sIQe2rWpq6h6jemSNP8s/s8xTM01tAQ7RDjX7nfedDcT8nulR65R9iXHeRTt4cinYuvKEQGSLVLRpWHyhtRDV9spD2wsoknjBzM6vr9VLRyACP8FBx0ZFbUp0v15qrhx0UXDCjuoPpdSxVCBi3coNQCGaKHK36HatfgKTjBnspiGb2RRgcDlBsfzSK8ybedCFkmn1+XMT0r6XImdDX2Sszmh0pPKRDozCs+BGK93qYOgnsxhmflX97e8wXifmySincBBuZWfVvGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5371.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 07:16:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 07:16:07 +0000
Message-ID: <e5ade92e-e7ac-49b0-ab7e-7a4aa6723fe0@siemens.com>
Date: Mon, 14 Sep 2026 09:16:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2 1/7] secure-boot-efi-keys: Add
 recipe to create EFI certificates
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "Heinisch, Alexander (FT RPD CED SES-AT)" <alexander.heinisch@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
 <121612bb4bd7cf2f08c83f39d439d7382f0667ee.1787757655.git.jan.kiszka@siemens.com>
 <6f0cc5409fe4c6e5d1b8e8907c2ba2091ae90f8e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6f0cc5409fe4c6e5d1b8e8907c2ba2091ae90f8e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: e4acf097-0e1d-4e6b-e3b1-08df12300bb3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	A+igRRvRKez87MEPhic0kQgkv4JUZB04zfDgas8nPJkXSQS7hLY35gMBY7ZAoT20cSuP4EepiBBI/RiDyi1+VbSmRJRVWKR+TrysjHPQPu/PzK/nDY9NY+pbCdWNFNnWf0EN7TNsXib8b0Zq1rXalBh/tWVAaeNcceuCxMRw9l/MSKveko/TE/zpTliIfijtbwyuuWkdCHyxaqx9+XcL//Oy56jXKI5ynRA7yCiaMGhwMb1NKPfUeSKTyGznLlwB0yp+oBYENoD5+eMpTKhsaycb+qoqG0Cv7zaREeJUTUDEw7mQsiN29BMimbZZ9PpoypgdqaCgAl5DhPEiH9zTIvV9ayI319Du7zTErC/1aE2gWAhNSDxtYu6iuLY6EVNhaYX64OnqjWq2CTjuDg5uwMwFI+BzHVGr5LV6KdMCiQVi4tCmw1WkpAuQ46cm0fHQHKAj7IlysWa50b/EACxMCqeBCMcQ+zSsf4rQ6iipT+FFhI4J8PHf6RR0GZjn3LYNeskSfyg2iVngsFUkbgm6Hh1WopEUCpSyTveYJhCTq5B66V0MKQL3Bhg3hqRgf9XQpXi4Td89EUPAhpOS5ee7H7+6w4SGfDzAy+NGwLRXBXSakQJ1dDShKkf6NG4ImqrLZErn/4Xs09l/30qONQqo82DWIQMFVBcAAwbGRldHq/I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUFNVkEzZ2NHdTlPMW1Rd2JwOUpraU5YMUg0V3g4QWV4REF2M0NpSU5jTk1p?=
 =?utf-8?B?SGhObmtmaDd2RUpObmpsTEt3T2xmck5Vb1o5VXVtdFNOUmZZc01JVXhjTGFI?=
 =?utf-8?B?UmlXNUtaWGxYOVd0TTlobEg4TEZlVFdYa2J6dEorUHJBUVRCWlVveXRvWGhV?=
 =?utf-8?B?VTY2NUp6QmtZZ21HNDVGaWJUSGhobGxsS2VXTm5CRVdmd0cveUtrQ1hicDl1?=
 =?utf-8?B?c05kSzRiVUpGTGlzekxCRzlxaEoyNWRWR3pQbWkweVhPUlBvNFRiZHNjRlJn?=
 =?utf-8?B?a09kVjhScGxhZGNmYTR5dGtZSkJMSEZCU1ZyelhGUDdROXlqY0ZWZHdjN20x?=
 =?utf-8?B?RENyaFJvMldXZTF1U1IwSDR6NkVGWGR4bVpnTWdWSFY2SHJ6c1VEZDFxcmpO?=
 =?utf-8?B?NldsRWtSeEhianozd1IxSG00SVIxVnB0ek53VG11MjVzNGdrSjMyUm0wWldh?=
 =?utf-8?B?K0QySFhtbzBSRi96N0JtQ0VuTHBKTjEvelpVS0ZYcWtjZk84WnVzcjNuamFi?=
 =?utf-8?B?Q2dHNTgyMHZCcGp6M0NYb0Z3QkFvcHRxTHJpZ3Irdldad1lDcm5yRng5SThv?=
 =?utf-8?B?QmM2ZSszaDhORWJ0ckdLV05KTFoxOS9Dalp3bE5GZnN4Z1NQTkhicWpqS1Fr?=
 =?utf-8?B?bHFHdnl2UFpIZTF5cmdTakJLWVFpTWQrTVpYU0t5eUlPeThyVFFFNUZia0hl?=
 =?utf-8?B?d3pHSTBOR3pOYTV1RGVQczVUMjlndmFlV2x5b29nYzFmUjVwd2Q3UjEveG9w?=
 =?utf-8?B?MjAzcWl5cFBNQlMwSWN4eDdwa0w4eldGci9sS3lVejh0SmZlRWlaaWRqN08r?=
 =?utf-8?B?Z2I3UlNHb1pTZWxWK1plYXpvQ1ZxT3hFNCtXMHROd3dDdzR4V1V4N2NVU2h3?=
 =?utf-8?B?NXJmOWlCclQyNjdITmFuWXFkcWRwRWZrOG1sNjlUdTZzaEh6WlBVV1NablNi?=
 =?utf-8?B?OW5PTURMSEhNSU9uc0EvcCtaSWM4Ui9UcU1CYkVwVHFYTTY3WHZuZGtBU2tM?=
 =?utf-8?B?bEtBWlZLK0V4NHRNNi8rbW9oeE52TG1yeGFkSHdxMmhYQjN2U2gwWGhKY1Q4?=
 =?utf-8?B?MklobDltcnlVcmdCVm5pV0gwT2RwQmQxM2twUmFnNFZkdnJ6UklFTnRhMFVM?=
 =?utf-8?B?L3ozeGJzZjBvaWRZZEx0dmNEd25pajAyTU5kU3ZWakQzRkcya29HWEJ6WnA1?=
 =?utf-8?B?dHZLVGQrTDlaTExVbERLN013RFlDMjlVdzFMd1djS2RVMk5pS3hnU0VYMFc5?=
 =?utf-8?B?SWcycmZ6NFJ1VVptcTVKS0swb1dnWWtZdHdHMmRTSXR4MXRObE0reTZxNmk4?=
 =?utf-8?B?MmpVdVNEVXJCbWcrTmtkbUFMUTJHQWQrOFRmWEhBVUNBckUvV2JuVlJWQ0ph?=
 =?utf-8?B?WEtRemEzK3d4WWp0aUh6MVV3M01nd3F5S296dzlWS1dQdy9wcXIxRzc1OEFF?=
 =?utf-8?B?T0YxdnlNblZvVmljMFdLQmw3WkF3Z25ZOWRTTEZ0ODVySFcybTE0dTl5eUFU?=
 =?utf-8?B?SDFBZWFOUi9Lc3BNODBBTGUzM2ZSOHMvSUkyMmNBMmd4YnVha3RWZWd2Tldv?=
 =?utf-8?B?WDBvbGxudjQvclA3d2JSazdBSjQ4N1ViVExpdnhhMnBsVWVHcXNvZCtEd2lj?=
 =?utf-8?B?UHZWci9sb2thays2VDlZeVNGRDc0OGh0K3g1NnRIbGdZTEh2SUlaRlBWdkhD?=
 =?utf-8?B?dFYwRHMwSjgza0EwWW9JOVUzU01WUVRoVXlYZkVvZkVabjJ4WnJ6UkErOVd5?=
 =?utf-8?B?QzdPTGo0VEVFL0RYVGZoUk96ZHdWaFJ5TkdjeU9XTFVZSmcveElTR1VYVzgv?=
 =?utf-8?B?N0tUcHBTNXA2SG0wNXpRWGJ6RkUzb3IwOVFrWmxxa2dvNm5kMGRmQytpNGRm?=
 =?utf-8?B?Nk1rUDNJdUtlcnU4bmRmeXJURHljV2tzeWdaU09WUVNQZ1QrYWpqaklBbFo2?=
 =?utf-8?B?TUx2Wnh4c1RBYTF6SG5lWG1WOWR0c3FNY0JiajQ3b29FKzROV1FlS21qWnFo?=
 =?utf-8?B?V1ZxS3VqTkxnS1A5UmlYMmk1Q0s0dUFsVWYxV0xaa2tQdE5abGFRK3V1Nkcr?=
 =?utf-8?B?UDU4Zy9jTXhJWVY3c2ludHFjU2tncUtJREpZVWpJaWl5WktPZVhkYkpTKzVh?=
 =?utf-8?B?NTY4WVd1MlB2SDJjcmR4R1JUM1Y0RXdnQTUzZGYyS3hvSmJiZ2s4VmZUckJE?=
 =?utf-8?B?RWV6VHZJejRJN1QrVnlQUmdmNjMybDB0bG5Icy8rdG1TNGE2RiswaW9LTFhJ?=
 =?utf-8?B?bHBWQ3lDellFcmI1MlBwek14ZXozdWVQbU9EazRyU2I0bWUyVy84aGhaQjd4?=
 =?utf-8?B?Wmd6KzFjdnBveE1BM3gzc1k5ZEZ3WWJWMnpqMEd5NzVtZDFWRDY2Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4acf097-0e1d-4e6b-e3b1-08df12300bb3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 07:16:07.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxp+me2X7QdkjbIXcok6MJIdbVxj/ryPkhhgvGW3sVpgc2dCBzI+j/TT06JAJI8LTqxdtR7I9dh0biAbRElddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5371
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 07:16:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24169

On 14.09.26 08:59, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Wed, 2026-08-26 at 17:20 +0200, Jan Kiszka via lists.cip-project.org
> wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This recipe allows to derive the PK, KEK and db values from a single
>> signing key as we are using for demonstration/testing purposes and
>> simple scenarios. The recipe provides abstract "secure-boot-efi-certs"
>> which could also be offered by an alternative recipe/package that picks
>> up differently generated certificates and/or a proper hierarchy.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../single-key-to-efi-certs_0.1.bb            | 41 +++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>
>> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>> new file mode 100644
>> index 00000000..01d27041
>> --- /dev/null
>> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>> @@ -0,0 +1,41 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg
> 
> Hi, please either use dpkg-raw, or set DPKG_ARCH = "all", as
> this package does not depend on the architecture of the target.
> 

Added

DPKG_ARCH = "all"

in next.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

