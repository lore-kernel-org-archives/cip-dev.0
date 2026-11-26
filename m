Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14346.1795701617336871497
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 06:00:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vxh/81QP;
 spf=pass (domain: siemens.com, ip: 52.101.66.13, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn2QSsvxY69Pg57ETwgZLJjftf49CHc+HxQTTJnrVjOgH3LF/HQLyw9XKbN42aGj07gxlkgTsD8kAGPwT3ffFGwmUOadWZ3C/K/7Dge+rI0/A2bMvTcCIaX2BnDoYr88d4rhKETVoPpILA1Aq7AIxCGHTz0FGpk0K6yM+Ifx/CeZGWKoh5arnyexpvRUL3akHsHOWUlQJzpkc2JXN2pK2rR4ypsY7zSfoHKmAb/PaTo6WcacQpjVKN1q5ui9B9Yq0T9Oh2irrP3S1G3KMvF3LsCcUe0YVAfGK5pWc2lVpq4iEK2glZJYPL+g9VS2oGgLkg+uCrI93h6OlkV6x8Oe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TPC8nmjyIOFqkwqboK4J4udYQynT2dtNZoijZWLPFI=;
 b=ndYGGwY1sC6uQ2OrJZPaCgUHdsrl9Phaj7rAniqcxLVYm/3b4C7v1E0unjUdvj3MOovPORjluOIrCt6G2YLFz9bBIKke6V70s1WmOD17W355ZwrpBuX82D9J5fpmOElXYV7Q4sf97ux5o2/pvXXbSIZJMvIfkDiFbZffBxgwEJ6o7mrPQXbyMhivS21zJjTJz+Ob6NysBoHP9EGCRbihZTtudv9LwoxR3wpFm15RbRPtLAdS8TZW45Mi5etw1yCsUn91wIcVeIVmyCuJ1JBIxT93Ll7OGJ59wKtHkQbsjDtM3gWsv8Egrgvi/xxAQWZsnPyvY0BqFJzLAwGCtgtq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TPC8nmjyIOFqkwqboK4J4udYQynT2dtNZoijZWLPFI=;
 b=Vxh/81QPh8oAZB3VHo/1L97I5oUSEXL08ZwEpOvUq5v13nl5JiN/wShrDzTAfsYCnivZTASGb6qrdbNspRThu4P1h9BedoaHSFfn1QSEdUeP/ZMcgckjhi3HimC1WBlx+TUPTy+KvjVrXwg6EPylI5L3cS6oh530Yd215rMsRxGIWeHWCfoaqctNz/42WFeWlyIcBcaRs+c9b5SUk0EhYyBhPY+j31ISrpU5cszFLB8ckQ+JNK1VQ9NMjx9IvfSU2VKZHQdh62DNOiM20v+6DFt0/v3aCM2yRMDvKLv6EX0LYAXNJkEMgee3zaxsrDxDvKVFwd1ns2edsPWD556m6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9)
 by VI0PR10MB9659.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 14:00:13 +0000
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7]) by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7%6]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 14:00:13 +0000
Message-ID: <317d0a2d-c838-49c8-8f07-7cf71979189d@siemens.com>
Date: Thu, 26 Nov 2026 15:00:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Kernel Vulnerability Triaging and SBOMs for CIP
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 "Masoudifar, Negar (FT RPD CED OES-DE)" <negar.masoudifar@siemens.com>
References: <eefa6825-b571-4671-a870-5845f8700af5@siemens.com>
 <awgFnhmjayrgXWRq@duo.ucw.cz>
Content-Language: en-US
From: Christoph Steiger <christoph.steiger@siemens.com>
In-Reply-To: <awgFnhmjayrgXWRq@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cf::9)
Return-Path: christoph.steiger@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR10MB9423:EE_|VI0PR10MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff78ad0-829b-49f6-932a-08df4bc5975d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|55112099003|56012099006|4143699003|5023799004|11063799006|261009223027099003|261102123227099003|10067099003|261026140227099003|261022105027099003|261022115727099003|261026121527099003|261022075727099003|261021121427099003|261028144727099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: IztK+jXw3XnKOb73+22N8LCdg0za/yE0aXIGQ+cGzQe4tujtVGs92Ifwv9WYd4IrWD65P77uFtd1NOgLdN5HYG2J7W/oyWnU0iHIfsRz0b0g/ndNipJArEyx5wH4Z8HTWXUCixjatmYNbs1xgygTnw5+qnXfLj8ZRbwIcB0qeHjv5n9hOVIaApHLwIeBM+Wt9qkKNwCg7M5gS+LSKN/ImgNT6Sc8/fjgjzFS8sj62/gXLg83rYrE4SsGj/dw/vg7qFpRxzXoqIHwJzBnZ0nTRreFu47GJgw/w3aMZ0h/UUtJGgAdYSSPufkjwx7RGaoENKT15+UejohevLtUmzqTYs8RRX4DzRLdQqAvXTfIYO14WQy4piLLaru1bgZKy1HTJKUld0L7g/3006CWnvxeG+wIGRrVfK24FgKL/04gHiJULdB6/HV05rAFHFw+TLBqr35CPANdsTGf3kR6BZEpvNsmahtkvBRKipa892V4Pl2fnnTvHVkH2vu69C5nnb7z6u0gALysZJ0nvKNmbRr1tg9gH9vz1QYpQ+uwC/vUBNxY/shZD8EdLksfPbLr876xn1mBNizzIzOFZClbaqJJEOxN4FBHjc8ScYLDZ9Jnwdau0pp23Rw5tzbdcWn3JfEX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(55112099003)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(261102123227099003)(10067099003)(261026140227099003)(261022105027099003)(261022115727099003)(261026121527099003)(261022075727099003)(261021121427099003)(261028144727099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FveFVVTFFHMFJ6RmRTL1dseXdqSnMwMG9YL1V0VytSZlpSdUhMWEFseFQz?=
 =?utf-8?B?RlRkNVA2UnoyRE5vR0xoZDNVMEN2N3VPVUo4emdxR0QvNkc5QktUaUkyNHkz?=
 =?utf-8?B?WmRyK1JzVzBVM25FUHpOQ3JSN0JqNGxtTEVPUFRxN3BQekdQZlN1cjJCNURH?=
 =?utf-8?B?VW5aOVpwUU9qeW14SjFTZ0xMZnRmM0Z1U0tURDZNdkprWnF6QXhJUHFMMlNE?=
 =?utf-8?B?YlNYS1JhMHNqQUFGWjByRU5kRnErVFh6blhBT3pLeVBmcWxUOTU3ZTJuWnNK?=
 =?utf-8?B?UjY4UHV1R0tpTERNc1hPSWxTbFRkNXVuVmJyZERCaCttWUU0ZHF3cm95cloy?=
 =?utf-8?B?UDlZTU1NQmxIdzFDN2lkRHN0SVZXa2pvNXVPUUhLZHp5S0IxQXR3SHByVFdS?=
 =?utf-8?B?ejVkQmlpa0cvK01qWkdKVGlKTmZLTUFKK01zWkRZMXE0dU1VYzZ5YlI5Ni9E?=
 =?utf-8?B?N0gwK1V6dUl1L1ovU3YxYU91Qk9URU9HVzBXd0Qwejc5QmtMYXpTYURyYlhN?=
 =?utf-8?B?WTBScDNOTHA0THJjbEVlQUxuSHgvTXNsYWE5QjRJQ2hUaFQ1TEtyVmV5OFlX?=
 =?utf-8?B?Rk01WFUyK0kzQkovNGFxZ0c3ZEFwMWltRE52d0NWdzRrVTBkTDNzUkpxSURw?=
 =?utf-8?B?VElhK25uaTJYa05PQVJweXRyM09yeDdUV1Q0NkROaFMvRGIyT2hoQllEeWJa?=
 =?utf-8?B?T0luN3NaR1hOWThCU2R5Skpmay9GZGYzY2lRZndETy8zQ1IzbGhiZWV0ZUpV?=
 =?utf-8?B?d0ZkWTdQT2FmM3hOUi9LeW1zeW5jVjJ5Q2t5TU1NeGljdW0yR04vU2JNc3JG?=
 =?utf-8?B?czVBS2lUdGp4UVFnWWpaZnZ4YVhBY09SZ2ZHdm8ybHdqL2tvMEJTOXlUb0Jh?=
 =?utf-8?B?eTdmbU5ZUzREZmN4NHU3TzRqc0hBaVRkMjJrUndiNTgrUXZnQ0xHbW81UFI0?=
 =?utf-8?B?YkFNWVkxbzBrYzZSQmduOEN6cEkwMm9aWTcvd211VEMzbVc1MURxUGswNzV3?=
 =?utf-8?B?Zm55MHN3UDFFRUpZRGFvTHBDenlHYVdBRDM3R3d1MmJHUm5DK2xkM2JtWTZO?=
 =?utf-8?B?dGlqTzhsWlpBcGpZczkwdU9WUWlybyt2R3pCODVWQUd3QSs2ZHZidUkwMDhY?=
 =?utf-8?B?TjBDRnVSWEtacHpZcFZSd0M0bHoreGtjVGJDVEdxMjBDZnNGbUtYWjZySmpD?=
 =?utf-8?B?aVFxWStLbEpnVWlIV0tIdzlXWUxhRTVkclJTWS8yR3dVZ1NFSzhPSWhlMWsv?=
 =?utf-8?B?MS9IdTBrOEp0dkN3RVByVFl4ZTNDYjgxRCswWFRKeTFkZmZDQUl1QnpqNHh3?=
 =?utf-8?B?REd3alRGbW5SeW9BSDBzakhzWmN4Ykp1cDA5NVlGNXhEMVpPaUd6eHdtQTFY?=
 =?utf-8?B?RHlWMTNuWkFkU2VaTHlQTXlxTjAzbHdNbXRwQ0ZiOVlQTEJRd0NwOEg1SVk3?=
 =?utf-8?B?RkRFMmNvK0theDlZc0tUdkhZcnZxVy9rTlY3YlA5eTdjNVpaWFBkVWdBNUpo?=
 =?utf-8?B?dm5WL3A3Y1g0VzNyMW50bFc1UWZTTEdsRDEvRUgzL1VSZlRNOFZaVDF2KzVp?=
 =?utf-8?B?QlNNQjliMi96eklsWUlkWkNzR0liT0p1alYxMlZtMXVDODJCQTVpbXd6aU5M?=
 =?utf-8?B?WjlYTlQwSno3a2RDN3U3OTlTZWpUaGhzYzFCL21YVFh4YUdHekczU0F0bFRz?=
 =?utf-8?B?eUUraUI1U1pwdk81NEdsSUJGTDJCVTFtSGs2SW1BbHhxVDdqWUtiNkpVSzA0?=
 =?utf-8?B?Nm53c1VJSkdmK1BSdmVRcVZDd1dTdEtUaVlzR1dzQ09QbkYvbG96SitBcm9C?=
 =?utf-8?B?RUU2R2dOSGtvWDJzcEttVUFub2J2UmNFTUdGaUI1dTVmSVVJSnFxTXZJSFlm?=
 =?utf-8?B?anNHMjZqTmhPZHd5WmxpSnFySmt6MUthN2pyT2JKa3JUNURNeDRzbXZwR3Nm?=
 =?utf-8?B?ZWlTbkg0VUF1NHA1MnpBckd3MHNkYm1rZGF1alBOT0U5bWRCUFdJQTFISDJw?=
 =?utf-8?B?NlVYdEdEdGJJTHhrT0p5cEpXb3haMG9sbHdKUC93UlhIRW9Ibm5WVE96YVRX?=
 =?utf-8?B?aTV0K2lER2ZmaDBJS2ZyVHhuK29aYXhEMjFBcURyclpKU0NlN3FjUTE0Nk9z?=
 =?utf-8?B?UWEvS05MOWRNY3BKYXQ1NWd4OUU0SDhyN2pXci9ud1hzY3hnZktWd3JWRmJU?=
 =?utf-8?B?Z1pDQ1ZKbnJFZVVrT3A2UWd2QnFmZVJtN285K2w2VW1DdGlZbkZLTFJ1THBj?=
 =?utf-8?B?eU1kVlh3aUtEU0M5Q2ZpV00zMnpwSUlkcHFQd2NDekRyQndlbXVtVEU5OThW?=
 =?utf-8?B?blJvOENEUG84eGhUODJNSE1rOTN2Yk9rRGdVRkdtdWFPQ0R1TnlwbjFxNkFH?=
 =?utf-8?Q?bQG5KBjrVdxQxOG0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff78ad0-829b-49f6-932a-08df4bc5975d
X-MS-Exchange-CrossTenant-AuthSource: AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:00:13.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5Df3jECkSiC2cDOMOjjjYMhWgEE+sUVNCWl+qYrwHKFv4jYaFInFJgktktf7j104lZ2pGgV2vNU0Nyq4fm0KVQATld0oeTLNX8xiq8FjDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9659
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 14:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25107

Hi Pavel,

I am not sure you noticed, but this is a repost of the earlier posting 
here [1]. For some reason this got stuck for a week and I posted the 
other one in the meantime, which appeared immediately. We have 
discussions on both posts now, but I would suggest we try to keep it in 
the first post.

> Hi!
> 
>> For this, the following things need to be done:
>> 1. Backport the SBOM series into our SLTS kernels
>>     This should be pretty easy except for the v4.19 version, as some
>> prerequisites are missing there. The series consists of around 15 patches,
>> but is solely confined to the scripts/sbom directory.
> 
> I'm not too familiar with SBOMs. Could you provide example output?
> 
 From the docs [2]:
   When invoked, KernelSbom analyzes all files involved in the build and
   generates Software Bill of Materials (SBOM) documents in SPDX 3.0.1
   format. The generated SBOM documents capture:

     * Final output artifacts, typically the kernel image and modules

     * All source files that contributed to the build with metadata and
       licensing information

     * Details of the build process, including intermediate artifacts and
       the build commands linking source files to the final output
       artifacts

What we are probably most interested in is the listing of incldued 
source files of a build, as this is useful for triaging vulnerabilities. 
An entry looks like this:

{
       "type": "software_File",
       "spdxId": "b:1085",
       "creationInfo": "_:creationinfo",
       "name": "fs/efivarfs/file.c",
       "verifiedUsing": [
         {
           "type": "Hash",
           "hashValue": 
"0b043a061086790dba2bcef05c156cf5c56119ae25e4e2bf9665f674a55e10a1",
           "algorithm": "sha256"
         }
       ],
       "software_primaryPurpose": "source",
       "software_contentIdentifier": [
         {
           "type": "software_ContentIdentifier",
           "software_contentIdentifierType": "gitoid",
           "software_contentIdentifierValue": 
"cb1b6d0c34545c701ca36bc881ee922d1ff41bac"
         }
       ]
     }

> We have kernel development history in git. Some of that is copy pasted
> into CVE reports. That's not very useful.
> 
> Taking copy of that and presenting it as a SBOM will not be too
> useful, either, and I believe will make many people unhappy and ask
> wrong questions.
> 
> Best regards,
> 								Pavel

[1] 
https://lore.kernel.org/cip-dev/b62df3a5-fc1a-4fbd-a81b-0ffe38d8d854@siemens.com/T/#t
[2] https://docs.kernel.org/tools/sbom/sbom.html

Kind regards,
Christoph
