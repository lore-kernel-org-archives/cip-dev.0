Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D35DEB64DB
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 13:42:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web11.7823.1687182159236589052
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 06:42:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=H00acT4k;
 spf=pass (domain: siemens.com, ip: 40.107.20.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1mTJP3WGw9soD4OY74XoEbNqTBNjc6/NAnUy2ksBlHatnbRK32rsc0iPo3UqP4HOdpE4tr3yaoqYS5HGRC4eu3Nn+RHdLxjtpS+NclGUdtTe9M+HZuQkNx+PyCYBYt9QN0ixYKa5aLheXPAf0PFmGdv1PkDYUnofdaoUNxanUbioVXe/PNjgzxha8H5Us3xTIrWkJhTqd40JwUd6vHdu8Z8AMQmR/apBO6EgmyoH05QcMe88To41T7RZKbFrDAFc9MBBlvUHLX6STyFL0sFSDembdAvz4wMQvUyNf6HdHD+UwE+1DlEP5Ckp316yGaX40OexDumccaKyNP9NErwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tisoXBbKT+yDvoO0Jjng1bw6nMXR7AdIt2sXZ/9RzB0=;
 b=kLphdGJhoVKjaXKBqUSZJuLnfmr2sSyt4uiJFkD0f3BFFZPvXp5Nu5IsIKn4XdxOPdr2Ti0JUdR3DFyhG2fQjO5M0sAHIT1h8Y9+bZYNeCv1rTT01aOtgkKqFW7ur0zddWVNhjKVkK3GtlVarjxYgu1f64lxuCMvj6SUGy2Sp13/10634n9SrCvLxlGQXFsmQso5XIkPZDaHWC4YbN8z2KQ1UC68FSQFexlu5vMxpPsn50SXDa/LGi9U6iUAg7z84YuwcOV9DO9VeBbbB+IZSrcEvItW/gSIyKuHG33Ttq328SkHuZstenipaYEwfUavZDgtGd11j/USpfs6uW5XUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tisoXBbKT+yDvoO0Jjng1bw6nMXR7AdIt2sXZ/9RzB0=;
 b=H00acT4kf/B5NHVde1gUB3Et5Ygki7+I1t4i+I6atF8ncKDkmxNm9tcG8/JeNfhWaruFZ7es7fXDHr+H/0Gele2ItzgyXMKzj/CC/0sYBuw6pQrQJkIBUphMW3z1E9TmmPvZdnu2nX5GVWbFsKHcYZtblzM0WI9IhsYEWe0+Stgx5291BvWy2OHiog2obMol4OLN78oEK6txJHHf9dvyVJp1dYzJgWuFKBzL6WaNC/UU4oDD0ET1Qbwq7JkDrcxAsyScwNkgnCwpcBZH45zprKUrWqusI2pa/Qv8g/k8qC4PZEtQIWldzr5cncI/IoV4g9o5ihBtQugoOUUcjLXJ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7677.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:494::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 13:42:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 13:42:36 +0000
Message-ID: <d77518cd-d96c-13c5-f857-989326b283ba@siemens.com>
Date: Mon, 19 Jun 2023 15:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] efibootguard: Update to 0.14
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
CC: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <795ab3b7-8aaf-3649-bc48-87bf780e11e4@siemens.com>
 <041140b7-0ac6-f735-22fb-2c8be047c8dd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <041140b7-0ac6-f735-22fb-2c8be047c8dd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6254a6-a6d1-403b-3da1-08db70cb0a58
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OGrANDgPJI69Y6tVXx64YBetEs7gWsBUpFQ1inx5XAOEw9tbii/hwxt0mjkLGT4aJ7EBLd4Ei6XELMNhpcxQYthCkyW4bse7xWBCOYaS08ReKo5PvSEDxNbl+g6NTBNNm6LtNbR4UM1nMN0V3qoeAynDm/lvQdhPxvV7JhYaFOA0WAMG0TwClw46IEZbGinaDNEXzPO+UFVG9P7QplThdCSB0EJPpgJpV1cTurmGXHtew+U0T2tzVy+rQTDtu1+BO+/qGeSj44IE7f1FCHW+dYi8fwJ7mD1DIhmVsmDKvbeKsgdEnfctoUnSi7bO9pT1xthS1Bhh+mHQI77pquyqmkiG0VZwbax+w7Z4uTP1NdEpjMYFlM60xfzQFUmoduPofarbJhkIBJp1PO2TaTcKJV1rxd9XhZsGeg14sCThl/GTZhRnFbFFbTKkXpsyfKNEHBnNC9jVCswqrCKHsm/85bTsv2X+qvluYBeusk49tI+ejJ8jYuoy437tE4l8pVi7BSzbmKh3Iz/IIqAq8ns43wybhai5c2icfkc1idUfJbxDOZEdyNvZGRh+RUQNKXe3jKyH3Cl9zFJUkgqRdUPSio9LFRMaHIVxT2x/yfjSsjbzMXhTFUBN1PrghXb6Vvs8XErPfrkPbjMhnsNnu7OfVL852YPY6iRzT0Zzs/8ERpo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(31696002)(478600001)(2906002)(966005)(6486002)(2616005)(15650500001)(110136005)(86362001)(107886003)(36756003)(26005)(186003)(6506007)(6512007)(53546011)(8936002)(8676002)(66476007)(66556008)(66946007)(5660300002)(38100700002)(44832011)(316002)(4326008)(83380400001)(31686004)(82960400001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xPrXcjjUZ6M6IBZRlFWi1wg2OUv9a14uj9EfeNx6ug+ocp+tSCW6N1qWrGMf?=
 =?us-ascii?Q?POgcOPbf84Nf3VzQ89dAQF+zgp2ubypj2aiqZLh7WUzEByo5s/XG88469AIP?=
 =?us-ascii?Q?2P7M9Bdj2E8UAcmqXSfVAz6lvzoG+4Jj5SNjVEYw6q+jSsFBjzk+00GxMjbe?=
 =?us-ascii?Q?3+Sk0/jY1CVByI6XJZ26ZV74gD0t5kA23+0kRdJCdcvkK/8CCfgD9UkC3/jk?=
 =?us-ascii?Q?qSCiOknu37Hu1P0WkyIt5Xeu9edtcl1cPjCQvAjKsjK/+6sE67fsSJO6L/46?=
 =?us-ascii?Q?Uf9RkpVmSNoeZKlGKkmeeBGwJNfeGbLxWN/x3MjsNlkOqpx2SWal4BN6vby+?=
 =?us-ascii?Q?HCZgshdQiMXhVfpVQbDHpHVKfBKJPjZGbn1loCmDcjg8KuUFkxbN13gdPLlG?=
 =?us-ascii?Q?lHofg/Yw+JyLoYmtU3wzDspPS3NHr7a8yUj0i8t0VCfzjVJ1Z2OkHuNJun+R?=
 =?us-ascii?Q?bMLcYSSIExuJMyqzIPSelywXt2CxC03TVCWZnjvY+J12gIQWFef/hnmgwsni?=
 =?us-ascii?Q?fnAvdD+NjopMtfJdKZhEBf56QBvSRY4SgeO+/1wq16iUhbz6KD9OP+uz2qdH?=
 =?us-ascii?Q?VuThj6snKENro2ARqcbQABt8S2YxD5nFEBFgVFPqKk7Oobat2N+k5cEXamA+?=
 =?us-ascii?Q?Kxhco5tDVH/6giXp2HqUAk/D3YnvSX8NDSMtObi4nidM2Y+MpLfTlPInwvfu?=
 =?us-ascii?Q?eotuMRvgiaeUFUJ6rBsHjGeWqGPFu1HxhuRLUNToilmCoVPaFVbCultgWOo3?=
 =?us-ascii?Q?0cqktmexAqtsmgQPUGBuot4aiHomhgXH7kkDyXQQzTHNQRA1tFaild6sUL2q?=
 =?us-ascii?Q?7hQIWJv0VLxTs+wGx8C0D7ZDs9kDOFG5SFD/dhiJPXFuvADgWdT3OJEwvLKM?=
 =?us-ascii?Q?8+tcG9DuKeQlQfUagMX8IPC/DPpHoTeM9uwzlL3Te7PwDYWckl10XVlPvfhu?=
 =?us-ascii?Q?x4/IoQn0JmylCepmDIfF8iBVXkdF9T6YrCmt45k+2onXdlsHh64Eke6K0g/A?=
 =?us-ascii?Q?H90FoB0XeF2t9s8lGYtJLiEpPHEvEqBMFmtaM2WEg65/LDROkDVRSqf4t/VN?=
 =?us-ascii?Q?jXi0sF2svPdBNCOME6dTSO6IDe5yXdymSlmuha7fY4gs0J4wlvfi6XJ9jffB?=
 =?us-ascii?Q?bS8QKXYF8CMw0ytn1mpUovpopb5mrhxZmssvGzwQU0f96JdV65mb13pjxk7c?=
 =?us-ascii?Q?Utsx5RZLgFPYlFVucUFcb+QAF8y6Xe3Qdz4J9BJ3jCT2ggdtSsS8c2I8ntRl?=
 =?us-ascii?Q?WuyOWHw9KDxkZeyrGuCm/Ggp4XxNgPfXfwXzHps6inRkPxxKglMtO3wCBBrW?=
 =?us-ascii?Q?+GsWAb/rDYlC4peLBAF9tlnnmD/qyvIfhj0RO9XZ89I2x45NE/WFdSOBNZmE?=
 =?us-ascii?Q?hC8C6TfqVfW8key/gZvZccVvWKHlrGwoMDrp4BSa9asEp9AIMyHKfIloVWye?=
 =?us-ascii?Q?YJ6rXsgB9qbjAoChbTCfjChfBtZ9731tJsjc4tvZIXjdWWpKuxCE8pzoQzap?=
 =?us-ascii?Q?nKcwLNPht/g7Oq/codRGvKerlySvtvqXcoqMjpXYeY2OwKuHAr5ntYHZdICj?=
 =?us-ascii?Q?Hwc2tqyGws4qmHWl/5+jcqoq7zPkz1/+fZqpCAhWpBj2v2GHX1RYfc4x7SL7?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6254a6-a6d1-403b-3da1-08db70cb0a58
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:42:35.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCSAenIrgurlhf4B5JcsCzfzdi9Ie8d1iAElnk6BvL/uJMkd88KaoC1l36DS1sP5RFVEcZW+VORf48Dv6zHqsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7677
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 13:42:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12077

On 19.06.23 15:29, Gylstorff Quirin wrote:
>=20
>=20
> On 6/17/23 15:09, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Allows to drop the RISC-V patch.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 ...0.13+cip.bb =3D> efibootguard_0.14-1+cip.bb} | 13 +------
>> =C2=A0 ...01-add-machine-type-name-for-riscv64.patch | 39 --------------=
-----
>> =C2=A0 2 files changed, 2 insertions(+), 50 deletions(-)
>> =C2=A0 rename recipes-bsp/efibootguard/{efibootguard_0.13+cip.bb =3D>
>> efibootguard_0.14-1+cip.bb} (78%)
>> =C2=A0 delete mode 100644
>> recipes-bsp/efibootguard/files/src-patches/0001-add-machine-type-name-fo=
r-riscv64.patch
>>
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>> b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
>> similarity index 78%
>> rename from recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>> rename to recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
>> index 9fc15a47..f58a3200 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.13+cip.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
>> @@ -17,18 +17,13 @@ LIC_FILES_CHKSUM =3D
>> "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=3D751419260
>> =C2=A0 MAINTAINER =3D "Jan Kiszka <jan.kiszka@siemens.com>"
>> =C2=A0 =C2=A0 SRC_URI =3D " \
>> -=C2=A0=C2=A0=C2=A0
>> https://github.com/siemens/efibootguard/archive/refs/tags/v0.13.tar.gz;d=
ownloadfilename=3Defibootguard_0.13.orig.tar.gz;unpack=3D0;name=3Dtarball \
>> +=C2=A0=C2=A0=C2=A0
>> https://github.com/siemens/efibootguard/archive/refs/tags/v0.14.tar.gz;d=
ownloadfilename=3Defibootguard_0.14.orig.tar.gz;unpack=3D0;name=3Dtarball \
> I would not use downloadfile to create the orig tarbal. Reason is that
> the usage of downloadfilename currently breaks mirrors, see bug report
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15126.
>=20

You mean rename the file in do_prepare_build?

But that's not really a regression of this update ;).

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


