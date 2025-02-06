Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC88C02194
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 13:14:15 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.web10.40397.1738847649821213991
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 05:14:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dnXEU4Tt;
 spf=pass (domain: siemens.com, ip: 40.107.162.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gslrLMRgWW3TrPOZeT1BQkWFeCMrM3M5Xz2YjAAfY+Ja23Kqoe2NpHKEU9eGUvA1bNYjET4rwncZlhfc5U4jKhKCqMKMQ9RAm9m+cAz8EaGZyKi+HQ4KvYcpINPrXpU72S3FUJ9zhAnoMQpMRAly8Zcrg6PYaH46+JVIsKu6bGANKhQzISnwzvuZXgi4Lu2W+JMKT8BDwn5mtgc02W2L+uvz8/r7HtTlbjBeZ8t4dlLqM6T4p6jmIzPF9CtbCzmW2fHWjqhJzTDBiZS8owKQr1EABqxn7Y8LIWT3NfQXCfX9DAm2zCBiVFIIky0jR6+yJ0Jbqcdt8km9MJ60s+uDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6b4MtbcRA1mUzKLRpb9rM8vKElJucqQhy9119AMujo=;
 b=lvcZkVqNTl61xuNFhQNkjRgZbL4/OvlAzkAzA/kQOO+cxR55zfACVP035q3aU77t15AsaSFCf2IxAAO1oEoig6JnHynd6vUNPu6dSEWgQlDzCVE3B+vjqDYuMFNmu1ciNV/KsSvnNWSKJWdeoXQfmIRXkAO4vHUdgANGR7/Gp31oZwahZCVC/RslpUxdOavhXJcIN2TySe7d3RG0VGLz7FPImLG9jgaTxf5TG38W5qtN+gE+0dNzpW7DePKheuhTo1jVnzF1k0fx4ZeiBQmMWCnZrVbDwkTYR/2/RZ8/lJpVPBUJIN7fOLejy1dQWxJvF+GfufCP/1wjW+eVtmzxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6b4MtbcRA1mUzKLRpb9rM8vKElJucqQhy9119AMujo=;
 b=dnXEU4Tt98NzNbIQPWFThWfMOwwFZJ/o5pqyY3yEex3VWhH7oAjCvGbWA+zDTkPqO7vmKPtPGv/phBDa//a+mZA/hFfY0XPFWEou5EvllLx0vZ62N3/GYKKVWeNppQ+xeeKPL7kpY5NdA4NGZCFY9Ww0ejHik1KC5/dbojiq+cx2Qp6Wa2zqyo3VPAeG1sPb4p+KNrK/m0Z0xCSTwc+krJpb/kvQpyjhNo+h3/qWkSyiL8XgoMgQrRsTxTXxoRJazuk8tUR1LhINzeF1M4dNJnpYLPdQdJE48N+/b9rGd3ELtWqWymlpr0zDJQTknHTv3ZARwHwTNuHryngAyDi+LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:451::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.7; Thu, 6 Feb
 2025 13:14:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 13:14:06 +0000
Message-ID: <ec851152-cd06-468e-b1aa-53ab5e1a0a42@siemens.com>
Date: Thu, 6 Feb 2025 14:14:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: update kas-isar from 4.5 o 4.7
To: Michael Adler <michael.adler@siemens.com>, cip-dev@lists.cip-project.org
References: <20250206125650.164733-1-michael.adler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250206125650.164733-1-michael.adler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddd9b1d-d520-4911-231f-08dd46b02254
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q1ZJS1E2Ylo0c2hNZS9kNjBHajNjWEYvM1kxQ0VlMkkvWjlGZ08rYVo3YytI?=
 =?utf-8?B?THhwOWx2dGNZUy93V3dYUEladEVlTUlsZ0x5TTRpdEJPZ0l2RlN5Y1pTanlB?=
 =?utf-8?B?VllHRTF6c1FIMVBVSGo0OWFaYXRPZit2RG1vcnJSVGkxZWpiWEs3ckZDaUVE?=
 =?utf-8?B?U21HYXBVTzc4dXp5RkkxbThJSTVmM0xWS2NKVFg1OU9xSmlwaDJwcUFLZXp0?=
 =?utf-8?B?c1htMXRuQ25GdUg5UCtlUFNwbnFZUEFibnNzTWcxR0h3U2d6OXNBNUo2eU1X?=
 =?utf-8?B?UFZGNzhXWDNFQUREQm9DRk5mWk1QZmlsN05HSTc0RDdMckFnbEREemlIVHNI?=
 =?utf-8?B?YUtxOXA2K1AwTXpRc1dSQzlJN28yUFltZGV2MzlQalRDeVFSclhZbElvdjRM?=
 =?utf-8?B?MkhrWS9UUUNMWUtLenBTUldjTGpUOWV4OFlrQ2YyVU12Z1RhUFNWTjIrODNl?=
 =?utf-8?B?bEQ1aUIzcDBmcmZPVllRK3hVWVoxWTJxU0R2dE04QmxVZ0JPa00zRWxSdGV0?=
 =?utf-8?B?Nm1MY2hnM0VhNjJkNGxPaHBXK3ZaZVVaWU5obVFxM2JBMGhDa2VOYnlXTER1?=
 =?utf-8?B?cW9zU2lKUXBrcWFjQ3l5S1lnbjc3VzJmMTBURmJhb1Z4ZnhsWU1IaGRRb241?=
 =?utf-8?B?dk1VZTFueTIvdFdEZWdHY09YOVlOU1hGUENKd0FZclJEWklORmx0L0NoM3RO?=
 =?utf-8?B?R2JiZEk0TXJGZ3MyMmQyYURGL2FzQTRxV0t6WTlSbHJ0TDA2emxyaVdZeGE5?=
 =?utf-8?B?cjluU1dweHNIMUN5V0prR3ZlWkdCTjlSUnpoeVovS00yTlRmc2V4ampvdE9l?=
 =?utf-8?B?SVUvUjd0WVV4Y3hSR2lZb0ZhY2pWUXYwcVUyTHVVVG0wNnlPNXdxN1krU1NQ?=
 =?utf-8?B?MTBaWC9NYUVKMXVXRU80Mzh1UVNmTXFGQ2RZajhyMU9ZQW1TVWxmcjJnWG1Y?=
 =?utf-8?B?Q0psbm0rTkN2TUphYmtveWpsOVVaYm5RMXRYc3BmUFlGQndTN3h2NktuN2hY?=
 =?utf-8?B?bGZVdFExTnJJS0Y4em4yamdJMk9KS28rNTVJVFZTUDlBdmhYc1ZFRkQ4bSts?=
 =?utf-8?B?cStiaEFibTRmem9nd0UrZ21DUitGazVkNHU5RmEvcDFIQmhzUnY2VDdOeUho?=
 =?utf-8?B?LzFGR0tWc3FBeG80UWNUR3N1QWFocTlWRlVMY1lkNkdnVEp2c0x3ZGJSV3Vw?=
 =?utf-8?B?OWlISmp4b2lCNENWMExOdmdiclcrQy9jUXJKYU1LWkV5TVNxQ2JvYmdTWU9I?=
 =?utf-8?B?TzYrTHhnQXIyeDZobUlLaEY3eVlJR1VJREhadHlVNlRsejE2QlpYQXBHYVd5?=
 =?utf-8?B?dlhqcW1lTW1IT2Rkc3ErVlNMYmNKazgrNXkvRHo5RmpQaXBKazhoclplUHZP?=
 =?utf-8?B?REJ1S05pUWNRdHF0cTM1L2VxYU4rUjZLeGtKL1RRKzF5WXRKZyt3ZmtLc1FV?=
 =?utf-8?B?eGtRVFk2U2tOMHVKckRuSXozYi9qMzRpWDFMb3RhM0xndUdFcXdKZ2ZxT3JX?=
 =?utf-8?B?NktzZndmVFNuanorZ2kvd2ZLQ2U5aGc5d1Ria1pBNWZ0SGxVeDZyekJUWVNW?=
 =?utf-8?B?VWFyK1lkQUZWZTJaOGUxSWZBTGlSMUJjOXdtQ1BWS1pmdFRKazNZbldmNWhv?=
 =?utf-8?B?cXYxaWNHV2M0NmF6bEFkUTdUeC9pbnBzMTBLYnZ5ek9GbXpNaWc4RHJyMUMr?=
 =?utf-8?B?WWtzd01rUjhVNU8wVDV5ZmMzZDRMK1M1b0hLaktheGdvMWkyY25xOE9ZcG1v?=
 =?utf-8?B?REx1cW9yWmdBaTFzZkQ4MW1zWHNxVU5SMEFndmlydjBXOEtoUHQ0TUw1VE0x?=
 =?utf-8?B?Ym9NSWR5V3BtV3BEem8zZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzYvcVBBd1FOdGdPK1pML1oyS1lYOWNNWHp5SEpSVmlCVFJFOXRQSjdFOVZH?=
 =?utf-8?B?ZDZzL0Mvek8xYzZKNjhqVXprVnNIOUlXSUkvU29yYmxtZFBLbDcwZXFSakEz?=
 =?utf-8?B?b1d2TzZINGhPUHBRa3JoM3ZXL09pNHlnUkRBQVB0ZFB3WXJneXZ2Q0F2dzRx?=
 =?utf-8?B?TklLYWlWNEJxbXlFZkpzYUZyMjBnekRsYU8ydk14QjRiMitUYS9OaTVTdy9a?=
 =?utf-8?B?b3RVYnNWdTNtVUZTSUhLWHg4aWQvVGVLeXg5K3I2dWg2QTFpVlg5WkFxdWZo?=
 =?utf-8?B?d0I1ZjZ3dmVZTENVQm5MQklBUEpSL2NxNFozQTh4SWhQY3VPSW1OZzJaWFBz?=
 =?utf-8?B?VWRrUHpGQUlWdmhybU1qd2hKMlEzWkRyMTA0NG5URVBMN3N1OXZJcGpaVzNM?=
 =?utf-8?B?OVBFVmhHQS92cC9ub09EV0QyeVVZeHB2R0szazc5NExpZ1FlUzlvSmlDdmZR?=
 =?utf-8?B?dzBQdTJKdFJVaWRaMEllTlRKa0ZHV3pzUTN1Y2sxWmRYSmFkRkxmdEluZWkr?=
 =?utf-8?B?Qm5maFBkeWVuYUs1akwyRzdlMGRMSGdmRjQ1TDcyaWY2QzRTZzJyOWNUblJi?=
 =?utf-8?B?T0pidS9xVnlGZEpsekpwaXc3bEFNd0FZd2RsbjYxb0g0V29sVEh2Z3RrM21i?=
 =?utf-8?B?L0V1QVhNWVNiQ2VWVXZ0QTVaeTltRzQzSmZFRDI0UFZEOXVaa1hjQXo1SmhW?=
 =?utf-8?B?UTQyU3FYZlk5MXk3eEg0VWNpOE9YTC9NTlZKSER6U3M3NDFUYzVDSFd0clhD?=
 =?utf-8?B?ZWFFMkkvcmNIbVd6U1NQd3d0L04veDM0OU5VZzRVYUt0OXFSYWRXT1JUT256?=
 =?utf-8?B?bytCNXRLU04rU21Yd29Dem5zMHBoeWFoaFRqR2RaV3lJclJOdGc5Rk9samVO?=
 =?utf-8?B?aVB0VEhEd2ZIQUU1R0dLdFppUUVIVGVDdWQ3aDd1Ym5vNGpjYnUvUWVCNHdB?=
 =?utf-8?B?R0RaTFQrZXYxVE54cURWTktKN1lnYjhlaUVXbDJtems1d1JuSThYdUtpVi9s?=
 =?utf-8?B?czdTcmFCb3J1alZHMU1zV3hUY29iMEE4VVAvc01NMUhsclpVRWxuZWhNVytN?=
 =?utf-8?B?YXdVUUNuT1d2ZndWZ0VNK3g1OHZ3ZGx3d3JUTjkvUzQ0b0txZEF3WEl5L0x5?=
 =?utf-8?B?SVNGcjJoa0VOVWg1cGxBSzdHeG4yRDN0SFNzY2Y2bDlTbmZtUTE0ODdvTVcz?=
 =?utf-8?B?aUNMT0h6VzA0WFhkM1pGU0c2VGRkWXFLRHZrUTZ3Q1ZrWDYvNEhEbUs2eDhM?=
 =?utf-8?B?RTN5dnJveVhEcmtINFNxUjV6c0RUNmFDdTc0TFNZR05hL0NQSjFXUDM1Vi9V?=
 =?utf-8?B?Nmxna0xMaVB2dC9XMld4UFlQRWpOWkN3M3dxWGNkVGRqWTJoYnlwN09jUUcz?=
 =?utf-8?B?WmRIMmNjNjl4dDQ1cjF3VDJGVW00M1ljZ01hRFB5ZjZKdkl5TWV0bjFUMVZm?=
 =?utf-8?B?K0hiQ2s4eDVsL1B2T3FyYUsrUkhjQnZGSlhxTXcrUHQvQW9uanJrNCtOeXBV?=
 =?utf-8?B?RzNpMWhxdEI0NXhPL1dUa0R4cG8zRkZXMzkxVmQxQm1ldVo2SGFEZ0Nicnow?=
 =?utf-8?B?TlkrTG1xeUVENnAzVE1UcU9DTjh0VG5qUTRwc2hkUUZQcCtFQmJSRm9vR3lP?=
 =?utf-8?B?TGd2cUNJNGlsTTN4b3ZnTWtqV0xCVURmZVFYejdWemNuUCtIT2lZaXh0Qk9Q?=
 =?utf-8?B?cVpIdEF6Snl0Y25UTjQxZ3NFaHZPaFZWN2Evc05UOWc3V2JPYkNRV1ltbjJi?=
 =?utf-8?B?WVpPUklNOFp1N3VkZk1qWVV5N3E3aVpCbk9QbmFaMzJWWWR3U3UxMDhjTnFp?=
 =?utf-8?B?eG03YzQ1WnBDcEZlYkpGWUw1WmZ0Z0xrbkxuTTNESkVkV2J3Ty95UmlXamRP?=
 =?utf-8?B?L0p4RXZSZGh2NXQ0WGIrZldWdlI0OEdMamZPNXNFaEFLNHpDRGZacm50VXoy?=
 =?utf-8?B?dzVYZUNQdWYyaUlLUUFMWEh2Znp5Y0o1SDJDNFppc0puVGFpb2NmSnZiZEJ6?=
 =?utf-8?B?UnVvSmFOOVVoa01Bai84MUcwOWprZVdaUk5tdHhoMVNxY1NQaG1rZ2Z2ZDlX?=
 =?utf-8?B?N3pGSXRvOFhxdzZrU3lya1g4TFZGTGZYVFVGRGFobGtYNUYzbUlOQzJ2NDZ4?=
 =?utf-8?Q?F62352GOI6MXzbCYjbY9pTj/y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddd9b1d-d520-4911-231f-08dd46b02254
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:14:06.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dzHnENBgHiU6SmLHEtt76cHB8asumLHIGlzvcTqP5R+aXMHcPZQRLGfHGDXmlESI9WpzKi1B+jGTFCkc0fpQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7148
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Feb 2025 13:14:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17761

On 06.02.25 13:56, Michael Adler wrote:
> Signed-off-by: Michael Adler <michael.adler@siemens.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d4bd283..62f6edd 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -12,7 +12,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -image: ghcr.io/siemens/kas/kas-isar:4.5
> +image: ghcr.io/siemens/kas/kas-isar:4.7
>  
>  variables:
>    GIT_STRATEGY: clone

Please have a look at past kas updates to see what it takes for this step.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

