Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABE6C3DA59
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 11:43:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.65])
 by mx.groups.io with SMTP id smtpd.web11.8694.1721130220099520912
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 04:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=EMhMI+jW;
 spf=pass (domain: siemens.com, ip: 40.107.22.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc4DcBXNAZE2XEPTnbOGsltNioRQvCOLr8tQy2upVAXEw8v+EQ5P5TuyDgPESPR+zIst8Z9KTi/6PgoVNTACnYO2d88IfFLe2KXT7bsF7rG/lYk6frJiMNvx15yw84N772jQHX6K1gYk5VntWK9bvE+IrO3nJhLV51VZ1Cwmg8pghnTPRKYBMqKOd8cBVwClKZ8JZtCEr3R/wc7nihxNOcwDKSQe1fIwlRaKoZ2fLTXP8uZE21+QCa/qVZhtDv3QKaFwq8Q1PqMN8+W2rDZ7tMzQvdpV8fevENctRQKtEK3G2qMPOCfE53Pa3QzfIn69X0r4GRufdBVMX9adLuWqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZXwNVD0ptZfkvbmYsi8tib5fMNLiXeIq448lvZV5jA=;
 b=b9T2HLIhTw0CKfKOHM0GPKHvdtiqXr0naqVs3PJxPMX4gQmmGisFPLblMOT+IJQCBkUIlpXin18preBXEoglKgSNCJU1/0Vx3KKWWWrRVwTLuyrJOFHMHl5MJ61JN9omTmxgMxM35Vt9pSWA5FG6dsJmhQQLnwu8dGwFvAtnrqLKDapeJ9CaepPDoXnKR3hvLXKA9vvmf+/mmBdcx32tCf+TCzeh9tD57S0bnVEHW8PpC5EwBQzMBX+uoKdnRH9Q+6ePEp4OPESOz+u2meH6/9f8JJXfb6ZDbPKwbN67dsGVu669YPAe4zHUcz+aQgnrZj/u0J6SjZYr6NO983yIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZXwNVD0ptZfkvbmYsi8tib5fMNLiXeIq448lvZV5jA=;
 b=EMhMI+jWGQJY8/Jc5H+vOUPUqlBCtlnlniE/HjsHUFhP6FhIAelk3mx9JKVxYM7tIhwsh9+sqrm7Ite7MQOvCpj3Td07ElugNjKJxv2znwLgYm4/KXOVpXiTancN1fqk5YgRf6S39V3zBy+UkUId4lhKM3Q6ezxlWg2fZdNIKFgd+Ij5SxuisOA+0Tt4b7nFEAhcMrMo9huCeWtPj9ivD1WVT0g4/SMQUe7U4lgqy6Sn/vBNHqXOUyAE/tj8FKGob0ZwCoc1ZXiHZ6sc1JgPDHphTYY1M2jsAiEEUcDm3Q9dgLsnmHf3CbyVED2Q+vDSu6+a7E/uXNj48ilgqzYpmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA2PR10MB8412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:43:36 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 11:43:36 +0000
Message-ID: <93151bc0-8e20-4f7c-91ab-7abffdb570b6@siemens.com>
Date: Tue, 16 Jul 2024 13:43:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] initramfs-crypt-hook: Allow speed-up of
 disk-reencryption
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Storm, Christian (T CED OES-DE)" <christian.storm@siemens.com>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>,
 "Adler, Michael (T CED OES-DE)" <michael.adler@siemens.com>
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
 <20240715134630.1640160-3-stefan-koch@siemens.com>
 <ea872d1e-8af1-4bb2-84f3-728f611c79af@siemens.com>
 <03d16527c1ead75ddcc84e67b90779ccce7ff6f7.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <03d16527c1ead75ddcc84e67b90779ccce7ff6f7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA2PR10MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7524640a-4b55-43ec-2c06-08dca58c8779
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AwgThjPUH8AS/PkofyijVPELEWrJkDsGA+EffRfdwH9rYsNElQzClPFTT0qZ?=
 =?us-ascii?Q?yc/1QWNBAjGf+++wfj7UV/KdaiJLdWGtJ/kn4QzdNt3G/fkJ/jGGNocfzyxo?=
 =?us-ascii?Q?otdWgxGVs/4BlQYQbSg1V1FlwdjXmdN7NoqDoFk4QxAAgf891tjuCkZKrqF0?=
 =?us-ascii?Q?QqkmSsA9uuTuU1xb3aEBkI98Mb9nScv8uw+KbHQf9zLiK8yjYv27sX5KPFqx?=
 =?us-ascii?Q?c9vaW18IY4TGNWXrgflOS8j5TJGpmxlZgnq9FfEiPfDWUbaqOcs6ggRaGuGL?=
 =?us-ascii?Q?wnISAoGSfq+etMqWkmkxLNDr+JnND1D40dDJvdrAdA/WYsdDFSfEbhchOJOT?=
 =?us-ascii?Q?dEGv6A+KMnTmI/gTpWtaBA+AuHeHzk7di2CHzJmenq0cZNBIktYIeBG0W/kK?=
 =?us-ascii?Q?xWmybgm2WedVRD+EyuKqXMRrcTlc3AcYR0yGSAY7UDYqrLhb1jaNV8JgmmeD?=
 =?us-ascii?Q?6e10ECqujH31WqsTDJmcAEyxvqpTvy4rjrZOGUmae4dhpJuSZgBXCMTk8rti?=
 =?us-ascii?Q?WsYa54q5GUnQHrBil8U0V+P7dG2aMnPF/XJc1KLo3TgrD2W4QIB8k1IE84OQ?=
 =?us-ascii?Q?hk2MMOcpm780CCYcLPf1PAEfhecxtQJXv1kkN1vhy7W7eBEkN7SOyLjgHZ04?=
 =?us-ascii?Q?RsquRYzwKFr3EkXvd3eYahhmnDyR293x1eiIhuVvO06wxQ0tWBHGwrgCdGpC?=
 =?us-ascii?Q?3y0M7tZhc+fYubVw1Qdv8fC1Aas14Fw4J8BoQRJnPORJhFgG/mU+UcEQPxwq?=
 =?us-ascii?Q?vetwKdJHxveaWMxfjpQNk+fS6PdGgrSatmeJ3by0XdNdU/c/uCC4Z3VDbpAO?=
 =?us-ascii?Q?KJOi8rudqAxaTl3W5fYT16TLmHOqoI9ZEwnO4/fIDLugSeQ0jLg17wZtLX4R?=
 =?us-ascii?Q?98EEU7IpLdKA/G9J5LUanHkEHnlEzdhnm7/UHrm58PSLtNBzz07MiC9GYHZH?=
 =?us-ascii?Q?3vCis3eydJuuEnGKQ2reZi0u/ZJMh8R/qUOc4YEG1u1VxmzmWrTOLAi4od0x?=
 =?us-ascii?Q?jSBWLZCaPq3kaVoM+nLByVuTJnuLdBY2bHbLJYHHCfy0TFpjDKZZdxot8NWb?=
 =?us-ascii?Q?vEUdLbG48EAhMelD9UelrCXZ0darSX8V0VMIQ+NbffeL8Jj7tWelThJxFStk?=
 =?us-ascii?Q?19ndWhXtielWX8c+dodz31RfUrSBx0eG8559zNOPvR8d7NNg803MjzjGdJ8G?=
 =?us-ascii?Q?bnTNUftwyWqgPkpOiZo7A0UbH9eVbi7l2UfYpyC/hA8a7ebLgxJeYR4lNJ4i?=
 =?us-ascii?Q?r7T5dDWBsLydHMu4fs6v5k9s9Zl0y7rBTOt9sGJ8U9VZCP358GS1yygnFo5h?=
 =?us-ascii?Q?5InHIznzXTppFWCEuCg2GpjAFtoKZmrOLG2zEshcXUET0w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MMtDkOsp8GNHvFjZi+xJeREGrMCyqjKIKEKgI/R54Yke73h6s5jdZZNiyUAe?=
 =?us-ascii?Q?pFICsQF2Ht9pkMOJME9PiR7qFCszKGwZTArIMoe4KTZQlBzRoHyQ1NjLPAJX?=
 =?us-ascii?Q?Bdd8OsBM/5q+mVwfZdjbtYDBrDIzO7uAOCyOrsrDaX8nh82hvAgW1WaYlDL6?=
 =?us-ascii?Q?wm0S8UIdnuh47ydzerK1c+cEgIzD5k0SQjKDWhyLVPulRo/0noOjhfwW0edD?=
 =?us-ascii?Q?fp4Hhao0Z9fpk7XRvQVS6NvwVjpVz0KQyo4XDxuSVyuOe9sJ72cNw9baWo7C?=
 =?us-ascii?Q?J+3+nUxsX9WwpS2ue9YCUuh0y9iTOPipDvqoczFvIrNOj6hC7E6FMRLfc6WV?=
 =?us-ascii?Q?AExYP020oKaP9nrvjLY3I81EaEr5OVoiEymKJacivqDdumkGwVaY8sUqIclY?=
 =?us-ascii?Q?yViHpVCYATGsz91zYtwuZHBO9/l95ml2pIhc3xpMDgpCBD7klwHBCv71QMRi?=
 =?us-ascii?Q?pTOOgwv/QEF+10m1LzXrqVWdMi4V5bF4Et6qPDQ0hzJsPmjPr4VPxp8/mU9M?=
 =?us-ascii?Q?ZzhQ1KHh51xU30DTgpGSPA5Bvd7SlNqMJDWHuERROsvWnlfWj7CNIUJtNGjL?=
 =?us-ascii?Q?9+sEt6snT+y92vIOri7lCF6/aP3PC9RTBVbGgZl1u9FJStQeGdYcm9RF55sD?=
 =?us-ascii?Q?Ska9ooY8Z6fmlL7S2tiJRfVXm+DRCMbSEmG4PFQty75u6wL3G/LLsuPPpC7f?=
 =?us-ascii?Q?ozvCbMZ6gYLEBEg8ngW3m1bVRwmPzoPm/SrPupt3ja6+JISTve9PTKgEi1iT?=
 =?us-ascii?Q?UsnFAmEAvYR8YYK3kQBZVK1vzIxBtgXVBaCjrtmr+2EfyWnkU4RB6u3a4I4g?=
 =?us-ascii?Q?v9JpwCSsKqonnOPn/HIHXEQyipgN8/nXvdMMPSpQ8BRA54m3FZbKTRa7FmfG?=
 =?us-ascii?Q?9exMLNrkI5kg1LOXTBmbCbM+O6iu8zHY0tdfTE7Kj5qf7C3v6SLSJjMnBeRr?=
 =?us-ascii?Q?yFf5ZmUQUMD41tcsaaix0G/TOWtl+Mq+Yi7xbID0D77CzLrjHgJNlXWjCdsf?=
 =?us-ascii?Q?WLnoNcZ178+PDRqIRLa5q0GUF7thtUUmmxFdHg7XVLQWZDhaCpwgxumfpX4H?=
 =?us-ascii?Q?zjZu38S/A2waDv0Xq+fpxuZnHPEeioCzY8Fu3ce6b7s7IZUFkX1yQl54HjmA?=
 =?us-ascii?Q?a/m145gl0mugNg8vkkDe+ibDdnRixnon9ZgyP5PwYOmHVX02//OxkqWAtaql?=
 =?us-ascii?Q?BzUe3pAJmyYK3wdqv9X0ZS3sCGUQkO/FoJBsgWo6rBTxCU1LYeaZ0+Nvx2/H?=
 =?us-ascii?Q?S23YLQWtybFzeBgEy9KDEVu3VJEQLariuYjxsZGdyVtN6P6ZtqbsV/vWrB2i?=
 =?us-ascii?Q?Cqbz9z39nPHY+iwGMkPigpiP3eRra707e9e6lK5pMMyrCh1JczHr981Sg78v?=
 =?us-ascii?Q?PEAqB9YYwLRkW0NcRV7mEJ0IeuEaiHgfElhlAfmgKQRTxfW5aF25cKZRPpEP?=
 =?us-ascii?Q?eogg2ttyLCsjNVZrZ/W7nPInO9duCWpDs18BnjZiXrWXzxQ2DluQncPT3uQo?=
 =?us-ascii?Q?/SYZLrGXHVs1kcj5lzIu441hW2sh6KPlUMDspPjbCExcorJ235VuwnhlPwKl?=
 =?us-ascii?Q?3vRkgmRi5L3+/choiz4DdK7+0qA+qIcpRCRxs6AIK5CN4uLUuWdHnODIjIcr?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7524640a-4b55-43ec-2c06-08dca58c8779
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 11:43:36.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXAMaeEARZaz1beCmQAQLv8PBM0ao3pRncJ3Jx2lsd/tjkN7vQlHLlQM/Ba3QwhZE5KzGebWy3auizZ7TEdWbsogkCCn46uNR5mBtJojnTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 11:43:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16559



On 7/16/24 10:13 AM, Koch, Stefan (DI PA DCP R&D 3) wrote:
> On Tue, 2024-07-16 at 10:08 +0200, Gylstorff Quirin wrote:
>>
>>
>> On 7/15/24 3:46 PM, Stefan Koch wrote:
>>> As the reencrypt mechanism doesn't work at file system level
>>> so it wouldn't detect used and free blocks.
>>> This means that the block-wise reencryption process could
>>> take a very long time depending on the partition size.
>>>
>>> Using the format mechanism instead of the reencrypt one
>>> would delete all existing data (without wiping). This would be very
>>> fast,
>>> because it doesn't matter whether a block is used or free.
>>>
>>> Set CRYPT_FAST_REENCRYPTION to "1" to speed-up the reencrypt
>>> process.
>>> So, this would be done:
>>> - Obtain used space of the unencrypted userdata partition
>>> - Shrink the partition and resize it to the size of used space
>>> (minimum size)
>>> - reencrypt the userdata partition now with smaller size
>>> - Expand the encrypted userdata partition back to the maximum
>>> possible size
>>
>> Why not simple use expand-on-first-boot. It has support for encrypted
>> disks and does this without adding something to the initramfs?
>> Quirin
> When using it on devices that are still at customer side, shrinking is
> needed, too ("reencrypt" of existing data).

So we are talking about the case of updating an existing device with a=20
expanded partition.


> But keep in mind, that a power loss at reencryption will destroy all
> data. Because the key is stored within the TPM *after* reencryption has
> succeed.
Then let us solve this by trying to store the initial encryption key in=20
the TPM. Instead of resizing which will have no impact in the worst case.


>>>
>>> Some disk encryption implementations like within the Debian
>>> installer
>>> will overwrite the entire partition with random data for security
>>> reasons
>>> (e.g. wiping old already deleted data, hiding metadata, etc.).
>>>
>>> However, this speed-up lacks the described security benefit of
>>> implicit data overwrite.
>>> So for security reasons, it behaves identical to the format option
>>> (there is no support for explicit random overwrite within
>>> initramfs-crypt-hook).

The initramfs must not do that. If this is required it should be done in=20
an installer.

Quirin
>>>
>>> Keep in mind that a power loss while reencryption will cause data
>>> loss
>>> (with or without fast reencryption).
>>> The key is only enrolled after fully succeeded reencryption, yet.
>>> So, no recovery from already encrypted data would be possible.
>>>
>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>> ---
>>>  =C2=A0 .../files/encrypt_partition.env.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>  =C2=A0 .../files/encrypt_partition.script=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 53
>>> ++++++++++++++++---
>>>  =C2=A0 .../initramfs-crypt-hook_0.2.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 +++
>>>  =C2=A0 3 files changed, 55 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.env.tmpl b/recipes-
>>> initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>> index bb93361..2b02f55 100644
>>> --- a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.env.tmpl
>>> +++ b/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.env.tmpl
>>> @@ -5,3 +5,4 @@ WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
>>>  =C2=A0 HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
>>>  =C2=A0 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
>>>  =C2=A0 ENCRYPTION_IS_OPTIONAL=3D"${CRYPT_ENCRYPTION_OPTIONAL}"
>>> +FAST_REENCRYPTION=3D"${CRYPT_FAST_REENCRYPTION}"
>>> diff --git a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-
>>> crypt-hook/files/encrypt_partition.script
>>> index f943aea..7bb40c9 100644
>>> --- a/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.script
>>> +++ b/recipes-initramfs/initramfs-crypt-
>>> hook/files/encrypt_partition.script
>>> @@ -54,6 +54,9 @@ if [ -z "${create_file_system_cmd}" ]; then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0create_file_system_cmd=
=3D"mke2fs -t ext4"
>>>  =C2=A0 fi
>>>   =20
>>> +# Path to full (non-busybox) losetup binary
>>> +losetup_path=3D"/usr/local/sbin/losetup"
>>> +
>>>  =C2=A0 service_watchdog() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for n in $(seq $(($SET=
UP_TIMEOUT / 10)) ); do
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0printf '\0'
>>> @@ -62,13 +65,16 @@ service_watchdog() {
>>>  =C2=A0 }
>>>   =20
>>>  =C2=A0 reencrypt_existing_partition() {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reencrypt_device=3D"$1"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0part_size_blocks=3D"$(=
cat /sys/class/block/"$(awk -v dev=3D"$1"
>>> 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# reduce the filesystem and =
partition by 32M to fit the
>>> LUKS header
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0part_size_in_kb=3D"$(expr "$=
part_size_blocks" / 2)" #
>>> blocksize 512 byte
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0partition_fstype=3D$(g=
et_fstype "${1}")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# reduce the filesystem and =
partition by 32M to fit the
>>> LUKS header
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduce_device_size=3D3=
2768
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size=3D"$(expr "$par=
t_size_blocks" - 65536 )"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_byte=3D"$(ex=
pr "$reduced_size" \* 512)"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_kb=3D"$(expr=
 "$reduced_size_in_byte" /
>>> 1024)K"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduce_device_size_blocks=3D=
"$(expr "$reduce_device_size" \*
>>> 2)" # 512 byte blocks
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size=3D"$(expr "$par=
t_size_blocks" -
>>> "$reduce_device_size_blocks" )"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_kb=3D"$(expr=
 "$reduced_size" / 2)" #
>>> blocksize 512 byte
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case $partition_fstype=
 in
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ext*)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0# reduce the filesystem and partition by 32M to =
fit
>>> the LUKS header
>>> @@ -84,9 +90,31 @@ EOF
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! cryptsetup luksUUID "$1" &> /dev/null; then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
e2fsck -p -f "$1"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# shrink partition temporarily to minimum
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0min_size_fsblocks=3D"$(resize2fs "$1" -P | awk -F ":
>>> " '{ print $2 }')"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if [ "$FAST_REENCRYPTION" =3D "1" ] &&
>>> loop_device=3D"$("$losetup_path" -f)" && [ -n "$min_size_fsblocks" ];
>>> then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# set =
encrypted size for expanding step
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encryp=
ted_size_in_kb=3D"$reduced_size_in_kb"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# mini=
mum partition size
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0min_si=
ze_in_kb=3D"$(expr "$min_size_fsblocks"
>>> \* 4)" # blocksize 4096 byte
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# shri=
nked partition size (reduce_size +
>>> minimum partition size)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduce=
d_size_in_kb=3D"$(expr
>>> "$reduce_device_size" + "$min_size_in_kb")"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# set =
loop device as reencrypt device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reencr=
ypt_device=3D"$loop_device"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# cont=
inue with default reencryption in
>>> failure case
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0FAST_R=
EENCRYPTION=3D"0"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ! resize2fs "$1" "${reduced_size_in_kb}K"; then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
panic "reencryption of filesystem $1 cannot
>>> continue!"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if [ "$FAST_REENCRYPTION" =3D "1" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# use =
temporarily loop device to simulate
>>> shrinked device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# beca=
use cryptsetup uses device size at
>>> reducing
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"$lose=
tup_path" --sizelimit
>>> "${reduced_size_in_kb}K" "$loop_device" "$1"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fi
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0;;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0squashfs|swap|"")
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0[ "$debug" =3D "y" ] && echo "skip disk resize a=
s it
>>> is not supported or unnecessary for fstype: '$partition_fstype'"
>>> @@ -96,9 +124,14 @@ EOF
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0;;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0esac
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -x /usr/sbin/cryp=
tsetup-reencrypt ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/usr/sbin/cryptsetup-reencrypt --new --reduce-
>>> device-size "$reduce_device_size"k "$1" < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/usr/sbin/cryptsetup-reencrypt --new --reduce-
>>> device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/usr/sbin/cryptsetup reencrypt --encrypt --reduce-
>>> device-size "$reduce_device_size"k "$1" < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/usr/sbin/cryptsetup reencrypt --encrypt --reduce-
>>> device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ "$FAST_REENCRYPTION" =
=3D "1" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0# remove temporarily loop device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0"$losetup_path" -d "$loop_device"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>>  =C2=A0 }
>>>  =C2=A0 for candidate in /dev/tpm*; do
>>> @@ -182,6 +215,12 @@ for partition_set in $partition_sets; do
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
reencrypt_existing_partition "$part_device"
>>> "$tmp_key"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
enroll_tpm2_token "$part_device" "$tmp_key"
>>> "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
open_tpm2_partition "$part_device"
>>> "$crypt_mount_name" "$tpm_device"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ "=
$FAST_REENCRYPTION" =3D "1" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# expand encrypted partition to
>>> maximum
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/sbin/cryptsetup resize
>>> "$decrypted_part"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# expand filesystem within
>>> encrypted layer to maximum
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resize2fs "$decrypted_part"
>>> "${encrypted_size_in_kb}K"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
log_end_msg
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0;;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0"format")
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-
>>> crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-
>>> hook/initramfs-crypt-hook_0.2.bb
>>> index 3497d95..e3dd515 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>> hook_0.2.bb
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>> hook_0.2.bb
>>> @@ -57,6 +57,13 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt
>>> var:/var:reencrypt"
>>>  =C2=A0 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to
>>> create the filesystem
>>>  =C2=A0 # in a newly formatted LUKS Partition
>>>  =C2=A0 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>>> +# Fast reencryption state
>>> +# It uses temporary partition resize,
>>> +# consider security and data reliablity aspects when enabling
>>> +# (e.g. wiping old already deleted data, hiding metadata, etc.)
>>> +# Keep in mind that a power loss while reencryption will cause
>>> data loss
>>> +# (with or without fast reencryption).
>>> +CRYPT_FAST_REENCRYPTION ??=3D "0"
>>>  =C2=A0 # Timeout for creating / re-encrypting partitions on first boot
>>>  =C2=A0 CRYPT_SETUP_TIMEOUT ??=3D "600"
>>>  =C2=A0 # Watchdog to service during the initial setup of the crypto
>>> partitions
>>> @@ -68,6 +75,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
>>>   =20
>>>  =C2=A0 TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CM=
D \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_=
DEVICE CRYPT_HASH_TYPE
>>> \
>>> +=C2=A0=C2=A0=C2=A0 CRYPT_FAST_REENCRYPTION \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OP=
TIONAL"
>>>  =C2=A0 TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
>>>   =20
>=20

