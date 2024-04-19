Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7110BC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 07:30:37 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.65])
 by mx.groups.io with SMTP id smtpd.web11.14694.1713511830800746506
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 00:30:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HHfAvfM2;
 spf=pass (domain: siemens.com, ip: 40.107.6.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etogL61/dB7iZ/MGA7d6EshY8sJhV7I8sB0DSHDkrTU9Gl+I2r2lQrukvRAbvk0r+yI8liENlAc1cPdFVkZAL98HcewGPp2/W9OaZdVw4aA+RzpyglpILHovtDk9fxwgSyjtEM+EgyHSVJ8gtfsJnyc565TJxHnPauPQL2n6LPhZa/pzm5vVpEPdI45be6ZURiByatjeXH9VQGhwZviOwbWAi8c7DMAqyNY4auFkZLy5XcMOB1rPK5gbO5Ak1z4SBLxW0exSYy4LP4iImnOOFokk2bAh1zy3j908jNR2rTTge5DvZKAmrSCZRZZgVq5dVVw9F4r1yHm/5q0NczKAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF7EkO4dzpdUqVlN+LvvuchSFf7e12RYFGag3+Jv/s8=;
 b=Ids8HCVpmS/25MulzGHIamQ9Vlxe++D/Di9/LZVV1bHdihyUGMRFcuSZeiM4+Q+JXllvYIkOKj+NSClelqrMPiUhRN8j5+tiNUX9yQUJJEHrsDzsH3yfmApj0TDpp18aK/mP1GR3FK/OXBKhU4vpFFTi5Arsd/R5e6vB6zsmnA15nwMyTXYP87TVwkkbP2fA5pf4kFuFB+3hp9Mv1zwtWNcUF1GLwZ7LVcb+TIS5fxdycP46Pszy+elGz1rzYuI1gugfIt4+QJCeCpPCNuw60fTVJynGMWDZ5jr4kDOOm0uVCkiEdH/rDzr1hVFRDp5ikJYC01CwLLvvzFp6El7fEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF7EkO4dzpdUqVlN+LvvuchSFf7e12RYFGag3+Jv/s8=;
 b=HHfAvfM2Qx2xGGedeb1HP3/MjhEcORfpUdVCYHF7TBTqrXcLweb6y4uq5YP+UB4eT4S2rwIOJPW0MYMWKnUhtl+/f8dGY00NumCF3uaQKR+D+MI7F+zD0wJYYEhQDgcC5lDoDWM2gSoNh8Im3KDophJyFUtoFhheFa6hlZRyZkZBW0PirIloG7QNxUTX2DINHDrh2SuRWY3HZkoEPMZd7RVI4bKpTfaZFbPsq2rs/RBGLnGz3nRfR61/JxvXHWfmKG0C28vEoaCI4X9iRKaLuwIHwRW3xlgsY7EqLkyZHf7tW12o67VEHmLoXEEMr1uhMP04sipuW0reGlQnoahfqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DBAPR10MB4043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 07:30:28 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Fri, 19 Apr 2024
 07:30:27 +0000
Message-ID: <56321bd1-6188-4d31-b740-c7e488e1a1d2@siemens.com>
Date: Fri, 19 Apr 2024 09:30:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 1/1]
 recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in
 debian/control
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, Rakesh Kumar <kumar.rakesh@siemens.com>,
 "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>
References: <20240418110353.584628-1-kumar.rakesh@siemens.com>
 <efa6a0f8-ac10-46c8-946e-8f41d6f874d8@siemens.com>
 <5b0ae665-7634-4288-9986-18b1df5cb38c@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <5b0ae665-7634-4288-9986-18b1df5cb38c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DBAPR10MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c69cfaf-1219-485a-8f8a-08dc604295e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ojcz8UtICbyuhMHgcPgy0bKSj/v7dLsdH+UFEwgvJJDYqJkwQ3seTFzK8WeT/+HTU6FTJGHmPNdpFNs80Hv/7qfVBSkL+NZTr4+6TgnS1u3Rybk7FXJqhbUOZ030JhCrQg57PNNk8nJY5KAbC87r+EzMqGqskAR7452BqC0KFSHiybNhUFTBUAdAUx8RrAil8EsfCQ+yfrdMEScguHinOtyhUuP6nCpAzY9zk9hPdRIaX+NvQoC0msXsXli5NxB4afnEnrb3Trm8sO9a71xjOH6oxfTaJQw0LO/lmWJ5d9gtsjb2wPhnJWIYfv59BAfJ62rXmllyDh2xT26Ly5Q0cm5oLdIRWLJaZPzh3hkRcA1y3r/PahYpjiFy3E/lPSY0/FYyjY+jf8AEjLvdUtVna4jMe5ql0/mbZ51BAoJB1F4ZoQqYA80j6G+eMMGW1hcCW4LKt6sHOrJb47RxYCz7Ju95xEzNiuY63R6MH0CM6KScP3Vpbuw8L6fUN9gTXvVVi5zLwdcUO3N3FhCRGl2+7qD7KEhaxJSRimew/qkLnmpg0hbK09vXjUi5apM4X0sMT+IxJULjUrg0/4+QDoEqfsPvo3ynG3BnTf3oSgdQPno=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wBgl6X4DvA14X21GaEBtcvZrmYfunmomWOD37OCK/6tPqmB7d9wgBMB9GSG0?=
 =?us-ascii?Q?SKVW2HwjJXkKGhfs44rDI02T33lqm/+BqFvCYDjtRjENkbfIrflVV1j6szRd?=
 =?us-ascii?Q?PTQ4JRTTzQxCtFd/fLD30Fi2TtZlZdlnb40mkOIVHxCpWHuVgxdfwGyx2MWo?=
 =?us-ascii?Q?Jd3fc1y0wK8mS0M52eMfgijCnZhYwc6UGA9IoIPcMzU5TNXCu8ZI3i4OL0yi?=
 =?us-ascii?Q?rPTTQAO/Mqo+OvZdb0Sb/ljBj01ABqIOxck3bsU0fVaHC8bn9X/VtdN2tJd1?=
 =?us-ascii?Q?xr/giQnhgB2IPbbFzlZTy75dUj9k2bXR1/1cNQM7jFa+zbO0qMKN+phDXD4P?=
 =?us-ascii?Q?gEboK7jjKyZEDN3UDG/sa1UmePrnaRgcUDLKPTgFvgOD9fQWAVZbofnxmdak?=
 =?us-ascii?Q?YKoXZCRs2JB93ePP7YelyHtom7v3m4ytJKrvLBlrn1iNGDJjgqjL4KxxCDc1?=
 =?us-ascii?Q?380Kp1Co9z0wxpu/IBd3p5BJ0h6GO42S3IkrqZC19z18uq5JStl1RKRxx/fR?=
 =?us-ascii?Q?82npRFQunIukmBPncc+IKwOhu82TXDefoSqHg1zd2YpPI/pWfDus9o4k3qmr?=
 =?us-ascii?Q?kJnBPZSdhxEhs26G2jtTS458i5kmtbrMjJicmRyT3m7hEIikPO/E4B0uBcvw?=
 =?us-ascii?Q?JUkPLDByjqdEh0Sc1QgNcXGWl4dxCojyBX/3UCMZdk8jp8zhJmy5zhgcxRWp?=
 =?us-ascii?Q?xi1MXdbE/Mps8tJl/k3QCCwihn8ZQvjZ7xqHapbnRl/Zv+dpN0nYHBBXziM2?=
 =?us-ascii?Q?rF+5AVIVnXmuUxmXAdwD8w8Hi3lrxHbBetBemub81GYogU1OmOCASzdA2TVE?=
 =?us-ascii?Q?SLySKrOD89VmYQXN7snKffyb4aDcx1byWcjDknbEq54LBt0XhkDwjKJ3ReCz?=
 =?us-ascii?Q?BCdlskcejTwjbfpQkRynRuJBF3l8YehLXJSvIph7eWeZUVTFj7oiL9fLazn/?=
 =?us-ascii?Q?tXSuVG8QQYgnB3DDgHZ3oq/zULYDlK4hYlwK9E4Pm9hvpWNC58H5fW36zTh1?=
 =?us-ascii?Q?K0LUtijg+mZHfbb2JwZzhL5l442DQvLU/tzw0wG0Aw2Sbk5fjjr/0dEDShtn?=
 =?us-ascii?Q?GzNq/7q0tdSk7hmf5JMMf64YIYAFuH2vfBh1E9VVoj3YpbkXzJShsFHcTIyF?=
 =?us-ascii?Q?d9Y2NBrc2bDbDKoEdVyHRYxsUlUGJSSSdjCW13atPGaCfJ55/J7dve0PJ9D8?=
 =?us-ascii?Q?X72w1T/RKDGUgK1/4Ez9joUbKDNMuznOUAt0FmQA8eWGocgnPKbx4RPjnt2G?=
 =?us-ascii?Q?u25LJiY2OgzLkH1Fy7uJPK1Okg6l+w58ALvabS6vMN7fJk3DTygVk96kbmCA?=
 =?us-ascii?Q?GB9z4P3/XnRWmAmZidHb/M06RqUXWWIQvbhIv7kSR/PR6LMQxI/KagQ+La8j?=
 =?us-ascii?Q?cbB8F8BOr4T8lpEep4ztgGJ3SRnClOI6ZeChstCcxEE02HhcdzrjWtp/0wFl?=
 =?us-ascii?Q?2LuIZcVslckBns73MN2fLCkNwkKPPres4FxO5Ke5JjxVFTGdWShevuqNMX6h?=
 =?us-ascii?Q?I+bB3v8Ui79lNIP/SDTPtm/5kBy5yRfqaLzm61EutcuSjdU+3un9ygTOKWRR?=
 =?us-ascii?Q?xBy/V7w4poABiuUe3bobjSJb9QnLGRCP9qzwGqsEkZh5Qvp+kiMiIdhBfiQH?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c69cfaf-1219-485a-8f8a-08dc604295e0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 07:30:27.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6vxrqMgc/8n+j/Xn1Bj0D5KlzHz9XP95N/RNYwPXn6ErjB5e7bu3dJwOYtuMK27xm4VaWbnFVqSxC5fU38d+DJG4nVNo/T6jLfOpgxzwrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4043
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 07:30:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15585



On 4/19/24 9:22 AM, Quirin Gylstorff via lists.cip-project.org wrote:
>=20
>=20
> On 4/18/24 10:27 PM, Jan Kiszka via lists.cip-project.org wrote:
>> On 18.04.24 13:03, Rakesh Kumar wrote:
>>> Previously, the debian/control file contained a duplicate Provides line=
,
>>> which caused a build failure ad below
>>> | DEBUG: Executing shell function do_dpkg_source
>>> | dpkg-source: error: syntax error in=20
>>> secure-boot-custmpk-0.1/debian/control at line 16:
>>> | duplicate field Provides found
>>>
>>> Use DEBIAN_PROVIDES to resolve the duplicate Provides problem to ensure
>>> that the build process completes successfully.
>>>
>>> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
>>> ---
>>> =C2=A0 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc | 4=
 +---
>>> =C2=A0 1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git=20
>>> a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc=20
>>> b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>>> index 76233b3..559d295 100644
>>> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>>> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
>>> @@ -12,6 +12,7 @@
>>> =C2=A0 inherit dpkg-raw
>>> =C2=A0 PROVIDES +=3D "secure-boot-secrets"
>>> +DEBIAN_PROVIDES =3D "${PROVIDES}"
>>> =C2=A0 SB_KEY ??=3D ""
>>> =C2=A0 SB_CERT ??=3D ""
>>> @@ -29,6 +30,3 @@ do_install() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -m 0700 ${WORKDIR}/${SB_CERT} ${=
TARGET}/secure-boot.pem
>>> =C2=A0 }
>>> -do_prepare_build:append() {
>>> -=C2=A0=C2=A0=C2=A0 echo "Provides: secure-boot-secrets" >> ${S}/debian=
/control
>>> -}
>>
>> Thanks for finding this. Can expand your patch to cover the other two
>> cases we have in-tree as well?
>=20
> This has no impact without updating ISAR first. NACK until then.
We are using 0.10. DEBIAN PROVIDES is introduced with=20
4d0955547453e4303f1f274354a0fb6558a74fa9 after 0.10

> Quirin
>>
>> Jan
>>
>>
>>
>>
>>
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15584): https://lists.cip-project.org/g/cip-dev/messa=
ge/15584
> Mute This Topic: https://lists.cip-project.org/mt/105596040/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

