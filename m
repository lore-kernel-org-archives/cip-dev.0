Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3F9C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 12:00:44 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18558.1789387242139426587
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 05:00:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NLsp30wk;
 spf=pass (domain: siemens.com, ip: 52.101.65.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbBoSfQH8Lv3mmqGfgziDbrw7ddKNJXZQEZpO7OTmWSSnxd+XMC5nmflgEtRBU2ZUQt9e9zyE9ktMpD4LI/sAooVzmm3j8JUU3aRNapDREv5vPQfGZ2CiY+4Af4KHmHVHr2G9tQcHf0sVD3WNULY7qg8JVI7K+KjExyzQDp4MkeCh4VztnVDkAwfVNojAcABTct93oXN3es7NQVxtGmwr7kjAEIVr12ch9g8m4kmz/XauPO53e6VsVsF/6rF7iETloaVW2ZwBynfVp1rczMg5iCvsEHJK7Jx3yKUQPsEph5pvYwUwcsX/m1I4JAcIX1IUjOTvl9aJlXiHuKCa3jMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkNfUQFPsGp5fdaASFAYno5p4TavtJyvY7paikZZBYo=;
 b=KLDdFyL3lRQ9USOkw+ClJmFjXF2TaCAitnWOzU5jn46l+v5JSeE7li5MYXHkBaLBC6tIhRSzv0rXbHppeHPq3VxhetVwdjjfAd9K8PTk8Tg/tTdLZPs7qxbKTVyLiuFsIbJy8KrVL6VTY94KfPoCn/B25cMZk8OxG6qs34RLc0glzVoLzpgCZvfuqDYfgHneqA74AYNQPtZBzQgQ1/xPCZgtbNhOHj+a4uYSo3ZixBo/7tq4I+tjw0c9arrRXRlDr1WcUUBBc1+7ds1/QXg44vYLzqvjkn1GVum2Y6ouK3re4B1rz4X1w2z0ChLZW19PdYTcT5p/+/erv5Y9I5aWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkNfUQFPsGp5fdaASFAYno5p4TavtJyvY7paikZZBYo=;
 b=NLsp30wkkNbX8he2PEP1ww3GaFWKlakLiNnneAXtqgmc57YUTBtcP7VX6c5w3CaL9B2dlvjNxJYr6kaacetNOpc3yJ+TqC5W7hH358Avi7hC/tMXIrRrrAuFMxt0BP4h/hiNnaG4zCBvFth0d0ng+6KqVhv+zf3kW2nc4mInqdtCkM4kHzZHlvKz7Hl6AmrRkIcVsB9FktVQwnklase/yEX6FFNAbpjjHq2qPjqOOnBq48bYYQxVRa+MTCm4w6iwTjiujA0EUWH2whXMxId0BwLDwdAoaqpv6D+IMGuCi0nM0yUgI4wdfkxnvJpUUpPfkSmnBWmn23BZbV8Erwkbfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AMBPR10MB109479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 12:00:38 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:00:38 +0000
Message-ID: <aeffe361-de7e-4f99-ae4f-5ed840b5955b@siemens.com>
Date: Mon, 14 Sep 2026 14:00:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 04/12] Add cip-cis-rules-config
 to configure the hardening according to CIS
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, clara.kowalsky@siemens.com,
 christoph.steiger@siemens.com, dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-5-quirin.gylstorff@siemens.com>
 <88a055fb-6ecb-473d-a0c1-f0659a0c6c21@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <88a055fb-6ecb-473d-a0c1-f0659a0c6c21@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AMBPR10MB109479:EE_
X-MS-Office365-Filtering-Correlation-Id: bb35b032-b792-49a2-ae75-08df1257cae9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	5RrI/zDSuOO1TllbhKZIw2okPawh/O1XUoTwsDdN2tvBSruwTy3wiFB3S2gAMMOU9KCT5th4J8UKhvS6+MRbBGvjoPVl26wGkVK99NSNJbd3Erg2KToQT0n28Tf8iR7+MXyHpCvPVgR49P7snXEX+4vVylzY8GzJVmjuwLO6HYfLgmj96dFBNcizj7pvazKmHuAEJ7hOhhPK9d1gO+ztVIZYTkx7V8X/awFpqTDOci6Xg4/LxCKQ0uXhBy0tGQqQqbODLIdEC9eVacuh3qHB4zF0i5f/LnZY9gl40zy3Q8wUf+MqvGAJdGeZx9QDZHp372E3iAmGVyFLx1PhJ2fR0s8mdhMby+Fm62P1STjEtdTAbf6ZEwsuvJ9HeceWp6R+ZMc5RCLHaQLCAr3Zc++e0WMp4uXUzzaDifLyv5vnMJxnDK//VZXu62xg95NbYfcz6Dy5WntV4e9ARHDA/eXuLmbcFx+74Gfvp1uYqFBAhxGUPLcYD0N81XKZQ1krrBWvKAO86JA+pOSdyivvnif2c1uLdFTwaNPMA/uahCk+k51vuIBizDZKSR9IVpup5vHSzqDBXP8Fczntssu4md49oMCn3eqthsuswEpc4B/iiG2q4nqzHd4FWUOJNEdZ03B/SGULBkfqS1ER3gHBbJ+9yKnZcCMF1Dbz5VMFuF/2Bqo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFVtTDUyWmVyZFlkeE9CR3NOL2xWMmwxZ204M2MzclZLYUlhU2sxYWxDZHJo?=
 =?utf-8?B?eW8rZTRZNTEvQkNBSnByUWc4TWJscWtiREVQeTNwdmFxYXJLR1hKaDBqenBJ?=
 =?utf-8?B?WTFQekhFWi9PZFZUcDVNVmVSemFCT2dTR1dmVTBzWml2WDhuMWIzbW9nb2Ja?=
 =?utf-8?B?T1ZiVFBOZ25DQWRoY3lkODVxcW55cVhZQUg2T3BCUkQ0MXJHZHVFNVp0d0ZR?=
 =?utf-8?B?NnoyQjFGM2IxRTd5TmhPQUJRYm9WMnN1ZEVibUp0YjI2R3ZCWlJaVVR6ano2?=
 =?utf-8?B?S0Mwa0hsdmlpQU1XUmRmcjBFYzhQMlppUm84WXNCSUJURWxZSTZyRktmdEJ5?=
 =?utf-8?B?aHJ4OFdTNS8xZVkyTkk2R1V5L2t3UmZmR3N0aEt4MjBYS2tTUGUrc1h1Kzd5?=
 =?utf-8?B?eEx4M1h6ZFQyZUJvTWVHSlFBQzNrSEd0V0N1N25HQjRlMXZhT0JGeDd1bnMw?=
 =?utf-8?B?UW55SGxDb09kdFhqTXgzUmQrVko5R3VXVmg0b2x5NXVndmx4N2psRDRxUXF3?=
 =?utf-8?B?UzlSOUxlRlhXbjFWZHh4K04zWnp4M2JtVlQvMDFPc215UHNNTnN6SWhkRE9J?=
 =?utf-8?B?SEVnZGx2VDFlU2x3ai9yK2F0dEpEUHJ1Qld2alJURTdXSG5SWWREbHNzSXEv?=
 =?utf-8?B?bytWTnV2Y2NKdUVKeXVKOWFHd0MxRXkrK1pZUUZ0dkxsWGZ2UnVqakpHVCtM?=
 =?utf-8?B?cTRUcXZGSWVCcDZkYUY0cnBYd1Raemt2dFo4ZmVlRWVmbm5sbWZVN21nL09z?=
 =?utf-8?B?T0YzZVExay9JRGtQY25zTnlxRlo2NmVsb3BBT1BKVGxXbjZtNkZhcVNjN1E5?=
 =?utf-8?B?VEY5bG1GaHV4ZG13bVJsVFFTQ0wxQ3ozU1QyakIzRHdkUEh0ZGY1TWN2dTBr?=
 =?utf-8?B?QVV6bHh2V21FeFk1TnlTcjRrZ3owS1AwMWZXNHdOdFNzaGRIOHdUSEhJQWVa?=
 =?utf-8?B?aWdHTGJuUjZ1WXlCRnZJdnpBUUhMa2xiVzhwVzhuR0thVjZUV2R4Q3I1OFlo?=
 =?utf-8?B?ODJpRit2cWFxWk9oUzR6VHNMWVkrNXVoSGU2VDU2SVpKa3JIdStNMHRaakhI?=
 =?utf-8?B?dmVMdDRIVXRKMVM1Tys1NGRkTWlYRkVOSmtRZWVGQjlFRUtnVFZtTkxpS0NU?=
 =?utf-8?B?VkJhamtyd1FFLy9HK0k4RGVIUmRoZGJaU0NSbTNUaWFJeDYrNzZIYWN1MGtF?=
 =?utf-8?B?Njg3RDY0VHJzYVhiMmFpQU9TVDF2WlRQZkd6anFNNXZRWXJmMTEwWmRKSmow?=
 =?utf-8?B?dnM4ZkhzMW5ucUd1SUVtdDRjM1dKOG1vb0UwYVhPSlBTN0hzalRrSUNWdFln?=
 =?utf-8?B?SFp4b3R0WUNneEw3cFVWdjJHZ1Q4cjBxQWtMZGhlekl2VUhsanJaaXVSYmJk?=
 =?utf-8?B?NXhEazJUSVA3ZnBlRXFBNmJNWnJ0RHZ5Z3FkaVlGWll5dVlTTElTQTh1QTNs?=
 =?utf-8?B?THpMNmZmZ1JLdEpqTHVna3hWQ0pnS0ZJU3NialMrU3NQWkRjLzR2RWlUNFNv?=
 =?utf-8?B?UEdESy9HQmV4Vzk2NVc3bC9iSG1LZWg5ZW96VFYxUHRHN1BnOE02aCtRYXgy?=
 =?utf-8?B?OWRrWmNmTDhSNUlPbnJWOFF4ZTJyVTgvdmxJRzZmdWd4dUNwaVduUy8vL041?=
 =?utf-8?B?Z2xRcm9iUWw4RWg4Ymt2V1dpZVExb3F5K2J0UnFrM3AwQ1RPblNMSFdqQ0dU?=
 =?utf-8?B?Q0lzTTBEZEZ6TGR1Y0Q2b3FyemZxV3ZSWnlKY2xINUxlREdNRElTY21nM2VZ?=
 =?utf-8?B?QjJjM2lRdjEzS2F3YXFsUEpPVTlxUytVbTJMVUJNS1RGQnN2OEN1NDh1OC9k?=
 =?utf-8?B?cHVheU9DQnhnR0Q1Rm9hcEYzaWxLUzFUTmFlOUJlVkdobnhRbkthdTFISFk4?=
 =?utf-8?B?eVFyZlQxbHVHU1Zmb3Q0UUROb3RhZW5LSXdrR256RDN1NTg1alN2SXVIMnVQ?=
 =?utf-8?B?NWROSU05Y0FiTUFmU1hDUDZUTWNvQUs1emVaY3VoSFV6b3YwK3lGL2FBcUxP?=
 =?utf-8?B?TnB1Z0NBMmh0VkM2ME1aV2NETFZOWDg2TS9mbkdHbDV5Q1BYd0hJMmI0TXkx?=
 =?utf-8?B?VTc1NTRmcmFIbmlzOHJpbFVlMzE1Z29Sem05R1prNndSZUt6WjA0SlpsOW9Z?=
 =?utf-8?B?Q21pbVc0UTU2cUd4THhDUnRVVUZRS3lKdjdBMnFsU3NrOWUxdnZyUm00dzFP?=
 =?utf-8?B?OTB4WU1jeW0vbHEvZUJVemxqaG8zdXhWOS9UbVNBeFBsaENtanEwWjQ3cGQ5?=
 =?utf-8?B?Mnp2dWEvRTR0T0NNakpaTkNaM2pvVzFKV0hlcXJGK2pOS2k3NEZySCtpemZM?=
 =?utf-8?B?UklUMmN0UjNDZE03S1hoSkFlSUo4MVZXcEZDNUZ2TndsVUdyM2IzclZUWFJm?=
 =?utf-8?Q?pAL9ptd0GZ3RZQGI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb35b032-b792-49a2-ae75-08df1257cae9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:00:38.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RF/e3MyGi6k0uVsPVy610ycYmd/5WuaC16lCL8nmzy72K/m3T95LSMGNWx2x7cUiKeoLGSRzHUrsLPwAcsvb/qL2xmTnQUm+E5U1MQeK5mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB109479
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 12:00:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24172



On 8/25/26 4:24 PM, Jan Kiszka wrote:
> On 24.08.26 11:46, Quirin Gylstorff wrote:
>> The `cip-cis-rules-config` recipe allows to create a use-case specific
>> hardening configuration based on the CIS hardening rules.
>>
>> To tailor a hardening config the command `bitbake -c menuconfig cip-cis-rules`
>> can be used to generate the hardening config interactively.
>>
>> After the package build the generated config can be found at
>> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}`.
>>
>> The package also provides a kernel config snippet
>> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}`, which can be used
>> to apply kernel hardening during compile instead of a runtime
>> configuration. If the user changes the config.json all followup jobs are
>> tainted. The code for this is from
>> https://github.com/yoctoproject/poky/blob/077627338ac18aeca34bfe0c52777fab38e2e0c0/meta/classes-recipe/cml1.bbclass#L37 .
>>
>> This packages generates the Kconfig out of cis-debian.
>>
>> Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../cip-cis-rules-config.bb                   | 159 +++++
>>   .../cip-cis-rules-config/files/postinst       |  32 +
>>   .../cip-cis-rules-config/files/rules.tmpl     |  19 +
>>   .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
>>   .../files/scripts/config.schema.json          | 124 ++++
>>   .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
>>   .../files/scripts/gen-kernel-config.py        | 165 +++++
>>   .../files/scripts/select-hardenings.py        | 616 ++++++++++++++++++
>>   8 files changed, 1798 insertions(+)
>>   create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
>>   create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis-hardening-to-kconfig.py
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
>>   create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/enable-cis-rules.py
>>   create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
>>   create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
>>
>> diff --git a/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>> new file mode 100644
>> index 00000000..686fbfdd
>> --- /dev/null
>> +++ b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>> @@ -0,0 +1,159 @@
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +inherit dpkg
>> +
>> +MAINTAINER = "Christoph Steiger <christoph.steiger@siemens.com>"
>> +DESCRIPTION = "Configuration files for CIS hardening"
>> +
>> +PROVIDES := "${PN}"
>> +DEBIAN_PROVIDES := "${PN}"
>> +
>> +DEPENDS = "cip-cis-rules cis-hardening"
>> +DEBIAN_BUILD_DEPENDS = "cip-cis-rules, cis-hardening, python3, python3-kconfiglib, python3-newt, python3-jsonschema"
>> +
>> +PN .= "-${MACHINE}"
>> +
>> +S = "${WORKDIR}/${BPN}"
>> +
>> +DEPLOYDIR_HARDENING = "${WORKDIR}/deploy-hardening"
>> +SSTATETASKS += "do_deploy_hardening"
>> +
>> +HARDENING_CFG ?= ""
>> +HARDENING_CFG_NAME = "${@ d.getVar('HARDENING_CFG') if d.getVar('HARDENING_CFG') else 'config.json'}"
>> +
>> +SRC_URI += " \
>> +    file://scripts;subdir=${S} \
>> +    file://rules.tmpl \
>> +    file://postinst \
>> +    "
>> +SRC_URI += "${@ 'file://' + d.getVar('HARDENING_CFG') if d.getVar('HARDENING_CFG') else ''}"
>> +
>> +TEMPLATE_VARS += "HARDENING_CFG_NAME"
>> +TEMPLATE_FILES += "rules.tmpl"
>> +
>> +do_deploy_hardening[cleandirs] += "${DEPLOYDIR_HARDENING}"
>> +do_deploy_hardening[sstate-inputdirs] = "${DEPLOYDIR_HARDENING}"
>> +do_deploy_hardening[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
>> +do_deploy_hardening() {
>> +    if [ -f "${S}/${HARDENING_CFG_NAME}" ]; then
>> +        cp "${S}/${HARDENING_CFG_NAME}" "${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}"
>> +    fi
>> +    if [ -f "${WORKDIR}/hardening.cfg" ]; then
>> +        cp "${S}/hardening.cfg" "${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}"
>> +    fi
>> +}
>> +
>> +python do_deploy_hardening_setscene () {
>> +    sstate_setscene(d)
>> +}
>> +addtask deploy_hardening_setscene
>> +
>> +addtask deploy_hardening after do_dpkg_build before do_deploy_deb
>> +
>> +do_check_config() {
>> +    if [ ! -s "${S}/${HARDENING_CFG_NAME}" ]; then
>> +        bbfatal "Hardening configuration is missing. Please run 'bitbake cip-cis-rules-config -c menuconfig' and include the generated ${WORKDIR}/${HARDENING_CFG_NAME} in your SRC_URI and HARDENING_CFG_NAME."
>> +    fi
>> +}
>> +addtask check_config after do_unpack before do_generate_kernel_config
>> +
>> +do_generate_kernel_config() {
>> +    if [ -f "${S}/${HARDENING_CFG_NAME}" ]; then
>> +        "${S}/scripts/gen-kernel-config.py" --config "${S}/${HARDENING_CFG_NAME}" --output "${S}/hardening.cfg"
>> +    fi
>> +}
>> +
>> +addtask generate_kernel_config before do_dpkg_build after do_transform_template
> 
> Why do we check the kernel config outside of the kernel recipe? Wouldn't
> it be better to hook in our (or even all) kernels that are built under
> CIS harnening regime?
> 
> This also inherently limits the check to CIP kernel recipes, possibly
> requiring extra work downstream when they do not derive their kernel
> recipe from ours here (there is little code in it, it's easy to
> replicate from scratch).

Did you mean to comment another patch ? generate_kernel_config generates 
the configuration snippet for the Linux kernel. If the snippet is used 
is up to the user.

There is no check cip-cis-rules config.

> 
>> +
>> +do_prepare_build() {
>> +    deb_debianize
>> +
>> +    cat <<EOF > "${S}/debian/${BPN}.install"
>> +${HARDENING_CFG_NAME} /usr/share/cip-cis-rules/
>> +hardening.cfg /usr/share/cip-cis-rules/
>> +EOF
>> +    if [ -f "${WORKDIR}/${HARDENING_CFG_NAME}" ]; then
>> +        install "${WORKDIR}/${HARDENING_CFG_NAME}" "${S}/${HARDENING_CFG_NAME}"
>> +    fi
>> +}
>> +addtask prepare_build after do_transform_template before do_dpkg_build
> 
> This task already exists - why not simply implement it and rather
> re-register it here?
>

Will fix.

Quirin

> Jan
> 


