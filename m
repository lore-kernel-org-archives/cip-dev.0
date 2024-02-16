Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF707C48260
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 08:34:28 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.84])
 by mx.groups.io with SMTP id smtpd.web11.14663.1708072459093429548
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 00:34:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g1wE44iJ;
 spf=pass (domain: siemens.com, ip: 40.107.20.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLDqR0smGj6+7zbaR6SXNE4hH0Lexw1D/CQPSnqFd7QoPIWC8M8hi3VS+B+wFHcj+2GDqSL8OqQk8yNsSTcGYoHC3i0U3wWiudZW4hMMguDEZlETtxLg4t6c5Si/9trySNgm3/2eSxrU+kGCvOo0pM0agIE7yy2T4P3TAzmct7N5CGb5F+w6qmcYTj6VJlBrjkCKHZwLZKDyW/+HR9ZzhFQeS6O5GDJjTE9P6uEgUTyjga3JgDKnCee6+3Gx4EwPbK7zMlrj3S/MdNOqZrA3paxfwDC1u2m9Sfp8xvaS21csipuoaXm3aIEhMGrWbGRiv6w+VJG3JXir80UyUH7fBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHZQhBXOfuuKMvMNVn1jfMbPukiscavGE2jOZFo6nZY=;
 b=LjPkx8ym+ZrZO7yUtmVBlvgt7Vu0S4sccIR+jWi52gIagQXXl461EvpoAEdnHqPgAYTeCnR5YDPDOK/swPjZRZjQUEztKRTCB4w/rqLoo8beEP/MM1p1Jhbs3IC54Zg9ZtpbrYay5l7WyN6rBTqh2lMcSzFmX1nAhpcmBuSDskNZuWmkHc7vV8O1BMkMBU2JxE96hwGxgS609vIBqONRg8hMI1oWudka9HuLpR06PXvb5xI1TpEAQYldCG4FuArDzHKlURBP/tU7FDDmC9le1z1XJqSlZD6KU5inEAiN/wcSZfgMOldOSt/Q/bF/p/r6sYoOeYhiA6oojKA2TugvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHZQhBXOfuuKMvMNVn1jfMbPukiscavGE2jOZFo6nZY=;
 b=g1wE44iJLm+CeLm5gV83rdRQgm7Pqu2B5d+/W1mnb4+tzhvGXXBO7QJvXsJhCL7VlYp9j5GtqR6Xs9tUI1HR/XQgKTxgvTBiyX+RdPAe/M3FKfIJgu/OZTbyESyXsvuFPuzukBHrE14+C9qB7UkfrANLVM1/8/NupW06SmZzlNGD4dlHCs3gPZ+/65Oeref0fbKdXme1gZLGK+5+socAp/6LNWD+NqcErsWf9v0XpP7gzuK04s6ljkUcrR/BoGOhfGFDFG8MtZyOYCCH8waYeQbg+ZawjtMrIXi4kizfsSlQRx/HZ2D0vIpDL6bYMWI4hnk9h3CuDAQu8XkkbORphw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 08:34:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 08:34:17 +0000
Message-ID: <e25e314a-8fdc-45a6-9454-55c4bbc2fe1f@siemens.com>
Date: Fri, 16 Feb 2024 09:34:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/3] Add SWUpdate 2022.12
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
 <bbabd895-880b-4bc8-b297-084bffa1ec72@siemens.com>
In-Reply-To: <bbabd895-880b-4bc8-b297-084bffa1ec72@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 4704779e-3d98-439e-ffa5-08dc2eca1026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	12SjMF3OH/1M6fdjWiUXpnRTIGO4hwSr90oTtpkFoIgDFcPBasC4WQjI8UGsnm51jef4NM7zU6apahtGgLySjzU9Uf51eIHmbmqBQqyS9ZJWcz0m/RJBsCL4qyHlZeC2+TlNn/SM5XLRT62B9WXcPkCnlSBbrIc2MPyrp0gFlcRprpv0Iln5549EduQTemKYyceYcAPPE1RFbsy61eKN4pR8HZJKCKYaEqWI3tCBIQcusDdiyCPxjDLAF4KwFAvSBvggTtxniLh+XIXo2c2ONt0dJbWDrGKhnm1i415NUq0hmyTtfxDn4pAPh2lngOjQxLbETTX81DoWR+WkVDu3SgkbGHV3rGVlxSnMEqwZOEUltTKU6HKR7c7zFIHm/FLfYGJ5dgpZVTRudX8/Bkra5XGHwncwLER4FdYzWK7fa+bE/BdAh2JtbYJq3mK7huJNccxomsKx+77kcHSUH61Kawp29+cc3R8lTPi5o2W/OOBST1V/0rAQrcEH99p4Vf2Z+R6OgdNGNsK4hDWi/Q3uRLr88XLUa2NQAbXMD7pRd2cVTP5uTO3CCzpQNTIPLkHP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(44832011)(66946007)(66476007)(66556008)(8676002)(8936002)(2906002)(36756003)(86362001)(31696002)(38100700002)(82960400001)(83380400001)(316002)(478600001)(53546011)(6512007)(6486002)(6506007)(2616005)(41300700001)(26005)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkxlN1BRcnpiWVBzRmtnNzFHd1F6QkprWVlSVFZ6VlNlU2RaRTNJMkNXTUx0?=
 =?utf-8?B?emdGNzdldHdJQjZVbkl6Unp0RFpMU0Mvd0xERlJWdUR1YWdWejJML3g1NzJu?=
 =?utf-8?B?bkIyVDB4bzlVZXMrS2V6ZzRadDU3WHowL3VCTDR4TzlzcHpwNTZNMzA2b1BZ?=
 =?utf-8?B?YlJlMHJGWHhJTjFRRU16NXdHc0VKYnd0LzgxeUxPelVIYVZMOEZQNU1MMC9z?=
 =?utf-8?B?Q1BXY05FTzgzZnU3ZmtMR0thSmkwVHBqSUZsMDJpMEtaaEZhY0QyN2xkeCtt?=
 =?utf-8?B?WEllbEdCNEhNVEY2VTFsVHpXc3QwZ0dic0N3ODR0dmUzOTU4VjlGTDhoRVlo?=
 =?utf-8?B?S3BjLzRURFE4M3FVWUNPNVNFQ1gveWFacEhlSEExS1MxMnBRcHZoaFZTUDZY?=
 =?utf-8?B?Z3habW5LbEFOR0ZuZUZrKzJ4RENnWndDZDlQa1BDOXB6RzN2QURkcG5tU2Mr?=
 =?utf-8?B?WDBCQnVzQnE5aDluQ25CcW9SZzhXZWxibENNUW1yKytlQ2d1S3lRNkRrNXRo?=
 =?utf-8?B?T1RtSEgzOEtsNFliaitqa3BaSmtQTDFWSUlBTkNHTXNadUYwQzU2SUFJeWxU?=
 =?utf-8?B?ZzR6SWFhNk0rZlBiUHhvVlYrNVVyU3hzWmhTVFZxWUtzUGErTDB3SHd5TU50?=
 =?utf-8?B?YVlrc042ZlJNSVVZeEQ2cFhwN3hnckJtNnEwUjNGTnY5aWgvZkdBdVJ0bS94?=
 =?utf-8?B?TmZiZzNaZWNtSStTQnlRclg0MXp6OGZPRTJkbVcvSllTUkRsQlc1TGROWmpN?=
 =?utf-8?B?Y3NCaFZHTVBuaG9oZmNEa1JrLzlDSUFSWUZtUmlWbFJzMUhIcWNRbnF1STFC?=
 =?utf-8?B?QXd4MVlXZXJZK01KbnZvbkpkYmw2RjI1TFNvRHlKdXJISGFZdmx0UVR0TVV6?=
 =?utf-8?B?M01NOEVDaEExbitkUkZ1RkNVT0llbG1QVUxyZ1VaaDZFZ1lpYVl2K1NXR2Nn?=
 =?utf-8?B?RHZWUUg2Y1hzWTVIQi90bGtiNVNrN3VsN3JIY3FCdHNPOGk0NlQreGFRT0lY?=
 =?utf-8?B?eUdtOWpaMFpIN2dYWC9GaEFmNHZqRFBFcWJ6elIwM0tvdXBCU2ZvcHNDWGQz?=
 =?utf-8?B?TGg4RzBmdXNXN1loaVB3TXNXNGFEUThVN1Y3ajZBMFFQUzRwaVFmRE4zZk1P?=
 =?utf-8?B?VGhCVnJ1dFVuK2d2S2o4VWF3djdCYzNCa2xQendOZUdKUm1OZjdtUUJ2ZE9C?=
 =?utf-8?B?NUZtZVlwYThFcFdhbE1qanp1bFNQMWF0SGUxTS83TmN2MXBhWGNSQ2FoSjR0?=
 =?utf-8?B?cjZycGQ5VkpHMENsOWlpUXhVaVBuZWEreHAvY3UrK243RXNUbmxPSDlVcjNO?=
 =?utf-8?B?ZFBWU2thbllCM29aeFozMFNKaWxVR0xQaGhsN042Sk45c0QySjRkYlVZTnZL?=
 =?utf-8?B?L1VnU2xTcFozYjc4SU16VE9zNzFCeTExalFqS2crZHJab2tpWkhHaVhaTnFE?=
 =?utf-8?B?Ull4YzVIaFd2eGphOW5JenJuT2RHZ1hOb0VwNWplbVRXOXc1WkR0Y0lqWTJt?=
 =?utf-8?B?cUM5aDkxU1BOVldvU1g4bTY2T2J0SWlrMlJqb0M1SllKNFBJdmJIR1FqRTFG?=
 =?utf-8?B?SFZtSUlnU0ZkNW9MUVF4NnNrWTlFNDczaVRCeFRkTXF2T0w0NkRRaVd1ZWdP?=
 =?utf-8?B?dkh4UTM1UEhQK2lkTGxKbUlBUEZ5bkgwZU41Y0VPYlBqVWZHWStqcC9ndkl5?=
 =?utf-8?B?YU42cE9WSkVIV3VWbkhWNW1nWnhYMWczRkdGVkhpRFp4bHlPbnQ4QTBsSS8r?=
 =?utf-8?B?Z1hyTkpEdElXRFpiNGxZeWJHdm1XWjBYMkg5Qmd3bmJvK3o5UVZQTE9UdE9K?=
 =?utf-8?B?T2cxUjFaVms0L0FCRUJhYmlTd0g1a0ZzMWlyb1V4M29FaHBST0JXbiticE81?=
 =?utf-8?B?WHZobUdWS3dsTFd4amo3blVTZFlxNERVL0p5aGRkZmVRQnNTZGR0eG4vc1RJ?=
 =?utf-8?B?M2RRSS93REtvcVRnclczaWxlMXI5UUgydEgrWHZVVnZmNVBLUGpHMGYrVWx6?=
 =?utf-8?B?RktiWllXUFRBNkRUMjFWeFNZZkhOMVg4dGxvT04vMDVmcjFWTVYvcXNQbTZh?=
 =?utf-8?B?aUo4V0hhNWNPWFdEWDdyVFVsOTJYZW1zTVNmZDI3UmhBMmJ4eWE4aGVYYkJ5?=
 =?utf-8?B?c3MyZHVxS2VYWjcyeU4rMlM2d3FJYzR1SUpnTjVnKzEzdHVTRFpRZkxadjBC?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4704779e-3d98-439e-ffa5-08dc2eca1026
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:34:16.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxeVz51HAq8UmT0SZcc0UBptBKYQFXM+rWfVGEBMUpWgQUk4fUhXYSi7SB7vamT0sesoXf7DDbKKrS+QChyLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 08:34:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15013

On 16.02.24 09:33, Jan Kiszka wrote:
> On 15.02.24 16:53, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> SWUpdate changed the API for the Suricatta lua plugin with 2023.05.
>> To support released legacy application which use the old api add
>> SWUpdate 2022.12.
>>
>> Changes v2:
>>  - Reword commit message 'add SWUpdate 2022.12'
>>    - add information from salsa
>>
>> Quirin Gylstorff (3):
>>   swupdate delete unused patch
>>   add SWUpdate 2022.12
>>   build swupdate 2022.12 for qemu-amd64-secure-boot-bullseye
>>
>>  .gitlab-ci.yml                                |  4 +-
>>  kas/opt/swupdate-2022.12.yaml                 | 22 ++++++++++
>>  ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++++++++
>>  ...ch-to-add-the-build-version-to-swup.patch} |  8 ++--
>>  .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 +++++++++++++++++++
>>  5 files changed, 97 insertions(+), 5 deletions(-)
>>  create mode 100644 kas/opt/swupdate-2022.12.yaml
>>  create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>>  rename recipes-core/swupdate/files/{0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (94%)
>>  create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
>>
> 
> Thanks, applied.
> 

Err, v3, not this one :)

Jan

-- 
Siemens AG, Technology
Linux Expert Center


