Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAC1C10F16
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 15:58:40 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.41])
 by mx.groups.io with SMTP id smtpd.web10.16876.1714751911853322055
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 08:58:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q7G7AiV7;
 spf=pass (domain: siemens.com, ip: 40.107.6.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyVuyenY8xGH8+8U6/PxXSTgV5EZzQaAjonR3hJRqlWkDC6A+n+Kf1vmXNr5qxGGJ1quIOqu0ZdorSff6ruW5sEiPzyh8kTmIpBSg4JNMEh4MZ00t+inCAMBTJenSDGxhcdNH/BkkHX01z+aT0v/nBSZX+AxbNsw19pgJalw+Nn4AJyLdq8xFh5ud3ymSerRGK865160SR2te44z9JaPfV2918GmuEo1orWHlZX0eFm1vSPJz+vPdZenoAb6EGEwvERmeU4vsbERye3rHQ/iQw0giND5B/NpUhQ2ZccKasUSe5BJ3eY4hOZ8ooVEZ0cunnFL3VkvevqkWvhqMrnrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DptECynu1q7qtWF0cc+/E9ldVf2Jf3qMpBCobUrIMc=;
 b=BtLeQV29xrLy36uTYKA6zMtVM/KIVPejVoYTg8l25CFQ/1mZPV+TVwleJhLpa4iYzDnO26p+ip4zQs+imD5zhQed3l06GNCiK3Rk+F0PKyEx3vHuhRI3rdCs985QFTu786/KpDy4P3tBvcpdjNPR+luASDyAbJmoBt1ofUFC8NRiAvTlzdSk1XYRq1QpdipR8xu3cmk0sJk4ZBpbVyedt/1ovIc0yieXSYasToCANREJKUYr7J1p3v1Nrj660+U4aRSSVmmStuBn6C2l/Fmyq62CUTZq31kTDklumk6bVJAjjjYopN8rPCBhPPLv5u5pF9WLJltve/Y26PYbZtztaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DptECynu1q7qtWF0cc+/E9ldVf2Jf3qMpBCobUrIMc=;
 b=q7G7AiV7iEaQuZYm+bPGDhgPrD5zE173OMYKnKx6gfQEkSJRsOkXIKun7cdgj85qYgr6E67/VpcTV15T0QwQoBLHOAatmgoMqmthTsSdR4NAgFmfBuMvzAQre5/Ik12zu5b1NL7kit1ZyR1XakfTWmSw1yxzNUlxLIGNiDjExsvCiBDg3DgIVCBcGuts3HU05Ta97OXYtHnz4otYFVECsl+/QAAGwOB2cFAfWMDZWkZU8b33X+XGWSCY3Oc+//LepgLwBRtL1NuE3JlPtp8PXa/EUj/3IjfY2ygrx+ZL61uuOeFBf+QugNvtSxzuUW7kCypydAvXHwa8hT8oiQoe1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DUZPR10MB8170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 15:58:28 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 15:58:27 +0000
Message-ID: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
Date: Fri, 3 May 2024 17:58:21 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>,
 "Schilling, Benjamin (MO MM R&D SYS SEC)" <schilling.benjamin@siemens.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] Generic x86 kernel configration
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DUZPR10MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cece1b2-45d3-4e23-4db2-08dc6b89df05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TThsWEdEOHFMc1ZyMFVOMnlBOUVxSm03ZnlnOXBWZXUzWDU0ZW81cEFLOUhB?=
 =?utf-8?B?Rlk0NXcxZTNWNmFvNVFyeDEreG94TmorS2RmQ1JWZHFFYnkxS3owak52Mk5V?=
 =?utf-8?B?MHZPN1JVTktHZ291alcyNzVIcjJVUExzbDNvYmZrNDRSc3Fzb2laRE9EZ0lu?=
 =?utf-8?B?cCtYbVF6VWhFM1J3NFhXdEZhd0RVM3ZGMWlwdGZsTnRHM214MWhHS2tYZU1j?=
 =?utf-8?B?WXc4cUkwMkp5Q29sVHFON1UreWxyUExFc1Npc0hlRzkzdWZtR1RtdTI1S2dx?=
 =?utf-8?B?dDE3U1JRbzlLL1NGTjJ0NHJ6ZjhFV2RiT3NOMVNYaUpBdUJESjN0UDlpRllP?=
 =?utf-8?B?bzhac003b09FU3VKckU5VmFPcjRjRnZMaEhpWGVDbmphMUhCZCtqd214MnZn?=
 =?utf-8?B?QUU1Q0xxdVkwZFNiYVBwRmZqcFR1Um1JdUNuL1VrUzFwTFFnK2hiRzVJZ3M1?=
 =?utf-8?B?OFM4TDRDTU1JcExOVnVOcG1kN3ZtS1VlK1ZueExwU1lQUHRKeFgyeWM5T0Nu?=
 =?utf-8?B?elRwc24zSkRHUlpKYjRuc3Zla202V0dqMC9wa2pTTFlubGN6c0VUNkt5Vno2?=
 =?utf-8?B?am1EeElQcUFjRmdwUG8valBSR1NkazdYSVMwMkNsaWozMFNuWEZBTGpULzU0?=
 =?utf-8?B?QUtoaHBFb2o4WWJnVkJ6V1RKUXIxR0lCUW91b1huVmdpUUhTcEdUVjQzWkRw?=
 =?utf-8?B?aDlDVVJPWENiR0NmeE1LWHY2SU9sdDVBVjlBTGxpVWRabWJrTUMzSUwzV0Mx?=
 =?utf-8?B?WHZOZlh5MmVKUGNMWHpTVHY5dlpYSisxa2dsZHJEQWdPdHRQdXZuVUNMU3Js?=
 =?utf-8?B?TTdnQ2E1WjUvRHR5N0g5TTVMYkhtYmRBVzZ5YVNzTksydGwyaklEMkJaajRm?=
 =?utf-8?B?VGhkcmRyYXIxM1A3dlhtQ2tGV2JhdnRsTHFtNkdRS2c5Z2FaMDFxaXpwemxO?=
 =?utf-8?B?Z3Y4K29TZUJKR3Z0d3NPNTVsdjVMMmEzbkFKUlI4bFVBM3RvYmlJb2dlY003?=
 =?utf-8?B?ZkJvUHRZdFBLM2IvU25ReFprTWJEbW1JWjdzRjgxWEM1VklWZXZvNTJCcDNW?=
 =?utf-8?B?S2o0M3JwT3VsK0lqdEpkcHNxZlRwMnZIRjIreXhRSkRLYkZxRFR1enNWQTVJ?=
 =?utf-8?B?QkpmVmtnTCtycit1N0x0VExiYXBOWUFkRXBkNXRhQVNjaytXLzFCdzE4Ni83?=
 =?utf-8?B?dm9FRWliWEF1bnpDaEZOcHk5LzU0N1A3S0xyTDcxOXh0UUx0dENQNlJmRzl3?=
 =?utf-8?B?TTlsc0xOdE9CckRtNzF1K3ZTalhvS0R6OUdveWxBemFKdWhYdjg0Qm1YRTh1?=
 =?utf-8?B?enc2SWNZdkE1R05OK2lqbW5EVlNsSURkNFlXc05DS3R1aVNYbDBPU1JiaHky?=
 =?utf-8?B?bFM0UmpRMUx4cXZjVHJnSjZOcVBGUVRMNzlxdU1xbWJGNkN2STArYkZ1TG1X?=
 =?utf-8?B?eDZ3MEIrWXUvV1RyWVZOTkhqTWxSNHdmSS8vK1pTTHhUaktVNlhoWVl3dEJB?=
 =?utf-8?B?OHIzbUFrN0orelUxeG13a0huL0MyWGtLYm9hekx3Z2ZHakdyTDBQT1RjZTcv?=
 =?utf-8?B?eVczaklNaysvSkxJZVZPSnlJMGlLbEpjQU1VQkRFMS9LUnJtRDBKS2V0WkJJ?=
 =?utf-8?B?a1hoSVB2b1NTWS93RFoxYUxUTmFIMkhPaXhVZk5Vbzhsb1pIdXB5bjZyREdW?=
 =?utf-8?B?blF4aUVmNEtQZDJSRkFxcWxNOHN0OXpmcVRqZFlwMFYxcVdIODJRZnlnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmgxRnV4cGxnSmZuOFl4MnNIaU9Gd2FPci9UVUZ5R3BLdWhMWXh1V2tjMHd6?=
 =?utf-8?B?WWkvRGVkTFc3c2V1clZsa1J0VXU0c3l0LzJhNVY2TGlqeXF3OXVwalBKWEFQ?=
 =?utf-8?B?bFdlUHArUmN3bC9RZ3Nrd3JPaVBIaFF4L3lEekhleDlBTk1oT29GdlozeVF2?=
 =?utf-8?B?T0dQOWVCVm8xZnlJenQxdUZHUFUxMmU4UjhBb3lhWnJsRnFhRUF5dGlCcG1D?=
 =?utf-8?B?dk00SHl4L3FmMWtBVXdhNkh4Z0ZCTU9xcnhscUt3N3RWR01kMU93UDR5aDdB?=
 =?utf-8?B?bDFFZmwvYXdmaEV0elB3dXBidGN6NGtPWWlIT09GVmdwc1ZjMDhUSmY3NmVQ?=
 =?utf-8?B?NExwQXFjQzVibCt1d0s3b1JhTW9BVnRDN2UxeTVkWFZxSHhQUkM1dmFsaDd3?=
 =?utf-8?B?ZGRRT1lUTXFaU21KK2FwZ01Cd3Z6ODRVbGM3d055UElXTHVpZE1KdHFNQlR6?=
 =?utf-8?B?SktJTFZYSG15bWlUUUVPZkY2UzlVcDl5emdHUFZDd2ZKTTFWODR4SzFzYzRV?=
 =?utf-8?B?eWNGZjQ3eGg5bzJodnJhcWcxRUVCTTVUVGNOQmY3aUNLb2pGU0NybzU2U1Q3?=
 =?utf-8?B?UGhmR3liR0QvZzNsaVp6bER3WGZYbGgyclY5TTRYUDArUldsYTFoNVJoQ2wz?=
 =?utf-8?B?ZjdnMFJpNnRCTWE4YTZKYm1BLzNEVlFIMkVjWEpCa0k4alJFdzFYWjJYTkRz?=
 =?utf-8?B?QmZNR1drTFB3ZTk0ZDRDcUVCbkg1OGp6aTdoOTN0M1YxSWczV2FVNGw4MWxL?=
 =?utf-8?B?OTVjS1ZyYjh3L0tIaVQ1bkMxSjBDMjFhbG1OV0hyUnhNaHhtbUM3KzE2ency?=
 =?utf-8?B?Y1VNY2FwN2p0TEJjVVUxZkpOcTZJSnk2a29ZZ1Y4ajZsMWMvMUJCUWF0OFJr?=
 =?utf-8?B?RzZCcDZkTlY5b2pZTmFoZXJMdzBtNlh4Q085UXEwNTdzSGF2K0ZuU0lUd1FQ?=
 =?utf-8?B?MWlpOU11ZlNPT0FSM1MwYzRsc1BoamxDQlM4azI1bFZ6cVlKNkROQW5HRUdj?=
 =?utf-8?B?OFZzbW9CVis3bnJHcXFHbVhhTlRJcUhzd0JKNW5LN1lLcUNsbTlDbGIrMytH?=
 =?utf-8?B?UGt2Skx5aWF1emN0dkVIY0gvdVZrUHJReHZBS3c5d0JKRWw3NDNZa2RoV1E5?=
 =?utf-8?B?VE1Db25id0hrVFFkaS9KWXE2MFAyWHRpeGxTcFRlN3BZZVcvdHFoN2c2Y3VH?=
 =?utf-8?B?M1NibkYvY00rRDJzckFQOGZvK1hjSWNsL0kxYlVkS2NrRXFvWDdpUXU4R0RR?=
 =?utf-8?B?aVJuaXp6RmdpeTNNTThCeGwzaFdpQVFIR0tJcVhyNy9pZXJBU2V1NFhyTmZN?=
 =?utf-8?B?Y0EyMVE4VFlMRjJMV1N6Z2YvaWFkamkxNnhaSHA1U0tsQjdFU3FJWTUyM0Q5?=
 =?utf-8?B?dE4wVFNjOVVOODdrVU4xVm45My9OOGJYMGd4N0FNRDR2aGJJdEdkQUR0QkV6?=
 =?utf-8?B?emlPV0pNQWNJbnI4QnVSdEhCclNWL2gvZzVlTTVkb2drUHhha0J0eWR2b3Q1?=
 =?utf-8?B?M3dqdG9ZK0FsVGNuNlhJLzVvOGF6SlRiWlpoeXBOVlFMOGZkZlBTL0Y5VnIr?=
 =?utf-8?B?ckZQakVVTHBDNFY4Ujg1akxrS0x4RWNLaGtWa2pHVU42K1hsTDFFWHNLUVdH?=
 =?utf-8?B?bU1FcjFwemhwSGUzb0Q1ODdsMlEvK21HRFhxT3g2T1VUclVmV3RGYlJOUlFZ?=
 =?utf-8?B?K2pzQWpUYUJtQVBtK1M2SEdLUXA4KzhQVVg5Zy9Uc3RwSC81RTludjlzZzZJ?=
 =?utf-8?B?eUpBeG5HTzRrUmVsMDBBaU5uMUtGTWYzZXpIWURQbFhORUdYWVNwUnNpVnUx?=
 =?utf-8?B?N3pxbExsOWc2a1RTY1Fwc2xBenVPa2d0bWFvZWZNTGRRK3hsdUx1elErOG02?=
 =?utf-8?B?TXhNa2wvaEsrOUQ2SFhleU5lQVNTWjM2eHp2Mk9mVTJjZmpTS2tFQkdCU2Ns?=
 =?utf-8?B?bFFqeElKNXpyV0RMbDNHNk1oakVVQnFDbVV6UmFCSmZxcFlDZEVJcEJCSjRB?=
 =?utf-8?B?V3gzcTJ3OHJlYjZCN3V1RXF4OXVjNUVIQ0s5ZXVWaWFyejEvVzhBSlB3a2tV?=
 =?utf-8?B?NjJaVWhueTMxeXBUZ0s2MU5ydGs0enRRMElkd0xuNVUzY2lUZUVzejI1VVA2?=
 =?utf-8?B?UTN6SW9jNnNNVjI3MXpMVVlGNDBWajZWWjBuS2ltcVUvNGh3MitYbjZGemsz?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cece1b2-45d3-4e23-4db2-08dc6b89df05
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 15:58:27.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqkA0qa7Xzl9g6JZOSct80hOeZwm3t/YzAt8gAlH4dCz3BDZXXhPtdU0GCcHq9tU6WGxLjCBApmTbCXn/GV8xfkxAozYrnLreG3vfE1b0tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 15:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15823

Dear all,

I have used a forked version of [1], which you can find here[2] to
merge the following x86 kernel configs together:

cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'
cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconfig'
cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'
cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'
cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'
cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'


I have tested the v5.10.214-cip46 version of the config with qemu-amd64. 
The next step would be to check it in the cip lab on the real hardware.

The script takes the Kconfig entries of the specific kernel version into
account. It also adds all dependencies to the config. You can find to 
log of the merge at [3] and the diffs to each configuration at [4].

An first integration into cip-core can be found at [5]. 	

Any comments from your side?

[1]: 
https://github.com/zephyrproject-rtos/zephyr/blob/main/scripts/kconfig/kconfig.py
[2]:https://gitlab.com/Quirin.Gy/cip-merge-config-work/-/blob/master/kconfig_merge.sh
[3]: 
https://gitlab.com/Quirin.Gy/cip-merge-config-work/-/blob/master/merged_config_5.10_x86.log?ref_type=heads
[4]: 
https://gitlab.com/Quirin.Gy/cip-merge-config-work/-/tree/master/5.10?ref_type=heads
[5]: 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/qg/merge_kernel_configs?ref_type=heads

Kind regards,

-- 
Quirin Gylstorff

Siemens AG
Technology

