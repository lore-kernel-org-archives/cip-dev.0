Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF574C2BD09
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 12:03:05 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.52])
 by mx.groups.io with SMTP id smtpd.web10.15382.1719576185106972428
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 05:03:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RKh5jmA0;
 spf=pass (domain: siemens.com, ip: 40.107.249.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJjgadxIW2+QWQf0H7yXmnSM2rwU/iUTQWQimceP9ctv0FWrtZoCqvRCGJ+Atjbs/bRxNnzDYFbBsRbK0SXwS1sgnXNZKjPz+CHl88BqwwDkxjjl9HyIhYbwJ0a4FDNSX56dbcDiGFnHDd4GCXXN1YRuGWq2v9zkDZsRXo+vXVDq4233pLlsbjyrlF2rcfMv8P3ciNLuucbuxBxgbyjYbxO3UrNRDkHNmDOELLkkefDshtoQLN4gJ4LRCvrSNt3FeFY5q2mpQIVIw092uC1tptu61EAt8QQAEa5Vq+X7IrygDVTIlebdJohh0O/pStaUhtgNOTHYP/rXZ+F6lxkGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjdPrubA1nUs01ui/WQxXfeplJBu05uc63TmKszuN/k=;
 b=nCB3WVMaZlJNZTLEcfyetZwTId2PT32KIsHmzAt99tZqKXfQ8HPbhcY2dYW0RJ2bPofHtl4hetjprrNujjE1+X5gna/wBFczRREG40RK2SYgykQrJ4mxSZoWAxviyvnrRqwjoT0l1kFlS37zIBwqq+IUiuahgc1S1Y6K35x7po5MFc13Z2Ye5elcj/SKsC2Ni8nHcf/arNn4qFSOzFtWTxKFj7oKKRIxlhfdMQJQIubZJLSU+h8jzAJxxV9gHYgNMeMi+rgB6CYjsZ/AcejfIxkgf3J/rBtVdOP8iLpDjCIejDh5N853PW1Yo6h3bWz3lgz71GnlOzourrKwifS3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjdPrubA1nUs01ui/WQxXfeplJBu05uc63TmKszuN/k=;
 b=RKh5jmA0GSLqb8nfpLREYOWU26dpQuN7MLV/3nKPTOrbeyzABn2zw6ClqzGvqtkgkFzDj4Jw/KulR6YLTlO2hjMFW+8XtgipK8Mm9eSpqPS9kXecg+S81q2qIoxVMytzK5cFFO58IIrNJoCJ5xfO9dwjHy/IRTkErkW2ydiKCjLJ0SVELDOwgThA02/DOMR8BthswQE7M/3YjxlJWLq3f48xIJEdSTy0sSn7Ck/Gv9iuohsCz/OeNWqPCbNxDEzVJuSiiIVgCcopBZeTTKPj6Ub7JI5ntyjLorw93JOB0kArdCs3c0vD4/qvjEBgkf5h1EeFigHGMdYV79ZrzALdzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 12:03:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 12:03:02 +0000
Message-ID: <d4d7231f-8164-4af4-9243-c3126c36136d@siemens.com>
Date: Fri, 28 Jun 2024 14:02:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/2] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
References: <20240626134141.74487-1-clara.kowalsky@siemens.com>
 <20240626134141.74487-2-clara.kowalsky@siemens.com>
 <0fc2eb61-c41e-4704-a329-a14b0529a1fd@siemens.com>
 <e3bffb4a-0f87-4465-912b-f497a8cd6826@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e3bffb4a-0f87-4465-912b-f497a8cd6826@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3154:EE_
X-MS-Office365-Filtering-Correlation-Id: 7feea3fa-201f-4ba0-d1c3-08dc976a4297
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uG5/22atoUzSaXZVoWMWr1TWZ3a0M5aXXuLPQdWf1tjWF2uWTW/9+M+wb4Gg?=
 =?us-ascii?Q?IIZQ1KoEGqqnmiXCDFcYR1Cdq4rZkTBcQgL4srX4SyaGFvRizD6JLpnX6qM5?=
 =?us-ascii?Q?YbJS0e9KMclTXG0L2mUJvQLjD2u5D2anSI5wPTNDmlF4iBxME8X3Rvhp2uD1?=
 =?us-ascii?Q?H+gU3mpiFSXOWOpscDqhAAmUJ0PdR5RUGsugGvbEiSYN3Tk/b0A2tfISZSRo?=
 =?us-ascii?Q?Urf4yO9lzZ/sMa0wu7OK20DUs3l+H/I57rdDpe1lcPnNQKHS/TJPoR1/MiGF?=
 =?us-ascii?Q?iWZVtRGbLKZlXw6Og7Tz1/smlEBL+r5YzHektBOYykBkSbt560VWSRQ537oG?=
 =?us-ascii?Q?gZl9+CZH7FwbuorFSmnD+Bp3HYjWm/fiVcbch9E2qxWa/p5aZck9Q8tMttYE?=
 =?us-ascii?Q?4cKOgQyuWD2p940Oz8VdZrl+s9dsgB8qoQwoIb4xp5O1xXUbamn3rmAAfpbx?=
 =?us-ascii?Q?8ag5jHqExzYGZ/sxlAc3iBY67vqck5aKZZw8k/xGTqFcpVA2uCjCqA97F+PX?=
 =?us-ascii?Q?Yu/4YzEMYzWlQp2/D9+nHc7mJaCazxqYaAnhTu6ZMqnfJH12syRnIGLnkQan?=
 =?us-ascii?Q?6e7LD4UFtHsoM1M+HRbgcuVdNBT9HG3AlLiXBcRZi3X92H5VpQln+d1AFTY8?=
 =?us-ascii?Q?wEtpKx2kPpHh+jz/EPZ7Z6IjU+7yR+VcRMtAFdX5JqkATSDuuRgGD6m/OHZQ?=
 =?us-ascii?Q?85fcnZQOq/+OOYbHQcKBINUyBHwEia61t/34Smz8JHUOi7AJ7iNkS5lKJw3H?=
 =?us-ascii?Q?lcAYesv4g31qPR1118NvDDPus7KVAnS3nrIr9ATkXXWglxN+j84QYXZgpZmR?=
 =?us-ascii?Q?N3WhT46jPYHDNhGa/WYlivFx6Sn7wmQqo8pRqZQnYgSfzsD0yYobDYwpNrgw?=
 =?us-ascii?Q?IVjgcrKefnDaqz446SE4EkQvcyRaypDypKEsHM188e5CK4/fD52uw1yh1Dlr?=
 =?us-ascii?Q?7MImflHBlQWsjSg7gxJhjWxkwoUIHWnVbCL9Ydtstc6ajwJnDk1cALgTQC/T?=
 =?us-ascii?Q?2sU4EKXIjFaHmi2RIMcJuDjRZDCsH7Hi++am/KEXW8L3ZZgtGOXqRFN380yd?=
 =?us-ascii?Q?zjM9SFOp6QtXeC44x2uurhDNlxRE7f+ryYRCa2cw9KyqsU9ijK2dx+DcnR/F?=
 =?us-ascii?Q?cDSfXCHJQCAjjOyX9NAaoexgVNcz59pNRG9SSIzkKLmBmrKxBDHISeAp0Mx5?=
 =?us-ascii?Q?DzP1yL5Elf2qZQOEBgVmoH1XwtU3wuVtRrqle6XRUeAeOxS3f2YBzgHd2Jtm?=
 =?us-ascii?Q?dWeDV7IO1SxrJuTn3QpJqq7q08nRel2SR9MlUCb05Ttxwwf+a9akEPH6kAw3?=
 =?us-ascii?Q?wALE/lsnvSdVOdEWBRBrLVlTqOTWBZrkUXOWhf7QSu1vEg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QBe6x/L+CFZG1PvynODDU2Vl5Kopp5WAerelDH+xqRqSge0WV2Xdt726X3EY?=
 =?us-ascii?Q?6CYC6pbVBfgZxxtO1iOxknTSvQb2btZiYJVqOgogmNVUS96+4IxVTxVAg1ke?=
 =?us-ascii?Q?r2ayNQM5z4/j968RCXfSJK0EfwzyiOtSVWhiScFzV9IxzQFduuvnJogQSF/J?=
 =?us-ascii?Q?8Svnl/IrMyUhji6w90gEz16j+g0nbuRRIo4cF0nR4pbEDCmzZo04vh14DpcZ?=
 =?us-ascii?Q?VLgFki09EyFIaAmc5WaFs4yP5xfkFplBL+KgSS7GIYBmZB2ynctv25cXGRIE?=
 =?us-ascii?Q?jjq2o7HoUKaqbl7acBGxStRzKVC2UsGf57RJcsOuKlKqFGTreF1ZeuXDxSn8?=
 =?us-ascii?Q?o3JjGO/l5PJ3oqECxakfKolq7y6DrOYMovxX6Qf5WGUeGXd4wOFJH9v9J3Dj?=
 =?us-ascii?Q?J4f+0klux+j09MXLjyQs2lcpt9QgwNjfZWa/UBZiTCnYA0BcNFPt/IAfrVH1?=
 =?us-ascii?Q?3LXlY8+nrUC9NfiOHevXjSwuAiCril43DMtJiF0P6ubzfMXAbtyKWEba8X+S?=
 =?us-ascii?Q?bvML5cicR1pP9TiQWWsqf8uTVDgFrknIhcJj9QiDPj+9bW8lMQ4SaDNj87DE?=
 =?us-ascii?Q?Y7E7W7W4DIkGMiGG54KX9MNAJ5Feh6BSM9RCYJEdsCCCrowHkD4GQie0UCRa?=
 =?us-ascii?Q?eoq+x7fF8gN4LXdL61rgaJ5vy/cTrt7h7qQsrz1AHnkJjatWrOLUVjo7Vu+p?=
 =?us-ascii?Q?//r9bAZ9AZM+Li2EphJx6zu7hA9n1hHs2/9TbRaRa7QVdzFGfhlpiejGm0Xf?=
 =?us-ascii?Q?uevHSWHPN8+1MzIScqoMMq+RjtES3DRktxD9Bcz25462yBf6tdezYDmLPQwp?=
 =?us-ascii?Q?FT1sqi5N93b7jCP+lWUjiVopZbtkAVOiIfnrUKuhVHUzV6KvZjfkHpNlq7co?=
 =?us-ascii?Q?KVNLb9WunHqGllv+bj9/Df/s79/JJK51XsZNc36lOHlLClQm1KTGI8K1sCvR?=
 =?us-ascii?Q?KN07eOXov6lMlKYvzqTUazQBqMPZUOjXCeJZrtw+4WClZ5DRmZP+WSLrZUxd?=
 =?us-ascii?Q?Uccfkow8P1abmFeY3wQ8W5KhDLbz028z2UFT6T/nzDMysWv5YCKXOyHjDHCZ?=
 =?us-ascii?Q?tb8fKPAbgwceeUrSK9qqcHRzyhW2KzdS7Nbamf16SwqJ4SgzKkGRYAa3jB/j?=
 =?us-ascii?Q?/ljvXZHWeXCvPaqIaFpS+MCzbw0aiYSYaVSPmLJqoFpWVcVMRcGTUSokE0Bp?=
 =?us-ascii?Q?KONx4Te6rjwV1e1YSwEjF6oRN+xsKbEixwgjR+Lhp9jGZcP/rDxXO5FcLRrj?=
 =?us-ascii?Q?1g4pHPsEjTZ9u+VnljzPNLroRiBhQtoJu/govaA1FsVgN18y/CNTO4z3J5Jw?=
 =?us-ascii?Q?t0BgJOa0CAKX2v1cPP+nPPBG0BUCJgG9RODmCtwt/6j+c9vSJs7Y7cf5sZE7?=
 =?us-ascii?Q?i0oBoCtQ1jj7NCQXXFeEXFh0c5vGsf1uR2A1tjBW0EKENBQNt8r7EX+lePHm?=
 =?us-ascii?Q?gI+LOnHiAvaxrJwew/392/OWaAw4DphG6uMDYPuyH05EhG9FHUui0vHe7kcs?=
 =?us-ascii?Q?hheZBIXt6fxXOdTwdygxlwDbps4sFq5u0v1osivmr3do9Xs5ZlhIJBfalufs?=
 =?us-ascii?Q?V6hfYhPcT/Wlzp0tsQ3Tf24GDQMR6ScqIwNx6r/WKOIPXP0CSYwwD5lXCEMR?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7feea3fa-201f-4ba0-d1c3-08dc976a4297
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:03:02.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGHcTPCO4O7I/8k30M/r8iNxK4PWyLD9jCH/O9PG8mLOnnRtQllE5JusOauQKfkRykqjUGvtTgw1MRo6tA3qcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jun 2024 12:03:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16344

On 28.06.24 13:58, Gylstorff Quirin wrote:
>=20
>=20
> On 6/26/24 3:56 PM, Jan Kiszka wrote:
>> On 26.06.24 15:41, Clara Kowalsky wrote:
>>> In case of ext*, this detects and fixes file system errors in the
>>> partition device before doing the partition mount.
>>>
>>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> ---
>>> =C2=A0 .../initramfs-overlay-hook/files/overlay.hook=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++--
>>> =C2=A0 .../initramfs-overlay-hook/files/overlay.script.tmpl=C2=A0=C2=A0=
 |=C2=A0 8 +++++++-
>>> =C2=A0 2 files changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> index 8b00ecf..1a54853 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> @@ -22,6 +22,12 @@ esac
>>> =C2=A0 =C2=A0 . /usr/share/initramfs-tools/hook-functions
>>> =C2=A0 +hook_error() {
>>> +=C2=A0=C2=A0=C2=A0 echo "(ERROR): $1" >&2
>>> +=C2=A0=C2=A0=C2=A0 exit 1
>>> +}
>>> +
>>> =C2=A0 manual_add_modules overlay
>>> -copy_exec /usr/bin/mountpoint
>>> -copy_exec /usr/bin/awk
>>> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not
>>> found"
>>> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>>> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> index 42eb59c..6b404c6 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmp=
l
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmp=
l
>>> @@ -34,9 +34,15 @@ ovl_mount_option=3D"${INITRAMFS_OVERLAY_MOUNT_OPTION=
}"
>>> =C2=A0 =C2=A0 root_mount_storage=3D${rootmnt}${ovl_storage_path}
>>> =C2=A0 storage_mount_point=3D"$(echo "${ovl_storage_path}" | awk -F/ '{=
print
>>> FS$2}' )"
>>> +partition_fstype=3D$(get_fstype "${ovl_partition_device}")
>>> =C2=A0 =C2=A0 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; th=
en
>>> -=C2=A0=C2=A0=C2=A0 if ! mount -t $(get_fstype ${ovl_partition_device})=
 \
>>> +=C2=A0=C2=A0=C2=A0 if [ $partition_fstype =3D "ext*" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! e2fsck -p -f "$partiti=
on_fstype"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pan=
ic "E2fsck on ${ovl_partition_device} not successful!"
>>
>> Err, this will break the boot without even a chance to go back to
>> factory state, no?
> I would add a hook to a script which defines the action in case we
> cannot recover.
>=20

...and maybe already provide a default action that reformats (thus
wipes) the state.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


