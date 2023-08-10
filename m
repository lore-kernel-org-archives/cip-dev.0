Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7869DC04A94
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 06:12:04 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.43])
 by mx.groups.io with SMTP id smtpd.web10.11653.1691647916446970556
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Aug 2023 23:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qGR33hSK;
 spf=pass (domain: siemens.com, ip: 40.107.20.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENd3fB6/KyuLLuJc98fXJVtKkrWVJbe0X53/T56RIlDf4pr6EKSjc0fjJTmwblJMrVtkMD6pfIJTb8oK/Jcmhhny6xypNjn4PD6O7eEszJT6lVll4No6iYpFzWFXYY0Cl6b0PBl52zUIE0S69wM4q9tL+O+3yqfQJM/GTkR1dv/RQ6noR9AdjO6h5cuA28+Je69QtcZQ5J5shdOWhsT0KmHwWF0VU3R0Oam3+kcqmk02Uwn31mBqw8knQapDJwZDMjrrd69eTOuRjFp1Qg6zCBS+v/qNZlmImwUIligYuGDfb10F26qbCiTmqTDBEvFSa7RFII9MofpB9N5Z7mG3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIw+++AaNDvpA8itmiqCcVSThakHDYngNXR0cUcVxmQ=;
 b=YzPPykXiH63Ej1QAr7JYRiejqzTR1K2pVuWdwv4yDiVNPr2Qn5ZNhDXG6M719u4GISAcNVI3RzYMCC3MFtUep86jgET1zmj1Z7H6f3t/nm15QnVSrFlSC9p1tlf35eWaWrqy5J821clmE5VW75HpWFNqzIKm6m7vpO+2QitzIdV7qpOyprMsfWEGD5a++0ufS3nvFBQw36UIujAC6eg+bCkwXEINuxJOxyIsJ8PTH5gaGhZ6fP/CafghMsHg6GaQ5VHWWHywoX4UoBHdoKspKC8LGv8GlM7YaxdwRWX1vpOMa0e7ouMvMPUYA5J5fj3tQQonMpsFBoyuvvefS1apSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIw+++AaNDvpA8itmiqCcVSThakHDYngNXR0cUcVxmQ=;
 b=qGR33hSK77L7XFL9BExumTd7uXrfZIKTq68cpgYCIgL/PQhvIskgRsShmpneslvnHvWP/khWLgO6wlQn8CS4dlX+4PrVVgSxP9/gFR/l7RzlcPkpxxGwnMO9yK0Mq2yRcKpWJ752Cx6MTe0PnTt7gAK1orCgjXoganZZ1S5s/POm2SpahsTNbqXVeCgl3u0E9HXoOHaqaCtNteS388FxZmJMyojZTKnpHwkvEs4fltSIeC6BKSgZbP23iZIS+G/k8p7zr9r6Q3DT9PKRZJZUHGxoPqFllx00+k1mqwYVuReam7TfVEIM3ztJG+GHKx45dgwPcIndnVt0TVFxTsTMyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 06:11:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 06:11:53 +0000
Message-ID: <fd48d401-7106-4643-bb5c-3253aeef5b10@siemens.com>
Date: Thu, 10 Aug 2023 08:11:50 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3211:EE_
X-MS-Office365-Filtering-Correlation-Id: cac2d254-32c9-4223-dc7b-08db9968b14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n4MFdC618guEFmAS4FZ+ycJTnlIB0y6aXxFKj5XLdhEPqVUBfUvqu1vUHAahRugWxWWsyxtgtmIq9YVnaNoO5uSWzfvkitNhjXfKsLjmW163nIW32JtcoeKoSCwbaIqXb0OZ6j/6xDIGFWRjrdIG6yvOOLQWI0eMfaa5pXQHS792tbAKNid8A4WBAMLPL20KC0q75RfeBsEAY1GZFrZ0pCBOc+dF/Kll8Vn1TA4IDUmAivjb7DvVyukcqndhLm2oUBPuWPUst0puyOXZp6V7QUzZNKFs85s+lN8oNp1XmbpICMHhgS8pOaVX9B7R5nJsYz/Sr3x9GffhRxWitwqqGWV+xcwRPhQy597AkWu5VF8CPymbjKnD38StdED1HTEdjmAdPzpvHi2VRMYrJ5QfoSoA1xd7ZkNALN7sWBujw9F1NS9G28yKHI4+l3VtXigK3Iw7ASx95Ynt+mVM3IX4lKxoFffJHwcOwyJ4/dPp/OArgoggTy1BAGZYud72GSqNXN3ojEi0St8H5MOTGbPE7CcfnKgmLerP5cHGVNB3DM83/L3FDpprWhSQbws7M4AexRFoLZKM1mghE4nZdeDSMtdLSAJqtlKssczIeIV4TcOla3aEnUXM8GIXw/AE226Gat9NPxzW0I5TMsMX4RLb0A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(186006)(1800799006)(451199021)(4744005)(966005)(8676002)(2906002)(31696002)(86362001)(8936002)(31686004)(6486002)(316002)(6512007)(26005)(6506007)(478600001)(44832011)(38100700002)(41300700001)(2616005)(82960400001)(6916009)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0h6V3NIL001OTQ3QmtFTGZEOUhtOEM1Rm16OHc2QWIzNitJSkIxQ2pEODVD?=
 =?utf-8?B?dVNqN3JKN1lldC9DSk9qSC9zVmZDWFJSTnc3am4xMERDVDl0VXV4SFBDRkds?=
 =?utf-8?B?dDFSeGt2OHpNNU5jSk9iNDhWOXRsUXBUQ2VCV1BvS2Y0bzRVT3NLNFBIVEk5?=
 =?utf-8?B?VUIwWXNvYnZrdTJTRlRMYldSTUk0OWkzOENJSUphaW1MYXM5c1pzR2drRjQ2?=
 =?utf-8?B?NFBVbUZYdVUzbk0vVGxiRWZvNlNGcTRRUkRYczA3Sk9TZGJEMytHYU1Bb0VS?=
 =?utf-8?B?Y0pOaStzYjZCVldiNkxnOHB0d2p5MzBtN09rQzdxSlVNYk9lQ0VpaGhrcUVE?=
 =?utf-8?B?V29Vc25xbWtyNmlaK3NFeUlURGwzejZUVXJKODV1TXZLT1N5azJ3ajhXK2JM?=
 =?utf-8?B?QVBvbzNZcyt3eWx5OUluQUNrZGFsdFk3c0dkRTVEazZIcmdEaWhMS1kzV0th?=
 =?utf-8?B?VEIwYW9GODBBUysvd3orUlVmTzBMaThZNzVGWkZSSzBZMlc2LzhRdjJ0NE9R?=
 =?utf-8?B?R09uZ2lOdkg3YW9ZNnUzeDUvRVFJK0pOV1dkZCtYYlNyVTgyZ3NUamZzMUZO?=
 =?utf-8?B?RUZMSWtVZlpuY2dJK0x0bUkxUU8xUDdkWFFyWjBJYy84N0J5aVM3RnBhMG1X?=
 =?utf-8?B?dlR0M0dqTXgrQjM5WVNkV0MraWE3MERnK1c3UXdMY01kKzh3NGtwcU1OL3hz?=
 =?utf-8?B?ZkI5bzl1N0srUDhPYy93SEFIVGhmb3JiTzhsenoyeDNuRi8rMERTU1pDVnY5?=
 =?utf-8?B?VGhGTXk2WXI0VzIrVGM3cWg4dVQ1bVpjRnMzS3JrL1EzVkxaVWlFY0tZYy9J?=
 =?utf-8?B?VnhmV2NzMkVrWEN2bXo3dTlyMmcvYk9BbFdEa2tIcXIyOXVTckJUMGxZQkFa?=
 =?utf-8?B?TTk4UWgyWWIvMStsOHNrMzZrSzN3RkV2aUlLbU5WZ2FMaHJCdWt1bmZQVjRD?=
 =?utf-8?B?ZmVxK0lNbnRSOGxqVEhMVkhWQW5MSTRwdlJ3U2d3OHdNb1BTNmJFUkNoTW5M?=
 =?utf-8?B?TWxWeXcreVF2TmFKcTRwUHljQmZtLy8rRGlpTDUwa2ZVRjNlYmdlWWl2V1lF?=
 =?utf-8?B?YVFZZFpFTERQVlBzSnBLdndzcUUyeUxKSHNhMkp6amYwbUVHMGRCTzA0NTIw?=
 =?utf-8?B?SkZXOEQ4d2RxS2RURUVvcGxJMzZNOVIvazc1dk1VRDRIaiswZXpjWnFCWk9X?=
 =?utf-8?B?QWQ2L05JTktxYlBFaHRnYmZrcW90SkdQWWxhTmdmUkVTZXQxWlFjSlhFc1lR?=
 =?utf-8?B?dVlBb2VNOForL1N1MVo0VEY5T2lSRmsxSm5pSVdveVc3YU8zNnBLbkxLa0hE?=
 =?utf-8?B?SDJWMW4zMWI2aWFlTkR4dzExQ2hsMEhaVm1GTkhwejNHU1phUGdBczdpSndD?=
 =?utf-8?B?aXB0N0RwSkdTeVZNRWF6eW9hSVlBUWxRTkhsQk5lMklyU2xKRzBYNFJyQWJl?=
 =?utf-8?B?SHozd0ErVDB1TUljVDFDUGZBejUwTm1VODQ1Y1NTby9GSSsvdzlXVU1jT1Ra?=
 =?utf-8?B?QVp2VzJoNHYva3c4MStVZTRQOUk0YnFaRml5c1BVRGhIbE4vbW5PZ1VUS0lx?=
 =?utf-8?B?QlNXVUtlU1JsemVYWVJVTkhMcDlQM2NxemNDVW5SWFNIblFXTWlMTHpKU1Fy?=
 =?utf-8?B?SU56dEZqRHhNbDJObS9yWEdzam9vRGtBUXZqbGhsb0dOalpnQ25vWkg5T2lx?=
 =?utf-8?B?dlhac2hXVCt6WTJFUGhwREVVUXQ5cWNNZHIxdDZqYlZUYWR4akpmZ2JGL0d0?=
 =?utf-8?B?dGpiaVUyUStoN2ZGZitSeTR4NlU1UDl0TXpFQVpFZllwNjdlVHp5d1EzWUVx?=
 =?utf-8?B?L3pDbC93dmNaTjE2eDV1L0VIOEIrekJYV3d3MktVL0xlT0NDdC82UTNJNzhL?=
 =?utf-8?B?Y3duaVM1MlluZFFOTWcvdStCbExPTmE2T1B4dlNBcHQ5ZDdldzgvN3c5eXk5?=
 =?utf-8?B?aVpnZ3VhUi9LV0NqWnl5MTlXQktUUlIzaHVFU0thM1ZKVzZ5SHFlaGlDeWJY?=
 =?utf-8?B?eStUT1RvVFJMU0dGN2t0TFVjbWV4RGErZ3U4NmZxLzYwejd5RnMwZllMb2V1?=
 =?utf-8?B?NEZZQzVKUGdOQmxxY3FIZVZmSE8wdUpxY3kzVjcyZjJBUmNFRVBRT29XVEhn?=
 =?utf-8?B?eWxCRlBzTjR5QmFkTmF2S2pCZVRRTldKckRqYjBvNkkramwrZUE1cWRGbmUz?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac2d254-32c9-4223-dc7b-08db9968b14a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 06:11:53.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftGC6wrk6w2V3Iagx1o2L3UJG6y8H2WQF2lJR6k9tJCikIps+b3Str4O6TC683tzdfkcYLESz1xH7vxzw6KQZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3211
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 06:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12588

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=8&day=10&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/08/cip.2023-08-03-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
  2. draft press release on 6.1 release (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

