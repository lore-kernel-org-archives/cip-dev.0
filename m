Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA52CCFA13
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 08:42:58 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15748.1777538569138481144
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 01:42:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FH6LTqkH;
 spf=pass (domain: siemens.com, ip: 52.101.66.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roBHfN2GYiDPxrGK8CYNlkFuq8HyHJeco9tR7XMERGdEJ6Gr2TO5nSXt/YWySWphTT9YDFFHQmWSywn4LBeVpq5MMb/hqEsOOadhiIz1IE4T6Yz5n72dDxCHMuOw4zWEEz457il1a66X+KMRePOKTDw1fc2/YW3AkybJxH0Y5OJ7NR30FBvxMIDMybpRUa4Nb2TjCMGFV2XS5xqKQe3IhQW2glhlLFGrFciN+oPKQVuudVN/9Cs6NSL2aiVe5M56I4jCDu4m5ofctVQzCVpZpbP4SGaIs0Cd5SqjPzACFWi56FIzT8QIYScnsS2h9Qt+G2VAHmOQ3yMYpxdMAM4KGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAhxpNIeuYAwUqENSPJy3Lz9TudWenGOHz8YnDDKHQ8=;
 b=Tc5/oIcagjO2vUkzd9NgsbRJzJtlMsZkl4ChUiPo8DO9y+m6/IZFbaGwv1QaBPtZFWzqUDHsIMnHkDdh3pVrF8KVS2EkX+4bbvCbRZUxKxyG1J2JcZponYNHUwitNENHC5MOGP9vUKs6TeAwgzUd940IIsbJkTlTO/AtS4kN4ZJ6yVpuEiIdpUpzASPgngQgjGfIVM1yPQqn9ijq8m9vlx2J9iADBb+grl+0aXrEQ6pcOkMwaIuYKMkTNmRY3mqzAtAqA3rdhMwBO7ZHEBgRyOdk5BpukH6lFfZVIE3ZbgkNjVIWIReE8+kO1Rs+ntIC++4q1juMcK2Y48kjjMoAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAhxpNIeuYAwUqENSPJy3Lz9TudWenGOHz8YnDDKHQ8=;
 b=FH6LTqkH1FGGU1ZloiY9pm2zneeOcDcQ6K87cKpSJOWWPcah5FiS/6DqQsUbsDVc7BxR2xeKhCw7NlVM5FggxKUp2Na8Na77BG90wfmxXAje5VwyzU5P39PQmYRWib+RdMFnkbHwTuU99nincWvsaTxmha1gEpMRGe1hLM0i6cScW1b2sCYA/IMj7DbVscfuUXtSndjVF5R0lD14ZPgasDgrLHKoCMEyZRzRQaS0+6iAwBAKULc0ftJcAL8PLq3pdW07VXvbL/YJKQo/Mnph0lcNili+akkT+CRz5nvzLKqqFiI4VW2fs1NHW06TaQ+1QQuWZDn73hMcR6pmVv/yUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB9195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 08:42:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 08:42:45 +0000
Message-ID: <cd3a15a7-4a59-414b-afec-045676582803@siemens.com>
Date: Thu, 30 Apr 2026 10:42:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] security-customizations: Hardening ssh
 configuration
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260430054112.250485-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260430054112.250485-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ba5854-1ec9-405e-6193-08dea69472ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	qtabUHqGwez+17786ila/9+7K0WuHWqLsQQdUr3bTDEZ2ZB5cHwdDzuwRmMivb+F69aUlL6CO2f2ImEbUoDdOpB4xV7o5pevWqaSIi2r6xT55LQY7RJSUC48dIAr/zzAz5ILY2x4bIMgnd+czqlZRXCjlaR9cR9PYYrXUGcht8ebzuebs4fzP4+h3QzGjdrFBeyRAKLCxV53vJoMYFNU7O7LSiSM+m3vi1lziRw+DZm02LCtoHWpaCDI4D3xuvmDA07xYt3bB5bqLSL2p4N05hs1S2iqqWo4M7ka5AsdAb9ME3wYbvx/kZfF4z9ifBszduRQlIUweDsC1cQa7DkoAFkGaUHQg7oLMPaiSMnad62IXrGlNgCoZxm1JJRqyajfvmfS4PgGmK6afDk/Bokpbtv1aNjklamaqGa2ue1Tntjwl1xJxWNQvFmvcUQO2zsoAqEichFC8g+BvGVpWLSx6K6d8LEmStX819o70U5asHnhZV5q67/i7fKrJ9Db1Y7HOB2wU8ZMU5EstQpOLhMyUT1f1a+s37veRXoqbD7sr5HuzJvLGOEDXun0b6Mk7YnSxWcVkrefGm4sh5pt2G3ywa0HZrIuhxpQzHUmzzI5coHGgBBzazFRhRw8geSQ3p01lg7XiHVbDvQHIVzZ9zXNjpudr1xuhGCwOM1y8YtaySOCaT27kGBO1/mdfNFKo1YuhnhZf+qoMMM+sZHphRLWtu+UcWQhdPqkWhaJJMtTqig=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHBVMHo3TnRZQXp6NXhkdEcxdHh2eW5lSnhpelNid1hCUUhzaDlSVXZjWEg0?=
 =?utf-8?B?VlRDQWhENkFGbmYvaG9meWFkZ2VJWmpCK0dyeURKZWxmREMvZGcxWnhGc1JV?=
 =?utf-8?B?T1p5Y2Z0QzRHcjhlZXBRQ3FyamE0ak1HSWRZeFJSSkh1VzBoMldnN2Q3KzB3?=
 =?utf-8?B?WjYxZUUrWEpOSUVHZlJUZ242bU83ZVByWlJSYldDOUE2RmxxNjFxNllPN2xT?=
 =?utf-8?B?eXRTRGcvcy81MmdrL2xJYmNQbmVYZllsTHlIT21PUGgvWGFjdWFJT3VxTEll?=
 =?utf-8?B?WVI3dWVVTER3SnhSbjUwUlJJRkhmYlJXODdrcExmRWRlRFlOVW1GU1F3bVZE?=
 =?utf-8?B?ZFp3bGdMUEN4U2dvZnJLeHpwNXRqdTFUenJJY2ZrdndSOFBRYXJ3dVM0VjV0?=
 =?utf-8?B?NUZLcTFvK2V2WXhhaTcrVi9pWFJPcDlCQnh6QVlxY1RHaEJNOUJUaWQ4NTRz?=
 =?utf-8?B?NjdOT3E2QXR4Vk1PTW1scWVqYVh6cmNIZmlHMEJkTzgyWU1heEZpUlZkbzN4?=
 =?utf-8?B?eGhINlAwaTFpV0pYbzE2aTY1ekFWUWhJYnE1VFZVN1c4NS9rOHJXQWVEQjdr?=
 =?utf-8?B?MUJpSE84ekhJVUEwYVEzdVQwWjJjOG1ncC9KSG84ckxPS1VOcDZsbU1mQXk2?=
 =?utf-8?B?WmM3VkZ3Zm1tRG9JenBvTTl5cFJFdWdPK2NxcEZaUEJVWDlOdnRsTWs1ZTlq?=
 =?utf-8?B?Zk1XV0kwQU1ZSUNNN1c5YTlRMXZ4YWhRckpMbDRPR29CbXlwQmp6bHNqSjRQ?=
 =?utf-8?B?YVdQTlpkYjEwRi9WNGJNZFp6UlM3OGJkc2picmQwTlRaV3hyQlFlc2k5cThG?=
 =?utf-8?B?OFBFUGVKQTJKMTFVZkxCN0VTcURSRWRudk5TM08xNm1sZGlvN3FWRnRnSmVV?=
 =?utf-8?B?RlBBZWhNRC9OeDNEVHJHT0dCQ3MvcHl5RTBuWThkV3dXa2Q3blo0bnQ5RGJQ?=
 =?utf-8?B?T0ZIdXd6ZE1ocDRJdWJqY1hDWjBybWM5OEp5MVo0N1BITDg3OXNjV1BRbm04?=
 =?utf-8?B?eTd5MkhrOXVaS21hcCtkTnF3aGFiVHVGdVJSRGhvN2M5bkJFcEVTbjdRaXNj?=
 =?utf-8?B?L2I0cHhKT3huN0FwaExCSmc0RVJNd2hRTzY0NDRpSW5hNnVhNEpGRHZqVGh1?=
 =?utf-8?B?dDNQZEUvb1FXZEpEVzdsNFYvdTVrNFJJVFlPcEhyZ2ovV3cxRWFNdUJBTi9K?=
 =?utf-8?B?VXhjbXZQUW1SZHpWRmVqdXZVSVVaRkxCcnduM0pWd2w4UDVXRGlOV3ZhMWNU?=
 =?utf-8?B?M2w2VFJNRmxjWUVNRHBNLzFTVFhGeklpSGQ5aFNFeFloNHdYYWpnTlp1VXo3?=
 =?utf-8?B?NEwxY1prdko3VWVKek5wMW43eVRUTjRiU29ReUtIYkowQUNnUkpXL1VBVU1B?=
 =?utf-8?B?Ujd4T3B3Ukk5RGR4NFlnSDFYL2RURGV3ckRQS3NjRlpsWXEyOHVrZ0lXK0NB?=
 =?utf-8?B?U0pEdDVzT284UndRclBTZjE2dUk2ZE5SMktGWWN1M1NubkloMUIxVEd2Tk4v?=
 =?utf-8?B?YW1MMHFYQ1dRWnlxdXN3K1VjRGMrRFhJd2EzbFdZRGpHYVNQajFCYnM4c2Vz?=
 =?utf-8?B?KzRIVkpKQ0hVQktFaVU2OVRNbENTYW4xZE9KRXE0bzhnWWUzZkhOS0w1SGxM?=
 =?utf-8?B?cEt4VWRyS3RoZmMzenE0dmRJZyttaCtLOGRlcS9PNVZEbEFFc1VReTVpY2Ez?=
 =?utf-8?B?RzZ6WUxhdkYzTVMrcVc2SE9jV2pBRTJIV3hEcmxiYWVwNmlNa1lEMWJ3NmNG?=
 =?utf-8?B?TEpvc0oxMlJtdFpqOGRoOXB5VHJPbnFpT0VPNDdPMjk0TEJDQnJyaXN5MHIy?=
 =?utf-8?B?LzM4bFNVdkM2a2QrSzBjb0pldUlNb0N1dklVaytCK1l4T0RNcTBtKzBLclBR?=
 =?utf-8?B?Z2wzVlRKdjVZNUh4bzhndzJtNkZUS1hHRVVQalJFRDN3QXVReVNQbWQrbi9l?=
 =?utf-8?B?SGYzZU56Uncva0NGZlNWZFEvbGtUTEFuUWZLNmJKZEEvQ1cwQ0NHUVhlSWxr?=
 =?utf-8?B?NlRRaTBDNmxIQWYyQjZwQmRvaGt0MVR4cUsvaFhCTVNTS3pvbkxLN1R1ZTRW?=
 =?utf-8?B?ZDVMdHlhYTltL1hHTEVHRDd4UkI2elJIUnJrYVh6WVdRUFd2bGIzd0ZXZ0Vy?=
 =?utf-8?B?R2RFMGQ0U1lXalpkMnArMDRCUHR1TEJ6Z3N6TFdYYmdrYzFrUlROMmljdExE?=
 =?utf-8?B?dnRkMHdEN01aN21pUW9BY0p4RVViWDBLS3F5TWszUTFWeUMyalU5aTBnZ25a?=
 =?utf-8?B?QWJzdkp5RDNPRkdLUzdtbCtuTGxjSXdjb3RoYi9RNGNiQTY2RHlLeFl6M2JB?=
 =?utf-8?B?S0FXTkJtS2ZZQW5QT0FWcEtUMFpJUGdUdHEvV05CYldHcjhienI3Qkh4V2ZC?=
 =?utf-8?Q?0cnT12pCyOof5c14=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ba5854-1ec9-405e-6193-08dea69472ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:42:44.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMAhy4M3ceT+4gvCcl0lWVqw/reacQqiDxQcrzLGcdMxbd74USkJHSPx0leTQ64OUXQNmp+W5VTa1e4CHJzrDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9195
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 08:42:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22827

On 30.04.26 07:41, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> IEC security assessment had a few suggestions to consider w.r.t the ssh
> configuration in our security images. The suggestions are listed in [1]
> 
> This patch addresses some of the suggestions from [1] like:
> - MaxAuthTries (set 6 to 3)
> - MaxSessions (set 10 to 2)
> - X11Forwarding (set YES to NO)
> - AllowAgentForwarding (set YES to NO)
> - AllowTcpForwarding (set YES to NO)
> 
> Suggestions *not* considered:
> - LogLevel (set INFO to VERBOSE): given that embedded storage may age quicker, overlogging must be avoided.
> - TCPKeepAlive (set YES to NO): the suggestion to disable is due to TCPKeepAlive messages being unencrypted and spoofable.
> But I couldn't find any resource that suggests that there's an exploitable vulnerability with TCPKeepAlive.
> 
> Closes #153
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/153
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  .../security-customizations/files/ssh-hardening.conf   | 10 ++++++++++
>  .../security-customizations/security-customizations.bb |  4 +++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/security-customizations/files/ssh-hardening.conf
> 
> diff --git a/recipes-core/security-customizations/files/ssh-hardening.conf b/recipes-core/security-customizations/files/ssh-hardening.conf
> new file mode 100644
> index 0000000..3699370
> --- /dev/null
> +++ b/recipes-core/security-customizations/files/ssh-hardening.conf
> @@ -0,0 +1,10 @@
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# Generic SSH hardening settings
> +
> +MaxAuthTries 3
> +MaxSessions 2
> +X11Forwarding no
> +AllowAgentForwarding no
> +AllowTcpForwarding no
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index 382f0c8..90af8f4 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -17,7 +17,8 @@ DESCRIPTION = "CIP Security configuration for IEC62443-4-2 evaluation"
>  
>  SRC_URI = "file://postinst \
>             file://ssh-remote-session-term.conf \
> -           file://ssh-pam-remote.conf"
> +           file://ssh-pam-remote.conf \
> +           file://ssh-hardening.conf"
>  
>  DEPENDS = "customizations sshd-regen-keys"
>  DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
> @@ -34,4 +35,5 @@ do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
>  do_install () {
>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf ${D}/etc/ssh/sshd_config.d/
>      install -m 600 ${WORKDIR}/ssh-pam-remote.conf ${D}/etc/ssh/sshd_config.d/
> +    install -m 600 ${WORKDIR}/ssh-hardening.conf ${D}/etc/ssh/sshd_config.d/
>  }

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

