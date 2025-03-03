Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F2C282CD
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 14:03:26 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.16])
 by mx.groups.io with SMTP id smtpd.web11.53528.1741010597938763605
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 06:03:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=SCGmwpYc;
 spf=pass (domain: siemens.com, ip: 40.107.162.16, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/B7oVErz89d4DFH4xzQoCBL5VIhNQ1S8Cu8w74XV4LkcV2SpHPAwEaWbT5yEliibXpVzSLayznl4f1yTmr/o1R/AJyzIqfC+Ytk8AmOwmKbY4rLFcoHpPdOle4vzcStnlUOH28JoYtu9REGg7DCnCsxcyViHPrZyCQ8Q8u7XkrV9Y7SklNX4iFfLT7SD78tfy5jEDHT3/B6OlJDjzx8JC/IvdnIrrVHyjJ20vP5WC6ux82H+11U6QAy/nGf1uIgVgjBF0CqPhu6hl7rZi1g41WpEH8e9HzPlrkun8vreUbjeHVi1leLh0lutMJElRPUCdGSD/9xkJ/sjcLH37DCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L10b9tXAtOH23R1ZeOiPB/vGrOrLgXXeFCHTCTEo7yI=;
 b=RHwpHufldEKCh2U14rON5n/eQGgeupMI2lVXAxtFtcZz/2gIjMkYtuDn0lj3Gdn46LJqTLarPXwTwG90e0WvePp648wqrNl4sDRvJ/zJNmrdI3vSUbAY3ymE+2HRrp92+vaXEyG6+xBjuVadJDEwN5ldYVvDjwR+24WIf5BmkZDaNMUJew4kh2uhwPx9cY+47vLcYorw+sqVOeSwb26j9dn51SdA2tOc2M4I2SQk716Kxj8zaQOFM13r+tOn1DcSp93yS0AdPpZYnHLG8JR7a4CUnGwjY4qnxzO1UAgrqy32kArwiCyJlSr3ylUM3cudK2svW1f30drjcFQRRlC2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L10b9tXAtOH23R1ZeOiPB/vGrOrLgXXeFCHTCTEo7yI=;
 b=SCGmwpYcUV1AeqWLXw5ePIWjIlZDvQJnrLDht2JH/+wl2bZT0UihxibF0by9BtnJbFnipKH63QketnbZm61/AaVnG2h3VuF3AORSv2RiXJquzKXYwEvSiPonVep4rchVvrobG1Cts88ojsg6awBSCgsVyW9ABcdwwuMIK3Tlro/V8cGaUMmyyXcnd/i2Q/fj++HSmmf6i4PLInVoppn/A5RhJoydtdGXYQxnco2ZyPFzI6KvBkf3bsWLOiJmM3gKi+j5DUC2q1HCSyfiH2kQ7xom+1gPgB83H/cYWWE3n7U963VznXQQBvdHYv3UmYn3bhaTj9mLjSBlTmb57lqIdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB5PR10MB7842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 14:03:14 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 14:03:14 +0000
Message-ID: <424c471a-f93b-4db9-8720-56c4376d1281@siemens.com>
Date: Mon, 3 Mar 2025 15:03:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/4] Move content of home to
 IMMUTABLE_DATA_DIR
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Nussel, Ludwig (SI E R&D IOT)" <ludwig.nussel@siemens.com>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
References: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
 <20250303112342.851020-5-Quirin.Gylstorff@siemens.com>
 <39c6715d47f0d1ad0ee2121ed94adef40e487162.camel@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <39c6715d47f0d1ad0ee2121ed94adef40e487162.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB5PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bdd964-a0a6-4b39-99ea-08dd5a5c23e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mf3PYCZPmNU9GHxJiJTlxHJewv6ZJbkgC3oV5/SjJJahK8hAPJun9CnVDRnA?=
 =?us-ascii?Q?2plizogiPW7f0O1rNNeYp7gI8e2BISiJep+1X2QarZKb7jYJHPh9sZSFdPCU?=
 =?us-ascii?Q?rrdwywd4wbAi+J53GtiQMgGvq1po9CHCSAvGkGngh7fyVDTYxN1jTrDhyrtx?=
 =?us-ascii?Q?nOkQrstjQZtgQwA7sjbTpRX7xThRCZNikh0XIIl9h+Q46naLvQAyyNi7aIi6?=
 =?us-ascii?Q?y6dmdVcMd2GyR5K0UJh4Ao0XHAgCxrX4IjoYT5kv8JhCprRuuPz+CXdFTQQ0?=
 =?us-ascii?Q?nJA031rrMjFEYA7SEGbKaN1idbaxXXqSH06MYJDCwoa6tXxnCIpGJ85Ef8Ki?=
 =?us-ascii?Q?U16uB0fhLpMdYGH954zUU95Ll8Vgn6Jnui4d/ne2t9+R5EYNRv98ey007pEg?=
 =?us-ascii?Q?JCYqJT0OoQAN69T1ULc7zpDFmHfIpBfEdPFcJWepJtypCGv6067x44i6xZNw?=
 =?us-ascii?Q?PFVvb9U+iRSlxhBm6YqxAMD5R/VmaWi8zF5BHBALPWBouELt4bvoY5enUPwD?=
 =?us-ascii?Q?+yNlZPLHvr2hcFXpPBRRdw74s1nTtkV5t0wgwnM6qY81U4WoL+dovGC9MHvE?=
 =?us-ascii?Q?pe89V1tW0rcorMjkzZs1idR6g9b8Z0QDCwnfrK+RwB0xnc6iwHIjgRWWRTEn?=
 =?us-ascii?Q?13GVzPV8e3lu2YmRVIz5X8A9bMoFvXjMu/Urloumre1mrx6bFISRnS+ie5Gu?=
 =?us-ascii?Q?QjskoS5GkjUK6vysio4o1Kt8h0fG1mDbRRCSDjbUwfDd31RKSrlCAMJf3qwV?=
 =?us-ascii?Q?H6F+xiqagrQLNMtEfBvvB3AM4xp/i4AzlpRAl3RA6eD35FpnE0eHIS/iXZJ1?=
 =?us-ascii?Q?VSQdI2Vls9m68in0JqVqhK/0ShWcwLwTquSAUrmNQ8GPaNG/cs7d6yxEZq+C?=
 =?us-ascii?Q?J+2Smcfu2njFjbfsixjZsce+1n/xbOIr5qPXZDX+Dkzf+KReDLbeslEZxsAb?=
 =?us-ascii?Q?iFtXpJiuczigt6Dtkr0m3jl4aP3KhpN4/29ns1kXwGIBK04E+bl6SHor5Yzi?=
 =?us-ascii?Q?/l/FYDAZw18wBYoJa/gJf5SqlWyTWa1BLlnGJ5xy8F1CNH/JV0KLmoY9SqOE?=
 =?us-ascii?Q?QCCmiNkysUMyAH79trMRxuZ0EXKThTp8rxzhk489fLY91oeci58gsTOUaPjs?=
 =?us-ascii?Q?xTi3Vsihp7fLu7voBZd1kWyreTHVEsSCWFtjbTRJBHLVFPx8dDjGgikCYtXo?=
 =?us-ascii?Q?W/Dh1UgK+x/IrZPo2SutB+1HXc6mjery2dN5vYgCuj2mC713pRxIogp5Qi8O?=
 =?us-ascii?Q?Kt3/2VdDEZ/qlcSPlTv2+QvK/24gWXNlgfy8r/j404m+DOUy4NY+bf98CROz?=
 =?us-ascii?Q?7hgkpR1HvCOrKxX+mJMcpVznWMHwCgUYY26fKlwHyHaAdtGgpTX9FGFbgAHx?=
 =?us-ascii?Q?NlfKG59TrIDyT3AuGNcROitTGTm1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+FX8KZjXYwPbJmE+UmszDSosklaHtUSW39HL4Nbgs6FbAI1DN/XrrzvScSis?=
 =?us-ascii?Q?gzGrIaTL/SVWTSf2j4Gsyefp2gJ9LW5kJ4tiMC2iMrqk/GhTj7Yn3AAtx9qb?=
 =?us-ascii?Q?tDMgrbizSf7kyM6cb4Lknpb9d0i2NvzJHw2LK8sZKbA3OoyNB3wilDfVj7i4?=
 =?us-ascii?Q?JUauQfZc3LyntYJTP9y0U12sZNB/qRT6Zw+kr5iVM5wphSRIm3Ky+NFirb4M?=
 =?us-ascii?Q?FDFLRumTVIKWs1MaLLW7CUWP2xLhdrBaLQu17O15v+BaNrIEo5Qy7UQP2MM9?=
 =?us-ascii?Q?WjKrtThkksCRvBZU36OongWVvfowQVf5hpyWFumQxnrE+bN3r+ddjNOkMX02?=
 =?us-ascii?Q?wpXEprnkl8ieCJ0ImCc78wHBCQ67Ria9/negS30UdeYRb6oldbVtQO0l0/Y1?=
 =?us-ascii?Q?Ku+Mn9U/fE5CfItgIBX0kVoIdtuyJ5K/5iNzrNj7Ueyz9f/Oa+IuQIlpCxF0?=
 =?us-ascii?Q?71GZDOMn1muDADWz+vNk25x4KX8X9mYX0lMYOO5Qw5ackqSd87MjvEMT2/Jd?=
 =?us-ascii?Q?PpvGGZbA2/FrL9gHma8FCW/DIlVMjo43vYdFmRqGYbuUKxHpyM8Nho5QLxTs?=
 =?us-ascii?Q?apkvngV6T3r8Acwicum5QH/FlKWJfwykV8kdaRn6tBEMtWA8eyuZh+C+0m4x?=
 =?us-ascii?Q?C4oWSLFQ1O5rhVRKdndAoFCIs/J5a9767bfo7gZVvLweQayhk6tPMxi6faqC?=
 =?us-ascii?Q?G/BlUmlG2EG0Vhm48F3W17vdokEtkIB9vLD2BT2PL8SyAmWs2j9qKOEURJWX?=
 =?us-ascii?Q?56LCxUHdkW8iEzf5QbpVV7TNMRIuR7mPP6WpLf6KVNkq6S8xmr4bGP6giVPV?=
 =?us-ascii?Q?ERrNTqq8sVZYNkebP3r1Hw4vXL7lnM0H+ZGrbofvtuuJ4evxyN+WTfMyFb5m?=
 =?us-ascii?Q?nl7PUFI6I6gYZDvfp4zjA/8wXbLnbwBnVfNC9x0MDncTALAPyUPha73PK5lR?=
 =?us-ascii?Q?Xl6a9EHq+jMcfoUMst+ErsdP0NNJ4hdedGlEgyrfJRQAZfi5xZsl4/16TBhT?=
 =?us-ascii?Q?KyJycIFFwYz8Gi0EZ3HuwFGz5M4LIn0BFzfcp7fQ15O5h7IoxglHHzV5V3OK?=
 =?us-ascii?Q?qK+EW+5ClaS9G/zUFJr5tEd949Ckr0zESXAy5GbvGfepBpLcntIPcljCTbxT?=
 =?us-ascii?Q?QrAl1q6uYFGSvKaYfEULYtqkreJKcySQ7mKXphqWmpBMzrbV9bXgRd4km1mp?=
 =?us-ascii?Q?wffPyBdm8x++3x1TGFwvyRrDF8cJqO/J16IB8VBctFA6nfnjPCRPNfakFR9z?=
 =?us-ascii?Q?LLctlmwHo5eSH1FMahqUFjUIsVwHImFbV7wo+2G8Vfw7fLYoTYickrDwcQ90?=
 =?us-ascii?Q?rcjX4Z4FKmw06jrsnIrL0Ph04wnGtKlbxE/FgND7NlezlriCDyNVEQSshBFD?=
 =?us-ascii?Q?ncP1eiwsj99ubOo1quRCXYK/KPHQqGjfxS1F5cjQojiViaOCMhRg7Q+Oxoh+?=
 =?us-ascii?Q?HmqOMVpA4+cJpkdhcLEW7eHoyMNo4aIkE22CmUjqCJ8YPPn7kKH6fD9LSPbH?=
 =?us-ascii?Q?cEknKKo8UY0d77sR1Y/ZKyQCeXUFuVmCY5OvYfMTKWwxrJ2bHVN1pf4YkAbA?=
 =?us-ascii?Q?/MGfiDhKok28giLmRxyK+1k5K31O4DR5H3CxMi5Q3MJX8bPbGTnWbq+3dkj+?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bdd964-a0a6-4b39-99ea-08dd5a5c23e1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:03:14.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMsUwJEPcxhcUFAgmoSh2oH/oXxik2J+HLB/nJcWlvWM01jJkExOEJYChweTTVXmLprnQsaInoEUxCG/kfSLyfVdJHAAgDQd0XvZ6l9R9G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 14:03:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18003



On 3/3/25 15:00, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Mon, 2025-03-03 at 12:21 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This reduces the amount of necessary partitions. It also
>> allows to use a A/B-update scheme for the var partition.
>=20
> Hi, how would that work? The /var partition is by-definition not
> updated by any firmware update (a/b rootfs update). It must be deployed
> empty and in case of device resets can be cleared.
>=20
> Felix

An example would be Jan btrfs a/b rootfs with snapshots.

Quirin
>=20
>>
>> This fixes issue #123.
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0classes/read-only-rootfs.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++++--
>>  =C2=A0kas/opt/encrypt-all.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>  =C2=A0kas/opt/separate-home-partition.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21
>> +++++++++++++++++++
>>  =C2=A0...ook_0.6.bb =3D> initramfs-crypt-hook_0.7.bb} |=C2=A0 2 +-
>>  =C2=A04 files changed, 40 insertions(+), 4 deletions(-)
>>  =C2=A0create mode 100644 kas/opt/separate-home-partition.yml
>>  =C2=A0rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-
>> hook_0.6.bb =3D> initramfs-crypt-hook_0.7.bb} (98%)
>>
>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-
>> rootfs.bbclass
>> index 0c8ae24..4e70d81 100644
>> --- a/classes/read-only-rootfs.bbclass
>> +++ b/classes/read-only-rootfs.bbclass
>> @@ -14,8 +14,12 @@ INITRD_IMAGE =3D "${INITRAMFS_RECIPE}-${DISTRO}-
>> ${MACHINE}.initrd.img"
>>  =20
>>  =C2=A0do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
>>  =20
>> -IMAGE_INSTALL +=3D "home-fs"
>> -WIC_HOME_PARTITION =3D "part /home --source rootfs --change-
>> directory=3Dhome --fstype=3Dext4 --label home --align 1024=C2=A0 --size =
1G --
>> fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-
>> 46dc-9c0f-58904f369524"
>> +WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs
>> --change-directory=3Dhome --fstype=3Dext4 --label home --align 1024=C2=
=A0 --
>> size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid
>> c07d5e8f-3448-46dc-9c0f-58904f369524"
>> +
>> +WIC_HOME_PARTITION =3D ""
>> +IMAGE_INSTALL +=3D " move-homedir-var"
>> +IMAGE_INSTALL:append:separate-home-part =3D " home-fs"
>> +IMAGE_INSTALL:remove:separate-home-part =3D " move-homedir-var"
>>  =20
>>  =C2=A0IMAGE_INSTALL:append:buster=C2=A0=C2=A0 =3D " tmp-fs"
>>  =C2=A0IMAGE_INSTALL:append:bullseye =3D " tmp-fs"
>> @@ -37,6 +41,17 @@ copy_dpkg_state() {
>>  =C2=A0=C2=A0=C2=A0=C2=A0 sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTAB=
LE_VAR_LIB/"
>>  =C2=A0}
>>  =20
>> +ROOTFS_POSTPROCESS_COMMAND:append =3D " copy_home_to_immutable_data"
>> +ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part =3D "
>> copy_home_to_immutable_data"
>> +copy_home_to_immutable_data() {
>> +=C2=A0=C2=A0=C2=A0 IMMUTABLE_HOME_DIR=3D"${ROOTFSDIR}${IMMUTABLE_DATA_D=
IR}/"
>> +=C2=A0=C2=A0=C2=A0 sudo mkdir -p "$IMMUTABLE_HOME_DIR"
>> +=C2=A0=C2=A0=C2=A0 sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
>> +=C2=A0=C2=A0=C2=A0 # as the rootfs is read-only we need to create the l=
ink
>> +=C2=A0=C2=A0=C2=A0 # between /var/home and /home during creation.
>> +=C2=A0=C2=A0=C2=A0 sudo chroot ${IMAGE_ROOTFS} ln -s /var/home /home
>> +}
>> +
>>  =C2=A0RO_ROOTFS_EXCLUDE_DIRS ??=3D ""
>>  =C2=A0EROFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
>>  =C2=A0SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
>> diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
>> index b6d4041..faf7206 100644
>> --- a/kas/opt/encrypt-all.yml
>> +++ b/kas/opt/encrypt-all.yml
>> @@ -20,4 +20,4 @@ local_conf_header:
>>  =C2=A0=C2=A0=C2=A0=C2=A0 # As we use a weak default assignment in the i=
ntramfs-crypt-hook
>> recipe we need
>>  =C2=A0=C2=A0=C2=A0=C2=A0 # to set all partitions
>>  =C2=A0=C2=A0=C2=A0=C2=A0 CRYPT_PARTITIONS =3D "${ABROOTFS_PART_UUID_A}:=
:reencrypt
>> ${ABROOTFS_PART_UUID_B}::reencrypt \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 home:/home:reencrypt var:/var:reencrypt"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 var:/var:reencrypt"
>> diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-
>> home-partition.yml
>> new file mode 100644
>> index 0000000..aaf349b
>> --- /dev/null
>> +++ b/kas/opt/separate-home-partition.yml
>> @@ -0,0 +1,21 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
>> +# from the first wic partition
>> +
>> +header:
>> +=C2=A0 version: 14
>> +
>> +local_conf_header:
>> +=C2=A0 separate-home-partition: |
>> +=C2=A0=C2=A0=C2=A0 OVERRIDES .=3D ":separate-home-part"
>> +=C2=A0 add-home-partition-to-crypt: |
>> +=C2=A0=C2=A0=C2=A0 CRYPT_PARTITIONS:append:separate-home-part =3D "
>> home:/home:reencrypt"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.7.bb
>> similarity index 98%
>> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.6.bb
>> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.7.bb
>> index df335c9..80a4755 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.6.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.7.bb
>> @@ -70,7 +70,7 @@ SRC_URI +=3D "file://encrypt_partition.env.tmpl=C2=A0\
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 file://pwquality.conf"
>>  =20
>>  =C2=A0# CRYPT_PARTITIONS elements are <partition-
>> label>:<mountpoint>:<reencrypt or format>[:expand]
>> -CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:reencrypt"
>> +CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
>>  =C2=A0# CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to crea=
te
>> the filesystem
>>  =C2=A0# in a newly formatted LUKS Partition
>>  =C2=A0CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>=20


