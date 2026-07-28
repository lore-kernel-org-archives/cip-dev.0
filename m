Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A06C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 07:53:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6694.1785225176019717804
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 00:52:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R+NodIFE;
 spf=pass (domain: siemens.com, ip: 52.101.70.7, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq7B59/AUip8Wn1xEGAyUrgVAH9zNOhtMw3Eh5+XOrusoSx3TKOKeBZcr06cYfTKBpraVRE9bLXjQebsawLoCBep6PC+jhvB7T4tUdYIhBN5J4/Ra85tX65AcIj0oT1PiY02W6VNzElHSYk89ZnEXYHQ19EJv75Ju9Z+4De9gHReGDuPmq74jdpSoMdUOYe1vvXD6ZutOVsse+hMT5y0dkotsKE0dvujIYAJbiaxdul1lN3sNwuHr76fl9l2ipjF0Vuhl/NijEEebW+pykcAFt2KV9Rte4EnP0Ijb7m9iwpqDYDTjy1vjrZlxJxCjevzlG1p5IJDZjNLCW1zK38nCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYTNgFgw4a0tKK2bWHeeZrXhBEuHehnp3cJJRXIpvhg=;
 b=wVvmF7ZuPhlbnLZtu3LAKWpk9y41XSYw75CRMVYUcypr+xhFY4s39zZJ654MtcphN0/f2FRGCjz9iiCk0nw3dQOoOX+q7pluhPD5JdwXwncImSB4krc2Ii9SIXbw37rC9fMeMKEzg2V5WCKhCkViZgGAw7G4bgY2YDT0bz5CDSExj4kAO9YKceNASzJZk1j8U6WlniAWnwcfXnd2isrF21DzFFEFzKEwHaeISNXkSpcDEOxmkClmkoCUQf/CD5uIBB9ZmpUD8EXIw1AHL0Vi3IVMEXGrSq9u+w3rpGVIzC5KiioAuxXToQMX1bY5LKJjKZ0DXExRBraN6ZyhB1rY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYTNgFgw4a0tKK2bWHeeZrXhBEuHehnp3cJJRXIpvhg=;
 b=R+NodIFEpQwh1DubOLSq9uZ7zG6TSF945xYFErKu2ALjon2tbYjUHUYAw+a5lY/4Lb6ryAqpOzpsYcU5SVZrk7LRP4idS115yyPgCT2v2FH3BddXo6OQ5ECd9MJFg0khm2Kxq+F21LoMOHm/MgOU2OdS9Xz/y5H/Nq0mtJEtJp8uocUzzveFrN50F5wjCTqMEAB1WczF34hK51WZBYj04cqCXW30hQdq4xA1479W40wLOgNHk50mT2fBv/TrVR7MOrJs3YLC1GGKbw4nfu+YK3U1GvZfZ+pd1edlCPHvOVY0mM90V1RM9R4ochN7dD+XpIt9oXET6Can0kclIRnuww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4031.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 07:52:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 07:52:50 +0000
Message-ID: <f9f043c2-ad2d-4f94-bf2c-209402fb2a67@siemens.com>
Date: Tue, 28 Jul 2026 09:52:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] immutable-home: skip postprocess function
 when symlink is already created
To: Gokhan Cetin <gokhan.cetin@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20260727123100.828634-1-gokhan.cetin@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260727123100.828634-1-gokhan.cetin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4031:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a8bc0d-a74e-46c9-5b24-08deec7d391a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|11063799006|56012099006|10067099003|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	fBjd/VLRbUAwDk/emjzXYifFEmr0nkJwuw6jxS5l4qg396BR31kpkTOvk66ktAmXIZ3f4B6ACsQL5CXi8anfKd4LpA546UEDqxncvzoVdWnKBNBdZBuKtGV2r7ryu3hA7QWThGon+EIH4GXHPbyrIxahCmdjdz1dpHsdDhoWtGnBeqTfUjDxTP4OtAktQGniZRBptxz341+pGv5l9D3wtusuSlaCosQKZaYuf4mcQ4/UJWHmleCBIuu0GumsavM5Mz96BPrdFz7nZE2DBNcAIYJBQ+dMphFVugYFSJkZvtPGaD1jHGZczyIWH+FC0W4GpfqC/d+A93gAcNnS3+gHQn5giRWnp1cFJ9YcxFG5W+xOB3gK0+TML0qORdQ9cVizXoJi3Xz6eJb0XbzFSeXIJE5+J9DdKokDfqQcOsD2mxMcPpYVmG1vOPytHcsOQ03RNrnrisuvaBX5HExmSmkQkULHTeKTELKfOmiAQVOS/Dfi4xrBRvJnxDCV3AKNjuWOkwclAPCmolKUHB5Vg2Mnwa9YX4Sz5J1SnbzeoSYVlwZFjNi1fHc29yPJkZttUdh1H1vlKLAXooHc2xee+TmnJa+IRL8zA1M46rJPc1bjaG09zVk/TBwVUCSs0VvtLp8Ef9Co8gRrZdbu5ItLklPEqmQ6eUQZcq9+m4PDtEjDr2s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVpENzhKKzlHMVpKbmxQR0RFTnRQdVpzL3FzT09yZW1qYUhuSUFPOW1hQzIz?=
 =?utf-8?B?ZVNaU21TemZSQkhGb2JtY2FPQmN4MWFwb1NFaVNvZmxpSVRSc1hZR2J4RVdV?=
 =?utf-8?B?N0NYdWZ1UUw0UlczaWZyVkZaR1RONGdYVkVvaTNmdmZiTzR5NUpHTTh2T0lC?=
 =?utf-8?B?ejROSHVpS2k4dHh1SW1RSmh6alhqRkxaRnNBaFBuaGl5cThhSWIvMEQ3VHNm?=
 =?utf-8?B?L0JOa0FETU8vV2d6czdaaDhiQkpObllSOTg2aSt5L2IySGZycGo4VDhOYWhj?=
 =?utf-8?B?eWM0d2QxdkRFdmZjS2RFNHAxVXNScnFnWDlsd2FxcmxxODJIMEU3WTNHY0lj?=
 =?utf-8?B?eWYyVXREeW9PSzBtYldqYmJxOTRxbm13dVVGNkd1ZFMzSm5Ya1pGOE9zdTQy?=
 =?utf-8?B?YWxzcndQSW1iaG1YZ3h2RjBDL3hYNVpidFdORSsxVmFORGFCQ1VHQW4rS3Fr?=
 =?utf-8?B?MnpkejMvOERCTXhFSU9kdWFGUmNiRGRPSWxraHE0T0hzREhDb21oVWI5MFVU?=
 =?utf-8?B?R0tSa20vbWtpbmhteU9EZzBYWDV0N2NtYzdjQ0dZbDlZTm80SmRRMStJQVYr?=
 =?utf-8?B?TEloYWFLZXBlMlBMdlAzR0d4STlRdDlHaURteGI3K0RXd3NFb1JGZG5zNWlo?=
 =?utf-8?B?ZktXeHdrSUN0ZWU2bjdKUVIzcWw5K25RcVJXaGRicFkvUkxwa0tOK2Q1bWNl?=
 =?utf-8?B?N29jQlFVR0tFTTdTdktRYVRXcVYzZ3VKak9jTm1aN0tZc3lhNFh4Z1NuNHBo?=
 =?utf-8?B?L3p0UjZ1LzNlQjFyYm1HWUhLWGU2MklMZyszNG9TV0J5UEpaVk8yUlBqUXY3?=
 =?utf-8?B?dWZlRFlxTzMwYmZJTzFuUWplS3ZOZ1JRZ0djM2dkY3QxYS9NeklEVDk4c0Zn?=
 =?utf-8?B?Nk1FTE4xZ0xHZTdTbEpORkh2dFRXR3o4YTl6TW03anlzSlJYbkJmS0NYSzh5?=
 =?utf-8?B?bDl4d3J3LzErYWVRSnA4US9VU0xaS1IzTy9ybGFQWERtZUswOUpVdXRVNjhO?=
 =?utf-8?B?WVhtQlJScDg5UW5YQkV4TFVUdnZnU2NNWmF6VVJFd2FCS1RzT3lvRjdvZmZw?=
 =?utf-8?B?TnNaeHFYdi9XZGlPYjViMC83SVYwbkJTS0R6M0lzblQ2T1lXQUlMU1RoU2dr?=
 =?utf-8?B?Y09JY3JjNVdpWVNka0NXQk1BYW9DcGRxQkM1WERxMEtvekFYUWRJTEE2RjU3?=
 =?utf-8?B?Mlg4NlNKWkVwTktWMStBNEk3bzFZUFUvVm9OajkremQ4YTR3WTdsTHlQQVN1?=
 =?utf-8?B?MUo0UWhnSnZDZnhLRElOR05yMnp4TkpiSjcxS096WjNhdENtTlNFWXBuelZk?=
 =?utf-8?B?VCtjenN6K2dqZXluN2FMdlNiWHFGNEF5c09TN0hzUFVuRzNkaldqWXBKZy8z?=
 =?utf-8?B?VUs3akNwVmM3SDhGaVB0emxuQzVNMll4Mm5LZGFPVldaNmQxWVZTc2dqTjMv?=
 =?utf-8?B?NVZBUy9aYlpJd05ZLzc5OUFydTFuNUtXeFRiZ2pkTWo1dHhLRmN0c1p0YWdT?=
 =?utf-8?B?ODVwNk92WkNmTCt0dVBHTFYyKytFSHN0dUhWZC92NXFQWmhBYVh0dG9jSkg3?=
 =?utf-8?B?NkREU0pkRnpwbk5QQkhIWVpnaFVxMDM5c0lVVm1GZHpIZ3VMbStSRFZvOEEw?=
 =?utf-8?B?REJJVVlBTTRRQndvRndzK3JvaWRic2VvSFdISFVnQVBLOHJtS3pjU00vTzJH?=
 =?utf-8?B?V1loN2M1bTVycTNYRkQyaGNBZVZmNUt1b1FKWlBtTGZyVVNrSVJKQ1VEaHFi?=
 =?utf-8?B?ZTF2aFFxdElGd2VRaW5pU1FIVW83R3lRMWZVNFBXbW5HTnNBZ2dBZjdBalRI?=
 =?utf-8?B?cVBMR2hiWDFNaVVNdEYySjNsNjZiMWNwWm9GTXhib093Z2ZTdXYzQXZZd29I?=
 =?utf-8?B?YXJzWUU3VWx5THAvV2JtdGVsbCtUWSsxMlN1dDFXbDA0MStZYXJtTFFDWTd6?=
 =?utf-8?B?OUZub21Oc1ZNOFV4SnJpTTlSTWVrYndJZXBLdmZKcldHZWVIVG01V2lBcmJr?=
 =?utf-8?B?cUtONlhMRy9SN0FIczVHNFkvY1p3dHNBMC9kYjA2SzMxanpaQy8rV29FdTlU?=
 =?utf-8?B?NkhQL0RPMGwvQzE3ZE5qeXVBaFhmdTk5RnFCQjEvOFRaSjkrKzQzY2NuUFFh?=
 =?utf-8?B?aW15TDFqTVdJVTZoSTQ2V1JrSUFOQjUvNzRYMGU3R1piSFdkUUQxOVo5YzVY?=
 =?utf-8?B?WVlBeFZWOHl4Z295bU1xT2tDYm5TQ2o2NnhtQThSUGVCRkh4ZWpEREwxeGRp?=
 =?utf-8?B?UEYvcnNyT2FNSmVCengxbHQzd3FIQkZwNWZJU2s5OVdLWjZzdUVHVTFDb0xS?=
 =?utf-8?B?cFJTQy9ZNzBHaTkwUjVtWHBzUlVRb1VmN2hlTDFiR1hCSWQ1ZXYyQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a8bc0d-a74e-46c9-5b24-08deec7d391a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 07:52:50.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbOdRODEPUYSWAeSMng8advkAjifG5U1ayjoH/cdWEIKsYXb4IEH89XQlysfBnYUcayGnCn/pmnKpBZEDlSkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4031
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 07:53:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23792

On 27.07.26 14:31, Gokhan Cetin wrote:
> This solves "logging in with home" issues when rootfs_install is skipped
> during rebuilds, because of a change on task or POSTPROCESS function,
> since IMAGE_ROOTFS has already contains immutable home directory and
> symlink to var/home, and running this task again just cleans immutable home
> in this case.
> 
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---
>  classes-recipe/read-only-rootfs.bbclass | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
> index a67bb5f..1c57f33 100644
> --- a/classes-recipe/read-only-rootfs.bbclass
> +++ b/classes-recipe/read-only-rootfs.bbclass
> @@ -52,6 +52,14 @@ ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
>  ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
>  copy_home_to_immutable_data() {
>      IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}"
> +    if [ -L ${ROOTFSDIR}/home ]; then
> +        bbwarn "Skipping moving /home to immutable home directory," \
> +               "because it is already a symbolic link."
> +        bbwarn "You might have a custom task or writing POSTPROCESS function."
> +        bbwarn "If there is a change that requires the rootfs to be reinstalled," \
> +               "consider performing a clean build again."
> +        exit 0
> +    fi
>      sudo -s <<EOSUDO
>          set -e
>          mkdir -p "$IMMUTABLE_HOME_DIR"

Looks rather like a workaround, and also a noisy one (bbwarn).

Wasn't there the plan to start image post-processing from a clean image,
rather than rerunning against an already processed state?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

