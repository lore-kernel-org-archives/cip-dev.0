Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15426.1795097587947040107
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 06:13:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Hll9xo+q;
 spf=pass (domain: siemens.com, ip: 40.107.130.24, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrRDTvvwAIuKWsmHWatja44tLDJ49dBKPdZz69RJhInkbrfKXGhTZ/mYiH5j83jCmt7EBpdn64iJ7lFtJZb09SJ7H4medK9EV1W4LyP/YUD7Fc9yAljG3Qu2clBtBX1IwMuZ/v2p0XpNPu6fTFkgQ94qyv2bRuJHqkme4OXtkwPsPkqKIaJl2/J5scOr1E/qFmzc43PKKinBTB9YjvUX/4qfICI4jSAhiBmF87eaNV5xAydbzFfHWAOeHj0AY1w1xSP5Ku3s6b4AelMdi92CN7cqDUoL34/E8pdy7yXv3RKq2uHPxsnphxUNpAtMuPRiw3uVnESep4oQqx2GLEa1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY6w1BEIq713u8+HouAoLg9xyZQkEn+h2RR/8UuzxuQ=;
 b=i7Dpu5p5KhHUdlP3AiecYmpghaM+ZW5IQyJlBGhd0nGeOCkc6o1+6agXP1a7kCI0RWps3lb6tJgDiEjT2OkXQoBQWRas4GIuUE4Kqi4eCOHLa2vli6JMKi5fjwE0eGYU1pO/78xJjJzRq16jt0tLMe8ylwF4S1BebPPNvcWFDvdP6ady2oHzkURRWnG4pvjLP4TdlOEpF1+VtL+36cuWc9oRRXBoMxg4WekcwMWjvOjdYNqEhBCozNl8CVBPiLcVv1Cz020hIzApeZ6D02S0V00IW+cWBhTbKG1YcsVfbb19e8ypKXhh8whZSTTJNXFaA5W2O+ZwDVeSPlP1mpZjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY6w1BEIq713u8+HouAoLg9xyZQkEn+h2RR/8UuzxuQ=;
 b=Hll9xo+qIVBIv7du3VPlBgVJCFEPMqWbPfbPcPSKghlG56xsNx3KJFVu8/MPu45PNv5PKcCgco/IvYgpcE2cigGbSTIzPMt/4yu77dkJoH2zJIzHn9onULcjOeqiRAwS6nVxCUam3qJFGrkIQVYchZZSroklVsWdbomCh+Id/1WwD7fMEzZHO6VzTdrnkzdxWAseRpOHw8dbj0Kmuw2HWwAp1kXr2clE6gbjZGeSJz1ehvb16FMwduXvgpfn/jF997+yJL+tAB3ipv3KBstuo6cbrCNE4sYUEr8E1DHdRP7TwiqJ/FomNQNtuzqPM+PiSUv/Qe/6ku0Ye307V6SWsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9)
 by PR3PR10MB3946.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 13:58:00 +0000
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7]) by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7%6]) with mapi id 15.21.0662.000; Thu, 19 Nov 2026
 13:58:00 +0000
Message-ID: <eefa6825-b571-4671-a870-5845f8700af5@siemens.com>
Date: Thu, 19 Nov 2026 14:57:59 +0100
User-Agent: Mozilla Thunderbird
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 "Masoudifar, Negar (FT RPD CED OES-DE)" <negar.masoudifar@siemens.com>
From: Christoph Steiger <christoph.steiger@siemens.com>
Subject: Kernel Vulnerability Triaging and SBOMs for CIP
X-ClientProxiedBy: FR3P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::10) To AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cf::9)
Return-Path: christoph.steiger@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR10MB9423:EE_|PR3PR10MB3946:EE_
X-MS-Office365-Filtering-Correlation-Id: c464240b-887f-4656-a726-08df46451f6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|6133799003|55112099003|11063799006|10067099003|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261021121427099003|261022075727099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: YvI9uDDTM1xg0J6d+Ne3LCKM3r9TaT/93GD27Y+uO8EGvctgOYzfppnGCd/0TlWwRte3wb+HKe1+JSukyVFI5jZafyMLOKQSI8VTyeMqn5yqlcL2jU1wp1xhYenpUvD+DRvXMl3eNi2eOUw1AWLGGNV7tQda93d75Z7Qd/jcvSua2FE42wuMTqNPcqXfhzrhG8Sobf0ObuPbFMHcttSwqXZoCxvUahk1K2V/QbXINiP1idnoTaLN13iDnVJPANmuXcAlyVrdHPWjkjZ6c6CeldbVy6E8cZ36b9c5BLfp4aZN9QCsO4iHP/ZefWXAlREg0AGO/nWGSB5npZbSaZg+NbUeY9brnpcwCzT+PWdR4BnxSX9k46SmBrCdazpV4SpvcweGcRk8cVDgBhFwgsCbWCc5sGnIJngpyokYEp/LIwaYoDiQoNouPiQcOckCNExbZE0kcIT7oQVnClxgWIz9LMI5PN0iw6iSKO6p3kURzgaobDovQqQFdhsIcgFRzQRTY7pGXY/n8OFFtQS8dbU54LoRGyXOt5DC6OWincBaXfh0vxrv3jNcUbIiTHWfRaamabYvQkm+RWkWpa6WtiuK28fHQmWjpnZ7DqGc477Z/0uVTWjm9GIuqhhiwgrwtSOU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(6133799003)(55112099003)(11063799006)(10067099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261021121427099003)(261022075727099003)(56012099006)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRITUNUNXJXZDA4ZXF3RytFTkR5Q09BUy8zNGJ2UmdEYmdrK3VGWUpNQUxi?=
 =?utf-8?B?RHhPTW1Gdkcvb2JlTkh3eXNuWjlCU1lpNndNN0dUcFhyTWJiaHFJaVBhenRP?=
 =?utf-8?B?UG45TnlLWHZ6blQzSFlNbFdVSlh6MnFsNUNPVkNvS242Nk9oZ1ErelIxUXA5?=
 =?utf-8?B?cWhQZWI2c29qT1B4RlZMcWtOZDJhd0lmYmNTdFh2T2JDNHZoTDJFMFE1WC9m?=
 =?utf-8?B?YzZNWE1jMUFVUWlvdGl2c3VYV2NwekdrSUJScit1RnVEWEJibDB3UXc3dm5h?=
 =?utf-8?B?M0h1ME5vWWExcTdjQUEzTG83cndYd3ZzenhRRnpZZ1NtNG5LSkx6NHNQMlhj?=
 =?utf-8?B?bTBrS1o4RmY4WVEzRW5YaU01VEhuTnhYUDJ0RzZMZTFwOVhMVjNjSFdIcW9D?=
 =?utf-8?B?VkJtMEh0TFBGYWkzdVhmWDRsMGFMMkJyWGU2TXJDOVJ6a3E4Q091bjFSVmcw?=
 =?utf-8?B?eC81MEJHc1RWZGxRRG1ucFpWUmtUT2VpOTQ0cGx1ZTE1UFNJSWw0VDRidjN3?=
 =?utf-8?B?VHoyUGxOaWEwcTZFZTVGSHRIdDNsWVUySGwrcjhZVkZEK085QVpnUVFYYlNy?=
 =?utf-8?B?Q2NZS1lDKzhnemJNYXBweFQzd0NNS3N1WVFobTU3akxGRUx2bkJvOUZPaUd4?=
 =?utf-8?B?bndGTmNGd2d5MitMMURGSjY2cEUzMVBMVm5WWVVtR0w2ODhyS05hdUJvem42?=
 =?utf-8?B?RC9ISFVuZzk2MFZxM1ZUY0h0dlpwMWhXckRxdldUWVdmeFUwWDdMUEd6K282?=
 =?utf-8?B?QkdJVCtRVFVIeDBid1dPZFdoaUNWZlZGL0g5N05oUVRpUmZhU3RpZ09aWjhE?=
 =?utf-8?B?c25zaDNjaFdvUEZDQnhqN1NRaHYxclplQWhNQVEyUlVtRnFud2k0NUR5ZkpR?=
 =?utf-8?B?Y2Rwa2pSckxlc0U3OXd6ZWs4QVlSWVFvMk5MK1c0clBFS3FBYmZ2ajUvM2Fi?=
 =?utf-8?B?eDFQV2ZrQmRtNUV4N0hJQ3dZcHVzS0c1NHliSTRYc0F2ajJLSDlsZmZ6SnJr?=
 =?utf-8?B?d211c3ZWK010ZGduZ2J1MVFMM0NNUjJnNE5RaFdYMEYyUHhySG80OC8zMXk1?=
 =?utf-8?B?bFpxS0FGYUl6cDluZDNXcm85dytLTitYWGxUM25UNTBGYTY3UUtyYVhyY0t6?=
 =?utf-8?B?bWkyZVB5QlF4R0hiSXEzZHhRSmRqSWxhM1RyWnFRUUZnTEp2aCtBa2xiMWZk?=
 =?utf-8?B?NEthTFQzZDNQSzNEbXp0cFBRL3FLay83MlllWjdyK0FJc0luRGJOQU02Yk9M?=
 =?utf-8?B?eGw3a3dmQXpIVEtSUjBzVnVtaUc2V2VEVkRZcGs4QUFxT0hWOHBVejgwdWJv?=
 =?utf-8?B?NVY0NHhjY3NGYzNZV0swK21vbUZza3hwYkIvblVoVEFaREVIZzFBVGRMU05y?=
 =?utf-8?B?elhHR1ZSckx3ZHhqbzNRQUlQbkNBd2dqSEFZZmJZclhlc05WNlBnLzB0V1dM?=
 =?utf-8?B?SUt2a3JRblU2TzNJeE5yQmlxZnArWkhTVzdsZ2JDMWtZS2ZrZjZWQzFvNEVv?=
 =?utf-8?B?dlBtWGhZbVlCM3ZUSVZ3WkRWYXZsTmdzdzZLcGJtQk9TaG5VNERxa3R3ZTRk?=
 =?utf-8?B?SFR1cDFxWUVzN09DcVdxZG5sMXhBVXlCMHBnZyttQXROaThYM0xvQUFnbHla?=
 =?utf-8?B?UFhldG8rYXM4WDk0V0R4NEZqSHlXaDdId0IvbXFiaGJ0ZWlNVVFaRzNOUUNY?=
 =?utf-8?B?TWhOcU9TalZiVWVwaytKdWNxQ0RLVWliejdpT2hhTXR1eVdGV1JLVGZCZVpG?=
 =?utf-8?B?S041RVdVQlNPWXpEZ215TWQrcGt3aUtUVW44YXI2cTllQ3NNTmhUV3JSa05S?=
 =?utf-8?B?Zy9vM1oxUkk2ZXpmR2NBdncrWDdERmZMWjEyUHJuTnIvakQ0WEVjVWJLRFdG?=
 =?utf-8?B?Y2hvZUc3cHd5bHFtOVpIc3NhYmhiQnlvaTNBTUFzc1dXZ0Zlb3ZSYmRtcFRK?=
 =?utf-8?B?V2preTBtb1JDeHU1dmsvclhpZFdENk11cDFGcnlQaHl6MTcwdy9HY0ZQSW5h?=
 =?utf-8?B?eFZNbHhjTzdnOXBwVldIMVNKQnFIVk95cGFpNmtKUnBQSUYwMWM1b3ZqaW0x?=
 =?utf-8?B?dHZYNDBpejRPVFkwOFA0TGxSWU92Zk5SOXZOTnlBYUcwdE5MVXpMM3dwdGxn?=
 =?utf-8?B?UGo1UWd0c0N2OGI1SXdqbCt4UVFmN0FpYkFYaHcrYm9UcnluaVVoRWViMFJI?=
 =?utf-8?B?Qm5wSGxiYVBtQ0RYOEU5RTZFUFRIc2xsbDJ3UHNXOTRxbUFxdW4zVUNaZVh2?=
 =?utf-8?B?ZGM1ZVNhWTEyaXkycTBIN1BBblZKT2R4WTRuWGpjeDJBcWRhaXFMVWh0ejJ3?=
 =?utf-8?B?RU1sZk80QmdBTHJjbFBYc0F3TElGNjZHNkxVaDBkeTRFY1ZyRTkrRW83OE5m?=
 =?utf-8?Q?eFAGLw7HDjxwZfvQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c464240b-887f-4656-a726-08df46451f6f
X-MS-Exchange-CrossTenant-AuthSource: AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:58:00.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzxSbFyYid4FxDWdnuXguDANYqlaNt10EkYcv5xCHPI8FmluCFoe0U+qnB0Y4ZaimdHGtUgJkI6WK66xJaPKkZijUcjrFtVKD/nxPv2CWBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3946
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 02:27:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25078

Hi all,

as we all know too well kernel security has become a huge topic in the 
last years. Triaging vulnerabilities has also become a necessity for 
every user, and CIP already provides a central place for vulnerability 
reports [1] and tooling to triage vulnerabilities [2].

Other ecosystems have also developed solutions, famously yocto provides 
kernel SBOMs and tooling now that help deal with the huge number of CVEs 
[3]. Recently the kernel team has also introduced native SBOM support 
[4], available since v7.2.

The general ecosystem seems to move in the direction of kernel SBOMs, 
both for compliance reasons and for easy triaging. Kernel SBOMs, as 
provided by both yocto and the kernel itself now, together with 
vulnerabilities from vulns.git (with the affected file information) make 
it very easy to triage your CVEs, without requiring much additional 
tooling on the user side. I expect that we will see further focus on 
this SBOM centric approach. This is also pushed by the kernel security team.

I think it would be a good idea for CIP to also follow this approach. 
This would give us kernel SBOMs, easy triaging and access to all tools 
developed for yocto and the mainline kernel.

For this, the following things need to be done:
1. Backport the SBOM series into our SLTS kernels
    This should be pretty easy except for the v4.19 version, as some 
prerequisites are missing there. The series consists of around 15 
patches, but is solely confined to the scripts/sbom directory.
2. Generate kernel SBOMs with isar-cip-core
    This requires some changes in isar itself, as the CIP kernels are 
built with isar infrastructure.
3. Integrate affected file information into cip-kernel-sec
    Currently the vulnerability reporting done in cip-kernel-sec does 
not include the affected file information provided by the CVEs in 
vulns.git. I think this would be a generally good thing to have.

I already have a basic PoC where I backported the SBOM series to the 
v6.12.111-cip32 kernel and did some quick-and-dirty integration into 
isar and isar-cip-core. With that you can build a linux-sboms package 
that contains the kernel SBOMs. Let me know if you would be interested 
to have a look at it, and I will clean it up a little and post it here.

Please let me know what you think of the ideas I outlined here.

[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec
[2] https://gitlab.com/cip-project/cip-kernel/kernel-cve-triage
[3] 
https://docs.yoctoproject.org/security-manual/vulnerabilities.html#linux-kernel-vulnerabilities
[4] https://docs.kernel.org/tools/sbom/sbom.html

Best regards,
Christoph
-- 
Siemens AG, Foundational Technologies
Linux Expert Center

