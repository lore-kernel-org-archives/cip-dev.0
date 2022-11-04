Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE54C433FE
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 06:00:38 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.86])
 by mx.groups.io with SMTP id smtpd.web10.8161.1667541631156219592
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 23:00:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UF8X+5k1;
 spf=pass (domain: siemens.com, ip: 40.107.6.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+8hXYG4wRazMWGxeBJWviQdm1Ptg/tU749SZS3LXdy/hzCptVlUFESHRaumk6fn0dSfiOvQS+zxrrmSZIb+pX7OMBIfg8nhDs5DLol9lisAlRSTx46FyT7cIIeQZ+QI1YjBmMuRExifPTguh1Yu7bPfgnSiajN+P08wLo9c7R7dWJCUd07iYs70C3rbyUXREpBe3EL9bRM8TFtZuksyapr077Rcc0JwTBlL420IgzNNedD1Sp5Yg7IMw9G6eah6C3/2y4hOJeVeD2fTtWFspll/roVLu10wn4SG+FJGu7lQp9qWF3SQHdQ2WQEwXHhGkHJikcNrOd052k6exvCZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy/6HJYnDi2BoYIhpIxWePRq2uygDGVwghQ8PLqZ96s=;
 b=SNPtkUar0DvcCznISMGAgJzYntf8GVDI/ZLJCLbhEH7YhdF2b7Tw5UjAe7SEWiN4892RyGmEjC6/rHbgBb/vGXBRkXiGct1T+hi4fTwAxsOWQpx6MAII6KCzPOw6veh31xBuUcaSdu+YyeaNJHE1yNH8TYYNcKRiZD/IEHzEVvLZvHMMHiQjdMuwCP2V7bmAqkdydI4X3vXJanM1Z+sybK4FyKMzLQvQGNNWHtfMZ7hiAxSPv2WynAwmnAVVUEsElUwMzEFpxwnbprtkzMq5ntGr0xT+l687sgyEjEWfoBIzNFEhBuqaVq57D+okatbyB5dVusL9qTRrN7I94SrM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy/6HJYnDi2BoYIhpIxWePRq2uygDGVwghQ8PLqZ96s=;
 b=UF8X+5k1vPQxNXdd3s9x2pUMVxQL/AYFEg0UPEz2PQs927ILkcsC+zl1f4yFKwX6IfaD9RRdMMB5PUa7yGKqkuCFwVlnLiWxemeQ1bC9Ggq8fvG21rhgC9V4+tmx71Mo5hGn+r7/ZX+jp0f7pVvHX+mWaEVOR1yeTMtzXQ4j804VOHfhLBz6NYk5CpzANd+7g8XTsa2/T6hOOHVeIJxkMPcfnRr1hwike4AlXnrDHoyBeYilRWuUcEl8ERvUQPp+5xhhggsGOxltGHM5gKqOM+d83EpRi89PZwsgUYx2yrDrP+s+lKEcRxFXDI/+01k6AgTf13u33lCVuubIa7Pmbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 06:00:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%3]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 06:00:28 +0000
Message-ID: <f04e070c-7a7f-a65d-3995-000348898a2e@siemens.com>
Date: Fri, 4 Nov 2022 07:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH v2 1/1] add sha256 fields for
 sw-description.tmpl
Content-Language: en-US
To: peng_qiuming@163.com, cip-dev@lists.cip-project.org
Cc: felix.moessbauer@siemens.com, quirin.gylstorff@siemens.com,
 Peng Qiu Ming <qiuming.peng@siemens.com>
References: <20221104031158.52896-1-peng_qiuming@163.com>
 <20221104031158.52896-2-peng_qiuming@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221104031158.52896-2-peng_qiuming@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d012e8-1199-48be-0622-08dabe29dfdb
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d+VmMKzGQ2jjmYU+xSco6LFmOcHJ75uGxYjM0nxDFkG2QzBjKXzyXpHmsL1KzIujME+f4V11IOzjn+RPzywjfKkM9J17PG6VRiGCQu805Dnvz2EmzSzClY/jObC/yrz/jYsg0w6bcXjqC07dy5TDQzcGzBhDK8yJ8px5n51ZnLZVFu+IKlJIciwT//N946NG3mfj+4dkeAcAe0crrbHY2wVQJ9bsSuMYS5WTZXNDOsBsN3kDLAYNliLVWR8vvT4WDekTIqYNaYCYVB4V1rzwNS9DRdBgP+KCwnL3dLag5/rVMBNFbCgigORIyLhpbhzEkoMVHRDgRMIAEJH9+eE+m4/jNKj8NLsarKy5BS/IusRRTcM4rQ/6uEqS8XIdzxe4sCByDEuI52z18U4J2sru3R9WTS3vz14QEc6D6OMRSFHzQnP6iLxNZtIGd23wxQqM2yhzPthxY1SkSYp5tBbNpFFo1/QUChOgsHUDtf8sQmbZrMzZwntbPFUlongVLRVpowxSvzOoBQ9RZn36vkrBFnY6TZpK9cddELQQkaEFD5/kpr64SGSRJ9B9n7MQRvXLq10tWFbwi6Kd4YOyk9Mi9I+omjBcVPOoSz78Id6CDkXyruiuDrjKJe2i7jt5GYQLIRk5nOWxPVBXDhWY12xuoGgvH+DoDORU8Bfi6Sp2RKKlaumA0lwf1wuyUPxraPQaWNi9IIS6/ZvOaUyoexjpW0/Z/dBCOJblnK1Q7+CF/ppKPczns0VUIeftMgvNVyuDc/jl3uQvkQ6YECoBV5/kyO9Ta/Fu8OogCmqBQPDzFx4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(66556008)(66946007)(8676002)(66476007)(186003)(4326008)(316002)(31686004)(6486002)(5660300002)(478600001)(2906002)(44832011)(31696002)(36756003)(41300700001)(8936002)(107886003)(26005)(53546011)(6506007)(6512007)(2616005)(83380400001)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SEhrcC9KNUxjV3RjMzRiR01nYS9jK1lXUlV2Y05mVWdsUVRsMXFhK0NMOERH?=
 =?utf-8?B?ZEt6Z1o2NmhUN3hGQWJvdEJNc3RHeFg1VW5SZXJpTE9lcWlHbzYyNzFoUjM0?=
 =?utf-8?B?eXptdjIzSmxSei9EWmZhUGtpMzRMdzBmWjhBY1BoMWtPUThHL2NQNjF2c1R2?=
 =?utf-8?B?WTFhUHJhaFBnTStwSlBuZlNpQWREcXViSGNRYVpFSktaS1c3VGNJWFVZeGpG?=
 =?utf-8?B?N1dkRmJWQjZOWU1TN05OYytkcW11dXVPT0FLOHRyM1ZtUmFqdGdKdENCcms4?=
 =?utf-8?B?NnlqZnlwZzZEU2xDT3VBSjJCQVlUZUV1WlI1QTR3MUJ2R2w0aW5CckxvZnBo?=
 =?utf-8?B?MC8rckRoVjNrSVlHTTN1dXNmK3k4aEZCeWoxRXNNc2ZBMjliNGFZL2dpV0FT?=
 =?utf-8?B?eFFZREJLZWdONCtkdTQvQS9HSXdVUU1pNXBZMFJGcXplYVpRKzltaFIzOFcw?=
 =?utf-8?B?UzY1amd6R2FLTi90cG1renZxUlpPQWp5bEpoVWxQcW84YWY1dWRDQXg0TC9I?=
 =?utf-8?B?bnBvZy9VbTB5UFlqR28zNmJyU3l0eStDdkJCeVNTek5lc3ZMaThNMlN4dzNn?=
 =?utf-8?B?NDB5Tnd6ZXhmTlZMRlhHV0VtTkRrYlZueXZEZEtpbkkxUk0zelVLN3NNdkFQ?=
 =?utf-8?B?aC9HMURrYWVIbWF2YTF5TGVxYU51ZXE0VmVEbHMyQVJuYkVHVkRrb0J5UUhM?=
 =?utf-8?B?YnpTOTRTU1JueGhDbEwxU1VuWDArV2xKaHZnN3ZVVFJiR1lnd1preGU5K0R3?=
 =?utf-8?B?ZkNtaEl4ZUt4OVZyYjcwTURySDlvY3NRZTV0Wm9Wd25EYThCdDdDNWVFTDBy?=
 =?utf-8?B?YU9WNlIvbHp2Tm4xMTg1RVFVOStkUE0ra3A2YU12bDAzaGN0SXAxTjEvQ1Zp?=
 =?utf-8?B?c2w3bEJjK3g3bUN4Vm0zUldQTFhoZ3pSUW9ncFNNbElWNVNwaFJrUlJiMWtm?=
 =?utf-8?B?a2hQcVA0MkhZY3VWN3M0L0t2dGo0aks3ZkF3b1lSTVZFM0duTlZGWG5JeFEr?=
 =?utf-8?B?YlF4VllFY3J3b2Z4VDdDbHVyZ1VrVVhiZ2RHVjBNSWo3QVBzVUt3YmludG1s?=
 =?utf-8?B?NWFobGlRTWlsSUhtazQyY1NmYS9QbzltSER6OFVJdGMrWFIwUGl5dU0rL1A3?=
 =?utf-8?B?QWlsdGpVNllIa3IvVTRyYVhIYTdKajNXVUVVejE3YTJ4K3U2SmQvMExNVjg5?=
 =?utf-8?B?USsyOERaWTJKeG5wYmNUVzBkWHlWRzVEYmRzd2I0bHJoR2w5Y2hiSGtrTWZT?=
 =?utf-8?B?V2lvZjBGYWM4Wkh5QUpoclliQldLMklaRXpNeGpDUUtkOVNtejQyQlA3MkZX?=
 =?utf-8?B?VlBwRDFaS1ZsRXBlQkFLaFNjRE1KMjNtYkxrbFpkYjNWTzZJa28rTllFdFJk?=
 =?utf-8?B?dERVZGNhclpKbURpdmJGbzVSQlRVSktXWFdqUFNqQ1NsSXRjMkdvekxBQ3FI?=
 =?utf-8?B?OVltaUJ3ak1SVDVMZCt0ZkZJeWwrOW85VEx5M3R1UldaNmNreWpRWE5qUkR2?=
 =?utf-8?B?dWpNVGJaeEQ4TXpNUjV6bjFmTkRPaHF2QWZuVXIwT2hNeW1RUjhEVlA5Yysz?=
 =?utf-8?B?U2dvbXdCOXcwYktuZFh6KzZvNFJIeU9UNXlvK1BXbGF4cTErR09icXRZRDZ2?=
 =?utf-8?B?Y29odnpxNW5Pbk5uZ0tsYXMxMkpOMHVidzQxL0NmeStBMUZwaTF2NTdzVjhn?=
 =?utf-8?B?WG0veTluYXR4NGw4VHBkblordVhTWTE4WmhmdDF4RXd3TzdwQ2hEWloxSmNT?=
 =?utf-8?B?bGN4TFQ2VHltblZrZ2Fvd2RPUjlDamgzUGJmVjVrZVNZWmQ5VXZzc0RicHVp?=
 =?utf-8?B?ZG5zWTVhdkt3aTd4QThxREFTbER3QzN5eFo2eVVLbHhkSVNTOVlzd1RqMWxM?=
 =?utf-8?B?SDRiY00zMFRVR3BCOEFybXEybkNWZkJNM20xY09HRStQRGtnT1Rselh3d0l5?=
 =?utf-8?B?NTJBblpoUkZ4UnFuOUpKUmhPZnVGaEx4TUU4T2YyVDBxSHBRVWtiZjI4L2lL?=
 =?utf-8?B?dUNHbzVuclM2WURTTWZiYk1iN3FlSEsxOUF1cW1pMmNjVzJTcmFCK3VXTWVL?=
 =?utf-8?B?bE5LcWo0bitVWVVuWSs4VWNqS1RWMlhTL3BHa1gyNlExMFVOQ3NKNWlSTVRT?=
 =?utf-8?B?b1I1VDZYcW1EWlJCSFpRZFM5Nm10UW54eXNiVTVjdXp1aDdUeWNtZXZmVWNl?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d012e8-1199-48be-0622-08dabe29dfdb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 06:00:28.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWWlejCh+iVmVt7MeIEqIjBVKf9fq6y5kFn7/7QyoeNHv4oooc6zBp/e6UR7vagCxLz776gW48U6pAVL7/g5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6345
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 06:00:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9922

On 04.11.22 04:11, peng_qiuming@163.com wrote:
> From: Peng Qiu Ming <qiuming.peng@siemens.com>
> 
> isar-cip-core provides signature function in swupdate.bbclass file to support sign swu image,
> but there are no such fields named "sha256" in sw-description.tmpl file to support that, this
> patch will fix this issue.
> 
> Signed-off-by: Peng Qiu Ming <qiuming.peng@siemens.com>
> ---
>  recipes-core/images/files/sw-description.tmpl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index f5cafeb..1c0db02 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -21,6 +21,7 @@ software =
>              properties: {
>                          subtype = "image";
>              };
> +            sha256 = "${ROOTFS_PARTITION_NAME}-sha256";
>      });
>      files: ({
>              filename = "linux.efi";
> @@ -31,5 +32,6 @@ software =
>              properties: {
>                          subtype = "kernel";
>              };
> +            sha256 = "linux.efi-sha256";
>      });
>  }

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


