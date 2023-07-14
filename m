Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07355EB64DA
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 07:28:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.68])
 by mx.groups.io with SMTP id smtpd.web11.13567.1689319677537356510
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jul 2023 00:27:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Ff2tYL9w;
 spf=pass (domain: siemens.com, ip: 40.107.22.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/JC9aMMtcLU9bY16YqdWatDYJ0aiKH9OAv4i6eeV1WNPQvcTXjt6sQXjyih36EBuDBkiBXNOVUZFzLrgBovaJecb1MBAtFMQUacA1xRL9VxhpuAw+6Xr7OVW8YTMbthpZOgZxjY0nwoL+zB9pQdoczDEdck39XV5tPr69g71xEynnFrHo7AYxJ9sHr2J5wJKbPPLNDZcn6uVNmVSJqvEr7vUyq1dJ5QuXH5+3sdMAZpOJi5ih7UOrcsvkEmNg8LG0W3PD/t0GMu9q8IGEkOk43MV7rhRpLUOU4Zg/qvL4oJ30SEu3Bd8CkuCBYhueFzx3J7+o0Ytbj6IMSBmB4N4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6dtePVb8tNegveb7JRSCDYo3vHMY7LWNKcUKc9vbSA=;
 b=VKvncc2XvuNpiQhAtIBcjKYI/J0Y0hHbTvnjZdjgedSfRxbhaOhQ1p4ek7wM5DlJtrcTQrnI3dXj6eENVCZhUgjLTKFQsX1fAxumySAkpnvwVcXreOP/H6+f9hCaiV3V7ZNxCU8JyQGoPQhnAjViujAOJ97FDVAtBY8gJJA4bOSkRaukTtglIeT1kp1eTE1B9ebVB8fF+omSmn7qIIprwlzS7EVPWE8fmoTGHu1VJh4r1vbJHYfZPrwnoYS7beS4eeoeaFSfYQ6ihe7MZbSyKXms8SaBlh9BNF5lSaNojNPvt2Kt+Ur74MpwYOtoF8hBZQg0ibWuKcuerkp/BMaF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6dtePVb8tNegveb7JRSCDYo3vHMY7LWNKcUKc9vbSA=;
 b=Ff2tYL9wirMqaB8Gy6d61Y3eVGhhbg7v8/pJdSLIK+iWHyMCssXAyVH2VOdSwHvks5lyL2kwybZ2KcjEbD8qdGAc7qLgYikNJXjtneKslKb69rRJp49Wm0aezBWm14PcM0XArapWS2HBWGE9wWt/RY97OwRURJEFU4a9Vd1aJZh8NQvP1be9EgqnfIQVRiaM0AJv86f8nmsI/HMr4zjjG1xm4ylh0SRmybK1R56lojF2ppfLfN3fLn6HIAGXZ5c0hTt1oPmYY2nuHTHnLmKud63DswiNcgXCtjePiC+QIh/6RITPeBs+o5vFq5xcfmxJxyLQMo8OSsjVc5akZ3/75w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 07:27:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 07:27:54 +0000
Message-ID: <6d3b987b-77e4-5268-54b4-cfd187b4875c@siemens.com>
Date: Fri, 14 Jul 2023 09:27:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [cip-dev][isar-cip-core][RFC 3/3] swupdate: Enable signed updates
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
 <20230713164055.2786350-4-Quirin.Gylstorff@siemens.com>
 <dd74be31-e7b5-6794-4b5b-8298bc97fa5a@siemens.com>
 <09100b3c-5308-71c6-70e4-383809bcc46a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <09100b3c-5308-71c6-70e4-383809bcc46a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ed4181-60ee-4e17-458d-08db843bd6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o95PlSiY594kFLosqutiJoBjLMg8Rntx4RctYGFoQ44JPF2Ns0leBO1dvJR8DeFwX0W1d/7rSEjaDfz5YixwiasYUHEe3xmWjGhwd6dXLCK+oxgM6Y3dbMfXxzosfGi5sCsi0CXM1yUIbeydDDfOGsqEQ8nhNjvec0IxwIbfsU/E0LP11Y6jUEwmY8MzLeH/qOf4r83QR1NCxbCjdboP7PcF7uuJN+q3SHsRBz6KL4JpEL87n6OMR1wSjNGQ27iby1l1Ujp+id5ftRCP5gxp7FYFJfWX8b+4UbZdDcySSR95lD3/U/AcKyja23cdn5gqqgpWKGIBuwpPrSfTua4mfWfk1zjVWgnhj1UyO+dbczVFmyAUEmAM9rMnFfL+D6tfMexwR5M9MJK3FFGKWa3nyHOHY3fByxLNUdI2iHV4XIH1aAOTNWvB/KSj15wNqWj9SV3oj/NDXuMXG0DsgsNE82XhPL2mVivFvob6Ci78AYpNlGa81lITEvQ7uEOOp5kip4uq7HH2uIHwcIafz8pTjvawkjjPXfF6+JSOanCYnazkw+ZCpncgO6aQ0veY8ehUJg/PKX7LXPU/CgTxob1Gfr8F8ry1RdhweCDFgRjvbBpBwcyEHHO2S0iDkF4ZCFX6LcqHAkq7S5xWCmfjeHt+cQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(83380400001)(2616005)(478600001)(82960400001)(31686004)(186003)(6506007)(53546011)(26005)(44832011)(6512007)(66946007)(41300700001)(66556008)(86362001)(8936002)(316002)(66476007)(2906002)(6486002)(36756003)(38100700002)(15650500001)(31696002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q3/B3d7Hkn8NOkMsJlqxOxuYkYYw6A/RDnv7V/B2jY3+nmZkPba3xy7WE9FI?=
 =?us-ascii?Q?TN/FuVdELBNJUuxvwtH5L3xh6UchnDXpBDCUnq/d/Ef9p3Nq4jF8Z8Nzeq9q?=
 =?us-ascii?Q?/UuppMnOZogj0x3LHTRgKea2n6S24HWK49AxC6GNvkBPez3INh7kJ+5dbTZO?=
 =?us-ascii?Q?/hn+yVaszI0xc2/i52+qS1BIsnChvO0vxeZrXuijasQL5Ae2oRghi4UdWQvY?=
 =?us-ascii?Q?uwSj2TXq19pML1n3bc5EQamMQ5uzGiYQrHZjEPpqG/Ep7ZsN0CNQ/F4E/r8z?=
 =?us-ascii?Q?GIYmFT7p/64L7zegFJ5NmUn9TnsCmPmxhOEfA+VXi+FymZ+MxHGK9FW3Bbm5?=
 =?us-ascii?Q?88YiRWYCRgXt4kAvszRRjQysk5sbsbkG0i/Mxtpd3o+PaS0JxycsNxFJZQvo?=
 =?us-ascii?Q?szY+IP1rM3dSSbvMDo5D2eftebhuyTVkfBCNb6mao1gLOBHZkyGqZuGyb5R3?=
 =?us-ascii?Q?nPhDeKueNDzc4HP4A8OCStaxD6C4UpsCrwVUbkgjsrsn8atWm/QbGNDyw3RZ?=
 =?us-ascii?Q?GtFuABWIDfS4P0DIFBMWKMPNLxC+hHMFOlzJEXnhzdKmMffpySBTP8vDzmwN?=
 =?us-ascii?Q?wRqyaBSIsf4q1IC8MtB+yQw2KB4CH0lNrg5A4R5p06MymPU+fdfMDdPoqmZu?=
 =?us-ascii?Q?/wcl3rww0sDPq4Fn84wqM8hwr7ijOOvC56kslarMNTWXVKrEeCSqnzJJ/nXC?=
 =?us-ascii?Q?CSRs5AlRem/oH+oYx5FGBylkVLkX22idoj0UWd+bKsAE9CISAkiDYG7m8XCd?=
 =?us-ascii?Q?oo1VBiFF9WJT3YI5UU05zpZopkDbexX9eyqJYO+LI9MRjmgTkDNiWHr9SQGW?=
 =?us-ascii?Q?OKvYTPA12mBs0bsHfepo9pcxRQO9/YShS5tBB2I05QtGTxpEUPdTizaMbWQD?=
 =?us-ascii?Q?qN7iwv7J3uUqtlSsxBCrleEQ4cNd4/GmD3N+kdhhanGsuaCxAJWUo80ZEdjh?=
 =?us-ascii?Q?k8k0XWdPORszWvuUbt4i/Wi5Tru7u7CsapzCXGeFcLwCEOX+C+WS/9wI5vaM?=
 =?us-ascii?Q?n6V+8VGRRJCCoYus2Vxjg1udACpQFfvaONec2oMA0szuSwpuQURKD7FMduct?=
 =?us-ascii?Q?CDPYpaNR/iJhpDMcN1nGRNosFjfA9AZBDlZ0/6KEvBHyQYXy5HTlC10KhRsO?=
 =?us-ascii?Q?88heuVWMM4O+ifoPoZSfhpBqxDSvXWUejH6GbKi5W7fGm+d5aLPtTi96GhVf?=
 =?us-ascii?Q?jcG6JgnxVD4hyJ5tEGW/hbriFrD+8XmRpIS40Lm9YRFuiQU5kwIMEaIz5T+K?=
 =?us-ascii?Q?lzDMcGA+3YdqFBksUVQ7yHpBKyXnjwaBWy7mKa2XAJoZlhMxw0klZJRRL0kP?=
 =?us-ascii?Q?87u3sCuVNSr20iPttvJQDU9Kice+EvDOa0+0pwa+GD8t72SI40E4Y3gGPE8C?=
 =?us-ascii?Q?We5WmcgztcFSHDHlG345qDAMGvqMdT+4aP+v/YEGXPi1BmAK6+1AV1ZlXS+A?=
 =?us-ascii?Q?c1Y0GiHpA0BE6hSekm0mkgJSRzUh8n/GpdyasWWJVP+cN3mMZbElrhWnsMjk?=
 =?us-ascii?Q?hzrZvqHayldmMpcrvOMaL0zrNS0zD6EzHOmRpah4NPWu/TLMGjG6tuxkg7l5?=
 =?us-ascii?Q?8ClS4YNmXQJVe/d4fGFjFov7d86rc8E/WxuN2djKZIRD2oGWvETSs/TI7ssv?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ed4181-60ee-4e17-458d-08db843bd6b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 07:27:54.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8XLdkQFdqD2vetUkGMYXtaVMIXWPJQK78XZd1wnoKfdRvItBAU24x3UmY3rQerFt/JU2V7nG2QLtfLHBX7CJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 07:28:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12345

On 14.07.23 09:18, Gylstorff Quirin wrote:
>=20
>=20
> On 7/13/23 19:06, Jan Kiszka wrote:
>> On 13.07.23 18:40, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> With this change SWUpdate requires signed binaries to update
>>> the system. An update without the correct signature will lead to the
>>> following error message:
>>> ```
>>> Error: SWUpdate is built for signed images, provide a public key file.
>>> ```
>>>
>>> If unsigned binaries are wanted readd the Build option
>>> ```
>>> DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>>> ```
>>> to a swupdate_%.bbappend recipe
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 conf/distro/cip-core-common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 kas/opt/swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>>> =C2=A0 recipes-core/customizations/files/swupdate.cfg | 1 +
>>> =C2=A0 recipes-core/images/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
>>> =C2=A0 recipes-core/swupdate/swupdate_2023.05.bb=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 +--
>>> =C2=A0 5 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/conf/distro/cip-core-common.inc
>>> b/conf/distro/cip-core-common.inc
>>> index 5d3ce10..a3d959f 100644
>>> --- a/conf/distro/cip-core-common.inc
>>> +++ b/conf/distro/cip-core-common.inc
>>> @@ -14,3 +14,4 @@ KERNEL_NAME ?=3D "cip"
>>> =C2=A0 WKS_FILE ?=3D "${MACHINE}.wks"
>>> =C2=A0 =C2=A0 CIP_IMAGE_OPTIONS ?=3D ""
>>> +
>>
>> Stray whitespace change.
>=20
> Will fix.
>>
>>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>>> index b0293ce..0e30e89 100644
>>> --- a/kas/opt/swupdate.yml
>>> +++ b/kas/opt/swupdate.yml
>>> @@ -28,3 +28,5 @@ local_conf_header:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_INSTALL:append =3D " initramfs=
-squashfs-hook"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ABROOTFS_PART_UUID_A ?=3D "fedcba98-7654=
-3210-cafe-5e0710000001"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ABROOTFS_PART_UUID_B ?=3D "fedcba98-7654=
-3210-cafe-5e0710000002"
>>> +=C2=A0=C2=A0=C2=A0 PREFERRED_PROVIDER_swupdate-certificates-key ??=3D
>>> "swupdate-certificates-key-snakeoil"
>>> +=C2=A0=C2=A0=C2=A0 PREFERRED_PROVIDER_swupdate-certificates ??=3D
>>> "swupdate-certificates-snakeoil"
>>> diff --git a/recipes-core/customizations/files/swupdate.cfg
>>> b/recipes-core/customizations/files/swupdate.cfg
>>> index 9ee47c7..3e2b45c 100644
>>> --- a/recipes-core/customizations/files/swupdate.cfg
>>> +++ b/recipes-core/customizations/files/swupdate.cfg
>>> @@ -1,4 +1,5 @@
>>> =C2=A0 globals :
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bootloader =3D "ebg";
>>> +=C2=A0=C2=A0=C2=A0 public-key-file =3D "/usr/share/swupdate-signing/sw=
update-sign.crt"
>>> =C2=A0 };
>>> diff --git a/recipes-core/images/swupdate.inc
>>> b/recipes-core/images/swupdate.inc
>>> index 6a01abb..6b7da60 100644
>>> --- a/recipes-core/images/swupdate.inc
>>> +++ b/recipes-core/images/swupdate.inc
>>> @@ -12,6 +12,10 @@
>>> =C2=A0 inherit image_uuid
>>> =C2=A0 inherit read-only-rootfs
>>> =C2=A0 +SWU_SIGNED =3D "1"
>>
>> Shouldn't this be a weak assignment?
>=20
> As signing is a compiled into SWUpdate and cannot deactivated I have
> decided against a weak assignment.
>=20
> If we want to switch it on off again. We to add an overwrite for the
> signed SWUpdate binaries.

Then why do we still have SWU_SIGNED at all if it is always "1"?

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


