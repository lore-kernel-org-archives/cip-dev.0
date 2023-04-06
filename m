Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CDBC7618D
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 14:41:45 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.82])
 by mx.groups.io with SMTP id smtpd.web11.160099.1680792104242560992
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Apr 2023 07:41:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=S0ZhTBh8;
 spf=pass (domain: siemens.com, ip: 40.107.13.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcg+1HHsKT5Ql2PAW4ZX0dFqbGFK11vOww8/ZmT+8esR3rXvwf3t9vvrrWBy9IOyW7R8Nr9EFcvpS69+8cZ+LHECY7fk13XpnGh+cmWaOBhiFiLxiir+xgml78hK+xmSpwkxWBmZobqTnC2gnue8jAR3npkKF09kUlAEQ9kV6alJvM7+U8CIAKX07ZLXEEss8l4JQOlTdT3RbeXorhaG4/7OTmmDT4cvoOtfW2WxkxoBc6Awj/0XIS3VvGByBq62EnPKmUUZlbOZPLJHIULKuO4fXhjwCE8ORhmVDw0aygx7q+BTJlTnuI7wgt3dVoZbu+szxjVS1f9M45npL5ACTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec7DLQ6A6K6F7yRu7Z+77R+wtKHZ8MCY3hNo7etmId0=;
 b=inn+4e1bIKgMhWqCnVKaoVCHWFmv0NubZ5wFRj6BOwMfqdqAiX6w+8m6wDBydPFkK62e95YszjgLvJAFCckgFVW1gUGgwj3GEAUka772VwOUXBcSdvydIQWD9PIGfLRp69DqlsB3AAJ0h61l6GREmGGU6JPr/tuCQkbf2DSq/6MXVdSAfiABYI0UJuKGdFfpUMAqukEsAIWTpKBj2CIcySa6GGKOYfkz7dmzl5SJ3T1dO9oX2yHAsyaadyk2nAPevB3xjh2ZJWPF18squWFQQChPID2Ox+2cM/P7mncL4aRqvQkKpoJqJ7uA4bezNqnlOoNpHVnQVZ/BAcuY8Nz2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec7DLQ6A6K6F7yRu7Z+77R+wtKHZ8MCY3hNo7etmId0=;
 b=S0ZhTBh8AHTFLwuiFJTIYfrcSAJoT/z/yxLfevMHMldfJTQx7ltGJo2vfiQLBYKk7nzFP2zvgMdhjZ3lx9I4J6OHHXDe3j+DeFDGIaBJmq1jB3lXsvwaX38uMcvSD/NF81Z/3votS0UIhj74XscAot7Ac99ERug4tEISoQpqXXd6HoCW7qkbdN3PFffXgVr0e5/xIcnhjL/5rJ22VAL/29bUBuozXGgs4CvetbTXfrW4NFFzacrHI0y/tLlApmVqzFfHD01vXGUdQq1ldyCrxSpJKRkuBH/suJhVKp5ytYVbsz6rWQ3uaszDR02bUrzKPYMZkoTo8sel/kU7Nd1wjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.14; Thu, 6 Apr
 2023 14:41:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6298.014; Thu, 6 Apr 2023
 14:41:40 +0000
Message-ID: <d2f8d9e1-65ff-d50f-7eb7-d725f5a1f52b@siemens.com>
Date: Thu, 6 Apr 2023 16:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: isar-cip-core distribution versions
Content-Language: en-US
To: Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 cip-dev@lists.cip-project.org
References: <CANgtXuPOyqXGzeoFMRTyQ63zFrFJL8nDc=DE+JEJ2E3ARF_3GQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CANgtXuPOyqXGzeoFMRTyQ63zFrFJL8nDc=DE+JEJ2E3ARF_3GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:610:4d::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3135:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c1eb7a-33d9-433a-ea12-08db36ad0882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1sAg9bl0JXxrT3ypQjZpIt1FR9kS8+IeSbOX2qkiFlH0rVg8snCdlrRpJ7MMYqH/mnOQ22ElXnLTqyELz76zo+4U90fpUQ7dKMCCBg2CAf9Qaiy59Rq1o/v8jPAM/NB6VmuDJ20ybh2kB6vevAZ4/N970Nq2JemBpVn+19GPXz/NxEyLWhyhUeF3gRwN55S8fVQiNbWWTer08lKPRRRSvONxTOgYJ6KYHBj7PhjEE7ZAphB0SZP0oyfxWfsJcK6vYaifp5mZfF/mW9nKdUk8flQhCMgkR1Dr4sNLxMmyH6cSU85GhJjTfcRR3XcWqp5L8pgkPPGltwQMmVv8T6jkiWrPIL6rdvWiNkz3A6QGbom733KSCyZQC7VYOMH6eDCB6sH3NYiKUjhUt0JhR+wHCl4AhtQOdRJgM7TVGttnn/IA5Bb4gMCHq2w9jKeLEbxka7wC5BW+Hi7GcA5zbvUwPJ+OHMLRb2EW9eEjIZY7V9mkaSgxM+Ae7D/5l/sCpPFGj+1Zls0M/GnXI8r+UwB2UyQajIJFLO5tyMJCNKUck8bNsjz5xWVNv+rf+7E6mpe+CAKzxcbxD+P6x5IPbkF7nNs+RP4h0wKZ0EgA7eQkdfB7xuClgYE+2YuUw3lYKXYyQZMIm+Il16XquaimCGukDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(478600001)(6486002)(6666004)(316002)(26005)(6512007)(6506007)(186003)(53546011)(966005)(2906002)(4744005)(44832011)(5660300002)(66476007)(66946007)(41300700001)(66556008)(8676002)(8936002)(82960400001)(38100700002)(86362001)(36756003)(31696002)(83380400001)(2616005)(3480700007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjNPMFhmQk9idDNCdlVkWjh3TlkvWGNabHlyWThwK3RpWEg5NEs4VEdoYWUw?=
 =?utf-8?B?L2dkWFNLaUF6MS9hVG9JQm9sSmpmaGRjTmkvYUlpRjJIOFlkTGtNc2ppVlVm?=
 =?utf-8?B?dG55MzBvZ3FDUlI1UnQyZ2RpWDJqdG1kYW5qQVlQVUlKUUh3ZVd0THRYR1Ix?=
 =?utf-8?B?R0FqdXpvY3hyQ2NCRG8waWYyQ0pRMUpNcGEvUlNTUXJaSytFOVBWUEczVktz?=
 =?utf-8?B?ejlCeGpPWFhxMTRaYmlxRGd5NFNTNXlDejA5RnVNTGh2RjhmUUFIN3ppc0ha?=
 =?utf-8?B?c3oveHg4VGpwSlVpaFUrQ0VlOXlDR0ttdXEySEhZaWVXdlNPNGhGQkRmcXgy?=
 =?utf-8?B?ZHZ2TTI5ZGFPSldnRFFSejZqc2x0ZnZnMTNabFlsMW1xT2d1SldlcnNQYWJD?=
 =?utf-8?B?Nk0xOE1sdXRRK0psTHJtSWM3MElRcUQvbXg0Ym9tUjdFdjVJUHFrZkliVHNu?=
 =?utf-8?B?aExMdElEd2lSd0M0eE9jZ0lOckJDUjlNUnlEZzFkY1l5TUFwUExXeTFUaCtj?=
 =?utf-8?B?TkZrd2twQjdWYW1PZzFXT2tuZVRZMEtoR29rVEJKMFlZN2tKWU15a2xwQnJV?=
 =?utf-8?B?L1hRejZZVVE5b3RwTkJ0andlci9uWE9jVFY1ekdVQnlVR3JtdnR4MVF1OHdq?=
 =?utf-8?B?MWJ0b1FUd2dRNnAyRkljWFkzTE5kRkIrOW1TV3BUU1U3cFNleUE5ZUVRbDhz?=
 =?utf-8?B?TnFPdXJ2aEtsR0dqTElyelE3MHk2N1V5ZUdXNm9xVFFma0xLNXNEMG00YWJI?=
 =?utf-8?B?dnNQVnNrUE9IRnlCNVBxaklhbUliUS9hY2h3QWNUTjhMMGs2anNTSTM4aDdF?=
 =?utf-8?B?RFh4QjJ5a2hIcW9PS1BneUxOUjVzelF6VmpOQXcyMEY2Zi9wR3czek5yRGh1?=
 =?utf-8?B?cDFzNTRsbUlGNDNtcDBCcTV6VnU3a0MyVWZpTzF1N1ZwS3RXZHdqTFV1VjN5?=
 =?utf-8?B?NzBNSHF1dTFrUXhiR0dpTThrMXVZczg2U0lQYVN6c1FlZEdvZnlsbzltN0JT?=
 =?utf-8?B?SGJDblBDNHJQem9mLzhOTkZULzIydmI1aHBnQUE0WStZNHBrUnN4WWNGV3VT?=
 =?utf-8?B?NmtxVjYxYjhtdEtDMjluWk0rTGhhZVQzTGZyemRGSytSS1RvSDVHN0ZEV2dV?=
 =?utf-8?B?c0JzOUN1T1JSZW1FR1lqUWNZL0dBQU5zRTJTV3lQdE40bUNBbVR6R0NYUW5T?=
 =?utf-8?B?Qy9KUE1udFFjTS8veHRTNVVISTFyT0xXdVYyR2tUdlBER3ZYUnI0cG9tSXgy?=
 =?utf-8?B?RnVEdHJaUVJwWVZlS00xN1pzUXVxc2hHMmxhZDlLU2g0UURKcnVOR0VvY0hN?=
 =?utf-8?B?OGdWTlNERjU1QXZBTlBLWXh3U3pLeC9VL2VCYXhmTUl0eUtyblpUZzdrWmY2?=
 =?utf-8?B?OWtCRE9GZm5naVhib294WmtZb2NiRkNKUFRWNEdYcHY3NDFPb2hVcmxoN1RH?=
 =?utf-8?B?SkphSVd0SUE2TjhPM2ZhTE5ISUlYNjd6SWVOd1hVMFhKTUtYWjhacFRUQ3dh?=
 =?utf-8?B?ODBLYkkxTlNvUm56ME83N2VCWHBYdzBEdWozYmZXUlBnT2xzZHhPYzBHTTJM?=
 =?utf-8?B?WGp2c0FCWmsyVGV2NENiejJobWpBT3FGNG15RlVva1lZOXJSeDVSVVpoQzZ5?=
 =?utf-8?B?VS8xaEVXMUt2ZkhHaHZTU3ZyVTI4T3ZBeW1IeFhSQXRCVTJXUXFZQ0RqcmF1?=
 =?utf-8?B?RVVsUnFhRWJLeW1qSms3ZXV2NnF4YzEwOS9tRS9GcmZabFMvMWo0dFIvTVNV?=
 =?utf-8?B?OFFwblBWaE5oOHpMdVlTM1ZYbExqSWFDWTI0bmF0MzEyTENWRlZtK1daZU9J?=
 =?utf-8?B?WmNxTzJ5WElqdUpwVDdqMGpOa28zajMxTEtlOE1tQkt4SkNObVBhTmlqbHFE?=
 =?utf-8?B?SW5XL2RTWXNoeHV3LytCU1JmaDY5MS94WUI1UUZPeXZFaTUyVnRCeG1ZRm44?=
 =?utf-8?B?dzlRSmpQWGpWM2dHdlhZMDJnajFRSTAwNDFkejhxSk13V0pNNnlGcytHMkZk?=
 =?utf-8?B?YVQ1ZzBXNXNwLzlLUlpQMzVEK3dkN2c0dHZ2bXlLdTFnT0Z6OXNCN2pYcDUv?=
 =?utf-8?B?RW9uV1ZxN3Y1eU1tQ1pmTGN5ZzNYM0NJU3R0ci8xTXZJUUtjbFpsRVIwbm5r?=
 =?utf-8?B?TjNHdHRWNmxTOVdMSU5XQ2l2QW9MalhUMVpJYyt0NmgxNUMxelJGMzFoVFN2?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c1eb7a-33d9-433a-ea12-08db36ad0882
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 14:41:40.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C7IRRmVrKA6vmtF5fAZDm9cmoeDMo1G8oCJ2pu/WEBphR13jDRzjxhmhk9EasWcw7fWPrfTm8mk9lOhrEJDkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3135
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Apr 2023 14:41:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11189

On 06.04.23 12:53, Arisu Tachibana wrote:
> hello everyone,
> 
> the update to a recent version of isar-cip-core on KernelCI is
> currently in progress by the following pull request:
> https://github.com/kernelci/kernelci-core/pull/1656
> 
> While updating the pull request I noticed that in the current
> isar-cip-core version,
> we have changed the distribution from buster to bullseye.

To me more precise: We changed the default distro to bullseye quite a
while ago. You can still select buster for your image, and bookworm is
coming as well.

> Do we still need the buster version together with bullseye or we can
> drop buster?
> any opinion on this?

As discussed in IRC today, the risk is that a too "new" distro may no
longer work as expected on a too old kernel. E.g. systemd may start to
complain about missing features and maybe even refuse to work then.
Would it be possible to keep the images kernel-specific?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


