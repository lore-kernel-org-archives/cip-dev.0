Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3814BC61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 08:48:01 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8004.1787734080382367552
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 01:48:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=v+HHKCWu;
 spf=pass (domain: siemens.com, ip: 52.101.72.27, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJxa8h1fXArtDKso63bE+f09Nh0RDpcXth/CzrGWLXVp7UG9jGdad4kDY1gs4CitQBn5IoNAvQwC0q+Q9Q6OaE7u1oP0RAeQu0v+InVzi7BT/dSaE+7pdeUCMnFe6h7qrPENE2k6HmWQpuiPP9hC5/KY1H/qIF9LpaupJJ0U5miVwNUzdKmFKECT0mXMNPtrNWkbFeYmb6dZfQkk7CJL0D1/bRGE+qJZaOYA5ddA57Rai3SqwJ10QZfuIxW+UZlwcfybqH+BUXrhAklhBmvB8Uu8noDGxPSz4vA2urSYSe9p58md/h0IMkS5G2LNFEX5c4ip0dl6XOWsVXsQ/1JhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAlODFOkqEpiqYX04OnDVrUA6bCygHDVevzYAhtxGX4=;
 b=dC2I1x1+RvKxYWJYnB/m9VqwEhiCIldobwxhw0mYlwvJxNhRZCYvwNcacSzplLyC1yt2SPlGQCMzkXvUHODsPxpTG3O+XC5CXA+WzhUsyOiPLP8wrI8+vQQvBV5jPGwNeBy2KxTqkDwzF9u50RJ45ivqeP3IuwvLDQaLl1NSw9Pe3GxkACeVH4VXsdQWLH/kIqWWVg4RnOLIXzRiTLRDO4JgcK84/aj//qwbj4esfnAxGjt4RUJPURc4lWss3xbt5NdXzK8LSZzjUNmDZsjH7e8WcCYf0wD0ogBoU+Jfwf4niO4VD9oVmlHKnwE9KjeordSB1ckeEfaIfLVB4Pns2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAlODFOkqEpiqYX04OnDVrUA6bCygHDVevzYAhtxGX4=;
 b=v+HHKCWugtrL/byQj6muEXwirWLNRzcaIjpx6dkcmte2huJ79dQTqYs3NYwN2K0kn3PAPBT+prnL7nmBW+bfnYlByFdkfWKqdOFcoJeTzD1HJt2V3/7IwIxx2U8yenqarzm0WeDdz6D3B/ZjQUOZM+PRf6LG22QaLLwDnpyWXDNHK/5jPL0OeCBsasgr2CDVVZRrT3ouXVbVg4vBaTobCBWD43YJSiKf0WVwsu+T5UfcxFBQDWexmX7oGlMoVDtaYzX2aHVcWlscmIwGF/mmPIqkeI3F03x69hSnoLfrYfsitT+bV1Dp6N7iQ1USl5cyWyY4R3Sb80d0uALdjIR2Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by DB8PR10MB3642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 08:47:56 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:47:56 +0000
Message-ID: <67394296-6c60-4b72-9e2b-d906e1334b3c@siemens.com>
Date: Wed, 26 Aug 2026 10:47:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/7] secure-boot-efi-keys: Add recipe to
 create EFI keys
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <97dc63827a8f33a225a39b3884afd6e6933c048b.1787722904.git.jan.kiszka@siemens.com>
 <51c1c773-6416-498e-81e6-48294b6cf80a@siemens.com>
 <9d3170b3-4d7a-4bae-aa1f-a1cefe25f08a@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <9d3170b3-4d7a-4bae-aa1f-a1cefe25f08a@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIYP296CA0012.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::13) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|DB8PR10MB3642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8a075f-f3b4-4ee9-530a-08df034eb986
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|4143699003|11063799006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	LvWOhYbhiYgR2B/dOuWddGMYYcheBObi6S3l7mQqv8ehBxeNn1ApmCXPonlPNRMAW21lno6yzcWUxS221T2aZqX8VpsMUXFzxZsCaaeCpnpXuRKKfxHfR+uvOobIZblXa9u1o6U9rp5hDB7ZGDtJIzM8fKIKgrmtCtvX809AAHWIFk/4Z2fi5Vblsyyh7b0wYqwSbABmIO6y0IT4Qzg0IL74pM/QczHNe3y9Kru/jBHHX3QGM5vIt8GM7lixae2Z51NiwUWOUuwU9gtxZA26dWbWbLAL3lJ0BHf4NVL1q6KnR/6CxBJVMVaNprMRSXcQDK7+I5V39Cfn6Zea92BOlhSnVBh26QvgNg+vZlOjPudl1vaBf9irMhSJFuX9hY54na6gd+81QKu116MDaKoZeTwpG0XagXwt2QWlIK/aWeJC77fsqJ+wRRJx5l01WoYirJbpmoWk5faT10Hix61rZFDXY3tBUDbCIKEHPHLahf+gDvaZ4+n56VaYVAAKmPNmB5+zOlXhquho2CNYdeYFn5osxj/BmpMsJLx0KiE2xF2reKdyqL62yyodwUIW7cg5kVuNVpXxbsckTRwHdylslEPSRILTc6ohqB2qMh1Pn5ZHkv1sPmMZhaXTejIR0WvGtHEI9680n4KRorbTITeEiLiiE9GAd16Uj6Nay45X91I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zd/4gCcb4GpERzK4o6WMQ/9/KtBnd65zy3twvsSeTsA7V/Bl9h/a8YammT2X?=
 =?us-ascii?Q?HhiyWPNOkve4ACpDmfvLPOaGPjptV3QAkfamL0uXgwKck94gIxuG16iYIy9y?=
 =?us-ascii?Q?OBy4a/kHNzcbtXa0BpiSn95SBA4G+bEB0TQcmO/SBpfMokHHGCL3KkQ4IFIw?=
 =?us-ascii?Q?pR59He9knPNMrKSlm2dFfnOYAgFmrYt5NHNKa0K3zU5HKbKZLfZacpXzZ5Va?=
 =?us-ascii?Q?MDcRJoQoRSlj1028pHu13bM9tjqa9Y/MrLU4KARs5DCpIHMTLteg0V+qt+D+?=
 =?us-ascii?Q?O518y0FbatBGitDtdmrBgQHbD/p7OcrCB8c4WdopowGLz/SBzU6ZhKx3+IKO?=
 =?us-ascii?Q?GUUQJPODTh+9pStNHv6N/iysagTOhMm6ZxClMBtSS4PGPo3+bIGm+OrNgezD?=
 =?us-ascii?Q?15nyiNIESimok27NtrA4sigq8Mgq4fxl55qy27k/1yfi6cUI/LQAJ0ENzwVc?=
 =?us-ascii?Q?31LsZb3Dq1AE1nAKntxTyleF5Klobh4QSQuqQjpq04WBYp2X50yhcXQ91D2d?=
 =?us-ascii?Q?CS4GX5VfditU5Uiwc6aNmKqy7U4syWm/bfdBR4azhRMou2z1yw83+A4kZBMq?=
 =?us-ascii?Q?tK/1mOjHA7WXBRCyHN5Ty+VLhdZdM0Z1MSDKdHGW32jaNEpRrwaZVVcItuPA?=
 =?us-ascii?Q?DwvbcBBu2Vzd39tyROiys7ZGWtmb0TjzoMw9a2xvxSGLzVA+EDv6017LjHdW?=
 =?us-ascii?Q?iZrbc7o+FSdfwy//50RTZEbYiguR7hJDrTcrWq3W1XuN5MH2HQnAGot536W+?=
 =?us-ascii?Q?3NyKKbGIZXVWEc8FcOr7RqQRR8EUfEhPkKfcid0gBwGI7qik2U+iC/savF2g?=
 =?us-ascii?Q?1haREwtlbWucKU9+cqohw4JaYxOE4vzf2lLfmkyLbctnRsBDrAeTHmjqRZrf?=
 =?us-ascii?Q?PHS54m/HlEL7iZJ/aeaHYXP6nDGZdRjNpH+oM9bxdl1ZJDNQ8FljQe61tp1W?=
 =?us-ascii?Q?LgCOdOjLfN21cSjxM4AeEUO2ytP6D94WoLcHPIxC09S55vZBKsRohj4mwCc4?=
 =?us-ascii?Q?Sqa+LNCIBbmK8wEOcl4G2Sk+57KJLZRPLKxpzPwYTb0BXtOPZ7AEZqBqdey/?=
 =?us-ascii?Q?0xsh10E3jVHfVSeYgpV2ub8jFABoZ1Fcm9hDAuOqP9+ReRo1jZ6UzYlCAnxW?=
 =?us-ascii?Q?h3Ni2abOO7BHtWttle4yOeYq9CFaITEUX8sLHu/JTFp6kVTanuBBp74jKY5S?=
 =?us-ascii?Q?1V0zA3mpez09DpJiEiIBdRvUP0Z1Vo6Vd5LaIsnO4P1Hk9PK5bTdRlSnhV90?=
 =?us-ascii?Q?9XHCxm0EJVS34k9+uqDtQQ9ACqiq12YvBmcomKSoNIARrdeuvIROZI0Hg2I/?=
 =?us-ascii?Q?KuR9fmk0g39LCeiLiZXdWgrI7RAYSfQXovDsJhNmZniCBha7QwlW6I37EgAF?=
 =?us-ascii?Q?ln8djHUbUZUKz6VtcNVaEZq1rwglqwyJbITXr8x82UzkzGlVp6ksBTP7Ql/l?=
 =?us-ascii?Q?/f+LRrwzefWfYALnwCDclN8o+OnoVXDUW6JwMVR5M7PHukGOKbljrNOGfqH1?=
 =?us-ascii?Q?aEuHZ5VfTQotQUKSMsCKEcb+T3fr4MkqIsvXrxiDnY2el/arzWJZWG6DQEKK?=
 =?us-ascii?Q?/M0eq00hnP2Fxi6/UtugjZbYBKEiSRlSNJQwc9cXYvC6ibc4a3sDrC0wdeZ6?=
 =?us-ascii?Q?lADa5sDZahA4VEd5HJaqm7zaEMw1AxjxsP6f1/iijlcoeff60XjF+dLOUWGZ?=
 =?us-ascii?Q?r8Sp6wFi+mCDlXvwf9E+Sdg6P12YJ4WGLJXTTjLOKQBjoUCVJ/1TrL3i3DDs?=
 =?us-ascii?Q?OKi+EI/4/d51nPVpvJYR6EjgSybIvzA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8a075f-f3b4-4ee9-530a-08df034eb986
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:47:56.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJIRjcH0jsgI3d7X4CHJwvLNpJtHjtVDJoxzbznBfIwRayHY4SByl2OZNUSPtFGDpDcw4Ay7E54TbNRe3XIgNIlGxy6FULqpskZEf9PDGPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3642
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 08:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24020



Am 26.08.2026 um 10:44 schrieb Jan Kiszka:
> On 26.08.26 10:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>
>>
>> Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This recipe allows to derive the PK, KEK and db values from a single
>>> signing key as we are using for demonstration/testing purposes and
>>> simple scenarios. The recipe provides abstract "secure-boot-efi-keys"
>>> which could also be offered by an alternative recipe/package that picks
>>> up differently generated keys and/or a proper key hierarchy.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  =C2=A0 .../single-key-to-efi-keys_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++++++++++++++++++
>>>  =C2=A0 1 file changed, 41 insertions(+)
>>>  =C2=A0 create mode 100644 recipes-devtools/secure-boot-efi-keys/single=
-key-
>>> to-efi-keys_0.1.bb
>>>
>>> diff --git a/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-
>>> keys_0.1.bb b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-
>>> keys_0.1.bb
>>> new file mode 100644
>>> index 00000000..cfa48b7f
>>> --- /dev/null
>>> +++ b/recipes-devtools/secure-boot-efi-keys/single-key-to-efi-keys_0.1.=
bb
>>> @@ -0,0 +1,41 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2026
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Jan Kiszka <jan.kiszka@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +inherit dpkg
>>> +
>>> +MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
>>> +DESCRIPTION =3D "Generate EFI keys from single secure boot key"
>>> +
>>> +PROVIDES +=3D "secure-boot-efi-keys"
>> The naming confuses actual keys (private portions) with authenticated
>> efi signature list) actually holding the secure-boot-certificates - so
>> maybe secure-boot-vars-auth, secure-boot-certificates-auth or even
>> secure-boot-certificates is more intuitive?
>>
>=20
> Agree. How about secure-boot-efi-certs?

Nice.

>=20
> Jan
>=20


