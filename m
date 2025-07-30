Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9249C87FC9
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 08:43:28 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.web10.30607.1753865000429036002
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 01:43:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BJWT9iSm;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywoJDLt3f72A+RgbYgLbRzCi/qGjaXWCE76b2p7xlzDANQwnH+92yFqtNeYKtYnlB4CZ2jHRgSgf7x/Zy45fSXkJBa5kaLKFEhF1t9nJjmP1BKjwDx+nc8RzAD5K2z8qCquU6gfbPOvVFCrfxL5+4EjhsLH0isPrIgmNWELw0vlfhGfAD+PHF2quEyCAhC37bgkFFmm3T+LuZlXq0E+i1pibU5f3oKPFQ5s+00P6OOal+VmW5Slmoyz+hMCBLlWm+o5ko6tJMq+zKglS70qCSV0KwhzL+XCOiphEsfCtkjOD1snPUSPXVd3SrUf/3oevGbVqbCLREfq7ITSQE4jpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ0fSGaU8hamZwEbjImBg3KGzebw0Nnl5lEM7MpzpN0=;
 b=ivATN79W0d1VC2RcfZWQHqHzaK4szYvzUjrMTddgjhj7buHY7ENEfUAkWbvNWk+rK5/6wpzBnsy9n+MJfrBs/TXcKR3rooTptXiClqGpX6ocuv7mGJS/ECYQq93LCOs7cIwX7059I7IU9n5T/j5hVCrzBOCM0yjjqV6B6AAJnvj0EEJJMOye5IEiUcIXt7D0jEwg0gK3wsx9keWu9e+HxxMdzpkKbmydOA5TQuP7ax7ZWq4kjmHH7hqBDKWA1xSZf9d8fkvMABsb/flkM2/AkAu04w8jjiavn2tr+qILA583k/4f6R0fmzNKUc90DY7cNqUpHd8OZVUmGRJtIlh8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ0fSGaU8hamZwEbjImBg3KGzebw0Nnl5lEM7MpzpN0=;
 b=BJWT9iSmmKxVH3vEllOAQNYGF39NGo1dvdTPYODMbGWMuckbY1P5X5Bl/lX1L9yRFHaqPnUR0CgjfKPY155IAv7I1beql21hVamaSebJ/9e2414PAKZcTYt6Ki8zSYZlXEwBLeQvmbcJ9eOt3NWVuqSydOc8J2aZw4w13OgDM117PbSwTBEA/xbW+/C7ORARNP8EEpS8ZynvmsV4Vh9+2haz0EK2DlKComu4akWQcXMNdlTvSTj7nTNwSvXdP6UKd5/7JxwrRXOorGNzcKf9vFoyG8CBD230RhbVj0rXlD+sdDD4dtvgYjUgnAWn4SZyK8oTTFrsmbIiYTFb+0kRmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 08:43:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 08:43:16 +0000
Message-ID: <9d5f9bf5-1235-42ae-b387-e424bf15f1a7@siemens.com>
Date: Wed, 30 Jul 2025 10:43:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
 <TY3PR01MB110754BBC6C6B9E2D8B90BAD1C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <7294c0cc-3b39-4857-bca8-2258e2da9f91@siemens.com>
 <TY3PR01MB11075FFD9AD18F9025A11ED32C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075915C17031D280B208A16C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <643a6b8c-feb3-4b27-8fe6-f76a30ce0a3d@siemens.com>
 <TY3PR01MB1107546DA13B576633ABC1614C757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <2006d2a3-df31-469d-9fb0-09f0086b7b59@siemens.com>
 <TY3PR01MB11075AF23719F7D751E3D703BC757A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TY3PR01MB1107531A5EBAC974132D95A0AC759A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <TYWPR01MB110635C8A76AFFA2ADAC6B4A7C725A@TYWPR01MB11063.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYWPR01MB110635C8A76AFFA2ADAC6B4A7C725A@TYWPR01MB11063.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3313:EE_
X-MS-Office365-Filtering-Correlation-Id: a7003a7c-709f-4a1c-835a-08ddcf452090
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jjuDlAwJVaPFLhN+MD+ty4oEJjvCq7fT4ys+CbIiSq/eWVBGULx5m66OAEwX?=
 =?us-ascii?Q?0wfhnNA2yge7SvlRjKguhSFdQPh3Usd9lb/o+1AgbY5ejmj9KBfwuAxja7sA?=
 =?us-ascii?Q?wpuDQ3KnvMooD60OkcoOs12t99yRgCSCb8mZNktUlBkolfIntGqfPbDNLiA8?=
 =?us-ascii?Q?ABoM7x364sQhs97XJCyq4zOrZV/yh9rhZWCf/esb84w0/QOIszY8StW50Re4?=
 =?us-ascii?Q?vaRxARzRNhPmrxBaJx5xaeLsSigvkY/r68YSgqIJRdwlLNU7ZP/7eUtJXKjU?=
 =?us-ascii?Q?6qIzb32kkYE/UX0aLbiKixTDSdB6R2icMvJhASZkS7eaU97GbQdm/vmsGas/?=
 =?us-ascii?Q?o6QRnq+7cTENzzvI36u6QhDtzZCl1WyQrh3uqYqUBhXlkaE3Wv+EB+pIF2tp?=
 =?us-ascii?Q?AQEMkfWK8CoYlQWaCtuJxVxFeHIqB+8nzRoiw6Bw0PHpDTDwCOvPQALBVtjy?=
 =?us-ascii?Q?F2Ac6z0OpuDy0IwjuPgvgVCUhfiAH5EnR9i87kENx60l8IO47EWOz7eixlzt?=
 =?us-ascii?Q?CUUSrQ/rvLe87jq9NEuOW561AUz7vxYpwYm2sMYsdkEg/cJV6zCvIjL3ScQs?=
 =?us-ascii?Q?EynDDYIjP93cdY7inwqPbvQiVq57wFp2/nOjhTpEKQCFz0sFsxzdE03IX84F?=
 =?us-ascii?Q?YLob5rbJncd/gZrOeVw3xlryckXLb9KVytID4NRSNDY4aXtmvtL4JOQJtUFz?=
 =?us-ascii?Q?n6Bg8G1CeCd7JgjOlBZzE+xFN7jIz7O/mZyzKHz/XsZzguIeD4sZ3FMsIKWJ?=
 =?us-ascii?Q?LGOQ/hjGgT8BXSKr9LjklKa5vl2CagCGQA8gMH2AYicKixb+ORGX42PwYv9v?=
 =?us-ascii?Q?eJ+ha0ZUYrnd1GEo47w0A6CN0HL4qq03CqNvt9QheCfged+5BvHdlZWJInMa?=
 =?us-ascii?Q?hXz5o2Z2qLsLfvqTgQ1W3J2dYqqEssw/X+yZACBbBrJ+H/wLZ8ZvL2uWKFvE?=
 =?us-ascii?Q?EqGjWkOdZomcDZVq7ojlo1dYfLNCF1cabKNSx0UVqMHms2b+CgcwWxWR1ENP?=
 =?us-ascii?Q?icpgwOBaYlM5NmEYG68EzeZmlOM3t6fslXcCFz5nnS4Jmbqo18qdIdLKvk2l?=
 =?us-ascii?Q?VGr/uRElM/9lz3vCq8sfbMBRtNTt2oKYZrM3V5KwDXK+cGF/MuGtOjKnnJZD?=
 =?us-ascii?Q?SzdefcTVRAukkeeHFJLWS/pDbTXkGeMSPrjiGNN79cXZX5rkn/YuRgT0kWVH?=
 =?us-ascii?Q?IvfmO7U811zw8HwKryXQUVW4pLKR39AMds6JO/mNvOmNWR2c/bjRzMkI+Kjh?=
 =?us-ascii?Q?r9NyYcvKzTrQBJBw3DXFo/Nx6XauVIanDg5UMMkSjXNn73dO5ZHgF3NkoLet?=
 =?us-ascii?Q?vElb68qVXleF+sTMMzgmP1nU14kqv55KhuFF6xhoT6I0f7pS/p7EL5vPh0Aa?=
 =?us-ascii?Q?bjXJ4Qc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Nf6OOhlF2mfjQWjqOY8b+jl1QMviVJIkg3gJheb+P7FqD6yQcD2MQdX9vnEp?=
 =?us-ascii?Q?68pFL+/GzojvZKE81oK31NLUPi1J/jPLWuCz1W+s1MUjmXJcAk7TPHp1zBSF?=
 =?us-ascii?Q?RDrUCBaWRY6sslSnhy+ol+4yWYasdcUsDlS9jJ2zRifyandInsNQPeb3g5sU?=
 =?us-ascii?Q?/OdtnXhriK+asnNBOFSLDHqucn0QiAZRJLS2BYdNGQ5oZV5GL+8qlSdYcr68?=
 =?us-ascii?Q?jYEKAQtWhdW8pxVNvYIDDs0TjilOYqy0dl8tEn11/xQPiZAsOdBA0nVmp+88?=
 =?us-ascii?Q?71z39H38Bfj+Ctqb1qvjD9C+M5CIUN0wJAvw6lrz3F1FiD96pEZsgg4P2leQ?=
 =?us-ascii?Q?o6ml60QVTOgtzF2uj1+gW2g3Sgfa/AXRUkGrjA4Xk8utmtIZdsxiNAKog4U2?=
 =?us-ascii?Q?e5JO95edQ2G/2EdTiPseafzA5v2ZD2o8kNPfgSYy7Ce4yMuEuNmNA2q02k7N?=
 =?us-ascii?Q?5KCw6fbf3pqHXLD77UFjEdweYINO+es9sqV7Ilj/WXP4JNKIj5K9TSc5iudw?=
 =?us-ascii?Q?qi9cIaqMTcell3yOhFYp6k5GyaZotXbcpoNYa6jtBrsFj1eqfcT7+DXxDUrC?=
 =?us-ascii?Q?mSogik11i+P9coMiWHMPxS9oRpm7M7IAqySdk1x5HrPQlvZL9J2dCqDOoDxG?=
 =?us-ascii?Q?JPwmLKgZ08Kh/XQPswyvKQiQuK1POwQ/fpFmAy8ddcbXytjhFKUvs5A48ZTc?=
 =?us-ascii?Q?Byc23MNSjrFflevzzqMrwgtR9smxffU7qooYBSIlsrF2NTVFb/Sh8Axt5w/m?=
 =?us-ascii?Q?QRuRRPvJl19W9nX3/QNsyRIyJqLYC3McQ9Ffzx2bsSkJh6KWicBHtfUFLwzi?=
 =?us-ascii?Q?O17r1lBKvKLxkpWp96YN+JTG/GgbuO2n+81uW1EMAST+8WhWHtl+dpFHEZaH?=
 =?us-ascii?Q?fVrZ4sHgJb8pSCAHCoZoxAKbvWtWYCZjuP7DgSyopQ9y7U3MfyHGlMepQ55W?=
 =?us-ascii?Q?Pal4QgSG6OChrtP9ALHhNf4dChL6HVH20jETtr6BgnzcTtTVfZrbWTl570UC?=
 =?us-ascii?Q?HDI9besUKPZAn0VnbWtkv0r4So6qWC+5/YIUxZvqbDvkdkmtToOMZRyRXmnQ?=
 =?us-ascii?Q?2EQ6c7YtF/451f7HQPE00C6DqKttfj5DqvV4T4EJNrmqYhglCYVRGs+bz/nR?=
 =?us-ascii?Q?A1lB4gyGhWnfAJs0uL3nzlfAlGGkR8uY6twzXMIoJcV/W24c/960VGc+uXLC?=
 =?us-ascii?Q?g1cMlE4/18bztumO/FEJXdlh7Nnu2uvANZX0+NOMNUYkRaGXn7AlAtVsJAlz?=
 =?us-ascii?Q?Js7/DvM3MTDWKdma8ve59IWm0zyL/I5leOvTakr+2qaXEUeS/VMYFvUIARpt?=
 =?us-ascii?Q?CWRvnPSzAFqDVLN8KvzQio7O2E0WtCnExeSSN5KfpcPxeW65EgofoPWl0qZ9?=
 =?us-ascii?Q?9rTu9ZsQIZ2XZiObTtrPUfvrNJDW3zPXh/iDWXdSA2LQpO4ffV4q8kVelB94?=
 =?us-ascii?Q?SqA95bZKRB3/NFlXWuvz130ylcjWtQcFjG35WEmoQU/hhehCQdfrC0QCREZn?=
 =?us-ascii?Q?l618RUBqevmk/FOpxZusXZHsg86WE4ospRYko7176awWZtEtKKW/mCPvWGHN?=
 =?us-ascii?Q?osO2+6XFijn6rp7HANh6fKXtNACrjg8m6mIPV7At?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7003a7c-709f-4a1c-835a-08ddcf452090
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 08:43:16.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0fxS751ODAuesPv5bXibbrtXrFw5xzPKWJ1q+tROQJahmdDjWSuCsrjdpT9rdjrHTogT+seDCpVO9CB1P6TIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 08:43:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19620

On 29.07.25 11:44, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
> Any comments on the below approach for rootfs corruption? If this is fine=
, I would like to send a patch to isar-cip-core ML.
>=20
> So, the final command will be as below,=20
>=20
> $ dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-bookworm-qemu-a=
md64.wic bs=3D1 seek=3DROOTFS_START+96 count=3D8 conv=3Dnotrunc
> Note: 96 --> squashfs superblock (header) size
>=20

Sounds good to me.

Jan

> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-O=
ST)=20
> Sent: 25 July 2025 20:16
> To: 'Jan Kiszka' <jan.kiszka@siemens.com>; 'cip-dev@lists.cip-project.org=
' <cip-dev@lists.cip-project.org>
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dine=
sh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =
=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=
=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: RE: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detectio=
n case.
>=20
> Hi Jan,=20
>=20
> Thank you for the discussion so far.=20
>=20
>> I tried using dd command to corrupt ROOTFS as below (write zeros to=20
>> starting address of ROOTFS) $ dd if=3D/dev/zero=20
>> of=3Dcip-core-image-security-cip-core-bookworm-qemu-amd64.wic bs=3D1=20
>> seek=3D157286400 count=3D256
>=20
>> After the above change, the job failed with below error [3].
>> "Could not find device  mapped to 'home' cannot be encrypted!
>> Rebooting automatically due to panic=3D boot argument"
>=20
> I found the reason for this error, the above dd command is truncating .wi=
c file after writing 256 bytes of data to offset 157286400, basically the f=
inal .wic file size is reduced to 151M (original size 5.5G).
>=20
> Because of this truncation, it is not finding the file /dev/disk/by-partl=
abel/home[1] hence reporting the above error.
>=20
> So, I've tried using conv=3Dnotrunc option for dd command as below,
>=20
> $ dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-bookworm-qemu-a=
md64.wic bs=3D1 seek=3D157286400 count=3D256 conv=3Dnotrunc   =20
>=20
> Here, I confirmed there is no difference in the file size after executing=
 dd command.
> After this, If I try to boot the image it is failing at dm-verity verific=
ation stage.
>=20
> Please note the offset 157286400 is starting address of ROOTFS and I foun=
d the squashfs superblock (header) size is 96 bytes[2].=20
> so we can set ROOTFS_START+96 as offset.
>=20
> Example:
>=20
> $ dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-bookworm-qemu-a=
md64.wic bs=3D1 seek=3D157286400+96 count=3D256 conv=3Dnotrunc=20
>=20
> So, by the above command, I've reproduced dm-verity corrupted error.
>=20
> [    4.831137] device-mapper: verity: sha256 using implementation "sha256=
-generic"=20
> [    4.836710] device-mapper: verity: 8:4: data block 0 is corrupted
> [    4.837747] sd 5:0:0:0: [sda] Synchronizing SCSI cache
> [    4.840607] ACPI: PM: Preparing to enter system sleep state S5
> [    4.841498] reboot: Restarting system with command 'dm-verity device c=
orrupted'
> [    4.842894] reboot: machine restart
>=20
> I hope this method is fine as it's a very simple one.=20
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/r=
ecipes-initramfs/initramfs-crypt-hook/files/local-top-complete?ref_type=3Dh=
eads#L235
> [2] https://dr-emann.github.io/squashfs/squashfs.html#_the_superblock
>=20
>=20
> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-O=
ST)
> Sent: 15 July 2025 18:39
> To: Jan Kiszka <jan.kiszka@siemens.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dine=
sh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =
=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=
=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: RE: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detectio=
n case.
>=20
> Hi Jan,=20
>=20
>> Where did you read that this information is appended? I'm reading=20
>> https://www.kernel.org/doc/Documentation/admin-guide/device-mapper/ver
>> ity.rst,
> and talks about a header and some hash blocks following it.=20
>=20
> Below is my understanding, please correct me if I'm wrong here.
> =20
> we use veritysetup binary to create .verity file and that will be written=
 back to .wic file later. =20
>=20
> veritysetup --data-blocks=3D256 --hash-offset=3D1052672 format
>        <device> <device>
>=20
>        Verification data (hashes) is stored on the same device as data
>        (starting at hash-offset). Hash-offset must be greater than number
>        of blocks in data-area.[1]
>=20
> In cip case, device will be .verity file and the verification data (hashe=
s) is stored on the .verity file.=20
>=20
> So in ROOTFS corruption case using squashfs method, I'm not executing thi=
s veritysetup step hence the final squashfs doesn't contain verification da=
ta. =20
>=20
>> I would have taken the rootfs partition, added some reasonable offset of=
 sectors to skip the header and either hit the hash blocks or even the root=
fs itself this way. No regeneration of any squashfs, just one sector read, =
"bit-flip", write.=20
>=20
> Hmm, I will look into this, will try to derive the reasonable offset.=20
>=20
> [1] https://man7.org/linux/man-pages/man8/veritysetup.8.html=20
>=20
> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 15 July 2025 17:24
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dine=
sh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =
=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=
=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detectio=
n case.
>=20
> On 15.07.25 12:53, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>> Thanks for the reply.
>>
>>> How do you account for the dm-verity container here? What you get it ju=
st the dm-verity container start, no?
>>
>> Yes, from the fdisk tool, I'm finding what is the start address of ROOTF=
S (systema).=20
>>
>> The re-created squashfs image is written back to a offset (start address=
 of ROOTFS) using dd command.
>> In this case, my understanding is that the ROOTFS is not corrupted here =
but only it don't have the required verity hash details appended to its tai=
l.
>=20
> Where did you read that this information is appended? I'm reading https:/=
/www.kernel.org/doc/Documentation/admin-guide/device-mapper/verity.rst,
> and talks about a header and some hash blocks following it.
>=20
>>
>> $ dd if=3D/dev/zero  of=3Dcip-core-image-security-cip-core-bookworm-qemu=
-amd64.wic bs=3D1 seek=3D157286400 count=3D256   (157286400 - start address=
 of ROOTFS).
>>
>> In case of above method, It will corrupt the ROOTFS contents, there by n=
ot identifying  /dev/disk/by-partlabel/home file and ending up with panic e=
rror.=20
>> panic "Could not find device  mapped to 'home' cannot be encrypted!"
>>
>> Although both methods use the same offset, the boot will fail in differe=
nt verification steps.
>> If you feel the squashfs method is complex then we might need to investi=
gate further to find a simple step to verify dm-verity corrupt issue. If we=
 don't find any alternate solution then we may need to finalize any one of =
these two. =20
>=20
> I would have taken the rootfs partition, added some reasonable offset of =
sectors to skip the header and either hit the hash blocks or even the rootf=
s itself this way. No regeneration of any squashfs, just one sector read, "=
bit-flip", write.
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

