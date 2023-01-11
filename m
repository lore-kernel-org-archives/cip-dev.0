Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D6C46467
	for <webhook@archiver.kernel.org>; Wed, 11 Jan 2023 06:34:58 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.57])
 by mx.groups.io with SMTP id smtpd.web11.17553.1673418894992934693
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Jan 2023 22:34:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=xYDgsvpq;
 spf=pass (domain: siemens.com, ip: 40.107.7.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVwznHWICxQoWNRaUhPpqLxAmfBOef4gUEEdHWqkuTOYG0B8bUZZFFpQaCVTt9BaPL+sBw9pOF5KMGLasS1KsnjAACEKhKjkrFSbz8n1egyRA/qYNZ/r4vENpOULhZ7hg1OQ1AO29+iBEPW/UiM+LqZv9fZKGBVpn3nCJSHxAOTqZLR+sDQgZwj87uE20zqA9tQxzn+vlziXbVHMKQcVPPVzEViIlYDgwYngFGvfFRPjlJVRp1LbwqJYWlXaF2LY8Hd9FZKzN6gnofmiUksmtPlnoIszP1sYx8LCh/VP1B+s643kkUkdPfVs9CEsMnUUFVpNPHQoWBekZE92vHLUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGPSp+1JzLw3g+Tr+TjBXDpKmlgysU02HjV5HZyjirA=;
 b=RPxY7wm+KXF4gwkau8nKIFgY5A5etUqfSOWfRsHeaIbQOlBQurYTo6xQWK+I8x05saxxb2Yj9qqXSW6EHsgWDVTNmQw1pPsziPnQ92wFZgzvq9YNXlMDiZsKtuSo7uf8uiXB7sIn9C5rtYAObJCiMRHSJSI+VO/JBgApm++OaTXhkIy0AczzJIfNuUtyqs1fi+eYTId7j3dV8nWh66YhPGB5kga7J6jVnAqRkETqeA5/2i1cr81MhpQUBcNt2TbiKYyP9hlXeGplmkTQ4wY8OtMX3Cf2MSYfXvS6ELG27d7F/Ky0N7WetcZ7Nr7zAF6l2GBqg8I30FmzkmttqwhnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGPSp+1JzLw3g+Tr+TjBXDpKmlgysU02HjV5HZyjirA=;
 b=xYDgsvpq1qTlsWlwStwpqMsL1cE/zeaQ7SmQaSB1ZLrFHa3JO+zXA/qw4cWQ1mQSWVch7DJ831zn86450lb6NnkCYnDXraxd3kUQxfOeBdp2NjE5mO5yXigLHgSajoz60+53Ep6PvEkwdv6YKx8INKWRLg9F4dB4CR91GPOlrUiOTxiKAdCQg5m5/QaRZwa6V/HOj8slPsuPY+e4e/kvhL3ovhO+mnZKaRhvg5J0HGd4BrUo+27DrdrBiZd2x+hdMBdHP0rYJWue4Nsrq4sRI8FV8Q4PuLvhuhYgjwt+ExWrzM1cx2PwGUbgx2tzg8j4mKQszeEw5DmcydD/yeN6Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:176::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 06:34:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 06:34:51 +0000
Message-ID: <3a91239c-c0d5-e258-4d9b-ca454bad0a57@siemens.com>
Date: Wed, 11 Jan 2023 07:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Create a generic initramfs
 overlay
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20230110120055.463166-1-Quirin.Gylstorff@siemens.com>
 <308b3247-d201-317d-e3dc-ebf8edec817c@siemens.com>
 <dcc2133a-68f5-352c-138d-bb5e5ae86569@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <dcc2133a-68f5-352c-138d-bb5e5ae86569@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3793:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b95ea9-1e2d-4585-b12c-08daf39df175
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rFlGwkYOxXF/6RF2hm4Kp5qJ0zzZvpFdhAQ/MmBkEFEpHHaXSjUBcBKX1aVasLTeL3yovEq57dy/anBLIXdxvAlJO3qM7zNXK9zsGudXMGwdBaEulwEcqv5ktqNH1Iv++Zof+QBfAw+6jd/qOu8/8sq4vzEM326TDpFhB2l0wggZKeCcXL+ycpoAee9Cmu+YcnRp0GmP49oDdNkkenwGz8xSNXIX7txrEhzwUSoch0Pg0T+WLf+bX8oxDn69n5/44t8bSYxVt8rRAgyGhHXV4dyPJujR1m9ZYemZUwlKneSUqthuLDh4WCbmpYXng31mDxfrlUD3JMcKO/ObMKOPmpjJ2mAhkfiaMsfT2ioMQeziZce2mUdsravDKC03kDizfhajeSAiU7X/PEF5QmKKVp764+jgy3KDZx54W6ECHsj/0tvGMrWOfxlL2En+9mUwq/YOby9fMvHksfbzdXGQ13YB+9DXxNww+uBmaobf0oJ2gzI0yhtX8FcJwvQPzrA8o7pk6iloCchZA6gfFV75rbXDkWG42jR0dxgRPWRwgf7GLYLEiJpguVFLxQgVEt9r929Mq1FQ6cVOtUZEyX7SGSrHryzxe+bm5fzH/L8J/j6J6cw6yVDHGBzZXwUO45t35X7n54mk6rdrDNI5xOA55TkrwVSjzyvW1ctQQGbzchzwaQXEVVMu8yhb2WIkEBbzrg0E21EgVkc3+M7GSxaUgV92GgBMr5V68X3tvPZCnUJuILVOi0BXTew1+ZOq/O1c
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(8936002)(66946007)(66556008)(66476007)(8676002)(36756003)(83380400001)(41300700001)(6506007)(186003)(26005)(53546011)(6512007)(6486002)(478600001)(86362001)(2616005)(316002)(6636002)(31696002)(38100700002)(31686004)(82960400001)(44832011)(5660300002)(2906002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R9xXySKR7lMNJmEA8U908ZHdbbMCK/fWQhAwZCOge4LmHImKDIjvYdo88Uea?=
 =?us-ascii?Q?Hd60HA2zyq1FTS/QELbwNCqGFlP+rOs4Lk8HO+kj3JTVxNCx0PEPeAroiHQP?=
 =?us-ascii?Q?1rnYeTzFC7VHqTe90x0fgjfGLiysPzsHE3u1TQSzAO3NywVUgT0PkUunomEO?=
 =?us-ascii?Q?F2z00hwfWhmIWj+aUU9D4oxEgg+uMAZMEN4BnOFa2FpoTM+1xuaSvl8xk8u4?=
 =?us-ascii?Q?rcdXau82MVE4AB3uqr2PxulKjGQfrNkCDdtYsEUsV2JroldY6X3gD0bSkjGC?=
 =?us-ascii?Q?BsKeNk0KBoeC8Nh3o1AFPmWKQnUckg/4vSxqUjQwer0YNN9y2vGQEmV+ZB5N?=
 =?us-ascii?Q?kaHdrazzztNkrYOW+E1/L2WtqWZc253l8At+osUwyXeRhu36jJqh3VbMDIDN?=
 =?us-ascii?Q?vSif2LA1tUb9AVCWrxL+pvMEP3jZGp+1iPbjjlqKRj8CmGqWGSpQS9R+xlre?=
 =?us-ascii?Q?rYkg8nIWABEvymxA7/DXuTvr3rkfRuxPwQKGg2Fv3yrZMekW5e5Mvfiss6O5?=
 =?us-ascii?Q?Mt58WUBRDuzXc/zO981yhxzqG4qfUEx5+JmqAxL7Z7dC73Xy0iaPxGosDG43?=
 =?us-ascii?Q?FqrCq9PwbGIn4SGfiBCCO+2HCh3YELbRe3eMY0vJxlXvrb/DK6FB/Peu0+ia?=
 =?us-ascii?Q?l6Y1afHUlqe4fRTBhJHCZt3QdvDXrobDOun7WJfCj3qKafsN727kwhuFJap9?=
 =?us-ascii?Q?YUKvE3NxCE2NqN2N0mbtvK0d8OWOCUUM4t8B238CSrSKfN0Cy73yIIju8qMO?=
 =?us-ascii?Q?PjwEIAVCqFtjgCutrjCUq40dWB42ONs2+YJTUBLcNVO10EgiYru+9NH8hNo6?=
 =?us-ascii?Q?5k37v0IJuz4fxCJDRTT8HaEx0BceyMGTnALqkTtq35f9JTvU+QUZrmyPUJgV?=
 =?us-ascii?Q?kb0PZezqpGWEFJbURPTN6Ln83mn3IAYAxw3Njw3A6reDYCRQvM6rCkIxipQQ?=
 =?us-ascii?Q?Fw6KAaRMReJ3XQvhHSO27fQNP7vb4oBkkRzjgysy3YMvmABFUyAzeCiJsjhR?=
 =?us-ascii?Q?SEMbpOvNfYAQfdq8w71S56IZcSfRF5+fpkPVXwZ4UQEh8w5cyYLijt2EbBHB?=
 =?us-ascii?Q?tzhSy73Ro7/43ZJ/bbX8JPeWp5xxXWY0+RInOAGr1pcowtLOFSllLW3s2s3B?=
 =?us-ascii?Q?SzMhvrdq0EL6YfNdCuKwpOUX7WAmXKcYL+senYhtTztnDegt3xO+HmQHxvf9?=
 =?us-ascii?Q?dSRIcJpHJMPr0VQyVKwZzM6jNoJ/j3HsPC/G9eX1dFjaMigG4eAGH5fslpfd?=
 =?us-ascii?Q?1YmIgCMRbvjMeywqKjXxbeXIFsH+YQferLwIhzoBbmGn2oKEOSc0jstBbSsO?=
 =?us-ascii?Q?3Jn90CbcPmGCeDAm5KnxE673M3Zm6WxNIwj4Vzj1o4hdmSdE/80eoBtNNWDP?=
 =?us-ascii?Q?UPd6CUao4woKsB/2WBRKqXq7+cibIdSvjlv5C7Ra4duv92sBisy7h2K81Icc?=
 =?us-ascii?Q?gPcIPF0vvW5p9Cv2SvsKyVXw+k19IvP/A3B7LWnON1X6Fc6iim4v4kV+1PTL?=
 =?us-ascii?Q?LbhnlTd61/dUtLoq20+kL+A2i/hk87j72fdmtx1XhOiw/7oOCjXtgvdmlj/Q?=
 =?us-ascii?Q?T+E2Rc2nfB/XtEWjNC6trXSSb1xjB6nVDLLqfr0uxvFfzrb7jjNYwRvui89h?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b95ea9-1e2d-4585-b12c-08daf39df175
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 06:34:51.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: levGntY03Pjde4BoyIin8vu9iyCjiE1TZgJZM/HoWAKxQH6S1OkLSLQSf9AHHqUAntM875Ru5O5x3UQDEQV1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jan 2023 06:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10341

On 10.01.23 20:01, Gylstorff Quirin wrote:
>=20
>=20
> On 1/10/23 17:38, Jan Kiszka wrote:
>> On 10.01.23 13:00, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows the user to generate multiple overlays in a given
>>> location.
>>>
>>> The configuration used the following variables:
>>> =C2=A0 - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partit=
ion
>>> to store the overlays
>>> =C2=A0 - INITRAMFS_OVERLAY_PATHS: space-separated list of overlay
>>> directories (lower overlay directories)
>>> =C2=A0 - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition
>>> where the upper directory is stored
>>>
>>> e.g.:
>>> ```
>>> INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??=3D "var"
>>> INITRAMFS_OVERLAY_PATHS ??=3D "etc"
>>> INITRAMFS_OVERLAY_STORAGE_PATH ??=3D "/var/local"
>>> ```
>>> This will create an overlay for `/etc` and store it in `/var/local/etc`=
.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>
>>> Changes v2:
>>> =C2=A0 - INITRAMFS_OVERLAY_STORAGE_PATH contains the full path
>>> =C2=A0 - updated copyright
>>> =C2=A0 - formatting
>>> =C2=A0 - fix typos in commit message
>>
>> Could you also explain why my other suggestions are not feasible or
>> reasonable? I would still prefer 2 over 3 variables, if possible.
>=20
> I can add the 2 variable version but in my option this makes the
> configuration harder to understand. As the script tries to mount
> a partition which is not mentioned before.

My suggestion only makes sense when the partition (label or whatever
identifies it) can be derived from the storage path as it is mounted
already or in an fstab that is accessible. It that true?

In any case, please make sure that INITRAMFS_OVERLAY_PATHS can be
specified absolutely ("/etc") and that subdirs also work ("/etc/foo
/etc/bar").

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


