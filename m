Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C054C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 20:34:28 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.58])
 by mx.groups.io with SMTP id smtpd.web11.4737.1718742861494819677
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 13:34:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=enOjZlsV;
 spf=pass (domain: siemens.com, ip: 40.107.21.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCDXqFUAj9ABf3mhf6PCWYXHbzhKk7IfTMsWZM+4czuaD03O49y5DeYhQ9aZkTXmnGumEVURUwk/mwrkZDDHVVdc5ilnoUAU9P3wkmHQRLvXmRG/ZkIsQ6mvzXoNAo6a9VKWCZ8Cc+y2KuwjbARTxc2yrt98XNyowMLbVLHUQBt8ewXjmNEO/8lP+gIMyRSCQ5Zxf5GgYRUz2xGjLT/Oygmgus/nXazSA+gOwDnZyr+d+yKpImZgoPyG89aUcuDK6hUaWGvceKSKdm+aKg2rGgmvMx3uBts5tCQ9VB0ZGREc8uRMFIPryB0YkBFwgOqPG47rKmBcHSgOd+ctJY9pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PwyXtxfYfbfLrC3rJxBHFllFJUWE826Ds+bdlAY4qg=;
 b=NUyzKdgt28CtsZYjNBHSaqfSFKmWi84dmj1SAFz7hP3ZPTAT3uPlBFMPDKxuPVbayVPGe35fU4RNlTJ5LaaZSYK/IEwZw8ylot6oF4OD2apRnx+/rcTGaJqIiL3ds3RmoH9K5DsyNXUywqqovIChMLcQJx29m9PLjfCCkgxGQt/VFWsF2oofQasx0r1Lg7fO8Qf1uCcpMhv/5h8eFpu6Z6hp/phiW/elEBwTsV3Y6txu94RLDCWXDMpIV/oJz0G6IZ45zss8o0rUNDeDBSpLBVx5stJappN+Goaa1HyWQc3YVoBTq8SGv19Uy8WMerDBhDcGvG9cxD3O+urQI0U3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PwyXtxfYfbfLrC3rJxBHFllFJUWE826Ds+bdlAY4qg=;
 b=enOjZlsVY5ibbc203oLQrOJKPMsyLbgFZhXQ4GkBk10k8WCCm0DZqlFMJBPpIIzn/0oEqR1qacSvsr0KbdDXWZjtgre38OwNBEiDCXov+LAgO2z9cm5s76S+LT+JO5tTSylp/6ggikq/2kEYa8YQBGEQeEfUrV81bo+t/WMhKvuNpS9UgFGruzaNeZ7uEKAYddKsS/daML5pOEHiHszSVK0d3ILa25d7tcR2Z2JDCIkGirof0aaEymgpgc8tGp44caEnTiZJVuXVitlkbTHQU3rDmWduDGuJN3nRV4bKUErrSHGOxwIYcoUYNQCOzuKwfx+fbsbgrGj+miMccmr6YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:34:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:34:17 +0000
Message-ID: <9a9a56de-90b4-4cbc-94d1-7aae0aff2108@siemens.com>
Date: Tue, 18 Jun 2024 22:34:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 0/3] Minor corrections to CIP Core testing
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 12233db3-2732-401c-b7b3-08dc8fd606b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UFVGZTZNNXQ1SWJmNW51cUtaampOOU9qMHJrN21UZ1A0UXhxZndPVGVZTm1Z?=
 =?utf-8?B?bVkvcitlbmN6eG9rNjlKVXZ0YVYyQlNYbm13cXZicTc4Q2U5QzR4WXJjakgv?=
 =?utf-8?B?eWlhQUc0Q0NkUERGV29oalhPb3NjenJueWFIRFFlVHVRRmFFem4wL0VKS0hm?=
 =?utf-8?B?aVNsbE9IcENKK013UFBHNm1LSnljRlB2Qmh6Tm5NZlo0UW5pSWdSRTQwTkNZ?=
 =?utf-8?B?c1VKeU85d0swcHF6Nm5xWkt1b2tjV0JTMDBzMkZoekJsQXJYSEpJRm1pcFBK?=
 =?utf-8?B?UEtoYmpIK1pzTmpvSFowWmdvei9nZHV3VlA0RTJFS3RMVGlSajlHblVoeHVQ?=
 =?utf-8?B?VndTVDNkd3F1eEx1SGVxSXptZnJRMTZ2cythTVNtb3dKcEM3MmZlMzlITm5Z?=
 =?utf-8?B?MzJBSHBLRVkwZ2JjNXJLRmRDK2RxT0llbFkvb2d5Rmk0Y1hza2lxZTEvMFlC?=
 =?utf-8?B?eXZEcE1zUXR3a1poRUZQZXV5OG5lUVNiK3lUOHlGWE5TZVBZZFZWdHJmTGVj?=
 =?utf-8?B?YlJCRGtDeXE3VVBCZEJFRlJmYjBvR2YyRG9YKzNvczRxYkdQMlJ2RHNaUGpq?=
 =?utf-8?B?RXQzeXQ3OUoySm1qTXlzRW9YdW00MjV2WXE3Vm5md0FxYUVVamZPTjJkVzMz?=
 =?utf-8?B?aHhSTzJnc0tONCtsSGlSaGR4Y1BBUzR4cjVZNVlBSUdNQThSRm9NWmhZQnps?=
 =?utf-8?B?cjVjeDBJTjFlcTdMMzFHQnd4TnBSS3JMK0xEKzJhd0F0Nks3TElJKzVpc1hr?=
 =?utf-8?B?ZGdUVHN3VkNuRU9OeWZzQkZTNGpTQ3l3bEdEZE15TU5rQ0p5YVRTRTF4OWky?=
 =?utf-8?B?WmI1R1ZtSEhtVTZUTUtyQ3RYa2I3QnI1Z1ZCcDBnNUZheThxcXFTQU1sT05T?=
 =?utf-8?B?aW02YmM2Um05ZTRUNlpZa011QWJ6VytJMHRUQ2N6WlVCNWhoR3Z0UHBIaUlE?=
 =?utf-8?B?MVk2ZVNuUDg5L2xDTUlabkM2R0VHQ054blN6V0xialBiUUJ5QXNkc3pxUlE0?=
 =?utf-8?B?YitBbWt6Y3huUXQzSEROOVlFYTlsSms0S21VZEpld2kzaXFtT3QvaFpGUXZ3?=
 =?utf-8?B?YkJ6SWdYUVQrWHhsRERSUzg4MmdwZTZCampoQU1tbFcyckk1MkFGa2lsZ0Rh?=
 =?utf-8?B?MVhaRkhpclVRMzBLUEZrYjgyZUQ1ZktiNDF3THcyd3JwbXRSckJDQmRLT2Ni?=
 =?utf-8?B?UHIwTktobGRxaURNMWYvQ0pjbWgwNEdsa0NkTWNDSDZJRjRFdjhuTnBsVjNu?=
 =?utf-8?B?c21kdE5JbDlLZUNWVjVsNkJ3bFIxdDhReTVuTnBzLy96MDgzY0traDFsakRJ?=
 =?utf-8?B?MWpNcGZHazhGeHFUYVJZZm1qSVp4NTQzZEhoL2VIVFJ2QkloMkl3NjV0M3NE?=
 =?utf-8?B?VWdXZytxeEw3eTd2QW1CYVBXcElWZFN5NVZlMWl0ZFdRMC91ZkdOZmVRaU5X?=
 =?utf-8?B?MDd4cDk1UHVIUHVkNEtjUlVxUEZRNXErSFl4RVNmNDJWa3kwb3VsTU5QdjVY?=
 =?utf-8?B?SG1icSt0WmU0R3B4NSs1TmRmcjBPL3pmRzdVb1lMdGx5VHgrdHlQS1dSVzM5?=
 =?utf-8?B?K3ovcmszRE9QM3NJS052OWJEMGZjaHFNVlMybnZHVi9QUVYyeGp5L2I3Y0E2?=
 =?utf-8?B?Vmp5RjdFQmhVTjhsMUdCbHFleGlBZ0FnVUpJUkErSWlCSG1PbHpQeExPNHE4?=
 =?utf-8?B?Z0pQTFV3UEpLb2hON2t2ZEpaVjdwT0VuV1ZYRXF5cExLUXpObXQ3ZWgwNFVJ?=
 =?utf-8?Q?vkAmuzoYvdKNBjEmUY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjdTVWRiSFRqcTRnNGxqMXEyWmQvRzdRUkxRM1FYZHkzVGQxRDFXYTRRSFBi?=
 =?utf-8?B?NUh1dzNmNVR5am01SWJMVEVicU5TdzdBWS9ITHdnS2xlVFNPdDZuSHlzeUxR?=
 =?utf-8?B?aURjOCtXY3pIUXA1UHk1NnRUcGtpL3dGTjJvNXljdGpKUUZrR2c4L04xNDVQ?=
 =?utf-8?B?N0hFLzB3cFpWZ2NFWDFDWDJWSGZydVcvTFhjWlVuQmhzdTNmVkl5ZWpGa0NH?=
 =?utf-8?B?dng0SmFaOFRRTElPa3E3UEtmb1V1dmhrTDVZWmg2VGNac2sxRFVpb283YjZq?=
 =?utf-8?B?VHhXQVF3L044WlVUbmIrMEdxdG1WalBLZndEYWNlN0lWN3lHRUNJZ1AyR0Vm?=
 =?utf-8?B?b0NSdlZuWHRzQWROMHJQOTVPWkNka1UwUklicmNURWFFdmI5YlV0TjFESk0x?=
 =?utf-8?B?aTdyT0ZmbDJaVEFiUHJkTEpoMWVjQjZlWjZxT2R2NlpIYmdEd1duWEtVM3VY?=
 =?utf-8?B?YXc3c0FaSjlDR0NpMzBMdDdKZGxoUHpnU0xSZ1MxbDZZamhWM3c0UXNQSjVW?=
 =?utf-8?B?elR6aWNYelZNWURMLzNDN3ovVnhhN1VaUnYxRERoTWNnbEphZW9ma0xWS0ZV?=
 =?utf-8?B?T2FmNit0WlI2cTVDNG5ZSG9jVS9XbmliUCtSVGpsY0hWSmFNYmI0N3dHSDNq?=
 =?utf-8?B?Q1RsaHJ0K0FaYXlWbU1ROE1tQzlmalJPRUl1U0JSbzBtOW5EVnQvU2pEVVE4?=
 =?utf-8?B?NS9heGRUVXVBN2lsaFVhSnNyMzhwRnI3N2Uxeko0NmsrNTNNSWlhNldqNXpO?=
 =?utf-8?B?OG9BUzYvWFVjdXhNVmEyZDRPbEt3NjI5bWxrYkFmdmY3ZUpRNDRTdEZ1SkJW?=
 =?utf-8?B?UWNkdi9UNi9TZEZ0YWJVQk5rWGswNGJQTnNSclU5Nk9JNUR4TzViOFhCaUNi?=
 =?utf-8?B?cU1lMEYyWXVBTVRWSDljcE55R1hiQm9lNVphRXg3OThzd090L1NRZHhxczJD?=
 =?utf-8?B?S2ppOG1jczQ5Q05LRWxncWFtMyt1bnZtenZvTGJtNjJHdXlaUmdEbytFZW0w?=
 =?utf-8?B?bjNCZ09UbkVYTkgzVmdKRm5neDRKVGZLK1JseC8rOGZBdmJ0YzNxMERVNXN2?=
 =?utf-8?B?U1owUDM1NGJVNzhObG8rc21sQUthdkg0MnFPTk1SNHRRbndJSHNEMzN1eERp?=
 =?utf-8?B?c0wxY2swbnF1VmhQUjg0RDlvT2RPYnBNUkNPbElxdzVwTGxncjZFb0RwU0Q2?=
 =?utf-8?B?S1FHdlo3Qjh5bW9mdUpSYXBnZ1UzRDBLUGJkUms1eEVYWHZCY0w4UjlzNk8z?=
 =?utf-8?B?WXJqWFI0MGFzL0dRaDE3UEVZeXVoVVliT3E1anBqWFNiOHpRQUJoeGRucGVl?=
 =?utf-8?B?dDl2ZG82eGxSQ0J1bWVmVG4xa0pkRzh4M05ZU25scEdOWHpZdStqMnYraUY4?=
 =?utf-8?B?SDNBWDBCeXhONDIzcU5TRkZ6RUYxY0JTWUVCOENUeU5Pbi9lMHZYem5WYk4y?=
 =?utf-8?B?M1Vxdk1ZalZ2V0lLcnBWdDRLa3Z1ZFdWZ2NrSGlKVEJhSUVXK2EzNkpZZTZX?=
 =?utf-8?B?Z01vd1AycUJha2lXUUhYSzdFd3VDdTRianYyTmoybHhHb1Q5RFpqZGI1MVZz?=
 =?utf-8?B?Q01RZWNMNUVoVEVLeS9JVVdUL2RTMFN4dXB4OUZZQ0xrL2Zoa1lJaXh1U3R0?=
 =?utf-8?B?KzBTQnZYSEtod0h6SEpIRFZMUWNuRjJUVHB2bTRLL0VYRmpaZnptR2VlWDNk?=
 =?utf-8?B?dmNid0VHYlVKOXZBemNUOGF1eFR1ejNzTU1pV0hWTXgwTk9IWTFEN0xLNnVC?=
 =?utf-8?B?N1Z0TmMyL0NjZGMzWUQ0bFlNSWZhcVdBeDNaZGduSlpyRnk4VXh5Mk53VVMv?=
 =?utf-8?B?VDgvaXQ4Tkx0YWZQS1lUalNEM0JKS292WHZPOGFZZHhpaC82RGwzajh3Uitl?=
 =?utf-8?B?NzRFTGY3WTZRQmRaOFd0UllseG1lbGRkeXdPSnRoanBVanh0MnZrRlF0TjNm?=
 =?utf-8?B?UXZUVUVqcnV3b2Q2dTFVU1JCQ00yRThOMWJucU9iNktDSTMyL3Jac29EaHhU?=
 =?utf-8?B?WjA3TFdnQnlVWHZ4MnloQlFJVEJQd01tK21oNW1LTTZCMExGdlNrT21tTzEy?=
 =?utf-8?B?NjRTVms1NDlzRU5uSkp3dE5mV1hYcm5jRDFoMkQ5ZUtXcmZPRXFmZXk0ZHNP?=
 =?utf-8?B?R0h5NG1sWFdZVURESjcrMDM0YkIzZC9vWGdFcGtjbk8rb1JhcWpmVkFManAx?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12233db3-2732-401c-b7b3-08dc8fd606b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:34:17.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2Vg3/KTU6sDkCfBsRbe6NhDWzRHl5UV1qp7uhtyAsPsFpTPsCU/NBeCmfGbetZ20AYzZH6hFiLJiHgL4B4Oog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8096
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 20:34:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16289

On 18.06.24 18:10, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This series of patches rectify minor issues found while checking the
> test job results.
> 
> sai ashrith sathujoda (3):
>   templates/swupdate_template.yml: Fail the job immediately after
>     unexpected outcome
>   submit_lava.sh: Rectify the ustate value in case of a rollback
>     scenario
>   .gitlab-ci.yml: Add relevant qemu target in 'needs' for test targets
> 
>  .gitlab-ci.yml                        | 12 +++++++++++-
>  scripts/submit_lava.sh                |  3 ++-
>  tests/templates/swupdate_template.yml |  8 ++++----
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


