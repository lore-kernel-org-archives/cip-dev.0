Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD9E9A03B
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 15:55:25 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16786.1771516520169858355
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Feb 2026 07:55:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Zb//okTz;
 spf=pass (domain: siemens.com, ip: 52.101.70.66, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i78hZPcpcFt82mt5rKMSaILH/pKBZggteYC9/JCmnIiUGdDnKqbgzd+IIqaLsfb5kHhZ41pkFIRKyxCJY2bMSmGydztVFeb990qKrIQ8r2TMFSu4gFji4hbh5UAqnYPdTYVPqa5bOh401VOQfMGwjshS1FBxGJ3l2YVMe+oE7SL1vBeZmb3tu8Esj3cjmQN5fHkDLjkZxuOOKE8HdjRw2drOFlbI4tcL0x2k8nbEYW9jf7uwr3EsHg21pVXjb2ynMMugKjkeZ8fVGYHbV2zgJsBSzOat/+/+gfSLhy/1dWpw0SUY4la8hZPMBFH1iEIAn/OhG6YgWb2Hij11A7XD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0z7ry+YJL5PjeP0rcKB79m1x7lytTxADrkN35KLF/s=;
 b=gY5gMUC69cTfCYZlYmqfowQc8WQPU61makL6XJXa99sp+V1XZ5UpkCG8Sxf32VOu3btCFqQQS0QYtBmqoQknQ/5+1hgcCM1KRc8m7KEDkb++Q582c1s9p1q5ejnrtSWkCNf/x4dp8RkgqWL+Wr6hsvFjWvGKdQ/xIt9rCJLMk14lmQcuDXSjXuti5HUkxvCu8QPomFhq//hrppJPu/JUNQc4NEPrXnD6Me6O2H4I36lHmnU7FE9LEDPj5WDizLYnYj4ykNUeaDHJE4SXIRGZOR3iztekI/bXBaoHgMveUsOlqiowGLuy6N1/zeJ+4YtbU3znQNpV8m0KJy5bQCqZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0z7ry+YJL5PjeP0rcKB79m1x7lytTxADrkN35KLF/s=;
 b=Zb//okTzOZbufF5gro8qJciCkpUrQuR54qT9eHa5hNynGTLo3tj8Xy1oZtz9jZmlC8LrJrfLKhvTFyAZ2UMRC2GJvgNJI3k7pDIbFUkPHRMop/Enl6qDBfgeqPgooHjUlLoGR7wQj4SIeRMF7v/8sCBBQ/Xs6mjUYYodRHLytnSGzFCU6GYN/F3tpS/Y2BbxUJCUCK1xPjSGWmZCXdiXI6HBn9aytdzlKc9glXqFZy4A69Sa9zH4zS75kBCQ2HcwIdOhZGkQtABB6iHZNaTkdQdVqnCh03GzqB6v8bUaXmugAV8vh3U3uvl7HeGjNChduodToMDrx3WC8F+ZKGF2uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e2::19)
 by PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 15:55:16 +0000
Received: from AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad36:4857:1094:f10]) by AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad36:4857:1094:f10%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 15:55:15 +0000
Message-ID: <be505282-f512-4fd8-8058-2a00606720cc@siemens.com>
Date: Thu, 19 Feb 2026 16:55:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 1/1] swupdate: Enforce signing and
 verification for swupdate by default.
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
References: <20260212214003.734787-1-alexander.heinisch@siemens.com>
 <20260212214003.734787-2-alexander.heinisch@siemens.com>
 <779171e4-d002-44b1-a7e0-879af3bed946@siemens.com>
 <ef6831b618ace68c2a97cb8147aee606cd91faaf.camel@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <ef6831b618ace68c2a97cb8147aee606cd91faaf.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2306:EE_|PAVPR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: ef37b653-a4cd-4488-fe35-08de6fcf4607
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?65Rmnp3XS7W2eiKxsHsIoB6dubLGyvUiIxW/j6pA+QGSwl0pCmd8uPqjLT9n?=
 =?us-ascii?Q?R+04ogEOPXs9+oTLvW3aKO2ZLhKC5vi/Hdu6Lk0DwGWwwNy7KHUpaTAJFlwv?=
 =?us-ascii?Q?FyBapEimieHdQq/xPJYg5fZ8YU3+3AJfTqsY/ewONotxhdrzrCVCh9BbmvTo?=
 =?us-ascii?Q?/+8EfmfCaa7QCU17ltYcGM7kH2I2yZ5EmGtZ0M6hY9pdgmcz87SLmipCdQHa?=
 =?us-ascii?Q?SnartFdQ4pSlN1s8lZHgIUxLE26glNbouZFeOejVBLmLpL0bAXMOdsrh9U/G?=
 =?us-ascii?Q?TW3QrYGZpnIcvc2nGA+UfLy3YwXjCgeFcU7xS1CEl73hI2tDw1T4mdmwPD7F?=
 =?us-ascii?Q?5gNA+NfFiL/rrDsBXwMWUMdRaCocku2TR12aR5iP7/m5FV+IxTfFeAu13VFt?=
 =?us-ascii?Q?WetgQyu1kX9rmj4fEFMqR51VHrLAhGVarvDPZ3L5lNHSzOyuzUAM8J1O/7LX?=
 =?us-ascii?Q?808FdW48KqmmUOSe+LwbeySj+puYfDAXUhIJRBeJbZgsw+eMyT4k2zQjUU9o?=
 =?us-ascii?Q?ScP1SLQOY0h2FugvM4FYprtbPInPvzsUbLv8TYfYgNvrwbNWkiTQ0Ipvpyxh?=
 =?us-ascii?Q?I1vxB/q4Zvq8mC26rbadPluRp/Vu8IosiofUoVtninjrZiOWWLk4LQZ+OXDF?=
 =?us-ascii?Q?hc+60E9WEi5TUdSSB3YMCrBz6h8sbsLnEFYjYK1RndGxKJBRNzlG+/hffqv8?=
 =?us-ascii?Q?myTnmmKjHXwyzODt+qMbMKGgvJQcKCWritu2GjRySRly+pBlKYfBvm5XZ4Kw?=
 =?us-ascii?Q?WFQzg9iFrZnr+wz3t6BdtcoLOmHAloquQhWgzGJ3ifgW4OKq6x1mQWP4ddUY?=
 =?us-ascii?Q?P3lbPwrSl/vhxuHtfliuD+ve0FBuTtz9zLDPqwGch54fvDhq6I4/tomTphAU?=
 =?us-ascii?Q?wXAGDXXGaBJEeyhDvO0ky+hx1KKGgRX/37HWxj/x/FrxrE0gQ1ZYyN7AQbZd?=
 =?us-ascii?Q?Pq14udYU++mkYtB4ARqc2hVgUPciSMp3L84Wqv054EOs34+U6eZSN1UKO0Cq?=
 =?us-ascii?Q?aB4t5guoyrn8fUv/M+nz1seaC6/GZsKcfqHLUw2+6GGhiZRLxudAo2ssR5wG?=
 =?us-ascii?Q?vNo4GIrKc4atj2vh4p/9kc+zO7jU4d+HmYvjD11R5l6BQXFBdIgkz4axT+so?=
 =?us-ascii?Q?oAd4sXffEh4vqHuDNisbPqo1NDmng6C3iqijZiWmXKL1RZv93dyuaoJas/Gr?=
 =?us-ascii?Q?/ST4Xj0VcrbG2zYUK2QtvOpS3gjI1WHvkqzDBcNXTXNiK07Y3rbYYOiV5ALs?=
 =?us-ascii?Q?AbZuY0l6xDM+Z1mZhI2x9fGZKMNIM59e5HLMJdGiJWPFHxEs34adByQvTvve?=
 =?us-ascii?Q?Dz5vr6u7IeBq1VFT7MGfxnPDeyypeIRhRHEzvvts2SBkuY3jFVwmTwN40fYN?=
 =?us-ascii?Q?U1L9JC7+V+OgkchTco5DSgq7vMHZ+lNKuCE5LEAakemK3IUOpWT/xgiWrQpP?=
 =?us-ascii?Q?hGs6KPQ7jrQx26fLwIadGopLAd5D5wFfelrBHfAmWOi1zBwYKItrUJYREPIO?=
 =?us-ascii?Q?9EJyuIHNrJF+WjI7d2cKVTxAf8Bm/oJmbJTrT3g1pimBkaEuF7ysNHMPMoUn?=
 =?us-ascii?Q?Ppt9hMCEBFdubrE9nDI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eQMdLc9PUsr0AbB2AtyCzricEeZbNerBaUu/r2MrlXtSkCtVZedN7LNSiQZL?=
 =?us-ascii?Q?Xkvs3KfYu2iA8IGpyOVWpkHVaoGmfscd+TsC122nWahOzC4Wj23lnlSkiP5h?=
 =?us-ascii?Q?wsVK72Y+rR48Y7Pxj1BWokce15yfGgmGDitfARoez1dznOci2H7idW+0UY6F?=
 =?us-ascii?Q?xJb2Po1Fs4/mXaBb5vKprc1VRLGz7F6UhkljJScYMmm1QXvPmjVpwFQnSAB5?=
 =?us-ascii?Q?ShmNnloiSheJTIu7HyaB4zQ2ykbTW+oS8GhoKVAzmMfThQ/JwD8gHyply9ee?=
 =?us-ascii?Q?Ebq9ZYZkqhEi/cwpN6yVOyE7fF2CgCuvWDV9NvdnWw53yLQA86rtAB4joNtP?=
 =?us-ascii?Q?Vsd0aWYGCZ1OZ8sr82pnx7qXowIV6X77jLGcS9IJmLlnZOjAK0QfVVRtyoGY?=
 =?us-ascii?Q?4f2Fmd6TatKzvnBrdVI8Qm1mEf+P5bmkiJofsKQ05gNH7YcJpypXvz0JuxFb?=
 =?us-ascii?Q?F1i+cf+OLF6522VsgnUTGyMv3cK77lAcLDxod7fd370V0YPdYGPRuT1QHbx7?=
 =?us-ascii?Q?T2YrSCf2vqxEL9wZx8l9BVi4bqy5GQp9O844J+dATfpKBPy/3ganFEKgYBpW?=
 =?us-ascii?Q?7SpRYe6tEebegEpPmeiiwvT/XTjAreCAnVO+25Kud6O9y3UagOxRR6s4z5mg?=
 =?us-ascii?Q?00nVUe/EG98yu52Z6tWOOozQJoLd5l6JiUhYzfRERBtJksL6/6St2PCGTwDE?=
 =?us-ascii?Q?xq5TZ5u88FwEc0KdxVWsJaOeK0IcIAF5YwIqwenj+7sE4X582LR/+q6P3ESQ?=
 =?us-ascii?Q?cBKWiBT5HrRudy3X5CGXCLA0r7K0Oo2HRV281F138ICva8jhOCdSuszRzkWi?=
 =?us-ascii?Q?RS8dcaUF1KeyTscXdud7sgX6sktbP9Qn8puanrfI6wnNQRUWbFy33lQc1fgh?=
 =?us-ascii?Q?0yO6/OdYdz6hQvVRfUji4Ev7cjMm2tD0NSNlodfuHDfd1ali83iBYxL24Akd?=
 =?us-ascii?Q?LYM3Dwr58GMTtL6P1ABfE03Y1B8afN/mYjsxRkLfY6jn94ZYYEYoHY5YsmPy?=
 =?us-ascii?Q?i4WqanIle1qDARASDBEUW5Ke5lqNmfTtlidNyjd6KOuNvIma3G5xs84l9i2y?=
 =?us-ascii?Q?lOkt20+xlF30Wgf0VyaOq9gKyjEQTxNEyu2odSWeCB5JK14ZTnW16XDNm3ne?=
 =?us-ascii?Q?I2V28dOYErBndkfYefzRQvRSFqSBfFABZOPDk5ENCVKOJJnclfo9LxwKLRmw?=
 =?us-ascii?Q?WaDwAdRymBEBy5E1gzIygGwVKL6GMIFrPSrIh1TYWlFmp/vLRptZ25kuvNuZ?=
 =?us-ascii?Q?Jdy3nxcdSXFiD96YROM7I5LEmwRMvokZbWi2zay/sg5gwXakElgUvYKSOoS2?=
 =?us-ascii?Q?4W6eZQRgCr08piyylIkdwfuFRagMFWF8VriSPWYwftxNzdhQSROV/KXYAJ52?=
 =?us-ascii?Q?EREhSY8euCOXWIcMPa1p55oxaMYdfHUJVn8gzZs7Zgq+Rq3ppdtLcPrzgbX/?=
 =?us-ascii?Q?oFFBq8Z4kTMKa4Fg5xnhrz3XelmDMJf0NW6EuJbMtVN4kFeaMlHKjc1XOUzv?=
 =?us-ascii?Q?QkQyDS6+Uabr8JB1xGut0cH3PvC09UPOQCl2VbFvTODFjniIuO/5cVLtRZ82?=
 =?us-ascii?Q?pET1gzvz1QFiLGJRROVL0ZBbfP+nwsNurZVcJvlkmwDld6q3OIJJM6bevmh7?=
 =?us-ascii?Q?xcFRQnw0ExyfYGpjzVEaCB1fLkQCc3bP3tZ1o1gb8f8z4xHuGrHZLxeiz4YN?=
 =?us-ascii?Q?a0yvIofQrp08SI1ZLlP2VLSVLCAneECK/+lE1j9j3wYqW3oUBuYh6eNVrX0e?=
 =?us-ascii?Q?Wqr51K+dqTfrVw+coNU/dzQfk+P37pg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef37b653-a4cd-4488-fe35-08de6fcf4607
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 15:55:15.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoqJUXas1v3s67nJzEmbk9mXj1x1OzwehsSb5tZckZwCJjcMiEfROzMDkvjKbsQMD0TMM4SqBq/byGUpkpIqRdKg6/YTcuMPNl9lAz//Gs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 15:55:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21901



On 2/13/26 1:55 PM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Fri, 2026-02-13 at 08:00 +0100, Jan Kiszka wrote:
>> On 12.02.26 22:40, alexander.heinisch@siemens.com=C2=A0wrote:
>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>
>>> Aligned defaults for SWU_SIGNED to enforce signing of swu files
>>> as well as verification in swupdate binary.
>>>
>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>> ---
>>>  =C2=A0classes-recipe/swupdate.bbclass=C2=A0=C2=A0=C2=A0 | 4 ++--
>>>  =C2=A0recipes-core/swupdate/swupdate.inc | 1 +
>>>  =C2=A02 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/classes-recipe/swupdate.bbclass b/classes-
>>> recipe/swupdate.bbclass
>>> index 59dab9f..d92d55f 100644
>>> --- a/classes-recipe/swupdate.bbclass
>>> +++ b/classes-recipe/swupdate.bbclass
>>> @@ -39,6 +39,8 @@ SWU_KERNEL_ARTIFACT_NAME =3D "${@
>>> '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
>>>  =C2=A0SWU_IMAGE_FILE ?=3D "${IMAGE_FULLNAME}"
>>>  =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>>>  =C2=A0SWU_ADDITIONAL_FILES ?=3D "${SWU_KERNEL_ARTIFACT_NAME}
>>> ${SWU_ROOTFS_ARTIFACT_NAME}"
>>> +
>>> +# Including swupdate.inc in CIP_IMAGE_OPTIONS enables signing by
>>> default.
>>>  =C2=A0SWU_SIGNED ??=3D ""
>>>  =C2=A0SWU_SIGNATURE_EXT ?=3D "sig"
>>>  =C2=A0SWU_SIGNATURE_TYPE ?=3D "cms"
>>> @@ -52,8 +54,6 @@ IMAGE_TYPEDEP:swu =3D "${@
>>> '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
>>>  =20
>>>  =C2=A0IMAGER_INSTALL:swu +=3D "cpio coreutils"
>>> -IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>> -
>>
>> Ok, this removal deserves a separate commit and an explanation why we
>> got here (@Quirin) and why this is safe or even required to drop now.
>> Introducing commit was 980cd0089ed0b0318977522882c4f9d520f6688e.
>=20
> The line removed here got introduced in
> 9c2ce98c43473e7d9d12508bed924faf1d688bc0 in file swupdate.bbclass and
> was copied to images/swupdate.inc in
> 980cd0089ed0b0318977522882c4f9d520f6688e
>=20
> classes-recipe/swupdate.bbclass provides the imaging capabilities to
> create swu files (that can be enabled via IMAGE_FSTYPES) and thus is
> inherited via IMAGE_CLASSES to all images no matter if swupdate (swu
> generation) is used or not.
>=20
> The image specific parts to enable and install swupdate for a
> particular image (recipe) is handled in recipes-
> core/images/swupdate.inc. Thus, modifications on the image should be
> handled there.
>=20
> Totally agree, that this should be in a separate commit!
> I will split in V4 once the discussion resolved.

With a split it looks good to me.

Quirin

>=20
> BR Alexander
>=20
>>
>> Jan
>=20


