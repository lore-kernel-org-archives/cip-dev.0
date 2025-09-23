Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9034BCAC5A7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 07:34:29 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.28])
 by mx.groups.io with SMTP id smtpd.web10.11237.1758612861393876611
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 00:34:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cZBhw9qU;
 spf=pass (domain: siemens.com, ip: 52.101.83.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1cuho4esuuPStpZ2def9Ik6bnyLLtIRLONOCEEa7+akC4BQM4n7EhALKmHH0IPt+TE5O4v29Z0wB814Uij+BcjHAodKMhguv9J4n6Eb9hLyQMrR0LrCm277NSR5SN16oPYnYSNXeIQZ+KApej6HdOR3kaLA3GPk1phPvbI8+bm1euhGj7qLwj0FS7AUUFAjoiQSeAseasEBLxu6TJc6G9gT6m6rwRacLkBshDHjT4t/nwyQjhxao0GUrBLdsTct0WTZJRs8dtvW8mRhSA/ecIqAgsnXuqYzCbp/cRP+kbddwqhHriMKKnOI7tDlFPghYYkIrQDpt1gEsTl09mfFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG0jSMT4b7C/ytAr0u6sBUxzRdxu2Et/YP88Qm7qxCk=;
 b=hNNCXkv9T2nrR9I/db9COJBkftf7znt7cZzutoob+jqDFnAeWIe9FWDtC3X820bv9xeeoO7tkBxgg6t1U9BTu+QFCcbJ1MD9kaBD6cXuOMGLwMFMgYX9jJUtHTTrwpHjO5QwKAf3flEqGQAQumSbkixzAxntQwjR2EiOjs8W4kLVTbGjKriiwDZ4T6FslPWUZnapi+uNS4aeND+42A+LAsh5ViqlxU+U8Lpuexv8EXgefyC9bQqW7vETLun7RNu91vP7lyqz+iV2zoq5hjHWHF6L3t5OISl4C/iDWyHR8OjS1t+tWh+1Hr2tNSMGntc5yGfvF3oWN8apb1a9Tk3bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG0jSMT4b7C/ytAr0u6sBUxzRdxu2Et/YP88Qm7qxCk=;
 b=cZBhw9qULA5qyMeLB1PMkmvMuhj+3z0ebWENyMfSOASmcvDm1p4d0EIX7rCwQD05mD3HqB/8hFo2ZdXUQ3GCQSVp0/2u2Pome3RSdjkaHh1XV6a5LYqzV41jcEdC9TrRg9e/H26IsKHEOduNFN8EYZbPp8mMt/Ic/YOW4d1Pn1OkK82BekJxYdg2lfQzTHm5WWyNyOxQnDFShy4f7K/63VThSHq2xvAhG16EUzPeZCGPfeGFIFWZdZiNpziHIK1AgfV+ZyIo3YjNVJueDSY1m0Gj81iwbYpXIoKmguxvE0b71W+GDAg4oObsHdUNWLP6GyBVw3nqSVC4GfF0bRz+Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6368.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:34:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 07:34:16 +0000
Message-ID: <91ae62b5-a467-4046-a371-d682b1a98525@siemens.com>
Date: Tue, 23 Sep 2025 09:34:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 4/7] Add factory-reset
 information to encrypt-data
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-5-Quirin.Gylstorff@siemens.com>
 <f21857f5-b5ec-49de-b847-377403c7de94@siemens.com>
 <09676e81-ab0f-4f98-ac5e-a9a1bdd51110@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <09676e81-ab0f-4f98-ac5e-a9a1bdd51110@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 54db7284-6b51-464a-7931-08ddfa73998c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yFveh9L/grDIClqevFgpPqmjSsWTr2cVy95BIw0Y5iN8Uy4+516jq6qjjh9S?=
 =?us-ascii?Q?u+qVI4BMxRKVXRwCI/57/iH0ovOb9cvSX+sJbVUw3WL47KAHSG/pRXY/Dseu?=
 =?us-ascii?Q?vcasi9UJPYtqBgYA5yYk29FRJjP12rP+7i7RCtze0T9Wm45ZETmHr5Xy73Xz?=
 =?us-ascii?Q?crnpAoEgUE73sdRGw7hZKJ+7pqHzkkcKMgh7y950U1KJnC/Wfy5UtAucFVSl?=
 =?us-ascii?Q?lwF74oo0hhxJQf02xZNVf1hNzdj/pqxfSiJMvWz+Wj20vVrEN7awuz78y6D5?=
 =?us-ascii?Q?7uyEppUWJVSbH5BCsUQSmbsws+Lmdo3Zx+2Uv9yXeZ2Xp8ojbDqZmqpLz+Yv?=
 =?us-ascii?Q?DqSG1vgZ/sSFUrZx/5Akc2ETU0Uvck34KtGyoNxWQwtousXwnQSr1svJtyE3?=
 =?us-ascii?Q?CO1fMchkuzRho/4MLvkq4sp2brTp/mBg4alRFaAA1HwsImyEhJzTDr4Sr5TF?=
 =?us-ascii?Q?6ZN8eXcOGzRF0aADEarWMx0Hmie8QIxerQ8XIOfPMiK4V5eBEpFw724gao+z?=
 =?us-ascii?Q?vqyEl/bqPWKDaSCaw6upq+XuSeqChgyk2VgAzsyKcnIPsKX3IpoDxGNP9nL+?=
 =?us-ascii?Q?WrBqJJRFcZ/vfE8dlN2k5trIYg9EN4KlhCv9zht3UCFJomakI6v8jld2HjlU?=
 =?us-ascii?Q?2cBzzWMZLD0Lfj1suP2Q/MyUa5f9vAeIboT3LambWY5GaVzYKDb/vpDewlyy?=
 =?us-ascii?Q?SxRDKddJAYfP4LxvewiG19hvlocIKXJdIFy9Lp2oK64BqsaEsSnd4rvFahz1?=
 =?us-ascii?Q?L8pXwTEXPyb0+ybyYeVmzHIxSF4PcTs66RgwkJmeVZWJbZlDEjVSfXDh29lH?=
 =?us-ascii?Q?JC0ZpXvcqsg4K7IzcIhnePsUdg792LtLBUaoLc2bh9Q0eTmn2TNT5W9jILB6?=
 =?us-ascii?Q?Ajz/ylfw4tn+Gw5+2tvmnIyZZ5rzbBtH9Zsm6w2gsbVK8TY5U5JCz9xsJ0s5?=
 =?us-ascii?Q?/Nm3JZV6u99ZRTmxWSOztRG3JMd1YSOMskjcMCmsBOgAVYA6SbAYBHJ9LZF9?=
 =?us-ascii?Q?I0XkMJFZSxZteo2w0htR024L4zs/CEN9fgWTD3txyO+3syB8gHjAo6AXf3kJ?=
 =?us-ascii?Q?/dMuo1LFFGAgAz8xU/Mf3XLlyUPedXk78Eu4wHHmqdyP0mfaA+VvQHhaD1El?=
 =?us-ascii?Q?uxoiBZS+aFu3ongJ+yEK+HSo5lV4FU/cAE5tiAzzBF7Dr5ROes8Z3l4rip98?=
 =?us-ascii?Q?4hZLhEkpJ1v6yGXA/J5kgcdPvnrhJESYrEUPHQ3VXdDVlbXiTpSNfSecbw43?=
 =?us-ascii?Q?RlpJh6J2WOSAMq33i4vK7NXpjbkEr8lxCdVqpa+lbjx7Uc/EMGolr+QCNOg6?=
 =?us-ascii?Q?IrLLv9Z/ppPu+aNEpaXewIRKGZ41SCElRX3WHAJ12mqz/4QxtPh7sx/gZcW0?=
 =?us-ascii?Q?mhJsO/+JyzeYVvmSg2lyKUvgUhsLr1esSFIJ/+KIZOaWp+hNZ5xIkrNXXK78?=
 =?us-ascii?Q?DJV74LGQG0g=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6eOmALz4b1EFAXXeRLSu/86Rk6eUVNMYBR2MfwsHEkbJGwam+gLzcUmSUxwX?=
 =?us-ascii?Q?oG2I2y2O385HCF3doGspbuwGyHNhgRDd2p70M1YNYsli2biD/DpgVI2n6nDS?=
 =?us-ascii?Q?jGHvJYEQoMEM+TxE94rNtss0MyAAxpKjR8tynim3DxJVgilVjCO44JGrUCaQ?=
 =?us-ascii?Q?BQ9lbdd5ozVXvd7jC1gWewokoXBBGO9Qdt6QtHrgVdUXr504DudIV3JtvHQ+?=
 =?us-ascii?Q?gEPl8gH+7t9y2Rn44rl4FaIPSBWX1KrdFjlHi6PNU9uNaebJCB4W/3qBy3BE?=
 =?us-ascii?Q?Wfduj5XJxv7CPEWV06tRCZgFnO/CYTg4dQBuYa32eqeTHjAa5Y4XiWEAK7Xl?=
 =?us-ascii?Q?TlADArVNT1mmhODdFlMQiMXPqZzAxhx2S1eQ/9wh262skBdkXddBLMh3Nybi?=
 =?us-ascii?Q?GannZe0CvBlt8K14fhvabcT0ZrU9KuWhrWv+pH5HbEE+VI5FkVN8/qIOB8Vu?=
 =?us-ascii?Q?PhZotxRnkDCd2USW05ZkkBwFSGcEK+2RtJU7nxfm4cM3yl9eW7w4xzaMoPRS?=
 =?us-ascii?Q?xQ3NRvtR6SVDLsOq6qgYzOZpkgtNqGtILTHolp72uHjwKMD8JiTCmGmqcDRA?=
 =?us-ascii?Q?0ZrZ/HYsnVhNGJP1r4KCVXeWXWLy00HNnexi9sEfsJ0MzvMQoA1N7vXi1w38?=
 =?us-ascii?Q?y+S9DJFz5utEkP76aPN+T7RhVDAJ51/hgAU8IVBhVMzN3mHw9Nz6Idhbnzvk?=
 =?us-ascii?Q?/u6bkdgirjgiGKM6LLlU8gUcjTxsdk7FaN3p0hQrDG7yyS3cEX6zV7Sl5+Rx?=
 =?us-ascii?Q?cVjV+oJWZ6yUl7Nv/IikRbiNvY2XyVrm5Xyh14VZcrSjG+V1TFLRTn6460eM?=
 =?us-ascii?Q?8ja16QvArZlscMPWzpxxSkd2ebBsaLg3JMUfQ4SYAkFkeaF/EMD7m1evUZPO?=
 =?us-ascii?Q?jAKuRY6npydxetGiKR8r7a6c31V1ybaEgm78In2BLZTYw5hMNFFtUq05+hu5?=
 =?us-ascii?Q?BHrRcP4U+b9xy/qFSfYD2d9EwgabXK52FAhpYTwu/Kb7NcksiPELMJOWImWo?=
 =?us-ascii?Q?0/XtXKBKiysAmEUpKdbpkr/zvnCA7NymkBdckKvzlu7oQ+vpxmTkAUTpUHgk?=
 =?us-ascii?Q?Rxup8p903kvih7sgJHtF9dJFxWScuSxyhskAxPWAdCGvZdRa75897ntzptAL?=
 =?us-ascii?Q?awNdc7K5X0GciJDmh62ZzjP28uuGyF1AV6r2VKkRKHRSx5+HII59h1JO5COz?=
 =?us-ascii?Q?HRxyuuK/aSy3SROs4oT5zVVzrmA+2CcYTM53nUyBuq8J0JHsUDnIKmPHcyY6?=
 =?us-ascii?Q?N/nCAGk7W3S++sUmDxD4ECF8IPivlrsM5Y8kDiXVYk3yrH9pMmDgGzKWVbD9?=
 =?us-ascii?Q?2AsUnpfLVItWK3UnX1Adda8OEOgfIhybtJvEqtfafqXQQHcxSThdfYhYmAHj?=
 =?us-ascii?Q?jiv/RAoiMzLC3ETtLCsc5dNDxucJjkTAf6NJrjA/ySyCqBllwLEVZiEFCsy2?=
 =?us-ascii?Q?FrXTf6rr0ZyC9Be3bjD5QZ6gMKwGPDIvlE2K3Mmr52FE/MFqOkHYe3FZB1xi?=
 =?us-ascii?Q?AHcdyT2qyR4uM9dEvj+MtlKpl7P8EWH/5+4Rds1SbH/UW3vLKENz9WlEXTBf?=
 =?us-ascii?Q?mWSeCi+YuNqWcf8nZEBN+2lIj58y2scBhty7bm/y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54db7284-6b51-464a-7931-08ddfa73998c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:34:16.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EK1zRpQ/9mZJ08T39Dmz5RHJAMsqDk0Q/jCZ8pasN3Xtj+W3JPQY/TsWMUNPMAIuqYmY0q7n9avil6Vom7xE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6368
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 07:34:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20093

On 15.09.25 09:52, Quirin Gylstorff wrote:
>=20
>=20
> On 9/11/25 18:22, Jan Kiszka wrote:
>> On 04.09.25 11:39, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 kas/opt/encrypt-data.yml | 3 +++
>>> =C2=A0 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
>>> index 3de76ab..4292d4c 100644
>>> --- a/kas/opt/encrypt-data.yml
>>> +++ b/kas/opt/encrypt-data.yml
>>> @@ -15,3 +15,6 @@ header:
>>> =C2=A0 local_conf_header:
>>> =C2=A0=C2=A0=C2=A0 initramfs-option-encrypt-partitions: |
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OVERRIDES .=3D ":encrypt-partitions"
>>> +=C2=A0 initramfs-factory-reset: |
>>> +=C2=A0=C2=A0=C2=A0 INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE =3D "=
/dev/disk/by-
>>> partlabel/BOOT0"
>>
>> Hmm, it should ideally be the currently inactive partition so that we
>> are never corrupting the branch we are sitting on...
> Then i would need to maintain some logic which gets the current boot
> device from ebg and use the other one. I would prefer to solve that
> issue in a separate MR.
>=20
> I could also switch it to /dev/disk/by-partlabel/EFI but this would not
> solve anything.
>=20
> The best solution would be to forbid encrypted boot without writable
> efivars should not be possible.
>=20

The key issue for me is not creating recipe APIs that change back and
forth, even less across releases (with 1.9 in sight).

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

