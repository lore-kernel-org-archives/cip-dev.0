Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD87C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 09:26:13 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.64])
 by mx.groups.io with SMTP id smtpd.web10.19363.1751448370204266043
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 02:26:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kWnH8n7M;
 spf=pass (domain: siemens.com, ip: 52.101.66.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvQKceeOD8s8VsX1OOU/XffVZmfSap1BUmJH3DgkhduwVKRtZFnGei1aB9V+6M6aIeHK30LvTzJz/hUw7zAd6eqyHh+ApZYFykev/3vx8B1iGhRkT3uAbnq0V4m2tepZ9n2hudEVahUtcaYMkGalf2aduCr5aKYBQVbQyxzMNTcaDEzS/ZPmyLmU3mjT4ZDAR+BVfWhcYhNGzMhCVgehI7hJKUtYVYEM2c9RfMYLSPFkOhHKIfXhyWB7P8up0hvrh7Q8rIzg3ek56I+qMeV5aVturfhr1SdqdBy8eYMLJJUwQgFTjdGx1e3YSzmxYurnZ9qDsMxxuWxImyoDBdM2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fravq1qNi+O6CSdLOoDW46fpjgPEA3FS0VEgH6L/SM=;
 b=ZyTE/jJ3UCJDDdmvAhFF0FHHgQmL++cW7ml/Bj0Ny5MahPi8GN8xx9tiUTaN/r8DK7qfGR7H37LI/J9+yXMeL+Cp5BMCsqGdO5/IQry9FG39SvNjEgwNJbJu+sFLpJ1WKlfqRinPCpSKWipWFhlvoE7LVMljMiS5f8CkhUEWZB3uAnbcRgkCivfErJt+yBto2b5M6hwxjGwMi7vUVolkPGFddn/m7WCAzIslQURGMuJSl8vwxnDLbKWWytaKIB2H2lEdjyxSvg/aNE0x6/dHPcD9VVkvH/jWXLasyi2dqb2q67b/7k8NxUhjECVSNGFb3bfdPEfJ78VXG+42qGs+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fravq1qNi+O6CSdLOoDW46fpjgPEA3FS0VEgH6L/SM=;
 b=kWnH8n7M6YptWpZa80fQpqE9kxFVQN6AMqz/VINgobrJDFl/5Q9i9Ta/80csVwo0KeD7VZ4ajd10n8H3TqivH3444kHHKbpkjAZTug3JYsZ52/XwxXZaEUKjy++bxjgE/GKoTTVEOdOEWVydfyZ0wGnaZ++p0jdCuTU/JAKlFTnILqQ2Upp0vHc/g4u2ada7/e4aG69rL6de7Mbtm0TxQZ9zteFQWhCQCzNT1hz7k20tMMOlrxKf+EqCGQlQsQFylUHm7YvJcY1+b8AJThzxgJp+4tsf6aJJYlE4WSx+B/n1g2mi+JTqa9nlmvNSjmV6X7tRLxKlQ1tPZTrtcYnOvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 09:26:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:26:06 +0000
Message-ID: <4e7965a6-f4ac-4d1a-a6c3-ac3a09bffd50@siemens.com>
Date: Wed, 2 Jul 2025 11:25:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] LAVA: Support ROOTFS dm-verity corruption detection
 case.
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <511d0d4a-5604-4be5-ab59-c8abbfab8a26@siemens.com>
 <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110751BC4788282D51875846CC740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: e21c0f3d-809c-4069-1fd5-08ddb94a7872
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UEtsZnVHLzkyS3lrVWd3aGtVVDIwOEUrWWtmb3NTL3FISEYxaG1QMmtZeU9k?=
 =?utf-8?B?Sm0wMitjRTBYYVpNUWhJNUVWRDF5Z3dEMTBNVWordzd0ZSsrWTlSbWU0bXpS?=
 =?utf-8?B?Y2lpL3ordkFwVmFaZlVzc1h1SFVtL0FQdlM1VmxkVG9MWk1XaGhLNmgzZ0Vk?=
 =?utf-8?B?VGMvdzVqYUhGNGFjazg1VGFqVWdaVTQzNHQ5OStEV3cyUGE0bUdaM3Qvc2hM?=
 =?utf-8?B?ZzNGSi9WelA3MEc4VU5oQkx4ZkUwRTVzWkowWlNvak1pTVJ5YXNDSHEvaXdt?=
 =?utf-8?B?ci9KMGRlSkxGNlJ6V2ZrL2ZDR1dwOFBmcGFCUW4vTGtUNE4rR05lMEVzUFlS?=
 =?utf-8?B?NlRCUFlhcitiakdaSkpEY28rL2ZVOFJFL05XdytGaFBpYlFVVkJlSTlsV3pL?=
 =?utf-8?B?WDZDcFI4RWxUTUQ4WEVuM2E4Q1pFdThnYUw0OW9WaWRrVUFWa3V4aU1HUXNr?=
 =?utf-8?B?OUNDeUxoblZHeTdLNzJsSU1Kd0wyRW4wZXo1aG9wYUpCODBDUk5TUXFGT1Ju?=
 =?utf-8?B?bGRkNTRQOVNaSEU2NzQwZHFkYXp2ejQyb3AvamlBWHhlV3NvZ3l5elZvNmFF?=
 =?utf-8?B?d0dwUEMzZXNrMzV1cDRuYmxzMjlZUFljK2lIZUJZN3A0ZTRhVmYrb04yYXpt?=
 =?utf-8?B?bk81RUhVWlpSR1BIMnBYZDVMbXU4UnRjWG0ycEZrc3JYRVZjUFlRUEl5RHBv?=
 =?utf-8?B?REtJQ1BNd214dFh2N1JvVlkxM09QS3Q3L0M5MXBDSVJQV0ZQN2ZYcmhkVGcv?=
 =?utf-8?B?enVScmdYWGpvMDBDNHJKTGhKTHZqWXZTckVCQVI4YmZCaGNBVTVzMktuWmJJ?=
 =?utf-8?B?eTc3cy9OUGt1ajlQRHkxSW1iYzA0K3g4c2lxSmVTcjdRWGszRVNjaDg4Tk5C?=
 =?utf-8?B?RnZQL2d4MFZRMTBqR0k0eXZSM1I5aC9KZnB2V3dOaU9FU05sTFowcDZWbkdF?=
 =?utf-8?B?S2I3QjhoZFpZLy82dUd0ZzNQcGFnSk9aTUlSQVNCN2wvZjlQTlNlSytNNE1w?=
 =?utf-8?B?dmtXTk1hdkFmNGpDNzJXK3ZKbzRpaWZid2pVdHZxd3IxMWFmRmFwMCthWmxO?=
 =?utf-8?B?eVRKNk1WZWxQNnp0eWM1VFUzUHhPZlRyUlhtYkVkd0FkVXpORVRjUXV1SnRR?=
 =?utf-8?B?clhrazlDaFBPSVZGUXNTU2txdGhWam9zdDdDWW1sN0hUcnpKT3JZTENmbitM?=
 =?utf-8?B?Q1JVdWlXSDVXSTBTVXljdXNzSGxXWkRWQWFRbHVJU3RpTTEwSmpndmcwb2pG?=
 =?utf-8?B?WnV1WnREQ09XR3M2cGtMcE1Xd0tXY3l4TTlDc0FIWFZaUG9vWGV5YjZOUDFj?=
 =?utf-8?B?eWFxUVU2ZmN1dGNHNndSQzhrOXJPVHhjS09Ccy9DMkxKbkRYVDVQQ1h0a0d0?=
 =?utf-8?B?M1JESy9uUEt5WGVwWkFVR1BHMXlZa0xCeWJiOERvVGFaeElqSUx1eVRFU2Q4?=
 =?utf-8?B?WXpUazBVTnhWNWJFeG5UYnRubGJKaTNrWUtrMUNYK0ZWRlJONXZWaXUwcENP?=
 =?utf-8?B?a2VmaEJJNXF1aE9UcmttemVmdnFPanNMcmFQNmJPNGRkeFhDMzI4aWNrcGpO?=
 =?utf-8?B?THNBOFR2STVYTG00MnEzMCtHaXF5OE5seTU5enNYSGwxcUljWGNibWRoQWhI?=
 =?utf-8?B?cmJubS9WZW5XWHVZRTcvTWM1Y1R1a1JVMEIzMzNVMldLRDd0L2E2dng0UzVz?=
 =?utf-8?B?SnZYdVF1UTczYlcyb2cvaHZDdTVtbWtKdmlVdzFGaDllcXNYRGhoSFhuNnlE?=
 =?utf-8?B?dFAwYkdLNC9SWVV0aVlMUS9ZMktWbXdFU0lzU1BkRkF0SktJQXhFMUd1SmZH?=
 =?utf-8?B?ZkpwT0toZUFTeVVjNEJYL3pQT0o0cFI4TzFTWk45dWRGVW13YVFpQnNyU0Vq?=
 =?utf-8?B?UExoNWpxQ2VZSjAyWUdQMGg2NndNd2pXZnBUL0tOQjFqQ0RwZmY3WnA2b1J2?=
 =?utf-8?Q?5mt0yq85lhQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHZNSHA5TktTR3lGVWZXTjNPc1N6RCs5bjhTRGZlYXNFREd1Qml3cmpZd3JT?=
 =?utf-8?B?NHMrWnJjRTJDUk9zUTQ4OWhIMTJLdzRjZVhNUVhneDlsd0xKVjVWYlZBdGNL?=
 =?utf-8?B?MUtQSW9rbEtOMVU5UDBWdmhYOHZjZnV2ZnV6VHVPM2pkcUlobTJobkU0b3hE?=
 =?utf-8?B?QUVzYjY4YzJrekJiSEtZay9ZOFh6ak1oTUxBbkV3Smx2WFYyT1F1V1gweVVp?=
 =?utf-8?B?Tk5CMWM5c29YTWFIaHAvTzY3bWNGVURYKy9RamxHWVh2SkFVZjFxaFhYWDBO?=
 =?utf-8?B?ekZuSGViWGF1Ty9rNnVzM21Veis1WXFLdXoyUTR6Rm1ONEJvbGpSbEx3dHZK?=
 =?utf-8?B?THg2YTdXS3BoSVFoQ3VjbmIrU1ZoTGY1MS9tUWRYZTNkTjNqb21KaGpSZkd3?=
 =?utf-8?B?OUNNT2pVRWRzYzNyVEZZcWpVSkJWQlcwc1JyUWMwOFFDaXBtRjVyVWRpUmxP?=
 =?utf-8?B?SVdEa1FyMzJ1M0Q2blZCcjBKRFd2RG5PVUNvZmZlN3d4b1dBaDMxT1VsYlBS?=
 =?utf-8?B?a05BS0M0R05EZmVRcjZ6V0l3ZmJsYUdoNnBJL0hGcktxWkVlS1dNZHVNUUVN?=
 =?utf-8?B?RlRPaVp5OHQzNDZRM1FtOTd1ZTlodE1ncDFKendWb0xRV2tVLzJNSVhvTzJO?=
 =?utf-8?B?RzRGcFFtSk0wSi9rRXFFQmc2UWRoSGQyUjVxNXJOVjgvUFk4LzNEdXhNR0lo?=
 =?utf-8?B?K2lKMVZWT0JFdGV5S2JlcnlOb2hra2U2dzRlbGs2b1ZXZnREVDdkWjFHZFF4?=
 =?utf-8?B?V090VDYyQnRlYWEwaWxEMWVJcXI1YWROL3BIdXB6ZEtyYllkZXM1QjloeTNn?=
 =?utf-8?B?TU5pd2FmVHRYRDd3M3MyTVJOY2FJSTFxTWRvd3ZyYUMrRlJEMjVObW43UWNK?=
 =?utf-8?B?aFBwd3pOSWlZYnRnK096cllwRUE5R3crZFBvOWxCQ0dXUTA1NFdZbVZ6cyti?=
 =?utf-8?B?NkFkN3FSVUV6R1hOa2FwZWJLSy9kQmlCOVpuK1lYdzR3azIxUnh1YUYxd3Rm?=
 =?utf-8?B?VTJjOVgxUUtyVm1TWmpWU2E2ZTNDWUh3UUplay9SS09Mekl3bnVnZkx5S0tE?=
 =?utf-8?B?ZzZmZk45b2FEa1dMVS9TM1FTOEV6R2ZIOFJjZTd4VnRkOWJjMTN4WEF0VW1U?=
 =?utf-8?B?SlZKbGwvaVdVeTZXMWZUdkREUmJCajBDd2ltK29OVEw1SEhqZTRxUG5uN2ZM?=
 =?utf-8?B?MU9aZTFmbUtPQnpvcDRhRDgxVjNCVitRM0JoQmJBVk1VeHViazRtUEdQQm4w?=
 =?utf-8?B?YjhyeUpIZkdUa2V5eTVPUDluZllmZFZaRFdFOVVxU3VjaXIxd1VLRktqTGRZ?=
 =?utf-8?B?OGdUZHdpYitEWXVHazI0ZzlPcnpyZy9sSlZlUFQvSThnZEdJUFRIQkRQdDRu?=
 =?utf-8?B?UEhJZ3B1VGFTWDdObkdiaVo3TFNVNG9jNHhReDhxam9DNGwrUEZiY2NCenNV?=
 =?utf-8?B?SGtDZGd2dmFmY3dJK0tsVFR3V2lpTGEyZVhhWW1kck1sTHlaWXI5QmNKOGh1?=
 =?utf-8?B?OTBkZ3hXcUl3VmdGSUlIUXFWUUFmQkhlRUhsTjRTM1A0NFVnTkVvdUpkMEVY?=
 =?utf-8?B?dk1WVDBPaWhtYnJjNTg0dTY0ZjVvWEg3aE9URW9nek9DYWZYT2ZDenJ6T3A3?=
 =?utf-8?B?c3pkU0p4dVk2UkVIbkRHdTNVUFlrQ3ZmV3lwV2ZPenVTelpLQjErdW5uSExV?=
 =?utf-8?B?UFBWWkZudFZLeWs1ZzZYdG9yY3Axamp2Szl5ZHNDWXFodU9MbTJ5RFB2Tlhr?=
 =?utf-8?B?MStwaHBpYXRzVHY5R0NQeGZnZUhjSGxwMUlZa0hNZGs5QXVhbXVXcW53VXFR?=
 =?utf-8?B?aGpHNXZXaGJWSjMzdUZGRWlvcnFCS3ZJRWljb3JmZkpaM1dIYWhhaytxK01l?=
 =?utf-8?B?MlBRdHlsUXhxVHlXcG5EQ2FVQkdNYmNLdjh4bmxZMmw4eG5jSDNWV3FzQldQ?=
 =?utf-8?B?K1FHNzRHdno1V1dNNFEyY2FVLzBNTUdEL1drTFdGSWFicTBJUFN3UzlrOEpD?=
 =?utf-8?B?L05XeE1mU1lIbWJFeWJ2MXVPNkZaVWxNLzg2R3gySkJhcHZ2NkpYa1dyNzM2?=
 =?utf-8?B?T1hPWXE0ekVISUhXZDBqWmZpNEt3dVZRcmxWQ2pOM0I2ZVFtVHcyVWxvcWRD?=
 =?utf-8?B?dVJ3V0IydllTNWRFcm5ka0lSd2JvcW1MeDNHNnh6VmNXNENqNnJhKytVaW9R?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21c0f3d-809c-4069-1fd5-08ddb94a7872
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:26:05.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIEVwScdMkDU2EeEnrue/kjpai1NW5KlyzyAzV/uAomXYEY7YQSeznL7lXLNjMOEDnWQK8/nuZ5wRH8nUs7C4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6924
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 09:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19282

On 02.07.25 10:22, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,
> 
> Thank you for the quick reply.
> 
>> Is that offset pointing into the rootfs partition? 
> 
> Yes, it is the start address of the ROOTFS. 
> Even I also tried corrupting ROOTFS start address + 10MB, in this case also I ended up with same error. 
> 
>> Are we also encrypting the rootfs? If so, then this is obviously expected. 
> 
> The lava tests are being run on the security image so /home and /var partition encryption is enabled and rootfs here is squashfs. 
> You mean if the encryption of /home or /var is enabled then this is the expected output?
> 

No. I mean, only if the rootfs is embedded into a luks container because
we want it to be encrypted as well, this kind of error is expected. Do
we build that security image with kas/opt/encrypt-all.yml?

If we don't then you likely did not hit the rootfs but the luks
container for /home and /var.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

