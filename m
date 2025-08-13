Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68203C87FCF
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 14:52:42 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.42])
 by mx.groups.io with SMTP id smtpd.web10.103479.1755096751409597487
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 07:52:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sWcJPZJ7;
 spf=pass (domain: siemens.com, ip: 52.101.70.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIxdRAWxniUmWJ34Onvr/RTB8s6JVObxAqYELURfmwAAaf6wgQCWTbcHKFzatJY7Pxvw6PaB1+odWK9s6FixYE75kpeoT5qi/O4361H9jIKjaXd/+inIdB/xevSAU2O435849cF+d0RBRAjjBhVx/cLuKEDM4Sa7IzW9ffP94FA5LcqUMopT5Yww4b8g7dSa+Lm5LlN5ucbGF9ufptv74yswAV12xv2QzQvGJIFSq1WiVlR40Z6VYAIQtibU4UTvEw/77JrEslegOWye0JKHL3tA3UZFX6BE3RRZ2FARFLdVufG5LeYFouQRvCUPcbVZp20st5E1Z4C1onOv8xjpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYiARNVaQzf2KuX2JjX6Od3Zua/1+j2FFIZpWb0Eb58=;
 b=SZbWiOwX7ND19w5UiKN8dOQ9mxEgV7MCK39Ro7HDYcwA2WI9G8QOkWFadZxMCQ9+dZJG118scDAe9kO05Lu70P+XjOv972dGXdegMm6m76ee2TAJTahTlczpNuBTUfgImkVuY+GpGIWMeSem/I27qmdakiaC3091hptD2O4wgRTwtMunCkqd95DcN7Et450QWc3mIBeVIGAYuipxy1+IyujxwIJyUb5zjQ7/IHVEM0ExIumcxuMmMYgIuubmXdS2vhfijNfbG+EO4yg475iVg6qkb23J2KCcc4l/Lg9Gpi4XZHpmJk2ah9DZINXZmVR/C8E3B8OqEAkxtuHr3BFZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYiARNVaQzf2KuX2JjX6Od3Zua/1+j2FFIZpWb0Eb58=;
 b=sWcJPZJ7Z1i8TumjxNWyKHCoSnf9C2L/HwY7txINEmeVAkJxX64pVmKWYGoz0T+w0UjvcMKMqTsKQA1Hrjlez8VELEElsKoB9PwkmqMXfmBvjfqzHyrQxn67lJF/fOIJywmoF8hY872k9SmTGZPF2vsjrXN0wNj71bUZsOI0OypUfEmOuphGyDhBj+ALEKI5qde31Wy7lAwv2nepZRz6UGhhSoqaQh9ig6lCdVFUKs5N5soNQrlo/srEl+DENOMmc6sqIxHjF+UcQdYoKHrlaIsX3/dpy2J8edPFaToRu98/5Kjrjkms+fLudu3+hmPF4BVdR5ZtQzXIW24IAo5AFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 14:52:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 14:52:27 +0000
Message-ID: <420f5c3e-e5fc-41fc-8b95-e5e86af0e4dd@siemens.com>
Date: Wed, 13 Aug 2025 16:52:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 0/5] Add support for delta kernel binary
 update
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250813134630.3943194-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:610:118::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce4a6ec-a467-4777-c93c-08ddda790592
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NnErTVhQSTJWYUprM2pJME9GZVdQc3F3cVJFemxVSVFhYThCMkdObnZkNXJ5?=
 =?utf-8?B?RitBcTc3UEpqRVNPUkZXaXl3Zno0V1hmL05iTDdkV0IyR0FPVVAzZzNvSlNW?=
 =?utf-8?B?WVZodkFEOGdydUNTcTROM2QxYzJNVzVJdkNQT210M0lCYnhKMkpFaVVFaitJ?=
 =?utf-8?B?YUgzQmNJWXBQSVRNaHoyTEtnNjdBSTFGYllzWHRTQ0swWWFXQTcvb0NrKzMv?=
 =?utf-8?B?YS9VSEQzbTRoWm5QODFkMXErLzlpNXlEUWxkV1RYNEtKeTB2a3FHdThMRkdt?=
 =?utf-8?B?RHY5MTZucFdMQ2t2Vk51VDB4QjBSRURhbUVvNlZQNXBjYmFXWGNUaTJocVFV?=
 =?utf-8?B?ZVlrN0xJZVdWNTlBVkpuUVZYY3hsem5vQU1MaUtjdFJMcE9Ea2NwT3k5Tnpx?=
 =?utf-8?B?U05iUVpBdjQvL1EvU0JXYTEwdVBPVFdQSmI4YUoyM3NLcm5jRTdaaEZoVE45?=
 =?utf-8?B?aFpOVi9GdURBVUtmbHlrVWRnR3ZwMmw4UEJaTXpjOVJJVTZSNHBLdENKMDJW?=
 =?utf-8?B?dkRNa2FqNU1jV2tIR2RvN21SSHM0clhZNEdnRFZUcXc2UXE2QnZDVVdpMy8z?=
 =?utf-8?B?d3pYZE5PUk9RNnFqYUEwZHhzQzRDVWJJdThndWdyQ1c2ajFGMlNaN2YyVUNV?=
 =?utf-8?B?SFNqMmJiU2w1bVdqUTVDQ2c1T3JVQmYrb25HcW9aOEc0SFk5ZUYwc21UUG01?=
 =?utf-8?B?VlJIb3BoamQ0czRaMnJvT0FkWjhmRmtiaStmZDJJVnJRbjg0ajRnajc0RVgv?=
 =?utf-8?B?QXNXWjI0T00rNDE1bm5QU3d2R0gyVTZRemJsMFRjSjEwZFgzcFk4aHcxNXFV?=
 =?utf-8?B?K1Fwd3ZVWENFbUZTMWtVUWFvcjFNOS9PMFNGNkx0cDJOSmthL0s3Ni9DSTlF?=
 =?utf-8?B?cTEvbUIrYUdML2FSZGlGRHIreUdId1Z2NFN6V21nTDdQZUFEbWRYTUN1cCtF?=
 =?utf-8?B?bGdxazJadnFJd3R5bjVIUWFrbFVUNFowK2hGOFlLcWFpUi9JVERzVituZWZj?=
 =?utf-8?B?aW5ybDUzcyt4c3FyaFY3Q2F5dis5eFZqSkdKYzl6aWVMakJCUHd4YlV6KzRX?=
 =?utf-8?B?bU4zUWl6U25jKzFxdEZwMEpjblp4NmNnb1ltZVEwL0NsdGhZZWkxTitnNFlG?=
 =?utf-8?B?MVlqcUI4amJBYzZiRUJnK0RlUXJPa25XY202S05QZE1PbHdMOTdwczhvaWVP?=
 =?utf-8?B?Y0o5Ti9saDRLMWFFNUR0Y0R6REY0bGV2SmJRMVBJeXdGRDZtVU1JeVpRNXpj?=
 =?utf-8?B?ckU1Ymp2UjhkcXRkSG9PTGtMSXJ4aFlvWGZMWWZoazFXaVd0b05xdkE2anpB?=
 =?utf-8?B?VWJQeGZnRWFCcWFuWW1aTWtMSjUzSE5vS3ZjWjJhenRDYmNzQ3VueFp0N2ds?=
 =?utf-8?B?MEVrZ2w5T2RlaFE0QnB4VGUxYkw1S1dPWmljcFZHd1VVZTNKRnN6R3NucHln?=
 =?utf-8?B?Qy9OVWhNTzIvQTNxY2ZVWTUwZEV3V2ZTd3BOZ01Lbk9FaE51d3VIcUlsekpL?=
 =?utf-8?B?Qk1XNnhsbWxkM29ubXVXcnR1KzYzWVJXc2tJcmM0ODNGbFBpdUdFQi8wdzI4?=
 =?utf-8?B?Y2wzeWhDVU9kVk40TStWdnl6ZVlMRGhRS2haSGJsNGtwL0VaUmJKQVVtTEdV?=
 =?utf-8?B?QzhVZXZNQjRIQXVnc1pwM1BDNHpueHV2T1puK2hBOFVyYUc3elhvbzZoMk1T?=
 =?utf-8?B?aW0vMkFWNTJ6bVJDcUZ3K1VUVTBwRzRxbExXWWVSeC9DOThmUllGYk9lcXE0?=
 =?utf-8?B?bzhlUkJvU2FxWlZZcjdaWEdzb1RJZG9xelcvTWw3dW4xRFNzSktaRXI0TFFn?=
 =?utf-8?B?QWxJc0NTRS9PL3B4NnlKb1pLSk5vSVNMRGhRTEh2bC9vQ2FCcnNTcU5uWU1S?=
 =?utf-8?B?RW12c2U2YkVkL3ZMRFNhRkY0VTlRZHE2bGxWelZGczZ5WFZYTGFxZHVIVWtm?=
 =?utf-8?Q?aTMzrzdYlgw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXgxRlFuRHVNWlJtdG1XenhQY0RhZmlUUHhsNTZtZmxDQUsrWmtTZEJhRWZS?=
 =?utf-8?B?WWVFVFhCM1RINHBaRjloNjhJakpyZmVUWnRvZVN1TVpKQ3Nja09Kb0xwcVVV?=
 =?utf-8?B?dDdrNWNVT1hUM09nQzNuM3FpT1Rxd3lVN0h3Tnl2MHp5cGhqQ3dzS1Jha1dM?=
 =?utf-8?B?c2NGQWdJcGJFTG5MSXZ6QW1GMVNNUE56RkNJTzVkdnR3ZFZ4SVBHei83QTZP?=
 =?utf-8?B?ekpvNDQvQWkzKzZTZGxab2g5TnIzaHprMXZDZFIvQ1pEcEd4OUVJRyt3aFZT?=
 =?utf-8?B?RXpNMHArTExGTGZpUC9GTWROMEgzdGEySDJSTFFLeXNxcWhrT2YwaUlNSjNF?=
 =?utf-8?B?Y1JSYmpuaUJ1Y05DN2hoRmRvWkxnajVJZ2l4MVpwcitncVVMUTBhYzhxVS9J?=
 =?utf-8?B?SjAzWHZMSUVGM1c1d1FmNGFRRnR4TnlaTi9iam1RVjVEWFp2QkZaNTZrNkli?=
 =?utf-8?B?c0xlK0x0UGRyWXdKcFdoN3IyQkdrRk5xUWJKT08wOGJyY09jS1FhV1BUQnhC?=
 =?utf-8?B?MUlsKzNDNnJnWmdKd3g0Z1MyWVU5OUJmM1hUb0ZmdUFNQW9JSFhQNlZ5bkNN?=
 =?utf-8?B?bDc1ZkVTM0hCVldIK2dxWEVBTzk3VkVIV1Z6TFlTNnpFTGh5T00xaXBnN0dX?=
 =?utf-8?B?QjNXRVJCQURvRm1TbnlreDZFUURvbVh2MjhGVXUremk0YWxVU3VvMy9Qc1hi?=
 =?utf-8?B?ckVLV094OUJUQXZ3SFEvcHVkU3FLRzF3UTRNWkxobkxJVnJ6RzZXR3h1cVJ6?=
 =?utf-8?B?OHlXYU5zd3g0M2oyY3dGT1dkc0l2NWVUYysxYmV4ZmtZWk1IQUJBcGs0Uzg2?=
 =?utf-8?B?Zkc2T08zblRkR3h3K0ljRGNhb3h0OFMzTWJhVkR6TDZFWFNuRDFTZklBYVpS?=
 =?utf-8?B?cG40d3UwYmhXejRUQWVqaGdiM1JvdGVEMGhCcEtUcjR4TVN5ejFaSGtja2JM?=
 =?utf-8?B?N3cxbDZCM2Jqc25vRDNzbnRmREt5MDcvTWZOam1XOS84bktDSkJWbU9pR3oz?=
 =?utf-8?B?RnFBWUlrZ0g0cnFHdzlIOG1ESUIyeXlqb2xmYnV5dzdyMGVmYkl6d0JrOHhR?=
 =?utf-8?B?K2NRUUxpVkdkZEliVFVTdys0SWlBQ1Z3MXM2OFdTeS9DckNBQnd6RUJvVjdn?=
 =?utf-8?B?emQ3ZDlTNDhHM0liV3NsTEdiS1NJQWRtdzBGczJPeDRHdnNycWxoaTZURWJY?=
 =?utf-8?B?Z1VKd0MzbTNtcTIwcTBPelVYeVk2VXlwbVdFRDJkVi9FaWEyZ0JScjExOWYv?=
 =?utf-8?B?eG5KQVM5QndMTk1ScXpuQ1hBSEgvZU9WNzB1V3IzTlZNUXZhSG4vdDVsencx?=
 =?utf-8?B?OU16blROb3ZzYWh0ZDZQODFsL2lFaHNRVmo0eld3MURmaFpWQVBEbEZSaDBi?=
 =?utf-8?B?QVdjRmVwZnZaTHpVSW0xRVN4eFpSem1hYW9xa0FlQVcwcDNhNUdJYlUwaHhB?=
 =?utf-8?B?Ujc2dWdqL041OWFWa3h6bU9uUWVsdmRQekdzWml5dXlFRE1UaFBhZ1RDOUNP?=
 =?utf-8?B?Ujd1VlI5TDVlTm8vS2hPWWk2bzRZRnJHQ2FJSFlnSnlwNTJIcEhFTUsxUlU5?=
 =?utf-8?B?ZGlDa09RNkgyc2U5K0psTTRvYUw4TGtPU2VTWFM2K0dyblkxaUMzejB4MWVX?=
 =?utf-8?B?S2JmaDRhZXRiU0hqZFpCbjlja3VWODFzTkdyRWZPc3pLYTUyN1RBRXlzNkVq?=
 =?utf-8?B?ZGx5VVZxNk8rdEt6dXJmZWdNOUFMWHUrQytCOVhXc2V0MEhFaDV2UVlLS1Ru?=
 =?utf-8?B?ZnEzb1BHV0F4UWNVNUlIYWtwVExQcmEzc2ZGblpKc1dHWXZTN3BzUUx4Q2FC?=
 =?utf-8?B?TVRKclpkSmZYSERGTXFURDlzMEZsR1AzTjNBMEhjbkZEeXRVdGJQVDRYRHBW?=
 =?utf-8?B?Z3FXMmN2MlltdS8wMTlCNitmdVREOElMVzFKZjRKOTB2bGhVY3MvVjYrUWFr?=
 =?utf-8?B?VHRjYmlFOHo5b1dUNjBRWmo0SE50T05zU0Fsa0xEZk4rSER6WE1WdHR3aWhG?=
 =?utf-8?B?N0dGTHdZY3JPK2NyUTJKd2xWV0dpQ2JFdlBDZ1lSOFAydFpVRDVyZjZqQTJ5?=
 =?utf-8?B?WUF2eW5EK2xHOFlkbXBROGRyR3R0c0Fkb2RjMEtCdzVSREp1QTVCM0p2dGNM?=
 =?utf-8?B?UXlrNkFuZDl6Unc5Zlp0WDBWTlpLNVpiRXhrd3dMT2JPMVBnc1JxcFVoVFZQ?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce4a6ec-a467-4777-c93c-08ddda790592
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:52:27.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rgjYtjI6tgQjhrXnYo2LpYw6PxVBSSFJmlELJ0VmWgIoDdZkbd8eqOv7LVxGEbR2dHu1m3i5Atlxt1QGBwlMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5876
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 14:52:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19734

On 13.08.25 15:46, Shivanand Kunijadar wrote:
> This patch series enables the delta kernel binary updates along with
> rootfs. When rdiff is selected it generates deltas for both kernel and rootfs.
> 
> In the CI, we just change PV value to 2.0 for the second image and there
> is no change (code) in the kernel binary at the moment. Do you think building
> the second image with RT kernel is appropriate here to verify delta
> kernel updates? 

Right, we may need a better delta example for the kernel. I originally
chose that (prior to delta updates) for having changes both in the
kernel and the rootfs that have to correlate. But we actually already
have a link because the ID or hash of the rootfs needs to be stored in
the UKI and, thus, updated in lock-step with the image.

For delta demonstration, we likely need a small change in the rootfs
only. Maybe enable/disable CONFIG_IMAGE_TESTING / kas/opt/test.yml? Or
something artificial and truly small, but that would clutter our menu...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

