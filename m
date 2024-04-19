Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08CC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 16:29:23 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.64])
 by mx.groups.io with SMTP id smtpd.web10.25888.1713544155834012811
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 09:29:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f+ecRidc;
 spf=pass (domain: siemens.com, ip: 40.107.22.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PokKV2EQNZ/sLup2rv9GDf77mGO3EWbyzxZC8up8+5oEK1fsoha0+/m7tyng1Gf7a04xdnxdAa402YVLerogeswXIqv00Nfro+HsOKoI3m6nkUyunw6eTrWYfrgUmuP0WxvdDkau7lQKlu7BzAOilEfQ7NMFpq3rwZ3onwXW3aEv1eQ8veAdTyP+UJjj3de/HupTzoCD+Xvqho23KLlT0S6fkihrjWtdk3L38TIFl0Vtcb9ykU7Vwbj8Gf7VJXw67H8Fk0O3jF48PzpgDHVkon7lwCwvElq27064Xeru+sqq/5fRDPg2NRcWjJeZ1OOEovA/BG6YlsGTppy9Yz+QHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrtHCMaEayCzu3Oa3qZQSsjjHSfVbQ1YT0UGOpXQ5EM=;
 b=gbhUr9iheaM5hCnGJjbZ11Wbg/z1VBxD6iU0fjbbvMk8JUBRSVh3ovZcriooaOvZXn8Cqo/sW40Eq9SnSCEg8dRsp+mnqZ4IQVpVZ88zIlyRLSvrj8TUc+Hpf5ZEXqWWj/Fhw04vfwDUNdaz7qxbTuHdoDhRebt+45GVNzD25RiXKkO1aejwQtIaayuzzLcVpMgS5a0pl94j7LGhDHAovS0IimfCubhxPXVnfrNqfpjHVR7JdxdzrgWH1Kz2NHsNUg/Ma8GSyRCxoDnwV8EbPYGSFUAcMrPLOaAvBm05MYgyq3heS0TM3RF02SVOkbtDtB9e4ic9OKXks02AocU7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrtHCMaEayCzu3Oa3qZQSsjjHSfVbQ1YT0UGOpXQ5EM=;
 b=f+ecRidcTBcqMGME8ZTVSusOkVFdvdtTdfLAzeKeL21Z3YD94VDfzLP0U9GURrYJvE6Zr/pyscDdgELlQbXtFzt2+gBBGRzkehrXXh6DX1cBRewRRy1N0REU+p9sgYYiFk9i1YB0TDzzgpyaTGg/yhPGRixlVcmnYjNZhovtWJsmb66vT58KnuUNUB9CmAS2CKoY/RPZ00OV0cJFEu5USjEx03Ub7yaP+zydANtsZ89NJh8k11wXL8DPY/W2Do3e89nos6t844pq3J3gV33+RQhPdidpn75n/fjrvVZDbkck9grXR6OEhdXrcPtOfXG99v9PbKf+fm4GpGHaFWP/8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 16:29:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 16:29:13 +0000
Message-ID: <8c11a82d-c489-40f8-b150-ab3e9d3922d7@siemens.com>
Date: Fri, 19 Apr 2024 09:29:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/7] fix: disk formatting
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, johnxw@amazon.com,
 cip-dev@lists.cip-project.org
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
 <20240419082036.2389583-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240419082036.2389583-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9f2a0d-adbc-4698-7f13-08dc608dd92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L1NYWjJobFJJM24xZmQxODBjYjgraUtQTHZzM3BIaU9CbkR1blVnTnAyTVlB?=
 =?utf-8?B?NjBRZHVIcTNaL1Z4NnpSUmducWV0UWJpMjFYTFZyR2ptWHhpWnpnV3pUaE9X?=
 =?utf-8?B?RWhVaFRldzhUUDdiVHNZZmp2R0VueHI3d1NQMzMrR2ZQY2d5cjZNUnJLNDFP?=
 =?utf-8?B?Y2t1QTFsaG8vbXBFVzBjQWlzRURwUHdIbitjeDdoL1BUR1l3K1FuRnZUSmZQ?=
 =?utf-8?B?YVZEZlp0b3U0UVVqR0pLUFdxbDNWNko1dEZzbWduTVRPTmQyR0dTR1UrU2pr?=
 =?utf-8?B?MXdkOFN4M1h3d0FPQ3UwSTlQWDd1SUU5cHJ5T3FVcFlVc2o1eW5JaXA1K3hF?=
 =?utf-8?B?SzBQUFFwY3VFWmJhR3hZQlZBQjVicVk1M0QyL0libCtNLzdGcFdkVHRIL3pQ?=
 =?utf-8?B?WGZ2SmxNT0ZhOGZqZ215aWtFV2FYMU01amJPanlNNjhoWTVSUzU3VFkwMWk1?=
 =?utf-8?B?WmpNQzJtYWNwN052UWlBTTV3NGtIWnYyc01qMzdmOGI0WlVMYk1RY1JFYTZB?=
 =?utf-8?B?WVJtd3VlbVJ3NWcwbE53UFJGUE5UVTRWUjIrR2tKYUptc24zV2Vkbm9HK0I4?=
 =?utf-8?B?aVl2eVVwTTZFWnJRejVnTHdaVlFjUy9YZDhVRHY1NFcvUFk3aUZ0ZEx6cjdy?=
 =?utf-8?B?Z1VUNlJtTGJtT25kUWM0T3FrRHMvMDYvYk1sUk5IRFFIaDV1ak5iVGk1NEwv?=
 =?utf-8?B?cmE2K1JFcHV0OWhZSitoOXdJRjNTWitjVHR1VUlMdFdWRkx6WFlucXRvZ0Ja?=
 =?utf-8?B?TVR0WGVZL0w2dTRTUWFYNTBocFI2bVNQYzJiUExFNFYvVFM3YnlmNVdweGdD?=
 =?utf-8?B?NHd6eCt4V1hJVnhweHNZMzdqaXVmaGY4ZlVqN0tDSGl3YVdTUGo0TGZZWGVO?=
 =?utf-8?B?QjFOYys0cFdYT2lkM1M2aDg1cmhaTGpHR2VQdE82c1ljT3QrOEpua29Fd1Vm?=
 =?utf-8?B?UnpkVG4zMGlGdlorMEpKSUJ5NWNYN2NxMHhDbVp0bHpQWDcvTDdGYjRPZEJO?=
 =?utf-8?B?KzlKbDRYMFRWYkFuTG9LbGNaUThQY2wrc2d1WkRSWEdseVVON1NqSmhCU0Qw?=
 =?utf-8?B?clZyM0FwRXNOTFRrRG15bkFGTmhMald6V1B0QlhWNk1aTzFxTnBwZE5lYyta?=
 =?utf-8?B?aWJvMG5uOG1BeEdlRVV5TTI4bnpWM1dxa1VJbnlVWVRJUG5QdGZ6YVlDYlhT?=
 =?utf-8?B?aWVWdThSRzNOcWIwVGdMSDJvZi81R3gxTDdmSlVmbzYzMVorZnBnRnREOWtX?=
 =?utf-8?B?SDl5T2d5ZGpGTGtnOWlrZXdjblVCTVQySGRGMThFcHVtaW1WaTRkWGdSeFIy?=
 =?utf-8?B?dEtZbXFFQ1IwaE9sd2lrRFUwcWJCRndUbi9FZGJTTjJPQy9NMHgwZzVIRnpm?=
 =?utf-8?B?TzM1UjR1dGE0KzBZTTFvb0NCcHNjaXlCUGNkbzd1cXAxNE1pbWFyN3dTNE90?=
 =?utf-8?B?REZmQWNnak82aW5NZnJUZ2NZN29RQWwyRlNONTBWQTBWVlBMWDJNdkFRdVZ3?=
 =?utf-8?B?RFJRSUlIZDZQZTN2U0xybmNvQVZ4WTBqWCtHTk1IK0tOci82MXErNWRDL3dV?=
 =?utf-8?B?bTI3ZklpV2pDaFJqb3VGVi9PNlBQTCtoUENSSGl5eUp5RkVXQnNwK09KQTRy?=
 =?utf-8?B?cGZEVUx3L0s4STdETFRZcEdEa3VPNUxMem1pSDUyVkhZcndVdzk4dzNxSEFS?=
 =?utf-8?B?WGZlNzAxL3g0MFFNTXlsQWJTbkF3MUJRa1JBeXBQZldkVGJSeFZxMmN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?REU2djhGemtmU0FBUWRJa0RYaVVBdVhIU3hXR3JuR3o5dDZUa1hUM3ZXa1pC?=
 =?utf-8?B?OGdBaExQaFpyMGU5UmZ3TkpoZFRnejVnRHhOZTlEMmtkRkVJR3gwTmFuUUFr?=
 =?utf-8?B?Y3ZWWXkxQ0krNnRqd2xQcHE4Y2VmaWZxa2FxRHFITEdISDVGRDAvUHU5Uk5C?=
 =?utf-8?B?eGdLWUxkWnpqZEdybExscTFycjdqMXNaeWREV0RxUTQ0MzhGUWRVdkFJS3dP?=
 =?utf-8?B?UHJFTmtaM01LdU5sTDFGeE5IMk1meHR6emtVVDZZSzc3ZkdxSVdnOXprb1Y0?=
 =?utf-8?B?b2UwcnFteTNlVXlDcnhydXBTM0ZEWGp4em9rdEhrVThPR2V3Z3A5UTBadnpO?=
 =?utf-8?B?YlFXcmVEek5Ub2d5aHVGN0JTMk52TldTMjRXVjMyTkZzYUZZZDF1a1NsN29R?=
 =?utf-8?B?YVloNUg3UEMvbmVqSk1zd0ZrazlURVZsZUpwaHRIQlVWR040alF6MS9DbWlW?=
 =?utf-8?B?VUIvVHV6a1Z2czZNeHhUVXNJaWc3NzBLV0FFWnZmQmxycnh3NVFZOEh2aFA3?=
 =?utf-8?B?U3RLRmFjbkhranFsMlVnS2tTVHZLNEZad2psYWptMklLU1ByQW0xamRlV3Vi?=
 =?utf-8?B?aVRRaWE4SUJSMXBwYjJXeWQ0b1pDTTNXZWlHQW80RzVqdGg5c1UvaVRuU3NC?=
 =?utf-8?B?d25zaGIzOHBOVzh0NEZqNmR1MnFFMERYbzU4T2c5SmtZZ2h5QVhJc3Roa2xC?=
 =?utf-8?B?ZlJyVHN5THhpbWRwdjFNR21TRlBXWW5YdXBXWDFvT2FxVzBRMTkya3BDalVJ?=
 =?utf-8?B?ejZybnBkQVBnc1paelRjT2JkU1h4V2ZnNGNYdEZPUUY0R1VpVzk4Ny9wemZ0?=
 =?utf-8?B?V1Fqb2I0MklNdWV5Qml3SmRGY1g3RWozOWVxVzNQSUZjSXlPNytsdmswK3ha?=
 =?utf-8?B?Z1liTThSL3M2SmVFRWhnV0JjeXpKa1dwOCtNZHVPRkdISnVWcE1TaGFBbERl?=
 =?utf-8?B?Z3U5aU04VVE0WkhQNjN4Qjc1VStlM0lyNGJkT0tSbjBpRDM2cHVzTzV5RFFt?=
 =?utf-8?B?QjQ3Q0NWamNQZEZtMWlkRDhCbmV0cXRpN1FZREErQ25pSXRSWHA3eE1NUlNq?=
 =?utf-8?B?cFlmSGJYNFZVL3VZVnJCZGYwQnFtWEVXNVh4a1pCeDNFQWxpV1RDQXNFdlRO?=
 =?utf-8?B?UmxCVE5PcXVKVVhCQWhyYjB0UlBVOHBwTEZUTU8rQ1YvQWVjZHpUMkhaSXVG?=
 =?utf-8?B?ZHpacDJ1QzVNUE1xN2kxeEJnYnpnOTlWaGJNK3Izb25oQzZKWkN5WXZCc1F4?=
 =?utf-8?B?NlJzeit1OFd0RWJDUzJ6amNubU4zL0htOTdTOTlCRnEwdHVzemVQV216OExj?=
 =?utf-8?B?cG9UeFVKSzhxWkM2cGY0eU5raXcvRUQvZGdGaTV3UXFLTlZIYmpqeExTcjBz?=
 =?utf-8?B?M3pvdkpXekdjOHpQNzZPcVhpQkcwOVd3VGxzaUI5TUFPTk5FTTNiV0d2Kzcx?=
 =?utf-8?B?NmNGN1ZiWHFxT0FzWEV1U004YmZCYkkvUmhEWFFIY2pGdmdTRERCMlhPQ0U5?=
 =?utf-8?B?SmV5dllZTzBRbzhBRXBCVjUrbUNJWW40bmtQMHY0SzRCRm1jaWtPQW1lVjBw?=
 =?utf-8?B?c1RoSkpSSE8weENQQW5wUThDdnFTOXMzYkZtMFlYWU9ZYWlrTlkzS1A5TmVT?=
 =?utf-8?B?Vk9wRERZR3NYM3Fhd3BrUjF6bVJmb25oTkJUUXhHNGdTYTZHU1hkS3F0N0Fa?=
 =?utf-8?B?ZndvQjFPRnRJaDZsaFdNaW1FRndpRnBQbGdSYWZpM1FnejlvZXY1YXFhRTNx?=
 =?utf-8?B?YUY3MHpqc0NMSHVjQlhSdFA4emZIZFZOaVhnYzlQS2t5RUtuYWpidHFPQUpq?=
 =?utf-8?B?MXVGWnJ6L29oblh3TFFlSHd3Zk91eWJZakRZOWZmTXZac0FlV2FZNkUveHVK?=
 =?utf-8?B?ZHpTY2pRMXQwelVYM081R2N6RmVzdjA4VGRxR0FoTkRYOTZ6WVJXWENuMzhE?=
 =?utf-8?B?WEpidUEvdUJFSVpCQVprYTV6cEUrT2RKOGdZcFpxSk5XYStlMFJkQ0pFdWpx?=
 =?utf-8?B?emdzdVEwUWRZMnR4aGg5QThHVGpCZFQ0cVlCdnRzRkRacWJXZWVNWlBwNXBw?=
 =?utf-8?B?eE9GT0FmM3hOdElNRFFVRFJYelliRzdvSU8xcmtrcU1kYWN1YmpCY2prUDkx?=
 =?utf-8?Q?GpzwZVh1Ddns5hxYUdajnOHLP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9f2a0d-adbc-4698-7f13-08dc608dd92c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:29:13.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCbH9gcTZ8lkLnYo0SZkIkNaC8jIxcMgvZ29X4uvy49XGtsETj/lN8nsgIetBTbv0zISoNmRHVoRpmBVNUZkjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 16:29:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15703

On 19.04.24 10:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an regression from cfef8103a0385c0d6c4631f23aabcdf65de4efba.
> As the format path was not update to the new function arguments.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index 8763f69..8f6cbf6 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -147,7 +147,7 @@ for partition_set in $partition_sets; do
>  		"format")
>  			/usr/sbin/cryptsetup luksFormat --batch-mode \
>  				 --type luks2 "$partition" < "$tmp_key"
> -			enroll_tpm2_token "$part_device" "$tmp_key"
> +			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  			eval "${create_file_system_cmd} ${decrypted_part}"
>  		;;

Merging this one as fix already.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


