Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2552.1794419041851902069
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 09:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=janJar5O;
 spf=pass (domain: siemens.com, ip: 52.101.65.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW0vzCYgRRBCzUX4onI6/MA71clDKCEATdMuRskB7vweSP1ra/wNBoxkZTeYEFbKDGMr5/xzWAOCFJ9N8wm6w9iD/LbBzzKjJV3Un4XFCg85cd0mCDKmgQK4AgqkGMy0qn0qWbdS1bWGPV+9hlBn6ac8ovU5xcahWkxDrjW7RrJ7L0ch20PuQ281s7cyU/vmH1uTG2IOI4dLJ1wvergB0hqPP+XlByPQ3r4ZmFFcMtJMdbAAnmzeJdT6dWCUIEKgMUiIrdrxH3z4qCb6irgjPG1mHIYu7XPn2DQRIa1h+zq5Z+9ByM/q+rIYhZTrTrgAG+rfh4R/NUODvOUdyNBA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv/n6TvBKPLp2n/7V5uzSK8TuoTrcb9pDf6lIS9X0jg=;
 b=tkk6lTJxpwGgaqbVplTyc29MciOh4skrSnTcX3fPzr8HNNmdGSYrjFAIgsl2ZPtSqnwT7pAcCtmYUYEK8a+HjSQKl7xF37UWZoq8HO3nhrf7E/b+ywMCbIgCkC9ERqhyHunTYSMhMLv+lW6RIwQ+YBbys+TVwkQO/Yu/NcIr9ldeq/1Z5a1RrlWt21HC7GQSqTBmTLCXMAThLzA+ZaTOvan+y291f5hEKEOqVHnc7bCy0TnvuzOIsTIW7aaflE85SavKG4dZcPm8mqi87jfRkxhh7H5QLq02u9OCWbLiQKQtta3k9MBpjT+aEK9aDXl617PMEd7wJsD7flkvxHBPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv/n6TvBKPLp2n/7V5uzSK8TuoTrcb9pDf6lIS9X0jg=;
 b=janJar5O3+4OFH8NNOx0M25MMr8s9bN7fkQwVAWeqlPJ4rF82qh8jlcw/xS3S4zJGGmCpIJUtiEQYH5brr0l+JHbKxpHvMQkacjU8VrsjOiRmtBQ+hyvF+7ZT3ecnE9YQbksWVn8O9kCAAcazXaZBb0x0ZIVvsxGESP3tUBvv0PGhToHuY/nvaAPgTWUXklhiH9srs0trJ9m8YswL+h0sZE9btldJhZvZ1CCYt+68O/lXScrgkMYfn72dGtp5Kjv1mLySW5//JApcwSItgG6Mm1MZ7kMOpgDEyalJUKU3fuFe0WP3xy/q/c+J1rVZtuM9hUZIRYpen0uBpOnixKplg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by BR2PR10MB992333.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:2c8:1c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:43:58 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:43:58 +0000
Message-ID: <ba7ff534-a104-4b1e-9dd3-ab20b87417bf@siemens.com>
Date: Wed, 11 Nov 2026 18:43:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] fix forky tests adduser is not
 installed automatically
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20261109084125.21199-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261109084125.21199-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|BR2PR10MB992333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cffe7b0-cd18-45bf-2f22-08df401b5d2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|6133799003|22082099003|55112099003|10067099003|11063799006|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261022115727099003|261021121427099003|56012099006|261021123027099003;
X-Microsoft-Antispam-Message-Info: vVHMca6ZL6GK8/nKHOy50laG/cnWPMJjdI3UGLwk67PaRlCUvG+RQYihyEP5u+RlIjM/m3f+m4D8KYBK3SXPbnb/gnLNooRqmv2dT/VKaU80mg9bcNcwtM9z+XYlosUTbIzwkMpnP77bM846o5oIMmDXhn/jQZZCiSG1Gvtlqhp2bnsePRHQCw1D58yMYO9x3DAwT7cqH7YETwDcrrLlmENYOHrhkhxVBaFpV1h636B8WFD5GiBjAY5MNhTUlfwicptSYZBeGnmzO/qWJzPILXUkcvm8IilD89XdzqP7tQBUWlCM3+MoOAn9u6fXzCESW1yWlFDSh+gl1cs0jWSGPOjxbqi1zKdaGaSGtZ66tsDj/NqjMwBDO1e0o/XD/CK2YPJsmiFCK9y8EFgCfIrLJO/ksrpItxhD6J3TPyX2rDvXSwnr8kdx231HyiuWjUgyom6DFOdTnRa0rJTJ/gBMlSaBXpe53KTl6fV8TNeUk6iE/41szSmI9UdnF0ZZcps00G2dzGKbAankj3UmX0kQLCKw52AsL1fM9nkUwDCbhObvTGA1+20K6D6LcjFuf/ckmGA/+H93lDgPG0tyMKisrrlMfbKc3LR1IVxZ8MoPi228A7vkf484GQc5xKx3AyhW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(6133799003)(22082099003)(55112099003)(10067099003)(11063799006)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022115727099003)(261021121427099003)(56012099006)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dsUWdPaU5rUjFMcG5IRDBMMWhFd3FEdzVBRk5hNjUzRjc5bVVya2ZJQlVY?=
 =?utf-8?B?WkdISG92ZWdmTHRQMUd1blVlY3l6ZTVUUWc5ZkptUnVmVU82czBzaFl0RTVY?=
 =?utf-8?B?bDVrRVREUVRmNHJ4V1h0WkFmckV1eVRZWVhaWHpCeTVnMm9Yam0rWU8xcEFi?=
 =?utf-8?B?V3FBWTh1VXZ6RGZNajdFTVBNS09Eb2hvcjBNWVFLc2xMMFpwNUl1VVpiS2xh?=
 =?utf-8?B?am5CbGdVMmxXVDhMR2ZPa2dtMWNqNklkeTlQa0Q0enhWSEFMbCt6UHhMS3VI?=
 =?utf-8?B?ZXkza3VPcHNQOEtVS0wvU2RQTDRaT1JxbGMrL3JqbmtiQWpHY0JaMkJSWmhE?=
 =?utf-8?B?RU9Jd1F1Q1FHVmkrVi9IVDRyVEtKTE8wWnZZVllTR0l6aDlOVzcyNHBZc3do?=
 =?utf-8?B?SGQ1OEUxYm1nUzl2Q0kycGdPekhEZ2M1d0x1Uks2QWx6dk5KbUNoOVFrZFpD?=
 =?utf-8?B?cnkrUHQ4YjlRQWdGazFJU043RmdHeUFabG9lRDVKMzZYQ2p4RkZkcUVFWTlI?=
 =?utf-8?B?bXBnalJsYkRIY0x5MGRDMEpORDVaOHQzN21yS1cxVk5IY1NYbkppWG53NWZw?=
 =?utf-8?B?SERtRU0vT3loMThCNzRxWlN2QjhlU1cxL21iaUQzTDE2SWRIRXFJZnhVeW9O?=
 =?utf-8?B?NitYc2xvL0ZCUzh6YkxSWDBNaG9LemkxWWZ6WWpST0ZOSGx3aDM5Z2xQaDUx?=
 =?utf-8?B?QWdCcnpvQ055ZWJvN1dxbWZsMERVVkR0cmNjU00rY3JLNTFwZy9kTlNnOXYz?=
 =?utf-8?B?RXptTVlIM1d4YllIMTB4QURrb2VHNlgyZU1CaURJbjRoUjVGV3BrMXRIWEox?=
 =?utf-8?B?VXFNenNPM24yN3ZzMXVQUnhjaFA5UU03ZUZXbzVKV3FmSnhuSnVHdE9oV0g1?=
 =?utf-8?B?NTdZNjFmd29XNmxnRTJEN0VrOEtkb3RPOE9POThjMDFzWFNvR0FVYlhUVi9t?=
 =?utf-8?B?Sy9rakdRNndZOW5hakhnMUV1a0tRLzY3R2tESUVjWXZjVXhtWFRWYjZwdjln?=
 =?utf-8?B?MFJvRUFseWRxemVaNzJQTGlkNndLUGlNb1BnaGxPMjhRY1dXdjY4cWVRb3Vp?=
 =?utf-8?B?cGNjdHRPc01JQkRRR2ZLSzl1ZkJpeno3am5KTWw0RGZVY0x4Y1M1a2d6WFAv?=
 =?utf-8?B?UGdkSjZlM2ROZGxtRE92Wk44d1pFMzE2ckRtNDZNejgvd3pnZ25XTTl1SGt0?=
 =?utf-8?B?SGdHbStNS0Q1anJxR3B6VmxpZDlPYVczQlMwMDNBMjR2bHNCSkJabVJGdm9X?=
 =?utf-8?B?UjM5YS8zdExoV0Rla3hSZGp5dXdGdEZVM1J0ekF5aEpoSDNEOVF5WFIzVmtx?=
 =?utf-8?B?dmxHUEw2OFdVdWJSNXdub1VrZkdWSllHZTg4MDFTWXE4THl3Nm1RcXZwVDZh?=
 =?utf-8?B?dFl6TElNZjY0TFNOdHVvbTh1eFRmbjRvaU9yQXZjRE03bW5KMWhCM3U3QVlv?=
 =?utf-8?B?N3ZBbFlRcnQzenNDRUhrOXNBN3lRSGtOZEV0KytHaHkzMVRyR1NjWjJZMERv?=
 =?utf-8?B?YU83YXU4S2JuSmZUT2QvVEEyZHZ4Z25Ra1pFWlg3OWhvajY5a3QwcVk3YjVx?=
 =?utf-8?B?VGdIL1BPcFdHNkFZOUpMKzhsK21xTXJiWjh5L0xlUDZ2ZUxwMlgvQ1dJR1lC?=
 =?utf-8?B?bURpYmxHYmhFK1NUR0preUM0SmVLcStFUTR0cTcwSmJuS2VRTkRsYnhYeGhs?=
 =?utf-8?B?MlB5Szlack1VeXk2MUJVYXluRUtDQ0txZW9yZUNZR005MnJZcmpwTldMVTFk?=
 =?utf-8?B?Q3hyeXZNZkx0cERoM2hnTEhHNjU1eFlYYkhLay8yd2pWYjNQTTdXTU5rNy9i?=
 =?utf-8?B?ZDNVQWloSFA0YmtWclZ5cjZjcW1jT24rTDl4djEzaHpkby9tY01QVGhyZTUr?=
 =?utf-8?B?VEVFem9yRGo1MnorODNtV2xiRDlJQ0RZVHJidTVCc0RhSisxQ0ZkT3FJcUFQ?=
 =?utf-8?B?RVUwajNqVCtnKzkyeFdDQmNIVGFtdFZUdGg1cVhJbSswUm1COUkvZWJBbEtI?=
 =?utf-8?B?N2JNQ3BFSU45Q1BrbDFEdW0rYTZBdVhnaFVKb1Jtbk5Tc04rZ0lTbTdXSnlR?=
 =?utf-8?B?SkJGc2xZZTlkbUs5VzN4eEdYamxtYjNZNGhpT2UwaS9jbHVzNklPZU44Vjhr?=
 =?utf-8?B?ck0rdHREQzZqalFoV2pKdUFLRU1hWmxpenhJTy9yN0lRbWRsME0wdUUwbzNG?=
 =?utf-8?B?M2hnU2ljY0FGbTZxZGh1a25GNHNsMVRVWDN6Si9YM0dNWDZadnVWQ1hObTRL?=
 =?utf-8?B?NHRNVEpFMm9RVCtVOW5FZTk0b0xXRkN2ejI0NFI1bkpyU0ZZa3d1VE9raHhU?=
 =?utf-8?B?MjJJS3BRTGxXU1dxNllUaUNCUFdOV3RuM2pWT3YxS1NzNE5tRzIzUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cffe7b0-cd18-45bf-2f22-08df401b5d2a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:43:58.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUQWWEotqN8AHVBUsbO2yK5/vuG0Gvgka0mmtWNAfBSy7A2h/ZcgkvXjTeX3PknNc0oyIEd8ugOHxP+t1mKESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992333
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 17:44:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24765

On 09.11.26 09:41, Quirin Gylstorff wrote:
> This adds the package adduser to security-customizations to run the
> forky tests[1]:
> 
> ```
> <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=TC_CR1.1-RE1_1 RESULT=pass>
> TC_CR1.10
> preTest: TC_CR1.10 Authenticator feedback
> INFO: openssh-server Package  is installed!
> INFO: openssh-client Package  is installed!
> INFO: check_user: 'user1' exist
> INFO: Deleting user 'user1'
> ../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
> ERROR: del_user: Could not delete 'user1'
> postTest: TC_CR1.10 Authenticator feedback
> INFO: check_user: 'user1' exist
> INFO: Deleting user 'user1'
> ../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
> ```
> [1](https://lava.ciplatform.org/scheduler/job/1538035#L1072)
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes since v1:
>  - Move the adduser dependency from common.inc to security-customizations.bb
>    to avoid unnecessary dependencies for images that do not include the
>    security customizations.
> 
>  recipes-core/security-customizations/security-customizations.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index 90af8f47..e5855a4b 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -21,7 +21,7 @@ SRC_URI = "file://postinst \
>             file://ssh-hardening.conf"
>  
>  DEPENDS = "customizations sshd-regen-keys"
> -DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
> +DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd, adduser "
>  
>  # Append PAM module dependencies for password strength enforcement based on the Debian version
>  # - libpam-cracklib: Deprecated, but still supported in Debian Buster and Bullseye.

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
