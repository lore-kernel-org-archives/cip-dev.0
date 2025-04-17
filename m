Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D1C369B2
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 05:12:15 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.74])
 by mx.groups.io with SMTP id smtpd.web11.1935.1744866730717851904
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 22:12:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cijbibHB;
 spf=pass (domain: siemens.com, ip: 40.107.247.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgZAjJWSV6Fh9E13MPLj5gs9RcMP1QWgO6G4toEyibajrun4057lDGiV5jJXqQ5jjayruN1CMpIwkZlnyNNUSBjQZV58H4xg9WXn4ah+Dw1D1/35zf5NJCpZ234BoLfCOVl5tc1/FvFWivXjuvJBaCK2EY9irj9B8jDR6d5/Uzhpmjy9v3m9EjXFx/VPojI0biBSQY8glKLg3ZVC+8I7zDnYZvtG5lmKWABbMQa0iISszFjbRUU1SrwL9KELKBgoLDO6S5DNFLLjKiI4Mitvo8RZtyUyfhjnyWCp0mZXnknr/C5NiyJekpxU+LAobk0bPWqBFHOMv+oagPxe6IhBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMFb4m0ELG5iqfJQWdGP+tQSyM5EtMGgLIuBFhbF9rQ=;
 b=RbYoQKT+B2x1m7e8VLquei+Nlw7jIssXfHCFFSVqj4aUnRv9pEHYKdHmHlRgES2M5Df7rDlaqM8JlFaHAtkiWpq7m5UAt8zQtrmBlZ8c0t2qAYLagaISPhhAeeq+aFitew+DQ0vfZj4FqnnXQ0XTyHfCTs6ahQtU2mNc+vFF9HtC2YhBvPAaYLZNg6hyfrYWF4wCg6Hzz4OAM6hkDp6kQ1kEqu/0xW/iz02eTyiH6K00XNQ5kvRQ/ZZI900qAgaNkuMHfNEwxVfp+IrPnW2+cRU6YGx33FwC9/BAVFdmKo85QPWlPiQM41aUtENEc5AtOLfmUT6xs+AtVsbi/aQWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMFb4m0ELG5iqfJQWdGP+tQSyM5EtMGgLIuBFhbF9rQ=;
 b=cijbibHBMnN/BW9CqYY5XoHDawhMFJ3PGeA77EFSQd9CR8BxYPASXW82LwSkuPJPxwsb6+pgRCmBFyhVJsHvtwNmvKicvhV0CuXBRhkcJI0BJgfYuCUuHZWsqRZkB6oXhH1ZMvxKKJfo2MT7JLxeJyJNR/ZecNh4lQmlRFueaA/ukAbwfoFVX4SAio25+1cZjdV1QENI5Wt3WKglw3JuOpNR/qP0hqcARMDr7oikpFlU5vG44CUtF/NxtbOrDARZBC0qymYaP6jQsdjuIfL+C6NBpe0ZhaXaEOwJiEdVuMCtPZKjd4il4K1UEv7o6mi8MTVpUi6O0YhP3yK3WuXUsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Thu, 17 Apr
 2025 05:12:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 05:12:07 +0000
Message-ID: <d7ae5ea3-243e-4841-8f73-43941922376f@siemens.com>
Date: Thu, 17 Apr 2025 07:12:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v3 1/2] .gitlab-ci.yml: Set timeout
 value to run IEC layer tests for different targets.
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250416145141.2678093-1-Sai.Sathujoda@toshiba-tsip.com>
 <20681ac7-eff7-4eb7-a666-805607d99f82@siemens.com>
 <OSCPR01MB1483849AD6A77BF9A11D936CAC2BD2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSCPR01MB1483849AD6A77BF9A11D936CAC2BD2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: edc5979b-0b7e-4d0b-4540-08dd7d6e65db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dE9NYWY0VS8vNXpJMW5tTXV1STZuRnRPQXFYblJQUE9tSnUxelpCMGs5Rncx?=
 =?utf-8?B?aVphQ1dHWkRRSTJOR1c4VmdCSFhWUUVGdnBzdG9SUTRmTDUxWmwvNnlZVzQw?=
 =?utf-8?B?eVo2ZmhPWXdoU3NBei81V0dEYTl1UkRhbklWbXdVSHhpT0lFUjZYMWxnTUd5?=
 =?utf-8?B?b05VNDRrdU1ZK01mR0lRcm1OcUwzZFo3Z3YvRURFK01EMUliWGNxNVpEOXlm?=
 =?utf-8?B?cnhSeXNGMXpnL3JORm96bVBGeGRTRmFZWnF0NkMxbWo1SnZFa1Vnc0F5L0hr?=
 =?utf-8?B?SSt4elNhS2RDYUt6aWVuMWd2RXk2VG1jcENpdy9CaitpT3JCenpYVGJOYitD?=
 =?utf-8?B?OHNaaCt5Vk1SMEt0YUxWWHoxVzBpVDU4WldkRzg5bUR5eXJmVnZEajZkeW8w?=
 =?utf-8?B?U0hzdVRyWnRWczN0aXlUVW1BYWhXWUR0QWIzS0dNZVVzVXNkTFhaMlQ3MmJR?=
 =?utf-8?B?MWhNNW0rY2pSZjRSMENBQlJPSEtrSXM4YWVNVzE1V0pzVWdoY1IyV2U5Yzcz?=
 =?utf-8?B?QUlqRmF6OFF3ZGZNU01yL3J6NkNxR3ZGWVZKMkVFNk44SGVjYWsycEYrRlRs?=
 =?utf-8?B?ZWRvM3VieVFidEZPVGZNV25PVXo5WGxqYUoyOGhuYUxFVXB4SmhQdUk0MkpI?=
 =?utf-8?B?Z2svUTR1QVh3Y1BmMVVWeU1QdGdmS1Baa2F5VmFlYkp4NllUL29ieWsyOTRH?=
 =?utf-8?B?Wi95OFRSUktrcTJNaVpnRlp3d2YyeHh1Qm5zemw2T08yVGg1WmtSdEMxR1pU?=
 =?utf-8?B?WEpuUHF0aWd2Vkh2SEVyWGJnZTAvdjFWQVhPVldBbjFYbkdBNEgzVno5VjB3?=
 =?utf-8?B?aG1KVFNZeFc2R3lkVXRJUXJIbHIzVm9PMmd3bkFZWEZ4V3M0RnVkcHpDU1RU?=
 =?utf-8?B?cWtzWE5vVFEzNEllRUxIV2tCckFkZ2pkbkZxS1ZySTVUaVBRTUxjeXlueFo2?=
 =?utf-8?B?R1ZhejRsMFBHbzlFdmsvZVRPUTZONGE5dnVqT1RrSnRJeElXd3VHUU1VYnBB?=
 =?utf-8?B?VWlleVdyVFR0Rm0wWDlYdkhWc3dXV2JSeklEUXNLdmQ3ek5lWU9ndFRnVmtm?=
 =?utf-8?B?cGttSkRnT0diQ0swejE1TlRyNGxyYVkybmk3eS9QcWExb1ZqSUU2NW8zNlMz?=
 =?utf-8?B?dDdqcjRGQTBXeC9zSHl3Zy93U0dncndjQVZuOHBQYzhxcTBDOE0ycDQrTzND?=
 =?utf-8?B?b0hqSHYwVGNWS3pSeGZHU053bTZWaVJIb3dWSHFjMEtZS2ZGR3dOY2hlcVdm?=
 =?utf-8?B?SDdtKzdKaEJjTngxLzk5blozWm0yRndvRVA5OVhzOWJNR01CanFieWpkOGhQ?=
 =?utf-8?B?aW5TMG5tSmx4ZzRJc29VUE51YzBWMmRvN2FGSk5LcVd3Nlp3YldUZnN6eTlW?=
 =?utf-8?B?ZWxnQnBKOGNOZlZSWjJ1V0pZOFg3aHdjMXMwOWtpM1luYTlacjlDV2k2WXQr?=
 =?utf-8?B?UzNvRFFSVWV2c3BRRU81MW9pSE5OZm1nOUJKU3V2NnlmZGRFeU1YM09LU29S?=
 =?utf-8?B?dFl4eUpFRHlyODQ1eDYvY0RBUXRlMU83QkUyWVhHQ2J4ZDRBekNoS3RwVFp5?=
 =?utf-8?B?Wmc2bkZBN0ZZdzRqQ3hjc0htc0d5aENCazZ0ODhBMFlJRlBUY2tIOTVUT1ZM?=
 =?utf-8?B?OXB4QmlSOFh2N2ViTWRTNFJPa0xPSkk0d1dCLzhaQlluVDlrMGVsaFhZY0Na?=
 =?utf-8?B?bWkrM05qaFZiMUJPTGVxa3oxQ1RaeWhlQjg5eWpEZlUwd0d5V1dRYTBXTmdP?=
 =?utf-8?B?aU1yRjZ2aWdhdHpTcWxNUUEwOFV0cTBLMFpNdzEydTBXTUxPWlJOZVB6ZjBi?=
 =?utf-8?B?cEFabXpyZW1vZWNEd0FPWVpYUms4d0FoOTVlc2RMZW5tV0c2MXFDMWQraCtE?=
 =?utf-8?B?QWI1bkw0WHpOU3VJSTB2Uzg1dTkyV0pqUGgvVTJLRi9LUllLY0JtdldnNlhQ?=
 =?utf-8?Q?r3b/pM0YYI0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2ppVlVLS0EzekRENzlOa3ZZYWx4bjFkSmtkdjRxeHJ4bWkyaVFMc1J3UVQz?=
 =?utf-8?B?ZnlMcVBnTWUvUXN2VFJYYy9mZ0RhZDBTMUQzZ3lhaTZkelp3RjN1bDZxRmIv?=
 =?utf-8?B?QlMzZ1l0TnZVeTFxeFJRNkJ0eXpVUmk4d0hyWDBUTDhGV3ZESDU1MnFRS0g3?=
 =?utf-8?B?OStXT04vNlUwTTNMNWZYWHFNWjltY296OEJxR01jeVAzeTFIWUQrb2Qyd3ls?=
 =?utf-8?B?bGNhQWdPTHVPVTdnUWVkS1RldFBXYmpMMTJFQU45V3ZGY2NyN3QvYXJiQnYr?=
 =?utf-8?B?Y1d6ZzFWdERQeHhjYlR1bEFUVzg5aW03bTkrZnVTbys3WC94SE1aaTNBbEhn?=
 =?utf-8?B?WS9waDROb2RzdDlmRFVQdmtoQ242cGJycnJlZWZpOWU1bzdmaXlwNG1scFJB?=
 =?utf-8?B?aWVFSEtrUFdPeXpRS3FVcmxOV1BzRUJ6VUd2VVE2MW8rT2ZhdWk5VE4vSVFB?=
 =?utf-8?B?L2ppMlhqN1ZKTm4vRVR3SHc1TDhjSzBFMkdOSUo3bWpvLzUvUCtSMkc2MjhE?=
 =?utf-8?B?U0VyTnRIbHVXSzZPbXBFZjVUeTVTUFZEbVlUTGJpR0h0ZUNZbkdZeHJSTGdI?=
 =?utf-8?B?T2kwWmk1R3p2QU95ejRqdXhLVEx1U3JSNDJQVmdueTkzdFdQY0s2VW11WmZG?=
 =?utf-8?B?MCtqUzgyMmdBbjdEMmZOWVcya3JRQ2VBNks2a2FUQVZCZm0xb1d2TTAreHlX?=
 =?utf-8?B?RDVVdDBBRDZ2SFZTL2tYME1TUXhwNlBZSnppU1pvS01ONU9Ta0NlQmlsM0xv?=
 =?utf-8?B?TUt1UnFPaml0R1BZaFQvMndrTjgzaVUrZnpqT3dPTktrdnZ1NEszWTVwUmtm?=
 =?utf-8?B?VGtEWFBSbVAreis0TG5VL25jcDNtdGFhdnBmZzhpeUlsZHk3TDd2WFp3YjJl?=
 =?utf-8?B?b3dheHJyRlRWbk5PNnNGYzlydE9neGd6UzZ6TmhndVlBY20xejk1M2VPV0pN?=
 =?utf-8?B?YXpWL083QnBqeml6TWl5YXFvRVdCbGNtM2VIcTh3eGtYcE5yWng2Qm16L1hp?=
 =?utf-8?B?dVRsRzJjSzNGUXlzdjQwV2FoU0Jra3g5Y01XeERRR256SXJDMnpGb0xpaEFV?=
 =?utf-8?B?d1FsMnBtQ09BY2N2WUs1V1ZybmRQR1RMWlJ2R0FVR0lPRkVGMXhUR3hETDJm?=
 =?utf-8?B?ZEprUUMzZnNzcElSYlYvZGF0c3FvWGlvVVl4OHQ5dmQybmk5ZFIxTFVTYUpR?=
 =?utf-8?B?UTNUcnF4STRNSWdycCtYUG9nTE1xMDJTV0lKdG9oM2FwaE1MWnhkbjJldVUw?=
 =?utf-8?B?YzczT1JPRTk4a1cwUzlVRmdkS08rSjNnRThhck54bHNJZ00yVTc2Yjcva29X?=
 =?utf-8?B?T09pdVIvNzB4T0d3YmtITVVsSHpSMkwyQVduRXhHWkxWZEZCVFZ4YW9yVnhj?=
 =?utf-8?B?MzF0NW9tcWJZRkx4UXoreDJoRVdnZW9HYzFBZlV2VDhWcDczaXk3V0dCemFC?=
 =?utf-8?B?QVErSXErdnJteFJ1b2xSajY0MExaV1FFS2JFZjR4N1lDYm1XVVB3V0lyaGs3?=
 =?utf-8?B?NG03TlpoSGpMUU1EN09aOEY3d25hNXdnN0h3VEE4dkt1OU1Ha1loZEpQZlhl?=
 =?utf-8?B?MTNsUnpnWDZoYXJGcUx5amlVK2krMlh3K2lLTndvNDVsTThOdVFwdi80QVE5?=
 =?utf-8?B?bW5OVmY0ZEx1MklqQzFrRDhjTnZCdTZra2F4cDZJWHVJeVpUZE1GRklpVzBl?=
 =?utf-8?B?SjlnK2R0U2JZbC9uV0NQTDduRm9NMk1ZL2FGMldkWmRzdTR2N0ZlWXJPanlq?=
 =?utf-8?B?R3N2RHgwRmttbzl1M05GeTU1MFdzbHdUL2FYYm0ySDZHenZIclpweVBRUGFt?=
 =?utf-8?B?K0tTRVlPRHlzMzdiVE80SEM4ekl1bHp5bms5d1Rtd0dmOXZmODRtTVRUcU5u?=
 =?utf-8?B?Wm5mVzIwa2xlNFhkY1J6SWgzNTVtVm9tU3pyR2FpNzduaG1mTkN6WGhBakFq?=
 =?utf-8?B?RUdxMTI0ejFFS2lCLzdJdXhwSHZJNXl1QVZFbHpkTy9rVlJrN1l0Zm5RZGw2?=
 =?utf-8?B?U0RsSEpYcnJRZnNEU29GUWZadVdXMHdxcnBBYWRMUU8yY2YwY1prMTVCY1dZ?=
 =?utf-8?B?bFI4N3lhbXh2OUtkanFnVnlCdnR4TWFGMXNWVGpSSkt3VmhDMVg1TnRIT1Q1?=
 =?utf-8?Q?xeYXG7sczgNQkqcPtTuaMq9YA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc5979b-0b7e-4d0b-4540-08dd7d6e65db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 05:12:06.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kO6/1Ey1LBHDQLo9pj1VVpotG4S99jIWq0naEMAx0b1XD1k0BZMmWrNOvhA0ZMX2/eEjazGIzZnOWw6keGB0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5943
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 05:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18516

On 16.04.25 18:58, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
> 
>>> Can't we avoid this duplication? How about running envsubst
>>> unconditionally on the final yml, just like xenomai-images does? That
>>> will allow us to use this pattern not only for the IEC cases.
> 
> The timeout of 40 minutes and 60 minutes is only applicable for IEC
> tests on QEMU and M-COM x86. For swupdate, secureboot related test cases
> that amount of time is not required.

I was not only referring to a timeout as potential use case for
variables in the templates.

> 
> That is why I added envsubst is qemu and m-com job creation methods
> separately. But as you suggested to reduce handling various timeout
> values, we can set 60 minutes timeout to all the test jobs (IEC,
> swupdate) and we can just run envsubst directly on the final yaml as you
> said. Please confirm if you are OK with this. Then I will update and
> send v4. I will also include exporting timeout value only once when
> submit_lava.sh script received the value from .gitlab-ci.yml in v4.

Please move envsubst to central place an run it only once. It will do no
harm if a template has no vars to substitute.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

