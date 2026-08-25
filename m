Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E023C61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 14:24:57 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23266.1787667886760197202
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 07:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uGgr9Bzg;
 spf=pass (domain: siemens.com, ip: 52.101.66.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqKt12S1VrDxUBrINWlSB1igmTTUJzGw3NCgp/GnNv2yRR4GpyjiT6EEerrcJMlvitITybzgXtwbTeWOqfd6HWo2MRfQFfUbP+3uP6/yk8zjHC4DmuSop04A0qOqeq/AULb5jdHnBFpuzUKDoApj6KYC2kJvdbI3GXjwF9Du0yfMhikC/3kVfYcFIDjHFfVQrgIoTMDMoOqLGMpRZwTp7kLDSAr9qQcvQtb+S6NthJsVBxaOJz2tTL/SR88JhXFMju+Pi0MlUYT51mZHswKhdYx6EC2mB2XFyVth7GlryHh+FNAe5jS/fkVemEhvdvlFCfkfJWwtut+/c0EKm9Q0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2dB9QQYUIWOtntqxz1XXG1fxPgU7jSK4xOKd2w0kuI=;
 b=IwwKFCCdgjdYSZEvVDDyit4yZ5sD5EFvlBV2IVsesdHlriRyMWHQbm4aM+s0wu97+tte0XE65L1MEOnQlksExwpxpKfH0hE5BEnx6hXUvlwfjxUPV88JG4MvDMdPwSvvh9wq+u0093BKkk+EeimK7GKg34HLk96UeFEEDKbotqGjOiWJB7ZxLyPCxWd+VdeBWZq1t5yFu/RQiN3TvkYLPCvbC+rz+yeY42dqJjKBX1aJWpL5fkSCGbT+ic8ov+ahmZW/47jPkbw8GSz9+VhVLq+ofKKG+/EfN7vzlKm3tSpsWs2q9yTs847BGq0eAIa1K1HM4r5harHGz5l4we0mFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2dB9QQYUIWOtntqxz1XXG1fxPgU7jSK4xOKd2w0kuI=;
 b=uGgr9Bzg5FSayxAAA3FBGGm7h+5sMGlAY3VCaEGToqZ/6lYNxUiPS9X6mPTBzBC6ORCPA2fVgzm/9VcsZEOw9s8MnZxcmxTbsyemjeWp3EhVVtxYe+u3NFeh+r8f0Ig3RvG5150kM53nxg/v8+/uWMgn6V3z3E/xgsms3pmvO33w3bfE9DcQee8N2DfNB/TO5+/E3mw8y/21FrZsmb0U5JvvQ0j7rCidtaNSlB2P4b79D4sGXe9Y1x4q0tXjYX14sPvNdSZr/fI2Dytvn71TEbru2RIZspmIomtHmPFU7Tpii8TJmpU+VjS/+cbMg7XnKDfVcTCxTVmHxcobEqh4Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:24:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:24:39 +0000
Message-ID: <88a055fb-6ecb-473d-a0c1-f0659a0c6c21@siemens.com>
Date: Tue, 25 Aug 2026 16:24:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 04/12] Add cip-cis-rules-config
 to configure the hardening according to CIS
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com, christoph.steiger@siemens.com,
 dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-5-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260824094721.2636375-5-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8f188a-88d6-4274-de91-08df02b4992b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	dWY/wbNo1s7D5pjoaS5MSDrXt4hpCaL0wInqHl7TC8ug9GPBhJANaYEFK3M94GXqznoaP+/UJ+WqU90hz7M/3VVw2trD+s58OUognzu8DBBExzU7yQp0+kW38Q/CJpQ2oltmWA4y9C/fQn4zDFmQKEsn5y0VjwfTS+zKEmB/sVd5g0MdrjtpnoZpM7dpspXyN9T7zv8oaBTVA4/N+V7rE1ooDXHPfwliYGUQWSyPt9+T/xDmf01FzT99DmOl0HNL6o9SeCi7WjSuTO9hUkUSvnpDOCYLGauMIBx8fHqC9b2/RBsM5DxxCR0r/jqvzlyXt+niw4MVuSxBCH8f/tHvKuDem9AwqiirYe/3Y3RHx6t4l1ZWfuWj7th0tpuj2At/aoZbS9gfiLx/we//JelQMYqNjfEUAgPV+AzA6qDa2U4RTB14hKBqKOzUSmWqyZepgQDQizrdgTftXWfn19VvD8eELSn2jmxCQOFenCJIAk7nVcCtlRKgQajWBjBxd/zZxJNp5MseWVWBiZELKF2YhuCRWsDnWLnTFTI80ERuj5je5JMOLCZhba+fHK82UUVk0Hx1RmpFaxSIslI0M5ko12kCWaP8qfSA5QEvL6yjMAzi47VtdJ0svTxzbiGssH/6NFCS1w8L+4+UQkoon6mInAbOEps058OEaAead3eOB04=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emZheFVpaHlaOUJtTXdYNENOdDV1N2p6ejlNdWpPZHZma1ZRRnpidEhhRVBw?=
 =?utf-8?B?MFl0WVdBYlpPZ1VpTytxaFhReHVJR3FLVFVRa3NpcU5VNVY2UWFvby9kZFNz?=
 =?utf-8?B?UVVzM3dIWnp2WlR1aWhTMWVQbkI2ZGkxRlN1d3N0VkhRdk5jV0g3Tms4RGVZ?=
 =?utf-8?B?S3gvalNacGNuWHBESm15YXQ5NExnMUM0UW55aldsUVVXcTFQbTdqN3N3VXF3?=
 =?utf-8?B?cTRNUktFd3ByL0t0TmVpZkIwZVc2YkdkQXBIKzhrWEMrbkZRdm1uVXF6VWQy?=
 =?utf-8?B?ZmhTYVhhRjZpVFFrWGQvY0hXNWQvY3YvMEJaSk1ZcTVJYmVTME00VVlwSENh?=
 =?utf-8?B?VlJ3bWdlU0VzTkIvVXY4Y2ZYcUUzMVBNMzFSMERwakU0MVJGdnJjdlc0VFB4?=
 =?utf-8?B?OTNQcXpsUElJTitoem1xZDRGYzZCWXo2b1JpNE9zYVZoQjA4dHdOWnJ6NFdV?=
 =?utf-8?B?QStHbWw4b2pUMUppZlYxc1Zkbng1QkhaUGkxeTN1Qm94emNTRjR3MXZQeVpP?=
 =?utf-8?B?RjAySmdvUlpRNHhXVVdZRWlXNUFuOFB5ZkFXMWdHZ25rOTZxSXptR1R4RFBw?=
 =?utf-8?B?MHc3Zmt2ZXE0NDhLdkpYT3hzN241ck8weUY0c2pOVmQ5cEVnVjNPaXRzZWhy?=
 =?utf-8?B?WjlaaEc4OFcvVmpIN2MzRFB4R1VWSE1xYWg4cEI2YVVCMHkybVZzV2Q0NHdR?=
 =?utf-8?B?RVEwUXBaeXVLVWZTamtnemhBOVN5bnU2VklYOXltN3VMak9GM092TEowMUMx?=
 =?utf-8?B?NWJIb3JFSldLdXc0VGFEajdCdFdkK01Sa0szdmJ2bDhOODZsajdBMTMwTkd2?=
 =?utf-8?B?YmV2NUlydnhvZFp0eSswOVowclFmYko1eVJYdnJwMklKTWltRzdIbnNXcHpR?=
 =?utf-8?B?MUdMUTVQWWJCTXVYMDZvS1ZuRko3SVZyR0VUVmExZmYrM2IwY21NdmpMNnF1?=
 =?utf-8?B?V05FYytDSEp5ajBUT09oZiswNk9ER1M0RDlUc1FLNC9pWkVPeUZvZ2tDWXF3?=
 =?utf-8?B?OXlBZHBXdy9nbC9KcHArNmJNK3BHOS9USlc5ZGVaOHhhOTJKZXI5aWQxQlkx?=
 =?utf-8?B?THQ4V3hXNmJhWk5tK2NxMG9BMW9qS0Ewc0FQSFlVZzZpQytPakg1aURqa2oz?=
 =?utf-8?B?TVVXUDRKcUJxa2dpQ3JwalZMZkxnaXEzNWtLNklDbmUyYzlQVFF5RE9kbHAx?=
 =?utf-8?B?VTdBRHpYVklKbXBtV0p3c3JDeVE3Zm9lbFZkZVMvQ2JIWlRyMFJUUzBNUnJZ?=
 =?utf-8?B?VTBtM2ZSUkNnMlNUcmFVT3UwS1QyeE9EVVo3eEZjS3A0bmRrZml4MzlpdG9J?=
 =?utf-8?B?T0IwNWRMRUF3T0JNK0drOVh5US9CVVZvS043cmVEcmRoTjhVTldySDJEdGZi?=
 =?utf-8?B?VG4reVBlYW9vWElVUHZiTkpYNFF1U0xLRjRDOXNhMnQydWZuVzY4eXM0UVdN?=
 =?utf-8?B?aTZuSnZZUE5FWFBkUnJYTDRtSW50QkJkbEliMERIWUlKMGhnNFNHd2pILzJt?=
 =?utf-8?B?N1d1dVJBenZra3pnMkd2ZW56MlY0M1R5ZmFTTVZOK0t1d204VGlVUnZ0R2RR?=
 =?utf-8?B?eWdKVnIvYzhWVzZCb0FrN2M3cDVEc1RDZGFnMktMYkhqczhtOEhFcjVBTFV3?=
 =?utf-8?B?cFJBQ2pIbEZ0NndQM3BJSFNVRER4VEpoRHFQWGZIcHFKSjYzU0pLWVc1S2E4?=
 =?utf-8?B?a1F6MFdacFZyMDVkRkVFZmtiL2hCQ3BrVERIb1JyM0RxOWk1R0xDLzd5QVlH?=
 =?utf-8?B?WUtyRHoxbjNLNThVWVQ3L0Vnb3JYWWh0ZmtlRkJHTmJNQVc2L3hnTG1JM09Z?=
 =?utf-8?B?by81UFRQMjJEeU5heUJTY2ZnYStERVRiUE1wdjFrWWQ1WXNtT2EveElsVGd0?=
 =?utf-8?B?Vm5NeHZqcUMwMDIzZUN1S2ppRDA5TGZQc3loU1ViUDNUZzQ4ZzJHMG5GUFRJ?=
 =?utf-8?B?L3lSYkRIOTR1YXJqL28yV1ZBNHlneWZIU1RKNU8yaThUVXlVL0xFNWtENUp5?=
 =?utf-8?B?U1pnNVZhOVhZd0lpQzUxaTVwMDYxZ1l4b3lBYjBMZmN5WGdxdVh3YlRXV3hp?=
 =?utf-8?B?c3M3VjBLVTE1ZkkvMkJMNXJQK0t2d3ZLbUZhZ1FHdFBaamh4bnVWVjFhZTI2?=
 =?utf-8?B?TlJGNWxiTWZ6cFhHdUc4Z3ZXUEhjZFlrdkxacDAyam5pUk1uOStqUXVsVHRz?=
 =?utf-8?B?eE8xbHFNbzF0UGRzY3RFNVFDQ0FRRkhjN1Vsc2lRQ2hhaTRSOUpNdzZLODVZ?=
 =?utf-8?B?dmlDWmd2UjlDRzlLN2Vuc3VPL1Q1dTJaVHBmT0trYk1lKzJseXVtYllUQ3BB?=
 =?utf-8?B?VmYvMEdzTEdxRVlZK1c0UFFud0RQc1NYbkpBRFRxSUs1SFBZUm1sQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8f188a-88d6-4274-de91-08df02b4992b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:24:39.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFqklsJqQ9riu+SdezlwZjk32xKIi5+GHGMPgOgyionvfQNgeRWwSXZlspOP5Pb7i85G/mHQ0T4wHyruJmiXtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6115
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 14:24:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23997

On 24.08.26 11:46, Quirin Gylstorff wrote:
> The `cip-cis-rules-config` recipe allows to create a use-case specific
> hardening configuration based on the CIS hardening rules.
> 
> To tailor a hardening config the command `bitbake -c menuconfig cip-cis-rules`
> can be used to generate the hardening config interactively.
> 
> After the package build the generated config can be found at
> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}`.
> 
> The package also provides a kernel config snippet
> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}`, which can be used
> to apply kernel hardening during compile instead of a runtime
> configuration. If the user changes the config.json all followup jobs are
> tainted. The code for this is from
> https://github.com/yoctoproject/poky/blob/077627338ac18aeca34bfe0c52777fab38e2e0c0/meta/classes-recipe/cml1.bbclass#L37 .
> 
> This packages generates the Kconfig out of cis-debian.
> 
> Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../cip-cis-rules-config.bb                   | 159 +++++
>  .../cip-cis-rules-config/files/postinst       |  32 +
>  .../cip-cis-rules-config/files/rules.tmpl     |  19 +
>  .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
>  .../files/scripts/config.schema.json          | 124 ++++
>  .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
>  .../files/scripts/gen-kernel-config.py        | 165 +++++
>  .../files/scripts/select-hardenings.py        | 616 ++++++++++++++++++
>  8 files changed, 1798 insertions(+)
>  create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>  create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
>  create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis-hardening-to-kconfig.py
>  create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
>  create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/enable-cis-rules.py
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
> 
> diff --git a/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
> new file mode 100644
> index 00000000..686fbfdd
> --- /dev/null
> +++ b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
> @@ -0,0 +1,159 @@
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +inherit dpkg
> +
> +MAINTAINER = "Christoph Steiger <christoph.steiger@siemens.com>"
> +DESCRIPTION = "Configuration files for CIS hardening"
> +
> +PROVIDES := "${PN}"
> +DEBIAN_PROVIDES := "${PN}"
> +
> +DEPENDS = "cip-cis-rules cis-hardening"
> +DEBIAN_BUILD_DEPENDS = "cip-cis-rules, cis-hardening, python3, python3-kconfiglib, python3-newt, python3-jsonschema"
> +
> +PN .= "-${MACHINE}"
> +
> +S = "${WORKDIR}/${BPN}"
> +
> +DEPLOYDIR_HARDENING = "${WORKDIR}/deploy-hardening"
> +SSTATETASKS += "do_deploy_hardening"
> +
> +HARDENING_CFG ?= ""
> +HARDENING_CFG_NAME = "${@ d.getVar('HARDENING_CFG') if d.getVar('HARDENING_CFG') else 'config.json'}"
> +
> +SRC_URI += " \
> +    file://scripts;subdir=${S} \
> +    file://rules.tmpl \
> +    file://postinst \
> +    "
> +SRC_URI += "${@ 'file://' + d.getVar('HARDENING_CFG') if d.getVar('HARDENING_CFG') else ''}"
> +
> +TEMPLATE_VARS += "HARDENING_CFG_NAME"
> +TEMPLATE_FILES += "rules.tmpl"
> +
> +do_deploy_hardening[cleandirs] += "${DEPLOYDIR_HARDENING}"
> +do_deploy_hardening[sstate-inputdirs] = "${DEPLOYDIR_HARDENING}"
> +do_deploy_hardening[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
> +do_deploy_hardening() {
> +    if [ -f "${S}/${HARDENING_CFG_NAME}" ]; then
> +        cp "${S}/${HARDENING_CFG_NAME}" "${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}"
> +    fi
> +    if [ -f "${WORKDIR}/hardening.cfg" ]; then
> +        cp "${S}/hardening.cfg" "${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}"
> +    fi
> +}
> +
> +python do_deploy_hardening_setscene () {
> +    sstate_setscene(d)
> +}
> +addtask deploy_hardening_setscene
> +
> +addtask deploy_hardening after do_dpkg_build before do_deploy_deb
> +
> +do_check_config() {
> +    if [ ! -s "${S}/${HARDENING_CFG_NAME}" ]; then
> +        bbfatal "Hardening configuration is missing. Please run 'bitbake cip-cis-rules-config -c menuconfig' and include the generated ${WORKDIR}/${HARDENING_CFG_NAME} in your SRC_URI and HARDENING_CFG_NAME."
> +    fi
> +}
> +addtask check_config after do_unpack before do_generate_kernel_config
> +
> +do_generate_kernel_config() {
> +    if [ -f "${S}/${HARDENING_CFG_NAME}" ]; then
> +        "${S}/scripts/gen-kernel-config.py" --config "${S}/${HARDENING_CFG_NAME}" --output "${S}/hardening.cfg"
> +    fi
> +}
> +
> +addtask generate_kernel_config before do_dpkg_build after do_transform_template

Why do we check the kernel config outside of the kernel recipe? Wouldn't
it be better to hook in our (or even all) kernels that are built under
CIS harnening regime?

This also inherently limits the check to CIP kernel recipes, possibly
requiring extra work downstream when they do not derive their kernel
recipe from ours here (there is little code in it, it's easy to
replicate from scratch).

> +
> +do_prepare_build() {
> +    deb_debianize
> +
> +    cat <<EOF > "${S}/debian/${BPN}.install"
> +${HARDENING_CFG_NAME} /usr/share/cip-cis-rules/
> +hardening.cfg /usr/share/cip-cis-rules/
> +EOF
> +    if [ -f "${WORKDIR}/${HARDENING_CFG_NAME}" ]; then
> +        install "${WORKDIR}/${HARDENING_CFG_NAME}" "${S}/${HARDENING_CFG_NAME}"
> +    fi
> +}
> +addtask prepare_build after do_transform_template before do_dpkg_build

This task already exists - why not simply implement it and rather
re-register it here?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

