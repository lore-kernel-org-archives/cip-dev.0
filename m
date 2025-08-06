Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79153C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 09:42:01 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.52])
 by mx.groups.io with SMTP id smtpd.web11.21537.1754473311151094339
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 02:41:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NcInuPou;
 spf=pass (domain: siemens.com, ip: 52.101.69.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yhh8cizBg/Jo2S9DaD08htYEyehigRtPxJb8/XoJg256U0t/DQouozZzkXDeP0qi46EcUauZO5oDPWy0qyHa1lwxX2He3fntFztzxTHpeYOVj8+99zS0bsa0xcMQp1sKS5a+h1pPD/Jmn2f4aIRAoybP5eUDrmKGqe2skUlC3k0zNZLtpQEZUM/fzRf26y7r6BaXzra4O2pmsXFJ7IY0Tqwkppcd6eT3UUSFwsO6Yfo/Glea/Jm9dZJ8pgZNQdyefsFjR9c9vM2r8q5j4C18MYbCboM/sABkGr98kamWsKx+TgJ5j83xytMH7L7MVsfSJL+91G4OBKXMiszCLwlGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlftt/j0AsxrtGHwNsedig/v+xnSubBrUfnzc9aVcVw=;
 b=QNrObsU3mwFBvosTNm53XeLT4IHcSVtFJIW25mKTHOk8LSv5QuKcNtKy26y2xdMYBUnyOeefdpR1QuGFU/hOpmUiIi7R6hbOK+o3YlkvoflXIE6WfkJWjpXUWsQ+VjPY5+kMtDOQdqQheVoQiSfJRZIHIApSxPngCTJlBuJvcWTrrAANZ076+wuAl9MaCM6l9HGOPc6wXth5JgX0QbeRQDVR+GbubjED2nP3r1amKb+Za0KkTbJA3uwdO8GywCizMd/puVMBy9RnLVHcBpsEzl1jaKdRp+N89DYc7KpksSdFK3LXrRiTgh0uEqeNUJ4hW6oOzFxZXfJcrxDtFnMhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlftt/j0AsxrtGHwNsedig/v+xnSubBrUfnzc9aVcVw=;
 b=NcInuPouoMy7xe4P379LfCr0aEB83nUrey4vGiml7wwY1CaoutIdP2XXteaafjM9dlIXpsAGdWKRSKry08+QnE80aFAX+6KAVIvs1dXwy8J5wMMlu0ZhtfN9pSjYhYUZh0pf+4GBpL0+8/N4GxSVqKFrYi1wv7ECupk5tvJxo3XVC+UZ9BsMbr/3hqpAKZVUm6qYgcyKYLVzVZVSnBSXQbLD/PbmVDXMwSewPr6XxzWezbeRvvq7+YD2+g0q47lJhY7X21lICWbWPPTHBc+yhH6vkX6QdWXFmWkto9RxxLQcCLnsxJmhqxqqMcvOyhNQCqUfafZjHzHHRF6TMtdMMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5315.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 09:41:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:41:47 +0000
Message-ID: <1be0fb51-87e4-4b8b-8f53-2d5a44b4e2ae@siemens.com>
Date: Wed, 6 Aug 2025 11:41:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not install
 kernel
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:76::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: b493b89b-ba28-44d8-876b-08ddd4cd75ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S0F1SjlSOU00aUVhUVFzVjJyS2dSckx2Z3lOVzBVNlBWYTZvZUc2OTgweDVj?=
 =?utf-8?B?K0ZlU2V3R090d3UrU2ZJZnhraXV1Z0Z1U3hnYjd2YkJabWdWbjZySWRaekh6?=
 =?utf-8?B?Y1BkVmp3aU95Vzh1WXR1VUVZNWppK0JYd0VZM1Q4UXNrV0RocUF6WjJNbjY5?=
 =?utf-8?B?MWNuVVkrVkExcjhHTjB3QlFmN3V2cDRvY3N6aWRLUTA3Wk5OS0VhZTJMYm93?=
 =?utf-8?B?YkYyZlVoWStzcXlFdjFBTmQvM3JvOTV1QzNEcjhKejNKMUF0VHZUMWwyMDBW?=
 =?utf-8?B?V2lxQy93bENFblA4R2NVM2srNWFuQWwxZ05oVzBxczQ4Q3ltd0c4OG83VURi?=
 =?utf-8?B?ZCtVRUN5b1dmTWV0N2lmV3FuVVAzekMxUFVYdmY2a2JyZ0FLVnVUZWZMdW1H?=
 =?utf-8?B?VlJXWEZ3eWoyU3hDS0pZZkdxcFllTk5qUC9QSUtaVUhEeE5uRjlqa3lyZnk3?=
 =?utf-8?B?bDJ2UkhHNThYbFJubTgvT3FhS2tFZFg1UVVVckNXQ2xEb1lENVI0ZlloRlJn?=
 =?utf-8?B?T1hKSnl2Nys2REpHaGVZRjVDTGNmNjVpMFU0MDFtc0t2VWlNQU5jdlNWeWlF?=
 =?utf-8?B?ZUxrRjdUWW9PTXRRL1BqU1Z2b0x5bldxS0I0a29QeFhVQ3N6OWNvVzBlelY0?=
 =?utf-8?B?WEo2QkxnYzRickNWd2hReFdVdkR4RTA5Z2JTVVc5amlqdUp1TitQUDBBNEtu?=
 =?utf-8?B?WGtsQnVnL1owZW1VVHkvOUpWY2dkTjVnRkIzRXllOEZSR3h3a2pnWWNmUHBs?=
 =?utf-8?B?WWZiUm5CTFZBUmhrN0R1Y21LVDdvamh0djgwTzErRDhTZzVoWU14aGdaKzJo?=
 =?utf-8?B?YldqUHE5dUtLTXRPWXBZaWpvRHRIL0wxcUEzUkErVGkxeE5OdDBMbkx6SEJi?=
 =?utf-8?B?RFlpeVVPM0IwWEt5ZlJZeWhkWkxqRzhnbUVpV2diQ2U3bGI2UXJiaXNaTTk4?=
 =?utf-8?B?TUNZc0xuU21TOTREcW5Nbjl5bUZzdlhBWEZEUTZva0tkMUNlNWF4aDBwaGRI?=
 =?utf-8?B?cHZLYXFJMkxaSFFKUzM4QWJMNFU5K1RwazQ0T1JYejJmeUdUamQvRkN1MG5o?=
 =?utf-8?B?L090VzB0c3d6OHVESmZ3ZVltS0o5Uk02eTBOT0V2WEtBZjVDRWg1MGJaNXk0?=
 =?utf-8?B?TENoSnFhQ3NTTm5USHZLTmJhSW5RRS8yeDduUmdOaHN1SnloMzE4TExFbjhu?=
 =?utf-8?B?Nllidm9VMXdKS3F4SFZtUjl1MEh5SVdTdElzaTdFU2FOcytOUFMyTnpPTE9z?=
 =?utf-8?B?QW43NGtTK2kyWlZ3L1VoVFZVRm94RmNlU05kWGZQRGFBU3lmTnBuODVLWXF3?=
 =?utf-8?B?cEQvZ0N2bzE1NGZTVnNFcGJrNXlZTzhsVzR6b2l3TjJ6T1lRVCtsSS9oeHdZ?=
 =?utf-8?B?a3dKNDdSUFRJaHFMbGhHODM3YXNtQURDOHJKMzQxZVJtYmV5WVoyMzc4azZT?=
 =?utf-8?B?Qk9nMGN1NEpRenpMZlVpdkJYeXVoQmFzajd6STZURCt4WWU0aytWRjNsS3Yy?=
 =?utf-8?B?N3VXRUg2OFNmR3B3NnZlTmowVmNpeWw2RjNxUmhvQVdrS0pYbEhYaXBGNmNj?=
 =?utf-8?B?c010TEhQYkJ6TFRPRnRkaHBiRkFqejZJSnNSZkZpM0IrcTBuODZOYWRPM0U4?=
 =?utf-8?B?OUphKzRIWm5LNm5EM0I0Q0ZMbUpDMGFtY1dud0VqQk5sREFpZG9ZZGZRVHhU?=
 =?utf-8?B?NkZmS1drSE5VcVo4a2lyQ2lqVUs5QmdvVzN0QnBnZVoxb01QTHdzYkhGMTM2?=
 =?utf-8?B?MkNIVmtKdUNxZ2dMNTRSTUJ0d0pRQjFpUXE2U1U5a085N0JKYXc3ZENkRFoz?=
 =?utf-8?B?YWYxelZpZjRIYURhOGJDYmtzRkZGTTVybW8yV3djVitMc0FiZERLb1A4WHJ1?=
 =?utf-8?B?Qm5ya1ZhMkpiNmthMWVsK3FrNmdSTFJPTlpkYTdnTXhmcCtWZDd4OUw3RitT?=
 =?utf-8?Q?wyC/NRL8Kwo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnBNT2VrQjhwRGxvV3daQW5SNHFHQlNTTHBMcjlzcHVQTDNVT2lIWnBPajJo?=
 =?utf-8?B?cWhHQ1Nzenpnc1Y3anF0ajBRcVI5akJiY3NiWHREU3hUY2l6YWtTMk5XcENs?=
 =?utf-8?B?elNtVXhFUWdCRmhoOFo0Q2duUzFpQng5SmNWd0JzRmQyeFFuQzQxb2VOZitY?=
 =?utf-8?B?RnNKTk00RVRzWG55dEVYQ2ZvTU81c0pNT0RxNXdzdzZid2p5L25XeWtOalFv?=
 =?utf-8?B?NGVURTNoa0o1WVdKekdlOVo4aXVjbXNQcFpSMFJIdDVaamowSkh1QWtWakFK?=
 =?utf-8?B?cTFOT2pvdmRCM3pQMGgrNVV2ZFExY3FGVnczY1Bxc2NRbjBqdlc1aGs4ejlk?=
 =?utf-8?B?MjdOTVIxdXJKZmtiTk9nZDFxcHNubmg4YU16SjhXbldlUVRBRUJ5TGdjUU85?=
 =?utf-8?B?MVF4ckg5ZDJUaThoUEhYMDQ2MzArZmJtcWZyL3hxeGNrUzc2b0JjODVYNktF?=
 =?utf-8?B?SGlSamlOdEJMeGhQS0dybG1BNXArRXh0ajYyRGdjWlE0eGpUbmgvVW9lOXZv?=
 =?utf-8?B?L2hEdS9hdGRBc2JUNXlOVTIrT3ZiL1NLWWxBSFhMcUZOcWtTajlVY0NXQlFq?=
 =?utf-8?B?MjdvczlVTlJaUEhpTlhSelZXclpNRlZ0T2Q1TW1NTE9aZFZ4NWFQOTFFbzla?=
 =?utf-8?B?TVlnUUQzS3lpVVZxc05CenlxR1VjT1hQSlhyc2drc00veE9JQWV0MHBMNUZL?=
 =?utf-8?B?bWd2RGVPKzV3VzZoMlA4MGc4WEVnUG03UXJTUTlsZHBYRFBJVlFoMFoxWkVa?=
 =?utf-8?B?ZjJqZmIwTUd1cE9kazVCN2hqTHg4YStnTld0Z1pIS0pXWTVoekNTN29SOEVZ?=
 =?utf-8?B?NHhySjdKZDM1SGo5RFo2Q3R0QzlUOUpIUDlPbVZST0NWSjhIMmJKeXBEYmJW?=
 =?utf-8?B?OUlLZC9xamNTMGtMVlJHVTZzNEduVmRwQkM4ZU1pK1ZTTVd3dnEvb3JWUk9Z?=
 =?utf-8?B?ZnB6MzllSkE2aEZiVjJPVTdSeHplc1BJSFhDWHJRY2JJd1hvQjB5cEFBbzhK?=
 =?utf-8?B?NnBBSW9RTDlaNktwbFNuNjRKZzFKNWlnWXRjaEo1VHVmYUd4TjE1RHdoSG5Z?=
 =?utf-8?B?Z3VlYzNJL0MyZnc0VituTUo0VGNtQjFaYUd1NHN4OWdJdjJ0ZytDNWgycGJo?=
 =?utf-8?B?SlNhbG9EdXJGalRhMVJnb20yTyt4M0ZCek1PbGhTc2R5VWQ3TUtzMFdNNjZG?=
 =?utf-8?B?eTNiUDlid25nT1FMajhaeVNQbkVmZUFrcTRic1dxSUtuVmttSzdiSENzd1lN?=
 =?utf-8?B?WXIxN2xJTWgydWdWT2pvMk5ZQk9wNy9MaS9ZRnUyRi9RdWxuQTVYWE5KSi96?=
 =?utf-8?B?YThxOWMvdVF2Szl3UTB5Nk9wQkZnUC8wQW93ZlF0eFYwTUEvemYvZTBpZE4z?=
 =?utf-8?B?YTNuTEx0dXViZVBsckd0Qmt3VkVKT3BDajZuVW1XLzFCZDJjVisyVDVKWnQz?=
 =?utf-8?B?djQzMTVZeW1rVmVFd2Q2eWlrNGxFNHpWVzM3QVlDL3AvcHoyVlVBRG5vVzVI?=
 =?utf-8?B?UjJodlJKeVM1aDBEOHY4c3hCaXI3blpwb2s4TXE3MjE2K2dPSVNxUXpybTds?=
 =?utf-8?B?WXpLME9FSnB3UUp6ZHBLQm5oS0hUS0Z6VWFBaDRaalRRMmVHcUFZMkpUd3h6?=
 =?utf-8?B?azhOUUlpdktUS1BDYkpuNjB2bFY5aHNxUmpDd05keUxSVzIzQzdtSmZjMCsy?=
 =?utf-8?B?aEgraVdYcUZVZWJXUWw2MzA1S0FPN2lnUHdJWUphUGFwaVhzREU3Vnl4VzVM?=
 =?utf-8?B?bWt1QUNwZWpENTJzZCs4UjU2SlA5V1EyZEVIeVpKRjJrUW9pQUprclFZT2Ju?=
 =?utf-8?B?aHh2TUJCVFFZRjJqMEU1dXRVQ0d1Z0FJT1I3bjRWcmNnQlNWbXRmYU1LMlJI?=
 =?utf-8?B?L3E2ZUZOZ3k4ajNCS2k2eFdwZE9iUFhaNk15LzRPVml2alU4cFpDUEh6UHZr?=
 =?utf-8?B?UVFXS01rcUJPZ3B1NHM1MzhvSFo2d2EvZ1hkQmpwTmNnTW5mRGFWQ2h5Q2ZM?=
 =?utf-8?B?U2o1U0tsdk54MGpFdmVDckxiK0IrWjJVZEhzUG9oaUMrRzg2Z3ZaSDZveVZ0?=
 =?utf-8?B?UngxWElPNXBEbVBGSjVhV2dhL0V0SzBlN0JkRmppMHhhczc4c3JKNEZYSmhi?=
 =?utf-8?B?RXNkK1RyU08rQVJpUmt5MU8vb0YxbEhkNWZMaGt1Y2lENVVKbm5oNGxvMzhx?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b493b89b-ba28-44d8-876b-08ddd4cd75ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:41:47.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeOYkDhD0AGpXNZjROZgvZQBmp7rMODt8nXK3jmxW+L8juxAGib5H/KO1hR/ML4PqZiK9hrP05ET8dVh7iqX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5315
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 09:42:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19693

On 06.08.25 07:22, Nobuhiro Iwamatsu wrote:
> This adds an option to create an image that does not contain the kernel.
> This is mainly intended to provide images for kernel testing.
> When testing the kernel, kernel image files that are not used for testing
> are not necessary in rootfs. Providing images with these files removed
> allows you to reduce the size of the rootfs image.
> 
> wo_kernel is false:
>   -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> no_kernel is true:
>   -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09 cip-core-image-cip-core-bookworm-qemu-amd64.ext4
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> 
> ---
> v4:
>   - Fix the NO_KERNEL check to 'enable' only.
> v3:
>   - Update commit message.
> v2:
>   - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
>   - Add build:qemu-riscv64-test-nokerne; pipeline
> 
>  .gitlab-ci.yml             | 36 +++++++++++++++++++++++++++-
>  kas/opt/no_kernel.yml      | 17 +++++++++++++
>  scripts/deploy-cip-core.sh | 49 ++++++++++++++++++++++++++++----------
>  3 files changed, 88 insertions(+), 14 deletions(-)
>  create mode 100644 kas/opt/no_kernel.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 628e624..496a56d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -28,6 +28,7 @@ variables:
>    swupdate_version: default
>    test_function: swupdate
>    separate_home_partition: disable
> +  no_kernel: disable
>  
>  stages:
>    - build
> @@ -69,9 +70,10 @@ default:
>      - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>      - if [ "${security_test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/security_test.yml"; fi
>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
> +    - if [ "${no_kernel}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/no_kernel.yml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>      - if [ "${build_swu_v2}" = "enable" ]; then
>            mkdir build/previous-image;
>            if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
> @@ -229,6 +231,38 @@ build:qemu-arm-test:
>      target:  qemu-arm
>      extension: test
>  
> +build:qemu-amd64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-amd64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm64
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-arm-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-arm
> +    extension: test
> +    no_kernel: enable
> +
> +build:qemu-riscv64-test-nokernel:
> +  extends:
> +    - .build_base
> +  variables:
> +    target:  qemu-riscv64
> +    extension: test
> +    no_kernel: enable
> +
>  build:x86-uefi-secure-boot:
>    extends:
>      - .build_base

Another follow-up question, to the general round: Do we now still need
the qemu-amd64-test, qemu-arm64-test and qemu-arm-test targets? CI
pipeline housekeeping...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

