Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC575C433FE
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 06:00:18 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.46])
 by mx.groups.io with SMTP id smtpd.web12.8097.1667541615603472224
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 23:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qKybjNbK;
 spf=pass (domain: siemens.com, ip: 40.107.6.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0di/Mp+M5YGOa9nhYVewEA0aVh1gFvp6tdAFJMEHvaT7s+m1K0Lj9SMM5bMqp9RI1o9elet/unAK5d1ar4YlYJq2TbK4RIyQlpQvNnIdnUjZRDm4rn+y1mfYVDh1Q27S0MoUl6Mw6vdfI2XrcPwE8CW7w5LeuaQfBG+bsrFMAYNnMJIlG18OyTpNyw/WGLBswuUcO3vnZd/gdY2GR/fOry4/NVbduJOxFfjE7d58L98iHr3gu6xHA2zqcUy3hyM2UDfVx05YMhCATmTGDH+RfM/Y2k2bSTyxrtp2NUxjNE5Qm+jHm58P1ngMe1lf5WSYrK/FBtkrtq0w2zaAn6GUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3J8AT2R0wFVgwVhYD9V624GEJgot4sf+qmj++a7TkQ=;
 b=JsrasGwnhVQ9lP4/F/0SbDyT3q5twbg2CPVZkCNWDIjnCxOa1kLTcvVc/rmSEuFkwFPcCbdz1yUQlnI3rltBvLiVQhTq+3NLkgMTCOVD1UGY8gBTBPN0CtK7GbwBk6OfwOZ/CQ49GMhyYjzlUl/fGLlSRb3bZJ8eU9sAIHZeUGyWH2QkM5xTkLUE5yIXD+UO67F5LdiZrsupO5UgTnaln/FnDnq9TyrHKzRlhokersvjv92XWvO4aZw0ZiyMGMG9ckJrSleoEnbHRJXMcYe30YNS5TYULib7MvcxLpnh2Qd4GJnPkNEN8t/Ccvedhn7ELD/vw7bbowVgL5n2V4DJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3J8AT2R0wFVgwVhYD9V624GEJgot4sf+qmj++a7TkQ=;
 b=qKybjNbKAu4i/vQCiMYlg1+jWbtA5uwwMOOj98J9UbDsIxe6tRgysgtTmc8fChxMagxELglRu9m2Uaxed2/cpV88gQE79W/ITq9kWtbg/xQ4kUe2vrXCodeNZs9ysv9M0y7ulvFUVkF0tLiif5N2Z/NyyABVXSVkPCD+MHe4m/3MKNPkgqMWA/bhz3DDx0nak7IEFIwHh/UE8kI9PXiKXNDdWYgMESDcegc+FSAtqcqdoFCA0esWxnMY/VOPi9RXQAQieen7ccxxuwxbbxFx+iw7Otgr5P4Z9YLbDO5OvO39R1U6bx2DEjSjzpvBDJw/t7zrTBlW+62hkFFXV4sSGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 06:00:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%3]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 06:00:12 +0000
Message-ID: <1e13a920-af10-1f18-cb16-8057d141aeea@siemens.com>
Date: Fri, 4 Nov 2022 07:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Adapt installation
 to Debian upstream
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20221103083643.14912-1-Quirin.Gylstorff@siemens.com>
 <2fd34818-509d-567e-0de8-1eaddfb2d975@siemens.com>
 <a2e8a677-1b89-e7cb-9300-22cd6a711f12@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a2e8a677-1b89-e7cb-9300-22cd6a711f12@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: dd55a2f9-bb85-49fd-dedc-08dabe29d604
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZtH8ma3ezk05DG76BSZQ20baLBsdvkwdqhWgccYxqulCGUJAGbBm1p5QIxm9ux92hntw+lU1RLV7BuLLvX9wWns9lE/CGowfGq2kVlsL6jKJDwMHxddr+Tle2Mng798F6gA385AnNovAuAAdo7v1dURbNoobNLNR7Zonm9BcuvveiZD2gaatki0aM9oq789cd8zgN+fxorqqVfCPRB4FwvN7fK2+mOqiVDLLVWG91XMfQQHf+W1wkxtjAG6yUQlsoQZp3HSfvCwtUeKJH/ip5T2rX4x8z9g2Re5yTTx+EQ6y2lbcpWOU/vZeiQrpkjg4B7iORQX853R5w+eKQy1mC8lROF4u4m45ica1b2lI+pR9OF+N/tVnf1QUyiE5vv1SyyF5zegJN4kkShv7NcnTHBKzHufeES6LqPCnTw2ZvMtIKd/QJ2b4RiymrzPbeBhuUtQpGwo/UHe7m2zY5cr7o57gS8m8q/mw3kc//zx/m7A/+OxnQfAUbeKNh5FaXDV20eGuBBo5kw88kSz3dUkASBLpJBaepiUZ5q2J3cJm3q+vIQyhumiX2dWurvBorIrrtDyY1SA0mGec9eD4LXf29uMDfipoKlowJtYrYx2ikMek+k02WPrnGn36ZwOF7X9xNxPDC68et3yZ6lVA/XFkLLPQJlM0G6nt4DPQPscFBas2v+m5iNljbNf1yzDpBM+4yIWeABC/obub8BmZ69lw98UR2Tx9s4qtTVmcQvjcQCoD5FnYyExbfN+1OVQDudficchi9XSm6rneE6a4N+9FDfU44/JaAoPxqoVktmBjipzXal9cCojdKNyc3ruYzH3hycl9KE56dVY2VkVaygb1Jkl1vPvEzxBgHj46Wtm8sBgU/9Y2HIEVhE5Lex9AiMD1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(66556008)(66946007)(8676002)(66476007)(186003)(316002)(31686004)(6486002)(5660300002)(478600001)(2906002)(44832011)(31696002)(36756003)(966005)(41300700001)(8936002)(6666004)(26005)(53546011)(6506007)(6512007)(2616005)(83380400001)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rs/k2al0SrV91EOxtUVP/HjaznufJ5kS71vbDyjvlMYPTpw8v+0cspMyI+B5?=
 =?us-ascii?Q?BxMeASLO+qIHfgsx6kq8ljKdrzU5sRtlJU+K9NJq8By7gunbY6VasMFURJCi?=
 =?us-ascii?Q?yfCkaACsDZdDIGE/Nw2SIZ3GKdM0NA2+0cgozk+mBwlsTGrWAYULdWjDmpeX?=
 =?us-ascii?Q?rXIQDa+9v5fpiRkzIOrInkDOjA+JPYxhJdUP+4Z00mKE0g139dMiqNPWzEE4?=
 =?us-ascii?Q?DGzHybCBfH0jsj/5S7FZQO2fDvr2nQCFO/Oc0CPKUAc/J+uq2Z1xNxhuNwUC?=
 =?us-ascii?Q?MfVoQOGaZb2ksyy+N110wn8SrS7rOoaLFSWTQ6aMh83+qNTd9MTJw3706rGQ?=
 =?us-ascii?Q?qt2Z2ffj9n88kmiRTFq3MKioS3xUPYXGxLpim06aQaT06ywg3oQEeyEHc8Nz?=
 =?us-ascii?Q?x67gdrTaDbMqrrCeCDI5DSOHsxEUknfuFlRPz+D7teXnyppIjVkTtKaxj5G0?=
 =?us-ascii?Q?UQRkE9DPpxm+p8P+Zc1eJWlQPuSD7db4PIPINbUVOYbJv80E/PqjAPh5nqAO?=
 =?us-ascii?Q?bOHsxyv2HpmtI7mpzKK1sT0T4u2sUiPbEm6GwnxEhnmgTXKuk0Vbxk0y8sXq?=
 =?us-ascii?Q?FCSoo3eeUiRjsVyTzAGauJk70NqsrZ/STsfATGx6JIXuXuEemRmHc3ce812Z?=
 =?us-ascii?Q?K4OOOiymljrqpIeqdNLQkeY+wc4GXgTZfb5b5Kakp30sV45Kfec0LUSNE05k?=
 =?us-ascii?Q?NaA4Xl2RqWpCS8Rcg7tPcK/AWMfAwmbm4yONVhEP9h5u/kiOKi5tj11N6YTd?=
 =?us-ascii?Q?gQDJ+d0Nq7M9jK2Ynl04UfsTkrpezptHhWVbO2QLwe24FUF4DxQFgimRutxe?=
 =?us-ascii?Q?fSxyy6wwq+ToQnpPXj6S9U37V2AVhzTB1E4Jsc5SrpwGNpIUEcEzfmzx33oW?=
 =?us-ascii?Q?QzcBth0lKkiGg1v7z98DHW9qPabEEEAUkGXfUvZTTq+NySf1Vvawk5vBpBXv?=
 =?us-ascii?Q?elMrWKdKZsB8jJim5jSfEAT8l7UkUpIOrplDLxNbw22+TuNh3YIZV1FLBcIh?=
 =?us-ascii?Q?n9geagQaCXUfyjB/megcEIpPj53SjvrFMIzhJA/4JNBTq2P+QxGBFtxLuE87?=
 =?us-ascii?Q?w18ZKkP/LN0stnpCbTcMlhfBzBGQrzQEd0umQT0/UMtQ/F/CU05drOf+NUQm?=
 =?us-ascii?Q?5BdCaLd3OQdjRHB1hNhv+xFyFOYf8ufX5v01++/2N1zbvUVl8voiVO2eXrXv?=
 =?us-ascii?Q?lnoUDoe+Uq+4wpXqdEqi1Kz5Bi7t+LF0ox7K3h5G1dQS+07hJiLAvXJafUQL?=
 =?us-ascii?Q?MQkVRD8wMxnQ/LRg1Ttyz3x7AcuTPdB/M2/BUYouix1Ph+g7uUN5EYKBN3Vw?=
 =?us-ascii?Q?JW4TDLD5ZdbMkQrfSQ8bqIbOuCT/SziL7wtzjdkIBfDxoqoYhllh7hen2Ku/?=
 =?us-ascii?Q?9A1KhKlfhsc+O/KRFhci7wNCZjHRT6cLRGoiqmPcIIcJLMVrnmYedgRIeyzR?=
 =?us-ascii?Q?NU+dyONdHbGNqCyEVycmdKa2KiB9tYeKYwtrWHm08yNeI6kQ5t8G65u8WpdS?=
 =?us-ascii?Q?DFOEfXDNWzFYS8Or5PAd3DtkgcTLMxUpaVJForfb2anQ4kazCubqBfxVhBok?=
 =?us-ascii?Q?DiW058OvY6Mn1fHP6fE6WTPkWozX4rFABvJYkqUXKkgaGnJG/eaaf8a6AZso?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd55a2f9-bb85-49fd-dedc-08dabe29d604
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 06:00:12.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BECU06Lid+dffIqhS/6gKAY/dLYZT4q9zbWZwO7nKXh+HFCJcWpvS6n1ExHJdbcuzG5m32N9L/FOQXZTYttczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6345
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 06:00:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9921

On 03.11.22 13:43, Gylstorff Quirin wrote:
> Hi,
>=20
> On 11/3/22 13:07, Jan Kiszka wrote:
>> On 03.11.22 09:36, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows using the Debian upstream version of efibootguard
>>> in place.
>>>
>>> Also add the new libebgenv to the installation.
>>> This fixes the missing library from issue #47[1].
>>>
>>> [1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/47
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 recipes-bsp/efibootguard/efibootguard_0.12.bb=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 .../efibootguard/files/debian/efibootguard.install=C2=A0=C2=A0 |=
 12 +++++-------
>>> =C2=A0 recipes-bsp/efibootguard/files/debian/rules=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++--------
>>> =C2=A0 scripts/lib/wic/plugins/source/efibootguard-boot.py=C2=A0 | 12 +=
+++++++++--
>>> =C2=A0 scripts/lib/wic/plugins/source/efibootguard-efi.py=C2=A0=C2=A0 |=
 12 ++++++++++--
>>> =C2=A0 5 files changed, 28 insertions(+), 20 deletions(-)
>>> =C2=A0 mode change 100755 =3D> 100644
>>> recipes-bsp/efibootguard/files/debian/efibootguard.install
>>>
>>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.12.bb
>>> b/recipes-bsp/efibootguard/efibootguard_0.12.bb
>>> index 88dc2ed..721b9dc 100644
>>> --- a/recipes-bsp/efibootguard/efibootguard_0.12.bb
>>> +++ b/recipes-bsp/efibootguard/efibootguard_0.12.bb
>>> @@ -26,7 +26,7 @@ PROVIDES =3D "${PN}"
>>> =C2=A0 PROVIDES +=3D "${PN}-dev"
>>> =C2=A0 =C2=A0 DEPENDS =3D "python3-shtab"
>>> -BUILD_DEB_DEPENDS =3D
>>> "dh-exec,autoconf-archive,gnu-efi,libpci-dev,check,pkg-config,python3-s=
htab"
>>> +BUILD_DEB_DEPENDS =3D
>>> "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3=
-shtab,zlib1g-dev"
>>> =C2=A0 BUILD_DEB_DEPENDS_append_amd64 =3D ",libc6-dev-i386"
>>> =C2=A0 BUILD_DEB_DEPENDS_append_i386 =3D ",libc6-dev-i386"
>>> =C2=A0 diff --git
>>> a/recipes-bsp/efibootguard/files/debian/efibootguard.install
>>> b/recipes-bsp/efibootguard/files/debian/efibootguard.install
>>> old mode 100755
>>> new mode 100644
>>> index d3ea007..01cf974
>>> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
>>> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
>>> @@ -1,7 +1,5 @@
>>> -#!/usr/bin/dh-exec
>>> -bg_setenv usr/bin
>>> -bg_printenv usr/bin
>>> -tools/bg_gen_unified_kernel usr/bin
>>> -*.efi usr/share/efibootguard
>>> -completion/bash/bg_printenv.bash =3D>
>>> usr/share/bash-completion/completions/bg_printenv
>>> -completion/bash/bg_setenv.bash =3D>
>>> usr/share/bash-completion/completions/bg_setenv
>>> +usr/bin
>>> +usr/lib/*/efibootguard/kernel-stub*.efi
>>> +usr/lib/*/efibootguard/efibootguard*.efi
>>> +usr/lib/*/libebgenv.so.0*
>>> +usr/share/efibootguard/completion
>>> diff --git a/recipes-bsp/efibootguard/files/debian/rules
>>> b/recipes-bsp/efibootguard/files/debian/rules
>>> index 82e9e0e..9c3b916 100755
>>> --- a/recipes-bsp/efibootguard/files/debian/rules
>>> +++ b/recipes-bsp/efibootguard/files/debian/rules
>>> @@ -1,21 +1,15 @@
>>> =C2=A0 #!/usr/bin/make -f
>>> =C2=A0 export DH_VERBOSE=3D1
>>> -export DEB_BUILD_OPTIONS=3Dhardening=3D-stackprotector
>>> -export DPKG_EXPORT_BUILDFLAGS=3D1
>>> -include /usr/share/dpkg/default.mk
>>> +export DEB_BUILD_MAINT_OPTIONS=3Dhardening=3D+all,-stackprotector
>>> +include /usr/share/dpkg/pkg-info.mk
>>> =C2=A0 =C2=A0 override_dh_auto_test:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # we do not run the tests; that avoids h=
aving to pull the fff
>>> submodule
>>> =C2=A0 -override_dh_auto_install:
>>> -=C2=A0=C2=A0=C2=A0 # install using Debian's .install files rather than
>>> -=C2=A0=C2=A0=C2=A0 # make install in order to have a proper package sp=
lit.
>>> -
>>> =C2=A0 override_dh_installchangelogs:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # we're not interested in changelogs
>>> =C2=A0 =C2=A0 override_dh_installdocs:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # we're not interested in docs
>>> -
>>> =C2=A0 %:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dh $@ --with autoreconf
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> index f9b232b..3d6b2d7 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> @@ -187,10 +187,18 @@ class EfibootguardBootPlugin(SourcePlugin):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "armhf": "arm",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "i386": "ia32"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_to_lib_arch =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "am=
d64": "x86_64-linux-gnu",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ar=
m64": "aarch64-linux-gnu",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ar=
mhf": "arm-linux-gnueabihf",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i3=
86": "i386-linux-gnu"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootfs_path =3D =
rootfs_dir.get('ROOTFS_DIR')
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efistub =3D
>>> "{rootfs_path}/usr/share/efibootguard/kernel-stub{efiarch}.efi"\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_arch =3D get_bitbake=
_var("DISTRO_ARCH")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efistub =3D
>>> "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"=
\
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .format(rootfs_path=3Drootfs_path,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> efiarch=3Ddistro_to_efi_arch[get_bitbake_var("DISTRO_ARCH")])
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libpath=3Ddistro_to_lib_arch[=
distro_arch],
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efiarch=3Ddistro_to_efi_arch[=
distro_arch])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uefi_kernel_name=
 =3D "linux.efi"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uefi_kernel_file=
 =3D "{deploy_dir}/{uefi_kernel_name}"\
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 .format(deploy_dir=3Ddeploy_dir,
>>> uefi_kernel_name=3Duefi_kernel_name)
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> index a754ee1..2d16fe3 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> @@ -59,9 +59,17 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "i386": "ia32"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_to_lib_arch =
=3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "am=
d64": "x86_64-linux-gnu",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ar=
m64": "aarch64-linux-gnu",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ar=
mhf": "arm-linux-gnueabihf",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "i3=
86": "i386-linux-gnu"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 distro_arch =3D =
get_bitbake_var("DISTRO_ARCH")
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>> "/usr/share/efibootguard/efibootguard{}.efi".format(
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dis=
tro_to_efi_arch[distro_arch])
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D
>>> "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lib=
path=3Ddistro_to_lib_arch[distro_arch],
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi=
arch=3Ddistro_to_efi_arch[distro_arch])
>>
>> These arch name changes look suspicious - or does Debian do the same
>> for, say, systemd-boot?
>=20
> You mean the move to `/usr/lib/{libpath}/...` according to this quick
> search [1]. It is a pattern in Debian, see
> https://packages.debian.org/bookworm/efitools.
>=20
> [1]:
> https://packages.debian.org/search?suite=3Dbookworm&arch=3Dany&searchon=
=3Dcontents&keywords=3Defi
>=20

I was rather referring to the binary name - but I misread that it would
start to carry lib-arch names as well.

Thanks, applied.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


