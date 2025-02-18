Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF2DC02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 08:46:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.45])
 by mx.groups.io with SMTP id smtpd.web10.15320.1739868378444048885
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 00:46:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yLLXQfHH;
 spf=pass (domain: siemens.com, ip: 40.107.20.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er9J2YkFlWdYvB9VO6a2gQZtJi3ibw7B3fq7oXrE23uDc5yrGlDRD25Kl6IKvDgGfNVpIP73QssYPcGdRz/QpveDQ859y3Brh1hXS3M0eHsRVHFPRPgUxdW8VzlLWbNFZleWBm9xVy44BEnozVxe6pg4xc5dwMnwq3EmurY8cQBKObQcjZAWiaoKSuC+cVQ//5eguQjKPpjSuM/tYAPDwdJ6sG3H16ufuoK+j1oXcx9bKh8n5FJcGYKlg0WEMLv0LJILzDvXqcYeu9tbySbNZKEX4Jq6xk46II8ksaC3E8nN1mIKp847M4D4pSfeP+PcgLZy06IWXxaZlXqt43ezqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiN/lRBE213/nseajBBAYfNsIyxvrvNidjm6QT4gcZ4=;
 b=Umd9+JB7v7FJ1Lv6DZ8RgaqINwSSp+4Cf91JaMQN+ne14ARl1RcGRZbRF67KGJWr+2qyZU0vWRPIT0kHedFS/uOBAHDtQ7KmcI2rUL3GqTq4yQCxKMi+GOTqkUDzHYwZhsR2DnTcGoGF1WCfQyjc2frV9coXtHH982w4IIloLhLAAFw3QEasy9yj5VWtQlg1IDYZiP4oe7jgYdk4UQi8WvWIWfIBZNW9rfh6WCqMw0Xy+GyQIOfcOyqVpBOsQNioWWkN3fI1tCN+S0/g09IH8EatC8DoNNMdq8VjkeEoGIwEKBRz1MfcHvRlcPYCPMiy/BoOCeipiTU6ME0C7tPO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiN/lRBE213/nseajBBAYfNsIyxvrvNidjm6QT4gcZ4=;
 b=yLLXQfHHc7OwlkTlrAzFmvcKQ84eWGlmE2zdX0OB9DC7bSHKXq9rRzdvNljpxXyAOEr2TmRSoeMGVI3majk36x3yXXctcfDt1eMrJG0LaMHIyKs1SDZiO91+wLdD9OZmlhMSJ0hDOuxHaUCyg6Utv52ZHGNhEG1lSa4Lpv5IvJTOGU25Jul4lM9khermttkxRfxXkSY/mK5qJ20d8p1bvnWBqIFgSY19oKbMgdhhRDwUbzaBhI3g5TCEXG3b/M2tX4JyzKMl2bAdrx8yBdbV+k8ue6GEK1MmI7uoMu0/JltF/xHfiH1TjTxnmUP3Z6AnjRUNN7xjITscPLUSFokT2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.9; Tue, 18 Feb
 2025 08:46:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 08:46:15 +0000
Message-ID: <15b8d12e-46ce-47ce-be49-e22b2d8c16ea@siemens.com>
Date: Tue, 18 Feb 2025 09:46:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/3] Added support for rootfs-overlay (for
 development).
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250217100024.42995-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:610:10e::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0235b6e1-3609-4658-2fd4-08dd4ff8b3f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3UvRXlwTEk2ckhpL1hHck5CRDJBYWhSTmJITG9ERnJCWXZxb3ByU3VoSWhX?=
 =?utf-8?B?VS9MT3VOZ1UyMEJ6MS9PbEU0OEJkb0swRVRMT3cvYlBPYWhPWVZqRWJGM0cr?=
 =?utf-8?B?TTJKckR3Z2xoWW1wYWFyS3JZVXJwMW9CUjV0MmhKdzRYYVVnb0JQaUs2dWZ2?=
 =?utf-8?B?L3oxVFFONGdKRGQ2QVhMY0lZV1BvTUEwYThWTW9EeVhqZVVXTUpqVkRHa21v?=
 =?utf-8?B?T2NDYmtoSXRVY1NaQW5RUGNpZlVzcVZKK0dnUXUvMTF4cEhIWGJ2akdJTmJ5?=
 =?utf-8?B?OVVxVGxrWlFQZ0dDT3MxS1YvYjM3dndnNWFtMmFnL0FoTVpQWDlaR0NhSlNC?=
 =?utf-8?B?L3ZrOUFJZnp6aGJlQXhmYlF6WERXODdJZHlYcTc3TTFiRHpHREp1TzJxRE05?=
 =?utf-8?B?YXVtbFRIVW5FRFQ2OXBUdVhaRjBvcWEySnFmLzdKN3ZrNERhd2srWnRDQVRo?=
 =?utf-8?B?cjJOSU10WTdERmx0WTFMRGE5WS9jbEFVcXJIOUJoMXg1ZnVMWEhyeDFlbE5K?=
 =?utf-8?B?c1g5UEpKUEFHQ3p6QXFJQkdtNjRLZ0ZMWTJOLzNhREZUWWpyckYrWFljR1dy?=
 =?utf-8?B?YUNvZXdMcUFBY25EUUE0S3BLbnl4Y05mWHZ5ZENhZ0FsT2ZBR1UrTzlEMmhp?=
 =?utf-8?B?MU9wWjBpcWlHbVllYnN1OW5QL1NiSHR6RmVGMzlwbUhOdWhhc0VYMU13b3dv?=
 =?utf-8?B?NFJkM0pKWjltVnIxN0tzY2dac0M5QWszZWtBaXZXeGtCWjd4R0JMS09LeUoy?=
 =?utf-8?B?bHpHK2dMRUpVNUpMZFA0bUd6Sklxa2RoSnVYSGNmdFczZitiKzBPajJrc2Ux?=
 =?utf-8?B?TTVJY24xK0xnRklVQTFKREJ1cFE4MUJEY213M2FvUThsMjZtQjJqc2lGd2Nq?=
 =?utf-8?B?UDNFb0lrQzI5WjVtZG9tc0YxalVWK3N4L1YzRVZLU0J2S0xXRU5WVDIrVVM1?=
 =?utf-8?B?c0NlTUMwazA5MFRBWWRWcE1UaDl5dk1kU2lzQkEyMGRZWGM4ZjlJeE10QWxY?=
 =?utf-8?B?TnNLQVpWMENnZHBvNnliZHVkOTdScnhVd2hxZ0dxV21lZnJhcTNDYk1OWnNS?=
 =?utf-8?B?eXNKSHB3SFE1eUVVcG1aOFVlNGFwNWdqdWhzSzI3WXZCcnJ0QTZ6MVloSmRj?=
 =?utf-8?B?ZDZNZUIxVjJ4NXZDcVUwV2lGaFNzTWxmQ1IyN0MvMmJabnNVb3dQcHVNb1l5?=
 =?utf-8?B?UmJzZ0FGbTllc0c5WnVheW8xcnZOQTBvc2dqcTAzYm9idkU2RTFjWHdzOEZn?=
 =?utf-8?B?OHpEMSsyOVhjZ3BLTlpWVElxUnFuRWtjNVVGK2lwZURVOURoNjd2R1dtOCtZ?=
 =?utf-8?B?b2hXdVdOQUNaak5RVmhTVm5vbDZZcVU1ZVN1UElrcytDVk96RnlHZG9xQlkx?=
 =?utf-8?B?cG1aU1NMQkxDaW94MGx2STVjWnBVZENya3lQb0hBOXlwdGxCNk5vckI4MXBW?=
 =?utf-8?B?a0dxRkxrS3BIVkpkYlk5b3BTcEhyeUhsb2NyVlI3aitST2ZYQXVWRTEyUGxL?=
 =?utf-8?B?ck92dHJaaU1TTXNzOFVsTW5nUVp4c0oyOFRzV21xWEc0R0F3OWF1aGhDaGRp?=
 =?utf-8?B?VG44akp5RmF5TnFUL291SE5tdUd6RmVUaExiV0xvK25yeHlJVWRpNjMydnFW?=
 =?utf-8?B?eGJNTmM5VVZxOVM2NVZKRnowYlVUK0p4NURhZlFLZEdOSDlhcTNrdytHY1Vl?=
 =?utf-8?B?ai95aWlGbGczeWlyN2h1cUd3NGUyNjY0QnNDejRlc3dZb3V4WEtUYW15SEF3?=
 =?utf-8?B?bVphL0xORHVvWkVYQkljUWxDNTZlYklQbnJZKzZIUVJudWx6WEdHRU1FWGtP?=
 =?utf-8?B?RXpxK1ppSVA2RGVxdGk4MnhzNlBYdXY4NWRSa1JNenVSaFYvUW5NL1BoUE5s?=
 =?utf-8?Q?g64b7GhrnsFIh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enIydzRGQzhTNkNaajFadkNDdnhNaDhCTlROYVBRZC8zdVA5UnRkdmtvUksx?=
 =?utf-8?B?ZGc3S2hmTXNMTm5zYUEwL055V3ovejFlL0U4VFErcDNZbnlOSlZiWGRtZlNB?=
 =?utf-8?B?eXZ1R1JkYUtubmJHUXpTZlJsdmxFVng4S1V6RXNmbEFwNDRvT0NyejZNY2FR?=
 =?utf-8?B?cnZTZU9DbGVEZWdrTi9ZT0JFeWFaU1JGak93R050YVZvZVgrNVJDR282MEF5?=
 =?utf-8?B?ZzZ3cVpiY2VyQm9Vb2RQbEFRTWhCUGFEWFdvdEQrekFWSSsxbllGanU2NEtU?=
 =?utf-8?B?OHp3SDJ3MGx3aklZL1J0SjdaT2RpeTFremNhUlNtYmJpVDNDZ05rZTJFejF3?=
 =?utf-8?B?MDFpU1B3ejdocDFRQjFTbTdXRXNaR0U1VDloN3NuWTBsZCtEM0szSEVNVjZn?=
 =?utf-8?B?OTJLSzZBNTZMcGJmZklZRFdGMXkvN1lZZ2dwazZHWTRWS08rNzJ2WFZWOFNy?=
 =?utf-8?B?RG9hQWorbGZrVVczckdYbWdFWGsvbVhEYUQ5d0cwdU1HcE52WWRpR2RldGlj?=
 =?utf-8?B?dVBaODl6cUtzY1lSc09RQm01emNPUktVOXc0Q3JDUTh0ek80aGZjYi9Md2RZ?=
 =?utf-8?B?MkJHZWF0QTc5OUloL002Vmlab2Z3cWNDMU5USTdpNlhZWFU2VWpOaUpKL1Jr?=
 =?utf-8?B?K0V3ZW91dzJFdjdxUFpDd2E5eXFIdzlNa1dFaHNEMHJERGY5MHl4TE0yQk5E?=
 =?utf-8?B?Zk55eFd4KzNFY2RXekd5YUVSOEZWNnVIL3o2Zmc0LzBKREo5RVF3cnFEdUNK?=
 =?utf-8?B?MURQWUs0NWNHK2REYkU0dWFYdm5UY2FtYytEazRJQzNRa0xjbVA1MEZlV2Fk?=
 =?utf-8?B?TEgwdnlhcTVPQlhtN0dzZlk5UWdWRDhlL0RiMTFJczBUZEl4RUMwUkFNTG1R?=
 =?utf-8?B?WFVmd3ozak9XODhrMUJZanRVRXp3ZjVZSmlFU3M5SG05VG0zYk1OejE3NFB5?=
 =?utf-8?B?YjR6NVF5dFc3SElnazg3VlBrT0J2QVBJWVY3RVdQR0ZmaU5vYmF3Z1I5VFJO?=
 =?utf-8?B?Y3Z1TldObnBQdnV0ZGh3cU5FeUIrbUtHTitaUkcwaG0zWVIwKzg0QzBRYm1p?=
 =?utf-8?B?SWwxZ2oyRDM2UGg3dEoxVnk5VnJMK2V4RFkwcHdxdTV1OFNaMWJnWkxrRVUr?=
 =?utf-8?B?QjhOeWw1Zm9mcm9kcGFMNGd6UHJ2ZmpXWDIrNlhCUFU4V1Z0ZUhKVDFma2JJ?=
 =?utf-8?B?allHOEtkanNqTXFSd3RUNGVGZ2N5MWR5V0ZENTNrMHhKQ2tUN25Sa2R4eUFT?=
 =?utf-8?B?NDY1b1N6WkNPWVdzV1l3KzNyYzFmemRIK3l0SGo5WG4yQXJUeDI3SWhaOUJ3?=
 =?utf-8?B?VEQxN1RtNzRWRU1IeVVSak5iZG9aV0JvUnUrZGU0cGRJdGw3cmRaUlU4RWV5?=
 =?utf-8?B?RDBtNStoZUZwRSttVVd1RWdHVUdSZzRrTURzbFZJR2FmaUovemUzck9peU5r?=
 =?utf-8?B?UXB2NDEySEdINEVMUjhkakFiOXN5cTlTRGpGSDl2bEQxVTZ5MU14Y0o0dnFI?=
 =?utf-8?B?dDR5dVQ3b0swaVdSUGNkSkEyZEo3cWMvSjNKU0JoalRTUjIvUUVMVEMzNVFi?=
 =?utf-8?B?TnRNU1V4aVlYdWN5OW9YQXNMSFFLdzBIVEN3YmZPVFFVOHNqN0lOc0hmaWVp?=
 =?utf-8?B?azZCdzVJc2J5WW9tUGdKc2x0TFg0aVlDK0FsK0hESEJxaUo1RWg1KzJ1U0Jl?=
 =?utf-8?B?RW9TOHliNEVBM0ttQVI3UVhZWW1UY1kzOE1VMklBN3RCVk92MVdQUWpGZGp4?=
 =?utf-8?B?T1ZpK3RjakNURS94Mm5RajRDK0U0MHlrMTdpbGdTQVlmWmEwNUV0K1FWbWtS?=
 =?utf-8?B?KytPNWxBUkxpN0RxdHNSSlE2RG51d1pWZWVzbk9ibkhxYy9icTgySE9GWThq?=
 =?utf-8?B?bkZVcVJpZlA0ZGk4WFZUcGl5YzVTN1VNMDhTNktiYW41K2Z5a0gyRHRWSGtV?=
 =?utf-8?B?N1ZJWHBxMzMzVnZ5Z01RSC9HTkVKdDJQYjhjNEg1cXRUemhJQVV4ZE1STXZt?=
 =?utf-8?B?MEhsbnNmWjdMakl0ZGtUNEZ5bUljZDhZdkw3Q2lFbk8yU09QZk5tOFVyc0xZ?=
 =?utf-8?B?SzExaXN5d0JpOWdsUjNISHFSb1k4SC9NaGRkN1RGTTZBMkhnSnpuQnI0L0xG?=
 =?utf-8?B?MDhLT0FYQ21lakxqaENKWVdITVBzUU1PMEtKc3JoVU5nVEd4OUI2VnJGWFNI?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0235b6e1-3609-4658-2fd4-08dd4ff8b3f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 08:46:15.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5m74wQnHUfA+vjJ1zQNzGVU9W4IU8RzrhS8qZqS//xt8tpOTz/FCzrVoS/3UV6DcPkJDlKEVM285kW/oOxddqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7229
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 08:46:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17860

On 17.02.25 11:00, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Updateable images based on isar-cip-core come with immutable rootfs
> out of the box. During development this oftentimes comes with the penalty
> of having to either rebuild images with additional files, packages aso.
> to accomplish development and debugging tasks or derive from the production
> image in a way that some fundamental features like verity, squashfs, swupdate, aso.
> are not part of such.
> 
> Both cases are far from optimal. With this patch series we want to share
> our attempt to streamline development by staying as close as possible to
> our production image by overlaying the squashfs or erofs based ro filesystem
> with an overlay. To make changes redundant accross reboots, we decided
> to use a persistent storage option in favour of a tmpfs based approach.
> (Although, technically there is no limitation on doing so)
> 
> Keep in mind, support for the root overlay is thought as a development
> feature! Thus, it is not thought for production, as it invalidates many
> of the properties we have from ro-filesystems. Also, keep in mind that
> changes on the overlay may partially hide updates or lead to "unexpected"
> results after applying updates.
> 
> Alexander Heinisch (3):
>   Removed "ro" option from read-only-rootfs's fstab.
>   Fix return value handling on filesystem check
>   Added support for rootfs-overlay.
> 
>  classes/read-only-rootfs.bbclass              |  2 +-
>  .../files/local-bottom.tmpl                   | 97 ++++++++++++++++---
>  .../initramfs-overlay-hook_0.3.bb             |  2 +-
>  3 files changed, 87 insertions(+), 14 deletions(-)
> 

Thanks, already applied patches 1 and 2. 3 is still under review and
will need at least some rewording.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

