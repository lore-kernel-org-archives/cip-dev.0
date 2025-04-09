Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE8AC369A1
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 07:58:01 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.79])
 by mx.groups.io with SMTP id smtpd.web11.3223.1744185480111579368
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Apr 2025 00:58:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e7xu6tuX;
 spf=pass (domain: siemens.com, ip: 40.107.104.79, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aN3ovpxfi90bJfiQb5lP1nRRHGeeBtVWkQ5AZEGgHGNcnXSsWbG+4hrVccVOmVEIey08WnlWAU5Reh+iKAmOzzhB9YKxBC5ZMfO4LzCVtBgoWsKxTo6ASpTkWa0Cu1uZxCH0MmEVj+DLkLAOEKYv+up1xkySb04BOSXQIMS4Hh0YaVaxWdBKX9b41IZ7yD8OCKNYr5142IwU8eJdtb3nhMay78jI5scz9B2w/VffHQChEqxl3nDPi1sYDoOyO+MGJR1EOx0WPRrtcqKcYZHmd62gZ3EcdhyyXjL7shLOvxGA58zwhpWj8xFchUg5pLPwKGA7YR3+J+10qoRSTjNNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2L6VjSwiw7346bcGsJ7VpqRAMO9yzarWEo3IFxjHFg=;
 b=W2VOTfB9XZcKt8FR6Om6jkoT4BDCA+sQb4XHjDi5J/ONtkiy8dQ2y4NVmdakopQ/5FdJMZFJAKADz+aPKad5i/UaMJhBx621mFr1+fO5OoBMEkhJkjCVOlCcGKwCxqEl7p7yY3QjidpFtshOE49ciAicilr+1Yf1snFopOAwM4FNYBftWO+TKFKomobjwADlS+VjSwd87aulXQZYKfDbcv0UO8NxaHTDM1Y8KbBfgcqCe5xkuxjeG8OXXh0X514XwKXO254/WqQ5OuTnlPegOx9JbnxfBclpaZ4lGtuxj+66OQGQmdmFVh/ICeBxgZMx941wV8kDfyPpqaO07FwsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2L6VjSwiw7346bcGsJ7VpqRAMO9yzarWEo3IFxjHFg=;
 b=e7xu6tuXlLbYGAXSQ1hnuikCJ3iV42jQyz3fR/ue/Djf0TkHM6w7QK9Fugn7ScIVGiYXGiFRxmqH6E3v3CU+l4+jAOper7ogLLCDhO7HL7s1XaFW2uvPSd6Pu6sDZ7afGm5FIGgXgpSYa9YoSDjDSKFd4CE5ZuPsyXKvguUrc58KbhB7H+5DX2IqIkN0Hr3hdO/FK8FIWAzMCrEdHui83DejbHPM4c+DsQ4IDUjNTeI0wCa+bVOR8K/wNCi5bZjr1DbEJe7KmyZKV//CEZkPr3c6WFFcAg0q1TVT/+YnaSwlNG4ztfNXXKYJVOiVagLbGkaZhsrI7n/X1YYt9eg1ww==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VI1PR10MB3694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 07:57:56 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 07:57:56 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Cetin,
 Gokhan" <gokhan.cetin@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] swupdate.bbclass: fix forgotten
 whitespace in assignment
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] swupdate.bbclass: fix forgotten
 whitespace in assignment
Thread-Index: AQHbqQUePYm1knwEx0eDp+ARV275n7Oa+CmA
Date: Wed, 9 Apr 2025 07:57:56 +0000
Message-ID: <c5fc1e2273b76860ede5abcdb97c8fcdd8c2f4b4.camel@siemens.com>
References: <20250408192718.1530180-1-gokhan.cetin@siemens.com>
In-Reply-To: <20250408192718.1530180-1-gokhan.cetin@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VI1PR10MB3694:EE_
x-ms-office365-filtering-correlation-id: 47b55a39-bd10-457f-690d-08dd773c3d3c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dFBmekZ4N0FneTlUTll5MU81cndycTUwQ0ZVb2dyV1h3UmtSSVZRN0JUcVNF?=
 =?utf-8?B?K1ZyWDZuc0dOcERpSXZJYTJXVjdFMFFldURQWjBKb1JRQ01KMnkyTkJvbGEw?=
 =?utf-8?B?MndpRFJDRG9DOFpCN2tuS0p2SUY1ZWpLUElyeXRQWkVNMzl1MjdIWjVnbi9n?=
 =?utf-8?B?TmxFVm53OUtxeEdvRFFsTFc4ZDhONS9uTGIrazI1aG9SVjF2VlgwTW03R2hy?=
 =?utf-8?B?cEhTMmQ3bWtxSTdaaGd0R0pBdmpEdnlUZzI5K0tLQ040Z1UzSmZ6cmJjeUVw?=
 =?utf-8?B?VWNNdWVQMWRQTU11eGVvOUdoQnA0WHljTGk2dkI4cEdGeUd5TWttcVJvU0dJ?=
 =?utf-8?B?OFczYzBCcVV0S2liZlRGTDlndTNseEd2UHMxZnhuWGdka3laMHlGUmx0ZWIr?=
 =?utf-8?B?U0Q3d3hlOWUvTVJIaWFJNjRtWUpFVk95ZXBDZEZyd2ZubmVsUEpxRXhuM0F5?=
 =?utf-8?B?aVdzUFQ0ZGxrVHJrNFdRWUZMRmtQVW9UdU12dGc3MEJNOGRLMlo5Y2JHZXJV?=
 =?utf-8?B?WURsVVdzRlljaUlwQWtJU0M4S2hNVWkxdXhWQmV2QXV0M1NBb3RwaW1qTmdl?=
 =?utf-8?B?aDVIeTFtdzIzK3NmM1Baakp4OGwwYnpSb1gvY2hjZnBNcEZCQnViQUZNczZv?=
 =?utf-8?B?UzJaZS9QbDU2SnAvQ082b3Y4Wi9TVURXS05sbWp2bDVWMkJmT1dSenFzVis3?=
 =?utf-8?B?RS9LMERNRFBqQUpHbzU1eXIyaTNkdytzZ0V6WnpQOWNpVnJ3cWdYdmwxSHNo?=
 =?utf-8?B?S1ZYejBxMktNUVc0Q2RXVU1Ya3J4bTcvWGpVTjQ4dDlWSzhlOHh0c1BqWDZN?=
 =?utf-8?B?REg1dlpLN0Q3NVExTUdHQWF0TjhjQTJwcEF5WG1BR2tOdU5UOW1xb2p6bGlm?=
 =?utf-8?B?N3JJYVRBcGMvTWp2QzdqUWZVOUV6TVFsTjhhZmJ6eTl0NlZjc2FucXI1aXJN?=
 =?utf-8?B?b1lpUnQ3QU1MWDdVaFhlclp2NGEwVU5Ra2FQRDYzK1J4SElENzg1VkxRMnhF?=
 =?utf-8?B?WW1lYldOOVRJdXZPbmpJL21NTkFTbFVsYlJ6SXlNeHB2RVZtL0RyTGduQWdz?=
 =?utf-8?B?a1hGZHJwOW1QNEZnaFpZZUhWRjVRMllBY0N1UmFERlVtOWw0K0pweVBkZzV6?=
 =?utf-8?B?NDFTaWgvTXR4WVh5NlJyenNLSzRuVkRvdjhCTGtXN0t3QjUyNHVuc3JPS2ho?=
 =?utf-8?B?Vm1PRks0bXlPa0tWTTFqZ1ZOYzBDMWNybFIzWlVnNWhoazFXWFpscnNFRTJv?=
 =?utf-8?B?YzVlWVJQdDZiOVg4U1NLaUtLeFhqSEtJZGdLSi9UTEdETlpBU1lOUWV0RVRR?=
 =?utf-8?B?ckZqZ3JQZHhJemlFcDNpY1pKdklCeXBLN3FHek5JZWhrb2pXZEd5TitJbnJx?=
 =?utf-8?B?aHNSeWZSaDA0YksxanFFU3pneHBQYmFkUXhjN3dJR0VTQnptUGZKbk5qc1h0?=
 =?utf-8?B?L0Rmb09yVTUwWGtHcTB4bzkrcCtHaEFlbmFmQnA2bGV4TUJDWC8rK0wza0pP?=
 =?utf-8?B?N25oSWp2VXViU1R4N1dSN2hzNHZnUmV6VFVPQ0RjazVsODVmaFJFcjZjVm16?=
 =?utf-8?B?QVZnalVOUGduSlN1cG1sbEszb2hWaElXd0RORlFzdjcvcnIyUGRuT0h3WFVj?=
 =?utf-8?B?bU12NVNma1RRaWo2WWFPUmhjaUZDQmVnWmdKMEl0Skdpc0UyR2lJSUtUQVVw?=
 =?utf-8?B?ZVlmUGJiZlo4b21rYldLUkkxajVCMmxzRjhqUUdhQTlrbHp2WGNVcGgvdFN1?=
 =?utf-8?B?K0dObFYvU29sUlpETG5QMTluVzlYREgydnVGWit4QU1RbkRXMXBxaVhNemoz?=
 =?utf-8?B?WndZeUR1S0RDMUxuanRpVXBCelZEdkk5cHNvdGhTeVk2UWIrM0RidkZybjQ0?=
 =?utf-8?Q?3MlY+rqZjaKjE?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Ym52ZlQvemFjZ3hDQjZoWHI1ZFBHZlRlajBzNHpISEhnRVJQSTZES2NWcXZJ?=
 =?utf-8?B?RFJrekJIemRJYXltYXZHcGs0R3RSbHRadExTUnFHdVI2Nlp3QWF4SEdJNTQr?=
 =?utf-8?B?NWx0blFtejd1UE1RUVJOUHQ4NWNXNGkzd00wOVdtK0ZtUW84amFwZ2VGdkxh?=
 =?utf-8?B?ZDZrbkluZngvQ0FQMU5rbjBqa3pXOFNhc1Y2bzJzMVBMVk5tYXZjNXEyU0hL?=
 =?utf-8?B?K1Q2MXc1cGhSaEMyWUt3bkZreTRGMEhYeGJNc2Q5Uisxai9xK2ptNkxzSE9w?=
 =?utf-8?B?Y20wWncwbXRqWDlDU2ZjQkYycm9tRTRUS0dmRk8wbmhRVW1PU0g2d0lZaXpX?=
 =?utf-8?B?L2g1SVBlVFlvNjl6eHFZbDJCeUxRam9CMXd1RjdnSnpsbFNHV0dLWTN4TVg5?=
 =?utf-8?B?MnJxVjVmditST292cENoSHV2RFh2Vk5US3F5K2FGNkVmb3NUSytEalNTalA4?=
 =?utf-8?B?dUV1c2pRNis2azdQL0JPRG9VdytvWmFxWTVkOVFoRXBvRzZQb3JoaTBuN0xz?=
 =?utf-8?B?TlRaWUZlN01lWFZJa3ZHRTFyYWZJTHA3QysvdDJjY0JieUVoWmVqcExHcWN3?=
 =?utf-8?B?bXltTXNEcTNET3BUYlBLcXRmQ3diUmpuVEZDODE1ZGVXMEpJSDZ6QzBYS2RK?=
 =?utf-8?B?cnowSzlTR1BrNDZoMzZvd2k4MnA5emhST0tTbEQ5cGhuaTNsRC9JZzNBU1E3?=
 =?utf-8?B?UkIrU0MxYmZYUVdrNVZmYjRod1YvdThlTkpJby82U09iMTVMbVlLc01na2hv?=
 =?utf-8?B?WWhzT3B0R01Jbis2ZU56ZXZlbFBnWjNFeXZnbW9rNTRXRWtuazZoU0tUd1B4?=
 =?utf-8?B?TU9FMG5RdEFGdGt6dHcvd2dMUGFoQkdwdTB3VnV3T3dSQjhLYW1NcGdJRjFN?=
 =?utf-8?B?ZnJMV2Y1bnlEdGRxVFFsM3dKTnBCNVhlcXRFQS9qaFJWQkZiaS90OTcyTC9L?=
 =?utf-8?B?dnBqM093eFk1bGVsRGNwNjVpZ2VPYlVZU3I5OWN6c3pza2NMdzFIME15K2ZL?=
 =?utf-8?B?ZkVEU0I3NDhENDYxdnRGem1qZ1NMMUVzbWRabXl4dEc3c3dQK0x1U2MvWEkz?=
 =?utf-8?B?MmtNVlBZQzg0c2VKQnFhbDc0a1ZRNTlPZjlYdkMyZWlBd3lYdkZyM3JzYmJV?=
 =?utf-8?B?MHU1ZWkxNmEyQnZ6RGUwUk50RVMreldTS0wzck1qem02c2dUKzVManB5Z1BN?=
 =?utf-8?B?aUR2UFo0V0RmZjFMKzFWMWwrUFE3T3dZWTdIV1R6QjQxUU5TRnUrUUd4RnN0?=
 =?utf-8?B?Qy94dzNXM2YxRTVQcE9qbjROMTd4ODFTM0U3Z2xybjJDbXByVngreEZUZkQ4?=
 =?utf-8?B?cHVBbUQySUo3aklmS01NdnIxNllvb2QwK1pGUGd5aWlVZzdBMEY4dDFtZEVp?=
 =?utf-8?B?VnFBa3o2L2pTTURBbVFiVEhneVlZQkk4TEx5QWlCNk1lSUNHRVFsSDZPZnEy?=
 =?utf-8?B?cERlR2d3MmpvRnRkNXVod0VmTU9JUVpWbkU2cnB2WWtGYXJXL3EydWh3eHlq?=
 =?utf-8?B?QWE2QVFYTkMyREwraDgyUEZSSmNBci9UcnFEOGoveFlrQ1cvMk5McUVjMWlr?=
 =?utf-8?B?cGptMGRqYWxnRVV0aTlEK0ZVY0x4K1dISzVpVlhFVDBLNzU4U0NhL2N0V1po?=
 =?utf-8?B?T0JrMmU1UEp5UDIrWGN0bTJHWnR0ekdZRFFnb0tyS29NK0Y5VnhyTjlCUkNr?=
 =?utf-8?B?M1lMRFV6Sk9vZVI3Ym9tMWFEdVY2MFluSHY0eXNWMWVmUkpLY3I4bkNwYTVl?=
 =?utf-8?B?NUQvZm0zSWhnQ2MwcGpMa3RZN0JTZWRqWWVsSE5yR0dQNG9MQm5Wc2NWVmZQ?=
 =?utf-8?B?cTRKUzVqWmtRd3AvSjY4czdNU0RhTjN4bGJ4R0Uwa1lDWmYwMzJnWC85OUN4?=
 =?utf-8?B?UHl5WjcrNFUwcjRzSmNrRWppNDJFL3VEVGRWcnV4eTJ4bG03dmdTb0VHeU5x?=
 =?utf-8?B?Vk9pS3RjaWVxWW5RZ3g3MVZIeEFCbTNxVTdaUEhMNkprN1ZOQ1gzZUNtRFJT?=
 =?utf-8?B?VklMeDExM3lRQW1GdFZjMjNsMkpFL0dPZDZRVkZnVmpqZnYxYWtPVlBPdjg2?=
 =?utf-8?B?OEJhS0Q1MkJ1dUFZSjYxRkVTaThoTVJXRTlRbHlEd2VhUjQ2dU1LamhIZ254?=
 =?utf-8?B?TjVFSTgyTDM3S0ZCdmtVMUM3TlhNWGNGZ3Z5d0xva05hdDBHc01Fa0tIK3g1?=
 =?utf-8?Q?mvIAnVVn5Inotx5K9hh2Lw0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3FA7ECC7BF2CF45A0D7EFEFB2FF925C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b55a39-bd10-457f-690d-08dd773c3d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 07:57:56.5455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07l+CE5Ut5R4ShJ88WhRtwpzL6sN03fg6sPW2+vFIwPREB/F1k2FN4p1I2wrwsfnR1i/PcUCOIOFWdTP+78BBqlulXqU3Wa7ntTwDgZQaNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3694
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Apr 2025 07:58:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18496

T24gVHVlLCAyMDI1LTA0LTA4IGF0IDIxOjI3ICswMjAwLCBHb2toYW4gQ2V0aW4gdmlhIGxpc3Rz
LmNpcC0NCnByb2plY3Qub3JnIHdyb3RlOg0KPiBGaXhlcyBgZmlsZV9zaXplOiBjb21tYW5kIG5v
dCBmb3VuZGAgZXJyb3IgaW4gZG9faW1hZ2Vfc3d1Lg0KDQpGaXhlczogMmYzMDZiNyAoInN3dXBk
YXRlLmJiY2xhc3M6IEFkZCBjaGVjayBpZiBhIHN3dSBmaWxlIGlzIGdyZWF0ZXINCnRoYW4gNEdC
IikNCg0KUmV2aWV3ZWQtYnk6IEZlbGl4IE1vZXNzYmF1ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2ll
bWVucy5jb20+DQoNCkZlbGl4DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEdva2hhbiBDZXRpbiA8
Z29raGFuLmNldGluQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqBjbGFzc2VzL3N3dXBkYXRlLmJi
Y2xhc3MgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzIGIvY2xh
c3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+IGluZGV4IDYxZTRmZTEuLmIwYjA1ZDUgMTAwNjQ0DQo+
IC0tLSBhL2NsYXNzZXMvc3d1cGRhdGUuYmJjbGFzcw0KPiArKysgYi9jbGFzc2VzL3N3dXBkYXRl
LmJiY2xhc3MNCj4gQEAgLTI1MSw3ICsyNTEsNyBAQCBJTUFHRV9DTUQ6c3d1KCkgew0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBjaGVjayBpZiBzd3VfZmlsZXMgYXJlIGxlc3MgdGhhbiA0
R0J5dGVzLg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIyBUaGlzIGF2b2lkcyB0aGUgbGlt
aXQgb2YgY3Bpbw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIHN3dV9maWxlIGluICRz
d3VfZmlsZXM7IGRvDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmlsZV9zaXpl
ID0kKHN0YXQgLWMgJXMgIiRzd3VfZmlsZSIpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZmlsZV9zaXplPSQoc3RhdCAtYyAlcyAiJHN3dV9maWxlIikNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgWyAiJGZpbGVfc2l6ZSIgLWdlIDQyOTQ5NjcyOTUgXSA7
IHRoZW4NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlY2hvICJU
aGUgc2l6ZSBvZiAnJHN3dV9maWxlJzogJyRmaWxlX3NpemUnIGlzDQo+IGdyZWF0ZXIiIFwNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidGhh
biB0aGUgbGltaXQgb2YgdGhlIHN3dSBmb3JtYXQgb2YNCj4gNDI5NDk2NzI5NSIgXA0KPiANCj4g
LT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdl
cyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTg0OTUpOg0KPiBo
dHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC1kZXYvbWVzc2FnZS8xODQ5NQ0KPiBN
dXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL210LzExMjE2NzA5
NC82ODc5Njk2DQo+IEdyb3VwIE93bmVyOiBjaXAtZGV2K293bmVyQGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZw0KPiBVbnN1YnNjcmliZToNCj4gaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvZy9j
aXAtZGV2L3Vuc3ViwqBbZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbQ0KPiBdDQo+IC09LT0t
PS09LT0tPS09LT0tPS09LT0tDQoNCi0tIA0KU2llbWVucyBBRw0KTGludXggRXhwZXJ0IENlbnRl
cg0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5nLCBHZXJtYW55
DQoNCg==

