Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383C2EB64D9
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 13:47:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.65])
 by mx.groups.io with SMTP id smtpd.web11.7966.1687182461634517933
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 06:47:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=0BwjDjFp;
 spf=pass (domain: siemens.com, ip: 40.107.20.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYZdN/ra/Po3EemdGHkiouiwnVJ34vNss0FbHiMaHyQP5YFy2l4+mNKSs2ssycuizPn1DhTGXZZV20cAGEMQtZDnWr4hbJG9uyomIOJmai0KT9XisuKSuyPORPDBGeMnBH8K83t49sq0hJ77fqLxvWmLWuw2++ZvoxmLTyDFTZqis5wFXEYj8nIP/Xaj/OYHLwlOvxHuR12dVBXZu0lpQLNHy/LpN/1vWMeGaAVL8keuh0TKUTuelrAAk+hFS0vmxJzMrq1ZW5MSsJw7uvyCo3vzDjHHYLS6U4T+6x4Po0zOSSngtlKRF7Hv7WIyfxqYgNaHREN+1lINEkW/wb6tSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pha1VNWvaSJyUItnAXWyKLxoQqoZcRvyb4VMFTXdcpw=;
 b=Zo5fwnjBKLbQPtzFrcuaoKqUiNi5aKyn6gh9DQL6YPUZ4In/kieeJZ7W8BrsNuj2PsvnvWUYKGSPIfWX31xNd9jdmqED+wZJ7+YTNatQXHrFsRLp1ykqN0aPpituxTqIYVVAImjR/y1NrzTpGvRAq7qchSrhDncwZigvNDkhjgXdtdJeGFy2LAFJsU07Lz23T0qlo7ZqWDwuYmzFDVgH8fLhkTif//0DmZfN96XTEtB2RKiQ0SovH6vo64xqts60XipXuRwNhwrsQCeA3JZTNHfgGnosc/deAOFPrSjhlI7mvMijtFIXO+uKHMxNmRxXUwMomKAKua5EtaUInz+qvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pha1VNWvaSJyUItnAXWyKLxoQqoZcRvyb4VMFTXdcpw=;
 b=0BwjDjFpQrBgB+e0wzoNSH4Hr/xgkVjC/YuC6nlQJxQ+Fw7aHomGOIAVRqym2uonfWeiN+19h+6PwuVlwNmhCy3ch4tyfZMzxKTD9F0oAmz1xwnE0i8Xzxya7hYO2ThqbfTiTceO+zAHi/NVB0zXYXxhWVlaBqaI/6vyCXmvPwV3JFz24rBQ1LYt5tVhGWLayHqKC4xEzP/ERZFZhcT9byfuVMb6VdLntbUKgr3C0fB5Z3gbG4pNecyynEq7ZPoEJBVDLD/iPys/iHWRjq1vAC73gH7T4FEA5pIl7za6rJGeNTG2ifvudKyeRd/YVfOdAyQrP6kyd9fhaRKC+RL5Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7677.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:494::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 13:47:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 13:47:38 +0000
Message-ID: <6149e31d-2d24-a577-829c-78fe28f88067@siemens.com>
Date: Mon, 19 Jun 2023 15:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] efibootguard: Update to 0.14
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
CC: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <795ab3b7-8aaf-3649-bc48-87bf780e11e4@siemens.com>
 <041140b7-0ac6-f735-22fb-2c8be047c8dd@siemens.com>
 <d77518cd-d96c-13c5-f857-989326b283ba@siemens.com>
In-Reply-To: <d77518cd-d96c-13c5-f857-989326b283ba@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bea09a-e4f6-486a-ce6b-08db70cbbeec
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xgrq73fn/1F0E8uWY+XWyZ6uYhYjZkp0ao562vtYWZNT+gxudIFctFa1TAUYqXXJMFxhD8Wma6O1NtiwLj0ftcXoDqRDqgxZIBwdXF/20HOLoOY0IRFW4gmpUYTK0Rr19WPLDfRhqJvqH3HWetPK6MrL2G9pXZeKAhoKT+YhYSbVXe6NcPJYFHbkNJqUcOE0osiAiiMpgZlRnfQucqkXtWSij1YDsnFP+NRXuDqOfKm3NmLboa0BMM7eaAQYo5WOLZuGvArmGRAavnqVuCRA0/YFJcR7DN6EzmtSaxzTfqrNCuTXYx7ARBrer7ENvJK3/AMiazrVX8wWfL5AZWMb/ikUJjpN8eZ4QYREUhIyuGfAjeGGBZ8vWhD5ZY5mIY5ff+cIyhkjDkHXNReAEu1sVaA15XDA/32dfCgBHadGhYeT9W2LWPui8hY+mPRibDUzUNbI+MAMNvPLhZCwOL4Vh/UvFr4oMk/XtTsK4Xph99b0PgahA8ELUDde7dn1R6Ow86sds/zeISiHBGeYBhr5QDEpKyxmYAbdsKQEZAR8dMmic/JSa+vki5LYyJAQvpoTNqTtwiTdrcRa6E51dJKpWRUWJrv6/LSBpP6cAxwcgbkXTySalvBlVw2B6QMdxOZcuvoaRK5Jc/swRUzwZ1N2oxviaD93V9WR3wZWh6SJgGI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(31696002)(478600001)(2906002)(966005)(6486002)(2616005)(15650500001)(110136005)(86362001)(107886003)(36756003)(26005)(186003)(6506007)(6512007)(53546011)(8936002)(8676002)(66476007)(66556008)(66946007)(5660300002)(38100700002)(44832011)(316002)(4326008)(83380400001)(31686004)(82960400001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x1h68cXdvKi+yEhSAiCkevMUxGuJymS3zn6s3vRcy6xy3TZRQkfVLyn/QRiX?=
 =?us-ascii?Q?HUoZ6weVUsUkrg8x8MsS6qc/v6EZh4El81an3CYj4HJ5VVyQUdq8V5KmP/np?=
 =?us-ascii?Q?A0HZnJwk4RjQQr1mfZLSjC8rWM2GNGBkiZ7pHGtc3PjbqGEWgI3puykvmQzL?=
 =?us-ascii?Q?rNUkkj8XAlw6s1OCK3CMzAAmE6ysvjx096JRLxafxqW166fTBC6/TQR02u2r?=
 =?us-ascii?Q?kKUBxk8xmqED064/FSzUxPVW0xHAHl8J6nkU5t85k7JmA/dYlXwRfwAgTMAF?=
 =?us-ascii?Q?MCvomxPX4dFPsaWp4g4FMoTiq9RIqcmRQjuILohXsUCPVy4xbQtyTcB3QWuY?=
 =?us-ascii?Q?vWn2J3QqnE5SaLb9C+lNfuyLP6LylKo9d6HWf3V5NOPN73/HZHB7Q8M1BLvS?=
 =?us-ascii?Q?gWnhz6YSe5ocsO/NKwewqPckJHCpn4yHmDjJS4hSrAqtDzMGGcnnoGcsOfRS?=
 =?us-ascii?Q?uXXIUb5iRSQOamVYYSyWeAju1MF2baa9q1U7le8YXevdRPhIQ2uZ18j2ztfQ?=
 =?us-ascii?Q?CdQaZ8KQ6pzp3p169Nnb1eAcEB7V/7kzCygfazJsK6KsP7xACnQtMUcqE0Kj?=
 =?us-ascii?Q?OWHqHDHXxhloznoyoWMe3B9541diNDMS8fYO3pdh1LUEzBJG1YIaW4Qpxmu8?=
 =?us-ascii?Q?apgNiy/v6hL/t3H9v/O0dDcEn1GS6TlO0EMT+ur2iqv22Z/EMFtLcVrUGbs9?=
 =?us-ascii?Q?9PFOlPx2+7fni9qt6ccsF63SR7JytdH4IjURYsz69sTevQ98HjqwAjJezmtN?=
 =?us-ascii?Q?AyazWR09EMZ2GcvDn3NZkjPFhZN1jtC2AXhRZnE/QUQwB9uyzBsN6X4BVXgg?=
 =?us-ascii?Q?dwSxc0DjM7zatSOWNGGfzWcG1/GhEm9Smwjb+Ot4N5tWiVxoO51tFWwl5K9g?=
 =?us-ascii?Q?eEpQiQZSsYeqV2QJQ8U97lKIh34gqVu0oOv+EWceKRsJIdQMzFjN3dqBi62y?=
 =?us-ascii?Q?5+wJ2TytzbPt3WcvLSa7BF0ZkuFxYpQggD6fcPauRm+aYiiPyE40qL2hEFhr?=
 =?us-ascii?Q?T9+f1rljR9L8gXNLX5rmlZuFl+fWqLIT2VxhKcsF7sMgNMiBfSZGqO7BINHS?=
 =?us-ascii?Q?2EsYQUk5DshM36XQtBZhLc7ycJKhJ1ABGk3M7LCy+HA5HGob+8w4PnOPwmnM?=
 =?us-ascii?Q?A7R/KzUlh3dUNwQJ2C+rG3AXaZESLzFXoKbLdupfKb3jxqJDUPdVN5bU6OYJ?=
 =?us-ascii?Q?XnaEskblNj7GMNg6Bl40qcXgKQNCadxot/MC/74HrAfLbITBPeAOh9dPq7ij?=
 =?us-ascii?Q?wiL7YDMWjxg29KoVKFGEmwyMH9x26uXU99KtcP+rHYKlCv8/mn2LgY7Li6gk?=
 =?us-ascii?Q?SPZDvKSKbAAPDEK7Ax61t6MJtTia98ARlFh9+qOHNyJD5RnOjY8pAiYWZnAW?=
 =?us-ascii?Q?jfTJA1stNL4t0xR0QPmyOA6tzc4v3SYqExeIcgnTvd/ShlHPau+7WveR3hhP?=
 =?us-ascii?Q?aX/+HBZmPFUrkwTqKgxtolY57xsKGT6iN72z8L+IQUfp1IPW9paxZyiHSDqS?=
 =?us-ascii?Q?2F2TRqxABc2J+kS/csMkpReR2xsNRfrV9za0Syim9YeSjFWF4sStQ6dYZ0Kd?=
 =?us-ascii?Q?Ho3QngBr4XEKtJSm1t5Z8VnlliftOA5zDGzC2dfFCgUOTzf0a7ndaYxAe+TF?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bea09a-e4f6-486a-ce6b-08db70cbbeec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:47:38.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dWqUYz8Vqtwa9ROSwqhUpjn6nCcYQGlk2Yff/IqnnPgSadCFwwlNyVOSSsGIewalpUDOBBGdQN3NXmfDHLtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7677
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 13:47:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12078

On 19.06.23 15:42, Jan Kiszka wrote:
> On 19.06.23 15:29, Gylstorff Quirin wrote:
>>
>>
>> On 6/17/23 15:09, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Allows to drop the RISC-V patch.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>> =C2=A0 ...0.13+cip.bb =3D> efibootguard_0.14-1+cip.bb} | 13 +------
>>> =C2=A0 ...01-add-machine-type-name-for-riscv64.patch | 39 -------------=
------
>>> =C2=A0 2 files changed, 2 insertions(+), 50 deletions(-)
>>> =C2=A0 rename recipes-bsp/efibootguard/{efibootguard_0.13+cip.bb =3D>
>>> efibootguard_0.14-1+cip.bb} (78%)
>>> =C2=A0 delete mode 100644
>>> recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-f=
or-riscv64.patch
>>>
>>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>>> b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
>>> similarity index 78%
>>> rename from recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>>> rename to recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
>>> index 9fc15a47..f58a3200 100644
>>> --- a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>>> +++ b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
>>> @@ -17,18 +17,13 @@ LIC_FILES_CHKSUM =3D
>>> "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=3D751419260
>>> =C2=A0 MAINTAINER =3D "Jan Kiszka <jan.kiszka@siemens.com>"
>>> =C2=A0 =C2=A0 SRC_URI =3D " \
>>> -=C2=A0=C2=A0=C2=A0
>>> https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;=
downloadfilename=3Defibootguard_0.13.orig.tar.gz;unpack=3D0;name=3Dtarball =
\
>>> +=C2=A0=C2=A0=C2=A0
>>> https://github.com/siemens/efibootguard/archive/refs/tags/v0.14.tar.gz;=
downloadfilename=3Defibootguard_0.14.orig.tar.gz;unpack=3D0;name=3Dtarball =
\
>> I would not use downloadfile to create the orig tarbal. Reason is that
>> the usage of downloadfilename currently breaks mirrors, see bug report
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15126.
>>
>=20
> You mean rename the file in do_prepare_build?
>=20
> But that's not really a regression of this update ;).
>=20

And it would leave some "v0.14.tar.gz" file in the download folder,
waiting for collisions - we really need a real bitbake fix.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


