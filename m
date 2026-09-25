Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD986C9830D
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 08:43:38 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3749.1790325810426753247
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 01:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KGn2fIhi;
 spf=pass (domain: siemens.com, ip: 52.101.66.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcbtPJLuuvvOpDGmNj7EpEK+wQFyWtnfEnXkAzc5WUtFg0LSvXn1WIbnbBgsGLs5gHA/VgcGC9wKcmCJcpMFqcH8IqtZRnP2FxiRP8IJ2AiHZNipDK9RVM9/Ul/hEomHwSQF2Eo4hBOfqGC8GxqqU+ZV1U6CdQ6aInkjC5mn7d9LDQDNH3LxVsTWRckOLJakGuUXiS4KPBBChfmgGGIK8YUH7LcuvZLv7MYY9wjy3n81afkG8Rwmr4N2cL2y/dfpfI07rf7neJECYERYZcDQagrEHLT+EnTHTWyLNeJ+apojyGN9KTeLxzULD2onqtyywmfsRzuRpCiF4ifl6yHyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSOc+Cq6mYcW/65mXRFXMoSQFVlpnO5Pr3FwlenJpOo=;
 b=o++bgnpraQH3SOuA37fIr3K9/QrrKCkgZ6XgQyQJEfrXg3DqK7GkMaTgjYPfXna4LSiuJ61cHYnxIfunEFVq7EtzXsV4XnVCvJFGjcmPqrCG1msbfBsACdHjkNsbkdyHNwWnyVZWPs4sq6DMZlRaftVVanyHle848mhsfb14tuNJ5mIYi743JvpxUvrHUiAndebxJ3+LkRelYnafMXjTjMHDw+FxaPDBqrYStFux1gqpfif3K9Bw8VHKPx1eEyn3fo0ciVKp1wA3aXxs9sh0y+ejJGvn9R5V/HvruBxHJvfwLckZ9xrBwqOtGZ333oXAPYqlpZsK85kdA72o8zQTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSOc+Cq6mYcW/65mXRFXMoSQFVlpnO5Pr3FwlenJpOo=;
 b=KGn2fIhizVqwVoIChjTX61Ss91O7GZ5QZiSQ0aGFwnO5Ux0FHfk1GNtz34579MHuSx8Mm52uvbGELbjakN1RXyfopkY24toWF9gy9mzp+sHFR1m5sYoqiLJHM+Y9QxqEesbPXRJj2JNLBmLDyCsW/lgauxeP10VrPcnZtpeDJRuaWS8qYlfDScHPVa2PXZwYL4JvNglNFZpFjyZujvwfeUejAFPUlKZdiaLD5EB9XYgkmUABOYY2LylBtCwrc5ID8Qz2lPubSG7cMMm8OEnCi5DeegWwIa0kpdjn1pChMQhw1nkVI95QMJmjrWCHegx1xaDZJpnRpKcBxkmIbicV6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AMBPR10MB9705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:763::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 08:43:26 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 08:43:26 +0000
Message-ID: <5351f96b-9ec6-49f4-a2b5-f484ecc9e7e7@siemens.com>
Date: Fri, 25 Sep 2026 10:43:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 00/13] Add recipes for image
 hardening
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, clara.kowalsky@siemens.com,
 christoph.steiger@siemens.com,
 Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 "kumar.dinesh.h95@mail.toshiba" <dinesh.kumar@toshiba-tsip.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
 <025b1ab2-1377-441c-8fb3-de47b7816fe2@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <025b1ab2-1377-441c-8fb3-de47b7816fe2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AMBPR10MB9705:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f60deb-a1c6-47e1-4333-08df1ae11102
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|3023799007|6133799003|18002099003|22082099003|55112099003|20046099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Qee3EmX268frfpHO59o2nZKR3z3RcnR9rqeknYI4Bn2its3FJ8nM1bE67xfv0jAXd5RofEYKamN/LsuCB8ksQQ1O7rtJX9M2NcGX/XnFTdczoHZ7R9iw1MFQJs1jVvrhZ+HYoR/EBDLkjXbDyQzAuKCcGWUwrhMnmzHgMuPG3FflfClMGEUOr9LskYLDReajf7KDkeE+qtYYng4dl0bJh5fFGigiDvu2i5uQ9WqByrcs4DEyymcx8QySymSYE+2tzkL3hQ3mmYL9fqoMcWml+yfa75bE6WTkB54sSTlWFpHLwyG820bQstYLYIwWV9nVpsx9+vcxkKwlaM71K3zeSCN9XEYIN8sXmzMA4QA4N61GeWdoC0c6+PyABZwYvXyIqebZkSrwZ9eCAAIBWeNX2uLGufAPBQOT0zyMHWIbqBlS71OL5SsdRGBilk7LpC7Eg+rXkzli5KEVWyVqbWDhXpSTa5axxPA4LoXNWN9mqrywVLLaEm3XKej/4dCKIxRqR8H+nkBndmlPG8bg19mTyvJ3QjUw1NX3olzEDggwgtuqHPRKNZq/ji+QGLGWwEvizUhcmZqLVczaHSlydQCAgrw8Ae/IGIgt1CGf8RsPnVUbY9x/yeP9IidCgu6LIvyBOlo1pcr7I5gDGhsdcCdoPQyjyeOOjgYADJeNuwp/9vs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(3023799007)(6133799003)(18002099003)(22082099003)(55112099003)(20046099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3NrRzFyWkx1cEFBRjBockhTV2M0M2FZRUxxU1hEbklQNHVmeUVtOW5zaWcr?=
 =?utf-8?B?UVhQT0ZCSHlGbWlIQzVRRGxaVHRNd2tOTk0zYzB5aGRia05sQ0NGNFVlVzY4?=
 =?utf-8?B?WWx0UHpyUWJtUFN2Y2JYS25hK25zd093KzhzYjk0aGdDWm9DYzg4ckY3SWxJ?=
 =?utf-8?B?cE1PcXNHbC9pZ3JhMlpRUmJVVTZCS3habTgvWVY5d1pRVTZKRWIxTjBKVzgz?=
 =?utf-8?B?cVVxUHM5VFNrN0FJcncwOHc5c2NOcDJSelVNR09ocUJEdFkyOVRwTnNRNmRn?=
 =?utf-8?B?SHJWNGppUnQ3dGtGcHYwU3FnSlBFNENudnNDSnpTeThpVWJGd0J0UThJdk1v?=
 =?utf-8?B?eis4Ny8xbXkrNVFZNGNCTHFEZ2pVODU4a24rRTZ6cktXZjFac1k2THZSSHJz?=
 =?utf-8?B?TTlFT3cvb0x4WDdYRjIyejFMczRKTnlMdDNFaTFUY3RrLy9Dd2RoaURuUU50?=
 =?utf-8?B?ZGlCL3B1cU0zUXplZGQvNjFTYlhvWCtOd2p0ODdmdDBXS0lGaUNrM005R1hE?=
 =?utf-8?B?ZHhueUxLQURmeHBpRDV2REtiUE9ERno1YUt2N0ZzZlk0cFl0TTc3c0FRNGlv?=
 =?utf-8?B?SVFrUTh0MHN4S2F0WGcxaGtSRndXU1FoUWhlSXNvY2JocEovZDdLTkxUeC9I?=
 =?utf-8?B?YzU1Q2MwckIvdURKRnRZTk9QaGwxZitqbFZBbEEvUnI4eVpNd3hvOVpXc29Y?=
 =?utf-8?B?MS9HczBndHhuZU5aSFQ0dlEvZFA0Q3lRN09wVzdHMXlINmVjVlcra0paR2NF?=
 =?utf-8?B?WmRWdSs3cTBBV3c3amRPcW45Q01Ua05IcFBYOHRjd29leE9YVGlJalBVSk1C?=
 =?utf-8?B?M093eXdwWlpVTEd0aHhQNFF6aytOcC9ocDQzK0lkVXdaZG9oLzRYNVVPTDY3?=
 =?utf-8?B?R2hhQytTbi81SXp6UlVpSWFNRm55U0ZTRHR0eXJzVzVWTk04dWZzTG9FWEps?=
 =?utf-8?B?aFlnRWJSbWJMTFJIT2pPVW9NMU54a0hqTUs3aGc5VW5ZM2todnRLSE54NCtY?=
 =?utf-8?B?M1ZONG4xSSs2dHhIRGhhaVVIaUZvMTNrQkV3RkpwYjE4OVJiQzZwRjhKK1Bx?=
 =?utf-8?B?ZWo0TE91SGx3bkFFdjExTVYzU2l3dWlxNmdlUndTMkVOTjJsamJnZENUNUE3?=
 =?utf-8?B?MGZxTFdzSFUrd0FTWGNPalgvc0xHZngyT21sR1R2Z1REblNzSXo1M1NDdldq?=
 =?utf-8?B?ZHhmditTM2RBY0FNQ2dXU2wrbVJEdFJPMHdoRzFFRWQydVVKVHA0Z0VicUdu?=
 =?utf-8?B?eGNmQTFSWklZellsNk8vblBEeDByS1dtaHdXemdkUzlUa0RiNGIyUnZHRTh2?=
 =?utf-8?B?SkF2UWd5bWd5V0trbEZoZklIcTdKSHFObGZzQzk4YVRmdCtlT2Z1bFNsQUg0?=
 =?utf-8?B?RWRzNUNVVW9Zc3FvUlVEejJsQnNTTXVLU2QyUXN2ckozTHpXYmdmSmRIWE1Y?=
 =?utf-8?B?UFZjSXhTRmVIcS9oWE02U2s4NktFanRjdUYyNGYzL0tkeTdaUUZBOUI0aWhQ?=
 =?utf-8?B?dDgxc0hIazdtWFBHcytiMEVmcnR4WHRZZDc3clFwKzE4SVIrSmhDSTNKQ3lR?=
 =?utf-8?B?emEydGFUNFZreTdpa3dBYWdnQXhWWXlpUDB5N3NDVHFnZlRwWmVJNHZCUWUz?=
 =?utf-8?B?d0lEV3VnbVAzQVBheXRwOXI3S3BocWRDQzVGWWREWHd0c29mR0E1aXhHYXpV?=
 =?utf-8?B?MjlyWDRuTHhGK0c3aVhFUFg3T0dQc2VKdE1jRFZVZzBjcG9OZ0p3RG5BWC9F?=
 =?utf-8?B?blhJVUJsUkJCSTBaM1BSK0FjMjNnUUovWkZKa3Bob1Jtc21yejdPZm1IL3lZ?=
 =?utf-8?B?UksxdXFOWFppMEdtUXBYVVFkVmROWmIvUml0K1ZNNGNjWmUycGt1dUlwVTdR?=
 =?utf-8?B?OHAvMkd4ak9vdSszQXJxNjhtcEQrdFJQNWVNc1NwZnlya09WYjBzbjRiQnlI?=
 =?utf-8?B?d3hBQ25WUmlzcjBxZlN6RDRmdmUvcEpJdGc1aW54ejhkZ3BJVkMzYWo0MFFO?=
 =?utf-8?B?ZHFXV0lveEFsZ2RvR1RxVVVqclJ6cGE2RHNFVGRwSTFMR0w0M2JRSGRObnBM?=
 =?utf-8?B?ekZUS0VlMmdlTFBQTGx3NE03WUNKeHdSR2R2U3JyaVBKWWsxemdjMWNpYVIw?=
 =?utf-8?B?QzZRelU0cWFIWEZQbUlEei9PcGxYY3IxWmcxV00xZjUvT0ljZlFMWlhJZFFD?=
 =?utf-8?B?dmd4S2c1VkV3OVN4cXVWN3o2Q3VJalpLa2Y5R3kzaG0wMDhyTWpEbVNPOFRP?=
 =?utf-8?B?di9ReTFySXJqVFNQaUJ0Vkg4KytnQ2NOOGtQTEJEVUUxcysvb2t6Mzc5VjdT?=
 =?utf-8?B?VGJFVU1CcXhPNGhPMmF6T0pNQ0dsOGhMd3VaSm04Rm1WNytCMjFNMDhvU3Nn?=
 =?utf-8?Q?Pla1a9WKEtogn6sc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f60deb-a1c6-47e1-4333-08df1ae11102
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:43:26.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JTAXx/aOAcBM2Atm6rJL2IUJxihMCwyMvQcsZq4+vUmyuq9C7nP0HQDwLNZhRMBUPoWUjPmb7ZntfkgRHdSUWUrWUTHuHdshPf/AmeacXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9705
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 08:43:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24346



On 9/24/26 7:29 PM, Jan Kiszka wrote:
> On 24.09.26 13:35, Quirin Gylstorff wrote:
>> This patch series adds the option to harden the build image according to
>> the guidelines published by CIS. The patch introduces the following packages:
>>
>> cip-cis-rules-config: user-facing configuration, stored in .config.json and
>> configurable interactively via Kconfig.
>>
>> cip-cis-rules: uses the configuration from cip-cis-rules-config to generate
>> a custom Debian package containing the necessary hardening configuration.
>>
>> cis-validation: an optional package to validate the hardening rules.
>>
>> Additionally, the kernel configuration is checked against the hardening rules.
>> This patch set is currently developed and tested for hardening level 2.
>>
>> Changes v5:
>>      - rebase onto commit 75c3ed7cfebf8ec5c79329abaeb7a9a50ca546b1
>> Changes v4:
>>   - rebase onto commit 6ced51c2993421738c86838832fcf37b9b2076f3
>>   - Remove redundant addtask for prepare_build
>>   - Switch cis-validation.service Type from oneshot to exec
>>   - move validation to kernel recipe to avoid issues with kernel config not
>>     being available during rootfs install or validation of a upstream kernel
>>
>> Changes v3:
>>   - switch cip-cis-rules-config to dpkg instead of dpkg-raw as it allows
>>     better task dependency management
>>   - remove json schemata validation during menuconfig read to avoid a
>>     issue were outdated config cannot be updated.
>>
>> Changes v2:
>>
>> - rebased onto commit 73d8558efc2fb49436aafac36126564c6a725565
>> - reorder patches
>>    - README is now first to explain architecture
>>    - layer.conf before arming
>>    - kernel and image are armed together
>> - use external repo for cip-cis-rules https://gitlab.com/cip-playground/cip-cis-rules
>> - menuconfig now uses devshell to be independent from kas environment
>> - generate config.json and kconfig on the fly
>> - bugfixes
>> - rename cip-cis-validation to cis-validation
>> - remove CIP_ prefix from variables
>> - rework readme
>>
>>
>> Clara Kowalsky (2):
>>    Add cis-validation to validate the hardening based on the CIS rules
>>    Add kas file for hardening configuration
>>
>> Quirin Gylstorff (11):
>>    Add doc/README.cis-hardening.md
>>    Add cip-cis-rules to apply hardening configuration to the system
>>    Add github.com/ovh/debian-cis for the hardening validation
>>    layer.conf: use variables to control path of hardening config
>>    Add cip-cis-rules-config to configure the hardening according to CIS
>>    Apply hardening configuration to the kernel
>>    Add class for validating the CIS options in the kernel config
>>    Add class cis-hardening for post rootfs generation fixups
>>    Integrate cis-hardening into cip-core-image
>>    Integrate kernel validation into linux-cip
>>    Kconfig: add option to enable CIS hardening
>>
>>   Kconfig                                       |  13 +
>>   README.md                                     |   1 +
>>   classes-recipe/cis-hardening.bbclass          |  52 ++
>>   .../cis-kernel-hardening-validation.bbclass   | 260 ++++++++
>>   conf/layer.conf                               |   4 +
>>   doc/README.cis-hardening.md                   | 283 ++++++++
>>   kas/opt/cis-hardening.yml                     |  19 +
>>   recipes-core/images/cip-core-image.inc        |   3 +
>>   recipes-kernel/linux/kernel-hardening.inc     |  18 +
>>   recipes-kernel/linux/linux-cip-common.inc     |   1 +
>>   .../cip-cis-rules-config.bb                   | 157 +++++
>>   .../cip-cis-rules-config/files/postinst       |  31 +
>>   .../cip-cis-rules-config/files/rules.tmpl     |  19 +
>>   .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
>>   .../files/scripts/config.schema.json          | 124 ++++
>>   .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
>>   .../files/scripts/gen-kernel-config.py        | 165 +++++
>>   .../files/scripts/select-hardenings.py        | 616 ++++++++++++++++++
>>   .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  23 +
>>   .../cis-hardening/cis-hardening_4.1-6.bb      |  17 +
>>   .../cis-validation/cis-validation_1.0.bb      |  52 ++
>>   .../files/cis-validation.service              |  11 +
>>   .../cis-validation/files/cis-validation.tmpl  |  65 ++
>>   .../files/generate-overrides.py               | 103 +++
>>   .../cis-validation/files/postinst             |  52 ++
>>   25 files changed, 2772 insertions(+)
>>   create mode 100644 classes-recipe/cis-hardening.bbclass
>>   create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
>>   create mode 100644 doc/README.cis-hardening.md
>>   create mode 100644 kas/opt/cis-hardening.yml
>>   create mode 100644 recipes-kernel/linux/kernel-hardening.inc
>>   create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
>>   create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis-hardening-to-kconfig.py
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/enable-cis-rules.py
>>   create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
>>   create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
>>   create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
>>   create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb
>>   create mode 100644 recipes-security/cis-validation/cis-validation_1.0.bb
>>   create mode 100644 recipes-security/cis-validation/files/cis-validation.service
>>   create mode 100644 recipes-security/cis-validation/files/cis-validation.tmpl
>>   create mode 100755 recipes-security/cis-validation/files/generate-overrides.py
>>   create mode 100644 recipes-security/cis-validation/files/postinst
>>
> 
> As usual, one thing is always forgotten: I didn't ask for CI coverage so
> far, and it looks like this has none, right?
> 
Ups I will send a v6 with some CI integration on QEMU. Build test only 
or should we add some additional lava jobs.

> Other than that, this looks technically OK to me now.
> 
> But before merging this feature into isar-cip-core: What will this imply
> towards users regarding future maintenance? Right now, it is constrained
> to Debian 13 due to the availability of rules. So, this version would be
> the minimal one to maintain, at least as long as we maintain trixie.
> Does this / should this imply support for forky as well once that is
> released? Has this been discussed already in the Security WG or the Core
> WG (don't recall for the latter)?

Yes as the rules are updated  we should have some process to update 
rules for forky. There are even point update for older versions.
> 
> We can - and probably should - make this a topic for Prague as well. But
> then it very likely be a feature for the next-but-one isar-cip-core release.
>

yes we should discuss that in praque, especially the update process 
onwards.

Quirin

> Jan
> 


