Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0090C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 08:02:01 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.72])
 by mx.groups.io with SMTP id smtpd.web10.15788.1718784120316457297
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 01:02:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L6AwKWIN;
 spf=pass (domain: siemens.com, ip: 40.107.14.72, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvbHKb2NW1tA/UJ1NDllIIVCAMgKdiggQVaWN8D1YMBK3ax1douLGlkFZeJ3XDpXVG6J3chZqt4v8ze9sFk7ZqdaXiKgjT8lUHGUTp5d1ByOuoa6OXlgikEtdvChh6gIDjLkgXCc0rgRo8gV6oBvj3vZcGkmnnDT87IkHWulykC1U88N/i0nzq2sc4fFD+/yMxE8d3BPr0CwRoXzkLY0Aaa7cNcIaTGWKXVLjOJpnQOzvsMAwrDq1mx+vjRMAKAhfv2iks6AJHcqTcKIIL4OIQRtHBAoHH+/QuTf04Iz9xdE/kI+de+9O9AafyV9tgs8auFAQN8L/C3WGaGstk7/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89LrtD7iiLA2aObsVxa1bGXYwkXJDCkjkGUDDITe+cY=;
 b=JtiH0ZK9SPQAIZcqh0K1pc+QVp+eaf8Dw4LERyMaq2vLlt/3BW7wtuNjfRALW8E7dXWcI9rR7SjoPnX83alIpdJzXcDS2vMzgV6nA6z5qplI+9FSk24Bi94+gH3gpsuh56k0rt2zfrC+GB48enkJSfforEiGKabUprDS90XrTXiW9+LV4E9pIU8Lw57OJyJUM/YS0YOhnGYXL7YbrJjev/vz1fbtsPCWaP4wXOBQvtbLxzVRwvA9zUMs6DDu6Gi0EvHUoEgsqnQapIhai7voBvZX8Z/VzQcEiWmlhYonPLfVFHoiVHAHaHNUGMXHmFJZgmnx97Iu0qxMO2Y8mf3B6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89LrtD7iiLA2aObsVxa1bGXYwkXJDCkjkGUDDITe+cY=;
 b=L6AwKWIN1SJzabRAUQJW0x0itilEpey3YjIZL36HUPt4MgMLfpH5+GlMLr8+yCMEYmPGetwPZbpP5La6COiWlYoNxD5hwAl7JO4hOmvIW26WSHkEL3YCR7oKCHYBZTRGx13nI0Fb+e2mjxHLfBgS1JJgb+W1OtFSlC8oO5dXL7giD2pnFzUv0gaRCcIlq/6nOhcXrBRh/g53KTVEP8qasTTA0ckmFZIqpO11mtYGfYIdkl0f4l/AuCG8ffqMGUeHcHGYuibFB2jeKHOBwkrP86TQZgkJmEFomPydNjYyjrra1GhI2HPEzpgrlcA2RxZlv7uTu4rFTGkYLRxFTrJTpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB8095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 08:01:56 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:01:55 +0000
Message-ID: <6fc5ee26-59a9-4c68-ad2d-597a01e5f5fb@siemens.com>
Date: Wed, 19 Jun 2024 10:01:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: fix reboot progress
 with wfx
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <20240618155914.1458889-1-Quirin.Gylstorff@siemens.com>
 <d3c6d33f-4e7e-44a9-9fa6-cfd308e645b4@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <d3c6d33f-4e7e-44a9-9fa6-cfd308e645b4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2828b5f6-65d4-428d-9ca8-08dc9036163c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RlA5ejN2MHhVek15OWRjZDVzWldKUkVLVGNEdGczMUVYMUN2SjB2b3pQZ0Vw?=
 =?utf-8?B?VmpTQzhTaW4xMEVzRWdjY0s1ZFEwMkhWajdxUUVvUTY5b3hrak4rQk13SEpW?=
 =?utf-8?B?NGdKN0VPajYvS3V5S25SR2pRZWdtbTJkckloUFFuWklxNjJPOGpxQVdVbmVP?=
 =?utf-8?B?RE5NVTlRSkM5alVacUxmMFFERUI2eGZSa0RjQzRhYklDT25Rd0xKTVlNekJT?=
 =?utf-8?B?YjY2NXlQSmxaRTNqV3lmMHlkblBrZkZpZGkyM29ma2JzS2VtRDVMZUJVaXNp?=
 =?utf-8?B?NjFtc0V0RnFpYWZqUkUwclZiMGEvYmlZU1FmWWRac200YW41aUV0SDBYMFRr?=
 =?utf-8?B?ckIxL1BLa0VNNkluMXV6ci9FUDNHN3NZSTBQSHRWdjZ5WWxESjBLNnRuUlBh?=
 =?utf-8?B?NEVTcTd5R2xLQnBmd04xc3R1VWFXMnMyRXZpZTJYNk4zbDB5cHBnM21pb0Y3?=
 =?utf-8?B?N0IzT25FenIwYWlMUURsUkxtTTVwelp0am85SXc3Q0NwWW9qTWl2N3dhL3RH?=
 =?utf-8?B?RFhudVJNUEtSOGhETHhDSUdscU9IdFAwSVY4dFlxV0lISWp2Ui94bkdjRjF6?=
 =?utf-8?B?WlMyV1A5TWpoZ00vWmg4MDVha1RBUERiRHIrdEc4T1UwbGMxd2ZRZkx6dnov?=
 =?utf-8?B?V3VzNWsyK3RreEdLYnlnaEVucjJWd2tYYUt6cE9uMFl0YS9uV0JzS3JUYzI4?=
 =?utf-8?B?d3pEM1N5bHdyenM2UDVNVmhDOTNDbFU3eVE5bHBWa0UzZjJOb25QNHB5U0w4?=
 =?utf-8?B?dkprRlZ0SlpyMTBhbUlwQXRra3VCVGVUdG9wZjNUVUI1STdUNjZKLzZhMW02?=
 =?utf-8?B?ZXdZMVYvcVpuR3RiYmw0REI3akM4TTczZTRXWVlFL0IxWGZwbDZkNS9QWFdS?=
 =?utf-8?B?MkRwUFBtaG9Ca0p3K3Z6MUZIT2NET2dvWFNlNit5cDlaZGVrL2dhN3c2Z0gv?=
 =?utf-8?B?aFJNbHdPUjVFNnZNSGVaelRaY1lBc3R6UVQzMGpPWXdodCtQV1V0QkZpdlRL?=
 =?utf-8?B?ZGJCSjNYNFJFVGhodUpwaGdUUk1BaWN5L3J5aXMxUmg0OE5JOE1lV2lTdEJs?=
 =?utf-8?B?U0pFS0pSU0x1SmxnV3RVemN5VDNnT0d2Q0ozOVhlcThuaDJuRlFERHpTeU9U?=
 =?utf-8?B?YUtLK0ErcGJTU3JpMjdzd0ZqU1h3MGVRMGV0M0tUMjRsbS8yUll3c2dQbjZz?=
 =?utf-8?B?MjJSb3BUTGx3YTlsQlpJbVNqWmNJVk5tQTI5UEMwZUsxWTN0cEIvYXRYS05i?=
 =?utf-8?B?R0Fnak1kQ2p4cTJ2OUVyRlJLRlFRcVhjcWl0K0dlMlFoWjRDRS8yb1k3YS8w?=
 =?utf-8?B?VU1HYU1CYlovZzNCSWFOTVI0blpIZUI2NlFpQy9kWTFhd1BCUkxZcENINzgr?=
 =?utf-8?B?YUlRRzR1a1lhMmMxYXZRc1ZrTEtReVNaMEJNZno3Nkk2eVZOSXRXSDUwRDcr?=
 =?utf-8?B?Z3Ayckh3MHZrOG1STG12VXp2VDVYWU5hb1lWWXExQmtNZjlUdFE2ekIxMHJr?=
 =?utf-8?B?Z3FLanlVakozdVFKcjlnT05KbFk2SjJXNXVJbkdObGJUUzIybi9NNjFKMkRH?=
 =?utf-8?B?bFJEM3pMS2pJT2hrQitORExSNjh0Y2o4NEhVbjNlTTJTVW1LZlhQMjRjZlRS?=
 =?utf-8?B?ZDl6M2t5UEppQTQzbWhYaU9JRUMvS0RiYzJWMTRvMnBxTFFwL3p5RnIyTnpW?=
 =?utf-8?Q?CNHRNnWWtZrpWzTrYNxH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWdwbENHcE9CY3loOTJTUUxldVh3bU5xTERvUWxxeW55cno2eHp5LzFjdHpi?=
 =?utf-8?B?TkRmbnFkVzhtd0xUbCsyVUZtdFJZY01LZUVVOGxrVHhhS1lGV2VmSlVIa0FK?=
 =?utf-8?B?Z28wT1RMa2NocXhFWGRvNW1laHhvL3VvZFNuZ0pyT0VyV3EvUWZXSVhCUWR4?=
 =?utf-8?B?WnFqYmpkdTZTeXBqSDlQT0h4bVNBWjhpTmFnZUNDcFk1MUkrZnk3VmJZRUtU?=
 =?utf-8?B?OW5Rc0pXd2xQYWhUbmZoZE9hS1dmY0FxTUV4VzF0b2RydWU2YkNJVkI1K0pL?=
 =?utf-8?B?Y1ozMklQOWZlTjFPSVJmOE5PeDdQeVgyNjdUcjR5WlhtM3RoNmlhd25UdVlU?=
 =?utf-8?B?bTdRSWlOY1Z6b1JYK0xoeVorOFhUSzd6UVdGVE9IWlhKUU1FN2dyTkYycVJn?=
 =?utf-8?B?YXk0cUN3YUlFdTFEZ3plRi9hWnhqajFSR01ZYXpBZTFRRFdva1NBM09kZ0Mr?=
 =?utf-8?B?cENyT0RyMXJBNnZ4cG9TZGc0bldIdzhSZG5IUEt0V2FUMnZxWjk4QXZZZnJH?=
 =?utf-8?B?SVp2K1A3RlBNcGxLQXhvK0ozUVd1d1l3OG9FRjU2MDF0MGFFV0FzZDdPOGRr?=
 =?utf-8?B?WGlGeVhTVGRaZkh2cmpOWm9Nc0laMFpZbjlzVXhwcnBnY1NSU3RyRHNqRG1Q?=
 =?utf-8?B?SDB4NlFLVjk5MERRQ1lkTmtnM3NVbHRCWG5LaGtYSC9WQ01ZY2tlZ2RDalAw?=
 =?utf-8?B?c3p0NmUzMGlPa1AybXcrZm1yam9ObHErRmRRTjdWZVMyZkFpOXhKRk5JWnUr?=
 =?utf-8?B?U3hmVW9tWnVPRlFlWk15QnNtTHFnbk8vUDZaRytEeDUrbE5UWEVKS2JyYlNp?=
 =?utf-8?B?M0tQenEyUmZFOTJ4UW1tbUdRMHRZME5POXl6RWVVQ1AvQnp2MkxjN2ZaN1Zo?=
 =?utf-8?B?U2Zpd1RRaHNFK2VZVGx3S3UzOFhaRGdIRUlSY2J1WE5yWUFYcVEyMzZXamQr?=
 =?utf-8?B?RFpSSTNuc1FLUFRZUXpRUjlLQzcxSlBpdHE3WDROT2NmMzBndG4rRC9wRUt2?=
 =?utf-8?B?OFg1MmYvbG1hR1kyMmIvZitJVDc5MElhUHRlQjd2VUZlL0VTbWVtYTBmWk9H?=
 =?utf-8?B?Yy91dTdSdHFkVnVLVkNsanRBNHhWVUYxZUN5SHVoT3h0VDdoZ3dqdlVOVWRm?=
 =?utf-8?B?SFhBSDd2NUtvTS8zZ2tDY2cxZzlQcXk4bkM4ZG1jN0djUkNKU3dhOCtTeG8v?=
 =?utf-8?B?WHhXMzAvdklCZ3VQa2poaVM2ZlIxMUZUUCtFUG9ZRis1aE92NzJCa1pOb3ZB?=
 =?utf-8?B?cnN6VnMzWWxvZXo5WjFHMmRtUUFQTTZyc0grazdvclZGOHdDSWlFS3hVZnBL?=
 =?utf-8?B?N0FiUXZnVmNvY040S1ZxeVd2QktQUjlGY3cxYkxRVXVGR2hla1krK1hqNzI0?=
 =?utf-8?B?aEowdTcyV3pJR1BpU3QvUUx3MEtoc25MN3F6K2J6RXJCSWhJcThQbk9YSDU5?=
 =?utf-8?B?UzBhWkE5TWp3ZHF2cEVQM0R4UDFhY0M5WnRxOWt6ZTBJQjRRZTVUa3pXVXBE?=
 =?utf-8?B?TzY0NS9TckV4eFhnVWF3c3ZsZXFOS20zdjFwd2k3bFJic3c1VnhwMWg3bHFX?=
 =?utf-8?B?NysrNDJxeE5GWjRFNGlYMTI1SUpyRzJ5RkJPdnUzZHpWZkczWDBxTzVnb0NT?=
 =?utf-8?B?U3phK0dJL0wrcnlOSFZzN01MWTdJSVhlRkY2UGNHejdkcVpTeUFZajlpR1RH?=
 =?utf-8?B?UlNka3pPQzlvZkEyMnh5Z1Z1c2ZGV3QzUjN5Y2d5UHBUcTJXTEVKVWxMVGcz?=
 =?utf-8?B?U25GdnkxaDJ5YzY1NXRCVUhXNzAyOXg4clZheUw5WlRVRnlIVnJjZndZUU5p?=
 =?utf-8?B?U25GcFVRcnpyRUVqUHBCRHNHSzVLYndUY3E5Z3JSSVRZL3lsTTRQdEtHRVhp?=
 =?utf-8?B?Rk9sRjRQcUtDSU52UGRGR2NqM2IxNnlFVjFBQmkzdWQ0VnQwOVhqZ0xRVHVv?=
 =?utf-8?B?NnE1clU2TlYrQzhtR0ZlTGt5SVZzdnAzNnIxby9VOVdEbmlRVlo1djBVYTBi?=
 =?utf-8?B?ckE0Rm4rRFQzS3pZOGxXYVBBN3c5Yzk3N3N6aHFnYVU2Tm5aR0ptWnVIYnZn?=
 =?utf-8?B?elVJc09WRTJUY3laNHFVbVJqOW1ZSU56M1hYWmNsYWpKdlFlY21wZUpUa1J1?=
 =?utf-8?B?Y2lJZCs0Wm1Xckl2cE5EVWNhZXlYd3I1VUdQZXBrQXdjOXNZZzEzYlJnaUxF?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2828b5f6-65d4-428d-9ca8-08dc9036163c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:01:55.7346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmP+Bzfon1US4vVEPC4C54+ZOMbuhSbCmjnsp5V5Y1TTQCGwjeP7SA4hkhieMe8/MLEMN1v5uHcnppoRxhvcIKTA/eDkS5LCpwkyKiN/BBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8095
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 08:02:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16290

Hi,

On 6/18/24 10:31 PM, Jan Kiszka wrote:
> On 18.06.24 17:56, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This back ports the fixes for the wfx progress handler to avoid a
>> second reboot on the device, see [1]
>>
>> [1]: https://groups.google.com/g/swupdate/c/wJ6g5lajuYw
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   ...d-suricatta.ipc.progress_cause-table.patch | 30 +++++++++++
>>   ...ress-Fix-reboot-mode-message-parsing.patch | 52 +++++++++++++++++++
>>   recipes-core/swupdate/swupdate_2023.12.bb     |  3 +-
>>   3 files changed, 84 insertions(+), 1 deletion(-)
>>   create mode 100644 recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
>>   create mode 100644 recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
>>
>> diff --git a/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch b/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
>> new file mode 100644
>> index 0000000..69873cb
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
>> @@ -0,0 +1,30 @@
>> +From 3ac2b34958a31c3694a78f840201373cfaff6c10 Mon Sep 17 00:00:00 2001
>> +From: "Storm, Christian" <christian.storm@siemens.com>
>> +Date: Mon, 3 Jun 2024 20:16:56 +0000
>> +Subject: [PATCH 1/2] suricatta/lua: Add suricatta.ipc.progress_cause table
>> +
>> +Reported-by: Adithya Balakumar <adithya190298@gmail.com>
>> +Signed-off-by: Christian Storm <christian.storm@siemens.com>
>> +---
>> + suricatta/server_lua.c | 5 +++++
>> + 1 file changed, 5 insertions(+)
>> +
>> +diff --git a/suricatta/server_lua.c b/suricatta/server_lua.c
>> +index 7ac5e972..2641a037 100644
>> +--- a/suricatta/server_lua.c
>> ++++ b/suricatta/server_lua.c
>> +@@ -1592,6 +1592,11 @@ static int suricatta_lua_module(lua_State *L)
>> + 	push_to_table(L, "SUBPROCESS", SUBPROCESS);
>> + 	push_to_table(L, "PROGRESS", PROGRESS);
>> + 	lua_settable(L, -3);
>> ++	lua_pushstring(L, "progress_cause");
>> ++	lua_newtable(L);
>> ++	push_to_table(L, "CAUSE_NONE", CAUSE_NONE);
>> ++	push_to_table(L, "CAUSE_REBOOT_MODE", CAUSE_REBOOT_MODE);
>> ++	lua_settable(L, -3);
>> + 	lua_settable(L, -3);
>> +
>> + 	lua_pushstring(L, "status");
>> +--
>> +2.43.0
>> +
>> diff --git a/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch b/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
>> new file mode 100644
>> index 0000000..9719057
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
>> @@ -0,0 +1,52 @@
>> +From c65f5435eec2a0c51f6f0c356451c2091b2f3fdc Mon Sep 17 00:00:00 2001
>> +From: "Storm, Christian" <christian.storm@siemens.com>
>> +Date: Wed, 5 Jun 2024 06:35:24 +0000
>> +Subject: [PATCH 2/2] swupdate-progress: Fix reboot-mode message parsing
>> +
>> +The incoming msg.info reads, e.g.,
>> +{"0": {"1": { "reboot-mode" : "no-reboot"}}}
>> +and sscanf() also needs to parse/read over the enclosing
>> +{"0": <...>}
>> +part, though discarding it.
>> +
>> +While at it, use static buffer allocation as the BSDs don't have %m
>> +
>> +Signed-off-by: Christian Storm <christian.storm@siemens.com>
>> +---
>> + tools/swupdate-progress.c | 7 +++----
>> + 1 file changed, 3 insertions(+), 4 deletions(-)
>> +
>> +diff --git a/tools/swupdate-progress.c b/tools/swupdate-progress.c
>> +index 584910d4..14040757 100644
>> +--- a/tools/swupdate-progress.c
>> ++++ b/tools/swupdate-progress.c
>> +@@ -339,7 +339,7 @@ int main(int argc, char **argv)
>> + 		 * Be sure that string in message are Null terminated
>> + 		 */
>> + 		if (msg.infolen > 0) {
>> +-			char *reboot_mode;
>> ++			char reboot_mode[20] = { 0 };
>> + 			int n, cause;
>> +
>> + 			if (msg.infolen >= sizeof(msg.info) - 1) {
>> +@@ -354,15 +354,14 @@ int main(int argc, char **argv)
>> + 			 * will be added, JSON lib should be linked.
>> + 			 * NOTE: Until then, the exact string format is imperative!
>> + 			 */
>> +-			n = sscanf(msg.info, "{\"%d\": { \"reboot-mode\" : \"%m[-a-z]\"}}",
>> +-				   &cause, &reboot_mode);
>> ++			n = sscanf(msg.info, "{\"%*d\": {\"%d\": { \"reboot-mode\" : \"%19[-a-z]\"}}}",
>> ++				   &cause, reboot_mode);
>> + 			if (n == 2) {
>> + 				if (cause == CAUSE_REBOOT_MODE) {
>> + 					if (!strcmp(reboot_mode, "no-reboot")) {
>> + 						disable_reboot = true;
>> + 					}
>> + 				}
>> +-				free(reboot_mode);
>> + 			}
>> + 		}
>> + 		msg.cur_image[sizeof(msg.cur_image) - 1] = '\0';
>> +--
>> +2.43.0
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
>> index 1c140b0..cc01a98 100644
>> --- a/recipes-core/swupdate/swupdate_2023.12.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
>> @@ -27,7 +27,8 @@ SRCREV = "6ccd44a8539ebb880bf0dac408d5db5de7e2de99"
>>   # patches
>>   SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
>>   SRC_URI += "file://0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
>> -
>> +SRC_URI += "file://0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch"
>> +SRC_URI += "file://0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch"
>>   # suricatta wfx requires suricatta lua and the dependency
>>   # is not set automatically
>>   DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
> 
> We only support wfx with SWUpdate 2023.12, not with the other versions
> we have recipes for, right?

IMHO, we only support wfx with SWUpdate 2023.12.


Quirin

> 
> Jan
> 

