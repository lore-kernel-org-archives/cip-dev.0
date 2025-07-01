Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4322C83038
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 15:14:04 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.29])
 by mx.groups.io with SMTP id smtpd.web11.13592.1751382835921488466
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Jul 2025 08:13:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eBSBblTg;
 spf=pass (domain: siemens.com, ip: 52.101.71.29, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4zBUEGHOke4DKmFsWyaBqa3cvGpV1cmxKgX5cl13OrKht6am6tDb0h5gOsNlI4JefU8/cs+iqLjdJ8ZU37AFnl5dxPE83HCNHb0nATO31/eeDH2bGT4dedAdHwNVzTyaK5oIWifTh0AqBm6cIWyINQr5twnLqalEQIMVUQXr8WHJZd/BftSqJHUSvWrHI65r+9HECRjlkWTPjIy/GhnUH9+xosIZSCAwSF9i5/Cdn7ACel37WXR/ui07jgDPKle+MoT3+zDFK3VDTa+1+EdFcf/p/+MLcejvmpjF0s22zDslawF4vjmor4OlH+lUoiYIAG4hYjqe+WrUtvwHujCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk+tLszvTHY5tOV+6XTjzywkrTbT25TyboVOcTuh5+s=;
 b=AtrOMbpCjsrkVWvrU2tZogYezLxGtSXjGAldIWUXQ5atue9GEhZpZ6nPwcf5Y1dljxWf2gQpptmjWIhN1SU2XWZ0N9WEzxWAW9v69aJmQ99Vv5meblaWz7fSBwUJc96EpnpfL2384upwx8q6Rwpbq4gQrs5LPC/cI6vOy/i2kL1dHCSN4YvnuNQcR7L6qng95lFbe7LMSZgLNz4imYAVG35wORGHyqT6UJMBN8k4uzOotfvzlnVAA5q5hmKtG1B/ojhY9WvVU7UzmcuOk0UepC8RliKSiOz4o49yireT0LvOQi/9jTzti1EEHYWrdXs1RHfu+s46/1RaZrs5axd0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk+tLszvTHY5tOV+6XTjzywkrTbT25TyboVOcTuh5+s=;
 b=eBSBblTgFmjQcgOfJId9zZXOeK/NE61iP8feZacoAjexOLwbPrzRXPxgJ9mPzjbj30g3WgF2N/13seq25QZaV+ZZ/YGqRZg0bv9fAIU9AW+vX/CtvG1EgNPGSiD1HQus53uAeAYDUyI2QlsMKl+kq8KKPLmcIuxjt3Rt4XTEcw5xB9B01i4N4/RLbo5NEX0s2111zXGaLBDJo4fgb+QlMr00zu1kwVTpV/N+dM+jCqdrQ2wcuhU/Di4nNO7mml6xFpcdz2Z3daVve4FTgai1srpPrzSIr71pRzBmkIPlGo6oY+igRdJsY04yRzcIjpeT45vYZVONS/zg/MehX65HxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 15:13:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%2]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 15:13:51 +0000
Message-ID: <6f2099bb-cd5c-432d-b4d2-79dd3782b562@siemens.com>
Date: Tue, 1 Jul 2025 17:13:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 0/7] Immutable /etc
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
Cc: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
 <881c1466-0b98-4f48-9faf-0c7c65cbfc57@siemens.com>
 <2fc7ada9-53fc-4fb7-90dd-45d275c90501@siemens.com>
 <a7ad4a8f36cb3606d772570b48b9d1fdeda24387.camel@siemens.com>
 <065d9adf-dce3-4c3d-b2a1-04e98e9894b8@siemens.com>
 <748cfb874c01c5437bd8d0a84b66cf5e28e3d4df.camel@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <748cfb874c01c5437bd8d0a84b66cf5e28e3d4df.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 3773cef2-c679-4469-bc8b-08ddb8b1e2ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bnU3dFdjVTQ0QzdGWjhTcDJ4Y2N1UUY4aWQ5WW04SjRoTk9oN1ZwZ3J0eVFO?=
 =?utf-8?B?Y0FpQW5Yd2M5UkNGcCtQSGo5YjBjU1FPcDMwZGQ2ejVhL3F3VXlNcUp3Y055?=
 =?utf-8?B?Z1RwSnIycWUvVHRsSEJWb1cyZnlUWHJWbnlCMnZGMHN5SkJiYVpaV2JpcjBn?=
 =?utf-8?B?ZXlyaWRKc3hMaDFqUVFpM3BTUU9NOTF1c1BqeWNuUko4cWgvNURYdjh6dmh4?=
 =?utf-8?B?WjRPejFTaUl5VGhDUEpTekFNWFJoVmF5bW5rL2pWaUcxTjBBazV0bkZZNWtB?=
 =?utf-8?B?dEoxUHV3emJqWHdXYWJwYXhkdXlNUGpzdE1tWGl3eE1VM2xoR0tTUUlLdHFy?=
 =?utf-8?B?a3l0TDlQRHIxdXVKSHFjWGZoMkJzaFdlTS9yT2RyM0l3Q0x2TkVPMTFOc1gx?=
 =?utf-8?B?M0lWekVRUnZQeTk3bGZIZDhlMytlamhndmkydHU4M0RTL0FFZkFFcGtJYVdT?=
 =?utf-8?B?ZldXdUx5dTBZc3VpbTJOdktQUk5RdUdQWkgvVkpJcWVFdnFhVWw4UHNYK0Zy?=
 =?utf-8?B?SzB5YStlcVFTLzVkOEtZSTJJREowQVF4cTh5YWJiaXlFWWR6SmJIYURDb1Ix?=
 =?utf-8?B?SmJ6ZmJjaGtRMENmNFlyL0VtMkh1OG1kMUZuY3RYSUJjMGdNRW04ZlQySDZi?=
 =?utf-8?B?czk1Q2ltdnRtbDV2RitiL0RwLzQxbFJ5NzQrZHNaS1RqZG5NY0NSKzd3QmEr?=
 =?utf-8?B?WjI3d0g1NXduY01WTDhia2RpSGxyVEwzSjVvMEMzUFVsR01FMGJNcjNFQ2pj?=
 =?utf-8?B?ZFJsYmtpQlpxN3R6ZzI1UmViL2UrbEQ1ZWJXbktVRzlKRjI3YXBnRE5FY09E?=
 =?utf-8?B?ekRIdHk5V2JRWWFsY1FhYlhYNE9xazBaamFpRjMzaDkyWjdrV2xlQXVENUtD?=
 =?utf-8?B?ZGlGeVZpdXUxdG5zM2VHNGhxcnh1VGlyQnh0L3ZUT0g1MGhuSWxnNTNKWC9N?=
 =?utf-8?B?YWNRcllGZkFFSCtnNFkrL2FLOExhZGdLZmhDR25OVnYyblA5WFI0dDdvaHJZ?=
 =?utf-8?B?Q2NwYys1RFcxVGhwazIyVEtrejVtdG1kZ3RDTFBtWHN5cnFMODNUODg4eUNq?=
 =?utf-8?B?dFRibXRkWDMwWlYrLzZZcGFFUzV0alhqbjg4MmI5dDFlNTFvd0RyZnh6Tk4w?=
 =?utf-8?B?RkhtZWpHT04yOXNJUksyWUI4OCtCK01QS0NUOHQ5NXJOSndwN2NyYURVaURO?=
 =?utf-8?B?K1RpQXhPaEJhOEdQMWpSS2lRM0plNERmWWdnUUIycjFmQkRlSlA5N3luVzNi?=
 =?utf-8?B?d3o0bkg1RFdIa2wwR2VCM0dXcFBzcC9jUG05NGhudHVmR05jT1k3QmNLM3lM?=
 =?utf-8?B?WHFhT0Y3UHdZMVJyZWJPWm9jRnJyYnoyS3ErOEFQOFdlM1gxRmo5ZDI4Z0Fp?=
 =?utf-8?B?NDduOEJuMGIzYUdnTEk5Ri9PNTNBdkordW1udFlPVTdJeVJkTnNWQ1lPZHZ5?=
 =?utf-8?B?VVFwcURuRnJSZm5Ia0I5UUZucE5WMzFoZzZVUXZucVRoN0dWcjh3OEFkaWw2?=
 =?utf-8?B?bjlvU0ZCdVFjbllYU0VwRHpnSWkzdEg0UzZQbTM0ZytkcFRqUm4rTUI3THlv?=
 =?utf-8?B?NzUzSy81QzIyUnlzcUJtbm4rd1poTUhBSGJld2duMlBTc2VWSjdRSUV4MkZs?=
 =?utf-8?B?RUtKeDE2VmE3Zk9SNU9aVHRuRndsTGhpVk5tZytQQlRudEVYaXJSREs5YnB0?=
 =?utf-8?B?eDB3S3R1eWxuVTE1akZ0SjFNZm5US0F3YUZUd0pDZXhSd1Y2Q0ZhNUdtbUIw?=
 =?utf-8?B?TjgxOXcxQ00rNmNmZTRWWHBTK0RpWTkxWVRzYythTktqemNEWk0ybWlZaEZS?=
 =?utf-8?B?VEd1LzZYQVI3U0JNd3J2a243c0hrdERpUnZXMUI3amJXb0RNNkp4UlQzaXFX?=
 =?utf-8?Q?3gztre+93I6UU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWM0Q2dtRDBJZ3RsejZaMm4vL2JCc054SVluTHBFNXM0WHVvcVFmOWhGdlQ4?=
 =?utf-8?B?ODRVUGRwY1hsRXpNaDlaMFlKL0NFbVZFV2trS1RYQ1h3SGJBMm9CcHJzaDY0?=
 =?utf-8?B?Z1VFOGZ1VXV2NkhIeGlNNEowTHlyRkNkdlVXSTBJdGZLckY5ZjZvRTMwVG82?=
 =?utf-8?B?aFRsYlp5MFcvSEREL0M0WkJ3dUdNYnFFQ2Nvd09kcm9uc0pCT0M5bEJOTTQr?=
 =?utf-8?B?STUrZlF1Qk9VczRmdGR3Rko5cnlCa0c3eCtlMHM1SXVXVXRSMzNpTWM0QllR?=
 =?utf-8?B?MDZvUGlMd09jZVloYkpXUThoRnVBZUtTcWljcmI3Z2VvYkcvUzZFMXVkMkd1?=
 =?utf-8?B?L1EvQ2lSb0J4dkxEYVRlYVR2WHd2Q1pWdVZrVlFKOGNvandNbkpjUXd2eTN1?=
 =?utf-8?B?c282MkJsSklDYjNaWkpwVFpqK0xTTDcxZGZKTmZGYnFFcVk2eHVlU1UxLzAw?=
 =?utf-8?B?MkVGS0lGMlFjOEd4ZytSR2dzUlZBWFhpQnZuQWkxWklaU2E2MlROSmhENEVI?=
 =?utf-8?B?azZ1eUxMRWQyYS9OQ0RnZEwrTlZaVmtUL2tkN0h5Q0RxWTJPVjVkTG95VjZj?=
 =?utf-8?B?ZExzL3R5TVZvbWtxYWZvblZFSXNRelRGN0tWL0tpNG0xYm5sQkxIQTFHYkRk?=
 =?utf-8?B?ZXB3L2IyWHNPNnlnRERtWC9CWUNFVDMrSDZyRVhKQkM4cGZYTnFnL2hNd2hm?=
 =?utf-8?B?cVY2VldlVDFyTDlEOTA4Zi92M3BHNTlzdzZBdUY2dHN2RkQ1QnVRRTMzbndP?=
 =?utf-8?B?OCt6TVBmeG44R2lNcG5HM2tjazMvc3lUbGdHZXp6b1E1WVVCM0pqSm9HOTBu?=
 =?utf-8?B?MFAyajh2RVdzTjBHVXFwT3o3RnNPdWdGdmRkK3ZtNzdoNzI0dHdKYzJzUjdm?=
 =?utf-8?B?ZGcrTnV2N3VqV1B0WkdaT3B2cGhEckppVHFnYTZSbUVSZ2VzbG02U0R0UzRy?=
 =?utf-8?B?NXpiRk5VVnhYN3RLZjlldjBBTUlmeWhGR1FVVWNWK2FLb0xFa3JqREwzTjlo?=
 =?utf-8?B?TkxnMnQ3NUM0T1FGRGg5eGtPWGNYM0tpR1d5MUhjRWRXcnpzUVRVRVJDOHQ2?=
 =?utf-8?B?U3F6NUdtRzM2NGVKRE4zb0JSNjlZTE81Y1NuQk90N3plaU4rQ1A5QkZJVzZK?=
 =?utf-8?B?czNUMzhCYVJoZE1meGprTjAvWGJxL1Vkd2dobjFBa0lsQkxkWitqOUxQd2xL?=
 =?utf-8?B?bWgxUlFhNFhGV3p6QkM1VTRsQk1EelpwNG5NNjJsZkptQ1RPVTRuYzdhOU1v?=
 =?utf-8?B?T3JLME5IN0pjaEJDdXdFcjRMT28zTUYxLzYvMXhRV3NQNHlTNGFNazFKNmpN?=
 =?utf-8?B?U2tjMjhGcnVEVU8ybWNSWG5SdW4zMm1iQnp1RmFzYnlpTUlYdTFTOTIwOENW?=
 =?utf-8?B?VmJ0OWp3UlA2V3lOejJvRjdjRmtKMHhFT1pIWHlSeCs2SU5zQ0JnUEo4NlNt?=
 =?utf-8?B?Q0xGUHZySENpak9sMWlGUW8vNnMzdGJBWjhDMFJSeHEyTjRlZzVDUlJ0c3lX?=
 =?utf-8?B?V1B1SG0veFBJa3NCd284M0o0Y3NCQk9hVzZnTFhHZmN3Nk83bXYvUnh3ejRk?=
 =?utf-8?B?RmM1ZTVKQ3I5Q0YzaWhXakRzYXdTZE42SUszMVBVdmwwK0J1TzhRSzZiYlB6?=
 =?utf-8?B?WmN1dklFZTNpUEhLREMyTGx6Rzd6b2wrWHd6YkVTbk80akF2dEtUTXIxdDJZ?=
 =?utf-8?B?YVI2Wm1wME54RG5uUi9qeGx4dE54VDdqOFpHZE5jdHIxTkFOVG5LS0poQnlv?=
 =?utf-8?B?bjVLRXMvaXhuQUNieWxZd2ZyTFR4T0Jub2RvaDVpOW1ROWdRa0tTTHRTN29U?=
 =?utf-8?B?bzQxNE02Tm1IQTlaRFE0MFpMQ280RTI1Z0FhZjZOd0hKMXcrRFY2QWFheDdt?=
 =?utf-8?B?a3JGdzdwYlg4K3RyWUNSY0NSbXBMOWtQYXVOazRDcy92Z05FWHhCY1ZmOHBi?=
 =?utf-8?B?VFMzRVJDZmt2a1FVRDEvZ0FzdGdiMEZSL3QxMDY4dWE5dnYvYWRVcnp5Vm16?=
 =?utf-8?B?RG9qK0dYUGxCQkdSZ3E0cUFzbkM5L3E0bi91RGxvaFFUM0FONGtleFZUT1c3?=
 =?utf-8?B?WkIwM1dNaWI3anBmZGtOS25uTFhsQTRjR3dHYVEwUk5ld3BXT2cxVm85c2Fx?=
 =?utf-8?B?RGVWV09PcytuWlpvaFBKUHRLZWIxdG56aEtLVUJ0cGpOV2FGc0p5TG11L25r?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3773cef2-c679-4469-bc8b-08ddb8b1e2ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:13:51.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ds/nKRVLehCdr0YqJkvzad6dCpeljo22/JJKt0/xIwCBNmfvAC1fiGsYyXWnuEE2CoYlboiZNw1kvq1+XpkphdPfgQuHSGapyhEMZJRN4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5498
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Jul 2025 15:14:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19274



On 7/1/25 16:48, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Tue, 2025-07-01 at 15:59 +0200, Jan Kiszka wrote:
>> On 01.07.25 15:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>> On Mon, 2025-06-30 at 22:11 +0200, Jan Kiszka wrote:
>>>> On 30.06.25 22:10, Jan Kiszka wrote:
>>>>> On 30.06.25 20:15, alexander.heinisch@siemens.com wrote:
>>>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>>
>>>>>> **NOTE:** The patch series appended to this RFC mainly covers
>>>>>> handling of /etc/machine-id (see below) in the proposed
>>>>>> solution
>>>>>> and serves
>>>>>> as a basis to estimate additional complexity ro etc
>>>>>> introduces.
>>>>>> Thus, be aware that some of the patches included are not to
>>>>>> be
>>>>>> applied
>>>>>> on next, (yet), and therefore, this patchset does not cover
>>>>>> all
>>>>>> cases and introduces some regression on the images built
>>>>>> (e.g. ssh-regen-keys)
>>>>>>
>>>>>> The setup used for the PoC was built using:
>>>>>>
>>>>>> ```
>>>>>> ./kas-container build kas-cip.yml:kas/board/qemu-
>>>>>> amd64.yml:kas/opt/6.1.yml:kas/opt/bookworm.yml:kas/opt/ebg-
>>>>>> swu.yml:kas/opt/readonly-etc.yml:kas/opt/machine-id-on-
>>>>>> var.yml:kas/opt/config-on-var-demo.yml
>>>>>> ```
>>>>>>
>>>>>> ## Background:
>>>>>>
>>>>>> During hardening activities we identified potential
>>>>>> security implications of having a rw /etc.
>>>>>> While this most certainly is a problem when attackers gain
>>>>>> root access to the device, it prohibits unnoticed
>>>>>> configuration
>>>>>
>>>>> You likely mean, that rw /etc "allows" unnoticed changes.
>>> Yes! Seems I confused permits vs prohibits :-) Anyways, "allows"
>>> would
>>> have been the best choice :-)
>>>>>
>>>>>> changes by tools running on the system, as well.
>>>>>>
>>>>>
>>>>> Can you please elaborate more on the actual threat model? I'm
>>>>> not a
>>>>> fan of adding such complexity based on "something may go
>>>>> wrong".
>>>
>>> The main concern is that attackers or poorly configured services
>>> have
>>> access to configs on /etc if mounted rw.
>>>
>>> While systemd brings fine grained sandboxing capabilities, those
>>> are
>>> not always preconfigured in upstream packages (according to
>>> downstream
>>> / embedded requirements), and thus, constitute a high potential for
>>> bugs and security threats. I have to admit, proper hardening of the
>>> services is a must anyways, but nobody is perfect.
>>
>> Then let's fix those issues upstream, one by one. The alternative of
>> working around that here, one by one, is not very appealing and also
>> not
>> according to our principle (upstream first).
> 
> Not sure if this can be solved in general. It's not that upstream did a
> bad job. More like, hardening of many of those services happens on a
> per-project basis, as requirements and use cases differ. embedded vs.
> server vs. desktop vs. embedded vs. embedded ...
> Anyhow, the assumption of having perfectly hardened services which
> remain secure forever is not feasible to me. So having both counter-
> measures (hardening services, extending immutability) in place
> definitively makes sense.

Most of the scenarios you mentioned can be solved by setting
https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#User= 
and/or 
https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#ProtectSystem= 

for the affect systems.

And setting `User=` and `Group=` can be upstreamed.
>>
>>>
>>> Having a ro /etc prevents many of the following attacks to
>>> **persist**:
>>> - enabling/disabling/masking services,
>>> - extending /usr and /opt by enabling/loading systemd-sysext,
>>> - permanently mounting (external) storage devices,
>>> - reconfiguration of network interfaces / dns resolution,
>>> - modification of ssh-keys,
>>> - modification of udev rules to trigger certain actions,
>>> - auto load kernel modules,
>>> - add users / groups
>>> - ...
>>>
>>> Yes, bad guys having root access, can do everything anyways! But
>>> that
>>> way we can fix many issues at least after a reboot.
Why not use an tmpfs as overlay upper dir and throw everything away 
after an reboot.

Quirin

>>
>> Again, I would be able to follow your proposal if only a few global
>> measures would be needed. But as all this requires pre-package
>> modeling
>> modelling of /etc persistency or at least per-package qualification,
>> I
>> would rather spend that time on fixing the root causes.
> 
> Observing changes with the /etc overlay active showed, it's not that
> many services at all. It's mainly services expecting files to be there
> (ro). Which actually is ok!
> 
>>
>>>
>>>>>
>>>>>> Further discussion is based on following observations:
>>>>>>
>>>>>> 1. Many services don't need to be reconfigured during runtime
>>>>>>     and shall remain static. With an (rw) overlay on /etc this
>>>>>> cannot
>>>>>>     be guaranteed.
>>>>>>
>>>>>> 2. Having fine granular overlays won't work either, because
>>>>>>     some services rely on files put in /etc directly.
>>>>>>
>>>>>> ### Systemd:
>>>>>>
>>>>>> Systemd maintainers suggest to have full /etc rw and
>>>>>> put immutable configuration to /usr.
>>>>>> While this theoretically could work, many programs
>>>>>> don't fall back to configuration on /usr and if so need
>>>>>> to be reconfigured (efforts not estimated yet).
>>>>>> Further potential to reconfigure services (permanently)
>>>>>> is still not prohibited, since in case of systemd
>>>>>> /etc has precedence over /usr (/lib) based configs.
>>>>>>
>>>>>> ## Proposal
>>>>>>
>>>>>> Therefore, our RFC proposes the following:
>>>>>>
>>>>>> 1. Having an immutable /etc
>>>>>>
>>>>>> 2. In case of non-epemeral, rw-able files use soft links to
>>>>>> /var/mutable/...
>>>>>>     In case attackers get (root) access, this still impacts
>>>>>> those
>>>>>>     configuration but the rest remains static.
>>>>>>
>>>>>> 3. In case of ephemeral, rw-able files (e.g. config that can
>>>>>> be
>>>>>> regenerated)
>>>>>>     same can be applied backed by tmpfs and config service /
>>>>>> tmpfiles.d
>>>>>>
>>>>>> 4. In case of rw-able dirctories fine grained overlays are
>>>>>> ok.
>>>>>>     But most probably on hardened systems config tools exactly
>>>>>> know
>>>>>>     which files to touch (so use can be limited quite
>>>>>> exhaustively).
>>>>>
>>>>> Are we the first to propose such a scheme? What do others do to
>>>>> achieve
>>>>> similar protection goals?
>>>
>>> 1. systemd / Lennart Poettering (see [1]):
>>>
>>> Two types of systems:
>>> 1.1: Zero persistency ro /usr ro /etc. The (re)booted machine is
>>> considered a completely different machine on every boot and, thus,
>>> a
>>> newly generated "random machine-id" is ok.
>>>
>>> 1.2: For Machines having persistency / config he proposes a rw
>>> rootfs
>>> and only an immutable /usr, but having /etc only (pre)populated
>>> with
>>> local config (which imo is not realistic). From the threat model
>>> described above, systemd itself, by putting precedence of etc over
>>> usr,
>>> does not support our case in that regards.
>>>
>>> 2. sytemd confext: Lets overlay etc with configs from
>>> /var/lib/confexts/ (among other locations). This if mounted mutable
>>> reduces /etc to ro as long as the config is mounted. As one can put
>>> unrestricted content to the confext (etc) this still exposes whole
>>> /etc. Further, in case we limit /etc to ro this still requires the
>>> machine-id hack to persist generated machine-ids. -> While nice
>>> when
>>> you plan to reconfigure your immutable system in the field, it does
>>> not
>>> help with the security concerns raised above.
>>>
>>> 3. yocto/poky suggest following scenarios:
>>>
>>> 3.1: run systemd-machine-id-setup at install time -> this either
>>> requires a non squashfs backed etc partition or a link / bindmnt.
>>>
>>> 3.2: have / read-only and an empty file there (for stateless) ->
>>> regenerates new machine-id on every boot
>>>
>>> 3.3: boot with / writable
>>>
>>> 4. elemental (rancher) / kairos (similar code base / fork): mounts
>>> /etc
>>> as rw backed by ephemeral storage  and bind mounts persistent
>>> portions
>>> of it. /etc/machine-id handling is done using cloud-config based
>>> workarounds copying machine-id to ephemeral /etc/machine-id in
>>> initramfs. -> Also introduces special treatment. Compared to my
>>> solution it requires special setup of a tmpfs overlay on /etc,
>>> special
>>> treatment to restore machine-id from persistent storage (cloud-
>>> config
>>> stage), masking of sytemd owns systemd-machine-id-commit service
>>> and
>>> custom script to persist generated machine-id later on in the boot
>>> process (also cloud-config). For the persistence they use bind
>>> mounts
>>> compared to links.
>>>
>>> 5. Some other systems run their rootfs in ram only and link
>>> persistent
>>> portions to persistent storage. (according to SO at least some
>>> versions
>>> of QNAP)
>>>
>>> [1]:
>>> https://github.com/systemd/systemd/issues/14131#issuecomment-689643106
>>>
>>>>>
>>>>> And how many services will now need lots of fine-tunings in
>>>>> order
>>>>> to set
>>>>> up all those links and folders?
>>>
>>> During our investigations we found following numbers of potential
>>> files
>>> at risk:
>>>
>>> downstream:
>>> - files on /etc (regular + links): 731
>>> - links needed for hardening wrt. /etc ro: 10
>>> - service modified for hardening wrt. /etc ro: 2
>>>
>>> isar-cip-core:
>>> - files on /etc (regular + links): 262
>>> - links needed wrt. /etc ro: 2
>>> - service modified wrt. /etc ro: 2
>>>
>>> services to be modified:
>>> - systemd-machine-id-commit
>>> - sshd-regen-keys.service
>>>
>>> In case of sshd a fine grained overlay further reduces the need to
>>> modify sshd-regen-keys.service and also the number of links.
>>>
>>>
>>> Thus, the added complexity basically reduces to special treatment
>>> of
>>> the machine-id and setting up links for the services we want to
>>> reconfigure. In case we find agreement, bringing a .bbclass to ease
>>> such setups further reduces complexity of such setup.
>>>
>>>
>>>>>
>>>>> This sounds like labeling a system for selinux: Can be done
>>>>> once,
>>>>> all
>>>>
>>>> ...labeling and creating the policies, of course.
>>>
>>> It's about hardening, and as you said selinux, apparmor and
>>> similar,
>>> don't come for free either. This proposal is also no replacement
>>> for
>>
>> If hardening goes against maintainability, you lose security-wise on
>> the
>> long run. That is an often ignored fact, sadly.
> 
> As said, imo, compared to selinux/apparmor it's not that bad at all!
> 
>>
>>> the former. It just brings an additional layer, which imo, can be
>>> understood quite easily. Maintenance burden is something we have to
>>> take care of by providing the right tools e.g. bbclass to support
>>> developers, and probably also export of reports documenting such
>>> setup
>>> at build time.
>>>
>>> Imo, the main burden is having the /etc/machine-id setup which is
>>> kind
>>> of unaligned with systemd upstream vision.
>>>
>>> Nevertheless, I understand the skepticism. Maybe I overlooked
>>> something. Unfortunately, I have no better plan yet :-)
>>>
>>
>> If the goal is to avoid persistency of sensitive configs across
>> reboot,
>> come up with a proposal that keeps /etc in tmpfs and persist
>> selectively
> 
> Even in that case special handling for machine-id is needed.
> 
> Having etc overlay backed by tmpfs could solve issues with projects
> where many packages require (ephemeral) rw to /etc. But should not be a
> strict requirement. In case like for isar-cip-core and my downstream
> project it is totally ok to have /etc ro, without major implications.
> (See nr of links to be applied above)
> 
> But I agree, having tmpfs overlay as an option (probably a default one
> in case of non read-only-etc setups) in kconfig is a nice addition, to
> round things up.
> 
> 
>> on normal reboot or when explicitly requested. That would provide a
>> way
>> better chance to not collide with every second package of today while
>> improving their support for r/o configurations one by one.
>>
>> Jan
>>
> 
> BR Alex
> 
> --
> Alexander Heinisch
> Siemens AG
> http://www.siemens.com/


