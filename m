Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF303C4332F
	for <webhook@archiver.kernel.org>; Thu, 15 Dec 2022 12:46:31 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.84])
 by mx.groups.io with SMTP id smtpd.web10.131880.1671108389115435899
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Dec 2022 04:46:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rQidtBH0;
 spf=pass (domain: siemens.com, ip: 40.107.6.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORwNhVHDfmc6keTGm0Awf4rfMbEIjNdNbb4jXHdZv4QL+3Q9aPjlpJkcKhXLtOXnx7kTNtFFs3U4rljCNDZE+/2IrW3LJseTcRXZzp3eUT50puZ5dTFY43HW7pUEyg2+FT+3ECao1UPMSEc4rAlsK8xtLvMrcPKuPmevURHxMcgSWIgNcnSWkzT+sDM6s5k+bBDZRgtmgDyS2I8pJ8cNoRXkeqSO9StN7JCGawVaj87zLDKJAtbbJg3UAyLgQHttyBo523Q1Su+dpFtFz0nP5tbyxLsnh9G5DcE3LSfiBwjH72932Lh0+Z9NGKFRy4bJbONHv96OIoowmq9LlYhnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p87sDpxPF4RQytCwMwx0wkmHQRArI4P1ymjiqibrDhA=;
 b=EFhZzXWoYgCLeW/cPOnvVUYyNJJsnFcQCbrgWvNusdHxeSh0FqqOROvzQjbffvrKxoSG18sDwdyZAnkUYYW+pwAAnCjIb4LuSKgzStuubZux+/OHBGG7947VLZvAPiMvNL4/pUDN0GVaaoxLQnEjO6xTsaiSJ3l14Uk4usPhxx/fedv3LYEwppOLCFQHdMoAiaBrgUzucfibKWN2TbcKIXlL7O218ySo1EOkLq1XFkwrvhDab4ZLRlFtunt256zYudA0LvkzHqZpYt/dR6iVpVuAPnDuj+gaYUK9Pkgm9MhTX6kqRrYg/2pomXDqOhvpk+4TxDL6YdV08AtSA4tI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p87sDpxPF4RQytCwMwx0wkmHQRArI4P1ymjiqibrDhA=;
 b=rQidtBH0hlAvu6QAqq7dAmsM7U4wDP0Ryv2lNB2UCpfH6HJvd4l1/DrloBRgUpejrx4idGnKYot1ABmu7WFLPdZC9heZKf5p2zI32QoJXkTPRR6wtQrxtYAr+G7Jat33Ny6VqFqNxk2f79npMdPTLHP7wjsjtu77oevCLhGdzc3hziY4IqYHyOyxm5tZ57bW3NnMxSeO92mF8x4CVGL9nVtG9fi07oD/55wneaWKpNqWZ+kjQXZchpxU1WicVRFq9YddlKkeToO5AN/oP1wgOD29QfYkiob1/lcfT413qRZOPQQk77l4IDyvOdCWchs9RQ6IP8hRl80GnMrcrxwROw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5527.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 12:46:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 12:46:26 +0000
Message-ID: <1363a53b-d301-4974-31e4-6b855cdc3027@siemens.com>
Date: Thu, 15 Dec 2022 13:46:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Kernel WG IRC meeting updates
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5527:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a6fdb6-e0db-4e3f-9e75-08dade9a60f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z5Uk8ZWD5EwSkXGeluXRjgz2F1OXwC3CdHegfWbYkaNILzDYKqBPVpv3jojfT8gNssFs+RQ1wdxbvYkZvilqhYLXGzl9q189//e0v2dviFZCf4FRxyd47Juu4qimKuBdI/leIBOcO/dpi8tLWQ4mm8itUvxP3qbj4ib2oHsQF3gPeVKaOI8tcASczVIsd+grXJ7q76zxgGjd1nuSg8sDnPrFnEx+h8UpVRVRl9iTSp8HIrsLGsoRCkwQSWovSUtUv/G5OC7Dph98jLsnRzXB5z/ixXayAkZ+TEI4zlKxxOYEWxbgE4Melp+UVVv7IHxDDSayOokoT+tUz7OFvq4gEEucCMIMRKJiJNzIgWPpTQbnR3ZdFcPX3nM285A0A5pvdIYNOJlXrdaikhjJLMdXqodvI36yFbx1AUSIIZGUzaFKPBAycxzKlDWHqVMAgJDE/1yh4PkBTb99rbwp/Hf2LA8+URYQ/aXZepEig8wM/GiJiTFz4zARVZ3mbXSTh7IgWSiIfmDZeokZ7AGwysNp9xJ5wX28ild7dc1LJ9Ft6bkrWTTDh4EaKqlqQm52sgfwbGWqrzq31WIv+fUpzV57fW/NGIgCMeoMwu0E3QptDcPc6aYwmTDvCOvxvq8KkFBORFfTYQPer9i1nM8WRnH1crIEsHFY0IRmnZV+YxWmMxpkWxKWP+w3/lA64byp31Z8PHU644zNiiFehqSaJNeEOHr4rSU8TFJ5uajc16YTg1s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(8676002)(44832011)(6506007)(6666004)(6512007)(38100700002)(4744005)(186003)(66556008)(26005)(66476007)(2906002)(82960400001)(316002)(66946007)(6916009)(6486002)(478600001)(36756003)(31696002)(86362001)(31686004)(41300700001)(2616005)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THp5VDBZQnB2eWUvMmtXWUFhSjZyT3dJTVVRbzUyNGVVc014SDJuV0pCbFpv?=
 =?utf-8?B?di9HVlE1dWJZQUxIQytJNGpOdURXV2tPeXJZUWxqNi9Za3NnQWZDdGpTb1lh?=
 =?utf-8?B?emxja29adGEvaE5RbVNBSzFCTStQaFpJWDc1d2RQOEkxOUZLUWFxRmxSL3hz?=
 =?utf-8?B?TEU2K0lhSmg3ditXam5aK3o1UnJ4U0lFaW5VR2RwcWk1QlUyTld6Nkh6Mk1R?=
 =?utf-8?B?Q0xJYThkbDJnK2RzNElBS0FhZ01oVW5ZOXkxSEg3Q3d5N1JhbGtTMWtEb0F0?=
 =?utf-8?B?L2dWc3lYMEVPQ25oTG9MamFWdnBqUnY5OUZNTXhhZFRkcVpUSzZ5SlFSQXc3?=
 =?utf-8?B?MDlKc1o4OGhOUlZENHpNSC9BTnptdGFNc1paWEVwVk5TSC9yUnNOS0NYK04z?=
 =?utf-8?B?SWhjUTE5NUJoVDhKTU5IVnpuSW96T2R0UUhrd2lLQzZrSFR1QjluLzNEQ041?=
 =?utf-8?B?MG9kRm5XYUx3eEVkV3lFKzdFLzJlWjVkVmNQeW5McXQrOVpTdmdGSm85dGdm?=
 =?utf-8?B?SkQ3SHQveUMrbUNkTjIvc1N3T1BkSmxVK28zNjIwVjdPT2h3QnBKQzJBTlRZ?=
 =?utf-8?B?QTdCdDVnTURqYXk5YUsvallWd29McmM2c0JaeUJUR3N2U3hWbE93ZWwzOTJ3?=
 =?utf-8?B?c2thVnVNaTdyMzAvOVVWNCtQSVlJM1JzZXV3Rng0eTlldXFOaDc2QStVeVdM?=
 =?utf-8?B?OW1vZ251Nk1yQlJkTEJITHByWlVldUErL3dBWHlTM1plYnZFMzZBZkhZRDdV?=
 =?utf-8?B?dE9jbEhqYURuY3l4ZGNZWW5wOER3MzlyNUZEZWJYcHVTb0NZNUxUWDJXK0dm?=
 =?utf-8?B?VXRiZWVyZVJ5Q0hrVk8zOFhZOFJlcUp6WDA4eTVlMDNCSFA0RDdXTU9QUnB3?=
 =?utf-8?B?MzRJQUt3RGRmUHlpZ293UHVSZEZ0aTQ3TmFXOXhmQnBKZGF6bmx4cnNZeGo4?=
 =?utf-8?B?aEY3UFN0U3kzS3JGb2dncFRVZFIrci9MeTZDeVRXREk3empWdVpvdzFGVk1w?=
 =?utf-8?B?Vm1wUjdaQWc1bzBpU0VLc0w2RzBNRERnNGkyT0JJdzRteGRwUllyc3JyT1ZS?=
 =?utf-8?B?VnBkOG5UNSttUHBTVnJHQWRlc00zUmU3dHM5QXhQcnEyNlRmQ0pPNFpRYVUx?=
 =?utf-8?B?cWFVM2FGUUFsL2F4bGlMWlhUSTIrK0tUTEZhYnZXTjVGY3V6RzZwZVBHeGhH?=
 =?utf-8?B?Z3lZRXZOOXAwR2loQ2YyUXVNMmsxZjh4YWZHV0RaMm1xVmY3d2hROG9mYzlH?=
 =?utf-8?B?bk1jS1ZoOVVtNDI2YUlJY21ZZ2FRQ0ltNEV6SDJnWGRlaUsvbENxWE44d3VC?=
 =?utf-8?B?K1hiS1FNRXRaSXd5Yk9mZlovTFJsbmE5QTBKc0Y0S0UwVUZXYlZHTmwwbFJX?=
 =?utf-8?B?cXQ0WVNldFFwUW1vMmROOUJVTkZDbUowUHFnblV2ZVBFMjBKWHQvOGRZcHBk?=
 =?utf-8?B?eHg0bVYway9Mc2ozcFJTaW1JcTBJbG5TWEkrVzY5NnUxc2h1cUpKZUFkSzFh?=
 =?utf-8?B?MXNnN3YwNmJlZFE3cUluOWNQLzhYZ3h6ekhFM0FxRG5JMUxQTHd1MTdiQWFz?=
 =?utf-8?B?QTQvNzh1Z2VZclRpVVM4RmRCVi9Vc3M5dkU2ZW9kcDJXaFRuakl6NmhpVkNU?=
 =?utf-8?B?Kzd5dUE3b3VkcTIzaWI5T25FZ0gxMVZ6NG5jLzZCVUNzbWt5NWcrcm1yMWdD?=
 =?utf-8?B?Yk9hYUg3UmhNM1NwVUdjQXRRdDhhZFNrbFlHRVdRUVZDbmNHQWpVaWVxS2hq?=
 =?utf-8?B?UStVUGlFZi9tVWc1eU5tL012VlB2TTJwVi9Sd041eDBjV1EzSC82RnFIOVVT?=
 =?utf-8?B?ekkxZEtZeERNbG1zdjdRS2RVMi9ZdmlLOVpXeitGSG5jTEY1cXFCZ1NmUlJr?=
 =?utf-8?B?aEFxQklSM1NrQnJGNFF2bjREYXFEVW84U05idGVwL3hwZlBLcFlYa2lPZ0Jp?=
 =?utf-8?B?Q1RXak0wMW83eTdxSG9qVVpVM1JJS2J0RFdIYTFOL3ZNckR6WUtGZ25vRTJj?=
 =?utf-8?B?aE80OGxQWXRRS0c0cXpYN0hUNG9HR1Y4UUdCMm1NVkRiNHpmZXB2M0ZhcVVX?=
 =?utf-8?B?S21SZ3RyRnRXbFJlbHZkbmlIa0UvUGhEN2o3blg0V05PM3Jxa2RWY3hJcDd1?=
 =?utf-8?B?UHN2Y0FxUEJMeHZyRHA0R1pMb1NEczB1aVZWTUs2TXNwZk1GendML3ptQ1Jv?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a6fdb6-e0db-4e3f-9e75-08dade9a60f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:46:26.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jq/at4qaEKxbvpQm/wzSH8LUE6CbdrkqUqCpf69OV80+1GqAFPGw69SO1uCndA0KW0jcZmSbWa7KVDeEJtVPeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5527
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Dec 2022 12:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10233

Hi all,

as one of our regular participants has a regular conflict in our current
slot, we - once again ;) - shift it by one hour. New time from next week
onward

UTC (GMT) 13:00:

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

PLEASE NOTE that this will mean +1 hour during daylight saving times for
US and Europe.

And next-but-one week (Dec 29th) we will skip the meeting due to
holidays in most regions.

Happy holidays, Merry Christmas, all the best for 2023!
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

