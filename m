Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FA7CEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 11:38:52 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7267.1763379513456383274
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 03:38:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p5lOeA58;
 spf=none, err=SPF record not found (domain: siemens.com, ip: 40.107.130.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INwb1W0h1L/kFhigXaPaEIYx36owpDGXIW4qLwaX7+ftCBel5DXZeWgeNfcgZz2nZTzg0HKAZnk6ci7vds5CEHB5NR/NI4s4HxF6slBbSngFwm0UeNaNmzl++jD2oJk96RUTNJMjx7IapyJeRLAVHoRoOoxeEMi4EkcG6qPIdljaH8drGbilNGhrn3DqB8pMNpFGjTw2/FLXXiIKxDCBGrzK3lP4skear9PtsdfpUagXio9wxpQc8LjJYAoFLIP3CunpiZMfaLMR3k01airNuMoUydu+qywUWvv5Wd8B3eCF99CT5TdoFDfyjpgmMUZzRR+O9qQlKEiPtno2sjDqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I11L5HHkwNc7woV9bffyefJnp+VvRc+isRELtUC/TkA=;
 b=AM76k/eudo+NKqRGQXzcOFddbBkL3BBvmvcxqqMh1/5XrKRNUJkDE0Ec3gGrWJOBfisQghEav7RWidsChXv1/bl3qiYoIWtspBH8ukf1cT4WYvPYMtxNY+KIcHDPjOMYOyCvMz1mzxMqpPHbzW8DZjMvCMLUAqmh2tQWnh1bXfPFC1MA+gkvaVRxL7OgedlDjvNZ6k83xYzveD3ep6pLeAm/DsQzkx6u5rCf7Yo2SSW45BZHKkqzkyL65tTFiPw9KSJ6l1NaiOSVzKqTv0ZS4/xooWLp3D8u+h0z8Ehl7zwNc7DR6iQR9Cjw19NvXMj0Dk97DEJos6d7cgAOJaaf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I11L5HHkwNc7woV9bffyefJnp+VvRc+isRELtUC/TkA=;
 b=p5lOeA580jYaclM2qQtkaIMtmVxVIMpHGxvs/xiqJ4o12oqZn1VYgnvNbt70Cm1w350d1YwWWSdFZ5tfxNTMq76aZTehrtdfr+4tbedvAK1svl9Z6zqYNvTJmUp/8Q3SyYQCZ+ChbkL3sB+pAsnrQIskQPlELrK+MrWYLOtA6Bq7oUaXKNlvS9/AXI3bvjFZkbtoQKQciVfdPchYvqZjv/VujuUy4S+gVeFgTUslU+U5lDP2wbZOVQqUN3vAM8nv7VNCNfQRW28LXuIUP4Zm8EyZnWL7sBLsb2CYd9T2R7tMaxiIpBlJAS5kZmEYwAkn9fSEpibIvsUOZXeXTms68A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3676.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:38:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:38:29 +0000
Message-ID: <f2c73b72-cbb3-49c1-8555-9341b3cd3535@siemens.com>
Date: Mon, 17 Nov 2025 12:38:28 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: DE0-Nano-SoC & KernelCI
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3676:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1e6145-cc51-4471-d808-08de25cdd469
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a0RMNjRMY0RJWlR0ZHJKQzh0TlBiTmhJMm4ySi9VR0hwOWQwbzNxVGZjNUJi?=
 =?utf-8?B?cDVKVC9PaVJtMHBxWGJKNVUyUFhIYzFMOGlJV0U4UHBTUVF1L25vZXZOb3h1?=
 =?utf-8?B?REdoQlR0bjNJQjgyQ0tMRW9EV0tOeHlYejVwYnBFbjMxTUtzVU5ieVFPODBE?=
 =?utf-8?B?SVYrVlhyemYrQWI0eHU3TG1yUDVDb1JoMVJuUEo3ZmdSSkRLZ0JyRldSK0Q1?=
 =?utf-8?B?dEdsR25KY2FiWTRiMmpnbnU2bDh4YmYxbk5JNlB0TzJ0SFdYUkVUUkVqbkNu?=
 =?utf-8?B?UjFsMUtWb2krWXZsQkRSNFduTk04ejVaUjVGaWR4MEtHbFYvOVpZelVaeEhm?=
 =?utf-8?B?NE1ERDdpYU9Ub0pQWmN4NTFidmZBZVFJT3huazRJMEIvaVd4cGN6N3pWNjUw?=
 =?utf-8?B?YWx3VlU1TlZZY0ZoYXcvZW11cmViVmY0RVZkSysyNWxBT2VRRUhmaktrbDdR?=
 =?utf-8?B?V2RGblkzN3hnY2FjY0p5c1JTcW5oMUVUOGQ4UTFabC9ZTWVhZVVqQklUWDZE?=
 =?utf-8?B?b0xLQy9HUzY2amJ2SEtnb09KTWZyOW9MK0g5L1djejFCN2RvbE5qY1hUQU03?=
 =?utf-8?B?M3VKb095VDVaa3ZSa0hSNStuaEtCbENVTk5EaDFFK2VXV2w5bUtnWmpQRFEx?=
 =?utf-8?B?VWgwWHdlblp3QlRWWHBRSkY5dXdJOXVTK1lzRmxnQ2RoZzRMaDlFVk10R3Ex?=
 =?utf-8?B?dGtsb05WSWJKL2F5b1JybkVKazVMUDlLTWk3aG05M041ejM3VW9zSklmZlBV?=
 =?utf-8?B?eEFhZ1doN3MzTjBydWxMT2o3MERzS2FWNEFzVWsranhvbVRlRTFya243UTZI?=
 =?utf-8?B?TCs0ck9Xa0dmY1N1YkZvb2MyKys3ZldMSzl4RzVUSXFWMkhQK2N5aTczTHF6?=
 =?utf-8?B?QnFQcDNzekk1VzJsY2RXd2orV0pwVUFHRWZpekd0dk5FZGpUWVlVczBsU2h2?=
 =?utf-8?B?clRoZlYzMFFMeElSdVZEMkt2YnIyY28zZERocjFXTGRVR3d4VTgzTE41SDNR?=
 =?utf-8?B?SUNZUUZaVGpZSU8xYVdNV3pES2xYVG52QlZZOGtQSnc4WWtmYm1CbDFmZTFE?=
 =?utf-8?B?RGYxbitQMm5mRjJRUFdQaksxU2psYkI4enBGcHhYOXEvVHBVZkxlb29RblZG?=
 =?utf-8?B?NmRkYitrWnBWc0huNGY1QndXRzJnb1M5YVNsWFdBdFZQelhGODk0aEVkYUo2?=
 =?utf-8?B?NWlMeUZnV250OTBvQnRyajhmazF0UFJZSWtVT05NQ0JTVE9SdnZta0JJb2xG?=
 =?utf-8?B?TU4xaWI1c1Z4V2hmWEgweFlLYkYyWjduUXlXTnZUS3JJZmNaaVhkTGRnVmR6?=
 =?utf-8?B?Z1NPSzhHd0lwb1dEdFVYc20vNXFSdHNUeXhNYjIrTDNCTG5YTmtoVUZxczN5?=
 =?utf-8?B?SDV0cEl2c1cwc0xUSExGNnlITG5SV3FYR3l1WW1OLytscWlkbk4zeDZFTWEx?=
 =?utf-8?B?QnR2YUFUL1dTSHJiUkhIeUNlZW5qU0VGQmhDaFJzUGRwbEpXWDdGV05wNVhV?=
 =?utf-8?B?RSt5SmRVb1c1aVRmdklNTkI5OXJKc2RuWVdMbEpTMk8wR0gra2VaU2J0RnUr?=
 =?utf-8?B?S3J3bGEyblkwQkdXTUt6R3JiYjZBT0xXSXRwN0FVZnQzS2tMUTc3MFg2dklw?=
 =?utf-8?B?NGNKaFVjTFBuQXRSZ2owZlZiVk96WWRNaiszQ3dVYW5ldkVDOG9HL0pDc1Rz?=
 =?utf-8?B?YkJuRHhPaTVMN20wdzI3RllsaVlCM0J0SVQ1ZEFMWnd3WVp2YmFnZmpjbmw4?=
 =?utf-8?B?enJPRlFyalpBV3ppYkROWGNYQ2JOVmhNNkcrbVQwVk5ZR2JLc3NZWkhaeUhC?=
 =?utf-8?B?cWhZSG9kVWpOTE42U0RUcHRUSGdqVXlBemlxbVFKOGpaVWlSeHNhQ1JTN0Ix?=
 =?utf-8?B?YzJiQWd1b0RTRjhoUVh2OXJFN05ON0x3L256SFM2N0FkRTF1NS9PcThKYXdh?=
 =?utf-8?B?N3p2ZTFQZWM2MDhQdmFjVVROemJZeEt0ZGhjcXI5Q0hMaXR1T1NZZWp6RUh4?=
 =?utf-8?B?L0g5SXYwenBnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aS91TnNodkFvdDJ4cDhWei9UejczUkdCQzU3SkNmU2ZoWW9HMUJyMUdrOGN5?=
 =?utf-8?B?VXZmKzY4RFptSENkOWVGTWIvR0ZyT0lKTFA4YnlWUzVYVTQ1UWNaK2ZtN2xn?=
 =?utf-8?B?emtGNjZ6bEUxdk5vb1ZwS2xJQmIycDZxSE9iNDFLTHpIclB3RzUvaFVpRUsr?=
 =?utf-8?B?b0tMamlJWGpDdGhzVndObjRFUXh3K01PQlcvM2hWelVRcHBIMnIxRUo5UXE2?=
 =?utf-8?B?SHVTUFRXV1dIbG1oOE5adUhoOGg1UHRHWDNLWWJrb3Noci9Ma09MN0kwWWQ0?=
 =?utf-8?B?eG1Id0hYQ2hXQnRDUkRJRFJXWVMwdjBsUXRSZ2VYMDBkZ0ViRXprWGxMT3VE?=
 =?utf-8?B?SWxmMkpEYWxBVVdkZCtPcVZoRzN5R29ZWGJKRUZ5ZHc3cmN4ekJXZlY2WU5m?=
 =?utf-8?B?d3NNWkJ1b2lZcHljb0hsR2FRRzlWaEJPWUo0Sm41UUR0VmViK3ozRldxcWho?=
 =?utf-8?B?QzFUZGdBOWtmRXJuSExjU2JuWXNlZWs2SFF1LzhPWW1sZkJ0aVc1dnhNb0hJ?=
 =?utf-8?B?Nk1jb0VBTldRNUhMS3V0bUNjdk1GMXVZNm5BTGl5VnJiV3VRbG9MdmlicWV4?=
 =?utf-8?B?T1poWGU4WW5EeGcxTG4xU05Kd2VETjVtSjBSTXZpVnVwdU43K3BXYWl6a3hy?=
 =?utf-8?B?REJKbFg4a1ZDKzJpOTU2Mm5WUWg4U3BJeUIvWjlONE1Va1ovNitsbHVUVklT?=
 =?utf-8?B?R1VHb3M3cmFhUkNIcnFaVzRlZHZYa24wQXAwbVpkVFhnZWJNSExoYUIzbXpE?=
 =?utf-8?B?U1ZLNWNuNkZFWS9uSnNSbllzNjlVSGxNVVVBdXoraVRIQ3ZiYk56Z0pHUzQ2?=
 =?utf-8?B?OUlTR0JOWlI0Y1YwZUMzODgxMmF3d2JsMTZ6NHBWekd4RDhtVUFoWjRjT3or?=
 =?utf-8?B?UzRZZCtsZEU0cW5FRzJMWUJiSmgrVi9LMWxTd1NDak5PcGJaVzhJSjZMaVpU?=
 =?utf-8?B?d2UwRHNtKzRGdzJxSTF6WERSazhuMHQ1ZERuMkpRUi9jdjNjOEszaFFpZytG?=
 =?utf-8?B?alJ3WGh2NXMzY2VYZnhoc0s2a0FiNUxVSFRER2xmL0p4UmZyWW5weTRxZUJh?=
 =?utf-8?B?ZG1ZaGwwVXd2cmJFVmh1R3NyNVFQYXFuVXR5NUtaZWlrZTFESTJyb3dVSjZU?=
 =?utf-8?B?enNZZHRjeVNXUDgxTE1SY2xDNkJhcFN1dng1ZGh0RFN0N3hNc3krRmlsQ1pF?=
 =?utf-8?B?ZUNESGtWcm9VcFZmbGY5K1U5eFlnaTRzTHFhUWw1WFhnZ0hHK3V1MFlhRkQv?=
 =?utf-8?B?REgvb1JsR2kvYnVEMzA0c3FKMnFOMDNtTHBVR0FiU3pUU01KS1dLMUwvL2Rv?=
 =?utf-8?B?RlN1MlFPbDMzQmxUUnFNSVZSZUxwTlZ6Z2s3TTRVVWRxZXp0K3RvVzlxK0R3?=
 =?utf-8?B?OVJ1cjI0RTZIMGFqRTQyYW1ybklIK2ZUZ29ZVHNaVGtQcDZQeDZPUlFBMi9j?=
 =?utf-8?B?ZUdUS25IbUswcytrMGJrQW5HZ1I2a1R5Q2NOTjNoamlCT3R2MlBhYnNTTmFI?=
 =?utf-8?B?b3Q4NStNMCtmWGlraTJhbUQ0QTBGdEhaeHJ4MWYzVmpHWUIxbkZQQ2pWN0t0?=
 =?utf-8?B?b1ZENXE2MnlUc3ZTUElsOWVIUWVyNkFVVmM2SzRFcWdFdkpsVVRJNVJ5dDY1?=
 =?utf-8?B?MHM3NHBIQzJxSjN6UmUxYVBBWi9lTTA1Z3JYY0ZDTERrTVZQWWpWV0k5NWdn?=
 =?utf-8?B?TFpsSG9aS3BLdnllL0ZPTnNpbG5OYys2Y3UzT216elk4UDlWbGxUd3krS1dw?=
 =?utf-8?B?N2RhMVJPbVRzb0RFMUJGM1l0OXBBMWpEVGI4RWtTd1pUSEMzUlczc1U0cjUr?=
 =?utf-8?B?NmV4MWdtNTUwc0d6Um5wSjg3REdwR0NsVnEwVUUxTWE3TkNlbDZFdEhKUThL?=
 =?utf-8?B?VHdXOUNpQTE0TS9ncThNWFZ2L1dUK1JFWjY0cGpMSERuMWVSQXlidE9WRW9D?=
 =?utf-8?B?MmpDVlRJMUhld0RCK3Z6aVJJY2lPcVFqNWpOaFBnNDl4dURNNmE4NGs3TWFa?=
 =?utf-8?B?RFd3REhMai9yL3gyRFBINU1aOHF0V1dwZ2lJZzBDZ0pGcUdicS92L2k3WGZE?=
 =?utf-8?B?OEZWNHlPYUtwYUttZEgzYitJb1k5bHlCb1dYQ292T2Z6MXpHR2o3dlhZQmx4?=
 =?utf-8?B?dXp4YXNTbW05SEhyb2ZnbmQ1c05HTWRKVVd3MlkrSW5DUWR3bExkcUdGbmVL?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1e6145-cc51-4471-d808-08de25cdd469
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:38:29.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxQE4wgVFhehSI1Zoqlg29xX5lrHdpRnn5ofwtO1hO8r/UhuvG8J6yk47MtY1smu/EfJ/gEcaJ1Qx5AUL6Xdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3676
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 11:38:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20578

Hi all,

as promised on our last IRC meeting, I looked a bit into the state of
recent CIP kernel & config on the DE0-Nano-SoC. One outcome will be
posted later (isar-cip-core support [1]). Another is that 6.12-cip with
cip_merged_defconfig does boot fine on the board in principle. I tested
both EFI booting (not relevant for kernelci) as well as legacy (bootz,
u-boot-script), and both worked.

What I noticed though is that the pre-installed U-Boot versions on the
two devices in our labs are quite different: 2024.07 at siemens-muc,
2013.01.01 (historic vendor version?) at iwamatsu. That may lead to
different memory layouts and problems when artifacts grow (as they tend
to with newer versions):

2013.01.01:
SOCFPGA_CYCLONE5 # tftp 0x82000000
1329397/tftp-deploy-so0uyc8_/ramdisk/ramdisk.cpio.gz.uboot
("works")
SOCFPGA_CYCLONE5 # bootz 0x01000000 0x82000000 0x03000000
(hangs with 6.12-cip)

2024.07:
=> tftp 0x82000000
1329285/tftp-deploy-2s1r4tdd/ramdisk/ramdisk.cpio.gz.uboot
...
TFTP error: trying to overwrite reserved memory...

I unfortunately do not have the parameters for the my build experiments
anymore (host decided to run out of power over night), but we may want
to double-check what u-boot-script naturally picks kernel_addr_r and
ramdisk_addr_r. The initramfs I built from isar-cip-core might have been
smaller, though. Maybe worth to check, first of all, if the kernel-ci
pipeline would make the kernel start to boot without any initramfs (even
if it will get stuck later on). I may also reproduce my sd-card boots if
that helps.

Now, simply updating U-Boot to a more recent version turned out to be
not that easy thanks to no one (hello, Altera) testing U-Boot upstream
on our board for a year or longer. Patches to fix regressions there were
sent upstream, though, and will also become available via isar-cip-core [2].

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/next?ref_type=heads
[2]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/cf43e9da3cfc59771e801d3215d3b3794f3602a8

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


