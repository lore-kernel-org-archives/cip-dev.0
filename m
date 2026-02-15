Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC6E63F08
	for <webhook@archiver.kernel.org>; Sun, 15 Feb 2026 19:59:27 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5433.1771185562596754260
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Feb 2026 11:59:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ASKFhtR3;
 spf=pass (domain: siemens.com, ip: 52.101.72.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=un3Jm+1b6OlO9gxruU0yk7H1JshWh7ikE7KI/3ZBd7YQ/QNUcq/zdkMvPc+0T1CjUNROICOr+nm99A9Kx9LasNPXzz9hn+ygFrLZtaShiCBmRzGrjx2hsm7BomxQ6bkeb5d3RSas31sMF3q672VqqgkbvTDZZ3iOVptXVq6sGuW0l/319jEia30+aooJ3LH4Olufq0Qw23a39wGK41eH0CJdW6ciVm961vSffrvUF6cw7V+YrccCXzCuv65YUjQgocHOIpVFKkQBMyEUA4F4lLMNbCBYQrKfBGQAc4Vx86k9IViht7Liz3TkmsRcFhGhOx812PuirSdJm4VnmwaZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfmcK3i6r0cIis6qSkegYuoGexhXiGr++Q2JSfS4Az4=;
 b=skGlqmtrpXXj5wmBnGsiycY+23o9X/Zx6XbXFBih4+I+gCd4AWqsZo1i2Fs8OmxK9mbPaB08JhX04x7IcQIjaWEPD5ghQDhGY/c/aeTvixdkTGJWTQdn7lf3ThLO9SoDLQzGCZRI2w7D3GXEH1aiuhshDp4K7Ing496H/+ICagA8tUnDEb+GOO8qIY4QTNhNGhvEYdAkwJWZViuQccBtZRqC/yDJHUWrK8xkYqogkA1rMgTa7y00dH36WV4/zW4KTsIT9QB7UQOm+Btxuo/viT41YErPm+DgYU5eCigfwIkrDw+LSuo+qQLF818dkkFnF2okfAiFiJrUdDgSiMnKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfmcK3i6r0cIis6qSkegYuoGexhXiGr++Q2JSfS4Az4=;
 b=ASKFhtR34olDgZvbG4/5eTtse7YRaG2/1BpUdPopk1SgkXIlcVll4vygrQkHBmDsNYeNnftsHNd6eaIle1DBW6N5KsqZ8Lr8mqnRlf/8yqweWwj+yJ0yaEUiY0wjLcEcdJFHqatgRAOO9kB1m+7fXDAJLvulUO1mYHHlfKiDIpUKQGUhHWP+ip81Lv4PYFeB1NzISs9EdtNc8+f4nx8+14BURbcfhgZGQ3nzg8tCSBKY4FVArb02FlJN2wegf390hcm3FPB9XdJS2FjtMvR6TxlTE8CjaIJoLcAh8q9aI+8YQGJ9ml/v/LbUn9gUlK7gO+N9dlPW5J39qolsl97QLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 19:59:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 19:59:22 +0000
Message-ID: <ef00de95-4721-4aee-a325-c35e1b859c89@siemens.com>
Date: Sun, 15 Feb 2026 20:59:21 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.249-cip69,
 6.1.159-cip50-rt27, 6.1.162-cip51, 6.12.69-cip17
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee2d9d9-c701-4bf2-a2fd-08de6cccb630
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0pvR2RsQllhaG0zQVZNRE5DU094Z2dBMUdPK1BEUjFpZjZUVm1xUXhaM0Uz?=
 =?utf-8?B?L05vanFzMDRLRDg0T0F0djNFcU9jWUZOdHJOdGQrRmh1VFZJWGFpeEFzUWV4?=
 =?utf-8?B?MTMreGJNb3FNa011bERpVXhuVjdxR2lYVmFNYWxMdko4cEZvTDF2RWlsc0dC?=
 =?utf-8?B?cVpzUjE0Szd4NWpOc2t0WmQwT0lXQ0JjNHRIVS84Y1FGWmdhbzE3b1U5WFRG?=
 =?utf-8?B?Mk55cUpVaElSTXNPOVh0eHlGTXhndXc1SUVZSXZaaTZ0NVl3R0JiSmJRZm82?=
 =?utf-8?B?MzVzWmIzakxmeVAyeUNGQm41UWp4ZUVFMHRTK0w0M3NBL2RUMitmMm1raHow?=
 =?utf-8?B?L2tuSDF4ZlZSdEZ4dUZybXNxUGFyb2grWkRvOWRXMzJDYmQyZVFNcis4Rkw4?=
 =?utf-8?B?WmI3S1ZGUy80eTY3VGR6ejkyem5WOWd3N1JLTWpyNGFuVnRycFRzRFFKTzJG?=
 =?utf-8?B?KzFsdE15MzZ3bVQ0cUNJUXNsOWVIV251bzY4ZFRjZlYySW5IWmpwZFhHdk1S?=
 =?utf-8?B?QUZRL0Zzb25WdHk2RVJEUFZ6aWt1bml6ZzRESnNBSkJ4L3hnSnd6SkUxOExr?=
 =?utf-8?B?YTVtdHpIME9DOTZmTmZZcWlGNmg1QTl4WVM0TGE4NjNScUxvOUE3d0hYYlpa?=
 =?utf-8?B?ek9GVnpUeFRTUkY5ck55UXU3TW9WUFdOeDNUSzZ3aEUvTTc1OXJ2QytBVkFt?=
 =?utf-8?B?Z3l5aStsT25mYVBIUk1NbFp0NHhTdWxMQXNoZXdWcitndDVGejNrNVVBMmg3?=
 =?utf-8?B?alliWGdPU0FMVUdFZ2g0MU1OV2tjNFk4RW9ndkhtUDI0T2JkbzFLZUZ6T29K?=
 =?utf-8?B?MGs5WXRBODlVV2I3M2hzakVSSHJjL0RnWXdZK3ViZFd2bk15RUVVMkhxM1ds?=
 =?utf-8?B?ZEJ1cGpvSFhTSTNiaDVmM01NTEZQb2pBTCtMOW5UTTRyd2gxRHd0OWtJU3NL?=
 =?utf-8?B?aGZtckZVampWajdLNzZkRkxXOGVEVE5DNHFvbUJ6MEJydlBScGxrc0dkTVlq?=
 =?utf-8?B?dXM2UjVKSjdIby82eGEzSEl1ZGRiaWFQWm9CTEpvS1RGcGNiWm0yaWZwcC9k?=
 =?utf-8?B?RDlQRGowdndnWjAwdDBDdVNrdHc2NDVVMTBEbnhzTGRRcG1aNzRoMWFEYjQ5?=
 =?utf-8?B?ZGlSZ2YrYjdHdTJNMWtvM29xS05DTG5rZmkveE4xVC9wcGFSZFZHMlY5SDRw?=
 =?utf-8?B?UlBPeG1MWFNDNXhHKzhOS1QxaU83cDdESDJDYy91VXdjWkRKQkdIUEhpcjg3?=
 =?utf-8?B?T09scjJ4dWNGNzFsQlhlLzNQMVloSEtMZ2RRNHp6K0tYRlpwL1hIMWt1ZzRv?=
 =?utf-8?B?UWt5U2VrbTQ4WG9ob0QyRFYwUHdQSEg3ay8zQlBQVkNrRWY3c1N2bU5UOGx5?=
 =?utf-8?B?TS84SXNuWUVINEdnb3AxUWlDZHhHaHVPdHFwQ3BSSGplMU56SFphTnhXSUEw?=
 =?utf-8?B?MWNXUkJBUTQ1MTVhVG9CY0VTV1doNVRBK0Q5dEN2ZWR3NTYwYklHQldza25X?=
 =?utf-8?B?dTgySjRySnBRaXRTYUE1MjNQMGdnaXNhVlNQM0w1L2tLOXVML3lzZktvWGRt?=
 =?utf-8?B?OERvR0E3S0xMM1BDeVFOM25nVm9YN2ZYdmxuNldzWStEdnd3ZG9QaWtQRjIv?=
 =?utf-8?B?OFNPaFJ5VGxidlNqb3JxRk1XWGZ4b2ZqUm1pNGwrU1Z5S3ovMUMxVmM5b2dM?=
 =?utf-8?B?VkFRSUdVYnZ3cVoyNzFtVW42VnJQUVVxaWgwYnZDb1VkeDF0azUxa3EyYUI1?=
 =?utf-8?B?Q3RsMjg3dEZhSEZsdVVyR211YTB2MW5peUNOMHgvM3U1NldPWk5CeEY0UTlG?=
 =?utf-8?B?aVg3b0wzMEhodXJHSTFNRTlYSUR4bWVaV1FmVTdRR09FLzlFM3czUStCU2ZC?=
 =?utf-8?B?cmg1WUFqOTZtaFRkZUMvVEtGVStYU29WZnhoSmR2d1dnVmowbVFaRG9qS2ZD?=
 =?utf-8?B?ME1PTUV3UkEvblMzNEhCOWZObEVoYm53UUM0c2lIcFBvL2t2Qk5VYS9kQktE?=
 =?utf-8?B?K2d0VytKR1BOSTNzV3pyRk1iMk5FYXRBdEw4N3AvanYyUGlMZGpVbnZ2ay9N?=
 =?utf-8?B?UWprMkFrRDlqK0Z3eHk4ZXJwTFlmbjMybTVhb2QxSXNzUW15bW4rZEMzZE5D?=
 =?utf-8?Q?P5Yw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blJFZDZMRlZUUjJZb09mcS8zcW9yZ3laMXh3N3o0VnkvMHlQMkNtTHBEdjJL?=
 =?utf-8?B?dUJhWHRWd08zNFJWTGx5WFR0em0yUFc1RjZZYS9EVWx2L21IRy9mSHUvK3NN?=
 =?utf-8?B?ekMzMkkxQ3UvT1RlTVZjOW0xYm84cW9oODVzUUM3aWNyWVAwRXJJSjI3WUdJ?=
 =?utf-8?B?RHg0NkhWVk44bUJvZ0VXd1lObytveno5MkJESWVKVDhNRFl1R0ZqM1EwaW5T?=
 =?utf-8?B?Ym15K01nK1VrdEZicS9jZTRWOEZtUWZQUUNtVks0dVVuWHZYL0p0UG1nMy94?=
 =?utf-8?B?MGVCc1RSRStuU2lpRzZwcVlQR09VNU0zc0s5RnFzb29kN2kvaUZSOXYvZ0lr?=
 =?utf-8?B?dEJMd2pnRlJiZUgvei81Z2dYMyt3RWtGODlDMkU4ZGkzTXM2ckhhTWpWU3gv?=
 =?utf-8?B?ZjE2NGREMllKSGNkcTllUzFmeUJMbUJMSU9Cc1lxaC9mdjJBYjI2RDdxQUQ0?=
 =?utf-8?B?ZG83R1Y0QnJUMUJBeWVWdG5ESmk3MXVCM21xR2ZmR2RuVnpSblp2R01namIv?=
 =?utf-8?B?SDFnMHN1WkdMbzVlUjRlQTJvcTlmRmN2N05jZjBKRFZOUUxSTlJsdG5XckpZ?=
 =?utf-8?B?R01Da0hkZ0hCb1Jrek8yWEtQckFoOG8yS1RIcjU1TmN4Tm4rMUZiY1FPNW5T?=
 =?utf-8?B?VGdnb3FtQlhJWisvb1U0RDNNM0RYbGhFdzlGRHNZY1hsemh1QUd0LzVpOEti?=
 =?utf-8?B?TEk4ZXBXWW91VGIyWVRPQitnMmNKRVBOYkRVbkJvRVZ0UzJ1bUtsSUJOc3Fz?=
 =?utf-8?B?TzVSVmhnOGJ4L2x0UElhWmlqQXE1bEEzZHNIdnMvSGFnNGZQSEVTdnpCQTZZ?=
 =?utf-8?B?ZjdQSWR4N2w0ZTVYMW1oWGkzOXBFOWczZ3puK2ZkOG9NZmhCUUFtZjZaTFZG?=
 =?utf-8?B?c2lLeWFvQmJPUVdxODdZMDY5aVZmbDdvQllLL2VjZW1GNmE1clZ3akRjaWJJ?=
 =?utf-8?B?cytkRnc5WDVvR3EwenFzTTZ4YVgxTnVBNWc0dWlYNTNUcUdvUjAzb0xValc0?=
 =?utf-8?B?VjA3MGJxYnduRDY3UU8wRWIyWDdBTVlzSXljYUIycFNDRTc2aGVGL2toWFF1?=
 =?utf-8?B?Uk90K2NraFh3Y3d4R3ZReWV5RXBKeUVHY2ZIaWRGQVBYY3F0cytiSzB4Q0J0?=
 =?utf-8?B?dlNSNkFLQ1NkMHRqNTZVTE1zbVg5K3duaTNiYkMxakg0bEVWWStVUXU0aDJt?=
 =?utf-8?B?bmN4RnFyZW9Namppc1JTbWIrSGVzU2hJaEVsQ2tTTmw2cnRUSWNCVlRRbTd6?=
 =?utf-8?B?enZtR3hOZXlualAzaWxaY0Q2MVB3cU5lSUFXd3EzRFNFSTI0Mk5NTUJvdjFY?=
 =?utf-8?B?UHBMZUVxRWNJTzY2ZHFaLzdvSWFzMTRNZ2I0c1dHRXNLbWlqdkhHL2pzWVFX?=
 =?utf-8?B?NHJYbUtsZHJWYUtjZ09CNlpESnhBRnVRdWt5S0tSSFN2NkFMV3pHclRyeTR3?=
 =?utf-8?B?bXNxVFJYclVYSDIweVgrU1E5d2IvVWpGWTk3enNFSWxCeGtsMGJ1RTJGWlF5?=
 =?utf-8?B?MlpncEVjakRTSUdpYjBvNWV6bGVWWUNadGtrcTY1d2J4MGxRWHRlenFZN1I1?=
 =?utf-8?B?S3dwVmRHYXBxakdnaUFEcVN6SGU0MjFvK01FU1NhQ3FvekdVbXlFUkFDZ0xu?=
 =?utf-8?B?d3E3MnQ4SnR0cSsvemJ6VUxDckhKUmJOZ1pROGllVXpEeXRac3ovdkJzYWdC?=
 =?utf-8?B?NUNkMHJpS0JnZnVPbytQYTNqOEZpNVIxMFBCNjJZcmRuMGFSYWt1QUdBZVRC?=
 =?utf-8?B?VkVUalNRMThpeDZDV3RzMjhLK2VjYXVZM2VlOU0rcVNHd1IrbjE4WFprRGI2?=
 =?utf-8?B?dTFqZ3FKOVNaUEJieFU2UGdUaTdmL0FPRWNVdzZvSXlzaDZIOHBOQzFLVFJ6?=
 =?utf-8?B?N1RiVVhnc3pMQmY4T3ZnQ2poYVVpNDFSYzdrMGNOV1pFZ1Jld0t4R1NwaHpV?=
 =?utf-8?B?bU12dHRvYjlrSXZGa1VCa3l0WWZuL05TVjJsNDk2V000dVh0dHR4Uzc0MzlN?=
 =?utf-8?B?eHh1U1AyT0orWXRXWm43ZEZXM1FONHBNUHE3ZmdtUHo1UTk2NDVqUEIyWVR6?=
 =?utf-8?B?T0RYQXJ4WkZRSEhiTkNiTWRVNEplWmlvRW5Lb1pCeDFXU3VyNUhaMlE4U2xo?=
 =?utf-8?B?ZWJJM2ZDUVVNbGRrUnFza2k0eWliZmVlUGRocTFhRnlUR0puc0NSZmVlSnc2?=
 =?utf-8?B?T0cvVzlUZUQwdlVNdUpVcndpNmd0Njh5YjhxQ0IzN1hhTjkwZnNBRXpuYlFH?=
 =?utf-8?B?M253ek0rY2NhTlRZZWptd2s1TisvUHpka2FsQUNxL2lOanV1SGZGRFpnamV4?=
 =?utf-8?B?c3hYY1lNcENoM2NKT2JYT0JQS3ZISERRRFpqTDkxT2s3eHpRYVNiUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee2d9d9-c701-4bf2-a2fd-08de6cccb630
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 19:59:22.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbBErlKVAAx7RZ2XtpMy0X5WKBtPoc0FPtUr5cqNev4QG+kpCUhk3gVOHZ2J2QsMuO7TTuakqW6H6djE7LTjng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9387
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 15 Feb 2026 19:59:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21876

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.157-cip48-rt26.bb => linux-cip-rt_6.1.159-cip50-rt27.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb              | 1 +
 ...{linux-cip_5.10.247-cip68.bb => linux-cip_5.10.249-cip69.bb} | 2 +-
 .../{linux-cip_6.1.159-cip50.bb => linux-cip_6.1.162-cip51.bb}  | 2 +-
 .../{linux-cip_6.12.66-cip16.bb => linux-cip_6.12.69-cip17.bb}  | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.157-cip48-rt26.bb => linux-cip-rt_6.1.159-cip50-rt27.bb} (59%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb
 rename recipes-kernel/linux/{linux-cip_5.10.247-cip68.bb => linux-cip_5.10.249-cip69.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.159-cip50.bb => linux-cip_6.1.162-cip51.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.12.66-cip16.bb => linux-cip_6.12.69-cip17.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.157-cip48-rt26.bb b/recipes-kernel/linux/linux-cip-rt_6.1.159-cip50-rt27.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.157-cip48-rt26.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.159-cip50-rt27.bb
index fb4810bd..5ddc44fb 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.157-cip48-rt26.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.159-cip50-rt27.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "38f7198a3b3e1b0f4c92452754582866c9d12b14272fa57f502c75ab64c8e576"
+SRC_URI[sha256sum] = "1ed937388ae8cee994aa8b28e56fe38851f967b013acc6256d0dd564783dadd1"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb b/recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb
deleted file mode 120000
index 6e65d612..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.66-cip16.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb b/recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb
new file mode 120000
index 00000000..96e4c4d8
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.69-cip17.bb
@@ -0,0 +1 @@
+linux-cip_6.12.69-cip17.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_5.10.247-cip68.bb b/recipes-kernel/linux/linux-cip_5.10.249-cip69.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.247-cip68.bb
rename to recipes-kernel/linux/linux-cip_5.10.249-cip69.bb
index be45795f..13efcfa6 100644
--- a/recipes-kernel/linux/linux-cip_5.10.247-cip68.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.249-cip69.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "68942a5e17039b54731c763e274cef62c0807c1e3b2c1276a1f4d63e7769bbaf"
+SRC_URI[sha256sum] = "9e5342629465767c635f7afd2b9d0c60fa70204d9609da00021e307e306f443c"
diff --git a/recipes-kernel/linux/linux-cip_6.1.159-cip50.bb b/recipes-kernel/linux/linux-cip_6.1.162-cip51.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.159-cip50.bb
rename to recipes-kernel/linux/linux-cip_6.1.162-cip51.bb
index 182b34ce..f3310dcb 100644
--- a/recipes-kernel/linux/linux-cip_6.1.159-cip50.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.162-cip51.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "528d3ce9aa06dffa3359e26c73492a2f2ce7fd7026e5b82f33f355a8263e544b"
+SRC_URI[sha256sum] = "b4ab5ade94bcfb0b0f1051b8266772a4c72020253646ec0b389f99c1d9d7d086"
diff --git a/recipes-kernel/linux/linux-cip_6.12.66-cip16.bb b/recipes-kernel/linux/linux-cip_6.12.69-cip17.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.66-cip16.bb
rename to recipes-kernel/linux/linux-cip_6.12.69-cip17.bb
index 9db40ef6..0fea130e 100644
--- a/recipes-kernel/linux/linux-cip_6.12.66-cip16.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.69-cip17.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "8789118bef502c6ed32cab8dcf2de605b08152569a71ebe19ba8d0d4476c5cdb"
+SRC_URI[sha256sum] = "5185fc3b792317497c8eaf0796ae21bf6b6973655d9ad3c2f26feeb1f661b492"
-- 
2.47.3

