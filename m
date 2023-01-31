Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9FC38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 10:56:33 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web11.9478.1675162591067663745
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 02:56:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WEhzqaYv;
 spf=pass (domain: siemens.com, ip: 40.107.22.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcXBVHejpXRyTaZ8BbUYk0Yt64OgQmq6OUtwaJWz2jzGWzuCn5y9ky5qe5jb+VG4dkW3IvtZei194YP2Gm2coT0IJTYom//LhTsaQ6+Pmw+2Wczg9IXKhQOYzuhW8br7JjLg3loCIaGk/TEZWBaUWz8SAVNnkjC3HMo46poJtep6zBYAvqKyd6F+WUf5rIbbiaGBw8BUWmSdRenv6OfEZh04dVUZ48llRbP96VvNlljIGPi5kQIWPYy06RyvRGCmf+6/8iaIfU5rT3GlqVHThshvGap6gSO2+OTHvGg/qW3NnkWq1Xb0MVjKwmCqs11ODBgZC7EG6+D9HBC+c+prog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wB67/dZ2xBxY93CohXc9HNSeH3twA9BcYpu/EJpmOI=;
 b=Xg5eB+rq6d/ALKSu/5xGCiVAtwMtOzIyHZw3rhmdTpido3aDZ6STf2PbAen0+QWgVuAvN7omJ9YcQdVGn59l30zDaU8/3GXdcMlHkp6r9b061jCD9nlNuax/P7Eu2MMsxmbP17m5BEpxySX2KvAExyUf2B1h8K8At56OdCqiEFtK7/xgbj69H4xC55ZsFxaPrCbaCEVZkM9u9zvnohecD3qiNRr4th/ECVXRcEvm1WMfcQN5s1HwhmZL7Q7EbTzAzd43P+RxIjXNlD8elj6WgD80hk615l7Zk6WJgBzlgZnGKO3yEor/tP+XPmycSqSrGVz9qVayJ/6ecvd4PCd92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wB67/dZ2xBxY93CohXc9HNSeH3twA9BcYpu/EJpmOI=;
 b=WEhzqaYvQg4rAlh4cdq/NW1uwmpT67+0EqsO4pDDNyrDuJFa05wotm05b2axyXnTTanlZEw498GkEh/JC2RROv1cAlVAR0l4sSVctwoD1fV0XZtfDKTsLXKGLqM0idrCA4VyUlAAnkN1j04hzlCsjO0jv4ktw7rTTuHQyyow54vwkTHpjttjY6o7D5fVMujs0z/Pgui4UuA5Gs6900hd3Dv2fV/CHUFNPIceVgQWN++WQZ8ApFg6Tm7QWaPn1Y4/hg3sBjoNVGz9dlM728Pn3Wia7Vc5wLdHDmISIzJxa1pqjjNxl5ebMF9DGFVfi2XAdry6GDtOlJ72tvorfSOV2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 10:56:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 10:56:28 +0000
Message-ID: <019fa6c7-8dea-3140-a740-a2baea095a87@siemens.com>
Date: Tue, 31 Jan 2023 11:56:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][RFC 1/5] add tpm.cfg to the kernel
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
 <20230130150204.697758-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230130150204.697758-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:4e::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc8266f-51b9-4647-aa44-08db0379cdaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pJb6Yi77ZAxq/pmhOFiydCNLUFFpQUdX/EGCk/W9KF/LV2fElQg/vtqA4wJOOsq5avbOjwgDTRAo/iVZJcHcsboi/jvl08gs+goB9GVy2PPZy+aP5bwwWG9z6HVcXnlKYkf3TSEqRpYdZI9RSEjB4UPHIJKsvH6OQt0S3NZGs1bc1EojUkGIkpcV+SHHTMmxUvGim720l5NrZ+jfd0FEDJcbrgd4rHIPTrTg13SFdJpE5qrl0GHFEfnQWmauReirzU5XG0rLoBQN+Ysfv63O5XLHm5aj8l+O3HnvPiOSmp/DsOqofjxcEUJApJhzoiO2cKxAvNHkbMG9Qjlr+c2CTdxnYVwsXplJmRa95m1qD6mRaesPhmuC+gpJhJVoBt5OROF0fgIvLD5ximEWnN2pp7tt7jRBJ2RW/vcCIa0oo0ZIrOLGWSc2/1XmcckhPiPl3HPggWkXyE7XrLQxWQowyexRPd1A4AU0aMcuiSuERLYWXSbPI1mFyyBP00AduU2fVmy5GD9WvR6B0UERUROb4ugnmVgbQJ3ILSbTzKibMuapQFUuwTGatvPHqKxcf4pl/HiHYvWCvK/vn47CG0yhAge2rEZpmRcn5LCA8UYsMceqy6UqGatCxOHclSekVAGf6vfVNcTd1bZ3EhxDJho+Cyl6zDHUG2oAYTeuXFWj5z45HdxuxzrgoCBXr+rU4BZhkEGaCmFtj8yUOZMMOQaQ1StYwwR7F5b3sG0myYpYTMg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199018)(31686004)(6486002)(478600001)(36756003)(6512007)(26005)(2906002)(6506007)(44832011)(53546011)(38100700002)(6636002)(316002)(83380400001)(66476007)(66556008)(2616005)(66946007)(6666004)(186003)(8676002)(82960400001)(31696002)(41300700001)(86362001)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTFvSEozMlowRlI5V1hnbGdkdFM5YmNIK1lUWGZoSUtSOGk4OFdCUUIvOCtZ?=
 =?utf-8?B?dDg0T095Nm81cFJJdFRCY3doM1ZQeUkxaFFOd3B1YjM3M0ZoNnBZelZ0SVhT?=
 =?utf-8?B?Z0JFZlBRZVVhMWNKTG51Q2lUMmVxclB6TGRETEhrSEM3eFV4d3Y2WWNCTmFE?=
 =?utf-8?B?QUp0Q3lvYnQ3K0JoMFdmRG1JZGZHL1cvaXkxZTMxSXc2cUsyWUlWblpMNC9t?=
 =?utf-8?B?TTBLYi8yc1BxRFRQRkJtUzZUVzlqZ2hJd3ZQYWxLNmZZV0tTaUN4c2VVT0Ey?=
 =?utf-8?B?SUNPVmd2WEJGbEE5Q2JRekJENXNCYWtOemplWFJ3QTlzR1g3UVEwY3ZXVGxi?=
 =?utf-8?B?eEdORm9wVnEwR01YbjlqN2JnTUZ1ZHFQcjhySHJDVXBoKy9oNS9jSkRmYUg0?=
 =?utf-8?B?QjZwVGZTT20rZVIrYVdhNE52cHRaSEwvNXhBdkVnRm45TXlsZ0pLZnM3RDhm?=
 =?utf-8?B?eGNkRmNTOHdodjZaQTcvZGNtYWp5SWpLNUdtc2srWTd2OWZkVy9DMkdpWUZL?=
 =?utf-8?B?TFMwMlo4Q3hqb2s4UXR2ekJnS2l6WTd1UEV5MnhHM1REV1BvUmxBN295aXRx?=
 =?utf-8?B?NWp1cFdpdkRLeW1JWGEzOWdNMDl6T3I1ekdQNVh2TmZpSnBZTHJhRXlON3g4?=
 =?utf-8?B?a0E3WlpoNFVQYUszaE1ydU1TRjJkcGY4b0dzT09YWCt0ZGF1cHJKUFhZeVdm?=
 =?utf-8?B?T0xJY0hVbWlvUzZiRXliNTBRV3llQVRIUjJhSGE3T25waHZqaDByN3dvSVBj?=
 =?utf-8?B?VXNQUXFZbStTRllCZ3c0ZFlPc3BoZjl1d1BURDdmRHFWSE9yMU5vcEw3WFBW?=
 =?utf-8?B?Njk1SDVYc2pnaFkrSGhyd3U3NmJRaWpDbkxhRHE3M3haM3N3ZDlRcnY0ZVhY?=
 =?utf-8?B?ZHhvVE5oclF4WmhkRjZ6UjJVMjJ1OE95NVZpRUwxQkVwN3VaV2dWYTFCbVVr?=
 =?utf-8?B?UXJ6RFRBVEp0clVqTFkxdC8vckxUL0tGTWYwZzRHN0pmdVV4dThNd2JlUjVS?=
 =?utf-8?B?dUdLWXlaMmdTZWdPclZNQTR4N2hpWUhSUlNnRHBFR0o0dnl2OE02eUxndGpw?=
 =?utf-8?B?THJ0MlZld1pScDhXWUlRT3JaUTNFcGJEMjdOcEgwWXdTblN3cWhBK1lUaHdU?=
 =?utf-8?B?Q0xMM0FLbzYrTW1BZDB6YWVjZ1lBVGVMOUNhS3o0WXA5c2JrdHVJcng2bmN2?=
 =?utf-8?B?Ni84OFJqZUVTZnJhem1vNmk1L3NnYnVyUzFIR0NYUDVBK0Vrb0xMMHorb0Nu?=
 =?utf-8?B?d2dzeld0V08zNUhLSVRCa3daem15Tk85UUtLNUxKRWFGSm9RTUYzT21aT1lQ?=
 =?utf-8?B?elYzU3lZL3dFWitySWxmd1ViNjF2UDg4UzZST1U1VkVQWHlzY1Zlb0taTW1z?=
 =?utf-8?B?aU8xZFltcGxzQ240UDRyamM0MHRGWHd6cmNxVG8vb3BXVUhPTXFLMzRmQXhk?=
 =?utf-8?B?T1F2aVB6UUJiWXFxYWNoSnFNWDI4bGU2cy9uNjNFUkswNkQwL05aSklGekhI?=
 =?utf-8?B?T3NwWFlySlo1Z1Q3dFdxUnhZS2hCQlVvb2dzOGJpc3lFQ0dGWkZFOGphZVJD?=
 =?utf-8?B?eGpzM1Y3UmV4aEFkQ0h5d1REMGxsZlhEdXNvUWlUdWJOQTlyMjkzeWZOaGlS?=
 =?utf-8?B?bUJ2azVnUThjUUIvS08rTDJ0M0o0bmJkb1JvRlM4YVJ2SWZKZG1MWkptQ1BG?=
 =?utf-8?B?WVJWdHJaUTFhdE1nWlhmSlpLd2FuMHgxc3Bsb2xiMUxQb3h4dVR1elprYWRF?=
 =?utf-8?B?T212dXRhNnNkQ0xvaUZqNlJXMnhROXNYdFRYNkw3cUZVVEk4UHkvNlZ6LzJB?=
 =?utf-8?B?WDFQOGhvTHVuMWxna3FoYXpidkgwV28xd2xOb3l0KzlTcTdwbVp4YnR4WC8y?=
 =?utf-8?B?ZVVoUXBmR25Xd1U3aGdBVmxNd1lzU1hSaWd4azhzVzNJVmJ5VVlOOWMrMWZQ?=
 =?utf-8?B?S2RqWEtuL0EvK25GSGtHZFMwUE5PQk1uY2dmcklDVzZDdjN0U3BWaTcwMjJ6?=
 =?utf-8?B?SzJXRnE1VytJejJmbGxGZjNjSUVtdlZxTStHVFc3QzRaOGFaTmlUZytzRWN5?=
 =?utf-8?B?NXB1RVZGNGtBc1N2RE5rb1RkTlFzbU5HeWxzdkw3eTRyYi83NGJzcW1WeFFt?=
 =?utf-8?B?SHB1anNEU29JQ3I5SFVxdjExQXhpYUg5c3NwL0grZ1BPSFZNcjVSYnFGVmw3?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc8266f-51b9-4647-aa44-08db0379cdaf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 10:56:28.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHwVvOxn/SE2QL++xIf+r1/nX3cmQAvqrLdYYYRZp84S116B3Rey28MVsxiXupS8Zu+cs+HaKh6i2eLZqkqLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7711
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 10:56:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10521

On 30.01.23 16:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This can be drop after the linux-cip configuration was updated.

Already created a related MR? There earlier the better, and then we may
just drop this.

Jan

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/files/tpm.cfg        | 13 +++++++++++++
>  recipes-kernel/linux/linux-cip-common.inc |  2 ++
>  2 files changed, 15 insertions(+)
>  create mode 100644 recipes-kernel/linux/files/tpm.cfg
> 
> diff --git a/recipes-kernel/linux/files/tpm.cfg b/recipes-kernel/linux/files/tpm.cfg
> new file mode 100644
> index 0000000..22268ae
> --- /dev/null
> +++ b/recipes-kernel/linux/files/tpm.cfg
> @@ -0,0 +1,13 @@
> +CONFIG_AS_SHA256_NI=y
> +CONFIG_CRYPTO_HMAC=y
> +CONFIG_CRYPTO_SHA256_SSSE3=y
> +CONFIG_CRYPTO_SHA256=y
> +CONFIG_CRYPTO_DRBG_HMAC=y
> +CONFIG_CRYPTO_LIB_SHA256=y
> +CONFIG_CRYPTO_XTS=y
> +CONFIG_SECURITYFS=y
> +CONFIG_TCG_TPM=m
> +CONFIG_TCG_TIS_CORE=m
> +CONFIG_TCG_TIS=m
> +CONFIG_TCG_TIS_SPI=m
> +CONFIG_TCG_CRB=m
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 9b6cd3b..e4292a6 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -23,6 +23,8 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>      if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
>      }"
>  
> +SRC_URI += "file://tpm.cfg"
> +
>  SRCREV_cip-kernel-config ?= "ce52837418aea714e780e0cbc8afb9515c12cc1b"
>  
>  S = "${WORKDIR}/linux-cip-${PV}"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


