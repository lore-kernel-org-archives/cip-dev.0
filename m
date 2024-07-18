Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A4C3DA60
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 07:36:29 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.62])
 by mx.groups.io with SMTP id smtpd.web10.10054.1721288178681586998
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 00:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dBcOMAUi;
 spf=pass (domain: siemens.com, ip: 40.107.247.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPT4uKDmwepVVLzzjsktbWVB7Vk7+k89Lw56rOLkIG64hkQeW/MefV/5YWBQKkkopEfM8qQQOyMYktaALMX5uJ3Jiz5r9YayCw1OaCci/moNuc3f5ZBY9lGEJXh1RpT9E06E+FOcXZtm9OTQqzZQzlJwiMlYa3pfbAcR2cdK/OOGjkRV8CNRcxVJjoqBRIXFZ0porGvscBwjZXLqsU9LULKn0tuozrCbkMH8ZOy7Lgr/YtHtI6SUF461UXlLhNmEI31sKlH7hozCqjPWGwK84R+MPS5fScdh1pTSOh90Z37Nar/T/qeHASVR8R5U4qniHGS54pf7PeBvot/5yzuyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTFCR1d/T93j/gv72gNGqys20L3nGZVtUGLLZevNoNM=;
 b=cNdJHJD1LR8Y4QCdQp8+jWLXGqj5CBiMv0LeUqu7he9CidvwQ60lQjWRhpv+QHRqFuQkxfJHN0KqVR95P1W+wUEsUA8bbiw6xoiswHls8fntBhpiV3SnZEHkQ4B0JZ34/1QoZ4GoFDPDFyFEX60gDw2/4Ciu1YWKlsM9o9WfDpiok8P/+QoyPF2Y+reZr3KpIlXpnRsNCbKk6F8BKWkz72R1oR8msziutlkMBrQUBzIGFCS553oNVY0mTfcSNNiFL4RnBT1PL7LrnikbTlLxJcZQHnXnYXa0DDeSeu/CMtQfWHE0FbOnoRTrwQonw1mk6+/z/elCJR9y3bFo2qutyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTFCR1d/T93j/gv72gNGqys20L3nGZVtUGLLZevNoNM=;
 b=dBcOMAUiTvCV4jW6vsMAUo4JkdS9+dC64FQGXT8nK+decuqFyw7wOZvHHjt0xJx/kw5Quclpu1GN4uIJpyTMzrEnecAftROoL76BPGvrSErDXh3PvTps0LwpyfGxg3I0zLge0Bf0KZ3/BspRuZyYKq1FtQhHllIxEjm/FhsYPy1aQRV3lgKtdNd94sdPxLba862EAyFMhRQA2IdeoXVs4dnMSJmGVXMEWgVzzbqhGeXgTbwLnLygdVnm58ins4cbnyBfIiezIu/X8DbvgLVyttsWF2XycIWVCm8NpFSbhv97pKovYPJK+gxZM8Wldzu4Jusav13wc6zgn26H1Qeyuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 07:36:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 07:36:15 +0000
Message-ID: <59dd7734-cf54-4bad-9df1-6023847653c4@siemens.com>
Date: Thu, 18 Jul 2024 09:36:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] wic/x86-uefi-efibootguard: correct the
 partition name
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20240718062455.9560-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240718062455.9560-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bf73c6-c550-4c6d-f6cf-08dca6fc4e74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YWFwU2RMUWt4NHIrd1VYZ3JyKzNWcmNrbDJoc0UyT1NYUlJoQUxhQWdFV2Ra?=
 =?utf-8?B?ZEFpSFZrQVY2eFdRNnVKUEd5a3JMZmNNekIvUUV5Zk0xM3hjbkF4R3BPVHdu?=
 =?utf-8?B?dzdEek9ZUzFXVWk4UGlMckF0RmNSU2JwYnVZMEcyVnBaNmdtK1B0VEJUS1ZQ?=
 =?utf-8?B?bjh0WkhuSlJ0c3dqcXRDK0wzRkxncEE4SlJLZ1ZLUTZybmNoMWQ0QXlVTGdW?=
 =?utf-8?B?MGNFd05iR1QyRllJY3hpVGh5M0t0c3IrL1BmSUw4OU1iY09NdmNzR2FLWGUr?=
 =?utf-8?B?K3ZJY3NwQ0NGc1VDV0FMY2xHaC9oOUpHSmJkV3gyK0NQc2VkdTJZcWFaei9i?=
 =?utf-8?B?eUpmUk9LUGNIemZQSHY1ZENrSGN5TERwU3JLeEhSOHZqbitnVDlUUXdPNWxh?=
 =?utf-8?B?NS9nUzFIdG1GWmU3dy9VQTBZb2dZSDFlUEJnQzBqanplQkdRaVBzRUMzbmlK?=
 =?utf-8?B?NjIzcjBJMXpHL0thSzh5cHN2MDU4dnpDaVlqQnJ1TmpYQzBxRFJRK3dnR042?=
 =?utf-8?B?MUVKUWJzY0RjN0dSTXBNbU9TTXVQR2Q5SUhRTVY3WDZoM1U0UWVqVURhV24v?=
 =?utf-8?B?b0lOR1hTWThjNjN1Q1ljeEVvbVZmTmdQa0d6SmtndXM1YzNNVTd4M01ENldT?=
 =?utf-8?B?eHZXM2U1VnE4ZlVhNWJCL1VLVExrVlJRSFBlS21tWHdNR3BVaUhvZjg5eHNj?=
 =?utf-8?B?blBLVlZVczViSFlmdmpHbU8zZ0J5a0FLTDZlZnU3VC9UcTVtajl6NDJjRkMz?=
 =?utf-8?B?a0NoOE1SOUlIbzlFVllZSXJHVE54WE5zWWRsc1lqVi9UKzU5R0hLeDZESlQw?=
 =?utf-8?B?L1B3SThXRjROTVM0VzR1KzBCRUx5bkNUTXJWb3oyK1duTkZweXgwSm5jQXhD?=
 =?utf-8?B?U25nZ3RWRXpDZnBXc1RUaHM2eGdUTnl6QmplcmpLQjUrankraHVnc1I0NExM?=
 =?utf-8?B?cnc5MDdxbGI3dlRocnF0ZkRXOG9vS29IZmZCSFB2QmpSdUJ4dmdIT1hXRGF2?=
 =?utf-8?B?K2wxRkpXQTVweDgrd0RLYzJ5djJ3TVl0UnVjNzZCQUZJL0lnYVlXM0VKdXpZ?=
 =?utf-8?B?Ym8vZFE3Wm4xODdCYVZvU1dNbHgzZ0dnK1lXaWY0QW54d1dBSXM5WUhrWkNm?=
 =?utf-8?B?YmZpbkZCUnFsMG1RY3JLQU9GLzRiSCtuRldFbXRveTlNN2p2RHVycFFxNkQz?=
 =?utf-8?B?VHNHbFlQRjJSZXB4MHlrYmRzbk4vME1oYWtYRmVyUVc0eWJnd3Z4ZDlvQWRD?=
 =?utf-8?B?U0RVSzg0dmlram43cWFMMndSazR3WXNnbGpIaUIvT0V3aFM5cUNqRStRNnpr?=
 =?utf-8?B?T3ZMS3JmY0lQMDYxMUNYaGNKNlU3SjF2cDJYdFRSKzRsaVJZUDFqRmVjMm5N?=
 =?utf-8?B?N0RyODB3SzI1eHpub1NGZ2tjaHZJTWhVZmc5T0FqUDNOZ1UrQmxYMGVNWWlC?=
 =?utf-8?B?WllBL3YrZkZUUGZuMlpLM0hReDRMQytwR1pyQUZkRmZySlNJcWRSeXB1aXNC?=
 =?utf-8?B?Q2ptaXQzSE5RU0IzYnU3MWFyNGMxT2Y4TlFrbjBuZnV5aGNOZmJyNVhxcFZC?=
 =?utf-8?B?S2dSc2k1TFFMQWFVUUJjcmlEajVTZ1FMaGV4RW5pUkxINFRGcExsdzM2V2s5?=
 =?utf-8?B?WGNkVjQxS1dBYStMRmR3MWRZVzBpWkpYcFd0U3BnK09ZbHNPWGtPS3BDNjRI?=
 =?utf-8?B?SzZPdmlCMmhtcEV5TGl2dGNXV09UOTZxcTdMQ3ZEWDZkcW9pNFpUL1VXUDdD?=
 =?utf-8?B?QXRjTUdzUVdRUDlCZzYveitDdm5Wbkh4UThhR1VmczZTUFNaSzgxZzlSMDZv?=
 =?utf-8?B?ZldsdkJQekZScUtSUlViZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TU9veU5HZDBOR3BEUnR2MGF0dnNzQ0hpdWEzTHA4N2xsNG9zblBEbk84RXlS?=
 =?utf-8?B?R3B6UmRjLzJpZVQ2cStMeFgvckVnUFM2RFNIMkVndGphdUw5T0pkUXlpendi?=
 =?utf-8?B?eTBoa1FOVHRrVDRLTnIxNjZuOUJQTTBPK29GYXpXaWU4SUpSempVK0Y4bWRF?=
 =?utf-8?B?c2QzcGtvK0VKWTRXcmxYNVdTSWJXeENHVEdTV3BVK2tZYTBUM05EdnZvT3pi?=
 =?utf-8?B?RDNlMXY3aHNwMGtObCsvZ1FiYWVqT1N3K0dwREJ6N0hjZ1hVRUtxREYvZC82?=
 =?utf-8?B?UGcrWng4NXRlOUo1ck5DTlNUQ0QwUFBia2E5WDcwYm1kSTNCT0xRTlh5ZFlB?=
 =?utf-8?B?ajE0M0ZzVjdiZ0ZLZWI4NXhaYjRCcWZZbzBEMjQwV1BCOVVLSHpTd1lKM28w?=
 =?utf-8?B?ZVNDTnhkUUF2T2pvWnZQSkJBZDlyc2lQdFFaZXJCZHNORTQ5eFR3eHdsZGpp?=
 =?utf-8?B?OFNwUmg1SlpGeWVaTml4UDQxMGtjemVjVVRJU1E4M1FuNEs3dXhmT2t3UFdq?=
 =?utf-8?B?ODhWc1hXQXBPKzFVemJJM2d3WFJ0bjNlb0xKSFVNOHBDQjRLbUNvUHRsSGdK?=
 =?utf-8?B?dU5HUUpOTFV1cmNwaEVWYk40QVpxdDVpdVlSL096TmdUZjFob2d6TWd2R2NO?=
 =?utf-8?B?M0ZGdnhGcjZkY09zYzRBZVV3am10bEpOSkEveUVEbTNtc3ZrblhralNaTGcw?=
 =?utf-8?B?Z2xZeURsTzk0VVJmaXM3N1ZBQUNpTExzYnNpWlZtd3lOdUFEK1RTbzVDMUhx?=
 =?utf-8?B?ZjdHd0U0aitYakFBdUU1SHpGUktuRFZxMm9CSVJYSDN4L3FQWENBR0orbFRE?=
 =?utf-8?B?YlZwSUF4T3MwNG1kN1ZDQTNPdmt6SnZWZHRkMjJkZ0NXY3NMNTVEdVFnT0p6?=
 =?utf-8?B?V05lTDFkWlFRWkR6WnVWZkduZ0pYTk5JeTc0ZE5ranBNRXVCaG40dUM0eDl3?=
 =?utf-8?B?dTI0ODhrTm1RZHRhc1BHVDRXQytNMHBWYTVqelgzVWxFUThNQ1hiZ2VvT1ZV?=
 =?utf-8?B?M2d1Vk5sT2tnTFk4dE96MjcyUUEvOWx2aFRIYU5lYU95WFZ1RFlEU0x0cHNE?=
 =?utf-8?B?SnJDK1RuZis2NTM3aU5mQW9nMVhVRVYzYjFLWDhZUmZ6bnFPWUhMcWliRjNk?=
 =?utf-8?B?N001cnp4SzdsNlNQdHhtdkVlckI5bjZUcFRjNlVrVGdvVnlUZytCMDlJempu?=
 =?utf-8?B?VWRSNXhuMmt6TlI2RXN5dE90NDdBdE5CVHRpR3YzUG1kVFNDVmNMaEtDcE1x?=
 =?utf-8?B?aC80YVJiVldvblEvdzBVcFRFTTFlVHMzUlZULzNac0NiNlhYTHFvaHN3NXF5?=
 =?utf-8?B?U1pjNnFwQldxQ0wvT053U3M1Y25uWkprakplOGRrYUhOWWZ1Z01ZcjdWN3d1?=
 =?utf-8?B?VnRocWppZlBhZ09zM0FZbytzR1owWC9RWXUvR3U2YmJZV1RnVGtEdlFaL2Va?=
 =?utf-8?B?eEhQUXI3bmI2SElucmxuQ2hMYlhlZ2RqYnBiWE9DWnVScmtjRGVjME9IQXdv?=
 =?utf-8?B?TndPZnpVbkNCU0VoQ04wUjZORkNvMVE4SmptcTVWRDlRajdRU3RoN0p0Z0t6?=
 =?utf-8?B?bDN5bFRraHNTNnhRaldkOC91NVJVTXBTUTVWaWgycVVWc3psbnFDQm1aK2Qw?=
 =?utf-8?B?cUlsQ3FoZ3FTVS9GWDJqVEdtcEZJVlVaTktHQlFKdmVhbW02L29DRHVTNmJw?=
 =?utf-8?B?amJMNUF5RWNyVGl6K2pGNWhRcUNXY1dFT0EwTXZ4cWxSM1Vjd3IxQ3ZYYkZO?=
 =?utf-8?B?RFcvdXNRVWFadm16enpnK1pNc2g2cEJFb2NxUmZIdWNzNFFwZTNmb2pZa25B?=
 =?utf-8?B?Z1BRQ3FTYlVTQkIvSTZTTFFFTVhIZWZiODZiQ2dualJOTTVNRWdTY0FZY0Ft?=
 =?utf-8?B?R3htRjFySEhVSCtoVm5ibHhBV2dmd1p4Q0RCKzBQVFo0bUlkdDArV3drY0hl?=
 =?utf-8?B?b0Z1Z3pFL1FSZXJWV01zOGt1eHJTZ1lyMithdE9IYWlDN1lDTnl6WUVjTlZT?=
 =?utf-8?B?TWoyYjJld0xNdXNrekFvN3VxTjV0dFc5NFdQZmJZdFB4TWRvSHBxK3V4aVY2?=
 =?utf-8?B?czJPZ0Fja0dGWEVaNkk3YWVmYjFYUDQ4TUF5a1hQQ3BIME9ib2lQMG9vby9n?=
 =?utf-8?B?Q3loYnRnQTNpdG13cG1yVmNSUlF3dVcvVHRTay8zSVZka0ZWZWFwVHFzMjZQ?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bf73c6-c550-4c6d-f6cf-08dca6fc4e74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 07:36:15.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSdE34e2nm/sFkzABVkfwqrEjQw62/8zsT7ClPeqhpYtEVDeinFn48aOGotX0WqZ57atk515r+Y+1khNvsdXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8231
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 07:36:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16576

On 18.07.24 08:24, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Use the correct partition name for partition B.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  wic/x86-uefi-efibootguard.wks.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
> index 4c0484f..a1cebc1 100644
> --- a/wic/x86-uefi-efibootguard.wks.in
> +++ b/wic/x86-uefi-efibootguard.wks.in
> @@ -4,7 +4,7 @@
>  include ebg-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> -part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
>  

Thanks, applied. We are not relying on the names (for good reasons), so
this remained unnoticed so far.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


