Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3068CC48BC3
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 08:53:36 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.55])
 by mx.groups.io with SMTP id smtpd.web11.8931.1708505613115310252
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 00:53:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hqfRV5Ln;
 spf=pass (domain: siemens.com, ip: 40.107.15.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2WhRn9CfFC+vUUQm5KHkr5bZxJONGxonfSEGFhu/G65E5cYYp+WlmLKnlu/wODP6qRg4elO+HmFh8EkX5mT873aXHaCc+zT/9Tx8u3EfZuipzh4Vk2otjwVrtredQ4iKN25P+IJjofmWiom2+i2S1EUCJL0igI038Vyyr/pkGsxla4nFqhQGFjbhuRwL2mG4dpc8iGIYxzXAWzlcf3nGM6T/JWzFLc9oseHQkwkTGmNa2uONyMDQa2TFwp9Vh2Xz4nOPpH+htV/LWayYuufGpcQzf2qNVfF2IcTuetLD1KrCkQhcnFiM3+qlsfnoF1p+j+agw939U0lGqEUO9qBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLM/5mK/7y5qdYVws0WbIeDNYKn1IK/JNhbixy08QDw=;
 b=X9foRECSz8osKPvCLKB6otsxUdYKHXTdUUsNN4rXsuBVzZTf3FH/EIeTRZfyBjTodCqUReXg2zm1YaPJwi7PUfRb09PM+B5+9oVmlRdmykQomSE+xGDaEDNJRNh6YFRBppH/j97AXGiEcrqiOxiRZIPdN+lopu0T8RpzVaYzlDNV/mn215dkQK/BIyEhgcRLFSUuT+0LwdJyK+R2TNxxe3fz+cUP8tD7OsUnqN5cAU+vadMxq7nmKQEglS4RJJHb/njUtv7S++i9O5LaADLN2x9HeyewBllpg73dGi/hSBqswJgJ9yAlD6IzK+CtzvLVIVAqrcVmZrVQdg9CmMiz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLM/5mK/7y5qdYVws0WbIeDNYKn1IK/JNhbixy08QDw=;
 b=hqfRV5Lnjg059JsOTJCBFvFLDn6JWB46ap70bva0qTwl5utuEIEe+/OxUjwJA9JSgeg55WCknQ4qrQ9ZwolOm+i05WSCLm24JhDROoM+oOtyrruvGrZY/1oY6vr1Dn90NPRuRAo9p4MH8FPjw9Hf7Q6f68/DNAV3Uh8GVF6zR19/4pA6msDwQFCLv8AdLzBKphQGLVLm0FgkXdeXXIArX+4ImMsDi7y+vKkBxM1B2mv+925xn77il8v7AxrU5iwzClXdSnET4yK3w0XpFqf/BKo2OjI69QYIToCnlkRAKttPzrDTUL4qJNhKfcCvpfOAwa4ZHwLuWVRmLei8OqbzQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Wed, 21 Feb
 2024 08:53:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 08:53:30 +0000
Message-ID: <10f157f7-4b0e-4900-a7c3-2ef1f08c5c8e@siemens.com>
Date: Wed, 21 Feb 2024 09:53:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 2/3] swupdate.bbclass: Add
 SWU_EXTEND_SW_DESCRIPTION
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-3-Quirin.Gylstorff@siemens.com>
 <217b7c161aa3a608ff107d5f2661d384722a259f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <217b7c161aa3a608ff107d5f2661d384722a259f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b650e08-db45-43e6-3abe-08dc32ba93b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tA9yXAtLJOddtTUVTOX5nEqUGsYsWsKb27MTpBl2vL45vCaqdWdMDDL+GgVYKpHlZBwgnHd0iwuH7aDKPdOWRJGDixLk+u6P4kGMq9jsNVsNajcc6FhxUjiee2bd0/igt/Ttqn2yZAAaMs0r54ir6JA/LEO28+UDKZ2mB2RkfmK4+kOBWx1/O5M/45X7g8Yph+X1zESmF78i2rjPBn2z+R4sjaBxk4duccn+tO7SSFyHFgi30Qbk63QfIRIVzDX/zqPBheYXY0I7NW71HBlQZUwBehci83rjUl/D6VvB1PxxQyN9367b9wQn3GwoZr44rerKCo+ji3Y7kRwU3TLJml7tYXsGlqDi7/D5Lu7xjh2a5q9/fqHexicfyiWmvxJM0bBCy6ndzqdA9oDTpJVv5lDnj5T3jV/xwq5s7/kDo0w+INw0KISWNTC579jT45wsRpwRz9pVzeUTVo5mWJGcYWodNVmNQXJ5+8mXiaMdCfv7MBRVfJ9uobATUWnIN3pra/R6zcMga5qqjVFqg4vavfAuWfN7tDTOAuxDJ+hC5x0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4aFImekJ0IgiEBwBT+7TSHp5F08338z+/JtDJig8cEz1v+++Kh2T2WCXpbC3?=
 =?us-ascii?Q?VWG94qAmUVQEKDFOCw3ttm9FZY50651M/nyqfqiWLK5gDvtjVDcx2q3U1brx?=
 =?us-ascii?Q?6KtvLFvbwLozhV7kAbTMFhnicJQgSJF2DcyHErKkXw/XDJ/bQAOzB+xEyzk0?=
 =?us-ascii?Q?pMo0JOpbwojuvrPSFuoMJ56g/mU8D//vDmwB20Ha7PVLjz2zR+cv50WpmAmC?=
 =?us-ascii?Q?uq/ZEp3wWWL370u7TSXYZSQEjzUyieboqN3aJjh1o8XloV9AKsStUrowjZqV?=
 =?us-ascii?Q?0CJaQKrGmjYKEaaKA2PzNpqrZflanAumYApSiL2fGBws7gDOrR4Lp6jz/vKd?=
 =?us-ascii?Q?4CosvhOnKtKuL2QJNtUuibMPqAToDRuP4yqo6DHV0grGu4G7SgXskpv72zL3?=
 =?us-ascii?Q?xu1GkfDzSBhkBS6I9Djzfc9sx6Kd2akhdcFYwfjTUjrG48wXITjo2EjT4Uwo?=
 =?us-ascii?Q?qMibQke/JlU+rF87JRWFiLdvKYa+1+z+n+T3h2ZrYi3DsmtQe/IXCijPdhf2?=
 =?us-ascii?Q?Hd2mnz5uvl3ckJ3S+Hw2otflPMofKBkq2fqo92oHtvGhPmhVF0bGpgKRmA2a?=
 =?us-ascii?Q?DC9po5oNTyPlwO2saW5txHNUJDnJEpKecgN5GHia74XyPZYxMGUpoegUym42?=
 =?us-ascii?Q?XfHibtX+nASKTrnd0voBfOx81ILblL8GA4XAKuVd8uIJa7Y55KcPXtxYGqIF?=
 =?us-ascii?Q?iG4q2qs2dQ+pT4efB9m+3M/oiuH/nuUqfxkJt2NTVIldXbDO5xg0iKeth18w?=
 =?us-ascii?Q?kqOp3eaZqgHtqGRskkDEbX2OmTwfXnMsSFbrOUi460ch9lZqlsoFKaS7ydJd?=
 =?us-ascii?Q?W7E8E8qAg3PJDPDHgoQZBxOfstdajy7rSKRYZ9q93bI4BElG74DxvzJAhCvY?=
 =?us-ascii?Q?9lHQDcwFAkAh/NjAMDpysH/lXb/n8gGLSVEXPQ8VQbvPAfLi+6FF8v7FuvPl?=
 =?us-ascii?Q?N2EC96wiecB9ZERXT7zOkkm6jyJ1Yhtpd36OPWaBXCkNNHKfzMOVce08dgIn?=
 =?us-ascii?Q?DXe/kt5O2wDNkjuNRkMwFs4swuP29GWGiUPOKBlRTw/FF4sgCyfRAq7e7HNA?=
 =?us-ascii?Q?2EAAowcBtBz/3m1tywR2BIYLD2kl9jb3J6EBxPkEe/SlDCiDMopFFlUCY6T4?=
 =?us-ascii?Q?JLEtwp/NAfHqfgThQRwLl5Iay7QjLeanh4BKhweF//rwhZx8OzYh5xF/uZJW?=
 =?us-ascii?Q?GbicQ4EVsZ9FKcNxwxqVTo95Z1nz2eSccoB/tZ97b1+l5L0S9+z4T+SOmDzu?=
 =?us-ascii?Q?TCYzdKcI5WnU6co0BI4ucHEz+7brnxeoSMWLqE8VGjH9irm4ABJqLFmEL9Q+?=
 =?us-ascii?Q?F16UJZqoHVaN8y3/zK4rpTSPDau1NB5mYFy0rpTbHDqGe/nGniRk1qD9JHSZ?=
 =?us-ascii?Q?Hm5gu646zpGwQFgTiOYKg4arGvM9m0m0t3EAH0kRM+uOmQiybKclTmPIHbhA?=
 =?us-ascii?Q?2tPTUSdTMszf5ulVEiwXzXUrWzH4+xFOUDz+g2/x67eMoL91GadUVPk/2nJ3?=
 =?us-ascii?Q?C46DdGcD/Kq/2oYEe+Kj1eUfWTp/1hBpbxm7MqLxt/h5BDaZ1NwEEdaY2zc9?=
 =?us-ascii?Q?4oSsFgzK70B+IIqk8ZIAWt6l+iS/L7nRAcGmuEhWj7Q6HZ7cFtKlbAAirgBx?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b650e08-db45-43e6-3abe-08dc32ba93b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:53:30.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3/kqhHeS7jLQTV2glDQrV38fLxd2JCciu48FcDybxNBODlmgtll/0VwySMSXWQZyQ3uO1+cItALAsIsjD1glw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7066
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 08:53:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15044

On 21.02.24 09:22, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2023-12-11 at 13:19 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The elements of the new variable are called as functions. This
>> allows the user to extend the sw-description file with new template
>> variables and new entries.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> =C2=A0classes/swupdate.bbclass | 14 ++++++++++++++
>> =C2=A01 file changed, 14 insertions(+)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 117f9fe..0e95e3c 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -22,6 +22,7 @@ SWU_NAME ?=3D "cip software update"
>> =C2=A0# space separated list of supported hw. Leave empty to leave out
>> =C2=A0SWU_HW_COMPAT ?=3D ""
>> =C2=A0
>> +
>> =C2=A0SWU_IMAGE_FILE ?=3D "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>> =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>> =C2=A0SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
>> @@ -53,6 +54,16 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>> =C2=A0addtask do_transform_template after do_generate_image_uuid
>> =C2=A0
>> =C2=A0python(){
>> +=C2=A0=C2=A0=C2=A0 cmds =3D d.getVar("SWU_EXTEND_SW_DESCRIPTION")
>> +=C2=A0=C2=A0=C2=A0 if cmds is None or not cmds.strip():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>> +=C2=A0=C2=A0=C2=A0 cmds =3D cmds.split()
>> +=C2=A0=C2=A0=C2=A0 for cmd in cmds:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.build.exec_func(cmd, d)
>> +}
>=20
> Hi,
>=20
> this function is completely off. As the swupdate.bbclass is
> automatically injected into each image, this function will run in EVERY
> image that is reachable at parsing time, during parsing. Please move
> this to a task.

This is ugly, but under which conditions is this breaking the build or
causing other serious effects?

>=20
> @Jan: This is a bug that needs to be fixed in a point release.
>=20

We don't do point releases in isar-cip-core yet, and I first need to
understand the severity of this issue.

> In general, in the image-type classes, no anonymous functions should be
> executed.
>=20

Yeah, that's likely better.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


