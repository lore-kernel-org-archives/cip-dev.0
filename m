Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53178C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 12:48:19 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.61])
 by mx.groups.io with SMTP id smtpd.web10.9758.1740660489929762436
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 04:48:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=AK81Elnx;
 spf=pass (domain: siemens.com, ip: 52.101.67.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6mbsAdzwrvR/DEeaezljp9C3O6l2XZoc/ccoSkh6n835zhtiiTKGxHgWHjSWoMbe5zoaO1S5DLBKtTehR3ZRtPIhMselVLo8OApVKYa05O15xXHXZvUmj2pz9dCv6oeSh5In3vubppYHc+CJciBHHQm/ktmAkUDuiC/Uvj8NodMK7WkufvdgJjXOH6B6b2AUP+hTAQfD/eaMxG4VSbCbaIZWvng0E5hSIW1jCFtbIqtEigZzroTesIYM61RWPVVjS4TG/WzGlPeq2NbDN9cz5EHVqxihpeHv44zQKPqq5otk7EjDMQQaXmiyu6B7O0cSMJCWBLVNHYLxtZ8mPLHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfokB/Hj/jiEX7ancubhxG61uAaFQefJzMgYWSIGTsM=;
 b=Mk8CjuXY/MEzFEVukccKlqigEmjy3cTa/mMUWV7+T1U9LDjibfWJAxcNcNbqQm2/DqRXgIKmzHB/WX3zj1AzxrdJN0lLYBJnpoJIDVq/bCJ84s5mwS6JPP5DQmZEw6Myi6I0BUbOJF5B49bT7iUZ41YxQcv+avukUSNfWqaDErYzinvmHY6TiQlmmGbkNKZKjyleNTLW3OI1kEykCl5EyjAvPbo3Z6kEdy/D7uz10GmZKZ6qcz38rYp90t2zQ/+lPspZ3cZRpmJCHIAqS/JFRabaf21eVEPXyvL3ukvvwIFrctsD4qpRzi5s3D8+tciWkbkc8CN0k03FX3fXRfmY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfokB/Hj/jiEX7ancubhxG61uAaFQefJzMgYWSIGTsM=;
 b=AK81ElnxTYRMS2WIDEK1WqDENYIu6plfSU0ePBbVv2TZblAIBP3CYhb8mMkaT9aWyT7F3EbEiyOOkvWF8vEcHHZ5bqL5bWp8WWvgLM+oliPWCGQabOCNNddV8reiS6BEKpJ03il1IHi4RhR1oU1T1hy4gfKLi7HImGQFT/rteKxx6f/b/e1/ITp0bk9MBG2DKLQCuJfJAYI+f/hsZSP5OgzJUQHi6RyyGu+ANZNdiAeezVnRbC4JzH9XtXq+ba1+N01bUCf5vDyPjhKxnqK6Eg9zYBUmOPdITiLhUj/Ty8/lrUMdbRyGRvWq9e7jJlQF0h4OSwP0w9dluarEl0ihCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 12:48:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 12:48:07 +0000
Message-ID: <8e6ad5e1-b38a-44d5-912b-38e2272ad4f5@siemens.com>
Date: Thu, 27 Feb 2025 13:48:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] initramfs-crypt-hook: implement 'noencrypt' option
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-5-ch@denx.de>
 <2977fbac-b0d9-44ce-8f23-a4fca025cdf6@siemens.com>
 <e9ca4969-3123-4411-a19b-3afe1becef2e@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e9ca4969-3123-4411-a19b-3afe1becef2e@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: d17b965b-fbe2-4d01-1385-08dd572cfbcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PqUDUl8kGduI0IUJhJhK5cOVpuAlCAW8gTvFhBoMX9ITGDwgx2rNgXNk4g05?=
 =?us-ascii?Q?/QtAtnJeTPehl4DKonyn05SyeQ9glLL5uIaVX0mVI2++tP7XFKgx6rB3HqQO?=
 =?us-ascii?Q?1eTF1tG9qDfi5MtQ+DmWAl5bbbDVr7Ap2nrucqGxS7O8i9mFQinLrsTz70dP?=
 =?us-ascii?Q?mdkCiufnDhcjKfS+3MZz+tqB9ZGvGMNHX2ZsZag0Gimfl38x7JGkzT1JUppw?=
 =?us-ascii?Q?2bQgisi81MzAxzV2vkeC55O1TWPvwTtLzXDRrcNkPZ2CQZWG9PC7YMTTUFrt?=
 =?us-ascii?Q?kqTCY9q3K3+pZKvQtqqexOA8SVx7/pZqny9dehLPzVa465s2M2OQyHwJjbLX?=
 =?us-ascii?Q?AX+uwIRryhELkFdC6sajHTuadNLU1lAw3vuyOhRIVdEGoCFjuOWUQFFTNsVC?=
 =?us-ascii?Q?mWhoiLb33OuX5hPgbhk0MI1fppC1aANAMeGT1lEWc/+2T6R2vYdUaEXSjTxa?=
 =?us-ascii?Q?xsQm2uWmtYeIqHLMg15wNEcfXIHXRq4K1ZVfbCRqtpmnMCgJZaEozCN9L/Si?=
 =?us-ascii?Q?mHDW1AG50ugT9evT9DDAyzHdNhP/eU2CDkyk4CwOulHxBqmmEVdvMrzgln5v?=
 =?us-ascii?Q?Fde+TA08/P/y9TGIjDYvQvr8nWtMMZSyrZgXDodegbWtfBMl+j6O1XI2MGrh?=
 =?us-ascii?Q?FXQfqIXJ3/2eGFuOH1HdMWJ/sIFvn12JEtDYJaK4YwAD0TPjCzD7tiv6Ie27?=
 =?us-ascii?Q?qTdT7MpB3uJ2q01lhD+XvPCjB6jYZIHxpLu3FStreBkUWjhvD50htLd9kIzZ?=
 =?us-ascii?Q?Tm9QFfEMBSonOe0NdddS1pwOWF4wjrz1BXFQz9hq5OIA1Pc0s0PzjyGrlwcr?=
 =?us-ascii?Q?LE5NKhLStLyDttlCzNPGF+tHUXKBruzxOhPOlWcQqRQ7It40Q/BEVC6fYLXj?=
 =?us-ascii?Q?df+VJEBspKYaifAV/bDt5fyN2TtnIvXtm5T7B5eZLbS94o25XS+s6YgoqAz7?=
 =?us-ascii?Q?tMiTUyAf6KCFro5S5B9DWoPddoyK79Hqqu/pvbutVyVOWBdoEDKs6v7ff+gg?=
 =?us-ascii?Q?loLbLXQf83g/rmh4qg6IhtENwGvwhwC07dYrNrxov7+erFDLcTFEiMXUkvjO?=
 =?us-ascii?Q?0g8YrYYHKUfEVsspae65DFzCeKWJpZn4kpa6BrPWt38ch9Y6PJkT9ZwD3rvv?=
 =?us-ascii?Q?HblMDiyQMOUQIvSAoDmgfBv/w2FPZ8pt0/ex5NrAycQkYdCtY6JADK3xyTs+?=
 =?us-ascii?Q?nVNvUgBqH+RJe3zF1ZiuasoU6FtwPXJU0NnW4XuX3VYXPoHMhlMiES3V893n?=
 =?us-ascii?Q?ShzSiKvQ/NRq/MnFRc67JnTOIq+lDF09aWwHmR6N+tAPwJxqn3HY/mEUg6R6?=
 =?us-ascii?Q?MfKgCZayfF9detzV4enRYkQ55qTEV3YF5/2SFicJv8HottrrJNHWeEf1Fdlw?=
 =?us-ascii?Q?Cxd4EonmNdSEpIBvPDBj5tdffkuH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ulKw5kQdbSETUjYwVzIjXQvm9ZsGDDuJeh1BsbsgzjS3jMZY6TMa3fUFZLY5?=
 =?us-ascii?Q?eZj0aTspg2JBG7+R57sLREY4fD/FuyUWuj00AP6otXIcmJPYiJTshsavl7tR?=
 =?us-ascii?Q?lHSi9NuLJGiePCbG7HUEDbTRHVv/bpFALfe3DiKB+BAROYA7OsWLeQblo2CD?=
 =?us-ascii?Q?UXWn0rVZMvdNKs6rjh+uueUGgVFf5qkNE6O4OmgJ6EQnZ0KSbXTxkIQTxZbZ?=
 =?us-ascii?Q?sonihs+i3DStGWEGB2/rEgVjN4cXrXy7I8k4GyKsnKa0amPExhzObkEdi5YF?=
 =?us-ascii?Q?tCyK42Sh/OdBmN0pVXOD8ufvLhNJQ1cKms3fyOSbjTkybxDhtB9wKz2EKFfB?=
 =?us-ascii?Q?C++H0eU3YXaiX8sC1TGQC5OI3jJR/opg4XBbJP/kF5EOLHQnsE88YiBOqnb3?=
 =?us-ascii?Q?/lLlv9UrUBicS3Uu2tu3xGI4D0wfj44HS10OTH+wyzpY9GjpVsOiTnuLiCka?=
 =?us-ascii?Q?3AolKwCFJpuwOeK/0MEIpCUDn3oQSe881jaVcv7OmbjR57q5YWT6L4dyk7Dd?=
 =?us-ascii?Q?hz+amnEOXR7aQGixpvFWVH22zmH/Wz2Fa1JrxzfdAxNxs8P6uftegdF2Twmd?=
 =?us-ascii?Q?w9DmnZxtCcGkJO2ggfQrAt/AQ0u5wIP+OBR1z2Q+llDRaG2tAJ2J3PGFGn9V?=
 =?us-ascii?Q?oGf1QATJNISzCoK2xs8neWlPHIM3u1qraISUYpFBiP1OvGSKof30tei8Cg7D?=
 =?us-ascii?Q?SJSz/WNczD73kTparAvd+yHjpG5SDP2BPsdhgyGL66cS6B2tDB3ewRAo92ph?=
 =?us-ascii?Q?js4c9sCUNfwxsCYOGsPrwaA+BDJERpzhFJ3qQb8WwbDqSszUjLia1uDy6Adj?=
 =?us-ascii?Q?oHKUvXYxZ751rgenm9l2V5XTxmPutQm6ICnTSwClqDBVqg4sUjKPkRDq8kea?=
 =?us-ascii?Q?OhYXVgZn0SgGufcfcyYYXKPYlTO6s8WS3w2mAnWA01SbHqjsn+NncdxFwTcg?=
 =?us-ascii?Q?C0zkoTX/x8W8hXZqd9sbiJ2l9pQ9scFpXGJKvh8tm6Zka7plvdsRuPyD63QS?=
 =?us-ascii?Q?ngsoSOKP4AhB9+rVW119RMFAEfeYBapyeofa2xUrMin2e2TtlmMwbykR2rHt?=
 =?us-ascii?Q?cFYehNiR6yRLTOaTB1zOYJ1C5Q0JltrEl95MOc06bv49SY17P6epkeIfzZNx?=
 =?us-ascii?Q?1XM8HNS6WlXH2iJRKNYzPG8orDYKy9R/Gz2aezCfyg8Evzp7RwRI7RwuRqlB?=
 =?us-ascii?Q?Ue675jLUH49Qhb5+Dj4iOV93ZOqHAwclB8KosZWHrAgYODtQAQdOlXgbJdJj?=
 =?us-ascii?Q?lziiN9tBD2IveJE/u+BiFFKrecvNOBdohkASEY6mticFFMMKtUfD7dTyuw5N?=
 =?us-ascii?Q?0g9UXI5XKSRdwXM0EtdIVTndOeIo46YjD61LcYW0FT8OTA8abMPhjkpXDKwW?=
 =?us-ascii?Q?5RYlRJZw5STFYZbbinVMe2dsZbvzEogE9IsZRMApLdBsxEjSq8WjO7q9LA6t?=
 =?us-ascii?Q?AjFYygCU/8cRh8FUALQY1k3/sr9bEpTqDdPVpBPvsoZRDrX+f342w6KxQoS0?=
 =?us-ascii?Q?qBgNpd+MrtY8K9wfUW1BP8DoVsoeTnk+ug7y6MKhLKMpEQFRqVXDKWIRArWa?=
 =?us-ascii?Q?XzjUuLRbfUg97vFXlIIOIEu0A1rBBEFH/4/rjXyeGNUpJqQuJbB8NvgkG6A2?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17b965b-fbe2-4d01-1385-08dd572cfbcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:48:07.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y30MiQh14ipVpoZ65Nb/Tpel5GBXWsX1G/tp5k3jksrsy5ATRjY94Vo/WnkOMX/ORFud3WTGcvcugEpGIXZoKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6007
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 12:48:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17937

On 27.02.25 10:55, Claudius Heine wrote:
> Hi Jan,
>=20
> On 2025-02-27 10:17 am, Jan Kiszka wrote:
>> On 26.02.25 10:59, Claudius Heine wrote:
>>> In case encryption needs to be enabled via an update, while still
>>> allowing the update fall back to work. One update step where encryption
>>> is supported, but no reencryption is taking place if the device is not
>>> encrypted.
>>>
>>> For this the `noencrypt` hook is implemented, which requires some
>>> restructure/reordering of the `local-top-complete` script.
>>>
>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>> ---
>>> =C2=A0 doc/README.tpm2.encryption.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +=
-
>>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 +++=
++++++++++++----
>>> =C2=A0 2 files changed, 26 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/doc/README.tpm2.encryption.md b/doc/
>>> README.tpm2.encryption.md
>>> index 3f7e89f..515348a 100644
>>> --- a/doc/README.tpm2.encryption.md
>>> +++ b/doc/README.tpm2.encryption.md
>>> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following
>>> variables which can be overwri
>>> =C2=A0 ### CRYPT_PARTITIONS
>>> =C2=A0 =C2=A0 The variable `CRYPT_PARTITIONS` contains the information =
which
>>> partition shall be encrypted where to mount it.
>>> -Each entry uses the schema `<partition-
>>> identifier>:<mountpoint>:<reencrypt or format>`.
>>> +Each entry uses the schema `<partition-
>>> identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>>> =C2=A0 - The `partition-idenitifer` is used to identify the partition o=
n
>>> the disk, it can contain a partition label, partition UUID or
>>> absolute path to the partition device, e.g. `/dev/sda`.
>>> =C2=A0 - The `mountpoint` is used mount the decrypted partition in the
>>> root file system
>>> =C2=A0 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting
>>> content of the partition. This reduces the partition by 32MB and the
>>> file system by a similar amount
>>> =C2=A0 - `format` creates a empty LUKS partition and creates a file sys=
tem
>>> defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
>>> +- `noencrypt` will not try to encrypt the partition, it it isn't
>>> encrypted already, but will open it if it is.
>>
>> "it it" -> "if it"
>>
>>> This makes it possible for an image to support encrypted systems,
>>> while not encrypting anything on their own. Useful when updating from
>>> a system that is unencrypted to one that is, while supporting a
>>> fallback system.
>>> =C2=A0=20
>>
>> Please elaborate a bit more on how things are supposed to work this way,
>> which scenarios should be addressed - and which not because they are
>> inherently insecure.
>=20
> Well. Switching in-field from an unencrypted system into an encrypted
> one is inherently insecure. I agree.
>=20
> It seems security requirements have changed in an existing project and
> now they wanted to add encryption via an update afterwards.
>=20
> If your decision is to NAK this feature, since it promotes insecure
> approaches, then I can understand.
>=20
> The reason I submitted it here, is because it might be useful for others
> as well. Eventually encrypting systems is still better than leaving them
> unencrypted.
>=20
>>
>>> =C2=A0 #### Encrypted root file system
>>> =C2=A0 diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-
>>> top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-
>>> top-complete
>>> index b907ea7..1214a63 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -216,22 +216,41 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ ! -e=C2=A0 "$part_device" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Could not=
 find device=C2=A0 mapped to '$partition' cannot
>>> be encrypted!"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> -=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>>> -=C2=A0=C2=A0=C2=A0 # check if we are trying to mount root
>>> -=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint" =3D "/" ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "ROOT=3D$decrypted_par=
t" >/conf/param.conf
>>> -=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_expand" =3D "exp=
and" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expand_partition=
 $part_device
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # If partition is already encrypted, decrypt=
 and continue with
>>> next partition:
>>> +=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch=
-mode "$part_device" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | grep -q "luks2"; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partit=
ion "$part_device" "$crypt_mount_name"
>>> "$tpm_device"
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we are trying to=
 mount root, set ROOT to
>>> decrypted partition:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint=
" =3D "/" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ech=
o "ROOT=3D$decrypted_part" >/conf/param.conf
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # If partition should not be encrypted, cont=
inue with next
>>> partition:
>>> +=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencrypt" ]
>>> +=C2=A0=C2=A0=C2=A0 then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we are trying to=
 mount root, set ROOT to plain
>>> partition:
>>
>> And this is exactly where all alarms go off: We should not promote the
>> inherently insecure scenario of trying to post-mortem secure the rootfs
>> via an in-field update to encryption unless it is backed by some
>> integrity protection mechanism already (dm-verity in our case).
>>
>> We may encrypt certain data partitions post deployment if data on it is
>> not sensitive or is integrity-protected at application level. I don't
>> see other scenarios here, in the official isar-cip-core layer because
>> they are simply bad practice.
>=20
> I agree. Security requirements shouldn't just change after a product was
> released. But apparently that happened in the project where this feature
> was required.
>=20
> Question here is about if cip-core is trying to deal with it
> pragmatically and support it, or if cip-core rather wants to demonstrate
> the best-practice security implementation.
>=20
> I am fine with both options.
>=20

Well, as I said, there can be scenarios where encryption could securely
work. If we clearly describe them, I'm fine with adding features that
are needed to support them - and by chance also scenarios that no one
should use for security reasons.

But Quirin and I discussed further, and we have more questions regarding
your approach and its robustness: Right now, it looks like that
isar-cip-core cannot recover from a powercut in the middle of an
unfinished encryption. We believe that your approach is equally
affected. At the same time, the crypttools should be able to handle
that. Maybe we should address that first before adding something that
suggest it could provide a recoverable in-field encryption.

And please describe HOW all those features should be used. We might have
guessed that wrongly why thinking about their shortcomings.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

