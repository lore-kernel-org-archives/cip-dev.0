Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B59C2D0D1
	for <webhook@archiver.kernel.org>; Mon, 24 Jun 2024 16:28:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.40])
 by mx.groups.io with SMTP id smtpd.web10.145957.1719246501032311709
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Jun 2024 09:28:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r66fJoV0;
 spf=pass (domain: siemens.com, ip: 40.107.21.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4y8KyZ5QMebIz+l/hSQNJZVIY2U9F0ka4jclMLGf9rgkaQRAffJ3HxkUgAJtd6ywqLDciHA75CQiofRGk1ZAzw7nVqJCJljEPulu11FgR3AOFf3KYLZwoF0DE2PpmYAKz7oQ3f4TTDvXqBrSX5Y/aMpvIUW8ej/Y9Q9m7xhK49JrOKYpY+o42pTIG0wEblINBa0G4SLPzrP+iVESDsXCNUiUf3K++BCMyXtXnRDZimgjLQ0BIbEAF7f8y+rIQ3A0En35vxbe0ss36nKCTGVZAWQrKd70peBf9CO/6zhNGit4gmpT4eeR4CEvinMDyD5Har1qD/V4GfGO2KY3T7POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl7uwPoTya0Sd6sgcaT53cagFqIBqx1lvhC6U2DO+RY=;
 b=XCHX2KRbkcKniJ8v+aM5iMpU903Mx76jbpWfKB136TIgLaI0SFl8KFevcXNSqeNVgZdpASjbkYIGrwQA6JHR+pEdJneIutcV54mFq8bCovETxRWf0D8yDkkt9xS7ZnN+rhvSTWR+l/xPp0qFkiUjBXSpmJHEsKqvcJRIC9Ml4WtbJjQjhVxVo9qftVZ2WzxNmgRgG2KV82OpMMHbFQsn3AFjPT6bBAnGwFmpwNRskmz28L5l3ZP/dZCr0cEdiKH/vxmJIs5fjJEbOTqeqF9IMlFLki0gwRORbFXa8OWtzCMyViFqP1wvuNq8zOd2D6LiSPa670wTQcOm2ESXKYVZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl7uwPoTya0Sd6sgcaT53cagFqIBqx1lvhC6U2DO+RY=;
 b=r66fJoV0VzNmze19FQDa1UdgpHeiDY62W6MlUSr6BovTwr9Bw370xwzOCgRfZDACswpm0Mheo4QueW+zuIewzjlf8KqsFxd1hc2ciyGYUBrL+tcc5TlJOIDaMbWDQwQaAKw/fHRrJDdYUa8UizPk9WdBl0/e8bjcdgdyQyrVkAg0+vlgKSqpDkee9SPDjf+6+2mDhv87CgWbdV4lTjeXFyWxdXHSxhtW7C3AM88aaDx057pQ1qcz504rP3h7zRn1zqhENKm9i35oJHkeAiGJfT6P9MNybcVfrbNAgR7mmjjE98SvmSCeiPoeDdLoXvBKSCcp1IMXSItJzr6rvIew5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:448::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 16:28:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:28:17 +0000
Message-ID: <dfdb05a7-2dbc-4e01-abca-0f0727af1190@siemens.com>
Date: Mon, 24 Jun 2024 18:28:13 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.4
To: cip-dev <cip-dev@lists.cip-project.org>
X-Mozilla-News-Host: news://news://news://news://nntp.lore.kernel.org:119
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: b22e8fc5-9f3c-4475-fa22-08dc946aa737
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bmdGaU5QNndwT1NsVmVuSFozamE0R3pIZnhTV240MzNyZ0xyWWdjZUZzMitw?=
 =?utf-8?B?d29SRmk1aEIzeUQ4QlJET29HaEw5aS9IZVpQU3ZKN1hDellZV1B2ckI4M2xo?=
 =?utf-8?B?TlAxc20yWm5MTkZXaGFva0JjczFDSGpOWklUT2lBSTd2YmpHNUUzc2NiVEg3?=
 =?utf-8?B?T25ZVjhCNEd6cWlWNlA2MjBjWVRMQ0RNRzlLaGJnQ3dCbjV6amFUVHFpdVgy?=
 =?utf-8?B?V0ZEdlF3dWN1cU1EQjlYVmtZZHIyZXhKSlpGZTZhc0xrb0s5eFY3bUQxa0hQ?=
 =?utf-8?B?NjJPcWNvT0xmeC9EWGJoZDN4QVg5Um9iT1NTWExMdmEwN1JMWEpkdS9wcFBN?=
 =?utf-8?B?ZG1GRTl5RGR6NEMzblZVZGN2MGRyV2JRQXNySFdkOVUyMHJ6ZHdyOXRuUkNT?=
 =?utf-8?B?cXRuUllrL2pEdUZ2alVuU2dtYjUrSkdrZTZPeUl2czBzdVl6OVJYekJ3NzVj?=
 =?utf-8?B?OVEzYm56UVJ0bGRmSzhnSVNjTGlMVHYzSU9sVXRZMzhYWklHQ0pMUnRiZFNN?=
 =?utf-8?B?cHp6WmEyUXc1SU94MkhJVEhRWW12cldHSTYvdGJ6eTV0dTljRGEydDdqMWFm?=
 =?utf-8?B?RWRONStob3JOeUJaRzRzMVE0NVBnRHJCc3hJckdCR1dGRS9yKzBSaVhpQkZw?=
 =?utf-8?B?aHZkQ0ZreTZ2aHQyQmptTVVUK2VJbXcxMm9XSDZiZGVlVWxFV01pZ29IQnQ4?=
 =?utf-8?B?Z05pc01nNGRJWGx4d2dEcWhBZ0pPNHMybVZKblRDdW9kaDFEempoZDBkWW5N?=
 =?utf-8?B?Wklma3pQRUZyd1l5SHdSc2tOSmlDbXBTYTlORW9aWmkxMlBBanFrSUlOTDJN?=
 =?utf-8?B?VjFzUnFrekNweDA2WTFGb05mM0JnaEczcmFjU0pBdGx3bTRHNU5NdnZuZk8x?=
 =?utf-8?B?UnFyNFB3R0V4UkphMDcySzR6RHRHQkZBejYvdUE0bnpnL3kzK1M2YzB0dFdC?=
 =?utf-8?B?R3FhQXMvSk01UVRaejhnRE1UVXpwbkl1MkMrQ3A4alhtbVFDSkQvOE4yaU9X?=
 =?utf-8?B?aVNUK0g3L1BEcG5JVVhJM1JxUGYzYXlVc09SMlRFK1lZUEpIeW91TGtaSXln?=
 =?utf-8?B?eHM1L21RZ1k4ZzFQbHVOK0YzQU9qRE5FalJXaTBpNElUSG1hVXoxcHQrUEpr?=
 =?utf-8?B?V0w2MTluTEdLVU5JZHBKNUVyQTExOHFoQ2NEOUZsWUpMaHVQZUNGNjl0UUxa?=
 =?utf-8?B?NHRZT1ZmM3dhanZxUU9jQnFyUjRtSFZWc0orSmZQQ0phZ09tbnk2Y3ZPNUVw?=
 =?utf-8?B?aVYyekIxY1ZsOUxwalFJeXVLa0hQaVdMMHFBYzRrYUVFK3J6bVZPNmtjK0l2?=
 =?utf-8?B?TUZDOHIvaEpFR1c4U3VRbUZoOElFZ1FZMTlidG1Ob3lHQzVKRUtKbC80cEFp?=
 =?utf-8?B?OVNIUk5kdExHY0FzcWp2cngxNlQ5Q25FSWtrVzVvOG9RaU9TeEM5blZuS1pE?=
 =?utf-8?B?TmFzempOSitodVBUNmJlOGZMWG9uNEJhdGp0Z1lmSjNucHpyQUk5T0gxZEM1?=
 =?utf-8?B?SE4rNzV2TURHcXpCaUpES3owTmhRVmk0YWh5MFlnUjhHb0FBclJlUXJkbGUr?=
 =?utf-8?B?Zi8zaVVrcS9JNnhvYWNGenNRdUlqcFNhYWVVSUprSGc2TmRGOExVWnVVdDZE?=
 =?utf-8?B?WHdJcmJMdjNaaTBSVndQaElFeXFTTTlNN3FWOEs3NmM4dzBIcEtGYk5RZWJG?=
 =?utf-8?B?MS9GUk83cUJ0eWt1dHJ6a1phSEJlMFp3d2JWMmwvdTdFWFcvSTBraWNaczVJ?=
 =?utf-8?Q?hhGCMZnVOZl0MA2B8R8m0iLOS1UHID8lBDAKh59?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dEduR01acDMzSFlnL1JYUDY5RUlWTDVsUmFkRXVCc012VXNlYVNMTkpabEQr?=
 =?utf-8?B?dnhkS0o2WVpCME1Dc3ZyNlhKWFplUDRJOHNUY3F4Qm9ZRU82dmtDK3d1YzZD?=
 =?utf-8?B?WVpHRjkyTmg4Nkk2UkVTb0ttQlpWVkpEdjdXcFpUR2dmVDRyT3hnbXExbloy?=
 =?utf-8?B?eUVQaE1CdCtYM2ZZN3BteXJ2c2RDTlpDYmVKelBvOHNXZkhDdi80QWgyREdO?=
 =?utf-8?B?NWhFN3paY242enNXMWRhaE5yazV1akR0V3d3RUhweW0wQUVJZ3lBQWdUaElS?=
 =?utf-8?B?d2MyMFJGSFpEU01SZjc0ZGNXMG04OE9kZ3N4T2gzMlFqcnovREU1ZUVOdDg4?=
 =?utf-8?B?U280SVJlS2N2SVA1V1FIenRPUC9mLzZQT3NURURNVG5oYWVMZHdMTXJSWTdX?=
 =?utf-8?B?MnBjVjNtc0ZyMzZIZWphQXpQbS9TUzZJczJFdXg0RmZrQUVCeHFYb285N2xH?=
 =?utf-8?B?Zlkxc1V5UXlFbUdSZ05FTU9oM0NLeW1JVWlmQkc3OWw5c3VnbWpvVW5BcmVv?=
 =?utf-8?B?WnJmckl3QWxSY1BpNUhBcjJLRWtzU0lNRWE5Vkhqek0vbURzRFExNjJZcVI1?=
 =?utf-8?B?Z3dScWFPVjUvR2R2UzRXcERXa1UvVzhmMXVwL3ZnWUpxZlBveVZodjFndEw0?=
 =?utf-8?B?eW1idmMyS2t0TytPNlBCc0RzQUFZR2VWaVlpZmpUb2xsRE4wY0lyRGoxRENG?=
 =?utf-8?B?TVhtZ0VJekV4SXNKOWRUNFJJRG9PUjBCMlVrVm1mWkg5TmxRS3Z3L0Y3TlAv?=
 =?utf-8?B?R2QzQ3pUdVdUTGd6VVB5Y2VxSVJNa0NuTGdWeHRpdzY0c2M3djF4TXJrS2Rk?=
 =?utf-8?B?RWFLR3Z0L1JxTHo1dEowSHoxSGVFYzg0K3RkQVJDNHdqaHFIQlRVaG5tTWtw?=
 =?utf-8?B?WEcvYlFJZHFUM2UzOUhNTWRNdmMzV0xHRVRnc1IydDRWNm5BNSttL0gwZ0hl?=
 =?utf-8?B?cjNhbDltdTRaYXQ1dm50bEc3N01LN3VnU3pZNmgvbEtobEFHVyszVEFTMXp0?=
 =?utf-8?B?U0tVNjB3UU8zWnA4dkNhZ2VmZG9ob1cwb2ZmVXBKUHJFaUpnNmJTckx1NUNW?=
 =?utf-8?B?K1BidkpKMW9NSFU3TGh5VmNvblJERDdicmpXNEJtZEVDazBEMTdDWUF2Q3A1?=
 =?utf-8?B?VW1FaUJWNVBWSjFCRmhLQWtxV1czOFl5Q2ZLalZXNEM3MDgyZUdqK0krQndE?=
 =?utf-8?B?NGZuTWlrOHhaV0tsUUxyWXJ1RHFCOEU5bWdCNG1wUEZYdlJHR3haT3dZWmx4?=
 =?utf-8?B?eVo4THRyY1N0MXp6KzhIczgxbDZlUE5mYnJRSUJuTjhORVJ4OTM0dGNSUURS?=
 =?utf-8?B?VjVBQWtrVTV6M2NPTkhTZHh0VEpIdVRtYzgyOGtzNFgxRGdEV2h3QjZ1eUFR?=
 =?utf-8?B?b1dZNW5Za2hRQnVzRkF2b3NScDRSQ0dadEJaWXcwTDdoTUJqcTlRclQ0SnZr?=
 =?utf-8?B?Mnl1YkNtbnU2cmU2QmcxSy9TWTA0U0M3Z1l3VnJjN1g4TFhITXkza2d2Slly?=
 =?utf-8?B?UDVBejh5angvZVFpdXhjNTA4UzFla3BzMVBmZUlxbTZldHU2ZWtzUDVQSVpM?=
 =?utf-8?B?T1JLYXVhd3B0NTY4K3c5YVpqd1UwRm5wbWJtajhTT1pySUtpb1VDUDNGMlhn?=
 =?utf-8?B?V1N1dHBTeUhVVGt3MitWOHZBYmRkMG95WFVkazY3WmoxeHhHYVlickQva3p5?=
 =?utf-8?B?Y21CSkR5SEJ4TnRFaWlNaGJSOXdIQjZjUkJzQlFaZzlzZTFOZTg2RHVKR2RD?=
 =?utf-8?B?MzQybXlTeTd1QnIrNWlWSEdIOHhSTXVJa1FORHkzWkZtU0MrR2Q3M01jb091?=
 =?utf-8?B?TStqMk1WOHJ4TU1OTmFJTmRESFpsNkppaWVnTGlYUXlQZS9La2JNR3NiV3ll?=
 =?utf-8?B?d2J4bzhDVDBsSEhSR1ZFVVZtVHJ2Y1JPRUtTU1g3SWxLTC9PQ0RWenRzbkJj?=
 =?utf-8?B?QlkyMW5WditUc1haU2s0SFVYUVNqVDRiMXdabzc3dnV4eXB6d002eUs3WjBR?=
 =?utf-8?B?d2cremR3Rjdpbk9QOUNPT1VnL0dycHVqQm5NNzVOQ3hMdmh6NVdHS0cxbEx1?=
 =?utf-8?B?M3g5dXplUUNSczJycVArbnhLa09CRjFJaTRwWHZmTTF3OGsrWHRJWjJncmRq?=
 =?utf-8?B?bUluR1NwNEtKczdlbGdLbUt3Z1oxdnZwSWU3ejU2ZmpxUzZQNEZzVXJKS0VU?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22e8fc5-9f3c-4475-fa22-08dc946aa737
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:28:17.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Vsy3E9id2ol48UQ8j3uH9sg+lqVSrlJhY/XJ66ruRkwOQ3jSEPyWoy1cY0li0C7Mk8Zq26deIxaev7fudyZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7263
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Jun 2024 16:28:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16320

A new release of isar-cip-core is available.

133 changeset, 10 contributors, 12 files changed, 2679 insertions(+), 
820 deletions(-), these are the stats of release 1.4. This is clearly 
larger than the last one because we are exceptionally late with v1.4. 
Originally planned was spring, now it's summer, but there were good 
reasons to wait for the dust of isar and our own one to settle.

This release brings pre-integration of delta updates, see 
doc/README.swupdate.md for more details. There are many more changes to 
SWUpdate support, e.g. empty /var on first boot or a fix to work with 
the immutable dpkg database in read-only mode. Support for rootfs 
encryption, and you can switch more easily between the different 
encryption helpers, systemd and clevis. If you want secure boot with 
TPM-based disk encyrption, this is now officially available for a 
generic x86 target image. Last but not least: Our CI pipeline now 
performs an automated test of SWUpdate, including certain update errors. 
This shall help to keep the integration quality up. Find the full list 
of changes below - I'm almost sure I missed some important highlight.

Thanks a lot to all the contributors - and sorry for the late release!

Jan


Adithya Balakumar (8):
      swupdate-handler-roundrobin: Increase revision for Delta Handler support
      swupdate.bbclass: Fix setting reproducible timestamps for files in .swu file
      Add Delta update support with rdiff_image and delta handler
      swupdate.bbclass: Generate swu for delta updates
      doc/README.swupdate.md: Update steps to test Delta software Update
      Kconfig: Add delta update option
      .gitlab-ci.yml: Build for delta update when build_swu_v2 is enabled
      doc/README.swupdate.md: Minor updates to verification steps and additional information on usage of zchunk handler

Cedric Hombourger (1):
      recipes-devtools: use DPKG_ARCH=all for arch-independent packages

Felix Moessbauer (8):
      refactor: use change-dir to split rootfs parts
      update ISAR to latest next for dh-compat improvements
      swupdate images: initially deploy empty var part
      copy and symlink dpkg db to ro-rootfs
      swupdate: use to_boolean to compare boolean variables
      create audit log folder with tmpfiles.d
      fix(sid): copy immutable dpkg db
      use ISAR snapshot infrastructure for sid

Jan Kiszka (45):
      swupdate: Use prebuilt version on sid
      ci: Reorder rules to ensure they are all evaluated
      linux-cip: Update to 4.19.306-cip107
      linux-cip: Update to 4.19.306-cip107-rt35 and 6.1.80-cip16[-rt9]
      Switch sid-based riscv64 back to a snapshot
      Update Isar to release 0.10
      linux-cip: Update cip-kernel-config
      Update to kas 4.3.1
      linux-cip: Update to 4.4.302-cip85[-rt48] and 5.10.212-cip45
      linux-cip: Update to 4.19.310-cip108, 5.10.214-cip46, 6.1.83-cip18[-rt10]
      swupdate-handler-roundrobin: Silence fetcher warnings with different SWUPDATE_BOOTLOADER
      Switch to snapshot.d.o for ovmf from buster-backports
      linux-cip: Update to 4.4.302-cip86, 5.10.214-cip46-rt19, 6.1.86-cip19
      dosfstools: Use BPN instead of PN
      linux-cip: Update to 4.19.312-cip109, 6.1.90-cip20[-rt11]
      linux-cip: Update to 4.4.302-cip87 and 5.10.216-cip47
      Update ISAR to latest version
      Enable APT snapshot for reproducible builds
      ci: Append reproducible.yml unconditionally
      ci: Require qemu-riscv64 sid target to succeed
      Refactor tar.gz image option
      kconfig: Express dependencies on SWUpdate
      linux-cip: Update to 4.4.302-cip87-rt49
      deploy-ovmf: Avoid blank in network varflag
      shtab: Align recipe name with source name
      ci: Drop obsolete setting from reproducible-check
      cip-core-images: Make ISAR_RELEASE_CMD available to them all
      linux-cip: Switch x86 targets to new cip_merged_defconfig
      Generalize SIMATIC IPC227E configuration to a common x86 UEFI target
      linux-cip: Update to 4.19.312-cip109-rt36 and 6.1.91-cip21
      linux-cip: Derive PREFERRED_VERSION for native and kbuildtarget from base target
      Update isar revision
      linux-cip: Bump cip-kernel-config revision
      linux-cip: Ensure rebuild after changing SRCREV_cip-kernel-config
      linux-cip: Update to 4.19.315-cip110, 5.10.218-cip49[-rt20] and 6.1.92-cip22[-rt12]
      Kconfig: Fix and update security extension option
      ci: Only test stage when build stage ran as well
      Bump Isar revision
      linux-cip: Update to 4.4.302-cip88
      scripts: Address shellcheck warnings in submit_lava.sh
      Add missing wic file for x86-uefi secureboot case
      ci: Use small runner for CVE check
      Kconfig: Make EFI Boot Guard watchdog configurable
      linux-cip: Update to 6.1.94-cip23
      linux-cip: Update cip-kernel-config revision

Quirin Gylstorff (56):
      Update certificates for sid
      swupdate delete unused patch
      add SWUpdate 2022.12
      build swupdate 2022.12 for qemu-amd64-secure-boot-bullseye
      swupdate.bbclass: add scripts section to the swu file
      swupdate-config: move swupdate.cfg from customizations to own recipe
      swupdate: set SWU_HW_COMPAT
      swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
      doc/README.swupdate.md: Add documentation for hardware compatibility
      swupdate: check output of sign-swu
      sign-swu-cms: check if key and cert are valid
      doc: Add section about SWUpdate signing to README.swupdate.md
      fix do not add files to each image recipe
      format: classes/efibootguard fix spacing
      format: classes/swupdate fix parenthesis
      swupdate-handler-roundrobin: Add link for handler search path
      swupdate: Add recipe for 2023.12.1
      conf/distro/cip-core-*: prefer swupdate 2023.12 for all distro except buster
      remove SWUpdate recipe 2023.05
      layer.conf: Move SOURCE_EPOCH to kas-cip.yml
      initramfs-crypt-hook: Allow switching between clevis and systemd
      initramfs-crypt-hook: Align systemd encryption and clevis encryption
      initramfs-crypt-hook: move the mounting of encrypted disks in a seperate function
      initramfs-crypt-hook: Check if the TPM device fulfills the given requirements
      initramfs-crypt-hook: add flag to make encryption optional
      initramfs-crypt-hook: add e2fsck to avoid resize error
      initramfs-crypt-hook: split encryption and mounting
      initramfs-crypt-hook: Add check if root is part of the mountpoints
      initramfs-crypt-hook: split hook in multiple files
      initramfs-crypt-hook: Consolidate clevis and systemd scripts
      initramfs-crypt-hook: Increase version
      README.tpm2.encryption: Add section to switch from clevis to systemd
      fix: swupdate_2021.11 with efibootguard
      fix: disk formatting
      wic/*: Add part-labels to system partition
      initramfs: allow empty mountpoint for crypt hooks
      initramfs-crypt: Only resize partition if ext* formatted
      fix: use luks2 to identify encrypted partition
      Rename encrypt-partitions to encrypt-data
      Kconfig: Add option to encrypt the rootfs
      crypt-hook: Extend partition selection
      README: Add rootfs encryption
      README.swupdate: Add section about partition selection
      fix: Remove spurious '-'
      initramfs-crypt-hook: cleanup logging
      fix: Add missing mountpoint to crypthook
      encrypt_partition.clevis: select tpm2_device for encryptition
      Enable secureboot and tpm2 encryption for generic x86
      Add fail2ban-config
      Remove tpm2-abrmd
      wic/ebg*sysparts.inc: increase the size of the boot partitions
      wic/plugins/efibootguard*: Take --size and --fixed-size into account
      encrypt partition: Add support for swap partition
      swupdate: fix reboot progress with wfx
      encryption: assume broken_system_clock for e2fsck before resize
      doc: Add section howto generate the a efi auth file from snakeoil certs

Sai Sathujoda (2):
      deploy-cip-core.sh: Deploy .swu only if "swu" is passed from .gitlab-ci.yml
      .gitlab-ci.yml: Add condition check in .build_base to build v2 image

Shivanand Kunijadar (1):
      doc/README.secureboot.md: Fix incorrect secure boot user generated keys path

Srinuvasan A (1):
      recipes-initramfs/initramfs-crypt-hook: remove unwanted directory

Tobias Schaffner (1):
      swupdate_2021.11: Backport raw handler unmount fix

sai ashrith sathujoda (10):
      tests/templates: Include functionality based templates
      submit_lava.sh: Add script to submit the jobs prepared from templates
      .gitlab-ci.yml: Add test targets specific for CIP core functionalities
      doc/README.lava-testing.md: Add README to explain CIP Core testing
      tests: Modify the replacable strings and increase timeouts in the templates
      submit_lava.sh: Modify the script to handle only one job at a time
      .gitlab-ci.yml: Break current test jobs to run one LAVA job per Gitlab job
      templates/swupdate_template.yml: Fail the job immediately after unexpected outcome
      submit_lava.sh: Rectify the ustate value in case of a rollback scenario
      .gitlab-ci.yml: Add relevant qemu target in 'needs' for test targets

