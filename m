Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB69C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 16:56:45 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.60])
 by mx.groups.io with SMTP id smtpd.web10.187.1702313797905205317
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 08:56:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=djUtZ/Ry;
 spf=pass (domain: siemens.com, ip: 40.107.6.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbfAEuoRG+jC1PFaJFl/FmZMEiGZZYTaSw/IwYqT+jv705W8jBN4c2vI/pVNE9cRfXEjgueHBjrzpIZKS70SkYpILy0uRZ/rijfwZzYfA5D2rzYsMBkLkZx0HB/ztR3RipB5NSsqE/zE8b6oJ+cto3BArTwgrM/TP1bH9IUjKyH7WCF48tPIreLBLfsBVW1HW3w+dFBxCq2EbHb4f6RkhOgJElLeVjfpqfY1lEAZU7OBDkcRx21pwY20j0oyoMUz5yXm2LfZPVtu70lNBQ8Z96U8dcSdHW2U67h95RrZqdeY3Os1h+kd4m45KJdSMtaoOiz8LSN07qHqjefyVYfvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaLLuO3RtWJxWTVmjYgLHlSRSbWuVnRmbzL2CvFuJc=;
 b=fPafhSAUDRxCUO0FXM54S8zdVJAIcsirdIJzSdtAcp0XdYqyU+Sue6MI82rXFP19XkGWk3EBMhHMulXfZbRvy4rvcBnxCAzBFZrqENGkbL6QzKYlKLOJgFgvbmDXO/p2RAg7hU/arJN85xsLZy0jI1qMDUkNOJWOg+SmYulMPXDtnYp0MUbvKmB0s6g5dAPUX4QVrq1+J9e7/eND2e5Z+0SXWQtcWTNloTXN1DgAT80x351IyCqdmO7nafg3qTUJ9a5+fDbEaBQiOXyIdHmq565miKiNDQK354J2vqjWtNpkC7zfKi7gQIbYqO1aYbFBcwhYHv5NceLAsbNM2USfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkaLLuO3RtWJxWTVmjYgLHlSRSbWuVnRmbzL2CvFuJc=;
 b=djUtZ/RyuWLVIOuC18PcxmUiQiR7f3lYJw2LJrlHhOMz/JUmjos9s3C1J/YJ08pBe1LKKkhH7IwDpgR0yXRqv6/OgYbUuQa9r6GXr+MhibYkQDk3V6hOcz8YyxXhAdkxC7lcWNOSK1rra5tL87LwrFiOA81WttcFv7+S62Wx2fsUU9qHysKaq/45HIhfkGv+V+MjDJTFotn4/jQfWFvUfM/yWrUPXTASfF4KfZrmz0KmMrvo1hdGtMnf85zHNyirDeZ2tNG6QW/cmY2kXgk7N0EJ3Nr1/cqz/nDirdqLjosE3zMhPwY/pNx6qLXq0y/kdnXgI0SqHQnFEmHmgNE4hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:56:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 16:56:34 +0000
Message-ID: <1eecab1f-5b66-43ca-b6b2-1045a05b6319@siemens.com>
Date: Mon, 11 Dec 2023 17:56:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-certificates: Fix shell
 error
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20231211165345.821930-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231211165345.821930-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: b90e0a69-377e-4228-901c-08dbfa6a220f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sV53WHVAECFTAewSQqIbE+ZDjbXP52aoBpIkQcDqElcBu6+lcpZY22G7eeoiYvHUpLhdfP9TuEhLcDVkRcBnksU04JMHpSlzyPfx3tw0iu6Hk6NWTR+u8QHAzZPJ7sWYbJ62uXSRJTpeLWDWupsXF3i4AtExDajeZPoZRzX+1OnuYl9DtajMjzr5FsozzSw5XWErFY/aa5IZn9UH1gJFu/F6YrJw0ee7Lvnn4Kr37U0RiBUlp8WZ89/K2SB9sstVv0Hf3wvenSO4rCVJlfA3mYgdVYa8NxtJP3ts7dcrC4JzetsEmVdo2Kf1hhgXyGMGjZPqOx7lTNKxwCaaomvNN0BNykbnCBw5AUZgOT5Dn+SDZhwl65XYN1xIXE/7caMruX+IuRZOzYwWdK4KdU0x2nsVhoStHYa5qYG0oF2C+ra54KW8PA7GOWIGRHNui8rUdVNRLpNrYM+tDJAlcwrWybf2nl7BCuDwNFFbQm5AOUgMte4qR0V5nLHAqRy24tHw2l2BkY6chRr7pJDFjMUjm2zXQs6LWwudSno3afWouK3EyvXQJ2yTQWlpRuJ86479wQwL30mQsNGRTzD9tn4QlTiQbygApTD/l4Bx/4MY6mX/c5FDTvqEqLmv7FstdHyhZUG6Jduz5V9FmC3sI0dl9w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(41300700001)(38100700002)(31696002)(36756003)(86362001)(82960400001)(2616005)(6512007)(26005)(478600001)(53546011)(6486002)(83380400001)(6506007)(5660300002)(44832011)(316002)(66556008)(66476007)(66946007)(8676002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzVaNkgyYXVaWnU0b3hiSU9QOGdkVWlyRGFsdVJONWRFeUVLZFRxcVQ4U0p1?=
 =?utf-8?B?Nk92QWw2V0p6U0ZNbjZ4dGhENUZnSzVSNUZoeDE4bzNVMXpDNURERUEzMFZm?=
 =?utf-8?B?MmMxa3A2djl2UUFoNzBmYWdRRWtja015alhYTVBMU2ZLYUJiYlNSSkhCbHRs?=
 =?utf-8?B?ZnJxK3BQTGhkc3A0VTJPSi9jdjNQQjNiNVVoemdtaGtaV0JBNTRlNUpVSytE?=
 =?utf-8?B?Z3BNYUx1Z0ZBZHBEdHRUVU1PM0s2aUxFbDBlUjBNejYwNUtGTFVEVEtMSWll?=
 =?utf-8?B?c1R1N2EvTjVrRHBSa2xTWmw2RXEyVmpjQzdsMzhhMnV1NnZPWm9JYnZCTDAr?=
 =?utf-8?B?MklqZkRDemJrVFNtVDN4dmRtSGI3cTYzMml3TVl4bkkzdXJ0ell2cEJLYnRv?=
 =?utf-8?B?MXI2aE9RMjdFQWp5cGlzUXVBdzFUY0ZCTGpkT01qMm5hbEEvWWVJb1Zob2x3?=
 =?utf-8?B?d21NTkwvaWp1Ryt2ZHFVaTdHRDJVWjNUWHNkNzE3VStQS3MrakZjUFlRZjla?=
 =?utf-8?B?SjRVYWpvWkowTFFic3B1bkh0bHJ6TzkrcUwrNXo3T2ltNmRCakxoVy9VQzM4?=
 =?utf-8?B?OHpWTjlzeG81ZjRJM2Nkc0VTZVh2SUdkOTV2T0FISlEzVVNJYndqSVR0TytY?=
 =?utf-8?B?ODc4bTNYWG1YdllXNkVUZkI2TW9PVjRMR0htSzYxUy90OU1iRjl1bDh5Tmpv?=
 =?utf-8?B?THpOaEIxZ0N5L3V6N0JtY1FPTVUxcUhFTFNuQVlKYWE2YUpaWTJwaXlNQ2Nm?=
 =?utf-8?B?citwdWtvamlBQ1pxdVdKcXAxNnVqejdlRHkvV0c2NmVFNklScm5YVEZlNHlV?=
 =?utf-8?B?R2I3M0k4ZWRBN2NlVW1hM3dvUHFVSVViMGVybUNKMXNGMnYyaUZSSHBxMVlH?=
 =?utf-8?B?WmdSY2pGZ2RoUVBkQnpoRjYzZUJkajhBNlRmM1hZSm5KdGxKS0IvUzgzMkl3?=
 =?utf-8?B?V0U3UmxBTzg2N0dpOVM1TnZZU0pGVURpZkdqOWwvZjd4am1PU1QyTURTTHR1?=
 =?utf-8?B?d2Z6eHlLK2RMTW16M1JQUE9IaDJydHdoVS85VU5VVEh5RFJRVmpmeU1UKzNC?=
 =?utf-8?B?bHAxZFJKaUZkd3A3d252SXpKQkVGbjlLVG8zT0JtSnJKYlhKMVZiaDJ6Ynlj?=
 =?utf-8?B?OHNvU3QyUXpRODY0eFYyekl6UGtQS3VtVlZKNHlOZUlKeW1YWk1FWVNveWhj?=
 =?utf-8?B?VnZidXpSOHVvWjZjRUF1Qm9ucHZWQ2t3bnlZZURHMlZaaW44bUZsaEFHVDFO?=
 =?utf-8?B?TFR0aE44dVJ6S2xOT1VvQU0wUHV0dGMrY2pHeE5HUTBldVpsQ0FyT0hwMVZU?=
 =?utf-8?B?VGNseUM2SS9VNUN0dkdBVWo2VXBIQ2VZQ1EvcjM4NmRKTHRHRnRvT0s1NGd1?=
 =?utf-8?B?dnVKNnltNTJjUlNxUDZIYis2amhMMFliNmRpTXl3TU9uQ1RBN29qQjlkdlhj?=
 =?utf-8?B?b3BkcWQ4dGFPWDQrc1RNbFVhQzZTbmpHSUlWQ1VWN210TjNDcldRYzJtODY1?=
 =?utf-8?B?VXZpdW9BYllORWViNmozdmtJWENhbERBQTJxWWYwVy9QbUlZWkdDZ2NPVXdF?=
 =?utf-8?B?d3Zsakg1aTAxWnJjeUtURUFjVnVJdnF3Mk5pTlh6S0JrWHBLR1U1ME9zWjRp?=
 =?utf-8?B?dk1OVENaRTF2dFBJaE9YaG8zMkhHekRZK0cvSTJKM0J0aGV4ODlYRHJKZVA0?=
 =?utf-8?B?WHlNdXRUSHZpMmFWY1NKKzZ1c25EamRURWpRVlgzdEREWXo0Rm1qYzl2dEJ5?=
 =?utf-8?B?RGZ4NDk2RjVSeE55S1VHWEs1S3gvblg0UWJOSXROUmtsZU80TVU1QmlXdnNT?=
 =?utf-8?B?U2dub3Y4bDRKZjNxM0p4L3E0T2YxY0VsUlBWRThLSlRsVXpLaGoycCtxazJ6?=
 =?utf-8?B?WXZmeU1XZkZpaWJ6emIyWno0OXUxYlQwdWJCUVZoSVNHSzhxMWt3cjFndEl1?=
 =?utf-8?B?UjY2MFBKK054UGNicHBIWWpRdll4c0dtZG1FcEoyMnhXeC9kZFVlKy9TUXFr?=
 =?utf-8?B?Y1Z2KzI4NWpRN2lqd1dtSldvZEk3N3E0b240YitkSE1EaVd3aTQrU2RBVnFS?=
 =?utf-8?B?V1ZTQURXZGVreDFiWHhwSXhYQWJMTmZ0NDdIL0tiVWRMa2ZJTThTU1BZd2ov?=
 =?utf-8?B?TlZUUm81dnVJS3pVUExCdVBQdXpnb3Z6SzMvU2MxZWk3MkhJRTQ4THV0dUVB?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90e0a69-377e-4228-901c-08dbfa6a220f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:56:34.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZTX0RBZs77tWQa/xcQEPc+4PwoFo9lWk0eaZ/D6Zw+brX9YVk6cOn8DyxW+hmd5jAkQ3fwJCD71E/tnwireog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7881
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 16:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14035

On 11.12.23 17:53, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> An Additional bracket was added to all if cases, which leads to build
> errors.
> 

Fixes: which commit?

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> @Jan This should be added as soon as possible to master
> 
>  .../swupdate-certificates/swupdate-certificates-key.inc       | 4 ++--
>  .../swupdate-certificates/swupdate-certificates.inc           | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 0b3e045..56d006a 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -21,11 +21,11 @@ SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SI
>  do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
>                           ${D}/usr/bin/"
>  do_install() {
> -    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ] ]; then
> +    if [ ! -f "${WORKDIR}/${SWU_SIGN_SCRIPT}" ]; then
>          bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
>      fi
>      install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
> -    if [ -z ${SWU_SIGN_KEY} ] ]; then
> +    if [ -z "${SWU_SIGN_KEY}" ]; then
>          bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>      fi
>      TARGET=${D}/usr/share/swupdate-signing/
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 0553c25..10b6833 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -18,7 +18,7 @@ SWU_SIGN_CERT ??= ""
>  SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
>  
>  do_install() {
> -    if [ -z ${SWU_SIGN_CERT} ] ]; then
> +    if [ -z "${SWU_SIGN_CERT}" ]; then
>          bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
>      fi
>      TARGET=${D}/usr/share/swupdate-signing/

-- 
Siemens AG, Technology
Linux Expert Center


