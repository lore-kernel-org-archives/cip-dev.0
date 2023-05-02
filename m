Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9E5C77B73
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 13:09:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.78])
 by mx.groups.io with SMTP id smtpd.web11.128061.1683032930613369836
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 06:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BpA9y4bZ;
 spf=pass (domain: siemens.com, ip: 40.107.22.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haM6c81KQEiXs0pThNA693u0KsMs+gHYwLoLVaKa7rVorSHtMuVA6VzX3XxzZr+y2tCDJOvz0POhSfSm6M8i6OslYaZU+DMe0yFYtbmERw7mBiAlloPhv+XiCt6Hkoy3fchJ2ZEEURdwelGLTr0s683c6A18QjTPfk9XhfsfEqE+kizQEtjVs6D5l8MWgWo05tVFWavLL0D/4Aelz+EwmH8WwnWyhLbHC/8zWVmYH0zgAzyzBweylRqOKGm88BDlbqv+UlfAIcBjZUjBv7eMpVY4tCBUHi/GmkUeMna/yxhURNGg35Fw5MCYzccuaAwnuRTZZ5oeweFDMT+OOCiAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z163RC3eDW5w8kY3Gn/PsHXQFYm9I3tThNmWarqhHM=;
 b=AlplX4bi8PSozoLxBPWXj5gXUFuF08mnYGOE1c1Tg9K7WS93hYstE37sih58ZPn4bVQqf1ZOD0C6GDddh265wwLaM25Eoq0GCFQGq8gjYXRuy6m5Doe5igkOnL3ccks8M7uvfxsyv4TPwgMWjOcF6Y9DlC8P8XJ6K/H5JH/CtBTyRI7zi38bO8nXwdHNuJnEAVL3gb1cPQF4ivdBqBerwdIrKEY+9tlDu3h9Bq/zI7nd6AufFM5puVd9/AwOJ1bqhV6zXdFiZoZay+D1vj1DO1w8c3vrLhAb/dYN01wIeihpA0wxMmEHQ7YHvCrf7DcPMIFuQ62Fs2qPua4VXAW94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z163RC3eDW5w8kY3Gn/PsHXQFYm9I3tThNmWarqhHM=;
 b=BpA9y4bZH+PBjJvvETo1St1XbWGjtW5w4UwfhmiBTm4KgVH51R+9Cah6w7kkpSGAtoPkjXW6GvFKG96TP2Op3UmmE0uLjj3p7FkZUVSOQmCrIveV8AOekJHQNJSf46FaRv608tzJI+ngeRep3Vqjb+RI7OY59cmrE72PvODM+jOi8LlNzFpqwXsae34fczZ/lTChKW+r6zmAcgOlANYPA4xUIlzpcNwxtPdewVWAG1+Z3k4wJG9hxtqiTJRTV5KyGJuSyJQLQU+1rr0+15oe/cCItLD9i5taKQm/ePXhHdKb9h9t0zvVVT9/xjX/m81q0dm+nNkwyFgFQvC3iWJtMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5579.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:477::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:08:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:08:50 +0000
Message-ID: <b4701d13-bf68-25bc-eec0-45abfbe6ea7a@siemens.com>
Date: Tue, 2 May 2023 15:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] ci: Mark riscv64 job with allow_failure
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0105.eurprd05.prod.outlook.com
 (2603:10a6:207:1::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: e51bdf78-1297-49f4-aa72-08db4b0e5f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uwV3Or3ge7aNZp9OiGzO81EUb0upgRT41sUNoZjwce+XXBkeNLX+4vavFibuGN0x8e1Vp6+7sA1KkyGA4vBB8ZK7Fdo5XaVb2O/6lyyzHluoWrhimBZk5ygmxDd3pDxbY6UoGFQt7qfbb1QRu8OravmZAgz/58LeV5jB4f3QH9A1uUeTh9zmFUS0DJMrw7kKS8PiEvR0jBPNSdkTlW+NhKYKhM+pDRFhj4/PW8mb7MJMPXryHm20UrGs61KyZQbFPnJgcbG0CPGke4g5PUELwnCeZyY65wjdTNVX3dF+nuGquD4dN9C481f1GKBvY25BkkL86nBdvndhyTo7Gn4oeb8xAiwAO2tA/Qf83SLGMG2GbatnmmP7ZMcpZRE/nNbk3NrhhWHFMXsoKoZxnbsSeFK95Sy+RKeXRsPfOLRWVvK3WsMpoZGZFt9myMQNUD9r4wnGPlPn4mb+d/+T8jVsR2eVsZx4Sc2sfm9mj0Z0OfS+Hr71nGFWYrW/FSN0MqN2I1Ik94h63U+Cive0TCjyykV8HXHp864o+GMJTf1+mrScCrBQAUzw31v4ltjqV54GSiu6lUpY8mM4rPpOkrFvwc3SxqyvMo998fIgHgnI8ZesgaSL1CoeJ5Io6E/Q87sQWkRDARgH73GBja8Ix8Vw9w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(2616005)(83380400001)(107886003)(478600001)(31686004)(186003)(4326008)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(6512007)(6506007)(26005)(316002)(8936002)(8676002)(5660300002)(41300700001)(82960400001)(44832011)(4744005)(2906002)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2RzdUVzaWZiamt5NS9RYTROY2IwdVhtUnVtWGJPTUc3TzhONVVZMTRnblV2?=
 =?utf-8?B?RTBNMUhjbEhRSjJVRS9mTVBFbnU2eUxOYThxMnhHSEhqYkhHQVIxQ2d1S1Ja?=
 =?utf-8?B?dFd5K0hBUFdCdmRpbTh4dG5ZZGxzRkhNOXlITXJubGpxV3RSZ25aeU0zWjRm?=
 =?utf-8?B?SHYzendqaFBDNHBSYW5OM2RqZkhZWDhFWVJyNDQwNlQreE9ZNk9kMUNuclk5?=
 =?utf-8?B?djYydEhBdkwzbTlHcjdaclFsaFBUamtiSjJFeWw3bnZxbTdvMTh3QXBWcnNN?=
 =?utf-8?B?c2lZb0VDM3pCZUdqVkgrWGFwOHhOMnpsVElib1FsN2dXRExteFpKaWRtZmhO?=
 =?utf-8?B?UGlsd083WVlsOU16RGk1ZDY3STByMEU3bkFWdlppekR1WWdsQWtBR2J5cFQ0?=
 =?utf-8?B?WGZYaUs3bVZzbFQ1QzltR2xpR3k0S0M1WFZxQ1dJN2VTNkd4R2VxZHo5TzRv?=
 =?utf-8?B?bGlrdThKWlp5MzBQbDZmYjZhVHVha01PMDEzWW1UMnViMEFUS04wbXYzd200?=
 =?utf-8?B?TWpJN25teUpSeW82Rk82dmpLdHhVd3JYRHEwLzEyMlBhUGFOYkk3YVBsVDNT?=
 =?utf-8?B?S1Noejh5dnZ2QWlpS2xCVjRQUGpsbzdQbmRBd3QzNy9YMzRFTHpmK2ZqWnVW?=
 =?utf-8?B?OFM0a2hYL1VjWG9TR1NOaHZqK2pHeGdiVVZPUVl3WFlkekhkN3BBN1REZEZn?=
 =?utf-8?B?WEF3L1QyemxtemFHUHFxR2lxaGs5OW5zbjhPS2JOOE1RTndSaXUrM1F1VzJl?=
 =?utf-8?B?ek5ZNTAzT2N3NmJpcFp6TEZ5eGhKWG5ld2gwWG5YMUZpYVpoZWpKQ1FvTjhP?=
 =?utf-8?B?MTRxajZPU2IycVgrOEZOd25EM3l1UGNxMUh1NmRFY2NpZ1NnaUxXY25sTHlI?=
 =?utf-8?B?UGhxUkM5RmNBQXhrRGhmOUc1eDU0Z29INVVwY2ZkMVpDb0ZPTUVKZXBOWWdH?=
 =?utf-8?B?WGl3Umlma1VvTDZBZ1o1d2RWQmJmci8wYmljbzdLTVpabVBjaU1aL25jdUh2?=
 =?utf-8?B?R3oxN2xqd2xJU0RGMWtGV2Q1dGtiamEvTW5NcVFER1hIdlBqWEk2OGMwcUI5?=
 =?utf-8?B?MkN5REhjenRnRkpXRlh6UHVubEZxaUxsdzVYQlBNcmpOMGd2STNjRzFBUUo2?=
 =?utf-8?B?WjFRb2pyeDlyWFcyS3VKTERJSTN5WktOaDZFNXd1dERxbWRPTExXdHZZem1L?=
 =?utf-8?B?Zm5CS1dnMk5aeGd1L0tzZ2tDRzI0anovRUI3ZmpWNERscGJONVRHWmNLMVpM?=
 =?utf-8?B?NzNRdEJZcHF4dWNGUDYzbXgyWUNkK1ZtRU96S0VEY0ttYVNDd3pDOFRQQm5r?=
 =?utf-8?B?WVUyS1dLWHVIT2xkMWtLZFdqR3UyMHlaaU4xck82VmVNc2JZcVFJSFVNTEMr?=
 =?utf-8?B?cFE4NGdjc1ExWFAwb0ttaU5lWUNjZFBoUnE0bUg3NFVOSzVJREUxWll6eFFV?=
 =?utf-8?B?NkVpUkJpeXNvaFhMZG1Hc0RGNVBOZ0lieGxBWXovNTFLUmRSb2M0Vmw5SWtr?=
 =?utf-8?B?QzcrRi9ZNENDU0JtaG1BYnA1MER4enpwQWt1WldEb3JjNVNzUjk0NWQyQVF6?=
 =?utf-8?B?SEttUWhtS1lsU2hZdU9ydzlzTlRWVFlhU3ExNXByVE5vMSthQ0twaGRzNmhL?=
 =?utf-8?B?Q2FBSWFMR1dXUEhLK2tBMGhnWTFzZWk0dk1VdVhSOXp2MCsvdUxUN3d4a212?=
 =?utf-8?B?UzEzUFY4VDkvREVnQndDVjlRMzhkU2NuWUxqemMxbzFvRGhhN2lrZ2wzek5w?=
 =?utf-8?B?RVBoWlJEVFN3cEg4V0ltWlpYMUk5R0l4c0pIUDE3NjRiL2ErRklYMnFSbVph?=
 =?utf-8?B?RHdiK0o5ZWFpRWxVN0QrTGp1Tkg2WXdnQWV5dkVWVFdrdmdvZDJCUE1mcllP?=
 =?utf-8?B?RmxIaE5kL1VOMHB2ei9iYm1rN0E0Q0Q5ck5Kc25HaWN5Y1haWlcwOWFaSmtX?=
 =?utf-8?B?dXF4VDV1UHlISDFOTEhja1NuSTI2R1U0YkxlOWQ5YXZheXRJdUd5am1TMk5B?=
 =?utf-8?B?S09jZ1loOFBzdHRQMzFWbGdORkltYU9jTXM3V0NXdHNtQXFkSUhNalZMR3Fk?=
 =?utf-8?B?Yk9IOG9LQnhtY09LcS8vdUFsU1BlalJyL3ZrVGZNRVVFRkJ1SlpJRldFOUlr?=
 =?utf-8?Q?trJ+wSzy1weURdjuXYSBV9edw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51bdf78-1297-49f4-aa72-08db4b0e5f2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:08:50.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRrQmrHZEut/U2DJzQ/w1v482P63fG2UzeuL0PD16vAmAZQDlrUigLjo5apLXFt/RkctDg0tUNP7rUTtDqS6lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5579
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 13:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11376

From: Jan Kiszka <jan.kiszka@siemens.com>

Pulling packages from snapshot.d.o is very unreliable. Mark the related
job with allow_failure so that it does not break an otherwise fine
build.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 09b63381..8f530a44 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -324,6 +324,7 @@ build:qemu-riscv64:
     use_rt: disable
     wic_targz: disable
     deploy: disable
+  allow_failure: true
 
 include: '.reproducible-check-ci.yml'
 
-- 
2.35.3

