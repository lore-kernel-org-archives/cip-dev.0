Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B84FC54EBD
	for <webhook@archiver.kernel.org>; Fri, 13 Jan 2023 15:46:26 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.57])
 by mx.groups.io with SMTP id smtpd.web10.90665.1673624784201972418
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jan 2023 07:46:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oYVms3BW;
 spf=pass (domain: siemens.com, ip: 40.107.247.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJEX3eRc00hadzoqwFxMy0DMAluWHDZ1iYpgZtKtC3BunLwKkzxzyAzWObiznuTxx1cRJkefhZFjS0AmfyVMXVQfazSCZbwyVNWSFVMj9TTzN6NzokJD6i3c8HWLismQpwYMzM1qPIR7/RjKp9ZclPlodQuzBmV04CXPb39UZss145qhAOrnQDY1GZatSMyOfA4x23Bb1mFGcwCJppxdsXxGQJZN/4AHSgi2olBhUzOSuDT/TEGltUFy0gCg+Mj+02CqwRsSPDh1Nj2PlYGU01rps75zIIF14AXWOnGaY/mxyu5vmJAmPzJdZ1opGStAKq24pq/GSnvs9AiwuWLS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKpr8tk2mtjxQU1EUMzu+iMAqNz7381Ws8in2M7aHYw=;
 b=KiuDwcs9dvlkpYdPIhoI/6/LsU2qXxrHbIj6maQvm1H2+OX9VsYKZLBXZyzdJ/6AxTX+LtxAeNaT80lWmzA0QCUQOHwBNTJugPM37x6jSK/We6phNKhzX8h9zwK3DNc/TkavOR+LfiQPNJN47/zkfFJZBZuIKY9Hl+9wLxEU6iY2yg6i6FsW2jKbWV6kcK7t7sX8fXhyK5DzoEultti6fW5VaOQIhyRHgJuCrGWLZIcOgt1uHNDOfNy/6PQPpVUXgcDwBBjvyMgD4uocBaTnmYZcu4RPX9ExAkwtbSxgpo9vTJ/EMmmeZXxRja+C4vicOrULNRwMbb3rPc5hxtDUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKpr8tk2mtjxQU1EUMzu+iMAqNz7381Ws8in2M7aHYw=;
 b=oYVms3BWl1+qFUvuck8/Z/iEuKYmLdAJRErsuL7fhzSYhVWW97XZHEgmBooqeasZrMl3F7dsfYag5dgrQL9tSQ/+2fDrdSxANdMwWwP8U427Xrj43leN6zFR2emLJehURaAYX/DlvWrfDSPmWJYybTkAtiJWNGSk59VL8za9lGXD/ky43Ga2MBFiqioI3LyNvhPEqp6kVny1sXasaXkczJJ9k63yzRsi3dEjTJ7/OiOgSwy72g2jb7yPMC0IDm+KAzkKfi0GWTbvSyQuSRMaERkC1FHopvkcynLXPA6zrweCATrhT28iow78iClmNbRW7PfgZQrtdiWkvNZkjTemcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 15:46:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 15:46:20 +0000
Message-ID: <1ea2df85-27f8-9b29-ebb6-bd5e98cdfbf3@siemens.com>
Date: Fri, 13 Jan 2023 16:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Need help to configure gitlab-ci for building isar-cip-core image
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 "Adler, Michael" <michael.adler@siemens.com>
Cc: chris.paterson2@renesas.com
References: <OSYPR01MB5542EA0128B0A2ACBF60C686A4C29@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542EA0128B0A2ACBF60C686A4C29@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0410.namprd03.prod.outlook.com
 (2603:10b6:610:11b::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4254b800-a3ed-441c-fb49-08daf57d50fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CruelaP7tkrsu+WxZuZi37CzEQbeA3D3J/7znq70QCKo5lLsIgz5NnlE3B7B6Y9xJx9704Z4tHx2hR75oVhd0fxWpqGhucx34sfrrSwpFtokYa5xY36X/I0R5JzMCXjOFd6Djw2PgVPyZQCSoNaUjBxrIigu33kiZQh1Aq23tmEYPwJaEE9FBK/uJsJOG7gcrmtEXQxbgIVnoyrSqR0NRDrQGFyRicYZOyoJt1JfU/sgmpI4/AhJSB8iUXkro5MqJveRuWGUrqUGhGPWTce/O5MFgrKlWwrw3KqGu2jXejKR4Cg5d2el1yDdqKP/BjKLsj6Amh0ZulLijOMXtv2W4qQ44tbnIyFFnJ9u4hQ1Z//dCAcVBZh2Fs2WbRRSSnvAou1n/d27dpBw3IW8UOPlbGvaM2oSHbW0F7EI5bl26nD/InbD/JpWNre/ax7iyKRGW7iKUMaxP6mhyCrn6AVZaz+q9pkr+bqDbuXFJ0/OHom7eBuAWGNEIOUZtyEXq//aK5KbwO2cOfGgJCgAFZMOiKe1lYSj9/imJbe4lImFv+TMYa3YRK1kk8ReiNgoV/efkmn0sK60FIKFZ0i9YuPThI59z/dzDRhIyuU0sE3diey8FdV8ihMLFnD2aOR9NopVtZeMW5SR8aEfnc20WadgfCdbSeYDGzeNTWLfz5FCb7d36B78ey3AokbQQtKtabzHTzW9YOD7tIHWJtm9NIY60nQJibwzSz1jIim02mghpgOL970giBgyVosE4LCRvCfBNJkIluMedKjIS44AEBkPTEnpi3TT2lSQl7zKDumwhh71YJoCKZsG/XUptVpYyQoh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199015)(6506007)(36756003)(6666004)(2906002)(5660300002)(53546011)(4744005)(44832011)(31686004)(4326008)(8936002)(8676002)(6862004)(6512007)(38100700002)(82960400001)(478600001)(41300700001)(966005)(6486002)(26005)(66946007)(186003)(66476007)(31696002)(66556008)(2616005)(86362001)(37006003)(316002)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QlIxODA4UFA5RUllcVVTWUZOa0tBMzgvMm5nMGRKMTg0cTNhZ2FJaXIxSDIx?=
 =?utf-8?B?R2FwZ2hxeExIMFBGd2FxNlE0ZXAvUm5sekQwN3JrR09xUXh3VndFbjZGb05R?=
 =?utf-8?B?M2l5WVRFcWJpN0hYZmtJa2pNRisxWEhud1JTQytVMk4wL3c0aGhxcjlLZ2dz?=
 =?utf-8?B?ZEpLSDUvbFFoejIrQklSajJ4MVNNNi9iMkp1OC94TDFmWmNGWVRUR0Rkc0po?=
 =?utf-8?B?ckhWTzNocEd6aFNHUXVSNW1KQkFiRnVSVjVNZkQvL2hNYXEyQ1FaK3BCU2pv?=
 =?utf-8?B?YTRMT0VvNW82M2IzdTM3bUk3NVFMMi9YZXd5L0toTldEVEd5WVhncktvUit2?=
 =?utf-8?B?bUtJVkZqT1QwOWRTRjIzZEk4REZBalpybUY5V3gxNVpUNk9vdEkyNHpvYmZL?=
 =?utf-8?B?cHZvQnRUUC91d1NFZHNSTU42VjdUdUNlZ3pmMVlKTUZxdkhLTFphaXJpTjFU?=
 =?utf-8?B?VmRFYUJGV2M0R29PMDIycnhDSEdpWkpsMytZQk45b2k0NC9vNE10NGhqWlpo?=
 =?utf-8?B?SEZQYjJxVEhsWjNrY2lGbEYyeUQzWll6MzFWYVBQREZ1Uk1TS2s5ZVplVHVV?=
 =?utf-8?B?SDdoSDdsQStkOFpNN2VybC9vRHR0bEtaUkJ6QWdDQmlvUFZ4emdkZVJ0VjQ3?=
 =?utf-8?B?d2NwQWV2SlJ6bXJYNkp3cHVNbll1T1U2c2JoaHpYeEJGdXArOHdrbnQzU1JO?=
 =?utf-8?B?dXpBUGNGaVdMaGd2UFhpb1l2bXoyRS8xSCs0Y1JiMGp6N0lVOW9SQVZGU1Y0?=
 =?utf-8?B?M0FIMHQ1K1pabW5EVnV5TmJDUzlHelZOTmFQeW41MncvODhYY0lWZ0Uyb1p3?=
 =?utf-8?B?c3Z2Qit6UjBCRXppaWMrejRCcEJQM0labkhRZjQ2b0ZCM2o0QTZoRWl4RW9j?=
 =?utf-8?B?a3pBUldNcGlQZHl6Rjk0bmJZZXNicmlWYVpUakxqUStRanN4dmNlWUViTm1v?=
 =?utf-8?B?SmVEQXJvZmlHNHdXeWJpRlhBUlRLQWtaSHlJMmpWTW9Za2J2Mkl6OHNPVW5G?=
 =?utf-8?B?UnFPLzRMU2NmdXYwTUVlVi9WdktWNHRwZEpqdGRqZFNvQ2JNYytXampKQjVY?=
 =?utf-8?B?WTBJQzJ5SlNnZk8rYTZyWFRGWStrYytHeHhEb01TVDlsL2szbktBeFZRMUl2?=
 =?utf-8?B?RU9kelBGSzlJV1JPWDZoRC8vbVpaY1JBMWlWd2xoZ3EwZk1aWkRHSEMvRG1Z?=
 =?utf-8?B?K2xGNUY5ZHJRb1dSOTJrUnp1L3hjVDYvQ0x0Sk4zZ1diUFlzUnh0dlhRTTRy?=
 =?utf-8?B?M2pLMlJhdytWZE5JSTl1NlBmeDljamFrZ1lPNFl1bktRV2RpYTFJMWZSQWU3?=
 =?utf-8?B?ZVE4bU4yWUpMSU51OCtBY0RNMjBqeEF2WHZIdEE2UjdnelJCTjF5Ri9vaUtq?=
 =?utf-8?B?aUpMcEttNnR1LzR2K3J4SXRINTVUcHNjbmREOXR2dGt4ZEFSNDRtUlRXM3pU?=
 =?utf-8?B?OXEwMlhqV1B6eWYzUjhEUStoc0JrRkovZU5SRUVucDVtU1VjL2JNTlgxTStG?=
 =?utf-8?B?dVlnblo0NjhMMWJwV053d2xnTUk2bXpnTU5EdERaemVqMlBVQkFRYnFPaDc5?=
 =?utf-8?B?V0hDMW5UZXhSTUlkTzdkMW1XNlBINjZnWk5jMjQrOFVpRGkrakg0N0lINktU?=
 =?utf-8?B?azMwNG44L3BzOHY3YjQrbHY2eE1oVmlUZEJoUTZYdkc2YkFUOTdTZ0pQc3lT?=
 =?utf-8?B?R2VleDBBSXhmekZRZEVrWnhCRld5c0x4YkY5UWR5MG5odmpKbDRUOE5PUUxW?=
 =?utf-8?B?ZFdMRnRZcDBmUFJjbmRRSCttZlR0Vld3bDJGcDl5OWo5ZExGOGJEcWxCK2Nw?=
 =?utf-8?B?L2ROYnpLa3k1aFA3RW4xVVJycm5KT3JXeldiVDVYYWkrelNrWVRhNVBoWmhh?=
 =?utf-8?B?R01yTVJXalkvV3VMU3ZWYW4yZHlvUVVHUzJOTnpPbktrb0kzVFVIRUpyZ3VY?=
 =?utf-8?B?aUNlRElkRW9FZ3VsWFpvODExZFRyMWxUZFlJK1dlVHRuN29XL2VGVjVESHhR?=
 =?utf-8?B?ektBQUFwYVJDYVA4NXJkbzJsL1crb29ML0dxMVZYWWpXQ0U2T3ZvTGlXbzdz?=
 =?utf-8?B?VjNZQXpnUEJEOGV2Y1FOTEVFeDkzNWprSWoyRjZwZktzczhPaUlzZ0Q5ZTg4?=
 =?utf-8?B?RGVoM09IZVZxeHYxYUdNOVcwZ1RRdFVONXF5dVQwdjBCdlFTWG1OVjNXbEtU?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4254b800-a3ed-441c-fb49-08daf57d50fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:46:20.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owhbgCyRIv7R7thHKgOB4EcPwWso+xQVlw34//hWLfG+GitTi17JnJaRYLxVrpewz05iBOmun8TkesBXwxae+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jan 2023 15:46:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10348

On 13.01.23 16:25, Venkata.Pyla@toshiba-tsip.com wrote:
> Hi,
> 
> Need help!
> 
> I am trying to create gitlab-ci to build isar-cip-core images, but the pipelines are failing due to permission error.
> 
> Same thing is working fine in isar-cip-core project CI pipelines, 
> Does it require configuration in the gitlab-runner side?

Yes, you need privileged runners. That's also defined in
https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci, I assume
e.g. in
https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci/-/blob/next/share/conf/cip/large/runner.yaml.
Michael can explain more.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


