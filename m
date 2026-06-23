Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D32ACD98F2
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 12:30:45 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19513.1782217839872476645
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 05:30:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bv4Vk8qN;
 spf=pass (domain: siemens.com, ip: 52.101.66.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO4pnP3MP4gUhX8bsIhLsa/o+0jMnkrfZHzGPrlGwag4Shzg+ic4xY/49SOouNoo9DG1w8OX5+dUz8jIDAUQOkMnf517DhS9hiPpjsf7FgQ6t6V3Ui1GWhuefD/Ht3nBORTkHJyh0IiTS5aKb4DNQIW75PljZsGjj3j8E4YYwh/UDOT5NYhN0Bzr6P1JyXsUwVtW+5A5J4XPL5H6/I0JyIIYiyNi2BtS1puS3jg+xA4c+qu0+HWhixYS1/DH+DARi76Q9YvKLs8LXgrVuDXDAYNygKP0bGEaHkNMPN/SSJskNVbrdNO/FTDXxebhE/PKuoTwDNUVeXmA36mlUiK0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRQT5MvYE4lQlCLmvFj3D51rP/hiq4gobSyTXKsKEDM=;
 b=YX7+9PyqjcZ8YHjFLwCosBFHNmDS73g4PbWhLu6iWj6xVHE6bwX2fv31yGMuUbcdH9TN3TcS8ZmSggav6Hks8oQioA+DZ0+BwCvaZdP33Adak9ej1iyyxT6+E2TMeKmDulijZUd9nbzqGgpJLDP3otftIGJthBl4Zxizu9/wbeuwbFxhYQQppQtsd9rvsjGNSDXSH/dL64al8MFbqDqI62JXwoKUcJNRn+JbiKTWMNhwJdi/xIaExgb0wiDHMVNoQaysCCWyTElxvmZJgNuRiAW0uROHWghb0H3GtPPrPAP/2UHCSlLlKCTftM8nAwn6jNX43e3T6E2gcY52gOU6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRQT5MvYE4lQlCLmvFj3D51rP/hiq4gobSyTXKsKEDM=;
 b=bv4Vk8qNaFDW5KexnfPs0Pra2fQl+6Fv1vvyLK6uqEVGHigSXBJsN/i2Ku00lb7wBXKVg85EYtz0b5R7AJT7GkN1iNenUdjtnQyhyLzy5L3wf5Van84zLbbPFRwI1yR3MSDryZ1mZ6yra5cNsKYZT9lPK88oySl5OlvkHu3zXNg2P/UzkR6BXTtdPW6BCJKjgsCCyXDfk7HMRRLMjf7K/SxOjR7WvOkpMYM6OTpolQq5dPAIZyoTF0LHDykhBDj11lam5VTUNTPbr0lGDO0gKdbgfg6wbeo3b+rnIXkzDXXcfWX6YvI5WsRQGGnh46RkxgH9IPWkcVp0nXbn9RSe3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 12:30:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 12:30:34 +0000
Message-ID: <38ec0a76-9e33-4976-a6a4-612b4c12d935@siemens.com>
Date: Tue, 23 Jun 2026 14:30:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Revise README files to reflect the latest
 changes
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20260619105617.1891671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <8b2cfa70-08fe-45ff-8695-7564b37f36b8@siemens.com>
 <TYWPR01MB11063B595D1725A7B252067EAC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075F67BFD39AEA29DD9D095C7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <TY3PR01MB11075F67BFD39AEA29DD9D095C7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcffe93-855c-4ded-7956-08ded1233903
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	PCUAIW8Pxio2x4/iaaxi56SThnkb5uKQDz2AIec1VcN9xKP4BaxaIsXf3+TO/vxkkLxem1JJjxkTIBh6bMAtmTBEmBxhZ/Dht5HLYeBCA7080ve0Q8TXdR958EJ/KQu0IyEvVJaT1ugkfPVTR+jWlO/NZoAk1+S6eJWq+gJfWTjbN2loAs3Dh2mppKMzjDP4ec3qLvbFjqDoqMae/BApZY+PG2yaEUCaH2eZINlsnzHujv2r14C5qxqFfRcWDgLXnV7wGDo4oBX54xkRLg/mGmXPKW1JhXy0TRn7oR+Wf7pfu9XSslKVewdx8QfdE1ERuPaLJRLyPM2r3TnmuN3WWt/Jry2DqmGoLNtMYjlih4cWqUDWH+K7+HZxapxi2/AO0SEH4BBpAfcgMegpUCe84NsLqYNvA8rUiYD/LIC2SjZPLXN8IKBJy8NCBxSPeBbJcTVyfwqpBzKR1miDKN9r30iHK02xsb4vm7oZhVNZXO7mqDfaY0M0a6309Jqrmsq4+u131MDWsheitkja/zunJO7GJrq0RpWnWYY9VZfvjTYD8kHJ5Yzp1M/SFZYO3qly6yEbsHgNt0uIHUb9lsV1rmy2pGOaxgzmeOd0O0iCJ0ODgbPd2aRUspdAhnSmdkLjCkAsog3eyxMVxikw0HhiHzediItdbM9p7kGETlKzXus=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzB1K0lsdm50YmZTS2J6OC9VaUZCdzU1UWh0YngxYU5vZDduMUU1MnF6eVZZ?=
 =?utf-8?B?ZktpenIzUUdNQ0w1ZFAvcVNVR0RmNWpKemQrV25QR0Q0S21vNVNIbDZCelZ0?=
 =?utf-8?B?TUhZY2c4QjhBUE4wYTFaanpTM2tEL1FLdGVucjhFOURuaWhlZ3B2VUlla3RE?=
 =?utf-8?B?VWYvbXg3dXhxdDBYVk9yQnBzOFN3QnhBUVpFak9aWURVZTNRVXA0SWNXS2NJ?=
 =?utf-8?B?aFNXdFN5K1Y5dVlBMkdhM1R2YWk3N2piK1J4YkR4MEpNZGl3djhFcjI5YmVj?=
 =?utf-8?B?OHVWYUtIbW9VNXBQTktHS3VXSGJ5aU5GUXc1bGNEY08rdS9RZTNZRHlaZTJL?=
 =?utf-8?B?QWtRbWhydVhkTFNkdHVlRzR1bkVNM3hBbzVzZ2RVQVNjTE9wZ3ZKa1gyUDJt?=
 =?utf-8?B?eHlXUXBlNm9KZWN5UlM2T1FzdDF3dWVIbmZQcjZYSVhZc3QxVmFCTEFJSGdP?=
 =?utf-8?B?ZlV3cUdoR2hrOFBYQ081VExsdXJuQ2s3RUgrcUFCdXlsU2o4cndweHpodWpM?=
 =?utf-8?B?em9IUmx2OHdUVDBQSkpML3FrMUtJNDRNYjl1UXhRMVd1Y3JHWTVqNk9wa0h2?=
 =?utf-8?B?RE5CTkZuYUZjeThzYTU3ejJ0T1FnU1FCNmduVDVFYUVkOFBLemJvNzBaOHo3?=
 =?utf-8?B?bVdxbnFQczBPTngydUI3YitmcGNFZEFLcmNjbjZLdFplTldpekR6bmxmcGZZ?=
 =?utf-8?B?dXlzeEphRUNsR1BJODBWa2xtWk8zU3JxQW83eFh6RW5CS2s3WmxUNmZxWElG?=
 =?utf-8?B?dy9zQkRRQUI3L1lMdGEyS3kvSG13YnZVSThoeFY5YnY5bGlPdUxqUXQrRGlL?=
 =?utf-8?B?bFBSeUxsTi9FZ2oyVU96NVhIQjhwWnR6UisvZW1BMkM0MWlIeDJrcVhPTjNC?=
 =?utf-8?B?bVlXUzBaRGpRSCsrRzRpU0NsTEVNdWdKQldVRnl5QXdCQnRmb2dnSTROZXhL?=
 =?utf-8?B?eVJveHNQQVErYVRFWFpzeUVHdVRPaW5CLzRHYk5UOVhSUStVZ2s1L0M5eFFV?=
 =?utf-8?B?K1lPYXVaZVBNNXJ2ektWdkNQZUFXd2syNzF6UjVkclFRZjJzM1BqQ3ZNczhu?=
 =?utf-8?B?ZVErZk1yTzZSOHJlWFBCWkNJTEQ4M1hEZm9wdURPUGtPTzBiemltTTRUODBK?=
 =?utf-8?B?TG9kMG5kOWtaK0kya3UrdUJtTnowaFJTazRUVUh1MXdQZmVCZEk2OVZPVGUv?=
 =?utf-8?B?VUZVMnppVW5wNjE0TnhrN1JId01tUmFBZUJ6S1JsQmQrcHdaczhaYjBWdnN6?=
 =?utf-8?B?VVg2NU41NUh5TFM4czVPY1didG1SZC96MkpmaUJROUg1V3JneUZnV0NPTnpm?=
 =?utf-8?B?clVVSUxBcmJZYnNBV3c5djhDSnJtN2R3UDhweEp3cXA3czIyZ245dTU1ZGwy?=
 =?utf-8?B?eDNrU2tsWHg5M1NFRlNmbnpOQTZhZFRjSDh3Wms1ODlmVzdVcklKTm1nZnF4?=
 =?utf-8?B?V20rdDVXblg5Q1ZiTG81SGdEMWJKekdSVmp5OEpabnl4Y1dQZk9LeDl4Ui9m?=
 =?utf-8?B?R3hTYkhmTXpyY0Yyb05CVWpNd2VPSEswbzdjY085VXhyYmh1d2R4SzkvUXRL?=
 =?utf-8?B?N2s3Ym45aTFuTWlWU2tlMmd5azVZaVlNbTY4QU05N2dVSkoxYW90VE9kcXFM?=
 =?utf-8?B?SHFpODVIS2hWNnFsYjdZL0wrZk5aYzB0VWVCeHA5bDZqelB3SHVrL3dZRG9q?=
 =?utf-8?B?M3Z6QkErUllZYm9DQnp3R2xOYkRaYWk1aW9PUkcxaHFtUmlSblMweDRKckxw?=
 =?utf-8?B?eHNib2s1cVpHN0ZNeDZxWFpoYUg0Q01JRzFUQnNvR0w2WGlHUkQyQkJRR1BR?=
 =?utf-8?B?SytrRk8zMnJ1S0ljSkFoWFJKQ3ArcnE1L3BHNGRYU3pXQXRMcGpVcnZzdDNo?=
 =?utf-8?B?bDNybWxscWVDM3l6cXlQMTV2aG9sTi8vMGxHSHBBRWFSYmJ3UWQ5MnFlY0Jm?=
 =?utf-8?B?c3hrOWtzeUtRakdDbEs2WnNZdWpLY3JrcXBJazVOTEl6MHdLdi9IMHdXYlk3?=
 =?utf-8?B?MGJUbmVmeURaaDg4dzlVdzRVRVNOZWNpa2NoWmZ1Uzk1Z216ZE0raFJnNEty?=
 =?utf-8?B?VlNhbmF3MHhBZ09NemlVNFVNdkFOYzBtTjluaEQ4RUhocWRzTkdGWmRTbmt5?=
 =?utf-8?B?U21EbDhkdzVjaTdNRCttMlVVa3JHT0VydHo4VkxDN3o1cVZhM1grMzFScVJh?=
 =?utf-8?B?dUhzZ2xGUThnMk9LTEhDWERSSXZtdHhESUdiNkJvbFN2NnJ1bnI3aWZ6ckd1?=
 =?utf-8?B?WWJDWGVBVFljeE5nMEp4dm4xNVI4eTJQOG1vMVdKOWI2aVo5bHJIM0VzWExL?=
 =?utf-8?B?Zk5qSjBFdm91RlFEVHVaNVEwME80Sm10aG1ERnlTZjl0czY2RWpmT2g1UG5B?=
 =?utf-8?Q?C++9pIc6rpfplXQA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcffe93-855c-4ded-7956-08ded1233903
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:30:34.5433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djqCI7CSEKOPhzFIVOfl8F/RTNugr+aa1Fjq/R/xJ9IJIGvOsQ4ms/o5NgW7zDlJRaU96I+VbQpz+QFiZSdGSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7033
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 12:30:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23270

On 23.06.26 13:15, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
>>> Your dump is missing the verityroot container. Does lsblk no longer list it by default, or were/are there inconsistencies what was >>configured vs.
>>> what was run?
> 
>> I also noticed this missing verityroot container in the image. I confirmed the secure boot is enabled from the boot as well as dmesg logs. >However, the "lsblk" command does not show the verityroot by default. 
> 
>> Probably we may have to install "systemd-cryptsetup" for non-security image as well, see the fix for security image here[1]. 
>> This package is available from trixie onwards. 
> 
>> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/36b11192674082aaa1228c60e8c0239fa7c94111
> 
> Any comments on this update? 
> 

Oh, that was a question: If we need to install that package only for
having lsblk showing more details, I would not consider this a
worthwhile step. Anyway, the key is understanding what is happening
here, then we can decide.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

