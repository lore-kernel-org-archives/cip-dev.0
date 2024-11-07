Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A4D4334A
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 11:30:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.44])
 by mx.groups.io with SMTP id smtpd.web10.69968.1730979027577157640
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 03:30:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AzV0WHVF;
 spf=pass (domain: siemens.com, ip: 40.107.22.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkXXpfX7yBbIErdn5vkRqdnZwqLWXbLl3ilTKw3bXN6ATrj0MKVJ4tqtSM4CC5hp/eSRXTUTGfzV91f4iz36PO2YAPvVfC7b7XA96b7bWxtSjpf75+wxuNywyHHcziR3BYLPBHakZhgs2twPWMBnPZQFWO0CUp0RgOVItx9rJ6vwxOiy7wPLpuXwKZfEGQ1TK7XSPWQdZJFMFQ8OJPa0Y/Hd/pzmfN7wtiMUnb+sGEn8GeM0qdjvCElvEpIEGgzbz8xqw9P/AQZ5OzuU7sZ1QhzDDH8fkBPtWhITtQWsaL9KXvu3YcwnAIz8zcOcSE/1LVBByK+z/uEMssb2DOHafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiXzHfiep3DCyj7ANcv8aH572OVUY/3JJ4JNAP+Vb5U=;
 b=GLHZxmE5aBVyjd1t/Y8Wc7Wrw/RMGZ2Q4sdy3G6iljGqoGLYOdu6GtOTq9ADAB5CuqEWb/VkOWR2V2U63e5QVFRqDRS1Z+wXS/74bbtjynRps8/tzsRDKO3YkfjoaGCaMI+m9fBqXY2Csg8qKioVBgug3RvDDW56bPXaDl0+tDvR46oFnt/KFWafwQ6Cd66/l6vlegzkFUfu9KTenDcOiasfdyzvQhKMzNPucr4mfQIsLyVmc857q3refQG+vBXWuqCkuk1zZ86qj7NB7K31lHyFRfaH/EbLULHcvuA+3ht0BP2HvQq9QkVuIM6K6PiQJ9Qa0+BEMNSni+5OFhzwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiXzHfiep3DCyj7ANcv8aH572OVUY/3JJ4JNAP+Vb5U=;
 b=AzV0WHVFmB3ClkwKm2/omFkH2otXXzTTWBvL8jRgbCK5PWxTp9n9rpCPCzGlM5RRBZENuj+NxW8ANYreW6ibPDGcC0p1X189HIu6xDWbia2+/zzHnBAToyBYo2h1/6v/kfh9RaF8j8Bpu7PWaJA+pfDuDUHypgGXEErQ921cSG+0EGMed8ut60IZnYYHSuKFz8tuq67AGHEbDtn4WcA+kCO/efD9G9aOD8arxRHwS9HbK6gn7EqklVtxIgTPyHOK5BT5KBS14/Mv2CB92DpQ/UPTrgm3p2oYC9EXXMCE48kcUe5Q5JsJfJGgUQ7uhb2+qa8Uru9HRwIYKsZhCTKOBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV1PR10MB8417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 11:30:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8137.014; Thu, 7 Nov 2024
 11:30:23 +0000
Message-ID: <af85d99b-c02f-462d-b668-7a41ca966dd9@siemens.com>
Date: Thu, 7 Nov 2024 12:30:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/9] swupdate: Control self-building via
 boolean var
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <cover.1730977077.git.jan.kiszka@siemens.com>
 <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <c6ab307ddf903298d2fe23ad93b1e6a251ecc6b1.1730977077.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV1PR10MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 206e022a-05d8-4351-3c1a-08dcff1f91b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N1kxckNYWWpCUlhPWllhN3pGd1FZcTZlN3ZUbFM0VHFnVk1xUS9ZR3hyVk0v?=
 =?utf-8?B?NlBHSGFySzEwK2tCc2tEMmJpajIwdGYwdTlyTG50bHF1MHBzZ3ZZQ0p0c3BP?=
 =?utf-8?B?OW9qVUR3eXZ6ZkVlMXpvZURETE9MNHhTc1FNK1dGL282WGpTbnJBODJDL1V0?=
 =?utf-8?B?NXZ3SDRvM2V6K1JkaVVPUml6Nk5FZ1V1MmRaanR3Um43dWUwdjBRUVRvZkNp?=
 =?utf-8?B?MGp2cDJHV1RUSVYrT3VhSXhyUEp3TUY4VU9sSTFFc3Y4RXRhM2tQYVJHY2ts?=
 =?utf-8?B?L0MzK3RkVm9hbjVFL1h6ek1Qb1ZhcDMvbk52VjZJVEpkV210VEtQNzJxWG1I?=
 =?utf-8?B?Y2g5WlVJOEF5bjc2b25kbTRGWTBzeWxNNUZYM01CMU5TanduY0NVVldYK29o?=
 =?utf-8?B?U0JFTHFEeUZwR1NmS3ZRck1ES0VBVFk5WUw2NDkwNHhDcWtNemFDMUlwcHBu?=
 =?utf-8?B?ODRLS2ZIR29hOFVDU3JRdmw2d0Rxbmc0M1MvRmtnQkNRNXFXUGd3djlNM2ov?=
 =?utf-8?B?ZDJPSzBmYzhvdmhUT1A0U2p3d01Ba01nVkg4aVpwYmRibzlGRFpVNm9WOWc0?=
 =?utf-8?B?VERCL0RZbDU2czdlVmFaN2hQcjJJSlJUNTQ5dndXOGhWS1hocW1TMjZRMzlH?=
 =?utf-8?B?WCtIQlhZZHEzcVc4eEhHQ2wvZm4yRVFHdEpHcm5ReXpCbncxLzVZczNHNEd2?=
 =?utf-8?B?ZE96MEtKbGR6SjNxZ1BvNVUzZzdZT0tsWDlTZm1JdUZaaGZKTUpha1RUaVhu?=
 =?utf-8?B?R1pWVE9yeEdlYlZhTUkwUFQ2RlgzREkzVDNFN3RObVVnYTlVQ1hlWm1FRmds?=
 =?utf-8?B?TG0zVVlHdkEyc0kyb1VCd0c1azdWR0dJM1pXQVRkZEsvNkpPNGR4Z1djSUxZ?=
 =?utf-8?B?ZVhjaEZNUFp3VWNKaFM5YThMZ01HK1VCbGo4aUwvRFFrTVhZOXhKV1hUb25S?=
 =?utf-8?B?NzhhMW9LOFhhMzhQQVRFWVNHUEJOemV0VzRlc2p3VG1kRUdaSng4eVpjb3or?=
 =?utf-8?B?YnFvSHNkVHFkTSs2b1VZTlJDOGpTbElSWjFGU01KRnBTS0x3bWlJU3VIdzJv?=
 =?utf-8?B?VXFWQkVQQkZqWmdERVJjRXh3SVZ3QXg4TjFZajl4Qms1NTk2Yjc3ekw5clBY?=
 =?utf-8?B?NXBIaEZzTG5TMUpUc2ZJWlEzNmV0ZVNPOTllTjJVajY4Sm1LQ3kzbzZyT0t4?=
 =?utf-8?B?MDJzL3RDVWVlTDRKWDhnZlpCNER4L1VCMUg4WFUwYVlIdkR5TXlFdnlNbFh0?=
 =?utf-8?B?aDUvczZvR1EyKzF5MUV2QWVhU1lZbm9VV2kxaVludGQ0dytsWmNVTzlzelAy?=
 =?utf-8?B?Wlh3Z1I0d0dKVkRUMFJlZitvWGM1c2FwUHJlNklpeisyUzNhUEVOQ3RjNUVk?=
 =?utf-8?B?dC9GWDkrbm9tTEx2VTU0cXFBdXJ4QVdUekRVUHJaMTVXNVdRY0RhZjRzSnpj?=
 =?utf-8?B?VSt0TGJVYVJJQU13eDh3Ly9JN0tFeFNJb0Q5cG41VG1IMC9XMTFuTVpDeWVF?=
 =?utf-8?B?YWRPaXZ4YzkzejN1MFlZbzQ3TXpLL3NVWjhHSm5yTHBEb204QzFQZC82RE5B?=
 =?utf-8?B?VUpjYzdsZXoxSHQ3Y1dOenBER1gyVkRPMDBRU3llZWlQbjlkWVhDb2RyaXV4?=
 =?utf-8?B?cHNzQVdwWS9qSFE0SkN4ajVjT1d1dndHSWlRNFpPNElwMm9UV0ZvaFNuRk45?=
 =?utf-8?B?VkpmMjQ3c1BjY0x4Nk9kK0MvRE1HSU1vUmgyd3VMdVF2d2UyQ0IyYXB2K1Ba?=
 =?utf-8?Q?TqLKx3NBfKF39UMyFQEI4loBriILZLqZQmbTEix?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDJOalU1UGhFSGh6Vk5uUHBVeXZBT2p4am50QmRSYjVTNkZnZDJnLy9qS3Jx?=
 =?utf-8?B?TlZOcWhkZzRDSVFxL21IUms4U01QNmwzN2RlajFSYTB0SjRNMy95alZjWXo3?=
 =?utf-8?B?dnJESXE0V0ZoOUVXUkJyTHV1dnV1aEVVbndsV0g0WlQxcEJ1bExQQ0lkcGRS?=
 =?utf-8?B?ZTQ0d1lIeVlDUjI5Z1FpbXhVWjl0RjczT0p6NER2SlRLK1MrS0xSRER2aGl0?=
 =?utf-8?B?dEdJZnNuZVZJRGdBVkVRMHZwOGErZHR2RUIyUzdZOUtUcHN4NTMxUGQzUjQ4?=
 =?utf-8?B?TjBLbEl1SmtOSlRzM0VFczMyeW9nQzhTbENNN24xbnRUdnBmVzhPNGc5dEhp?=
 =?utf-8?B?bGgzcFExa3ZNaFkwekkySUl5RlBXeS9iYTBFWGd5QjQ4WWxpK01BUWJoVWl0?=
 =?utf-8?B?V3VQb1ZobVF1Yzl6cFE1SWhRWHVIWnpiWTF0TEZhYWRTdVc1N05RRldVN1Ru?=
 =?utf-8?B?VFpza0loU2ZBM1dZcjZpM2dQUHRpckZaQTJkVkUyUGM4VEphUkxKNHFRTlBu?=
 =?utf-8?B?SG1aUllRQUhraHdyc0VBdVVqL3dPdmRTWEpjeVBtbjhUM0JpeWMwSDU4MWhW?=
 =?utf-8?B?eWR3SjVOZlhTNWZqQjRTdjFwOWdRaktHRHM2UW82aUlualVpaVlQaENxWnVo?=
 =?utf-8?B?UlpDM2RPUHZ5emFaOEM4QmJ3RGZ2cDBtVkU0eFRUVlJ4aTF5ancvbStPaCtu?=
 =?utf-8?B?c083dFl2QUZrTlZyK0V4cmVqMGYvNUEyWDllbG9rSkd5djBGaDlidUh5VTFJ?=
 =?utf-8?B?dG0yZnJlaDFoREI0SWRFd0wveitrT1A4aHAvSURva3ByR1hVMys5MURqT29h?=
 =?utf-8?B?VjVSRUhnVkQyWHNpRFl2Q3NBaHJqMzdoOThCb09lN0U4WElvaUlYbnJ1Q2tZ?=
 =?utf-8?B?dnQ2eWgzbzA3MURPamh4aWRnN1dKK0tpWGxNMUM4Rlp6RmpXclhWK1JKNER1?=
 =?utf-8?B?c0l1TEcwdUtvTTErN2FvaXo3cWpLQVhjM0hCQ0dtWmZYN2UxRkVGQytlL3Jt?=
 =?utf-8?B?VzVNL3BlZHF1blJRbzllVTNUbmNzM1B5VndsUnhuc2pISDltR3hlNG9vNE5O?=
 =?utf-8?B?b2daWmpNTEdKeFFmaGtpc1JHcUN1S21mS3FtTlB6V004eXdJaE01SVFvb0VW?=
 =?utf-8?B?WmNjS2t4WDdxaWFKTnFraUVVUVV3bjJmRUlyUUZwME5RRmhWWGU0U3VRODVN?=
 =?utf-8?B?S0xsY3haVHhkazUvRFlmK2VhdE9YQksyVm40Rjh6UjhrOGw2OEk5Q2lyeDgv?=
 =?utf-8?B?c0tabEhQcjNwMHFSekxjdVhOWVM1NFdJRjNwbXN0MG5JU1JxRW40dGRJbjdF?=
 =?utf-8?B?NVExd3hnWDRIKzRHbVUyTVBmcVNkVEdZSGliYWwraTI0RWdnbkZ4b09Sejli?=
 =?utf-8?B?dzRTL0xUTW12S1ZzQjU0YkROOXc2SkVzeDlrU0puNnNiRHlEVVluTTBIMHdS?=
 =?utf-8?B?UDhBTDNMVmJkUU1rNTU2WlVDM3FHYzZlY0VES2t6VSswTFEvQlpRSzNnR0xw?=
 =?utf-8?B?eFFrV1JldTdxU2owcnNBYmNGQ1FwOFcvWlhlNEh1dit6dmxJQ2dZSVU0MDBH?=
 =?utf-8?B?d3BJbjdhbmFjaU5rSzVTb0FuKy90TEpXY05zSVNBaGJ3VkxPVTlmU2RtYUJV?=
 =?utf-8?B?QndMSTZBZEdBUVUrQnZGNS91Q29qRkhHQTU2TlhZcGE1UGVma1JzTGMvOTBu?=
 =?utf-8?B?SXZsWCtvcjJ1WThVT3VPZGtGVjRISG1FRkR3YW5Ick0vQ2dYUXUzcE1sNFVP?=
 =?utf-8?B?Vndqazh3ZDBQTHpZVHRqNzVnOVQvdDJkNVVMcytYYUM1dGtPK2ZnckZOTmpK?=
 =?utf-8?B?YzNhQ25nSnpZSXEwYkk1VG5TWjBneklmejIxRkdSU1hSa2Z1akd3UjJFeGdu?=
 =?utf-8?B?QlAxTWtRTlR2YnRxT0VBY2kvc21FQmh3bm9XQ0ZsNlV5eVo0L04wR0pxem8y?=
 =?utf-8?B?M3I4SnUrUHhtNXJ5QkhTOWhpR2dkQTNlMFo1bUhsVitPd2h2aS92Ri9HWnpB?=
 =?utf-8?B?Q3Nrem1GOE1semxadFl6OU1Yb21hUWh1UlA2Y0FMUDltY0RZT1hkZG1ITm9i?=
 =?utf-8?B?dmVMdjBPcFlTQzNnOWRJV1FnQ0lBS0pDRDBvczNzV1B0QWRoQWpUeFNpeVNy?=
 =?utf-8?B?Uno0R3E3YWhZRTBFMHRFcU9EdzY0c3pwZE9qM3lOQkJWakpSayt5c3E5SUx2?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206e022a-05d8-4351-3c1a-08dcff1f91b4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:30:23.5490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvBGuApbJargCtyOYHwMhbIjAl3Kwn3Bai8FHss56ALXOEKzOjuCjVyVEp19u1yt8CIctQbcrRuK9i1n+kZ6NVXnmfXqDoixSzWLGzsTcGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8417
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 11:30:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17214



On 11/7/24 11:57, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Under the assumption that future versions of Debian will deliver us the
> needed versions of SWUpdate, this eases to opt-in for self-building.
> 
Do we need some additional logic for SWU_SIGNED = 0? As swupdate from 
trixie requires signed updates?

Quirin

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   recipes-core/images/swupdate.inc | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 96994b5c..b1cad439 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -17,9 +17,13 @@ SWU_HW_COMPAT ?= "cip-core-1.0"
>   IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>   IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>   IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -IMAGE_INSTALL += " swupdate"
>   
> -IMAGE_INSTALL:remove:sid = "swupdate"
> -IMAGE_PREINSTALL:append:sid = " swupdate"
> +SWUPDATE_SELFBUILT ?= "0"
> +SWUPDATE_SELFBUILT:buster = "1"
> +SWUPDATE_SELFBUILT:bullseye = "1"
> +SWUPDATE_SELFBUILT:bookworm = "1"
> +
> +IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
> +IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
>   
>   IMAGE_INSTALL += " swupdate-handler-roundrobin"


