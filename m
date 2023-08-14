Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C978C001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 07:45:12 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.65])
 by mx.groups.io with SMTP id smtpd.web11.102609.1691999108415832136
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 00:45:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ps5HKtd+;
 spf=pass (domain: siemens.com, ip: 40.107.20.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHBpBxMmPbIPCCWBJwjuGZV0NNCPi3OGSKGK5hhtFaJ95OnF50SBlw39Y2HBmUL4qhJKYQUmR1n9xshF0GXiltfKHmK8elkdL0pMjIq5XdmN/XoBWRpT5Imcdntl2ZnGW16FN6LqjTDCR1ZMvpV/dabSWm5fIz9bN4kpEVH3te2xjxKCPEymucYumiIEqSZZSrD7bb45iD7Eusg3rCKHmUA8kGvpWNq7Ga3NIiKj4LmbDuacL7axYVo0gRfu6xLa10wnQtwm65FISmqmSIQVuJv4OmXbnwkRvwaRsBdyAXsB6WDuSmit8hCo2m0X4Q9+IFfugIB4hRtOYeluHEDfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrM13z7e1i+d7la0BnpKpw+SlkqsAcUF/iybO9xK+wY=;
 b=OH85IY8hdw20EDXaOhgmhgXQS/+oGMHKL/Rif+MtOKbrzTep0InIlAVnkneOyP+ehRfgBKcVQf8P7T57HbAS3EMQ5xCnc3ujkF1qSXWDw3dLarpWB3i8+oy1CBeldrqTz4SOx52YwL5g5fhLZCQoQ+5SD5PO4ws0gJK373RICc4KXkMoB7JUDXE0Y/3BSLd3HjtyZu55G9oTEcI+clTwssWBtolVup72OMaASyzCrg5BZF6p8SVJuiOZr8ShIQQpuy9CaDfecf7MiMc4z/TZ1czqo2TCp+s96wmF54zQWrfAmUNMJyZYlVhovYY72m6f6wJx/nqu2QqepAuRHW9lXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrM13z7e1i+d7la0BnpKpw+SlkqsAcUF/iybO9xK+wY=;
 b=ps5HKtd+rt8cYjm8JMFQI+i1+CDvJ6eH0hovEg2B95drZyg3yC8m11atZsFf0Q2Jl0pxnRyms2j1kJIv9jl7w+wx7ouEnOau7gz3w8wuvOGDZKOP2dCqP5+0vodChsO2/+sHKTFNfpNnZyT0Es1cFgS6z+XIQJ1ygSy9yQ86gIybfImhcFSnLcitN0qPkc1RzmxD/u6bWrmRcb+/nbZqAsWRujrUXpMGqrnmQyr6Gk3e+3gAseZa7lGzcot1/At6Nx4+oeckyOAUSgRqE+DXznPS3vcgEqG7W19U6GCczZcgRBwNWuWKj1u7DwSMFtsWx9bDkBvMLu1JkK+E9tjWsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5337.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 07:45:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 07:45:05 +0000
Message-ID: <54d2aac1-3fc2-4081-b0c6-86d33179cfca@siemens.com>
Date: Mon, 14 Aug 2023 09:45:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Query regarding image-uuid.env file permission
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com
Cc: dinesh.kumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <OSAPR01MB494549CD00E03E7B64EDAC71C217A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSAPR01MB494549CD00E03E7B64EDAC71C217A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e15ada8-771e-496a-0389-08db9c9a6013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1Jk57pmzQ75T7JSSOxFXaySR+/Hvk/JQK2uf//TyyYvdlb3Mcyq67z86gZMAwi2ToESkoh3MPNdrWqhKIJcSuOSO+IfTowbNV8KKJrvstdk6Vod6XDLcJrHbuVcUFzEtqD+2ZwttyxcJtIc8gBC7K0E2LoMBDUGeZNq4LMwt5ZyQPMeRL8Iq8uT5d0+6zYmwyVq27nu39tPtO0C081EwxP0stpC6tRiKpNqLcGFV9B8Y7uNt2CFf9pAU4nMt1ze/r5+PFYs+GBCacmTqs0hrLpB8M6rwsU02VxrHwa5KbRwQ/5xgi3XbLYjVxyrZgrBWAy4Q6ikgF3M41CEj6Hj8t8YAfjh7PA2T4zDhVVrxJlKBc00+FCWhs69HcwkVAgixoIxMM6GOq7MR9ub/RJLeDJfFIfK8JpGKIGD3NC1zQHkRJT8NVsQRbACPYYNSv9x8eZ9YDHRIbeNOvn9SQ/hSitovwdW6jX3i7fC2fvqTVfJNp6J3P+NfWzbS48pQ6ISy7g8UCC3rkGWpvlsOQA/4xLF4gw64hBEl701CmMrcF6gYEBC59eovouY/GptQsRfRL06+pd3pRP2IyF8NWCUPyyXDAjQ+R0CjsB7pa94yU16lLA5epXY3/pEFj1wEDO2ubXONYRuz4zixJhgYIcvj9g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(1800799006)(186006)(6486002)(6512007)(966005)(478600001)(2616005)(53546011)(26005)(6506007)(2906002)(44832011)(4744005)(4326008)(316002)(6916009)(66476007)(66946007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(38100700002)(31696002)(86362001)(36756003)(83380400001)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnh4Ni9STWt1OC9LK2xVMklUV1JHVmliR0RDM1lZL3JSR0N6U0dJL0J5Tmk4?=
 =?utf-8?B?ZGdqOGg0ZWdXOGZsSHpqV2JJL1FBZFR6c29hWXBrdndRWFRwcFZBdW9zcUx6?=
 =?utf-8?B?c3hCdHRDVGlGbHc5OUQwTVJhUnNsaEZxZW53WGduUWxOcFNvUStVNjBuQVEr?=
 =?utf-8?B?b0N4SENiSjkvTURhb0NDaThlOHVRWC9nbUdIMzhvRzVsMzJrNk1SUGtyTFp1?=
 =?utf-8?B?QXI4Rktock1Va1YxRHBRWDB2blVMNk9CQTJTSWJTWUxUd0hhVDhaUDBXQjdz?=
 =?utf-8?B?SldhRXUzYVJaVjh4L255RjFlZWNhNzRKOEhGYTJSakZsbzJ3ek90OUdGSDZk?=
 =?utf-8?B?SG5WUHRaYW9sdVByRWV2Q0VINm5VVFpUTFRmdm1hL0h3VVJZdlVxa1JmVVUy?=
 =?utf-8?B?aWtVNFlxWjA2VWdUVGJjYkdSUmc1MTJkV1NsZk12dVNxUkV1YkhQbFhvOHZE?=
 =?utf-8?B?L0dzTGFHU2JKZTQ4Y21YdkpxdlJscDJvUTY2Mnl6UDh0d0I4WE5BTkxzMGdP?=
 =?utf-8?B?ZkpDQ3pSQ0Jsa1J0RURMakZycVRGRE5MMGxlS0NvYzRBWXV3WEIrbDMrTE5h?=
 =?utf-8?B?U1JDZlBVc2tMNFZPQi9vbEt3aW43MTE0bEVjVWVNYVZHSE0wcDBEQ01GdTc5?=
 =?utf-8?B?N0NsNWhzRjROd2FRSVI4MVdVZnBPc3BPMWV1L2VzRlZocTV4UGJhQ0szOCtZ?=
 =?utf-8?B?S08wVWo0R1JMRTJhQ3M5TFpIcWxoeVZQRTArOTZkdjZORFJJSnRIMVJaM0VK?=
 =?utf-8?B?UUVzTjlZYmhQZ2c2MWcrTHFidGl0TzZ3V3U1WWV6N0QwMnA2RGZHRmVvRGZS?=
 =?utf-8?B?VjRFTkE3WDZxLzUrWW0xQWQwS21PNTZFMmprZjc3emY2UDh1aG8yT0MzVVB4?=
 =?utf-8?B?Ly9MYkV1UlU1WGVOL2hzK2R3TENnZXRFemp6b0ZqV0djNVFIenJpZmx2SnEw?=
 =?utf-8?B?S1diUzYwa2RDUGN5eWEyWE92SlNqaHMwSVV1cFlSWVpYbUNmOGxpejZoK1Rk?=
 =?utf-8?B?bk9nWVgrSWxTSSt5T3ZKY09wZFNBMzVrTEFPaGljOEVCZjV2U3ZDU2ZLSnJG?=
 =?utf-8?B?TC9vQk1vMGVRYkVBVVhOVEx3dlUrOFVlanJNYThSdFd4VmowYisvY2oxNzQr?=
 =?utf-8?B?THBJSi9UT21uR2J6NnhSdnNmZjBhYWpUVlhzVS91SjVOM1Nta0NiSk84QVNo?=
 =?utf-8?B?OFA3V2lpeUxzd1owdlRlQ2lSZzdZUzVNNmE2OW51ZFpUd095WU84M3dKR3NC?=
 =?utf-8?B?YXM4VjM5S05rZDF1OHlYdmUyOU5oT0Z6YmRjN1pzMU15Wk8yNTVTd2thb3A3?=
 =?utf-8?B?QWdaS08rUlROY2NKRFZCM0VXZ0sraFA5SUpuR0JyMXJFVzlqYk9mbWpoSzFD?=
 =?utf-8?B?MzBpcGtZT1Q2T1RiaWJkTmFzSllHMEJ1WjRMZmlKaFF3a3FuemcrTTVXWkRZ?=
 =?utf-8?B?OUFrNCt3UDJrVFdvR0h0eHpPcDdYVnJ5Q1d5emhUcjRXYjRiRGpLdWdVOS9G?=
 =?utf-8?B?QVdKS1kxbXM4WWtGN3NUc0dNSVlNazFjdDJjYjJmT2NacG41N0pFWGo1Z2s1?=
 =?utf-8?B?c2wzT1dzd25kdzliYjUvWUZOdzBreWdjZVM5ZDdnVnVBdnlkempBdFJCVnc1?=
 =?utf-8?B?dUVzUEQ5N3l0RFprMWRFY2Nrc3JWRDBlODZ3TDkvcEpld3R4ZG9UV1A0MGlD?=
 =?utf-8?B?NzdvanRVUE5OdXdvUEg1eEFVVXhrcXcyVDJNbHlHVHhBVldJdzI2QkpFMThq?=
 =?utf-8?B?U0tkNEVnTElERG9HUkpHWlNISm1abTdHR0x4K01zd0N3SCs1NzZteUpXYTJJ?=
 =?utf-8?B?aVRFQTA5S1p2U0hhbEJoSC9HcEtNZGswODluRURzam9iTEFTTHRZS3FpckI4?=
 =?utf-8?B?c3RUWTNnK3gzbnNmZytWOGVwMFBQaTV3WVNUa1BIWkNOVDRINzduV2drclFQ?=
 =?utf-8?B?dUhpS0NreTBsY3ZESEY4RitMS08zclJVQlRLYmU1Q1pmSnJUWlhXTzZ1OEJI?=
 =?utf-8?B?QWQ3MnBNTktSMVY0a29XV0c3RWxJVjZ3Vm0rcXhpZnRPNmtJaEYxakI2RSs4?=
 =?utf-8?B?RDdNekhuaTE3VkNUYjBwMWd0OHAzc2hDNnpHNzgzMEthcTA1S0tkNUFKb2U2?=
 =?utf-8?B?RkdoOEFtbGlkczVVcW5FUmZnMWZyZ3JET3dzOHppVmFxc0tvMGpUZlpzamZK?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e15ada8-771e-496a-0389-08db9c9a6013
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 07:45:05.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1zSiQqUqk9q9AwEifIOscyCLmqFhSz4q7MStqIrtrc9rv5ulzDIYIUo+sR87kPUwqqZV2oY/893DFP2wt6cFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5337
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 07:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12625

On 14.08.23 09:28, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
> 
> Can you please tell if there is a specific reason why write permission
> is also given to the *image-uuid.env* file along with read permission in
> the *initramfs-abrootfs-hook_0.1.bb*.
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/f1e559498116cd358277d147c008758b86f7fc0e#b69acba1c08d84c2ecfc3b8b5a60f7338876fa77 <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/f1e559498116cd358277d147c008758b86f7fc0e#b69acba1c08d84c2ecfc3b8b5a60f7338876fa77>.
> 
> When we verified with *400 *permission code, even then the swupdate and
> partition switch are working fine. So is there a specific reason for
> giving *0600 *permission to that file Jan ?
> 

No particular reason - but what would be the benefit of revoking write
permissions to a file that is root-only anyway?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


