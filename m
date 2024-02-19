Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF0AC48BF8
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 11:36:01 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.84])
 by mx.groups.io with SMTP id smtpd.web11.39537.1708342559127323093
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 03:35:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ky6C6mXw;
 spf=pass (domain: siemens.com, ip: 40.107.8.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agdDQF6nuaBQyWPHwCRdGhTjP22IpIAnD/6xMRKugWM8J9ybbA14G6y39idUwlRb2Qi25wXo/QQB28tf+uGaZf/M3V43Pb96W8CdAo3Z4TbE2s8lxQmYteNoNhvJeLq1M1An3AxOSiB8lKSuC4ojH1y21FUUPqrYcaIoZKUzO7tV79zyE/34sj0DlR8M4QLAAPY8W5qvHLgMw3MN6o6nhEGudSW2BzRPq+hPoCROXfMyt25exUtDlf7NM8CbpplV/HxSqZtK/84pWDULOjsJ/cjafTcUrepz/A9OLsSSY0CklaIQrfJrYZ+Ioz+7vnlyFA/PcNOTLyE1YfDbV/KeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKnCK10dTu/6L/O4z4j9qycFIafXerga4wAJsHgZyXo=;
 b=H3yzGEiYfv2tdB8g77xI74kzxjHTn96AeQvOY5WTpjF8Gh+1VJl74z/wEcFL59Y3THcszqm6yzboHOQk6wFLFnb+FYiXcju7chA0BcKhe3e/uca/A3Q8WCmmvY5pNo6Gw6XOKM69VeCRrLmlPNq4TbNhtNOarCBYCM6cQ4sQPqRVhGnethCT2ixp8vAWRvPBZiE09AUTRkYFFxdsilynhEk3hh80YppZZFZY8LjcYYcliTSNJ74duP2yXoqrGJvsDvor87mg5vKck7eTX28taPXlW2bfKTh67qCISAPhion7dZR6rXzifT58K49G/6Ry3Ko/V7qeZHd3IjT0rb1g2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKnCK10dTu/6L/O4z4j9qycFIafXerga4wAJsHgZyXo=;
 b=ky6C6mXwh3iGNFFHyewcL2NyEZ3DR+zn1wjQSZA/lIbSqwA6TxfTWUwjc54Wtcy5qoTMGOUs8cRMswhyGiCWuwBO+MGHLsk3YWvGTqQ6WqjaA8AgMd6mXTSB6b5D2/zyAfXzB6pZbls4G1mKae9W/ALGW5+gvwkY6Bu9Q1fHt7R/XQMzXLh396lXkXDhPpZFynveWWt1hy3aTR2Z3i8X8NLZhwMDuZPDBGo4lWjja16kFJopdRLB2cYuSWyC9xkj9+mQdGiPh/oivzPBej7jp3M0qcGWj1P+plP455wmy5KWVBmsp1kw9oeyYkmboNdaCy0VtYdzTgD3dF/8fo92qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Mon, 19 Feb
 2024 11:35:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 11:35:55 +0000
Message-ID: <bcc53135-b08a-4b2a-8d4f-933d7b92228a@siemens.com>
Date: Mon, 19 Feb 2024 12:35:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 1/2] copy and symlink dpkg db to ro-rootfs
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "shivanand.kunijadar@toshiba-tsip.com"
 <shivanand.kunijadar@toshiba-tsip.com>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "isar-users@googlegroups.com" <isar-users@googlegroups.com>
References: <20240130115648.311177-1-felix.moessbauer@siemens.com>
 <20240130115648.311177-2-felix.moessbauer@siemens.com>
 <29de90aa-1a30-4f17-9538-e6a2334bc343@siemens.com>
 <cd3b8b6b9d762cda263489202a5c16ecbb3fe68a.camel@siemens.com>
 <464bd7dc-85a8-4fd5-8452-256c02f60ff4@siemens.com>
 <aa3c14c1ba63829ed2ca07a600777498b0e7e1c7.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <aa3c14c1ba63829ed2ca07a600777498b0e7e1c7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e352b3-ccb7-41c4-223c-08dc313eef5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UOFuKfRMX9sfYOvc5iD7hS7ozPNtdvCwRZxnSmczHnI9QisL9rCV36Kr2iCMqJDr+Z47QbJlZ+bK3E1IJFV0wj/H/6bb+leCo7QYwZrCQz+AFUHxW0ILIJDPyM//N8OdIyD+YRQZg4XLGB0iBwpHsnNPacDunt/ToFrvGoH/1dzZ02l299uIGSCS9mST1eeIkf2y7gQKo3RE1sa+GUFwRBu7rnTVWKfSUjThfep3ewUTkl3HB+1mV+KShyPA2A+rYGOcb3wxSsoxDDtZhx77NSP9gnaE4S8qtYNbNOLcm/4Uz5UqsF1UwHQXCsyhcv6ZkGW7PJ0OrFuExNbPLpuxuJTfsZXwHKlzpCx5KbKvljCHkhF40g2R1h5JRGB/DXXg6eUswWgYWmsGSBMh+gQr9Zud34VTACv4a5NjYEDXoo45STj++9L6ieeLcCAWzF+MaMXvPMk316LAOGwHDBx/eyCcBSOer6e4hY/fhFEznvV5FtxUn+jlf3AnN28u4q7BpEuMLYHIjF9/dB2ovAgEMA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YigfmEEV5k5JLVC6AiI34eM+/zuM4Bqz3ryen6VdeNKOWGeEH4oYdG2U9skY?=
 =?us-ascii?Q?D8ttWPgNjFfdGD0gLpz/ZUU3TWKPnf0Wacu+pQkeJZyxzI+pTLE/YOD9K0F/?=
 =?us-ascii?Q?4PqRuk3DPYja9epW76EdS21gw9e/h4osH8rU0Mg7PTZFf9jlEdQT4KZvQZIm?=
 =?us-ascii?Q?HcMY3paewXb+N9xZxPmzMoushRN/njzXKJVBhPxyjoNxxqFn0KL9/oLFkfq5?=
 =?us-ascii?Q?3e1TO/WdDizeju8rmW2bYAIVX1ZFwUilyOpUVwR435ar8t8aHlFcE4y5/yuW?=
 =?us-ascii?Q?UjqXpFo3R6r/lMLLYeWjGhw1AjMkq3aeCmRUl7rP7JVUsvzqqInIFNPRfviP?=
 =?us-ascii?Q?Mcj4XPvPzSWV5TMBdcfiyHs3S55w3O0AaA0WYjrRPZFJ8hi2QmZdcz4vdiTe?=
 =?us-ascii?Q?7S8W68hpCUDKZ5e3n5fNTuZlinZfrtULJLqtncG13T0/oRgvvBfyHtjUpFNq?=
 =?us-ascii?Q?aAZUp+cKHLgmJGARvq6haNPAQY/h1Ek+7fexNgPfDoy3XsKkgqKWwokl7q3k?=
 =?us-ascii?Q?jz4LAdQnkiXfFkzDWFvvb6REhkCIbV+/aAWXm5Ax2QRMWNbLqEsKb84v5eB5?=
 =?us-ascii?Q?Kwdvd4Hq/gapwu1M9PH0tdMVo3IoG4PM+kUvznI/1Hbie5urK3M+pQnweE6A?=
 =?us-ascii?Q?59z9kt0fZNzJ6j8iFjMZW0vw/D0fTqG0Evw1XMOtXwYTpYTzrmVZrbUttkuU?=
 =?us-ascii?Q?HDaRNQ3603wEnx/lgJRDy2hSM8BZUkJOviIfEeLKBvDPYubM8FXvPEBdqV0q?=
 =?us-ascii?Q?z1Oh6LF9yav3fv6cpQuQlkXNBC3bquTmCLT1KGxjl0rzX45ju7jgSgsldwg0?=
 =?us-ascii?Q?HfpawXMksfapobHXd6a3Nc0WNDcU2nRK/RVDssa2Q4SIc+A9VDcPDRfCPA9G?=
 =?us-ascii?Q?hcXun6r4VMafRTDrZvX5efPGeiMBHUopgCW2CpM7NaKnKPcISBC/x3DvH6Di?=
 =?us-ascii?Q?ZXQ2gpHZyA3MjUg0AvrJ4CMHYpDfuXWjUDce1lLAf+yUE2RwXQXDd2mdYNLH?=
 =?us-ascii?Q?s7s7rE4MF3+eow0CjGAzuGCyEOT0vLkS8/ZOZQgefOZDbzPsDWbWDeWVpjj5?=
 =?us-ascii?Q?nGOu7MBd38c9sJJRFgSMc/hvqu1HXkN2QNfd//7RWlmbKGqy3ywDaitdq4yk?=
 =?us-ascii?Q?9CBkr7LGf368EjSFG8CQtUXErOx8sH6izYm5J+h6c/i0T141tTXZL3cdFQMm?=
 =?us-ascii?Q?EmqgxP4CIwtxhRXj6u7EJ1oqLKOUyoHxp4vWuBNLO8cf+34qQ7pCPQHqRegx?=
 =?us-ascii?Q?FMMY7DWx7ZuQu1YmEXIb8a2eF1KD/WhZN6hFSfRXDoBe0tszgrzgaZKQte0e?=
 =?us-ascii?Q?Cmwghm7vpjHbZDNK5R8t+roQr6dQYEzxyfRdNqmg6IWSpH5EthyHtBPbXiBX?=
 =?us-ascii?Q?JSDUfMM7Hh92QS4NVrBzgqBQkpu+MpDRK23EOFjkNHAoHoSJO4WlslCrF9ZO?=
 =?us-ascii?Q?1oEReQCrthOlEEoEpLd/WBB9qfQHlUeF3+vb0UUQXxdZmD0qV77/DuBS/36r?=
 =?us-ascii?Q?Gk9pzkX8LyiCdgQk2cgSSGcURTTfvP27qSCpsTC5eUo1ppyYh/VF/gf+lYSr?=
 =?us-ascii?Q?QZPZrNUILuH7RINp7HQKrtxediaciWIBYmyH4kTbGG3oaQwcOwEqZ/XB5ASx?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e352b3-ccb7-41c4-223c-08dc313eef5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 11:35:55.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ou4P+5pnQGCrBDh1ftQtpldgjVyjpu2bYbA9eOmdGK3a28/gVFU+R6bBYholTXik3U0M2YQyEP4soNfdMA5Skw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 11:36:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15031

On 19.02.24 12:19, Moessbauer, Felix (T CED OES-DE) wrote:
> On Tue, 2024-02-13 at 11:33 +0100, Jan Kiszka wrote:
>>>>> =C2=A0image_configure_fstab() {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>>>>> =C2=A0# Begin /etc/fstab
>>>>> diff --git a/recipes-core/cip-read-only-rootfs/cip-read-only-
>>>>> rootfs_0.1.bb b/recipes-core/cip-read-only-rootfs/cip-read-
>>>>> only-
>>>>> rootfs_0.1.bb
>>>>> new file mode 100644
>>>>> index 0000000..76453ab
>>>>> --- /dev/null
>>>>> +++ b/recipes-core/cip-read-only-rootfs/cip-read-only-
>>>>> rootfs_0.1.bb
>>>>> @@ -0,0 +1,26 @@
>>>>> +#
>>>>> +# CIP Core, generic profile
>>>>> +#
>>>>> +# Copyright (c) Siemens AG, 2024
>>>>> +#
>>>>> +# Authors:
>>>>> +#=C2=A0 Felix Moessbauer <felix.moessbauer@siemens.com>
>>>>> +#
>>>>> +# SPDX-License-Identifier: MIT
>>>>> +
>>>>> +# Note: This requires debhelper-compat 13, which limits it to
>>>>> bookworm
>>>>> +
>>>>> +inherit dpkg
>>>>> +
>>>>> +SRC_URI =3D " \
>>>>> +=C2=A0=C2=A0=C2=A0 file://${BPN}.tmpfiles \
>>>>> +=C2=A0=C2=A0=C2=A0 file://control"
>>>>> +
>>>>> +do_prepare_build[cleandirs] +=3D "${S}/debian"
>>>>> +do_prepare_build() {
>>>>> +=C2=A0=C2=A0=C2=A0 deb_debianize
>>>>> +=C2=A0=C2=A0=C2=A0 rm -f ${S}/debian/compat
>>>>> +=C2=A0=C2=A0=C2=A0 cp ${WORKDIR}/control \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${WORKDIR}/${BPN}.tmpfiles \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${S}/debian/
>>>>
>>>> dpkg-raw wouldn't have simplified this? I think even compat is
>>>> not
>>>> customizable.
>>>
>>> DPKG raw in general is only useful for a trivial copy of files into
>>> the
>>> rootfs. Here, we need the debhelper logic to process the
>>> tmpfiles.d.
>>> Also, we need to update the compat mode so that these debhelpers
>>> become
>>> active. I don't see any value in mixing this with dpkg-raw, as most
>>> parts would need to be written manually anyways.
>>>
>>
>> With [1] (granted, not yet upstream), this would simply be
>=20
> This is already merged into ISAR-next (as f1b8679), but as we only
> reference ISAR-master in CIP, we need to wait for that to get
> integrated there as well. I can prepare everything, but still we need
> to wait for the ISAR update.

We don't have a master-only rule in isar-cip-core /wrt isar because isar
is not rebasing next (unlike many other projects).

Jan

>=20
> Putting the ISAR list in CC.
>=20
> Felix
>=20
>=20
>>
>> inherit dpkg-raw
>>
>> DPKG_ARCH =3D "all"
>>
>> SRC_URI =3D "file://${BPN}.tmpfiles"
>>
>> do_install() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cp ${WORKDIR}/${BPN}.tmp=
files ${S}/debian/
>> }
>>
>>
>> The whole control file would become obsolete.
>>
>> Jan
>>
>> [1]
>> https://groups.google.com/d/msgid/isar-users/20240201101236.3555681-1-Qu=
irin.Gylstorff%40siemens.com
>>
>=20

--=20
Siemens AG, Technology
Linux Expert Center


