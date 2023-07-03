Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C929EB64DC
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 10:55:41 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.59])
 by mx.groups.io with SMTP id smtpd.web10.29865.1688381739028802230
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 03:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YIuW3r6Y;
 spf=pass (domain: siemens.com, ip: 40.107.15.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiamaLLDAFhqwUzC4HZ+7MM+/jxn4LF/saxq7tIw1tgM9aWOBpbm53D+h7/HzBPotdjJog6I8FOjXgv/dAzPr+UVOHCiQJPYe2vB53suQlKxvl7qBtXLr3/t3V24Vhg1N6dKFKtsVSpytT6i3ayMwzNsg6fBEkJnnE+3ZV+vITbzvLjJ9rXKSsq4atRNyPVsnn/dLIWc5mgTeYqq8vghpKU2HFec3j+efNIJT0ALF1k84UaE3jzn1NoPZLlkHyqa2dmuFQBjFzp72xqaz4M5WLL2rdjaOrykqThLYzk9xD3A/cS1gCFPLX+IqnlM1bPaAQvn2exiUtMqXuYC9A27Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IekVwjGgRA2Em85zw+NzgX5qHPTkNWYFvJRWGyQh8H8=;
 b=UX7KvKOR5l+sELaJoYEXhI+GTLUQZLk4k8rlOmtWOaFYmUEdBs8vbzjNwKA1NhU0ytlrX0Z8auLlitvuc29jeT7h/y16/ClwmcWFs73KM9SogBSVNONLOO5zZ1sUrbpdj6Tjs66v9SHvYcSjfqyJK2HpGKft5c1R7e+fzefOVT18X/Wr4Bd/iCiHgqL2m4RcsG3fvuvu8rs1JMmj0jCkswJZYV2ruKh3DZNOQNAbkJTF6q8oPNDgHPpH2OnF63yGM7LLHD0GL1lvG6Xoo63LvZ9kx8xEQ8HdG9scSa9+41uCYJVDspqaAvwIpW/s/eDFkMc2GSFeTjuMH9keGSxvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IekVwjGgRA2Em85zw+NzgX5qHPTkNWYFvJRWGyQh8H8=;
 b=YIuW3r6YX2ev8sKEPtnPFK165vIwrNRh9tgJB8S5rOy5hjaHpEzBBvjlxVqDx84deGnq7Oq0ygoe7QmghPxo//ZigOIodR3b7Gie9tdfwkEDLfDw/kXDTioCCS/IqCQzbCTfXiljCNZsnmX3NbWPrG7ywq8QcOn2ckJ88And8BUVDwS1a6SWYrTfOujguwcZ2JAvsEPb3SumGrJAPtPPZbyAbjpkiaVuqXyxJBEL0KnSqQ9Qk292cA0CldmiIWmxV5LiHAB6i6RLQ0CzTq2MDJ9dwpszWigBM6esErgrIgwsKOt644XDHItGowhg4mQXIuLghsbcb5cohHlRp4CE9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 10:55:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 10:55:36 +0000
Message-ID: <83abf77f-5c2a-1e10-25ba-e63cb205bdef@siemens.com>
Date: Mon, 3 Jul 2023 12:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core v2 6/6] swupdate.bbclass: Fix file timestamps are
 not reproducible in swu file
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <176C1D7D866704FB.6977@lists.cip-project.org>
 <20230703062231.18183-7-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230703062231.18183-7-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:610:51::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3835:EE_
X-MS-Office365-Filtering-Correlation-Id: 235a79be-c6da-4544-296f-08db7bb4080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XQR3Yg4dlrsl0IKMGSGqhYQ3aj9P/oF42s02yvllR4yN5LfyzmYalQA4f+RjSPplAk7DOZxe/CzpDknYw+ygQbglBdnK71hL0yftCJCM1OkW0RMqhEJGnCYCTktNvyKkbrPR2lMnwvgnTmGBiBpZfmnSn2AbsCkN+TNkvnX3eyHetFYUPtWSDzmvFjcx88UsiHssH1YKZ5xfMSSUEudXbWUvkZQW54t3Iqtx0BFNPxb8OBV8OlodZvPwfOv2qLBlQwO+IupE0iD28oUwaZEQxHqKRwkKPkAGccebgb68+WCr07WDxG4IittabCRGT5rNH4bTjBv1TyeDsIVyhtOvEX0rbaCmuv95lRMJ6wAM+X1HsjmBJeM2oJ8hrspNRXWwjTj0M4h39cceeP1P+MeoW0TgOeiPuk3ut71d0bqZXYC8qDXVWrVKfpCRtw3uF4uB5DAkxEOiML0jdkXl7HfcKAWzPYdtLOxEIZzoI89q1H8fqXO1W8mPdlMto2oSH69x4tHcp/GIivoBz9DiVUue4GCODAPEnafHoLy9WThiOPbsooCkIrlLseGOV4R6wL72RcPJoM0Jcb5qHpSvFUBi0f9RAw3Kw/GdzcY5t7jLcfIPspKdUpCQ0dA0spRFV0gF/Mn1O+c40CLDLtg5EP1wxg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(26005)(31686004)(82960400001)(478600001)(6666004)(6512007)(6506007)(31696002)(86362001)(2616005)(186003)(38100700002)(66556008)(66946007)(66476007)(4326008)(83380400001)(6486002)(53546011)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RldWS3lkZzVNQTlQaGdYRStUZUloZmVWV0JnZGxDdk41aEVLVlhFOE92eFNh?=
 =?utf-8?B?OHllQ1pZNzNuZnkvem1SaFZ0VDhUSlVYVXUxSzQrS1JTcHlNTEtxNlF6alNC?=
 =?utf-8?B?VDBxeTArM3VrVmFoc3MwZlM4MUtNNXk0dHRGMjZEWTRGOXRHdjBVYitQVmox?=
 =?utf-8?B?SjVHTUh4ZEUvcmFJaHhIS3IrdGRsRXF4d2NOS2RwUG4zT1JoaDZPQWhxTGpW?=
 =?utf-8?B?UlJrTTR5NW81Um03MXZRMVdQOHR4UDFmQkd1Zmc4RmhhTlRBa1d2TmhSZCt1?=
 =?utf-8?B?MzJ0YkFBbFI2c09JRGE4UGw0MXNSSWxRZVFGZzltaUE3YTlGcE4yaVJQdG8z?=
 =?utf-8?B?Y29HZTdrakt4YXFaSUFjeG9Banh0NjhBS0ZrZUZiZDNKeXZ6Q3VKTGZROTQ0?=
 =?utf-8?B?UXlCVmdRNk5GTHVmRkovZnFBT2d1NDd1aVJzeUVlcGg5OHY5TW1ndXNNeWhz?=
 =?utf-8?B?NDNzL2FUL0VHbEZMVjdpTENRTHRsczVJWXJkcytQTzhiN2RYLzgrL2tYZWpU?=
 =?utf-8?B?OXVKR1ZnL2RUSkVvVmZTWE9wbkpGZjhQYmxQM0c2bklLaTkxMkc2TjJRNXRU?=
 =?utf-8?B?S1RoUnlTRElHMFIzS1ozL0kxeEMzNUR1Ym5HSzVUeVdLSEczSjNzaVNEdXZ5?=
 =?utf-8?B?ZHo3OHZDK21RazEzWWZvSnROMW14Y0IzRTZRdkxERTE1aUkzQTZIbnYzR3NY?=
 =?utf-8?B?bEhOVUVaUzlPa21iUWF2d3Yvb0UzejV2bVltckZmOFlvbE1mRlhibnVQdkdW?=
 =?utf-8?B?Sng3d2hSa0dIVUlxTDJocFRORkxSQUxTSU9UeW56bVVFQW9RQXQxamxtaUs2?=
 =?utf-8?B?VVF3c3hzSjVyYTNNYzRKY2lhOEdLMUp1V3gwUnJFRk1KNG13QU9XVVZ1WlVE?=
 =?utf-8?B?V1BGMlNEcWxFZkZaN3pPbFg3UjFSVVpMSWNzcUhZSnJDTmowb1o2Q212dlFN?=
 =?utf-8?B?Z3JiQ2VpdnZxbWh6cmV5OEkzeHJpaE5oY2t3cllRaVZDbTFhOER2QUE1dnk5?=
 =?utf-8?B?akttM3Y0MENsV1QxMkU3N01JcFkxRjhidVUvNy9Qa1BWMlhVYy9LUVo3N2Ny?=
 =?utf-8?B?M2JMYkV0WnlOeEF5VUFQTEpvVzRsK1daUVFGSlQ2d1lMMGhNZUFxUTdLOWkx?=
 =?utf-8?B?NkprekwyV2s3Ri9UTlZNaGNUU2FoMDVtS296RXIvT2FuNWhicEZrWWhnSkFX?=
 =?utf-8?B?eWQvalhhNFdIS01EZ3ZHamhPQ3VxYk9VQzlVNUErVXlCWVFHeFNWWC83TkhH?=
 =?utf-8?B?QzRTMVhhQU9wZHg5QTdGYXM2MjA1Tm1uZDRnbDhwaTJ2azQ4cjFPSytVNC9u?=
 =?utf-8?B?RTRiUzBiMkNDMWtTdU9VaVNEZk8vbjlOVGJueEZVd1FjdFUvcEZBMlpMMjE3?=
 =?utf-8?B?dGRKWWdWYmRSVGkwRFR6VTM2V0xkbGRPZkMzNW5ZRlpMQTh6OGpGdmJuNWl4?=
 =?utf-8?B?Y3kvNUhwalNnK0oxUnBFSitYai9pU09HZnJEMHRGdUpUdURKNXp5UHFXMmNV?=
 =?utf-8?B?L3pHSnJLNTg5RWhtQTd4cmtpTXVHSEdyZTFqM2FYS3ZyNGZxK0szdG9DZTA4?=
 =?utf-8?B?RktCUE9MUzZseC9zQnkvVVBlS3FrVWdUUTZETkw1N2svNlpFTXJuM0hYZmZX?=
 =?utf-8?B?a0g4Ylp3M2xTQTRtbktya3IzV1VQYTAwT2J1Z3pqVlh5d0RzZTdEK3VqbEVo?=
 =?utf-8?B?YmxRU1VQS1A4azJuaWwzcFRwVWJ5eno1R0c5L0p0SU1DeExtYkFnV2N3RFVU?=
 =?utf-8?B?NjNZTEdlcnFGeHdCcjVCbWZmZXRBcTVNU1lXSGNaNmE3Q1pqNkQ4Y3EwWUNm?=
 =?utf-8?B?RUpDVmYvTzNzMC9WL3dHcXc1ZWdKa3hKYnUwWDBZV2tqSWpzSjV0R2pCaEVE?=
 =?utf-8?B?dHNaV3BVcXI3NFJYRXUxNkNWQnFaYnJCaFNRVmlQbGVVRXdsWUZpaFBIZEMr?=
 =?utf-8?B?NS9FQ2lDajVjRlNFL2tXNkRYT1pHMXBrczdkckNkZm05eGcwazdzbkh3ZlF4?=
 =?utf-8?B?elhqSHZGQmFrVUtKZzVDK3JHMUJ3cDU5aFdKMFF1QmNwVjRYWlIrT1Ywem94?=
 =?utf-8?B?SThMNllLSXRxUjRnMExhVTRnUHlIcXIzaVp3QUwvNGtnUm40aDlCUmN0ek1K?=
 =?utf-8?B?bFZ1ZEplVnkvQ3I0UEVDSGFVd1ZyOWNmeUZ4RW9nb1Q5MXNMUzd5all1M3dC?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235a79be-c6da-4544-296f-08db7bb4080b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 10:55:36.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BE2jHyHfTHfhtsfTM2AnlynQX3gArPdyQ1P5VjtUYSGaG6+JhDWdcIDK8e/fACCkC4fQNPHYguGQePLIu11IDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 10:55:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12180

On 03.07.23 08:22, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> The generated .swu file is not reproducible due to its file contents are
> copied with its build time stamps, so set all file timestamps to
> SOURCE_DATE_EPOCH value if it is set.
> 
> Closes #69
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  classes/swupdate.bbclass | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index ac59c00..3d2b5f0 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -115,6 +115,10 @@ IMAGE_CMD:swu() {
>          done
>          cd "${PP_WORK}/swu"
>          for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
> +            # Set file timestamps for reproducible builds
> +            if [ -n "${SOURCE_DATE_EPOCH}" ]; then
> +                touch -d@"${SOURCE_DATE_EPOCH}" "$file"
> +            fi

Does this work for SWU_ADDITIONAL_FILES as well? If I read the code
correctly, those are just symbolic links.

Jan

>              echo "$file"
>              if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
>                  if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
> @@ -129,9 +133,13 @@ IMAGE_CMD:swu() {
>                          -inkey "${PP_WORK}/dev.key" \
>                          -outform DER -nosmimecap -binary
>                  fi
> +                # Set file timestamps for reproducible builds
> +                if [ -n "${SOURCE_DATE_EPOCH}" ]; then
> +                    touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
> +                fi
>                  echo "$file.${SWU_SIGNATURE_EXT}"
>             fi
> -        done | cpio -ovL -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
> +        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
>  }
>  
>  python do_check_swu_partition_uuids() {

-- 
Siemens AG, Technology
Competence Center Embedded Linux


