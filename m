Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90931C77B7A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 11:00:19 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.81])
 by mx.groups.io with SMTP id smtpd.web10.27920.1685617211294417660
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 04:00:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fB1E5gQh;
 spf=pass (domain: siemens.com, ip: 40.107.241.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgVvldkSv7M4NurbcDFGNrr2pitttkvoENj5TPGSeAY8uYr2ExtEIwX0NKNmwwtsAs0Zgi/PxEFo/wd8B9x5s0hWwtMaaH2ok+giOqQQEZouosYX/wRr6ZObTlwja3ZwZbOfSSvhMQfG+Os+iXrmZ2jhctlIZgX5tT4x4YPmado0b7bKNBoVSgS5pcNSpwatrTDmXqeb4aGlIaLsclj1G30QSmJveTU1217pirltzD3nQylMSmmQHkZJIHHtvL02G7zcluI7PREwik8p3vT2cPqiK1sBa9yD1bp6HGrCkiJclBTm8CG6yjUy7Mn+pd06hCGCrUfkedcne3Sl0mHnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osO/0yO7rK8MXHH6qztbQa9lynkYYET5orONpOfLpj0=;
 b=QjK+cD6wbFimFHa9xmyr0K6LETCvT6jB3FK79MlMYIdIHnGQTL15zGygQSKvjyKVTnE7zdx5Dy4Ar4LC694vTcjv5GzBueb8ZC18mRZha+10O2WkR9EtLNZVNDfSbr/xbGEc7uabquC220kUgRzmdYAKC6ej+nTlo5Y7jo35xwBlz6YUfAuYTj2s9EHIgrFDETGvCsqmYoXjybzrV0QluKWWikVOdjggVX+NGtRHi3ZAeWnUXElk3MjsyvS/ZAdpXvxylb7Grd4nokdTHBHvd+7bJgIBJ7StnOMoi8z9rPA2ayFZByEF6KlZ2vegSRf5LfsdU3Oyo1HZAQQzbqBf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osO/0yO7rK8MXHH6qztbQa9lynkYYET5orONpOfLpj0=;
 b=fB1E5gQhojsPe/CEX+SRWVlZJPE9ECVbPcBZAvgU2GVo9PRaX1kMplZOhFE98mccIkmXzDM+NSATq0qg08KRsMqil6U9gzhaX3RdCt0Ja4ngjfEkNY33nIrxeH5xmewA559sI4GsVB+EXYnXSWMU2cnIh+05iSWqDiBg89VMOJW0UeFbbAsHRR/o3pVtjTlA2unSSqt1ROnFIRwot2oWogKowtSzvX7ou9Ste9bqMDW8tfoKJ8AyWPFJqSd9uVMmdtcqOnSV7xWrb15PEPWr8PZv36BLO5U6SFTuav3aA15v8E52/5sDaEZJOVvtnBGoATXdfoyH3B9od1bKu3RvKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 11:00:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 11:00:08 +0000
Message-ID: <e964e2c4-b7af-bcc9-2e65-48d680254a96@siemens.com>
Date: Thu, 1 Jun 2023 13:00:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reproducible
 checks
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230601073454.1896-1-venkata.pyla@toshiba-tsip.com>
 <54ccb6ba-4a00-38b2-bc65-65a7baf86957@siemens.com>
 <OSYPR01MB5542A26EB39703EE7F2421E1A4499@OSYPR01MB5542.jpnprd01.prod.outlook.com>
 <2b4b63e7-1e6e-beba-3dd3-bfaaff1f801e@siemens.com>
In-Reply-To: <2b4b63e7-1e6e-beba-3dd3-bfaaff1f801e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9560cc3d-1214-49b2-affe-08db628f5ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fzmyegX0vDQr6316xRnk8HVbeDIt+VjrMBEmZxD6pb52y+y3N+TxcRcX+wU27lprp8gI50VdshcKFXF5hPr8OKzrTirnddMmu7b7hN3yQsp0FWIKZZ2DJP6r4btgmi083DXML74OgJs+rbMQyMTUuGU95QbhM+xOuqx0rupJVZz1g0t4/VJ5gzaz6XuGoI0CxgySpSCUpsEuObNPXcjGjRkEK9Wq7tE8mO0KPf61ENQoInvR9UuV651XiUlitQmZhWi6+d8+4k2BOkQgfTbwrvyv/vPZVYZGVNOUGTb5R40lACnbRKFfpPmhbBISJeeUbS6OYRPZ5FgDz4xoNcKpL78at0ra0miDB0Qy7w9ZM3Zy0OACJHtWJy7wHiJOgJ9jJ36wPzCl1m+vjJjyMlg2ngsOKqI0IQNd86FmAcVxS+LvuFkCvSyFg7PlltjAnVd8/weU1wIYgLZ6WdlBuTAh/qNanxr0pp8VVvXxPyyf/6aSUDtpGwzt0JZAv2/2tIgoA4GXu+EKa4QZiVFTwbhe746/5/NMZbuqCC/Wdz0BKEBGZcRDIB56xjPIT/jun9bZdAW/TEQFcHi0lyZJ6b3HwA+YleC2j7geFZ/oGzHBVYFt4/0X0cSlVkj1tZGa09eO16s+3Df1fS4ev7k606mD3Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(26005)(41300700001)(38100700002)(6486002)(6666004)(186003)(83380400001)(6512007)(31686004)(53546011)(6506007)(2616005)(478600001)(66946007)(66476007)(82960400001)(4326008)(66556008)(86362001)(31696002)(316002)(5660300002)(8936002)(44832011)(36756003)(2906002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uzcoWprDHUMbm8j2DXixUxZc4JhCH3ddQntp6wVdw8u1vEGyuqEoy64TplbP?=
 =?us-ascii?Q?nI/lBW7rpI8eTpZIX7QTOh3UD0qoD5GjD9wNAzbWn8j/JsxNrLSSx2Pdxwa8?=
 =?us-ascii?Q?+R4Q2jiVDTml+xABuVqiePY290copoJO+9qTnHBR4CmKdGNdf8K9L8N5ZJzq?=
 =?us-ascii?Q?J4qkWMRJXBt6cymvN6gNy/gPpx+2ZOo69Oy40aWsiaxCGJw4BOF3bR7hhKtC?=
 =?us-ascii?Q?p5ykPInjDlSk8GUl4qcdw/paOpDxhlBq80837bp7mOHy2AgJ7KqN47D0752/?=
 =?us-ascii?Q?TddyeHMQNZPa6CkPl0IOpq4kZHd0Jfo7E/ZOVE6XDmc2WTl3YwzGxhGF+6/x?=
 =?us-ascii?Q?e6wYLRYL/6NK6qAC22WMkkZEhEby0kUNOWOXQ+zicEXnGb/fbWvYSHk45xmM?=
 =?us-ascii?Q?JPZWQ38axPXFameRBpcO2XwORmxuKLmOHkPHvsw7z5rY8hvHeocEOghY/LmK?=
 =?us-ascii?Q?ZQPCvv/tVkaQJxIRnMlAUNGEAxMLMrUfDNMD4K/Vs3Oquk8n15eDsbn0xDY8?=
 =?us-ascii?Q?OFvGJ/VM89C46Nk9UvhX+uFZLyaMOulbXkXx3ShAGTUZsmU2uN68+SuwHEmw?=
 =?us-ascii?Q?HIJftVzwo2oseGLAmsNMvA3Wvnuhs6w6QLL2BGmq1FF7cwle59frk0hyUUwL?=
 =?us-ascii?Q?+PNBaa9rfRiE3ZubidFr9xf7HWtn4oMnibo0hzNCOMi21Mj/sw6kTmiDpaQ1?=
 =?us-ascii?Q?fG0eC2MGlLtn3gl1rm80+x2SmR1/OHRUxbJyzEPe8/N5ghcfA4mNBJbtOXIO?=
 =?us-ascii?Q?mEWFoOGrPiWq44DAwzMeDA927L7TRdjALqSnZJdpWleMVIikMApdEyv27fTy?=
 =?us-ascii?Q?l3VW1q/c87kgbAYGHXXV4k6bFnk8wtgmvpmlSWA8igX+E9dXSsEEiDkxVTpx?=
 =?us-ascii?Q?Dse7NSFOqA4KhPuD4uyzsXuaE4nP5ksvl1XOhYDwWwQ/fo9E6RO+WzzEn/t5?=
 =?us-ascii?Q?Zi76DDeRqtEhfJ8Mq1Lq5bZPFgsFi+f/GzZOA1MhzS3Bq5xl/xRMIcLZJwKV?=
 =?us-ascii?Q?4MCL9yr1/kugGgmUKKIJbgbzN3soQNnnRW+1U8e5Qy89VktpON3b+3AzVUKg?=
 =?us-ascii?Q?7WoeHlPopGbJtG6okI5G4pthT3lNH+MjHP26XEcvHPFCBp2twI5iiD0u6Sq3?=
 =?us-ascii?Q?gLf3YeTtO5KE8aNR1CltDpM05GC6/hUYk0RQrf33ez+XGEaCE4Bs7zF9/XJs?=
 =?us-ascii?Q?q73hHwKkI/QRRWOzsPBR+xAIbtYZZVmrVQZWUKjDIVi+3/B0nt5y70H13rcR?=
 =?us-ascii?Q?c4yRCen0tnAL/06IwJHaBY7rOAJ0mnmg+mm4b5syXqNYUgQSnbiZuhSvKEI2?=
 =?us-ascii?Q?N5XtsjIIeKR0grWuZeSXmUfDrpupFu4sudgxwDvQNOtYLFlmqexxjAi+VGox?=
 =?us-ascii?Q?ffs+Bv0wgFB6TJx38EccOdCOQi/ETjU4kMxTQ41muAwIMIIukaMGVIjaufSA?=
 =?us-ascii?Q?DAEkGtGON6kZRq53KbaKhH5QrRrl+U8sQ/sF0mm/Otkqc+hhkLN2K9zxh2CH?=
 =?us-ascii?Q?2PFmR9n1tn2B/Y64YeIThVVP9RZDEelltRBm+lM9QIjlH5TBOpbGffjVvmwJ?=
 =?us-ascii?Q?yFEGqwdd4KxBzGfOfaR3uE8BPzIALg7g5HMPr6rEvPpAVjrOYsTgxluYu2qR?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9560cc3d-1214-49b2-affe-08db628f5ccf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 11:00:08.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/MEH8k6KQ5NnBCL/ZXrQ/R3JSH0TVvRy/dICZtnF0NZd5ppEeKpq0FPBDZb4sgCO3AQIgumtyuhSF8RZW14Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4008
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 11:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11726

On 01.06.23 12:58, Jan Kiszka wrote:
> On 01.06.23 12:43, Venkata.Pyla@toshiba-tsip.com wrote:
>>
>>
>>> -----Original Message-----
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of
>>> Jan Kiszka via lists.cip-project.org
>>> Sent: Thursday, June 1, 2023 4:05 PM
>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting=
) <Venkata.Pyla@toshiba-
>>> tsip.com>; cip-dev@lists.cip-project.org
>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting=
) <dinesh.kumar@toshiba-
>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>> <kazuhiro3.hayashi@toshiba.co.jp>
>>> Subject: Re: [cip-dev] [isar-cip-core 0/3] Add ext4-fs image in reprodu=
cible checks
>>>
>>> On 01.06.23 09:34, venkata.pyla@toshiba-tsip.com wrote:
>>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>
>>>> Hi,
>>>>
>>>> This patch series enable ext4 file system images in reproducible check
>>>> CI, which is next step after tarball images are being reproducible,
>>>> let's see new issues in CI after integrating this patch and continue
>>>> to fix them.
>>>
>>> Can't we address that directly via wic? That's a way more common use of
>>> ext4 in Isar layers.
>>
>> wic images include partition tables in it and currently diffoscope is no=
t comparing the partition tables in the images=20
>> so, I am using individual file system images (ext4) instead.
>=20
> But I'm still not convinced that, in order to find a few tunables for
> mkfs.ext4, it is worth to set up a complete separate test pipeline. What
> would be next? xfs? btrfs?

And if the unsupported partition table in diffoscope is the issue:
 - fix this
 - extract ext4 in the meantime (kpartx e.g.), after building an image
   via wic

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


