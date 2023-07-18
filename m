Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B16EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 19:35:45 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.77])
 by mx.groups.io with SMTP id smtpd.web11.5026.1689708942971114376
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 12:35:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wQIpanNF;
 spf=pass (domain: siemens.com, ip: 40.107.15.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkAlkAF0pnTtDcauI3FltV9VP8Dz4k2PsLr5txuNzoQQijRsw1E9B7+g7yx8I8wl8N2XCsR1o7GMjlB+hZn5awMxP3B+Foaw5f+mrQWwieDfZJYkhUgnzyDA/9RHj3KQn+nuWdDi0259qDjMFXPSJ0tOiEVbD42PrD7V9Gg2zbVlpA1832fAbH7X5yoSMCd4FreuVaKKxeHO61szSPQnTCReb4pwaZvIwHoghhSDaiQAVbUOa7RNelnob6GEyVULFrelFDH9DrsnnNXa/pr2jtJC3lYu1LKILl31VXUKb+W0qyUkYXM0PVCWkH4qGqKAHbHxL/x7Tj/uHPoOc+0FXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee7/T9RTMbGKI4wHliM2ZcjOTTfPa7DOC70k6seNlcA=;
 b=AVXu8TPjiY6varbVVKLiI7ir1plw6vld0jiHoEb8oF0yef+/vL3Vt7CU8k71G7Ea3GcE1VA2XXC5Alji+1ymrPCdBERMUkR1AvchylGFAHa4+l1qrRstC8YIOFsITJlMzs3M4HE6htmp98Wi0JLlGjMm0kjibV/maE8xvoYsmaK+Y+6TTUJMTEiTsfrZyQvrKKdVpAtkM6RiYnJZiWz6DBu3clMWFKhqJeUOO54EE1313cPwNZA0MLQGEmqGx/o2x8bkk7EjdVXprhk6NHOJSAE62ohlIt7aJ0LRGd0tFXpg+EHDIh2BRvFwKaiksn1+slYh5XLkPJP7Rb4Sj1gnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee7/T9RTMbGKI4wHliM2ZcjOTTfPa7DOC70k6seNlcA=;
 b=wQIpanNFsglcCdvp6vsuTNkaD7TZ2EjJI/nIwWBWyDhwbmIdfREH0YkogAgpQLUvK3SD/+BauSS2qxvfVYEev+5wnBIbOhyYfeIO73o5t0aFhp6YxIrdClxmsUKOjuOg7/O6+F72QA0BTN7yveMqLEJswBb4J7778xOuZFfAWEXnJBuqt070VT3Gar4TQmXSFDkNkFy4GELDbp7jlM8x6NuktPaP2LRbH83jrSrT/xjmcycm/bxnnaJg00M+pKeswggSSs77XcfB8fmCpF0FLm4647B1BsLnD9Eblb/Y91tTMFTYhUFWssGuUJPLYUX2LtO6LuTDMdmBe9zZuv+5KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 19:35:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:35:39 +0000
Message-ID: <78ca8885-1dd8-4b26-8705-9ba7903ef70a@siemens.com>
Date: Tue, 18 Jul 2023 21:35:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/3] Enable signed Software
 Update Binaries
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3684:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a3f28d-5cec-472f-4115-08db87c62a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+mcwUO0qi1Lxq3X0lXiJyok1BoHMPAM8VJ1jdWVVmD9GFfJYusT3R5n/vofDDSMHx8FT6ZohNQfWHl/i0Vf4jlPc8W2TiVmGqDLH3LEJmpgAk2QohH/MhKPXqcF9Yyu7QdPnA0Sdigh9zkUoQKLGEi2R3zPithwa8apIxt9udF/+sH6bMTE7YWzFgbcK6JXW46DlqN0eWqJdGYC65SX46gSLecDmpAfta98R7qaTgS6CJ+naG9ZoVKb2/AieR2V0m718QvAVriVYu4dzq2hb14rBsYqMSrTBk50cH6bEB7ewcOD/e1/Ep2XyB6MBV51bdaJ0+VaNZ3mUKNCPA3eWpIROw2v3L6jUdmmS0AwO84q+QcA9fu//WBA6i31FVtHK6Q8GCqsrFWv2Fa/1Rfk0eHg9Tv2e32eiOvmZElvV5CpdcEaDVL521fFOK1XJKTjz2/qfbQwffrni5TkHcy00d03i2vMXPZOFFk9UB32/5EJM4lPWCHXk1r+dGMPiAcTp7nYXhegWVFXjH5fg8K8DErwCrkYluV7twCQz+AMx8gYFSo2r6RhylvSHXjlvNYKtCSceOCICajrZ+Wy/FRa28gOhq8a1Dm0dvZ208lRtFskJLElE2kEFk8pZ1exN4ctfoYFnPFU3hNngB9bGjghIMA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(36756003)(82960400001)(31696002)(38100700002)(6666004)(2906002)(478600001)(6486002)(15650500001)(41300700001)(53546011)(6506007)(6512007)(26005)(66946007)(8936002)(316002)(66476007)(86362001)(44832011)(31686004)(5660300002)(66556008)(8676002)(2616005)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUxXQnFFZlJWcVlNT1VLb2lrdUd4Y0UxQWEvKzJpVUdESE1zWWRXak1EMHQw?=
 =?utf-8?B?eGgrelE0UjZxM0F5d1RBazJBRTVXelR1cHBuS0MrOFFBUzZGQ0syOVdIZ3pw?=
 =?utf-8?B?ZGo5cEtFcEJEQzZwSndSTEtEVWRNdUUyK1I5dWMvRVo5T3d1eldZZzk5cTVX?=
 =?utf-8?B?Y1hCZ0ZZMjlIT3VMMVJsL21FK1g5amFvWWN3WGtycGdNZHZUOWl2MHRZUlBQ?=
 =?utf-8?B?eTNlMitqbnFmdGRxTk8xNytuenBocFM3ZVVHTEhNNFl2bTI2cGRJRTMvT3Rk?=
 =?utf-8?B?NFFsOXdHYXdRaTVWUjEyanFuUlN5RzlBVmROaFFmUTFTQVpUZFo3azgreUxi?=
 =?utf-8?B?M1VUUlE3MlFDblJJWlY0RC85Vmw2VnZHMGhneHNzMWNZVkxpdTcyUnhENFF1?=
 =?utf-8?B?d21SZ0s1ckc0LzVNblRNcExqZk9zOVNkcjBtUTF5N1B2UlFEWlViOEl6bTdZ?=
 =?utf-8?B?TVJtSXR0b002MXhvNGlFVlQwMW90RzJnNWZDTjdTWlpoODNQZlFDVS8xOGc3?=
 =?utf-8?B?MDdzeXY4UVZHUjVQcXBzOWV2RnluMldNUlhSR1dQSFlUVmlwZzZjZ0xtemla?=
 =?utf-8?B?SVVPUXlZWWhBQ1U2emxrck1jdERSQjJ2VGREVUxGUk5WaEJzOVljWWtwNXV4?=
 =?utf-8?B?b3ViRTdnNUhBM05LUU0xU0gwSDBWTzZIUSsyTFRvWk1WNDVTQmltR3puUXR4?=
 =?utf-8?B?R0VQYUZKZjBibWhOYnBNMDZhL2luNHZXRU01SkkzcWNhRFZnamhaNythbi9L?=
 =?utf-8?B?anM4MUJZYWRlaWZweWdLcDdDQ0xyZXJDRTAvOUlpTHlodDRDQ3l6bXhKVk1s?=
 =?utf-8?B?OWEwS2tGd1F5am9QRy85eFFKK2VlUi9qYmtEMDdqOTB0ZzExbFVDV3BCL1BM?=
 =?utf-8?B?ZHZHRVA4UHEzVkJTeWZkYStyL05BaDZFYWs1SjBvZlpydGhwNXpvNmJlVVdj?=
 =?utf-8?B?eHZQRmxzdlhoOTZ0cXFYclFxOXNvcnFvR2VoeGVLVFByUVhBNEZwSHlPS3VE?=
 =?utf-8?B?SWZVS3lLdkxJTG5VczlhN1gwdEsxSkticHFKTXUxdi9PRFpZZTBmMDh0dlBD?=
 =?utf-8?B?ZnpGMTZTN2dhY01KcGlKNWZUeGJzWUN2MDZoR2FJVFZJWFFaUTJobmNNTTRQ?=
 =?utf-8?B?ZThKZUtyS2p3ZjVtd3V4c1k1cW5laE1aL2NMVDBXdWV1N1RSQWdZRGpKRkhv?=
 =?utf-8?B?NkMwVm51UVBWU3ZHTGEvNkZxZ1BUbVlpSVF0VjRJYVRicEVPV0QwNUJOYk9H?=
 =?utf-8?B?LzRYbForeGVraVRWcE9La29DZm5TMDl6bld5TGVHeE5BakFRUW41K3lOZzU2?=
 =?utf-8?B?aXA5Y25Ub09rV3htcnp4a2ppRnJ4bkdwbHNpdE5RRXdDSXBiSG04R0hSS29E?=
 =?utf-8?B?VlVIdGRpNzVPNGpnS2pkOUU2RU5EMjRXazZTa3RVY0VYYVhvemJHKzI2akRW?=
 =?utf-8?B?WndscDRVYklEZFgxOEtwblh1MW1jaU9xNkltRUx2elRDK2MwdnFXOHJ2eDR6?=
 =?utf-8?B?S1YyeVFUTEpwOTBpdC9kQjlEblBpbUY2OE9KS3BaMkJqUjh0ZVVnTXhEK0RF?=
 =?utf-8?B?bEdaS0RkemtQQ3AvclpuOEZvS09tempKRklNS1lCWFdORXdMcktWak96SmJG?=
 =?utf-8?B?Rkh3bThSYkl1NVZIZFZlRkliQW5tZnN4Z3lCVVBqUTBPMWdyVmdmblpzcmh0?=
 =?utf-8?B?elBPNDNKQ0xRMkt6blAvSE8xQ3haVDFVQ2ZMV1ZJTDdobTJqbE9WbjVZUkN6?=
 =?utf-8?B?dHVNakF3dXN5bFpORmdFaXB2Q2NWdG02R2JHU0RBeHBWUjhySTNObG1Lc2xy?=
 =?utf-8?B?NG1DeEkxdDNLTEsvU0czZlo0TnphOU1pT0p5cDhnc2Fmb3RZc0ZzT3h3K0JR?=
 =?utf-8?B?bUdNaHhqdGRra3E0clgvOTk5Mk8xZkt5Nk02bXhINmcxOC8vZ21EQ1dqZjJz?=
 =?utf-8?B?dVE1ektKeWFPM0JONWp5UWVLMVR4TFc2QXFockhibWptck1Bc1pMdExiaTJw?=
 =?utf-8?B?N0pJUjZ1RWRpOXdVT2VJdFZoMnBrT3NqWEZuUzBJdi9mdFlTNkw5T0RXSjh0?=
 =?utf-8?B?Ujcxa0tNS3F3TGlBQk5yc3NaTFJZYnBFWDNDRloxZ1NjU21wUTVwVk1IUVFI?=
 =?utf-8?B?K0RsalltMURYUDhZaHYrQmpZSXdqbHhmclNZWWovRnZVWlgwZ2ZlejZGa2Jw?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a3f28d-5cec-472f-4115-08db87c62a70
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:35:38.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0FWrjrGi8VFsnAjjozZ0vCELMM+GQKzyFyygS0IvW/eZoxq/0L0zxewXkRTktC2xMh7dHnx55sPr+xIgz14tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3684
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 19:35:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12416

On 17.07.23 12:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> With this patch series SWUpdate applies only signed update binaries.
> Also the signing will switch from RSA PKCS#1.5 or RSA PSS signing to
> a certificate based signing.
> 
> Changes v2:
>  - use Debian snakeoil keys and certificates
>    from secure-boot-secrets for signing
>  - fix typos in commit messages
>  - fix author name in recipe-devtools/swupdate-certificates/*
>  - enabled signing in swupdate.bbclass instead of image recipe
>  - moved dependency to swupdate-certificates to swupdate.bbclass
> 
> 
> Quirin Gylstorff (3):
>   recipe-devtools: Add recipe to sign SWUpdate update binaries
>   swupdate.bbclass: Use new swupdate-certificate
>   swupdate: Enable signed updates
> 
>  classes/swupdate.bbclass                      | 21 ++++++-------
>  kas/opt/swupdate.yml                          |  2 ++
>  .../customizations/files/swupdate.cfg         |  1 +
>  recipes-core/images/swupdate.inc              |  4 ++-
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  9 ++++--
>  recipes-core/swupdate/swupdate_2023.05.bb     |  8 +++--
>  .../secure-boot-secrets/files/buster/bookworm |  1 +
>  .../secure-boot-secrets/files/buster/bullseye |  1 +
>  .../swupdate-certificates/files/bookworm      |  1 +
>  .../swupdate-certificates/files/bullseye      |  1 +
>  .../swupdate-certificates/files/buster        |  1 +
>  .../swupdate-certificates-key-snakeoil_0.1.bb | 18 +++++++++++
>  .../swupdate-certificates-key.inc             | 31 +++++++++++++++++++
>  .../swupdate-certificates-key_0.1.bb          | 17 ++++++++++
>  .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++++++
>  .../swupdate-certificates.inc                 | 31 +++++++++++++++++++
>  .../swupdate-certificates_0.1.bb              | 14 +++++++++
>  17 files changed, 160 insertions(+), 17 deletions(-)
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye
>  create mode 120000 recipes-devtools/swupdate-certificates/files/bookworm
>  create mode 120000 recipes-devtools/swupdate-certificates/files/bullseye
>  create mode 120000 recipes-devtools/swupdate-certificates/files/buster
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> 

Looks good, but I will have to dig deeper into this, trying it out maybe
also with a downstream user after the upcoming 1.1 release.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


