Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1928BC282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 12:29:35 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.42])
 by mx.groups.io with SMTP id smtpd.web11.51808.1741004965329363854
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 04:29:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=l0096TN4;
 spf=pass (domain: siemens.com, ip: 40.107.105.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fsu6Z1Q2XuXEgVDOm7BcadmDWTm9wzRqRBB/M4i03IIc8CpYPZFYoT2ZvUOShdkKQeUnallm/viJzF15N7DWhMm3GeVvxkKY+0knsLGJwE44QX/k5u4+OF/zq64fiWnZxey0bEgijR6psd3RVjxWN8umwlmlX4/xi9Ctzjo8JARM3IYAkJ6UzfKU23M3EKO9I0zCEdWgoAelk0Xwd/gm4JzMM0NQZWv59dIKNNTHMmdDN1x7i88HDniHwuQhFj3qCGLNSuExPnU2ToUQmqNnJ4eAmGazogV8suOIQkYJ6YleiVXXf27h5gSMnmJgVlANTBC3oSDUS9egQkqYcAMMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgHxiep9u06UzDtbgm7MlTs8M2w5LDS7l/+HfH1u6ho=;
 b=ByiDofMGx0ad+WOfHvDq017NVlFHbBDQgdinGBwp93+sieovS4N92XGax4CsdcPNyE2nPLKfpioPj23jkwdq+TPeM8mWTDLlaFD5UixqoSvYDlTp/BrVW53CrY6ua74TlnAKVv2r2Prj5j7bhwftl5n0W6QKyEPjXixciS7FxMlXupFsKHKvSZDM3V76zTdLNVTNJmM42NcnJ4ypg94DDo6pSWbHgy04fSl6rnXzxrwRaZIMqz7xa9IQqmoQv/X1oNR3J5XHjdjCIEru4bpeb6MmuQibh0XYbWwFeCJKnKWAaqZN0Bfc8S7XUsdDtoPTVFW+0hP4gdlLvrl+cPFkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgHxiep9u06UzDtbgm7MlTs8M2w5LDS7l/+HfH1u6ho=;
 b=l0096TN4873pHH4SikAJH3Z5LHowXjj3FuOaBve48NH3p+tYBQaUY6FFtW/HhreRnuIey1q4K5aVc+OzLEi3OO4378QsTM9qLoTqzDWMFSao+Aiz7jKtdcvCHmvfQK5EwZDYmSsFolITbI3s2gw4qm8WwtnH7kofpr0Lxm5SqUYbG8OoT8yi2PTgJwERiZ+UzKnp0oLMrpKKQwhz7ZwsFsRCPPlPYuvq7YLbk6iOjt82eFL2juw/skN8Mgor+e38N/a2PGbXI2elXutd1Ouh9SZpVflFCcbpMZqb/yUMmDDT760eowHzCSSSi2XYwkWQwB+nbFeOAtxqewihIXh6Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 12:29:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 12:29:21 +0000
Message-ID: <0ca20183-6884-400a-a53e-73f74fd8dd9b@siemens.com>
Date: Mon, 3 Mar 2025 13:29:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/4] Move content of home to
 IMMUTABLE_DATA_DIR
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 ludwig.nussel@siemens.com
References: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
 <20250303112342.851020-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250303112342.851020-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f2b1c3-f3a3-4e60-5d02-08dd5a4f0687
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dnYvVlZtRXYwemRMRGFTMzRVdkRQNXVDT25BUkU1S3ZKaUd4Vng1czN0V1BS?=
 =?utf-8?B?bVA5czZGMHdmUGk5RWE3eGJWL0xsUndoSWVMNEcxcEZxb2NldGRzKzdIVEtF?=
 =?utf-8?B?T3pWdENDdG90VlQ2cXQydHY0eW5FUkJwbUQydjA4MHVHQWF5NTRCN2F2YnFR?=
 =?utf-8?B?VzQ4SWloYXd0NktoeWpnT2NXZ3pZKzlTSnZibzk3Q1FmY2NORjNoVWkzNGZK?=
 =?utf-8?B?SU9VOFJPY25DVzNxRXh6STlGRTd2bWdBNUxSMTR5OWVTekdHRUc5dStFLzkr?=
 =?utf-8?B?MS84WXowOWJZY0JDd01SOGkwMlViNFRTbkZiZmpSNitROWk4MHBNQ3lySlpV?=
 =?utf-8?B?ekNsRThYd3pmbFRkWDIrMDlKenlIbFFnNi9EN0w4Z3ZRci9UTTVWNGR1VlAz?=
 =?utf-8?B?UXF3VmF3dnFCM3dwaUxOSWU3U2dOZnVPWmFRMlBHcHFqRzNKZ1NmbWE5REEw?=
 =?utf-8?B?d0RMTzhWZDl2UVhHN0czUlpwaXVaQkdvQThITzVnM21ndEJKMGVIR1FWTWta?=
 =?utf-8?B?OVVScGV2YThXcENSNHgyWFVWYlZPeU14U1VKYmMyeDIyVllsUnRkTlZ5ZFFD?=
 =?utf-8?B?U0IyN1dtR3pkUVVyb1ArZVZHL3NUTnNpTnhFNnY1TkpsNTVCeVBXVUNqaDAy?=
 =?utf-8?B?MVU4Z3QxR3hXR3JOWndIalM2aDFiSFo5VWgrYlVaZ3h1VCt5cDZsem9lM2JD?=
 =?utf-8?B?ZzF5WklNYkZONzVSajVXN1FKZ3R6b1J2R0NlVlBMTUdRdDI4dGJVN1VuaFZG?=
 =?utf-8?B?eUl6NVhXNnFRRkwvTVBXc3hDK2c1Y1lBTUl6UDY5UVIyb3BDelZBdWJ1Qk93?=
 =?utf-8?B?Zkw2OGRmbi83ZXpkVkdqbVJLNmpxVzVuc3E1R0pic3NIK2JDc2drSUU0Q29a?=
 =?utf-8?B?UmFwcFYxME1sME13ckJtUkZrLzBGUzJuZ1k5U2VBUXFiaFFJVFRlWE9YSzNZ?=
 =?utf-8?B?Z1FlQWxEdCtoWGdocUVXdWJXaUNLZG9xcDdEY0IxSmMzM1ZRaWpWOHJiYzNo?=
 =?utf-8?B?Q2JBd0RXRzNLZUZMQ3J6Skgxb3ZGQWRmeW5EcUYvRWdqNFR2K0ZBMDFsUElk?=
 =?utf-8?B?ZFNjOVZpOUNmRmRCOUtDUU1HYkdKZEJJVERZd1YzVVVUNlJhQUIrVTNqR2xJ?=
 =?utf-8?B?ZzQ0L2gyVURtc2Rkc3VKYVZjY3ZneFNqcFBFU09WR2lLNCtWcXZNanoxRWZM?=
 =?utf-8?B?aFVxL1l1NzIxa3R2RldVT3l5RElTZi9hUk83T1FpSkZFTCtMR1lVMUp2bUdH?=
 =?utf-8?B?M1A0QzI4ZFh2VGZoak4yYmFRSU41b09LRXNtZ0lKNHk3MjNtUTNoanhpNWQ3?=
 =?utf-8?B?ZnNnenI0WWZWSFVENlJrZmVOMjdYdTd4U3Vhck1LWlhoN0piSWNUVk9ZUGxt?=
 =?utf-8?B?S0NVMnVVbkdpUVlOY3kveHhwakk4MTd6U2MyMEFSaEJZUHliT28zK2JBdko5?=
 =?utf-8?B?RndMY0djSUJUdkJlcmRFdGlUZllvUVpzSFhMZWVHVnBYMVNKTnRYSW5iQndR?=
 =?utf-8?B?OEh5OTNuN1o4eXJNbXpza0lyOTNFWFRUd2pVMW9NTUg5TGVFejFYRENGQWJM?=
 =?utf-8?B?LzFJQjd5MGQvdXV3dDdySVkwU245WGNlUXlrNUlTZXRBZjNtci9JYnlWc2J3?=
 =?utf-8?B?TUtWU2RNdTh5bmlwdWQvU3N3TUxIaXBnRFB3cmJab0wzUGdUWEF1dTEvNFVF?=
 =?utf-8?B?WDFRcmRlaDlkVmFiZmdVNTRHdCtTeWcrM3E4UUVCT3NGSU1BdGg4ZlJkNERN?=
 =?utf-8?B?ZnZQRGp0cWtISWNjOTc3Q3FMdzVpdW02dmNkRlVid3QvZWZEMjJBZ0VHS3oy?=
 =?utf-8?B?Q2xjZzkzektBNUlKTTh6eDZ4WHZodGJpRlNyUWt0Z1ZDOXpKcFFoVWl5d1pK?=
 =?utf-8?Q?Ut00bT+t4EcEv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGlSK0N2V1JaSmNmT0E1OHZSVWFTcHp2eXBYbWtPZGVSN0FsMklyR3FqVnB6?=
 =?utf-8?B?V2M2dzh3aElGcFNXQjU3V1B4K0d2UmFDT2I1eFhNNXpIV2haem1PY1NyRjR2?=
 =?utf-8?B?b2pDWUQ4aXpBWTB4c0M5M2lGdEt4eDlScHRsVnhPM01hL2FpSlhYcTR6Mm9r?=
 =?utf-8?B?NDlydUtSK0d2SHBqQWpYaWhvbzlxd3dQUkZ5enJNUmdHbVZxVUpHOHRwS2V4?=
 =?utf-8?B?OGsyMlZkNlJCSk1uanBPQkg4eTUycElxakcvSFdDdnRmUStGRlE5cHdRVXpx?=
 =?utf-8?B?SEdtRnRweEhzYzBYWHo0bC9CdC9FdTgzbTY0SldkZTAvdWhPMXRod084Njhr?=
 =?utf-8?B?am5adWNFODZvT1daTE8xbFRRUXhhTFdwYUxqN0lmd2pxUVNQUm5QWGMweHk4?=
 =?utf-8?B?cHJWUURaSWpHa0U0cU5vaWFDSVdtRUFoaFo4RHI1NytJbnZJc083QTBmUlFH?=
 =?utf-8?B?a2RRcVg0ZUxYMXlYb3haaGMwUFFkOXluTU4reGZuWCt4bXdsMnZlc2NjY1pP?=
 =?utf-8?B?WUY0K2MyeC9Eb1RoZ0hpWmtUdm1ZU0NsUVpaRG1RT2FiSTFCV0RUSlA4ajc2?=
 =?utf-8?B?K0NvSit4NnlBdnJwT214aENtQXNPNFBqb21aTlJPYjlvblQxV1NZZ2ZnekRj?=
 =?utf-8?B?ZzlkZDF1dGtSSVYwR1RRNjdnRXM5NlM3WnQ3YS9JbGM0ZGR6Umw2b3UzRmJZ?=
 =?utf-8?B?UTEwaGM0OGY1ZmMyUythaUd1T2JrMWh0dDFsY2VEZWxFMXV5MUxBcXVOZGEy?=
 =?utf-8?B?ZzNtWlkyb2drcGdYaGJHZ09xazdlRGhBT2M4TnJydUdaRjFBbXUycTA0dCtB?=
 =?utf-8?B?dXd3dTZFV2JjWlh6OG8wa1Q2QUxuV3M3OTE2SGJHRXdWSWdZelNSZTd0NHFJ?=
 =?utf-8?B?OVFBTHBvbmxjWXN4VkdOR0VBS2RoRThlMUR5RXZxOXlxd3JoTW44U21HVkxm?=
 =?utf-8?B?aEhYTzFsb0pjQjd2c1dCVDRMbDI5bDdEc2RWdEhjSy9BUjFYZytCWFlPZ0Jx?=
 =?utf-8?B?OGNMalFsNkhYckx4ZUtBMU1RRmhWV3d5aUZWeEw0VEtScDBjSTlOODVKcHk2?=
 =?utf-8?B?czg3Y3hadUdQNFdYL3BzT0MyeVRJT1JNQVd1UkdxY3JzZzVNbTVDWHQyNWJL?=
 =?utf-8?B?TW5PRDZrc1JSRFV6SFJoeWJQRFE3M0tXOG5ONHhYQ0FrZDlQeHAzZzZnMVhX?=
 =?utf-8?B?VnJMUUxzSHkrdHk3RmNnUkNxOG5sek5qcHZsbkkrWW1rVDJBaFdWZkd1SVpH?=
 =?utf-8?B?OXRxT0V3ek9wcjVDdDd3L0JvRGVvVy8vMXdhRjg4UXlwUFRoTTQ1Yy9pbHBW?=
 =?utf-8?B?bUdvQkJncXo2YmNkYUNORVRzVlVHU3JCcEN6OEZNVSt1LzhHK0pRbTJmWkxt?=
 =?utf-8?B?dTRZUCtIa3FtdmFUV1h1MzFwaDJBeFhuVXRqL2tKR3hlb0FUSlBXTFFMdDZP?=
 =?utf-8?B?bDZUNmJGd3J2bGc3K0QzdDNnNlZkZHZaUGFLQ1kxVVVid08yYVdXZ2U2RTVX?=
 =?utf-8?B?bjgvYVNNUXJKb0hENVdFL0VRZDRYZTBrakZ0eFV5aXU4MFJrTVNCZWM5aXox?=
 =?utf-8?B?bWNDaXA0SXJxRHIraFdmaEVZSGhYdDkyWGR1bGZJMk9TSi9wWlFlT2RUYWJy?=
 =?utf-8?B?NThralpucjlsOStuRGtvb0hDbkJlWmsvZDVEeXpheDFmNS9MV1JITmkyT0Ew?=
 =?utf-8?B?emRRQ001UFJVbWU1eEdpSUJiQ0VRcHQ2SldwZ3FtbUdKTlNrZzV5Nzh4dDQ5?=
 =?utf-8?B?ZkJmMXh0QU41bHV6YWtqb3paTE1Ga091dkVOYzZUaWs5TmMybW5EMURWV1RG?=
 =?utf-8?B?MlE5d3RRMmVPSlkxOEZXaXlLRTNlTlZaV2gzRTdRL0VOdlAxS3laYWlRN3Jl?=
 =?utf-8?B?Z01Vc0ZMR2M3ZmE2aFZqeVcwdXNldC93US90MFZ0MnVtVm1KREdhMW1ySWd2?=
 =?utf-8?B?QzlHdzlrbTdsS3VSb094L1dwNVpQY0R0OUhFL216TDVNYjcwbW4xam9paGlN?=
 =?utf-8?B?eDhpNHBLQ2d3b2JpNmk3d2ZJcVU0QWdsczV0OGRWTU9TcUlWL2pWQ0p6bzJL?=
 =?utf-8?B?SDZWZnZrVmFGY05XVGpuZ2NxRTdOWVhISmRYWDMzRHY1V3FzbjdaK296U2JT?=
 =?utf-8?Q?ByOyqBd+LlayfkJdkXDwMBGUt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f2b1c3-f3a3-4e60-5d02-08dd5a4f0687
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:29:21.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoVasFUj8f2qmTs+TojU9Qw+TtxjiR/8SdovYbcc5agFbizMwywtr4CqUHvAKs2PTWzuLnSGjIAlQlnC4K4bIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4139
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 12:29:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18002

On 03.03.25 12:21, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This reduces the amount of necessary partitions. It also
> allows to use a A/B-update scheme for the var partition.
> 
> This fixes issue #123.
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass              | 19 +++++++++++++++--
>  kas/opt/encrypt-all.yml                       |  2 +-
>  kas/opt/separate-home-partition.yml           | 21 +++++++++++++++++++
>  ...ook_0.6.bb => initramfs-crypt-hook_0.7.bb} |  2 +-
>  4 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 kas/opt/separate-home-partition.yml
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (98%)
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index 0c8ae24..4e70d81 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -14,8 +14,12 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>  
>  do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  
> -IMAGE_INSTALL += "home-fs"
> -WIC_HOME_PARTITION = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
> +WIC_HOME_PARTITION:separate-home-part = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
> +
> +WIC_HOME_PARTITION = ""
> +IMAGE_INSTALL += " move-homedir-var"
> +IMAGE_INSTALL:append:separate-home-part = " home-fs"
> +IMAGE_INSTALL:remove:separate-home-part = " move-homedir-var"
>  
>  IMAGE_INSTALL:append:buster   = " tmp-fs"
>  IMAGE_INSTALL:append:bullseye = " tmp-fs"
> @@ -37,6 +41,17 @@ copy_dpkg_state() {
>      sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
>  }
>  
> +ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
> +ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
> +copy_home_to_immutable_data() {
> +    IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/"
> +    sudo mkdir -p "$IMMUTABLE_HOME_DIR"
> +    sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
> +    # as the rootfs is read-only we need to create the link
> +    # between /var/home and /home during creation.
> +    sudo chroot ${IMAGE_ROOTFS} ln -s /var/home /home
> +}
> +
>  RO_ROOTFS_EXCLUDE_DIRS ??= ""
>  EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
>  SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
> diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
> index b6d4041..faf7206 100644
> --- a/kas/opt/encrypt-all.yml
> +++ b/kas/opt/encrypt-all.yml
> @@ -20,4 +20,4 @@ local_conf_header:
>      # As we use a weak default assignment in the intramfs-crypt-hook recipe we need
>      # to set all partitions
>      CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt \
> -                         home:/home:reencrypt var:/var:reencrypt"
> +                         var:/var:reencrypt"
> diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
> new file mode 100644
> index 0000000..aaf349b
> --- /dev/null
> +++ b/kas/opt/separate-home-partition.yml
> @@ -0,0 +1,21 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
> +# from the first wic partition

Copy & pasted?

May explain that this primarily provides compatibility support for
existing deployments with separate home partitions.

And where is this used, at least build-tested in CI?

Jan

> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  separate-home-partition: |
> +    OVERRIDES .= ":separate-home-part"
> +  add-home-partition-to-crypt: |
> +    CRYPT_PARTITIONS:append:separate-home-part = " home:/home:reencrypt"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> similarity index 98%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> index df335c9..80a4755 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> @@ -70,7 +70,7 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
>              file://pwquality.conf"
>  
>  # CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>[:expand]
> -CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
> +CRYPT_PARTITIONS ??= "var:/var:reencrypt"
>  # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>  # in a newly formatted LUKS Partition
>  CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

