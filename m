Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E34DC7EE23
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 05:09:15 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.54])
 by mx.groups.io with SMTP id smtpd.web10.1740.1686114550838838421
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 22:09:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Oc0GWglo;
 spf=pass (domain: siemens.com, ip: 40.107.20.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAPYsbvXiMtUbh5NklRtjTzjKAjjGmCa3dBB6zMba4f8e+E2eBlA/+IVeBC4ZFFcdvo6gzFgM/w8d2eDcsS1HejQ3qZp+NoVe+5T5UX0KLbxerdBgwgKcWqSsqvRj73oTpMT9B8yWc+Qpp3UhtilmEyzsw+WgaELXXEWDu22BLP4g5Y+AznkuwlE7M9PCGutJFtclfcH8ua2/nvWrd4HSYEYJvyssnx3maSHeu/tRKA/Cc+6ftjZOY7GSUiFWnMNynH3JyNL5e9X1JBRM+PC12psYsWmHgIRrmTxz71NiG9RESrvPnQVwuJBKq0zND2mGudu9tQ6YPecGQzGo/5HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9qw0ytJULZOhfqmhqJCOaAimiLfpQE9E8Ror6CjyuE=;
 b=GUMimosZlMyUFJvP2tb6764PO/Ph3VqOfKwWBQXEWpPHdV8UA08cJSR7PHpwev6GmJCp3TH8hhe7Nf4JvP0B0P+hbEQq9yw0W3E2xfp5sKukhI7ueCbVQFpLLa3m5bgVeRPZxPy04Y/g1pxg9TJjkn8soaziihw9VPSmExz5F2rBkXXO/f6dTVBLAdf1BpNCGnVXvvi1VUeHjN+Ox99bbkHSP7WRNzr5tNJ2k6Rm9EKPDpwLpx5SpG9f2wKbfst42JiJWS+jS/5SdFTckzau7YWuhcewBbmy9bCA7VYogDZvMMkL84w7/IkwMTj7O5Mfgg9saYh9hvrfVNZSqbs7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9qw0ytJULZOhfqmhqJCOaAimiLfpQE9E8Ror6CjyuE=;
 b=Oc0GWgloegdezLFXcjh5JRXCpzO+5DgDSK8u3eNJtNFG0kYzC3ZFiGpVwhA0ciItQeietkgtwqR+fPmWT8RwO6ae/m0yXuXTTkt0mr96jXjhHyM+48SYFr00y1ftLBggDcthiC5wKMdrVwUaEoH2+4p46RwAuB/RLmLBLCVCAJvUWLb9d8VDP7CdAXPA5cBP84X34pqB1+pyGtMhEWgR+H9yWBuR1d04z8N4gAhDPqJ0AmpSG27quTFOTstXgqDGN7FGNwxInK3tla6C2IWIdrNCADrHkxIf1UVQ77e+dFY2pP7jOMNikBTz81YkMg1xrB4MOatHfiOx8RqX1Qapgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 05:09:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 05:09:07 +0000
Message-ID: <f301af4c-05df-056d-81cb-deaf9b35535d@siemens.com>
Date: Wed, 7 Jun 2023 07:08:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH v2 1/2] Add recipe for optee-client
Content-Language: en-US
To: Su Baocheng <baocheng_su@163.com>,
 "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>
CC: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230606035506.10354-1-baocheng_su@163.com>
 <20230606035506.10354-2-baocheng_su@163.com>
 <15c4bbac-145e-f826-9c48-778531a1a403@siemens.com>
 <36fc108fed304bcfca50fd11656ecb0fef79f09f.camel@siemens.com>
 <bcbddc6b-0058-8c04-303b-82b1f16dbb57@siemens.com>
 <781c9d35-110b-67c4-9331-f2b55f28e73e@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <781c9d35-110b-67c4-9331-f2b55f28e73e@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 23961500-24f0-4bea-2ea1-08db67155222
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dh5wRjQuwpwaepi0mYNllpcf/NK/RYug4s9mePnJY2k3ZL2q68hnu2fqViGSEprlsMFXl+orLlFQxgtBnTYMdqHgiYB3Q9M8FImpqtWeQygWkLce5bm2Ik1B/Fv5XJvgOwXXMyI0KPOZFhdSCbB6WU2knRAeUWIssviqVr/JHL/Hb4env6IEhLZM1falMtrWdNMP13obOMcOdoRyyOHQd8Fjac7R07GMQv3teVqwGULgfCMa3D3DetvpQ1saEcgBjnroP+LB/nZBTlJ5ZtLEvv66X/Peim1xUNv0BYPxiirSCERcHOL/EFdtMJ6uLzSP2cEsNbMzCxvXr4JR9jC8UbEEnyvDH6z4GT6Mcokd+TcfcBLwaVjgqxbiPxqZpCUsUXvm1ex0y1WJbD5+fEMqaFPAww3WWtSBzSUzAcmH9eb6G9TUCkIIU6NDQcKs3TYWOKifWFXysWgUnKr/H+IwSRpGX+tmz3soHTiVoc88YkC3uiIZHQKXw7VAB+4E9lx5cDC1tqjISMV7Eqn6i6hN9hP5wJQyWdaXNs6CsYrUZSdac6cP7nwGWzFGxfBleAcql1dbIJozMGW+PAjdSj/c1Ucqjy9NRsGZMLQnC326KCKBHDyPC+E6L87TdZmUB5M6T1wzYF5JlU6/PiNNXGFv3TfaCDMJuCQsEIa7R8XITg9geEqTVyLSXVx7Bcqp8V4W
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(36756003)(2906002)(44832011)(31696002)(86362001)(5660300002)(31686004)(966005)(6666004)(6486002)(53546011)(26005)(107886003)(6512007)(6506007)(83380400001)(82960400001)(478600001)(186003)(110136005)(54906003)(38100700002)(66556008)(66946007)(4326008)(6636002)(41300700001)(316002)(2616005)(66476007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UUL6CDaiug4asWQyB2jrURvCOxRAPap1uAoiLcp6W4KzCZVNEWKPD7CJNUmy?=
 =?us-ascii?Q?gqu9bnGr/AcEsopvBoYj9V8xsgEsGTxsr/JNT5k1Qg1p1Xae5cTvSi2d8DMu?=
 =?us-ascii?Q?piq3R/pojhkHpP0j0G/fIWyGZ6fEfiBID9GVb3mXiRG4i/QnW/zDcISFcDAL?=
 =?us-ascii?Q?HyEFOhNfym++PPt7KQGamBS6oPpjTppy6+nBFrZipbEcLsuZ+IUtug8Ixd97?=
 =?us-ascii?Q?E1Q8xCduVHNmLorZdUua1YDtiHr5ihBCCVDYLScrAkwDNCBfDg4iEHXO20Sc?=
 =?us-ascii?Q?e+fhCdp0S4cW4suIxzugMfc4r5zdaMu2/L8K5OYOBLDqTICtYscIVEW22aQu?=
 =?us-ascii?Q?s/CLPR5ojHM9exRLrPocIeXMuV9IpdALnJpSkelZq5cN0ArUTHW4CD3lRf6D?=
 =?us-ascii?Q?i4X4zUSpdC///OjzsDy9/ON6XLZXbAv3YlwgCflxQCzu9yLjXXMq2m0Qkqmg?=
 =?us-ascii?Q?d1rNrlwd0YzPj5QiGazOR683ZA8LAcjhVlMP4zFzUiFYmwnA9sh7RWs2JxnB?=
 =?us-ascii?Q?sd7uqNpDSuZF/DeboUsrEbr1oafR4SKivK1L5g7tjsUknuF+pRXyE1uyXBab?=
 =?us-ascii?Q?eJiWbRxS9HF0e7e6ehaEyODtCV0ceBCPE4RYqZMQr/Xeg9khLsDPaLhL25JC?=
 =?us-ascii?Q?L9/kFYnaZFIyRuqAT424mgO5sRcq/pFHrsSVDcg2O3pFUlHF1ET2z5SlA0Uf?=
 =?us-ascii?Q?Xem2uAZqA8QmjrYyEbLMXR/LajkmWOjtV/Xj3Hx+ZY1aFVQWUbUu62O3xCn0?=
 =?us-ascii?Q?wya5lEqGyR2BUIpeUb9UveYbJNXoTtkbMcvAi6LmsdZYBecMGiT0VBCv4M9o?=
 =?us-ascii?Q?FyW7C9FLYlunO5zPNvHG/QC+x4shBquf/KBra2RAMy5o8GBx8y1H36dDEPnW?=
 =?us-ascii?Q?KY1Qj2Pdh4cxzUkbMcg+7kTIbf7gWF+apND91qfWLDnnb6OQ10G3AjrNPRAt?=
 =?us-ascii?Q?5cyhs+MxgxB1Qo/1C5IZ9XznMEP2AmBUW+6e7S1Gc19cVQ9yxyapYYNV6cS5?=
 =?us-ascii?Q?4HSxsP+19DDK+/QzL5XHnc+s7SO2+IirN8VnQPv9NvmPafWIEAUHov3/fI8M?=
 =?us-ascii?Q?A9Zg5VftfnniTq9vUsF4BPZjcZ5xjJMIfFyOX5uifJN7iX+MdpTxCsxI1HiA?=
 =?us-ascii?Q?tja9o7Oy9ACSQcohqghUthMc+sF9nMcfvUTetkJzJd59thH3ouiAMBn3FAs3?=
 =?us-ascii?Q?BoibGlSwDcETJ3ljwHag2cZXwHSkiYzd3LhzqZx7N+Il4WLnd6bLe+oHHCI+?=
 =?us-ascii?Q?YYz0rX8YkFgvhaE7vXid7ftM2dmfmZR0RttblA6oxNyHaob9l9L5FQRnAbc8?=
 =?us-ascii?Q?brjqdNCcupkWv4i5XnPiiXCRYP0ncuB4l+M9TJQ7Otz+7IRREET3Jg6oUtMJ?=
 =?us-ascii?Q?UW4a21lzgQ7Hq06QKp/k3ddx34ZygFqPt0CeOUzF5bdxgujhoGJWwLGrjioW?=
 =?us-ascii?Q?8KfsHFJGZu2zH4vh5Gqkr5/x+zoBdNhvH+/YGQIr11jZgb4r7jJRjXE6a1Iv?=
 =?us-ascii?Q?d1qsWi2lGfAnaUffey3vdopAORjcTd3RELIywhCPD417Jx7T0QJyhYHON4MX?=
 =?us-ascii?Q?BVoKC1yrWKwNAbEIHgL5CoMSKsog0HlUBz+fzjhUR+rORrxfSYjKlGb5HKzr?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23961500-24f0-4bea-2ea1-08db67155222
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 05:09:07.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4inGA1wJWicRVFyl584x7fKGIXPIN4KrEDc2Fo6WYfyguWgDQpKBAoglEC52bc/YB1IbfmPa81eovvLMnya6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8029
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 05:09:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11903

On 07.06.23 04:30, Su Baocheng wrote:
>=20
>=20
> On 2023/6/6 18:29, Jan Kiszka wrote:
>> On 06.06.23 12:24, Su, Bao Cheng (DI FA CTR IPC CN PRC4) wrote:
>>> On Tue, 2023-06-06 at 07:37 +0200, Jan Kiszka wrote:
>>>> On 06.06.23 05:55, baocheng_su@163.com wrote:
>>>>> From: Baocheng Su <baocheng.su@siemens.com>
>>>>>
>>>>> This brings the libteec1, optee-client-dev and most important,
>>>>> tee-supplicant.
>>>>>
>>>>> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
>>>>> ---
>>>>> =C2=A0 recipes-bsp/optee-client/files/control.tmpl=C2=A0=C2=A0 | 51
>>>>> +++++++++++++++++++
>>>>> =C2=A0 recipes-bsp/optee-client/files/rules.tmpl=C2=A0=C2=A0=C2=A0=C2=
=A0 | 20 ++++++++
>>>>> =C2=A0 .../optee-client/files/tee-supplicant.service |=C2=A0 9 ++++
>>>>> =C2=A0 .../optee-client/optee-client_3.20.0.bb=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 47
>>>>> +++++++++++++++++
>>>>> =C2=A0 4 files changed, 127 insertions(+)
>>>>> =C2=A0 create mode 100644 recipes-bsp/optee-client/files/control.tmpl
>>>>> =C2=A0 create mode 100755 recipes-bsp/optee-client/files/rules.tmpl
>>>>> =C2=A0 create mode 100644 recipes-bsp/optee-client/files/tee-
>>>>> supplicant.service
>>>>> =C2=A0 create mode 100644 recipes-bsp/optee-client/optee-client_3.20.=
0.bb
>>>>>
>>>>> diff --git a/recipes-bsp/optee-client/files/control.tmpl b/recipes-
>>>>> bsp/optee-client/files/control.tmpl
>>>>> new file mode 100644
>>>>> index 0000000..b0c3756
>>>>> --- /dev/null
>>>>> +++ b/recipes-bsp/optee-client/files/control.tmpl
>>>>> @@ -0,0 +1,51 @@
>>>>> +Source: optee-client
>>>>> +Priority: optional
>>>>> +Maintainer: Unknown maintainer <unknown@example.com>
>>>>> +Build-Depends: pkg-config, uuid-dev
>>>>> +Standards-Version: 4.1.3
>>>>> +Section: libs
>>>>> +Homepage:
>>>>> https://github.com/OP-TEE/optee_client
>>>>> +Rules-Requires-Root: no
>>>>> +
>>>>> +Package: optee-client-dev
>>>>> +Section: libdevel
>>>>> +Architecture: arm64
>>>>> +Multi-Arch: same
>>>>> +Depends: libteec1 (=3D ${binary:Version}),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${misc:Depends}
>>>>> +Description: normal world user space client APIs for OP-TEE
>>>>> (development)
>>>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>>>> companion to a
>>>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>>>> TrustZone
>>>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>>>> is the API
>>>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>>>> which is the
>>>>> + API describing how to communicate with a TEE. This package
>>>>> provides the TEE
>>>>> + Client API library.
>>>>> + .
>>>>> + This package contains the development files OpTEE Client API
>>>>> +
>>>>> +Package: libteec1
>>>>> +Architecture: arm64
>>>>> +Multi-Arch: same
>>>>> +Depends: ${misc:Depends}, ${shlibs:Depends}
>>>>> +Description: normal world user space client APIs for OP-TEE
>>>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>>>> companion to a
>>>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>>>> TrustZone
>>>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>>>> is the API
>>>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>>>> which is the
>>>>> + API describing how to communicate with a TEE. This package
>>>>> provides the TEE
>>>>> + Client API library.
>>>>> + .
>>>>> + This package contains libteec library.
>>>>> +
>>>>> +Package: tee-supplicant
>>>>> +Architecture: arm64
>>>>> +Depends: ${misc:Depends}, ${shlibs:Depends}
>>>>> +Description: normal world user space client APIs for OP-TEE
>>>>> + OP-TEE is a Trusted Execution Environment (TEE) designed as
>>>>> companion to a
>>>>> + non-secure Linux kernel running on Arm; Cortex-A cores using the
>>>>> TrustZone
>>>>> + technology. OP-TEE implements TEE Internal Core API v1.1.x which
>>>>> is the API
>>>>> + exposed to Trusted Applications and the TEE Client API v1.0,
>>>>> which is the
>>>>> + API describing how to communicate with a TEE. This package
>>>>> provides the TEE
>>>>> + Client API library.
>>>>> + .
>>>>> + This package contains tee-supplicant executable.
>>>>> diff --git a/recipes-bsp/optee-client/files/rules.tmpl b/recipes-
>>>>> bsp/optee-client/files/rules.tmpl
>>>>> new file mode 100755
>>>>> index 0000000..a8f2afd
>>>>> --- /dev/null
>>>>> +++ b/recipes-bsp/optee-client/files/rules.tmpl
>>>>> @@ -0,0 +1,20 @@
>>>>> +#!/usr/bin/make -f
>>>>> +
>>>>> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
>>>>> +export CROSS_COMPILE=3D$(DEB_HOST_GNU_TYPE)-
>>>>> +endif
>>>>> +
>>>>> +%:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dh $@ --exclude=3D.a
>>>>> +
>>>>> +override_dh_auto_build:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dh_auto_build -- LIBDIR=3D/usr/=
lib/$(DEB_HOST_MULTIARCH) \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CFG_TEE_FS_PARENT_PATH=3D${TEE_FS_PARENT_PATH}
>>>>> ${RPMB_EMU_BUILD_OPT}
>>>>> +
>>>>> +override_dh_auto_install:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dh_auto_install -- LIBDIR=3D/us=
r/lib/$(DEB_HOST_MULTIARCH) \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CFG_TEE_FS_PARENT_PATH=3D${TEE_FS_PARENT_PATH}
>>>>> ${RPMB_EMU_BUILD_OPT}
>>>>> +
>>>>> +override_dh_auto_clean:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dh_auto_clean
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -rf $(CURDIR)/out
>>>>> diff --git a/recipes-bsp/optee-client/files/tee-supplicant.service
>>>>> b/recipes-bsp/optee-client/files/tee-supplicant.service
>>>>> new file mode 100644
>>>>> index 0000000..7148515
>>>>> --- /dev/null
>>>>> +++ b/recipes-bsp/optee-client/files/tee-supplicant.service
>>>>> @@ -0,0 +1,9 @@
>>>>> +[Unit]
>>>>> +Description=3DTEE Supplicant
>>>>> +
>>>>> +[Service]
>>>>> +Type=3Dsimple
>>>>> +ExecStart=3D/usr/sbin/tee-supplicant
>>>>> +
>>>>> +[Install]
>>>>> +WantedBy=3Dmulti-user.target
>>>>> diff --git a/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>>> b/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>>> new file mode 100644
>>>>> index 0000000..b760a2c
>>>>> --- /dev/null
>>>>> +++ b/recipes-bsp/optee-client/optee-client_3.20.0.bb
>>>>> @@ -0,0 +1,47 @@
>>>>> +#
>>>>> +# CIP Core, generic profile
>>>>> +#
>>>>> +# Copyright (c) Siemens AG, 2023
>>>>> +#
>>>>> +# Authors:
>>>>> +#=C2=A0 Su Bao Cheng <baocheng.su@siemens.com>
>>>>> +#
>>>>> +# SPDX-License-Identifier: MIT
>>>>> +#
>>>>> +
>>>>> +inherit dpkg
>>>>> +
>>>>> +DESCRIPTION =3D "OPTee Client"
>>>>> +
>>>>> +PROVIDES =3D "libteec1 optee-client-dev tee-supplicant"
>>>>> +
>>>>> +SRC_URI +=3D
>>>>> "https://
>>>>> github.com%2FOP-
>>>>> TEE%2Foptee_client%2Farchive%2F%24&data=3D05%7C01%7Cbaocheng.su%40ad0
>>>>> 11.siemens.com%7C4165545a244e4709dbe608db66500fee%7C38ae3bcd95794fd
>>>>> 4addab42e1495d55a%7C1%7C0%7C638216266262554942%7CUnknown%7CTWFpbGZs
>>>>> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
>>>>> %3D%7C3000%7C%7C%7C&sdata=3DwpVB2SbJ1kQ2znZPG62J9EvJd7C4Bk%2FQT1EsqAi
>>>>> E%2FVY%3D&reserved=3D0{PV}.tar.gz;downloadfilename=3Doptee_client-
>>>>> ${PV}.tar.gz \
>>>>> +=C2=A0=C2=A0=C2=A0 file://control.tmpl \
>>>>> +=C2=A0=C2=A0=C2=A0 file://rules.tmpl \
>>>>> +=C2=A0=C2=A0=C2=A0 file://tee-supplicant.service"
>>>>> +SRC_URI[sha256sum] =3D
>>>>> "69414c424b8dbed11ce1ae0d812817eda2ef4f42a1bef762e5ca3b6fed80764c"
>>>>> +
>>>>> +S =3D "${WORKDIR}/optee_client-${PV}"
>>>>> +
>>>>> +TEE_FS_PARENT_PATH ?=3D "/var/lib/optee-client/data/tee"
>>>>> +# To use the builtin RPMB emulation, empty this
>>>>> +RPMB_EMU_BUILD_OPT ?=3D "RPMB_EMU=3D0"
>>>>> +
>>>>> +TEMPLATE_FILES =3D "rules.tmpl control.tmpl"
>>>>> +TEMPLATE_VARS +=3D "TEE_FS_PARENT_PATH RPMB_EMU_BUILD_OPT"
>>>>> +
>>>>> +do_prepare_build[cleandirs] +=3D "${S}/debian"
>>>>> +do_prepare_build() {
>>>>> +=C2=A0=C2=A0=C2=A0 deb_debianize
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 cp -f ${WORKDIR}/tee-supplicant.service \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${S}/debian/tee-supplican=
t.service
>>>>> +=C2=A0=C2=A0=C2=A0 echo "/usr/sbin/*" > ${S}/debian/tee-supplicant.i=
nstall
>>>>> +=C2=A0=C2=A0=C2=A0 echo "lib/optee_armtz/" > ${S}/debian/tee-supplic=
ant.dirs
>>>>> +=C2=A0=C2=A0=C2=A0 echo "usr/lib/tee-supplicant/plugins/" >> ${S}/de=
bian/tee-
>>>>> supplicant.dirs
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 echo "usr/lib/*/libteec*.so.*" > ${S}/debian/libt=
eec1.install
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 echo "usr/include/*" > ${S}/debian/optee-client-d=
ev.install
>>>>> +=C2=A0=C2=A0=C2=A0 echo "usr/lib/*/lib*.so" >> ${S}/debian/optee-cli=
ent-
>>>>> dev.install
>>>>> +}
>>>>
>>>> Looks like optee-client is part of bookworm, but version 3.19.0 only.
>>>> Latest is 3.21.0. Please make sure we aren't colliding.
>>>>
>>>
>>> That is a point, I will test it from my side.
>>>
>>>> And did you use the official debianization? If not, please do.
>>>>
>>>
>>> I borrowed something from the official debianization when I was writing
>>> it.
>>>
>>> Or should we use the `apt://${PN}` and add our modification on top?
>>> That may bind us to the 3.19 version for a pretty long time.
>>
>> Check is some salsa branch is holding what you need, maybe even already
>> 3.21.0. Otherwise, it would be nice to contribute and pull again from
>> there, at least midterm.
>>
>=20
> No salsa repo for this optee-client. The patch and the debian files are
> hosted on https://packages.debian.org/source/bookworm/optee-client
> directly. And the latest version is still 3.19 on it.
>=20

I see. Then let's keep it here for now, but we should clarify with
Debian the plans and whether we can help.

Jan

>> And, as we just realized during your private discussion about [1], we
>> likely also need a separate initrd hook for tee-supplicant to ensure
>> that this service is running before systemd mounts efivarfs.
>>
>> Jan
>>
>> [1]
>> https://lore.kernel.org/lkml/4ff09002-e871-38b9-43ec-227a64bac731@siemen=
s.com/T/#u
>>
>=20

--=20
Siemens AG, Technology
Competence Center Embedded Linux


