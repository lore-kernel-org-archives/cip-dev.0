Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45AF46109
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 13:11:34 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17150.1774271488239954636
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 06:11:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cDEmZXTl;
 spf=pass (domain: siemens.com, ip: 52.101.69.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFljY5zLI3shnUVYX3Gvv4QBHlLJVS9aMkJBJibdJvDM1uhOdhb9M1g4+RKCCNfDio0CBD6p5gXGTzXw+B8g/2Cx1ooULX8MhXJAk1XDqDYCBUAU+638GEdY1pUXq03BWg0wX2fENbftmF9ZuKOr1oVIlWwlHNfvz0txvfTpYlx284LOrAuW9J7GZwkO0IQOJolLBLVRSghucsrqwMaPMVFnsjUgN2a679b93Oxrqp4ET/3QqR5jrDPkOi2OFa8RknB7RJacmQ1uu5Y+oujtCWIYA5CRFJQHFfYWtwITl+QHdO/xAVYY6tbRo+FbHD3ugtOEwrFyhXrKbRCb+dxPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1ERKMbophDZkXytHlCkSHZn+N4qbKVHCdKGbALjq60=;
 b=DqIb1dboyB5QelAx1eHkmblIzSsQ5a/fjM87K46OfF/gS4KeAeliWSs/mjmQfH6EZh9S39eTW1wfWxrpSAJDD5GLAiwFD0jd99b186eeI94NM5gVCr5wiGyI0R8BxN2MExROWvLBkIHFnQMbkQBlSLH9ZfyJdYFUIt2VkzXmnU76QefzC3aIwKVovRFrFjJ9VIW7vgYNcnEcTEdfif5fIqm6tTi1A9CqB9f7rs5Ndr5HfMiG5fTEfdkg4eS/o6QmwPsodi1jUB4f6eARpHl0gkaaiWcU1eRDU9dVQSfg7/7M9kQeFSQKxGGlvyZx4V6RrLxRw8DkTqbRul3+gBRu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1ERKMbophDZkXytHlCkSHZn+N4qbKVHCdKGbALjq60=;
 b=cDEmZXTldGYNMkL6Wh6Zes0NTxovTYXNQWm6Sz5u5JwFAn78qlfrIkA+Mf25bHMiEgVWe20T9SFTtn93+QFdSMqgn3+eG2oDeRnt2//akY4auXNUVPmt0w8IhN+2sg8TosyEea/btsGefWaNg0d0s0AHiMbzYkf+71UH6TPA5NyN5aGkV0uncOAememUC4Q/luk8BTNL0b7kECtv/mdp2zuEDkkifc8ZJJAeiEEoYjNAwEGpIjM1bjTCbLnd6d/WsQZ009NA3CfMpBrNWVlD67n6JsQTnTp07WFHJXG5icYAzQTW5wWnDX0DYPWuiQsX5aSzTVsEBPcI8UPYc/KKGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:11:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:11:23 +0000
Message-ID: <42b19801-030b-40ae-b847-8a279a73a0d5@siemens.com>
Date: Mon, 23 Mar 2026 14:11:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH] scripts/tests: Add SPDX-License-Identifier MIT
 header
To: dinesh.kumar@toshiba-tsip.com
CC: cip-dev@lists.cip-project.org, pavel@denx.de, kamlesh@ti.com
References: <20260316-license-v1-1-5bb039f50c05@ti.com>
 <ff1b96aa-44e2-408c-85cf-abae3ae9593e@siemens.com>
 <OSZPR01MB851533DF594CC6F32A00B996BF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <0e193c29-a351-4405-a2d1-a102a7ce4c5f@siemens.com>
 <OSZPR01MB8515AD7A41E51815382BA4BFBF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <1aae01cb-60f6-4f63-b611-aeb940a9f1e1@siemens.com>
 <OSZPR01MB8515B83ADD99A27DDA7DA94ABF4BA@OSZPR01MB8515.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSZPR01MB8515B83ADD99A27DDA7DA94ABF4BA@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0406.namprd03.prod.outlook.com
 (2603:10b6:408:111::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: d73dedda-e323-4dce-9ae5-08de88ddaec3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	8cI47ZYzhmQlVw4wG0PcqqbGqi/2Cf4BV8gpuc4Lhk45oM/W1yncRWcOLKRZar+UcmZapJlpvgq6ZJ6qr/WfNrnUxBI0PCB4wCmxI+Fiukf9oBXcKYEXciNkIyd1NYfE1/uIprwNfvYlq7F4tczuAMs7sWpOuMrgn7OzmN0E8XGW/6nOhm9UrIlyNC71fsUbJGwRVdNbGdrkqB79XUROMAGsVc9OSZfqVVSWTIH7EjcUsX7oRDOX8e+6GsMP6bvhlcBvwmtJwAvwSJ2IHEGidIzPjjGiamuj775FqThCKGFq9qWtJmP/mpRj0aEw2X4ytR1rgTMtG2tJ50JGN5DF/jW4nbQRzTlMyYYTophA7KJBC0JHM7bQDIS9jzgF8m/5IRUgFcYk/z9hR/i+UHirghgy3rf/vzc34oWGpqvDed9/8NJl1/WpgrALP6+lMmijL4jRq6Ftuby4mO5vs9BfIeQkPrJzdnslMZG8Qw3mUArwiu7BzEzPXXEUGrDjZQvKxneXiXwpb5EHWi7uLVFPyu16RBhkm74MXeRkYPBHuDE/mciRlekuuMhnjxKyHVtCmPkf0/0WY12In+DO2kqAIIlZjVq5aVVbTvfvUYofZkWDpK23XamZfc5ihNhC8VTk9b2OaZvHj8PQTdzYyJNjshKD7msnHDqI/7G+n+Px+6K/UJnydkD8ymX/48iC6tf8FOTFOimeAbiHVAOa58xAMESymkilGrjwlNFX4AjUKRc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Flxo60i0pk2IgCnSDSQ0Uc6al5226u4aZ1KVfl6txpemwQ1/rF8XvRktgJCA?=
 =?us-ascii?Q?dNA5rAqBUxkzZNNBs07TCtJq3iGbNAl9zhokhqUUHmREmKMepFQ/NIb0z66R?=
 =?us-ascii?Q?E4AuMxh6gQYWFJSVwI8ijmiikLY5+16aQDuV7Rtx+vniEab7n/Yhj4K+yBaM?=
 =?us-ascii?Q?CYL8l6a23Gez73X+iUaWSkQfsrY/BL6rthg47JwNZmzdfS552Mxf/+ZZwR2B?=
 =?us-ascii?Q?VpZTY+vrjlq0GNXaVix/we/uzZjNuzmoER5GgJWD2q9EWxozJ8jt9JMJCIgP?=
 =?us-ascii?Q?u2D+Hd+UtY7mNz5d9+Uknc8A4l0i+69hWjPBCN9lQVG0c/I7rlph/s9qWgHG?=
 =?us-ascii?Q?qmB1YnS+ghbpQ+sMnhBXJOJp+hcCVPYHLFkQ8hbNYelf97V0b/J/n70B4ql/?=
 =?us-ascii?Q?lFTNzwnIHpp9j7KP4odbdOW/9j0yKv+YF2/LbOZI97BiywDACwL2p+wxlkZq?=
 =?us-ascii?Q?W29oVS3A+GzpUjIDqm+BkN/Kk5pK2qBAYKaKCQWyBEM0Glh0mZF2RxpsNUez?=
 =?us-ascii?Q?7DN0ClFS4TgI9zTz8UIOqM0DB75yVurC6ZTdBA8ZZc9HQqDmegmLbyXTgPLL?=
 =?us-ascii?Q?GWKGhQo08Pj6+HPdvPEgzj6ADr+1bnuS/tXcly33mJhtgdab3Y2MI2HnswgQ?=
 =?us-ascii?Q?53UE02TBVVD1sL6GPNXsyOe4gIjhkLX16sVURlwjHW0TY5JsJni0qJ8IBCvk?=
 =?us-ascii?Q?HcA7mS4ty4DZ61xje+iIOBHPWT2ccFY6pA/+X36PRhr/zAi/XzbYiQgYDTWi?=
 =?us-ascii?Q?EKMIpxMI9VXC5tcf71Lx7xf81rNFegazZRWNNige11gnQgvLZmaDeBwnVws+?=
 =?us-ascii?Q?acGkU8ktCXEX86qXjfZhVa6IraEXcFFGZycm/MevjNfwiFyNwSr36tB4R4eC?=
 =?us-ascii?Q?2juQ4jaF86dkwDnC1O6zTeJuLcYRaetagGwxJMdOBwYwpsUWCIcfq/yWYueN?=
 =?us-ascii?Q?WlELJAw250gGu46S9o17brQJZK4WrhIsSaltYTqkY5TGPEO0dpqHSLdD8luE?=
 =?us-ascii?Q?tB2Qw55TpIAcaCNIguPBdRdHZJzp53ZQmIMF4KNu76gRZAUGmXN0MZK7oiZU?=
 =?us-ascii?Q?qYqsMlcOUN4WT9TzVabiY+Yjjb+kNinJrWFJrJgV5yNLqlcD3NFdblf2XGW7?=
 =?us-ascii?Q?XUJHJ+ucsiyWo6w4jmG9fII4tQv89zTqRjkrEmIMr3TsbJBuvZ1gN363/7ih?=
 =?us-ascii?Q?HPm6cn5s50VPlYbOPFaBkRd4kFUn9wQi5AVjXbwfBDx5RTr3Rq64OafADulE?=
 =?us-ascii?Q?GSzGjXxSR4x/Y/yyV9L8OxwxCHoA1FIa6YIzIG8Nwzfh5nH7ebkADDnIStFp?=
 =?us-ascii?Q?HgSl/qRJNFXHmysqjjaaU1WQ0bfWR4/Vn//mwAa89ibfQndvlZPWqcYYgmLQ?=
 =?us-ascii?Q?UbFwJM6hd+kHsd3XKdEeTLli/zkp5PQWqZjNX7nsk6DDvII/EUKkfseTWCHs?=
 =?us-ascii?Q?uF6YVDozBip4Om0Zi7y36b/vzv10GtFDiCpQpK/qoJw6vNYPfuscao8HcHur?=
 =?us-ascii?Q?HEJGmW1EGwV1sxTaTpWT2qlV9Dmzqvd/FDi1Z1nJS3pXaaGATb0oLXZfmnxy?=
 =?us-ascii?Q?N721ezWbY7kCEjVYfI4jURwxe2hrSvbgtPIhL26ohUuqD521Qmk+0dfbXnrJ?=
 =?us-ascii?Q?sAJqmoZ2haT5hh55n3Lqrx6VkKYH3CEdE9+lWchCMX720U6gOB28EimZO//b?=
 =?us-ascii?Q?3WeHwji/NgJG+xb5OEsoTFdGwmylDDV9x6AEJ3SPXjLxWluBxu1ZTIdHmLqA?=
 =?us-ascii?Q?3ChYsCBV2Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73dedda-e323-4dce-9ae5-08de88ddaec3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:11:23.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78MgGp5S1r0fdQTI8sac35ax88rAhDU7g8OOQulGbpcMZpHkyXUIiBId9sWYYnggZtv8mP1dJ4zB4I3+7BkUHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 13:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22532

On 23.03.26 13:14, dinesh.kumar@toshiba-tsip.com wrote:
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Monday, March 16, 2026 9:00 PM
> To: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dine=
sh.kumar@toshiba-tsip.com>; kamlesh@ti.com
> Cc: cip-dev@lists.cip-project.org; pavel@denx.de
> Subject: Re: [cip-dev] [PATCH] scripts/tests: Add SPDX-License-Identifier=
 MIT header
>=20
> On 16.03.26 13:19, dinesh.kumar@toshiba-tsip.com wrote:
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=20
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Monday, March 16, 2026 3:53 PM
>> To: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <din=
esh.kumar@toshiba-tsip.com>
>> Cc: kamlesh@ti.com; cip-dev@lists.cip-project.org; pavel@denx.de
>> Subject: Re: [cip-dev] [PATCH] scripts/tests: Add=20
>> SPDX-License-Identifier MIT header
>>
>> On 16.03.26 10:27, dinesh.kumar@toshiba-tsip.com wrote:
>>> Hi Jan,
>>>
>>> Please refer my response below.
>>>
>>> Thanks & Regards,
>>> Dinesh kumar
>>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Monday, March 16, 2026 2:17 PM
>>> To: Kamlesh Gurudasani <kamlesh@ti.com>; dinesh kumar(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0
>>> DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>;=20
>>> cip-dev@lists.cip-project.org; pavel@denx.de
>>> Subject: Re: [PATCH] scripts/tests: Add SPDX-License-Identifier MIT=20
>>> header
>>>
>>> On 16.03.26 09:34, Kamlesh Gurudasani wrote:
>>>> Add missing license headers to shell scripts and YAML test templates.
>>>>
>>>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>>> ---
>>>>  scripts/deploy-cip-core.sh                               | 3 +++
>>>>  scripts/generate-sb-db-from-existing-certificate.sh      | 3 +++
>>>>  scripts/generate_secure_boot_keys.sh                     | 3 +++
>>>>  scripts/start-efishell.sh                                | 3 +++
>>>>  scripts/submit_lava.sh                                   | 3 +++
>>>>  scripts/update-linux-cip.sh                              | 3 +++
>>>>  scripts/update-ltp.sh                                    | 3 +++
>>>>  tests/templates/IEC_template.yml                         | 3 +++
>>>>  tests/templates/secureboot_corrupt_rootfs_steps.yml      | 3 +++
>>>>  tests/templates/secureboot_negative_test.yml             | 3 +++
>>>>  tests/templates/secureboot_template.yml                  | 3 +++
>>>>  tests/templates/secureboot_unsigned_bootloader_steps.yml | 3 +++
>>>>  tests/templates/secureboot_unsigned_kernel_steps.yml     | 3 +++
>>>>  tests/templates/swupdate-test-action-M-COM.yml           | 3 +++
>>>>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml  | 3 +++
>>>>  tests/templates/swupdate_corrupt_swu_steps.yml           | 3 +++
>>>>  tests/templates/swupdate_negative_test.yml               | 3 +++
>>>>  tests/templates/swupdate_reboot_without_confirm.yml      | 3 +++
>>>>  tests/templates/swupdate_same_uuid_steps.yml             | 3 +++
>>>>  tests/templates/swupdate_template.yml                    | 3 +++
>>>>  20 files changed, 60 insertions(+)
>>>>
>>>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh=20
>>>> index 623c216..1e08e47 100755
>>>> --- a/scripts/deploy-cip-core.sh
>>>> +++ b/scripts/deploy-cip-core.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> =20
>>>>  set -e
>>>> =20
>>>> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh
>>>> b/scripts/generate-sb-db-from-existing-certificate.sh
>>>> index dddd9b5..42d09dd 100755
>>>> --- a/scripts/generate-sb-db-from-existing-certificate.sh
>>>> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> =20
>>>>  set -e
>>>> =20
>>>> diff --git a/scripts/generate_secure_boot_keys.sh
>>>> b/scripts/generate_secure_boot_keys.sh
>>>> index 8be0569..28ae34c 100755
>>>> --- a/scripts/generate_secure_boot_keys.sh
>>>> +++ b/scripts/generate_secure_boot_keys.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> =20
>>>>  set -e
>>>> =20
>>>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh=20
>>>> index fff8a6a..86e2ddd 100755
>>>> --- a/scripts/start-efishell.sh
>>>> +++ b/scripts/start-efishell.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> =20
>>>>  set -e
>>>> =20
>>>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh index=20
>>>> b3180a1..a4d20ec 100755
>>>> --- a/scripts/submit_lava.sh
>>>> +++ b/scripts/submit_lava.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/bash
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  # Copyright (C) 2024, Renesas Electronics Europe GmbH  # Chris=20
>>>> Paterson <chris.paterson2@renesas.com>  # Sai Ashrith=20
>>>> <sai.sathujoda@toshiba-tsip.com> diff --git=20
>>>> a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh index
>>>> 5fbfa57..df306b2 100755
>>>> --- a/scripts/update-linux-cip.sh
>>>> +++ b/scripts/update-linux-cip.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/bash
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>>>> "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>>>> =20
>>>> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh index=20
>>>> dc8b947..321cc3c 100755
>>>> --- a/scripts/update-ltp.sh
>>>> +++ b/scripts/update-ltp.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/bash
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> =20
>>>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>>>> "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit diff --git=20
>>>> a/tests/templates/IEC_template.yml=20
>>>> b/tests/templates/IEC_template.yml
>>>> index f8558cd..148f07e 100644
>>>> --- a/tests/templates/IEC_template.yml
>>>> +++ b/tests/templates/IEC_template.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# IEC layer testing
>>>>  timeouts:
>>>> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> index b6f6628..5c47b30 100644
>>>> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>            - "apt-get update"
>>>>            - "apt install -y fdisk"
>>>>            - "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-=
image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=3Ds=
ystema '$0 ~ name {print $2}')"
>>>> diff --git a/tests/templates/secureboot_negative_test.yml
>>>> b/tests/templates/secureboot_negative_test.yml
>>>> index 2fcdbfa..a8e4226 100644
>>>> --- a/tests/templates/secureboot_negative_test.yml
>>>> +++ b/tests/templates/secureboot_negative_test.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# secure boot testing
>>>>  timeouts:
>>>> diff --git a/tests/templates/secureboot_template.yml
>>>> b/tests/templates/secureboot_template.yml
>>>> index e29b64a..0a075e2 100644
>>>> --- a/tests/templates/secureboot_template.yml
>>>> +++ b/tests/templates/secureboot_template.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# secure boot testing
>>>>  timeouts:
>>>> diff --git=20
>>>> a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> index 8d64b05..f4f4043 100644
>>>> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>            - "apt-get update"
>>>>            - "apt install --yes guestfish sbsigntool"
>>>>            - "guestfish add cip-core-image-security-cip-core-#distribu=
tion#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/boo=
tx64.efi ."
>>>> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> index f097ed6..6ab334a 100644
>>>> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>            - "apt-get update"
>>>>            - "apt install --yes guestfish sbsigntool"
>>>>            - "guestfish add cip-core-image-security-cip-core-#distribu=
tion#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
>>>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml
>>>> b/tests/templates/swupdate-test-action-M-COM.yml
>>>> index 56ff106..69c9cb7 100644
>>>> --- a/tests/templates/swupdate-test-action-M-COM.yml
>>>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  # TEST BLOCK 1
>>>>  # Fail the job if software update application failed
>>>>  - test:
>>>> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> index 2fad3fd..043867e 100644
>>>> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LA=
VA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-=
#architecture#.swu --output /root/cip-core-image-security-cip-core-#distrib=
ution#-#architecture#.swu
>>>>              - mkdir -p swu
>>>>              - cpio -ivd --directory=3D/root/swu <=20
>>>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.
>>>> s wu diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> b/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> index 74c9217..3cdb793 100644
>>>> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LA=
VA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-=
#architecture#.swu --output /root/cip-core-image-security-cip-core-#distrib=
ution#-#architecture#.swu
>>>>              - mkdir -p swu
>>>>              - dd if=3D/dev/zero
>>>> of=3D/root/cip-core-image-security-cip-core-#distribution#-#architectu
>>>> r
>>>> e
>>>> #.swu bs=3D1M count=3D5 diff --git
>>>> a/tests/templates/swupdate_negative_test.yml
>>>> b/tests/templates/swupdate_negative_test.yml
>>>> index bb79b07..250eaa8 100644
>>>> --- a/tests/templates/swupdate_negative_test.yml
>>>> +++ b/tests/templates/swupdate_negative_test.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# software update testing
>>>>  timeouts:
>>>> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml
>>>> b/tests/templates/swupdate_reboot_without_confirm.yml
>>>> index bfad106..074eb1a 100644
>>>> --- a/tests/templates/swupdate_reboot_without_confirm.yml
>>>> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  # qemu-swtpm.sock will be gone after soft reboot.
>>>>  # So the swtpm socket need to be started again for proper reboot  #=20
>>>> To start the swtpm daemon, first the existing one should be killed=20
>>>> diff --git a/tests/templates/swupdate_same_uuid_steps.yml
>>>> b/tests/templates/swupdate_same_uuid_steps.yml
>>>> index 3ff2e02..8329055 100644
>>>> --- a/tests/templates/swupdate_same_uuid_steps.yml
>>>> +++ b/tests/templates/swupdate_same_uuid_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LA=
VA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-=
#architecture#.swu --output /root/cip-core-image-security-cip-core-#distrib=
ution#-#architecture#.swu
>>>>              - mkdir -p swu
>>>>              - cpio -ivd --directory=3D/root/swu <=20
>>>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.
>>>> s wu diff --git a/tests/templates/swupdate_template.yml
>>>> b/tests/templates/swupdate_template.yml
>>>> index e1f71a9..9a3366b 100644
>>>> --- a/tests/templates/swupdate_template.yml
>>>> +++ b/tests/templates/swupdate_template.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# software update testing
>>>>  timeouts:
>>>>
>>>> ---
>>>> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
>>>> change-id: 20260316-license-c5fcde3618d2
>>>>
>>>> Best regards,
>>>
>>> Thanks for taking care! Here is the list of contributors to these files=
:
>>>
>>> Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>> Chris Paterson <chris.paterson2@renesas.com> Felix Moessbauer=20
>>> <felix.moessbauer@siemens.com> Nobuhiro Iwamatsu=20
>>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> Quirin Gylstorff <quirin.gylstorff@siemens.com> Sai=20
>>> <Sai.Sathujoda@toshiba-tsip.com> Sai Sathujoda=20
>>> <Sai.Sathujoda@toshiba-tsip.com> Shivanand Kunijadar=20
>>> <Shivanand.Kunijadar@toshiba-tsip.com>
>>> Srinuvasan A <srinuvasan_a@mentor.com> sai ashrith sathujoda=20
>>> <sai.sathujoda@toshiba-tsip.com> sarath P T <Sarath_PT@mentor.com>
>>>
>>> All worked on behalf of a CIP member. Furthermore, the default license =
rule from the README applies here:
>>>
>>> "Unless otherwise stated in the respective file, files in this layer ar=
e provided under the MIT license, see COPYING file. Patches (files ending w=
ith .patch) are licensed according to their target project and file, typica=
lly GPLv2."
>>>
>>> So, I will merge this the next days unless anymore brings forward any c=
oncerns.
>>> [Dinesh] yes please.
>>>
>>> Dinesh, the file list you shared directly with me is fully covered by t=
his?
>>>
>>> [Dinesh] No, there are few other files such as .wks.in, .cong, .cfg, .i=
nc, .tmpl, .list not covered by this patch. I think it's fine to ignore tho=
se files until someone has any concerns.
>>>
>>
>> What is the difference of those files to the ones handled above? If we a=
lready make the default licensing rule explicit, why not doing this consist=
ently?
>> [Dinesh] They are mostly configuration and data files, but I agree with =
you to make it consistent across all files.
>>                 Can you please proceed to apply current patch and we wil=
l send another patch to cover remaining files?
>>
>=20
> Let's not just scratch the surface but do it consistently and
> sustainably: Which tool did you use to identify our gaps? Can we embed it=
 into our pipeline?
> [Dinesh] I just used a keyword-based search on the output of "git ls-file=
s" to list all files not having SPDX identifier.
>=20

The please document that process in the commit message. We can then
decided wheather to encode it in simple linting step or try to make some
more generic tool happy with out code base.

> I just tried "reuse lint", but that gives more complaints than just the m=
issing headers. E.g., it reveals outdated SPDX identfiers that we still hav=
e in use ("GPL-2.0" and "AGPL-3.0"). If we completely follow the REUSE spec=
 is to be discussed after sorting the reports.
> [Dinesh] I agree with your idea to track missing license issues through C=
I checks, but it may take some time considering we want to get the badge wi=
thin March as we want to publish blogpost before 06th Apr.
>                 So, my idea is first let's add license details in each fi=
le and later automate the same including other issues you highlighted. If y=
ou are fine with this approach, we will send patch with remaining files to =
complete first step and get the badge within March.
>                 Later we will work on automating detection of license iss=
ues.
>=20

Fine with me - as far as it is about adding a header to a file that can
receive one. Some files will be naturally left behind, and there we
would already be in the space of specs and tools when trying to also
cover them (beyond what we did unformally in the README).

BTW, as this change is non-invasive, I would still take it for v1.11.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

