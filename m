Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD957C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 07:41:41 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.42])
 by mx.groups.io with SMTP id smtpd.web10.81122.1718696494488968189
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 00:41:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ta27OFdo;
 spf=pass (domain: siemens.com, ip: 40.107.21.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utqt35w84jkVayvbOmJ9IxcCJt9cfsM4mCh1lNK20sG1Io+1phciDV1bArw4+yFNyXj4Rerltz3ZQYSkcn4NdG13CuPZ/vUQ+bbR9lfEaNZPqc5k4yD0op0w8PnSs+4N5eIiISlVYKqjsiDWLihNs82uc7841qJqy45+9FdenxUXIWg2oy2vQe1FND8SuY+oNcN2vLDwOJETMXkm1O2lYH6fmsQyT03rPneISxSeA712/VmuzwznaWkn22Oiu/F6tzI8POcvnlDv13URWXgCFogtMEm0Wa3F7kXVH6RO/1jlSIviJ8GQArqzg4tbn2zgDeiy80jsSE1Ip00gOK/pXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW2oOpHMqIbW1pyHuZ0eqED35r1HQ7EOTEfIBKpKOIY=;
 b=QGJocP5+SRy0HBtx8RM3MHhhuFO/4CdHHkFQpxpwRajTGthaYHofnRpW6/DXze11N8y0bSl09z1cyet8tyL/1sVggfUdFvjAwtFiiPx4HAmfebMzqGtZxG/hyPN3a51FApvhN+eD1qoWmDJ+q6oGa1MvGBWM0fssvYvzbv1VzluQDOadYRVv60TdqwIajKEFyn/LnsFXDhprt2AwzyNsM6fD+7BqXPRi/EPo2qJqWW50JaNpNoFOjSL1/pVuVNpk+zrC108Pe18/GeNpJ0g967vJIwGw2L7B5KqNpQPkb2ub3/vjiXluD+XfSU7BZyjUOMzC/VYnN8jSZYHxZRnF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW2oOpHMqIbW1pyHuZ0eqED35r1HQ7EOTEfIBKpKOIY=;
 b=Ta27OFdoHk8lEztUwVpsVExAZbIJS/484CNvlrzKpk6IPPKXx4W8A3oUqxA40gqp7DVvaYGulyFdY813wXmrFenoEqvGHWuRnVlBdqs/3R6J7dad1hdDeSnmA+t82nbKpwQWhRX4SO3iKQ64v2XhY+Xa2W7ryllb5FYBy3JeIzCTWaAhL8ZPuv9jI6/t+SMdhymPfMETdgx+0NU2pmMRa0qXZ956sCLA9AH08fMM8Cgw8q4D61+vi1l179ttvOOm27sMnD+Pw9FqIpavHerdYQnhL2jskV+6oGJsViYYG8tEhicHnRFubrBXklEDJtqAhipeKzzgL6UUOVwR08o27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6715.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 07:41:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:41:31 +0000
Message-ID: <d24c2c72-892c-47f2-b1cf-13d2502fe356@siemens.com>
Date: Tue, 18 Jun 2024 09:41:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/3] Split Gitlab test jobs
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240618045008.1765300-1-Sai.Sathujoda@toshiba-tsip.com>
 <9fd8a910-c88d-4262-b753-89a3cbd7020d@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9fd8a910-c88d-4262-b753-89a3cbd7020d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 163abf02-9c37-4a0a-63ec-08dc8f6a1203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZkJKT253KzEvZEkwWmtFTGFOM0FXRUd2Q0cycXB5K2dwZS9SSmdjczRwUzNz?=
 =?utf-8?B?a2NvZWx4dVdOQzg2UTgzMU1BQk5qTFVjTnhBT1JiVmJWVjQybnZUR0xmMjlk?=
 =?utf-8?B?alRYQlNvN05TUWJURzVXb000aWw1dUoxcURBa0c4V3d3UGRLeEw4S0ZDZXhG?=
 =?utf-8?B?dHlHY2FmWkdKand6MFR5NjE5d0gyZlpoNmlHeXJCRjZlWWNEOWxGVFBjc2tH?=
 =?utf-8?B?a2daYzBJTnRwdW5ObWFrTlBRalFNTDJSeDhROU5HaTBnR2JOcXo2Zi8vL0VC?=
 =?utf-8?B?TmVxZkh5eUNlSTNSVUFqaS95L0hRcUYydm1LM3d2Y0MvcGhkQXgybnRwM2pa?=
 =?utf-8?B?OHJxR2g3S25NSGNBYnduYXFwODdhS1Nrd1FubmN2OW4ybXdqV3JBR2NvYlRG?=
 =?utf-8?B?RzMvWVhxbEpNNmZtYkV4a2VDbEZUblBya2o0dC9sbDI5TlNNWUNLZnVTN01V?=
 =?utf-8?B?WjVScW5PRTI1S053Q2c3MEl0SEs4L0s4bnpGTVRsL2RKZ1RkRnJNejFUTDls?=
 =?utf-8?B?K3loK0hES1N3a2VaTHVBR1hCQVhkYlFUcExNdTlnQ0hQVmdQbFNNc28wU0Vn?=
 =?utf-8?B?WFluSjVKOGNCeXlrOTNHQytzeVFQUEY3VTBvL2R6RmU3ZFlIRlJBanVoWG5O?=
 =?utf-8?B?QUZEQUc1NGNRekJNeDl2MWRCUVpNQnVBbGpMc3dyL0lFeExkclpRcTJUSndV?=
 =?utf-8?B?ZUxpMm00V2NESEgzalNBMHA0NE0rLytXWjdOK1ppRE42YzlJMEVlWWhUNWlh?=
 =?utf-8?B?NWRtV2RLMlhCcmV3K1hNd0d6Z0FCWDNhTkpjdUs3NWZxeHdNSE9USDlleWd1?=
 =?utf-8?B?K3NIcmUxQ2FycFRUVXlWRnJrY1B4RHZWVTdyaFcwT2lLTnNMV2s0OTFMNFhh?=
 =?utf-8?B?ZXhwcjFXQ0VJRVJRSWRSWll0ZTcyQkM0eEU1dnNxRVpqS2NQbnZFT2s5UzNt?=
 =?utf-8?B?NmUzeVdsQmNXdnhJdHRteXF6VjduZ3liaklZQm1TeFhiRDZPVlpyZFBaVGVq?=
 =?utf-8?B?Wnd3ZCs2blZmMWJvNXM4QkdEdzFwajJ5eXNkU05oQWdYMmtIbFdsUFlYcGlr?=
 =?utf-8?B?eEk3U3F1VkQ2dnBBWVU5RzMxdUd5dFF3SkJONDJmdmVPRFFobGtVSllqemRj?=
 =?utf-8?B?dC9FMVBCWDFJOG0wbWFBSFljLzlxQk56RDlXNjRzV25oQ0JGQVlYZy9uWUhr?=
 =?utf-8?B?UHE1TXE3WFQ2ZG5zVGVTYlN6bDBubW5rNnVSUWxZek5MYW1qa3lUWUNMWVc0?=
 =?utf-8?B?eEJCVWlCYmlMQ3p1eVhvSVpjNkQzSTc2MFpjRHhjSnZiT29vWEpWa0ZlaTM3?=
 =?utf-8?B?bnRLSzhjMWtZbkYybjFVU1c2ckhWRzRUNmd6ZGVIN1FKeEZEMnc0YXNwWE5V?=
 =?utf-8?B?WWVndkRrUkhPclpsd2dhZldlc2lPQnp5QnFDaUREWlVTYUZPTlRmZDRPQjNK?=
 =?utf-8?B?UTJWQ1E0UGVpV2tKNFJWMG9QY3JWcTlkcEIzNXhOMkpDTXdNM1JneCtERi91?=
 =?utf-8?B?ZXpKZzBkeHJBdG5CbXpoanFsNitwYWZvcmI1QVhDYm16VHl3UmpvNzJNQSt4?=
 =?utf-8?B?TzhIdFlod094N0pjeDhXcmhSYlhKRFdPMHFvREtNc0djWWF4ci8zMURRUllI?=
 =?utf-8?B?UUdFcUloVEgvMkk0aWV6SlpKK2ZWaWl4N3RMTHFGeEdHVmJmckZXUWQ3ZzhP?=
 =?utf-8?B?elp2akJqSDYyNWpnWFY0VFgzVmlrTEdkWXFkcnU2OCtadCtrMzVxeFF5cmoz?=
 =?utf-8?Q?6Ym4+p6LTOKvQfthvGQs4cIBhPc3QWp8kjv04K0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OW1TVWpzQ1BZNXQ3UHJSZW1xUjVqNXVkWkVLbjFUQVB0WlVaRmhYQzJhZ2pR?=
 =?utf-8?B?cFhBRVcyb0VUMWRlQzQ4Yjd3c2tXNW54VTBPa1E1SnFmUGhsdDNCcG9vSGNo?=
 =?utf-8?B?WlMyUGFQMHkxY1lUejFxeExSRlh2MkgzbFlFVGw3N2RiSExNMGNTU1BFaFVl?=
 =?utf-8?B?T0tyNXF3Ym1CeXQ2M0x0c3BENWpBbUdhSnlEbXNSRUxhaGt0YVpkbXpMZVdP?=
 =?utf-8?B?RElsM0Nic1p4ejVlWXpiNnFjdFRrODlLczRYd3E0Sk4zYjIrQmZvN3ZaeFdK?=
 =?utf-8?B?dGREQ1V4bm1QYzRwR1lQZ2x5c2ZoN1BlRk41aTFsMUJwbTRYVFhreVQ3TVlx?=
 =?utf-8?B?TGZOZDRXTkZrcUZCSkQ3VmdPN3NLVDRxLzFuL0o1QitldTFPRXBlbzdNUjNO?=
 =?utf-8?B?NHoxTmh4VktiSDF2dzVzeTRuUElNZGZ2ODg3b0NGSEl2OGlLZld2RGRHeWdF?=
 =?utf-8?B?bWpqRjIwajF1K2JuNXVyOUNPdzNKTm5FWm9XUVEza3ExWGxva1gzMEFHd3pT?=
 =?utf-8?B?S21PcGplTkxXSXBCVzBxQmZUdG43dVpJcEdkemhKS3ZYT3FnUGFBYlg4dzRu?=
 =?utf-8?B?am5MYzRiZjRWUmdPWGlscldELzE2cU1UNkZmcEdiNmdneFdlNzJTVDhDY1Nw?=
 =?utf-8?B?S2RuNEc4VzRyU0lnN1N4Y0dXc2NSb2ZiYkM0MnZ6SkVVZWRZU2NtWHY0RGto?=
 =?utf-8?B?WHYrbW5tUVBJSFJMSHNvOGVkNnJoMHVmOUZ6RjlwcTZjd1ZRaXIxRGZIdnl1?=
 =?utf-8?B?Zmo1b3hXd3NZS25UYXdGbG8ydHB3UEJoRE9WRGpteU1VYTlkbFpQVGxEUjY3?=
 =?utf-8?B?QmE1TG5OWEZxTncxRUI0Nnh6aTU5dWNMdkdFNmpLVVhScXE0MXk3OFBRazhV?=
 =?utf-8?B?SW00VnFXcWI4WmE0SHJXR2NVT2JBT3l2TjJGNkM5TlFVTWpmUkR1YkFtOHJ2?=
 =?utf-8?B?Szg1cS9hMWVrRy9LeWJiVVFBNEVRRDkzVkJRcUY1cmpiQno1enh5V081ODNr?=
 =?utf-8?B?cTVlQTVjTlZkaWNYQWl4OG5WT2dHSWh6dUFNcWR3MHVZMm1Fb1JHamVJRDAy?=
 =?utf-8?B?TC9ZTnl1eU1DUUlxSG9YTXVSQldNbTdXY3hIOGRCK1pKVlh0RHlJTnpvYS9T?=
 =?utf-8?B?TmtsRjZaWHM3Q1ZDaVh0TVJQd1pnd01DMUt3ZThZc3R0dWhLTUFQQzZpbzZP?=
 =?utf-8?B?amNPWmlZYUo2SEREWGNLc2piRFNSQklsRTBTektNUTU2eVJ2Y1p0cFRIc1BU?=
 =?utf-8?B?eEVTSlV0TEwrUnB3bE41aGlMS2RMU0I1MmtzTlQwaEJRZyszSlNTNllncGgz?=
 =?utf-8?B?eWdlVWN0cWFwRTBpUWpaYVR3aXI2ZzlNcXN6ejRsbWxnMFVnL3F0MU8wdVN3?=
 =?utf-8?B?aGFsYllxT24wUWwxYW8zdnFkSTFBREwzSDRGRjZZTG9RS0Q2SWZLMG94alFv?=
 =?utf-8?B?dTZCOEp0ZGRFNkpneWwraFY0MUNlTGZIMmhpTjJiUGFERi9DN3BHS1MyRTd1?=
 =?utf-8?B?TG5GMDNXSkJKZTRsQWN6UDJ1U01ESnVqOTFEZTE0Y1YvSVFGSGd2bG42MURi?=
 =?utf-8?B?WXN3NHFWY0t5MVhITVJGSlBuQlFkM0oreUZiRktTOWJhZUFydjRvSmx0d2hy?=
 =?utf-8?B?NzR2YTBZRlFnQnRmM29iRFQ5aDZMUzh2MXI3dHIvUHAxOXA3SVFhMU9XN2RE?=
 =?utf-8?B?c1lWdnJxSFV4eSt1RTh1elo2bWE3Y2IwK1BLamxvUmVnazNnSTFkOHFXR01m?=
 =?utf-8?B?NmI4cXl0bmw1QkEwRGhLYSt6QWxnR1FqNUhXZ3I4QitldHREWHNHR1I1K1lK?=
 =?utf-8?B?WGFXSmJMWUZpSlE2ZVhMcGdZSERHdGJma1NDdEljeGpzdEdMR2xlSzhXT2p0?=
 =?utf-8?B?T2lYMnlndDdmOVpVVjF0OGxVbEl4L3IzNnJqUnZrVUhWaktMM013UjlkYnNz?=
 =?utf-8?B?YUxUVmZFdWhyaVN0eWZTTzIwNHBlZkcySnY1N21DRU8wOG1xM0FSRlZoYUhm?=
 =?utf-8?B?Zko0bXBqeTNXVExYWDNCMmVoU0hibktWUGVtNFpoSEYwV2V3TmNUVDc0NUwx?=
 =?utf-8?B?TGJrZFN0cDFKQ2dFclp2cEVnQVB2R2w3RVN1U0czQVNIek9SZ010VTQrRFYx?=
 =?utf-8?B?bkE5YjlCZGtvbS95U0MxTjYrVU1FaEFRZVoxd1B2Sm15cEhtL2tmclppMXJT?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163abf02-9c37-4a0a-63ec-08dc8f6a1203
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:41:31.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J3sA5ae8PU4yRd7Jw4OJQMEsBHnsvSYQveX9NYCELmZOf8PpUwCUrb79ormNXFpzGvu0hAOr+srbCbR0CnDcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6715
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 07:41:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16278

On 18.06.24 07:21, Jan Kiszka wrote:
> On 18.06.24 06:50, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> This series of patches will run one LAVA job per Gitlab test job.
>> Accordingly the submit_lava.sh and template files are modified to
>> sync with the changes.
>>
>> Changes in v2:
>> Patches sent in v1 are re-ordered to work as expected.
>>
>> sai ashrith sathujoda (3):
>>   tests: Modify the replacable strings and increase timeouts in the
>>     templates
>>   submit_lava.sh: Modify the script to handle only one job at a time
>>   .gitlab-ci.yml: Break current test jobs to run one LAVA job per Gitlab
>>     job
>>
>>  .gitlab-ci.yml                          |  80 +++++-
>>  scripts/submit_lava.sh                  | 336 ++++++++++--------------
>>  tests/templates/IEC_template.yml        |  16 +-
>>  tests/templates/secureboot_template.yml |  14 +-
>>  tests/templates/swupdate_template.yml   |  18 +-
>>  5 files changed, 227 insertions(+), 237 deletions(-)
>>
> 
> Thanks, applied to next.
> 
> I've also addressed now the shellcheck warnings on top. Will share patch
> if CI passes.
> 

Follow-up wish: Please make sure that the output of the DUT is
live-streamed into the gitlab CI log, like we have with xenomai-images -
one click less, avoiding to go to the lava portal for that.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


