Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3AEC87FD1
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 08:50:24 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.71])
 by mx.groups.io with SMTP id smtpd.web11.17160.1754383822152219704
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 01:50:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YvBMkUqC;
 spf=pass (domain: siemens.com, ip: 52.101.65.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMtHy5sNBZeidFfUDMW/0CIEIDHybre4c1BDhgYocsWmHmLNliayWymrNUAPCrC+5RBOK9pRe18CDDZDW47ZQVUOUN7S0fJ27BEagg/UWJaJOfOG1yRQEcCg6P2JUXqUyMyizrY4WxJuqiGqrzr3KERoEkDPk0RoL+TiujV409H1yJrwEHJnP4agy4FgrhJqpwo2M2TzrMUKQcoQoPALxxWT/vw/sFRYkqwktLF0An3SL3E2yRpXchpagnjNnrcOeZ455jtDwmoHX3XIjE8DGQQ6dVFIGKjlxLWKua/7EVJFXSoNsNFCFRspWcxn5niQp1ru8uGEbl+wu3/0CH0f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0AE7+Drk8fdETkeYmehmwBNgUxFuk0Kd0yCkvMk8mI=;
 b=WArixCSHA+deHDgVvXiRrlRSchKRWyzq6eOmxo7q+vXwJuXFREQONHYHasexWfqFZtM3HVPOGP1OyPhcCcblGJa/rNIsKbH4xQleQ76jI9DYuq7kYsf0jYxUaTAPixuZm7rxe0S87PC5vCJ92wfPDZ4XrlO+Tw/EAv/WX65HGJ6YMt1HWRXGE6xmOId3+HVpp7KEsf6ghN8gCP8e74aSzPXJu8ejaklHU7bHMIs0nT496zzEjwJPColGKT9O7erBVI4EXldRJQ89aAYfM7FG25W0FFHdKUFQmPhc0DeVElrJSkXHb6tWCVCKrvvy3/sJ7LpOb0JYQsLpoq7nNpcUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0AE7+Drk8fdETkeYmehmwBNgUxFuk0Kd0yCkvMk8mI=;
 b=YvBMkUqCbPlEEy9BToB8aPYO4KCy4nAX2FMcbTOkBAC5gE1bSLCZ7fCfRg3JQ7KHjhIWgeE4dQCGp+SZEHhSf5E9XeQaoyOlPm9yZ7c9OTZCgl09sFMxKDceUUCgGKhQVEd3bv1BmVnxy9yTtSrwmO+L2dwxlevLchLmlckU4bw089y4KjwsljWnjEL+3PF9R39ZsxbMPfDjOiPhK9iTYAxO+bdQB+ZqZcjyBcVuJSSWqOYcblciyNsK+iWpFiDuQJLZkf+apvluoaJzGf/c3kAOkf7lNJIwmeM0L3OBYqET752bI4jr2H4WjXsP/gYWrxn+JGd7zOflxLCycM9iVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5584.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:318::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Tue, 5 Aug
 2025 08:50:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:50:16 +0000
Message-ID: <0fb7c732-4403-47c9-9bb8-5e125fc5c5ec@siemens.com>
Date: Tue, 5 Aug 2025 10:50:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add additional test for secure boot to
 test rootfs corruption
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250730091400.950461-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250730091400.950461-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf68a2d-969f-4ef7-4265-08ddd3fd1955
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c09wUXd6S2dqUGJDK2ZHVnZTZlpzZ1dtL2xlTFVvVkYvRDFndHJ0QzIvVDVo?=
 =?utf-8?B?NHR4a3dHUi82WE1iTnlPcmtNY0JjcG1ud2pNdHhWck8rS3NGV2dLVkQ2SUxQ?=
 =?utf-8?B?NnREQXRpZFdzY3RXbmRTVFlMUzZnYVBDRFBabEhiMEE3c1BndTJJWDY0Qkwv?=
 =?utf-8?B?M0JOWTVVZFdmd1A2Ym9aaEtLK0ZzK0NaQVVycjRQU3VKR2VIS0Z3YjhMWU0w?=
 =?utf-8?B?MlFpd0I1QmMzYzBxK0FlcjFpdzNhVXc2aVhjN0JEaU8wdkgzNGJWN05GMzZk?=
 =?utf-8?B?L3J2ck43QlJaRlU0cGxCRDA3anJwQzdibTZOYWpFUHhZdk9ldUJtK0hyT21L?=
 =?utf-8?B?aFNTdktqaEVIVFU4aUtsNlFaczlORFQxUmg3b0hFS1c1cWYrRU9FVjJaZlpR?=
 =?utf-8?B?UFJlQkFJSExiOS84MDJ3S3ExdmdzTEIrMnhpcHIwajZSVkpQOGtIWmdCbUhl?=
 =?utf-8?B?cCs2c1krbkt6bWg2MWJPWDZxeDc3NHNQQmJHcXRBN1dxdzVpUTRENUJWOWlz?=
 =?utf-8?B?Y2VXWHJ3NlREYVMwSTlUbGJJU0lyL1FzRlR6d3BFTldyS0N5czlldnI4Tk1M?=
 =?utf-8?B?NW5jcC82TzBQR1FnM3hYSUE5NzUvSzNURXFjZ1AyaXZKbTZYOHlJNFdrR1ZN?=
 =?utf-8?B?L29YdGhDakRCTXNsQ2FqNGx0R0ZraW5hVDg4TVl3QnJtUDVsdXZqWnZBeVF6?=
 =?utf-8?B?eVEyTmoxb3VqRTZaMlNQS3J6V1VjdXpYb2ZYRlVXWkl5N0VpT0EvbGhmOEpu?=
 =?utf-8?B?VWRGRmtWaXkyQWJjU21MbDA1SkxTQWlJOU1uTFg2YWMvMkR5ZHhkM1ZQcFZ5?=
 =?utf-8?B?OE5NU3RTYzhZR1Jac2p3TmNtcStZS3hYald4OWZzZFdTMlROMHhIWWNBTXlY?=
 =?utf-8?B?ZEhhNGNYTDk3WlFPRTN1S09TL2FRSzlxZmsxSUtkUXpFNEVBNVJWN1o1VHFn?=
 =?utf-8?B?SFl4dnBNU2xGVkhaQWpFaEhicldoL1BVWjJhS1p4VS9JMFFoZGpPaG5Mcyt3?=
 =?utf-8?B?LzRCWklLRnVyMFA3OVB1K3kxVjd2ZzU5SUkwek9TK1B3MTd6Y0VlNHBGTEoy?=
 =?utf-8?B?Ykh5czRJU1p5bVNQQ0I1Yi9FZmpDd0VpeDF2TEZrQVNTa3FwVkZrZ1MxdWFn?=
 =?utf-8?B?a3FKenM2Snpkc042ODFFcWNyODdRTG92MzE0NTl6RU1ZQTV6MUp1RXVlRjF5?=
 =?utf-8?B?WS9sMGpnYlNJSEJvaGVSUG81SS9FeDQvMjBDQ2duQjl6OHJiRTlJQnEzODEw?=
 =?utf-8?B?TkZIRGVIMklFdFh4Yi9UWHYyUm8wSXZuMzR5RkJRUUpPRDdnejYvRXBLTktk?=
 =?utf-8?B?MGRDalkwYTEwL2dZN3BTOE5yaG44UC9KV0FTL1FYMnBMQ2lQWTJ3K1Vhckwy?=
 =?utf-8?B?cDAzMmdGOUJ0V25FMmQ0anRvMHJzMUdsYUlmVUtGMDl3RWFKUDBjY1dlMVBR?=
 =?utf-8?B?OVRpa3lyOEJxNVZ4VzZjdUpabGF5WUlaRGRLMVQvWk9nOURKZi9EY3VYNTNL?=
 =?utf-8?B?S2hWcldneVdieTJLdTQyRDJXSitSOVpMemJNUFAvVEs2TEEyenZWN2pNUmto?=
 =?utf-8?B?S3dwSk1ucEJNM3pnWHVGRDRlUTF6ZGIybUZzV0J1VEQyTHc3bjJKWS85ZXJj?=
 =?utf-8?B?SndGT3d0NWNRd1NIV21neGRHalRyMGJPdzQ3d21UOTl1c1dUSFZId2Q2eGly?=
 =?utf-8?B?V2VzTVhDakNNdHRoRHhvZkNHa0NKT1pERkZrVW1zdDNuNkJVU09lVEpLalV3?=
 =?utf-8?B?UGpvUFRrR2pQZ2xGb214eUNoZWN1eFdxY1V0c2wySHRLZityc0d3ZFpaY1I1?=
 =?utf-8?B?OWM0VHl2UGt5TTRYUHk4Vy9FQzY1dUF2bmxFcEZaUklNa3QzUFltcFNqTFFa?=
 =?utf-8?B?UGxaTC80anh1cVhzRjZ3a2NYT2RtNFZweWc2UloxbHovLzFOL2JvTTFXbllX?=
 =?utf-8?Q?lglzh5wAMdU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWd2ZHlnak9wcW03NjBsdlpDdWlSbklJQ2Q3YzVGdVFLbHU0MC9OdWtxZlFj?=
 =?utf-8?B?SjlZRW9wakRQY3RsOWtXNitaQmRUSGFtbWllbldaWkFsaGFlaVdzZnpiNGpy?=
 =?utf-8?B?KzgvYVZmNGJNR3gzSzlYdnBQaVM0TmRpQW05Q1NVbG1iSlRwd2xnby9XdHJH?=
 =?utf-8?B?RVJSZ3UyVzNKUmNQcDNDcy9JTXhjaTI5WFRyKzhkSVVtYmF0a0taTi9iaHNn?=
 =?utf-8?B?ci8zVEczSWJwdXRxREVMTjlsM2NjM3FWUllqOG1OSHl5WUdBdDZYc1lZbU0z?=
 =?utf-8?B?SzNha3dySEszQ3RCNkZyMUFVWTdjSlN4SHJNTjdERnRrdUFCbkVJNWV6NC9K?=
 =?utf-8?B?WmZ5MVA4WDZ1TEpKUkhWME9ZY2dyNmhLOWlDRGdGcXl0T3lJZ2lDQjJ0OHpR?=
 =?utf-8?B?d1VqSzdwd01TZ0Fsd3dzM0JvbUVTU0xackYyL2tyUlVmNmcxS3h3c3B1Yisw?=
 =?utf-8?B?MUk3YXF3UThlbEEvdFc1eXB3MW45cUcrMHJhRTlEUVJMMFd2L0tmdDFnbDFZ?=
 =?utf-8?B?NHAvUEV4L3lGWFZlaWlHc1NneUpjUDRyUFZxdGpNdE5lSzFtckNlUzVkTkdj?=
 =?utf-8?B?SEcvWlNtaGxtRkUyTG02eGVWQ3VCSDcrQTZKM3YvUkpuZ1FTaDh3VTVib21s?=
 =?utf-8?B?ejIzVkdoSmxvbFlYYWsreTlHNkFKNWhxc1BpeTFoYkdMKzdXRDg4WktnWS9u?=
 =?utf-8?B?SVdRN1lQWUdIT244WEhmSHh1ZVNaS1AxYW4wK1hsbWFMQktVTFY5VUs5TVFG?=
 =?utf-8?B?OFhCUnROUlhuSEFRcXc0MjJJYmNEb0QxdHBHUHRTQXd1bHVMclB2YVFKZ0tX?=
 =?utf-8?B?NklYSC9kOTBIVXV3b2tUclNlK2Y2dDlab1MyN1hnZGdNN3h4cWlIR0lEWUZJ?=
 =?utf-8?B?UndRanFzWjZLNzhpQlNOcjJPck01VU42eFV3UG16cTFmOWdJOE1pVjlWQkZp?=
 =?utf-8?B?eGt3dXlLUnRWZTkzbmhzUnZORU02aXZDMkRWc0ZGeFNSWktJYjhyM2JPM2NE?=
 =?utf-8?B?WUxOeFhIdFc1YjdHTTdGZkcyazVPNWV4cm1Zd3RaNXZ5NWVGZ1RIc1dsS3Qv?=
 =?utf-8?B?bFV2RGxUWnl0RFhsK0hUUjhsSVhna005NE9YYXFUK0dHYkt4L2pVREZNZUVE?=
 =?utf-8?B?TFFOaC9GTWN3RWI5bU5jMVUxZHNLcTVzUFhPdGxrbzFjZUhPQnRyY3p5RXVN?=
 =?utf-8?B?cys1dC9xYksxV1lkZklTVVZjY1hvc0tVZG10SUpSc1hqTlM0ODM0OGdrZ0hD?=
 =?utf-8?B?azYxTHFJbzlVeFFsVittOStjLzA5cEgyOFpvdFF5MW5EL3FIK2o5V3Z4dkJW?=
 =?utf-8?B?WStoTzRoLzV6S1ROZDBaS2drcEN4SFFzcVZnSDJjSEpsZ0dLK0NJTkNyRnRF?=
 =?utf-8?B?NzFkSWh0c2ZiNTJmb29Td2JPUFRMSW4va3JUODY0emt6QWJKNmhnQTZqVlky?=
 =?utf-8?B?cGRIU2thWjN2VUxtckJBQWRWaTRTTGlyQjlUdzBGNFR1QXFlZFErM0hOUDZl?=
 =?utf-8?B?dkh0SG91TkpXNTd3ZHYzaVdqUzhXc2tSWkRlN09jNU5tUk4yWjMwZGlSRTdn?=
 =?utf-8?B?NnJDTkpCZ1UyM1ZGVjAvdVdHZ0NTYzNiQ0hMZVFRang4WkU4YlZ0RVhxYVFP?=
 =?utf-8?B?amxNeHBCUWlvZUNsV1lFQWF5NUpTTXJLY0tsQ25EcDVoaDhVVXl2ajBtL0Jr?=
 =?utf-8?B?eTJsdG40WUxTWjUwbENIOHhBZ0l2RjRFd1NmZ3ZrT0Rjb1JVNEJPRGVyWmlM?=
 =?utf-8?B?SUJXZ0VPNUtyZ0RRN21lNmpIUTVaaXJuMVh2RlRLb2hWUjd3TTVBL2E3NmNV?=
 =?utf-8?B?Y3RUdU1OK2tFOStKQTdOM1NBZWY0NWtuQzFtbkN1VkxUSG9CQUI0WTQvZEpD?=
 =?utf-8?B?OHF3aW1RSTV4K2NoWHRTTE43ZmxiNHkwWlduUnROQVlWbG85L1lNRGQ5N0li?=
 =?utf-8?B?KzljU01Kc3hpSlV6cTJGL0tuWDBEZk1nT2JvSUdJZVZBRWducTNwem5WSUMv?=
 =?utf-8?B?VjdmZkMyTEo5cnB1ZVFnUUp5c1dscFpRcTl1aVM2cFJLQmVSQW5FaWhkZ1hM?=
 =?utf-8?B?eXgzN2U3ZmVDejhrRjBWdlRWNjhuS1ZZem1ydHVmZFEra3JnM3E0YTVQb2V5?=
 =?utf-8?Q?0YEtr7U5XD0oHP3PalfDLJBUp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf68a2d-969f-4ef7-4265-08ddd3fd1955
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:50:16.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxS24lRPN4ktXbZEe9fEqINSGXwNEuChcAsvhuIe2DroCVIVUYGqz9bW0JDABC+q7daCJCO2c+qYzm4eYp+QBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5584
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 08:50:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19662

On 30.07.25 11:14, Shivanand Kunijadar wrote:
> Add a test case to verify and detect rootfs corruption i.e dm-verity corrupt case.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml                                | 24 +++++++++++++++++++
>  scripts/submit_lava.sh                        | 16 +++++++++++++
>  .../secureboot_corrupt_rootfs_steps.yml       |  7 ++++++
>  3 files changed, 47 insertions(+)
>  create mode 100644 tests/templates/secureboot_corrupt_rootfs_steps.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7c05ad4..628e624 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -508,6 +508,30 @@ test:qemu-arm-secure-boot-unsigned-bootloader:
>      target: qemu-arm
>      test_function: secure-boot-unsigned-bootloader
>  
> +test:qemu-amd64-secure-boot-corrupt-rootfs:
> +  extends:
> +    - .test-cip-core
> +  needs: ["build:qemu-amd64-base"]
> +  variables:
> +    target: qemu-amd64
> +    test_function: secure-boot-corrupt-rootfs
> +
> +test:qemu-arm64-secure-boot-corrupt-rootfs:
> +  extends:
> +    - .test-cip-core
> +  needs: ["build:qemu-arm64-base"]
> +  variables:
> +    target: qemu-arm64
> +    test_function: secure-boot-corrupt-rootfs
> +
> +test:qemu-arm-secure-boot-corrupt-rootfs:
> +  extends:
> +    - .test-cip-core
> +  needs: ["build:qemu-arm-base"]
> +  variables:
> +    target: qemu-arm
> +    test_function: secure-boot-corrupt-rootfs
> +
>  test:qemu-amd64-secure-boot-mismatch-keys:
>    extends:
>      - .test-cip-core
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index 6cb0837..5cb4430 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -118,6 +118,22 @@ create_job_qemu () {
>  		if [ "$2" = "qemu-arm" ]; then
>  			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
>  		fi
> +	elif [ "$1" = "secure-boot-corrupt-rootfs" ]; then
> +		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
> +		cd $LAVA_TEMPLATES
> +		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_corrupt_rootfs_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
> +		cd -
> +
> +		sed -i "s@#END_MONITOR#@reboot: Restarting system with command 'dm-verity device corrupted'@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
> +		sed -i "s@#START_MONITOR#@EFI stub: UEFI Secure Boot is enabled.@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
> +		sed -i "s@#ARTIFACT#@rootfs@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
> +
> +		if [ "$2" = "qemu-arm64" ]; then
> +			sed -i "s@bootx64.efi@bootaa64.efi@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
> +		fi
> +		if [ "$2" = "qemu-arm" ]; then
> +			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
> +		fi
>  	elif [ "$1" = "secure-boot-mismatch-keys" ]; then
>  		if [ "$2" = "qemu-amd64" ]; then
>  			cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_mismatch_keys_${2}.yml"
> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/templates/secureboot_corrupt_rootfs_steps.yml
> new file mode 100644
> index 0000000..b6f6628
> --- /dev/null
> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
> @@ -0,0 +1,7 @@
> +          - "apt-get update"
> +          - "apt install -y fdisk"
> +          - "rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=systema '$0 ~ name {print $2}')"
> +          - "rootfs_start=$((${rootfs_start_sector} * 512))"
> +          # The value 96 is squashfs superblock header size, so skip header and corrupt the data after that.
> +          - "offset=$((${rootfs_start} + 96))"
> +          - "dd if=/dev/zero of=cip-core-image-security-cip-core-#distribution#-#architecture#.wic bs=1 seek=${offset} count=8 conv=notrunc"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

