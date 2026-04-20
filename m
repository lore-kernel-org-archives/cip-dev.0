Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860AF557EE
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 09:11:53 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15354.1776676305817596710
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2026 02:11:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QqfNl4M5;
 spf=pass (domain: siemens.com, ip: 52.101.70.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV5XVEdtAvxaMxU4Gw0V0YAq6qmv4+Jhx/TVcT3rrfroMJt6GecoV3899WZFl+wspP752z8XxGmx3c0C7KbzvBqL16pv4I7CuBwW2dUkwDwFzQkPXpGJ2YcF1la3FNi0Y3Zvh1KojCMlox/COjeDoEOMyiGXfuRQvWRH1AzSauMp8BVrBBA+4iq0P5/4iS9nCe7JkHRpcx3sujKvoaFqyYuIc9T0ycaqszp21lwbskC33xJnf8BrxpammcJ43HAjlry6rFAOm2BWiUF6FftrSaVvESZNXrEVq2Y0vdARBgkOMnSdS+c7zKpCkFDkWQd8VQUv4g8EQGkKK1Sp9L70UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqArbN3F5w0z3Dca3QQPiseiW4n0eS4A8g8NnJQCzak=;
 b=SfpfV+7b+M1/DBk7whK1p6i+lw8DqpllLEDYM6xBaaAR3S7x4ytU8Kw6EbPdjYzbGM/qA7LbHoNyw7GcFQp4pdvU8IlN9GjYQWtPntQpt8gLUQcLnt1QcY0TVWednVHALfeYuWKNnhk/EnkvaqM3MTCdA6a5CX9iSqD2u0rNsyGRK3XatuBOLkp3YD+BHUpXu+d93UNPghAwB8CUtl7egKoCSl7QMc+EFRKttj1LOTMmYJsqNjSKXvitzSaHNJH4hw6f/tDa7BYlFqmk09QSzFTWVSPt2uPbfC+sLmTHFQvsyyTVZAvlaD2MFafcZHfMmiXBV6w25NXAsro7MefgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqArbN3F5w0z3Dca3QQPiseiW4n0eS4A8g8NnJQCzak=;
 b=QqfNl4M5TuLCodiqaXlVykSQr5FHiLCLg1gXvplSf0fH8TkciLjDUMCcg95OxgNncyWunE4Dhydr7bO2SARIuD92Gn+skXXItn+Qisr7EelafL+jtjfNwSWwtju69WqFJcbVGdra5k6moESBdhfPwWeFFaz6lRc2AI2uauxOP3bt4n68CDg5zwj9U1jgdGS0KXXvD3o8yYRdqG013v+U6vqjgg0k6k+XQ4zPgrTHrhP7HdMetpJ9GpgTyrbAfHyHf6gxMCz3jfMWlhWMZ9YcCXNioj3jeRZuZuQimUsyiMWIMC5wWCWv15KaiHnPr/OT1xS1X5gT1VOtSdhHiVP4kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 09:11:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 09:11:39 +0000
Message-ID: <782e663a-1503-41ca-940e-6f99da8c1a47@siemens.com>
Date: Mon, 20 Apr 2026 11:11:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate-config-wfx: make device
 identity configurable
To: Alperen Erdogan <alperen.erdogan@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: erhan.cakir@siemens.com, gokhan.cetin@siemens.com,
 "Adler, Michael" <michael.adler@siemens.com>,
 Christian Storm <christian.storm@siemens.com>
References: <20260420080018.7091-1-alperen.erdogan@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260420080018.7091-1-alperen.erdogan@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bf1fc7-d013-4551-0de7-08de9ebcd4bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	OwyJJkhifgbw9nUQe8JWq3bXfDxDVsqEWc8KUSOapfbkpkoFLMryryuErgntwA5oGI+0DIafL0xYSxbp8NkoGqEdyxlZ6EXtNUinIFuLxUtbtcB+dps2Ap83PR7PGCQsf99Nu3Zema4CGCUQhH3BySTWNIHqDJK429tQpb6fegVoQLVVXgYO/4bRqe0jemQqw77FBzjI3q66qAeIhMszjenP2A49s4HiFcvqAR/nAXd09s/SUqLyuSNviHnU5Ot++Vpzch9frBWkEgLEcwbm884bFnhQ6Gb5qyNFPJQRsW9O/HOwEPqhkaYuRsffzFCDiKnjKSjtX5PowZ5QNXvQemNYYmPfuGUfFdugzHWiixfktm1OF/ddGduFNlfmViaE5n8aALm4TxwMe/Kpjuflnxd7oSguGBCzWvYG78ZMsIcFve64uKH24gT7bvSmMXWerX/4mJe3pyeTxq0cmhHX89HI4gTdv28RKLMcOLqDj3c1O4BEQIt3S9OiCNudCypKQQXFhledphbX9pZLBt4fkVZm36BODDrO52Fp0YPqJbFni/qfhRMLa10W+wfWt466+4RUE/nFNBUPuY6zkZAheyZHfzMHkbs6BEKL2HMzdjdqco2LlKcdyktMhY6x9Y+/8mv009UEchXjuhpEHJ4eGSZtKAIQMkToNaItsra/WzswPwMwPnzLFBrTo12nIqK4T+s8JGizJnGZfJCdvCCahR41LXOhD75A6knjiEsaDNg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVpBckdqcTdLOHkvLzFjelpoWXdjTVUrc01nM3J3dmd3MmxHRkF2MlNoWUpv?=
 =?utf-8?B?Z2hmVlErVklTenZzVlQxVlEvVzYvWmtONDRYSThJQUxaQ0orMml6VGxucDBC?=
 =?utf-8?B?U25rTDNwYWszQUMrVXhtQ2pJa1JPNGJNR0haa2pEZVdOL0JsRittTHo2alVp?=
 =?utf-8?B?NDVUWUNSc2tEUnN6S2ZVa2pVeXBVQmFVaEtINEdKVjFqRzRjWDQxVnFhUkZx?=
 =?utf-8?B?NzJ2cmFZQWEzNzFtL1JOeFk1b1B1VWRncW1TL1VPSnFjMHlJYVExYXJaRWVE?=
 =?utf-8?B?Y3FjS0gzSk1VbGZxT3RVTHZLYlNJTDIxRzZvbGY1WWNSaTNUbloyUDNjd2pT?=
 =?utf-8?B?WUtpb0VvSFRQdUxrZXNOWVdkWTJWQ3dHNXE1MHZIa3U0WW5aYjJNZkc5U1ZX?=
 =?utf-8?B?SjI2L3BSTFJtNG5URGVGeDVac2podm8wempkTURubmVCMUdDS0NLQ1d4Sm1T?=
 =?utf-8?B?VER2UVh1YXJvTHF1OVhha09FZjd4QmJYdDdmSzV1OFZLd3Y2c1JGNE1JN3Ew?=
 =?utf-8?B?TTF4OEhQRVJSang3Z0xGb0VIb1ZjUjNtYWdkRlpRZDV3NVl6STZOV3VQTkQ1?=
 =?utf-8?B?NmZTK1c5bnhlWU9IL1hKRm9HeHRVVUl6S09DaXhZZWViMncyZGJOekMzTTNL?=
 =?utf-8?B?MEZoRlM4QnpkOS9XN2pTcmxJZmgvSFNGM1BSdUlSZ1JGdW9Sd2NMdkVKK05w?=
 =?utf-8?B?Qy82ejg5ZjBYY0VVa1VuNWoxK3phQ01oYmkvWFRDaXBHRnhlM2pnZU1ORTRx?=
 =?utf-8?B?WUFwcFNwa29JZmFTVDhPUkVHSVp2S0hvc08vaFVTdU01MGo0b3E4cms5TmFu?=
 =?utf-8?B?ek9KR1VHY0loWCs5OW45V09TbFJYRlpHS1hiOUtvMGJzUzdNQ0ltSWNmYTgw?=
 =?utf-8?B?cVFPY3Q0d2ozWUVnb1FScUlNT3J5TlJSRUNNeTVjTVlmT1dxTUFkV0J0ZUxu?=
 =?utf-8?B?Nmx0RnVEUHJIN0xzK3JYcW14ZGhIZG15Q1ZmaWg3U0JJSUxhak55RnBjM2Nn?=
 =?utf-8?B?eFVWbEQwVUMzSVByNE5JaE12OFZ4V3AzTCszeUlWL3JkTThBOStTU2RsWTdW?=
 =?utf-8?B?VmE4YWIxcytJWW5kamJjRUlaZDdOOTRuV0gxUXhkWjZGWll3OUFNRkREL2Jl?=
 =?utf-8?B?SkF5L2IyQmpQalArMXl2WG9Za3Z1SG9qcTZUMytjM25kTjdsVmEvd0wyMHJM?=
 =?utf-8?B?ejVIa2N5MzhYUjlUaTV6R0JTdTZPclJsV21vclpBSHFoMmlUbGF2bDYwakhE?=
 =?utf-8?B?ZkVXQlZicnJwV01UWVVNUmtqaVU4S1lzY0pFNHhudVNrenJyaENjN1FtYWt1?=
 =?utf-8?B?d2pVRWUxRmttSTBkQW9zTFV4cFFCM2xEZnhBK3FUa3JjaGYwTXljUzQrOXh2?=
 =?utf-8?B?djVuRzJzMXFrUkZKdmZONlVnQkNqTUs3Ujh3ejNVb054dnB3enRGdHV1bHhh?=
 =?utf-8?B?Zm5pWDNNdUVpdHZHQWU5Z0lEeHBvVlBTV1g0RnY4RDVoM2IvWVg5c2FtZTBy?=
 =?utf-8?B?UVJ1N3JKNU94TEhIMFNxQlNHWmRYUHlDU0pqQkhPMzJ4N2xnMm1DSmNnMklr?=
 =?utf-8?B?SGhiSU1wV0p3VTNGc1p0QVpvaUNFNnd4STNTMSt6MDQ4c0RLTldMdk1JUnlJ?=
 =?utf-8?B?NSs0UU42dld2MjRnc1FhK0UvdlZpR2wrV0o0UFRMVEQ5bGhQOTIwT0ZaOXdH?=
 =?utf-8?B?dVptSnJnTndCckFDQVVjUy9RQkovcGwwVWJ4RWpzTi8xUk5vU3EwV2F2b2VX?=
 =?utf-8?B?cW5QQ0ZYdW1FZHFTWWFjTzhSMDBuSVVBWk96aUlwZnZJVTdTVEl5THdYVVN1?=
 =?utf-8?B?ZmZ6TDNWamQ3cFBxakpUay9IZ1p5QVcvd3pNdVMyQTF6MnM2MTZBMWJ0dmZj?=
 =?utf-8?B?Um5lVXVkdjgxWjVjNFVKUUllMUZ3SDVrRmJ3K1ZObGI5UXREUFVoWEJiTVc1?=
 =?utf-8?B?eVJQY0lIRG9Wd1l5Q2xvVzlBZ2JqYXB1SXZNUGRGRWRQS0FObVNNeENDQUN4?=
 =?utf-8?B?SmUzblZZV0s1ejNMdDhpUHVnR0c5V2tTUWhTajJnSGlueURCd1RGUjJSeHFC?=
 =?utf-8?B?d3MrRkd0UnpjdlpIeVlmSnNjY3JBWFVNbE1nVkFVclZIcWY5OURpMEQ0M2FU?=
 =?utf-8?B?eEh1b2tNV3hpWnhKMFFZeVRlYktvNHhWMHdVV3VoanJmdzVZYndONUFXWGt3?=
 =?utf-8?B?NVNURENDK3BZTWFPUkhqZk11ZEkrcGN2VXUvK28yS2Mxd2RkbEszMU9DOTQr?=
 =?utf-8?B?TWt3MTFoOVplWjFEclA1TTl3cVBJMUJaNHMwckFITXp5d0dSVkpnTjVYOXhE?=
 =?utf-8?B?eE42TWQwTFVQb2xFRGtRT1NJemVCN280N3FLRTRVSEFKTGl4aG5nQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bf1fc7-d013-4551-0de7-08de9ebcd4bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 09:11:39.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iz2KpNPLly2QTSu7AHmScgL8EyuQLXIxwLP+udBuD8RENUbMx0GkXOqPPtC5mJ70JwpQnLgk7ybu/Nh4kocjoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Apr 2026 09:11:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22770

On 20.04.26 10:00, Alperen Erdogan wrote:
> Add WFX_DEVICE_ID variable to allow configuring the wfx suricatta
> device identity at build time. Defaults to $(cat /etc/machine-id).
> 
> Alperen Erdogan (2):
>   swupdate-config-wfx: make device identity configurable
>   doc: update wfx documentation for configurable device identity
> 
>  doc/README.swupdate.md                                        | 4 ++--
>  .../swupdate-config-wfx/files/suricatta_wfx.conf.tmpl         | 2 +-
>  ...{swupdate-config-wfx_0.1.bb => swupdate-config-wfx_0.2.bb} | 4 +++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>  rename recipes-core/swupdate-config-wfx/{swupdate-config-wfx_0.1.bb => swupdate-config-wfx_0.2.bb} (86%)
> 
> --
> 2.43.0
> 

Looks good to me so far - but would you mind explaining your use case as
well? Do you replace the extraction logic because your target provides
an production device ID differently, or do you pin it to fixed known
value in a development image?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

