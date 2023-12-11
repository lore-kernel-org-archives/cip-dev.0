Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D2C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 15:00:24 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.78])
 by mx.groups.io with SMTP id smtpd.web11.10333.1702306815537824957
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 07:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZvXwICoz;
 spf=pass (domain: siemens.com, ip: 40.107.20.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6i78CNchLe4bLlhGlOgQMYQhfEq95QwwU8AD35jU7gn6Ko48dBUf8C5tXmvP89820yNvUzKVW8IeX3mdugReD2PuiSTbmY5+6rWukwmpP1z23hSmQav9OTr1wcbJ+Lip3RY6saq2okwKLhYM1Oq+mje6VgLEpNLGdxuD00Jhy3NVQexGgZIG//Ictgiw2DgRCJnIUcNhVdnG1ealQ1N0urPliLYM4zAqaZyvdTo7ZJIssr+o6ZI/JEkxliU6SqiYfvPha8gssWs0aS35CdXVZEoXHaMTHNA6gukH8Nls9u+PPRJuY5IsjwMBqYP0l9N2lr/51PivmBfEblqd0E/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxR7VDtC6DNx57n17oc1A4E0H58245v9Vxw0kV8Jfy8=;
 b=Ru0N624qUc3n7KIpjMq3B0Qe0qsPDmtZFyLleBcf2Nd33SV4VLk7kBaYblx1lFR+eG0/SasovoAY8Rskd+nsCx3AAfKPz3i43+fuqoBwnRMgYTKuRBEvAkLUof4Iq7IFeD7lbplhdgIyziYKGTfg6KoxeZhA/PalDch/tHnmbfZ8OXWmPnELVGXxoEk/eP+ZnvVSjwQZkCbg51JB6fP2L+tf0oSFJXL5nzLAjCRnMSLQj4Gi4pr4yJJ11Rn9I3L+N9GEJC2KD0RdbuROJWKmi3GMeZpo/uHH53mVmHgNZBTsXqGxLo1vPsQMgO7QDqhovY/e7PT/O+hTODs6mxTmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxR7VDtC6DNx57n17oc1A4E0H58245v9Vxw0kV8Jfy8=;
 b=ZvXwICozYuSCQtY36jhR5vBpyOqG9cbr55cyWWcna8DH68gJXve8h0sp5fPXoRvOyXL5EwL3a2mpo3oO+HCLob6i9lTjoI1wnOZ3poJ4zAdH+o/xu3HRQdWYUt/7HNrL6Jog4JoLdj5Oi8kUj5DluhVZ7bI3OHC2fyzpZdjLxde1OkaEYxL/sSbyNoO4AZePykijCM51pdwSajICNDRDoYoUg/UM0F613Ns0SI96fv4F21EBvXCv8lWDx7WM2O0Haila0LVFiAlzupcy9WCOjdYsqFi5kHBgqY89XhQqG2m7DfgYfpGwHlM2CuZ0RkThKIuOKdRm7yT0smL4SJy4Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 15:00:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 15:00:12 +0000
Message-ID: <d965d3fd-9e7a-4c14-90fd-a2f71cbe5ae2@siemens.com>
Date: Mon, 11 Dec 2023 16:00:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update
 binary
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <570fc651-6525-4273-ad9a-aeef4737272c@siemens.com>
 <952cf6cf-65a3-4e53-ba25-01afe312452c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <952cf6cf-65a3-4e53-ba25-01afe312452c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5ce5bc-4610-43db-5767-08dbfa59e01b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8JrRDxOkXHqhwphcFBRaNZE5jYdtMctc5RQHglWoKHExsHJQfyv677KfI52tDwjczFDLaRljKkbdR05rBbXUbg2WKWoL3/xf54N2DwU9NnSpQFIB+wkBqUPYBXIHZHgFwW0BYmJav9jrRF83GzXG2AJkXrXj4/fNja3lLq7RVpfvmJ2urHqiZUiakPK0bSpTCkOrEK8zGVRsHckFSX//EWdL+ipfi1RXXhF/NPP8o1WTA25it6rzguDetTZxSkWAsX7fqZHIHPoUSTKh3YhMQxrQ48tCu/PmKAkjoy29Sz/ljcOrA9BAVIYQeWrHULQ2x3EQJeZ7YrbX3Lb0e3tqk1csemxIEh4CB3mlgvWmw14BrfAmhlOPzKHv0KX8YPx33YsEAIU+XeizsTS4gHVR+DBcz0wzeAZPkIuVETjSkESINbSi0iJMwRizqu6gU24MLYT5YcqRLc9uMIIr3A5vvdSr8u6VQ2ZXna/Hlw8roJ0QSRk8FEfZ8HrYkrzJY08js0Tw5b5LZpeZL7e8BQodoz/WJRZJY/tkz1qPPxtsSC+vJnPc2U50IQXCwyGESZCDr4cwFa9b/BZsM1+x748J/dDcoxN6pcjFkKeRHsDWgrJzG9tqcfapKGcOKRPZDbNML8ScUNtyziUa2n6E+NFIOg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(15650500001)(5660300002)(2906002)(6512007)(53546011)(6506007)(2616005)(31686004)(6666004)(36756003)(478600001)(6486002)(38100700002)(82960400001)(83380400001)(26005)(8936002)(86362001)(8676002)(66476007)(66556008)(316002)(66946007)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F/AUG7ZM9j0goQBSNGIO/mlL0IEdQBU+ouXcoQvxTjXQNcLSqHzrj286BuVP?=
 =?us-ascii?Q?2jD45mDakGAcbx7xozzUOnx9H/HU/o4+6EcXMDRrdnsTndkpGms3JeGI7NLO?=
 =?us-ascii?Q?uhVRHFiSe2kiTxRvy28pQMryy3Q5NvkI+fYt+2obvDfOYKkXU+nOFUOXrlLJ?=
 =?us-ascii?Q?wf7eKdQ5HtP67EXIDI3EoGRTnaUqActX9kXt12CEZJyvVV0KNnF6DeGlzmQF?=
 =?us-ascii?Q?avZV3FQVMv9146D5is7IN8GSGm58ZU2Snda2AyYrYDHrZG4raQlDbJN/nOtj?=
 =?us-ascii?Q?f6dkfP5sGDiuoMFDPPuWx8PAiMEg5dAbVeOzmI9z7/ZlFpaXZzrFonZFriWU?=
 =?us-ascii?Q?iDsr6zIsb/JCTjISVPeypR/QfU0rvcVKCSaQLkE4w2UyY0KCno3Uy773od4r?=
 =?us-ascii?Q?KNSOUhlTaEmRJhf1w0e/+tUOeEGKhySSd7DTBlk/pMeEkj0BcYiA1LR4juqu?=
 =?us-ascii?Q?WjzO4VBTBq1a13WJPit21cfhQI72KoNVsocOdGIfzeCJiJ+Sp50rJxN8Z7g9?=
 =?us-ascii?Q?DRr0RNPapSE0oev4E/1u2Vd2ffv6WhbfFHzS1KcJFSswR2Q8P2eo4XQ6v6ZN?=
 =?us-ascii?Q?PVpcK85iVbl0Icq7QCsim80pOQ2aXU0rZ0zVnt5HRBbZCFZ8FtDuroutFDUN?=
 =?us-ascii?Q?+3JyX0Ylb+z2roY5EX2URsLspXAz80Kr+tQ4fOXKGIz/6feFU5a+5e8hu0Nc?=
 =?us-ascii?Q?Pu2K29tK9ea9WTH757y4v5fx1e7tcmSvkau1oY/wzeev/kAUZ8LHVrkJ7UVX?=
 =?us-ascii?Q?vavsPDhepBdC1CNX9zhrh3lWZSafMH448mHruPN9sjy7PfCePe8LXMjx1Sqx?=
 =?us-ascii?Q?yhYbrymLpA0w9orjvhkQn32h+UiZMJW3IBtrrVIuWRn9s3i6S0aVb5NF4oJT?=
 =?us-ascii?Q?yqAHUpufqHexUWo67AHjoeM8lU3LAZn3EmErwpVm7GoDQbWBh+ZQH2nItI52?=
 =?us-ascii?Q?fFZoJYu3EqIJXPgFhF+T51scZ3Cg0EgpZTsJURyS88xvryfBCl1AYaF/pLZQ?=
 =?us-ascii?Q?iIHug98fdpA5QsAn3E7CSiT0OZ/9sCvgU+k4Aey8ArVp/MSiQ1gUS7Nhbc+n?=
 =?us-ascii?Q?HvK7MkC18h+bZ2U0FXdR0DDI5Ke7RUL4zAEFs/xeRjv506BQ3+GhxCuioyvG?=
 =?us-ascii?Q?Y9yky/ObOu6hZbsHc134ASpsLNwlTBPr5a2o313BwxdG6dVoq1cmVxxU3LdD?=
 =?us-ascii?Q?JvAN7ssDMdtPTH1/qBO6WTn5sMKbmTcVhdVgdE6nWi8p91gL/EY2oPBSHxXZ?=
 =?us-ascii?Q?VoqG2yd4JEYzGnOV2NgF49OP0fVJ55CKY6QWaJfi377W5vifJSJxQLK6WonM?=
 =?us-ascii?Q?gAYwCnzAzDNJFkruD/Nn5GMuercs8J5wzcDoRV0ekYmviMl9H1ANMza0HrHk?=
 =?us-ascii?Q?IUKR2v+oVuNI4Yi/6R5kX113hNYIABOlGNpwJBQWr/PeWjsh4JkTDV9qXfDG?=
 =?us-ascii?Q?7wiC+YmrgjE1C5kOdg6R3ufOMKvsNOEOKKbvXWQ9BQ1mupoFh7JKC+lIJ/Vr?=
 =?us-ascii?Q?QH77esOky7kGhBcxjfTQzhY0ptiQ3s2NoYzhA0UM5Cm/EPVoovYj5ZmSDn7a?=
 =?us-ascii?Q?vi8rmQ3b6jliWyJN81MsznsyYyVyf2vrhXXn/BD9g1yDxqnlt7aUnhEd/KDi?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5ce5bc-4610-43db-5767-08dbfa59e01b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 15:00:12.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRU42DtDLmE0y/p97e4jPA1qAp+QGN/sNTsRivuhKYsqieCRLU4kQACpLzT7E5RfuFDRZWngRzcziHZOSth74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7910
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 15:00:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14032

On 11.12.23 15:13, Gylstorff Quirin wrote:
>=20
>=20
> On 12/11/23 14:46, Jan Kiszka wrote:
>> On 11.12.23 13:19, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This series adds the, possible signed, efibootguard binaries to the
>>> deploy dir
>>> and adds them to swu file and sw-description to update the bootloader.
>>>
>>> The new entry contains following information:
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
name =3D "{efi_boot_loader_file}";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path=
 =3D "EFI/BOOT/{efi_boot_loader_file}";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devi=
ce =3D "{efi_boot_device}";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
system =3D "vfat";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha2=
56 =3D "{efi_boot_loader_file}-sha256";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop=
erties: {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic-install =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> Changes v2:
>>> =C2=A0 - The efibootguard file is only added if the new variable
>>> `SWU_EBG_UPDATE` equals `1`
>>
>> What about only updating EBG, rather than always bundling it with a
>> rootfs & friends?
>>
>=20
> Currently this would require a separate sw-description.
>=20
> I am thinking about rewriting it with using libconf (python3-libconf in
> Debian) to generate the sw-description. This would allow that use case
> and other more easily.

BTW, will this series already work as-is in QEMU? Because the target
partition is not mounted normally. SWUpdate will do that for us, right?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


