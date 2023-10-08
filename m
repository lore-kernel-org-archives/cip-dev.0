Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F2E95A67
	for <webhook@archiver.kernel.org>; Sun,  8 Oct 2023 10:02:18 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.63])
 by mx.groups.io with SMTP id smtpd.web10.35367.1696759329702212570
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Oct 2023 03:02:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MwvA2k+Z;
 spf=pass (domain: siemens.com, ip: 40.107.21.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSmwKj3NjHTQIQAyAFqCA4EztYoCz+WMGowYN1aGLaX+nYj3aNyin1BgLCZe9rZ8Kze4FCg5l5wJXagZtN6fwzjEFCzZNa1EhE20is+NiUlCAUgMrgI/8BU4EYMahlD+1CJNyoyXTFtyk6nL8nbD80f8NdOE2Ho9Ev5md5CTzlXlu/Wl5ynGEtd4OyaK4EOOoZOkJiGMsbxp1yzXbHFDrbMxXH73PPi8Vo9psiJ+Xlk1w/AaWfBymfTbaXSnnYqZiBvfnSM89NVX2nZFGLWvZ9L8/oFSMBrrOuSylj0cq5eIcfWf7RfOydLjHAvmDNIkR59cKKLHam6nFdc/BTHDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iIxiWFRbS4okG6Kzw2XqFKGLvBlzsJadkRHh4UKhrI=;
 b=G1y94VDhX/Ilh/SUWeRYXyGV41g4avUZoh36CcsBAHqnHmslD+yUzR/LUEii08cNFaec4BEvL2xt4QmY3c3rBsv401r3SWU9rBZAMsf7XUiOUfgytyKV4wopmlYM4N69VHvi+swDL0h+8h8vffXuuyy0/n1iWReV1ECK6vz5+B+kQtW/KoR54iOEcKb/+YbG+fmHEZl64TzSs3qkSZgMu4MNkMckXec6mXDBrnUZfCmr6I9f2n8uNq8OQlPCmNkVakbDdES2CTnhKkREpnuD1/SFkShMWMzD+vFs1HeN7ggztWd0VHARYY0/yZXiKkqVo/n1cvN78M1W2legV0fztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iIxiWFRbS4okG6Kzw2XqFKGLvBlzsJadkRHh4UKhrI=;
 b=MwvA2k+ZHyNSWjA83F63qvrlF8BjkHLB3NyW5dTFIkMu2zJRjsa/m4iMuWXNBZkMI5PzfZMIOR0ik14IS29+HzATUFvibek358NWs/9VgQy1qM2TC5EjsBP+uEJwOqB9lIlfZixMeTtsoyppbG2XzO9UTyEo4O8WTzFPsZZ1F8LBG4kHH8itilY02MCPgRM+UOkjnDdkII5zJnkPFajXUO6dFPAnUHqIeY5q6+OUw7oK2eTpfyMi1nduRYBGQmmTWuT12QMrMK1czLZxNNIoOvW0ubcHF1elo3PmjEOjOvKa256eX7cCChUmC4VxKOsZ6WhX/C0O3Sm5QzUlfCzHOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 10:02:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Sun, 8 Oct 2023
 10:02:06 +0000
Message-ID: <95401178-5f5c-4959-bb06-4296af18dba9@siemens.com>
Date: Sun, 8 Oct 2023 12:02:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] drop dependency to no longer existing
 buildchroot
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20230919144309.3499738-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230919144309.3499738-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f792b18-14af-41d4-6a03-08dbc7e5a06e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kFBrNQyDh91E9L4WNPj4ZMtncvxneSfBvqgC4bsNmk6Q3S1l7PklI4weOBjB3BCOauFncY7mq1UPPyQrb+G90qtm8H44ra8p2YhqRbE7IlKXMxmFf8a+tLqWnRBvXoKlZAJzr/nazyp08eGtGdk6ylD9Ara8KhBo2lEjaAjeMDDON6bJUgd6Mqwvhknbb3slMSPZC2KUxuiFL3pqx4rAc8GgrikJYZ/ciVGzvCmMEMETjx9Sdvs+JQ9q7otaY1x+ytIG+LZuIjRvklSNBnQOoU56DbXGXofJQdH6Tr1uUgRojBriMWZNhQ615uylN9z95KonyN+/TP54qWELjEchc+2AmxtNRo7Okecdq63PwujGHj+RnRBxpI3EgEi8RSSDrn1nDDscF/dq0AycxLX6+b2QSJJDO/q0zpyiPWUkkXApcWJebVTneJAyAOl28I8q/pxS4xTRKUT2npqwqIRad+K7DgJbDnY74pOw8jARWwIJMdK2MNBANpNXmxT7b2vAIx9hFRT9pf1JitKzd/1sHSergcqFvGoMjp+jbKWwbVFcZTpR1VhveBQHItbYaI/06q3fMMgpriO/mF+djPf8ji+87ofT7ygcRY80Ud2VZAUOfxUy/42ltmMQJ3V4290EH/ZBgQ8M6TW7uieGfQaW0g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(53546011)(2616005)(26005)(6666004)(478600001)(6506007)(6512007)(8936002)(107886003)(83380400001)(8676002)(2906002)(4326008)(66476007)(66556008)(66946007)(6486002)(5660300002)(41300700001)(44832011)(316002)(38100700002)(36756003)(31696002)(86362001)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVhUcmg3SHphYkt1OTFQa05hTlZxdG1EU1doQWF6cm1tR0xjNXhZTjJKVlJH?=
 =?utf-8?B?WVpkK29wbFRFanZhbmpvYnJNWWdCcEZWdlowVEoxTmNDZVZEWVordkh4Y2Zh?=
 =?utf-8?B?Zmx1VE9sTGI1QUMrNVhtbmpZaU9BYUNDQkMxWGU3azZmRWQ3VDhLY0NZMnlE?=
 =?utf-8?B?b0dWU1VlM0Y3RnlmZzEvVDM3eng5VnNMNmg0T3RXaUVYNTBRT1poNWx0OXBY?=
 =?utf-8?B?UW5ibm4wZXY1SVBXbjYwM0Z3SU9ZUFVEeDUzWVNrejU3NTVJU0lOZFpWcjRp?=
 =?utf-8?B?YWMrS3luWXBrSFQ3bllzWGZXbHhHTDVVL0lHbzdCNzNSWnQ2NEZkY0hWY0dn?=
 =?utf-8?B?MFd0ZkdCUG5tQ1U1TTJlT1liRWFrUGpTbFYycDdKUXJMNGJjODBucktzRWRu?=
 =?utf-8?B?dExnNVd3Y1BTV2FDMUZGTVBiN2gzRFJ1T3k0d2sySW04RC8wRlNDZTFMMXdu?=
 =?utf-8?B?MnFDZkZsYVdnWVJXeXlVVGVWK3FuOGI4ZW1mN3V2d2w1QWNuWE1ZK3Y5d0tu?=
 =?utf-8?B?VUZ2TjQ0dy9WcmZ4UGVPQ21kdjhJSzVLNklycEZIck9HVzVBcGl2Y21YSktm?=
 =?utf-8?B?TUlnSTBnN1VvODFEQ0kwaGIzblZpWVAwOGh6M3Z3VGEyOVZhcmgwQURPNXhB?=
 =?utf-8?B?cjZDUXo2QTVtcTNPc2NRQlYxVHBRZVRQY2FvdHNONFBXREtZa2lCSHBybS92?=
 =?utf-8?B?cGRQNytRcnBkSnNQSksyK2dZNDl4NDhqWkp0Yks5Nm1ENnREa3Raak8zMTNF?=
 =?utf-8?B?cFFqZnBodzRsVS96TFdjNzNyWkxiTHVjZitBcTMxZHRZUE9YV0RucDNFYnZP?=
 =?utf-8?B?YVBsVTlzbFdlT29nUno5Y04yOUFiQ0tmNXVDQTQzd0pOYW1sSzZkRlJzN3hD?=
 =?utf-8?B?V1Y3WmdFZi9kOVliWnlNLzN1Umpub05xL3VhV3hIalNBczl2RDUxSitIa21s?=
 =?utf-8?B?M0MyMDExdzNrZldQRFRmNWpIdDhIV0pXLzlGOU9kM1JZTzlZQkVyYXZVVFRQ?=
 =?utf-8?B?Y2FGaTNWdTJSNWp1cUpLdHdZZUU3RmI1eVFjRDJtVit2ZzM0bXRGWnVSdGpZ?=
 =?utf-8?B?ZjhRUXJYa3BEN2I1SDkvcWdJcnpkUEhBWVJDSFh6eFVyTXp4VWZXdldnTXh3?=
 =?utf-8?B?WUk4L3crZVA1cFJwREZWcW5BU0xsUFhublBFYllEVW9HM0pLQm83M3gxaTl2?=
 =?utf-8?B?UlN1QlZEb3ZreE93M3p1a0o4dkIzT0I2QzRuMkhKekI3VVc1aWY4OFc0VHFr?=
 =?utf-8?B?eWVRbVpnaW16SGtlUFFUa2tGTlVNS2ZXLzQrV2k0UFM1Z2JwN0NuVDZXZ2ZQ?=
 =?utf-8?B?N0xGQlpmcWxtb09iV0I3L1RlSlpVbjV2K0REd3F4Mmtoa3BYNmFlbndIV1BU?=
 =?utf-8?B?OUE5VFpPcUowV3RhMEwyUCtXampjODJsQ1NKMmRkRDZ3a094a0l2aFg1RDZ0?=
 =?utf-8?B?WTBrMGZ5Um1YK2lqV1lDSWJ1UUplcE5CUERmTmczOE45VnQvWmplMDFJYVBM?=
 =?utf-8?B?d2FyRGVyZFgvalNxdUFyKzBCSGNYQkttenRtcEVIUEpZeThzcVhWTGZXaWpC?=
 =?utf-8?B?Mlh6T21qbDl4RWEyQmxpdUwvb0NQTHY0ZkEwN3Jnd2drM0lTbGsyNEkrTk5V?=
 =?utf-8?B?TXg2WkZJUzZwUXRwMDZsODkrejdhWW5QTHdsTVRCTG1TQkFVWG9pdm1HeW41?=
 =?utf-8?B?MnFEMVVST1NlWmY0TlpyTGtIb3gvcTdSK3U0ZnlWZnEvcDV4L1VXLzBNcC9W?=
 =?utf-8?B?N3hoNW5vSm4wL2tMZHczQXQzTW1lTVRIaGhjbDJHSFhXblFiZVRPUE16aGhZ?=
 =?utf-8?B?aG5Zd3J4aVpiV2oyc28xVjdEbDVyN1UrcXY3YyszQWUxRG9qcUw1bkhwZXlC?=
 =?utf-8?B?N2dJVUVKMlhzdFNsVzlHazJvUVRNc2VpKzlJRTRuMkxlVTdmTGtmaG4rUkNO?=
 =?utf-8?B?SkhDUU9KQWpOb0Fjci9mRzJjMmoxV2V1amlpazg1ak1BSnpMZXJUMWlTN1Zz?=
 =?utf-8?B?QkNCZ0NubG9JcW55OG1JQk1seC81L2Y0djV3QmluakhnK0pRRHBmVGJKSVZ5?=
 =?utf-8?B?OURjQWprTmJGd0dhTzg0SE4rQWFpT3lKeGFpc1JXUUZlRkhpZnEyRDJoTHla?=
 =?utf-8?Q?nCe+75JaVQ9GMirs6S/kGraE3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f792b18-14af-41d4-6a03-08dbc7e5a06e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:02:05.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN166SuMw8L/CP3bFLzwy91bkUcDAsrq6V2guErXXXAi/3Wfp5pdmUC9dQQ9QbJpBmvlElk501v1UN2PdFzebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3590
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Oct 2023 10:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13304

On 19.09.23 16:43, Felix Moessbauer wrote:
> For a long time, the buildchroot(-target) has not been used anymore.
> However this target was still available in ISAR for downstream users. As
> this is now dropped from ISAR, we also must drop this (obsolete)
> dependency in the image_uuid class.

I think this dependency was never needed in the first place.

> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/image_uuid.bbclass | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 37e86d9..2cd8459 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -42,7 +42,6 @@ def read_target_image_uuid(d):
>  TARGET_IMAGE_UUID = "${@read_target_image_uuid(d)}"
>  
>  do_generate_image_uuid[vardeps] += "IMAGE_UUID"
> -do_generate_image_uuid[depends] = "buildchroot-target:do_build"
>  do_generate_image_uuid[dirs] = "${DEPLOY_DIR_IMAGE}"
>  do_generate_image_uuid[network] = "${TASK_USE_SUDO}"
>  do_generate_image_uuid() {

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


