Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B76FC3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 11:32:09 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.55])
 by mx.groups.io with SMTP id smtpd.web10.47667.1743075126766436705
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 04:32:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yma+JQdA;
 spf=pass (domain: siemens.com, ip: 40.107.22.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crG6XZsjvAc2Qt79vL3RZ/AvGQxEOFeXFp4D1rcGmc6g9mUQblWd29gIp0ort5AqRjAhQK2iMeXYhLyuz0Y4FEZTbjfEl72D678UGcgtu382GWvqYDDzvNPQHDYooI5/jAstVBvOflPjLky1jOWiyzLYm234U066umvjNCI+8O4dmO7PlaHJljXAyjMfOWZXeDIC28603V3rb3hpLMRv2LEQ++nDmjS98bKP+R0pbZAzsO5f4WIK/n0oQel/0PNDXFDdXNEYY+qMq+TQyigo9I5b8DCnDQZzUAeVX2ioHEw4sUKV5E0dbHefVtiEPeS24eSin4mVBYhOcVuplDIumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCaRiayI0jwtEFsihd31qnm3ERnUt56LLwue2vhOogc=;
 b=ATzAoNq7sWcgbbVBaSEz2+dBUdjuN9lF517jP70m3hF1jgEY/bTTShFYlN+U6vCMcLxuo9IqgC2y8aB4nao9LMm7RM/YFs/FGd9iJR9aCCP3gqGiRCmAc9U+jU96Y7YrZS422Vni8Uhmw9bAVkdIFRpzkZO3h5ntdzc+iO9phrSTne+XrgnznVOrDFu7JPV1cFCmVEx4UOB2NbGIE56x+Cu8DgjKjG/0fNYJvlOReXUxPbrzcXJZdTGPZdmDUAx0dk36jHfwublM5hZX9m8z4OowuIBsXayMJ3jkVzkFZPpXzC+xexSGjJkognNbNiiUN2s7ugzk7Ls2PLL3ws9SUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCaRiayI0jwtEFsihd31qnm3ERnUt56LLwue2vhOogc=;
 b=yma+JQdAzRY2QNQbGXH7fggI1diNjTYUsAroH/jqAaFynWuGooP8mYVfgjuVAtylPXqXvog2tsP/HSu7wY7j2/s9pUdsSQZtGpTDHO48C/Kekc7ey0R2DeX93MO+wFyKCf+or8794zqkrtjzDJoQDUWOOvW3q89cASJhu3N6M2/SsL5NIWJdltN1sTntsbqbeZx8RycvtkEVfHmhheYlMnV/Q4Fj6RjKf38PO0C4cAfVM8g0s1YXvg8wTVeYzPjbYN9IaMq52BAwxK1TE5YT9nazD1H4VxlEqM9uNYYGiM6U0V3OpRyG/sGh6iB1b3ljFRyJCjG88oenmNKlCzYgTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6253.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:32:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:32:03 +0000
Message-ID: <f04f10cb-7df9-4308-9cd1-b77e6bb6ce7b@siemens.com>
Date: Thu, 27 Mar 2025 12:32:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] IEC_template.yml: Update IEC tests to latest
 revision
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250327093358.3419546-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250327093358.3419546-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf49d11-b076-40ab-aef8-08dd6d22fead
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cElJa2NjTDhnUks5RTU4T1R4QWs3c1NZVVFLUmlHNGpNZW5BUlNBTzczS1M2?=
 =?utf-8?B?Q25MYitPa2tmM2FrRjAwenJENnJtZkNvN085T2I3VGV0U3NqMWdRcENkek1q?=
 =?utf-8?B?eGRoZ1B6dk8ybXJ5N09aT0ZSbUQ3cUlVUVlMWk5OV240UmpVdmNYbWdhd1lX?=
 =?utf-8?B?cmFJTG5jMDg0RHBIYUh6NkFOYmNrbTYyNnJ4V2lGK1RJdWx5NU5xK2pQN3VY?=
 =?utf-8?B?akVKc0k2bWlpZWUwc28rNjBtc01uWlcvVjdmMWpYcEhzSmRoczM1elA5azcz?=
 =?utf-8?B?aFVWbmM4NDdlazFlbEpCSE5hdnZLVlcxNEp2RUVla3BFV2Zyb1hxUkNDaUJr?=
 =?utf-8?B?c0dSbTVhR3VYbzQra1V2WDB3SFo2bzhlTTgyZk9QWFBJSWk0d3pQWU4ycDdC?=
 =?utf-8?B?RXh1NlRQcVlaYTR5K3BDMEVGcnhqUngzOUhBS0ZwWGgwUUJQZmxEbVd3KzdY?=
 =?utf-8?B?SU9MbEljcjYyUVNQMWV2VnpvZ3g3SkhjRi81cTlnSmZQdVgzUG9jVDNUSzIr?=
 =?utf-8?B?dmp5aUF6OWI0Mk9wbEFodDBIZW8yWG1EUnpweEEvSlRyajFUTWxoN291TjFE?=
 =?utf-8?B?OEQyK0hvbUJIQmxQWWYyVGhTd1BGb3FQQlg5VW5HKzdyUXQ5a1ZkNEU2OGFG?=
 =?utf-8?B?UFh0eW9GcHFJWU5EM0dLMmVBcGE0eCswRFJQT2MxSi95bG9TbU1zcWpKN2Ra?=
 =?utf-8?B?dEVQRVRQVEJzdUMrUytoaHZsd1VYMitsRFJwVENLMGtlc2p0TzZVeUNMVWJz?=
 =?utf-8?B?RmJRKzBMQzZ1aSt0U1hoZEFyakxSclNiU0VIYmJoZ05UclRYeVl5VzdPNFBh?=
 =?utf-8?B?eEtydDc1M2hDWHpxNlExbU0wTDlSeWtDdTRKQzlValRPYlZnTXhUUFlpdFAz?=
 =?utf-8?B?NUdSMnhNSG9XRlBVOFVyYi9SamhUYXFBRlZBeVQyNEtoc0pkUE9jUWFINzhX?=
 =?utf-8?B?YjZreFhRY0FjSWVhQis3OTRacTBtc1VpT2hWWW9kVUI1V3d2aU5GaC8wTktB?=
 =?utf-8?B?Qy9GSlFoQStnRG80cDlVbE5SZ2Z0TmtsTys4Z1JvUklvU24xMWNDOS9kdWlr?=
 =?utf-8?B?cVc0QXd4ZWdxb2czcGxDWHEydzBNR2UxRHBGeUhwNkdsM0tPRTVnaU51NXdW?=
 =?utf-8?B?NnpnejY2OGxrWm9IQ1ZmWVZ1TWJ6N2Jhb1RwdVkzL3pacGNpOVY5RzhvYXZr?=
 =?utf-8?B?T252QVloOGVQZ3l4ZWFCV21tR2FyckJWQWdudXdxb3VOSDgyaFMzbzg0WDVs?=
 =?utf-8?B?ZlpGMC9YSU80WG9WTVdoR3BycTY3TFZXQytqajEzMk85cCtCZ3hMMnlDcksv?=
 =?utf-8?B?d3YzM3h6YVhQR2RXMStoazFacWRoZFlxNTBJYkI5V1ZWdENLODlya1Q2WTR0?=
 =?utf-8?B?enJjdDV2Qk5vcEJFc3pDZXkvWGREbWtXaGZZZDJlTzBNSkdsUnU5Wlcrc1Rv?=
 =?utf-8?B?TitkcXpDTXNLSGhuTmdhVkZ2UnptcnFoSGxIYTZONlpNbnYxTnBWVUdWR0ov?=
 =?utf-8?B?ZmFMY3NlQkc0VmJEeDNXblRmYTQ1WkZiQ01id3pTVUVHRU9LWVIrUDNZZTlW?=
 =?utf-8?B?QzZkWjZZWGJWRnhiV0VmT0c1M1ovcVR0cXZxOXY2eUx6a1BaeHZlRUZLUEh4?=
 =?utf-8?B?SHdReU9FTTlwYVE0ZHo2SXhENi9jbFNTVW4ya1JNdGYrM0dMdGRYY1A1dnYx?=
 =?utf-8?B?L0JweG1aRUxoV1NCMG1sTFR3UERMY2VOUU9VVk1LZkdYN3VPMkZ0T09sL1VB?=
 =?utf-8?B?Rmp6SGZVa1d3dDRMQXBVcHRSdThBTk45U0IyT2QxblJ5Z216WnJkMitaNXpS?=
 =?utf-8?B?Ykl2UWFHa3JGSFBQV1RlQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWlDUDdaOXJTRDN6YktPNjdXeGNSeG5ML1E0TE81eVJUS1NtR1ZPa0xBWmN6?=
 =?utf-8?B?bFFFT2NHelkyc2pPVTRPMXc1M0lRTkUwSXlIVGRkZGlpeFFMVXRKTW56Vkph?=
 =?utf-8?B?WnJPdGRhSFM3eHYyOWxXY2daSmdHTGRNSjdQbWFqM1p2SWh3d3ZsQjIwMGho?=
 =?utf-8?B?RHRvVzRVU1FUSjBhWVYyRUpVZHgyamxhbWVFVVBUUDJ2a1lwUEVYUzFPSjVW?=
 =?utf-8?B?NldscCtVdWxlOFpyMDN2QnhZUlhxOER3WHNjbEdhdStWbXVLUytzYm5tc2J3?=
 =?utf-8?B?SjhDOHhLUGZrTEVvTjNURGx3eEtIQzRobm5jaitkNmZGU1FSMzJDS0hzUExj?=
 =?utf-8?B?L2lVRW1nekJoUHZNSlpPK1drOEJYczYwSTBCZE1kMGJFSkZURnFQVUUwTUNj?=
 =?utf-8?B?N0Fld3k1TGVKVDNxeDJaakhkbmRHRFk5K0FZMDZKejUzQ3VpTUo3TERoWHpV?=
 =?utf-8?B?RWcvUUw1SE9RR0dDWjdUdjdCU0lYcmhlTVhETW1HSHpHRlBhV0hKbHROTThT?=
 =?utf-8?B?d1MvTFFWMnprOHFkWTA2aW1PMHVzbHZxTXcxaHBkakMvTExsbHpCY0xadm55?=
 =?utf-8?B?c05vZVRtUXlrcG5BSnZseFl5QVNiZkZaM3NoeVhhOGh4TzJqUHhaSDJtNGw5?=
 =?utf-8?B?eStJcmc2ZEk0aHpGOU9qaS90elJJOUJXMVNsNVBtOGs0U2FIN0lZSkZrbzNn?=
 =?utf-8?B?TVQ1a1lxRDZIZjVhWkYwZGR2cjRkcG5xSTV1cVFOby91YmsvVjlUYjNCLy9X?=
 =?utf-8?B?aW5yVU5mRjZlb25mYnRwRUlPdWs2eE5rcXJ1MlJGSUVlU0tCMndsdE1VMmJB?=
 =?utf-8?B?M0RmZlZ0U0Fsb2Q5UHNtdUFRNXFjQ0wxN3MyMzd3bWRHMDJOMGp6RW9idWJK?=
 =?utf-8?B?dk9SeElwSGNLQjFjWmt0Tkp3T3R4cDJjZERGYkswSU1zRmRkME9DdDBlMnVy?=
 =?utf-8?B?ekN6cmFhUUd1aSthN0lHSDRIbXdFU3lBYVhMalVHWFA3bGVGMFBabVlqekdC?=
 =?utf-8?B?WmRKUElZSGlNa3BGTmxxbFR3SHJaWXhOcnUyTmtkZ3M1Q0ZHNlRRb2xHSGRL?=
 =?utf-8?B?Tkc1eUxvNHM5SEQzZDlRWkR0MDFRejk4cURvdzllMEN5NktIUCt4NjMzRWVw?=
 =?utf-8?B?bDkxWHpBNHp0ajdUbGROSmI5QnZZYVhvQS9CU1NsclRpN0NPYVJOSmdSMVZt?=
 =?utf-8?B?ZkQ0dHlnU0RTRU5RL1JBME9DeFo4TEYwR3BmejdvMW1raXNuMlI3NzhVVmsx?=
 =?utf-8?B?d3pnai9EMzBnL2dQZWN0eVhaRDhTL2psMnUrMlgyYkdEdWhwRXFickN6N3JL?=
 =?utf-8?B?YVlQMEJ1eVBUMjArV2s1cWQ3aVQrU0RSeHFWZzJDS0FkRGt5NTlweWc2ZzhH?=
 =?utf-8?B?RkQrekNZeWN6YXJBUVZCbml6R0tPUUxxcEN4dW94dzE1VStPYWFicXVUc01Q?=
 =?utf-8?B?UXBMdU1nbXN3RTVMQjhXN1NqR1pPM25LSzFuQTV4QVBuMzZReUpDKzZmNUZo?=
 =?utf-8?B?M2lPSkpHSVRqQWxuZ3lrL21jZzhDUFVFelpVT3dCeHk4SkJPcnduQngzYm13?=
 =?utf-8?B?MndaOHNvOTEzWTBVV0JxRXdDOVdJK3dUczZiRzlZNnZIeGhYekxYWlpHeFcr?=
 =?utf-8?B?ZDlBSHo1WVZTRmROK2tZdG1zKzg2ZENUVVE2RXFxOVMyZWt0TkhXL0d3TlAr?=
 =?utf-8?B?eGZDS0FpS0ZNaHJLVW92WkFCK1psR3JmYWtSaytqalIrbmU4d0tDNFpkajZa?=
 =?utf-8?B?b24vOVl1UjhESkRuY3hyOHB2Tm93ekdaMitrbzlTU1pTelpsSHBlU3lkVUwz?=
 =?utf-8?B?dGh3MXIzanlmZFc2Vys4SUtYV2xLVUVuSHF3QXptRTJyOXhMdU9PRS9OQ0xW?=
 =?utf-8?B?NGFLZVdTWmR2TU5IWnVBYmlUblRPZmg5b1gwRTJUcXNuaDFPNk5vSDJVOHZZ?=
 =?utf-8?B?Q2FQL0xvUUxOOGZhMHVwcWczWkRIWmViZDhQTnJrYi9BRHZRcmcvMmxhWW83?=
 =?utf-8?B?SjZ1R0JaV1pJdzFialVFL3lsQ1pSUi90QmxnZUdCSFozSnpyOWFtTURUeUhG?=
 =?utf-8?B?ZGM0UGxxT3lhVEZmQmpvYmJSRHlpL3VoOHJuS3ViVEJKY2xEWUFJZWU4OGc1?=
 =?utf-8?B?eVRMZXVzdjFiTkFML2RNUjI2MXpGeTU5WUZDMnoxaURQMUtVd0NFVjBUSjNG?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf49d11-b076-40ab-aef8-08dd6d22fead
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 11:32:03.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BF00eO0b9NXv1UcbfwLU1oMHrfArHNfbaPneMyS0dCoylOTjKZR5wMDEQ3TBjMZsoAq8xeZTN1jJ478Y/kJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6253
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 11:32:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18376

On 27.03.25 10:33, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Major changes in this revision update:
> 
> 1. Skip TC_CR2.7_1 until it is redesigned to remove dependencies on static time delays.
> 2. Improve tests to include testing of new IEC-62443-4-2 sub-requirements.
> 3. Fail the job if any failed test cases are found in final summary.
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  tests/templates/IEC_template.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
> index 3c33773..92944da 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -64,7 +64,7 @@ actions:
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
>         from: git
> -       revision: 064a92b98127b0001ca527a83b175521bea4b626
> +       revision: 5dbc47f55d4a43449dcbde4363e5d23d6e96344f
>         path: iec-security-tests/Singlenode-TestDefinition.yaml
>         name: Security-Testcases
>  

Thanks, applied. Let's watch the pipeline:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1738025966
:)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

