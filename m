Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53841CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:40:30 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.70])
 by mx.groups.io with SMTP id smtpd.web10.15266.1755679219951396885
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:40:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eYalBw8a;
 spf=pass (domain: siemens.com, ip: 52.101.72.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovP3ss5JUpuA/29/0ZfhLYQV7JDTbhTiWrzA2Xd5E7sL952oCZD2SPWTlPOlAWWFmogtr1irDdYbq3bZYqUywTn2JZy/8lSu3ev0muCoEMO9NOpKY8be8kWe+pQ3eerASpZGcurqb+C6qbIW8Pp4d3BT5G3ev+zwIDdjDW+2eINJwnNfBbQ9GGIhTqGvk92ku+YZi7XONDGuBifLzhc39FfVhzFkO954AtmRqN1cRE9XedtpNumrlmJO25GjiDqeLUE/8u5AtOf8q9C6h1jYYcEquAxDTqquTM63c07i7f3Hc1P8yo4cJ26EgPYU+HDNh+ff6Ote38Y9K8wNTy1g+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2htyhZmuPYxGbi695cySeTNs0JlPDdy8pJmEy3srZV8=;
 b=qEyrWNmbLTDK+5McKzgZxaHa97S9dRZ4opkVMhmAw0nXhPpSdzoWfa5n/w/+aJZlFxf/Dii4Bz/uz55XNh/YQvkPmDxo3EH+VMn/V9S6o2e9rwdLRFJNVTWt9M5xBouNsS4MZt+ajjpTn60d7ZJDTx4sk/KCX0XGBlh3yobx68Y2mGwsBiMET59VymM7JttJjWbfCFU8qPytat5YyD2keh+DiYm5u7sVz1NTsTkrgZkH8jL7ENjeXGF3KHtPDl7QIYu4GSvLUIqyZsWYLI9SEYqXTEwY3xa7DjnKtz7qmwZx1FSE5bvOYzdyv1EfNg3gOCUd942ZrmxqxrM4vkMybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2htyhZmuPYxGbi695cySeTNs0JlPDdy8pJmEy3srZV8=;
 b=eYalBw8ahsm4fl9o54ACv+rOrotHrGpu3yCUAxf6kRWaNeQ/hO8ylrdH1C37HLmUEACuL2itkfmgUnNFuhh7peEDAELSP1Y37gxqcSyw6GLBr+P9KjKNwyiDdegwpe4SE/hwwdyEEntCQ5bkmv3MkDypvCort/u5dYDyPlQkhY8u9pRPOlbsyumNEZqDZirEjB0zus54dcevZgLF0RKeBNv7NK0Q3XeZv3yO9PhkEEwuj4l3QuFuMjDn2z/HRafl9GnNFBd5cR9jI3VCDaHFOOP8Qe1w4Zc4Y1S94/vUMyJj8knzlOwcKMjl2ao+Rx8omNfKRZckeu3EKMVS0oMQ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:40:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 08:40:17 +0000
Message-ID: <9e7fbdf8-7e5f-40f9-8952-2af8cafdf61a@siemens.com>
Date: Wed, 20 Aug 2025 10:40:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip123 and
 6.1.148-cip45
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0331.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc43205-33d7-4c91-c8a5-08dddfc5305d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NUlnekxGRnB3T3RESzF2NlVObkcvMzV4L01kMUFocTRRZnpuckYvL1FQYjRa?=
 =?utf-8?B?THo1UmdCQ0N5dk1GYVVFQW1yRTVKUGFpczZ0MlhjOHpzY1BBSWNaeGJNNElU?=
 =?utf-8?B?b1krb082R2hraXVMWFZod2tQOUlXQjlXK3NaQm9SYXJmb1lMb0hDQUJTWERH?=
 =?utf-8?B?VDd2ZTZGWXZYc3JrUi9TaVNOWTN2dVNxcWYzS1FwbE44TkpYcmRnQ2laNDNL?=
 =?utf-8?B?RFloRVNIRkh3KzR0Sy94WGZKVlQzdno4MjhwT3RPNU9RQms2NUY4NzkyTE5P?=
 =?utf-8?B?UHRlMHNtMVZnZ0d6RzhZVzAyT0p5WnJPTFpBM0NtMUZHbDdWaE5BQnVrazNU?=
 =?utf-8?B?cVBkdDNvQTA1Q1ZxelRmMzBRMTFOVThlakdiRk1iMVFOMWgyNURKOG8zbkdz?=
 =?utf-8?B?UnNJNU9pL1BaZUd6aXppUTJoclV5K0d4eWVncWgzT3VDUlk1T1l4amxXYm92?=
 =?utf-8?B?Ly9QTjRMQzlvaEpuc2YzZVpJU3RPSk54QXBPRU9RbXBObnc4SmdETHJmQW4r?=
 =?utf-8?B?RVUzeXZTbW9saDFLMStCa1FvNVZsV3czSVQwdXdrSW1IdjFPN0FweXF4THZz?=
 =?utf-8?B?TjlTaVhNQklNVnRWdnNGSFJrUDlsZEtKU0FCWUYxbkhlc2hsMXNvZU5wOUd5?=
 =?utf-8?B?SEYwMEV3T3paKzl2SFJKRlAwRjBEeXc5dnNsdHJsWmJUbk54RXpWUlVoZmF4?=
 =?utf-8?B?bVBreFlZK1I5aVBDb3FYaTNadnR0TURZZjljbFBIUDJnVnp2ZytrOEdUU3Ur?=
 =?utf-8?B?YnBPNEFKSWlVeTcyd1JCSG5lUERNS1IrY0lLd2dvQXF6SkRtek1CQ2pwMWto?=
 =?utf-8?B?M0ZXZktxWXVRbGwwWVo4Vm9jSEdiWUJSeUwyS2FJcnI5SGJ3d1pnN3dUdWMw?=
 =?utf-8?B?U3hRYm16T0tvOC9CckR4TnBlZGxQYnQ4ZTdiYTNYV0xtRGkwb3dxY01lOHR2?=
 =?utf-8?B?aTgyTFZlam1JVEVMcEg2MVY5RktWSlFYYUI1cGlLOWdBdEtCYVdZWUxLMkdX?=
 =?utf-8?B?c0xneGtyODE1Snp1T1lsWkZtRVdzajJTUDNaUXJveFNlRjZGZ2xqSythcUxs?=
 =?utf-8?B?QWVUMFcrNjljTDBuejE1am85TzlyenYwcSsyblVieDJNVUR3V0diOGRSb0la?=
 =?utf-8?B?WEloT3dXeEdtY2N4bll4dEsvMjQwcXhZWmZ5UENRSDNiNEtRbG54bFpBeHpU?=
 =?utf-8?B?dWNwNzdNS1VsalJyQXJZWHRFSUtKeTdneTBZei9YUlg5VVpjcWFmYWZUL2pK?=
 =?utf-8?B?cm9TVlhDeFVpaFk2enltY1FkS1NvWlFNZmR0dHJnZHk3cUZEL0hobmpGUnRH?=
 =?utf-8?B?cDAzcFFmOWgxUndyL3FGNytWVE9xR0w3Q3BTdjN1TWM4M1JXSUdvWDVxSW9h?=
 =?utf-8?B?eEROVXBndll3ZjB6R0FwUnArNXI5SjR3YzIwNGozVEhQR3lhQUF2MEdlRGUx?=
 =?utf-8?B?RkV6R0VDK0JRMzFyZS9tWkRzVkhBdm1ENkZXZ3duTkdiLzFkZnc3MWJBbnVM?=
 =?utf-8?B?SlNJV21LUWJORk9kUXNteWZ4a21rTXRYaG9NNTJpeXpGT1JhMmNFeGZCWUpP?=
 =?utf-8?B?OHVKMVVzZitpT2ZreFp4VUVmZHdYUitrVlZpTjR0cjZERkVFU1Iycm8xcGZm?=
 =?utf-8?B?bFNTajcza0pvUEhBdjlSN0xQeUZaMjhhREVXYmZrQ3RPSjlYY1lERk9wVEQ5?=
 =?utf-8?B?S1hCVUlPWjFHSStnUGtzRDJxaGdmR3ZpU1RnakRFY2lkcnJaMHBFZlMwNFRo?=
 =?utf-8?B?dHdQRjlVMkhvK1h5d0w0bUlDVGpHU0xiakJOaTdoU2w3cUp3UmZHWHo2NGkx?=
 =?utf-8?B?S3p5c1pHWXJTckV5eS9GK1owdVh1TFRlMVlFL1NzZFJqSmx0Uzc1RWlsUmVq?=
 =?utf-8?B?ZlBPL3JkNFFuMDM0Tld6UWtnUE4wSkZzaTZlZFYyNWhzMVRNTWtFR0pVTGFJ?=
 =?utf-8?Q?L+EYq37jtV0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZldnWHU5aUhaY3VrdFBuK1ZneTJtNUdnY25waXByTWhuS1pVaWlZU0xudng3?=
 =?utf-8?B?bVJ5ajMvb0ZZcTA1NUpOcUw0N1ZjbzA3Y3pTK1o3cjNxbCtwblVMeUdNTXZG?=
 =?utf-8?B?M0hoQi9PZGZ6alN0TllyMG5DalhRT25vNEdoVDVBdHZkbXJ4dWQ2RWxMV1NO?=
 =?utf-8?B?NHBaTWtORU43ZHk5T1pPTmg0VUppYzhVdWdWQUNqcGI3WXphY2Q4ejNkNTFy?=
 =?utf-8?B?RTEzTGNSOFVsSnNhcUpMc2ZXUmZEc0p2S3JjSlpPa2FjSm4xcHF1d3pBc1NO?=
 =?utf-8?B?TGRxc3dNdjYzNWxQbXZrREoxZzVtWmhDZUpxYTI2aldQbFYxKzVEUEJhK1ph?=
 =?utf-8?B?akVHUEFmZnlHREdWQnBPeEdodHo5RTlGRXdiTEt3eDhsdHdHUFNQVlNDcFRQ?=
 =?utf-8?B?R2JsWmE1RXdJUGUzU2VBRDlwOWNWWTFISnl5d0tZUjl6Qmp3MjEvbXh6Y2FM?=
 =?utf-8?B?SkdXYmJZWUFHTEJuZ1ZrK0gzY0g3RnFacGQxOXZkb1duTjY0NGh4ODRSNXd4?=
 =?utf-8?B?Sm5YenlPQjA5WHNVb25CWnhEWHBaWG45b2dUdXhOVGljaWRBcnJEVWM4cS9z?=
 =?utf-8?B?TVhlRzh5aCtYT0VBZzI4cUNVZ1pFRU5JS3FMaXpGZlc5bnptTUJ0dlcwNnQz?=
 =?utf-8?B?L1hYOEgvQUo1N3ZQTjRxWms1UGkvVDdCcCtVaTJraHdaRlFoLytCZ0RwNHFI?=
 =?utf-8?B?bWZPbXhaMm5hT0hUV1hMdmRJaDlnemlZem9OT3VLVUFqSW82K2NuL2ZFSUly?=
 =?utf-8?B?aFlkQUFqMllLV2hoYUZockY1T3h4L29MbWVaOVY3TXJSdlk4ekRFbSt0bTZV?=
 =?utf-8?B?dURTbDk3VEcya3NaOW9mUm83VitYRlhGY2tQNGYyQ2RlcXlweTVXZEtjMXFM?=
 =?utf-8?B?RjlZRml4R2xpRThaREhKT0N4SFI5MlF2aWMrSkVyTU5McStrdDdud1RINWEr?=
 =?utf-8?B?U3JBdzA5bVgzVmZMR05HdEUwOGFmMmJCOWxYZmRsOHJNTURoMmRrVTdlajJh?=
 =?utf-8?B?R09aSG5QRHM1cU81dzdQUGJ6VE52NFNyV2s2ejhlaWpTcG9DTlgvaS84Qjha?=
 =?utf-8?B?UVNMMm1NTi9RV2JPTHRKVGpWQ2h2ZkhFT2NvbUEzMU9UamF6c3daT0grOWJO?=
 =?utf-8?B?aVFmVWFjc01INjd6U2pQVE0ycnovK2lVTGs4UkNZdEJKeXZlTlR5SENGcnlN?=
 =?utf-8?B?UU9jdGliTlhrdCsvZE1NcEdhYUVrYm9IUFlBNTBDT3haNks4Y0t6T1F4dU50?=
 =?utf-8?B?clpuMVVRUkxDY2VSN2VLMGRLVDdDSzcyc1RnLzRKNkpQRkZ5THRBMUFVYmYw?=
 =?utf-8?B?M2dpYWY4S0ZEbUc3c1ViSnNqRUhNZTdUVElReVhFSC84UGN3a2JENGZRVUw5?=
 =?utf-8?B?QjdDVytJK056aUduV25NeTNkN2dDSG1qR3E0aXNaeUNwczJXbXFYWjQ0V3ZV?=
 =?utf-8?B?L21hazlGOFo0U0o5Wk44RDl5bEwvN3FpK0VRL08vYU1WSGlRSlVNbmtuM25J?=
 =?utf-8?B?ZXo2eVRtTzROQnNCUEtVNWFzU0syQ0NSdWhxYXNXRlBZeXBUdStJTEdxcVhE?=
 =?utf-8?B?enNVTFRxZitHNk5UMG55WmxBRHlaZGQwV21pbDdUNXpwMnpvY0xOMDdDaFlv?=
 =?utf-8?B?TmpSUjd6QnNIS0ZiYnl0SWtoU3BtL2FNMXZVVENNYlhGWVl5NDh1alpTWlF1?=
 =?utf-8?B?aVpBSXhpUDZrRXhGTmlIZWgxVzRuL0pQUldCakd3VE8rM3oxV1JYcUgwcUtl?=
 =?utf-8?B?aDNCUlBzcUJhclhxMHFDYVdqNzVSdEl2eWFLaEdoYUJlWUo0ckdhalhUTzNV?=
 =?utf-8?B?RDhpVEJJbFQ5N1RoaVd4S0pIUmhmTm9SOW41SnhVY1hRcDVQMVZxR2NFZlVP?=
 =?utf-8?B?TGJhS3NIdkdqa0svWlhMWVBXNTdaU3BqcG1RanJta2NoWXpmN0VUc3FZeHRJ?=
 =?utf-8?B?RXoyQ3IzeUJvdWhhMTU5RmlMb3MreDdrMncySU1JcEZwV1lVL29UZGRSWEZz?=
 =?utf-8?B?M3cyVjFwUmY2aFlTT3Rta2VlemRTUXlTMU9EdjhjcTZCa0ZsVU9pKzBQcHRY?=
 =?utf-8?B?aisxWkxYZlpOUjhVeWhZcmJWeDl6ZkxEZ2w1K1Q2MUFZNFVSMzZYR0pKVFM4?=
 =?utf-8?B?MS9obE9sMjhJYjNITGdRWGxiVzViU01UbHdibnNjRlpCdHUrQjU1NFdHVHN0?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc43205-33d7-4c91-c8a5-08dddfc5305d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:40:17.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrVMZHwawI29a+ksAplipMUgKRsVo7lG9uEm9Xe83uW5irk9meTgxmN0A8eeM4/Tg1W39sw6Sa8CRq6iG7Vlvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:40:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19794

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...inux-cip_4.19.325-cip122.bb => linux-cip_4.19.325-cip123.bb} | 2 +-
 .../{linux-cip_6.1.145-cip44.bb => linux-cip_6.1.148-cip45.bb}  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip122.bb => linux-cip_4.19.325-cip123.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.145-cip44.bb => linux-cip_6.1.148-cip45.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip122.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip123.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip122.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip123.bb
index 8b66eb83..da1ca312 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip122.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip123.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7e90e8c5a1557a8fe02455437f10c3a549c9f46424638ef9763e08d1cda36152"
+SRC_URI[sha256sum] = "79b1f71b255fdf4cdc67c8e7b38f110ac95691a9c5f20bce2f83107b8112cdff"
diff --git a/recipes-kernel/linux/linux-cip_6.1.145-cip44.bb b/recipes-kernel/linux/linux-cip_6.1.148-cip45.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.145-cip44.bb
rename to recipes-kernel/linux/linux-cip_6.1.148-cip45.bb
index 1234d096..6cd91f26 100644
--- a/recipes-kernel/linux/linux-cip_6.1.145-cip44.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.148-cip45.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "9e701e770dcaae87736c8a442021eef7d57c09aa70ae093c20531d70fc94b089"
+SRC_URI[sha256sum] = "7566ef5e23e2215edd31e285b779aff2619e9d85ff90c0f7a1d69264524679bf"
-- 
2.43.0

