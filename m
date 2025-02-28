Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EFEC282C1
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 15:41:39 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.51])
 by mx.groups.io with SMTP id smtpd.web11.18781.1740757296857343861
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 07:41:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mhlrJgU8;
 spf=pass (domain: siemens.com, ip: 52.101.71.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/pN77slIhV9ZPzjG9kqdOTla6K+9vN3KlLyCCG0O6QpWYoC7yngnToO+l22m7ORd2NpFlI1yVnw+zzMSNcwdsEjJ7XjlCwTrEEHFi6Rebbq7/F4DCOBdQupjnyXC6fWDWfTJGacnUBDlawQ6Y1u8cP9N9laJOBDfL9er6UZY/9hmkOjlTj7PbQ5/MLrwd4BV/hf+0lvbgBfWFx4Wmq5z7p2E2EqqmOhVCkmtFDRO1GyXsamaSD1M4yy5zK2fVPRu0Ryl1BFf/WtKcVslHkZ+/bUZXFjkEfjb+mFnIRVXf4tKIM8A4HBxjCWB2+WMmiUDqdAKx/BhGb5RZEqUWTfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEWUWsnt9SPko5y0A0GZyDuH57sDUL8EymxNgEnnd2g=;
 b=ZFeMyC3rBfLgOke15BCwKIdOGPDKthOisaMTMlO1yV+s6BiJDfLZsLroYT3s1JtiKXCl3Uni19jmWYDTSrRe++YN5+YO3IuM3XDgrxUyEW1HIN0llB3E45PTzSLyUEOrSmEHvUSUo90vWDv+I+bwBAKsyd0SKnBg+Rwtnd5T25ucNcjR4KLrrg7Fh0b8ODzDmdxmZL9EgJpcPjlwMF/Om9Va/63wL4/b86EfFXoBP87lA7SLdd+HTEXXk+U6nLUeZWjqie8eUmco+kghNI+13S/2x0+PtAgINLPb1tiqSoeyKI+lFtudK6JZKlu85jfj2u7OV/3ry/jTrjxGjygdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEWUWsnt9SPko5y0A0GZyDuH57sDUL8EymxNgEnnd2g=;
 b=mhlrJgU8bIE9cvqBctzCv9SR5hPnCWpFiZ+XZNrihCw/DZVWtCZ77m8wxb/dSCNPZ8lwJeqLEv6Sy+2C9lodZr2lEWmCunzoZnjam3ZoB6cVs518Zq1dAOehrbRZon3gwwoiJcwc3zfNdsHGQer0XGnscRAhnICP97WaFbHBTDOOu7FxmQ1BY21MEq0d6puwRUUIwmBQs9jPlu7uWJOc6BrVgUsefssjBtTf+rCNEiLXBmJ32GP7wsNe93LQHjFFvXx2WOWlNFhK1lW1gQaMmP94MUeZi/Y3f7NQBCG3fgShkJSbbsX0usx2UgAhDEHME25Mo5ZkyM/WLDwLKMhMzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 15:41:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 15:41:33 +0000
Message-ID: <3deff6cb-afee-4f1b-b6fe-e8b4261ff8cd@siemens.com>
Date: Fri, 28 Feb 2025 16:41:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] Kconfig: Add config NO_KERNEL for
 kernel selection
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1740746806-6557-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <1740746806-6557-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1740746806-6557-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 6717afe9-ac5c-4626-c2f0-08dd580e60da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SG1JS043TzBDNEFScDBVRnZPNFNzVG9jaWdheFhpM0RBVGtTV0c3Q2Q4b1NB?=
 =?utf-8?B?OWNWaDhZaGtwR2tTTEdPNHVTakJ2WUJySHhFR0ZzRDVaWEgyMmdCMUh0Sm9T?=
 =?utf-8?B?Q3ZyUnR6bklCN2F3VDJabGpSNVNQUmg5OUVvZllWYWlTSzFydk82MlZrNmJZ?=
 =?utf-8?B?RHRPZ0U3d1g0SmlZZWZNVmdzd0ZUVE02Q0haNkNTSVdBbld6QUNsSlVrYmd0?=
 =?utf-8?B?cklEN0h0K3daUDMwSUZnZXM2NHJRa2tpTEZoVHFEcEFuOG96ZXNvem5zUUFP?=
 =?utf-8?B?VEJOVk9pK25CQklrY29YbEkzcUdlTXFLeDBueUlTUVJNblpnMi9HNTZreS9Z?=
 =?utf-8?B?eHg0Z2VZS2tkK2FoT2VWMVZkaXNRMG4rNGdFaDJ3aW5jbE9hRkY4WGFWOWV0?=
 =?utf-8?B?bVZYVVpGdnlacU9qNVc1V1U3Y2V4SVlNa2FpeWVkeWZCTzV3OFUvanNFbUhz?=
 =?utf-8?B?bUFmZVlrakR5dGs0ZkczNXdhcXNrdzN2ZWtrMjRrS0xKbDdTeXVENS8yUFds?=
 =?utf-8?B?OHdYaHZwUlZHRFJZUi9qU0VSTXBLRzFTam1jYXVRVG5rSUFJYnNOaWFvQndk?=
 =?utf-8?B?MkN3RFU4WHZGNGxCQ2VrM2ZzTWpWTSt5THVRdW11Y2tGMCtEUlR0L3IreVR5?=
 =?utf-8?B?Ym95WnZ5cEcwdnVUVENWL1pMVk1NSVBuM3pSR2NnbitlQ1VlKzZWbzl2aXRo?=
 =?utf-8?B?c1ZQTmdCTWxsc2VBaXdXNU5YK1pxMFBOT1BSUkhkYkYzMys2MzYybEFjbDgy?=
 =?utf-8?B?Q0VoQzhGOXZMVFZlcjlMQmFlcytDQWNLd2FsRjhBbzlUWk85bFpPZmdTdVlj?=
 =?utf-8?B?azFTVy9mQVoxTDF0czNXTFI5NUtrcHBrZUM3N1Y1WWh2c1l3Z2lodDVnRWl2?=
 =?utf-8?B?dUNvUXJZc2hSS1dmZERhaFpCMEZJbXpXRGxyczVLeENRQTRlZCtzdGZDWUg5?=
 =?utf-8?B?MW1jeURNSWN1bkg2YloxaFQ2TlVFck9FNE5WaGgxeVlad1M2Q3dNN3VkU3BG?=
 =?utf-8?B?VWRaZ1BnM2JVWGJVc3BRSjJXc2grZnM0Z3hjN2g5WmRlOXFOTXZFcFhIOEJ5?=
 =?utf-8?B?bTF4L2RiKzJjWXFkOHdqK0I1QUxwUzVZUFNHdkh6MHFtZ0dHTWQxWmM1Rk1H?=
 =?utf-8?B?L1J6VVV1ckM1aWVZODVOMkJWNnBIYmhxOGhrZ0IzYldCMGpFK3YydXFLSzBz?=
 =?utf-8?B?K3IwTHlPYmNKR09aZ0VVVDBIdTVRbGdZbmt0YmZsUkVJMXJncldFSHhJaDZR?=
 =?utf-8?B?a1FKYWJoNC9JbXJFZUVBM2VTdys0Q3E5N3JkS3BTb0FKemlzUStoenFKZ3Nv?=
 =?utf-8?B?ZkxpNFdsRW5hRnp6Tm1SbFp3OWJ6Z3dQVWY3eXJCVUh2TGhValhZM3p6ZWFK?=
 =?utf-8?B?M0tKL0pOQlBuQWcrZmJrZ3d2cmo5Z1p4eHZocjZocVRMaWRPMWxOQ2ZXZ2dL?=
 =?utf-8?B?VlBZSU5vV2l2YkFqeGhkNmk1aUJvQW9NWnYzSnZLWTcrcGhHb2ZQUkFJYVgz?=
 =?utf-8?B?WjFWTU5BQ05ZMFJKbFdnOWNibnVTWmJ1RjlYdUw2elhWdWdxSnRzQWlkQ0w3?=
 =?utf-8?B?WHFhZDN3Uk1OYklrTGt6K1kwODNuZm50WVArWWF2VXV4dUJsRk1wVnQzU0xq?=
 =?utf-8?B?cnZnNTcwOU01c2c0V2NXTDIrVUJFaVNVTU1HWE12eTFDMm5OYytCUUh6MDdB?=
 =?utf-8?B?WnRWdlRqSWhNSWpsc3VEcmsvMjA2dUNWclFvT25nTVNLQlMzS1hhYStuMWcw?=
 =?utf-8?B?a251TWlzOWhyb3ZhZi9XNHlDWjJJMGZFeUc5UjFWa1BZclBHcStXclZuSXhj?=
 =?utf-8?B?aHRhUDVabndsbC9FTndUdjl6S3dBU3A1Z3lnc20rRGtMWEtjRVBXK243Qzdp?=
 =?utf-8?Q?NaR2hZGn11uAL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elJRdUFuSUQ1YnNQbXYvRHBLRVBSdGZDSXdOcktxc0tUbVBYRDV2ejV4S2lW?=
 =?utf-8?B?U1llZHFjMERQck1tTnZIcmViOVRaMFdXZ0J5ME45eXNIUUtHRGgydTROT3kr?=
 =?utf-8?B?REk2QWl4V2VENS8zVzVOZHpYR0hMV0tqd2lMczFaZDBtUEVObGM5YXZsU2Np?=
 =?utf-8?B?Nk9BRi8xTW5vRkREUFBDaUR0NjNxVC81elNuNmFsRE1vaXlsbktIK0xaVnMz?=
 =?utf-8?B?NjAwK1NkUGI2eDg1RVNUM2R2MmRkVUJIeEpCb0M3ZUYxVzNiTWxxbEZuSGhn?=
 =?utf-8?B?YWFmYmEwTEFYcWVkSUxwZnZsZmhUZnBnbDRYMlh3UU5sSFdLK1BZTXVIcVpy?=
 =?utf-8?B?WFVuMGltSjJkZ2JtVzdIMWI0OXJZNkZJNnJlS0xFWmpQV2w4aWk5T2oxbDd6?=
 =?utf-8?B?blJYVk5BWUpxRU9vNGRhOUZJaEZLQ2hzclVTWUFDRzZPdFYrUzl1MVdmSjBV?=
 =?utf-8?B?aTVYVXJuMmtXdHNpbkhlMFd2Z2ZUajhpQnpacStNd2g4WnpOaVFwbU9Hb0pz?=
 =?utf-8?B?aHBPemFzc09QSDM0aW9CbDBXZGJNczRETVFmc3liczlmZmswY2preWZTSlZY?=
 =?utf-8?B?Y2d4ZnlvRk9PT0RSVWJmNlJ6b2g3WklwaWQ4TjlGWEhTOHBhWkR1SldoU3Er?=
 =?utf-8?B?NGIzdDVIYVBLeGdMeW0zQWFtek5CTElqazN4SDZGbG01d2p6QlFiZ0ZpS3Vp?=
 =?utf-8?B?OGhkbXMvaTlHcnJUUDBkWUZRbHB2dmV3cFNJcDNPRmlVcUxoSEp6U3NmSTJX?=
 =?utf-8?B?LzhkMzdYTXVSRUZYREUxajJmMTNjaytXR045cjJveXVITGpuQWFjZVlCdGN5?=
 =?utf-8?B?cHpqNnh1RlRCWTJiaVZNZVVnN1pNemVGVkptTHVmelJCTmtwaHZTYWtrWlNa?=
 =?utf-8?B?ZEd0c1JrcmVJMTQ0VlZZVFNsS2FNMUFQWERGblNoY1pqNUpnK1VvNkV3TEZN?=
 =?utf-8?B?VmpTUklYNWIrVmdHQ0xWYjRSR2VhQWc5OXdJZmt5VkJwbWk5Wi9JSXdmOVVv?=
 =?utf-8?B?ekdXdTNidVlmK0haSXU4OC9aTGl1ckd0TGtqMndhdUNXeUdCcUNXU2pZdWMv?=
 =?utf-8?B?K2Z0eXJmQVZzUVl0TnN3Nk1wVzdvajRlR1A5QUlTbDNycTVOaWJLVTZ3QVJW?=
 =?utf-8?B?aFprY3N4cmJqcEpLUktxTFhiZ0FZSHIzclVwMWVjOTRoSnl6WSsvczMrdTAx?=
 =?utf-8?B?MkxIbmN5Mk1tbndLaXZaYnRnT0dHYWxXbzZsV0Q4NkxNVkNRWC9CU3l6U1Zm?=
 =?utf-8?B?TmxHVWR2N3lrbGNSaW11SFFXL044U1ZwSUpKRFR4R1NtdEFsK040WlJmM2RU?=
 =?utf-8?B?NDZ5d0FOWWhTc01SMk0weEIxSHJ4ZVp2SWY4OVU0aWNyNVlZc2JXM21EN1VW?=
 =?utf-8?B?S2VPamVFY2Myd3BXdktmMCtoQm1RYVZlUUFPOFZTWTVKUGUwc2d1WXE1bXZU?=
 =?utf-8?B?QzNqd0R3SEJFaWFNM0s0bGNFbHdnQUZjc0I2bVlZZWRhbXdxdTFtZU56WEpJ?=
 =?utf-8?B?cEZmRkZxUGx0bjlBSFBpdDBrNHVvZEZrVXBrUGwzbVpqaW9DTnNlSkluWFJw?=
 =?utf-8?B?RHRuRnhJQjQ2ZW5URjJUNEZtR3RuSkxFd1dVS3NrZTRlbEp4SDZuN04remw3?=
 =?utf-8?B?WjA2NGVlMTM0QUl5UXBXTEpqN2gxbXh6NE5teGZFaGd0Y2w4OGIxRXN0UFZO?=
 =?utf-8?B?TzhucnEyY2ZUMHdHNUZleWxZdlNGUWlOU3RIcXVHRTFoOXNlWU42ZHlMbDR4?=
 =?utf-8?B?K3lOUTNFRUZHYkpHK1JUMTd6VTJrT2x1ZkF0VjhYYzBibzcwWXNYMC9JYlln?=
 =?utf-8?B?MStQVFEyNzQ2RVhuV21Cb25YaU5xMkd0R0QyRlQrYmZUaFBiQ2J6YlJENzNQ?=
 =?utf-8?B?MVMyMUxLekZIQ0JCSDlkUSsrYUdlVStJbVZGeUcxaStrQU5JMEZZeDRabS9l?=
 =?utf-8?B?NDJuU0psTStLOE12NUdFYW5IY2E3TzhrWUI5Q1JDZ3NsMHNsbDNkeTlneVdT?=
 =?utf-8?B?K3JSdXFudWNTNG9YMGp2cEE0TjBESnpXYnpNZ0ticXZobnBuY1liQmtaUFAv?=
 =?utf-8?B?TEF1MmVyMlA2T2Q3dTJOdGN0THRWbllKcEUwRUpaN0ZtK2tmWFo1dThMbWhM?=
 =?utf-8?B?aXBqWUVCZDhWeXJ3bE5ldkhkdlFCMmNZbHQ1d1d4UWZBVUQvRW10TW8yb0V3?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6717afe9-ac5c-4626-c2f0-08dd580e60da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:41:33.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbBW+hVQrzxZwillkBhxC5QTXDvSy/3RZVWxKSiQQEcuC/beosm+zt0cRMxJh1vVcossggEMLfyFjIdkrUzGfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7841
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 15:41:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17990

On 28.02.25 13:46, Nobuhiro Iwamatsu wrote:
> This adds config NO_KERNEL not to install the kernel select.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 3c246fa..cfa4d11 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -100,6 +100,9 @@ config KERNEL_5_10
>  config KERNEL_6_1
>  	bool "Kernel 6.1.x-cip"
>  
> +config NO_KERNEL
> +	bool "Do not install kernel to image"

When is this useful? And will a normal user of isar-cip-core have that
use case as well so that we should expose it here?

Jan

> +
>  endchoice
>  
>  config KAS_INCLUDE_KERNEL
> @@ -108,6 +111,7 @@ config KAS_INCLUDE_KERNEL
>  	default "kas/opt/4.19.yml" if KERNEL_4_19
>  	default "kas/opt/5.10.yml" if KERNEL_5_10
>  	default "kas/opt/6.1.yml" if KERNEL_6_1
> +	default "kas/opt/no_kernel.yml" if NO_KERNEL
>  
>  config KERNEL_RT
>  	bool "Real-time CIP kernel"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

