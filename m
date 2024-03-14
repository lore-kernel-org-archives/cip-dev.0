Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E6C5475B
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 06:40:33 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.53])
 by mx.groups.io with SMTP id smtpd.web10.6298.1710398423589321260
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Mar 2024 23:40:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HN9kdtOu;
 spf=pass (domain: siemens.com, ip: 40.107.249.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ4OZsSpl4rN0fQmTGdPzW+xxJRNo6kdNJ+zvTrwEgJ95RS4alaqmWwRtYHIw2/1pTqFdQUJnbHuhTlFzEyO8rks1OoX4Nc8BGbY/sD5Qbez4G/dXyxm2DhUBLgBkhElT81FiEsepWIL8bZb64d1duXvFIebh0gASbGh/e/jqQirzQDzblcsBHiymTGct6Td1SggdWqWR/jgtOno8LomfsagAnpKxoIvebHDHWXQUzvbInkwwK/YUdQJ5Zd+IGbawFwCU4O6hlWmPEcc0r39BhpXZaxYuXoYQi9qMrBr5idFAh0GXu/Xj5znctgNzL6AIm4ONKs2p8v7K6HC5ondbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+vggSEGGJPnOkqcIrVFZX5pwRs7bJnWxV8U4tfzLcA=;
 b=lTOm5ntuWmGxGLFH3x5WbghTIiS2BSucp7pKW6EF+9BuInmQXVsPhyUKqraR2RsiPOjUI3QTxm4HQ9eu9OfSwEYQlSfr7P3U6YCsb3vfV/Tmlel4F9IxGXf68P4V6jFcABpvbsxtsZasJkoIkitCC/ndMzAkdA6zD8oyn6x0fE8UX7t5K9atAY+kbPwHn+AEp0SNqWBa+6e3SXO+KAEoOcAcaGk6KWOZkP0wj7DOO8PzOttmRtEgeKKZ4NM1a14ktpI3sjQLQIS23lwq2SEtHYQE11E0x8Ipa/LjEKQlFMPef8TWk9bpZL3O+c2Cr4Zisr18+KlhBZc2DRdY2T6TvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+vggSEGGJPnOkqcIrVFZX5pwRs7bJnWxV8U4tfzLcA=;
 b=HN9kdtOu5K98SS5acv1UpncvgjYe/5BJ0CTluZRLt8trW2xIAxtmqoI8nkJckEzHRiRZSgKpc+t7mhyC9UtxJevo3XVTHxbWXi2v/YumVgZ5EIucwuH93k3CxUpMrR5klUAgsFejDK6BlEQzFHhWTC2La2onbAhmBgcbWVGnUqksk3RrnlvKWup50xnxcgv8+l3baunWQ7T0xT/qZLZDCJv5ka4vBM3W4THYgVJwRpcNx2OCSJVYsAUoBJ2UzfLus7tqIVVi95o3zDE2R87s/9oCxfCt6/6/o3IowCXGC7uFGrgG0XtZeka+fEjD2vWn52BrmMNrihbE//29Vnz5HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 06:40:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 06:40:20 +0000
Message-ID: <03cd1e82-b8c2-4e41-ae87-cc38fe795840@siemens.com>
Date: Thu, 14 Mar 2024 07:40:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Full disk encryption
Content-Language: en-US
To: JohnW <johnxw@amazon.com>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <M7ni.1710344950155327128.L0dJ@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <M7ni.1710344950155327128.L0dJ@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e00812-5d26-438f-ef4b-08dc43f19e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C8gUA7/mJdbwaNihMmaYbzLfu1vkb22KCQFGUoen3+6OTwvCFToEOzytT3Jbi2B+yRAM/WVTk6w9irOlqqzMX6YyPW5HaCiQrMBPID5tlonpw1CX33+2kRkw7D5+5qgjUgaliYwR0W4AQBOtVl/j3jasMZx3zbdiRWIW34YwtBVRodiMhUytSTKmJGSG0sMywbk4t+0kQD3eOS+1DGt69ObnHQaauPQHNhemi15PoYhntW5G5gSUNvo7EjyavGm03r48aL0T2ao8s01QgE09PpRfZUF9FtCRvDNlKuLIbjRO46fJNBp8/x78SzKUJIfEXhrIgoIsZRjL5kHG3qPFRN9xu5lqEwHEzp7JkYzlMj4kulJpPKlqm4y+A997Frt9afVKhg74nMEiPJzJHyIZA/fc3ZvuaFr9mvXJQkcuMSzkkeemYuCVNzW5LerpNzOpyCC3vaPkH89kSAbnfO2KmwawRrSBGo8WnA0I4MRyk8L7j+RKySHNaM1yWkztR736aMih7hjOQkjvbGpPOGC8Ar2NDibhiRM0MEBlhiTxpRF+Z2NPAZmhvxnn6YpEu45oxCkTPIvJXJN1Ou25QH72VxEk+heBIeJVCB49yOKfUykj2fGW9GKyaeHbPJ74pKempR5QbxIHxTQjjL088mIB/Q5eMfOIoBZbaWHZEWUGNds=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4n6j+slJ/UXXqT520RjYkcSyfLOLywMnZa+Ir/3jVzUR47Y+D61d5vngpilO?=
 =?us-ascii?Q?rlJAkwAODEzWZ7U5PzHaqkZhTbePPZGuv6+PyYo5dQPpvgbo5IsIqb9Q2zvr?=
 =?us-ascii?Q?8+aZDhAdh4ByaEddP1LM2OO541qB+PVKyxnNapf2CVQBdPJYN+QE7UhcS1k+?=
 =?us-ascii?Q?FL+mLtCLpiNK8Xhmzv8REC+SA+KdeEFQGjTvEo0m82KW+UI5xH71R1dkvTsn?=
 =?us-ascii?Q?NkcV9/ZPWygmIkwlZfNKaF1tHCO86Nmiib/1dM6z1lLxbY/l+x+VdRltk89Q?=
 =?us-ascii?Q?LcS3B1eRpgtvXBGc0HWbnuyb7tN/TDPkwOsGrVcQjUaSLccpFa01hQI1m0tA?=
 =?us-ascii?Q?mR0KJfuSVALpf2FfqTZaGpV7BwnC5mr6TG9Vp8RVyPFF+olO62LnJ85KdrfH?=
 =?us-ascii?Q?6lGZ/tANClk8Vg2FXFyJz5z5tWpkXpq91aPBA0vajRKj1QQeZt8GMtq0Df/Y?=
 =?us-ascii?Q?o4qDPy/ayPLJTpfLqHCDRlIu5T7UqhpFajJJQXxzIc60d1SVfA3SuQmO2TBB?=
 =?us-ascii?Q?tWscb1oJCfI6VOxolkQn9hylrZa1QjaoB2VobtJTBWkYC1IMfXw02SwQwGgj?=
 =?us-ascii?Q?h4VLiCDeH/ssFJdyXQ+Y54iTRUal5lNP8oGoK2NcawqYu/FL0xCxlgn9IARh?=
 =?us-ascii?Q?RIf1v0yX9L3sPySm026N0NXLsI4a0I1qfpL7vXU6sljkbeRTv2rVASt7C1vO?=
 =?us-ascii?Q?7c80EdWFVxT0wjcqIz88STO3DYULq6ofEr6sx6CGCXQ7DJuMAnIe1zO6yQVL?=
 =?us-ascii?Q?5nk0Cgj+fgab2TW80fA7U7y1t2QwDCWAAEPf/NhQ3jT69JTs7/iOE8otGydX?=
 =?us-ascii?Q?4otyKZRyRe0HBfeHBzW8PR1AkBF7gqnOddzfTQA1lFT7Czi0Rp/7QAyS22Ju?=
 =?us-ascii?Q?3INOvIwWbZB27uYTtQSmN2RKVVgXqeLeAIaIKWTsEWYOQvINsg+94lgWc97+?=
 =?us-ascii?Q?zn6iqX+Tb5T47D6qw/9bMPL3Lv+XyspCnVqg1y9rE/cfKRyaVt6ZW/3OP/d6?=
 =?us-ascii?Q?+s9t2GP9tnkdTvmZU9g0r0BJqKinXNsHewYykvbU4IlQc2ChZ0J8pTl3me7c?=
 =?us-ascii?Q?nL23e3JLUIaeb7P1ceMuD9oD4MGhOLprOA6pngA12AtPiJcwmdnXDUdZlc+1?=
 =?us-ascii?Q?C862LUmU7IrfMLQzReow6Qq5xYB34ZxzgGR3oVqEVjYmDNvyM7bYHSeIpHG1?=
 =?us-ascii?Q?g2719PXzvnv1Tn8T0WMwoWPcZu/1emfzTK4ETwOrGWICe4upOprRJyF7BHzE?=
 =?us-ascii?Q?BULlbNeEE0dyxoFYhmGOnzm8rrgh5eH8iAvlpvdFXLx2en4PPNRyB9OB7H2y?=
 =?us-ascii?Q?QwlePFb7zpOpZFGNBjjiiJOhlyy0XvmHxGSbvStO1q3N8oQtcwuAyptw/2Qp?=
 =?us-ascii?Q?5ncP1TIWQ45Jz238ThQCvNrcEYGuMfN3aptCFhmNT+GD2YvDZfrbke6KYkcz?=
 =?us-ascii?Q?qPg4MrdeYIMLmVRXMfj4RRtES+b+ry0Z0D1SLCDEhVbx2RLXozz2QUtvCxn5?=
 =?us-ascii?Q?39EjeOrcgVRiC2KcgrWf2TF9BxUff149DeonFNSw5dw0Dn1gDe30vIGq0F+W?=
 =?us-ascii?Q?6n5xg4BhJuYpwlwm7ocwlKBpA8GsO1Eys7u++8AtMG8/LY/lXEGiZlrnfFI1?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e00812-5d26-438f-ef4b-08dc43f19e19
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:40:20.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+nwYv8q/EN/fayWOL/Aq3LAlhBozoK1c7K8j56c/F0oMi2kDrKv5lsojRT2v+xBfA0v6z7t+sx5kh4nmfBq6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 06:40:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15295

Hi John,

On 13.03.24 16:49, JohnW wrote:
> Hi CIP dev team,
>=20
> I=E2=80=99m working on an image build that requires full disk encryption.
> Currently the CIP package only support partial file system encryption.
> Does anyone have an example or guideline on how to perform full disk
> encryption on first boot?
>=20

Let's make this clearer: You are looking for adding support to
encrypt/decrypt/mount also the rootfs partition(s) with the initramfs
helpers of isar-cip-core, right? All other type of partitions (minus the
unencryptable EFI system partition and EFI Boot Guard's equivalents of
that) are already supported today.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


