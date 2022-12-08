Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD0BC4332F
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 09:30:34 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.56])
 by mx.groups.io with SMTP id smtpd.web10.9372.1670491828851867440
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Dec 2022 01:30:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sQ8fVyXH;
 spf=pass (domain: siemens.com, ip: 40.107.104.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWIGxXHSIMcgqKBNHcEDAsW3lY/8y+5O4kFDT43U0onInJeJdlAOLVy3RjEWSkmWU7rp6cGAfbYY5YqhHo7+s0i5FCUQSAYCyPVYQFEUFb9H8qUFnb9blgNeHmDO/1AsNtfCaoUp9h7lGmidbW5iNQ0kNaQYeHPbQLBAnS4MccykfMUlhbF0S0w9fwR1saCCDHoGwT2HbFBmF+qTpQZCjVUF7g6JbT5wGZMExMzWN7nz005RA+g0HR5sV+Ems03ty5IGyBpwqDXV9oDyHIieKS85oJWuYXMt1BlXck4WJLIO3SxWQ8gdqlW9rJUvzEyWYm0JpnevMNd2nLZdyRHx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCGil7MsCuHuqtS2NyGGIuIYzDeTaQ6k+NUlELVr0yI=;
 b=QV+nZRJpAg9eLEKPwlwWYmgng0BKzMCcwknV2PxyIzMvJ9/qTwxDxgMZznxQz+wiegO7JG0IG037wszziaJ9PJ7Fih8QkNYPsOQ1+dDwE/rUsCXiY79ZgW5FiubBBeNRQl4M+tG4OMjv3MRouYkq6pyRuoK93EHLfdYypNyQGelIkIuLU0oRc/3Wu3KCBZdG+9CmjTY+V9YWrMFktXyIvTJOejKeMsvjoEdyqG6Nfu7DxpGpufcZcUcTRQGkMBGDC2Kmj3j0RHh/Hel9bqsedwCQuvQh4/u5OlZqeXqSLqfIdbv2l77liOkDDyj13bX/DWdHNa0zzFdbRa3U2dDgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCGil7MsCuHuqtS2NyGGIuIYzDeTaQ6k+NUlELVr0yI=;
 b=sQ8fVyXHw8bTGgfFr1wJNrczVuxFBDGIlhmR1vULf0LOmP702Noi44Mdp+TXxb9jz40xTsV8zOQHtmOzdyddtDcQ0BFr0L9GfweHAK+v7QhG1ov22FY/AtJtBL6WpMyj/zDxl+6X68EjHKI0A1fuKZikHOKwgu5Rbx5oxzRVdY6JauaiDDbxhQ8mX189st4V+S5256RCoGECoklFP+kPcdQ5sf/iB7Ofimn1WwvwFq1USBlbMcjjqb+7Qc4b63JYv44UsUgOtFE9orUgeSTUcgEl5fNKBIOK7KoTig7RuyUmNSdLR4jEbXmRpksjSfQOih3MSQp+0Br4oquRTY9www==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:647::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 09:30:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 09:30:26 +0000
Message-ID: <99e62a49-0c13-01ec-9438-bc6fcec501e0@siemens.com>
Date: Thu, 8 Dec 2022 10:30:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [isar-cip-core] security-customizations: Fix account locked for
 non-consecutive failed attempts
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20221128052502.19286-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221128052502.19286-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 226c81c7-d0e1-40c9-6356-08dad8fed68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aSQz3JlEkO2Wm46NBDyrePcGO4cXqKXFkyPJEQQLLKzql5pTqyxOnh9GYQKPZjb46iO2R5sKplTGLUYErSidLh9DQVSxKsa29Y0kG1o/xYh7epzdRNpHVXn48AzBFCoWuwaiVx7lnXiiUWnEQuE7PBm+1ufamDD9hZrouFKtMixl0Th4T9fk8Q+LP8jDBZ5X1l6ohwLCUNLiX7e5BuO9+d3DYKeiQjYz3T4i7XMkaB5l4ZWTJI33gmwHrXhVoTeDl751HOdM1a5L2H5GfHkUOZEwYwpdS9YaOKivtsO+Ae05HVXa01kBj5jz8+J9GSkzRv0QOfoNZR5+sggDyj/CpO3yuCK2N0IIZdkUZeMDWjF5s65wr/sAPR4P/OjlGslcf5ewgKW7a7y4gyRfa3ajbeuEin5u3eNUlVb3sbHjbmnzPg1wcPANPziSqoz9iZuNqf4CMgKGy2weApui4d33h0LEOYNI+4PVb0NI3UzJCChNghDC6pgTv9QIBFLCyYn6fU8JaDZMvVk0HPfODyMl67ae2qZnd9sMNJt8nPHiK4Sg35tXuRAGYTk9WZ/YVYBD6HbayZZcumu1BrasXzHZYXyANMOsXedKntem4hR5Qwf/Ryz2tvwugFUBwPJsm1/L4Ee3NXHLkaMTyxIBOfKbml/6SYVMzTNohPE1dElu4+v1CpST5EfX1oeFbjrMXkrj3GC82pFWbSxtgZ8x2NTIZVpKYp2OOe55Fr+Iexflk8UtX2wpzlg1iKkBymdlG2F1U9az93OiZaXJn1zx7LBxtQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(83380400001)(31696002)(8676002)(5660300002)(41300700001)(4326008)(82960400001)(2906002)(86362001)(8936002)(44832011)(15650500001)(6506007)(53546011)(26005)(6512007)(6486002)(6666004)(186003)(2616005)(966005)(66556008)(316002)(66946007)(31686004)(66476007)(478600001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTVxYjhWYVhYTmd3OURWZWtwNGVFNHlHN0xQczVSbHorWWlGdUhrMnJSeHlV?=
 =?utf-8?B?K291UFZBWnpDUHhmLzdUcUc5amk2cWpaVk9jOGlsdXFDVGhGVmM2Z0gzOXls?=
 =?utf-8?B?V3NjeDBRaXIyaUdGWldoVFJqUDQvTkZPSnc5ZkxNb2tUSkpYM0VvUjRWLzVS?=
 =?utf-8?B?T3UyVEFuVkdCOThwZWZmUVVvQTRVVksrdCtpU0NXL01iYXlzV0NVUm1YaWtG?=
 =?utf-8?B?L1BoQ3dYdjg2QWFCV1lGeDNmd2RSSDVPcjZQVG1jK0ZyVURoOTNMeGV0MDZT?=
 =?utf-8?B?eXk5THJIcUZrQU9DdUd0Wm9SVUNFVVVaRjY0UFVmY2xUREFjTHMrdDJSZWtn?=
 =?utf-8?B?N3VON0pVaHZ2UHVkaFF1SVd3dWxTeXhmZ3FoTUtENGEzNlZBd3ZNTm1ucVhs?=
 =?utf-8?B?ZmRuWFM1OU02bVl1cE9uZkVoRzFlR0pZOEV3Yi90anBhODZSRDdIY3djMXlH?=
 =?utf-8?B?OXdWTzloVHAzWVpQbGduVGhOT2o0aTVubytWc041MjJRK2FJRkphVnJBMGVM?=
 =?utf-8?B?VExPVnRMRStQUjNjdkNUVlVjWS9aWTdTU3Vua1IvMUwyZFAvVUljVEU1cS9o?=
 =?utf-8?B?MmhDQkNYRW1FQmRHZVMwa25YRGJhM1p6WGJQcWhzcmo5OGEyMzJjUnR6NzRK?=
 =?utf-8?B?VlFYZVFMQzBBcGREOXplNHpiZS9HNW9pUmRZSVhmOVhWNGY1US81K2d0TXZX?=
 =?utf-8?B?QzdpZUdZOEs3d3hkZndaY3VHU21nMUhZcjc4VTQyeWMrSTNQaFp0NnNkTGpq?=
 =?utf-8?B?Mkx2SS8vTytLNS9BeTFSdHhYOW5GWnRMN0JpcnZiUFUzQ3FjZ3NhcVhjS0JF?=
 =?utf-8?B?OFhRL21hL01vZUY4alVQNFI2Mmo3dTFDMnh6QzVoendSYXV5UFhub0xvQ0V1?=
 =?utf-8?B?M05TR3lGbzNCNlJVd1lMQ1lEbGduT0R3Rll5WG1keTAvL0hVS1gwU2h5ZGdI?=
 =?utf-8?B?RS9xT0c3NlJCZm0zeW02Y24zdFA4YkVpRGtsUXVRUTlieWdWVjB5QUgzVnNl?=
 =?utf-8?B?cVYvRnZWS1YzOS94bnlxK1p5SXdFWE9rcWxQK21iaFNZbzAyOWV4ME9pTDk1?=
 =?utf-8?B?R1RWekVFQzhIMGl0MEdVcEtNMXczUXlYRVJtRDNTZW9BdnQ2dGg2ZW55bUo0?=
 =?utf-8?B?VnlUUGhkbzZIOW04UVFlMnJZQ2p3YVNKakNHTld2bW1OM0sxSWFDYmNTbGN3?=
 =?utf-8?B?WFBzYnByYkliYUptUnphNjVKaE5qRFRJMzBSN09GS3M1NU1GTWVvTmNlY2Vm?=
 =?utf-8?B?cWNBNWtHeTArMmVPZFZSbFpLVlFPb0pYQTRIODcyc2c2aVJ3Z2Y0cFFYc2VD?=
 =?utf-8?B?d3MvMXpXYXdIc2U2UUJnUld1OFlBVWd1NXF2R2s2WnNCS2VSYkYzQURpUzFu?=
 =?utf-8?B?TVhNUjFHSXFQVFMxNmx3TWxrU0cvQWR2WG5PQi9SQmpkUDlzL2E1SEc0TS9i?=
 =?utf-8?B?UVhSbDhIYmdURndMdnQydUVoR0doTFdEVnBaQWlBMEVNcVdSSmpHSWZLRHNW?=
 =?utf-8?B?dFhudHROTjZadExqY1JMRVZMTHcvdW13Z3hGQkx1Y1VOSkRITlY0R3ZGRGpl?=
 =?utf-8?B?UzRxaGJ1TXN4SmRBL2VqUzAxL2xwcWRMclVNcFpsa0xoMU5HRU5mVmtPMUtM?=
 =?utf-8?B?M255dmRDN2FmTVJTT3FIVnVQRm5NVGt2YXFIMVFDcnRXTjFqaWtETGtHVFFV?=
 =?utf-8?B?V0RCVkwvZ0RSTTBpWU1IQzAzeTQ1NXQ1cjlGOGdKYTU1ZXFYeWlyNFV1eGNt?=
 =?utf-8?B?dEZ4UTdxLzQ0U2h6UU9zR0htWlJucUNEbjBwaThQYjFZdzFIMG05L1ZlNTBM?=
 =?utf-8?B?VnBPQ29DMmQ0dkNoRlJrRjNNbWxaK2xPcWlEZzRzQU1lZ2lZUUorWGNOSldx?=
 =?utf-8?B?L2pLRFN0RDZLUHlJRDZ6aHg2NGx6WGp5dk5PZzNTa1VTNDFnWDJkMks5Q0p2?=
 =?utf-8?B?YmY4MXRnd1hyVUlZT25vd0xYUWc5UzQ4akJzWlErQ0tDZTNlamRCejI5bVoz?=
 =?utf-8?B?U2RkWWxXb084T2lBaHhpblpUYVA4Y2YvOHcwb2o1bFJLV2NOcEdNRFpNVTF4?=
 =?utf-8?B?TFhQYld3NWNDWjMxVlk1bDNIeTVHbkRFZklyVEp2Tlc0MWNTUmUyN0t3eHpU?=
 =?utf-8?B?S0NzeDFVVzJpN0p0SkRlUzEzV1Nnc0NFUWd6YjhtNmk3SGs4UkJ2SlpoS2sz?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226c81c7-d0e1-40c9-6356-08dad8fed68d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 09:30:26.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtJugZj9gkpqgMkG/TNwkRpgUjln9hiiawQGfEiB5/dNzbBoVAs1jEPSWzhaDc39gTLEw3P3NU7OqN9GjG6RkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7739
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Dec 2022 09:30:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10165

On 28.11.22 06:25, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> As per security configuration the user account should be locked for consecutive
> failed login attempts, but with current pam configuration it is locked even for
> non-consecutive failed login attempts, because it is missing the pam configuration
> in account phase which will do necessary reset for non-consecutive failed attempts.
> 
> Closes [1]
> [1] https://gitlab.com/cip-project/cip-testing/cip-security-tests/-/issues/3
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  recipes-core/security-customizations/files/postinst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index 0d0eb07..4ff8ecf 100644
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -25,11 +25,13 @@ PAM_AUTH_FILE="/etc/pam.d/common-auth"
>  # pam_tally2 is deprecated from pam version 1.4.0-7
>  if [ -f /lib/*-linux-gnu*/security/pam_tally2.so ]; then
>         PAM_MODULE="pam_tally2.so"
> -       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
> +       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60
> +                 \naccount required pam_tally2.so"
>  elif [ -f /lib/*-linux-gnu*/security/pam_faillock.so ]; then
>         PAM_MODULE="pam_faillock.so"
>         PAM_CONFIG="auth   required  pam_faillock.so preauth silent  deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
> -               \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
> +               \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
> +               \naccount required pam_faillock.so"
>  else
>         echo "No suitable pam module found to lock failed login attempts"
>         exit 1

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


