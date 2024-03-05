Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF0C54E41
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 14:13:54 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.86])
 by mx.groups.io with SMTP id smtpd.web11.24011.1709648032219286578
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 06:13:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=E1cMeVvh;
 spf=pass (domain: siemens.com, ip: 40.107.249.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTlThNYYWe40xq08/Y37dBJVkM84aVI5L1/xKSdb7GvgxDR40eiHJcfrstuvN2kXFaEE+CYWB0NzWvaXO/d+3c1LmI5XoycJuP53UXkZnghLW0CLDaGjbtS6NnKwgVgx+Bar5hA2gOaObFURh91J+Ak5MNEu8c4ZLz1hYCk2qiZjMhs6u8BafNX9CRQZBB8U9rIy+GKlEeqvB0HgJjvf8MqjRg7zUKRvYUJ/0JPpTxkUYY9CR2rUvaNnvOIH1g9r2Jokbdjy1C0tNLANVeLknLDXWWYiIkrqZ0El9U0eNNv3sm7vOW2GYnBkU80IsK76HNGRe9e64DyoejPPs8d8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nrcq4PR9lkstkSSFIfeuqsYa1ihoWrQjFrBvrUu6hU=;
 b=KKVt01Dkig8PYdNv98+pT71MDAHb3DUj8Th1dUVBRNG5a4Egxx4rlifA2mu39lOZNZrpuxTO5qOLPgSueZfhzVVr7IVT0Tphu3zEoEyx8NwD7zhbQIzEOj+jw0LL+HPjg5hge1oNbbPbHeYi7+Bch6eyAKhOs4x9b/TBnRxcU8osvurn4/GAui8guUaYXkrFoJ/gNCoqWIZQ92fGC1/USskjwemzAYExv9mkJlGYuKqKrJtlQ5OxWnopnOYD882JQKK0K+BX+kyU/U4aJ/unQ/Bcd5H4nz371OtLdNi6yPKgXhtDRoDBLyS7UrcagNkzpi/8tT46B5NMdJ7unLawBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nrcq4PR9lkstkSSFIfeuqsYa1ihoWrQjFrBvrUu6hU=;
 b=E1cMeVvhcXTdlYJPJCNx2HNR/E2VakaeSr4xN30ZOVtk/os5kr9QOrUSOLZXhpp3h+bRpURgsMXTzTVtfGjRWEjr9leOyv4Eu/h734f8th8+A3E9mvqP2S/vE/bVBNv8su/H+BzjXSAHGnSWUpST8FnUUR3ksVgAjGy0a1C8xLwHdiXDR/dyOmD3OJPKGiKFxmIYg5cw8cEdzSzoYhddZaaTZ1TemmUqOJhEETuTQdxncgmZaGs85dC8XgZCenkUHjOOS41h7+I6y/lQu6DJUzpk6T/8rVA3WLqH4y6sFCkQNn1gDEGFdB7YMwJxj+yZcZkG0EUIXO5uVAbU3SnI9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:327::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:13:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:13:49 +0000
Message-ID: <69c2b3ab-2708-4697-934b-c6059874dd06@siemens.com>
Date: Tue, 5 Mar 2024 15:13:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate_2021.11: Backport raw
 handler unmount fix
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240301121241.259677-1-tobias.schaffner@siemens.com>
 <4e3220ce-429c-4f5d-9066-457443412bf2@siemens.com>
 <4159087f-c5d9-4320-acac-054f7d90dd32@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4159087f-c5d9-4320-acac-054f7d90dd32@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc3eae4-7cff-4160-cb22-08dc3d1e7a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3UoXAseialdk4frIYDvHikFkdpPJJn4IUPeWFkv+MzjNVnScp+QkviewZSM8QtNCV4HjQsN5Z7C6/BqsA9iyr1bG8JfusD96EpLDSqrS5QHiHjJk/d+ydE+TGvVuQfDPGrigtj/RP1smWoolHtRGsK8drfpSpq0qrUi9ztss2ziHsk/gGypdrUY/FKoc59EXOfk27H50UxGhXuIYa+oy9mKvLHnHmuAgltD7/R21zPy+xBduGkQ8qyHiE/S/eiPjf+esLHkOJRoNOtXMDO9vWQv/EZKiLHP6oSR2Aub/xlHRjCIjUVHERShZZbILjpvhpA7mouOHuXkTEMdAhrxS70FblyY5HB9GXCqPWNmbmEbZrBCdQ2NlRGOIX7XlmG85PO0tVgtW+pXx2kjiYU0zFKiAldjvsMfgBzQuFftLdAGZDDsatE9wPbLUtrlWUkcB3Je9/rsVaSEMdsGS4tPrbl8kh7hdzFybsWrs2avSs/EcgEeNJ0UCTODLVrRu0iLZmclO+nNODJyOfvtfHU7fFtkYwQyWcoNzhV5cB1GlL+1UyAZBM2UDma0VpOf08a/W5mRT8MqJCKq6AVo6H2akhN1EKm9BnLseyL1oOHYy81+5viyg07bPWgmqW7JlJaedmVTxhY7/dCIoBceNab4I5c+xGZJSsrnB+zl0dN9+ttg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EFZzG8XxBWcRC8OaARKWe1JxO74I5cNhyyB2Y5kZ4q7pWfUK5YagdL4yeqoA?=
 =?us-ascii?Q?mmxZ8pbwMGkd7Kf13p1RJyVqqm+LWZtObF8x2rddM7e92YHSIenME2kg1CkG?=
 =?us-ascii?Q?b1C1LAtflIunmhznVn5SeXIrE95z17bB1Yzmdt3LNT2sEFmYLMA5N9B/hwwJ?=
 =?us-ascii?Q?lq3PIz02EPqCKAO1gbNVGRkCwAabBPHz/RhwzP6PXksaedOzPqrAkDwqvNQR?=
 =?us-ascii?Q?kUIgqvs/kH18EuY1PeBNf/LKYdsyqxkbX4ejlGW2lY+hQQzGPsKmxKYDp6Ds?=
 =?us-ascii?Q?uyR0gn17mJmLX77ksb1BU2bEGgaQgoNbXYLYpZbS34v3V+01hG4FlbJu9c/0?=
 =?us-ascii?Q?0FXQf+Jv0ZfetYKwVIQn3GVtIDQcZpCgSa/3v0Vet6ULOMudxolun6Q9sl4m?=
 =?us-ascii?Q?wKpPAffD/j+Bb7uo4KjyP9DRMhBNuf72TW6R4KxKrM/jJFqvW3K1gnXMVjc6?=
 =?us-ascii?Q?z95/Q8uPzBeNBmJltXGZFVvfkYzwSWyZGQO5SU43yGx6yQv0gNRmiUrY43Dq?=
 =?us-ascii?Q?vIbaAOCxbGsGPyVrclca79hCJoUaOYl1XDc7X/1VFgEQfN/gd9ewd2zXVHEq?=
 =?us-ascii?Q?mnQdPNMIY7MAMwNwuEamOnwGyvFr+JmIpcx7Q+09J3Tk/d8KP1GlG4rM8EiH?=
 =?us-ascii?Q?MOoC/wS5XlGj6h+276UEAMQxpwZdqBCn6y9cSrxEDGDv2uriKjpelS6h2F4p?=
 =?us-ascii?Q?LVa+4zeW/rUtgOg49C0WYMoDX3rdOajPp18gOXpPjn0WJKEhbxnu84yE1eAP?=
 =?us-ascii?Q?8HUNVDk0hbkw+OCCTqfYwUWTkfPJ5RMhPZqV7dLz4/AOxDDyk5PKe3OSeKH1?=
 =?us-ascii?Q?63MG/7VSIRoNlOSOU68bLz37/F3tWOI9BvDI+K8ji4iswk4PNITZQKAnQ3Gk?=
 =?us-ascii?Q?23fvicezmqzQgyb2ROv8qjn9fiFxEasGphbJdsnAagMNB/S0aY+MgZbaRgr+?=
 =?us-ascii?Q?jbJZ/NCh6DWoESTetgS0+sxpXlIjeDUgH+rtwvkRdOY9xWwsfIY7nXG8BL2L?=
 =?us-ascii?Q?MH1H1QF7OnejTuvZ8odd6JE9Nxqst3mXawm/u9ZJX4bIbN4lTa33OS4Az70w?=
 =?us-ascii?Q?oOmTVNu10zX1/yTLBm96X3K6OyqUz5GpHqqCJrn0NCya/p0I7E43HXoyhuRe?=
 =?us-ascii?Q?6zls11qqhENh3NQzsYj03lSM5lk05XktSWDJWOVCwdkK4Z/5MZNqMOt9Jv5B?=
 =?us-ascii?Q?rHtOdobQqcOWnwnOfNUniIFgf0oxcrYPDGtnZ7mIOKmWC6/9YimlLAfUMIC1?=
 =?us-ascii?Q?fVcNJg58LsZ+HREu9wrjb7Z/zKdo2rgtypZxC4bSy68ucUNy0k4odcaY3NDx?=
 =?us-ascii?Q?FoZub+hgHkdZWQy4hTlW4b83J/sFDf6Cry60WicLN/NItaTY2aaFw6IIiwuR?=
 =?us-ascii?Q?XMHUyDhJ2oK84p51CMPVAMzm1dYoehGdwAFv2qkDRnv88+PkBSJ2k5O3fbx3?=
 =?us-ascii?Q?eypkY/cdoJwWJhVvdp85iXgSc0s6krUXy9umlAVUDqWn7wUDy5Hgrg4JnexT?=
 =?us-ascii?Q?NWNrhCZYGPdHRPi0liOeP99BVeCC5SgFsK1+HgLQhnKIU1E/E9VdosA3Sv90?=
 =?us-ascii?Q?ecVZZPZ8P+dEKItT1sdhyrHJ4aihMkBTkECoH1w6E/2vXD+AimHGbRN2UusU?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc3eae4-7cff-4160-cb22-08dc3d1e7a47
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:13:49.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc1HZFInOS+MrzHozvz2GozqOErgo5r65nWnM/XnbgmE88bvlg7YUMkQ9e4QIeRSf5bRN+LbJbP/eP7lFNhzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5163
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 14:13:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15226

On 05.03.24 11:55, Gylstorff Quirin wrote:
>=20
>=20
> On 3/5/24 10:18 AM, Jan Kiszka wrote:
>> On 01.03.24 13:12, Tobias Schaffner wrote:
>>> Swupdate 2021.11 has a bug that clears the boot partition if installing
>>> a kernel file fails. On error the boot partition will stay mounted to a
>>> directory in /tmp which will be recursively cleared.
>>> This is critical if A/B partitioning with efibootguard is used as the
>>> ebg
>>> environment will be destroyed making it impossible to do further
>>> updates.
>>>
>>> Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>> =C2=A0 ...ian-backport-raw-handler-unmount-fix.patch | 165 ++++++++++++=
++++++
>>> =C2=A0 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |=C2=A0=C2=A0 3 +-
>>> =C2=A0 2 files changed, 167 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644
>>> recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-un=
mount-fix.patch
>>>
>>> diff --git
>>> a/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-=
unmount-fix.patch b/recipes-core/swupdate/files/2021.11/0006-debian-backpor=
t-raw-handler-unmount-fix.patch
>>> new file mode 100644
>>> index 0000000..fdea66c
>>> --- /dev/null
>>> +++
>>> b/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-=
unmount-fix.patch
>>> @@ -0,0 +1,165 @@
>>> +From faae516d5c06dc13b953002fd91c0ba3e9bba7d8 Mon Sep 17 00:00:00 2001
>>> +From: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> +Date: Thu, 15 Feb 2024 10:43:12 +0100
>>> +Subject: [PATCH] Backport raw handler unmount fix
>>> +
>>> +Swupdate 2021.11 has a bug that clears the boot partition if installin=
g
>>> +a kernel file fails. On error the boot partition will stay mounted to =
a
>>> +directory in /tmp which will be recursively cleared.
>>> +This is critical if A/B partitioning with efibootguard is used as
>>> the ebg
>>> +environment will be destroyed making it impossible to do further
>>> updates.
>>> +
>>> +Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.
>>> +
>>> +Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> +---
>>> + ...nmount-target-device-when-installing.patch | 128 +++++++++++++++++=
+
>>> + debian/patches/series=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> + 2 files changed, 129 insertions(+)
>>> + create mode 100644
>>> debian/patches/0002-raw-handler-Unmount-target-device-when-installing.p=
atch
>>> +
>>> +diff --git
>>> a/debian/patches/0002-raw-handler-Unmount-target-device-when-installing=
.patch b/debian/patches/0002-raw-handler-Unmount-target-device-when-install=
ing.patch
>>> +new file mode 100644
>>> +index 00000000..f291a8bd
>>> +--- /dev/null
>>> ++++
>>> b/debian/patches/0002-raw-handler-Unmount-target-device-when-installing=
.patch
>>> +@@ -0,0 +1,128 @@
>>> ++From d843a97aa56817c2c48dfb4f4b50315cdf753328 Mon Sep 17 00:00:00 200=
1
>>> ++From: Sava Jakovljev <savaj@meyersound.com>
>>> ++Date: Wed, 31 May 2023 23:44:22 +0200
>>> ++Subject: [PATCH] raw handler: Unmount target device when installing
>>> a file
>>> ++ fails
>>> ++
>>> ++Make sure to call 'swupdate_umount' in every scenario in
>>> ++'install_raw_file' function - this patch thus solves
>>> ++problems when an update fails on installing a file, and next update
>>> ++cannot be done because 'swupdate_mount' function fails with message
>>> ++"already mounted" because the=C2=A0 mount is still there from the pre=
vious
>>> ++attempt.
>>> ++
>>> ++Signed-off-by: Sava Jakovljev <savaj@meyersound.com>
>>> ++Signed-off-by: Stefano Babic <sbabic@denx.de>
>>> ++---
>>> ++ handlers/raw_handler.c | 65
>>> +++++++++++++++++++++++++++++++-----------
>>> ++ 1 file changed, 49 insertions(+), 16 deletions(-)
>>> ++
>>> ++diff --git a/handlers/raw_handler.c b/handlers/raw_handler.c
>>> ++index 619a2f47..ac6a2030 100644
>>> ++--- a/handlers/raw_handler.c
>>> +++++ b/handlers/raw_handler.c
>>> ++@@ -206,8 +206,9 @@ static int install_raw_file(struct img_type *img,
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 void __attribute__ ((__unused__)) *data)
>>> ++ {
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 char path[255];
>>> ++-=C2=A0=C2=A0=C2=A0 int fdout;
>>> ++-=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +++=C2=A0=C2=A0=C2=A0 char tmp_path[255];
>>> +++=C2=A0=C2=A0=C2=A0 int fdout =3D -1;
>>> +++=C2=A0=C2=A0=C2=A0 int ret =3D -1;
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 int use_mount =3D (strlen(img->device) &&
>>> strlen(img->filesystem)) ? 1 : 0;
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 char* DATADST_DIR =3D
>>> alloca(strlen(get_tmpdir())+strlen(DATADST_DIR_SUFFIX)+1);
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 sprintf(DATADST_DIR, "%s%s", get_tmpdir(), D=
ATADST_DIR_SUFFIX);
>>> ++@@ -228,7 +229,7 @@ static int install_raw_file(struct img_type *img,
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (snprintf(path, s=
izeof(path), "%s%s",
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DATADST_DIR, img-=
>path) >=3D (int)sizeof(path)) {
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ERROR("Path too long: %s%s", DATADST_DIR, img->path);
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -1;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto cleanup;
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (snprintf(path, s=
izeof(path), "%s", img->path) >=3D
>>> (int)sizeof(path)) {
>>> ++@@ -237,35 +238,67 @@ static int install_raw_file(struct img_type
>>> *img,
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++
>>> ++-=C2=A0=C2=A0=C2=A0 TRACE("Installing file %s on %s",
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img->fname, path);
>>> +++=C2=A0=C2=A0=C2=A0 if (strtobool(dict_get_value(&img->properties,
>>> "atomic-install"))) {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (snprintf(tmp_path, si=
zeof(tmp_path), "%s.tmp", path)
>>> >=3D (int)sizeof(tmp_path)) {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E=
RROR("Temp path too long: %s.tmp", img->path);
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D -1;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto cleanup;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +++=C2=A0=C2=A0=C2=A0 }
>>> +++=C2=A0=C2=A0=C2=A0 else {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(tmp_path, sizeof=
(tmp_path), "%s", path);
>>> +++=C2=A0=C2=A0=C2=A0 }
>>> +++=C2=A0=C2=A0=C2=A0 TRACE("Installing file %s on %s", img->fname, tmp=
_path);
>>> ++
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 if (strtobool(dict_get_value(&img->propertie=
s,
>>> "create-destination"))) {
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TRACE("Creating path=
 %s", path);
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fdout =3D mkpath(dirname(=
strdupa(path)), 0755);
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fdout < 0) {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mkpath(dirname(st=
rdupa(path)), 0755);
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ERROR("I cannot create path %s: %s", path,
>>> strerror(errno));
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -1;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto cleanup;
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++
>>> ++-=C2=A0=C2=A0=C2=A0 fdout =3D openfileoutput(path);
>>> ++-=C2=A0=C2=A0=C2=A0 if (fdout < 0)
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fdout;
>>> +++=C2=A0=C2=A0=C2=A0 fdout =3D openfileoutput(tmp_path);
>>> +++=C2=A0=C2=A0=C2=A0 if (fdout < 0) {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -1;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
>>> +++=C2=A0=C2=A0=C2=A0 }
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 if (!img_check_free_space(img, fdout)) {
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOSPC;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOSPC;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D copyimage(&fdout, img, NULL);
>>> ++-=C2=A0=C2=A0=C2=A0 if (ret< 0) {
>>> +++=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR("Error copying=
 extracted file");
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++-=C2=A0=C2=A0=C2=A0 close(fdout);
>>> ++
>>> ++-=C2=A0=C2=A0=C2=A0 if (use_mount) {
>>> ++-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swupdate_umount(DATADST_D=
IR);
>>> +++=C2=A0=C2=A0=C2=A0 if (fsync(fdout)) {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR("Error writing %s t=
o disk: %s", tmp_path,
>>> strerror(errno));
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -1;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
>>> +++=C2=A0=C2=A0=C2=A0 }
>>> +++
>>> +++=C2=A0=C2=A0=C2=A0 if (strtobool(dict_get_value(&img->properties,
>>> "atomic-install"))) {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TRACE("Renaming file %s t=
o %s", tmp_path, path);
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rename(tmp_path, path=
)) {
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E=
RROR("Error renaming %s to %s: %s", tmp_path, path,
>>> strerror(errno));
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D -1;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto cleanup;
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ++
>>> +++=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>> +++
>>> +++cleanup:
>>> +++=C2=A0=C2=A0=C2=A0 if (fdout > 0)
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(fdout);
>>> +++
>>> +++=C2=A0=C2=A0=C2=A0 if (use_mount)
>>> +++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swupdate_umount(DATADST_D=
IR);
>>> +++
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> ++ }
>>> ++
>>> ++--
>>> ++2.34.1
>>> ++
>>> +diff --git a/debian/patches/series b/debian/patches/series
>>> +index 98628a77..21a82863 100644
>>> +--- a/debian/patches/series
>>> ++++ b/debian/patches/series
>>> +@@ -1,2 +1,3 @@
>>> + use-gcc-compiler.diff
>>> + 0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>>> ++0002-raw-handler-Unmount-target-device-when-installing.patch
>>> +--
>>> +2.34.1
>>> +
>>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> index 2384f41..5671cfa 100644
>>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> @@ -25,7 +25,8 @@ SRC_URI +=3D
>>> "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
>>> file://0002-debian-rules-Add-Embedded-Lua-handler-option.patch \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
>>> file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
>>> file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fil=
e://0006-debian-backport-raw-handler-unmount-fix.patch"
>>> =C2=A0 =C2=A0 # If the luahandler shall be embedded into the swupdate b=
inary
>>> =C2=A0 # include the following lines.
>>
>> Looks good to me. Quirin, any remarks?
>=20
> Looks good to me.
>=20

Applied to next, thanks.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


