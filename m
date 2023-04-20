Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F94C77B73
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 07:02:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.2316.1681974138370555678
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Apr 2023 00:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eACvhfLN;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIesbFwpqCFWB5pwMdKX0iVmOaXf6qZVj7UraeF0xYNqGqMazM5gWvB44bSO+aDDpIDJVXHB5wLPW6NYVqcNHIeqjESBpiStQaZd3iu+LdFpxf5mTWfIxzOCvGagDInxNs1IvYBO592UCh7vVDAKuH+rU4wlXS7KJudxZy5xfYELkLEzGMaX5bmNSVI7cQcNe4v58otclGgFbygHJVdZjycJOSwHxqyiXb4xLNlqhT3XHBgFnk9/63XzYp1E7d4q9DW2UADIM9f/GFF7pD6NWH6Ol1kTMwedSByCe2kDkuirgwTcgfodMna9ASnsh680Y+t2econ/SzcOvh+V2hy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sEOvpQuk4qZTR9sjo039oGrqF6pgnBBfsVMpt+7s80=;
 b=Pe8YWp5KOAze9x965TnCDju3KKEBg1e2Es4z6Yxv4rItsI58IT/RzFB4LwwA99I4xAdekbH9+cMLj6+vUfIWOmt0jvP6jZPgItyiamy36Sio8vnjh/Tyun1PPTxHsM+WXbCtDcLzRANGjoan3zwVhOy+0OaoxjcVSYXK93gbIIw8IKN1hOvndUqZEK3h/OZ14tS8y6ULDYpXNBqIUTAfJOJvqRYKf2WtGkK4DM0PVgheuCEH/UCRlmQ1VP/CPyMdSZkxDnO4pep4I6CG1X6z/M5PO01uINwZHrS79X0rCixheEaoFTg7Pq0Za4ZBDKsWpLBuKoxAH5R6UWh48oydSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sEOvpQuk4qZTR9sjo039oGrqF6pgnBBfsVMpt+7s80=;
 b=eACvhfLN6umvczwxRDJTpYVtQynT6GtvZCfMovEAv0PQFcUbVyL2zSmev83o6/e62uza5BO1la7uIsT7cEws0HoT8cJz8osrzeV6MgpJCSW+R+iK8ZYN011sHhobjJBlgFlsKVwjm3PJRvquRhs/63eff2b32uWhvmDbr5W3fxpzhDUOlTzEY3cIVUvC/hygYO6j8AHvEnUa5oF03viIidwsihL5y6+KHdE6Fdk/POzYnbdIct5GhmlEsQcniYJEe5i4ZdE6v6cCdA2nYAXFZRE9qAogL0gtEnHKZMHbztiFSPAiD0j3gQp527IGas+mmwrd+TMXEjx9Xv2wU1rFGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7597.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 07:02:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Thu, 20 Apr 2023
 07:02:15 +0000
Message-ID: <116a9215-7279-9558-0645-8d2500cc06b9@siemens.com>
Date: Thu, 20 Apr 2023 09:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::48) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd2ef56-30a0-43a1-856c-08db416d2c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U+yNsqsbT0Au1eiYVM/yNSzrF7jNlJR3uF2C1LnxTHwMVs1vI4WL/uy0+xniHii/cQQ4/Wsq+ANGD3BPvTdfGFp8MgMA2a/RjDobslNO9tNkNwIVsK7GYZRBcI3LNQPRTwLzfiZ++hcOzt12zIHtr7OdX8VYXmwo6P2IYAIwQtd5p+7fWmRjjaS9xvthdO0zqR0dm/F33/ar/BaKwnvecwCM6cVO2ICNk93/rF8ln6UvMZIu6ldqRPiiD3q+2BzSL7W6oosXnjYRiLksZS0cKYx1AmuDRocIdC3WgyYV3fC4OUrYi56jnbNm9BeX0EfrJt+tCEL9TGOdN3xCXQ4K/0NPvtrRSzkOenifX1Pm096Ux5AVgN3776tDQex7q34gTTIvVvfHybs+0YPXcqzRHFgQifgVq5ohV7IGcYuEtK6+dzBMLYPImiUFZsA2gOXz+5TLq4ZPsL1l6FTuvcBbAs6oJMISIGjnaUzvvaIzd52aWe5XXjggfUNwon0Omo+epg507qCCSbRfHepcAsrEsoneMFHNJO2rLfheCi2TkGA7JP6GcQOU7NiwujCj+iFJoQkwT7p5a/olKpZ00xMDUNTrw4ZVYZ505utLMmC51JZZUFfruHTmR39M0bgaLSUKJ7c18PZUbKwwe9i59HsAHA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(2616005)(83380400001)(36756003)(186003)(6486002)(6512007)(26005)(6506007)(966005)(6666004)(66946007)(66556008)(66476007)(478600001)(31686004)(316002)(41300700001)(82960400001)(8676002)(8936002)(38100700002)(5660300002)(6916009)(86362001)(4744005)(2906002)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UG5IdnpuK0lxOFY1SWo3UjhmcGc1UjltMlFYZFAwMWIvcXl1Y08ybWtTRWd1?=
 =?utf-8?B?ODZyYm5PcFIxU2RZVk9oZDRJMWY4aU1zdHhUQ2hvTXliZEt4bHJqd3p4amxS?=
 =?utf-8?B?dDFNVkpoNDdKcElqbmNKcFhka29QcWUzQTRYRUJmYjl3aXpYaGMrSW50d1hR?=
 =?utf-8?B?d3liMVZiMHB3YWVJc29EUDZNemsycExPZWptNjdtS3F6M1dDWGNNTEU4OHM1?=
 =?utf-8?B?eUtVdXI4WkxxT2ZVeFN1MDdoSW9jb2xkUjR3cVMrQUpHbVQ0OEhNNXU0cGVv?=
 =?utf-8?B?UmtHMXcrMkl0cHVGSzUxbm1GNEwyeWJWRnBIcFZUU2pMT21YcTJFMTdKc1do?=
 =?utf-8?B?UG5namJpMzVaK096OTJhTGxZcHhMVFUrSTEyb0JZbzJuWlhVRngvaFpYZkVs?=
 =?utf-8?B?Q2wwUzJEMjFMTkp3VXd6MHA0U0ljMk8rN0hOYlplRlNHbzFCYjF1MXVhZEJr?=
 =?utf-8?B?M2M0Sk82RWNwOFRHcVViUUxWWUw3cE9WU1plYWxKa2psRW5rQjlLT213U252?=
 =?utf-8?B?RS8xOGJTUXFQbm12QWQrcUhNUWpVTkJDcU1sUW5kaDh1czIxWGtBSXgwUU1F?=
 =?utf-8?B?TnJuaWk3VGI3NlBLblNWMkMvU1hiUWdjbkZwTG15WmZQc1JkOUNBZFdhcHNz?=
 =?utf-8?B?cU9oVWVBRjloZzBtdDlHYmlNU3gvT1drVjJ3Ni8weXFwbkNWWS8yZ2ZNb251?=
 =?utf-8?B?cS8zMW1Fd2JGZFFoZEt3WHJERW5SZENqcHVRbFlYQTQ4SDRONXIzK1Z4TGsz?=
 =?utf-8?B?dnBSUzJYcHhyUm9USXdaWG94TWxxVTBoWHVZU29UUStCWGRhdDIxY21kcXJz?=
 =?utf-8?B?VCtoQ3RQUWRLQXRsclpFRElLTjhuWEkwNHhzcHMza3pRNk9Qc2pvSW5MSWdJ?=
 =?utf-8?B?Qm9jeDVNUk8ybVNwazZPUzFpTmNFb2o2eHJBRnMvOEdhMnVyZ2pnQXF5Q1U3?=
 =?utf-8?B?ZHIvNFVtOU1rbmFRWjFKeUlwZkcwTmlUbDlONy9uRDR5emNQeXo1MHNQZWls?=
 =?utf-8?B?V21taTYrTThrdTRRVU9lMC9hYk5tM0VKdWVpYlRjTE1WNVk0SjRlR21BY2Rk?=
 =?utf-8?B?VUlUSDEvLytmRm10TnQ4UVdGZmxXUjZ0NVBpRndza0tOaUpLb0NLRTJxajVv?=
 =?utf-8?B?RWRhRkYvT3Z3TGhzNThqQzFzNE1KRlI4NDFmdHVrRHVZUWE4N2N4TXZtRS8z?=
 =?utf-8?B?RUhEeHNEWlcvT2FlUE5xc3JtVGx3VXZ4eDZuRklhWDVoRGRSQ1dnc28vcDlP?=
 =?utf-8?B?cTEyWWFBQTVtbnVQbzU4OERMalB1czhZM2ZaUUpVRFdMbW1xY2VJTXRTVzRJ?=
 =?utf-8?B?L2dkeGNHYnVsbjhBaDVSSW95WjN4WUF6NEJycjU4Q1EwanB5NGl3QjByZTky?=
 =?utf-8?B?M3lIaG9jS2N1YVE1WXI2d2IwUUpWSG91eEdMaWdobXpjNlc3YmFwZ1poeDV6?=
 =?utf-8?B?ZCtJQk5uUkFqZm9lQ1FEN0l5ZG1TMVJ4UVdMa0tteTNRZzI3RjA4OTN3RGc3?=
 =?utf-8?B?dnZqTSt1dUZBVU0xbFZ0ZnpqeWJrSS9xS3lFSS9FM3lpZWxxRzBGRHQ5ak9n?=
 =?utf-8?B?L3hXNTFaQVNVUlFXbzZNU3A0QVJNeGhxdXNUVW1PbTczRkdTN2hsY0RwdmVw?=
 =?utf-8?B?MG41TC80MVV6YmpOT2k2Z0pwTGMyWDVRZFR2ZXB2MllPYWI5bWVKdWVuN3dL?=
 =?utf-8?B?dWY5MTVEQmZwaUdyU0FUU0RRZTZrSmlKSkwvdktoRGgxY1M4OStHUlpSM1pB?=
 =?utf-8?B?cjlZdEVqOGIxazEyMTdLVjgybmY2cjNGV09BWE1mZUZhV1BsMFQxN2NVKzJE?=
 =?utf-8?B?bWRJdEptdTM2SUQrNjgzcjBYc3lIbXZ4MWVpelkwQW5GbWhiVDNzdkU1cUhX?=
 =?utf-8?B?eXptd3Q1RUo0aTVmTjRyY1ZvdmJCUFB6N3MrWU84T1hYZGdCSCtaTVJiVVFw?=
 =?utf-8?B?b0NWNEF6cmdQOGJ2SjI0NWx1QTdMMEFIS2NDS3IyWUtweEhaZy9sNWVNYXBp?=
 =?utf-8?B?K05udHNpT3hvaStDRUVneExQR0s3cnJ2a0JTeUZDREF5UDdDTFMwU2l5bU1O?=
 =?utf-8?B?ZjFyQzBRTHFqN2RwOUFWV2M3ME9WZ3BITTNwQVM5MkUwVDdkTk1EaUM5WlFC?=
 =?utf-8?Q?g2DKz69PxMfa+C93zLPa0QiiH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd2ef56-30a0-43a1-856c-08db416d2c02
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 07:02:15.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIgvu4lK7k3Id1K822An70Nxv404uPWtzegVkVUJA3oQRAn4gU4qdodFIwXkiXlV0gXy6N1+oDDYo8QBBFdSAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7597
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 07:02:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11238

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=4&day=20&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/04/cip.2023-04-13-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

