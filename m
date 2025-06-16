Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77B7C7115C
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 11:08:04 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.25])
 by mx.groups.io with SMTP id smtpd.web11.27850.1750072079872818723
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 04:08:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L0rLBadj;
 spf=pass (domain: siemens.com, ip: 40.107.159.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFl1DkOZ0WVPJo4m68N5BhMyICFfLAxBCTfrsShUQd57EJrCU4dRxdBXUYSOom/rMpSYk84VBr3aA/kCpblwgx7xE9qWRhDQHxeMFjTj34S1D2RyxKq/JWBXoYbF8Un/yxiIHOSkFxSt2oOpIuysBQECWs0ZPz9+E378NDzRsFPfP3+Wcm05B0falM653hG9eL3s/P2tcxcWdlNNldyJV0jcee3cmz4b4mAAr1HccuD6M8V+3FJ9Q0i/VEu/m6nHx+rlLoCvNkgbG2FxueWKdLxYhqAptnZ2N4OLvnPvQB+XRCapcwUHwEyT+OP9soqcRbczf82QDXDEWxWf+UvSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AfG/Ac6Hyt/60oRBnGyXsanbuo+Do+gnxOa49+VzHE=;
 b=FQatW2zfMJSsdRvYFF8twbcURFMnUWY/S+AAkFTrkWenRdJfsq0nPe8ChYzDYRRbwJgSnHLkOut6C+APyp+sqCscRUj3Bocw1YhHRnh2zQdqwhg90QTnYWkZw4opTho82FCGuD3SKKzF8NduUt6UVZMXrLpTXYkp0rQ0u88Glk32OIZe+7Jrxxe57xWSAduFZh8oFADsg4sBd0w9wBfS9yIg7/5GZj/dvwxxCjBx5uSGlMJLA62LkPYc1N0lEmp3N5A+6nA0tIZFOs3nHzrDUV9iGDR67sS+SY7t3zhfa5tV9vpaV5F3QG0BiYvq1+NP8KHGtaWZmfKgTRWO1C3rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AfG/Ac6Hyt/60oRBnGyXsanbuo+Do+gnxOa49+VzHE=;
 b=L0rLBadjUF9O5yVPH5BX/mSTSKlsWj29U9nXZIBzx442Xy8FiHy+uHZ4wN656UO0jqie3kHmhV9+zVO9fAp8wEDeQKOr3SXyPGX+wD63ODKcbGy+qxXzha0kDW1z0np5QAuJxPDhkhY+87fD1r+7daOczid1AmAxziD3WArcyn5mwTkQ+WVK8HuZMsnlpVTO3qitTS96HdCFLD+TUvm9+tGWUZiTiA9fRRtyHEOsFsM6PFz2faE2zR7PtPfhK9oaRhzedzZgFCr7T6GCUqClbCGKekd1sZ1+CYd0a/iHkdEFPB3Dvm+NhWAjwaxGCMeMsAkfjLsh7LjPlyCjazU4FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:07:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 11:07:56 +0000
Message-ID: <6a3b4748-104c-4e21-9ec7-4f8ca7216f27@siemens.com>
Date: Mon, 16 Jun 2025 13:07:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] fix: Shutdown the TPM after
 disk are decrypted
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250616104736.1839331-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250616104736.1839331-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3269:EE_
X-MS-Office365-Filtering-Correlation-Id: b02f1402-4b46-4e16-9fcc-08ddacc60bfd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZFZuTy9WM0w5T0dVY1o1TDBJMlN1SXM0UGNZbklVNWord1BONi9zVGsvbzd1?=
 =?utf-8?B?VVdkWkpNdkZKMkdoSitiTmpMa0h6L1p2SEVjRU5YTk5naHFTaXlLOEZIY1Rl?=
 =?utf-8?B?bHAvQjlPNWpjZnZDRllXT2I1VENiSldqTWlGQnBHKzRibnd3QnlTV2pXeDZ3?=
 =?utf-8?B?NjBjNkRNZXAzOU1nRDNLUUNLdW5WZkhVL0sxa2gxbmtXRTBjaDJtd0QrVjRi?=
 =?utf-8?B?ZHo0NWErbXcvTG9uSE83VTJTVlRpQXhuUndNL2ZTVzlCRUNXVWhxTDlMczdU?=
 =?utf-8?B?Tk1ONCt0Wks3YXdHR1AxOUllQkxqYjdHQkdZaE5kVWx0NndTQmc0MXpZYnY4?=
 =?utf-8?B?cDZuL1RxZ0I0Yk5BMTZQeFF5U3NjT01LSGlMMlZubFpGNmpyS0Q0SzE0YTUv?=
 =?utf-8?B?dlUrWlJGclpvZHMwQTJoMEJlSE41aXA1TytmYW5ObDlDUDNoZE9nelA0SVJK?=
 =?utf-8?B?ckxoRlNqbG9DWHNZS2dxNitXVmJ6YUxwd29WVW1BSXM3K0ZHUEVycVd3Qkpz?=
 =?utf-8?B?T3R4V2FZVXE5aTQrNlpzbGpRbng5RUFNZklDVmQzdG9JaXpsSHM5MGlPZGZO?=
 =?utf-8?B?bnl2N1hWWXdkWFpxUFQ4VVNSOEQzV01ENlJzcldCaDNvL29BdmNwRnozKzZo?=
 =?utf-8?B?NXNGWGdHUjluUW0wR2RtcEZWaHBEcnF5U2IvWG5keStlMHNsVjdlWXNVajJO?=
 =?utf-8?B?MkE1Z1F2TlFvQ21jb0t6OXBOM2hEbUYvMnFKd3k3b29raWlOWFRwZk9lTXY3?=
 =?utf-8?B?ZG5CR29uRVJwYWszYmg0QklrbFg4elFGeFhvaldqZXNRbjFDZDZ3U2JCenRE?=
 =?utf-8?B?N3BMZkV3SXFjVWtKbXQxNTdsQ1lCSE1GcU9UNUkwQytRdnU4L3F0RzlVbWMy?=
 =?utf-8?B?MzlXZWhwQ2hhYnNDc3lkRStsck5nUGxUQWp6azk0TkR0TzRUaDFmR1BMcGR5?=
 =?utf-8?B?aFBTZ1huZXFieTd0bzFrRTk0RkJmY0dIQWJKM2tCVlIwTk5uWFl3TEYyTC9W?=
 =?utf-8?B?dEJ6eUxDR0lpN1J3Q0pFUmFMNVBUL2s2RTBFVlRxL3VHSFZ0dDc4dU90UjFN?=
 =?utf-8?B?bUVMVGtGTVZaaENLTGQxcVRXSzYvUUh6MmRwZ2c5SHdVUm1hTzMzMm9UL2k1?=
 =?utf-8?B?N1k3RmdZQlJNL055VTdISG9SdE14TWRTYWpURk0zbk1pdk4rd3h4NDE2V1JE?=
 =?utf-8?B?Z1NwQk5PaWFzdzdQZmtqU1BaZlBRdkg3RTRIaG9EL2NYM1YrRFBrRC9kQ2JE?=
 =?utf-8?B?OTZ1M0c5alp6cDdGaVZ0VGZZV09vWG5aWVVDQ0NWWXBQd3VTc1RtWDF0OGV6?=
 =?utf-8?B?cmtxbm4yNVpSODlDUFM1cm9rMEE5MkYyZW54WUJyM0s3Q1p1NkRiSlN3TmYx?=
 =?utf-8?B?WUR0R1V1NUV0YnZERWNBTmJOOUZRYXRrNWhyaUJpL0FrOEtmWjNoMldsdnl6?=
 =?utf-8?B?TE5jaE4vOFVHZkRSYWFKTUJ6THlzZUlzdnhEMnlKVkJKOVU3Rnd1TDJ4Ymt5?=
 =?utf-8?B?SjdyanVjNG1iVXl4aVZwN1oyNy90UU8xQ3RXSzVXOWIrK082MTN4emUzbExL?=
 =?utf-8?B?RUZERUc3VEYxcjloNWcwVWRIVWlsM0phem1TT1VJcnNCd3NORVhBREJQaTN4?=
 =?utf-8?B?RC9vM3cxZVNWWlE4QU5RUmVCL1B4RDM3NFlqczNwT3pnYkJYcVBKRWk4NldY?=
 =?utf-8?B?bElYcEVVQVAzMEc1b1l4UllzN0xKZkJibHduSzBuR05IajROOUdPVDB1Rmtp?=
 =?utf-8?B?MGNRMjk0MTR5V2dlSzZ6QS9tdDdJQTJib2hoMTBQSVpaV3o5bjFwZTZDZDBZ?=
 =?utf-8?B?T2s4TmgyeTNTQVp4eVNOTnNiTmhYbWhLS05pNkpjNHpueHpWNVNCTE5icUtD?=
 =?utf-8?B?bm5PUEF3LzRhS0xGcWl6OThzMjR6cVo4NEwrNDIzdU9aRFE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZTZGbC9NYjBTbTh3anRWdUw2bWRhNE9VSHN1dTJnUXYwdHlZdzR0dmEwekdD?=
 =?utf-8?B?VjhOdnhtcWhwNkFHMkxyZUswbTEraFhqVDBNdDFibWxLazVoQmM1RnpFOFVS?=
 =?utf-8?B?Nmh0VjZWNWVSZmlpUlVtTlExaU52RytCb1hEaWdXc1lrWnRnMlJkUlU5cnM3?=
 =?utf-8?B?QTVHdDJCWWNCVVJOYWZxbE9rS2NQTmFaQldOSVBIMVh4RG1DM3diTHRFNzRR?=
 =?utf-8?B?Tmh5NE52TXNJQTcyV28wOWFZQWlqeUpvVHM2MU5kOHJnbFA1ZkFwTzRQNFQ3?=
 =?utf-8?B?Z2ZZRllERFk2Y1lQUUhiVjJ0TGtMdmF4enZWTCtDVVZXdE13bzhIRnhNTmpp?=
 =?utf-8?B?YytIV0pUMjVScm5UcjdINVkrYUZtQVlySXNNVFFxZ2RvRmpkVDBTNVZ3ekI1?=
 =?utf-8?B?Q0E2VStOaWtseU9lcU9pT0JQUU9xd1l1ek51azlDY0ozMkJtY1dlSzJ4Ymla?=
 =?utf-8?B?Sk11ZUgySVg1dFRreERWNFl6UVdOMk9qakZtczY3eFZtNXJvejU5M0pvci9W?=
 =?utf-8?B?SGJpdS9sdXhYcThhWkVmRXZjQWl6UWNqbVFSd2NLWUxkVis0eWI4WE95c0Vk?=
 =?utf-8?B?emtjVy9pWjZPcXYvK1lzUXR6WDZ2RVVwUnpwdFBIdlBuSEtsWktBSlh2Vldn?=
 =?utf-8?B?K0syL2lxUU1uK0x6TlJrVHMxYzU0MjA1Z2dpNFJTcXh1UGdXQ2w1RjR6MlZh?=
 =?utf-8?B?STNlMVNWWWtRdmpmTk9FTlh4Z1k2eStYK2VQREtkSjZxM3pHbVR4ek9kRkZu?=
 =?utf-8?B?ZWZKU0EwM0VLVG92bkQ0czV0SVJnNndYRkVzaEZTZ0xwczNWMURXd01ZVEF3?=
 =?utf-8?B?TWNIUDhycExucEI2UWxQNDkvTUJFR21yYmVudlFNL3Rjejk5QmVpcVVabHp4?=
 =?utf-8?B?UFBjeEh0NlFqbk9lV1IzVGR0MlRJUnQxOXQ4U25vcGNwRmJYb3dMRytOeTJv?=
 =?utf-8?B?SG83Sm5id29KODg1VUxKV3RUZU5xMThqVllWYjFFTGZPTnNCeEprNkIvcHIv?=
 =?utf-8?B?aVd2N2NQOWN1eTl5czZQNzQveWJSRXA1ZU1aOHgyQWd1clZ1bUxQd285WUxv?=
 =?utf-8?B?dU9jZzdWS00vZ0ZiWlppQllhNTVrRUxHYmdob3ZrOENRY0RyR21udzJHZHdY?=
 =?utf-8?B?UlVDaTZCYVc3OTNsWXFuY0JCUGdJKzFWY1BnVGwxdVNvVFdIVWF2VmdaeUR5?=
 =?utf-8?B?QUlXRFBkbEJsMzV2bU1HUFZZTG85Y0N2V0VtUndBYjVzYmc0VGpTMTVCOUZx?=
 =?utf-8?B?UmV4VTFiZldhcERlcGh0cEJla24yd3lqS2JiRXJoNytKdzFnSGdwbkhwM1NW?=
 =?utf-8?B?bm41U1VicHljZEhGWVFuN09CNU12NVFNOUdpakpaOUFCcWgxUHF5Ky9UOXUv?=
 =?utf-8?B?c0JsYnM3Rmlla01uZTFwcExTSXpSOWRzZlJGT21CTlJyOURRR3VKZEJiTGtp?=
 =?utf-8?B?ZWFyUUVONEtkVEVYWnovWW5hQkVLSlVyU2NTMHFPUGo4QndQMDNQRjZ5a2M0?=
 =?utf-8?B?VGZWZVRQNnVaZlVtQlR3MVFwbG5ZTjJwRS81WWo0dStzb1dBSUQ0dXVYSm1F?=
 =?utf-8?B?QzhqSER4YjFad1Z4WElVUUMwbVhvc3J0Rjc4UFBLK0t4L0h5TmxiOEgxUEFj?=
 =?utf-8?B?SVpkQ2Vqc3BpSlExSlgyZ3dPVjFpYkZVcGRmUVJMOVlxQTBSQWVMdTJhWTBZ?=
 =?utf-8?B?Wll5a1pKR2c5K3dMai8wcEdsVHUzSmN4ZTlyeEJLc2RDUUZVZWRPeFVwaUJW?=
 =?utf-8?B?KzFveEJuWHhBZ1NQUXZZL3kyRlloQ24rM3NYUnB4d3lWV3M1Z2NwWVdTcXps?=
 =?utf-8?B?T0FQSVpzMnpNd04zdkZlSE9KbWx4amJZSkFBd1BMNURBZ0ZSUWJYY0RnNkc0?=
 =?utf-8?B?WUZGY2VyWnRvSkJHOU9pR3Nyd2RocGoxWjJpSXlwZEg1dzlNWTFHS3QydVp5?=
 =?utf-8?B?dTVWaGczWDJCeElBYjIvcEN6bGg2Q2lGZHV6ZzBHOEpWcVRjK09uMEpoNmcv?=
 =?utf-8?B?ZEJLNFh1OGtrSHErZytTaGZhNm85dnFieVNSK1BZcDNRS1hyYTNlUjJUbW01?=
 =?utf-8?B?SEIrN3pGcmNKa0pFVU01aUNuNXNUOVlkcTVWTWlMc1FEekl3elQ3Q0NlcEo0?=
 =?utf-8?B?RUo2RnFiczNaQ05vQ2xlcklIMkZTUjk2VTJhOFNqZ1hLK0JpRDZkeGNaUlNs?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02f1402-4b46-4e16-9fcc-08ddacc60bfd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:07:56.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcrkXd1DkWectsJX7LVT1arRj6IEqaQs4p9F3GU6SSk6i0iaUnIPKZoQcrQMaHIEOge9YUgFg2GNe1wDwdCIaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3269
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 11:08:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19106

On 16.06.25 12:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If an power failure occurs and the TPM was open/in-use the DA lockout
> counter will be increased. If enough shutdowns occur the device will go
> into lock down mode.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - use tpm2_shutdown direct instead the wrapper command tpm2 shutdown
> 
>  recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 ++
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb            | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index ae0dcef..009289b 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -293,6 +293,8 @@ for partition_set in $partition_sets; do
>  	finalize_tpm2_encryption "$part_device"
>  done
>  
> +# shutdown the TPM to avoid DA lockout due to powerfailure
> +tpm2_shutdown
>  if [ -n "$watchdog_pid" ]; then
>  	kill "$watchdog_pid"
>  fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> index 80a4755..41a3c83 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> @@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
>  HOOK_COPY_EXECS = " \
>      openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>      e2fsck resize2fs cryptsetup \
> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext  tpm2_shutdown \
>      /usr/lib/*/libgcc_s.so.1"
>  
>  HOOK_COPY_EXECS:append:clevis = " \

Thanks, applied, bumping the recipe version as well. Please do so in the
future yourself.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

