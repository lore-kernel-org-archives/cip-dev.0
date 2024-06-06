Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE21C27C52
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 08:17:59 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.44])
 by mx.groups.io with SMTP id smtpd.web11.9266.1717661877641296276
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 01:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sF0JN+iR;
 spf=pass (domain: siemens.com, ip: 40.107.249.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6dqaCfHSCaqHG/qKJvupQAX7LRrFXq1qUty2BmM/njs2LT8VkPhXxqUqYI+yGtMrvfw9B8dBveNJ4/04xO6FcFfR3lo10Lv5wMtkHWL9jxSCxNBDNOxZ+K1n3DFsrHV3L4iETPHa7k9DP9aa8suqUkaSoolZ9FEmtdzWqoLbT/Tto2lV/TQbhdFfXwvje+6RrsJuWFB8Kw1z5RJoQn79uhn3L2/Cqxf8UTaK93By4unS7WDGHle0YKPjAMPf8oVBgfuje+9L6TI7/SfmHtkwKAI8bfLC4//J6+1OD6mWtsdWA9QvZ0PCkZkj+naKr6LeE8uc49pcfxUnAiOF70N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeTf3JpcnWRx9d0SWpVeAYO1Uv8wxZDRYwkb49nF5T8=;
 b=CAu50Az/JvTnuE04HY2ydgMzsSzTczOpUR8r8IpqVC8C/CFt2O9hD80YreudkGGXRDU2eONiAM6M65n22HaShgA4/UJjp3tXEj07rvTG82dZqE+E4Pi4Jna/8NHkjLkFAtkOLn0Au8fJjriXfOZQ4NyvUl/XIVy88iamd+TDCYndsA6L77lp79lkCHzV9QmgE6Scv/4PdYjNIAGw9JSyKI11Th0O3xH2O0Ii1YSUCCJlnPy473YZtepqHdj/U07wqR+XkTeEPLzUIjlWrsEAyX1MxgG8Xf8lR/zJone1LOOsGO2iw2u7F0JmVrzQD6jqsgT8uSFrYYvv3errbpAyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeTf3JpcnWRx9d0SWpVeAYO1Uv8wxZDRYwkb49nF5T8=;
 b=sF0JN+iRHIr7rCT8aWS94KqkN4fN6oh3DnEHBRPcqy0jHsytyMmGmb44fLjLtJvqNIXv+uRsrCV1jjX8KcHwLwuRCSXRDQ9hQxRvkvTLje/RQ5FOohlGjGKXOVhktM+ep7Ru4gucdf4cxJ2Gsw6xp8R7TRIv0c+Mw2LnPzS80gAdfgDOYuD6gp26SobcTtPADJf/To0nNLGPjJ5EOxeWTcvGtijtNykpww96pk8kxZJocTwBBwCr3PVxyu7LKKVIAYuZkbSs9IyeWrNgM310vfj7mhhBKCTAqUwKTsH+q//nfmUE9EU/KyDqTiR4beefQTxQbTLvYzbP/PYjtsWSVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 08:17:54 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 08:17:54 +0000
Message-ID: <35bd7c87-c345-4d45-8053-27c0cafe489d@siemens.com>
Date: Thu, 6 Jun 2024 10:17:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Adding swap space to the encrypted partition
To: cip-dev@lists.cip-project.org,
 "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>
References: <lc89.1717001504639248244.RWYi@lists.cip-project.org>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <lc89.1717001504639248244.RWYi@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3595:EE_
X-MS-Office365-Filtering-Correlation-Id: 990f4050-b4b9-42aa-0b65-08dc86012a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?c9zvW1StJPy5HUt7H6a8LgC+/QrEhHiMBQXHdFbQt55KMjsvAVB/FZFnjXgw?=
 =?us-ascii?Q?V8mvt1B2r3xwz/9UdA7IsU23C4PcoBtIfcHuWgCHA2nfJUMZSt3hz2+ns48o?=
 =?us-ascii?Q?yJJUx323be303GhyfYt+qSyd6d9jWBqrrjMTIpWMlXGxPg5wgoUQarITGCAa?=
 =?us-ascii?Q?i4TdMBp8nUY7S8VcYxLCgmSj348niLSS3eCaW4m3vz++8ovrySqRhSQxcbV5?=
 =?us-ascii?Q?V9vs7RSyQO8RGhsKz1ZU/4Lpyx2mhsUzOuFlx/uMpBBsMXoiSAOfzD86Y/B2?=
 =?us-ascii?Q?Co6zbH9Knw8TOfDc505gw9zohTIgWLbtJrgkzV4QFd6LiJFUTJfnAW+hrO+A?=
 =?us-ascii?Q?nJnwA7zNtUdilH6NNwZdeosIm3MzEyzyneAruJ6r7R5ZzO7X+1QAwDWZBOBG?=
 =?us-ascii?Q?lfPYHlVAmv5YV6bGz7Vq/dwPzT5ZYCHra61X9nE3h4pYi0jtUjj2jswLSzD4?=
 =?us-ascii?Q?bbD9SbC2OW2SYInrsI1qJ2mzax38opf/6lZO/Cf7KotQL9FYn99VD+Sl1q92?=
 =?us-ascii?Q?Ada/qcF68EwO/exPWQHoQsUJuyZVc58c4rdxgaHnR2jOg+ZId4VEYR0frmdy?=
 =?us-ascii?Q?0PD7EnTGNwtxrKejeqcUiRScikuhpnvW60/a7s5tmyT1cY4QspuCYQHoTkmQ?=
 =?us-ascii?Q?Q9RG/oEjXZ9f4oZCqAyK2EmJ4oRT3tp5l6pqJI7jRhwmzpGycZzpJwj1L06C?=
 =?us-ascii?Q?SC9Hf4TSDkGztpqLS/5XbU42KxRhGW79mqhXU87rh4XbKUzKaPvYpbFd9bMy?=
 =?us-ascii?Q?RxrG3jMI2+ZHevVGqqssdYd38BJ2MIYawEQwaIb6soqjTK2+ahkVHChr5MWr?=
 =?us-ascii?Q?DqQa+YlcP6xoglUKixo8G9OGTh59U4pH2JgU9uLxHToR3vJfe4jZm1C+LTtQ?=
 =?us-ascii?Q?JP1KvXIfecMOn7wUWPizD4GOt0PZimJeVwHUsp/edObMRHBfyLimSREHVM4T?=
 =?us-ascii?Q?VJLw/kBbBy7vaJrjnYEB4Wyd0aepSoUd8hfakHZyTF0bsQMTMxCCORoEwQbn?=
 =?us-ascii?Q?yFIavOBdkknObVVqqOBfSugJLVU+akAeherRsRkqMveBhPTaT8cRSywIJMrs?=
 =?us-ascii?Q?STHSuaZfFagusp8GzhmY1S4jqYikQ6HOp0PfzQYkYXXft3SxJblXZPN7VnQh?=
 =?us-ascii?Q?P2F2S3HLKQRDxDD1/cKWXZAw21WhiW0oBBhBThze6tpHFueK+jnj/Aur8diU?=
 =?us-ascii?Q?mf+JZcnsXeW5iDBaGgaH7hPVJMMiqlZVU0ueT71W5Z9y5zGOfGzkd4YuNtHk?=
 =?us-ascii?Q?PllKVK4Bfh5pX6N6oSYY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aW2NhpwG1QXWTLbnF1Yibqdne+L01GCNvvBahueFQ1E9GKHwxyv44v+k017b?=
 =?us-ascii?Q?1l9CWGypxUpmhS+/WtDo+5EicoQOMC7AlNAauMT7oAoa4l+EGapjj3hto2US?=
 =?us-ascii?Q?FIu9Bj3JEKCS5H2n1gOjhlIutSBvYiVtXDoO6xHT0yvu7hFFCsGe67TNIPU2?=
 =?us-ascii?Q?F5GwV9m7FhxBTE+J8TufjrMsgM8fjnzYsFrWDNYJnP5SpleJJeXXXK2yg4Y2?=
 =?us-ascii?Q?RROpQmVXpio2Zm1JRjjPQ1S+dJcQTZEoYktmF6aPQAcuR9eC474FXs44WMrn?=
 =?us-ascii?Q?jEA9lHsMz+4OADIkgNU/PfT5EyOnVWYCDBK8CHzHJ4ypUDgVeO2WytZTIw0j?=
 =?us-ascii?Q?ioAMWDh4nb2iqVlnyLCZmuZbXiqBBHUsoLDgqH/E6xLbfZih+yaAeGXRp3Mw?=
 =?us-ascii?Q?gEPnmKvMe6xx2xF4hsjamOU7K02P9ao0AwZuq0Yq95sZ++NjhQtSt0Ku9cQx?=
 =?us-ascii?Q?Qy4qXufP1YRFxN+sxc71b4M1gt2cjgGovcxEOTciS91sq6k2oOqg4+qDE4cX?=
 =?us-ascii?Q?6gwviAzgqEHxg9UBYi11gnYtGjKinJ3AmCW+XCxcxd3k77PDyvGqCpOx12G8?=
 =?us-ascii?Q?2G9UOnNRyp66SANrL70YhWYHIqu2fAyH6gcysYGNPveos1o+q7XjIIpf1ezJ?=
 =?us-ascii?Q?1jOzr6Lfz/PSFCwp0MDxoBzJ86Qxg/upH5wFjs1lcAR06/v8JZMnRwrKyOrG?=
 =?us-ascii?Q?OT/Q0PJueW7i4cpvBLhS9Cwkq0lHVlkBorAMGOP0B+ch1baLKVT+doRrRJuW?=
 =?us-ascii?Q?c02B1uG3JEZBHgyAdkoft+FJTkruiqUBuF/CWCMl1cZXKqPr/oO5bSy9OsYU?=
 =?us-ascii?Q?HN5rz9Xay78p+T/XsWXp1Bq16HnB+BS9VRoCOl5ycHJhfd5eiJUt4ROC2/nU?=
 =?us-ascii?Q?ifbyFLqWSQiaNB5bWoQHEAOPaLlS/aEaK3HFTDtSHiuD1cJifgsXzl5E7vY2?=
 =?us-ascii?Q?kLI2lkjVCToUTUV5uxvxWeuCk7RWDPNpbkAHOk87Ihwpf7gwYX4frv/qBaRR?=
 =?us-ascii?Q?89cknoO3Ki+MkC6ZRkOJfi04enuBW0a/Q5aMXuqYtHjxOCCdGTz8usBskf0R?=
 =?us-ascii?Q?t454119Lem5MtN5sfVGTGKlNMVR+kUmyA2xQlfuR5+qeKeRpwcDApC0FeQzH?=
 =?us-ascii?Q?qnetRxqiDk32bFJ0aV6SK9e9O2yD7N3JRy9FJPHEfOEV7PI0+gMGyB0pRA+s?=
 =?us-ascii?Q?rz54zr+CofT8kdqM8m7fCAgdCEEzTfg2YCDyX8EdALXkP1e83YBtqmbudspa?=
 =?us-ascii?Q?K638L3mGm1HkyM9bXG2m0bMQqTyBgvJI5kxy1tl4dNhvRwMqZLHH4TNhuXc5?=
 =?us-ascii?Q?7ywR4szKuKw6X46NQ5Bx7cDu9WSyqggxhf7NyyIrv07JPJ6x9qaadSMLXIuj?=
 =?us-ascii?Q?2BjTZacezaRFxu1zXVhUGU4Uz7rijNcUh2Y1yIMoOo3m5rq2tftEFtB23fAX?=
 =?us-ascii?Q?tXboTpuZLeY5weRCANqttoJod3nE++sQydScags5AUZplEO3O0rId0j6lJnL?=
 =?us-ascii?Q?9Yo+wHnDy7yPsLJrawAl/M92wmymwDL2FrLHv7ellWX4rG/2Dis8QYrdGfy6?=
 =?us-ascii?Q?guLLJYsSNfadiXv2+/nZn4hhExAr6NF3Q3DrQr4QCorTTxEeUlmqL8fTecV0?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990f4050-b4b9-42aa-0b65-08dc86012a83
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 08:17:54.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm8l7ucvTJf727SqARQdDpHQP5YmcNGMNpu+oeCBh5K29N24AwpkyCxTHPWmSbJYVYOAozrA2iCHNdGr0vZmIcCgqIC6OYlUiPvBEJ9xnPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 08:17:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16124

Hi John,

On 5/29/24 6:51 PM, JohnW via lists.cip-project.org wrote:
> Hi Cip-Dev community,
>=20
> Is there a way to add a swap space to the encrypted partition? Something=
=20
> that will look like
>=20
> nvme0n1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 259:0=C2=A0=C2=A0=C2=A0=C2=A00 238.5G=C2=A0=C2=A00 disk
> =E2=94=9C=E2=94=80nvme0n1p1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 259:1=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0 512M=C2=A0=C2=A0=
0 part=C2=A0=C2=A0/boot/efi
> =E2=94=9C=E2=94=80nvme0n1p2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 259:2=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0 1.4G=C2=A0=C2=A0=
0 part=C2=A0=C2=A0/boot
> =E2=94=94=E2=94=80nvme0n1p3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 259:3=C2=A0=C2=A0=C2=A0=C2=A00 236.6G=C2=A0=C2=A00 part
>  =C2=A0=C2=A0=E2=94=94=E2=94=80nvme0n1p3_crypt=C2=A0=C2=A0 253:0=C2=A0=C2=
=A0=C2=A0=C2=A00 236.5G=C2=A0=C2=A00 crypt
>  =C2=A0=C2=A0=C2=A0=C2=A0=E2=94=9C=E2=94=80my-root=C2=A0=C2=A0 253:1=C2=
=A0=C2=A0=C2=A0=C2=A00 235.6G=C2=A0=C2=A00 lvm=C2=A0=C2=A0 /
>  =C2=A0=C2=A0=C2=A0=C2=A0=E2=94=94=E2=94=80my-swap_1 253:2=C2=A0=C2=A0=C2=
=A0=C2=A00=C2=A0=C2=A0 980M=C2=A0=C2=A00 lvm=C2=A0=C2=A0 [SWAP]
>=20
We currently have no  support for lvm based partition layouts or swap in=20
isar and isar-cip-core.


Currently you could add a swap partition via *.wks, but I never tested this=
.

Due have the requirement to use swap or is this a nice to have?

Quirin


> Regards,
> John
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16066): https://lists.cip-project.org/g/cip-dev/messa=
ge/16066
> Mute This Topic: https://lists.cip-project.org/mt/106372674/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

