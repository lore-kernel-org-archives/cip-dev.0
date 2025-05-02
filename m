Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA79C3ABA3
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 07:48:27 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web11.14310.1746172097555147572
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 00:48:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=emRREsuK;
 spf=pass (domain: siemens.com, ip: 40.107.20.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UevL4Fb5ieOKzVMCppI3NKSGJOduA314NriMuKSKJtSZm93YX879+2EcSP7PF8+FAR5/jKGshO129cVwp6vwV296CDSZB+0XRQNyKA3v9nNyDgjkc2Nv5n+DtL+DImUeI/wovMnACmmTYFa+411B3XLxM6cOHFUit6gtoaxOx9cNS/Mr0+Rh+4KZZWnSHflNQPuEk1B935zvTx9MNbFx7zHKlKgNYEyt1Lw1fURJ227cEjGFXmaZGvsbR9jJCHaji2Jnsa7RmasAx4uAY1Y+tYWXNOOQ+9nXo6K641XOEPlFWsg6X2f9tOHv5fBxdFcgl2d296lHEJqBwuwHnz9yUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9USkFtc5maNyAOvsTcHncQ7/E0gCo5/gYbL74oSbZA=;
 b=ebhiInAAo8luVy+PR3CjE3EFylgRj+vwq2g4sfQ99F4sB60fI9o3XGfHvMNaanemn+mIHhyL4FJ53gHV7jNW9IHx38By+0rtWjTXme+oikY6Ec05VcZ1M8vgHdsaYIFy3aW5+VXg5KVckRCJDNaDFONf5G2IKvifJTuw4u/BKSwtZ2LozCueAa/yoEO1llAgUuDGxhn1A/VWpErQzGYO1tPSTVhuCwPz5dJW/EWzgiVzkkcvA1gilY/1Gu72iwMrce1hsqW4oIUwfYLT9GXtGhA1foTAOprSb2B37QKUCGfPWMDa6dS7srn6SNWZLN9njvuhvz301k03cKBrPR/zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9USkFtc5maNyAOvsTcHncQ7/E0gCo5/gYbL74oSbZA=;
 b=emRREsuKcCkWcDZBOp5kWWHlW4QB8cmNZekQChXN9r1prJ04NIvZYF57qr1FN7JkaEx9KqAQan7NwTckg/qsAL0NY9ZYxG+lti2IiAP5kl8hnI58qngDlKoFyjMQit3bq/GoOVCi+E3u8GAFd7nLbYH8a3nfv6E8DMWD7pcOMx3Cehcu52aVAZLRXxCeWEqK+yh0yJg0F/D+oZ74RZQCZeWrw5J+scOhq/BM+//aojt9hTf96NKru7iHuJDojpHaArdfVxm5Nr6poULRYmcMsdaoYA4FD6KtrTVTp8V5Qit1huPnknHnvgsKbJSxTawXbNw2j/FgNPTlfTHU1WO7tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Fri, 2 May
 2025 07:48:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 07:48:13 +0000
Message-ID: <a4e695d7-7f81-49c1-8926-d7a2fc61829e@siemens.com>
Date: Fri, 2 May 2025 09:48:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 2/3] scripts/submit_lava.sh: Remove
 passing readonly=on for amd64 OVMF VARS file
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20250429042028.3579304-3-Shivanand.Kunijadar@toshiba-tsip.com>
 <015d9f1b-540c-4943-9a5a-1bc7bce6ec80@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <015d9f1b-540c-4943-9a5a-1bc7bce6ec80@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7958c4-6edc-4f38-bd13-08dd894db144
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WnQzN1R0ZFJydGpxd0tKVTIyMFpNSkxaVUtYYUNFYTRUWUlWbmlnV0cvZC9t?=
 =?utf-8?B?aWppSFZYSDR1WVZnbUxFOGF6SUQxN3JYZjhOcUJSdE8zQW5pbDZnOFlQMzRP?=
 =?utf-8?B?YzZZSmZHdzEwMjhjQ3JFeUZLSm1kT0dFWmEyTkNvcU9OblVUOG1HTFcrQVhX?=
 =?utf-8?B?clFZWHBVRFQ5TGVGZnNsSis2MVNMZnR4NXVQUzY1U1dSbS9EbmtFektXMmwy?=
 =?utf-8?B?SGdRVVJnWEUxRW5jZ0FLbXN6b2xqeXB4NzZnRDVvK01yZi9TdndkNDBHbDMx?=
 =?utf-8?B?WUZDakw2YXgzOTQ4L2RYSEFhcEJacmF3QXJ4Z3VjbzNxdDgwWWJQakxya09m?=
 =?utf-8?B?ZU04L3lHSGMwUE1Cb1dhR1hwb2hvUk9EdVhYRWMrT0x0ZHhJT1EyeTE5V3NQ?=
 =?utf-8?B?RDBqMDBQSWVvbWxJZG5EbXMwaENXSWtWU29yME5UeU5kc3ZOWVJUbXlDWFNa?=
 =?utf-8?B?V0VrQnpZOEpXcEg5SnQzREovZnNhOVhsTDVTWi9kam1HWHh2d2QzSW9nSHRR?=
 =?utf-8?B?SnltMTdRaFlKV1hINWgwdy9EdFRwK2JGNks1Y29yeThraWtDWVk5Tm9nUW8w?=
 =?utf-8?B?VXY1SEJPcG5rVlNOaHpVTjN4NjhOdngyQW9EVmdMQlhWdjN0dzRyUHhMdSts?=
 =?utf-8?B?cmcwanAwMFlTNGFzbW94VEdRVVNMWEZDYXpoZ1JYRTNmbG80aFhyWmc4eWpY?=
 =?utf-8?B?RUpUVW03ajdGR2NXU1Y5aWJKVjJwY0F4UlNQZE12b285V2lOL0dzRHU2UlVY?=
 =?utf-8?B?aXpHRUE2N3NjYUxKSnhWN1RJa2gwdVFwekhDOE5FTWpiV3FaZHZRLzJoaE5H?=
 =?utf-8?B?c1N4QnhCSjlING40MXNMbXAxZU96NFgyUnNsL0ljalBFMGtFUGdnUjVGTVY2?=
 =?utf-8?B?RHRGdFVnSHZaZ2dOM0ttaE5vWDRab2JEdW0yWG5Ocm15WHdlb2J6YjJPblc1?=
 =?utf-8?B?aDQ0ZXZ6b3ovQjhlQkJpTVRUTlg5Y2RJSVBUOEdRWGxxd0ExeUcySTd2Mmcz?=
 =?utf-8?B?VDhta3Q4ajlXdmVHL3VqWXlZdVdHbGV1REEvWnE5M1lrLzJHck9KeDJJOWdz?=
 =?utf-8?B?dWtCSmhGeDFBamJObjRiU3RSVWp1WWY3QXVQenhQODJyaXg0Ykk1K0VxV2xu?=
 =?utf-8?B?SE9CSVJtSzhRVWp6Q1NJM0tpYXZPNlZMVC93Tlcrc09HNGpoTG4rbmxVczZW?=
 =?utf-8?B?WGorWU5XUmtYcWNyMk1wU0Zhb2dKNm5qTnBuKy9YU2JkMGdYQ05lUDhRWXpN?=
 =?utf-8?B?ZVJ6U0QvOGpwQkgxd2pTWkRxVEhTdDMzblorWEtFYWNQSFByazJ2Z1JpaUpm?=
 =?utf-8?B?MFU0TTBKTWE1WmRFdTBmNXFrZGJvQ0h5dkJHakczYUFqL3lDY2prUXFOcEZ4?=
 =?utf-8?B?QXJpeHh6ckRGbGRJTCtNK0k3dTdSYlhQUGFIdTR3bjNKM3pmNGFpTlZQZkVV?=
 =?utf-8?B?Uy9lbVRFdmFNaHVObDJqWWgwR0ZPY2gzSno2TVBGb1hvYmxOU1llekIxUk1O?=
 =?utf-8?B?N2l2bXlmZENtdS9JNEtQMlp2cVNwVXY5bXZOMUtNYU1pY2VlRGEwcCtpWGZy?=
 =?utf-8?B?Q2Y1R2lHajZ1VC9IQ3lqTlBzK3FKTHM5bEdja2QzZVVGSkdLRlM0MW9PTFhu?=
 =?utf-8?B?YkFWWm11dGN4aStlSEJxa2I0VjM1Y0prMzFWc2VBQmFJVkR0dFZZMkhNNjU3?=
 =?utf-8?B?cnFDRncxUWZjMlZRbFd2Q1BZbjROTnNaZ2prRlR0UEIzd1h3RDIxYWE5c1du?=
 =?utf-8?B?cE5DZi9MTlcwZnRZMXpabzdEUXc1allpelk5Z1dUbUlHd0txVDU4KzBjM1pV?=
 =?utf-8?B?UlZSalhNVW1mOFdTYXJNWmdVZnJUa1l2WUw1bDd3U01yTjZMVWZoZ2pyRTFa?=
 =?utf-8?B?bVlUaXA1Y0ZrYVBLeVdOa1czV04zTktIcm0vVFlqbW9CZjB6RE1uUDhLSmQr?=
 =?utf-8?Q?N8RHsQ885/I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WG9rQmE5bUFpMnI1aTN0bTJ0NGFnUDlRc1J2OXJRZmNPNTd1V2hMampmTDRs?=
 =?utf-8?B?TG81N29aOVhralpJeFUrUU5SNkR5Qjl1YW8wV3A4M3QzT050UTBEU3d2b3BF?=
 =?utf-8?B?NkN3dlNjaWJPcVhTNk9kL0w1c1R3aGVWVit5UHErT0gzRDJjeTJlUDd3R2Vj?=
 =?utf-8?B?bERCYlVZWnB2UTFWTitkVWFWQXFsaU05U2dTRXNmaTJra0gzY2NhZkhlR1NY?=
 =?utf-8?B?OU0vTng5VmRDUVRVZUJsa3JBbXdCYlpvNkZmSkgvK3JKdnRNcTdaUFhBL0Q4?=
 =?utf-8?B?NHVOZVZySkluZUtUWWxKNG5nUjJRQklLbzhUVnI1OEh2Tm5VbkVFeFR6Wktj?=
 =?utf-8?B?WEplZm9HWmZKU2dxVVJPblF4Q0tLOUVWSkZmSTV3YVEwSUp0NHAvTDRmdEdD?=
 =?utf-8?B?UDJLMVdRSVJ5aGRSRHovSmNQQzRmclZaWGFHUFNhQVNqNlR4UHBYd29oaXpU?=
 =?utf-8?B?akJmNlMvaCtiUUpSaGEvbmdlNFowTi81VFNBLzZUb1FWMVA3MTVNK0kyeEtx?=
 =?utf-8?B?TFVnK3ROYU9PaHJYemVPTWJoRlREdjRiTEpGZjR0U3R4SDJOMHJ4cjVVQTN4?=
 =?utf-8?B?VUdONTBFU212bDJGVUNTOUtKYkRzWXBtK3dEOHJSaWM2d2JIM3pkK3hmSjE2?=
 =?utf-8?B?UDhRVS9rUDVzK3hSelZQUUk5MXlJUUFKdUZyamw4ZWpvS1pNZlBnMjhPeUhH?=
 =?utf-8?B?bHJlVFhpMzRLMEN2WUg0V2QrbjYydEZpRThwS2VJZy84cDd0NFJ3aGp4cDE1?=
 =?utf-8?B?cmgrSmJTT3ZjZmZqM2hFVy8rL29Yb2pWdjJBdkJPSDFnbUlDT1EybGlybUhV?=
 =?utf-8?B?TVNVV2d6d3JGd0xKMlpxblZVcDZTSU5MSzNCdjMvcFQzV0t5elJES2hmaEtM?=
 =?utf-8?B?RmcxUjI1UmZWWThFZ0tQWW1NNlR6cFBTVVFyYzE0eTgwbnlXdnlMNWdNdDd0?=
 =?utf-8?B?T1V1cFMvK3lWRlA5WjU3NG0wSWZQTWh2ZVFRUXZ2eDZ0VWFNK3VxQUcvY2d2?=
 =?utf-8?B?NUM0M0p1SjUrS2JsVVUzQ1hKdW9kb3pZZHEySkJCTUpnVi94ZDBSV3hKaWhH?=
 =?utf-8?B?RlYrOXhHbVhEaWxWYTlLVTdqV1JXSHlvVzU3alM0WnF4SW1qQ0pIRDNEdDRZ?=
 =?utf-8?B?ZHgrSnpCRlFER0s2M280dFBYQ3dtdDZJWS90V2VTem9mdEVlYUJPaWUyZjU5?=
 =?utf-8?B?NmdyU2VnUHRPMjd3WHFweWhnNVlpVmI2WkloNmNDM3BMZ1VTajJCeCtIVzI5?=
 =?utf-8?B?czJ6bHVkaGNXekRhNEFWdElHc0lxN3MwTVBWdUR6Wk10MFl4SXhkOHpQdVJs?=
 =?utf-8?B?aENYYnRyZk81KzNxVitBRFp3KzREQUxDckVKdFVSajc5NTVRTFV5NHpTYllC?=
 =?utf-8?B?c3hBOTNqaVJKd0t0dEJUU0ZyQWEwTW9YRUVtazErUWowUHEvTHZkaStTbnh2?=
 =?utf-8?B?cDlweU1KS3gwZFIrZk1IV1hNNjF5VDNRLzhuVXdBNEk5amYwY0QvWjBIS2to?=
 =?utf-8?B?aWxWakFNaDlGemlyL3U2bXdTMkVNOFNPaHl1TU9MRTc2Wnkxemk0RUlxdmVF?=
 =?utf-8?B?dnNGeFk0VGxhNTQzLzV5OW84MG9PYmxaZmhHUXJmZjJMdFZHNFpTL2hTb3FX?=
 =?utf-8?B?WHNFOHNyM0dFM0RuWTl6ajlVbWlTUTJBN2lvQmxRNllraFhyOWJaQS81VFhK?=
 =?utf-8?B?Y3N4cUJTSDJnb1lVR1BVQk84R1VidEJGeXAxbis0czVPbU9VbzZoSHVqbnRi?=
 =?utf-8?B?c1BhVUZRWEd2Z2ZDckZtSjJ4aFdKN1RKaEhiV0d6QnJHbGIwcVV2RVN4Uk9F?=
 =?utf-8?B?N0tnK3hpUkNrVVEzSEU5MHlCSTRnUG9BajNVekVaRG8rTjV2c3FUaFgrTUdH?=
 =?utf-8?B?MHZkMHY4dXdEYUEzeVNVZE12Mm01bkViNFN1SHBtMElyOUhlbEUxd1RnL1BM?=
 =?utf-8?B?YlRHcVBvdkdNRXNsSTVkNlRsQjlHbVQ3N0FQTVFtUGpCVXVveG02UU5UazNS?=
 =?utf-8?B?S0orT3BzdEkrZzBXcGdxeHgzNjlpYkwrQnBHUDdkRlUrMWd0YVhWWE4yU1ho?=
 =?utf-8?B?dE9pNlREeHRSRTVIYS9BU2VEVVpqNFljZjR0Rm56TXVtUnZzVHpob1E3WmMz?=
 =?utf-8?Q?6AEBb+Fv3VhXPAsu25All7U+t?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7958c4-6edc-4f38-bd13-08dd894db144
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:48:13.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJTieDMcpyMBIbPXnjb4PqTly/ZCDk7irQZdDh3wCSnrrgNX9RMbp1L5Lwi5i91fZwisSywl99hdhXkv1c4BOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5908
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 07:48:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18750

On 02.05.25 09:42, Jan Kiszka wrote:
> On 29.04.25 06:20, Shivanand Kunijadar wrote:
>> Passing readonly=on for OVMF VARS fd is not necessary, so remove it.
>>
> 
> But we are using it in start-qemu.sh. So, is this removal needed for any
> specific reason?

Ah, should have read it completely: This affects the var parts of the
flash, and that is r/w in start-qemu.sh as well.

Still, is this change a cleanup or is it needed for some tests?

Jan

> 
> Jan
> 
>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>> ---
>>  scripts/submit_lava.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
>> index 6eca70c..6cb0837 100755
>> --- a/scripts/submit_lava.sh
>> +++ b/scripts/submit_lava.sh
>> @@ -33,7 +33,7 @@ if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
>>  
>>  # Create a dictionary to handle image arguments based on architecture
>>  declare -A image_args
>> -image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
>> +image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
>>  image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
>>  image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
>>  
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

