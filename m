Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69322C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:29:30 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.43])
 by mx.groups.io with SMTP id smtpd.web11.5545.1686047360592482660
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ylBAsf57;
 spf=pass (domain: siemens.com, ip: 40.107.6.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMdoa4+1R8KqKOryxyvQkArB9ywFwxtEHXdR2uv+2l/kGwXk6BzP0xRKLoFFOHfONplq1RqlPXQxhM7nKWGyd5eqqWTmD04sjOAy+/h8iAnXWJNHzyUAXJ6x+WzmtaO4Pk8L63qHX2oq+7oHyNeSMvdrGfzxEvlQIX41jToEtCR9TQQK07/XQc0BOWR+4Q/hNL91zZc/zEdiJXGFL7KNyv0dLIn/djDRwe/acX2IWtbAXx/Bszv3rNBHfjt6NFZ3jykYI17axzoEZvr7GdOw5GJJSJppVKjlvfRNebRcY5GtlacR/eRvbEfFzaBBhp4oCN6/1jWGZY9JOiPpnCelNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg0rwqpokE+njVNf3ZCKJRNkxC7mw0TQLs8kVx0Wzrg=;
 b=LrB6Nq4kH8ZlP2xfej2C8ncjFB+iMFSJaiCME1CYKqSm3VWAfNe8WISfkVP6MH6B282gRygJPJ2rgWJlCtwaehgrfWM/XF+tHwllTsLwy2Zn1osqXDYOnCfh8nQYOHiP4zvLbYo0c9IlDePANLQ9c7SCHgLwneNpXqMpuoK7aITR5qNWaTZrvywTQOQVbKEtEUTlk29sdo6nSMbjmkxd+ynSUSurdqNrbwsH1rs17A6x0ZGqnT2ckJH1FxqOuhH1+11+0uPV8lgvqmWr44Q4fwikdq4UM2HlHMaund8Hfv/4zr42c3b1fuE3LsWQwg+FlQvizdNP08//ptr/EOrWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg0rwqpokE+njVNf3ZCKJRNkxC7mw0TQLs8kVx0Wzrg=;
 b=ylBAsf578KFWywccE3NkTrMd7YkE/C/3Eu/vXb8PWEZeM64i/u4yUmTcJsQJJvrYpLy9mGdzxQ+CyMI9//QMv6BgmooquNehUUjGtDOGpGqxZVlKqqpNsoWXxiE1bYnAjmvoil+Yush1gXTteifL5gKqxle3APA5hasKjl5Vy0GTCW1AIMWu4irxDh1k1DaksPtPG1vNyoSUe+/6fovNgVzySJSiiWmoUUcQ+4rLl85dzFG6yBJRJSTonsr5YLlZla3+2bo1uP5iXN1yW/Tbz4NcqT05FHqR1DUpwhKhts4g/vBTHNppaPu2vfoXl3ZO6U/mdySyiaYPBSF5IMhQPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:82::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 10:29:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:29:17 +0000
Message-ID: <bcbddc6b-0058-8c04-303b-82b1f16dbb57@siemens.com>
Date: Tue, 6 Jun 2023 12:29:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH v2 1/2] Add recipe for optee-client
Content-Language: en-US
To: "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "baocheng_su@163.com" <baocheng_su@163.com>,
 "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230606035506.10354-1-baocheng_su@163.com>
 <20230606035506.10354-2-baocheng_su@163.com>
 <15c4bbac-145e-f826-9c48-778531a1a403@siemens.com>
 <36fc108fed304bcfca50fd11656ecb0fef79f09f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <36fc108fed304bcfca50fd11656ecb0fef79f09f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 450aaa11-26b5-49b7-5d3c-08db6678e195
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8eHE8IB1BfYv0C8iZHhgsDbTpasUxHt+AgVTodzZsdLuGH0MjNVQUoXpCeNqDoLK+l+XNiVTPtnIoGClXQFwuJsX7yCkpoWrrc6wVx1aJsyZ4jBEuWN5ESAQJOIW2l6jx2wq2ck334lXdvEmHaNHDVQvm6dTq1R+J6BwCW2fNJ5mwi81gEyYJr/z27BrFMpDtEKCDpB+Iii/GcYEua9/50MRnLmvuRSXgLMUA1dnd2KMnjzCJfbCOw/v2hghP2W0m/8CeNqDyscF5oOp6gI90d/EBpoc4h7iq569YXpqWdzVfYRcmTSYRiYoxPMqaI04XjQjqqm8udq+OjKdVwwQnvMRjcn7tx6OwnfWPeQCw6/2jfN1mSOpt04gI4lLSSoUSxFw8oHdytyqscmHkRJWkLPt7313Xw3aFxMlH58hd3qDghPcyj/xqY238aHT5yaLKqebBKqsTje50cwmfV74N8SplaPFvto7Ea9ntMQngjKy92i92XLvdlzCG3nkTTr97ZHOYLXV4uWOSHeHExd9x/r2tWCEDKKSYTwbizCbApzvT3JZZJDa9skLLl972AyKvzAbybY/TMcrBvi3RK6uScmJ1SsJWg7hsG2wCdFej06OB83nAmaePW6awA2sFdCsN+oNsf/yvDQTVDRcqDAWew==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(26005)(6506007)(53546011)(6512007)(107886003)(966005)(36756003)(83380400001)(31696002)(86362001)(38100700002)(2616005)(186003)(82960400001)(8936002)(41300700001)(44832011)(54906003)(110136005)(2906002)(478600001)(66946007)(6636002)(8676002)(4326008)(31686004)(316002)(5660300002)(6486002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXQ3K0tYV1d4bFQwdE9rbDh0UjdpNU1keG9BdTZzdzFhQVRRRU5jSVp6djlz?=
 =?utf-8?B?SEZVQW01RUZ1WXpnNlpPMlBkdjNaY0dzZHowWnZyQmxVb0F4d2hkZEcwVXZj?=
 =?utf-8?B?U0p4aCtFMFZ1OHhaeFkwOXlSdWRHclJNQ1BqaTJGa203V1djMmNoWFhuMkVi?=
 =?utf-8?B?NGRwZW5keTZBVnJ2TU85MWZNSGtmcUY3U2pIT0haTlFyRjV2OHRHbzBPRURP?=
 =?utf-8?B?MlFNQWdscWE4aXZLbmxJYWNSbDFvSFlHVDRnVE9Sa09xTmlZQ2I5MkQ0N1hE?=
 =?utf-8?B?RmZMV1lzSmJkdmN3Y2VuMUdjZDVnREVyamJ5bHVMYmpTQVdIaGRrU0IzUTYy?=
 =?utf-8?B?U2JtUm1SZkNEMmE4TW9HRTRmZzRESHp6dHNSc3hMVHBJdWw5QWFZM1dyay9Q?=
 =?utf-8?B?cjlvUDZIcFNOcENra3NYLzRGNjl5Y3krckJua2ZlanlpMCtKQkFvbDR2NlN4?=
 =?utf-8?B?OEZWeEo3VGpEOVBpUktrUDRLdmY5M0E0R1MvK3YxSW54czcveVErK29UTVJm?=
 =?utf-8?B?VVV1ZlRJZXBtbTF4ZHFkREpMV1lNK25hSThNTjJuT2pGTjI0TitrdGFLcTZn?=
 =?utf-8?B?Z0ZacTZ4dTJSNG5MOC9QNUM0T09xS0g5UTBkVHM4eUlwV2RaODRKdk9tckZY?=
 =?utf-8?B?anJLUXFLUnB1RXV2QTd3R1hZSEQ3WWlEaXk3cWpLajQ4Nno3emwwRk1RTGQv?=
 =?utf-8?B?cDF1a0VQR1lsYmxoRkZyRTZEaC95T3lmck80QnZZVllmbHlXdW1OSk1PWDlj?=
 =?utf-8?B?WDZTbTluN25KRjBxMGVQT1ZjYVM2VHhseEl5aHM0NGRIM2JuZkdMVkVRMnBO?=
 =?utf-8?B?ZG9RRHI2amVpeHZBcUpXL0FFaVM3SWF0YkpLY1hrZzNOcEN1ekV3N3YwU25U?=
 =?utf-8?B?emsyUmZSckZkTWs3V2QrcW90Z2RJUkVQS3NqdGV4VXNERE5UeWFhOGJPakhR?=
 =?utf-8?B?bnJPSWUxVG8yVzB4OXZCdXlwUEY1K3pueFFjU1lVNjZqcEUzbENhMjV4anA3?=
 =?utf-8?B?TnJwNjVzVjhZV3VrSHcrcFFibnpBNFE0S0dsUWViMzVVbXhPQ3Z5bUtkK0lP?=
 =?utf-8?B?WWp2a0tuTGdUUkR6eUdVYzY5VU9vd3g3YmIza25kMkE3YVVmS3EwT3dKUmx3?=
 =?utf-8?B?L29keW11eUl4WGkrRTJSZVNCRnJkTTgyM0FOYmd2V0Q3WHlNZVluMjJRRXN4?=
 =?utf-8?B?VkVqNS9QZERXNGgwRE8zWlpZNm1waFNwU0JKQVExRWlqMjFpOFlRQWtBVXg3?=
 =?utf-8?B?N0F3ZCtkSWFwOGhrRktuWUlva1RDQ3JjKzM3ZDhpcERrM1dEcG41d2QxRlZR?=
 =?utf-8?B?aFNuU0J6UjJyRzRxKzJPai8yYzZCbUlDT1U3SnBPdjEyWm9WL3ViSnM2aFpi?=
 =?utf-8?B?MnBnTVB1WlpmbDRCMFVIUlBJUmJTZzRudVdNMEZCVys1bmlvODJZMHhXNDkw?=
 =?utf-8?B?RjZUL2VneUFCbi81Vzg3Y2tud0dBaisrNVg3SVpJQ0VJQWU4YkY3cngxbkw3?=
 =?utf-8?B?TndBN2tBSURjUlFidmE3L0ZSMktJZk5GdkdyNzlLV1lIa2FQNmNXUU1hU2N4?=
 =?utf-8?B?K0JiaU96aktpK2g5ZThKU2J5QjZ2MThkd2tYWVpyWVZDYUMvbkxtcW8yTWVy?=
 =?utf-8?B?MlMyYlNGYTErVWk3VXdOcC9yVTJEQzhpTk16T2UxUGhlYUxhZGM5V1NGWVlX?=
 =?utf-8?B?VXZQNTMxelM2MytaM3ozMHlMTUtuMXFKTkZjbGs0UkdxcDdQeEZIc1VYdDFa?=
 =?utf-8?B?ckZpTTR4NnFXZ3V3ZytQQ0MxU1EvRXkyL3NYTlNwZVZ0MEVHTjBDMzQ5QSsw?=
 =?utf-8?B?U2EwYkdNNERyVENhZVZkTHNvNjluZkFDYnVybUJYbWlFOXF6bmJ0clNEVWpr?=
 =?utf-8?B?SFQ5RE94eEFNRnlVZ0wyT3pWekZiSkdrMHlPOWo5Mk9nZGR4cVQ5THJ4S1dV?=
 =?utf-8?B?MytCSGswWnVVeTdFMlJsNFV5MGNKbkgyZWVCeDNBNEQzRmxKYmdPVi9Ud1RO?=
 =?utf-8?B?SmRUUVJlcnljYmtlY0FQWXFDYmZaNUZRN29GK0JCeGg0Y1VhNWZyRGFiRnEx?=
 =?utf-8?B?T3lMWE9WT2d4eGNOOHNML0NTQTNhazFRNG5wMUFiLzdHeDhUZ3R3VjNzUytq?=
 =?utf-8?B?VlEyRlQwU21IaWIrYUkybjBtS0VSejlUdy82SFE2bExtb2NTS0l0di9IWG1v?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450aaa11-26b5-49b7-5d3c-08db6678e195
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:29:17.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKkVFBdoRhZf2K2XG27v6BW0MTIpvbg4fHf5yuvs9+Z5YdBKD/jbUuOSV5cXdSFpO+2RL8cdeFWpps+shjNGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6657
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11863

On 06.06.23 12:24, Su, Bao Cheng (DI FA CTR IPC CN PRC4) wrote:
> On Tue, 2023-06-06 at 07:37 +0200, Jan Kiszka wrote:
>> On 06.06.23 05:55, baocheng_su@163.com wrote:
>>> From: Baocheng Su <baocheng.su@siemens.com>
>>>
>>> This brings the libteec1, optee-client-dev and most important,
>>> tee-supplicant.
>>>
>>> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
>>> ---
>>>  recipes-bsp/optee-client/files/control.tmpl   | 51
>>> +++++++++++++++++++
>>>  recipes-bsp/optee-client/files/rules.tmpl     | 20 ++++++++
>>>  .../optee-client/files/tee-supplicant.service |  9 ++++
>>>  .../optee-client/optee-client_3.20.0.bb       | 47
>>> +++++++++++++++++
>>>  4 files changed, 127 insertions(+)
>>>  create mode 100644 recipes-bsp/optee-client/files/control.tmpl
>>>  create mode 100755 recipes-bsp/optee-client/files/rules.tmpl
>>>  create mode 100644 recipes-bsp/optee-client/files/tee-
>>> supplicant.service
>>>  create mode 100644 recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>
>>> diff --git a/recipes-bsp/optee-client/files/control.tmpl b/recipes-
>>> bsp/optee-client/files/control.tmpl
>>> new file mode 100644
>>> index 0000000..b0c3756
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-client/files/control.tmpl
>>> @@ -0,0 +1,51 @@
>>> +Source: optee-client
>>> +Priority: optional
>>> +Maintainer: Unknown maintainer <unknown@example.com>
>>> +Build-Depends: pkg-config, uuid-dev
>>> +Standards-Version: 4.1.3
>>> +Section: libs
>>> +Homepage:
>>> https://github.com/OP-TEE/optee_client
>>> +Rules-Requires-Root: no
>>> +
>>> +Package: optee-client-dev
>>> +Section: libdevel
>>> +Architecture: arm64
>>> +Multi-Arch: same
>>> +Depends: libteec1 (= ${binary:Version}),
>>> +         ${misc:Depends}
>>> +Description: normal world user space client APIs for OP-TEE
>>> (development)
>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>> companion to a
>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>> TrustZone
>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>> is the API
>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>> which is the
>>> + API describing how to communicate with a TEE. This package
>>> provides the TEE
>>> + Client API library.
>>> + .
>>> + This package contains the development files OpTEE Client API
>>> +
>>> +Package: libteec1
>>> +Architecture: arm64
>>> +Multi-Arch: same
>>> +Depends: ${misc:Depends}, ${shlibs:Depends}
>>> +Description: normal world user space client APIs for OP-TEE
>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>> companion to a
>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>> TrustZone
>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>> is the API
>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>> which is the
>>> + API describing how to communicate with a TEE. This package
>>> provides the TEE
>>> + Client API library.
>>> + .
>>> + This package contains libteec library.
>>> +
>>> +Package: tee-supplicant
>>> +Architecture: arm64
>>> +Depends: ${misc:Depends}, ${shlibs:Depends}
>>> +Description: normal world user space client APIs for OP-TEE
>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>> companion to a
>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>> TrustZone
>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>> is the API
>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>> which is the
>>> + API describing how to communicate with a TEE. This package
>>> provides the TEE
>>> + Client API library.
>>> + .
>>> + This package contains tee-supplicant executable.
>>> diff --git a/recipes-bsp/optee-client/files/rules.tmpl b/recipes-
>>> bsp/optee-client/files/rules.tmpl
>>> new file mode 100755
>>> index 0000000..a8f2afd
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-client/files/rules.tmpl
>>> @@ -0,0 +1,20 @@
>>> +#!/usr/bin/make -f
>>> +
>>> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
>>> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
>>> +endif
>>> +
>>> +%:
>>> +       dh $@ --exclude=.a
>>> +
>>> +override_dh_auto_build:
>>> +       dh_auto_build -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
>>> +               CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH}
>>> ${RPMB_EMU_BUILD_OPT}
>>> +
>>> +override_dh_auto_install:
>>> +       dh_auto_install -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
>>> +               CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH}
>>> ${RPMB_EMU_BUILD_OPT}
>>> +
>>> +override_dh_auto_clean:
>>> +       dh_auto_clean
>>> +       rm -rf $(CURDIR)/out
>>> diff --git a/recipes-bsp/optee-client/files/tee-supplicant.service
>>> b/recipes-bsp/optee-client/files/tee-supplicant.service
>>> new file mode 100644
>>> index 0000000..7148515
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-client/files/tee-supplicant.service
>>> @@ -0,0 +1,9 @@
>>> +[Unit]
>>> +Description=TEE Supplicant
>>> +
>>> +[Service]
>>> +Type=simple
>>> +ExecStart=/usr/sbin/tee-supplicant
>>> +
>>> +[Install]
>>> +WantedBy=multi-user.target
>>> diff --git a/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>> b/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>> new file mode 100644
>>> index 0000000..b760a2c
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>> @@ -0,0 +1,47 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2023
>>> +#
>>> +# Authors:
>>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +inherit dpkg
>>> +
>>> +DESCRIPTION = "OPTee Client"
>>> +
>>> +PROVIDES = "libteec1 optee-client-dev tee-supplicant"
>>> +
>>> +SRC_URI +=
>>> "https://
>>> github.com%2FOP-
>>> TEE%2Foptee_client%2Farchive%2F%24&data=05%7C01%7Cbaocheng.su%40ad0
>>> 11.siemens.com%7C4165545a244e4709dbe608db66500fee%7C38ae3bcd95794fd
>>> 4addab42e1495d55a%7C1%7C0%7C638216266262554942%7CUnknown%7CTWFpbGZs
>>> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>>> %3D%7C3000%7C%7C%7C&sdata=wpVB2SbJ1kQ2znZPG62J9EvJd7C4Bk%2FQT1EsqAi
>>> E%2FVY%3D&reserved=0{PV}.tar.gz;downloadfilename=optee_client-
>>> ${PV}.tar.gz \
>>> +    file://control.tmpl \
>>> +    file://rules.tmpl \
>>> +    file://tee-supplicant.service"
>>> +SRC_URI[sha256sum] =
>>> "69414c424b8dbed11ce1ae0d812817eda2ef4f42a1bef762e5ca3b6fed80764c"
>>> +
>>> +S = "${WORKDIR}/optee_client-${PV}"
>>> +
>>> +TEE_FS_PARENT_PATH ?= "/var/lib/optee-client/data/tee"
>>> +# To use the builtin RPMB emulation, empty this
>>> +RPMB_EMU_BUILD_OPT ?= "RPMB_EMU=0"
>>> +
>>> +TEMPLATE_FILES = "rules.tmpl control.tmpl"
>>> +TEMPLATE_VARS += "TEE_FS_PARENT_PATH RPMB_EMU_BUILD_OPT"
>>> +
>>> +do_prepare_build[cleandirs] += "${S}/debian"
>>> +do_prepare_build() {
>>> +    deb_debianize
>>> +
>>> +    cp -f ${WORKDIR}/tee-supplicant.service \
>>> +        ${S}/debian/tee-supplicant.service
>>> +    echo "/usr/sbin/*" > ${S}/debian/tee-supplicant.install
>>> +    echo "lib/optee_armtz/" > ${S}/debian/tee-supplicant.dirs
>>> +    echo "usr/lib/tee-supplicant/plugins/" >> ${S}/debian/tee-
>>> supplicant.dirs
>>> +
>>> +    echo "usr/lib/*/libteec*.so.*" > ${S}/debian/libteec1.install
>>> +
>>> +    echo "usr/include/*" > ${S}/debian/optee-client-dev.install
>>> +    echo "usr/lib/*/lib*.so" >> ${S}/debian/optee-client-
>>> dev.install
>>> +}
>>
>> Looks like optee-client is part of bookworm, but version 3.19.0 only.
>> Latest is 3.21.0. Please make sure we aren't colliding.
>>
> 
> That is a point, I will test it from my side.
> 
>> And did you use the official debianization? If not, please do.
>>
> 
> I borrowed something from the official debianization when I was writing
> it.
> 
> Or should we use the `apt://${PN}` and add our modification on top?
> That may bind us to the 3.19 version for a pretty long time.

Check is some salsa branch is holding what you need, maybe even already
3.21.0. Otherwise, it would be nice to contribute and pull again from
there, at least midterm.

And, as we just realized during your private discussion about [1], we
likely also need a separate initrd hook for tee-supplicant to ensure
that this service is running before systemd mounts efivarfs.

Jan

[1]
https://lore.kernel.org/lkml/4ff09002-e871-38b9-43ec-227a64bac731@siemens.com/T/#u

-- 
Siemens AG, Technology
Competence Center Embedded Linux


