Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9748FC2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 14:15:12 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.82])
 by mx.groups.io with SMTP id smtpd.web10.8730.1720793706773992183
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 07:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qLWKqqIN;
 spf=pass (domain: siemens.com, ip: 40.107.249.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/BtPdZPlaHE/u7njoqZLQ4OjFknV/QsY1SLtubw7SjrmF5DeX/3+XcKQvkoHv6HIRdFax8YzRdLsS4jdSxFzeAbYrMaR/4q6rPHtE3PrhGl1afETTjWYOvQvdPguymsyxSrRITMhkKs+Bbd8um9g8F/kC5Jy5drKKVYVsIxckU0o/D0qlWpCN5/+E3NVwj0thiX7RUeZJi00UN619t9S9iHE/p2imbSggKr1Y7sxpv2xzD9WIAo21PIi8x2qYjqzWnkq3CeL2D6Cl/VWDE4obKFfTnKqoRhzuY6I6lA1CcholqXlJIrkRHpW8jpeZL9/vfWMzajgjVgr8IPbxZ04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gxg89m6DoJBtP3cHF+9FaYfOy148b2eaCXLNHrUItg=;
 b=fAQ7QR67CsDUNhPMYTwkl2Kbj9Lh7ON+01vHSnB86Wj8CNcAhp5PHZoS208QqeQli5u4YJlx3X0NWb0BbwMcQt6Y1490yWz1jIu/lv4zTFxAor3qxtgkslLhT8/sfrntBzzQFAr/JGOaJ2+k3XgS029gJ/Bo7g+vYVwy8rljjqQzvNd+Fh8nTfj66+XIDVYgLdv2ArWNoQfbiTY8BLNwH/h8GN49gvZePQmtcyFMqbwBGTFLDONZwCxxh8piaKKoohrlfmmWIzmmY0ZKfABQmsN1nqqYY8KF0a0xqzc4BFb9pxyk5AGcYOBxLEX0gEA1bNo29w5v8tMwBmTDBEcEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gxg89m6DoJBtP3cHF+9FaYfOy148b2eaCXLNHrUItg=;
 b=qLWKqqINsftlFzqsZtLbdudlQiCtu9UMTWPGkc8/Hb2ovnygU7EUpE8fbBhgkSaK7Tgw8RXWs77RoyadeavyTiroizRmtMgfK7eS80NpGJfdaZk383Cw4xOedbYUEF9jE/p03ubICj+f5CGyuD8NBpSdH63oc6PGQr/iOi/oiBS4qXuDrK7xQAx6V+jguDg8Rev8oX53dHPO+8tyagDLc1y/K4WGwcSDLe1K8FJieRbolqcj8XeBeL/FdGbKp1DVLV1shmlJLSJ8uL1nM21IGNmX4FQ+lirGNlN1dB45smn/e6Yq61CEHnKLAMkRXjBa0jCcDIN/dHrSAXnQ2kid3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA1PR10MB8737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:15:03 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:15:03 +0000
Message-ID: <eb80845a-dcdc-48c9-bfef-b07e79006e9e@siemens.com>
Date: Fri, 12 Jul 2024 16:15:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] initramfs-crypt-hook: Do not attempt to repair a
 partially encrypted filesystem
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org,
 quirin.gylstorff@siemens.com
Cc: christian.storm@siemens.com, michael.adler@siemens.com,
 simon.sudler@siemens.com
References: <20240712125713.2066512-1-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240712125713.2066512-1-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA1PR10MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: fea10aa1-14c8-4b9f-ab92-08dca27d060b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cDJOOFM0SmhIUEpHS2tjVmxvMWRIaEV6RVJLRTVGRUkxOE4xaFAyb1RUTnAy?=
 =?utf-8?B?Q09RbW9RYy9DdCszK3JKY2o1UStpdlpqeW13b3RWZHVHdkYvM0dvb2ovZUg0?=
 =?utf-8?B?djJFS3ZDbUhSZ3ZybStpeTB2WXhUV3hqTFArTGd0SjFCTm5EczRjc0Y5VGcv?=
 =?utf-8?B?STExWWttUzBleTc1eDA4Sk8wSEdhY1ZXZXg1VkY4bnVtOXVCUnpsVlhUeWhG?=
 =?utf-8?B?aE5zK2dYckl2L2wwSXZFY2tTNUxYU05ucHoxT0tYZ2ZNRmtyK1NEQkY3ZHpm?=
 =?utf-8?B?WjNwbFlGZHZja3F1ZG5OT0kwci95NS9QdkY5V0NuR3ZCQnBHTVhUUEF1TCtF?=
 =?utf-8?B?UWFPaEVuMlFMNzNCNEF2WHc1L2pZYUZjdmR0ZjMrTnAwYmlNK2E3ZFY0OFBx?=
 =?utf-8?B?OHM5VmpQSk0wUEZ0aVJuQVJDcnp0MkVRT1duRmExU2szaW1wSE5oLzRsY0Mv?=
 =?utf-8?B?NGV3TFpsNlV6UFFEWmRXandqbEFBTTNRL0h4Ynp5VEJKN2NHMUVXQ3Q0bWF6?=
 =?utf-8?B?Q0xjbzhaY1ZqR0hzOUZUYUpWWVROVG8rU284YmJ3bXNweGdnc0laRk1vTS9r?=
 =?utf-8?B?NGR2UXBUcGlDL084L2x4S1BrYUFZQmdkVFVyUk0rTkJwbE9KNnJFOXJZbGdv?=
 =?utf-8?B?RmQ1TXBMQUF0TVNrRkdwRGwxaTNJNzNGV0dNZHZybm1SSlA3TW9TMHhtVHNx?=
 =?utf-8?B?VTJ0SWczeXJUMjI0bHRuL0lqenRGZVNXZzFmcWliRVJ1QUI1VmV5eVlzaWFU?=
 =?utf-8?B?Rm1DOFc1MEFHN3NCRG41OTAxaW9TR3ZQU1JlOGR3OWZJbXZJeEVDV0k2RU8z?=
 =?utf-8?B?cE43WU9CQS9wNEVBYnRHVVRDdkRvZS9pMnUvSnJDandzbnFTTXE3aEZHZ0Nu?=
 =?utf-8?B?VHdhaURxNC9CME8rNy90NGNqb1pneStYSW9TZEw1VlJDYWhWdVVsOUtabW0y?=
 =?utf-8?B?QWRidEtiaytwSXNUWnRBMFNVQ3hIdjRRNmxVOUpoQWhqcUVNNXZseUZ5SUc0?=
 =?utf-8?B?WXRnd3hHcGdLakw4VGJTbDRKL3Zja2duUllxSU1PRlVhZXE2R3U1RkVOd240?=
 =?utf-8?B?U2NybFpWSENNRHpqTUVOeGtaaDI0d1dhWE9aMitEa05IR0VmMEFSRzBrakNK?=
 =?utf-8?B?TkprbTRicEFlNE44c3JEOGlIQ1FKbTZWMWtESFgxSCtETU9pSXYzQzFFVVVm?=
 =?utf-8?B?Mi9pQkJnM25tVDNxUE5GRnZXYTZqS0VaMHhjTVdsanZNeE9XbGlZR3l3c1h5?=
 =?utf-8?B?QlFoTVI4RG52SmxjRkFmb1R6ZWIxakNDa2tXUHd2ZmlyOTlVUURXbzluOXFy?=
 =?utf-8?B?TXhpODdlcTByejNYRGNURGpkMzBvaHpjQk8xU0VVRDM0Y0VaTlorSTFZdmMr?=
 =?utf-8?B?eEhGVzNjVXJmTmprcUI1aXdsUzVyalkveXpiVXo0TWJtV1hzeGJkRmlsR3c4?=
 =?utf-8?B?dGcyRlBiSUYvSWhWaE1BbXoxSlUvOGhCaCs1cWQxT0RWeXJWellacjRKcDlC?=
 =?utf-8?B?Q1RheURMU1NaSW5oQTg5MWhjaVhQZ0laL0JWZmJOOThqTkxZZDcwY29XQXJX?=
 =?utf-8?B?SS91NCt3Q0U4OUpiWjdZRmxDZnJsQ0NIRlJDSkNUT25lNHU1NVJBeUY1RjA3?=
 =?utf-8?B?bExrKzhDMTdtdzV3RGRDOFBUSVYyS0FGam1UTnBaMmw1QTBjbDBhZXZGV1Rx?=
 =?utf-8?B?WSs3WWxpVkYxaUV3YVY2U0ZtMTdWUkVXcmQzMXFWbERWalFKMjBLWng4eE43?=
 =?utf-8?B?Tm9QUmpKajN0VFlJNHNvaXYwQU05VnZiU0lWZFZ4a1liMWhiTGVhbTFzazYz?=
 =?utf-8?B?aFZCdWJidEpSMEpnSVZ2QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXBXa2x5WnVQWEU4N285MElwN1lZN3ZsNEpLRll3aGJ3MTRyL3hqSXRDNnR3?=
 =?utf-8?B?ekJuQVFxRFFXNWQ1NnhYWHVzWHAzVFFMUjM4MnBGYm9TZWV3RUZvdFp0d3Y0?=
 =?utf-8?B?MFNuajNTTjg0R2pkTWZXRzA5ZlpkWjZMZ2s4R3RhSW1aV1NYbkpYVzlFbUVS?=
 =?utf-8?B?aWNYRUMybVQ2WlRvRHdBNS9IRkNBaURHWVdiMkRUR2hjTi92NnBHK0F1K0NG?=
 =?utf-8?B?SGR1dk5nQXl0b290ZHowQ2VoeDNZQnZ3OXZQaExvSk5uNGxFVWpNalVJTGU1?=
 =?utf-8?B?ekFYRFIzaGt2S2pvUXJFQ1FiZjlpazFEWE1lODhNaENwTTU4aDl2Rlp5OUdB?=
 =?utf-8?B?Zjk2eE11clkrbkNWVUJBbmFXdk9KenJZM3BrQlRZRXF4aVNOWHlTaWVSa0FH?=
 =?utf-8?B?TmVDOW1QOE9GeVZETlptMTFDWENmdjIzYUZtRXVFSXRmNWRKZlJvLzUxRS9M?=
 =?utf-8?B?ZU1pWWI2c0NhZ1Y5YU9FNjV1b0lZc2Z1aDJOUWU3RFZqcTM1OG9QQXNWa0lY?=
 =?utf-8?B?Rytjd0JLZGdhVDhoYUhGcjBjTi9rakJrNFp4ZkgybUUvSm55SmR6QU9HTUpQ?=
 =?utf-8?B?YmhqeG1DYU5FT2pmYmZKNFhYOG85eVZFcitZZDk4NGNiczdzWms1amNqYXJo?=
 =?utf-8?B?Y1AySXoyczg4aVZTYjF6bDdVa0gycmNQVW0vVTk2VTFGRk1HUDhKZFpPNkZs?=
 =?utf-8?B?djhkN1B0d05UWktrbkprekcvLzZxKzhSM2VlSW5VcFF2YjdDdDlHUW1ZVXpz?=
 =?utf-8?B?ZWRVMzE3UnBBR2l5aUpLRmpxbGdod2t6STgvRFJkU0ZCaHF3M0ZZaklObnpZ?=
 =?utf-8?B?RktQOFhNOTNTQi9DVUpJeUtoZ2Q2LytjNlRucHBWQlBmN1ZpSStuVWI3Lzhs?=
 =?utf-8?B?ajdHbVkwMHRGc3pHTEFRM3VMVnRzR1QvK2lrS3gzS3VtcURMZ2E1eUpMWmVI?=
 =?utf-8?B?aEloNDBnVER6TnRQU0E5TURvR2ZUd2dTQ3JJbHpsU0cxSkFXWTluOGFzQU9N?=
 =?utf-8?B?UGt5N05McnJRY1NnWHREbjF6Y1pvaitrV29rQWZrcnplKzllNTlHdFAxdDR2?=
 =?utf-8?B?dmNmUFk5bDN1aHZqVTdPVVBUNWhGWVlIOFQxaHdkc3l0amI1ZnZnYkE1TElk?=
 =?utf-8?B?eFFONkF2T0szY1VYQ0cxeHN3T0ZPZTd4bTg0a05hWVNlMGFsWGpwbEcxYnRG?=
 =?utf-8?B?U05xMlpJU3hLRVowNEVxcXlaK3NKbDBKTnpySTZhKzFxYlgxajJ4Q1U4Vm51?=
 =?utf-8?B?ZlFlWTZFemFOVy9xYkNPblVIelpyNGY0OTdrVFNCZWlpb1g5QWpMSHFyK2dN?=
 =?utf-8?B?dmgrakhKL041c3pKQ0thS2FDN0FLYXFnL2FqSk9acnNRTExBZGxjUHZxOW11?=
 =?utf-8?B?bys4eERmaERrQUNpME9zdjNIbFZROCthUDRoYVp2UFFvbjIwLzBQTlhBeDcw?=
 =?utf-8?B?OXZDN0JsMUJDQ0FLUk4yYW9maDNVbWFIK1RjcERTSEc5RGJPd2xzUTFBME1N?=
 =?utf-8?B?dDdWWnJMdHlUeEFDVVVZZzZJUzl6eXhWQ1YzMGpCVVRWL0p0dGNMZTNHSXJk?=
 =?utf-8?B?QThWNGRvdTQ5Q3hjK3pWUmc4Zk96WDM1Qkk5SnUvQnFDS0RPVWlpY0VFaHlC?=
 =?utf-8?B?VWd5VDJDbnQwUVZzNHBoOENIS2tlSkdTZUJTY2FHRlhMdFk4eWQ3MWFVek96?=
 =?utf-8?B?UlZ0bFFIWkZvQ1grSmNDelRNb2hKb1NWYnVZbU1OWWE3T0JCdEN3TXRCYXRE?=
 =?utf-8?B?NmpmcDVwZTIvNDFJQkF6L0w4aXRCQzNlVkM0SFhHZUVrMUh2QzZITFlTdklx?=
 =?utf-8?B?UnhlMVFaYi9jcHA3bStXRU1hVDB5MFZSOUZjWVJvZlhubVV0Nm5LeVR1Tk16?=
 =?utf-8?B?TGsyeHN5UjhhVUtzcFNybHYzNEZCUzNwNVFUTmFleGdmYWt3M3RqRkxOUlhI?=
 =?utf-8?B?a3NUdkVxSm45RlRtMmpONkkrcGNSNVFIKzQ0ZExRZElTQUtwelYxbFZsaHhX?=
 =?utf-8?B?b05uU3hEaGhrTFpQa3d4emsrSFhEMkEwVXlUUFQ1Q1hYM3c1Mm0xZ2tqMS90?=
 =?utf-8?B?M21oc1FVRGpxb1NUaDNyT090bTNCamp6UGJuamZvTGpyNk16RXd0aDJONDhp?=
 =?utf-8?B?VnNkTWFhaEZpTDliRXdsSk9xdjJVNEJRQnFuQVdqemV0aFFtaE1qb3VIc1E1?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea10aa1-14c8-4b9f-ab92-08dca27d060b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:15:03.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfK4mXnpv/S2OCS3EbRbyL+QxWDJx4IRz4fUwTGJZw1p7ZGQCGtnxT57KbCGvbYVQv7jsheCo+pBMjpQvf0Ptw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8737
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 14:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16484

On 12.07.24 14:57, Stefan Koch wrote:
> Avoids that e2fsck will repair the partially rencrypted
> filesystem after power-loss while reencryption.
> 
> In general, cryptsetup is capable to resume a partial encryption,
> but there is no key available to unlock the partial encrypted data, yet.
> The key is enrolled only after fully succeeded reencryption, yet.

OK, that is understood now. Question remains, though, if we shouldn't
fix that directly. Quirin, was there a particular reason to hold back
the TPM writing?

Jan

> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.script   | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index ff4c135..f943aea 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -77,7 +77,13 @@ reencrypt_existing_partition() {
>  [options]
>  	broken_system_clock=true
>  EOF
> -		e2fsck -p -f "$1"
> +		# ensure that filesystem is clean otherwise resize2fs will fail
> +		# do not attempt to repair a partially encrypted filesystem
> +		# ensure that there is no attempt to
> +		# repair a partially encrypted filesystem
> +		if ! cryptsetup luksUUID "$1" &> /dev/null; then
> +			e2fsck -p -f "$1"
> +		fi
>  		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  			panic "reencryption of filesystem $1 cannot continue!"
>  		fi

-- 
Siemens AG, Technology
Linux Expert Center


