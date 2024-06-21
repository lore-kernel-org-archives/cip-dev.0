Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7AFC27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 11:11:49 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.78])
 by mx.groups.io with SMTP id smtpd.web11.70428.1718968301658366811
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 04:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q+dhRclt;
 spf=pass (domain: siemens.com, ip: 40.107.8.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxPQqLcUumeex1Y1IK3UwBZ/a2Hz9TUJDFaSO1QgmLHXCvGtyVGoUWvzi3NH4lNE9LHZP47UzKdnpiI0VvaTLMydkaHmJShMNGukWgajzhUiwc6No2mT13XHn2IjOsAJKf+2E4ILYjJOzpvA7J22nN0GXhQBVd+XXTxGQq6eya/+7lnApFcqBo1NRb4FpVf7YeThY9MYr89moQAgVOuiJo0pMhvfEtS7yIpwHVk71BIJJaNseH+HSExpgaT4rBuLo4rIQ+eIriezceACvY7k7+dJeRijYsGZOjZsxyuVGzb61IFcgJDnPiy7zQG//rqL9nqOSq68eUL2/V4AaQw3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqEqtZTC8XaKNlLtvaJUSb5mMS6UOXJdpx3tuy6gSfY=;
 b=gpAxELDrJace/oR52T1xI3zu2L34cZZRlo4qIVcGV//RKSpDp0/bDk/fY3Bh2Dzlv/VKUT2CchZB4PcZiQmEzPaPAPnJ2VP13rsCy/zaPbC7/yb66RYI55D62XyfDT+eRE6K9Gks0DN0f4rZyv3sNOJu/O/HfWKS3iQtVcBT4kJKqnsroMCVh/SyTj6w7UMVCkJR0bNFHqb6OIjBRYm0UrS2XVUjw78nEUN2BJju2WzkjB+RuAStuY19kmS+wa6ySD8temxrJmJaKJ1pxZTSbk+iyxQyNtx1pIapYLn8QmIVVgNz7D5FTC6w/2KoIvpt/anVJjjRLSsxPiRZ/qgwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqEqtZTC8XaKNlLtvaJUSb5mMS6UOXJdpx3tuy6gSfY=;
 b=Q+dhRclt/WPpouIEgQHy5Bou4fT01leqKFaZbK8IgGqdYmXaOl6R95MeAGDKwDdcCv/4GQqNOdpk3mcxugZmMIKfweKYm1feLgyi9hxuhxUUvyh4pBq0jHaREWjOz3xv/MRFresmujnet6mr5VqmyevcG2JEKNQUQ+G2veAqYUUmUIlsQ+pvzIcW3uki8GHUyNSIohKuTD08dWu+71RWqeQlO6zEynF0PKRiXxpdqp7WC3cRQxwprEfM4GPWeqc9yaRxpq9TRTPkS9xy9QaibER2T5b7iv82dKh9B5rMXsiGU0/I6wcq9fEoNwQRqYNwJyTldY7P4IPji0+0TFH8Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6314.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 11:11:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 11:11:38 +0000
Message-ID: <81014d42-2882-45b7-b64b-43525081a429@siemens.com>
Date: Fri, 21 Jun 2024 13:11:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] doc/README.secureboot.md: Fix incorrect secure
 boot user generated keys path
To: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240621110310.2335906-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240621110310.2335906-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d1cfb0-ee9f-486d-36f6-08dc91e2eb92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VWhZOEd3OHNUcVNWbXptUW5jbWtrVkdmZHJBSWQ3WGRmajlhZjdSemhkU2Nm?=
 =?utf-8?B?VXZiN21UTEl6aFpYS2JheEZ4TktXWVR0NmJaMXRLM1B5TEZlTWUxS1dqL3hl?=
 =?utf-8?B?aWFISXhKRGZvWmxROFpKTkpnTVRGb0ZjSmFHNWs3dlFUV2FpeDVXZnhMVkFk?=
 =?utf-8?B?YnMwU1VHQy9lUlFKenpGWHZaUGl6K3NpUFlEUmdTTXh0RGxhNXBIZHJtVFIz?=
 =?utf-8?B?YXVQUnEyRm1DbG0rSHBxcTJhejZNcTBLUDcxM0ozVWNubnFEMEZLMURoSzQz?=
 =?utf-8?B?Ymh6SUpSRy9IdVVyNDhuSjlGZmZGZHdOWVZ2WW9UWTgyYVhybG16eHZqTnI4?=
 =?utf-8?B?d1VLUGZjVC9QUjVQcnNEOTExSFVqQ2pMMDVsYkdEMUcxVXlWVXJnMTU1TUJI?=
 =?utf-8?B?TlEvbUFXUXh5WklWZi9yWnR2V2RSNHk0cHE3dTdhTTNsbWNodXB1bTZNblVO?=
 =?utf-8?B?VjU2bFd3UlRkSDROVkI0bjFCcFJaM3JYb2ZvNzRkWk04S3pXd2p6ejMxWXo3?=
 =?utf-8?B?cHBCWmMyS053UkZocWROZ0dQV0JFM1J4RGZUdWlHYysweWExR2JzNzZ5U3lG?=
 =?utf-8?B?aVlIQld1bmVvbndFdHJyMCsyY25yY0JqcWVFclVxNHhWeWRVZVFzQjZUY2pC?=
 =?utf-8?B?YjV4S1RZcWFiNnIxVlRmVHJOUi90M3V3d3k0b2VoTlhQTVprZGJ3amVDSFBX?=
 =?utf-8?B?eGtleEhrS3ZON0RPUGZsR1dCOVNqdFJMRmNtZ29sV2Z6eERSN1J4NUJQVUNX?=
 =?utf-8?B?QnZpS2E5VnR1aHlEVFFKYmlhbXhQNTJHbzR1V3V5WlhDUDhnTUVheWk4cWM1?=
 =?utf-8?B?WnZCYzFFY01BdEczVEh3c0hZQ2RmOVVIZm84bGEyalhIYVVIbkozUEZjVkQ0?=
 =?utf-8?B?K3NYdm0zWVV1aWcxUGhIdlh5NVpYYnA2Yy92Rno5SnlzeFlDcXRUMy9lem5W?=
 =?utf-8?B?bkwwUENyc1NyNVlCVmhoZzZqU0lxZU1CVVVoNzZCR3QxTVNTOUNBZ0VINlRH?=
 =?utf-8?B?TnZReHI5OGdCZ0hNRWxqWDVSeUZYYTNTTE5kQUx1VnFSc3Y2RUhSSmJ2WXF3?=
 =?utf-8?B?T3o0cldkaEZqSm0xb3RCeXprUVVYUG4xTVNoY1lXYXd4TndJRlJPczVUblQx?=
 =?utf-8?B?UzU5WTQ5aGc2M1hxUjBybDQ4NjBKaUV4MW9JanQrcDJCRUtDUlcyNkRkbnp0?=
 =?utf-8?B?WXNRYTBFVWZQQytJTlpoc3FzSGJDSE1ZeGVCbjdhVk1jN0pWQStGaE1iVm9j?=
 =?utf-8?B?aTNsRnhzWmV2TjZWK0lDREdmTENUNmVqSGlFSVhuN2RFVmVqT3ZsRFNzWDJ2?=
 =?utf-8?B?L0ZmL0ZEOFlPVjlueHZPSjc4cGJGVjIza1NEZTg3ckVXY3pDNzZUMkZMS2Fz?=
 =?utf-8?B?TGw3b0oxNmFNU0JLdGdZamlKUjk4cXNvbXNhWWVZVmdOdzl3RGdGbW9ZNEoz?=
 =?utf-8?B?ZTM5amZzWEZ2M2R1UXhEanpycTJHYjBBaHNFck1wVWI2cUZEcEdpTjZzbTJP?=
 =?utf-8?B?Q3J0TXdmVm9adXhpU1Q3eVNrWkRKMmNEWHdoSzYzS3A3VWRNOG9zNGl1RUJ6?=
 =?utf-8?B?RlJYVHZ6QUJBUnUxSmtHNmZjNjIvUWZOMjkweGdnUkRpTVlJK0NtOS93QVpa?=
 =?utf-8?B?TDl6VEhndTRvOTZFcmQxd0FKdE0wMHFGR09aTlZCWk5aYmtBNVY2L3ZKaUI2?=
 =?utf-8?B?UGIwZDNHb0JoZjIxZjZJb1dsRGxRQ1hPdWhTSWFmRU5qWWlCMDAxRjlQSmt2?=
 =?utf-8?Q?wtVhzvQyorF94cUTon24pjrrlH16v7mkH1OVoIt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VElBY1RtbnArclRlbmk0WFBmc2VXUC9vOTFGUGJYNGowaWVTTUxXRXBHY3Ry?=
 =?utf-8?B?a05kNlA1WjFERUd0bXU2c3EvMVJEcDkwUlEybXlCeHRobTlUSW5xVFVZWS9N?=
 =?utf-8?B?ejYra25YR2FOVmphV2FuVzRyQ2Nyajl2bitnQXBGeGl1QzdqT0dmTHJYUTBQ?=
 =?utf-8?B?UzhTdWdTTTNLMTg5Z1l4bC9qT2owRjA4aGx4REF6U2JYRDRuTkpnL1JuSkRT?=
 =?utf-8?B?SHBHdHJzTnFYMkJxVUlyM2pQOGsyTG93WmtJeDJBQnJRelVkN0JCNWFOcUpn?=
 =?utf-8?B?ZlhzRmJEQ3BsRDZkaDJvZERZdU5NUXZVdHdXcjhXcXJubFRUUFREUUJMSjVX?=
 =?utf-8?B?aUkwWE1QdmgzeDIxcVI4NDdBOTJjRFlNbzIwRjVjbnJTbXcvWFZtWDkxd2Ro?=
 =?utf-8?B?akN2UVNHWWU2dTZsaUtzbzkyckE2KzE5T1VzTHJxVXYvREQwSHlBeDI4cUFT?=
 =?utf-8?B?dFJqeHVCRThuaHNjbk9yeEgyM3BuVEFneEFmcTNXWkNEYmN4Sm5CQVJPNlZS?=
 =?utf-8?B?dlF3R1lTclM2VGtkeFppU1diUEFLVFpoUDkzUmp2Y3NhcGU0WjJDbk1QTXZ4?=
 =?utf-8?B?RE96NzAyeFlvaFJpbG5jbXlGLzh1SncrY25PYWZIdEpaMFdDYkp0OWkxU00x?=
 =?utf-8?B?c1JyYnNOTm5Yekg3M1JQNi81UnlQSlRvaDB5NjF2VmlFVDJDWDRiemg5T1A1?=
 =?utf-8?B?akw2c3o4aG52czNZci9GVERMenREZDlNdUNVeWxFd1FHQ0JaSk40SS8zUGNJ?=
 =?utf-8?B?MXh4bGliYnN6OGZjWDVMbDBHREZYZVBPNkRCM2VsQUwwRENKcUNta3pSbElE?=
 =?utf-8?B?R2FUY25hWTU2RnVCUlVwdTBubGJ0bWcyamdWbVlSQURmR0hvc2V3VCtvL0lq?=
 =?utf-8?B?RS9XcGI3dWJpMDdTM3QzU2I5Tmlqb2RkQTI3V1ZSZ21VRUI1a2RQM3FYSEUz?=
 =?utf-8?B?ckxUcm9sWkJGVklzelhyam04VjMzNDE4TmtXekZLMzhMMlVqT1pxTEhDSEVB?=
 =?utf-8?B?WU4veE9sTTc3USs4cHR4dDVkaWRtZThOdzZZZE5VTVFLdlpsdWNLTWw2M0VH?=
 =?utf-8?B?QzczdnZiV2JoeUgwcjlVdFUxK3FVQkNrWGZKMlN6VXp3eXFnTWlZUmlWd0gx?=
 =?utf-8?B?TUp0ekdsN21teG53V2RHV1lpeTN6MllXeFVFN3I4c0R2M2ZMSDkxSzdSUGlR?=
 =?utf-8?B?b1pQYTRleEt5YnVhd0xtaDNuMFFubjZyblgyc1pzbzMySGQzaitJYng2WG1r?=
 =?utf-8?B?Qmxid1hvc0JjZ0xiZElOVmlKalhFWWhSSlVudVpJSXFGRFJBSGlRVXVuWTMx?=
 =?utf-8?B?MUFFL1JlcXVKTW9aaVAzNE5xdFlDcE9LMXAzRUtNRGNuWWRIV2x3MTloclc0?=
 =?utf-8?B?QWVzYzVrVTAwZVYzYzVNVG51Q0JuTHNjSXRrTnNIR0xNTzk1VHh0c0h5VnU2?=
 =?utf-8?B?RzQyLzluZjVIeVpsTkxFRThwK2JVMm1ZdDNqVGxhUG5YL0YwRSt6MWw2Q1Bv?=
 =?utf-8?B?bm1CMStDNHU3NXVmUXd1OFFLNVJzbVdwaEpvQUxRa3E2TnhnUWNBcThrQXZx?=
 =?utf-8?B?dnpCN05Bcit2SUk5c0pwZzVSUWpoMDUyVjczRWlrTW52em40ZGJNbHVuNEhI?=
 =?utf-8?B?MFBaUWw1T2ZaZlljdE8xS0hNU012QWNuMlJWaExwTTZveWpOYmpTTC9mK1BC?=
 =?utf-8?B?ZDM4byswcnFtZEVPcE04Wjc5SzVtZ2x5TlNjOXhKQ1crRjJseXB6NEZJUTRS?=
 =?utf-8?B?Ky9uOXIxMlFQb1oxVGphRnRQQ3BnK3BnclVYUHNYVDFCOERtYzJzUm9NUlJj?=
 =?utf-8?B?L3RsajJVdXlPekhuUHZaTllrcVBYcUMwbGFqd2xZc0JqZHpMS3B2bDlQY3No?=
 =?utf-8?B?eUcxZHI1WEhGWVhtTXRoMlJ6dXBSNEZzbC9iMnFlcWhBZHhSMXZFL1FjbS9B?=
 =?utf-8?B?SGFVWEI0UU1jQTg0Q2ZqbWdQTWlQS0sreG03QkdEYnlTYlB1eWxDN2Zad0Ey?=
 =?utf-8?B?bm0zdlpYcTNDc2NUdnRFMWo1VlYxbXMweVBJTGp3Q1NsdURybFVHRTNXaGpl?=
 =?utf-8?B?T0ZZWDBZYS9nQTNVYTN1dWNrVTN0WS9BR2Vxc1NWVXpNL2pZZkd2T0JTcnow?=
 =?utf-8?B?bTB5Yy9BczlrODZpYnVnL3FhUVlFZ1R4cWgxUUVOUU4xOTdLYno0MVNxeUc4?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d1cfb0-ee9f-486d-36f6-08dc91e2eb92
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:11:38.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dtI4ihlMiFgshPquPjXQWlj8H6vQ3bsgRSmm6pEp/HtQyFbD367Kd8vOQS/t1ZkNNl2lTPtCKsdRxxVtK3cNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6314
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 11:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16316

On 21.06.24 13:03, Shivanand wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.secureboot.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 509de97..e6c8b0f 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -181,7 +181,7 @@ local_conf_header:
>  ```
>  
>  Replace `demo` with the name of the user-generated certificates. The user-generated certificates
> -need to stored in the folder `recipes-devtools/ebg-secure-boot-secrets/files`.
> +need to stored in the folder `recipes-devtools/secure-boot-secrets/files`.
>  
>  Build the image with user-generated keys by executing the command:
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


