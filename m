Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AF8C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 07:47:20 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.83])
 by mx.groups.io with SMTP id smtpd.web10.2898.1720770431567603690
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 00:47:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fwSHqRdB;
 spf=pass (domain: siemens.com, ip: 40.107.104.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKn+EsqYc7T0/PJS9NNpQRupbyhgROtKl3fgQUbfBHtWBru1O5B0o7Beh4we8t6FT/FOpaKbNXRCYoHlUzpRFRYffsks9Fl6ClRNj4evcxyWa/reN/vteT3+bNkhd3N3CQBz0SiSUtKbjqbbH+WQUmD1zMal536PEVrcezoxq6gqzfhRk1v+GLdhnzrWranIJcu0RnLaY//mvLOvqifzMQB3Q8BFmwTxDBHnSdfjZnziDlQk8CG7/O60hvnAIl+i+FcylGbMiVWsS9XBSBLXCSt/Z3aDlxq6k8h6o2b7lVGuHuHPUCy1RCbfZKzGnsh4eGlBFt2Ly6wvMRkcfBQ6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj+3S2zRz7pA9ZQ6CeuKRMvLYcZqfZYs/9fY+xD7LS0=;
 b=JmVk8FHaJ1A1wnDn6FA9SrONBtIJDr4oLQWf9pVAtHO6fGgulx+P3bhhtTd2opXExIYgaWquWf61xyfYgVOh/ddk5OE+KxWskfmeBqpmm28wC4hE3MgY361qZJmaScR+X/5yOi3USbYXN+vH3/fjlFuUPJHg85QhhMR4ETlPvgpULbdj5YxLcWdWqTB3uct6vPWOnempYqZRGZgOYXNZzDgCh7VRb1b0CzIWYXe4cMXhvKYOKaSEcRVnJzRFA2ccEHp80xH8pmgqgD91jtOmZ2XftQjsQmx+oRRwzqFStxEFZLs6DApU5a1yF8H1tcYRXU1zZs5N/VOswV2qkFXiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj+3S2zRz7pA9ZQ6CeuKRMvLYcZqfZYs/9fY+xD7LS0=;
 b=fwSHqRdBrkMATmVFpNqxdbSQ2QzHfkSkwf3Z6vEf3ejUBR5DAIzJfOqowM5QPl2EDRm+QxSIzrULVLq/bv1J/KdHtoanoCwxVwwVNJkv9QiyvknSranpfqkwOTOOR01FivCfLGma5bndRezL5msPnjDCMejpFIMacW+t+X4BkHx9ull3fKARTEkKHVWTmyt2v6L+vwozEcTrj21X9Iv8JPYm9z1jrBDRYiCsndbkDRPzC9/dfB5xX+mUiGL1tKI6iO5KCYPCw1AOKA6/pVccdZqgFwpffWRs0b5Yzj2OWJgcgOLNyrzZuQIzOFK8vgHVmKo5ja/291L39MhxGSaAxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 07:47:07 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:47:07 +0000
Message-ID: <c8f76c04-2297-49b7-9045-3708dc79ec62@siemens.com>
Date: Fri, 12 Jul 2024 09:47:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 2/2] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
References: <20240708124734.591324-1-clara.kowalsky@siemens.com>
 <20240708124734.591324-2-clara.kowalsky@siemens.com>
 <63f09b2e-7e46-4587-851b-b6140c191f96@siemens.com>
 <f89cdb44-855e-47a2-b455-5a95dd579007@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f89cdb44-855e-47a2-b455-5a95dd579007@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ae106b-9053-4e92-3b82-08dca246d416
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6lJCk6ZVl8dS9BUg+PeDiGxbtwqc71cT18g6NDtRw+xCvNoTDAvbAl1ePaQx?=
 =?us-ascii?Q?UalrrqRNXDtRit3bkjn+2E+KHJyvrWOatAvlDyyf14emxL3fJ0Tr6WgTp3gh?=
 =?us-ascii?Q?IQRGHh02o7JRPVKkM0vfvn5WEf0NmgWWdYMZh2l0XemoBk1+J0D5Kl5mOoyt?=
 =?us-ascii?Q?vBdNo47P1ZxSMxxVRIxFIU7oSxCi92h+bsNPl40zhSm+5Gqd8BsfI9sikQrs?=
 =?us-ascii?Q?fEdpRb3SrbQXW9Sc4YVWD9xRP2FoUeS1mIfy8Dd51DtNeLFoXvRIOANjMdMU?=
 =?us-ascii?Q?bowRc+Nwl7L/wYyKaNnn1vCy0TnZWks+Dx4Kaqyp5M1T+Tqkpw/pvQHS6MLa?=
 =?us-ascii?Q?6EYmk/pq7bgDRCmXhYsm7QGyvWwCSqWy3yXoTmRiqg7vfMiwzTg9ghq+lOMs?=
 =?us-ascii?Q?/+fOMplZbPf1QuEW5M/OuNBLJHyZO6NxRpcTeqN5pxjP4i1pTD21Katl56Gu?=
 =?us-ascii?Q?D3fNkZ6SAVs7lxGtfH6W1x5dcrORTu2sxKn3oaBxYUDTgaJ4R72nG/YfAayN?=
 =?us-ascii?Q?x2eKDIsQRbdU8IQjpgzARHl6cWq8hIbdBGH8WJh3ngrK/q2sSHLBwgqJyfPI?=
 =?us-ascii?Q?8ZhU/0rTM709sNytzltoXz/fzTvu8RnOYLCALx7o7AL0nZBIDqXK0OooznLE?=
 =?us-ascii?Q?Mc2pOWjytAfzfzIn9+e0RwipFEYn8kUUBqjSf0Ju1m1JVGxBOxFifrAqbdb5?=
 =?us-ascii?Q?4yEgvhqz2OWXoXEddW5JUkXefc2gId0Bc2p8Vzkb84xHUDz7FRYBOo2n+cYh?=
 =?us-ascii?Q?05dMcZ3kE1h3rxnZlXqR6sfLST6aApM+oI83RiRYBBwJDn58pYpFRd8KwBX+?=
 =?us-ascii?Q?s2193SrRv7MYuXw6A3i4SI+ciL/ws7bVPvnSaP9T0Sh6m+BMyfnx9sji6vmA?=
 =?us-ascii?Q?r5196L9s3Vl/1Qehklsu7PSTPYI0S33ZqvritZghRTHjBEPU+LBjIRtqZMAy?=
 =?us-ascii?Q?d4Wyjj5mgorey2ro5JsQlj/+UVwOXDfW5rFmtCzWxhdCpqvqwvT2RVGCfAqL?=
 =?us-ascii?Q?Z3/1rAi+8GTG+HtZxlU4SDDwjtUhwz1F9OBu9Dl5tvJ8eXP61MnGCXSJ+osM?=
 =?us-ascii?Q?k5crYnUIKyYRnFGmB1IUuDQttISZ+xq3IroW+qIPfWHRFTeeIeJUgPPca5LX?=
 =?us-ascii?Q?xLPWK1OzHsMaJzEO8T5T5EH4VmKrNY2Rnwl3oOS9UdW0TXffA3esJXS7sL98?=
 =?us-ascii?Q?LnlWOiGQHAZwH+MDoHULqbn1nWm3qNjZaKZPjXnRl9uVu5o/CoVJz8+VR6J4?=
 =?us-ascii?Q?5M3MIODWqGb5TRazpYKaMzx56XRuaULYztc9U4pFrTSikcahQE0qeyG+sn0K?=
 =?us-ascii?Q?/vFn5W+HzYX6p1ZGwH+1nc/xcgIwfJc/CDBP/7rq6pJX2A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oqh0UyJaF6nZZ/FQ7v5Tt8UPmoclAzmAjKjFDKQ+zzLiycWw6/DdE2tERJ9K?=
 =?us-ascii?Q?ot1N7g/xRqC1P3EBFmaX04OOxh1dWQ6FLLrqiSmpSgbX418GgGDTXZHpVdZ7?=
 =?us-ascii?Q?8jmllm24MIG2weydQmipdAfpZ/aNPP1YWB9PJYNPeO6nT8T6HToKgXUYF5ST?=
 =?us-ascii?Q?C2RjU3SKh45W3Rp9K5rEXfVghYspxIoMNuBkUrwKoIHigHzZFa5o0iHNOlYA?=
 =?us-ascii?Q?Ymv+zvUXWACGHuwsyDBkljy7p6SG2PKKOZqKBZHp+HkQa+rMbB7kDAYE+5pv?=
 =?us-ascii?Q?6cW29XGi8W7bb/OiNRlXLUyqRqizOVw6swAgxu3UtPv0FDlN1WzSc2QY//q0?=
 =?us-ascii?Q?Y/J2iXnJZX7dF14Sv5VkVHzfjS0BWKT9041YyR3MYVtrfI7rhMIkLSJkBPRy?=
 =?us-ascii?Q?rcYMrL0oZ+FlS0nYc+cKhYDBCSC7fvi1ueYgCtJvicJOca7+Oo7sOtsRPGzg?=
 =?us-ascii?Q?AUXYRDX8CIRgUBNRrCc3hlJdaH40MxVQGY03RIcLDRvndzBM3c+yvO0g7L84?=
 =?us-ascii?Q?ujcLjCwNWIxOmjVNiwgml3+5iHmBNaRrf6fi9sMuIfPedA4lyvC+wQT0BZkl?=
 =?us-ascii?Q?LG2gub3/+PNu1GoEgG/r8CfKiJq/rrWr0+g08mI05AyVDNkCb6Evp2+fANIF?=
 =?us-ascii?Q?yXtrqkS1iLjGA20poXvYE7MeIQ7fvHl9/0YLl0PjGsrXdH5YKx89E8ZDILHY?=
 =?us-ascii?Q?n/hqBN8+bNWpiIIakcj7EDCuLunmEfyYRyaV3LbKmQQgCUd4sCUlu0DrOPYo?=
 =?us-ascii?Q?A/2RnzXwiegRMKLWfca6M7XwH/prPvmWmjhNSTWyF5/ItO6f3SbuJl+RlzTF?=
 =?us-ascii?Q?NaKbFdg9ua+ocvd/SdyzMUvaNwQEb+fP8S9M/gYUPil0g4WrNLOg1flmZuVi?=
 =?us-ascii?Q?TEYXIUeZQgfLuwb8Rwr0aQTZX2rTM+z2Y05/JX6QUeW5pQrgIbKh+YpU/XEf?=
 =?us-ascii?Q?cB0DoBqRZ/pRkn5emnWZH9QtI8bQjYCSw6Vm4GUYHniIsLKPnUeNj9CI/leF?=
 =?us-ascii?Q?r0wBW9seLm0stTYDPuHcgmxjLVH17yquyJb7hojSGmNema0srNvuoNg6NhOj?=
 =?us-ascii?Q?0G6bXkQHLM4QAnKgf4V5fBHlWUJmJroHOPZgUP9eDitccLeuAH/tUvSabcsw?=
 =?us-ascii?Q?xB2e2jvb4hrN2LdYSGQzYyFP/pKQZiC6+uhvzLAMFfPJQuNo68lV3UnCMSed?=
 =?us-ascii?Q?ufNRY7M2FAfAhmLArgzGDqVAL8C4j4R62s8QqS9l/IDrgQ5ivQQxP2BF+242?=
 =?us-ascii?Q?8orJ0d8DXXOWY1sxvIcwgd9ufimH9qUiYvWk9+eA6GY4ev9Tk00WCn8frSOa?=
 =?us-ascii?Q?Npj86t31HUDYm6fb6QzMNhRydlFKRLuday/yE+9MmTLAG0AfXgVGCftakt3K?=
 =?us-ascii?Q?YSyNqTY/ogC/bsKf1hT6yq7RT3OewBJnQF2rjrfvh1aeKscivvxjKH2Nt9o3?=
 =?us-ascii?Q?aBi/Ql+BnYsrPrEH++wkmDgVlAmqlUXHwL7/FjD/Prqw526bmHnKm7veGCqj?=
 =?us-ascii?Q?TT3MTx6NdVKMckLJf0jD23r0h6+xOW+qA0J/yBqVL0KvAz0DOz5Jmg/zv6y3?=
 =?us-ascii?Q?fqh6cg/89UY0XgPicOFUnlXuh/7mlpx3G03hLXch7cF8YSWDhOZYKLu76pX6?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ae106b-9053-4e92-3b82-08dca246d416
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 07:47:07.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xva0T96U+Txw4HUNUo0UbbgoC0/wupYguKWB8dWnTCPIrdxbc7Xgi3ypO2nqWaP4qSMNGKqZ0kR/j+70bf8u0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8755
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 07:47:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16456

On 12.07.24 09:39, Gylstorff Quirin wrote:
>=20
>=20
> On 7/12/24 9:23 AM, Jan Kiszka wrote:
>> On 08.07.24 14:47, Clara Kowalsky wrote:
>>> In case of ext*, this detects and fixes file system errors in the
>>> partition device before doing the partition mount.
>>> If the partition turns out to be broken, the factory state is recovered=
.
>>>
>>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> ---
>>> =C2=A0 .../initramfs-overlay-hook/files/overlay.hook | 11 +++++++++--
>>> =C2=A0 .../files/overlay.script.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 ++++++=
++++++++++++-
>>> =C2=A0 .../files/overlay_recovery_action.script=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 17 +++++++++++++++++
>>> =C2=A0 .../initramfs-overlay-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++++++-
>>> =C2=A0 4 files changed, 51 insertions(+), 4 deletions(-)
>>> =C2=A0 create mode 100644
>>> recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.=
script
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> index 8b00ecf..6f634c5 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> @@ -22,6 +22,13 @@ esac
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
>>> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> index 42eb59c..6120615 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmp=
l
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmp=
l
>>> @@ -16,6 +16,11 @@ prereqs()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$PREREQ"
>>> =C2=A0 }
>>> =C2=A0 +recover_partition_from_fsck_failure()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 true
>>> +}
>>> +
>>> =C2=A0 case $1 in
>>> =C2=A0 # get pre-requisites
>>> =C2=A0 prereqs)
>>> @@ -24,7 +29,13 @@ prereqs)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0 esac
>>> =C2=A0 +ovl_recovery_script=3D"/scripts/${INITRAMFS_OVERLAY_RECOVERY_SC=
RIPT}"
>>> +
>>> =C2=A0 . /scripts/functions
>>> +# shellcheck source=3D/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}
>>> +if [ -e "$ovl_recovery_script" ]; then
>>> +=C2=A0=C2=A0=C2=A0 . "$ovl_recovery_script"
>>> +fi
>>> =C2=A0 =C2=A0 =C2=A0 ovl_partition_device=3D"${INITRAMFS_OVERLAY_STORAG=
E_DEVICE}"
>>> @@ -34,9 +45,15 @@ ovl_mount_option=3D"${INITRAMFS_OVERLAY_MOUNT_OPTION=
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
>>> +=C2=A0=C2=A0=C2=A0 if [ "$partition_fstype" =3D "ext*" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! e2fsck -p -f "$ovl_par=
tition_device"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rec=
over_partition_from_fsck_failure
>>> "$ovl_partition_device" "$partition_fstype"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 if ! mount -t ${partition_fstype} \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -o ${ovl_m=
ount_option} \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${ovl_part=
ition_device} \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${rootmnt}=
${storage_mount_point}; then
>>> diff --git
>>> a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_actio=
n.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_=
action.script
>>> new file mode 100644
>>> index 0000000..a05e4c3
>>> --- /dev/null
>>> +++
>>> b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_actio=
n.script
>>> @@ -0,0 +1,17 @@
>>> +#!/bin/sh
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2024
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Clara Kowalsky <clara.kowalsky@siemens.com>
>>> +#
>>> +
>>> +recover_partition_from_fsck_failure()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 ovl_partition_device=3D"$1"
>>> +=C2=A0=C2=A0=C2=A0 partition_fstype=3D"$2"
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mke2fs -t "$partition_fstype" "$ovl_partition_devic=
e"
>>> +}
>>
>> Why do we need to put the recover logic into a function? If the script
>> itself is the interface, we can save a lot of boilerplate and can also
>> avoid that sourcing with the shellcheck annotation.
>=20
> I suggested the function to allow an way to overwrite the recovery logic
> in case another behavior is required by downstream.
>=20
> You would call the script directly?

Then I'm not yet getting the idea completely yet: You are already
testing for the existence of that script and only source it when
available, and the default function is "do nothing". So, what is the
benefit of that compared to testing for the script directly where the
function is called now?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


