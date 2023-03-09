Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDF5C64EC4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 07:33:09 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.40])
 by mx.groups.io with SMTP id smtpd.web10.7916.1678347185237348993
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Mar 2023 23:33:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bl9808Jo;
 spf=pass (domain: siemens.com, ip: 40.107.7.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8nGKyUx45iu6R8p0uounZqCNNY7eLQU8psBAxQj4gREX11xGefysKaWRkYsZhlN3V6mEYAzKEwK/YB2w5H1evJvne0Py4VOG+2gRGcX4hj6jGD47A0FXIxhbWVLRU+Lc19IeWzMxum3GsdhGc7MtV1OoAThrq/R7FFFacDAmNoqEVHAVE1wa/3Llqojq8vsUSRO9BayMjKQYVUIJGoyM9O0JBbtPyZ+yzEZJL6ZZbv1Ff4GBhLpF4e8dHgTGCSjALrRMzxt9/JhYCn02Py9Qzdn8/4cUoWRydjhZhjJ/nN/Fl3bhTEPxrEq6Cl5D55R/TWGYouNHkWtqsRAVCjsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8AsYqkHM10cBtAP8EzKaPrguYkwv64HDbClXi6TwgE=;
 b=RAeH8F6mYMSh0yTgHbieqMGmIfNdgb9M3X2z6lALtLx+ISCSDg434NzbcEaCNpAcb2qtdYCNcoi6OxGrAAVhWUnbdZHHIUlXh9fntbRL1L18eso84gQEmAzMuP7uHc4a+v+OSud+dnFVInI2A+XUf+Whr7nY3IcyNmi0QSCZEHiBEa2qa7/yg4vb5A3ove/JiEmvpSsS1rCc44ba9IQluJsdXbVpw134Crr5gtNurDuKncfqgTnkoBo1mf3UduvlKUzb7E6Bx8Ju+hzGYdUZ0YQ7FLjX7xMpjgtriNR1vuW7wSVp0wYWqlaoODtrDqlfypaHTmwlSj5f8Mn/Jpy8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8AsYqkHM10cBtAP8EzKaPrguYkwv64HDbClXi6TwgE=;
 b=bl9808JoZ1JAVkiHiJnKdIsyBcZ7Audii6A68Lq1hRT4NrHvUCbIPrRqS0mXI6TssUbQCE7sEtCFPAJqoMMOhg4OcQZnTWCx5yJKRbhiRMvojqJCBLgzpHeVCyXCPXWV4U8x6oYsGO3mLkPgiDklH4igoVJvpExFQTgzLgthOg2rBg6WstAnNQ2gMyLnCVxciL2w5NTEv2epyfcd7UW6VNBQGmdG2pcIreivyVC3PmN6NM76+Kmvbk9TtIVyHh0Tu0ESaqP1Sdh2ZEuVKMnb5sAEnmpqBdB4ZjuewGmI+K5tKXZewJ5zYCtryu1ZqP0Bjv8cbLhV1ltntByO8+5zZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 07:33:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.016; Thu, 9 Mar 2023
 07:33:01 +0000
Message-ID: <3638b3dc-17d9-0b4c-f0d8-d5255d9ccab0@siemens.com>
Date: Thu, 9 Mar 2023 08:32:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/7] KConfig: add tpm option
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
 <20230306123926.243471-3-Quirin.Gylstorff@siemens.com>
 <3806f4ee-3a03-dfaf-72b9-fd40180be2a1@siemens.com>
 <9824f158-130d-6bd1-e0ae-6012a540d72c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <9824f158-130d-6bd1-e0ae-6012a540d72c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c41524-9cce-4a54-2e83-08db2070832f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	et8qWEXYrtUbiwG6mrvVurl65gCQtCh/V+qXxHQZaZNfxlJIWBzu9DBuq0uIy0CZ3bl5W+jNJZepcqBmPCq822kFmtNVg5nU1hjK/M3auzwE1Yc2i65QoFtYEN0UsjjmmT01yAbyyt/lIdJ/RwqHaY3TGLsST8Yl57iUFYXOIkeAIeupZ09XpWI96pILN226Bv7kV572nJ2V2tKBhzpyUJCozf5blx2xhZ0EHxTqnsDsMrDCGEKQNqomW1A3T1Qyb7TEc+/Rfl7+XM/YWVv5xvEvcacBFgh1In9YJDtUtTbotAoRM+YF9nRgM+RYHIqWEBp+UAd8oo6xcpfDjXWFL1XzhlSRyz/cMV9aXNUWjKedyI3DFBXXk3UI1BBnNYVCcetHIVLGBuJhd1ymz/gsH+PBWrUGu8YTAN8bLBq5Cx4aZ7dKo7CCWdLOAy8tFHfTrBi+qaZULDKEWkOXsNG5lpx2/xuBQhRmymnU8DckdHfr/MNZMIuGRM76QaKUeeej4n8x1AlynSRdzNxCmbl9zPTcKOr4B6zq5zOfiM/3pcKvs/pxZZiqwlUwFKNwzcqpHfpaQTm7ZS/rKD7DWVd44pYrnSS4qNEhLJ7o8cZkrzsTvDE4XoGrhfcTUAEqcuaFToQlugzLET0+hfL4xb+yDA4e5KqMmYQO7/J54LgmpnGHQr8AXU2b/sYEEtHrn3ZuU+juTTyiGFRLoMmZ3aJ/etvuH2S6MYXVJHWyr0mlok0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199018)(31686004)(2906002)(44832011)(5660300002)(26005)(8936002)(36756003)(6636002)(41300700001)(66556008)(66946007)(66476007)(8676002)(316002)(86362001)(478600001)(6486002)(31696002)(38100700002)(6666004)(82960400001)(6506007)(6512007)(53546011)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lqoyOzz2QUIONKzv4xSMaUcvf9Q+aj6uYCXFafVcLqZq4iSZDO/xG1bKUtUl?=
 =?us-ascii?Q?oLdHjGWLg1jMqHwQZgNBBoACVOWjmxogFpP+MMeaksNU8+4bVc0IEPf9a8Ve?=
 =?us-ascii?Q?rvmpkiUh+iGTuUXpg14Nq6vCrSGw+mg2J/12zw7scmgM3/+ql1mWONWSxV7X?=
 =?us-ascii?Q?cDh7QBTCluRJ132Xa3PVzfmkCKT9xIz0kYxd0xEhb5Jur5TmjhjO2Ow50AhQ?=
 =?us-ascii?Q?3My1FxFaf0KJUcXWCmXCmOgC3GP23MoqF4eaHJpabKSR8umXdqdOTms1nIV6?=
 =?us-ascii?Q?OooysyzraqbdZEtwi07MDeYHqgIXSdDmLq74QEjJbrI6MnhyVivxS0HmXRR3?=
 =?us-ascii?Q?6n/y1/PDcYI1cwr9uhJiucqHcllL9501I+9d9k9mLwxYd4AZchMO9magRH1d?=
 =?us-ascii?Q?7cfqdF7rDl/h0ZX9RxMJRubVxs9gVvlftkvb56C+ncSexNP5ejDLMrmz/Y2G?=
 =?us-ascii?Q?TPTGZeSvps/tcxIhcWfc7bAXY24RsZQna3xtxTePrCMT1Qp2aQ7+o1dh7jJ5?=
 =?us-ascii?Q?qZWJrDaKo0ljm8kizrsu+hf+d6XwyQYPyEL4oB+QexYC0Ur1nCnJz/TXO4j1?=
 =?us-ascii?Q?LPt2wIT7c6hva/gNgr0ZgdQ8sLE8DENJt96oaDi7duMSx9NGdaHV9UeSLHaK?=
 =?us-ascii?Q?zm9Q4nD9XDfGwFOULcfwhWiGSTseoH+cJj3hUVjMjtV0+cIav6xoWeW+MBV7?=
 =?us-ascii?Q?b++0NdZbRoMQpNj45XnN0PHtfynRdsPqHN3PlbbbhJiQ4IlPTP++qaszueqa?=
 =?us-ascii?Q?wlJ2smB57T8x8kU2oNpDhDtkMCA0KHT/b79bJMC4adFt/MQRp1fJ1/qUE3aw?=
 =?us-ascii?Q?DCgankgcGyA1bg6nKXH1g5ldWPbV7j+JW//b/qxeIeOZRjrYi+78KQLHVHCu?=
 =?us-ascii?Q?sY6HUZPA5RdI08xkRSVR+tiY0UZ+4DpysDhr6Sz/IG48AymPGgz66gJnMn3a?=
 =?us-ascii?Q?yEI1c96DM35z3kOQ6Ic5Tq3Wr1nWtQpAg0rujDuOFTb5ie/mvzOmZLGbzg0c?=
 =?us-ascii?Q?PJ9yHpwZkrf1xUg3ZefXi62Q+nYkn33Ik4dGY82rKSSDWorkrpuew9o9iwLX?=
 =?us-ascii?Q?tZYNOAtW3PnB84O49iAsU5jE+ZF59LQ745hsYJ747UH75pO9hDgtt/oE+vxS?=
 =?us-ascii?Q?aQj+W8zRVomjQJyOw7V5RRUr4wxbsLQ2FcKFzwIWMUNp6E0OIREFTsG/CZg9?=
 =?us-ascii?Q?SNAau6Zy5KRemiddfKBvl1yaT/z4stWGYYk7AbUQy5McBqQC922q+at2CRda?=
 =?us-ascii?Q?LdkZJvXP0fQhc3nAdnRsOO24IjAsadDGTnxoMWOR+UHApP2XgC+CVMMTroBc?=
 =?us-ascii?Q?PnRLiPHpaxG5ZsoBLEB7xoMrThlQonl7OHgaKPSp7IrLvk8dyy+mmdW8kmUQ?=
 =?us-ascii?Q?f+9Lrn94u5IOH/kp+n58Tf9JbEX71+dYOkYPPnOUbfRtVj+SgSD697TVW8A5?=
 =?us-ascii?Q?6ufp4jla0gI/02WKkCjfnuXv2VfAAEIjJjgg3HXNmlLY/sFYEVMeGEyHAnir?=
 =?us-ascii?Q?IHSygAD1Pkxusdi49WV7sU1y5ILM54fdwzTKh9f0W2wi8MVG3nvJjS2OosA2?=
 =?us-ascii?Q?12vXATpTiG97FICB2zIF79nFRztg3f7S4UzhyWan78xXPmytxkB6+URNxTpi?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c41524-9cce-4a54-2e83-08db2070832f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:33:01.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ0BW5IFQ8QfuVRZrkuUDdEUK4POS5apDTOn/MSF693ZGMCgbLVEDDNNuJ2/xe3GnHQ7fZO+bTyiJsbbUAUU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7924
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Mar 2023 07:33:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10955

On 07.03.23 19:32, Gylstorff Quirin wrote:
>=20
>=20
> On 3/6/23 18:27, Jan Kiszka wrote:
>> On 06.03.23 13:39, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 Kconfig | 11 +++++++++++
>>> =C2=A0 1 file changed, 11 insertions(+)
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index 7d72094..7ce87d0 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -193,4 +193,15 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/opt/ebg-swu.yml" if IMAGE_S=
WUPDATE &&
>>> !IMAGE_SECURE_BOOT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/opt/ebg-secure-boot-snakeoi=
l.yml" if
>>> IMAGE_SECURE_BOOT
>>> =C2=A0 +config IMAGE_TPM2_ENCRYPTION
>>> +=C2=A0=C2=A0=C2=A0 bool "Encrypt partitions on first boot with TPM2 (D=
emo)"
>>
>> Why "Demo"?
>=20
> To mark it for=C2=A0 demonstration purpose only.

I meant what part of it is demonstrational, what is reusable.

>>
>>> +=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64
>>> +=C2=A0=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables TPM2 encryption for the pa=
rtition given in the
>>> variable
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPT_PARTITIONS from recipes-initramfs=
/initramfs-crypt-hook.
>>> +
>>> +config KAS_INCLUDE_TPM2_ENCRYPTION
>>> +=C2=A0=C2=A0=C2=A0 string
>>> +=C2=A0=C2=A0=C2=A0 default "kas/opt/tpm.yml" if IMAGE_TPM2_ENCRYPTION
>>> +
>>> =C2=A0 endif
>>
>> I'm struggling a bit with the naming and description (throughout the
>> series). The feature is actually data encryption. The fact that we use
>> TPM2 for key storage on x86 (and possibly also some form on other archs)
>> is an implementation aspect.
>>
>> Let me think about it...
>=20
> I can change it to:
>=20
> config IMAGE_DATA_ENCRYPTION
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Encrypt data partitions =
on first boot"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables LUKS =
encryption for the partitions /var and /home.
>=20
> config KAS_INCLUDE_DATA_ENCRYPTION
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/opt/encrypt-parti=
tions.yml"
>=20

Something like that, yeah.

Thanks,
Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


