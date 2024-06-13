Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A1C27C75
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 16:45:15 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.52])
 by mx.groups.io with SMTP id smtpd.web11.13663.1718297106101936135
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 09:45:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=smdjTJ8Z;
 spf=pass (domain: siemens.com, ip: 40.107.13.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuIEapJYy6c3EVgEMTs0yb4hdbSd+iBtEIndyq5qMpnrwPPWb2b9RiaJAmnBTWXa2C0nDcL4u7PKpJwg5CwhpENHDwEMGKFwMN4Mnr+DcO9o8FMPVUDwaaOTofGAS+MqQ4v7v79ROwyKynoSL0y4LHVscHcJ3HUsg89M1G/DzKMAbAvd7LI+A0R4BP+fL8gxB9IMUMG0F32VIBrGrYMFQyV9AwNtc/2MGTY7Z8lJ0QE3wcpEajqiKXIEX2mkmNhr0xflXSt3Vo9Q8MrFFuClQ0CcR2o88c6GMJUzvRPggQiFFOiGwIm6b1L2Bt6oI4Mip9fob5JgovfZVuebTeZhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkBDK72wk40dAaO26OnIgZSUE6q20Ta8YLxSP8LgGLc=;
 b=eixyZ+coimh0kAqVucDX4ZQ7VpLcOt1pK7sUCPbAweimSGlQZR5WMjrKLnPO8d9YrdB0+f155oZeZQHfL3S0Jre4UMa/9IFl31lSo/meYFQRtvHstqN10fr6egyddQuK6bTGKodtKPp5Qyc1AMfGfcE+jtSxhhRVGYNDmtkWmBYIui7oG8SnRhbXYdmJbs0sWWMWslCx900aisJDZR2M9YIbt55g6AD5YiY9FYB1MOudO/Ofj+DfbXVmZnLjm3O9g9MjZoFrWZE7Ss0lW2kGrwCqc3Eq2EM9AJPcK2g7AYJ/AILZT8S+m8PayP9SjnI82E5bt4EEPEt3Ua7KCCRfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkBDK72wk40dAaO26OnIgZSUE6q20Ta8YLxSP8LgGLc=;
 b=smdjTJ8ZJVyTnqjksP8ecGJ4BW6h8pWLrIP9LQxb92OYN1fsFGMmayfDu0aruS4Yo6PktY39BiTvV8HPbW9BMi2nh0Cq2BztE7Wr0yLp/JUIu9YRDhsbkURibz6i5PuqKG01msxlqZv0pwwP7pf+jxlZRXpW0nIY+4k9Xo84usf14kGHLAa3Bz28Ea1XW9zsIKie4sFrOZx76OFx2/WXOd8wc2YQudU0l3dX6bqkvn5P308FYRs+R+Bwt0hjjaR6qgQMLpXU29ftXsJY5EzQPze28EX8UHGOlNfx0fGXIibnqUIvlFYYqnOP7PoKpC9RJ8Hk6MZ5kON3OA7gJ407ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 16:45:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 16:45:02 +0000
Message-ID: <6f510d36-e6c3-4046-ad4f-3a0bd9c511f4@siemens.com>
Date: Thu, 13 Jun 2024 18:45:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] encrypt partition: Add support
 for swap partition
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240613094845.1167459-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240613094845.1167459-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c083181-d391-4d7e-c677-08dc8bc82c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TERVaXZPY0w3Z3FYK3l4MDJYTXpNWU1KTGZ4cG0zUU9DVlpTV3FvQTR5aUVk?=
 =?utf-8?B?SmNOY0dPL3djbjFYSW4vKzhTSUNja3lvTUlXUytMSGxTNjA3S3hoUHFtaUJU?=
 =?utf-8?B?VUlEWitCd2FNckZoWlNHU3pxeFJ6U2NPVTVWQVdpam9PZ1Q4U2lVY0UxV3dr?=
 =?utf-8?B?S2NwQ3VoYzVVak4yMUpld3pHU3VCVUJxOGVadEtMZkV0d3dvR1VLdEt0WmdX?=
 =?utf-8?B?a1czcHM1ZWZ5VGlBdGRpOTZGbEdiZFVZbzVMMksrSnBUZDFSMDNrL1c3SWNI?=
 =?utf-8?B?cEhXT3poaUhaUjR5dS9OR1dCeXdEMitVc1hQajFPSEJ1V1VkbjFiQzNTeTNp?=
 =?utf-8?B?alYvODBpWWsxandGbk5pYUZnNVFFTk8xS2tBNndNdUhJeDlZMDJQSEVqRHZj?=
 =?utf-8?B?L0N6d21UQmJpbWY5M3huNUV5WVhaNXI0UGJ4NW1PaHkvZVcwelNCOHd5d3Yr?=
 =?utf-8?B?K3hoRXE0ZWd0ZDUwa25PcjZMMXJaUCtpOGN1NXp2MmUvbktUSDRucVBoYklG?=
 =?utf-8?B?V2M0M201MTE0cjRaQm5QUDdTcWFSK082a0hLdUNMay92ZThuWmwrN0NRWFBN?=
 =?utf-8?B?eDZNTWszSkJRcng2c0RScGViL084NnhqeXhPZFlGOGlRM3JSaHhQVUNMUHgy?=
 =?utf-8?B?UVptQXdGVnkxamlFTkpZalpUcVFsN2twdFBHVkZRZUxSRFhNdXJLbCt1SGIx?=
 =?utf-8?B?UHlsNUE1WW1WbjJlUCtWQ1dyUDlzM2RvK05RT3N4SUNzcTljcUp0YjJIOERr?=
 =?utf-8?B?b0ZXVldYL2RJcFhzRVZ3SVgyVUFuSTNOZVJqZ1F0b29oRWJWZENqM2lHODZV?=
 =?utf-8?B?NlEyR2p1QUtPK0VvMzFVRFBaa3lybFRjN09YZjNSZ0p1SjJETWxWMzZtT0ZP?=
 =?utf-8?B?UGJIZytld2l2cTBBbktBTHFIMTJqMjdZakdvd3NuWWxiUE9nNUwwNXRDNjYw?=
 =?utf-8?B?UStZTHdFM2k5dzhnMGNSdjBCUklEQWQwbWNiaHB5TTVWOGpvVERQMlJuTU5q?=
 =?utf-8?B?M3VkMnQ5ZFVRcEVRalM4Rk5ZazVjN05NWGk5L1F2OHM0RExGYlplMFdVTFYw?=
 =?utf-8?B?dzlkK3FtQmRqcmMzYzFzWXRMVFN6OGpvbE4vZURJazRpSzJNcElsMVR1Rjgz?=
 =?utf-8?B?YStOM2FSODM0SVVXVTRWaHJ4VkY1TFZMdnRWNXFTdGMyaXE5WjB3Q01mQVdm?=
 =?utf-8?B?VWxYNytRVHJYSklYeTV0Yk5IMXo5WFI2V2FKUzI1eEZsYXBTSW1aZThwWWxK?=
 =?utf-8?B?U3BQa2gzNTRYNFBodzc0SThIbjVZOWFjQys4NTgwY2R1bld1dnQ3TFI3UHhT?=
 =?utf-8?B?MDUvdnhzK1IwMXhvS3lrckEwSy9rREFmWUZvd3oyNVFibFBBOGJBdGx3WTlC?=
 =?utf-8?B?c2FRdFVYM3M4NDBidDkrWktNeUl2aHNOQk1pQUxreWtlUUxJK2pyeW83bHZV?=
 =?utf-8?B?RmJiWUxweWlycmoxcXYxZ0tldVJTd2JQK0RCRVVwcHozbFFWeDQxbUtlU1My?=
 =?utf-8?B?RC9vRitZUTc5ZUJoaExuak9UcXh1dWYzSmNjc1hESS9rT2xtQXFJY0RFelJp?=
 =?utf-8?B?ZlhtYWhVM3BpZk5qWVVvdHE5cEVWcWN2Y1BuUXNKeDg3ZVVTYXVWcjZrdkt0?=
 =?utf-8?B?V0ZOL2w1TjJQOU9DQTNGSExSM1VkWnhKV3ZoRDJHWUdqcjVsbWdvNWIvRjc1?=
 =?utf-8?B?V0dJSkRqcjhWVWd3Qzg2VVZIbWRtN0VEa1ZDRmFmSGVqb0xvZDdjbU1xSjFq?=
 =?utf-8?Q?fixAxgMhrfvNtvwIaBQiyeWH+HIvp2SmUJmKNcd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L29qR3U0blhIOWtMQkdsVkZFK040dTJaeEtWakJydHB6NVJNNzF0L2RWVWJY?=
 =?utf-8?B?RmZ5YkNWRkRQSFNzWHZrU1lwWUZDeFIzV003RVJ2WnV4d0hSWUJzaHFURXlF?=
 =?utf-8?B?ZURPK3JrT3ZhYUZPRXI4emRMWENaOWlKNXZtNjFsb3Y4NFpNOVZNYmVNTXN3?=
 =?utf-8?B?dUJiZHAxdDgwK3NxM0lsNzl5eFZ2T0xzcmxUakdLeUVIbmUzbE1nL21EbUhB?=
 =?utf-8?B?ZWlqMlNFMi9XazlVaWx6Z2UrVWd5dDZRYStiWGY1N05tdVkzelFLWFdKcTRu?=
 =?utf-8?B?Y0pwWXE5Um9xNW8rVktIdmQrcUtUL21IVWlZek4xeFk3Ujlod0tsUkxKZ3g5?=
 =?utf-8?B?a1JQUCsvcVd5akEvQ25iU0JPTTFIdDhmZ3VrYlZoL2Y2cXBlQjZRa2NtdkVv?=
 =?utf-8?B?Q2xsaktPUEJCTkFiV1lwdERyVDRrd3JuckRjbW44b3F3R1dKSUNjVjZXNHhn?=
 =?utf-8?B?T211Vml3RzZUUVE3dHVOeHZzdGczeXNab2doMUtWUWo3MDBSY0RGNDlxUkQr?=
 =?utf-8?B?NmQrZ0tudmxsZWJvRjBqWUszeXpNdU1UQW9hQVFXQU9zczA2TFRNMHU1bWE4?=
 =?utf-8?B?dEF5ckxncm1LQWtXU1hJME02V0RXS2RhQm1OWCtzb0tmSi9XU0pUUmZ3K2FZ?=
 =?utf-8?B?b3Q1ZDVsZUl0Tnl3cGYxVEJTZzRINE1MSHhGL01jMXl3Qmp4NVZDOHBDWlIv?=
 =?utf-8?B?YWtyS3pqZXRFaS9hRDVaNE5nZEZZVFlLVUVTL2lSMC84RUZnUDBaV2JHUzVh?=
 =?utf-8?B?R3dLZVJVSWVsOURLZk5qSGlXbkhMcE5lbllVb1FVNktjK0xQTGR3Q3NqZ29P?=
 =?utf-8?B?anE2Y1RmL0pBSW95ODdnRTNhSVNiajVDa1lVOFFSa1I3R0orOHdJWVp5T291?=
 =?utf-8?B?Ti96THNpYXVCaWdwdW96UEtIUzRPeGl6U3RvMTVOR0VoTFFST2lBM2VIMGg3?=
 =?utf-8?B?Rk1UU0hoODZWcEVSTXhxZHFqL080TUZ5VE1XLzRFU2k3aDJqVDhjdnhRcXRj?=
 =?utf-8?B?by9yZlRJbExQQ1ErVHQzWVhLZFZ3eGpCcnBtKzFGY1N1emFaVDlrc3l5d01r?=
 =?utf-8?B?ZWZ3ZUx5RU5CdklNNWRUUFpsaExHb2o2OXVqOVNMRmd5SEM1RFRwdFh4QklS?=
 =?utf-8?B?aTF0L0NQMlFpTVB4R2EzNS9FRlNPeVFVendZNWE5WnloZGIyWnJja2dvVHFz?=
 =?utf-8?B?cjdpdjNod0t6eWZsK0piQy9CZm1EMjQyaDRjNXVqdC9UYWxWMDNkRXNYZXYx?=
 =?utf-8?B?c0M5OW1mR1ZGUXcxOE4xR3ZpQUFRQ3FrMExQbDJZSGRVZzFJOG5CRmJaZnVH?=
 =?utf-8?B?SG56N0xWMjQvZ3pEWlVKcWNjZGZrMCtXUmZsdUpqV25veHQ0VEh5dU15MkFQ?=
 =?utf-8?B?RUJjU1V1TjRtbXFpNVB2R3NtYUdRQ1Boc1hpWnFXd1hXNHRWNXdMV3hacnBm?=
 =?utf-8?B?QUU5K3VzOTR2MCsxRG5rMmtTOHNOdlpVemxVNGxKTUNHYVVsaWZ0Rmxzb2lT?=
 =?utf-8?B?c0o4WVB4Nk44SW5oejlRMUtDcmN1blM4a24vLzlDNHEwN0RkbGtNeFBWS3pz?=
 =?utf-8?B?SUZDdVlqdFZWWkpaTDBINUFid1lMWVVaVTlyS3BZWUFiRDJzYXI0dVFkeFMy?=
 =?utf-8?B?OEVQMWErSjdyVzl3UTk5bUY3ZlhsSnl2cEk5Ym1QYjZ0ZzU5ejcxWjBnOVkx?=
 =?utf-8?B?Zzd6aHZnM2ZKSVFZcVBQcWo2UnRRV2tGMWpERFcrMDdMMGlrTHdNWU9HQmJJ?=
 =?utf-8?B?bTJEaUxjejcxenlvNTZqZDhKMEVQdHJEdE1PVzZXOW9zTXZlTWpIQWhsdTg1?=
 =?utf-8?B?bHJaN3FMWFZtWUREdVVkRFV4R082UThrVFdDRzZWR3RuckZ4Z3pCZWZycS8r?=
 =?utf-8?B?ZDFnek5YVENVN21tSGtTc3pHcVBiandSTm1rUTNIT25PRStYNHpKWERieGg5?=
 =?utf-8?B?ZURsSzFXTXI5Qlg3UlJMU2hsUWdkNHdoUzFwV2pRelZ1MGhkemFKVVdSYkZi?=
 =?utf-8?B?ZXVqUjhhajFHVUJtRDBSN2JQa3FGM2pKQysrZzdGSXlGdm5YWmxROGNVRngz?=
 =?utf-8?B?TzN4ZUJtOEpzUXhvMHordVp2QWF0a3FjU0lFdHUvVVBIUHZtTlhvS0xMMlNQ?=
 =?utf-8?B?OGo5SXcvV3p2SjJOaDNRdkM0V2hpT1dyTnJzRzBJK2haa1ZyQkwrVmhVSnhi?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c083181-d391-4d7e-c677-08dc8bc82c01
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:45:02.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEFb3B5tDx85Dg5LogYxbEVMlZXYdTF7b7O4UMrJUbG4Mow71eeSlrsPftTT0fh+8jq6V5MIf/5dMrfoHd4EvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 16:45:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16222

On 13.06.24 11:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This changes allows to encrypt a swap partitions.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.script         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index d48db94..8fccb4c 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -77,7 +77,7 @@ reencrypt_existing_partition() {
>  			panic "reencryption of filesystem $1 cannot continue!"
>  		fi
>  		;;
> -	squashfs|"")
> +	squashfs|swap|"")
>  		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
>  		;;
>  	*)

While not formally a fix, this is trivial enough to still include it
after rc1 - applied, thanks.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


