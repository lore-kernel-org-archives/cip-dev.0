Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC9C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 08:28:30 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.59])
 by mx.groups.io with SMTP id smtpd.web11.10263.1715675303795349206
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 May 2024 01:28:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bYGID+r6;
 spf=pass (domain: siemens.com, ip: 40.107.14.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqlqZRj4vKpK3WTJgGl1WdsjYWZwFHBk2nc1CQezDK5CgH6WyDz80dbTLR+78APeaymyZmJfXEndPK8MaEazpa120zJRAEPI8xjv3n/6eeqLaUaQmPNk3IzScbSd3ox+KL71WdUZYahEw+c11i3dkQK2XyIEY/VJyepPgSrb0OJqFTpfHgwo0nR2RoCdSjJQh56OV+51EsSda28xRDow1wuPQDwHz5rCbwpowdMRzBsWn5ZapCBfpR7EYfl4q+GImIg9slwdM/N08/3FYuxyL2I7TJ5kGazi3ddQouLPfrQYhJ8BL+jAPFTSGL9TdvMv4lnfZHDgB4+AJCX8tJZ0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7Qfy3A5F94Ll6F8SW7Kj1EZDoq9H1dieJNDsKDTDts=;
 b=m/KmBqZMjch5EJAj5pPVjwAZF70gSCnR8gvdtYaSxvz31qB8/xLB4YDoaTcTtG8k8cLpfL0Q1utDRjq+sQVvIeBooZ42pRhJJd6h/BBMP0YM2nzHKfzq9DYxp1Yp1kx6ebl5HEX/Z5Y2usZZxLHT1wLF9l4pBWNkBt9LueNi6Bgn+dmALcKl/nip6/92bw8ngNYWdSY9IfYsMwGbCZcOaDlO2GE2HQLLDiBkhzO49qAoWyg4VuCD90O7pJR6qt5H8Hmm14tV0ZGQMVaSWG+tFMnrveeiboW3iEjCBAF46LPh8e6UTe1zPt2q14aiatYx18X74K2ihSEz0MHt3jZg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Qfy3A5F94Ll6F8SW7Kj1EZDoq9H1dieJNDsKDTDts=;
 b=bYGID+r6R+B5jAMT6kop2fwJDkRP3rMnKJrnDp5K8DTtOlG5PAxLiuSDFt72eVbK0P2E6lXFLFaR2QqMV1GnyYfQBVJjcaf0CKtIFSV6opWDKtRq3QHAteE4A54HZiv4hWrZSu6Tij5Af+PXxhtc4hSkJEuLXldgVaaK9B9F8YOU9ohY2zctydWUZ6obHRnT640h/AtKqc8YnJLAKoX/4figK1iGtg8p4uunx8ewQ40KkmrOr8rcpXuKjl+1zSsHpVQ+H+UKz6OTsomHB263noBzps/7DYQzsZ25uy7/xXUKqv6Hmcfc0IUKJzKwWArOgr19M+2+gBs6JE5bIpmfAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA2PR10MB8912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:28:20 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:28:20 +0000
Message-ID: <31ac4186-abf1-4e9c-ae71-63de8bd99013@siemens.com>
Date: Tue, 14 May 2024 10:28:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Generic x86 kernel configration
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 jan.kiszka@siemens.com, Chris.Paterson2@renesas.com,
 schilling.benjamin@siemens.com, dinesh.kumar@toshiba-tsip.com,
 iwamatsu@nigauri.org
References: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
 <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <078e13fd-59cc-4955-be45-9ad5906eaf29@siemens.com>
 <AM9PR10MB4085D362B7DC095E040E755F81E52@AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM>
 <TY3PR01MB11075F2400D6FB592B37DE2A5C7E62@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TY3PR01MB11075F2400D6FB592B37DE2A5C7E62@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA2PR10MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 325dc797-f04c-424d-32c4-08dc73efd006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GGFHkJCRhcGDfEC6xd5cn0caioorVsCb15tdMA5wPq/i1Bt7HKg2M7KbhTCB?=
 =?us-ascii?Q?pwmgW38Vs3duqQ4+z+DrjT2QkAXi9PGgMkUHuKmivULVAvMHRBCXhyMwX9eq?=
 =?us-ascii?Q?luehtTzNYGXvv5E2V1rp7/uHy/aTGFVHn5O9UIQdhDO+V1nwO3Je4QMUhRZK?=
 =?us-ascii?Q?XBosjleBXuSsxAOarf/HCjvsLK7zjITUFoUSZ9MvuGYYpD5QhOTXbEGga16l?=
 =?us-ascii?Q?GSOU4ckNfqHgMpFh8+6sfVLLRqfzCUVdPDm5AXY9hHR4I24KGQAF9ZIXaFoM?=
 =?us-ascii?Q?LB3Ut3eIYJ01FrdNGLwcCicGxYA7eSKpQl1orxd7w/nJS+MiBReueEFzR9Cp?=
 =?us-ascii?Q?4Jl8EeGIgZCHZ763amcsMJYPMBjuGoYda/gUE6bpjvBtHwYMgJxVxEqOGJRd?=
 =?us-ascii?Q?Hx7Klrf5D3UK/KTT+RDN5ldeAQVNw0WyRBInmoTczf9R2fmgTc3AlSRVfV+4?=
 =?us-ascii?Q?Qt9HyKx6s5h1eMdZp9oKG4nYjWcsGZxgEhAJJov50P49CwS96dcQFRtDwZak?=
 =?us-ascii?Q?IzOHI2ECa4I18CcZ+O3+i5t7S02VIaHQJWQJjbgKbqAkk+5S735L0kAg9Ztr?=
 =?us-ascii?Q?jFCBhVSWQEkQH6nFI7QDt96+AiJ4EGKNMhVRcsz3345D2u5BJWfddZbx9JhV?=
 =?us-ascii?Q?VUqgZQWkREPzTPIRCCSFVoluUvpamEdyx+ppK4I58f2BGBUNL2+Bm/qtJZJ8?=
 =?us-ascii?Q?7dpZvaIGhpUN96jTC1IACTSt/oTHMIQIRc8YaZXCOB6zD8dtLWljV4rSMhn1?=
 =?us-ascii?Q?QMV4zFGbCk3fYkuIhRdmZ/FPek3VWDCPu7+L46KJ6WbpR2+wj9blrxTGMRJl?=
 =?us-ascii?Q?IFjvNxDJMMjvyo74bSXswFpbyJ3XWg8VCPiLNoR1GPynLGBw6DBYGhC0AM5M?=
 =?us-ascii?Q?oIhT9NTyN//plKMCeOwsF9MjGwrqoJQ9JOoF/srkQdzQGBHfo0e2sob0dJPH?=
 =?us-ascii?Q?r95P2foKTxYVvzRfV5vnd1VW/CgZm+MQzA8t7zde29o19Ts6kkUhvEMjgjW5?=
 =?us-ascii?Q?fUhSoOSZKquokKdL6PTih7mrLXcWaUuL5JJPHGwz/gaVeSAUpmkcBe1bER3o?=
 =?us-ascii?Q?DAzdp0r87tpe/7NYE4UCfDmWSqqrgR8cqAJuQmXjBTo1sWZJ5voJU9wwFgyP?=
 =?us-ascii?Q?S0na957gl0vGezta5g8tOvkbsp6jVc4vkMsktBFUDMKOGRaInJBKZyMVpOy+?=
 =?us-ascii?Q?lx+M+xYM42KMB6F4Gn78f+pCbeQM/HdJVB00UeNdsA86zexMnQETWPW9brA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CkcsXpb7+ZmNFrZSC0afsArw576sHeh+oA+AR3ZbURlRmO8ZJaGCVvQG/4Qh?=
 =?us-ascii?Q?RC417SL7DZQ5YIEg2WSMLePAv5eMhogmt4UBPM4InTuscT98relWo3JJUqYV?=
 =?us-ascii?Q?voKXcK8NgNRaV1oj25kyLtoXmGQGHuwX3pVwVHLQ6b/Dcii39Yo6CLytM/UD?=
 =?us-ascii?Q?gsOMicnZIzmxmLA9guGRyANMYKzNIYZiwVkmgdoOESir5wmYOTH7NvibdXsl?=
 =?us-ascii?Q?7l9CUARS+2C6EuFT+haLO5POJeT+7B9JlyBx9cNaU72uIUypLK1aeIMgRPUd?=
 =?us-ascii?Q?WQtE4GjYtDidZnmqY3pS7D/GSwcjKmjEZX0lxgcJYyvgczBeITHGFTd1dfuM?=
 =?us-ascii?Q?bmNEBSzf37r6K0tqagwAGmUNxh1aNsxOzKEkmm0X5Z7D/Q/D8YO+FRA3Z4xN?=
 =?us-ascii?Q?mMrJnFp8p1HTCcwjk0iHI7kqXgXIcRF26x63CvLOEIqBPbX8JrqMTpwUoi4W?=
 =?us-ascii?Q?NdZn25Njn0ulBMuuZ1R6IHcmiNtTqGk39pdOHQ4enpX5tmhYvNpx36IkWEzY?=
 =?us-ascii?Q?Fhc3JtmfPlS3mnjCXFUJVTrpgKzUAbKalXXdVBBuuRS1Mobg/3eafxmkcD7h?=
 =?us-ascii?Q?JYaa6tUbKghddVANToo3YsSb7INgYos0c+JSbo7wzLJKpPqQse+ynUR2Teqb?=
 =?us-ascii?Q?5uCpaF4GjitlG+pz4AdSqj7lMF0jXGJM52HzPk7NJa04OCrFkSQg83KC0B3A?=
 =?us-ascii?Q?Ma0SmL7vocPhB8hyqK/MV3jMEDCJGYl1awQEHmCBdXWEPVq/EQEixMu2IoGG?=
 =?us-ascii?Q?3E/BMw+ru+PZLpkwhP/FlAmaDVgqvAjraOh0ua3e/Tqysr6QRsuwQwNSWwuG?=
 =?us-ascii?Q?HGiauSIMUXAUhZynfpDuUBpNQ4kZ7nMxQKOtETvBZ2QAZVuyBsku+OgWK7C8?=
 =?us-ascii?Q?F/Fg2CknP7s6zvDdhbfmQivC8Ux6+7dXSPh/2dAsAc7PhKoCPkrB4DGGJc9m?=
 =?us-ascii?Q?MZd8LwgFgUa6x3dAfx/1IRxzVP8UhRA64whHQHq9qulfi2+Z3CjigjU9xVD/?=
 =?us-ascii?Q?ZTeEe3Ek823sPcbM3VRDDBjgIATfiqUg7uycn7SBwX4mAIvFRaGTCNi/QwOU?=
 =?us-ascii?Q?qNOp9Y2OBfKsp8x5KXcfXhu3wErbk0qqk3W83dpK0XCzgqAhTRgmlixkDlcV?=
 =?us-ascii?Q?qzPaZ2km+dDsn9I45eBZc0a9Uj/HJZWanyJXrJq3SL3vq8Zh4IFK+1Q8TFm0?=
 =?us-ascii?Q?PgAQl0ywCtM+1J/qp40oKE0R0aDk/42kqFr7yDgSCOGNTBU97fLiQXv73r5l?=
 =?us-ascii?Q?9bPCeFjPMDjlxslafgXQz5w/jDmT0tLC6Ch38s06fQTTvWvj1kJ/Sp8NVv9E?=
 =?us-ascii?Q?ify6KK5Xg+nkQyXahgkpvcYJ2Sdr1AFqjv4A8ZZ6RvbX7iOoT3l+VOJeSiey?=
 =?us-ascii?Q?C0Owaplcu5TxIDLtObRzVXFJSd/UyE6Xqf4rCeQ8tGyiDNc30OzkdSL8m6KN?=
 =?us-ascii?Q?0lqOyRq3Tmm5t5NCCzC+kOF1GzMoH3++3dm8R7BUQSy9t0D7H7aZjgsTx6N7?=
 =?us-ascii?Q?3uIgZlCJWcRR4r+dduvEm4ZxgFaVmoDQV1ZYXd1HE7N8rJzqbTgZk7GRnD5O?=
 =?us-ascii?Q?oQXUETUSm21bFGwXFATYmTc0ecYGOATq1z4S9jJgC02rFLkR/avwDOCVNY+H?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325dc797-f04c-424d-32c4-08dc73efd006
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:28:20.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNMvM8U2Hmj6Hg08Kya0le9nczeQ3OKi4s1yBAVqSRTy+Rv/uANxSpzN7eh6P1FLITljQxTrXXooAEdvOzjFgfl9tzPRFbZSPiLsGQ8GSLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8912
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 May 2024 08:28:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15889

Hi,

On 5/9/24 10:54 AM, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Quirin, Chris
>=20
> @Quirin Gylstorff <mailto:quirin.gylstorff@siemens.com> Thank you for=20
> creating a branch to test generic kernel configs for x86.
>=20
> I checked out your branch =E2=80=9Cqg/merge_kernel_configs=E2=80=9D and c=
reated image=20
> for qemu-amd64.
>=20
> Locally I also tried to boot the image but it failed with below message.
>=20
> Booting from ROM...
>=20
> This kernel requires the following features not present on the CPU:
>=20
> movbe
>=20
The error was introduced with the toshiba_atom_baytrail_cip_defconfig.

Best regards
Quirin

> Unable to boot - please use a kernel appropriate for your CPU.
>=20
> Thanks & Regards
>=20
> Shivanand K
>=20
> *From:*cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> *On=
=20
> Behalf Of *Quirin Gylstorff via lists.cip-project.org
> *Sent:* Wednesday, May 8, 2024 9:46 PM
> *To:* Kiszka, Jan <jan.kiszka@siemens.com>; Chris Paterson=20
> <Chris.Paterson2@renesas.com>; Schilling, Benjamin=20
> <schilling.benjamin@siemens.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0TMIEC ODG=20
> Porting) <dinesh.kumar@toshiba-tsip.com>; Nobuhiro Iwamatsu=20
> <iwamatsu@nigauri.org>; cip-dev@lists.cip-project.org
> *Subject:* Re: [cip-dev] Generic x86 kernel configration
>=20
> I will investigate it. =C2=A0I think this be one of the cases were automa=
te=20
> merging will fail.
>=20
> Quirin
>=20
> ------------------------------------------------------------------------
>=20
> *Von:*Kiszka, Jan (T CED) <jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>>
> *Gesendet:* Wednesday, May 8, 2024 6:03:38 PM
> *An:* Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com>>; Gylstorff, Quirin (T CED OES-DE)=20
> <quirin.gylstorff@siemens.com <mailto:quirin.gylstorff@siemens.com>>;=20
> Schilling, Benjamin (SMO RI R&D F SEC) <schilling.benjamin@siemens.com=20
> <mailto:schilling.benjamin@siemens.com>>; dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> <dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com>>; Nobuhiro Iwamatsu=20
> <iwamatsu@nigauri.org <mailto:iwamatsu@nigauri.org>>;=20
> cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org>=20
> <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org>>
> *Betreff:* Re: [cip-dev] Generic x86 kernel configration
>=20
> On 08.05.24 18:00, Chris Paterson wrote:
>> Hello Quirin,
>>=20
>> Thank you for your work on this.
>>=20
>>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com <mailto:quirin.gyl=
storff@siemens.com>>
>>> Sent: Friday, May 3, 2024 4:58 PM
>>>
>>> Dear all,
>>>
>>> I have used a forked version of [1], which you can find here[2] to
>>> merge the following x86 kernel configs together:
>>>
>>> cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
>>> cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'
>>> cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'
>>>
>>>
>>> I have tested the v5.10.214-cip46 version of the config with qemu-amd64=
.
>>> The next step would be to check it in the cip lab on the real hardware.
>>>
>>> The script takes the Kconfig entries of the specific kernel version int=
o
>>> account. It also adds all dependencies to the config. You can find to
>>> log of the merge at [3] and the diffs to each configuration at [4].
>>>
>>> An first integration into cip-core can be found at [5].
>>>
>>> Any comments from your side?
>>=20
>> I had a go at building/boot testing the linux-cip 6.1 kernel in our GitL=
ab CI setup using your merged config:
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/12834768=
01 <https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1283476=
801>
>>=20
>> It built and booted okay on the ipc227e.
>> However, it didn't boot on the qemu setup in our LAVA lab:
>> https://lava.ciplatform.org/scheduler/job/1129968=20
> <https://lava.ciplatform.org/scheduler/job/1129968>
>> "This kernel requires the following features not present on the CPU: mov=
be"
>>=20
>> I don't know if that's an issue with our qemu setup or with the kernel c=
onfig.
>=20
> The CPU type the kernel supports/expects is a choice. I suspect that
> merging multiple configs shifted us from "works with generic x86"
> towards "only works on Intel-whatsoever". Combine that with a
> restrictive CPU type selected for qemu/kvm, and you get that kind of erro=
r.
>=20
> We should likely tune the common config for generic x86.
>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center
>=20

