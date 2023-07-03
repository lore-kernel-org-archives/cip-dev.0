Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88643EB64DD
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 10:48:41 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.53])
 by mx.groups.io with SMTP id smtpd.web10.29767.1688381318040804719
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 03:48:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lfnxPv3M;
 spf=pass (domain: siemens.com, ip: 40.107.7.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHB4Bs7N/xvs0tFDJJOV6pBlrNk8iLoFCNJQPHhfC0j1eY/av5NS957RR4c41xUAV19M5x7ZC/jkmP8UnCCRnItNMib8XuRZDDeMsl+fJzAExOycL+wPwb+e/3H1IfqWS48lk8EkCGupSQJLrbFrr1MDZjug7MTCWYEih4o/NsSPViH4m5mVSvR7J33034jaGtSyt/4ziAOixlUdwAIUVJaRer/HAEVyK8Vnx6Kmu//EMwrdAgaYGuVHlkKzMzpfujkV1Ng39m0KYDg228gJ3pdEK7+TN+Z6tL/Gol4O3EL5jbEIWvaKBtMhn/Op7RGTDBKB8WT4Mw9MaTaSwI1+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7gfsB1GAnN1vuPvqfD1pQv4nYoPcH4WDfG/LihXjEw=;
 b=WeyFV/UBIqFRcnsR0cbYEi8PvGV5TZT3oA1iCwmAbohDvQu+pLFWRcqdQ84gbLDmRY3UxH/vwtT1TxBJ5+GOk9xFUQ430g849CiUppFJsmr28ILLcuM1jAER6PpGSwWSPjuNIgBNHCIjTj1cuYFthJ75dzygygZRRSxkY0TAUfPhANWi5mmoadXgY5Ece3YWvyJANizFhNFdBHHL6Ml1lFoKzDfCJXNekTtL0IpwkcoUWvaboLA93YTDeVDfalkiotgU1YNyMyl5pBcqwJ3tw3KQ4RDAXUTfirNHWDQtzrYY/lkbpNEzad51X1RtH6ENcuWibdb3c7EeiBaP2EqIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7gfsB1GAnN1vuPvqfD1pQv4nYoPcH4WDfG/LihXjEw=;
 b=lfnxPv3MpuhgZZHUZJthIUQK4WD1g860w4Jx+OR5CLDZ/jafXg6jMTFoyVQq/3PulSG5t9tXaNk+C89cw46/FBQVSLiCDGhVmosYWcTYoiJp+zHGje0TZEpaV/BaUUCT0S+dyq6B/tiYVgFTqbKR0weZ173B3e5Jv3Ft+eeYEbpONidA1kKLZQTOYikiFRBHuH/QXoN958BNB7K/+fSIC53aBFFx6mJlvWIlxgd0YR1DFuy/FPiyZhDM6z7uJ6RuH0bDMdb1OySWSealxQX/tC0BHHO8aOImzXr9p/3Gpw+Y84Jly1qCfFT1O1N3juXBhokgqh6d0/nV52L6d3DJVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:590::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 10:48:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 10:48:34 +0000
Message-ID: <b4ec5f45-0020-16fa-4f7f-86ee3c3eec64@siemens.com>
Date: Mon, 3 Jul 2023 12:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core] security-customizations: Fix broken sshd_config
 in bookworm
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230630113458.8610-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630113458.8610-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8cc598-fdf1-4152-fea2-08db7bb30c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hguminyaTqFGasbzGnbAPR9H6qqBXmLJnz9IIqan14QuZgw+WfQzo36alAtR/9TIHVPlKZEBO9VGpVXu2Tdc8yPy/4LdPtaw9brxtnGWyj3MBdJAU+0k+QUAmkhMuBy3KGMl5mf5wwy2g1wrXHw0jlt9rtpsRSvD9m3+IVyLVG3j4OlE4s/iDBDUVfF5JPI/EtTXAc7YvkFCKXVOZGAGD4hHeYg27+hmIYRraro08/uxlDzKtMhCvRkyflnj+XkrV8i+mKHBETgDxbwla6fMluIygvBAFEQpF+9a5hku7/JiTJISxEn8INQcieetztm5kqslBzK5ygQc4BejYHAoD34VVDzcOpkpe1yvLvcMjURg4wkz+D85F+r11nB7QYKC+PgAaBo/2AOWzPWGZT1MRCEkElmAvtRIxXQBtT1jvVjy9QhdTfM1aLdom4euBnIeydSsXjWXUcAqpa9bXasIoVo9YLuSD35Vr+dDNlfD8sUCgUE9OaMDlNxtZsjPu45n2tBDLFStXMslcmo7UYuV47of/MTqeXkhyDMTQXXI9cmROSAA8FglpX6ipPl9hIVVdImzlYlRT7EPxyys0WiZrt+LuLiyv3iPRXkSNZAyEhKPxWdJZygRjWqSVfpBkaNBVIS1F3iJTBR29ZY7qwit9g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(478600001)(82960400001)(5660300002)(8676002)(8936002)(2906002)(36756003)(15650500001)(31696002)(86362001)(44832011)(38100700002)(66556008)(66476007)(66946007)(4326008)(316002)(41300700001)(31686004)(83380400001)(53546011)(6506007)(26005)(186003)(2616005)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0lSZWNTNE9sQldnWTgzLzhTSlpnTHRPb0xOSkJOTmZVUzZaS0FQS1ZxSENK?=
 =?utf-8?B?N2x1QWs1OC9iZmEyZmN5MUtGTDVzaVNrbzk2V1B5SXhJTVMxaXYvc0t1TkVI?=
 =?utf-8?B?SmhWQVE3TzNLMGxlRGpZRHFIcXJicnlqbzB6UDZvcU5ySlhoQUFPODBXSXZo?=
 =?utf-8?B?R3NaOEFDNWRoNkpoSjJjaExYSmR3WVQxeGJaUURhZnVUZXZySlZyaVg3emUv?=
 =?utf-8?B?ejd0Rm85d2FYZTZsTTdINzlZNUJmdE9aSEVoK3JWd2dycUYxdDZIa3JMUWx0?=
 =?utf-8?B?aEJlWmZFMVVxNEprV3NGNDJRNUtmZVZuWStEdnM5RjhtNTlqSTdCZkl2b2M2?=
 =?utf-8?B?cXUxTVJIZ0JMWDliRkRDMjJXRnNKMmhYNGxVNzlKbk5uQnlNQTUyNXdaTk5a?=
 =?utf-8?B?WG9xSlBHR1lCenQwekk5T3B0eDN6bmg1T0VJbEFEUHhTSytJb1VtMlo1dWFq?=
 =?utf-8?B?cEJ1S2htYUhWbUYwZDFpZk0vY1A3bE82YUtTWUlXN2h5WjVsMm5QT0RJSGky?=
 =?utf-8?B?T1o2dTc3ZUpabm5nZzFTM1ZMWkxWTW1uS1U0R1oyNGhOanZmbUo1bWI0a3lj?=
 =?utf-8?B?aFJ1Qit2TTZwZE5QWGU5M21wNW9nRkRUUmtOd2ROWDRvcktsbyszS3Z4UDNz?=
 =?utf-8?B?czIvNUR2OE5FTHF4UDhkNi9XTTBLcE9ES2hTYW82YmVVV0hMUUx2b2xzUTJw?=
 =?utf-8?B?L2lBZ2FJOWhiQXJ0RGtPT0FWbHlFaTRlamZSZnhWRkp2ZFV0NXZMbU1hcGJm?=
 =?utf-8?B?Ymd4eXJsbCt6ZkhvcENBNkg5VldrSHljdm9ILzdlcmdUcG05bDEvemFXdW9N?=
 =?utf-8?B?Q0RaRWxleStzbVIwT0NlMU1DSjBaWW1iZXk5M2RPSzVPdWdVeWQ4ZmFzRURx?=
 =?utf-8?B?YXpucUNMemdKRnExM0FaOHhkWWlUakhxSW1UU0lkSTJJN2xSUE1MSTBWY1J2?=
 =?utf-8?B?a1IvMVhFS0xXcVhDdWo2OWpUZkVYRjQxSFRRY0VCUCtDRVVwYmdGcXNqOThx?=
 =?utf-8?B?T2RvVk83REsvem5OZVJFMFpnaUloMmdYKzRXRERGaE9TTkRET3l5ZjRtcytF?=
 =?utf-8?B?cE9mRkthV0hkcDI1Nkl3cmlFdmdCaERtOE1XWGFwYmVUSVd6NTBrSG9hYmdw?=
 =?utf-8?B?RkhIQnNoaHdaL0x0WmhiNGlsL1I2Rm13WFk3OEhOM3RyMFhEdDFZcGdjcXIr?=
 =?utf-8?B?a2NPaHF3UXlTaTFoekZ3Nit6UFV6THlDRzRUcDhjNjlQd0JtMWpKOUhuSWZr?=
 =?utf-8?B?VzVoTEUxemFsbGxvSmQrZUUrNnpqbFN4cmpNcWdtcm50OExPMnd6Ym4xVDRU?=
 =?utf-8?B?L2NEZ1NnYmJqWmpPendIOUtjSXl6QnBCbEVSb0ZzTTdyNWhObEdKcXdxWGZy?=
 =?utf-8?B?UEN5aHBXZnh6em8xdGF6YjRCWlJEc3lTS1FDTzdWWVJEdVR2NVNNNWVweDBP?=
 =?utf-8?B?MTVTbG5EV0VvYU1ucVZBaEI2REtJSTRFY295ZjVZT0RJQmdDTmFhbEZJcDdj?=
 =?utf-8?B?RHZIck5PZDViY2t0a1ErRnJCcFdqMFZSNHNqcFBOUjZKT1VsU1ZjOUl2VURR?=
 =?utf-8?B?YXlwamREazhoQ1lGcTEzQnRYZ0duNkJwQXB1R1ZQZFZYQ2hYY0E2Wk5NQzdh?=
 =?utf-8?B?aVl3VFJITmN2N091N0dwbDZaTzg2TmkyamRyZFNMVTRtLytsRGE3S2h1SS9H?=
 =?utf-8?B?VnU3S0dVMHh0RmExQjk5Uk8xaXhvVVFydFhqc3k1MEdtdVBiY0V2QjlxYlgx?=
 =?utf-8?B?bDFaSXBzbWJVdmtNU2ZwaENTU1M3TnAvR3U2TVo4S1BuaVNmUW5sVlFvdEJ0?=
 =?utf-8?B?UjlvTkpNY2VkZmQ0c2wxc0srRDg5cFA1TWxYcHJXOUZpNXJTZ2dYM1RETmZO?=
 =?utf-8?B?aDJaLytIZVBRSjR3M0VzVDQ5RFFNc0k3R2QxbkI1a2JXR0dVV2E2M0hHMkpC?=
 =?utf-8?B?aHdMZ2hEUVBQa3pnREd4Q0RuOFpnUVI2V090NG1HUUFMbzdiZ3V5YmlPbjVr?=
 =?utf-8?B?RUlzb0QxUndPYjlWelRRa3ZFS2dMMGtRbnk0U1pncEJLcEZNeGFrQjFMZDdJ?=
 =?utf-8?B?S2xJWk1acjdoMzdBcUFlcnZoQjMzZ3VtWnorNHZldFZHWDh2YTNhLytzUWs0?=
 =?utf-8?B?MXVyMnI0TE1yQnhWNFI1MXN0OFVLUHFZWFNPVWc0aS9paDVyUG5mWWhIUDRW?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8cc598-fdf1-4152-fea2-08db7bb30c86
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 10:48:34.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EblS0cxbhA5g4oY4yxCUQ0Vtgprv1fRR2atPTXFs462fDlIuUib7n51oo6mYiPGA8a7cyXHK0tjPhTQRp6JoCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7480
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 10:48:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12178

On 30.06.23 13:34, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> ChallengeResponseAuthentication configuration is sshd_config is deprecated from
> bookworm, so modify the configuration setting based on its availability.
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  recipes-core/security-customizations/files/postinst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 recipes-core/security-customizations/files/postinst
> 
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> old mode 100644
> new mode 100755
> index d370345..4438776
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -82,5 +82,11 @@ if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
>  fi
>  echo "auth required pam_google_authenticator.so nullok" | tee -a "${SSHD_AUTH_CONFIG}"
>  # Enable PAM configuration for Remote Session
> -sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
> +if grep -s -q "ChallengeResponseAuthentication" "${SSHD_CONFIG}";then
> +       sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
> +fi
> +
> +if grep -s -q "KbdInteractiveAuthentication" "${SSHD_CONFIG}";then
> +       sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/g' "${SSHD_CONFIG}"
> +fi
>  echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CONFIG}"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


