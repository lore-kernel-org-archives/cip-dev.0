Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9999AC5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 12:25:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.33])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5415.1785500703151225327
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2026 05:25:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZH/GO44t;
 spf=pass (domain: siemens.com, ip: 52.101.84.33, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfakMfDVxUcsKHuxxUyKCAFJybWfwhAzywDNCX2wJ/SA7aX8jN3MHweMQYInitvTvr18ZQ26XMK+VPgSI3cvK45GCv3Z8V9q4EMiOPjtNL4w2Q1WW9vIrHUbz13tUmg+/gxwhIUzVLzim6g42Bf3a/T1AkoHS/cig02BSXlnpHiMikF25IfKItW0ztq9PfW+jQyjtue2VskoCsjX2GiiEALKgku3OYn7SeLqjC0ZbhCsPVguhsC1U8O+248wcI64yzMd1f3WKuKF4T2jLNizGBByWu4cY6zeIqAtllJDzp5S29QSkhn/XAdqZPUWR71WcAxiogPuiqzZlphEX3oFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkbNdH0p/Jt3Mr8lDFEivxvvcRWFcLtiwklPEE5w9Qk=;
 b=XtlcJWNltfPYnBAZgYqAptG5xfm7SdDc/hqm2OSW78DY6nm8cIPY7RO60/0opE3KiSBofYREFBGmoS/b9oerEoMLlXjzXAgqKXRhHI1HUcSjS30J8Hai5+00XXjfxmuzfggXU84TaN158K2BzqeorOsfraaWTdkUUGqI+33ijakStmkmVBVgx8VZBWgtpM9zZCBXxDrVDRpgSJwBBBE1WSc79Stmn2syo6tDsfzFVxkYSV9Uib1nsYsLV2SrRbtW6ulfpf/sBV9QA+TLVSyumVbQBZYu5cZ1BMY/1TEd1AVzcVocCf/kas7nxbRgvhNejC0lq25hA8J6pfbCTkrdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkbNdH0p/Jt3Mr8lDFEivxvvcRWFcLtiwklPEE5w9Qk=;
 b=ZH/GO44tYA08MNWLAybCpGy4IPFVARyE98qiRek3NE3dXCD8jBePs9OJ/ZwzoG0qYsi2hFKErMR3xK8M8UZQMTvs5wyfi4WkH8AVYRzQQFUoyZjsvzHxfbMF0eaj5gi9Gt/M8eupTIP15GzBiZhjiSgT5zmHS7Qo846MMgoy6IixX+876Cqfq0nCCWqPl/Eo1LGAiHPZS0x8rdmyQt+KA6sYRma8LmWqzj/gUgq9EqVVd8PPiWttieZZ9wwTMlnq+JyeYkGdqZ02eFNoBuI4i6vHcfACV5ARHGvE2cIXRUfbpPeCrFAbz9/IyKY+mQmKBOb3w3wwSzQ8nHe2XPEqGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 12:24:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 12:24:58 +0000
Message-ID: <0e62c534-e8ac-40c8-bd74-ac27428da434@siemens.com>
Date: Fri, 31 Jul 2026 14:24:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 06/14] Apply hardening
 configuration to the kernel
To: Christoph Steiger <christoph.steiger@siemens.com>,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-7-Quirin.Gylstorff@siemens.com>
 <db84a10c-e0ef-4ae3-820a-3bb5198b263f@siemens.com>
 <943afddf-f520-450a-82e7-3d33450fd189@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <943afddf-f520-450a-82e7-3d33450fd189@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 280a1082-eeac-49d9-8a72-08deeefebc4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|55112099003|4143699003|11063799006|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	TdhKKy5QpjRMqCIEJnpmPMHaqdolRQFa9FAI2QYKi3MLJvrCHb5BfwF4tEYI5wk8XaqsuGIUo/8gngKuZObgda/YX3FhsuFjd3LcK6jjpfuhnqJOFIYGcty+yoG7T+YfZGI6lWpLFXamHacxhDUlUiru1uTEipkwiFbtA/AMdl8jmHt8BXyvqhb+XWkrE92kIcntHNIM1XrvjpK3zYsUQV8rxNAtTP5xce2ZZcZqQF1OZOHpmuBpmx5j5Kn/w/N5tE4KyiQDScOohjlq5e+6KTXyJQb2ob73cd86YfKfLA8e+FhHwJHDLoEUX0TO7RxT8ZW5hwCesC3vgYSK5ALDvDcqu9H6y69nuKurB5Jutp9yel3uo4mtdcOS6YzfBgstdJK6g5dJPLDzbSz4Tm1SJWPo7D8U7oDnuTNuozQAFi1lGd2raeIPHC1iMVR+Cu8f8PmORDVDQPz3j//qeSt+m2CZPPmxO/W1NBw8o/G0j/gVqGv5F+a8cy433bYQCP7AMUvCYrgiDUpbgHiu2xq1uZkgMctvtExYAgRPJ1kJUgCiFYvIASGWuyZzrOlH9WPeu3qSnlk9QRlCokXFqjUAU/Y7rLamB8rXc/WXoCc43aj958q2rP93wu4eFI/vwnzddcDTTcWs6meSuITtS6LNKfLq2VUbnxpUu2AIek3zUp4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(55112099003)(4143699003)(11063799006)(3023799007)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6bxagBzXKFtX/kiOdebrJh2DllvflfLuJUpxNO5TvZmi9B3n2R0KBqnaD++k?=
 =?us-ascii?Q?4R0hooJuhdPPwp+3zRboSTEH65YqiFFejKlvrKbayYo3JyAROl39o1kjWUo3?=
 =?us-ascii?Q?kctLDUW26ubS81XYNWsQTDNJ5AgszsuRVVhTBEwoL8IbPsEikpi0PKVuFrt5?=
 =?us-ascii?Q?dBTw7+22o6iFpsRVeNKNfZXLLWeJCmg9SRSKjRPuJtiMMbd9UQG67w/cbppy?=
 =?us-ascii?Q?c3H7F5LROSao7rOl3jIEmtHNRYA+Q12pM1mL7nJhReswZqY7HbXrdEX+LVQK?=
 =?us-ascii?Q?TxJkvLBd0NMKgJt4QJbZAwAwg5RrKhaQMtUAfRkWb4d1gl4BNDZMyWW19k4s?=
 =?us-ascii?Q?hR00ifI8C0eO+9asiUCVL4vVAVoKQmqXSFXsXcVJnAZXkseYYUy7DeVuNKvA?=
 =?us-ascii?Q?1SVIUtXnudBrpCJmLINvMbocwnmJvPR1X2/yQtoRsOutenzKfguQkiYj5cUS?=
 =?us-ascii?Q?X6rdsvbggp1gOnYeHJw2wMqkSrGhxJ3+H6nmPYY2RIkJXnsLNNeW3ae2bXC7?=
 =?us-ascii?Q?YUzkcVJxwVETLNk7i7hT8sQg0/lBk9kr/Z4Slgq+Af0HTWkpcKDDbht0yJny?=
 =?us-ascii?Q?s4quFgS9E6cob2jgd03uST+8HR204NnB3Yv7P2d+LJvWQLfXr8J8iOGKSOQG?=
 =?us-ascii?Q?UH5KN6Q9dEVugqTzIDHWlk8M99lYyjzXp4ykWw6S3ZI7foAm7EtGClnTeQvB?=
 =?us-ascii?Q?kH+vMSf0MKqRHRSNanVtNGDWC9qXUQtoG4mBKCfpVr43+t0dpaHd/ayznmSu?=
 =?us-ascii?Q?bKgxa95lENnie+Eap8SL9fZFJOJsDpgYJwyomIXAFat0DVc7zIBsYsga+ICH?=
 =?us-ascii?Q?cF3AzGFs5+L0OJB3A1RnKzydhQwFgVZL5ipkb11aVbcfbTtIE9MCjBw3J/fx?=
 =?us-ascii?Q?BF7vg+LKFNcOR+NSlvcUQQw8qNKtHJeOOJn+9Ef04KNHfSnbFPEykYtZhzNj?=
 =?us-ascii?Q?v5lHhma8lnKGtcGAm6nbqOoAn1Beti0GTuZZOlgUiglKcyHhGVi/9KyXVZJs?=
 =?us-ascii?Q?RQjdyixTXEucvg+Y4KEntjvk4z5NRTVnhcuUijmgyzRvfPWDXXTOrnuMDFeN?=
 =?us-ascii?Q?jJuT0eBSXbw7PN4VYT6K9Yf5oSN48WG0ScBHecloCkCLx07KXjU2o1x1y9NE?=
 =?us-ascii?Q?h6fNZaH/5uip7PSgPFfDJqTsPfmV8QeXxzIJNVl22tr47FHEK0PL7SZzW81z?=
 =?us-ascii?Q?U8idFesvTJ5PFb1wl4mlGO0aHivH7FYHqTbSc4bYu1v0GbhqNCKOIZPYnrB9?=
 =?us-ascii?Q?/S3y338kFhL8b2bMpmWvylu17V8Ek7cBrIlyMaMKixzrKMRpCIEp3LjgVxnk?=
 =?us-ascii?Q?eVdQ9kBSx1fiwFYCiTNJCkBc4tMMs9387GFCP0iqfBU/bNnVDLIg/DBNi0Ln?=
 =?us-ascii?Q?aCAxw3jszRfh5Y1z8Uj5L3YRTAh/q9tuLPNfFbdI5xjto+KBzMNGV7O8yEAo?=
 =?us-ascii?Q?pNtNOayqjAufd6YKbBnpoNd6bMiitVGGypE1L+Xrsif2wL6ZoGN8UWitUTYv?=
 =?us-ascii?Q?dPXBiTgx0pYfLdd36mrNPfA/yQlvBLCKHGWqxYwfYulc7d8yhd/EbGAoOCFz?=
 =?us-ascii?Q?4Hr1dqmALxGmXr/1+H9TfX+snNNOm2uSGvfXJSfpCVaXQcBxwwd0m7NabWm5?=
 =?us-ascii?Q?CW/N7iynyfBs3IonPXZIIDla4a0hNbkGzzWsoeZ1MOTiOLiNHKfqBnjmuuw6?=
 =?us-ascii?Q?r4s0jdc9CtNRk+fXZgYm7SCDE1dNRa3jbcMkBUoOB8eKyHP6OdC0wt0FcElz?=
 =?us-ascii?Q?81eOGhcC+w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a1082-eeac-49d9-8a72-08deeefebc4b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 12:24:58.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+UpBrxh4MkBIlVK8jz6+1du2naQoe2UIkl1aJVhDCch8oWCkpguNPk+bY9y7ZycPmqSOqQUd/6Pwy6YYfe2TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6007
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jul 2026 12:25:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23824

On 31.07.26 14:05, Christoph Steiger wrote:
> On 7/27/26 4:21 PM, Jan Kiszka wrote:
>> On 24.07.26 14:39, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Use the provided kernel hardening configuration options in the kernel
>>> build.
>>
>> Err, no, this does not do that. This just drops a dead include that
>> could be used in an own kernel recipe, and only then it will have a real
>> effect.
>>
>=20
> ACK, we will move the corresponding changes and fix the commit message.
>=20
>>>
>>> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 recipes-kernel/linux/kernel-hardening.inc | 16 ++++++++++++++++
>>> =C2=A0 1 file changed, 16 insertions(+)
>>> =C2=A0 create mode 100644 recipes-kernel/linux/kernel-hardening.inc
>>>
>>> diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-
>>> kernel/linux/kernel-hardening.inc
>>> new file mode 100644
>>> index 0000000..2b22fca
>>> --- /dev/null
>>> +++ b/recipes-kernel/linux/kernel-hardening.inc
>>> @@ -0,0 +1,16 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2026
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +OVERRIDES:append =3D "${@'kernel-hardening' if
>>> bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
>>> +
>>> +KERNEL_CONFIG_FRAGMENTS:kernel-hardening +=3D "hardening.kernel.cfg"
>>> +
>>> +do_dpkg_source[depends] +=3D "${@'cip-cis-rules-
>>> config:do_deploy_hardening' if
>>> bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
>>> +
>>> +do_dpkg_source:prepend:kernel-hardening() {
>>> +=C2=A0=C2=A0=C2=A0 cp ${DEPLOY_DIR_IMAGE}/${DISTRO}-hardening.kernel.c=
fg
>>> ${WORKDIR}/hardening.kernel.cfg
>>
>> Why does this need copying? Can't we just reference the right .cfg file
>> in SRC_URI and let Isar do its magic?
>=20
> The copying is required since having the config snippet in `SRC_URI`
> makes it required at parse time. The snippets are created at build time
> by one of the cip-cis-rules recipes.
>=20
> Either way, we are using most of the magic already by simply adding the
> snippet to `KERNEL_CONFIG_FRAGMENTS`.
>=20

That is fine, but then just refer to the generated snippet this way, do
not copy it. KERNEL_CONFIG_FRAGMENTS was exactly for such use cases
extended recently.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

