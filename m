Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57020CFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:48:59 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4259.1764668933671271713
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:48:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aM1npT7N;
 spf=pass (domain: siemens.com, ip: 52.101.70.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dopx30/cY9g0G+lLamYlzHFv8vo1Ip+fBeDlwIioo/4ZWf2tmpM/S+RrzakVu//NB9HGIKnNZHf0AJ2aLVqsxMNpXUEThkOuinGFaMdDjiD/K64xhmimAR5DafS4CeBCZzut74lkZykSITzU0zQWO7S9ub5hnWZZWF7dKZRsLSYgeXsAZ2DFhpfYNZNv2qoCnz5j/Srbj7gvUz7ftRhH/O+wYgRRdf3wbnWgQIbEcb5gwmjzfkneh3Wm4pnudy7kUcUDX6lGUJDAu8SOtB6+XVk0ou/bXAIRTtjft6zvB73450px9IC4iWpxQ8kH+88GcGIOCjv+NGZvi4RxPzAPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o62AZiFpYfN+Vsq6gECZ49ei3FBHOj9Dgf28+x46q4=;
 b=Suaa34GnYKjvakmaWLg+LMex5dwP3sKpftYJUMk8SFCEgjSBNHi5TQ+kpKQj4XztwEW4fAzbJOm9UCMTPpCLSY+UxShblKCdAZP8c3ol502w+rL8P1NPuOLJVRBiio61pSrkRN3toCmViWggPxjMdOga0QbuZeerwDEol819j1OP1gVqLx0yVbaMO4EquCl/2THyxyEylieJl3R7PuB2y6GS01XonyStNPS0QIXleZO3V4RTbLwmhhsT8f1Xx78RElRhgK0TLtqo14ZPn6ywKiHHOA+emwVXtEesvnrvXuYc2ukVfoooAcCA0k7PpzOZaMaTTL3pglWURbmNbevSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o62AZiFpYfN+Vsq6gECZ49ei3FBHOj9Dgf28+x46q4=;
 b=aM1npT7NSSKDLnNx/3R0vBdnGTZEv3GxfRwRydUMPeZeQO7+nJtqZj2oxvkoa4W+ic/ilErze9j6WA8Q0Jxw22XvKmi/kZzm27IdKpP43juGGFz5W67BSl7sM4v+Y/WR7GyvL23WszTnHbI5YQ6v5YuKSdmQ/rxZV9EnwYWViNG10YRtyn4kUiRkGK+1RyCmxnnbbXqFXygPcy6jzERtVOvUk1ERX/R60kg5Onwd6WxKsVRgIVQ0/xEjlcW0smPD5GeTI/lOveqvjQrnGCiLSh2V0OSW7h459Ej/99il1MfmzuBBMTdqsfZBpzRna+pdkIV7oOdMPMkBQlC3gj/LmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:48:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:48:50 +0000
Message-ID: <5254afb9-56ab-4dca-84a9-2c31e08ed38b@siemens.com>
Date: Tue, 2 Dec 2025 10:48:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 02/14] ci: Prepare for running
 non-bookworm secure boot tests
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 cip-dev@lists.cip-project.org
References: <cover.1764667279.git.jan.kiszka@siemens.com>
 <db363a65607faf0a2906abc2905fa24364b01496.1764667279.git.jan.kiszka@siemens.com>
 <DENMUFCSL2V5.2123DGIVNH8FU@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DENMUFCSL2V5.2123DGIVNH8FU@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: a043d4fe-3275-4135-2131-08de3187fed3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K1NTQVJjNWEwSVAzWWlBUGdMMnMyWGJMQjlqQk1UallqdVlRWmZEMTdkbkdO?=
 =?utf-8?B?Yjg0KzdFSlo2K1JIRmdPd24zK0RSYy9JeHFsTkxsTmhObjViWTBJSm1UL2c1?=
 =?utf-8?B?RFlmTUZXdFdWRkR1bUNmbW1TczZQVXJJUFBmUUJiaWR2bDUrRURxTURJS1pY?=
 =?utf-8?B?MEFtdThhZG9UREsxUHc2dmJXOFBFaHdqekVxVEZWUlBta2dKRmNWZkNjM2RD?=
 =?utf-8?B?dkxHTWVwUEg5SnpsVk9sd25ZZVk3OXdNN1YydHFEZjNtUFZSajlzUS9GSlZh?=
 =?utf-8?B?QXU3aG5iNmxSWWx2Zmt0bFdSc0JMejNOMzBrbnZpdDczdDVPaXR3ajJXQWdI?=
 =?utf-8?B?aXRKcHc4MWhIY1Nsc1ljL1lQS1FKUzl0OHVtcXNCeHJmaFdMNHBWd01VOG1H?=
 =?utf-8?B?UVpGYjRNK3JiQ21ZSlptalAzY2szTWpnT1lBaVRONVRYc2VvMkhaVE8zejQx?=
 =?utf-8?B?U0ZxSURLK2w5YS9RSFZTUjNHdjJOclBkWk9sMCtyQ2RvdmVZWWpkc290elNn?=
 =?utf-8?B?bHV0VzRSU1JyTjQwSmNaaUhZeEVwWmlqZUk3aUJVekR6V1NDSDY3N0Vza3VD?=
 =?utf-8?B?bXhuVVQzZWpGZTJyVkFTajRtZWhnbjJBWkVkajdBQ0ZKTkhEQXcxemx5alJo?=
 =?utf-8?B?eGR6ZU95bFpIQkw1TlYvVEVFOXZLR1hxc1IvNTBHeVlzclA3RUkvVGpoZGs2?=
 =?utf-8?B?YjlhRDNCNE0wZFNUc3hOY0dIdmxPdHFqYmRLVzZ5NGFGaXdyNWZmYlFGdVJF?=
 =?utf-8?B?cGhGTEpqdGx4NlJkNSs0VFI1WFRlZURwUmdWQVQzcTkyMlNqY3B1RHJtWTU2?=
 =?utf-8?B?QXZHeFYzYzk3VEhvdHo3OXBrcDBxZG56RGdESEtJR3kxN0tIdVAzbWRUeHRY?=
 =?utf-8?B?cjIxemFLbGFoYXlPa1kvYlpwbis1Unh3cmlVTHRvL2dCMmQxbSszSUN4SFZr?=
 =?utf-8?B?dVJEaFhzYm1EelNOazdMTWo1US91RVYyMDRpS0ZHblVNRFFyU05KSXRvYWYw?=
 =?utf-8?B?ZHdoN25Sa1l3TkhOSHlncjZ3dHZ4OWZOOVl5aEpiNHJMbjQ5S1JQZEZYTUtZ?=
 =?utf-8?B?bTBaNlVXamJ1QUtkcWw3K2hlVklwZnJEV2N0OUZnZmF2UlFHdmt0SS84cWZM?=
 =?utf-8?B?K2xjMFFSQWx5NTBFQ3lHUTNIbWVzczJ3VmVZOHdxYjF4MklTYmI5a2N5QWxv?=
 =?utf-8?B?M3MzYUlUcFBLQ2l5a1hhNkhncVk0TWN0Z0VHY09wTDNHSzZFMXp0aktGa3pm?=
 =?utf-8?B?bC90WmttZlR6aGRFOE9MWGllQ0p2dHZvUTkybGt1RFJkUmhYNURKYi8rQW41?=
 =?utf-8?B?RVlnRExsSGJ4dzB6b3VhR0EvOHJZdGFlWTlkRnVWbCt5akpCN0xid2FHRzJn?=
 =?utf-8?B?bm0zZTVlcTNGb1k2Mm0zNS9CZ2x1TTM3UkpWYXd0bVI2RjN4cXJYM2FYTHpC?=
 =?utf-8?B?MmYxWkptRjZ5R1p3OGJ4VTBEYlRONmFHYWozWHdlZy9pbGlDa1FlUG85YjRU?=
 =?utf-8?B?ZVpoak5NRU5DU0E0TXA2U1FGMDU2RzRHenV0N3F4bmJCWmhtakhDUmxrMkdt?=
 =?utf-8?B?bmFhWEhqaEJ1am9PN1BLTG5HVXBYTEVyOWNzSU5YWnk5MElsS0RPbW5tMUpp?=
 =?utf-8?B?bzlCTlFaeHBjdmVnVU82YURERS9QdmRVdHJwTVYzWDFRTjdDTWFRb3RWRklm?=
 =?utf-8?B?UWtPZVFhazRaTlBHZjRZcG15SkEwWk9oUFVjbGVTVURiZko3eXFweVIxUDZS?=
 =?utf-8?B?SmpKUzl1VVZFYzhMRWM0b2lla1ZEL1JqZytCME9xdWVITXZvZ2E4UHl2Y0lG?=
 =?utf-8?B?YzlxbnkyUDA5RStUV3JEcWt0cXJkMFBEUU40dVlRcXVhVzExNHB1Nm5YSmYv?=
 =?utf-8?B?ajlic3gzSjFZVG1Zbm04Ky81RE56UW41dW5qc0JkMEdFUDdCdlR5WFVIWGtP?=
 =?utf-8?Q?S2gtyxiASCwNGGPzQDzsc5LtLekUkLkw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmFwZFdKOGVIdnNSMk1oTjNaV0VNVzJQUnRIZ1ZsaW4reThmU1N2Zm5ZZ1I1?=
 =?utf-8?B?NGpIdkZYWHdWcjlqemVXeG0rY3RCY0pvc0J2T1JNYzBqU2Q5WTZ5QnhzcWlx?=
 =?utf-8?B?eVFaMkZOdGNEWVZqK2NWclVQZEU0bnlmTk9qK1gxOENUUE4zV0pjRFBWZUdu?=
 =?utf-8?B?c2tpK0tkSjRqSUlXWitTRDVGcnZjeDlSbkZmNW1zTmlUbkx5SFlHRUNpc2NG?=
 =?utf-8?B?TENUVkc4Mk9kVWZFL01od3IyMWxQNmZCSHFJNHBsK1dHWmtSa0ZNQVpmQXIw?=
 =?utf-8?B?a3RTU21Id0k5U2VKeUhTU2VjNDUwUUdSUm1WQStQT1BaVmxZWGx0VDVUTXFO?=
 =?utf-8?B?WEFiTk94VTZPVjBiMURRbjM1cy9YWWJzdXdYdjVkVHhRaHhRWGxyREQ5NkpO?=
 =?utf-8?B?NldCUzFzdURubzEvaXlSdFU2VCt4dzRiWHkrNGU1V01qcjZyakh1Q3JFcVJQ?=
 =?utf-8?B?Mk5sUjBadUZ6b09XNFp2TUJESGFiYVRodmhrTFZmY2xvQXNSQVQ1eWJrRDRV?=
 =?utf-8?B?TTRQZ3dtN1crdDJPN3lNQTN4SUtZZytHclluMG1qWUlGMzBzMVlaRXFoQkxH?=
 =?utf-8?B?cytrakw2NVY2N2x2SWg2cWFEblpsK00wSXd0c0NqVVJPUVVQMmk2c0NjYThw?=
 =?utf-8?B?L3BJYmFPbnlDYnJBRSs2eFRyNVpPOGpoODdRbk55ZkV4QmVIbEROMml3OXlZ?=
 =?utf-8?B?bThqYzdzSkdqZFd3bEx0clNwbWlhU09ZTXJhUDBHV0VoWkJPU0g0djRTVXE2?=
 =?utf-8?B?MThaMFJMQTd6QUIzVWp1UDhncVRYRHQ5Q2JmYkFGNElRTVNvcFpkWW1tdGYy?=
 =?utf-8?B?S0toeFZhUGRUUnFPOHg4RjFQcXBWOFk1Q1BLSUFFWi9jQUVmam5MbzZyV2RL?=
 =?utf-8?B?YlRaVXljWU1wTlp0UkUrQ1drOVBvYnlxcnlSZC9Ib1Jna1VBR1d0YmRqbSt3?=
 =?utf-8?B?cXdZaURxc2szaU5zZDZnZTRYMFNpWXYvL0lzRU5ZRnRRS3drc0NOSHBLZGo1?=
 =?utf-8?B?QXV1bXFDQVdMVXV1ZGhBRXo4VHA0S2lIUVAwM2dPTVRpRTlEaXZDQUxUdEdO?=
 =?utf-8?B?cVVqT1czZldMdzdCMGNYTmdENStya2xUeGhTTzZRdS82aXpZdlc5N0plWExE?=
 =?utf-8?B?aUY4USthTkxLWjlSdTUwZzBPVHVvRUMwZjJnMFk2QU5wV1ZKZ0VMSTEyZC9R?=
 =?utf-8?B?SzhVZXc5OVVUM1c2cGJua21yS0ZtZkozMmgyN1RMazFKbmQ3dEZnSnBEV3NH?=
 =?utf-8?B?WXZVK2VKcmxYNXJvMm0yOWd4NjYwa1V5NVd3QVJaQjZxQ0lmeW9jcit4TFB4?=
 =?utf-8?B?bGN4M2tqTExQL1p3QTFMZFlHTUNLcjZGS0cxTmh6K0d6NDhCYjZBVkpPS3di?=
 =?utf-8?B?UFV0d2ZXWGhPNld5QTRYQndKT2VLR2NEbUdNdHFQUStEMmhmOW51M0YxR21L?=
 =?utf-8?B?S3BXTWpTZzNmNUZUa2E5TzRLU1IrSGRYb282UlJOeGZpT1UrWVNSYTlPbDdk?=
 =?utf-8?B?aHpIZjY4emdPYzRXOHBQR05CaXVERVNDZnMzMXY5WllFTFBZTnRZV05wNWRy?=
 =?utf-8?B?eS9JWG9sejFUTGNWanVYNWtiRUVyOFNBTXJnejdCalRUVlJkZWZmYTkwUGI1?=
 =?utf-8?B?NUhIKzM5Z2VUZWEwaEgvTU5mNlFxci9DZ1daK2JuNDdHcnNtbnZYMXYzMzVM?=
 =?utf-8?B?MnI4c3FyOGtaa3dsSXVNOXJ5ajRUVk0yQTRIQ3IwdXF5MDhWdHJpNGwrc0RH?=
 =?utf-8?B?LzdMQ1BuV3l6aFRpTU9wMU1jek5mQXlsR2ZTMjFyY1hjWkhMZmlBVFQ1M0Mx?=
 =?utf-8?B?NUlOaFRrRW1HbWZuYVRDeUVGMzlsc3M5R2tGTnNPRXAwQXdsOEZlUU9oRGI0?=
 =?utf-8?B?K0svV2JWUlpmTktHRFZ6bVVUZS9YdjQ3cWFVZUVhSmtvYVl2OVJmb0RrSEVS?=
 =?utf-8?B?Nnd2RFgyU092ZXV2N216Z0E4TFRxa2cwbE1GVklJckRMeUhIVkp3Szd4K1RK?=
 =?utf-8?B?MnA5czRJaUtleUJlRDZITU5lazhIaXFjbUVtOE9idytxMUV5Vi9PeXFJc2Rv?=
 =?utf-8?B?RjhFYnJtYWxsT0ZxNHd1dkpKV0xzSEJjUEhyNWF0U3ZhemkvTkhTdEU2SG42?=
 =?utf-8?B?UDhQSk5jeG81b2YwT21MUEl1TFdXVmtMZDlXT0YzWVNEQnhHTTc4SFM1MXk1?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a043d4fe-3275-4135-2131-08de3187fed3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 09:48:49.9761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIp9feeNQFDBLe9oTqEHbvo4mI+EqufCdh3L2J+a8sXMVrEI+IEOjzIchxkG5FQMVLxPa5iYxAR0vEHgsL+CBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:48:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20805

On 02.12.25 10:44, Florian Bezdeka wrote:
> On Tue Dec 2, 2025 at 10:21 AM CET, Jan Kiszka via lists.cip-project.org wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Do no hard-code the release which provides alternative keys for the
>> mismatch test. This allows for testing trixie as well.
>>
>> While at it, consolidate over OVMF_CODE_4M.secboot.fd which is actually
>> identical to OVMF_CODE_4M.snakeoil.fd and is used elsewhere already.
>> Will allow to deploy less with the lava-worker container.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  scripts/submit_lava.sh | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
>> index ea733748..f7da99c3 100755
>> --- a/scripts/submit_lava.sh
>> +++ b/scripts/submit_lava.sh
>> @@ -178,8 +178,13 @@ create_job_qemu () {
>>  	sed -i -e "s@#architecture#@${2}@g" -e "s@#imageargs#@${image_args[$2]}@g" "${job_dir}"/*.yml
>>  
>>  	if [ "$1" = "secure-boot-mismatch-keys" ]; then
>> -		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/trixie-ovmf/OVMF_CODE_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
>> -		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/trixie-ovmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
>> +		if [ "${RELEASE}" = "trixie" ]; then
>> +			KEYS_DISTRO=bookworm
>> +		else
>> +			KEYS_DISTRO=trixie
>> +		fi
> 
> Really? That looks flipped, no?
> 

That's by intention: The test validates that a singed image is rejected
if there is a key mismatch.

Jan

>> +		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/${KEYS_DISTRO}-ovmf/OVMF_CODE_4M.secboot.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
>> +		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/${KEYS_DISTRO}-ovmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
>>  	fi
>>  
>>  	# Target is recieved from gitlab job in form of qemu-"architecture"
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

