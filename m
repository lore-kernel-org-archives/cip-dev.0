Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7771BEB64DE
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 14:27:35 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.71])
 by mx.groups.io with SMTP id smtpd.web11.24644.1725978448434599836
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Sep 2024 07:27:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=SRomjgC3;
 spf=pass (domain: siemens.com, ip: 40.107.103.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZeISxfxUVU36Xf9TNI3MRAfOCmxhGirYglATgffJH/yHNrIim0vPwyRSaKHWWlX6tAr0fDwAzxTg69Wehz9D8h18Ir/hh6U0y4WxnCp8htZm0LZT7SA9vh0qwZ/NhRlLPr3JVNjttgxqM4TlipkFsMCzXBzRHDcQGJQ/FBHwZiaXvn8dslgGK54HpOPJJ3hcu/St2trDJeCXfqb7V8Dz5s3KM1BO/1dImimcVLRXhtx3L9XVHSJ0WFg/4sREzivLWBqzPRc4m+rSvVX58Ny+9Z/0jR7sbgqW2ook3VoPuhT00B1f89pbEBN0ffo2aa4S07LqmVnAfl176SjPaYdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGl1Or3lyIH8RQ2V0zPDwd65gW/EI1Fs9BGKEhcpgsk=;
 b=hcDi2NaceDcH2QfYwX2pWPSbrJQaVGKsmIG/15v7P53Y1s2QB8/ySPE472fd+eMeUi/G87920PT0Ur4Xrr5TJa6ocpqL0X5IH3UHl3nkEkinnZFtbX//NcVkJYAZhInEy2AfLSfP71yy8cbwk9HKgEv4+X6Bg2KwJBrtSrnFaRhGMFGp/4VbwoDDaLEYXGcGh1VwTabT2GTslmy3VMw9Q236dJhHF402vEW/N1UiskylUv7xhwxY1ZmJ41QukWvSGNjrcvYWwODGiFrMRS4XYkMKAzIR3KHcqn4oXLNOrlUaIUmrYCS3OV6AxkGq0HmAzASQUiv/ymAK/ZCqY0ptvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGl1Or3lyIH8RQ2V0zPDwd65gW/EI1Fs9BGKEhcpgsk=;
 b=SRomjgC3HzEGVPIaPQTqwTU1kBS4tH9cKGkD+76vqZ+ACWFoG8rY3BcR8ZxehVtCzEqV1BVBI62S564CmKyDqnqyhP+ocycWLK7ZedFtWV5yjVqwbJYOJeRSsPQe7VMn13Bw70bs3jPgx6UhU0M36GHyQpcZlejhdZXv8TuvNllh+8x1j+gMYZmTEoC2CH3VtksuBHcxIkjYLeQNqrFalsO+83sxyJhsxDOLQUoIUclbXpFbcI2592/fqWaQckx/dLa+PDVEe3TRPvsEZAtrHPnNODdVqD0vTmIcXizKA0hkLbR35xzo0mwVh0MFr4WISG+SCHnTewGcl0syQ1/TGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 14:27:24 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 14:27:24 +0000
Message-ID: <8d40db3f-a411-46e7-a26e-8be159f6f67d@siemens.com>
Date: Tue, 10 Sep 2024 16:27:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] QEMU reset issues in CIP LAVA worker
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
References: <OS3PR01MB61031B36A1BE2249B2F4CA2FC2992@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <84bf903a-bfaf-4570-af77-b424dd82e9f6@siemens.com>
 <TYYPR01MB12402090C6FA11A9574C6D267B79A2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYYPR01MB12402090C6FA11A9574C6D267B79A2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3e9867-d44b-4c54-b6e8-08dcd1a4b005
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|4022899009|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?l72TLzUsUZRU2FCQh6y/P9uUE+qz2q92MkGaAtfZEEXhrLmATOhDuC+d3xVC?=
 =?us-ascii?Q?12mtk2sAdP5QLIQzzgrLQHOliOZr5IL13p3zLWipWLFcT3LRBDuAkeyYM7SX?=
 =?us-ascii?Q?dt3ufJcFuhUPN08szraaF34PBeEfJMImZWHKxNnLKkZ3kACvXnLgnu7CbrOV?=
 =?us-ascii?Q?ZennPaByGW3vCS1OImsN4PgUUVehxoaIMJI4dj7ySF9v2COt6WzMul0tBWBC?=
 =?us-ascii?Q?iTqt1/AwGqR8+3pdsF2rWuDeuzN3RTaMY+Tt4UagHfORsHBinmhFAUllPS+s?=
 =?us-ascii?Q?QYbGRRl+SxEoCakZP4l3Qba9+k41upN+sop+H4W7TY+++cqvm0JAhoSUsspn?=
 =?us-ascii?Q?vnOtFc8rn2j0A7EVVOfknD3+sfiPu0ZLbPxWwbia9qeU4kJ4apxfTVb6J8ZA?=
 =?us-ascii?Q?8+9e4BX/c3Wm7W8wYdYRLkbi1KnzBoZSZusxb79xP1yqiZXIfvc7uqb7hqBo?=
 =?us-ascii?Q?iySu7F6KSYDYMCYMKStcwplihSVdmI+TOzswj76aDsUwqpIsbeod55PvpIIW?=
 =?us-ascii?Q?sJMHcz0+b36dz/rLOp1VFpCD7L5uZobxafte8FfRDVA6j2RJBTCnXNaW1fF8?=
 =?us-ascii?Q?3Lepakxwrg56PvPYGh6ePuV3sriqWxzbvUUF2q3KaumuHMivAdLGMcPgrdpY?=
 =?us-ascii?Q?sWtvfyDL+d6L4NM7JykpeGgSw6vDRYQo4QrAwjqGzYp6ZGMd3XoITO0OY7MW?=
 =?us-ascii?Q?i7EYmceqmLkA+NLJRLWIJGva1xl+D1hhV2vooRUQR3R4beeGUZWhF2WdDpCJ?=
 =?us-ascii?Q?2r95W1MyMiSXedaFjjh8wivyRuEQSr7ZVCd4Ve1INhQhCUMH13c7Zmjs9EW6?=
 =?us-ascii?Q?Dw5mMCSoqZ9hnFMEPNWLsCm8CXK7xTOlVnnFP4i0IU4j1/x4w3D5Uy1im2ik?=
 =?us-ascii?Q?ie756NHHsjQ6FiExwstLoIUPR/hOGvGpl0CYzgXH8RlW2oTmn5YoKBZNAgnK?=
 =?us-ascii?Q?eDqlB0DGyxuRWJdw7Qt4Q903LtNVXkZ2TtBFn5TtSj0XhwcIWgcNNnouVx2F?=
 =?us-ascii?Q?PhgOZKJ5wikn5sInWUolVUPrGth91XMFcLxX/ovmpFQrwToSEQEHTuOTDijz?=
 =?us-ascii?Q?w0pl3O5h7faT9NTxhv1Ym+5hlNsfemzcUTFxuOyz27tgdOkYeWr6diTk1Xjq?=
 =?us-ascii?Q?5zuOuwwmgbDhIpVCdQbEAgJjxjEz0aejSLTh+UQE7A2Vkv8LI/WGUW+Nxpw9?=
 =?us-ascii?Q?fE/PXBB8M8DEAzhKi+Ba7TJYeLgGTpRPmqLbGYTA/UWfHfXMVBnGwSvDpWf9?=
 =?us-ascii?Q?R5ba5RPj/nj5+SMTOKY6dHB6A0iKCpvbWLnt64I2eADRa6gNOVjJaG5K5cJe?=
 =?us-ascii?Q?xb0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(4022899009)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g5smjEV63TGu5MRcrtdjlo7bSPgbHqfGcm8jDXqrIFadhaL/NwnvIRLcHVPT?=
 =?us-ascii?Q?TMTd5OYitLiywatsNsiAvAejgc8MmrCRY5X2Eq4+Q8ruupPDDVjQnmUtgurb?=
 =?us-ascii?Q?UXfmj2CMgNnqNXZwODGRZMTQ0RfZSZVasryA1J8iGzA1szezOZUqeeglE7mO?=
 =?us-ascii?Q?SXBb9KU/73lAk7e4QndvvndwMzyri3ImFvoD5aW2blxjdEvlHJEI+ZEZl6To?=
 =?us-ascii?Q?/1F3NS7cN/6u27i41n4Wu1rWPlwbRau4B3TMVKsbpM5dnCZ+Gisk22YKlbvd?=
 =?us-ascii?Q?OIxJ4n23ydBot9zzRyROruV8JuvkBUIavIpEAJ/+m/gdIQZHfyu9j0wdudpW?=
 =?us-ascii?Q?O5d/7Ogw/6nyrHkJlihtIOQbV0slgieQF78FM3eYxMIOfzPghXrF9/gUKmIP?=
 =?us-ascii?Q?IT76vPAgmXe4PMEfUAIIQ/6403mSbPvnvj1TmncQBSjGAU8Fh6KfNdJadGrH?=
 =?us-ascii?Q?4tlstUq3wh2YU3aR9VN14X0Tsv2P0bi3uZU3o90vfCFTr9pGcsr9JHxSZMx9?=
 =?us-ascii?Q?BgjY8Q7aDYxQICA5QMEtE/3IOYNTE974as9I5yESE49LjQWc6aUXnj2izZ/y?=
 =?us-ascii?Q?DydqvhV1cN4lLZ9zUaRtY7/jCXQKVvzUsCRdleTLgwb8SZVmv2Fh3Tc6DTNg?=
 =?us-ascii?Q?vz6QvPBpN8s7wexMFRzw0S0tshGbCgH7/ICBuZD2Xd9xiZUcQ40eifoRHoOO?=
 =?us-ascii?Q?CDwiKO+TShkD9lN5LV3rEVsc1JUKiEBpZtVyXoEOUo/hS67ROoK92NRDbRcn?=
 =?us-ascii?Q?G0tsN06y39CUiSzcXTBXy/km54ixbsTvvigJGBPQopBb4rP2NdkXtgBIdkgh?=
 =?us-ascii?Q?a4e11BoWJk9jzbdtbifDYaZTnpeHQoIqXqXDJuojS6ZAoEpGjSQG+8M5OLpT?=
 =?us-ascii?Q?I0KXfLHeRtpRrf09Ooje+3WQhazakTFW3nEg8ivCYXTnFiyrqque7iYTXsNa?=
 =?us-ascii?Q?U9OZ1y+EhvhTZRwPCs80xtSyT2FAOvpodXSk6zDk7yxp9BjQWa7A69w5gkA5?=
 =?us-ascii?Q?fF59y5jc9TsLSSmzm0zrMxB4zSLg7TUkLtInHYMzgGC8KRnq8uhOSJaQ20JV?=
 =?us-ascii?Q?HvilH3evrj9vzuUCvI3Wwo3yUdP67bfiq+MsbvpyPkIy6ReguGPiLjyK2gE6?=
 =?us-ascii?Q?hKJszv91pH4GWf3cx8TE38V4P9o5FZYfCWicLjfKI6+Rn3603nLeQT4vOZqh?=
 =?us-ascii?Q?G9ceeJRhECPBlA1xNAUBEsoM3ovlk3s+U9pO3FntZP0+woSoHFFgLd3/BTK8?=
 =?us-ascii?Q?1JgAOX5CFJodeoxeuKJ9wUK+aE2HDJmV/0dXZ392gAprIDnrLFfw6OPPUi/9?=
 =?us-ascii?Q?IetMpH/oETq3hA3wuBoSxPIhpz1GM28pmpIDUrlu3IDnb2JOGAMmoZESA9LZ?=
 =?us-ascii?Q?Sy4QLhpLjs8dVZbJbDZmXDw1zZaQHAY3OePWA1LmHLqVxo94JBG7LAABEKRh?=
 =?us-ascii?Q?rqq816RXBqmDmGQiN3B5+lFKdcD3aS7GJflufFkp9yaHorkRTUlvFl3cnNvE?=
 =?us-ascii?Q?opbZQvLevFewVDYd3I1DUgE5dpxXBEu/i6sBNuEN8vKi4z4vtkZ8AUK+vzwo?=
 =?us-ascii?Q?0XjvxdJAUkjikao+4vdGasJMGR/5A3o8pndoc8WXr9h+h+4N7Wt32/kqtKeA?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3e9867-d44b-4c54-b6e8-08dcd1a4b005
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:27:24.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdOp8KO+uLLH+5xslZWJVKR9AlFODr8JKnHevHhbTrLxFYYGV5puClqiq3ssMYDJzjF1zlp0IB9ql35XcDRNPxkjOLVBAdpt03E2iz3pW3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Sep 2024 14:27:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16878

Hi Chris,


On 9/10/24 10:12 AM, Chris Paterson wrote:
> Hello,
>=20
>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
>> Sent: Tuesday, September 10, 2024 8:49 AM
>>
>> Hello,
>>
>>
>> On 9/9/24 2:02 PM, sai.sathujoda via lists.cip-project.org wrote:
>>> Hello Jan and Chris,
>>>
>>> I have taken a list of all the failed jobs in LAVA after enabling secur=
e
>>> boot, software update and IEC testing in isar-cip-core. The inconsisten=
t
>>> reset issues during boot and getting stuck during encryption of /home
>>> and /var are found only in *lab-cip-siemens-muc*.
>>>
>>> Currently I have no idea what the problem in that worker might be. I
>>> think until we know the reason for this behavior in lab-cip-siemens-muc=
,
>>> maybe we can remove =E2=80=98swtpm-jobs=E2=80=99 tag from QEMU device i=
n that worker to
>>> avoid failures for now and parallelly debug the problem.
>>
>>
>>
>> I have tested on our runner the latest qemu image and the swupdate
>> scenario. As our infrastructure does not support internet access from a
>> Device-under-test i would recommend that we don't execute swtpm-jobs on
>> lab-cip-siemens-muc for the time being.
>=20
> I've now removed the swtpm-jobs tag from the qemu-cip-siemens-muc device.

I think the tag      sw-update-testing  should also be removed for the=20
time being

Best regards
Quirin
>=20
>>
>>>
>>> Note: The failures in other workers provided in the attached sheet are
>>> known errors.
>>
>> I also checked to errors, we have multiple source of errors.
>=20
> Thank you for taking the time to take a look.
>=20
> Kind regards, Chris
>=20
>>
>> e.g. https://lava.ciplatform.org/scheduler/job/1181952 has the error:
>>
>> ```
>> Resizing the filesystem on /dev/vda6 to 332595 (4k) blocks.
>> The filesystem on /dev/vda6 is now 332595 (4k) blocks long.
>> login-action timed out after 1438 seconds
>> ```
>>
>> and
>> https://lava.ciplatform.org/scheduler/job/1181944
>> ```
>> MiB/s[2KProgress:  63.3%, ETA 04m36s,  832 MiB written, speed   1.8
>> MiB/s[2KProgress:  64.5%, ETA 04m41s,  848 MiB written, speed   1.7
>> MiB/s[2KProgress:  65.7%, ETA 04m32s,  864 MiB written, speed   1.7
>> MiB/s[2KProgress:  66.9%, ETA 04m26s,  880 MiB written, speed   1.7
>> MiB/s[2KProgress:  68.1%, ETA 04m22s,  896 MiB written, speed   1.7
>> MiB/s[2KProgress:  69.3%, ETA 04m19s,  912 MiB written, speed   1.6
>> MiB/s[  609.374786] watchdog: watchdog0: watchdog did not stop!
>> [2KProgress:  70.6%, ETA 04m15s,  928 MiB written, speed   1.6
>> MiB/s[2KProgress:  71.8%, ETA 04m10s,  944 MiB written, speed   1.5
>> MiB/s[2J[01;01H[=3D3h[2J[01;01H[2J[01;01H[=3D3h[2J[01;01H[2J[01;01H[=3D3=
h[2J[01;
>> 01HBdsDxe:
>> loading Boot0001 \"UEFI QEMU HARDDISK QM00011 \" from
>> PciRoot(0x0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)
>> BdsDxe: starting Boot0001 \"UEFI QEMU HARDDISK QM00011 \" from
>> PciRoot(0x0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)
>> [2J[01;01H[0m[36m[40mEFI Boot Guard v0.16
>> [0m[37m[40mBoot medium: PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)
>> Found 3 handles for file IO
>> Volume 0: (On boot medium)
>> PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)/HD(1,GPT,D1360F76-B09A-4BC=
C-
>> B923-8195088CBE02),
>> LABEL=3Defi, CLABEL=3D(null)
>> Volume 1: (On boot medium)
>> PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)/HD(2,GPT,F870258B-706F-4A6=
6-
>> 8D58-B5A75CE61B8B),
>> LABEL=3DBOOT0, CLABEL=3DBOOT0
>> Volume 2: (On boot medium)
>> PciRoot(0)/Pci(0x1F,0x2)/Sata(0x5,0xFFFF,0x0)/HD(3,GPT,6E41F2A7-E3EB-403=
F-
>> 8637-B111E4482EE9),
>> LABEL=3DBOOT1, CLABEL=3DBOOT1
>> Loading configuration..
>> ```
>>
>>
>> Quirin
>>
>>>
>>> Thanks and regards,
>>>
>>> Sai Ashrith Sathujoda (T S I P)
>>>
>>>
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#16875): https://lists.cip-project.org/g/cip-
>> dev/message/16875
>>> Mute This Topic: https://lists.cip-project.org/mt/108352607/1753640
>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>> Unsubscribe: https://lists.cip-project.org/g/cip-
>> dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com=
]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>

