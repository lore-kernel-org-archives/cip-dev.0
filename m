Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171C7C02197
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:38:22 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web11.94008.1738604294053476138
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 09:38:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WbObHFv0;
 spf=pass (domain: siemens.com, ip: 40.107.22.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JExQLATn86DLGfLAQgBEbF7i6LkSXj747aNCHzHtBbeAcEfzMP5m3uLnm/jMpUOAV5aBBWqo89FEf8J0yUFTOtQqBnl6dkUKD3I0gCM7BJJm12xB9cogOVcDpNiuc8OQA8xjFvjPOYzIGwySw+ZK3cbipRlW3212qCR5UIhjunKx2+Fvow7vsW+R3BIHILpmm63PRKS73uqhkWf9HfaiRIGxlnjbhCCgVKBNGfL+t17Y7hKbPOqGo3i2FjzY91vuxbUllNLKVN5xlyE0nWDTaQY27B89tdsF/+Kr2/aebhEAdUppq6m13Ctzdvui0A9G6m1GBDB/V8FVXpCTRyipeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjPgHarm0wG4HZPOB61QehgUH35koP0ZJtLHvZclRk4=;
 b=IpP76glj+zYOs52AEaPgWCILw7jSfgBS0F6I9s9761GV3yKZNN3BuS5waO0JzSpFCFw6N4vED+Q68ygfpqZfjSbc3XrhQ38GXDPPN2Y8uG+kwBrYeH3kDrWqWzTNlUcImlJyI3DiOTWWrn6DiX+50x5wvslYDQXXGAKTgR4SB44Qku0rDkeHG4iB/TGBiuEtFA97I/0ysprOhhI/9ViZBi15i7SN+7pkbRP6px55y9xhXZw9TX27X6baJxjcjtCGzPx8NmjfIxg6ZuEc3lsNJMMNyVmjcThGrU4DseXYE/V7KKDS8SEPg+RzF++8Vn0EVwAMcLld56+Z9kTsb3QR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjPgHarm0wG4HZPOB61QehgUH35koP0ZJtLHvZclRk4=;
 b=WbObHFv0coSp2rt1B/K5w89Ii61+BGlzyudWUSYMVO1gHPjJzAd/ovZpam/JjI2EhFjtPdljS+weNXgmnRwupSUGLLt9vc2+3/ual4qUdep0x/x9dGxb+rSdTRSLytHmTxp1uyUR8hZH8+A+PNqlm78Bz9w26fAX+eG12bn0sFkLtly2zlbCpLguW/SHTgwhVA77qiEjIoIocoa7s7ki4bciwKt7j9yj4mZCqHTzUdz1DUQV/4bLfrz1299RSx+pWqlvi/ZnSTrew6uRSA+1ty1LQCiPeo54WS94SvXUNcfJXX5bLKtF9UDa8MLwLLOADkyAyz150xGleyVrWz//Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Mon, 3 Feb
 2025 17:38:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 17:38:11 +0000
Message-ID: <ea4ab037-fafa-4bdc-8048-d46b8bf4f724@siemens.com>
Date: Mon, 3 Feb 2025 18:38:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-crypt-hook: allow to
 run before mounting all overlays
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250203155221.342136-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250203155221.342136-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d60baaa-9968-4793-180e-08dd447987c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c1U1cE9lQk8vOFhUamNVKzRjWGdvZ3h3T1o0ejB2NTlpZElrd05EUE9kZ1dm?=
 =?utf-8?B?SllSR0NwaE5BTlJrZ0h2aGhEQkY5MWF0VisveUYxYVNubWZCdlBYUk93c0VO?=
 =?utf-8?B?SDhDam4yMXR3S1p5TmZ1bkdGU2xJTTdWYmpYS3BORmFUMFJWT05WcWNVWDZo?=
 =?utf-8?B?T3BCeFRkMjZWWWJYREZ1S3Bocmo1NittTzVtYzBNakxscXdpcm5McjJDYk9Y?=
 =?utf-8?B?OWl2N2UrQjdrWjlrekFVb0lNZWhIWXozVVBIVmNBdUExMWtqU1hwQ1FSbDBK?=
 =?utf-8?B?QXl4aXRrNjZhb0krZHQvcVBSd2FUWEZEaEs2bnM3YjlGNjBEN1IyZ3U4U1pu?=
 =?utf-8?B?cElmMDU4TTBFRUZhbHZKaFR5OHdLUWtvcnAvUDBUSzgxT1ZaaU1pZmMzVnNP?=
 =?utf-8?B?SCsvb0hhSXVlcTdEM2djOUdCOElPS1hZZTYzQzRmcDNmWURra3lXdU0raUpT?=
 =?utf-8?B?OTNHSEo2WGtOKzVxblB6UW5qYjl3cnpJdTlpRy9SSk5CT05TUVB6eW9Ka0F2?=
 =?utf-8?B?UUI1cnlKOUx2cVU0cklqb0h6NXcrSzRoK0VVZ3JjOGRWYUtBZDc2Q2ZZeHlG?=
 =?utf-8?B?NmNzSjVxdFh2aHFEZjNVMk9NOW1PRTk5K3ovcHJIb2V6b1VhSjNLYThXNGZN?=
 =?utf-8?B?MUFUUDNzMmJnNzViZWRTdXFOc0ZTQWN5NEtoNjRDaU5JRU9vQlBaaFRaTlNu?=
 =?utf-8?B?cUZ3d0FOU25yN0pFTXVxNmJIeHdqRlJWbWhXYTRudGorZTFTMXJqRDVlUzFy?=
 =?utf-8?B?Z0p1Y2N6V0d6ZlEvMjR6eVZYODJiM1hPM2tSMUxyQVFSVEZYdVhrV3BLS0sv?=
 =?utf-8?B?MWxzNWYvZkVwLzJHU0xxUVhJUDJ3RFFpZE9EaGJ0VG1hUXpMeEg4bGcxb0Nj?=
 =?utf-8?B?cXMzcE1lK0drWE80WXRXSVhYTWVWV1IrSmxnNEc0dUFzTENRNlBxbXRSWkl5?=
 =?utf-8?B?bXNvdU8rajJLR3R0OGJNRUw5WHVVOUd4dW1sRlJ1TkhQY2tMUXpkbjdISTJZ?=
 =?utf-8?B?aDlZQVUyWW96VDJHdlNEdEhzQXNQMFFWWGhYQ0VWUUxyMnIwVk9pYzdVV2dy?=
 =?utf-8?B?OW5GQ2JRd3RRL0hhZGNWRmk2SFNkRmpuQVVyVDMyc1VNVTV2QmdTckNVazR1?=
 =?utf-8?B?OXhyeE04dHpXWUdKeTVJM2pXVW5jdDRzMFhMbFdqMFFtVTJjUzEvTWVaNjJP?=
 =?utf-8?B?WW9MTWVsTVFoVmFSSHhSa25wZjUwK2lkOXltTjgvVHJlTmlPanBIc0dGY1JG?=
 =?utf-8?B?bXBRWGRreHErbko5Nm52VzNhb3ZVMDVmM205S3FsZ1psRjU1WUJGRkd4cEZp?=
 =?utf-8?B?bGRXYnZTRW9acDZ6L3lINDM1U2hGaDRBMTJTaVV2MTZFa0NHekpBZnV5QkdH?=
 =?utf-8?B?WXRpcmtCVGpBR3BoWVVhTzU1VEM3aUd3cWlZbW5PSmlBV2xyWXJxVjZtUDVr?=
 =?utf-8?B?ZFZ4VG5yZ2txeUhmY2ZxcS8vMXJab3lrNDJDcFp2ZTRMKzRON0VKbHZvbmZH?=
 =?utf-8?B?dm9EODA4bE1YZnFMWHpzVkdnMTc5TFk3WlB3VDd1VHVKbXdOVXdjdEQzVDF2?=
 =?utf-8?B?ek9xTkdSbjJGcy93aGRaOGZJWEdzVjZGU3U0d0ZVRFptVmM5STQ1VHQ2L1VR?=
 =?utf-8?B?YmZ0dGl4bGt1SmthV3AwOWNIZ1pqdnBKblhvRmkxSDR5MFkrNDVtNno5Sk55?=
 =?utf-8?B?aDJMclloYjgwVmdEZFB3S0o4VlV1dUdHR0RBMHdhd1FkOHB6ZDdNRVhNRmkw?=
 =?utf-8?B?T1JLMW9sZWFaMmZTeG1BMmhoYjU3dmNwNXozeVNTQXRWeGUzMW4ycXVsOGpU?=
 =?utf-8?B?eTdjV2Z1QUtMQjlDUDlJNnViLzJGL3h1Znk1bHFDdDNWejlYemxrdXhIYXJB?=
 =?utf-8?Q?jLTzXD1w9D0RS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aVczbVU4N0VHRXN0QjAwMWdhQjhBcXVoTVVtVEdNVFlNZHhRMmwwcFM5TVUz?=
 =?utf-8?B?bXVobnBmU1JEdjRiYTlaOVFSZ0VRWWFQSFRZK0dmOHNmRENna2JPNER2YWpW?=
 =?utf-8?B?RDQyaUw1ME9VMmdZQUNrajM3dHJwMWNqK0F4NFpadkh2OGN6cXBXVi8ycURO?=
 =?utf-8?B?T0YvWnZKMFNZM0NGY2hncUw2cEhoMVlKU2Z2cVVLVnpIR1VKSmVWZUpqWDNG?=
 =?utf-8?B?dk1ucHBuRFF0czhnZ1J6MFBwSjVBZ1M0cFlPdi9HNE1RRTdjcytFVmtvWWpB?=
 =?utf-8?B?bmpjZ1NPVzltVnpoOVE5eU5CR0dhOUhReGlOZGlBRDNMRktNN25rMkswQkxE?=
 =?utf-8?B?Z0U3RlNUQU9VaU9HTFFyQ0ZocUh6U0Z4eEtybDR5RUpJMlBQTVVXRkUxQ3VK?=
 =?utf-8?B?WWJjeFhhM25sdVIyNEYwWlllUE1VeWU0UE5ydjZ2VC8vd1RRTURJZ044Y01I?=
 =?utf-8?B?TGVrZW5lcTBvT0RmRGk5bkVPblZyVlVFWTNBTHZ4RGtOWVVza2s0UkN2SHhm?=
 =?utf-8?B?bkEyS3RDd1RTYmZMVjBDU1Z6REZDMm9DS0dpR0h6S3E1bEJsQkpZMFNvTUE4?=
 =?utf-8?B?YmJOemF1azJjVGltQnYyY2NPSjN1TDN2NVJwMDBDdk4rSnNmaDk0K3hLa3p1?=
 =?utf-8?B?cXJGU2hXMmNGQlV1Wkp4aUtKcWxFWkU0K0R3TjFBWW9oRDE4NTVGSXB5bS9U?=
 =?utf-8?B?K3o1OWpMczV6eGNJVEltRitzM3JrTEdHeFd2T3Vhc3lDTHZuSkFXU0FRZmpB?=
 =?utf-8?B?L1BhQzRSZ20wU3ZPSmxzU21pM2I4bTBCRHFIcXFwVFVxc0h3NG95cmIrRXhm?=
 =?utf-8?B?ZnlPUjhDbVR0Mjl4dzd4MTdoN0NTV3BFMDJuVTFvd0hoOHJLTGwyTmhDSk1Q?=
 =?utf-8?B?cjVSenJ3T0pKUDFUdWs1OUtzK1hFUVp6eEx1SDN1VkFVQ1pSUTk0OENEQ2NH?=
 =?utf-8?B?eWJXbkZjTjVyQmpUMXl0Mm8xamJYRzdnUThveHE5K1IvT3RNczZEbjRPdFdQ?=
 =?utf-8?B?UEw3by9QUGw1Ym56Vk9xeDNJMktueXZvYU1WRmJDb3JoL3RxUFBuYlhkSW9y?=
 =?utf-8?B?WEphL1krcmx1UW1SaUprTitrbG5abVZ2VFNDTENhOXd4S3NHa1VzY1NtaE1C?=
 =?utf-8?B?L3hwQkhmT2lmbm04ckhONVRHaTYxR3VZaEZBTm9QSWRDV1VZRm4wZm1WdVow?=
 =?utf-8?B?MEUzNEdYbWRtSXRzKzJNQ0U0a3BueUp4THdsL1B5WmkzNFo2QUQrU2NVTlZp?=
 =?utf-8?B?U2xXclMyWmNCZnNHNFJUWUNRNmp1MysrZE13TFlCZzk3SDBsS2FxKzFjNGRh?=
 =?utf-8?B?eHU2TmVJdGVjaW00SnRPeWFudkRYdkUvS1UwTk96bHhBeFB0ZGpuRVdrcElM?=
 =?utf-8?B?bHg5SWhVOXhiSmx6RGMvN3BndnJ3Y2p5RkRPNXZHWGZZc1RQR0MzbGdKbC9t?=
 =?utf-8?B?dXZpRVB1a25mOWF0TldNSCtmRW8yc2NIOGdGK3FhSzJscE84UGw2blI5cGFU?=
 =?utf-8?B?emNFVkFqZzV0cUVOMHNTaE5IV09ybGg5N1VWaHVsTnpzdkwrSzEwN0V0dG9W?=
 =?utf-8?B?TzdEN0tBeWw5TVBqUDFrTlFkMTdBSEd4M2RsYmpCZFFvM1UrMG0ydkdVV0lp?=
 =?utf-8?B?a1FIRmU3KysxM0tzc1pMZS9HNjVlVUtNaFRDYmZZeXlvUjJDQVdlUTE4ZUlq?=
 =?utf-8?B?dTh4QUNydU9Fd215azVxVXFUMFJicUlHTzhtL2p4cGk1N21CajY5bUVyRXpl?=
 =?utf-8?B?cHNjSHo0OGllWWxSMnFYanByVFEzNFhOUUdhMk1CemNxeGNHUnFVWEZSMUFM?=
 =?utf-8?B?OW1vUHRqaU9RTmlzK0RScHVkTG52cncyUjNaQ2F0NmZ2QUpYQmdNbDBSUXFT?=
 =?utf-8?B?K0dTdHF6SkNheXZNaTBJUU0yOTVHWStWUldjNjdCeUV1UXlobzJYa2Q5QzJk?=
 =?utf-8?B?aEdWRFI3dVlROUJBNFNxd0IyYTYwZzBtN1JQa2lZMExITUphc0kzWFhlZXdh?=
 =?utf-8?B?Y3crL2R4OHBIWWRoUVBMcDFodVJDN0k4RnI0djB2c3dYdnowZWtXVEdoRW9q?=
 =?utf-8?B?WnlTQmczeHloZzJINnlpSUpoK0NzR3dqN1A2VE44dW1QaUt5ODNKWk9IUGhh?=
 =?utf-8?B?WnJBandkSzl3RkFiU2RXVkgreXdzakxxbURYangvNEdoa3lHQ1NvclIvSk1H?=
 =?utf-8?B?UHdzYlh2Tk0vcVdYNDZiSWgzakRjdnBhT2VJdnlVanN3S1R1ZzdaekRQdzRp?=
 =?utf-8?B?TTh5d1hVN2VRTHJ1Y1ArT3NDNDVnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d60baaa-9968-4793-180e-08dd447987c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:38:11.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4swKBkgbsFKpLe7ESOX2qQHN8NvgYklmYNy7KAzCiAkLa/+1F2gI0auoZeTR9t276Uq6A4WM0h6fh4ED3KdWJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 17:38:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17737

On 03.02.25 09:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The overlay hook does not work with encrypted partitions
> therefore it must run after the crypt mount script.
> 
> The crypt mount script run last to mount all encrypted partitions
> which are not mount by other scripts.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/local-bottom-complete        | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> index f47219b..b991cb4 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> @@ -12,10 +12,14 @@
>  prereqs()
>  {
>  	# Make sure that this script is run last in local-top
> +	# but before overlay
> +	# This script mounts all encrypted partition, which are
> +	# not mounted previously
>  	local req
>  	for req in "${0%/*}"/*; do
>  		script="${req##*/}"
> -		if [ "$script" != "${0##*/}" ]; then
> +		if [ "$script" != "${0##*/}" ] &&
> +			[ "$script" != "overlay" ] ; then
>  			printf '%s\n' "$script"
>  		fi
>  	done

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

